! aux_model.f90
! created: Nov 2018
! 
! Calculates aux model parameters
!   also contains bottom_ten, a helper function
!

module aux_model
  use global_variables
  implicit none

  private

  public calc_aux_parameters, calc_aux_omega_parameters, calc_aux_other_parameters

contains

  ! calculate aux model parameters
  ! 1. Small logit - offers from model (linear prob model w/ fe)
  ! 2. Big logit - offers from all districts (linear prob model w/ fe)
  ! OLS - regress district chars. on average teacher chars.:
  ! 3. OLS - new teachers
  ! 4. OLS - bottom 10 percent of teachers
  ! 5. OLS - all teachers
  subroutine calc_aux_parameters(pr_model_match,model_match_copies,aux_beta_est)
    use statistical_models
    !double precision, intent(inout), dimension(nteach,ndist)        :: pr_model_match
    double precision, intent(inout), dimension(:,:)        :: pr_model_match
    !integer, intent(inout), dimension(ncopyT,nteach,ndist) :: model_match_copies
    integer,          intent(inout), dimension(:,:,:) :: model_match_copies
    double precision, intent(out), dimension(naux,1)  :: aux_beta_est

    !integer,          dimension(nteach,ndist) :: model_offer_all, seed
    !integer,          dimension(nteach,ndist) :: model_offer_sub
    integer, allocatable, dimension(:,:) :: model_offer_all, seed, model_offer_sub
    !double precision, dimension(nteach,ndist) :: ten_inc_stay, new_teachers
    double precision, allocatable, dimension(:,:) :: ten_inc_stay, new_teachers
    !double precision, dimension(nteach,ndist) :: x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, y, w
    double precision, allocatable, dimension(:,:) :: x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, y, w
    double precision, dimension(:,:), allocatable :: X_big, y_big, X_small, X_small_stacked, &
         y_small, y_small_stacked, X_tmp, y_tmp, X_big_stacked, y_big_stacked,&
         x_wage_big,x_wage_big_stacked
    double precision, dimension(ndist,4)      :: X
    double precision, dimension(:,:), allocatable :: X_new, X_2
    double precision, dimension(ndist,1)      :: M_exp, M_master, M_C1, M_C2
    double precision, dimension(:,:), allocatable :: M_exp_new, M_master_new, M_C1_new, M_C2_new
    double precision, dimension(:,:), allocatable :: M_exp_2, M_master_2, M_C1_2, M_C2_2
    double precision, dimension(ndist)        :: free_wage, free_capacity
    double precision :: sum
    integer :: i, j, k, cp, new_ct, non_nan_ct, ncopy
    integer, dimension(1) :: l 
    !aux parameters
    double precision, dimension(13) :: mbeta_small, mbeta_big !'logits'
    double precision, dimension(4)  :: mbeta_d1_1, mbeta_d1_2, mbeta_d1_3, mbeta_d1_4
    double precision, dimension(4)  :: mbeta_d2_1, mbeta_d2_2, mbeta_d2_3, mbeta_d2_4
    double precision, dimension(4)  :: mbeta_d3_1, mbeta_d3_2, mbeta_d3_3, mbeta_d3_4

    !double precision, dimension(nteach,ndist) :: wage_tmp
    double precision, allocatable, dimension(:,:) :: wage_tmp
    integer, allocatable, dimension(:,:) :: ones_nteach_ndist


    !some allocations
    allocate(model_offer_all(nteach,ndist), seed(nteach,ndist), model_offer_sub(nteach,ndist))
    allocate(ten_inc_stay(nteach,ndist), new_teachers(nteach,ndist))
    allocate(x1(nteach,ndist), x2(nteach,ndist), x3(nteach,ndist), x4(nteach,ndist), x5(nteach,ndist), x6(nteach,ndist))
    allocate(x7(nteach,ndist), x8(nteach,ndist), x9(nteach,ndist), x10(nteach,ndist), x11(nteach,ndist), x12(nteach,ndist))
    allocate(x13(nteach,ndist), y(nteach,ndist), w(nteach,ndist))
    allocate(wage_tmp(nteach,ndist))
    
    !flexible variable so can use neconomy or ncopyt
    ncopy = size(model_match_copies,1)

    ! ----------------
    !tmp for checking aux models (match is match from data, global variable)
    !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
    !pr_model_match = match
    !do cp=1, nCopy
    !  model_match_copies(cp,:,:) = match
    !end do
    ! ----------------

    
    if (purpose < 10) then !skip small offer logit if running eqbm
    !1. sub-offer 'logit'
    ! will create seperate seeds for each 'copy' of teacher set in data
    if (purpose >= 10) wage_tmp = wage !save wage data for later moments
    do cp = 1, nCopy
       !if we are doing equilibrium, find wage assoc with that economy
       if (purpose >= 10) then
          !wage = matmul(ones_nteach,sim_omegas(cp,1,:)) * wageschedule + &
          !       matmul(ones_nteach,sim_omegas(cp,2,:)) * contribution
          wage = spread(sim_omegas(cp,1,:),1,nteach) * wageschedule + &
               spread(sim_omegas(cp,2,:),1,nteach) * contribution
       end if
       
       ! start by calculating sub-offer set
       ! identify seed teacher-district offers
       seed = 0
       do j=1, ndist
          do i=1, nteach
             ! non-tenured, non-entrants
             if (exp_gr(i,1) == 2 .and. model_match_copies(cp,i,j) == 1) seed(i,j) = 1
             ! tenured who move districts (i.e. also non-entrants)
             if (tenured(i,j)==1 .and. model_match_copies(cp,i,j)==1 .and. &
                  inc(i,j)==0 .and. entrant(i,j)==0) seed(i,j) = 1
          end do
       end do

       !print*, 'seed:', seed(20,393)

       !use seed teachers to generate sub offer set ('matched' teachers)
       model_offer_sub(:,:) = seed !we know all seeds get offers
       do j=1, ndist
       !j = 393
          do i=1, nteach
             ! if teacher is a seed, impute other offers from district j
             if (seed(i,j) == 1) then
                do k=1, nteach
                   if ((k .ne. i) .and. (exp_gr(k,1) .ge. exp_gr(i,1)) .and. &
                        (C1(k,1) .ge. C1(i,1)) .and. (C2(k,1) .ge. C2(i,1)) .and. &
                        (master(k,1) .ge. master(i,1)) .and. (wage(k,j) .le. wage(i,j))) then
                      !if (k==20) then
                      !   print*, model_offer_sub(k,j)
                      !   print*, 'k', k, exp_gr(k,1), C1(k,1), C2(k,1), master(k,1), wage(k,j)
                      !   print*, 'i', i, exp_gr(i,1), C1(i,1), C2(i,1), master(i,1), wage(i,j)
                      !end if
                      model_offer_sub(k,j) = 1
                   end if
                end do
             end if
          end do
       end do

       !print*, 'generated:', model_offer_sub(20,393)

       !also add in 'match==1 district' for the matched teachers
       do i=1,nteach
          if (sum(seed(i,:))==0) then
             l = maxloc(model_match_copies(cp,i,:))
             if (model_match_copies(cp,i,l(1)) ==1) model_offer_sub(i,l) = 1
          end if
       end do

       !print*, 'match:', model_offer_sub(20,393)

       ! also add into our offer set: inc district for tenured teachers who moved
       do j=1, ndist
          do i=1, nteach
             if (tenured(i,j)==1 .and. model_match_copies(cp,i,j)==0 .and. &
                  inc(i,j)==1 .and. entrant(i,j)==0)  model_offer_sub(i,j) = 1
          end do
       end do

       !print*, 'inc:', model_offer_sub(1590, 165)

       ! finally, if teacher only receives ONE suboffer, set them to zero.
       !    we need them to have options for FE reg
       do i=1, nteach
          if (sum(model_offer_sub(i,:)) .le. 1) model_offer_sub(i,:) = 0
       end do

       !call exit(1)


       ! Acceptance regs w/ fixed effects
       ! all vars need to be doubles to work with demean subroutine
       x1   = wage                
       x2   = exp(share_low)        
       x3   = matmul(C1,share_low(1:1,:))
       x4   = (1-entrant) * (1-inc)       
       x5   = (1-entrant) * (1-inc) * exp_dum2
       x6   = (1-entrant) * (1-inc) * exp_dum3
       x7   = (1-entrant) * (1-inc) * exp_dum4
       x8   = (1-entrant) * (1-inc) * exp_dum5
       x9   = (1-entrant) * (1-samecz)
       x10  = urban                     
       x11  = suburban
       x12  = logdist
       x13  = milwauk
       y   = model_match_copies(cp,:,:)

       ! build up design matrix for offer subset
       allocate(X_small(sum(model_offer_sub),13))
       allocate(y_small(sum(model_offer_sub),1))
       call demean_and_reshape(x1,  model_offer_sub, X_small(:,1))
       call demean_and_reshape(x2,  model_offer_sub, X_small(:,2))  
       call demean_and_reshape(x3,  model_offer_sub, X_small(:,3))
       call demean_and_reshape(x4,  model_offer_sub, X_small(:,4))
       call demean_and_reshape(x5,  model_offer_sub, X_small(:,5))
       call demean_and_reshape(x6,  model_offer_sub, X_small(:,6))
       call demean_and_reshape(x7,  model_offer_sub, X_small(:,7))
       call demean_and_reshape(x8,  model_offer_sub, X_small(:,8))
       call demean_and_reshape(x9,  model_offer_sub, X_small(:,9))
       call demean_and_reshape(x10, model_offer_sub, X_small(:,10))
       call demean_and_reshape(x11, model_offer_sub, X_small(:,11))
       call demean_and_reshape(x12, model_offer_sub, X_small(:,12))
       call demean_and_reshape(x13, model_offer_sub, X_small(:,13))
       call demean_and_reshape(y,   model_offer_sub, y_small(:,1))


       !progressively stack all of our copies (this is hard b/c we don't know size)
       if (allocated(X_small_stacked)) deallocate(X_small_stacked)
       if (allocated(y_small_stacked)) deallocate(y_small_stacked)

       if (allocated(X_tmp) .and. allocated(y_tmp)) then !not first 'copy'
  
          allocate(X_small_stacked(size(X_tmp,1)+size(X_small,1),13))
          allocate(y_small_stacked(size(y_tmp,1)+size(y_small,1),1))
          !previous copies
          X_small_stacked(1:size(X_tmp,1),:) = X_tmp
          y_small_stacked(1:size(y_tmp,1),:) = y_tmp
          !adding new copy
          X_small_stacked(size(X_tmp,1)+1:size(X_small_stacked,1),:) = X_small
          y_small_stacked(size(X_tmp,1)+1:size(y_small_stacked,1),:) = y_small

          deallocate(X_tmp, y_tmp)
          deallocate(y_small,X_small)
          
       else !this is first 'copy'
          !allocate(X_small_stacked(size(X_tmp,1)+size(X_small,1),13))
          !allocate(y_small_stacked(size(y_tmp,1)+size(y_small,1),1))
          allocate(X_small_stacked(size(X_small,1),13))
          allocate(y_small_stacked(size(y_small,1),1))

          X_small_stacked = X_small
          y_small_stacked = y_small
          deallocate(y_small,X_small)
          
       end if
              

       if (cp .lt. nCopy) then !if more copies need to be processed:
          allocate(X_tmp(size(x_small_stacked,1),13), y_tmp(size(y_small_stacked,1),1))
          X_tmp = X_small_stacked
          y_tmp = y_small_stacked
       end if

    end do

    !temp, write out the big reg data
    !open(1, file='smallreg.txt', status = 'replace')
    !do i=1, nteach
    !   do j=1, ndist
    !      write(1,*) y(i,j), ',', x1(i,j), ',',x2(i,j), ',',x3(i,j), ',',x4(i,j), &
    !           ',',x5(i,j), ',',x6(i,j), ',',x7(i,j), ',',x8(i,j), ',',x9(i,j), ',',x10(i,j), &
    !           ',',x11(i,j), ',',x12(i,j), ',',x13(i,j), ',',i, ',',j, ',', model_offer_sub(i,j)
    !   end do
    !end do
    !close(1)

    !reg
    !print*, 'sum of the small aux variables)'
    !print*, sum(x1), sum(x2), sum(x3), sum(x4), &
    !     sum(x5), sum(x6), sum(x7), sum(x8), &
    !     sum(x9), sum(x10), sum(x11), sum(x12), &
    !     sum(x13)
    !print*, sum(y_small_stacked), sum(X_small_stacked(:,1)), &
    !     sum(X_small_stacked(:,2)), sum(X_small_stacked(:,3)), &
    !     sum(X_small_stacked(:,4)), sum(X_small_stacked(:,5)), &
    !     sum(X_small_stacked(:,6)), sum(X_small_stacked(:,7)), &
    !     sum(X_small_stacked(:,8)), sum(X_small_stacked(:,9)), &
    !     sum(X_small_stacked(:,10)), sum(X_small_stacked(:,11)), &
    !     sum(X_small_stacked(:,12)), sum(X_small_stacked(:,13))
    !print*, 'small reg'
    mbeta_small = linreg(y_small_stacked, X_small_stacked)
    deallocate(y_small_stacked, X_small_stacked)
 
    !2. All offer 'logit'
    ! design matrix for all-offer set
    model_offer_all = 1
    ! X's are easier, will be same for each 'copy' of teachers
    allocate(X_big(sum(model_offer_all),13))
    call demean_and_reshape(x1,  model_offer_all, X_big(:,1))
    call demean_and_reshape(x2,  model_offer_all, X_big(:,2))  
    call demean_and_reshape(x3,  model_offer_all, X_big(:,3))
    call demean_and_reshape(x4,  model_offer_all, X_big(:,4))
    call demean_and_reshape(x5,  model_offer_all, X_big(:,5))
    call demean_and_reshape(x6,  model_offer_all, X_big(:,6))
    call demean_and_reshape(x7,  model_offer_all, X_big(:,7))
    call demean_and_reshape(x8,  model_offer_all, X_big(:,8))
    call demean_and_reshape(x9,  model_offer_all, X_big(:,9))
    call demean_and_reshape(x10, model_offer_all, X_big(:,10))
    call demean_and_reshape(x11, model_offer_all, X_big(:,11))
    call demean_and_reshape(x12, model_offer_all, X_big(:,12))
    call demean_and_reshape(x13, model_offer_all, X_big(:,13))
    !now stack into one large matrix for all copies
    allocate(X_big_stacked(size(X_big,1)*nCopy,13))
    X_big_stacked = reshape(spread(X_big,2,ncopy),(/ size(X_big,1)*nCopy,13/))
    deallocate(X_big)
    
    !y's are not the same for each 'copy' of teachers:
    allocate(y_big_stacked(size(X_big_stacked,1),1))
    if (purpose >= 10) allocate(x_wage_big_stacked(size(X_big_stacked,1),1))
    do cp = 1, nCopy
       y   = model_match_copies(cp,:,:)
       allocate(y_big(sum(model_offer_all),1))
       call demean_and_reshape(y, model_offer_all, y_big(:,1))
       y_big_stacked((cp-1)*size(y_big,1)+1:(cp)*size(y_big,1),:) = y_big
       deallocate(y_big)
       !if simulation, will have different wages, need to stack
       if (purpose >= 10) then
          allocate(x_wage_big(sum(model_offer_all),1))
          !calc wage here
          w = spread(sim_omegas(cp,1,:),1,nteach) * wageschedule + &
               spread(sim_omegas(cp,2,:),1,nteach) * contribution
          call demean_and_reshape(w,model_offer_all,x_wage_big(:,1))
          x_wage_big_stacked((cp-1)*size(y_big,1)+1:(cp)*size(y_big,1),:) = x_wage_big
          deallocate(x_wage_big)
       end if
    end do
    if (purpose >= 10) X_big_stacked(:,1:1) = x_wage_big_stacked


    !temp, write out the big reg data
    !open(1, file='bigreg.txt', status = 'replace')
    !do i=1, nteach
    !   do j=1, ndist
    !      write(1,*) y(i,j), ',', x1(i,j), ',',x2(i,j), ',',x3(i,j), ',',x4(i,j), &
    !           ',',x5(i,j), ',',x6(i,j), ',',x7(i,j), ',',x8(i,j), ',',x9(i,j), ',',x10(i,j), &
    !           ',',x11(i,j), ',',x12(i,j), ',',x13(i,j), ',',j, ',',i
    !   end do
    !end do
    !close(1)
    
    !reg
    !print*, 'bigreg'
    mbeta_big = linreg(y_big_stacked, X_big_stacked)
    deallocate(y_big_stacked, X_big_stacked)
    else
       !the big logits aren't working on so many flash nodes
       !   probably a memory issue, so we have commented out
       mbeta_small = 0
       mbeta_big = 0
    end if

    allocate(ones_nteach_ndist(nteach,ndist))
    ones_nteach_ndist = 1

    !set up objects needed for OLS (probability of matches used for district regs)
    ten_inc_stay = tenured * inc * pr_model_match
    new_teachers = (ones_nteach_ndist - inc) * pr_model_match
    do j=1, ndist !"or" statements get ugly so instead doing loop to add non-tenured to new_teachers
       do i=1, nteach
          !if(exp_con(i,j) <= 3 .and. model_match(i,j) == 1) new_teachers(i,j) = 1
          if(exp_con(i,j) <= 3) new_teachers(i,j) = pr_model_match(i,j)
       end do
    end do

    deallocate(ones_nteach_ndist)

    !set up OLS design matrix
    if (purpose >= 10) wage = wage_tmp
    free_wage = (B(1,:) - sum(wage * ten_inc_stay,1)) 
    free_capacity = T(1,:) - sum(ten_inc_stay,1)
    X(:,1) = free_wage
    X(:,2) = free_capacity
    X(:,3) = share_low(1,:)
    X(:,4) = 1 !intercept last to match stata order

    !3. new teachers
    !  note:some dists don't hire new, so we need to remove them from reg matrices
    !first figure out how many districts do indeed have new teachers
    new_ct = 0
    do j=1, ndist
       if(sum(new_teachers(:,j)) > 0) new_ct = new_ct + 1
    end do
    !then allocate and assign the matrices to only contain the new teachers
    allocate(M_exp_new(new_ct,1), M_master_new(new_ct,1))
    allocate(M_C1_new(new_ct,1), M_C2_new(new_ct,1), X_new(new_ct,4))
    i = 1
    do j=1, ndist
       if(sum(new_teachers(:,j)) > 0) then
          M_exp_new(i,1)    = sum(exp_con(:,j) * new_teachers(:,j)) / sum(new_teachers(:,j))
          M_master_new(i,1) = sum(master(:,j)  * new_teachers(:,j)) / sum(new_teachers(:,j))
          M_C1_new(i,1)     = sum(C1(:,1)      * new_teachers(:,j)) / sum(new_teachers(:,j))
          M_C2_new(i,1)     = sum(C2(:,1)      * new_teachers(:,j)) / sum(new_teachers(:,j))
          X_new(i,:) = X(j,:)
          i = i+1
       end if
    end do

!    print*, new_ct, sum(new_teachers)
!    print*, M_exp_new(1:5,1)
!    print*, X_new(1,:)
!    print*, X_new(2,:)
!
    !!output this data so we can direclty compare to stata
    !open(1, file='M_exp_new.txt', status='replace')
    !i = 0
    !do j=1,ndist
    !   if (sum(new_teachers(:,j)) > 0) then
    !      i = 1 + i
    !      write(1,*) j, M_exp_new(i,1), X_new(i,1), X_new(i,2), X_new(i,3)
    !   end if
    !end do
    !close(1)
    !call exit(1)

    !print*, 'mbeta_d1'
    mbeta_d1_1 = linreg(M_exp_new,   X_new)
    mbeta_d1_2 = linreg(M_master_new,X_new)
    mbeta_d1_3 = linreg(M_C1_new,    X_new)
    mbeta_d1_4 = linreg(M_C2_new,    X_new)
    !do j=1, new_ct
    !   write(*,*) j, M_exp_new(j,1), M_master_new(j,1), M_C1_new(j,1), M_C2_new(j,1), X_new(j,1), &
    !        X_new(j,2), X_new(j,3)
    !end do
    deallocate(M_exp_new,M_master_new,M_C1_new,M_C2_new,X_new)
    !4. bottom 10%
    M_exp(:,1)    = prctile_mean(dble(exp_con)        , pr_model_match, 10)
    M_master(:,1) = prctile_mean(dble(master)         , pr_model_match, 10) 
    M_C1(:,1)     = prctile_mean(matmul(C1,ones_ndist), pr_model_match, 10) 
    M_C2(:,1)     = prctile_mean(matmul(C2,ones_ndist), pr_model_match, 10)
    ! check for nan, make conditional on having teachers
    if ( minval(sum(pr_model_match,1)) < epsilon(0d0)) then
       non_nan_ct = 0
       do j=1,ndist
          if (sum(pr_model_match(:,j),1) .gt. 0) non_nan_ct = non_nan_ct + 1
       end do
       allocate(M_exp_2(non_nan_ct,1), M_master_2(non_nan_ct,1))
       allocate(M_C1_2(non_nan_ct,1), M_C2_2(non_nan_ct,1))
       allocate(X_2(non_nan_ct,4))
       i=1
       do j=1, ndist
          if (sum(pr_model_match(:,j),1) .gt. 0) then
             M_exp_2(i,1) = M_exp(j,1)
             M_master_2(i,1) = M_master(j,1)
             M_C1_2(i,1) = M_C1(j,1)
             M_C2_2(i,1) = M_C2(j,1)
             X_2(i,:) = X(j,:)
             i=i+1   
          end if
       end do
       !print*, 'mbeta_d2'
       mbeta_d2_1 = linreg(M_exp_2,X_2)
       mbeta_d2_2 = linreg(M_master_2,X_2)
       mbeta_d2_3 = linreg(M_C1_2,X_2)
       mbeta_d2_4 = linreg(M_C2_2,X_2)
       deallocate(M_exp_2, M_master_2, M_C1_2, M_C2_2, X_2)
    else
       mbeta_d2_1 = linreg(M_exp,X)
       mbeta_d2_2 = linreg(M_master,X)
       mbeta_d2_3 = linreg(M_C1,X)
       mbeta_d2_4 = linreg(M_C2,X)
    end if

    !do j=1, ndist
    !   write(*,*) j, M_exp(j,1), M_master(j,1), M_C1(j,1), M_C2(j,1), X(j,1), X(j,2), X(j,3)
    !end do
    !5. all teachers
    M_exp(:,1)    = sum(dble(exp_con)         * pr_model_match,1) / sum(pr_model_match,1)
    M_master(:,1) = sum(dble(master)          * pr_model_match,1) / sum(pr_model_match,1)
    M_C1(:,1)     = sum(matmul(C1,ones_ndist) * pr_model_match,1) / sum(pr_model_match,1)
    M_C2(:,1)     = sum(matmul(C2,ones_ndist) * pr_model_match,1) / sum(pr_model_match,1)
    ! check for nan, make conditional on having teachers
    if ( minval(sum(pr_model_match,1)) < epsilon(0d0)) then
       non_nan_ct = 0
       do j=1,ndist
          if (sum(pr_model_match(:,j),1) .gt. 0) non_nan_ct = non_nan_ct + 1
       end do
       allocate(M_exp_2(non_nan_ct,1), M_master_2(non_nan_ct,1))
       allocate(M_C1_2(non_nan_ct,1), M_C2_2(non_nan_ct,1))
       allocate(X_2(non_nan_ct,4))
       i=1
       do j=1, ndist
          if (sum(pr_model_match(:,j),1) .gt. 0) then
             M_exp_2(i,1) = M_exp(j,1)
             M_master_2(i,1) = M_master(j,1)
             M_C1_2(i,1) = M_C1(j,1)
             M_C2_2(i,1) = M_C2(j,1)
             X_2(i,:) = X(j,:)
             i=i+1   
          end if
       end do
       !print*, 'mbeta_d3'
       mbeta_d3_1 = linreg(M_exp_2,X_2)
       mbeta_d3_2 = linreg(M_master_2,X_2)
       mbeta_d3_3 = linreg(M_C1_2,X_2)
       mbeta_d3_4 = linreg(M_C2_2,X_2)
       deallocate(M_exp_2, M_master_2, M_C1_2, M_C2_2, X_2)
    else
       !print*, 'mbeta_d3'
       mbeta_d3_1 = linreg(M_exp,X)
       mbeta_d3_2 = linreg(M_master,X)
       mbeta_d3_3 = linreg(M_C1,X)
       mbeta_d3_4 = linreg(M_C2,X)
    end if

    !do j=1, ndist
    !   write(*,*) j, M_exp(j,1), M_master(j,1), M_C1(j,1), M_C2(j,1), X(j,1), X(j,2), X(j,3)
    !end do

    aux_beta_est(:,1) = (/mbeta_small, mbeta_big, mbeta_d1_1, mbeta_d1_2, mbeta_d1_3, &
         & mbeta_d1_4, mbeta_d2_1, mbeta_d2_2, mbeta_d2_3, mbeta_d2_4,    &
         & mbeta_d3_1, mbeta_d3_2, mbeta_d3_3, mbeta_d3_4/)


    !some deallocations
    deallocate(model_offer_all, seed, model_offer_sub)
    deallocate(ten_inc_stay, new_teachers)
    deallocate(x1, x2, x3, x4, x5, x6)
    deallocate(x7, x8, x9, x10, x11, x12)
    deallocate(x13, y, w)
    deallocate(wage_tmp)

  end subroutine calc_aux_parameters


  subroutine calc_aux_omega_parameters(pr_model_Wgrid,aux_omega_model)
    use statistical_models
    !double precision, dimension(nWgrid1,nWgrid2,ndist), intent(in) :: pr_model_Wgrid
    double precision, dimension(nWgrid1,nWgrid2,ndist), intent(inout) :: pr_model_Wgrid
    double precision, dimension(naux_omega,1), intent(out) :: aux_omega_model
    double precision, dimension(17)       :: momega1, momega2
    double precision, dimension(5)        :: momega_means
    double precision, dimension(nWgrid1)  :: momega_pr1
    double precision, dimension(nWgrid2)  :: momega_pr2
    double precision                      :: momega_old
    double precision, dimension(4)        :: momega_dem
    double precision, dimension(ndist,17) :: X_omega
    double precision, dimension(ndist)    :: denom
    !double precision, dimension(ndist,1)  :: omega1, omega2
    !double precision, dimension(nteach,ndist) :: tc, tc_mean
    double precision, allocatable, dimension(:,:) :: tc, tc_mean

    double precision, dimension(ndist*nWgrid1,17) :: X_omega1_big
    double precision, dimension(ndist*nWgrid1,1)  :: omega1_big
    double precision, dimension(ndist*nWgrid2,17) :: X_omega2_big
    double precision, dimension(ndist*nWgrid2,1)  :: omega2_big

    double precision, dimension(nWgrid1,nWgrid2) :: omega12_grid

    integer a1, a2, j, k

    allocate(tc(nteach,ndist), tc_mean(nteach,ndist))
    
    !setup design matrix for omega1 and omega2
    !  (if I have this correct can move to start of program)

    ! first set of vars are average in district for exp!=1 and incumbents
    denom = sum((1-exp_dum1) * inc,1)
    !contribution variables
    tc = matmul(C1,share_low(1:1,:)) + &
         matmul(C2,(1-share_low(1:1,:)))
    !write(*,*) sum(tc * (1-exp_dum1) * inc,1) / denom
    !call exit(1)
    tc_mean = spread(sum(tc * (1-exp_dum1) * inc,1) / denom ,1,nteach)
    !Exp3
    X_omega(:,1) = sum(exp_dum3 * inc,1) / denom
    !Exp4
    X_omega(:,2) = sum(exp_dum4 * inc,1) / denom
    !Exp5
    X_omega(:,3) = sum(exp_dum5 * inc,1) / denom
    !Exp6
    X_omega(:,4) = sum(exp_dum6 * inc,1) / denom
    !master
    X_omega(:,5) = sum(master * (1-exp_dum1) * inc,1) / denom
    !d (lambda)
    X_omega(:,6) = share_low(1,:)
    !tc
    X_omega(:,7) = sum(tc * (1-exp_dum1) * inc,1) / denom
    !tc_tenured
    X_omega(:,8) = sum(tc * (1-exp_dum1) * inc * tenured,1) / denom

    !second set of vars 
    !budget_pc
    X_omega(:,9) = B(1,:) / T(1,:)
    !capacity
    X_omega(:,10) = T(1,:)
    !urban
    X_omega(:,11) = urban(1,:)
    !suburban
    X_omega(:,12) = suburban(1,:)
    !milwaukee
    X_omega(:,13) = milwauk(1,:)
    !CZ_tc
    X_omega(:,14) = sum(tc * samecz * (1-exp_dum1) * (1-inc),1) / &
         sum(samecz * (1-exp_dum1) * (1-inc),1)
    !cz share tenured (leave-one-out avg cz share tenured)
    !X_omega(:,15) = sum(tenured * samecz * (1-inc),1) / dble(sum(samecz * (1-inc),1))
    X_omega(:,15) = czten
    !share dem vote
    X_omega(:,16) = demshare
    !intercept
    X_omega(:,17) = 1

    !if no incumbents... 1-8 (less lambda 6) are set to zero (matches stata)
    do j=1, ndist
       if (denom(j) .lt. epsilon(denom(j))) then
          X_omega(j,1:5) = 0
          X_omega(j,7:8) = 0
       end if
    end do


    !omega1(:,1) = Wgrid(:,1)
    !momega1 = linreg(omega1,X_omega)
    !output to compare to stata
    !open(5,file='tmp.txt',status='replace')
    !do j=1,ndist
    !   !if (X_omega(j,1) .ne. X_omega(j,1)) write(*,*) j, X_omega(j,1)
    !   write(5,*) j, omega1(j,1), X_omega(j,1), X_omega(j,2), X_omega(j,3),&
    !        X_omega(j,4),X_omega(j,5),X_omega(j,6),X_omega(j,7),&
    !        X_omega(j,8),X_omega(j,9),X_omega(j,10),X_omega(j,11),&
    !        X_omega(j,12),X_omega(j,13),X_omega(j,14),X_omega(j,15),&
    !        X_omega(j,16)
    !end do
    !close(5)
    
    
    !for testing fortran aux code, set pr_model_Wgrid equal to observed omegas from grid
    !  can't have zeros in reg, weight to 0.0000000001 instead
    !do j=1, ndist
    !   do a1=1, nWgrid1
    !      do a2=1, nWgrid2
    !         if(abs(Wgrid(j,1)-omega1_grid(a1)) .lt. 0.001 .and. &
    !            abs(Wgrid(j,2)-omega2_grid(a2)) .lt. 0.001) then
    !            pr_model_Wgrid(a1,a2,j) = 1
    !         else
    !            pr_model_Wgrid(a1,a2,j) = epsilon(1d0)
    !         end if
    !      end do
    !   end do
    !end do
    !print*, sum(sum(pr_model_Wgrid,3),1)

    ! set omega1 and omega2 vars for regression
    ! _big denotes contains repetitions of each district for each omega
    k=0
    do a1=1, nWgrid1
       omega1_big(k*ndist+1:(k+1)*ndist,1) = omega1_grid(a1) * &
            sum(pr_model_Wgrid(a1,:,:),1)
       X_omega1_big(k*ndist+1:(k+1)*ndist,:) = X_omega * &
            spread(sum(pr_model_Wgrid(a1,:,:),1),2,size(X_omega,2))
       k=k+1
    end do

    k=0
    do a2=1, nWgrid2
       omega2_big(k*ndist+1:(k+1)*ndist,1) = omega2_grid(a2) * &
            sum(pr_model_Wgrid(:,a2,:),1)
       X_omega2_big(k*ndist+1:(k+1)*ndist,:) = X_omega * &
            spread(sum(pr_model_Wgrid(:,a2,:),1),2,size(X_omega,2))
       k=k+1
    end do

    !temp save the data to text file to compare to stata
    
    
    ! 'omega 1'
    !print*, 'omega1', sum(X_omega1_big(:,14)),sum(X_omega1_big(:,15)),&
    !     sum(X_omega1_big(:,16)), sum(X_omega1_big(:,17))
    !print*, 'omega1-1', omega1_big(1,1), X_omega1_big(1,6), X_omega1_big(1,14),&
    !     X_omega1_big(1,15), X_omega1_big(1,16)
    !print*, 'omega1-2', omega1_big(1+ndist,1), X_omega1_big(1+ndist,6), X_omega1_big(1+ndist,14),&
    !     X_omega1_big(1+ndist,15), X_omega1_big(1+ndist,16)
    !print*, 'omega1-3', omega1_big(1+2*ndist,1), X_omega1_big(1+2*ndist,6), X_omega1_big(1+2*ndist,14),&
    !     X_omega1_big(1+2*ndist,15), X_omega1_big(1+2*ndist,16)
    !print*, 'omega1-4', omega1_big(1+3*ndist,1), X_omega1_big(1+3*ndist,6), X_omega1_big(1+3*ndist,14),&
    !     X_omega1_big(1+3*ndist,15), X_omega1_big(1+3*ndist,16)
    !print*, 'omega1-5', omega1_big(1+4*ndist,1), X_omega1_big(1+4*ndist,6), X_omega1_big(1+4*ndist,14),&
    !     X_omega1_big(1+4*ndist,15), X_omega1_big(1+4*ndist,16)
    !print*, 'omega1-6', omega1_big(1+5*ndist,1), X_omega1_big(1+5*ndist,6), X_omega1_big(1+5*ndist,14),&
    !     X_omega1_big(1+5*ndist,15), X_omega1_big(1+5*ndist,16)
    !print*, 'omega1-2', X_omega1_big(1+ndist,16)
    !print*, 'omega1-1', X_omega1_big(1+ndist,:)
    !print*, 'omega1-2', X_omega1_big(2+ndist,:)
    !print*, 'omega1-3', X_omega1_big(3+ndist,:)
    !! I gottta print to a txt file to get to the bottom of this
    !open(1, file="omega1_reg.txt")
    !do j=1, ndist
    !   write(1,*) X_omega(j,:)
    !end do
    !close(1)
    !print*, 'momega1'
    momega1 = linreg(omega1_big,X_omega1_big)

    ! 'omega 2'
    !print*, 'momega2'
    momega2 = linreg(omega2_big,X_omega2_big)

    !E(omega1)
    momega_means(1) = sum(sum(pr_model_Wgrid,2) * spread(omega1_grid,2,ndist))/ndist
    !E(omega2)
    momega_means(2) = sum(sum(pr_model_Wgrid,1) * spread(omega2_grid,2,ndist))/ndist
    !E(omega1*omega2)
    do a1=1, nWgrid1
       do a2=1, nWgrid2
          omega12_grid(a1,a2) = omega1_grid(a1) * omega2_grid(a2)
       end do
    end do
    momega_means(3) = sum(pr_model_Wgrid * spread(omega12_grid,3,ndist)) / ndist
    !E(omega1^2)
    momega_means(4) = sum(sum(pr_model_Wgrid,2) * spread(omega1_grid**2,2,ndist))/ndist
    !E(omega2^2)
    momega_means(5) = sum(sum(pr_model_Wgrid,1) * spread(omega2_grid**2,2,ndist))/ndist
    !fraction of districts choosing each omega
    do a1=1,nWgrid1
       momega_pr1(a1)=sum(sum(pr_model_Wgrid(a1,:,:),dim=1),dim=1)/ndist
    enddo
    do a2=1,nWgrid2
       momega_pr2(a2)=sum(sum(pr_model_Wgrid(:,a2,:),dim=1),dim=1)/ndist
    enddo
    momega_old = sum(pr_model_Wgrid(3,1,:),dim=1)/dble(ndist)
    ! omega x democratic shares
    momega_dem(1) = sum(sum(pr_model_Wgrid,2) * spread(omega1_grid,2,ndist) * spread(demshare,1,NWgrid1)) / ((ndist))
    momega_dem(2) = sum(sum(pr_model_Wgrid,1) * spread(omega2_grid,2,ndist) * spread(demshare,1,NWgrid2)) / ((ndist))
    momega_dem(3) = sum(sum(pr_model_Wgrid,2) * spread(omega1_grid,2,ndist) * spread(dem_abovemed,1,NWgrid1)) / sum(dem_abovemed) !/207 !/ ((ndist-1)/2)
    momega_dem(4) = sum(sum(pr_model_Wgrid,1) * spread(omega2_grid,2,ndist) * spread(dem_abovemed,1,NWgrid2)) / sum(dem_abovemed) !/207 !/ ((ndist-1)/2)


    !printing to check distance
    !!omega1
    !do j=1, 16
    !   write(*,*) momega1(j), aux_omega(j,:), abs(momega1(j) - aux_omega(j,:))
    !end do
    !write(*,*)
    !!omega2
    !do j=1, 16
    !   write(*,*) momega2(j), aux_omega(j+16,:), abs(momega2(j) - aux_omega(j+16,:))
    !end do
    !write(*,*)
    !!E(omega1)
    !write(*,*) momega_means(1), aux_omega(33,:), abs(momega_means(1)-aux_omega(33,:))
    !!E(omega2)
    !write(*,*) momega_means(2), aux_omega(34,:), abs(momega_means(2)-aux_omega(34,:))
    !!E(omega1*omega2)
    !write(*,*) momega_means(3), aux_omega(35,:), abs(momega_means(3)-aux_omega(35,:))
    !!E(omega1^2)
    !write(*,*) momega_means(4), aux_omega(36,:), abs(momega_means(4)-aux_omega(36,:))
    !!E(omega2^2)
    !write(*,*) momega_means(5), aux_omega(37,:), abs(momega_means(5)-aux_omega(37,:))
    
    
    aux_omega_model(:,1) = (/ momega1, momega2, momega_means, &
         momega_pr1(1:nWgrid1-1),momega_pr2(1:nWgrid2-1),momega_old, momega_dem /)

    deallocate(tc, tc_mean)
    
  end subroutine calc_aux_omega_parameters


  ! for the 'other' moms
  subroutine calc_aux_other_parameters(pr_match, aux_other_out)
    !double precision, dimension(nteach,ndist), intent(in)  :: pr_match
    double precision, dimension(:,:), intent(in)  :: pr_match
    double precision, dimension(naux_other,1), intent(out) :: aux_other_out
    
    !double precision, dimension(nteach,ndist) :: new_hires, C1_mat, C2_mat
    double precision, allocatable, dimension(:,:) :: new_hires, C1_mat, C2_mat
    double precision, dimension(ndist)        :: inc_only, new_hires_frac
    integer,          dimension(ndist)        :: excess_capacity
    double precision, dimension(ndist,4)      :: e_xd
    
    double precision :: under2, over2, under20, over20
    integer :: i,j

    double precision, dimension(5,4) :: mom1, mom2
    double precision, dimension(2,4) :: mom3, mom4
    double precision :: mom5
    double precision, dimension(5)   :: mom6, mom7
    double precision, dimension(2)   :: mom8, mom9, mom10
    double precision, dimension(5)   :: mom11
    double precision, dimension(2,2) :: mom12
    double precision                 :: mom13


    allocate(new_hires(nteach,ndist), C1_mat(nteach,ndist), C2_mat(nteach,ndist))
    

    ! this needs quintiles to already be calculated, which happens in read_data so should
    !    always be ok
    if (sum(lambda_quintiles) .ne. ndist) then
       print*, ' Did not calculate quintiles before running calc_aux_other_parameters '
       call exit(1)
    end if


    !premultiply to get proper dimension
    C1_mat = matmul(C1, ones_ndist)
    C2_mat = matmul(C2, ones_ndist)
    

    !find E(X|d) for each d
    e_xd(:,1) = sum(exp_con * pr_match,1) / real(sum(pr_match,1))
    e_xd(:,2) = sum(C1_mat  * pr_match,1) / real(sum(pr_match,1))
    e_xd(:,3) = sum(C2_mat  * pr_match,1) / real(sum(pr_match,1))
    e_xd(:,4) = sum(master  * pr_match,1) / real(sum(pr_match,1))
    !set nans to zero (i.e. if district has no teacher matches...)
    do j=1, ndist
       if (e_xd(j,1) .ne. e_xd(j,1)) then !check for nan
          e_xd(j,:) = 0
       end if
    end do

    !take moments across quintiles
    do i=1, 5
       mom1(i,:) = sum(e_xd * spread(lambda_quintiles(i,:),2,4),1) / 82
       mom2(i,:) = sum(e_xd * spread(bt_quintiles(i,:),2,4),1)     / 82
    end do
    mom3(1,:) = sum(e_xd * spread(suburban(1,:),2,4),1)     / sum(suburban(1,:))
    mom3(2,:) = sum(e_xd * spread(1 - suburban(1,:),2,4),1) / sum(1 - suburban(1,:))
    mom4(1,:) = sum(e_xd * spread(urban(1,:),2,4),1)     / sum(urban(1,:))
    mom4(2,:) = sum(e_xd * spread(1 - urban(1,:),2,4),1) / sum(1 - urban(1,:))

    ! *** % of districts with only tenured incumbents ***

    !which districts only have tenured incumbents (i.e. inverse have some new hires)
    do j=1, ndist
       !prob for model, (i.e. no matches from all non-ten-inc)
       inc_only(j) = product((1-pr_match(:,j)),(1-inc(:,j)*tenured(:,j)).eq.1)
    end do

    ! getting NaNs, so I am investigating
    !print*, 'inc investigate'
    !print*, sum(inc_only), sum(pr_match), sum(inc), sum(tenured)

    !across all district
    mom5 = sum(inc_only) / real(ndist)

    !by lambda and b/t quintiles. 
    do i=1, 5 !loop over qunitiles
       mom6(i) = sum(inc_only * lambda_quintiles(i,:)) / real(sum(lambda_quintiles(i,:)))
       mom7(i) = sum(inc_only * bt_quintiles(i,:))     / real(sum(bt_quintiles(i,:)))
    end do
    !suburban and urban
    mom8(1) = sum(inc_only * suburban(1,:))     / real(sum(suburban(1,:)))
    mom8(2) = sum(inc_only * (1-suburban(1,:))) / real(sum(1-suburban(1,:)))
    mom9(1) = sum(inc_only * urban(1,:))        / real(sum(urban(1,:)))
    mom9(2) = sum(inc_only * (1-urban(1,:)))    / real(sum(1-urban(1,:))) 

    !now look between districts that have more slots than incumbents
    excess_capacity = 0 
    do j=1, ndist
       if (T(1,j) .gt. sum(inc(:,j) * tenured(:,j))) then
          excess_capacity(j) = 1
       end if
    end do
    mom10(1) = sum(inc_only * excess_capacity)     / real(sum(excess_capacity))
    mom10(2) = sum(inc_only * (1-excess_capacity)) / real(sum(1-excess_capacity))

    ! *** districts w/ new hires: new hires/T and charac. of new hires ***
    ! districts w/ new hires is 1 - inc_only or model_inc_only

    !which hires are new hires (non-tenured incumbents)
    new_hires       = (1-(inc*tenured)) * pr_match
    new_hires_frac  = sum(new_hires,1) / real(T(1,:))

    !average fraction of new hires over capacity
    mom11(1) = sum(new_hires_frac * (1-inc_only)) / real(sum(1-inc_only))
    !average characteristics for new hires
    mom11(2) = sum(exp_con * new_hires) / real(sum(new_hires))
    mom11(3) = sum(C1_mat  * new_hires) / real(sum(new_hires))
    mom11(4) = sum(C2_mat  * new_hires) / real(sum(new_hires))
    mom11(5) = sum(master  * new_hires) / real(sum(new_hires))

    ! adding information on over/under capacity for districts
    under2 = 0
    over2  = 0
    under20 = 0
    over20 = 0
    do j=1, ndist
       if (T(1,j)  - sum(pr_match(:,j)) > 2)  under2 = under2 + 1
       if (T(1,j)  - sum(pr_match(:,j)) < -2) over2  = over2  + 1
       if ((T(1,j) - sum(pr_match(:,j)))/T(1,j) > 0.2)   under20 = under20 + 1
       if ((T(1,j) - sum(pr_match(:,j)))/T(1,j) < -0.2 ) over20  = over20  + 1
    end do

    !12  
    mom12(1,1) = over2  / dble(ndist)
    mom12(1,2) = under2 / dble(ndist)
    mom12(2,1) = over20 / dble(ndist)
    mom12(2,2) = under20 / dble(ndist)

    !13 Pr_stay
    mom13 = sum( sum(pr_match * inc,2) ) / dble(nteach)


    ! save to the output vector

    !1
    aux_other_out(1:20,1)  = reshape(mom1, (/ 5*4 /))
    !2
    aux_other_out(21:40,1) = reshape(mom2, (/ 5*4 /))
    !3
    aux_other_out(41:48,1) = reshape(mom3, (/ 2*4 /))
    !4
    aux_other_out(49:56,1) = reshape(mom4, (/ 2*4 /))
    !5
    aux_other_out(57,1)    = mom5
    !6
    aux_other_out(58:62,1) = mom6
    !7
    aux_other_out(63:67,1) = mom7
    !8
    aux_other_out(68:69,1) = mom8
    !9
    aux_other_out(70:71,1) = mom9
    !10
    aux_other_out(72:73,1) = mom10
    !11
    aux_other_out(74:78,1) = mom11
    !12
    aux_other_out(79:82,1) = reshape(mom12, (/ 2*2 /))
    !13
    aux_other_out(83,1)    = mom13

    deallocate(new_hires, C1_mat, C2_mat)
    
  end subroutine calc_aux_other_parameters
  


  !Takes the average of the bottom pth percentile of each column of inputmatrix
  !  model_match is basically the weight
  function prctile_mean(inmat,model_match,p) result(outvec)
    use qsort_mod
    !double precision, dimension(nteach,ndist), intent(in)  :: inmat
    !double precision, dimension(nteach,ndist), intent(in)  :: model_match
    double precision, dimension(:,:), intent(in)  :: inmat
    double precision, dimension(:,:), intent(in)  :: model_match
    integer, intent(in) :: p
    double precision, dimension(ndist) :: outvec

    double precision, allocatable, dimension(:,:) :: sortedvec
    double precision :: pp, Wsum, prctile
    integer :: i, j, k, indL, nmatch

    !calculate mean of bottom pth percentile teachers separately for each district
    do j=1, ndist
       !first create vec w/ inmat statistic for only those who match
       nmatch = 0
       do i=1, nteach
          if (model_match(i,j) > 0) nmatch = nmatch + 1
       end do
       !nmatch = sum(model_match(:,j))
       allocate(sortedvec(nmatch,2))
       k = 1
       do i=1, nteach
          if (model_match(i,j) > 0 ) then
             sortedvec(k,1) = inmat(i,j)
             sortedvec(k,2) = model_match(i,j)
             k = k+1
          end if
       end do
       call qsort_2d(sortedvec)

       !following stata pctile method
       pp = sum(model_match(:,j)) * p / 100d0 !P

       indL = 0
       Wsum = 0 !W(i)
       !find pctile
       do
          if (indL >= nmatch) exit !check out of bounds
          indL = indL + 1
          Wsum = Wsum + sortedvec(indL,2)
          if(Wsum > pp) then
             if (abs(Wsum - sortedvec(indL,2) - pp) .lt. epsilon(pp)) then
                prctile = (sortedvec(indL-1,1) + sortedvec(indL,1)) / 2
                indL = indL - 1
             else
                prctile = (sortedvec(indL,1))
             end if
             exit
          end if
       end do

       !check for 'ties'
       do
          if (indL+1 >= nmatch) exit !check out of bounds
          if (sortedvec(indL+1,1) > prctile .or. indL >= nmatch) then
             exit
          else
             indL = indL +1
          end if
       end do
       
       outvec(j) = sum(sortedvec(1:indL,1)) / indL

       deallocate(sortedvec)
    end do

  end function prctile_mean

  !subroutine to make it cleaner to build design matrix for fixed effect reg
  !  takes a teacher x dist matrix, demeans for each teacher, and then
  !  returns a reshaped version
  !  only takes mean across obs where offermat==1
  subroutine demean_and_reshape(mat, offermat, outmat)
    !double precision, dimension(nteach,ndist), intent(in) :: mat
    !integer,          dimension(nteach,ndist), intent(in) ::offermat
    double precision, dimension(:,:), intent(in) :: mat
    integer,          dimension(:,:), intent(in) ::offermat
    !double precision, dimension(nteach,ndist) :: mat2
    double precision, allocatable, dimension(:,:) :: mat2
    double precision, dimension(:), intent(inout) :: outmat
    double precision, dimension(nteach) :: x_mean
    integer :: i,j,k

    !find mean 
    do i=1,nteach
       x_mean(i) = sum(mat(i,:)*offermat(i,:)) / sum(offermat(i,:))
    end do
    !demean by teacher
    do j=1, ndist
       do i=1, nteach
          mat2(i,j) = mat(i,j) - x_mean(i)
       end do
    end do

    !if teacher has offer, reshape into column matrix (outmat)
    k=1
    do j=1, ndist
       do i=1, nteach
          if( offermat(i,j) .eq. 1 ) then
             outmat(k) = mat2(i,j)
             k = k + 1
          end if
       end do
    end do

  end subroutine demean_and_reshape

end module aux_model

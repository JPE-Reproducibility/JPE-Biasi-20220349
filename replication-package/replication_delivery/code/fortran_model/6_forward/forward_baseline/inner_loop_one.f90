! inner_loop_one.f90
! created: Oct 2018
!
! Inner loop part one:
!  iterate over district beliefs to find h, and offers
!
! Parallel intuition: The master thread runs 'run_inner_loop_one'
!   whereas the slave threads run 'run_slave_inner_loop_one'.
!   The master thread passes ALL data necessary to slaves,
!   who then compute their part of the problem and return to master
!

module inner_loop_one
  use global_variables
  use utility_functions
  use belief_functions
  use knapsack_problem
  use statistical_models
  use mpi
  implicit none

  private
  ! ** mpi vars ** (get 't' suffix to denote thread-specific versions)
  integer :: rec_count, call_no
  integer, allocatable, dimension(:) :: send_counts, send_starts
  double precision, allocatable, dimension(:,:) :: Ht, udistt, waget, Bt, Tt
  integer, allocatable, dimension(:,:) :: tenuredt
  double precision, allocatable, dimension(:,:,:) :: pr_model_Wgridt
  !integer, dimension(nteach) :: noninc_offert
  !integer, allocatable, dimension(:) :: noninc_offert  moved to local to functions
  integer, allocatable, dimension(:,:) :: inct, model_offert
  !integer, dimension(nteach,ndist) :: model_offer, best_model_offer
  integer, allocatable, dimension(:,:) :: model_offer, best_model_offer
  !double precision, dimension(nteach,ndist) :: H, udist, uteach
  double precision, allocatable, dimension(:,:) :: H, udist, uteach

  !double precision, dimension(nteach,ndist) :: exp_uteach, H_target
  double precision, allocatable, dimension(:,:) :: exp_uteach!, H_target moved H_target to local fn
  double precision, allocatable, dimension(:,:) :: best_H_target
  double precision :: sigmad_glob, best_D, gamma_glob(ngamma), sigma_glob
  double precision, dimension(ntheta) :: best_theta

  double precision, dimension(nalpha) :: alpha_glob

  double precision, dimension(nWgrid1,nWgrid2,ndist) :: pr_model_Wgrid_glob,pr_omegas_eqm_glob

  integer :: economy_idx
  !double precision, dimension(nteach,ndist) :: wage_eqm_glob, H_eqm_glob
  double precision, allocatable, dimension(:,:) :: wage_eqm_glob, H_eqm_glob
  !integer,          dimension(nteach,ndist) :: offer_eqm_glob
  integer, allocatable, dimension(:,:)       :: offer_eqm_glob
  double precision, dimension(2,ndist)      :: omegas_eqm_glob
  !double precision, dimension(nteach)       :: mean_eqm_glob, sd_eqm_glob
  double precision, allocatable, dimension(:) :: mean_eqm_glob, sd_eqm_glob

  !temp variable for printing mean approx comparison
  integer :: print_indicator, economy_output_indicator, true_wage_indicator

  public :: run_inner_loop_one, run_slave_inner_loop_one, simulate_equilibrium

contains

  subroutine run_inner_loop_one(pr_model_match,model_match_copies, pr_model_Wgrid, &
       alpha_in,beta_in,sigma_in,gamma_in,sigmaD_in)
    !use ieee_arithmetic (not supported on flash gfortran compiler)
    !use simplex
    use simplex_salvador_inner
    !double precision, dimension(nteach,ndist), intent(out) :: pr_model_match
    double precision, dimension(:,:), intent(out) :: pr_model_match
    !integer, dimension(NcopyT,nteach,ndist), intent(out) :: model_match_copies
    integer, dimension(:,:,:), intent(out) :: model_match_copies
    double precision, dimension(nWgrid1,nWgrid2,ndist), intent(out) :: pr_model_Wgrid
    double precision, dimension(nalpha), intent(in)  :: alpha_in
    double precision, dimension(nbeta),  intent(in)  :: beta_in
    double precision, dimension(ngamma), intent(in)  :: gamma_in
    double precision,                    intent(in)  :: sigma_in, sigmaD_in

    ! helper for rigid pay purpose
    double precision, allocatable, dimension(:,:) :: C_matrix
    double precision, dimension(6) :: teacher_tc


    !double precision, dimension(ncopyT,nteach, ndist) :: v!uteach!, H_target !exp_uteach,
    double precision, allocatable, dimension(:,:,:) :: v!uteach!, H_target !exp_uteach,
    integer, dimension(ndist,2) :: aa
    integer :: i, j, k

    allocate(v(ncopyT,nteach, ndist))
    allocate(model_offer(nteach,ndist), best_model_offer(nteach,ndist))
    allocate(H(nteach,ndist),udist(nteach,ndist), uteach(nteach,ndist),exp_uteach(nteach,ndist))

    if (purpose == 7) then
       allocate(best_H_target(nteach,ndist))
       allocate(C_matrix(nteach,ndist))
    end if

    write(*,*) ' INNER LOOP ', nround-1

    !tmp ugly fix to share sigmas to theta_objective_fn
    sigmad_glob = sigmad_in
    gamma_glob  = gamma_in

    !calc utility matrices
    !udist  = utility_district(beta_in)
    call utility_district(beta_in, udist)
    !write(*,*) sum(udist) / (nteach*ndist)
    !call exit(1)
    !uteach = utility_teacher(alpha_in)
    call utility_teacher(alpha_in, uteach)

    !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
    !uteach = uteach - spread(maxval(uteach,2),2,ndist)
    uteach = uteach - spread(minval(uteach,2),2,ndist)

    exp_uteach = exp(uteach / sigma_in)
    
    !check for infinity
    !do i=1, nteach
    !   do j=1, ndist
    !      !if (ieee_is_finite(exp_uteach(i,j)) .eqv. .FALSE.) then
    !      if (abs(exp_uteach(i,j)) .gt. huge(exp_uteach(i,j))) then
    !         print *, 'warning: exp(uteach/sigma) gives infinite values,  uteach:', uteach(i,j)
    !         !call EXIT(1)
    !      end if
    !      if (abs(exp_uteach(i,j) - 0.0d0) .lt. epsilon(exp_uteach(i,j))) then
    !         print *, 'warning: exp(uteach/sigma)=0,  uteach:',uteach(i,j)
    !         !call exit(1)
    !      end if
    !   end do
    !end do
    !   print* , 'before share data'

    ! *** pass static matrices to other threads ***
    call share_data_to_threads()

    
    call_no = 0

    if (teachOff_decision == 1) then
       if (offer_eqbm == 1 .and. skip_inner_loop == 0) then
          !
          if(nround<=sum(incl,dim=1)+2) then
             theta = theta0
          else
             theta = theta_sofar
          endif

          best_theta = theta_sofar          
          ! (initial params, pct tol, objective fn, print, max iter, dif tol, simplex length)
          best_D = huge(best_D) !need to keep track of our best obj fun value
          call nelder_meade_inner(theta,h_tol_pct,theta_objective_fn_convex,&
               1,h_maxiter,0d0,h_tol_min)
          !Note: best_theta and best_model_offer set inside theta_objective_fn
          if(nround==1) then
             theta0 = best_theta
          endif
          theta       = best_theta
          call h_logit(theta,H)
          model_offer = best_model_offer

          !tell slave processes to stop
          call mpi_bcast(1,1,mpi_int,0,mpi_comm_world,ierr)

          !temp save last theta to compare
          write(*,*) '   theta dif', sum(abs(theta-theta_prev))
          theta_prev = theta
          D_sofar=best_D

       else
          ! no offer eqbm is run if offer_eqbm=0 or skip_inner_loop=1

          if (skip_inner_loop == 1) then
             write(*,*) 'skipping first inner loop'
             skip_inner_loop = 0
          end if

          !get h implied by theta
          call h_logit(theta,H)

          !tell slave processes we need their help on knapsack
          call mpi_bcast(0,1,mpi_int,0,mpi_comm_world,ierr)

          !run knapsack, saves model_offer to global vars
          call solve_knapsack_parallel()

          !tell slave processes we are done w/ knapsack
          call mpi_bcast(1,1,mpi_int,0,mpi_comm_world,ierr)

       end if ! about whether to do the offer decision, i.e. inner loop


       !Now calculate probabilities based on solved offers (note exp_uteach contains sigma)
       do j=1, ndist
          pr_model_match(:,j) = exp_uteach(:,j) * model_offer(:,j) / &
               sum(exp_uteach * model_offer,2)
       end do
       !Find matches for all teacher copies
       do k=1, NcopyT
          v(k,:,:) = uteach
       end do
       v = v + sigma_in*Tshock
       !v = v - sigma_in*Tshock
       do j=1, ndist
          do i=1, nteach
             if (model_offer(i,j) == 0) then
                !if no offer, utility is negative infinity
                v(:,i,j) = inf_neg()
             end if
          end do
       end do
       model_match_copies = 0
       do i=1, nteach
          !teacher pick district which gives highest utility
          if (sum(model_offer(i,:)) .gt. 0) then
             !if teacher receives offer, pick max offer
             do k=1, NcopyT
                model_match_copies(k,i,maxloc(v(k,i,:))) = 1
             end do
          end if
       end do

    end if ! teachOff_decision==1
    !knapsack is now solved at this point


    !Now take advantage that all threads still have their respective datasets
    !  each thread will solve for each alpha of their assigned districts
    if (wage_decision == 1) then
       ! solving optimal wage choices
       call solve_omega_prob_parallel()

       !set subroutine argument to same as module variable (output)
       pr_model_Wgrid = pr_model_Wgrid_glob

    else

       ! if not solving wage decision set all to zero
       pr_model_Wgrid = 0

       !       !if not solving district wage decision, set wage choice as seen in data:
       !       pr_model_Wgrid = 0
       !       call OmegaIndex(Wgrid,aa)
       !       do j=1,ndist
       !          pr_model_Wgrid(aa(j,1),aa(j,2),j)=1
       !       end do

    end if



    ! For rigid pay, we need to save the same stuff we save for eqbm, so that we can compare

    if (purpose == 7) then
       
       open(1,file='result/eqbm_dist_contribution.txt',status='replace')
       write(1,*) ' economy_id', ' district_id', ' avg_expect_cont', ' avg_C1', ' avg_C2',&
            ' avg_expect_exp', ' avg_expect_MA', ' lambda', ' urban', ' suburban',&
            ' budg_per_teach', ' budget', ' capacity', ' share_tenured'
       close(1)
       open(1,file='result/eqbm_dist_hires.txt',status='replace')
       write(1,*) ' economy_id', ' district_id', ' expected_hires', ' capacity', ' belief_expected_hires'
       close(1)
       open(1,file='result/eqbm_dist_wages.txt',status='replace')
       write(1,*) ' economy_id', ' district_id', ' expected_wage_bill', ' budget', ' belief_expected_Wage_bill'
       close(1)
       open(1,file='result/eqbm_beliefs.txt',   status='replace')
       write(1,*) ' economy_id', ' theta_n', ' theta'
       close(1)
       open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
       write(1,*) ' economy_id',  ' exp1_tc', ' exp2_tc', ' exp3_tc', ' exp4_tc', ' exp5_tc', ' exp6_tc'
       close(1)

       open(1,file='result/eqbm_omegas.txt',status='replace')
       write(1,*) ' economy_id ', 'district_id ', 'omega1 ', 'omega2 '
       do j=1, ndist
          write(1,*) 1, j, 1, 0
       end do
       close(1)

       !set up vector of teachers with full contribution
       C_matrix = matmul(C1,share_low(1:1,:)) + matmul(C2,(1-share_low(1:1,:)))
       open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
       open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
       open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
       do j=1,ndist
          !true total expected contribution
          write(1,*) 1, j, &
               sum(best_H_target(:,j)*model_offer(:,j)*C_matrix(:,j))/sum(best_H_target(:,j)*model_offer(:,j)), &
               sum(best_H_target(:,j)*model_offer(:,j)*C1(:,1))/sum(best_H_target(:,j)*model_offer(:,j)), &
               sum(best_H_target(:,j)*model_offer(:,j)*C2(:,1))/sum(best_H_target(:,j)*model_offer(:,j)), &
               sum(best_H_target(:,j)*model_offer(:,j)*exp_con(:,j))/sum(best_H_target(:,j)*model_offer(:,j)), &
               sum(best_H_target(:,j)*model_offer(:,j)*master(:,j))/sum(best_H_target(:,j)*model_offer(:,j)), &
               share_low(1,j), urban(1,j), suburban(1,j), B(1,j)/T(1,j), B(1,j), T(1,j), &
               sum(inc(:,j)*tenured(:,j)) / dble(T(1,j))
          !true expected hires
          write(2,*) 1, j, sum(best_H_target(:,j)*model_offer(:,j)), T(1,j), &
               sum(H(:,j)*model_offer(:,j))
          !true expected wages
          write(3,*) 1, j, &
               sum(best_H_target(:,j)*model_offer(:,j)*wage(:,j)), B(1,j), &
               sum(H(:,j)*model_offer(:,j)*wage(:,j))
       end do
       close(1)
       close(2)
       close(3)
       !save beliefs associated with this economy equilibrium
       open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
       do j=1, ntheta
          write(1,*) 1, j, theta(j)
       end do
       do j=1, ntheta_wage
          write(1,*) 1, j+ntheta, theta0_wage(j)
       end do
       close(1)

       !save stats conditional on teacher chars
       open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
       !avg tc by teach experience group
       do j=1, 6
          teacher_tc(j) = sum(matmul(exp_dum(:,j:j),ones_ndist) * best_H_target * model_offer * C_matrix)
       end do
       
       write(4,*) economy_idx, teacher_tc(1), teacher_tc(2), teacher_tc(3), teacher_tc(4), teacher_tc(5), teacher_tc(6)

       close(4)

       deallocate(best_H_target, C_matrix)
    end if !purpose == 7, saving "eqbm" output for rigid pay


    call deallocate_variables()

    deallocate(v)
    deallocate(model_offer, best_model_offer)
    deallocate(H, udist, uteach, exp_uteach)

  end subroutine run_inner_loop_one

  !return index of omega grid wage choice closest to WW
  subroutine OmegaIndex(WW,aa)
    double precision,intent(in)  :: WW(ndist,2)
    integer,         intent(out) :: aa(ndist,2)
    integer:: j

    do j=1,ndist
       aa(j,1) = minloc(abs(WW(j,1)-omega1_grid),dim=1)
       aa(j,2) = minloc(abs(WW(j,2)-omega2_grid),dim=1)
    end do

  end subroutine OmegaIndex

  !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
  !  these can be found in the !old folder version of this code:
  !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
  ! removed to avoid bugs

  !THIS IS TRYING THE CONVEX VERSION w/ FEWER COMPONENTS
  !  AS SUGGESTED BY CHAO 6/14/19
  function theta_objective_fn_convex(theta_in) result(D)
    !use ieee_arithmetic (not supported on flash gfortran compiler)
    double precision, dimension(:), intent(in) :: theta_in
    !double precision, dimension(nteach,ndist) :: absdiff !,H_target (moved to module var so could print values)
    double precision, allocatable, dimension(:,:) :: absdiff
    !integer, dimension(nteach,ndist) :: model_match
    !double precision, dimension(nteach) :: denom
    double precision, allocatable, dimension(:) :: denom
    double precision :: D
    integer :: i,j

    double precision w1a, w2a, w3a, w4a
    !integer, dimension(nteach)       :: nooffers
    integer, allocatable, dimension(:) :: nooffers
    !integer, dimension(nteach,ndist) :: indicator
    double precision, allocatable, dimension(:,:) :: indicator

    double precision, allocatable, dimension(:,:) :: H_target

    !allocating nteach vars
    allocate(absdiff(nteach,ndist))
    allocate(denom(nteach))
    allocate(nooffers(nteach))
    allocate(indicator(nteach,ndist))
    allocate(H_target(nteach,ndist))
    

    !tell slave to keep working
    call mpi_bcast(0,1,mpi_int,0,mpi_comm_world,ierr)

    !get h implied by theta
    call h_logit(theta_in,H)

    !run knapsack
    call solve_knapsack_parallel()

    !use offers to find matches
    !v = uteach + sigma_glob*Tshock
    !do j = 1, ndist
    !   do i = 1, nteach
    !      if (model_offer(i,j) == 0) then
    !         !if no offer, utility is negative infinity
    !         v(i,j) = inf_neg()
    !      endif
    !   enddo
    !enddo
    !model_match = 0
    !do i = 1, nteach
    !   !teacher i picks district with highest utility
    !   if (sum(model_offer(i,:)) .gt. 0) then
    !      !if teacher does receive an offer, pick max offer
    !      model_match(i, maxloc(v(i,:))) = 1
    !   end if
    !enddo

    !calculate 'true' beliefs which are the target. Note exp_uteach contains sigma
    !awkward logic here may provide very minor efficiency gain
    denom = sum(exp_uteach * model_offer,2)
    do j=1, ndist
       H_target(:,j) = exp_uteach(:,j) / (denom + (1-model_offer(:,j))*exp_uteach(:,j))
    end do

    !censor values for H_target, just like in belief_functions.f90
    H_target = max(H_target, belief_floor)
    H_target = min(H_target, belief_ceiling)

    !check for 1, to avoid log(0) case
    do j=1, ndist
       do i=1, nteach
          !if (abs(H_target(i,j) - 1.0d0) < epsilon(0d0)) H_target(i,j) = 0.99d0
          !if (ieee_is_finite(exp_uteach(i,j)) .eqv. .FALSE.) then
          if (abs(exp_uteach(i,j)) .gt. huge(exp_uteach(i,j))) then
             !can delete or comment out this check
             !print *, 'exp uteach is inf'
             call EXIT(1)
          end if
       enddo
    enddo

    !w1
    w1a = 10000

    D =     w1a * sum((H-H_target)**2) / (nteach * ndist)
    if(nround<=2 .and. call_no==0) then
       h_tol_min_upper = w1a * 0.02**dble(2) ! average discrepancy is 0.015
       h_tol_min_lower = w1a * 0.01**dble(2) ! average discrepancy is 0.01
    endif
    
    !We need to save the offers and matches associated with the best guess
    !  for theta
    if (D .lt. best_D) then
       best_D = D
       best_theta = theta_in
       best_model_offer = model_offer
       if (purpose == 7) best_H_target = H_target
       write(*,*) '  objective function call: ', call_no, ' best value:', D
    else
       write(*,*) '  objective function call: ', call_no
    end if

    call_no = call_no + 1 !keep track of no of times fn called

    !dealloc nteach vars
    deallocate(absdiff, denom, nooffers, indicator)
    deallocate(H_target)
    

  end function theta_objective_fn_convex


  ! ** Slave and other MPI Processes **
  subroutine run_slave_inner_loop_one()
    integer :: stopFlag, m
    !dummy just needed to follow subroutine format
    double precision, dimension(ntheta) :: dum1


    !integer, allocatable, dimension(:,:) :: inct, model_offert
    !integer, allocatable, dimension(:,:) :: model_offer, best_model_offer
    !double precision, allocatable, dimension(:,:) :: H, udist, uteach
    !double precision, allocatable, dimension(:,:) :: exp_uteach!, H_target moved H_target to local fn
    !double precision, allocatable, dimension(:,:) :: wage_eqm_glob, H_eqm_glob
    !integer, allocatable, dimension(:,:)       :: offer_eqm_glob
    !double precision, allocatable, dimension(:) :: mean_eqm_glob, sd_eqm_glob


    allocate(udist(nteach,ndist))
    allocate(mean_eqm_glob(nteach), sd_eqm_glob(nteach))
    allocate(offer_eqm_glob(nteach,ndist), wage_eqm_glob(nteach,ndist), H_eqm_glob(nteach,ndist))
    
    !get necessary data
    call share_data_to_threads()

    if (T_max == 1) then
       ! loop here until master says stop...
       stopFlag = 0
       do
          !need slave processes to know when to exit loop
          call mpi_bcast(stopFlag,1,mpi_int,0,mpi_comm_world,ierr)
          if (stopFlag==1) exit

          !solve knapsack for given districts
          if (purpose>=10) then
             call solve_eqm_knapsack_parallel(dum1)
          else          
             call solve_knapsack_parallel()
          end if

       end do

       if((wage_decision==1) .and. (purpose < 10)) then
          call solve_omega_prob_parallel()
       end if

    
    else
       ! we're doing forward iter, so need to do some extra sharing about teacher pool
       ! loop here until master says stop...

       do m=1, nEconomy
          if (t_period > 1) then
             call share_data_forward_iter()
             ! and we also need udist
             call share_udist_forward_iter()
          end if

          stopFlag = 0
          do
             
             !need slave processes to know when to exit loop
             call mpi_bcast(stopFlag,1,mpi_int,0,mpi_comm_world,ierr)
             if (stopFlag==1) exit

             !solve knapsack for given districts
             call solve_eqm_knapsack_parallel(dum1)
       
          end do

       end do

    end if

    
    call deallocate_variables()

    deallocate(udist)
    deallocate(mean_eqm_glob, sd_eqm_glob)
    deallocate(offer_eqm_glob, wage_eqm_glob, H_eqm_glob)

  end subroutine run_slave_inner_loop_one

  subroutine share_data_to_threads()
    integer :: chunksize, remainder, i

    !chunksize and remainder
    chunksize = ndist / ntasks !note int/int will round down
    remainder = mod(ndist,ntasks)
    !if (mpi_id == 0) write(*,*) 'id:', mpi_id, 'chunksize:', chunksize, 'remainder', remainder
    !set up send vectors
    allocate(send_counts(ntasks),send_starts(ntasks))
    do i=1, ntasks
       if (i <= remainder) then
          send_counts(i) = chunksize + 1
       else
          send_counts(i) = chunksize
       end if
    end do
    send_starts(1) = 0
    do i=2, ntasks
       send_starts(i) = sum(send_counts(1:i-1))
    end do
    !if (mpi_id == 0) write(*,*) 'id:', mpi_id, 'counts:', send_counts, 'starts:', send_starts


    !set up receive info
    rec_count = send_counts(mpi_id + 1)

    !send ndist matricies (B,T)
    allocate(Bt(1,rec_count))
    call mpi_scatterv(B, send_counts, send_starts, mpi_double_precision, &
         Bt, rec_count, mpi_double_precision, &
         0, mpi_comm_world, ierr)
    allocate(Tt(1,rec_count))
    call mpi_scatterv(T, send_counts, send_starts, mpi_double_precision, &
         Tt, rec_count, mpi_double_precision, &
         0, mpi_comm_world, ierr)

    !need to increase size for larger matrix sends
    send_counts = send_counts * nteach
    send_starts = send_starts * nteach
    !if (mpi_id == 0) write(*,*) 'id', mpi_id, 'counts', send_counts, 'starts', send_starts
    rec_count = send_counts(mpi_id + 1)

    !send nteach x ndist matricies (udist,wage,inc,tenured)
    allocate(udistt(nteach,rec_count/nteach))
    call mpi_scatterv(udist, send_counts, send_starts, mpi_double_precision, &
         udistt, rec_count, mpi_double_precision, &
         0, mpi_comm_world, ierr)

    ! 'waget' only needed for estimation step. Equilibrium uses waget_vary which is constructed
    !    where it is needed using wageschedule and omegas
    allocate(waget(nteach,rec_count/nteach))
    call mpi_scatterv(wage, send_counts, send_starts, mpi_double_precision, &
         waget, rec_count, mpi_double_precision, &
         0, mpi_comm_world, ierr)
    allocate(inct(nteach,rec_count/nteach))
    call mpi_scatterv(inc, send_counts, send_starts, mpi_int, &
         inct, rec_count, mpi_int, &
         0, mpi_comm_world, ierr)
    allocate(tenuredt(nteach, rec_count/nteach))
    call mpi_scatterv(tenured, send_counts, send_starts, mpi_int, &
         tenuredt, rec_count, mpi_int, &
         0, mpi_comm_world, ierr)
    !also need sigmad
    call mpi_bcast(sigmad_glob,1,mpi_double_precision,0,mpi_comm_world,ierr)
    !also need gammas...
    call mpi_bcast(gamma_glob,ngamma,mpi_double_precision,0,mpi_comm_world,ierr)

    !also allocate matrices we will use in h loop
    allocate(Ht(nteach,rec_count/nteach))
    allocate(model_offert(nteach,rec_count/nteach))
    if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))

  end subroutine share_data_to_threads

  !each thread solves its own share of the knapsack problem
  subroutine solve_knapsack_parallel()
    integer :: i, j

    integer, allocatable, dimension(:) :: noninc_offert


    allocate(noninc_offert(nteach))


    !pass/receive H across threads
    call mpi_scatterv(H, send_counts, send_starts, mpi_double_precision, &
         Ht, rec_count, mpi_double_precision, &
         0, mpi_comm_world, ierr)

    !all tenured incumbents will get offers
    model_offert = inct * tenuredt
    do j=1, rec_count/nteach
       !write(*,*) 'dist',j*(mpi_id+1)
       call solve_knapsack(Ht,j,udistt,waget,model_offert,Bt,Tt,nteach,noninc_offert)
       !offers for non-incumbents
       do i=1, nteach
          if (noninc_offert(i) == 1) then
             model_offert(i,j) = 1
          end if
       end do
    end do

    !gather offers back to master thread
    call mpi_gatherv(model_offert, rec_count, mpi_int, &
         model_offer, send_counts, send_starts, mpi_int,&
         0, mpi_comm_world, ierr)

    deallocate(noninc_offert)

  end subroutine solve_knapsack_parallel

  !Remember: Each thread was given a 'slice' of matrices with only information 
  !    about the districts they are working on. (t suffixes).
  ! This is an issue though for using h_logit_vary, b/c those global vars
  !    aren't just a slice, they are the full matricies. Have to back out
  !    which district nums each thread is working on
  subroutine solve_omega_prob_parallel()
    integer i, j, a1, a2, dist_num
    double precision, dimension(nWgrid1,nWgrid2) :: profit !resist_cost,
    double precision :: resist_cost
    !double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
    double precision, allocatable, dimension(:,:) :: Ht_vary, waget_vary
    !double precision, dimension(nteach) :: wstat_vary
    double precision, allocatable, dimension(:) :: wstat_vary
    integer :: rec_count_omega
    integer, allocatable, dimension(:) :: send_counts_omega, send_starts_omega

    integer, allocatable, dimension(:) :: noninc_offert

    ! allocate nteach vars
    allocate(Ht_vary(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
    allocate(wstat_vary(nteach))
    allocate(noninc_offert(nteach))
    
    !make sure everyone has updated H (only need for bug checking)
    !call mpi_scatterv(H, send_counts, send_starts, mpi_double_precision, &
    !     Ht, rec_count, mpi_double_precision, &
    !     0, mpi_comm_world, ierr)
    !and knows theta
    call mpi_bcast(theta, ntheta, mpi_double_precision, 0, mpi_comm_world,ierr)

    !figure out index of district j
    dist_num = 0
    if (mpi_id .gt. 0) then
       do i=1, mpi_id
          dist_num = dist_num + send_counts(i)/nteach
       end do
    end if


    ! use index j for variables with t suffix
    !     (t denotes thead only has 'slice' of matrix)
    ! use index dist_num for full matricies
    !open(88,file='dist_offer_check.txt',status='replace')
    !write(88,*) 'dist_num     ','a1     ','a2     ','profit     ',&
    !     'excess_budget     ', 'excess_capacity     ','num_offers     '
    do j=1, rec_count/nteach!85,85
       dist_num = dist_num + 1!85

       !write(*,*) j, dist_num
       !loop over omegas
       do a1=1, nWgrid1 !1,1
          do a2=1, nWgrid2 !1,1
             !calc waget_vary,
             ! XXX this is wasteful copying of waget? I should comment out?
             !   (i.e. only row j matters for the knapsack calc but needed it in this data structure
             !       to use the old same knapsack code function, so rest of waget is irrelevant)
             waget_vary = waget
             waget_vary(:,j) = omega1_grid(a1)*wageschedule(:,dist_num) + &
                  omega2_grid(a2)*contribution(:,dist_num)
             waget_vary(:,j) = min(waget_vary(:,j), wageupper)
             waget_vary(:,j) = max(waget_vary(:,j), wagelower)

             !calc wstat_vary, used to calc new beliefs
             wstat_vary = (waget_vary(:,j) - meanW) / sdW

             !calc Ht_vary (other omega grid points)
             ! (need to check how original is saved so we don't have to duplicate here)
             !Ht_vary = Ht !dont think I need this
             !tmp bug check
             !Ht_vary(:,j) = h_logit_vary(theta,dist_num, wstat(:,dist_num))
             !if (Ht(1,j) .ne. H(1,dist_num)) then
             !   write(*,*) 'idx mistake', Ht(1,j), H(1,dist_num)
             !   call exit(1)
             !end if

             !if (Ht(1,j) .ne. Ht_vary(1,j)) then
             !   write(*,*) 'not equal', j, dist_num, Ht(1,j), Ht_vary(1,j)
             !end if
!!!
             !not using this part of code
             !Ht_vary(:,j) = h_logit_vary(theta,dist_num, wstat_vary)
             call h_logit_vary(theta, dist_num, wstat_vary, Ht_vary(:,j))
             !print*, 'just in case dont run this code error'
             !call exit(1)

             !solve for offers
             !all tenured incumbents will get offers
             model_offert = inct * tenuredt
             call solve_knapsack(Ht_vary,j,udistt,waget_vary,model_offert,&
                  Bt,Tt,nteach,noninc_offert)
             !offers for non-incumbents
             do i=1, nteach
                if (noninc_offert(i) == 1) then
                   model_offert(i,j) = 1
                end if
             end do

             !take Ht_vary and offers and udist, find expected utility from choosing the omega
             !calc resistcost   (now needs to be within loop or else I could compute a vector but whatever)
             resist_cost = Rcost(omega1_grid(a1),omega2_grid(a2), demshare(dist_num), gamma_glob)
             profit(a1,a2) = sum(Ht_vary(:,j)*model_offert(:,j)*udistt(:,j))/Tt(1,j) - resist_cost
             ! Test
             !if(dist_num==12) then
             !    print*, 'j, a1, a2, district pi, pi-resist, #offers, expected hires'
             !    print*, j, a1, a2, sum(Ht_vary(:,j)*model_offert(:,j)*udistt(:,j))/Tt(1,j), profit(a1,a2),&
             !         sum(model_offert(:,j)), sum(Ht_vary(:,j)*model_offert(:,j)), &
             !         sum(model_offert(:,j)), sum(Ht_vary(:,j))
             !end if
              
             if (abs(exp(profit(a1,a2) / sigmad_glob)) .gt. huge(profit(a1,a2))) then
                print *, 'warning: exp(profit/sigma) gives infinite values,  profit:', profit(a1,a2),  'sigmad',sigmad_glob
                profit(a1,a2) = log(huge(sigmad_glob)) !for now just set exp() = infinity
                !call EXIT(1)
             end if
             !if (abs(exp(profit(a1,a2) / sigmad_glob) - 0.0d0) .lt. epsilon(profit(a1,a2))) then
             !   print *, 'warning: exp(uteach/sigma)=0,  profit:', profit(a1,a2),  'sigmad',sigmad_glob
             !   profit(a1,a2) = log(epsilon(sigmad_glob))!-30 * sigmad_glob !for now just set essentially to exp() = epsilon
             !   !call exit(1)
             !end if

             !temp, print out to check that everything looks kosher with offer solution
             !write(88,*) j, a1, a2, profit(a1,a2),&
             !     (Bt(1,j)-sum(Ht_vary(:,j)*model_offert(:,j)*waget_vary(:,j))),&!
             !     (Tt(1,j)-sum(Ht_vary(:,j)*model_offert(:,j))), &
             !     sum(model_offert(:,j))
          end do
       end do
       !if(j==10) call exit(1)
       !write(*,*) 'max profit', maxval(profit), dist_num, mpi_id
       !calc prob of choosing each omega
       do a1=1, nWgrid1
          do a2=1, nWgrid2
             !pr_model_Wgridt(a1,a2,j) = exp(profit(a1,a2) / sigmad_glob) / &
             !     sum(exp(profit / sigmad_glob))
             !w/ trick to avoid exp overflow
             pr_model_Wgridt(a1,a2,j) = exp((profit(a1,a2)-profit(1,1)) /sigmad_glob) / &
                  sum(exp((profit-profit(1,1)) / sigmad_glob))
          end do
       end do
       
       
    end do
    !close(88) !close our tmp writeout doc
    !call exit(1)
    
    !Share model_wgridt back to master
    !first set count vars, send_starts/counts are nteach * ndist, we need
    !  to adjust instead to nWgrid1 * nWgrid2 * ndist
    allocate(send_starts_omega(ntasks),send_counts_omega(ntasks))
    send_starts_omega = send_starts / nteach * nWgrid1 * nWgrid2
    send_counts_omega = send_counts / nteach * nWgrid1 * nWgrid2
    rec_count_omega   = rec_count   / nteach * nWgrid1 * nWgrid2

    call mpi_gatherv(pr_model_Wgridt, rec_count_omega, mpi_double_precision, &
         pr_model_Wgrid_glob, send_counts_omega, send_starts_omega, &
         mpi_double_precision, &
         0, mpi_comm_world, ierr)

    deallocate(send_starts_omega, send_counts_omega)


    !dealloc nteach vars
    deallocate(Ht_Vary, waget_vary, wstat_vary)
    deallocate(noninc_offert)

  end subroutine solve_omega_prob_parallel

  !
  !subroutine simulate_equilibrium(alpha_in, beta_in, gamma_in, sigma_in, sigmaD_in,&
  !     sim_matches, sim_pr_matches, sim_pr_omegas)
  subroutine simulate_equilibrium(alpha_in, beta_in, gamma_in, sigma_in, sigmaD_in,&
         sim_matches, pr_model_match,pr_model_Wgrid)
    use simplex_salvador_equilibrium
    use simplex_salvador_equilibrium_w
    use read_data_params
    double precision, dimension(:), intent(in) :: alpha_in, beta_in, gamma_in
    double precision,               intent(in) :: sigma_in, sigmaD_in
    
    !integer,          dimension(Neconomy,nteach,ndist), intent(out) :: sim_matches
    integer,          dimension(:,:,:), intent(out) :: sim_matches
    !double precision, dimension(Neconomy,nteach,ndist), intent(out) :: sim_pr_matches
    !double precision, dimension(nteach,ndist)          :: pr_model_match
    double precision, dimension(:,:), intent(out)       :: pr_model_match
    !sim omegas now global so aux model can see them w/out passing variable
    !double precision, dimension(Neconomy,2,ndist), intent(out) :: sim_omegas
    !double precision, dimension(Neconomy,nWgrid1,nWgrid2,ndist), intent(out) :: sim_pr_omegas
    double precision, dimension(nWgrid1,nWgrid2,ndist), intent(out) :: pr_model_Wgrid
    
    integer :: m
    !double precision, dimension(nteach,ndist) :: v
    double precision, allocatable, dimension(:,:) :: v
    !integer,          dimension(nteach,ndist) :: match_eqm
    integer, allocatable, dimension(:,:) :: match_eqm

    double precision, dimension(ntheta_wage) :: theta_wage, theta_wage_prev

    integer :: i, j, k, iter!, idx
    !double precision, dimension(1) :: idxd
    double precision :: tval

    !double precision, dimension(nteach,ndist) :: wage_eqm_glob_wedge
    double precision, allocatable, dimension(:,:) :: wage_eqm_glob_wedge
    !double precision, dimension(nteach) :: subsidy
    double precision, allocatable, dimension(:) :: subsidy

    !double precision, dimension(nteach,ndist) :: pr_match_eqm
    double precision, allocatable, dimension(:,:) :: pr_match_eqm

    !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
    double precision, dimension(50, ntheta_wage) :: econ_wage_theta
    double precision, dimension(50, 20) :: econ_main_theta

    !allocate nteach vars
    allocate(v(nteach,ndist))
    allocate(match_eqm(nteach,ndist))
    allocate(wage_eqm_glob_wedge(nteach,ndist))
    allocate(subsidy(nteach))
    allocate(pr_match_eqm(nteach,ndist))
    allocate(offer_eqm_glob(nteach,ndist))
    allocate(wage_eqm_glob(nteach,ndist))
    allocate(H(nteach,ndist), udist(nteach,ndist), uteach(nteach,ndist), exp_uteach(nteach,ndist))

    pr_model_match = 0
    pr_model_Wgrid = 0

    !initialize vars help to print information to terminal/txt files...
    print_indicator = 0
    economy_output_indicator = 0
    true_wage_indicator = 0

    !set up files for output
    if (T_period == 1) then
       open(1,file='result/eqbm_dist_contribution.txt',status='replace')
       if (T_max > 1) write(1, '(A16)', advance = "no") 'time_period'
       write(1,*) ' economy_id', ' district_id', ' avg_expect_cont', ' avg_C1', ' avg_C2',&
            ' avg_expect_exp', ' avg_expect_MA', ' lambda', ' urban', ' suburban',&
            ' budg_per_teach', ' budget', ' capacity', ' share_tenured'
       close(1)
       open(1,file='result/eqbm_dist_hires.txt',status='replace')
       if (T_max > 1) write(1, '(A16)', advance = "no") 'time_period'
       write(1,*) ' economy_id', ' district_id', ' expected_hires', ' capacity', ' belief_expected_hires'
       close(1)
       open(1,file='result/eqbm_dist_wages.txt',status='replace')
       if (T_max > 1) write(1, '(A16)', advance = "no") 'time_period'
       write(1,*) ' economy_id', ' district_id', ' expected_wage_bill', ' budget', ' belief_expected_Wage_bill'
       close(1)
       open(1,file='result/eqbm_beliefs.txt',   status='replace')
       if (T_max > 1) write(1, '(A16)', advance = "no") 'time_period'
       write(1,*) ' economy_id', ' theta_n', ' theta'
       close(1)
       open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
       if (T_max > 1) write(1, '(A16)', advance = "no") 'time_period'
       write(1,*) ' economy_id',  ' exp1_tc', ' exp2_tc', ' exp3_tc', ' exp4_tc', ' exp5_tc', ' exp6_tc'
       close(1)
       
       open(1,file='result/state_burden.txt', status='replace')
       if (T_max > 1) write(1, '(A16)', advance = "no") 'time_period'
       write(1,*) ' economy_id', ' state_subsidy', &
            ' rewarded_district', ' rewarded_state', ' rewarded_tot', &
            ' mean_reward_dist', ' mean_reward_state', ' mean_reward_tot', &
            ' mean_reward_dist_ratio', ' mean_reward_state_ratio', ' mean_reward_tot_ratio', &
            ' sd_reward_dist', ' sd_reward_state', ' sd_reward_tot', &
            ' sd_reward_dist_ratio', ' sd_reward_state_Ratio', ' sd_reward_tot_Ratio'
       close(1)
    end if
    
    !set module vars
    gamma_glob  = gamma_in
    sigmaD_glob = sigmaD_in
    !udist       = utility_district(beta_in)
    !XXX: in economy-by-economy version this is overwritten/is garbage at this point here
    !      could use an if statment to clean up but im lazy
    call utility_district(beta_in, udist)

    !! ZZZ no longer can pre-calculate teacher utility
    !    or else need to update uteach, and then take exp each time.
    !uteach      = utility_teacher(alpha_in)
    !uteach      = uteach - spread(minval(uteach,2),2,ndist)
    !exp_uteach  = exp(uteach / sigma_in)
    !also need sigma_glob in this version
    sigma_glob  = sigma_in
    ! and alpha_glob to call utility function
    alpha_glob  = alpha_in

    ! moved cf specification to read_data_params

    
    !shares: send_counts, send_starts, rec_count,Bt, Tt, udistt, waget, inct, 
    !  tenuredt, sigmad_glob, gamma_glob. allocates(Ht,model_offert)
    ! XX: this should be ok to do here if we change to the new entrant idea.
    call share_data_to_threads()

    !new code here, trying to load economy-by-economy belief guesses for cfs
    !   (only for first period if doing multiple periods)
    if ((purpose > 10 .and. t_period == 1) .or. (purpose == 10 .and. t_period == 1 .and. T_max > 1)) then
       ! (just wage for starters)
       open(1, file="wagebelief_50.txt", status = 'old')
       read(1,*) econ_wage_theta
       close(1)
       ! also now trying main
       open(1, file="mainbelief_50.txt", status = 'old')
       read(1,*) econ_main_theta
       close(1)
    ! in period 2, we need to read beliefs in again &
    !     (wages will be adjusted for subsidy, main is just a more closer eqbm)
    !     also, we don't need to do this for most basic baseline
    ! reading main should be redundant, b/c period 1 is same as baseline so should be at same converged value
    !    but for consistency will just read in... only wage gets adj b/c subsidy
    else if ((purpose >= 10 .and. t_period == 2)) then ! .or. &
         !(purpose == 10 .and. (flag_entry == 1 .or. flag_exit == 1 ) .and. t_period == 2)) then
       !wage
       open(1, file="wagebelief_50_t2.txt", status = 'old')
       read(1,*) econ_wage_theta
       close(1)
       !main
       open(1, file="mainbelief_50_t2.txt", status = 'old')
       read(1,*) econ_main_theta
       close(1)
    else if ((purpose >= 10 .and. t_period == 3)) then ! .or. &
         !(purpose == 10 .and. (flag_entry == 1 .or. flag_exit == 1 ) .and. t_period == 2)) then
       !wage
       open(1, file="wagebelief_50_t3.txt", status = 'old')
       read(1,*) econ_wage_theta
       close(1)
       !main
       open(1, file="mainbelief_50_t3.txt", status = 'old')
       read(1,*) econ_main_theta
       close(1)
    else if ((purpose >= 10 .and. t_period == 4)) then ! .or. &
       !(purpose == 10 .and. (flag_entry == 1 .or. flag_exit == 1 ) .and. t_period == 2)) then
       !wage
       open(1, file="wagebelief_50_t4.txt", status = 'old')
       read(1,*) econ_wage_theta
       close(1)
       !main
       open(1, file="mainbelief_50_t4.txt", status = 'old')
       read(1,*) econ_main_theta
       close(1)
    else if ((purpose >= 10 .and. t_period == 5)) then ! .or. &
       !(purpose == 10 .and. (flag_entry == 1 .or. flag_exit == 1 ) .and. t_period == 2)) then
       !wage
       open(1, file="wagebelief_50_t5.txt", status = 'old')
       read(1,*) econ_wage_theta
       close(1)
       !main
       open(1, file="mainbelief_50_t5.txt", status = 'old')
       read(1,*) econ_main_theta
       close(1)
    else
       !purpose == 10, eqbm will start from estimation beliefs
    end if

    !loop over our economies
    economy_idx = 1 !so threads know which economy shock to use
    do m=1, Neconomy
       ! Skip first X economies. Maybe for different sample or to add to a previously run code
       if (economy_idx < starting_economy) then
          print*, 'skipping economy ', economy_idx
          economy_idx = economy_idx + 1
          cycle
       end if
       print*, 'working on eqlbm for economy: ', m, ' of ', Neconomy, ' in period t=', t_period 

       
       ! this is specific for forward iteration, we need to reset the
       !     global teacher variables economy-by-economy
       ! the _period vars are updated in main for the most part
       if (t_period > 1) then
          
          ! update teacher variables for this economy
          C1(:,1) = C1_period(economy_idx,:)
          C2(:,1) = C2_period(economy_idx,:)
          age = age_period(economy_idx,:)
          exp_con = spread(exp_period(economy_idx,:),    2, ndist)
          master  = spread(master_period(economy_idx,:), 2, ndist)
          !for inc, inc_period saves as index rather than binary flags, to save on space
          inc = 0
          do i=1, nteach
             ! logic only works for incumbants. If entrants, inc_period = 0)
             if (inc_period(economy_idx,i) > 0) inc(i,inc_period(economy_idx,i)) = 1
          end do
          ! and set the downstream inc variables
          ! actually, these get set in 'share_data_forward_iter'
          !call generate_inc_variables()
          !   
          !   ! Share w/ other threads new teacher pool (C1, C2, exp_con, master, inc), and gen teacher data
          print*, 'sharing data for forward iter'
          call share_data_forward_iter()
          ! need udist w/ new vars (only if exp, c1, c2, or master are economy-by-economy)
          call utility_district(beta_in, udist)
          ! share udist
          print*, 'sharing udist for forward iter'
          call share_udist_forward_iter()
       !   
       end if
       
       ! for cf, initial guess will now come from 50 econ 
       if ((purpose > 10 .and. t_period == 1) .or. &
            (purpose == 10 .and. t_period == 1 .and. T_max > 1)) then
          theta0_wage = econ_wage_theta(economy_idx,:)
          theta0(1:20) = econ_main_theta(economy_idx,:) !(for main only have 20 of 22)
          !XXX temporarily changing belifes to be identical so we can bug check, but also need to make
          !     sure theta0 gets reset for this bug cehck, so remove the below 21/22 later.
          !theta0(21) = 0.25
          !theta0(22) = -0.1
       else if ((purpose >= 10 .and. t_period <= 5)) then ! .or. &
         !(purpose == 10 .and. (flag_entry == 1 .or. flag_exit == 1 ) .and. t_period == 2)) then
          ! also if doing bonus scheme, they kick in for t_period == 2 only, and we need to start with the adjusted bonuses then
          theta0_wage = econ_wage_theta(economy_idx,:)
          theta0(1:20) = econ_main_theta(economy_idx,:) !(for main only have 20 of 22)
       else if (purpose >= 10 .and. t_period > 2) then
          theta0_wage = wage_theta_period(economy_idx,:)
          theta0 = theta_period(economy_idx,:)
       else
          print*, 'dont think we should have gotten here... investigate'
          call exit(1)
       end if
       print*, 'initial main thetas:'
       do i=1, ntheta
          print*, i, theta0(i)
       end do
       print*, 'initial wage thetas:'
       do i=1, ntheta_wage
          print*, i, theta0_wage(i)
       end do
       ! initial guess of thetas MW
       theta      = theta0
       theta_wage = theta0_wage

       !iterate until beliefs and wages converge
       iter = 0
       do
          iter = iter + 1
          print*, iter 
          theta_prev      = theta
          theta_wage_prev = theta_wage
          
          !find good wage fit
          !print*, 'wage iter'
          !call nelder_meade_eqm(theta_wage,h_tol_pct,equilibrium_objective,0,&
          !     h_maxiter,0d0,0.5d0,theta)
          !!now find good belief fit
          !print*, 'belief iter'
          !call nelder_meade_eqm(theta,h_tol_pct,equilibrium_objective,0,&
          !     h_maxiter,0d0,D_sofar,theta_wage)

          !Setting tighter tolerances for wage and belief iters

          !XX temp using true wage, this was the bug
          !  (if I reinstitute this, need to allocate these here instead of in eqbm obj)
          !mean_eqm_glob = sum(wage,2)/ndist
          !sd_eqm_glob   = sqrt(sum((wage - &
          !     spread(mean_eqm_glob,2,ndist))**2,2)/(ndist-1))
          !true_wage_indicator      = 1
          
          !now find good belief fit
          !  (if doing bonus cf want to have wage iter first, otherwise stick to what we were doing before)
          if (purpose > 10 .and. T_max > 1) then
             print*, 'wage iter'
             call nelder_meade_eqm_wage(theta_wage,h_tol_pct,equilibrium_objective,0,&
                  h_maxiter,0d0,0.3d0,theta)
             !     10,0d0,0.3d0,theta)
             !    XXX temp reducing iters 
             print*, 'belief iter'
             call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&
                  h_maxiter,0d0,D_sofar,theta_wage)
             !      10,0d0,D_sofar,theta_wage)
             !    XXX temp reducing iters
          else
             print*, 'belief iter'
             call nelder_meade_eqm(theta,0.025d0,equilibrium_objective,0,&
                  h_maxiter,0d0,D_sofar,theta_wage)
             !      10,0d0,D_sofar,theta_wage)
             !    XXX temp reducing iters
             print*, 'wage iter'
             call nelder_meade_eqm_wage(theta_wage,h_tol_pct,equilibrium_objective,0,&
                  h_maxiter,0d0,0.3d0,theta)
             !     10,0d0,0.3d0,theta)
             !    XXX temp reducing iters
          end if
          
          
          !if not really improving more, then we are converged
          if( sum(abs((theta_prev - theta)/theta))/ntheta + &
               sum(abs((theta_wage_prev - theta_wage)))/ntheta_wage < 0.1) then
             print*, 'thetas converged'
             print*, sum(abs((theta_prev - theta)/theta))/ntheta, sum(abs((theta_wage_prev - theta_wage)))/ntheta_wage
             exit
          else
             print*, sum(abs((theta_prev - theta)/theta))/ntheta, sum(abs((theta_wage_prev - theta_wage)))/ntheta_wage
          end if
          ! XXX shortening this for faster code while bug checking
          !if(iter > 1) exit
          if(iter > maxiter) exit
       end do

       !don't know whcih nelder ran last so need to call again
       !   this will set offer_eqm_glob and wage_eqm_glob correctly
       if (m == Neconomy) print_indicator = 1
       economy_output_indicator = 1 
       tval = equilibrium_objective(theta,theta_wage)
       print_indicator          = 0
       economy_output_indicator = 0

       ! and save the converged beliefs for next period, if doing forward iter
       if (T_max > 1) then
          theta_period(economy_idx,:)      = theta
          wage_theta_period(economy_idx,:) = theta_wage
       end if
       
       ! if want to use true w_mean, w_sd, then save those and run again now
       ! XX need to recomment, this is for bug checking
       !mean_eqm_glob = sum(wage_eqm_glob,2)/ndist
       !sd_eqm_glob   = sqrt(sum((wage_eqm_glob - &
       !  spread(mean_eqm_glob,2,ndist))**2,2)/(ndist-1))
       !true_wage_indicator      = 1
       !economy_output_indicator = 1
       !tval = equilibrium_objective(theta,theta_wage)
       !true_wage_indicator      = 0
       !economy_output_indicator = 0

       !adjusting wage to include our voucher 'wedge' in wages
       if (purpose == 11) then
          ! B1 (incentive independent of omega2 choice)
          do j=1, ndist
             subsidy = r_vec(j) * (C1(:,1) * share_low(1,j) + C2(:,1)*(1-share_low(1,j)))
             !bounds
             subsidy = max(0d0, subsidy)
             subsidy = min(subsidy, subsidy_upper)
             ! add in subsidy and cap at our usual max bound
             wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper) 
          end do
       else if (purpose == 12) then
          ! B2 (incentive tied to omega2 choice)
          do j=1, ndist
             subsidy = r_vec(j) *  omegas_eqm_glob(2,j) * (C1(:,1) * share_low(1,j) + C2(:,1)*(1-share_low(1,j)))
             !bounds
             subsidy = max(0d0, subsidy)
             subsidy = min(subsidy, subsidy_upper)
             ! add in subsidy and cap at our usual max bound
             wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper) 
          end do
       else if (purpose == 13) then
          ! B3 (incentive only for c1, independent of omega2)
          do j=1, ndist
             subsidy = r_vec(j) * (C1(:,1) * share_low(1,j))
             !bounds
             subsidy = max(0d0, subsidy)
             subsidy = min(subsidy, subsidy_upper)
             ! add in subsidy and cap at our usual max bound
             wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper) 
          end do
       else if (purpose == 14) then
          ! B4 (incentive only for c1, tied to omega2 choice)
          do j=1, ndist
             subsidy = r_vec(j) *  omegas_eqm_glob(2,j) * (C1(:,1) * share_low(1,j))
             !bounds
             subsidy = max(0d0, subsidy)
             subsidy = min(subsidy, subsidy_upper)
             ! add in subsidy and cap at our usual max bound
             wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper) 
          end do
       else if (purpose == 15) then
          ! B5, student specific bonus, exog
          do j=1, ndist
             subsidy =           s_vec(1) * max(0d0,C1(:,1) * share_low(1,j))
             subsidy = subsidy + s_vec(2) * max(0d0,C2(:,1)*(1-share_low(1,j)))
             !bounds
             subsidy = max(0d0, subsidy)
             subsidy = min(subsidy, subsidy_upper)
             ! add in subsidy and cap at our usual max bound
             wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper)
          end do
       else if (purpose == 16) then
          ! B6, student specific bonus, tied to omega2
          do j=1, ndist
             subsidy =           s_vec(1) * max(0d0,C1(:,1) * share_low(1,j))
             subsidy = subsidy + s_vec(2) * max(0d0,C2(:,1)*(1-share_low(1,j)))
             !tie to omega2
             subsidy = subsidy * omegas_eqm_glob(2,j)
             !bounds
             subsidy = max(0d0, subsidy)
             subsidy = min(subsidy, subsidy_upper)
             ! add in subsidy and cap at our usual max bound
             wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper)
          end do
       else if (purpose == 17) then
          ! B7 alternate similar to B5
          do j=1, ndist
             subsidy =           s_vec(1) * (C1(:,1) * share_low(1,j))
             subsidy = subsidy + s_vec(2) * (C2(:,1)*(1-share_low(1,j)))
             !bounds
             subsidy = max(0d0, subsidy)
             subsidy = min(subsidy, subsidy_upper)
             ! add in subsidy and cap at our usual max bound
             wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper)
          end do
          else if (purpose == 18) then
          ! B8, B7 but tied to omega2
          do j=1, ndist
             subsidy =           s_vec(1) * (C1(:,1) * share_low(1,j))
             subsidy = subsidy + s_vec(2) * (C2(:,1)*(1-share_low(1,j)))
             !tie to omega2
             subsidy = subsidy * omegas_eqm_glob(2,j)
             !bounds
             subsidy = max(0d0, subsidy)
             subsidy = min(subsidy, subsidy_upper)
             ! add in subsidy and cap at our usual max bound
             wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper)
          end do
       else
          wage_eqm_glob_wedge = wage_eqm_glob
       end if

       !Now calculate probabilities based on solved offers (note exp_uteach contains sigma)
       ! ZZZ will need to change exp_uteach to the known omega choices here
       !uteach = utility_teacher_omega(alpha_glob, omegas_eqm_glob(2,:))
       !uteach = utility_teacher_eqm(alpha_glob, wage_eqm_glob_wedge)
       call utility_teacher_eqm(alpha_glob, wage_eqm_glob_wedge, uteach)
       uteach = uteach - spread(minval(uteach,2),2,ndist)
       exp_uteach  = exp(uteach / sigma_glob)
       do j=1, ndist
          pr_match_eqm(:,j) = exp_uteach(:,j) * offer_eqm_glob(:,j) / &
               sum(exp_uteach * offer_eqm_glob,2)
       end do

       !find accepted offers
       v = uteach + sigma_in*Tshock(m,:,:)
       do j=1, ndist
          do i=1, nteach
             if (offer_eqm_glob(i,j) == 0) then
                !if no offer, utility is negative infinity
                v(i,j) = inf_neg()
             end if
          end do
       end do
       match_eqm = 0
       do i=1, nteach
          !teacher pick district which gives highest utility
          if (sum(offer_eqm_glob(i,:)) .gt. 0) then
             !if teacher receives offer, pick max offer
             match_eqm(i,maxloc(v(i,:))) = 1
          end if
       end do
       
       !save matches, wages
       sim_matches(m,:,:)    = match_eqm
       !sim_pr_matches(m,:,:) = pr_match_eqm
       pr_model_match = pr_model_match + pr_match_eqm/nEconomy
       sim_omegas(m,:,:)     = omegas_eqm_glob
       !sim_pr_omegas(m,:,:,:)  = pr_omegas_eqm_glob
       pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
       

       economy_idx = economy_idx + 1

       !tell slave processes to stop IF doing forward iter
       if (T_max > 1) call mpi_bcast(1,1,mpi_int,0,mpi_comm_world,ierr)
    end do ! N_economy

    ! tell slave processes to stop if NOT forward iter
    if (T_max == 1) call mpi_bcast(1,1,mpi_int,0,mpi_comm_world,ierr)

    call deallocate_variables()

    !output equilibrium data so we can use in stata
    ! REALIZED OMEGAS (neconomy x ndist)
    if (t_period == 1) then 
       open(1,file='result/eqbm_omegas.txt',status='replace')
       if (T_max > 1) write(1, '(A16)', advance="no") ' time_period '
       write(1,*) ' economy_id ', 'district_id ', 'omega1 ', 'omega2 '
    else
       open(1,file='result/eqbm_omegas.txt',action='write',position='append')
    end if
    do k=starting_economy, nEconomy
       do j=1, ndist
          if (T_max > 1) write(1, '(I4)', advance="no") t_period
          write(1,*) k, j, sim_omegas(k,1,j), sim_omegas(k,2,j)
       end do
    end do
    close(1)

    !dealloc nteach vars
    deallocate(v, match_eqm, wage_eqm_glob_wedge, subsidy, pr_match_eqm)
    deallocate(offer_eqm_glob)
    deallocate(wage_eqm_glob)
    deallocate(H, udist, uteach, exp_uteach)

  end subroutine simulate_equilibrium

  function equilibrium_objective(arg1, arg2) result(D)
    double precision, dimension(:), intent(in) :: arg1, arg2
    
    double precision :: D

    double precision, dimension(ntheta)       :: theta_eqm
    double precision, dimension(ntheta_wage ) :: theta_wage_eqm
    !double precision, dimension(nteach)       :: denom
    double precision, allocatable, dimension(:) :: denom

    !double precision, dimension(nteach) :: mean_target, sd_target
    double precision, allocatable, dimension(:) :: mean_target, sd_target

    !double precision, dimension(nteach,ndist) :: C_matrix
    double precision, allocatable, dimension(:,:) :: C_matrix

    double precision :: w1, w2, w3

    integer :: j, i

    !double precision, dimension(nteach,ndist) :: wage_eqm_glob_wedge
    double precision, allocatable, dimension(:,:) :: wage_eqm_glob_wedge
    !double precision, dimension(nteach) :: subsidy
    double precision, allocatable, dimension(:) :: subsidy

    double precision, dimension(6) :: teacher_tc

    !integer, dimension(nteach, ndist) :: tc_ind
    integer, allocatable, dimension(:, :) :: tc_ind
    !double precision, dimension(nteach, ndist) :: reward_tot, reward_dist, reward_state
    double precision, allocatable, dimension(:,:) :: reward_tot, reward_dist, reward_state
    !integer, dimension(nteach, ndist) :: reward_tot_ind, reward_dist_ind, reward_state_ind
    integer, allocatable, dimension(:,:) :: reward_tot_ind, reward_dist_ind, reward_state_ind
    
    double precision :: mean_reward_dist, mean_reward_state, mean_reward_tot
    double precision :: mean_reward_dist_ratio, mean_reward_state_ratio, mean_reward_tot_ratio
    double precision :: var_reward_dist, var_reward_state, var_reward_tot
    double precision :: var_reward_dist_ratio, var_reward_state_ratio, var_reward_tot_ratio

    !Helpers for saving forward iteration results
    double precision :: tc, tc5, tc4, tc3, tc2, tc1, tct50, tcc1, tcc2
    double precision :: stburd, o2_0, o2_10, o2_30, o2_50, o2_75, o2_100, o2_200, o2_225
    double precision :: shrdist, shrstate, shrtot
    double precision :: mnrdist, mnrstate, mnrtot

    double precision, allocatable, dimension(:,:) :: H_target

    !allocate nteach vars
    allocate(denom(nteach))
    allocate(mean_target(nteach), sd_target(nteach))
    allocate(C_matrix(nteach,ndist))
    allocate(wage_eqm_glob_wedge(nteach,ndist))
    allocate(subsidy(nteach))
    allocate(tc_ind(nteach,ndist))
    allocate(reward_tot(nteach,ndist), reward_dist(nteach,ndist), reward_state(nteach,ndist))
    allocate(reward_tot_ind(nteach,ndist), reward_dist_ind(nteach,ndist), reward_state_ind(nteach,ndist))
    allocate(mean_eqm_glob(nteach), sd_eqm_glob(nteach))
    allocate(H_eqm_glob(nteach,ndist))
    allocate(H_target(nteach,ndist))
    

    !trick lets us iterate on wage or theta separately w/ same obj function
    if (size(arg1,1) .eq. ntheta) then
       theta_eqm      = arg1
       theta_wage_eqm = arg2
    else
       theta_eqm      = arg2
       theta_wage_eqm = arg1
    end if
    !  won't work if args are same dimensions though... easiest to just put warning
    !   and fix if need be later
    if(size(arg1,1) .eq. size(arg2,1)) then
       print*, 'logic error: theta and theta_wage have same dimension'
       call exit(1)
    end if

    !set mean and sd based on our functional forms
    if (true_wage_indicator == 0) call mean_sd_eqm(theta_wage_eqm,mean_eqm_glob,sd_eqm_glob)

    !tell slaves we still need their help solving knapsack
    call mpi_bcast(0,1,mpi_int,0,mpi_comm_world,ierr)

    !solve for solution in parallel (sets offer_eqm_glob, wage_eqm_glob, omegas_eqm_glob)
    call solve_eqm_knapsack_parallel(theta_eqm)


    !adjusting wage to include our voucher 'wedge' in wages
    if (purpose == 11) then
       ! B1 (incentive independent of omega2 choice)
       do j=1, ndist
          subsidy = r_vec(j) * (C1(:,1) * share_low(1,j) + C2(:,1)*(1-share_low(1,j)))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper) 
       end do
       !wage_eqm_glob_wedge = wage_eqm_glob
    else if (purpose == 12) then
       ! B2 (incentive tied to omega2 choice)
       do j=1, ndist
          subsidy = r_vec(j) *  omegas_eqm_glob(2,j) * (C1(:,1) * share_low(1,j) + C2(:,1)*(1-share_low(1,j)))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper) 
       end do
    else if (purpose == 13) then
       ! B3 (incentive only for c1, independent of omega2)
       do j=1, ndist
          subsidy = r_vec(j) * (C1(:,1) * share_low(1,j))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper) 
       end do
    else if (purpose == 14) then
       ! B4 (incentive only for c1, tied to omega2 choice)
       do j=1, ndist
          subsidy = r_vec(j) *  omegas_eqm_glob(2,j) * (C1(:,1) * share_low(1,j))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper) 
       end do
    else if (purpose == 15) then
       ! B5, student specific bonus, exog
       do j=1, ndist
          subsidy =           s_vec(1) * max(0d0,C1(:,1) * share_low(1,j))
          subsidy = subsidy + s_vec(2) * max(0d0,C2(:,1)*(1-share_low(1,j)))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper)
       end do
    else if (purpose == 16) then
       ! B6, student specific bonus, tied to omega2
       do j=1, ndist
          subsidy =           s_vec(1) * max(0d0,C1(:,1) * share_low(1,j))
          subsidy = subsidy + s_vec(2) * max(0d0,C2(:,1)*(1-share_low(1,j)))
          ! tie to omega2
          subsidy = subsidy * omegas_eqm_glob(2,j)
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper)
       end do
    else if (purpose == 17) then
       ! B7 alternate similar to B5
       do j=1, ndist
          subsidy =           s_vec(1) * (C1(:,1) * share_low(1,j))
          subsidy = subsidy + s_vec(2) * (C2(:,1)*(1-share_low(1,j)))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper)
       end do
       else if (purpose == 18) then
       ! B8, B7 tied to omega2
       do j=1, ndist
          subsidy =           s_vec(1) * (C1(:,1) * share_low(1,j))
          subsidy = subsidy + s_vec(2) * (C2(:,1)*(1-share_low(1,j)))
          ! tie to omega2
          subsidy = subsidy * omegas_eqm_glob(2,j)
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_eqm_glob_wedge(:,j) = min(wage_eqm_glob(:,j)+subsidy, wageupper)
       end do
    else
       wage_eqm_glob_wedge = wage_eqm_glob
    end if

    !now calc target H, mean/sd wage  
    ! ZZZ need to adjust uteach based on omega choice
    !uteach = utility_teacher_omega(alpha_glob, omegas_eqm_glob(2,:))
    !uteach = utility_teacher_eqm(alpha_glob, wage_eqm_glob_wedge)
    ! XXX temp printing for comparison
    !print*, 'sum wage wedge', sum(wage_eqm_glob_wedge)
    !print*, 'sum of udist pieces', sum(urban), sum(suburban), sum(milwauk), sum(samecz)
    !print*, sum(share_low), sum(C1), sum(inc), sum(entrant), sum(exp_con), sum(logdist)
    !print*, 'udist piece', urban(1,1), suburban(1,1), milwauk(1,1), samecz(1,1)
    !print*, share_low(1,1), C1(1,1), C2(1,1), inc(1,1), entrant(1,1), exp_con(1,1), logdist(1,1)
    call utility_teacher_eqm(alpha_glob, wage_eqm_glob_wedge, uteach)
    uteach = uteach - spread(minval(uteach,2),2,ndist)
    exp_uteach  = exp(uteach / sigma_glob)

    !if (t_period == 2) print*, 'jjj', sum(exp_uteach), sum(exp_uteach(1,:)), exp_uteach(1,1), &
    !     exp_uteach(1,2), exp_uteach(1,3)
    !if (t_period == 2) print*, sum(offer_eqm_glob(1,:)), sum(offer_eqm_glob)
    !if (t_period == 2) call exit(1)
      
    denom = sum(exp_uteach * offer_eqm_glob,2)
    do j=1, ndist
       H_target(:,j) = exp_uteach(:,j) / (denom + (1-offer_eqm_glob(:,j))*exp_uteach(:,j))
    end do 
    !censor values for H_target, just like in belief_functions.f90
    H_target = max(H_target, belief_floor)
    H_target = min(H_target, belief_ceiling)
    
    !calc stat for each teacher across districts, later can use matmul to duplicate across dists
    mean_target = sum(wage_eqm_glob_wedge,2)/ndist
    sd_target   = sqrt(sum((wage_eqm_glob_wedge - &
         spread(mean_target,2,ndist))**2,2)/(ndist-1))
    
    !calc likelihood D
    w1 = 10000
    w2 = 1
    w3 = 3
    D = 0
    if (size(arg1,1) .eq. ntheta) then
       D = w1 * sum((H_target - H_eqm_glob)**2) / (nteach * ndist)
       print*, 'belief thetas ', D, sum(H_target), sum(H_eqm_glob)
       ! XXX temp printing for comparison
       !print*, 'h target', H_target(1,1)
       !print*, 'h eqm', H_eqm_glob(1,1)
       !call exit(1)
    else       
       D =     w2 * sum((mean_target - mean_eqm_glob)**2) / (nteach)
       D = D + w3 * sum((sd_target   - sd_eqm_glob)**2)   / (nteach)
       !print*, 'wage thetas ', D, w2 * sum((mean_target - mean_eqm_glob)**2) / (nteach), &
       !     w3 * sum((sd_target   - sd_eqm_glob)**2)   / (nteach)
    end if

    !if (print_indicator == 1) then
    !   print*, 'teacher ', 'mean_approx ', 'mean_target ', 'sd_approx ', 'sd_target '
    !   do i=1, nteach
    !      print*, i, mean_eqm_glob(i), mean_target(i), sd_eqm_glob(i), sd_target(i)
    !   end do
    !end if

    !now use H_target and wage_eqm etc... to print info about this economy equilibrium
    if (economy_output_indicator == 1) then
       !set up vector of teachers with full contribution
       C_matrix = matmul(C1,share_low(1:1,:)) + matmul(C2,(1-share_low(1:1,:)))
       open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
       open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
       open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
       do j=1,ndist
          ! save time period if doing forward iter
          if (T_max > 1) then
             write(1, '(I4)', advance = "no") t_period
             write(2, '(I4)', advance = "no") t_period
             write(3, '(I4)', advance = "no") t_period
          end if
          !true total expected contribution
          write(1,*) economy_idx, j, &
               sum(H_target(:,j)*offer_eqm_glob(:,j)*C_matrix(:,j))/sum(H_target(:,j)*offer_eqm_glob(:,j)), &
               sum(H_target(:,j)*offer_eqm_glob(:,j)*C1(:,1))/sum(H_target(:,j)*offer_eqm_glob(:,j)), &
               sum(H_target(:,j)*offer_eqm_glob(:,j)*C2(:,1))/sum(H_target(:,j)*offer_eqm_glob(:,j)), &
               sum(H_target(:,j)*offer_eqm_glob(:,j)*exp_con(:,j))/sum(H_target(:,j)*offer_eqm_glob(:,j)), &
               sum(H_target(:,j)*offer_eqm_glob(:,j)*master(:,j))/sum(H_target(:,j)*offer_eqm_glob(:,j)), &
               share_low(1,j), urban(1,j), suburban(1,j), B(1,j)/T(1,j), B(1,j), T(1,j), &
               sum(inc(:,j)*tenured(:,j)) / dble(T(1,j))
          !true expected hires
          write(2,*) economy_idx, j, sum(H_target(:,j)*offer_eqm_glob(:,j)), T(1,j), &
               sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j))
          !true expected wages
          write(3,*) economy_idx, j, &
               sum(H_target(:,j)*offer_eqm_glob(:,j)*wage_eqm_glob(:,j)), B(1,j), &
               sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)*wage_eqm_glob(:,j))
          
          !belief total expected contribution
          !write(1,*) economy_idx, j, &
          !     sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)*C_matrix(:,j))/sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)), &
          !     sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)*C1(:,1))/sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)), &
          !     sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)*C2(:,1))/sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)), &
          !     sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)*exp_con(:,j))/sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)), &
          !     sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)*master(:,j))/sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)), &
          !     share_low(1,j), urban(1,j), suburban(1,j), B(1,j)/T(1,j), B(1,j), T(1,j), &
          !     sum(inc(:,j)*tenured(:,j)) / dble(T(1,j))
          !!belief expected hires
          !write(2,*) economy_idx, j, sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)), T(1,j), &
          !     sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j))
          !!belief expected wages
          !write(3,*) economy_idx, j, &
          !     sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)*wage_eqm_glob(:,j)), B(1,j), &
          !     sum(H_eqm_glob(:,j)*offer_eqm_glob(:,j)*wage_eqm_glob(:,j))
       end do
       close(1)
       close(2)
       close(3)
       !match probs --- this is a big file so just uncomment if I want it. it is easy enough to run 1 economy again
       !if (economy_idx==1) then
       !   open(1,file='eqbm_matches.txt', status='replace')
       !   do i=1,nteach
       !      ! write(1,*) (H_target(i,j)*offer_eqm_glob(i,j), j=1,ndist)
       !      do j=1, ndist
       !         write(1,*) i, j, H_target(i,j)*offer_eqm_glob(i,j)
       !      end do
       !   end do
       !   close(1)
       !end if
       
       !save beliefs associated with this economy equilibrium
       open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
       do j=1, ntheta
          if (T_max > 1) write(1, '(I4)', advance = "no") t_period
          write(1,*) economy_idx, j, theta_eqm(j)
       end do
       do j=1, ntheta_wage
          if (T_max > 1) write(1, '(I4)', advance = "no") t_period
          write(1,*) economy_idx, j+ntheta, theta_wage_eqm(j)
       end do
       close(1)

       !save stats conditional on teacher chars
       open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
       !avg tc by teach experience group
       do j=1, 6
          teacher_tc(j) = sum(matmul(exp_dum(:,j:j),ones_ndist) * H_target * offer_eqm_glob * C_matrix)
       end do

       if (T_max > 1) write(4, '(I4)', advance = "no") t_period
       write(4,*) economy_idx, teacher_tc(1), teacher_tc(2), teacher_tc(3), teacher_tc(4), teacher_tc(5), teacher_tc(6)

       close(4)

       !finally save the cost to the state by district
       open(1,file='result/state_burden.txt', action='write',position='append')
       
       !do j=1, ndist
       !   tc_ind = 0
       !   do i=1, nteach
       !      if (C1(i,1)*share_low(i,j) > 0) then
       !         tc_ind(i) = 1
       !      end if
       !   end do
       !   write(1,*) economy_idx, j, sum(H_target(:,j)*offer_eqm_glob(:,j)* &
       !        (wage_eqm_glob_wedge(:,j) - wage_eqm_glob(:,j))), &
       !        
       !end do
       tc_ind = 0
       do j=1, ndist
          do i=1, nteach
             if (C1(i,1)*share_low(i,j) + C2(i,1)*(1-share_low(i,j)) > 0) then
                tc_ind(i,j) = 1
             end if
          end do
       end do

       ! 'reward' from state and district (conditional on positive)
       reward_dist = contribution * spread(omegas_eqm_glob(2,:),1,nteach) * tc_ind
       reward_state    = wage_eqm_glob_wedge - wage_eqm_glob
       reward_tot      = reward_dist + reward_state

       !set up indicator variables to help
       reward_dist_ind = 0
       reward_state_ind    = 0 
       reward_tot_ind      = 0
       do j=1, ndist
          do i=1, nteach
             if (reward_dist(i,j) > 0)     reward_dist_ind(i,j)   = 1 
             if (reward_state(i,j) > 0)    reward_state_ind(i,j)  = 1 
             if (reward_tot(i,j) > 0)      reward_tot_ind(i,j)    = 1
             !flag for bug checking
             if (reward_dist(i,j) < 0 .or. reward_dist(i,j) < 0 .or. reward_tot(i,j) < 0) then
                print*, 'error, reward should not be neg'
                print*, i,j,reward_dist(i,j), reward_state(i,j), reward_tot(i,j)
                print*, contribution(i,j), tc_ind(i,j), omegas_eqm_glob(2,j)
                print*, C1(i,1), C2(i,1), share_low(i,j), C1(i,1)*share_low(i,j) + C2(i,1)*(1-share_low(i,j))
                call exit(1)
             end if
             
          end do
       end do

       !print*, sum(reward_dist), sum(reward_dist_ind), sum(reward_state), sum(reward_state_ind), &
       !     sum(reward_tot), sum(reward_tot_ind)

       !for sds this we need to take means
       mean_reward_dist  = sum(H_target * offer_eqm_glob * reward_dist) / sum(H_target * offer_eqm_glob *reward_dist_ind)
       mean_reward_state = sum(H_target * offer_eqm_glob * reward_state)    / sum(H_target * offer_eqm_glob *reward_state_ind)
       mean_reward_tot   = sum(H_target * offer_eqm_glob * reward_tot)      / sum(H_target * offer_eqm_glob *reward_tot_ind)

       
       mean_reward_dist_ratio  = sum(H_target * offer_eqm_glob * reward_dist / wage_eqm_glob) &
            / sum(H_target * offer_eqm_glob *reward_dist_ind)
       mean_reward_state_ratio =  sum(H_target * offer_eqm_glob * reward_state    / wage_eqm_glob_wedge) &
            / sum(H_target * offer_eqm_glob *reward_state_ind)
       mean_reward_tot_ratio   = sum(H_target * offer_eqm_glob * reward_tot      / wage_eqm_glob_wedge) &
            / sum(H_target * offer_eqm_glob *reward_tot_ind)

       ! calc sds
       var_reward_dist = sum( reward_dist_ind*H_target * offer_eqm_glob *(reward_dist - mean_reward_dist)**2) &
            / sum(H_target * offer_eqm_glob *reward_dist_ind)
       var_reward_state = sum( reward_state_ind*H_target * offer_eqm_glob *(reward_state - mean_reward_state )**2) &
            / sum(H_target * offer_eqm_glob *reward_state_ind)
       var_reward_tot = sum( reward_tot_ind*H_target * offer_eqm_glob * (reward_tot - mean_reward_tot )**2) &
            / sum(H_target * offer_eqm_glob *reward_tot_ind)

       var_reward_dist_ratio = sum( reward_dist_ind*H_target * offer_eqm_glob *((reward_dist / wage_eqm_glob) &
            - mean_reward_dist_ratio)**2) &
            / sum(H_target * offer_eqm_glob *reward_dist_ind)
       var_reward_state_ratio = sum( reward_state_ind*H_target * offer_eqm_glob * ((reward_state    / wage_eqm_glob_wedge) &
            - mean_reward_state_ratio)**2) &
            / sum(H_target * offer_eqm_glob *reward_state_ind)
       var_reward_tot_ratio = sum( reward_tot_ind*H_target * offer_eqm_glob * ((reward_tot  / wage_eqm_glob_wedge) &
            - mean_reward_tot_ratio)**2) &
            / sum(H_target * offer_eqm_glob *reward_tot_ind)

       

       ! Key:
       ! econ index, state reward
       ! teachers rewarded: district
       ! teachers rewarded: state
       ! teachers rewarded: total
       ! etc... self explanatory mnemonics
       !
       if (T_max > 1) write(1, '(I4)', advance = "no") t_period
       write(1,*) economy_idx, sum(H_target*offer_eqm_glob*reward_state), &
            sum(H_target * offer_eqm_glob * reward_dist_ind) / nteach, &
            sum(H_target * offer_eqm_glob * reward_state_ind)    / nteach, &
            sum(H_target * offer_eqm_glob * reward_tot_ind)      / nteach, &
            mean_reward_dist,        &
            mean_reward_state,       &
            mean_reward_tot,         &
            mean_reward_dist_ratio,  &
            mean_reward_state_ratio, &
            mean_reward_tot_ratio,   &
            sqrt(var_reward_dist),          &
            sqrt(var_reward_state),         &
            sqrt(var_reward_tot),           &
            sqrt(var_reward_dist_ratio),    &
            sqrt(var_reward_state_ratio),   &
            sqrt(var_reward_tot_ratio)
            
            
       close(1)

    end if


   ! ! For forward iteration, we will only save economy-level statistics
   ! if (T_max > 1) then
!
!       !
!       sum(H_target(:,j)*offer_eqm_glob(:,j)*C_matrix(:,j))/sum(H_target(:,j)*offer_eqm_glob(:,j)), &
!               sum(H_target(:,j)*offer_eqm_glob(:,j)*C1(:,1))/sum(H_target(:,j)*offer_eqm_glob(:,j)), &
!               sum(H_target(:,j)*offer_eqm_glob(:,j)*C2(:,1))/sum(H_target(:,j)*offer_eqm_glob(:,j)), &
!               sum(H_target(:,j)*offer_eqm_glob(:,j)*exp_con(:,j))/sum(H_target(:,j)*offer_eqm_glob(:,j)), &
!               sum(H_target(:,j)*offer_eqm_glob(:,j)*master(:,j))/sum(H_target(:,j)*offer_eqm_glob(:,j)), &
!               share_low(1,j), urban(1,j), suburban(1,j), B(1,j)/T(1,j), B(1,j), T(1,j), &
!               sum(inc(:,j)*tenured(:,j)) / dble(T(1,j))
!
!       open(1, file = "forward_iteration_summary_stats.txt", status = '')
!       write(1,*) t_period, economy_id, &
!            tc, tc5, tc4, tc3, tc2, tc1, tct50, tcc1, tcc2, &
!            stburd, o2_0, o2_10, o2_30, o2_50, o2_75, o2_100, o2_200, o2_225, &
!            shrdist, shrstate, shrtot, &
!            mnrdist, mnrstate, mnrtot
!
!       close(1)
    !    end if


    !deallocate
    deallocate(denom, mean_target, sd_target, C_matrix, wage_eqm_glob_wedge, subsidy)
    deallocate(tc_ind, reward_tot, reward_dist, reward_state)
    deallocate(reward_tot_ind, reward_dist_ind, reward_state_ind)
    deallocate(mean_eqm_glob, sd_eqm_glob)
    deallocate(H_eqm_glob)
    deallocate(H_target)

    !print*, 'end of equilibrium_objective'
  end function equilibrium_objective

  subroutine solve_eqm_knapsack_parallel(theta_eqm)
    double precision, intent(inout), dimension(ntheta) :: theta_eqm
    integer :: i,j,a1, a2, dist_num
    double precision :: profit_max
    double precision, dimension(nWgrid1,nWgrid2) :: profit!, resist_cost
    double precision :: resist_cost

    !double precision, dimension(nteach) :: wstat_vary
    double precision, allocatable, dimension(:) :: wstat_vary
    !double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
    double precision, allocatable, dimension(:,:) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
    !double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
    double precision, allocatable, dimension(:,:,:) :: pr_omegast_eqm
    !double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
    double precision, allocatable, dimension(:,:)      :: omegast_eqm
    !integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
    integer,          allocatable, dimension(:,:) :: offert_eqm

    

    integer a1_best, a2_best

    integer :: rec_count_omega
    integer, allocatable, dimension(:) :: send_counts_omega, send_starts_omega

    double precision, dimension(nteach) :: wage_wedge, subsidy

    integer, allocatable, dimension(:) :: noninc_offert

    !allocate nteach vars
    allocate(waget_eqm(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
    allocate(Ht_vary(nteach,rec_count/nteach), Ht_eqm(nteach,rec_count/nteach))
    allocate(pr_omegast_eqm(NWgrid1,NWgrid2,rec_count/nteach))
    allocate(omegast_eqm(2,rec_count/nteach))
    allocate(offert_eqm(nteach,rec_count/nteach))
    allocate(noninc_offert(nteach))

    !broadcast beliefs 
    call mpi_bcast(theta_eqm, ntheta, mpi_double_precision, 0,mpi_comm_world,ierr)
    !broadcast dshock (redundant to share every time, but speed negligible)
    call mpi_bcast(dshock, nEconomy*ndist*NWgrid1*NWgrid2, mpi_double_precision,0,mpi_comm_world,ierr)
    !broadcast mean and sd of wage
    call mpi_bcast(mean_eqm_glob,nteach,mpi_double_precision,0,mpi_comm_world,ierr)
    call mpi_bcast(sd_eqm_glob,  nteach,mpi_double_precision,0,mpi_comm_world,ierr)
    !broadcast economy_idx
    call mpi_bcast(economy_idx, 1, mpi_int, 0, mpi_comm_world,ierr)

    !figure out index of district j
    dist_num = 0
    if (mpi_id .gt. 0) then
       do i=1, mpi_id
          dist_num = dist_num + send_counts(i)/nteach
       end do
    end if


    ! use index j for variables with t suffix
    !     (t denotes thead only has 'slice' of matrix)
    do j=1, rec_count/nteach
       dist_num = dist_num + 1
       profit_max = -1 * huge(profit_max) !
       do a1=1, nWgrid1
          do a2=1,nWgrid2
             !option to restrict to increasing omega 2 choice
             !if (omega2_restriction==1) then
             !   if (a2 < eqbm_omega2(economy_idx,dist_num)) then
             !   profit(a1,a2) == -1 * huge(profit)
             !   cycle
             !   end if
             !end if
             
             ! option to restrict omega 2 to be nonzero if subsidized
             !    (deleted this, was commented out and underlying logic
             !       of subsidized variable changed)

             ! XXX this is wasteful copying of waget? I should comment out?
             !   (i.e. only row j matters for the knapsack calc but needed it in this data structure
             !       to use the old same knapsack code function, so rest of waget is irrelevant)
             waget_vary = waget
             waget_vary(:,j) = omega1_grid(a1)*wageschedule(:,dist_num) + &
                  omega2_grid(a2)*contribution(:,dist_num)
             waget_vary(:,j) = min(waget_vary(:,j), wageupper)
             waget_vary(:,j) = max(waget_vary(:,j), wagelower)

             ! add in the 'wedge' or subsidy
             if (purpose == 11) then
                ! B1 (incentive independent of omega2 choice)
                subsidy = r_vec(dist_num) * (C1(:,1) * share_low(1,dist_num) + C2(:,1)*(1-share_low(1,dist_num)))
                !bounds
                subsidy = max(0d0, subsidy)
                subsidy = min(subsidy, subsidy_upper)
             else if (purpose == 12) then
                ! B2 (incentive tied to omega2 choice)
                subsidy = r_vec(dist_num) * omega2_grid(a2) * &
                     (C1(:,1) * share_low(1,dist_num) + C2(:,1)*(1-share_low(1,dist_num)))
                !bounds
                subsidy = max(0d0, subsidy)
                subsidy = min(subsidy, subsidy_upper)
             else if (purpose == 13) then
                ! B3 (incentive only for c1, independent of omega2)
                subsidy = r_vec(dist_num) * (C1(:,1) * share_low(1,dist_num))
                !bounds
                subsidy = max(0d0, subsidy)
                subsidy = min(subsidy, subsidy_upper)
             else if (purpose == 14) then
                ! B4 (incentive only for c1, tied to omega2 choice)
                subsidy = r_vec(dist_num) * omega2_grid(a2) * &
                     (C1(:,1) * share_low(1,dist_num))
                !bounds
                subsidy = max(0d0, subsidy)
                subsidy = min(subsidy, subsidy_upper)
             else if (purpose == 15) then
                ! B5, student specific bonus, exog
                subsidy =           s_vec(1) * max(0d0,C1(:,1) * share_low(1,dist_num))
                subsidy = subsidy + s_vec(2) * max(0d0,C2(:,1)*(1-share_low(1,dist_num)))
                !bounds
                subsidy = max(0d0, subsidy)
                subsidy = min(subsidy, subsidy_upper)
             else if (purpose == 16) then
                ! B6, student specific bonus, tied to omega2
                subsidy =           s_vec(1) * max(0d0,C1(:,1) * share_low(1,dist_num))
                subsidy = subsidy + s_vec(2) * max(0d0,C2(:,1)*(1-share_low(1,dist_num)))
                !tie to omega2
                subsidy = subsidy * omega2_grid(a2)
                !bounds
                subsidy = max(0d0, subsidy)
                subsidy = min(subsidy, subsidy_upper)
             else if (purpose == 17) then
                ! B7, alternate to B5
                subsidy =           s_vec(1) * (C1(:,1) * share_low(1,dist_num))
                subsidy = subsidy + s_vec(2) * (C2(:,1)*(1-share_low(1,dist_num)))
                !bounds
                subsidy = max(0d0, subsidy)
                subsidy = min(subsidy, subsidy_upper)
             else if (purpose == 18) then
                ! B8, B7 but tied to omega2
                subsidy =           s_vec(1) * (C1(:,1) * share_low(1,dist_num))
                subsidy = subsidy + s_vec(2) * (C2(:,1)*(1-share_low(1,dist_num)))
                !tie to omega2
                subsidy = subsidy * omega2_grid(a2)
                !bounds
                subsidy = max(0d0, subsidy)
                subsidy = min(subsidy, subsidy_upper)
             else
                ! no subisdy
                subsidy = 0
             end if
                
             wage_wedge = waget_vary(:,j) + subsidy
             wage_wedge = min(wage_wedge, wageupper)

             !calc wstat_vary, used to calc new beliefs
             wstat_vary = (wage_wedge - mean_eqm_glob) / sd_eqm_glob

             !XX remove print when bug fixed
             !if (mpi_id==0) print*, wage_wedge(1), mean_eqm_glob(1), sd_eqm_glob(1)
             
             !Ht_vary(:,j) = h_logit_vary(theta_eqm,dist_num, wstat_vary)!,omega2_grid(a2))
             call h_logit_vary(theta_eqm,dist_num, wstat_vary, Ht_vary(:,j))

             !solve for offers
             !all tenured incumbents will get offers
             model_offert = inct * tenuredt
             call solve_knapsack(Ht_vary,j,udistt,waget_vary,model_offert,&
                  Bt,Tt,nteach,noninc_offert)
             !offers for non-incumbents
             do i=1, nteach
                if (noninc_offert(i) == 1) then
                   model_offert(i,j) = 1
                end if
             end do

             !find expected utility from choosing the omega
             !calc resistcost (only if from baseline, otherwise calc for each dist individually)
             resist_cost = Rcost(omega1_grid(a1), omega2_grid(a2), demshare(dist_num), gamma_glob)
             profit(a1,a2) = sum(Ht_vary(:,j)*model_offert(:,j)*udistt(:,j))/Tt(1,j) - &
                  resist_cost + &
                  sigmad_glob*dshock(economy_idx,dist_num,a1,a2)

             if (profit(a1,a2) > profit_max) then
                !if best option, keep track of offers and wage
                offert_eqm(:,j) = model_offert(:,j)
                waget_eqm(:,j)  = waget_vary(:,j)
                Ht_eqm(:,j)     = Ht_vary(:,j)
                profit_max = profit(a1,a2)

                a1_best = a1
                a2_best = a2
             end if

             !XX remove print when bug fixed
             !if (mpi_id ==0) print*, Ht_vary(1,1)
          end do
       end do
       !XX remove print when bug fixed
       !if (mpi_id ==0) print*, 'a1/a2', a1_best, a2_best
       !call exit(1)
       !set best wage choice
       omegast_eqm(1,j) = omega1_grid(a1_best)
       omegast_eqm(2,j) = omega2_grid(a2_best)
       !calculate prob of choosing each omega
       do a1=1, nWgrid1
          do a2=1, nWgrid2
             !w/ trick to avoid exp overflow
             pr_omegast_eqm(a1,a2,j) = exp((profit(a1,a2)-profit(1,1)) /sigmad_glob) / &
                  sum(exp((profit-profit(1,1)) / sigmad_glob))
          end do
       end do
    end do

    !temporary, just print out, district, and capacity vs. expected

    !share optimal choices back to master thread (offer_eqm, wage_eqm)
    call mpi_gatherv(offert_eqm, rec_count, mpi_int, &
         offer_eqm_glob, send_counts, send_starts, &
         mpi_int, &
         0, mpi_comm_world, ierr)
    call mpi_gatherv(waget_eqm, rec_count, mpi_double_precision, &
         wage_eqm_glob, send_counts, send_starts, &
         mpi_double_precision, &
         0, mpi_comm_world, ierr)
    !if (mpi_id == 0) print*, 'Ht_eqm(1,1)', Ht_eqm(1,1)
    call mpi_gatherv(Ht_eqm, rec_count, mpi_double_precision, &
         H_eqm_glob, send_counts, send_starts, &
         mpi_double_precision, &
         0, mpi_comm_world, ierr)

    !share omega choices 
    allocate(send_starts_omega(ntasks),send_counts_omega(ntasks))
    send_starts_omega = send_starts / nteach * 2
    send_counts_omega = send_counts / nteach * 2
    rec_count_omega   = rec_count   / nteach * 2

    call mpi_gatherv(omegast_eqm, rec_count_omega, mpi_double_precision, &
         omegas_eqm_glob, send_counts_omega, send_starts_omega, &
         mpi_double_precision, &
         0, mpi_comm_world, ierr)

    send_starts_omega = send_starts / nteach * NWgrid1 * NWgrid2
    send_counts_omega = send_counts / nteach * NWgrid1 * NWgrid2
    rec_count_omega   = rec_count   / nteach * NWgrid1 * NWgrid2
    !share omega probs
    call mpi_gatherv(pr_omegast_eqm, rec_count_omega, mpi_double_precision, &
         pr_omegas_eqm_glob, send_counts_omega, send_starts_omega, &
         mpi_double_precision, &
         0, mpi_comm_world, ierr)

    deallocate(send_starts_omega, send_counts_omega)

    !dealloc nteach vars
    deallocate(waget_eqm, waget_vary, Ht_vary, Ht_eqm, pr_omegast_eqm, omegast_eqm, offert_eqm)
    deallocate(noninc_offert)
    
  end subroutine solve_eqm_knapsack_parallel
  

  subroutine mean_sd_eqm(th_eqm, mean_eqm, sd_eqm)
    double precision, dimension(ntheta_wage), intent(in)  :: th_eqm
    !double precision, dimension(nteach),      intent(out) :: mean_eqm, sd_eqm
    double precision, dimension(:),      intent(out) :: mean_eqm, sd_eqm
    !double precision, dimension(nteach)                   :: var_eqm
    double precision, allocatable, dimension(:)      :: var_eqm

    integer :: i, th_idx

    !allocate nteach vars
    allocate(var_eqm(nteach))

    !mean
    mean_eqm = th_eqm(1) * exp_dum(:,1) + &
               th_eqm(2) * exp_dum(:,2) + &
               th_eqm(3) * exp_dum(:,3) + &
               th_eqm(4) * exp_dum(:,4) + &
               th_eqm(5) * exp_dum(:,5) + &
               th_eqm(6) * exp_dum(:,6) + &
               th_eqm(7) * master(:,1)  + &
               th_eqm(8) * C1(:,1)      + &
               th_eqm(9) * C2(:,1)
    !need subsidy components when doing subsidy counterfactuals
    if (purpose == 10 .or. purpose == 11 .or. purpose == 12 .or. purpose == 17 .or. purpose == 18) then
       mean_eqm = mean_eqm + &
               th_eqm(10) * C1(:,1) * subsidized + &
               th_eqm(11) * C2(:,1) * subsidized
    else if (purpose == 13 .or. purpose == 14) then
       mean_eqm = mean_eqm + &
            th_eqm(10) * C1(:,1) * subsidized_C1
    else if (purpose == 15 .or. purpose == 16) then
       mean_eqm = mean_eqm + &
               th_eqm(10) * C1(:,1) * subsidized_C1 + &
               th_eqm(11) * C2(:,1) * subsidized_C2
    end if
    mean_eqm = max(wagelower, mean_eqm)
    mean_eqm = min(wageupper, mean_eqm)

    !sd
    var_eqm = th_eqm(12) * exp_dum(:,1) + &
             th_eqm(13) * exp_dum(:,2) + &
             th_eqm(14) * exp_dum(:,3) + &
             th_eqm(15) * exp_dum(:,4) + &
             th_eqm(16) * exp_dum(:,5) + &
             th_eqm(17) * exp_dum(:,6) + &
             th_eqm(18) * master(:,1)  + &
             th_eqm(19) * C1(:,1)      + &
             th_eqm(20) * C2(:,1)      + &
             th_eqm(21) * C1(:,1)**2   + &
             th_eqm(22) * C2(:,1)**2   + &
             th_eqm(23) * master(:,1)  * C1(:,1) + &
             th_eqm(24) * master(:,1)  * C2(:,1) + &
             th_eqm(25) * C1(:,1)      * C2(:,1) + &
             th_eqm(26) * exp_dum(:,1) * C1(:,1)
    !exp interaction terms easier to do in loop
    !   master,c1,c2 colinear when exp_dum(:,1).
    !   Also exp_dum6 interactions will be colinear
    th_idx = 27
    do i=2,5
       var_eqm = var_eqm + th_eqm(th_idx) * exp_dum(:,i) * C1(:,1)
       th_idx = th_idx + 1
       var_eqm = var_eqm + th_eqm(th_idx) * exp_dum(:,i) * C2(:,1)
       th_idx = th_idx + 1
       var_eqm = var_eqm + th_eqm(th_idx) * exp_dum(:,i) * master(:,1)
       th_idx = th_idx + 1
    end do

    !lastly add in the subsidy components, if doing subsidy counterfactuals
    if (purpose == 10 .or. purpose == 11 .or. purpose == 12 .or. purpose == 17 .or. purpose == 18) then
       var_eqm = var_eqm + &
            th_eqm(39) * C1(:,1) * subsidized + &
            th_eqm(40) * C2(:,1) * subsidized
    else if (purpose == 13 .or. purpose == 14) then
       var_eqm = var_eqm + &
            th_eqm(39) * C1(:,1) * subsidized_C1
    else if (purpose == 15 .or. purpose == 16) then
       var_eqm = var_eqm + &
            th_eqm(39) * C1(:,1) * subsidized_C1 + &
            th_eqm(40) * C2(:,1) * subsidized_C2
    end if

    sd_eqm = min(sqrt(max(var_eqm,epsilon(var_eqm))), wageupper-wagelower)

    !dealloc nteach vars
    deallocate(var_eqm)

  end subroutine mean_sd_eqm


  !deallocate from all threads
  subroutine deallocate_variables()

    deallocate(send_counts, send_starts, Ht, udistt, waget, Bt, Tt)
    deallocate(inct, model_offert, tenuredt)
    if(wage_decision == 1) deallocate(pr_model_Wgridt)

  end subroutine deallocate_variables


  ! This function:
  ! (sorry this is a bastardization b/c code was never meant to have forward iter feature)
  !  - Shares w/ other threads new teacher pool (C1, C2, exp_con, master, inc)
  !  - Calls gen teacher data to complete data on teacher pool
  ! - calcs udist, and shares to be udistt
  subroutine share_data_forward_iter()
    use read_data_params

    integer :: sz != nteach * ndist

    sz = nteach * ndist

    ! 1. Broadcast the teacher data
    ! Don't need to broadcast these b/c not economy specific right now, they are all determined in main
    !!C1
    if (mpi_id == 0) print*, 'share C1'
    call mpi_bcast(C1, nteach, mpi_double_precision, 0, mpi_comm_world, ierr)
    !C2
    if (mpi_id == 0) print*, 'share C2'
    call mpi_bcast(C2, nteach, mpi_double_precision, 0, mpi_comm_world, ierr)
    !exp
    if (mpi_id == 0) print*, 'share exp'
    call mpi_bcast(exp_con, sz, mpi_integer, 0, mpi_comm_world, ierr)
    !master
    if (mpi_id == 0) print*, 'share master'
    call mpi_bcast(master, sz, mpi_integer, 0, mpi_comm_world, ierr)

    !inc
    !if (mpi_id == 0) print*, 'sum inc', sum(inc)
    !if (mpi_id == 1) print*, 'sum inc slave', sum(inc)
    ! exp con
    !call mpi_barrier(mpi_comm_world, ierr)
    !if (mpi_id == 0) print*, 'share inc'

    ! idk why I did inc and inct... but need both. Inc is in belief_functions, inct is here in inner loop
    call mpi_bcast(inc, sz, mpi_int, 0, mpi_comm_world, ierr)
    call mpi_scatterv(inc, send_counts, send_starts, mpi_int, &
         inct, rec_count, mpi_int, &
         0, mpi_comm_world, ierr)


    ! 2. Gen teacher data
    !print*, 'gen teacher data, in share data forward iter'
    call generate_teacher_data()
    !call mpi_barrier(mpi_comm_world, ierr)
    !if (mpi_id == 0) print*, 'gen new downstream inc vars'
    !call generate_inc_variables()

    ! I think I need to do tenuredt, here?!
    ! 
    call mpi_scatterv(tenured, send_counts, send_starts, mpi_int, &
         tenuredt, rec_count, mpi_int, &
         0, mpi_comm_world, ierr)

    call mpi_barrier(mpi_comm_world, ierr)
    if (mpi_id == 0) print*, 'finished sharing and generating inc'
    
  end subroutine share_data_forward_iter

  ! b/c of weirdness injected b/c we had to do the forward iteration, all of the logic is off
  !     and we need to pick up the pieces by re-sharing udist to threads
  subroutine share_udist_forward_iter()
    integer :: chunksize, remainder, i

    !chunksize and remainder
    chunksize = ndist / ntasks !note int/int will round down
    remainder = mod(ndist,ntasks)
    
    !set up send vectors
    !allocate(send_counts(ntasks),send_starts(ntasks))
    do i=1, ntasks
       if (i <= remainder) then
          send_counts(i) = chunksize + 1
       else
          send_counts(i) = chunksize
       end if
    end do
    send_starts(1) = 0
    do i=2, ntasks
       send_starts(i) = sum(send_counts(1:i-1))
    end do
    !if (mpi_id == 0) write(*,*) 'id:', mpi_id, 'counts:', send_counts, 'starts:', send_starts

    !set up receive info
    rec_count = send_counts(mpi_id + 1)

    !need to increase size for larger matrix sends
    send_counts = send_counts * nteach
    send_starts = send_starts * nteach
    !if (mpi_id == 0) write(*,*) 'id', mpi_id, 'counts', send_counts, 'starts', send_starts
    rec_count = send_counts(mpi_id + 1)


    ! share udist with a scatter
    call mpi_scatterv(udist, send_counts, send_starts, mpi_double_precision, &
         udistt, rec_count, mpi_double_precision, &
         0, mpi_comm_world, ierr)

    call mpi_barrier(mpi_comm_world, ierr)
    
  end subroutine share_udist_forward_iter
  

  !helper function to return -infinity
  pure function inf_neg() result(r)
    !use ieee_arithmetic (not supported on flash gfortran compiler)
    double precision :: r
    !r = ieee_value(0d0, ieee_negative_inf)
    r = -huge(r)
  end function inf_neg

end module inner_loop_one



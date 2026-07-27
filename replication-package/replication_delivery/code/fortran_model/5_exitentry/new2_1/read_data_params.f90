! read_data_params.f90
! created: Oct 2018
!
! Reads in from text files
! 

module read_data_params
  use global_variables
  implicit none

  private
  double precision, dimension(5) :: rvec_gradient
  double precision, dimension(2) :: svec_gradient

  !subroutines that are public
  public ::  read_instructions, read_model_params, read_auxiliary_params, read_data, generate_teacher_data, read_data_pre, &
       read_theta, read_weight_matrixes, generate_prob_exit, generate_prob_entry, &
       allocate_nteach_vars, deallocate_nteach_vars, &
       generate_exp_variables, generate_wagesched_contrib, generate_inc_variables, set_rvec

contains
  ! ********** Read Instructions ***********
  !functionality to be expanded as needed
  subroutine read_instructions()
    integer k,j,i
    double precision, dimension(4) :: txtline
    integer, allocatable  :: eqbm_omega2_tmp(:,:)
    
    open(1,file='instruction.txt',status='old')
    read(1,*) purpose
    read(1,*) teachOff_decision
    read(1,*) wage_decision
    read(1,*) skip_first_inner_loop
    read(1,*) report_weight_factors
    read(1,*) simplex_length
    read(1,*) maxiter
    read(1,*) outer_tol_pct
    read(1,*) outer_tol_dif
    read(1,*) h_maxiter
    read(1,*) h_tol_pct
    read(1,*) h_tol_dif
    read(1,*) belief_floor
    read(1,*) belief_ceiling
    read(1,*) NcopyT
    read(1,*) NcopyD
    read(1,*) Neconomy
    ! moving these b/c nteach is now flexible...?
    !sim_nteach = NcopyT * nteach
    !sim_ndist  = NcopyD * ndist
    read(1,*) wagelower
    read(1,*) wageupper
    read(1,*) omega2_restriction
    read(1,*) validation
    read(1,*) cf_match_option
    read(1,*) starting_economy
    read(1,*) rvec_gradient
    r_vec = 0 !this is set later, b/c we need to know lambda (share_low)
    !            (and, needs to be zero for t_period=1 if forward iter)
    !read(1,*) s_vec
    read(1,*) svec_gradient
    s_vec = 0 !this is set later, needs to be zero for t_period=1 if forward iter
    read(1,*) T_max
    read(1,*) flag_entry
    read(1,*) flag_exit
    read(1,*) wage_elas
    read(1,*) flag_read_entr
    read(1,*) ncopy_entr
    close(1)

    !default is no outer loop. Only relevant for the non-eqbm options.
    outer_loop = 0

    !set instructions based on purpose
    if (purpose == 2 .or. purpose == 4 .or. purpose == 5) outer_loop = 1
    if (purpose == 2 .or. purpose ==  3) offer_eqbm = 1
    if (skip_first_inner_loop == 1) skip_inner_loop = 1
    ! and for rigid pay:
    if (purpose == 7) then
       if (mpi_id == 0) print*, "Running 'Rigid-Pay'"
       teachOff_decision = 1
       wage_decision = 0
       offer_eqbm = 1
    end if

    ! check for validity of purpose
    if (teachOff_decision == 0 .and. offer_eqbm == 1) then
       write(*,*) "you can't run offer eqbm purpose when teacher/offer deicison = 0"
       call exit(1)
    end if
    ! check for validity of forward iteration
    if (T_max > 1 .and. purpose < 10) then
       write(*,*) "you can't run forward iteration for the estimation purposes"
       call exit(1)
    end if
    
    allocate(eqbm_omega2(nEconomy,ndist), eqbm_omega2_tmp(nEconomy,ndist))
    if(omega2_restriction==1) then
       open(1, file="eqbm_omegas_for_omega2_restriction.txt", status = 'old')
       read(1,*)
       do k=1, nEconomy
          do j=1, ndist
             read(1,*) txtline
             eqbm_omega2_tmp(k,j) = txtline(4)
          end do
       end do
       close(1)
       !translate into index
       do k=1, nEconomy
          do j=1, ndist
             eqbm_omega2(k,j) = -1
             do i=1, nWgrid2
                if (eqbm_omega2_tmp(k,j)==omega2_grid(i))  eqbm_omega2(k,j) = i
             end do
             if (eqbm_omega2(k,j) == -1) then
                print*, 'eqbm omega2 not matched to grid...'
                call exit(1)
             end if
          end do
       end do
    end if
    deallocate(eqbm_omega2_tmp)

    
  end subroutine read_instructions

  ! this depends on share_low, which now is set after read_instructions, so need to run
  !    this part after data is read in.
  subroutine set_rvec()
    integer :: j

    ! set the subsidy multiplier
    if (purpose > 10 .and. purpose <= 14) then
       !doing b1/b2/b3/b4 subsidy counterfactual
       do j=1, ndist
          if(share_low(1,j) >= 0.58385092) then
             r_vec(j) = rvec_gradient(1) 
          else if(share_low(1,j) >= .5350389) then
             r_vec(j) = rvec_gradient(2) 
          else if (share_low(1,j) >= .4807017) then
             r_vec(j) = rvec_gradient(3) 
          else if (share_low(1,j) >= .4015444) then
             r_vec(j) = rvec_gradient(4) 
          else
             r_vec(j) = rvec_gradient(5) 
          end if
       end do
       
       if (mpi_id == 0) then
          write(*,'(A30,F6.2,F6.2,F6.2,F6.2,F6.2)') 'the subsidy multipliers are (high-to-low lambda or share_low):', rvec_gradient
       end if
    else if (purpose >= 15) then
       !b5/b6/b7/b8 rely on svec
       s_vec = svec_gradient
       
       if (mpi_id == 0) then
          write(*,'(A30,F6.2,F6.2,F6.2,F6.2,F6.2)') 'the subsidy multipliers are (c1/c2):', s_vec
       end if
    else
       ! not doing this subsidy
       r_vec = 0
    end if

    
    if (purpose == 11 .or. purpose == 13) then
       ! w/ no omega2 multiplier need to multiply by a typical omega2 value to match magnitude
       r_vec = r_vec * 27.75
    else if (purpose == 15 .or. purpose == 17) then
       s_vec = s_vec * 27.75
    end if

    
    ! set the subsidy ceiling
    subsidy_upper = 2*6.566 !cap at 2sd

  end subroutine set_rvec
  

  ! ********* Read Model Parameters ***********
  subroutine read_model_params(param0)
    double precision, allocatable, dimension(:), intent(out) :: param0
    integer :: np, i ,j
    if (allocated(param0)) then
       deallocate(param0)
    end if
    !always reads from initial_param_guess. If you want to use latest
    !  parameters, just copy latest_param_guess to the initial file.
    !  This is because latest_param_guess is overwritten each iter
    !  so we want to keep track of params we started from each run
    open(1, file = 'initial_param_guess.txt', status = 'old')
    read(1,*) !first line is column descriptors - ignore
    do i=1, nparam
       read(1,*) incl(i), initial_param(i), step(i)
       !write(*,*) incl(i), initial_param(i), step(i)
    enddo
    read(1,*)
    read(1,*)
    read(1,*) best_L

    np = sum(incl,dim=1) !how many parameters to iterate on?
    if (outer_loop == 1) write(*,*) 'num of params to iterate on: ', np
    allocate(param0(np))

    i=1
    do j=1,nparam
       if (i>nparam) then
          exit
       elseif(incl(j)==1) then
          param0(i)=1.0d-0/step(j)
          i=i+1
       endif
    enddo
    close(1)
  end subroutine read_model_params

  ! ********** Initial Theta ***********
  ! theta, for acceptance logit h()
  subroutine read_theta()
    integer :: i
    open(1, file = './initial_theta.txt', status = 'old')
    do i=1, ntheta
       read(1,*) theta(i)
    enddo
    read(1,*) D_sofar
    do i=1, ntheta_wage
       read(1,*) theta0_wage(i)
    end do
    close(1)
    theta_prev = theta
    theta0=theta
    theta_sofar=theta

  end subroutine read_theta

  ! ******* Auxiliary Parameters *******
  ! - beta_T*   (clogits) 2 13x1 vectors
  ! - beta_D*_* () 12 3x1 vectors
  ! - also read omega moments
  ! - and generates 'other' aux moments
  subroutine read_auxiliary_params()
    use aux_model
    integer :: i 
    double precision, dimension(13) :: beta_small, beta_big !clogits
    integer, parameter :: nauxd = 4 !intercept budget capacity share_low
    double precision, dimension(nauxd)   :: beta_d1_1, beta_d1_2, beta_d1_3, beta_d1_4
    double precision, dimension(nauxd)   :: beta_d2_1, beta_d2_2, beta_d2_3, beta_d2_4
    double precision, dimension(nauxd)   :: beta_d3_1, beta_d3_2, beta_d3_3, beta_d3_4
    double precision, dimension(17)      :: omega1, omega2
    double precision, dimension(5)       :: omega12
    double precision, dimension(NWgrid1) :: pr_data_omega1
    double precision, dimension(NWgrid2) :: pr_data_omega2
    double precision                     :: pr_data_omegaOLD
    double precision, dimension(4)       :: omegadem
    double precision :: tmpnum
    character :: tmpchr
    !double precision, dimension(nteach,ndist) :: match_double
    double precision, allocatable, dimension(:,:) :: match_double

    allocate(match_double(nteach,ndist))

    
    !beta_T2
    open(1, file = trim(filepath)//'/model_data/betaT2_JPE.csv', status = 'old')
    read(1,*) beta_small
    close(1)
    !beta_T1
    open(1, file = trim(filepath)//'/model_data/betaT1_JPE.csv', status = 'old')
    read(1,*) beta_big
    close(1)
    !beta_D1_1
    open(1, file = trim(filepath)//'/model_data/betaD1_1.csv', status = 'old')
    read(1,*) (beta_d1_1(i), i=1, nauxd)
    close(1)
    !beta_D1_2
    open(1, file = trim(filepath)//'/model_data/betaD1_2.csv', status = 'old')
    read(1,*) (beta_d1_2(i), i=1, nauxd)
    close(1)
    !beta_D1_3
    open(1, file = trim(filepath)//'/model_data/betaD1_3.csv', status = 'old')
    read(1,*) (beta_d1_3(i), i=1, nauxd)
    close(1)
    !beta_D1_4
    open(1, file = trim(filepath)//'/model_data/betaD1_4.csv', status = 'old')
    read(1,*) (beta_d1_4(i), i=1, nauxd)
    close(1)
    !beta_D2_1
    open(1, file = trim(filepath)//'/model_data/betaD2_1.csv', status = 'old')
    read(1,*) (beta_d2_1(i), i=1, nauxd)
    close(1)
    !beta_D2_2
    open(1, file = trim(filepath)//'/model_data/betaD2_2.csv', status = 'old')
    read(1,*) (beta_d2_2(i), i=1, nauxd)
    close(1)
    !beta_D2_3
    open(1, file = trim(filepath)//'/model_data/betaD2_3.csv', status = 'old')
    read(1,*) (beta_d2_3(i), i=1, nauxd)
    close(1)
    !beta_D2_4
    open(1, file = trim(filepath)//'/model_data/betaD2_4.csv', status = 'old')
    read(1,*) (beta_d2_4(i), i=1, nauxd)
    close(1)
    !beta_D3_1
    open(1, file = trim(filepath)//'/model_data/betaD3_1.csv', status = 'old')
    read(1,*) (beta_d3_1(i), i=1, nauxd)
    close(1)
    !beta_D3_2
    open(1, file = trim(filepath)//'/model_data/betaD3_2.csv', status = 'old')
    read(1,*) (beta_d3_2(i), i=1, nauxd)
    close(1)
    !beta_D3_3
    open(1, file = trim(filepath)//'/model_data/betaD3_3.csv', status = 'old')
    read(1,*) (beta_d3_3(i), i=1, nauxd)
    close(1)
    !beta_D3_4
    open(1, file = trim(filepath)//'/model_data/betaD3_4.csv', status = 'old')
    read(1,*) (beta_d3_4(i), i=1, nauxd)
    close(1)

    aux_beta(:,1) = (/beta_small, beta_big, beta_d1_1, beta_d1_2, beta_d1_3, beta_d1_4, &
         & beta_d2_1, beta_d2_2, beta_d2_3, beta_d2_4, &
         & beta_d3_1, beta_d3_2, beta_d3_3, beta_d3_4/)


    !now read omega params

    !omega1
    open(1, file = trim(filepath)//'/model_data/omega1_JPE.csv')
    read(1,*) omega1
    close(1)

    !omega2
    open(1, file = trim(filepath)//'/model_data/omega2_JPE.csv')
    read(1,*) omega2
    close(1)

    !omega12_moments (omega means)
    open(1, file = trim(filepath)//'/model_data/alpha12_moments.csv')
    read(1,*) omega12
    close(1)

    !pr(omega1_moments)
    pr_data_omega1 = 0
    pr_data_omega2 = 0
    open(1, file = trim(filepath)//'/model_data/omega1_share.csv') 
    read(1,*) Pr_data_omega1(1:NWgrid1-1)
    close(1)
    !pr(omega2_moments)
    open(1, file = trim(filepath)//'/model_data/omega2_share.csv')
    read(1,*) Pr_data_omega2(1:Nwgrid2-1)
    close(1)
    !pr(omega OLD)
    open(1, file = trim(filepath)//'/model_data/omegas_1_0.csv')
    read(1,*) Pr_data_omegaOLD 
    close(1)

    ! omega x dem moments
    open(1, file = trim(filepath)//'/model_data/omega_moments_JPE.csv')
    read(1,*)
    do i=1,4
       read(1,*) tmpchr, omegadem(i), tmpnum
    end do
    close(1)

    aux_omega(:,1) = (/omega1, omega2, omega12, &
         Pr_data_omega1(1:NWgrid1-1),Pr_data_omega2(1:Nwgrid2-1), &
         pr_data_omegaOLD, omegadem/)



    ! now calculate other aux params, (note, used to call this 'sim' moments or 'calibration' moments,
    !   but that was not a good name)
    !   i.e. teacher chars by district quintiles, new hires, capacity, movers

    !first need the quintiles
    call generate_quintiles()

    !second, calc the moms
    match_double = match !requires dbl format
    call calc_aux_other_parameters(match_double, aux_other)


    deallocate(match_double)
    
  end subroutine read_auxiliary_params


  ! generates quintiles (global vars) which are helpful in calculating moments
  subroutine generate_quintiles()
    use qsort_mod

    double precision, dimension(ndist,2) :: smat, smat2
    integer :: i

    !assign districts to quintiles
    smat(:,1)  = share_low(1,:)
    smat2(:,1) = B(1,:) / T(1,:)
    do i=1,ndist
       smat(i,2)  = i
       smat2(i,2) = i
    end do
    !sort on first column of matrix, second column is district index number
    call qsort_2d(smat)
    call qsort_2d(smat2)
    lambda_quintiles = 0
    bt_quintiles = 0
    !quintile 1-4 has 82 districts, 5 has 83 (5*82=410, but we have 411 districts)
    do i=1,82
       lambda_quintiles(1,int(smat(i,2)))             = 1
       lambda_quintiles(2,int(smat(82+i,2)))          = 1
       lambda_quintiles(3,int(smat(82+82+i,2)))       = 1
       lambda_quintiles(4,int(smat(82+82+82+i,2)))    = 1
       lambda_quintiles(5,int(smat(82+82+82+82+i,2))) = 1
       bt_quintiles(1,int(smat2(i,2)))             = 1
       bt_quintiles(2,int(smat2(82+i,2)))          = 1
       bt_quintiles(3,int(smat2(82+82+i,2)))       = 1
       bt_quintiles(4,int(smat2(82+82+82+i,2)))    = 1
       bt_quintiles(5,int(smat2(82+82+82+82+i,2))) = 1
    end do
    ! add the last district to quintile 5. This is matching our stata code.
    lambda_quintiles(5,int(smat(411,2))) = 1
    bt_quintiles(5,int(smat2(411,2))) = 1
    


  end subroutine generate_quintiles
  

  ! ********* Aux model Wt matrix *********
  subroutine read_weight_matrixes()
    double precision, dimension(13) :: beta_small, beta_big !clogits
    integer, parameter :: nauxd = 4 !intercept budget capacity share_low
    double precision, dimension(nauxd) :: beta_d1_1, beta_d1_2, beta_d1_3, beta_d1_4
    double precision, dimension(nauxd) :: beta_d2_1, beta_d2_2, beta_d2_3, beta_d2_4
    double precision, dimension(nauxd) :: beta_d3_1, beta_d3_2, beta_d3_3, beta_d3_4
    double precision, dimension(naux)    :: weight_vec
    double precision, dimension(17)      :: omega1, omega2
    double precision, dimension(5)       :: omega12
    double precision, dimension(NWgrid1) :: pr_omega1
    double precision, dimension(NWgrid2) :: pr_omega2
    double precision                     :: pr_omegaOLD
    double precision, dimension(4)       :: omegadem
    double precision :: tmpnum
    character :: tmpchr
    double precision, dimension(naux_omega) :: omega_weight_vec
    integer :: i
    double precision :: d1,d2,d3,d4,d5 !to help skip columns in read statement

    ! need to create weight_matrix output from stata and then
    ! can include here.

    !beta_T2 (small)
    open(1, file = trim(filepath)//'/model_data/betaT2_var_JPE.csv', status = 'old')
    read(1,*) beta_small
    close(1)
    !beta_T1 (big)
    open(1, file = trim(filepath)//'/model_data/betaT1_var_JPE.csv', status = 'old')
    read(1,*) beta_big
    close(1)
    !beta_D1_1
    open(1, file = trim(filepath)//'/model_data/betaD1_1_var.csv', status = 'old')
    read(1,*) (beta_d1_1(i), i=1, nauxd)
    close(1)
    !beta_D1_2
    open(1, file = trim(filepath)//'/model_data/betaD1_2_var.csv', status = 'old')
    read(1,*) (beta_d1_2(i), i=1, nauxd)
    close(1)
    !beta_D1_3
    open(1, file = trim(filepath)//'/model_data/betaD1_3_var.csv', status = 'old')
    read(1,*) (beta_d1_3(i), i=1, nauxd)
    close(1)
    !beta_D1_4
    open(1, file = trim(filepath)//'/model_data/betaD1_4_var.csv', status = 'old')
    read(1,*) (beta_d1_4(i), i=1, nauxd)
    close(1)
    !beta_D2_1
    open(1, file = trim(filepath)//'/model_data/betaD2_1_var.csv', status = 'old')
    read(1,*) (beta_d2_1(i), i=1, nauxd)
    close(1)
    !beta_D2_2
    open(1, file = trim(filepath)//'/model_data/betaD2_2_var.csv', status = 'old')
    read(1,*) (beta_d2_2(i), i=1, nauxd)
    close(1)
    !beta_D2_3
    open(1, file = trim(filepath)//'/model_data/betaD2_3_var.csv', status = 'old')
    read(1,*) (beta_d2_3(i), i=1, nauxd)
    close(1)
    !beta_D2_4
    open(1, file = trim(filepath)//'/model_data/betaD2_4_var.csv', status = 'old')
    read(1,*) (beta_d2_4(i), i=1, nauxd)
    close(1)
    !beta_D3_1
    open(1, file = trim(filepath)//'/model_data/betaD3_1_var.csv', status = 'old')
    read(1,*) (beta_d3_1(i), i=1, nauxd)
    close(1)
    !beta_D3_2
    open(1, file = trim(filepath)//'/model_data/betaD3_2_var.csv', status = 'old')
    read(1,*) (beta_d3_2(i), i=1, nauxd)
    close(1)
    !beta_D3_3
    open(1, file = trim(filepath)//'/model_data/betaD3_3_var.csv', status = 'old')
    read(1,*) (beta_d3_3(i), i=1, nauxd)
    close(1)
    !beta_D3_4
    open(1, file = trim(filepath)//'/model_data/betaD3_4_var.csv', status = 'old')
    read(1,*) (beta_d3_4(i), i=1, nauxd)
    close(1)

    weight_vec = (/beta_small, beta_big, beta_d1_1, beta_d1_2, beta_d1_3, beta_d1_4, &
         & beta_d2_1, beta_d2_2, beta_d2_3, beta_d2_4, &
         & beta_d3_1, beta_d3_2, beta_d3_3, beta_d3_4/)

    !create weight matrix, diagonal inverse of variance for now
    weight_mat = 0
    do i=1, naux
       weight_mat(i,i) = 1/weight_vec(i)
    end do

    !Also reading weight matrix for the calibration moments
    other_weight_mat = 0
    open(1, file = trim(filepath)//'/model_data/aux_other_var.txt', status = 'old')
    !skip first line b/c it is varname
    read(1,*)
    read(1,*) (other_weight_mat(i,i), i=1, 78)
    close(1)
    do i=1,78
       other_weight_mat(i,i) = 1/other_weight_mat(i,i)
    end do
    !adjust some items
    !some are zero variance..:
    other_weight_mat(70,70) = other_weight_mat(71,71)
    other_weight_mat(72,72) = other_weight_mat(73,73)
    !weights for fraction over/under capacity
    other_weight_mat(79,79) = 100!0.01
    other_weight_mat(80,80) = 100!0.01
    other_weight_mat(81,81) = 100!0.01
    other_weight_mat(82,82) = 100!0.01

    open(1, file=trim(filepath)//'/model_data/inc_mean_var.csv', status='old')
    read(1,*) !pr_data_stay not used anywhere...
    read(1,*) other_weight_mat(83,83) !beta_d4
    close(1)
    other_weight_mat(83,83)=dble(1)/other_weight_mat(83,83)

    ! Also adding weight matrix for omega moments
    omega_weight_mat = 0
    open(1, file = trim(filepath)//'/model_data/omega1_var_JPE.csv')
    read(1,*) omega1
    close(1)

    open(1, file = trim(filepath)//'/model_data/omega2_var_JPE.csv')
    read(1,*) omega2
    close(1)

    !omega12 variances are located in same moments file, not separate '_var.csv'
    open(1, file = trim(filepath)//'/model_data/alpha12_moments.csv')
    read(1,*)
    read(1,*)
    read(1,*)
    read(1,*)
    read(1,*)
    read(1,*) omega12
    close(1)

    omega12 = omega12 / ndist !reweighting b/c variance estimator

    !pr(omega) variables
    open(1, file = trim(filepath)//'/model_data/omega1_var.csv')
    read(1,*) pr_omega1(1:NWgrid1-1)
    close(1)
    open(1, file = trim(filepath)//'/model_data/omega2_var.csv')
    read(1,*) pr_omega2(1:NWgrid2-1)
    close(1)
    !pr omega old
    open(1, file = trim(filepath)//'/model_data/omegas_1_0.csv')
    read(1,*) 
    read(1,*) pr_omegaOLD 
    close(1)

    ! omega x dem variables
    open(1, file = trim(filepath)//'/model_data/omega_moments_JPE.csv')
    read(1,*)
    do i=1,4
       read(1,*) tmpchr, tmpnum, omegadem(i)
    end do
    close(1)
    
    omega_weight_vec = (/ omega1, omega2, omega12, &
         pr_omega1(1:NWgrid1-1), pr_omega2(1:NWgrid2-1), &
         pr_omegaOLD, omegadem/)
    
    omega_weight_mat = 0
    do i=1, naux_omega
       omega_weight_mat(i,i) = 1/omega_weight_vec(i)
    end do


    !Load weight adjustment file:
    aux_weight_factor   = 1
    omega_weight_factor = 1
    other_weight_factor = 1
    open(1, file = 'moment_weight_factors.txt')
    read(1,*)
    do i=1, naux
       read(1,*) d1,d2,d3,d4,d5, aux_weight_factor(i,1)
    end do
    do i=1, naux_omega
       read(1,*) d1,d2,d3,d4,d5, omega_weight_factor(i,1)
    end do
    do i=1, naux_other
       read(1,*) d1,d2,d3,d4,d5, other_weight_factor(i,1)
    end do
    close(1)

    !adjust weights
    do i=1, naux
       weight_mat(i,i) = weight_mat(i,i) * aux_weight_factor(i,1)
    end do
    do i=1, naux_omega
       omega_weight_mat(i,i) = omega_weight_mat(i,i) * omega_weight_factor(i,1)
    end do
    do i=1, naux_other
       other_weight_mat(i,i) = other_weight_mat(i,i) * other_weight_factor(i,1)
    end do

    !call adjust_weights()

  end subroutine read_weight_matrixes

!  !temp function to adjust weights by hand
!  subroutine adjust_weights()
!    integer :: i
!
!    !ols subset weights
!    weight_mat(1,1) = weight_mat(1,1)*5
!    weight_mat(2,2) = weight_mat(2,2)*5
!    weight_mat(3,3) = weight_mat(3,3)*5
!    !ols all offer weights
!    weight_mat(10,10) = weight_mat(10,10)*5
!    weight_mat(11,11) = weight_mat(11,11)*5
!    weight_mat(12,12) = weight_mat(12,12)*5
!
!
!    !calib weights
!    do i=1,40
!       other_weight_mat(i,i) = other_weight_mat(i,i)*30
!    end do
!    other_weight_mat(57,57) = other_weight_mat(57,57)*30
!
!
!    do i=75, 78
!       other_weight_mat(i,i) = other_weight_mat(i,i)*5
!    end do
!
!    other_weight_mat(79,79) = other_weight_mat(79,79)*20
!    other_weight_mat(80,80) = other_weight_mat(80,80)*20
!    other_weight_mat(81,81) = other_weight_mat(81,81)*100
!    other_weight_mat(82,82) = other_weight_mat(82,82)*100
!
!  end subroutine adjust_weights

  ! ********** Read in Data ************
  ! 1.  Matches   (district t+1)
  ! 2.  Incumbent (district t)
  ! 3.  Same CZ
  ! 4.  Master
  ! 5.  Exp - dummies
  ! 6.  Exp - categorical (dummy groups)
  ! 7.  Exp - cts variable
  ! ++  Age - cts variable for forward simulation
  ! 8.  VA
  ! 9. Share Low
  ! 10. Urban
  ! 11. Suburban
  ! 12.  Wage components (omega1-2,wageschedule)
  subroutine read_data()
    use qsort_mod
    !read(1,*) goes by columns, so need to create transpose versions of dataframes
    ! there may be a cleaner way to take care of this, but this seems easiest JRS
    double precision, dimension(1,ndist)         :: wageomega1, wageomega2
    !double precision, dimension(ndist, nteach) :: twageschedule, tlogdist
    double precision, allocatable, dimension(:,:) :: twageschedule, tlogdist
    !integer,          dimension(ndist, nteach) :: tsamecz,tmatch, tinc
    integer, allocatable, dimension(:,:) :: tsamecz,tmatch, tinc
    !integer,          dimension(6, nteach)     :: texp
    integer, allocatable, dimension(:,:) :: texp
    !double precision, dimension(4, nteach)     :: tva
    double precision, allocatable, dimension(:,:) :: tva
    ! also need tmp vars to help turn vectors into matrices
    !integer, dimension(nteach,1) :: tmpmaster, tmpexp_con
    integer, allocatable, dimension(:,:) :: tmpmaster, tmpexp_con
    !double precision, dimension(nteach,1)      :: v1, v2, xb1, xb2
    double precision, allocatable, dimension(:,:) :: v1, v2, xb1, xb2
    !double precision, dimension(nteach, 4)     :: va
    double precision, allocatable, dimension(:, :) :: va           
    !double precision, dimension(1,ndist)       :: tmpshare_low, tmpurban, tmpsuburban
    ! to help make dem_abovemed
    double precision, dimension(ndist) :: demsorted
    double precision :: demmed
    integer :: idx

    integer, allocatable, dimension(:,:) :: ones_nteach


    double precision :: junk, tval
    integer :: junk_int
    integer :: i, j, l, exp_gr_entrant, jlow, jhigh

    integer :: k
    double precision, allocatable, dimension(:) :: prob_entry

    !allocate nteach vars
    allocate(twageschedule(ndist, nteach), tlogdist(ndist, nteach))
    allocate(tsamecz(ndist, nteach), tmatch(ndist, nteach), tinc(ndist, nteach))
    allocate(texp(6, nteach))
    allocate(tva(4,nteach))
    allocate(tmpmaster(nteach,1), tmpexp_con(nteach,1))
    allocate(v1(nteach,1), v2(nteach,1), xb1(nteach,1), xb2(nteach,1))
    allocate(va(nteach,4))
    

    
    !match
    open(1, file = trim(filepath)//'/model_data/match.csv', status = 'old')
    read(1,*) tmatch
    match = transpose(tmatch)
    close(1)
    !incumbent
    open(1, file = trim(filepath)//'/model_data/incumbent.csv', status = 'old')
    read(1,*) tinc
    inc = transpose(tinc)
    close(1)
    !same commuting zone
    open(1, file = trim(filepath)//'/model_data/samecz.csv', status = 'old')
    read(1,*) tsamecz
    samecz = transpose(tsamecz)
    close(1)
    !master
    open(1, file = trim(filepath)//'/model_data/master.csv', status = 'old')
    read(1,*) tmpmaster
    close(1)
    master = matmul(tmpmaster, ones_ndist)
    !exp_dum
    open(1, file = trim(filepath)//'/model_data/experience.csv', status = 'old')
    read(1,*) texp
    close(1)
    exp_dum = transpose(texp)
    ! moved exp_dum1-6 and exp_gr to teacher generated variable function
    !exp_con
    open(1, file = trim(filepath)//'/model_data/experiencecont.csv', status = 'old')
    read(1,*) tmpexp_con
    close(1)
    exp_con = matmul(tmpexp_con, ones_ndist)
    ! moved tenured variable to the teacher_generated_data function
    !va
    open(1, file = trim(filepath)//'/model_data/contributions.csv', status = 'old')
    read(1,*) tva
    va = transpose(tva)
    close(1)
    xb1(:,1) = va(:,1)
    xb2(:,1) = va(:,2)
    v1(:,1) = va(:,3)
    v2(:,1) = va(:,4)
    !Note: v1 v2 for exp==1 are mean of the group, set in data, no need to do it here
    !set C1 and C2
    C1 = v1 + xb1
    C2 = v2 + xb2

    ! moved to the generate_teacher function
    !C1_median = median(C1(:,1))
    !addmin(1) = abs(minval(C1))
    !addmin(2) = abs(minval(C2))

    allocate(ones_nteach(nteach,1))
    ones_nteach = 1

    !share_low
    open(1, file = trim(filepath)//'/model_data/lambda.csv', status = 'old')
    read(1,*) share_low_ndist !tmpshare_low
    close(1)
    ! this also occurs in generate_teacher_data, so if that is called alone it still happens (i.e. when nteach changes)
    share_low = matmul(ones_nteach, share_low_ndist)
    !urban
    open(1, file = trim(filepath)//'/model_data/urban.csv', status = 'old')
    read(1,*) urban_ndist !tmpurban
    close(1)
    ! this also occurs in generate_teacher_data, so if that is called alone it still happens (i.e. when nteach changes)
    urban = matmul(ones_nteach, urban_ndist)
    !suburban
    open(1, file = trim(filepath)//'/model_data/suburban.csv', status = 'old')
    read(1,*) suburban_ndist !tmpsuburban
    close(1)
    ! this also occurs in generate_teacher_data, so if that is called alone it still happens (i.e. when nteach changes)
    suburban = matmul(ones_nteach, suburban_ndist)
    !democratic vote share
    open(1, file = trim(filepath)//'/model_data/democratic.csv', status = 'old')
    read(1,*) demshare
    close(1)
    !wage
    open(1, file = trim(filepath)//'/model_data/alpha1.csv', status = 'old')
    read(1,*) wageomega1(1,:)
    close(1)
    open(1, file = trim(filepath)//'/model_data/alpha2.csv', status = 'old')
    read(1,*) wageomega2(1,:)
    close(1)
    open(1, file = trim(filepath)//'/model_data/wageschedule.csv', status = 'old')
    read(1,*) twageschedule
    close(1)
    wageschedule = transpose(twageschedule)
    !set up contribution = c1*share_low + c2*(1-share_low)
    contribution = matmul(C1,share_low(1:1,:)) + matmul(C2,(1.0d0 - share_low(1:1,:)))
    ! wage = omega1 * wageschedule + omega2 * contribution
    if (purpose .ne. 7) then
       wage =        matmul(ones_nteach,wageomega1) * wageschedule
       wage = wage + matmul(ones_nteach,wageomega2) * contribution
    else
       !purpose = 7 is rigid wage
       wage = wageschedule
    end if
    !floor and ceiling for wages
    wage = min(wage, wageupper)
    wage = max(wage, wagelower)
    !wage grid
    Wgrid(:,1) = wageomega1(1,:)
    Wgrid(:,2) = wageomega2(1,:)

    deallocate(ones_nteach)


    ! New for forward iter, we need to load in more granular wageschedule so can use it w/ new teacher population
    !ba
    open(1, file = trim(filepath)//'/model_data/wageschedule_ba.csv', status = 'old')
    read(1,*)
    do j=1, ndist
       read(1,*) junk_int, wageschedule_ba(j,1), wageschedule_ba(j,2), wageschedule_ba(j,3), &
            wageschedule_ba(j,4), wageschedule_ba(j,5), wageschedule_ba(j,6)
    end do
    close(1)
    !ma
    open(1, file = trim(filepath)//'/model_data/wageschedule_ma.csv', status = 'old')
    read(1,*)
        do j=1, ndist
           read(1,*) junk_int, wageschedule_ma(j,1), wageschedule_ma(j,2), wageschedule_ma(j,3), &
                wageschedule_ma(j,4), wageschedule_ma(j,5), wageschedule_ma(j,6)
    end do
    close(1)
    
    
    ! Moved this to gen teacher data, b/c has nteach dimension
    !set dummy matrix for milwaukee (d=224)
    !milwauk = 0
    !milwauk(:,224) = 1

    !read in the distance matrix, which is ndist x ndist
!    if (T_max > 1) then
       allocate(logdist_btwn_districts(ndist,ndist))
       !  its symmetric so could save w/ diff structure, but meh, this is easier
       open(1, file = trim(filepath)//'/model_data/logdist_btwn_districts.csv', status = 'old')
       read(1,*) logdist_btwn_districts
       close(1)
!    end if

    !read in the distance dataframe
    !open(1, file = trim(filepath)//'/model_data/logdist.csv', status = 'old')
    open(1, file = trim(filepath)//'/model_data/lndist.csv', status = 'old')
    read(1,*) tlogdist
    close(1)
    logdist = transpose(tlogdist)


    !set the 'dem_abovemed' variable.
    ! 1. sort
    demsorted = demshare
    call qsort(demsorted)
    ! 2. grab the median value
    idx = ndist/2   !integer division rounds
    if (modulo(ndist,2) .ne. 0 ) then !odd
       demmed = demsorted(idx + 1)
    else !even
       demmed = (demsorted(idx) + demsorted(idx+1)) / 2
    end if
    ! 3. create a flag for above or equal to median
    dem_abovemed = 0
    do j=1, ndist
       if (demshare(j) >= demmed) dem_abovemed(j) = 1
    end do


    
    ! cz ids, so know which districts are in the same cz. Will generate czten in generate_teacher_data()
    open(1, file = trim(filepath)//'/real_data/cz_id.csv', status = 'old')
    read(1,*)
     do j=1,ndist
        read(1,*) tval, cz_id(j)
     end do
    close(1)


    ! moved the "subsidized" variable creation to generate_teacher_data

    ! Now we need to add some stuff for forward iteration

    if (T_max > 1) then
       !age 
       !open(1, file = trim(filepath)//'/model_data/age_estsample.csv', status = 'old')
       open(1, file = trim(filepath)//'/model_data/age_estsample_johnfortran.csv', status = 'old')
       read(1,*)
       do i=1, nteach
          read(1,*) junk, age(i)
       end do
       close(1)

       !entrant distribution
       if (flag_read_entr == 1) then
          ! # of entrants in read in file
          nentrant = 20273
          !nentrant = 22354
          ! alloc entrant population vars
          allocate(exp_entrant(nentrant), &
               C1_entrant(nentrant,1), &
               C2_entrant(nentrant,1), &
               age_entrant(nentrant),&
               master_entrant(nentrant))
          open(1, file = trim(filepath)//'/model_data/entry_covariates_fortran.csv', status = 'old')
          !open(1, file = trim(filepath)//'/model_data/entry_covariates_fortran_full.csv', status = 'old')
          read(1,*)
          allocate(baseline_prob_entry(nentrant))
          do l=1, nentrant
             read(1,*) junk, junk, exp_entrant(l), master_entrant(l), C1_entrant(l,1), C2_entrant(l,1), age_entrant(l), &
                  baseline_prob_entry(l)
          end do
          close(1)
          ! And b/c these probs are population * 3, lets devide them by 3
          baseline_prob_entry = baseline_prob_entry / 3

          ! and compute the baseline probabilities for entrants
          !call generate_prob_entry(baseline_prob_entry, age_entrant, exp_entrant, master_entrant, &
          !     c1_entrant(:,1), c2_entrant(:,1))
       else
          ! we are instead doing a different entrant population
          nentrant = nteach * ncopy_entr
          if (mpi_id == 0) print*, 'Num of Entrants in pool:', nentrant
          ! allocate entrant population vars
          allocate(exp_entrant(nentrant), &
               C1_entrant(nentrant,1), &
               C2_entrant(nentrant,1), &
               age_entrant(nentrant),&
               master_entrant(nentrant))

          ! and fill these variables as they are for our t=1 population
          do i=1, ncopy_entr
             ! set indexes
             jlow = (i-1) * nteach + 1
             jhigh = i * nteach
             !if (mpi_id == 0) print*, 'indexes:', i, jlow, jhigh, size(exp_entrant)
             ! copy in to entrant arrays
             exp_entrant(jlow:jhigh)    = exp_con(:,1)
             C1_entrant(jlow:jhigh,1)   = C1(:,1)
             C2_entrant(jlow:jhigh,1)   = C2(:,1)
             age_entrant(jlow:jhigh)    = age
             master_entrant(jlow:jhigh) = master(:,1)
          end do

          ! Temp checking that these entrant vars are set correctly:
          !if (mpi_id == 0) then
          !   print*, 'indivs checks'
          !   print*, exp_con(1,1), exp_entrant(1), exp_entrant(nteach+1), exp_con(nteach,1), &
          !        exp_entrant(nteach), exp_entrant(nteach * 2)
          !   print*, c1(1,1), c1_entrant(1,1), c1_entrant(nteach+1,1), c1(nteach,1), &
          !        c1_entrant(nteach,1), c1_entrant(nteach * 2,1)
          !   print*, c2(1,1), c2_entrant(1,1), c2_entrant(nteach+1,1), c2(nteach,1), &
          !        c2_entrant(nteach,1), c2_entrant(nteach * 2,1)
          !   print*, master(1,1), master_entrant(1), master_entrant(nteach+1), master(nteach,1), &
          !        master_entrant(nteach), master_entrant(nteach * 2)
          !   print*, 'avg checks'
          !   print*, sum(exp_entrant)/nentrant, sum(c1_entrant)/nentrant, sum(c2_entrant)/nentrant, &
          !        sum(dble(master_entrant))/nentrant
          !   ! XX
          !   call exit(1)
          !end if

          allocate(baseline_prob_entry(nentrant))
          ! and compute the baseline probabilities for entrants
          call generate_prob_entry(baseline_prob_entry, age_entrant, exp_entrant, master_entrant, &
               c1_entrant(:,1), c2_entrant(:,1))

       end if

       
          ! XXX Temp let's compare the generate prob entry to the read-in
           !   looks good, but I think bb's covariate file maybe has some not right, maybe for exp?
           !   b/c I randomly don't match some, there is no pattern of unmatching
       !   In any case now we are donig a different thing, so this is irrelevant.
       !if (mpi_id == 0) then
       !allocate(prob_entry(nentrant))
       !    call generate_prob_entry(prob_entry, age_entrant, exp_entrant, master_entrant, &
       !         c1_entrant(:,1), c2_entrant(:,1))
       !    !! and compare
       !    do k=1, nEntrant
       !       if (abs(prob_entry(k) - baseline_prob_entry(k)) > 0.01 ) then
       !          print*, k, prob_entry(k), baseline_prob_entry(k), age_entrant(k), exp_entrant(k), &
       !               master_entrant(k), c1_entrant(k,1), c2_entrant(k,1), 1
       !       else
       !                           print*, k, prob_entry(k), baseline_prob_entry(k), age_entrant(k), exp_entrant(k), &
       !               master_entrant(k), c1_entrant(k,1), c2_entrant(k,1), 0
       !       end if
       !    end do
       !    print*, sum(prob_entry), sum(baseline_prob_entry), prob_entry(1), baseline_prob_entry(1)
       !    call exit(1)
       ! end if

       ! check
       if (mpi_id == 0) print*, ' Baseline prob check:', sum(baseline_prob_entry)

       ! Generate wageschedule for entrants
       allocate(wageschedule_entrant(nEntrant, ndist))
       allocate(contribution_entrant(nEntrant, ndist))
       ! XXX, need to check this
       do i=1, nEntrant
          !set grp
          if (exp_entrant(i) == 1) then
             exp_gr_entrant = 1
          else if (exp_entrant(i) <= 3) then
             exp_gr_entrant = 2
          else if (exp_entrant(i) <= 5) then
             exp_gr_entrant = 3
          else if (exp_entrant(i) <= 10) then
             exp_gr_entrant = 4
          else if (exp_entrant(i) <= 15) then
             exp_gr_entrant = 5
          else
             exp_gr_entrant = 6
          end if
          
          if (master_entrant(i) == 1) then
             do j=1, ndist
                wageschedule_entrant(i,j) = wageschedule_ma(j,exp_gr_entrant)
             end do
          else
             do j=1, ndist
                wageschedule_entrant(i,j) = wageschedule_ba(j,exp_gr_entrant)
             end do
          end if
       end do

       ! Generate contribution for entrants
       contribution_entrant = matmul(C1_entrant,share_low(1:1,:)) + matmul(C2_entrant,(1.0d0 - share_low(1:1,:)))
    end if


    !deallocate nteach vars
    deallocate(twageschedule, tlogdist)
    deallocate(tsamecz, tmatch, tinc)
    deallocate(texp)
    deallocate(tva)
    deallocate(tmpmaster, tmpexp_con)
    deallocate(v1, v2, xb1, xb2)
    deallocate(va)
    
       
  end subroutine read_data


  ! for forward iteration, when teacher pool changes we will also need to rerun some of these generated variables
  !    so this function is created to do this stuf here instead of in read_data, so we can just run this small
  !    section again for each period forward

  ! Note, may be able to run this after read_data_pre or read_data? will they have identical needs?
  !  for now, ignoring the 'pre' code, b/c irrelevant for forward iteration
  subroutine generate_teacher_data()
    integer :: i,j

    double precision :: tval

    double precision, allocatable, dimension(:,:) :: ones_nteach!, logdist_tmp
    !integer,          allocatable, dimension(:,:) :: samecz_tmp


    ! start with some district vars that are stretched across nteach
    allocate(ones_nteach(nteach,1))
    ones_nteach = 1
    share_low = matmul(ones_nteach, share_low_ndist) 
    urban     = matmul(ones_nteach, urban_ndist)
    suburban  = matmul(ones_nteach, suburban_ndist)
    deallocate(ones_nteach)
    !set dummy matrix for milwaukee (d=224)
    milwauk = 0
    milwauk(:,224) = 1
    

    ! teacher contribution related vars
    C1_median = median(C1(:,1))
    addmin(1) = abs(minval(C1))
    addmin(2) = abs(minval(C2))

    ! generate downstream experience vars
    if (mpi_id == 1) print*, 'slave before generate exp variables'
    call generate_exp_variables()


    ! and then wage stuff
    !      (technically for the first time re-does some of the above read-in, but we used that as a bug check for
    !       this new feature which gives flexible teacher pop)
    if (mpi_id == 1) print*, 'slave before generate wagesched variables'
    call generate_wagesched_contrib()

    ! inc related vars
    ! Note: this will actually get re-run seperately for t>1 later, when we do inc economy-by-economy, we need to regen each economy
    if (mpi_id == 1) print*, 'slave before generate inc variables'
    call generate_inc_variables()
    ! entrant
    ! czten (tenured, cz_id)
    ! logdist (logdist_btwn_districts)
    ! samecz (


    ! set up the 'subsidized' variable, which identifies 'special teachers', in that
    !     they receive bonus money.
    if (purpose == 11 .or. purpose == 12) then
       ! need tc for a district match to be > 0
       if (minval(r_vec) > 0) then
          do i=1, nteach
             ! if all districts are doing bonuses, then we just need some match
             !      to have positive TC (contribution)
             if (maxval(contribution(i,:)) > 0) subsidized(i) = 1
          end do
       else if (t_period == 1) then
          !this is ok, in first period we don't want any subsidies to hit yet
       else
          print*, "logic isn't set up right now for having some districts unsubsidized"
          call exit(1)
       end if
       

    else if (purpose == 13 .or. purpose == 14) then
       ! only c1 matters
       if (minval(r_vec) > 0) then
          do i=1, nteach
             ! if all districts are doing bonuses, then if C1 is positive for a
             !      teacher, they will receive money.
             if ( C1(i,1)>0) subsidized_C1(i) = 1
          end do
       else if (t_period == 1) then
          !this is ok, in first period we don't want any subsidies to hit yet
       else
          print*, "logic isn't set up right now for having some districts unsubsidized"
          call exit(1)
       end if

    else if (purpose == 15 .or. purpose == 16) then
       ! need either c1 or c2 to be postive, as it is max(0,tc1) + max(0,tc2)
       do i=1, nteach
          if ( s_vec(1)*C1(i,1) > 0) subsidized_C1(i) = 1 
          if ( s_vec(2)*C2(i,1) > 0) subsidized_C2(i) = 1 
       end do

    else if (purpose == 17 .or. purpose == 18) then
       ! need to take into account s_vec values to see if positive or not, as it is
       !     max(0, s1*tc1 + s2*tc2)
       do i=1, nteach
          do j=1, ndist
             if ( s_vec(1) * (C1(i,1) * share_low(1,j))  +  &
                  s_vec(2) * (C2(i,1) * (1-share_low(1,j))) > 0) then
                subsidized(i) = 1
                exit
             end if
          end do
       end do
    end if

    if (mpi_id == 1) print*, 'slave made it to end of generate teacher data'
  end subroutine generate_teacher_data

  ! separated this out from generate_teacher_data so can run it alone in inner_loop_one.f90,
  !   need this to set the 'inc' variables seperately for each economy
  subroutine generate_inc_variables()
    integer,          dimension(ndist) :: distten, disttot ! help for making czten
    integer :: incdist, inccz
    integer :: i, j
    
    ! entrant status
    !set new entrants
    entrant = 0
    do i=1, nteach
       if (sum(inc(i,:)) == 0) entrant(i,:) = 1
    end do

    if (mpi_id ==0) print*, 'finished setting entrants'
    
    !set tenure variable
    tenured = 0
    do i=1, nteach
       ! tenure is defined as > 3 years of exp.
       if (exp_con(i,1) > 3) tenured(i,:) = 1
    end do

    ! czten is only relevant for aux models, which aren't used in forward iter
    if (T_max == 1) then
       !set the czten var.  This should be leave-self-out avg of others share tenured in cz
       distten = sum(inc*tenured,1) !/ dble(sum(inc, dim = 1))  ! denom is 'T' but it is not set globally yet
       disttot = sum(inc,1)
       do j=1, ndist
          !for dist j, calculate avg share tenured among others in their cz
          czten(j) = (sum(distten, cz_id == cz_id(j))-distten(j)) / dble((sum(disttot, cz_id == cz_id(j)) - disttot(j)))
       
       end do
    end if

    if (mpi_id ==0) print*, 'finished setting czten and tenure'
       
    ! Generate logdist 

    ! to generate logdist, we need to know d0. From there it is easy to pull that row out from
    !      logdist_btwn_districts:
    !allocate(logdist_tmp(nteach,ndist))
    logdist = 0
    do i=1, nteach
       ! only do distance if they are an incumbent somewhere of course
       if (sum(inc(i,:)) == 1) then
          logdist(i:i,:) = logdist_btwn_districts(maxloc(inc(i,:)),:)
          !logdist_tmp(i:i,:) = logdist_btwn_districts(maxloc(inc(i,:)),:)
       end if
    end do
    if (mpi_id ==0) print*, 'finished setting logdist'
    ! check if we match logdist
    !  we match as of 10/13/23
    !do i=1, nteach
    !   do j=1, ndist
    !      !if (logdist_tmp(i,j) .ne. logdist(i,j)) then
    !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
    !         print*, 'logdist isnt matching', logdist_tmp(i,j), logdist(i,j), i, j, abs(logdist_tmp(i,j) - logdist(i,j))
    !         call exit(1)
    !      end if
    !   end do
    !end do
    !print*, 'logdist is successful'
    !call exit(1)

    ! Generate samecz
    !allocate(samecz_tmp(nteach,ndist))
    !samecz_tmp = 0
    samecz = 0 
    do i=1, nteach
       ! only non-entrants will have a cz
       if (entrant(i,1) .ne. 1) then
          incdist = maxloc(inc(i,:),1)
          inccz   = cz_id(incdist)
          do j=1, ndist
             if (cz_id(j) == inccz) then
                samecz(i,j) = 1
                !samecz_tmp(i,j) = 1
             end if
          end do
       end if !entrant
    end do !nteach
    ! check if we match samecz_tmp
    ! we match as of 10/13/23, except for one person, i=1870, who is an entrant, but somehow had a samecz value.
    !     now it is fixed with this new code.
    !do i=1, nteach
    !   !if (i .ne. 1870) then
    !   incdist = maxloc(inc(i,:),1)
    !   inccz   = cz_id(incdist)
    !   do j=1, ndist
    !      if (samecz_tmp(i,j) .ne. samecz(i,j)) then
    !         !      if (abs(logdist_tmp(i,j) - logdist(i,j)) > 0.0001) then
    !         print*, 'samecz isnt matching', samecz_tmp(i,j), samecz(i,j), i, j, incdist, inccz
    !         call exit(1)
    !      end if
    !   end do
    !   !end if
    !end do
    !print*, 'samecz is successful'
    !call exit(1)

  end subroutine generate_inc_variables
  

  
  ! separated this out from generate_teacher_data so can run it alone in main.f90,
  !   need this info "early" for entry/exit model
  subroutine generate_exp_variables()
    use mpi
    integer :: i, j
    
    
    ! experience related vars
    !exp_dum is read in, but needs to be generated for future periods
    !if (T_max > 1) then
    if (t_period > 1) then
       exp_dum = 0
       do i=1, nteach
          !exp_dum
          if (exp_con(i,1) == 1) then
             exp_dum(i,1) = 1
          else if (exp_con(i,1) <= 3) then
             exp_dum(i,2) = 1
          else if (exp_con(i,1) <= 5) then
             exp_dum(i,3) = 1
          else if (exp_con(i,1) <= 10) then
             exp_dum(i,4) = 1
          else if (exp_con(i,1) <= 15) then
             exp_dum(i,5) = 1
          else
             exp_dum(i,6) = 1
          end if
       end do
    end if



    !exp_dum1-6
    exp_dum1 = matmul(exp_dum(:,1:1), ones_ndist)
    exp_dum2 = matmul(exp_dum(:,2:2), ones_ndist)
    exp_dum3 = matmul(exp_dum(:,3:3), ones_ndist)
    exp_dum4 = matmul(exp_dum(:,4:4), ones_ndist)
    exp_dum5 = matmul(exp_dum(:,5:5), ones_ndist)
    exp_dum6 = matmul(exp_dum(:,6:6), ones_ndist)
    !exp_gr (used only in aux model subset offer logic I think, but now also used for wageschedule)
    !    do j=1,5
    call mpi_barrier(mpi_comm_world, ierr)
    do i=1, nteach
       if (exp_dum(i,1) == 1) exp_gr(i,1) = 1
       if (exp_dum(i,2) == 1) exp_gr(i,1) = 2
       if (exp_dum(i,3) == 1) exp_gr(i,1) = 3
       if (exp_dum(i,4) == 1) exp_gr(i,1) = 4
       if (exp_dum(i,5) == 1) exp_gr(i,1) = 5
       if (exp_dum(i,6) == 1) exp_gr(i,1) = 6
    end do
!    end do

  end subroutine generate_exp_variables

  
  ! separated this out from generate_teacher_data so can run it alone in main.f90,
  !   need this info "early" for entry/exit
  subroutine generate_wagesched_contrib()
    integer :: i, j!, tval

    
    ! bug check, can I reproduce the given wageschedule file?
    do i=1, nteach
       do j=1, ndist
          if (master(i,j) == 1) then
             !tval = wageschedule_ma(j,exp_gr(i,1))
             wageschedule(i,j) = wageschedule_ma(j,exp_gr(i,1))
          else
             !tval = wageschedule_ba(j,exp_gr(i,1))
             wageschedule(i,j) = wageschedule_ba(j,exp_gr(i,1))
          end if
          ! we are matching as of 10/13/23, although not in floats, some roundings are different
          !if (abs(wageschedule(i,j) - tval) > 0.0001) then
          !   print*, 'we have a bug in wageschedule creation...'
          !   print*, i, j, master(i,j), exp_gr(i,1), wageschedule(i,j), tval, wageschedule_ma(j,exp_gr(i,1)), &
          !        wageschedule_ba(j,exp_gr(i,1)), abs(wageschedule(i,j) - tval)
          !   call exit(1)
          !end if
       end do
    end do
    !print*, 'wageschedule was successful'
    !print*, 'wageschedule, need to come back to this after BB looks over'
    !call exit(1)

    contribution = matmul(C1,share_low(1:1,:)) + matmul(C2,(1.0d0 - share_low(1:1,:)))

    !bugcheck
    !if(mpi_id==0) print*, contribution(4,1), C1(4,1), C2(4,1), share_low(4,1)

  end subroutine generate_wagesched_contrib
  

  ! made this work as a portable function only using local variables here b/c
  !    (may) need to generate this economy-by-economy and seperate timing from 'generate_teacher_data'
  ! Note: right now not using econ-by-econ feature, we have same pop across the 50 econs
  subroutine generate_prob_exit(prob_exit, age_per, exp_per, master_per, C1_per, C2_per)
    !double precision, dimension(nteach), intent(out) :: prob_exit
    double precision, dimension(:), intent(out) :: prob_exit
    ! inputs are assumed shape array to avoid array temporaries as they are strided when called
    double precision, dimension(:),      intent(in) :: C1_per, C2_per
    integer,          dimension(:),      intent(in) :: age_per, exp_per, master_per
    !double precision, dimension(nteach) :: age1, age2, age3, age4, age5
    !double precision, dimension(nteach) :: exp1, exp2, exp3, exp4, exp5, exp6
    double precision, allocatable, dimension(:) :: age1, age2, age3, age4, age5
    double precision, allocatable, dimension(:) :: exp1, exp2, exp3, exp4, exp5, exp6

    integer :: i

    !alloc nteach vars
    allocate(age1(nteach), age2(nteach), age3(nteach), age4(nteach), age5(nteach))
    allocate(exp1(nteach), exp2(nteach), exp3(nteach), exp4(nteach), exp5(nteach), exp6(nteach))


    ! Age dummies
    age1 = 0
    age2 = 0
    age3 = 0
    age4 = 0
    age5 = 0
    do i=1, nteach
       if (age_per(i) < 30) then
          age1(i) = 1
       else if (age_per(i) < 45) then
          age2(i) = 1
       else if (age_per(i) < 55) then
          age3(i) = 1
       else if (age_per(i) < 62) then
          age4(i) = 1
       else
          age5(i) = 1
       end if
    end do

    ! Exp dummies
    exp1 = 0
    exp2 = 0
    exp3 = 0
    exp4 = 0
    exp5 = 0
    exp6 = 0
    do i=1, nteach
       !exp_dum
       if (exp_per(i) == 1) then
          exp1(i) = 1
       else if (exp_per(i) <= 3) then
          exp2(i) = 1
       else if (exp_per(i) <= 5) then
          exp3(i) = 1
       else if (exp_per(i) <= 10) then
          exp4(i) = 1
       else if (exp_per(i) <= 15) then
          exp5(i) = 1
       else
          exp6(i) = 1
       end if
    end do


    ! parameter values come from BB's stata code
    prob_exit =  &
         ! age dummies
         -1.726586 * age2 + &
         -1.918916 * age3 + &
         0.7195059 * age4 + &
         1.480628  * age5 + &
         ! exp dummies
         -1.905028 * exp3 + &
         -2.334365 * exp4 + &
         -2.210456 * exp5 + &
         -1.641332 * exp6 + &
         ! master / C1 / C2
         0.1716359 * master_per + &
         -4.867485 * C1_per + &
         2.958172  * C2_per + &
         ! age * exp ster)
         -2.518655  * age1 * exp2          + &
         -0.5922871 * age1 * exp3          + &
         0.3767474  * age1 * exp3 * master_per + &
         0.1986678  * age1 * exp4 * master_per + &
         -1.167858  * age2 * exp2          + &
         1.423465   * age2 * exp3          + &
         -0.522141  * age2 * exp3 * master_per + &
         1.70768    * age2 * exp4          + &
         -0.4261816 * age2 * exp4 * master_per + &
         1.416716   * age2 * exp5          + &
         -0.6827148 * age2 * exp5 * master_per + &
         -0.1266752 * age2 * exp6 * master_per + &
         0.2026788  * age2        * master_per + &
         1.476243   * age3 * exp3          + &
         0.6647152  * age3 * exp3 * master_per + &
         1.213979   * age3 * exp4          + &
         -0.0508234 * age3 * exp4 * master_per + &
         1.66701    * age3 * exp5          + &
         -0.3510542 * age3 * exp5 * master_per + &
         -0.1017505 * age3 * exp6 * master_per + &
         -1.21639   * age4 * exp4 * master_per + &
         -0.1618628 * age4 * exp5          + &
         -0.6211308 * age4 * exp5 * master_per + &
         -0.2079674 * age4 * exp6 * master_per + &
         0.3041041  * age5 * exp5 * master_per + &
         ! exp * master * (c1 / c2)
         -13.84134 * exp3 * master_per * C1_per + &
         15.31195  * exp3 * master_per * C2_per + &
         -9.065213 * exp4 * master_per * C1_per + &
         4.498231  * exp4 * master_per * C2_per + &
         -7.541903 * exp5 * master_per * C1_per + &
         6.049184  * exp5 * master_per * C2_per + &
         1.348466  * exp6 * master_per * C1_per + &
         -1.067225 * exp6 * master_per * C2_per + &
         ! Year dummies, we are assuming 2014 remains the steady state, so keeping constant and the 2014 dummy.
         !   If I got these dummies wrong it should compare when we compare predicted value of exit of stata output
         !(-0.1106883)  + & !Y8  (2013?)
         (-0.1253728)  + & !Y9  (2014?)
         (-0.3346778) ! constant term
         

    ! now translate through the logit:
    prob_exit = exp(prob_exit)
    prob_exit = prob_exit / (1 + prob_exit)

    !save prob_exit to a file
    !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
    !open(1, file='check_exit_probs.txt', status='replace')
    !do i=1, nteach
    !   write(1,*) i, prob_exit(i), age(i), exp_con(i,1), master(i,1), c1(i,1), c2(i,1)
    !end do
    !close(1)
    !call exit(1)
         

    deallocate(age1, age2, age3, age4, age5)
    deallocate(exp1, exp2, exp3, exp4, exp5, exp6)
    
  end subroutine generate_prob_exit


  ! made this work as a portable function only using local variables here b/c
  !    (may) need to generate this economy-by-economy and seperate timing from 'generate_teacher_data'
  ! Note: right now not using econ-by-econ feature, we have same pop across the 50 econs
  subroutine generate_prob_entry(prob_entry, age_per, exp_per, master_per, C1_per, C2_per)
    !double precision, dimension(nteach), intent(out) :: prob_entry
    double precision, dimension(:), intent(out) :: prob_entry
    ! inputs are assumed shape array to avoid array temporaries as they are strided when called
    double precision, dimension(:),      intent(in) :: C1_per, C2_per
    integer,          dimension(:),      intent(in) :: age_per, exp_per, master_per
    !double precision, dimension(nteach) :: age1, age2, age3, age4, age5
    !double precision, dimension(nteach) :: exp1, exp2, exp3, exp4, exp5, exp6
    double precision, allocatable, dimension(:) :: age1, age2, age3, age4, age5
    double precision, allocatable, dimension(:) :: exp1, exp2, exp3, exp4, exp5, exp6

    integer :: i, m

    m = size(C1_per)

    !alloc nteach vars
    allocate(age1(m), age2(m), age3(m), age4(m), age5(m))
    allocate(exp1(m), exp2(m), exp3(m), exp4(m), exp5(m), exp6(m))


    ! Age dummies
    age1 = 0
    age2 = 0
    age3 = 0
    age4 = 0
    age5 = 0
    do i=1, m
       if (age_per(i) < 30) then
          age1(i) = 1
       else if (age_per(i) < 45) then
          age2(i) = 1
       else if (age_per(i) < 55) then
          age3(i) = 1
       else if (age_per(i) < 62) then
          age4(i) = 1
       else
          age5(i) = 1
       end if
    end do

    ! Exp dummies
    exp1 = 0
    exp2 = 0
    exp3 = 0
    exp4 = 0
    exp5 = 0
    exp6 = 0
    do i=1, m
       !exp_dum
       if (exp_per(i) == 1) then
          exp1(i) = 1
       else if (exp_per(i) <= 3) then
          exp2(i) = 1
       else if (exp_per(i) <= 5) then
          exp3(i) = 1
       else if (exp_per(i) <= 10) then
          exp4(i) = 1
       else if (exp_per(i) <= 15) then
          exp5(i) = 1
       else
          exp6(i) = 1
       end if
    end do


    ! parameter values come from BB's stata code
    prob_entry =  &
         ! age dummies
         0.0325744 * age2 + &
         0.0379624 * age3 + &
         0.2772404 * age4 + &
         -17.3495  * age5 + &
         ! exp dummies
          -1.25937 * exp2 + &
         -2.332426 * exp3 + &
         -2.979173 * exp4 + &
         -5.143154 * exp5 + &
         -6.085858 * exp6 + &
         ! master / C1 / C2
          11.52152 * master_per + &
          .1238651 * C1_per + &
         -.8257369 * C2_per + &
         ! age * exp (* master)
         !age1
          -.995278 * age1 * exp2          + &
          .8970723 * age1 * exp2 * master_per + &
          -1.37441 * age1 * exp3          + &
         -.3075241 * age1 * exp3 * master_per + &
         -.4541572 * age1 * exp4          + &
         4.939774  * age1 * exp6          + &
         -11.97605 * age1        * master_per + &
         !age2
         -.7150135 * age2 * exp2          + &
         -.9261577 * age2 * exp3          + &
         -.1991195 * age2 * exp3 * master_per + &
         -.8881695 * age2 * exp4          + &
         -.5292741 * age2 * exp4 * master_per + &
           .931118 * age2 * exp5          + &
         -1.653275 * age2 * exp5 * master_per + &
           .996966 * age2 * exp6         + &
         -.7526568 * age2 * exp6 * master_per + &
         -11.44638 * age2        * master_per + &
         !age3
         -.5982546 * age3 * exp2         + &
          .6752357 * age3 * exp2 * master_per + &          
         -.2127474 * age3 * exp3          + &
         -.9563762 * age3 * exp3 * master_per + &
         -.3124504 * age3 * exp4          + &
            .79174  * age3 * exp5          + &
          .3825266 * age3 * exp5 * master_per + &
          .6864041 * age3 * exp6 * master_per + &
         -12.06308 * age3        * master_per + &
         !age4
         -16.82645  * age4 * exp3 * master_per + &
         -20.74089  * age4 * exp4 * master_per + &
         
         -19.35871 * age4 * exp5 * master_per + &
         -19.09953 * age4 * exp6 * master_per + &
          7.995786 * age4        * master_per + &
         !age5
         6.118267    * age5 * exp6 + &
         
         ! exp * master * (c1 / c2)
         3.296729 * exp3 * master_per * C1_per + &
         15.35585 * exp3 * master_per * C2_per + &
         -1.349531 * exp4 * master_per * C1_per + &
          1.904872 * exp4 * master_per * C2_per + &
         -10.67493 * exp5 * master_per * C1_per + &
         14.01958 * exp5 * master_per * C2_per + &
         -4.974793 * exp6 * master_per * C1_per + &
         -1.564769 * exp6 * master_per * C2_per + &
         
         ! Year dummies, we are assuming 2014 remains the steady state, so keeping constant and the 2014 dummy.
         !   If I got these dummies wrong it should compare when we compare predicted value of exit of stata output
         !(-1.510012)  + & !Y8  (2013?)
         (-.6139581 )  + & !Y9  (2014?)
         (.7970784 ) ! constant term
         

    ! now translate through the logit:
    prob_entry = exp(prob_entry)
    prob_entry = prob_entry / (1 + prob_entry)

    !save prob_exit to a file
    !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
    !open(1, file='check_exit_probs.txt', status='replace')
    !do i=1, nteach
    !   write(1,*) i, prob_exit(i), age(i), exp_con(i,1), master(i,1), c1(i,1), c2(i,1)
    !end do
    !close(1)
    !call exit(1)
         

    deallocate(age1, age2, age3, age4, age5)
    deallocate(exp1, exp2, exp3, exp4, exp5, exp6)
    
  end subroutine generate_prob_entry
  

  ! read in from the validation data
  
  subroutine read_data_pre()
    use qsort_mod
    !read(1,*) goes by columns, so need to create transpose versions of dataframes
    ! there may be a cleaner way to take care of this, but this seems easiest JRS
    double precision, dimension(1,ndist)         :: wageomega1, wageomega2
    !double precision, dimension(ndist, nteach) :: twageschedule, tlogdist
    double precision, allocatable, dimension(:,:) :: twageschedule, tlogdist
    !integer,          dimension(ndist, nteach) :: tsamecz,tmatch, tinc
    integer, allocatable, dimension(:,:) :: tsamecz,tmatch, tinc
    !integer,          dimension(6, nteach)     :: texp
    integer, allocatable, dimension(:,:) :: texp
    !double precision, dimension(4, nteach)     :: tva
    double precision, allocatable, dimension(:,:) :: tva
    ! also need tmp vars to help turn vectors into matrices
    !integer, dimension(nteach,1) :: tmpmaster, tmpexp_con
    integer, allocatable, dimension(:,:) :: tmpmaster, tmpexp_con
    !double precision, dimension(nteach,1)      :: v1, v2, xb1, xb2
    double precision, allocatable, dimension(:,:) :: v1, v2, xb1, xb2
    !double precision, dimension(nteach, 4)     :: va
    double precision, allocatable, dimension(:, :) :: va           
    !double precision, dimension(1,ndist)       :: tmpshare_low, tmpurban, tmpsuburban
    ! to help make dem_abovemed
    double precision, dimension(ndist) :: demsorted
    double precision :: demmed
    integer :: idx
    ! help for making czten
    integer,          dimension(ndist) :: cz_id, distten, disttot
    double precision :: tval

    double precision, allocatable, dimension(:,:) :: ones_nteach

    integer :: i, j


    


    
    !match
    open(1, file = trim(filepath)//'/simulation_data/match_pre_NEW.csv', status = 'old')
    read(1,*) tmatch
    match = transpose(tmatch)
    close(1)
    !incumbent
    open(1, file = trim(filepath)//'/simulation_data/incumbent_pre_NEW.csv', status = 'old')
    read(1,*) tinc
    inc = transpose(tinc)
    close(1)
    !set new entrants
    entrant = 0
    do i=1, nteach
       if (sum(inc(i,:)) == 0) entrant(i,:) = 1
    end do
    !same commuting zone
    open(1, file = trim(filepath)//'/simulation_data/samecz_pre_NEW.csv', status = 'old')
    read(1,*) tsamecz
    samecz = transpose(tsamecz)
    close(1)
    !master
    open(1, file = trim(filepath)//'/simulation_data/master_pre_NEW.csv', status = 'old')
    read(1,*) tmpmaster
    close(1)
    master = matmul(tmpmaster, ones_ndist)
    !exp_dum
    open(1, file = trim(filepath)//'/simulation_data/experience_pre_NEW.csv', status = 'old')
    read(1,*) texp
    close(1)
    exp_dum = transpose(texp)
    exp_dum1 = matmul(exp_dum(:,1:1), ones_ndist)
    exp_dum2 = matmul(exp_dum(:,2:2), ones_ndist)
    exp_dum3 = matmul(exp_dum(:,3:3), ones_ndist)
    exp_dum4 = matmul(exp_dum(:,4:4), ones_ndist)
    exp_dum5 = matmul(exp_dum(:,5:5), ones_ndist)
    exp_dum6 = matmul(exp_dum(:,6:6), ones_ndist)
    !exp_gr (used only in aux model subset offer logic I think)
    do i=1, nteach
       if (exp_dum(i,1) == 1) exp_gr(i,1) = 1
       if (exp_dum(i,2) == 1) exp_gr(i,1) = 2
       if (exp_dum(i,3) == 1) exp_gr(i,1) = 3
       if (exp_dum(i,4) == 1) exp_gr(i,1) = 4
       if (exp_dum(i,5) == 1) exp_gr(i,1) = 5
       if (exp_dum(i,6) == 1) exp_gr(i,1) = 6
    end do
    !exp_con
    open(1, file = trim(filepath)//'/simulation_data/experiencecont_pre_NEW.csv', status = 'old')
    read(1,*) tmpexp_con
    close(1)
    exp_con = matmul(tmpexp_con, ones_ndist)
    !set tenure variable
    tenured = 0
    do i=1, nteach
       ! tenure is defined as > 3 years of exp.
       if (exp_con(i,1) > 3) tenured(i,:) = 1
    end do
    !va
    open(1, file = trim(filepath)//'/simulation_data/contributions_pre_NEW.csv', status = 'old')
    read(1,*) tva
    va = transpose(tva)
    close(1)
    xb1(:,1) = va(:,1)
    xb2(:,1) = va(:,2)
    v1(:,1) = va(:,3)
    v2(:,1) = va(:,4)
    !Note: v1 v2 for exp==1 are mean of the group, set in data, no need to do it here
    !set C1 and C2
    C1 = v1 + xb1
    C2 = v2 + xb2

    C1_median = median(C1(:,1))
    addmin(1) = abs(minval(C1))
    addmin(2) = abs(minval(C2))

    allocate(ones_nteach(nteach,1))
    ones_nteach = 1

    !share_low
    open(1, file = trim(filepath)//'/simulation_data/lambda_pre_NEW.csv', status = 'old')
    read(1,*) share_low_ndist !tmpshare_low
    close(1)
    ! this also occurs in generate_teacher_data, so if that is called alone it still happens (i.e. when nteach changes)
    share_low = matmul(ones_nteach, share_low_ndist)
    !urban
    open(1, file = trim(filepath)//'/simulation_data/urban_pre_NEW.csv', status = 'old')
    read(1,*) urban_ndist !tmpurban
    close(1)
    ! this also occurs in generate_teacher_data, so if that is called alone it still happens (i.e. when nteach changes)
    urban = matmul(ones_nteach, urban_ndist)
    !suburban
    open(1, file = trim(filepath)//'/simulation_data/suburban_pre_NEW.csv', status = 'old')
    read(1,*) suburban_ndist !tmpsuburban
    close(1)
    ! this also occurs in generate_teacher_data, so if that is called alone it still happens (i.e. when nteach changes)
    suburban = matmul(ones_nteach, suburban_ndist)
    !democratic vote share (same as in read_data, not special to pre period)
    open(1, file = trim(filepath)//'/model_data/democratic.csv', status = 'old')
    read(1,*) demshare
    close(1)
    !wage (in validation exercise, wages are fixed at wageschdule, i.e. omega=(1,0)
    !open(1, file = trim(filepath)//'/simulation_data/alpha1.csv', status = 'old')
    !read(1,*) wageomega1(1,:)
    wageomega1 = 1
    !close(1)
    !open(1, file = trim(filepath)//'/simulation_data/alpha2.csv', status = 'old')
    !read(1,*) wageomega2(1,:)
    wageomega2 = 0
    !close(1)
    open(1, file = trim(filepath)//'/simulation_data/wageschedule_pre_NEW.csv', status = 'old')
    read(1,*) twageschedule
    close(1)
    wageschedule = transpose(twageschedule)
    !set up contribution = c1*share_low + c2*(1-share_low)
    contribution = matmul(C1,share_low(1:1,:)) + matmul(C2,(1.0d0 - share_low(1:1,:)))
    ! wage = omega1 * wageschedule + omega2 * contribution
    wage =        matmul(ones_nteach,wageomega1) * wageschedule
    wage = wage + matmul(ones_nteach,wageomega2) * contribution
    !floor and ceiling for wages
    wage = min(wage, wageupper)
    wage = max(wage, wagelower)
    !wage grid
    Wgrid(:,1) = wageomega1(1,:)
    Wgrid(:,2) = wageomega2(1,:)

    deallocate(ones_nteach)

    !set dummy matrix for milwaukee (d=224)
    milwauk = 0
    milwauk(:,224) = 1

    ! comparing to the read_data code:
    ! share por, and lambda rank not being used right now anywhere so don't worry about them


    !read in the distance dataframe
    open(1, file = trim(filepath)//'/simulation_data/lndist_pre.csv', status = 'old')
    read(1,*) tlogdist
    close(1)
    logdist = transpose(tlogdist)
    

    !set the 'dem_abovemed' variable.
    ! 1. sort
    demsorted = demshare
    call qsort(demsorted)
    ! 2. grab the median value
    idx = ndist/2   !integer division rounds
    if (modulo(ndist,2) .ne. 0 ) then !odd
       demmed = demsorted(idx + 1)
    else !even
       demmed = (demsorted(idx) + demsorted(idx+1)) / 2
    end if
    ! 3. create a flag for above or equal to median
    dem_abovemed = 0
    do j=1, ndist
       if (demshare(j) >= demmed) dem_abovemed(j) = 1
    end do


    !set the czten var.  This should be leave-self-out avg of others share tenured in cz
    !    First need to get cz ids, so know which districts are in the same cz.
    open(1, file = trim(filepath)//'/real_data/cz_id.csv', status = 'old')
    read(1,*)
     do j=1,ndist
        read(1,*) tval, cz_id(j)
     end do
    close(1)
    !    second we can calculate
    distten = sum(inc*tenured,1) !/ dble(sum(inc, dim = 1))  ! denom is 'T' but it is not set globally yet
    disttot = sum(inc,1)
    do j=1, ndist
       !for dist j, calculate avg share tenured among others in their cz
       czten(j) = (sum(distten, cz_id == cz_id(j))-distten(j)) / dble((sum(disttot, cz_id == cz_id(j)) - disttot(j)))
       
    end do

    !deallocate nteach vars
    deallocate(twageschedule, tlogdist)
    deallocate(tsamecz, tmatch, tinc)
    deallocate(texp)
    deallocate(tva)
    deallocate(tmpmaster, tmpexp_con)
    deallocate(v1, v2, xb1, xb2)
    deallocate(va)
    
  end subroutine read_data_pre
  

  !calculate median of a vector
  function median(vec) result(med_val)
    use qsort_mod
    double precision, dimension(:) :: vec
    double precision, dimension(size(vec)) :: vec_sorted
    double precision :: med_val
    integer :: len, med_idx, med_idx2

    vec_sorted = vec

    call qsort(vec_sorted)
    len = size(vec_sorted)

    if (modulo(len,2) == 1) then
       med_idx = (len + 1) / 2
       med_val = vec_sorted(med_idx)
    else 
       med_idx = len / 2
       med_idx2 = med_idx + 1
       med_val = (vec_sorted(med_idx) + vec_sorted(med_idx)) / 2
    end if
  end function median


  ! allocate all of our nteach variables
  subroutine allocate_nteach_vars()

    if (mpi_id == 0) print*, '(re)allocating nteach vars, nteach=', nteach

    !wage related, wage wageschedule contribution
    allocate(wage(nteach, ndist), wageschedule(nteach, ndist), contribution(nteach, ndist))

    !characteristics,
    ! match, inc, tenured, entrant, milwauk, samecz, logdist
    ! master, exp_con, C1, C2, exp_dum, exp_dum1-6, exp_gr
    ! age
    allocate(match(nteach, ndist), inc(nteach, ndist), logdist(nteach, ndist))
    allocate(tenured(nteach, ndist), entrant(nteach, ndist), milwauk(nteach, ndist))
    allocate(samecz(nteach, ndist), master(nteach, ndist), exp_con(nteach, ndist))
    allocate(C1(nteach, 1), C2(nteach, 1), exp_dum(nteach, 6), exp_gr(nteach,1))
    allocate(exp_dum1(nteach,ndist), exp_dum2(nteach,ndist), exp_dum3(nteach,ndist))
    allocate(exp_dum4(nteach,ndist), exp_dum5(nteach,ndist), exp_dum6(nteach,ndist))
    allocate(age(nteach))

    allocate(c1_period(nEconomy, nteach), C2_period(nEconomy, nteach))
    allocate(exp_period(nEconomy, nteach), age_period(nEconomy, nteach))
    allocate(master_period(nEconomy, nteach))
    allocate(inc_period(nEconomy,nteach))

    !district that have been expanded, share_low, urban, suburban
    allocate(share_low(nteach,ndist), urban(nteach,ndist), suburban(nteach,ndist))

    ! misc, subsidized, _c1, _c2, wstat, meanW, sdW
    allocate(subsidized(nteach),subsidized_c1(nteach),subsidized_c2(nteach))
    subsidized = 0
    subsidized_c1 = 0
    subsidized_c2 = 0
    allocate(wstat(nteach,ndist), meanW(nteach), sdW(nteach))
    
    
  end subroutine allocate_nteach_vars

  ! deallocate all of our nteach variables
  subroutine deallocate_nteach_vars()

    !wage related, wage wageschedule contribution
    deallocate(wage, wageschedule, contribution)

    !characteristics,
    deallocate(match, inc, logdist, tenured, entrant, milwauk, samecz, master, exp_con)
    deallocate(C1, C2, exp_dum, exp_gr, age)
    deallocate(exp_dum1, exp_dum2, exp_dum3, exp_dum4, exp_dum5, exp_dum6)

    deallocate(c1_period, C2_period)
    deallocate(exp_period, age_period)
    deallocate(master_period)
    deallocate(inc_period)

    !district that have been expanded, share_low, urban, suburban
    deallocate(share_low, urban, suburban)

    ! misc, subsidized, _c1, _c2, wstat, meanw, sdw
    deallocate(subsidized, subsidized_c1, subsidized_c2)
    deallocate(wstat, meanw, sdw)

  end subroutine deallocate_nteach_vars


end module read_data_params



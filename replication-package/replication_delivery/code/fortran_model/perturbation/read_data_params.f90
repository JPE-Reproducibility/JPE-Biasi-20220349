! read_data_params.f90
! created: Oct 2018
!
! Reads in from text files
! 

module read_data_params
  use global_variables
  implicit none

  private

  !subroutines that are public
  public ::  read_instructions, read_model_params, read_auxiliary_params, read_data, read_data_pre, &
       read_theta, read_weight_matrixes

contains
  ! ********** Read Instructions ***********
  !functionality to be expanded as needed
  subroutine read_instructions()
    integer k,j,i
    double precision, dimension(4) :: txtline
    integer, allocatable  :: eqbm_omega2_tmp(:,:)
    double precision, dimension(5) :: rvec_gradient
    
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
    sim_nteach = NcopyT * nteach
    sim_ndist  = NcopyD * ndist
    read(1,*) wagelower
    read(1,*) wageupper
    read(1,*) omega2_restriction
    read(1,*) validation
    read(1,*) cf_match_option
    read(1,*) starting_economy
    read(1,*) rvec_gradient
    read(1,*) s_vec
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
    ! and for SE
    if (purpose == -1) then
       teachOff_decision = 1 
       offer_eqbm = 1
       skip_inner_loop = 1
    end if

    ! check for validity of purpose
    if (teachOff_decision == 0 .and. offer_eqbm == 1) then
       write(*,*) "you can't run offer eqbm purpose when teacher/offer deicison = 0"
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

    
  end subroutine read_instructions

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

    if (purpose == -1) D_sofar = D_sofar + 0.01

    ! update h_tol_min
    h_tol_min = min(h_tol_min, D_sofar)

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
    double precision, dimension(nteach,ndist) :: match_double

    
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
       auxvar(i) = 1/weight_mat(i,i) ! for SE calc
       weight_mat(i,i) = weight_mat(i,i) * aux_weight_factor(i,1)
    end do
    do i=1, naux_omega
       aux_omegavar(i) = 1/omega_weight_mat(i,i) ! for SE calc
       omega_weight_mat(i,i) = omega_weight_mat(i,i) * omega_weight_factor(i,1)
    end do
    do i=1, naux_other
       aux_othervar(i) = 1/other_weight_mat(i,i) ! for SE calc
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
    double precision, dimension(ndist, nteach) :: twageschedule, tlogdist
    integer,          dimension(ndist, nteach) :: tsamecz,tmatch, tinc
    integer,          dimension(6, nteach)     :: texp
    double precision, dimension(4, nteach)     :: tva
    ! also need tmp vars to help turn vectors into matrices
    integer, dimension(nteach,1) :: tmpmaster, tmpexp_con
    double precision, dimension(nteach,1)      :: v1, v2, xb1, xb2
    double precision, dimension(1,ndist)       :: tmpshare_low, tmpurban, tmpsuburban
    ! to help make dem_abovemed
    double precision, dimension(ndist) :: demsorted
    double precision :: demmed
    integer :: idx
    ! help for making czten
    integer,          dimension(ndist) :: cz_id, distten, disttot
    double precision, dimension(ndist) :: shareten

    double precision :: junk, tval
    integer :: i, j
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
    !set new entrants
    entrant = 0
    do i=1, nteach
       if (sum(inc(i,:)) == 0) entrant(i,:) = 1
    end do
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
    open(1, file = trim(filepath)//'/model_data/experiencecont.csv', status = 'old')
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

    C1_median = median(C1(:,1))
    addmin(1) = abs(minval(C1))
    addmin(2) = abs(minval(C2))

    !share_low
    open(1, file = trim(filepath)//'/model_data/lambda.csv', status = 'old')
    read(1,*) tmpshare_low
    close(1)
    share_low = matmul(ones_nteach, tmpshare_low)
    !urban
    open(1, file = trim(filepath)//'/model_data/urban.csv', status = 'old')
    read(1,*) tmpurban
    close(1)
    urban = matmul(ones_nteach, tmpurban)
    !suburban
    open(1, file = trim(filepath)//'/model_data/suburban.csv', status = 'old')
    read(1,*) tmpsuburban
    close(1)
    suburban = matmul(ones_nteach, tmpsuburban)
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


    !set dummy matrix for milwaukee (d=224)
    milwauk = 0
    milwauk(:,224) = 1

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
       
  end subroutine read_data

  ! read in from the validation data
  
  subroutine read_data_pre()
    use qsort_mod
    !read(1,*) goes by columns, so need to create transpose versions of dataframes
    ! there may be a cleaner way to take care of this, but this seems easiest JRS
    double precision, dimension(1,ndist)         :: wageomega1, wageomega2
    double precision, dimension(ndist, nteach) :: twageschedule, tlogdist
    integer,          dimension(ndist, nteach) :: tsamecz,tmatch, tinc
    integer,          dimension(6, nteach)     :: texp
    double precision, dimension(4, nteach)     :: tva
    ! also need tmp vars to help turn vectors into matrices
    integer, dimension(nteach,1) :: tmpmaster, tmpexp_con
    double precision, dimension(nteach,1)      :: v1, v2, xb1, xb2
    double precision, dimension(1,ndist)       :: tmpshare_low, tmpurban, tmpsuburban
    ! to help make dem_abovemed
    double precision, dimension(ndist) :: demsorted
    double precision :: demmed
    integer :: idx
    ! help for making czten
    integer,          dimension(ndist) :: cz_id, distten, disttot
    double precision, dimension(ndist) :: shareten
    double precision :: tval

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

    !share_low
    open(1, file = trim(filepath)//'/simulation_data/lambda_pre_NEW.csv', status = 'old')
    read(1,*) tmpshare_low
    close(1)
    share_low = matmul(ones_nteach, tmpshare_low)
    !urban
    open(1, file = trim(filepath)//'/simulation_data/urban_pre_NEW.csv', status = 'old')
    read(1,*) tmpurban
    close(1)
    urban = matmul(ones_nteach, tmpurban)
    !suburban
    open(1, file = trim(filepath)//'/simulation_data/suburban_pre_NEW.csv', status = 'old')
    read(1,*) tmpsuburban
    close(1)
    suburban = matmul(ones_nteach, tmpsuburban)
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



end module read_data_params



! objective.f90
! created: Dec 2018
!
! Defines objective function for outer loop optimzer
!
! Also will write latest best parameters to txt file
!

module objective
  use global_variables
  implicit none

  private

  public objective_function

contains

  !calc new aux parameters for given param, calc distance (objective fn)
  ! param_in is alpha and sigma
  function objective_function(param0_in) result(L)
    use utility_functions
    use aux_model
    use inner_loop_one
    use write_moments
    use mpi

    use timer

    double precision, dimension(:), intent(in) :: param0_in
    double precision, dimension(nalpha)        :: alpha_in
    double precision, dimension(nbeta)         :: beta_in
    double precision, dimension(ngamma)        :: gamma_in
    double precision                           :: sigma_in, sigmaD_in, L
    double precision, dimension(nparam)        :: param_write
    double precision, dimension(naux,1)        :: aux_beta_model,  aux_d
    double precision, dimension(naux_omega,1)  :: aux_omega_model, aux_omega_d
    double precision, dimension(naux_other,1)      :: aux_other_model,  aux_other_d
    double precision, dimension(nWgrid1,nWgrid2,ndist) :: pr_model_Wgrid
    double precision, dimension(nteach,ndist)          :: pr_model_match
    integer, dimension(ncopyT,nteach,ndist)    :: model_match_copies

    integer,          dimension(nEconomy,nteach,ndist) :: sim_matches

    !for validation purpose
    double precision, dimension(nteach,  ndist) :: match_dbl
    integer, dimension(ncopyT, nteach, ndist)   :: match_copies
    !double precision, dimension(nEconomy,nteach,ndist) :: sim_pr_matches
    !made sim_omegas global so aux model can see these to compute wages
    !double precision, dimension(nEconomy,2,ndist)      :: sim_omegas
    !double precision, dimension(nEconomy,nWgrid1,nWgrid2,ndist) :: sim_pr_omegas

    integer           :: i, j, k, a1, a2
    character(len=20) :: f1, f2

    f1 = '(I8, A3, F30.8)'
    f2 = '(A1, I8, F30.8)'

    nround=nround+1 !track number of function calls

    !tell slave processes to continue running slave inner loop one
    call mpi_bcast(1,1,mpi_int,0,mpi_comm_world,ierr)

    !translate parameters
    ! param0_in is from the solver, then we scale by our custom step size
    ! initial_param never change.
    j=1 !index for subset of included parameters
    k=1 !index for all parameters
    !alphas
    do i = 1, nalpha
       if (incl(k) .eq. 1) then
          alpha_in(i) = param0_in(j)*step(k)*initial_param(k)
          j = j+1
       else
          alpha_in(i) = initial_param(k)
       end if
       !transformations for experience factors' moving costs
      ! if  (i .eq. 6) alpha_in(i) = exp(alpha_in(i)) ! 1st exp group (no moving cost, these are new teachers)
       if ((i .ge. 7) .and. (i .le. 11)) then
          alpha_in(i) = alpha_in(i-1) + exp(alpha_in(i)) !structure for exp
        !alpha_in(i) = exp(alpha_in(i))
       end if
       k = k + 1
    end do
    ! other alpha transformations
    alpha_in(5) = exp(alpha_in(5))   ! c1 * lambda
    alpha_in(12) = exp(alpha_in(12)) ! logdist move cost (is subtracted in util fn)
    alpha_in(13) = exp(alpha_in(13)) ! cz move cost (is subtracted in util fn)
    !betas
    do i = 1, nbeta
       if (incl(k) .eq. 1) then
          beta_in(i) = param0_in(j)*step(k)*initial_param(k)
          j = j+1
       else
          beta_in(i) = initial_param(k)
       end if
       !transformations:
       if ( (i .eq. 1) .or. (i .ge. 7)) then
          beta_in(i) = exp(beta_in(i))
       end if
       if ( (i .ge. 2) .and. (i .le. 6)) then
          beta_in(i) = beta_in(i-1) + exp(beta_in(i)) !structure for exp factors
       end if
       k = k + 1
    end do
    !sigma
    if (incl(k) .eq. 1) then
       sigma_in = param0_in(j)*step(k)*initial_param(k)
       j = j + 1
    else
       sigma_in = initial_param(k)
    end if
    sigma_in = exp(sigma_in) !transformation
    k = k+1
    !gamma
    do i=1, ngamma
       if (incl(k) .eq. 1) then
          gamma_in(i) = param0_in(j)*step(k)*initial_param(k)
          j = j + 1
       else
          gamma_in(i) = initial_param(k)
       end if
       k=k+1
    end do
    !transformations
    !gamma_in(1) = exp(gamma_in(1))
    !gamma_in(2) = exp(gamma_in(2))
   ! gamma_in = exp(gamma_in)
    !sigmaD 
    if (incl(k) .eq. 1) then
       sigmaD_in = param0_in(j)*step(k)*initial_param(k)
       j = j + 1
    else
       sigmaD_in = initial_param(k)
    end if
    sigmaD_in = exp(sigmaD_in) !transformation
    k=k+1

    !if running full outer loop, remaining parameters are beliefs
    if (purpose == 5) then
       theta = param0_in(j:size(param0_in))
    end if

    if(nround==1 .and. (purpose < 10)) then
       write(*,'(A22,A22,A22)') 'teacher decision', 'wage decision', 'offer eqbm'
       write(*,'(I22,I22,I22)') teachOff_decision, wage_decision, offer_eqbm
    endif


    ! Solve district problem at observed wages (also sets global theta)
    
    if (purpose < 10) then
       call run_inner_loop_one(pr_model_match, &
         model_match_copies, pr_model_Wgrid,  &
         alpha_in, beta_in, sigma_in, gamma_in, sigmaD_in)
    else
       !purpose >= 10
       call simulate_equilibrium(alpha_in, beta_in, gamma_in, sigma_in,&
            sigmaD_in,sim_matches,pr_model_match,pr_model_Wgrid)
    end if
    

    ! Calculate our moments
    if (teachOff_decision==1) then! .or. purpose>=10) then
       call calc_aux_parameters(pr_model_match, model_match_copies, aux_beta_model)
       call calc_aux_other_parameters(pr_model_match,aux_other_model)
    else
       aux_beta_model = aux_beta
       aux_other_model = aux_other
    end if
    
    if (wage_decision == 1) then ! .or. purpose>=10) then
       call calc_aux_omega_parameters(pr_model_Wgrid,aux_omega_model)
    else
       aux_omega_model = aux_omega
    end if


    ! If running validation, we need to calculate the data moments as well, as bb doesn't have saves
    !      for these
    if (validation == 1) then
       ! need dbls  to use the aux code
       match_dbl = match
       ! set match copies as well to use the aux code
       do i=1, ncopyT
          match_copies(i,:,:) = match
       end do
       !
       call calc_aux_parameters(match_dbl, match_copies, aux_beta)
       call calc_aux_other_parameters(match_dbl, aux_other)
       ! wages are fixed, so no need for omega parameters
       aux_omega       = 0
       aux_omega_model = 0
    end if

    ! and the distances:
    aux_d = aux_beta_model - aux_beta
    aux_omega_d = aux_omega_model - aux_omega
    aux_other_d = aux_other_model - aux_other

    ! objective value
    !     Note: Because we are currently using diagonal weight mat, each
    !       component is separable and thus we can just add more to L
    L = as_scalar(matmul(matmul(transpose(aux_d),weight_mat),aux_d))!d'Wd
    L = L + as_scalar(matmul(matmul(transpose(aux_omega_d),omega_weight_mat),aux_omega_d))
    L = L + as_scalar(matmul(matmul(transpose(aux_other_d),other_weight_mat),aux_other_d))

    !report aux
    !if (purpose>=10) call write_all_aux_params(aux_beta_model, aux_omega_model, aux_other_model)

    if (outer_loop == 1 .and. purpose < 10) then
       write (*,*) 'distance value for params:'
         !report weight factors (this is constant via input files, but organized into a file here)
        if (nround==1 .and. report_weight_factors == 1) then 
           call write_moment_weight_factors(aux_d,aux_omega_d,aux_other_d)
        end if
      if (L .lt. best_L .or. nround==1) then
          best_L = L
          param_write(1:nalpha)                = alpha_in
          param_write(nalpha+1:nbeta+nalpha)   = beta_in
          param_write(nbeta+nalpha+1)          = sigma_in
          param_write(nbeta+nalpha+2:nparam-1) = gamma_in
          param_write(nparam)                  = sigmaD_in
          call write_best_param(param_write, L, param0_in)
        !report aux
        call write_all_aux_params(aux_beta_model, aux_omega_model, aux_other_model)
!          !tmp write out prob of choosing each omega for each district
!          open(44, file = 'omegas_probs.txt', status='replace')
!          write(44,*)
!          do j=1,NWgrid1
!             write(44, 11) j, sum(pr_model_Wgrid(j,:,:),dim=2)/dble(ndist)
!          end do
!          write(44,*) 
!          do j=1, ndist
!             write(44,11) j, sum(pr_model_Wgrid(1,:,j)), sum(pr_model_Wgrid(2,:,j)), sum(pr_model_Wgrid(3,:,j)), &
!                  sum(pr_model_Wgrid(4,:,j)), sum(pr_model_Wgrid(5,:,j)), sum(pr_model_Wgrid(6,:,j))
!             write(44,11) j, sum(pr_model_Wgrid(:,1,j)), sum(pr_model_Wgrid(:,2,j)), sum(pr_model_Wgrid(:,3,j)), &
!                  sum(pr_model_Wgrid(:,4,j)), sum(pr_model_Wgrid(:,5,j)), sum(pr_model_Wgrid(:,6,j)), sum(pr_model_Wgrid(:,7,j)), &
!                  sum(pr_model_Wgrid(:,8,j))
!          end do
!          close(44)       
!11        format(I4, 8F20.8)

          open(22, file = 'gmmrecord.txt', action='write',position='append')
          write(22,f1) nround-1, '** ', L !write to gmmrecord
          close(22)
          write(*,f2) "*", nround-1, L
!call exit(1)

!!! Update the theta and criterion for good belief in inner loop
          theta_sofar = theta
          if(nround==1) then
             if(skip_first_inner_loop==0) then
                h_tol_min = min(h_tol_min_upper,D_sofar)
                h_tol_min = max(h_tol_min_lower,h_tol_min)
             else
                h_tol_min = D_sofar
             end if
          else
             h_tol_min = min(D_sofar,h_tol_min) !min(h_tol_min_upper,D_sofar) 
             h_tol_min = max(h_tol_min_lower,h_tol_min)
          end if
!!!
       else
          open(22, file = 'gmmrecord.txt', action='write',position='append')
          write(22,f1) nround-1, ' ', L !write to gmmrecord
          close(22)
          write(*,f2) "", nround-1, L
       end if
       !call exit(1)


    else if (purpose == 1) then
       call write_all_aux_params(aux_beta_model, aux_omega_model, aux_other_model)
       ! output omega 2 probs
       open(44, file = 'result/omega2_probs.txt', status='replace')
          write(44,*) "district_id ", "o2_0 ", "o2_10 ",  "o2_30 ", "o2_50 ", "o2_75 ", "o2_100 ", "o2_200 ", "o2_225 "
          do j=1, ndist
             write(44,11) j, sum(pr_model_Wgrid(:,1,j)), sum(pr_model_Wgrid(:,2,j)), sum(pr_model_Wgrid(:,3,j)), &
                  sum(pr_model_Wgrid(:,4,j)), sum(pr_model_Wgrid(:,5,j)), sum(pr_model_Wgrid(:,6,j)), sum(pr_model_Wgrid(:,7,j)), &
                  sum(pr_model_Wgrid(:,8,j))
          end do
          close(44)       
11        format(I4, 8F20.8)
    ! purpose 7, aka rigid pay, doesn't need any of this, it outputs 'eqbm' files specially coded in inner loop
    !else if (purpose == 7) then
       !call write_all_aux_params(aux_beta_model, aux_omega_model, aux_other_model)
       !call write_latest_theta()
    else if (offer_eqbm == 1) then 
       call write_latest_theta()
    end if
    
       
       
  end function objective_function


 
  !helper function to change 1x1 array type into scalar
  function as_scalar(inmat) result(scalar)
    double precision, dimension(*), intent(in) :: inmat
    double precision :: scalar
    scalar = inmat(1)
  end function as_scalar


end module objective

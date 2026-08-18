! main.f90
! created: Oct 2018
!
! Main run file for estimation
!  also contains calc_wstat
!
program main
  ! subprogram modules
  use global_variables     
  use read_data_params   !read from txt files
  use inner_loop_one
  use aux_model
  use utility_functions
  use objective
  ! helper modules
  !use simplex
  use simplex_salvador
  use mpi
  use random

  use timer

  implicit none

  integer :: i, j, k, a1, a2, slave_flag
  double precision :: tval  !param0 is structural parameters, _big adds in the belief params
  double precision, allocatable, dimension(:) :: param0, param0_big
  ! standard err variables
  integer :: jj, nauxparams, ridx, ntparam, ndparam, sigmaind
  double precision :: r_se, perturb_min
  double precision, allocatable, dimension(:) :: initial_param_se, param_se, perturbation
  !double precision, allocatable, dimension(:,:) :: W_se, G_se, parammat, auxmat, bigOmega, outer, inner, var, semat
  double precision, allocatable, dimension(:,:) :: parammat, auxmat
  !double precision, allocatable, dimension(:,:) :: Gt_se, outert, innert, vart, sematt
  !double precision, allocatable, dimension(:,:) :: Gd_se, outerd, innerd, vard, sematd
  !double precision, allocatable, dimension(:,:) :: G2_se, outer2, inner2, var2, semat2


  !use if we want to time anything for benchmarking
  call initialize_timer()

  ! Set up MPI
  call mpi_init(ierr)
  call mpi_comm_size(mpi_comm_world, ntasks, ierr) !get number of tasks
  call mpi_comm_rank(mpi_comm_world, mpi_id, ierr) !get id of each task
  write(*,*) 'process ', mpi_id+1, 'of ', ntasks, 'is alive,', ' mpi_id:',mpi_id

  call mpi_barrier(mpi_comm_world, ierr)

  call read_instructions()

  ! read the teacher/district data, needed in all threads so just reading in instead of mpi
  if (validation == 0) then
     call read_data() 
  else
     !validation == 1
     call read_data_pre()
  end if

  !compute the wage statistic for each teacher (i.d. x,v pair)
  call calc_wstat()

  !set seeds
  call set_seed(1,2,3,4)

  !draw shocks
  if (purpose >= 10) then
     ! tshock and dshock, nEconomy
     allocate(dshock(nEconomy,ndist,NWgrid1,NWgrid2))
     allocate(tshock(nEconomy,nteach,ndist))
     do k=1, nEconomy
        !dshock
        do j=1, ndist
           do a1=1,NWgrid1
              do a2=1,NWgrid2
                 dshock(k,j,a1,a2) = Sample_EV1()
              end do
           end do
        end do
        !tshock
        do j=1, ndist
           do i=1, nteach
              tshock(k,i,j) = Sample_EV1()
           enddo
        end do
     end do
     !allocate global sim_omega
     allocate(sim_omegas(nEconomy,2,ndist))
  else
     !tshock only, ncopyt
     allocate(tshock(nCopyT,nteach,ndist))
     do j=1, ndist
        do i=1, nteach
           do k=1, nCopyT
              tshock(k,i,j) = Sample_EV1()
           enddo
        end do
     enddo
  end if

  if (mpi_id == 0) then

     !set budget and capacity constraint vectors
     B(1,:) = sum(match * wage, dim = 1)
     T(1,:) = sum(match, dim = 1)

     !read in data from txt files
     call read_theta() !read in beliefs
     call read_auxiliary_params()
     call read_model_params(param0)
     call read_weight_matrixes()
     

     if (purpose == 5) then
        ! estimate, but outer loop has stuct AND belief param
        allocate(param0_big(size(param0) + ntheta))
        param0_big(1:size(param0)) = param0
        param0_big(size(param0)+1:size(param0) + ntheta) = theta

        ! run outer loop - search over parameters
        ! (x,ftol,func,print,itmax,dtol,simplex_length)
        nround = 0 !keep track of number of function calls
        open(22,file='gmmrecord.txt',status='replace')
        close(22)
        !call Nelder_Mead(param0_big, outer_tol_pct, objective_function, 0, maxiter, outer_tol_dif, simplex_length)
        call nelder_meade(param0_big,outer_tol_pct,objective_function,0,maxiter,simplex_length)

        param0 = param0_big(1:size(param0))
        theta  = param0_big(size(param0)+1:size(param0_big)) 

        write(*,*) 'finished outer loop'

     else if (purpose==2 .or. purpose==4) then
        !running outer loop
        ! (x,ftol,func,print,itmax,dtol,simplex_length)
        nround = 0 !keep track of number of function calls
        open(22,file='gmmrecord.txt',status='replace')
        close(22)
        !call Nelder_Mead(param0, outer_tol_pct, objective_function, 1, maxiter, outer_tol_dif, simplex_length)
        call nelder_meade(param0,outer_tol_pct,objective_function,0,maxiter,simplex_length)

     else if (purpose == -2) then !calculating perturbation
        ! need to loop over all parameters and save betas, then we can compute numerical derivatives
        !    take care also to adjust the transformed params

        print*, 'running perturbation exercise for appendix'

        allocate(initial_param_se(nparam), param_se(nparam), perturbation(nparam))
        allocate(parammat(nparam,sum(incl)+1))
        allocate(auxmat(naux+naux_omega+naux_other,sum(incl)+1))

        !get vector of ``paper'' model params, i.e. the ones we will perturb
        initial_param_se = initial_param
        !alpha params 
        initial_param_se(5)  = exp(initial_param_se(5))  !c1 * lambda
        initial_param_se(12) = exp(initial_param_se(12)) !logdist move cost
        initial_param_se(13) = exp(initial_param_se(13)) !cz move cost
        !  (experience params for moving costs stack and are exp)
        initial_param_se(6) = 0 !first exp factor is omitted (entrants)
        do i=7,11
           initial_param_se(i) = exp(initial_param_se(i)) + initial_param_se(i-1)
        end do
        !beta params
        initial_param_se(nalpha+7) = exp(initial_param_se(nalpha+7)) !c1 * lambda      
        initial_param_se(nalpha+8) = exp(initial_param_se(nalpha+8)) !master           
        !  (beta exp params stack)
        initial_param_se(nalpha+1) = 0 !first exp factor is omitted (entrants)
        do i=nalpha+2,nalpha+6 !beta 2 through 7
           initial_param_se(i) = exp(initial_param_se(i)) + initial_param_se(i-1)
        end do
        !sigma and sigmaD
        initial_param_se(nalpha+nbeta+1) = exp(initial_param_se(nalpha+nbeta+1))
        initial_param_se(nalpha+nbeta+1+ngamma+1) = exp(initial_param_se(nalpha+nbeta+1+ngamma+1))

        !first call to double check baseline and so we know beta_hat(theta)
        !  (note initial_param has params, param0 right now just takes out scaling)
        ! (note this is important to run first, because we skip
        !   first inner loop iteration so we maintain same belief params as well)
        initial_param = initial_param_se
        tval = objective_function(param0)
        auxmat(1:naux,1:1) = aux_beta_model
        auxmat(naux+1:naux+naux_omega,1:1) = aux_omega_model
        auxmat(naux+naux_omega+1:naux+naux_omega+naux_other,1:1) = aux_other_model


        parammat(:,1) = initial_param_se
        !parammat(:,1) = initial_param

        !set up perturbation amounts as SEs calculated in paper
        perturbation(1)  = 3.358  !urban
        perturbation(2)  = 2.132  !suburban
        perturbation(3)  = 8.312  !milwauk
        perturbation(4)  = 1.375  !exp(lamb)
        perturbation(5)  = 26.342 !c1 * lamb
        perturbation(6)  = 0      !param doesn't exist, omitted category
        perturbation(7 ) = 6.688  !d0 exp2
        perturbation(8 ) = 22.030 !d0 exp3
        perturbation(9 ) = 6.325  !d0 exp4
        perturbation(10) = 41.100 !d0 exp5
        perturbation(11) = 50.255 !d0 exp6
        perturbation(12) = 5.237  !d0 logdist
        perturbation(13) = 22.863 !same cz
        perturbation(14) = 0      !param doesn't exist, omitted category
        perturbation(15) = 0.106  !exp2
        perturbation(16) = 0.021  !exp3
        perturbation(17) = 0.376  !exp4
        perturbation(18) = 0.024  !exp5
        perturbation(19) = 0.034  !exp6
        perturbation(20) = 0.016  !(1-lamb) * c2
        perturbation(21) = 0.029  !master
        perturbation(22) = 0.944  !sigma
        perturbation(23) = 0.195  !fixed cost
        perturbation(24) = 0.448  !dem share
        perturbation(25) = 0.127  !abs(o1 - 1)
        perturbation(26) = 0.297  !dem * abs(o1 - 1)
        perturbation(27) = 0.101  !o2 / 100
        perturbation(28) = 0.341  !dem * o2/100
        perturbation(29) = 0.027  !sigmaD

        ! First column of output is our paramater values for easy reference to gauge significance
        !j=1
        !do i=1, nparam
        !   if (incl(i) == 1) then
        !      semat(j,1) = initial_param_se(i)
        !      j = j+1
        !   end if
        !end do

        !no master subset
        !semat2(1:14,1) = semat(1:14,1)
        !semat2(15:19,1) = semat(16:20,1)

        !district and teacher subsets
        !sematt(1:ntparam-1,1) = semat(1:ntparam-1,1)
        !sematt(ntparam,1) = semat(sigmaind,1)

        !sematd(1:(sigmaind-ntparam),1) = semat(ntparam:(sigmaind-1),1)
        !sematd((sigmaind-ntparam+1):ndparam,1) = semat(sigmaind+1:sum(incl),1)

        print*, 'initial param se', initial_param_se
        
        !loop over main params
        k=1
        do i=1, nparam
           if( incl(i) .eq. 1) then
              param_se = initial_param_se
              !perturb
              print*, 'param perturbation'
              if ((r_se > 0 .and. i == 10) .or. (r_se < 0 .and. i == 11)) then
                 !exp5 and exp6 parameters are close together for alphas, so we always need
                 !   to negative perturb 5 and positive perturb 6
                 !   param_se(i) = param_se(i) - sign(max(abs(param_se(i) * r_se), perturb_min), r_se)
                 param_se(i) = param_se(i) - perturbation(i)
              else
                 !param_se(i) = param_se(i) + sign(max(abs(param_se(i) * r_se), perturb_min), r_se)
                 param_se(i) = param_se(i) + perturbation(i)                
              end if
              !respect bounds for exp parameters in district utility
              if (r_se > 0 .and. (i >= nalpha+1 .and. i <= nalpha+5)) then
                 !if (param_se(i) > param_se(i+1)) param_se(i) = (initial_param_se(i+1)+initial_param_se(i))*0.5
                 if (param_se(i) > param_se(i+1)) param_se(i) = (initial_param_se(i+1))*0.99 
              end if
              !if (i==nalpha+8 .and. param_se(i)<0) param_se(i)=initial_param_se(i)*0.5

              ! negative perturbation instead of positive
              ! param_se(i) = param_se(i) - max(abs(param_se(i) * r_se), perturb_min)
              !if (i >= nalpha+2 .and. i <= nalpha+6) then
              !   if (param_se(i) <= param_se(i-1)) param_se(i) = param_se(i-1) + 0.000001
              !end if

              !start by checking/checking "model" param, (i.e. nontransform)
              parammat(:,k+1) = param_se

              !transform... some of this redundant but easier to code together
              !alpha params
!              param_se(5) = log(param_se(5))
!              param_se(12) = log(param_se(12))
!              param_se(13) = log(param_se(13))
              !   and the exp for moving cost
!              do j = 11, 7, -1
!                 param_se(j) = log(param_se(j) - param_se(j-1))
!              end do
              param_se(6)  = 0 !redundant, but restating entrants are omitted
              !beta params
!              param_se(nalpha+7) = log(param_se(nalpha+7)) !c1 * lambda
!              param_se(nalpha+8) = log(param_se(nalpha+8)) !master           
              !  (beta exp params stack)
!              do j=nalpha+6,nalpha+2,-1
!                 param_se(j) = log(param_se(j) - param_se(j-1))
!              end do
              param_se(nalpha+1) = 0 !redundant, but restating entrants are omitted
              !sigma and sigmaD
!              param_se(nalpha+nbeta+1)        = log(param_se(nalpha+nbeta+1))
!              param_se(nalpha+nbeta+1+ngamma+1) = log(param_se(nalpha+nbeta+1+ngamma+1))

              ! And weirdness we have to do b/c.... avoid nan and how params reconstructed
!              if (param_se(nalpha+1) == 0) param_se(nalpha+1) = -50.175662699999997

              !temp save what transformed params we're running for a bug check
              !parammat(:,k+1) = param_se
              
              !find aux values
              initial_param = param_se
              tval = objective_function(param0)
              !save aux params in our matrix
              auxmat(1:naux,k+1:k+1) = aux_beta_model
              auxmat(naux+1:naux+naux_omega,k+1:k+1) = aux_omega_model
              auxmat(naux+naux_omega+1:naux+naux_omega+naux_other,k+1:k+1) = aux_other_model

              !save matrix of param values for bug checking
              !parammat(:,k+1) = initial_param_se
              k = k + 1
           end if

        end do

        ! For the first perturbation, some output to double check stuff is working
        !if (ridx == 1) then
           !save parammat to check perturbations
           open(1, file='result/perturb_param.txt', status = 'replace')
           do i=1, nparam
              write(1,*) (parammat(i,j),j=1,sum(incl)+1)
           end do
           close(1)
           ! save resulting aux model values perturbations, only for those that get weight
           open(1, file='result/perturb_aux.txt', status = 'replace')
           do i=1, naux
              if (weight_mat(i,i) > 0) write(1,*) (auxmat(i,k),k=1,sum(incl)+1)
           end do
           do i=1, naux_omega
              if (omega_weight_mat(i,i) > 0) write(1,*) (auxmat(i + naux,k),k=1,sum(incl)+1)
           end do
           do i=1, naux_other
              if (other_weight_mat(i,i) > 0) write(1,*) (auxmat(i + naux + naux_omega,k),k=1,sum(incl)+1)
           end do
           close(1)
           ! save aux model values perturbations for every moment, regardless of if get weight
           open(1, file='result/perturb_aux_full.txt', status = 'replace')
           do i=1, naux+naux_omega+naux_other
              write(1,*) (auxmat(i,j),j=1,sum(incl)+1)
           end do
           close(1)
        !end if

        ! save weight mat in easy to read format
        open(1, file='result/weight_mat.txt', status = 'replace')
        do i=1, naux
           write(1,*) weight_mat(i,i)
        end do
        do i=1, naux_omega
           write(1,*) omega_weight_mat(i,i)
        end do
        do i=1, naux_other
           write(1,*) other_weight_mat(i,i)
        end do
        
        

        deallocate(initial_param_se, param_se)

     else
        !no outer loop, run obj once
        tval = objective_function(param0)
     end if

     !once code is finished, need to tell slave processes to quit running
     call mpi_bcast(0,1,mpi_int,0,mpi_comm_world,ierr)


     deallocate(param0)
  end if


  !if slave processe, then help solve dist problem in inner loop until told to stop
  if(mpi_id .ne. 0) then
     do
        call mpi_bcast(slave_flag,1,mpi_int,0,mpi_comm_world,ierr)
        if (slave_flag==0) exit
        call run_slave_inner_loop_one()
     end do
  end if

  if (mpi_id .eq. 0) then
     deallocate(tshock)
     if (purpose >= 10) then
        deallocate(dshock)
        deallocate(sim_omegas)
     end if
  end if
  deallocate(eqbm_omega2)

  if (mpi_id == 0) then
     print*, "--------------"
     print*, "END OF PROGRAM"
  end if

  !close out mpi
  call mpi_finalize(ierr)


contains

  ! calculate wage statistic, used to help with district beliefs on teach acceptance
  subroutine calc_wstat()
    implicit none
    double precision, dimension(nteach,ndist) :: mean_wage, sd_wage
    double precision, dimension(nteach) :: var_wage

    mean_wage = 0d0
    sd_wage   = 0d0
    var_wage  = 0d0
    
    do j=1, ndist !calc mean for each teacher
       do i=1, nteach
          mean_wage(i,1) = mean_wage(i,1) + wage(i,j) / ndist
       enddo
    enddo
    do j=2, ndist !apply mean wage across all districts
       do i=1, nteach
          mean_wage(i,j) = mean_wage(i,1)
       enddo
    enddo
    do j=1, ndist !calc variance for each teacher
       do i=1, nteach
          var_wage(i) = var_wage(i) + (wage(i,j) - mean_wage(i,1))**2 * 1/(ndist-1)
       enddo
    enddo
    do j=1, ndist !take sd and apply sd across all districts
       do i=1, nteach
          sd_wage(i,j) = sqrt(var_wage(i))
       enddo
    enddo

    !global variables
    wstat = (wage - mean_wage) / sd_wage
    meanW = mean_wage(:,1)
    sdW   = sd_wage(:,1)

  end subroutine calc_wstat


end program main

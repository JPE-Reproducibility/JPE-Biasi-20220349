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
  double precision :: tval
  !param0 is structural parameters, _big adds in the belief params
  double precision, allocatable, dimension(:) :: param0, param0_big
  !cz lookup
  !integer, dimension(ndist) :: cz_id

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

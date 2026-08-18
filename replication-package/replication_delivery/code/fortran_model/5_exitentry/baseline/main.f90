! main.f90
! created: Oct 2018
!
! Main run file for estimation
!  also contains calc_wstat, and set_up_H_design_matrix
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

  integer :: i, j, k, l, m, a1, a2, slave_flag
  double precision :: tval, wt_cumsum
  double precision, allocatable, dimension(:) :: tval_nEntrant !prob_exit, 
  !param0 is structural parameters, _big adds in the belief params
  double precision, allocatable, dimension(:) :: param0, param0_big
  !cz lookup
  !integer, dimension(ndist) :: cz_id

  ! temp vars to help with forward iteration:
  double precision, allocatable, dimension(:,:)   :: C1_prev, C2_prev
  integer,          allocatable, dimension(:,:)   :: exp_prev, age_prev, master_prev, inc_prev
  !integer,          allocatable, dimension(:,:) :: inc_temp
  integer :: nteach_prev
  ! entry/exit
  integer,          allocatable, dimension(:) :: t_exit, t_entry
  double precision, allocatable, dimension(:) ::  wage_baseline_entrant! prob_entry,
  double precision, allocatable, dimension(:,:) :: wage_baseline_entrant_tmp, prob_entry, prob_exit
  double precision, allocatable, dimension(:,:,:) :: omega_baseline

  double precision, allocatable, dimension(:,:) :: ones_nteach, ones_nEntrant

  double precision, allocatable, dimension(:) :: baseline_wage_tmp, wage_tmp, wage_entrant_tmp
  !double precision, allocatable, dimension(:,:) :: baseline_wage_tmp, wage_tmp, wage_entrant_tmp
  double precision, allocatable, dimension(:,:) :: wage_tmp_tmp, wage_entrant_tmp_tmp
  double precision, allocatable, dimension(:) :: wage_change, wage_change_entrant

  double precision :: C1_exit, C2_exit, exp_exit, age_exit, master_exit
  double precision :: C1_entry, C2_entry, exp_entry, age_entry, master_entry

  integer :: target_entry, target_exit

  !double precision, dimension(ndist) :: r_vec_tmp
  !double precision, dimension(2)     :: s_vec_tmp

  !use if we want to time anything for benchmarking
  call initialize_timer()

  ! Set up MPI
  call mpi_init(ierr)
  call mpi_comm_size(mpi_comm_world, ntasks, ierr) !get number of tasks
  call mpi_comm_rank(mpi_comm_world, mpi_id, ierr) !get id of each task
  write(*,*) 'process ', mpi_id+1, 'of ', ntasks, 'is alive,', ' mpi_id:',mpi_id

  call mpi_barrier(mpi_comm_world, ierr)

  call read_instructions()

  ! Before reading data we need to allocate stuffs
  nteach = 6600
  call allocate_nteach_vars()

  ! read the teacher/district data, needed in all threads so just reading in instead of mpi
  if (validation == 0) then
     call read_data()
     t_period = 1 !need to set this for the logic to work for r_vec bonus stuff
     call generate_teacher_data()
  else
     !validation == 1
     call read_data_pre()
     call generate_teacher_data()
  end if



  !compute the wage statistic for each teacher (i.d. x,v pair)
  call calc_wstat()

  !set seeds
  call set_seed(1,2,3,4)


  ! let's pause and double check that predicted prob exit worked correctly:
  !if (mpi_id == 0) then
  !   allocate(prob_exit(nteach))
  !   call generate_prob_exit(prob_exit, age(:), exp_con(:,1), master(:,1), C1(:,1), C2(:,1))  
  !   open(1, file = 'check_exit_probs', status='replace')
  !   write(1,*) 'i', 'prob_exit', 'age', 'exp_con', 'master', 'c1', 'c2'
  !   do i=1, nteach
  !      if (entrant(i,1) == 0) then
  !         write(1,*) i, prob_exit(i), age(i), exp_con(i,1), master(i,1), C1(i,1), C2(i,1)
  !      end if
  !   end do
  !   call exit(1)
  !   deallocate(prob_exit)
  !end if
  !call mpi_barrier(mpi_comm_world, ierr)


  !allocations we need
  if (purpose >= 10) then
     ! allocate shock variables
     allocate(dshock(nEconomy,ndist,NWgrid1,NWgrid2))
     allocate(tshock(nEconomy,nteach,ndist))
     !allocate global sim_omega
     allocate(sim_omegas(nEconomy,2,ndist))
  else
     ! tshock only
     allocate(tshock(nCopyT,nteach,ndist))
  end if

  ! these are all same across all time periods?
  if (mpi_id == 0) then
     !set budget and capacity constraint vectors
     B(1,:) = sum(match * wage, dim = 1)
     T(1,:) = sum(match, dim = 1)

     !read in data from txt files
     call read_theta() !read in beliefs
     call read_auxiliary_params()
     call read_model_params(param0)
     call read_weight_matrixes()


     !draw shocks
     if (purpose >= 10) then
        ! tshock and dshock, nEconomy
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
     else
        !tshock only, ncopyt
        do j=1, ndist
           do i=1, nteach
              do k=1, nCopyT
                 tshock(k,i,j) = Sample_EV1()
              enddo
           end do
        enddo
     end if


  end if ! mpi_id==0

  ! for (t in T)
  ! 1) draw shocks
  ! 2) set teacher pool
  !    - exp
  !    - c1/c2
  !    - d0
  ! 3)


  ! start a file where we can save average stats of entrants and exits
  if (mpi_id == 0) then
     open(1, file = 'result/entryexit_stats.txt', status = 'replace')
     write(1,*) ' t_period', ' economy_id', ' type', ' n', ' c1', ' c2', ' exp', ' age', ' master'
     close(1)
  end if

  ! ----- forward iteration
  !   (if don't want forward iter, T_max is just set to 1, so it runs one period)
  !      Outline:
  !      1. For t+1:
  !         a) move forward all variables (exp_con, age, C1, C2)
  !         b) generate exit probs
  !            - adjust prob based on wage eqbm from last period
  !         c) draw entrants (adjust wage prob)
  !         d) reset values for entrants and exits
  !         e) generate all the new teacher variables based on our new population
  !         f) draw new tshock for all teachers
  !      2. For t=1, if doing iteration: allocate a couple vars we will need
  !      3. Run objective function
  !      4. If t=1, save baseline wages, so can calc change in future periods
  do t_period=1, T_max

     ! If first period, we need to set the 'period' vars, so when they are used in t+1 they work ok
     !   (we start off identical across economies)
     if (t_period == 1) then
        do k=1, nEconomy
           c1_period(k,:)     = C1(:,1)
           c2_period(k,:)     = C2(:,1)
           exp_period(k,:)    = exp_con(:,1)
           age_period(k,:)    = age
           master_period(k,:) = master(:,1)
        end do
     end if

     ! If after first period we have to move things forward and draw entrants/exits
     ! Set up t_period specific state variables, for t > 1
     if (t_period > 1) then

        ! Now the subsidies will kick in as well
        if (purpose >10) call set_rvec()

        ! First, we need to share the incumbent variable with all of the threads, this was only saved in master
        !     at end of last iter:
        call mpi_bcast(inc_period, nEconomy*nteach, mpi_int, 0, mpi_comm_world, ierr)

        if (mpi_id == 0) print*, 'moving population forward, period:', t_period, 'of, ', T_max

        ! First, lets move forward all of our variables:

        ! experience and age   (note, exp dummies are updated when generate_teacher_data is called
        !exp_period = exp_period + 1
        !age_period = age_period + 1

        ! (need to the rest of this economy by economy now:

        if (mpi_id == 0) then
           allocate(prob_entry(nEntrant, nEconomy))
           allocate(prob_exit(nteach, nEconomy))
        end if


        do k=1, nEconomy

           ! adjust c1/c2, only needs to happen if changing experience group
           !do i=1, nteach
           !   if (exp_period(k,i) == 2) then
           !      ! entered exp2, left entrant group
           !      C1_period(k,i) = C1_period(k,i) + 0.0068
           !      C2_period(k,i) = C2_period(k,i) + 0.0009
           !   else if (exp_period(k,i) == 4) then
           !      ! entered exp3, left exp2
           !      C1_period(k,i) = C1_period(k,i) + 0.0154 - 0.0068
           !      C2_period(k,i) = C2_period(k,i) + 0.0057 - 0.0009
           !   else if (exp_period(k,i) == 6) then
           !      ! entered exp4, left exp3
           !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0154
           !      C2_period(k,i) = C2_period(k,i) + 0.0028 - 0.0057
           !   else if (exp_period(k,i) == 11) then
           !      ! entered exp5 left exp4
           !      C1_period(k,i) = C1_period(k,i) + 0.0117 - 0.0117
           !      C2_period(k,i) = C2_period(k,i) + 0.0049 - 0.0028
           !   else if (exp_period(k,i) == 16) then
           !      ! entered exp6, left exp5
           !      C1_period(k,i) = C1_period(k,i) + 0.0112 - 0.0117
           !      C2_period(k,i) = C2_period(k,i) + 0.0038 - 0.0049
           !   end if
           !end do ! i, nteach

           ! If doing the wage adjustment, will need to generate the exp dummies and wageschedule,
           !   in which case that code relies on these variables being saved
           C1(:,1)      = c1_period(k,:)    
           C2(:,1)      = c2_period(k,:)    
           exp_con(:,1) = exp_period(k,:)   
           age          = age_period(k,:)   
           master(:,1)  = master_period(k,:)

           ! Need to calc wageschedule here, as some have moved up the schedule when they change exp grp
           !need these to calc prob exit, and exp also used to calculate wagesched
           call generate_exp_variables()
           !need these to do the wage eqbm updating
           !  (altho this requires share_low, share_low isn't affected by changing c1/c2)
           call generate_wagesched_contrib()

           ! First, we draw exits (from our logit prediction, prob_exit)
           !   so we need to draw random numbers to determine if someone is an exit.
           !    Draw on (0,1), and if the R.V. is less than prob_exit, then they exit.

           ! generate the exit and entry prob for teachers in this economy, only gen from master and then share

           if (mpi_id == 0) then

              ! First, draw exits ---------------------------------
              !allocate(prob_exit(nteach))
              !call generate_prob_exit(prob_exit(:,k), age(:), exp_con(:,1), master(:,1), C1(:,1), C2(:,1))
              call generate_prob_exit(prob_exit(:,k), age_period(k,:), exp_period(k,:), master_period(k,:),&
                   C1_period(k,:), C2_period(k,:))

              ! Now we adjust prob exit based on wage elasticity !

              ! Now that we do economy-by-economy the change due to the wage eqbm change may want to be
              !     economy specific... In any case it is so small lets not worry about the wage adjustment for now
              allocate(wage_change(nteach))
              allocate(baseline_wage_tmp(nteach))!,nEconomy))
              allocate(wage_tmp(nteach))!, nEconomy))
              allocate(wage_tmp_tmp(nteach, ndist))
              allocate(ones_nteach(nteach, 1))
              ones_nteach = 1
              !if i reinstate this, have to make it a different variable than k
              !do k2=1, nEconomy
              !   ! "baseline" wages
              !   baseline_wage_tmp(:,k) = sum(matmul(ones_nteach, omega_baseline(k,1:1,:)) * wageschedule, 2) / ndist + &
              !        sum(matmul(ones_nteach, omega_baseline(k,2:2,:)) * contribution, 2) / ndist
              !   ! last period wages
              !   ! First grab them so can add subsidy
              !   wage_tmp_tmp = matmul(ones_nteach, sim_omegas(k,1:1,:)) * wageschedule + &
              !        matmul(ones_nteach,sim_omegas(k,2:2,:)) * contribution
              !   ! Now add in the subsidy! (if any) note it does not apply to baseline
              !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
              !   call add_subsidy_to_wage(wage_tmp_tmp, sim_omegas(k,2,:))
              !   wage_tmp(:,k) = sum(wage_tmp_tmp,2) / ndist
              !   !wage_tmp(:,k) = sum(matmul(ones_nteach, sim_omegas(k,1:1,:)) * wageschedule, 2) / ndist + &
              !   !     sum(matmul(ones_nteach,sim_omegas(k,2:2,:)) * contribution, 2) / ndist
              !end do
              !deallocate(ones_nteach, wage_tmp_tmp)

              print*, 'before calc wage change'

              !
              wage_tmp_tmp = matmul(ones_nteach, omega_baseline(k,1:1,:)) * wageschedule + &
                   matmul(ones_nteach, omega_baseline(k,2:2,:)) * contribution
              !we care abt avg across dists
              baseline_wage_tmp = sum(wage_tmp_tmp,2) / ndist

              !now add subsidy
              call add_subsidy_to_wage(wage_tmp_tmp, sim_omegas(k,2,:))
              ! and save avg across dists
              wage_tmp = sum(wage_tmp_tmp,2) / ndist
              
              !baseline_wage_tmp = sum(matmul(ones_nteach, omega_baseline(k,1:1,:)) * wageschedule, 2) / ndist + &
              !     sum(matmul(ones_nteach, omega_baseline(k,2:2,:)) * contribution, 2) / ndist
              !wage_tmp = baseline_wage_tmp !here is where I would set it to cf wage for 1 economy
              !call add_subsidy_to_wage(wage_tmp, sim_omegas(k,2,:))

              deallocate(ones_nteach)

              !change in avg wage across economies
              ! pct change
              !wage_change = ((sum(wage_tmp,2)/nEconomy) / (sum(baseline_wage_tmp,2)/nEconomy)) - 1
              !instead we are just 1 economy
              wage_change = wage_tmp / baseline_wage_tmp - 1
              !print*, wage_tmp(1,1), sum(wage_tmp)
              !print*, baseline_wage_tmp(1,1), sum(baseline_wage_tmp)
              !print*, sum(wage_tmp(1,:))
              !print*, sum(baseline_wage_tmp(1,:))

              ! Second, adjust exit prob b/c of wage_change
              if (k==1) then
                 print*, 'lets check here if the wage change makes sense in terms of magnitude'
                 print*, 'wage change 1 teacher', wage_change(1), 'avg % wage change', sum(wage_change)/nteach, &
                      'avg wage change', sum(wage_tmp - baseline_wage_tmp)/(nteach), &!*nEconomy), &
                      'wage elas:', wage_elas
              end if

              deallocate(baseline_wage_tmp, wage_tmp, wage_tmp_tmp)

              ! Restrict that those in age group 4 or higher aren't affected by subsidy (wage elasticity)
              do i=1, nteach
                 if (age(i) >= 55) wage_change(i) = 0 
              end do

              !           call exit(1)
              !print*, 'prob_exit check:', prob_exit(1), sum(prob_exit), maxval(prob_exit), minval(prob_exit)
              prob_exit(:,k) = prob_exit(:,k) * (1 - wage_change * wage_elas)
              prob_exit(:,k) = max(min(prob_exit(:,k),1d0), 0d0)
              deallocate(wage_change)


              !exit draws moved to below

              ! Second, draw entrants ---------------------------------
              !allocate(prob_entry(nentrant))

              ! Update the entrant prob.... based on wages
              !First,  calc change in wage relative to baseline, for each economy
              allocate(wage_entrant_tmp(nEntrant))!, nEconomy))
              allocate(wage_entrant_tmp_tmp(nEntrant, ndist))
              allocate(ones_nEntrant(nEntrant,1))
              ones_nEntrant = 1
              !if redoing this, will need to change loop variable
              !do k2=1, nEconomy
              !   ! First grab last period wages so can add subsidy
              !   wage_entrant_tmp_tmp = matmul(ones_nEntrant, sim_omegas(k,1:1,:)) * wageschedule_entrant + &
              !        matmul(ones_nEntrant,sim_omegas(k,2:2,:)) * contribution_entrant
              !   ! Now add in the subsidy! (if any) note it does not apply to baseline
              !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
              !   call add_subsidy_to_wage_entrant(wage_entrant_tmp_tmp, sim_omegas(k,2,:))
              !   ! avg across districts
              !   wage_entrant_tmp(:,k) = sum(wage_entrant_tmp_tmp,2) / ndist
              !   !wage_entrant_tmp(:,k) = sum(matmul(ones_nEntrant, sim_omegas(k,1:1,:)) * wageschedule_entrant, 2) / ndist + &
              !   !     sum(matmul(ones_nEntrant,sim_omegas(k,2:2,:)) * contribution_entrant, 2) / ndist
              !end do

              ! changing this concept to be economy-by-economy so need to calc here instead of using saved value

              wage_entrant_tmp_tmp = matmul(ones_nEntrant, omega_baseline(k,1:1,:)) * wageschedule_entrant + &
                   matmul(ones_nEntrant,omega_baseline(k,2:2,:)) * contribution_entrant
              ! we want to take avg as baseline
              wage_baseline_entrant = sum(wage_entrant_tmp_tmp,2) / ndist
              ! add
              call add_subsidy_to_wage_entrant(wage_entrant_tmp_tmp, sim_omegas(k,2,:))
              ! and take avg
              wage_entrant_tmp = sum(wage_entrant_tmp_tmp,2) / ndist
              
              !wage_entrant_tmp = wage_baseline_entrant
              !call add_subsidy_to_wage_entrant(wage_entrant_tmp, sim_omegas(k,2,:))
              deallocate(ones_nEntrant)
              ! pct change in wage
              allocate(wage_change_entrant(nEntrant))
              !wage_change_entrant = ((sum(wage_entrant_tmp,2)/nEconomy) / wage_baseline_entrant)  - 1
              wage_change_entrant = wage_entrant_tmp / wage_baseline_entrant - 1

              !Second, adjust prob_entry accordingly, multiply change by elasticity
              if (k==1) then
                 print*, 'lets check here if the entrant wage change makes sense in terms of magnitude'
                 print*, 'wage change 1 entrant', wage_change_entrant(1), 'avg % wage change entrant', &
                      sum(wage_change_entrant)/nentrant, &
                      'avg wage change entrant', sum(wage_entrant_tmp - &
                      wage_baseline_Entrant)/(nEntrant), &
                      'wage elas:', wage_elas
                 !'avg wage change entrant', sum((sum(wage_entrant_tmp,2)/nEconomy) - &
                 !wage_baseline_Entrant)/(nEntrant * nEconomy) * nEconomy, &
                 !'wage elas:', wage_elas
                 !call exit(1)
              end if

              ! As part of 'age5 restrict', we will eliminate the wage change affect for those teachers in age group 5
              do i=1, nentrant
                 if (age_entrant(i) >= 55) wage_change_entrant(i) = 0 
              end do

              prob_entry(:,k) = baseline_prob_entry * (1 + wage_change_entrant * wage_elas)
              prob_entry(:,k) = max(min(prob_entry(:,k),1d0),0d0)
              deallocate(wage_change_entrant)

              deallocate(wage_entrant_tmp)
              deallocate(wage_entrant_tmp_tmp)


           end if !mpi_id ==0
        end do ! econonomies k

        ! save our last periods nteach before we update it
        nteach_prev = nteach

        target_entry = 500
        target_exit = 500

        ! Here we calculate the expected number of entrants/exits across economies
        !if (mpi_id == 0) then
        !   
        !   !if (t_period == 2 .and. purpose == 10) then
        !   
        !      target_entry = nint(sum(prob_entry) / nEconomy)
        !      target_exit  = nint(sum(prob_exit) / nEconomy)
        !      
        !      ! (here is where I could put through an adjustment factor)
        !      !target_entry = target_entry -236
        !      
        !   !else if (t_period > 2 .and. purpose == 10) then
        !   !   ! we are good, it should remember target entry and exit from start of period 2
        !   !else
        !   !   ! this would be cf, we have to hardcode our targets
        !   !
        !      
        !   !end if
        !      
!
!         print*, 'In expectation, we will get entrants =', target_entry, ' and exits =', target_exit
!
!           ! together these will give us a new nteach:
!         nteach = nteach + target_entry - target_exit
!
!        end if !mpi_id == 0

        ! share the new nteach to the slaves
        call mpi_bcast(nteach, 1, mpi_int, 0, mpi_comm_world, ierr)

        allocate(t_exit(nteach_prev))
        allocate(t_entry(nEntrant))


        ! save incumbents in the data b/c we will need to reallocate these arrays
        allocate(C1_prev(nEconomy, nteach_prev), C2_prev(nEconomy, nteach_prev))
        allocate(exp_prev(nEconomy, nteach_prev), age_prev(nEconomy, nteach_prev), &
             master_prev(nEconomy, nteach_prev), inc_prev(nEconomy, nteach_prev))

        C1_prev     = C1_period
        C2_prev     = C2_period
        exp_prev    = exp_period
        age_prev    = age_period
        master_prev = master_period
        inc_prev    = inc_period !we already saved matches as inc_period in objective.f90, so use inc_period not match

        ! deallocate all our variables, so can reallocate with new nteach
        !     uses the global nteach, which was reset above a bit
        call deallocate_nteach_vars()
        call allocate_nteach_vars()

           
        do k=1, nEconomy

           if (mpi_id == 0) then 
              !  Draw entrants
              call SampleWithoutReplacement(prob_entry(:,k), target_entry, t_entry)

              !  Draw exits
              call SampleWithoutReplacement(prob_exit(:,k), target_exit, t_exit)
           end if

           ! Share entry and exit status to slaves
           !  this still needs to be economy-by-economy
           if (flag_entry == 0) t_entry = 0
           if (flag_exit  == 0) t_exit  = 0
           call mpi_bcast(t_entry, nEntrant, mpi_int,0,mpi_comm_world,ierr)
           call mpi_bcast(t_exit, nteach_prev, mpi_int,0,mpi_comm_world,ierr)

           ! together these draws will give us a new 'nteach', this is a check, prob can comment out
           if (mpi_id ==0 .and. k==1) print*, k, 'nteach:', nteach, 'nExit', sum(t_exit), 'nEntry', sum(t_entry)

           ! CHECK, we need nteach to be greater than 6600 I think... because of budget?
           if (nteach < 6600 .and. mpi_id == 0) then
              print*, '-----'
              print*, 'nteach less than total capacity'
              print*, '-----'
           end if
!!!!

           ! And we also have to save the district info... b/c these get expanded as well

           !if (mpi_id == 0) print*, 'before redoing nteach vars'

           ! and now we need to set these arrays for the stayers:
           j = 1 !track index in new teacher dfs
           ! vars to track avg stats
           c1_exit = 0
           c2_exit = 0
           exp_exit = 0
           age_exit = 0
           master_exit = 0
           do i=1, nteach_prev
              ! only keep those teachers around who aren't exiting
              if (t_exit(i) == 0) then
                 C1_period(k,j)      = C1_prev(k,i)
                 C2_period(k,j)      = C2_prev(k,i)
                 exp_period(k,j)     = exp_prev(k,i)
                 age_period(k,j)     = age_prev(k,i)
                 master_period(k,j)  = master_prev(k,i)
                 inc_period(k,j)     = inc_prev(k,i) 
                 
                 j = j+1
              else
                 ! for keeping track of avg stats of those who exited
                 C1_exit     = C1_exit     + C1_prev(k,i)
                 C2_exit     = C2_exit     + C2_prev(k,i)
                 exp_exit    = exp_exit    + exp_prev(k,i)
                 age_exit    = age_exit    + age_prev(k,i)
                 master_exit = master_exit + master_prev(k,i)
              end if
           end do
           ! and set it to avg
           C1_exit     = C1_exit     / sum(t_exit) 
           C2_exit     = C2_exit     / sum(t_exit) 
           exp_exit    = exp_exit    / sum(t_exit) 
           age_exit    = age_exit    / sum(t_exit) 
           master_exit = master_exit / sum(t_exit) 

           !vars to track avg stats
           C1_entry = 0
           C2_entry = 0
           exp_entry = 0
           age_entry = 0
           master_entry = 0
           ! and the arrays are set for the entrants:
           do i=1, nEntrant
              !only add those who are entering
              if (t_entry(i) == 1) then
                 C1_period(k,j)     = C1_entrant(i,1)
                 C2_period(k,j)     = C2_entrant(i,1)
                 exp_period(k,j)    = exp_entrant(i)
                 age_period(k,j)    = age_entrant(i)
                 master_period(k,j) = master_entrant(i)
                 inc_period(k,j)    = 0
                 !C1(j,1)         = C1_entrant(i,1)
                 !C2(j,1)         = C2_entrant(i,1)
                 !exp_con(j,:)    = exp_entrant(i)
                 !age(j)          = age_entrant(i)
                 !master(j,:)     = master_entrant(i)
                 !inc_period(:,j) = 0

                 j = j+1

                 ! for keeping track of avg stats of those who entered
                 C1_entry     = C1_entry     + C1_entrant(i,1)
                 C2_entry     = C2_entry     + C2_entrant(i,1)
                 exp_entry    = exp_entry    + exp_entrant(i)
                 age_entry    = age_entry    + age_entrant(i)
                 master_entry = master_entry + master_entrant(i)
              end if
           end do
           ! and set it to avg
           C1_entry     = C1_entry     / sum(t_entry) 
           C2_entry     = C2_entry     / sum(t_entry) 
           exp_entry    = exp_entry    / sum(t_entry) 
           age_entry    = age_entry    / sum(t_entry) 
           master_entry = master_entry / sum(t_entry)

           if (mpi_id == 0 .and. j-1 .ne. nteach) print*, 'XXX issue, j, nteach', j-1, nteach

           !if (mpi_id == 0) print*, ''
           !if (mpi_id == 0) print*, 'Avg Stats for exiters:'
           !if (mpi_id == 0) print*, k, C1_exit, C2_exit, exp_exit, age_exit, master_exit, sum(t_exit)
           !if (mpi_id == 0) print*, 'Avg Stats for entrants:'
           !if (mpi_id == 0) print*, k, C1_entry, C2_entry, exp_entry, age_entry, master_entry, sum(t_entry)

           if (mpi_id == 0) then
              open(1, file = 'result/entryexit_stats.txt', action='write', position='append')
              write(1,*) t_period, k, ' exit', sum(t_exit), C1_exit, C2_exit, exp_exit, age_exit, &
                   master_exit
              write(1,*) t_period, k, ' entry', sum(t_entry), C1_entry, C2_entry, exp_entry, age_entry, &
                   master_entry
              close(1)
           end if
           


           ! And need to re-generate teacher vars for new stuffs...
           ! XXX this now has to occur in inner loop...
           !if (mpi_id == 0) print*, 'regenerate teacher data'
           !call generate_teacher_data()

        end do ! k=1, neconomy

        if (mpi_id == 0) deallocate(prob_exit, prob_entry)

        ! no longer need these:
        deallocate(C1_prev, C2_prev, exp_prev, age_prev, master_prev, inc_prev)
        deallocate(t_exit, t_entry)
           ! And draw new teacher shocks...?  (only used by main thread so irrelevant what slaves do
           !  For now, both for entrants and incumbents. IID assumption. (also only relevant for aux model so meaning not at all in cf?)
        deallocate(tshock)
        allocate(tshock(nEconomy,nteach,ndist))
        do k=1, nEconomy
           !tshock
           do j=1, ndist
              do i=1, nteach
                 tshock(k,i,j) = Sample_EV1()
              enddo
           end do
        end do

        

     end if !t_period > 1
     
     
     ! allocate these to keep track of beliefs by economy
     if (t_period == 1 .and. T_max > 1) then
        allocate(theta_period(nEconomy, ntheta))
        allocate(wage_theta_period(nEconomy, ntheta_wage))
     end if

        ! Now we actually call the code for this 'iter'.
        !     if T_max>1, should always be a counterfactual,  then we get the 'else' case
        !    i.e. where we just run obj function to solve the model and obtain a counterfactual
        if (mpi_id == 0) then

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


        end if


        !if slave processe, then help solve dist problem in inner loop until told to stop
        if(mpi_id .ne. 0) then
           do
              call mpi_bcast(slave_flag,1,mpi_int,0,mpi_comm_world,ierr)
              if (slave_flag==0) exit
              call run_slave_inner_loop_one()
           end do
        end if

        ! save our baseline wages
        ! Every economy-teacher needs an average wage    (to consider exit elasticity)
        ! As well as every entrant needs an average wage (to consider entry elasticity) 
        if (t_period == 1 .and. T_max > 1) then
           allocate(ones_nteach(nteach, 1), ones_nEntrant(nEntrant,1))
           ones_nteach = 1
           ones_nEntrant = 1

           ! for incumbents, b/c pop changes, we need to recalc baseline wage each period, so keep omegas
           allocate(omega_baseline(nEconomy,2,ndist))
           omega_baseline = sim_omegas


           ! for entrants, b/c pop is static, we can calculate a base wage now.
           allocate(wage_baseline_entrant(nEntrant))
           allocate(wage_baseline_entrant_tmp(nEntrant, nEconomy))
           do k=1,nEconomy
              ! Don't need to do this for incumbents b/c the pop will change so we will work with omegas for them
              !tmp1 = sum(matmul(ones_nteach,omega_baseline(k,1,:)) * wageschedule, 2) / ndist 
              !do i=1, nteach
              !   wage_baseline(k,i) = tmp1(i) +  sum(matmul(ones_nteach,omega_baseline(k,2,:)) * contribution, 2)
              !end do

              !and entrants
              wage_baseline_entrant_tmp(:,k) = sum(matmul(ones_nEntrant,omega_baseline(k,1:1,:)) * &
                   wageschedule_entrant, 2) / ndist + &
                   sum(matmul(ones_nEntrant,omega_baseline(k,2:2,:)) * contribution_entrant, 2) / ndist
           end do
           ! and AVG across economies
           wage_baseline_entrant = sum(wage_baseline_entrant_tmp,2) / nEconomy

           deallocate(ones_nteach, ones_nEntrant, wage_baseline_entrant_tmp)

        end if

     end do ! t_period

     if (mpi_id .eq. 0) then
        deallocate(param0)
        deallocate(tshock)
        if (purpose >= 10) then
           deallocate(dshock)
           deallocate(sim_omegas)
        end if
     end if
     !deallocate(eqbm_omega2)

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
       !double precision, dimension(nteach,ndist) :: mean_wage, sd_wage
       double precision, allocatable, dimension(:,:) :: mean_wage, sd_wage
       !double precision, dimension(nteach) :: var_wage
       double precision, allocatable, dimension(:) :: var_wage

       !allocate
       allocate(mean_wage(nteach,ndist), sd_wage(nteach,ndist))
       allocate(var_wage(nteach))
       
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

       !deallocate, even tho it will automatically
       deallocate(mean_wage, sd_wage)
       deallocate(var_wage)

     end subroutine calc_wstat


     subroutine add_subsidy_to_wage(wage_tmp, omega2_tmp)
    implicit none

    double precision, dimension(:,:), intent(inout) :: wage_tmp
    double precision, dimension(:), intent(in) :: omega2_tmp !assumed shape to avoid array temporary

    double precision, allocatable, dimension(:) :: subsidy
    integer :: j

    allocate(subsidy(nteach))

    ! 
    if (purpose == 11) then
       ! B1 (incentive independent of omega2 choice)
       do j=1, ndist
          subsidy = r_vec(j) * (C1(:,1) * share_low(1,j) + C2(:,1)*(1-share_low(1,j)))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_tmp(:,j) = min(wage_tmp(:,j)+subsidy, wageupper) 
       end do
    else if (purpose == 12) then
       ! B2 (incentive tied to omega2 choice)
       do j=1, ndist
          subsidy = r_vec(j) *  omega2_tmp(j) * (C1(:,1) * share_low(1,j) + C2(:,1)*(1-share_low(1,j)))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_tmp(:,j) = min(wage_tmp(:,j)+subsidy, wageupper) 
       end do
    else if (purpose == 13) then
       ! B3 (incentive only for c1, independent of omega2)
       do j=1, ndist
          subsidy = r_vec(j) * (C1(:,1) * share_low(1,j))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_tmp(:,j) = min(wage_tmp(:,j)+subsidy, wageupper) 
       end do
    else if (purpose == 14) then
       ! B4 (incentive only for c1, tied to omega2 choice)
       do j=1, ndist
          subsidy = r_vec(j) *  omega2_tmp(j) * (C1(:,1) * share_low(1,j))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_tmp(:,j) = min(wage_tmp(:,j)+subsidy, wageupper) 
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
          wage_tmp(:,j) = min(wage_tmp(:,j)+subsidy, wageupper)
       end do
    else if (purpose == 16) then
       ! B6, student specific bonus, tied to omega2
       do j=1, ndist
          subsidy =           s_vec(1) * max(0d0,C1(:,1) * share_low(1,j))
          subsidy = subsidy + s_vec(2) * max(0d0,C2(:,1)*(1-share_low(1,j)))
          ! tie to omega2
          subsidy = subsidy * omega2_tmp(j)
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_tmp(:,j) = min(wage_tmp(:,j)+subsidy, wageupper)
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
          wage_tmp(:,j) = min(wage_tmp(:,j)+subsidy, wageupper)
       end do
       else if (purpose == 18) then
       ! B8, B7 tied to omega2
       do j=1, ndist
          subsidy =           s_vec(1) * (C1(:,1) * share_low(1,j))
          subsidy = subsidy + s_vec(2) * (C2(:,1)*(1-share_low(1,j)))
          ! tie to omega2
          subsidy = subsidy * omega2_tmp(j)
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_tmp(:,j) = min(wage_tmp(:,j)+subsidy, wageupper)
       end do
    else
       wage_tmp = wage_tmp
    end if

    deallocate(subsidy)
    
  end subroutine add_subsidy_to_wage


    subroutine add_subsidy_to_wage_entrant(wage_e_tmp, omega2_tmp)
    implicit none

    double precision, dimension(:,:), intent(inout) :: wage_e_tmp
    double precision, dimension(:), intent(in) :: omega2_tmp !assumed shape to avoid array temporary

    double precision, allocatable, dimension(:) :: subsidy
    integer :: j

    allocate(subsidy(nEntrant))

    ! 
    if (purpose == 11) then
       ! B1 (incentive independent of omega2 choice)
       do j=1, ndist
          subsidy = r_vec(j) * (C1_entrant(:,1) * share_low(1,j) + C2_entrant(:,1)*(1-share_low(1,j)))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_e_tmp(:,j) = min(wage_e_tmp(:,j)+subsidy, wageupper) 
       end do
    else if (purpose == 12) then
       ! B2 (incentive tied to omega2 choice)
       do j=1, ndist
          subsidy = r_vec(j) *  omega2_tmp(j) * (C1_entrant(:,1) * share_low(1,j) + C2_entrant(:,1)*(1-share_low(1,j)))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_e_tmp(:,j) = min(wage_e_tmp(:,j)+subsidy, wageupper) 
       end do
    else if (purpose == 13) then
       ! B3 (incentive only for c1, independent of omega2)
       do j=1, ndist
          subsidy = r_vec(j) * (C1_entrant(:,1) * share_low(1,j))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_e_tmp(:,j) = min(wage_e_tmp(:,j)+subsidy, wageupper) 
       end do
    else if (purpose == 14) then
       ! B4 (incentive only for c1, tied to omega2 choice)
       do j=1, ndist
          subsidy = r_vec(j) *  omega2_tmp(j) * (C1_entrant(:,1) * share_low(1,j))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_e_tmp(:,j) = min(wage_e_tmp(:,j)+subsidy, wageupper) 
       end do
    else if (purpose == 15) then
       ! B5, student specific bonus, exog
       do j=1, ndist
          subsidy =           s_vec(1) * max(0d0,C1_entrant(:,1) * share_low(1,j))
          subsidy = subsidy + s_vec(2) * max(0d0,C2_entrant(:,1)*(1-share_low(1,j)))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_e_tmp(:,j) = min(wage_e_tmp(:,j)+subsidy, wageupper)
       end do
    else if (purpose == 16) then
       ! B6, student specific bonus, tied to omega2
       do j=1, ndist
          subsidy =           s_vec(1) * max(0d0,C1_entrant(:,1) * share_low(1,j))
          subsidy = subsidy + s_vec(2) * max(0d0,C2_entrant(:,1)*(1-share_low(1,j)))
          ! tie to omega2
          subsidy = subsidy * omega2_tmp(j)
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_e_tmp(:,j) = min(wage_e_tmp(:,j)+subsidy, wageupper)
       end do
    else if (purpose == 17) then
       ! B7 alternate similar to B5
       do j=1, ndist
          subsidy =           s_vec(1) * (C1_entrant(:,1) * share_low(1,j))
          subsidy = subsidy + s_vec(2) * (C2_entrant(:,1)*(1-share_low(1,j)))
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_e_tmp(:,j) = min(wage_e_tmp(:,j)+subsidy, wageupper)
       end do
       else if (purpose == 18) then
       ! B8, B7 tied to omega2
       do j=1, ndist
          subsidy =           s_vec(1) * (C1_entrant(:,1) * share_low(1,j))
          subsidy = subsidy + s_vec(2) * (C2_entrant(:,1)*(1-share_low(1,j)))
          ! tie to omega2
          subsidy = subsidy * omega2_tmp(j)
          !bounds
          subsidy = max(0d0, subsidy)
          subsidy = min(subsidy, subsidy_upper)
          ! add in subsidy and cap at our usual max bound
          wage_e_tmp(:,j) = min(wage_e_tmp(:,j)+subsidy, wageupper)
       end do
    else
       wage_e_tmp = wage_e_tmp
    end if

    deallocate(subsidy)
    
  end subroutine add_subsidy_to_wage_entrant


     subroutine adj_logit_prob(prob, adj)
       double precision, dimension(:) :: prob
       double precision :: adj

       integer :: i

       ! 1. undo the logit
       do i=1, size(prob)
          if (1-prob(i) > 0) then
             prob(i) = (prob(i)) / (1-prob(i))
          else
             ! if prob is 1, then... need to adj
             prob(i) = 99999999
          end if
       end do

       ! 2. undo the exp
       prob = log(prob)

       ! 3. make the adj
       prob = prob + adj

       ! 4. redo the exp
       prob = exp(prob)

       ! 5. redo the logit
       prob = prob / (1 + prob)


       ! gut check
       do i = 1, size(prob)
          if (prob(i) <= 1 .or. prob(i) >= 0) then
             ! we ok
          else
             print*, 'prob out of bounds in adj logit prob', i, prob(i)
             call exit(1)
          end if
       end do


     end subroutine adj_logit_prob



     ! this is likely slow and dumb but quick and dirty is ok right now, and this isn't run
     !  *that* much to really matter.
     subroutine SampleWithoutReplacement(probability, sampleSize, sampleFlag)!samples)
       !integer, intent(in) :: populationSize   ! size of set sampling from
       double precision, intent(in), dimension(:) :: probability
       integer, intent(in)  :: sampleSize       ! size of each sample
       integer, intent(out),  dimension(:) :: sampleFlag
       !integer, intent(out) :: samples(sampleSize)   ! output, zero-offset indices to selected items
       integer :: n, m
       double precision :: u, probSum, tSum
       double precision, allocatable, dimension(:) :: temp_prob

       allocate(temp_prob(size(probability)))

       if (sampleSize > size(probability)) then
          print*, 'sample size cant be bigger than number of elements in sample without replacement'
          call exit(1)
       end if

       n = sampleSize ! shorter name for sample size
       m = 1  ! number of items selected so far

       ! so we don't edit the prob vector... 
       temp_prob = probability

       !initialize....
       sampleFlag = 0

       do while (m <= n)
          probSum = sum(temp_prob)

          ! sample random number and apply to our probability length
          u = Sample_Uniform(0d0,1d0) 
          u = u * probSum

          ! do cumulative sum until we are greater than u
          tSum = 0
          do i=1, size(probability)
             tSum = tSum + temp_prob(i)

             if (u < tSum)  then
                sampleFlag(i) = 1
                probSum = probSum - temp_prob(i)
                temp_prob(i) = 0
                m = m+1
                ! exit the do loop
                exit
             end if

          end do

       end do

       ! checks
       if(m-1 .ne. sampleSize) then
          print*, 'issue in sampleWithoutReplacement sample size)   m:', m-1, ' sampleSize:', sampleSize
          call exit(1)
       end if

       deallocate(temp_prob)

     end subroutine SampleWithoutReplacement

     ! ********* Set up design matrix for finding thetas in H regression ************
     ! note that wstat and read_data needs to be calculated before this is run...
     !subroutine set_up_H_design_matrix()
     !  double precision, dimension(nteach,ndist) :: C1_mat, C2_mat
     !  double precision, dimension(nteach*ndist) :: A2, A3, A4, A5, A6, A7, A8, A9, &
     !       A10, A11, A12, A13, A14,A15, A16,A17,A18,A19,A20!,A21,A22,A23,A24,A25

     !  C1_mat = matmul(C1, ones_ndist)
     !  C2_mat = matmul(C2, ones_ndist)

     !A2  = reshape(exp_con,             (/ nteach*ndist /))
     !  A3  = reshape(master,              (/ nteach*ndist /))
     !  A4  = reshape((C1_mat + C2_mat)/2, (/ nteach*ndist /))
     !  A5  = reshape(urban,               (/ nteach*ndist /))
     !  A6  = reshape(suburban,            (/ nteach*ndist /))
     !  A7  = reshape(share_low,           (/ nteach*ndist /))
     !  A8  = reshape(wstat,               (/ nteach*ndist /))
     !  A9  = reshape(matmul(C1, share_low(1:1,:)),  (/ nteach*ndist /))
     !  A10 = reshape((1-entrant) * (1-inc),                (/ nteach*ndist /))
     !  A11 = reshape((1-entrant) * (1-inc) * exp_con,      (/ nteach*ndist /))
     !  A12 = reshape((1-entrant) * (1-samecz),             (/ nteach*ndist /))
     !  A13 = reshape(milwauk,             (/ nteach*ndist /))

     !  A2  = reshape(exp_dum2, (/ nteach*ndist /))
     !  A14 = reshape(exp_dum3, (/ nteach*ndist /))
     !  A15 = reshape(exp_dum4, (/ nteach*ndist /))
     !  A16 = reshape(exp_dum5, (/ nteach*ndist /))
     !  A17 = reshape(exp_dum6, (/ nteach*ndist /))

     !  A18 = reshape(master*entrant, (/ nteach*ndist /))
     !  A19 = reshape(exp_dum2*entrant, (/ nteach*ndist /))
     !  A20 = reshape((exp_dum3+ exp_dum4+exp_dum5+exp_dum6)*entrant, (/ nteach*ndist /))

     !A21 = reshape((C1_mat + C2_mat)/2 * entrant, (/ nteach*ndist /))
     !A22 = reshape(urban * entrant, (/ nteach*ndist /))
     !A23 = reshape(suburban * entrant, (/ nteach*ndist /))
     !A24 = reshape(share_low * entrant, (/ nteach*ndist /))
     !A25 = reshape(milwauk * entrant, (/ nteach*ndist /))

     !  H_design(:,1)  = 1
     !H_design(:,2)  = A2
     !  H_design(:,3)  = A3
     !  H_design(:,4)  = A4
     !  H_design(:,5)  = A5
     !  H_design(:,6)  = A6
     !  H_design(:,7)  = A7
     !  H_design(:,8)  = A8
     !  H_design(:,9)  = A9
     !  H_design(:,10) = A10
     !  H_design(:,11) = A11
     !  H_design(:,12) = A12
     !  H_design(:,13) = A13

     !  H_design(:,2) = A2
     !  H_design(:,14) = A14
     !  H_design(:,15) = A15
     !  H_design(:,16) = A16
     !  H_design(:,17) = A17

     !  H_design(:,18) = A18
     !  H_design(:,19) = A19
     !  H_design(:,20) = A20

     !H_design(:,21) = A21
     !H_design(:,22) = A22
     !H_design(:,23) = A23
     !H_design(:,24) = A24
     !H_design(:,25) = A25

     ! end subroutine set_up_H_design_matrix

   end program main

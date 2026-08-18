! knapsack_problem.f90
! created: Oct 2018
!
! Solves the knapsack problem for a school district, finds optimal
!   offer 'dist_offer'
!
! Purposely does not use global_variables in order to be more flexible
!  for parallelization.
!
! Contains:
! - solve_knapsack (set up data, run nelder mead)
! - lambda_objective (function to minimize)

module knapsack_problem
  implicit none

  private

  public :: solve_knapsack

contains

  ! calculate offers for district d using beliefs H
  subroutine solve_knapsack(H,d,udist,wage,ten_inc,B,T,nteach,dist_offer)
    double precision, dimension(:,:), intent(in)    :: H, udist, wage, B, T
    integer,          dimension(:,:), intent(in)    :: ten_inc
    integer,                          intent(in)    :: d, nteach
    integer,            dimension(:), intent(inout) :: dist_offer
    
    integer :: i, k, id, breakflag
    integer :: n_non_inc, threshold
    
    double precision :: lambda_star, lambda_low, lambda_mid, lambda_high, lowval, midval, highval, step_size
    double precision :: B_inc, T_inc, tval, tmpval
    double precision :: B_rem, T_rem, w_sum

    double precision, allocatable, dimension(:,:) :: knapsack_data, knapsack_data_sorted

    ! Wage bill of tenured incumbents (automatically have offers already)
    B_inc = sum(wage(:,d) * H(:,d) * ten_inc(:,d), dim = 1)
    ! Expected no. of tenured incumbents who stay
    T_inc = sum(H(:,d) * ten_inc(:,d), dim = 1)
    
    ! Remaining budget and capacity
    B_rem = max(0d0, (B(1,d) - B_inc))                   
    T_rem = max(0d0, T(1,d) - T_inc)

    !if open budget/capacity, figure out how many offers to make
    if(T_rem > 0 .and. B_rem > 0) then
       
       ! Roll important data into one big dataframe, add teacher IDs
       ! only need non-incumbents
       n_non_inc = nteach - sum(ten_inc(:,d)) !number of non-incumbents
       allocate(knapsack_data(n_non_inc,4),knapsack_data_sorted(n_non_inc,4) )
       k=1
       do i=1, nteach
          if (ten_inc(i,d) == 0) then
             knapsack_data(k,:) = (/ udist(i,d), wage(i,d), H(i,d), DBLE(i) /)
             k = k + 1
          endif
       enddo

       !for non-incumbents, using remaining B and T, find offers using knapsack
       step_size = 5 !1
       lambda_low = 0
       lambda_high = lambda_low + step_size
       breakflag = 0
       !if lambda=0 does not bind capacity constraint, then it is optimal
       lowval = lambda_objective(lambda_low,n_non_inc, B_rem, T_rem, w_sum, threshold, knapsack_data, knapsack_data_sorted)
       if (lowval <= 0)then
          lambda_star = 0
          breakflag = 1
       end if
       !algorithm, move lambda 'window' up until low/high bracket the solution
       do while (breakflag .eq. 0)
          highval = lambda_objective(lambda_high,n_non_inc, B_rem, T_rem, w_sum, threshold, knapsack_data, knapsack_data_sorted)
          if (abs(highval) < epsilon(highval)) then
             lambda_star = lambda_high
             breakflag = 1
          elseif (highval < 0) then
             breakflag = 2
          else !move 'window' forward
             lambda_low = lambda_high
             lowval = highval
             lambda_high = lambda_high + step_size
          end if
       end do

       !low and high now should bracket our solution
       !commence interpolation algorithm to find crossing point
       do while (breakflag .eq. 2)
          lambda_mid = (lambda_low + lambda_high) / 2
          midval = lambda_objective(lambda_mid,n_non_inc, B_rem, T_rem, w_sum, threshold, knapsack_data, knapsack_data_sorted)
          if ( abs(midval) < epsilon(midval)) then
             lambda_star = lambda_mid
             breakflag = 1
          else !have not found binding solution
             if (midval < 0) then !move high lambda back
                lambda_high = lambda_mid
                highval = midval
                lambda_mid = (lambda_low + lambda_high) / 2
             else !move low lambda forward
                lambda_low = lambda_mid
                lowval = midval
                lambda_mid = (lambda_low + lambda_high) / 2
             end if
             if (abs(lowval - highval) < 1d-1 .or. abs(lambda_low- lambda_high) < 1d-4) then
             !if (abs(lowval - highval) < 1d-1) then
                !set lambda_star to be the one closest to constraint binding
                if (abs(highval) < abs(lowval)) then
                   lambda_star = lambda_high
                else
                   lambda_star = lambda_low
                end if
                breakflag = 1
             end if
          end if
       end do
       
       ! need to run again, b/c we don't know which lambda the solver ran last.
       tmpval = lambda_objective(lambda_star,n_non_inc, B_rem, T_rem, w_sum, threshold, knapsack_data, knapsack_data_sorted)
       !write(*,*) lambda_star, d, tmpval, threshold, B_rem, T_rem
       ! After running lambda_objective, knapsack_data will be in correct order
       !  and threshold-1 marks how many for sure get offers
       
       tval = 0
       !now take care of threshold case
       if (knapsack_data_sorted(threshold,1) - lambda_star > 0) then
          tval = (B_rem - w_sum) / (knapsack_data_sorted(threshold,3) * knapsack_data_sorted(threshold,2))
       endif
       if (tval < 0.5d0) then
          threshold = threshold -1
       endif
    
       !set offers
       dist_offer = 0
       do k=1, threshold
          id = int(knapsack_data_sorted(k,4))
          dist_offer(id) = 1
       enddo

       deallocate(knapsack_data,knapsack_data_sorted)

       !if (lambda_star == 0) then
       !   write(*,*) 'lambda = 0', d
       !end if
       
    else
       !since no excess capacity, no extra offers can be made
       dist_offer = 0
    end if
    

    !write(*,*) 's_sol', threshold, 'lambda', lambda(1)

  end subroutine solve_knapsack

  
  ! lambda_objective calculates a 'likelihood' to help find
  ! optimal value of the lagrange multiplier on capacity constraint
  !   this is a private function, only to be run by calc_dist_offer
  ! the likelihood L returned is the slack in the capacity constraint
  function lambda_objective(lambda, n_non_inc, B_rem, T_rem, w_sum, threshold, knapsack_data,knapsack_data_sorted) result(L)
    use qsort_mod
    double precision, intent(in) :: lambda, B_rem, T_rem
    integer,          intent(in) :: n_non_inc
    double precision, intent(out) :: w_sum
    integer,          intent(out) :: threshold
    double precision, dimension(n_non_inc,4), intent(in)  :: knapsack_data
    double precision, dimension(n_non_inc,4), intent(out) :: knapsack_data_sorted

    double precision, dimension(n_non_inc,2) :: order_stat
    double precision :: L, tval
    integer :: k

    ! knapsack_data(utility, wage, h, id) is known throughout module
    ! calculate ordering statistic
    order_stat(:,1) = -(knapsack_data(:,1) - lambda) / knapsack_data(:,2)
    do k=1, n_non_inc
       order_stat(k,2) = k
    end do
    !sort teachers
    call qsort_2d(order_stat)
    do k=1, n_non_inc
       !key for speed with qsort is to not rearrange knapsack_data
       ! but rather keep its own sorted copy
       knapsack_data_sorted(k,:) = knapsack_data(int(order_stat(k,2)),:)
    end do

    ! make offers to teachers
    w_sum = 0
    do k=1, n_non_inc
       ! stop if run out of budget, or negative utility
       if (w_sum + knapsack_data_sorted(k,2)*knapsack_data_sorted(k,3) > B_rem) then
          exit
       else if ((knapsack_data_sorted(k,1) - lambda) < 0d0) then
          exit
       end if
       w_sum = w_sum + knapsack_data_sorted(k,2)*knapsack_data_sorted(k,3)
    end do
    !fortran treats do loop akin to while loop, so if loop completes, k=n_non_inc+1


    !take care of threshold teacher
    if (k .eq. n_non_inc + 1) then
       tval = 1 !corner case where districts offer to all teachers
       k = k - 1 !get k back in bounds of array
    elseif (knapsack_data_sorted(k,1) - lambda .ge. 0d0 .and. k > 1) then
       tval = (B_rem - w_sum) / (knapsack_data_sorted(k,2) * knapsack_data_sorted(k,3))
    else
       tval = 0
    end if

    if (tval < 0 .or. tval > 1) then
       write(*,*) 'Error: tval should be a probability', tval
       call exit(1)
    end if

    !note that k is threshold teacher, save this for other function to use
    threshold = k
    
    !L = abs(sum(knapsack_data(1:k-1,3)) + tval * knapsack_data(k,3) - T_rem)

    L = sum(knapsack_data_sorted(1:k-1,3)) + tval * knapsack_data_sorted(k,3) - T_rem
    !write(*,*) 'lambda:', lambda, 'LHS', L
 
  end function lambda_objective


end module knapsack_problem

    

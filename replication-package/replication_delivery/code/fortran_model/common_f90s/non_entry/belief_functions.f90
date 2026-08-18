 ! belief_functions.f90
! created: Oct 2018
!
! Functions related to computation and estimation of 'h' beliefs
!   NOTE: wage beliefs are in inner_loop_one

module belief_functions
  use global_variables
  implicit none

  private

  public :: h_logit, h_logit_vary

contains

  ! Given belief parameters theta, return beliefs H
  function h_logit(theta_h) result(H)
    double precision, dimension(ntheta)        :: theta_h
    double precision, dimension(nteach,ndist)  :: H, f
    double precision, dimension(nteach, ndist) :: c_ave
    double precision, dimension(nteach, ndist) :: C1_mat, C2_mat

    C1_mat = matmul(C1, ones_ndist)
    C2_mat = matmul(C2, ones_ndist)
    c_ave = (C1_mat + C2_mat) / 2 

    f =     theta_h(1)
    !f = f + theta_h(2)  * exp_con
    f = f + theta_h(3)  * master
    f = f + theta_h(4)  * c_ave
    f = f + theta_h(5)  * urban
    f = f + theta_h(6)  * suburban
    f = f + theta_h(7)  * exp(share_low)
    f = f + theta_h(8)  * wstat
    f = f + theta_h(9)  * matmul(C1, share_low(1:1,:))
    f = f + theta_h(10) * (1-entrant) * (1-inc)          
    f = f + theta_h(11) * (1-entrant) * (1-inc) * exp_con
    f = f + theta_h(12) * (1-entrant) * (1-samecz)
    f = f + theta_h(13) * milwauk

    f = f + theta_h(2)  * exp_dum2
    f = f + theta_h(14) * exp_dum3
    f = f + theta_h(15) * exp_dum4
    f = f + theta_h(16) * exp_dum5
    f = f + theta_h(17) * exp_dum6

    f = f + theta_h(18) * master * entrant
    f = f + theta_h(19) * exp_dum2 * entrant
    f = f + theta_h(20) * (exp_dum3+ exp_dum4+exp_dum5+exp_dum6)*entrant

    !f = f + theta_h(21) * c_ave * entrant
    !f = f + theta_h(22) * urban * entrant
    !f = f + theta_h(23) * suburban * entrant
    !f = f + theta_h(24) * share_low * entrant
    !f = f + theta_h(25) * milwauk * entrant

    H = 1 / (1 + exp(f))
    !H(isnan(H))=0; matlab checks for nans

    !bounding possible beliefs
    !(note if this bounding feature is removed or altered, also need to change 
    !   H_target bounds in inner_loop_one.f90)
    H = max(H, belief_floor)
    H = min(H, belief_ceiling)


    !double check to make sure only h_logit_vary is called ine eqbm code
    !print*, 'h_logit called unexpectedly'
    !call exit(1)
    
  end function h_logit



  ! If we only want to get h for ONE district, not all ndist,
  !   and also may want to adjust wstat
  function h_logit_vary(theta_h,j,wstat_vary) result(h_vary)
    integer,          intent(in) :: j
    double precision, dimension(nteach), intent(in) :: wstat_vary
    double precision, dimension(ntheta)    :: theta_h
    double precision, dimension(nteach)    :: h_vary, f
    double precision, dimension(nteach,1)  :: c_ave

    integer :: i

    c_ave = (C1 + C2) / 2 

    f =     theta_h(1)
    !f = f + theta_h(2)  * exp_con
    f = f + theta_h(3)  * master(:,j)
    f = f + theta_h(4)  * c_ave(:,1)
    f = f + theta_h(5)  * urban(:,j)
    f = f + theta_h(6)  * suburban(:,j)
    f = f + theta_h(7)  * exp(share_low(:,j))
    f = f + theta_h(8)  * wstat_vary
    f = f + theta_h(9)  * C1(:,1) * share_low(:,j)
    f = f + theta_h(10) * (1-entrant(:,j)) * (1-inc(:,j))          
    f = f + theta_h(11) * (1-entrant(:,j)) * (1-inc(:,j)) * exp_con(:,j)
    f = f + theta_h(12) * (1-entrant(:,j)) * (1-samecz(:,j))
    f = f + theta_h(13) * milwauk(:,j)

    f = f + theta_h(2)  * exp_dum2(:,j)
    f = f + theta_h(14) * exp_dum3(:,j)
    f = f + theta_h(15) * exp_dum4(:,j)
    f = f + theta_h(16) * exp_dum5(:,j)
    f = f + theta_h(17) * exp_dum6(:,j)

    f = f + theta_h(18) * master(:,j) * entrant(:,j)
    f = f + theta_h(19) * exp_dum2(:,j) * entrant(:,j)
    f = f + theta_h(20) * (exp_dum3(:,j) + exp_dum4(:,j) + &
         exp_dum5(:,j) + exp_dum6(:,j)) * entrant(:,j)

    ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design
    if (purpose == 10 .or. purpose == 11 .or. purpose == 12 .or. purpose == 17 .or. purpose == 18) then

       ! special c_ave * dum term
       f = f + theta_h(21) * c_ave(:,1) * subsidized

       !adding term for wstat for 'special teachers'
       f = f + theta_h(22) * wstat_vary * subsidized

    else if (purpose == 13 .or. purpose == 14) then
       
       ! special c * dum term
       f = f + theta_h(21) * C1(:,1) * subsidized_C1
       
       !adding term for wstat for 'special teachers'
       f = f + theta_h(22) * wstat_vary * subsidized_C1
    else if (purpose == 15 .or. purpose == 16) then
       ! special c_ave * dum term
       f = f + theta_h(21) * c_ave(:,1) * max(subsidized_C1,subsidized_C2)

       !adding term for wstat for 'special teachers'
       f = f + theta_h(22) * wstat_vary * max(subsidized_C1,subsidized_C2)
       
    end if

    h_vary = 1 / (1 + exp(f))
    !H(isnan(H))=0; matlab checks for nans

    !bounding possible beliefs
    !(note if this bounding feature is removed or altered, also need to change 
    !   H_target bounds in inner_loop_one.f90)
    h_vary = max(h_vary, belief_floor)
    h_vary = min(h_vary, belief_ceiling)
    
  end function h_logit_vary

end module belief_functions

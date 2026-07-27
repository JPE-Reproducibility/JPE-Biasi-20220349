! utility_functions.f90
! created: Oct 2018
!
! Utility functions for both school districts and teachers
!

module utility_functions
  use global_variables
  implicit none

  private

  public :: utility_teacher, utility_teacher_eqm, utility_district, Rcost

contains


  function utility_teacher(alpha) result(u)
    double precision, dimension(nalpha) :: alpha
    double precision, dimension(nteach, ndist) :: u

    u = wage
    u = u + alpha(1)  * urban            
    u = u + alpha(2)  * suburban
    u = u + alpha(3)  * milwauk
    u = u + alpha(4)  * exp(share_low)
    u = u + alpha(5)  * matmul(C1, share_low(1:1,:))
    !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
  !  u = u - alpha(6)  * (1-entrant) * (1-inc) * exp_dum1
    u = u - alpha(7)  * (1-entrant) * (1-inc) * exp_dum2
    u = u - alpha(8)  * (1-entrant) * (1-inc) * exp_dum3
    u = u - alpha(9)  * (1-entrant) * (1-inc) * exp_dum4
    u = u - alpha(10) * (1-entrant) * (1-inc) * exp_dum5
    u = u - alpha(11) * (1-entrant) * (1-inc) * exp_dum6
    u = u - alpha(12) * (1-entrant) * (1-inc) * logdist
    u = u - alpha(13) * (1-entrant) * (1-samecz)

  end function utility_teacher

  function utility_teacher_eqm(alpha, wage_eqm_wedge) result(u)
    double precision, dimension(nalpha) :: alpha
    !double precision, dimension(ndist)  :: omega2
    double precision, dimension(nteach, ndist) :: wage_eqm_wedge
    double precision, dimension(nteach, ndist) :: u
    integer :: j

    !double precision, dimension(nteach, ndist) :: wage_wedge
    !double precision, dimension(nteach) :: subsidy

    ! this now occurs outside, i had duplicate work so this is more efficient slightly to remove here
    !wage_wedge = wage_eqm
    !! set up subsidies into the wedge
    !if (purpose == 11) then
    !   do j=1, ndist
    !      ! B1 (incentive independent of omega2 choice)
    !      subsidy = r_vec(j) * (C1(:,1) * share_low(1,j) + C2(:,1)*(1-share_low(1,j)))
    !      !bounds
    !      subsidy = max(0d0, subsidy)
    !      subsidy = min(subsidy, subsidy_upper)
    !      ! add in subsidy and cap at usual max
    !      wage_wedge(:,j) = min(wage(:,j)+subsidy, wageupper)
    !   end do
    !else if (purpose == 12) then
    !   do j=1, ndist
    !      !voucher dependent on omega2 
    !      subsidy = r_vec(j) * omega2(j) * (C1(:,1) * share_low(1,j) + C2(:,1)*(1-share_low(1,j)))
    !      !bounds
    !      subsidy = max(0d0, subsidy)
    !      subsidy = min(subsidy, subsidy_upper)
    !      ! add in subsidy and cap at usual max
    !      wage_wedge(:,j) = min(wage_wedge(:,j)+subsidy, wageupper)
    !   end do
    !end if
    
    u = wage_eqm_wedge
    u = u + alpha(1) * urban            
    u = u + alpha(2) * suburban
    u = u + alpha(3) * milwauk
    u = u + alpha(4) * exp(share_low)
    u = u + alpha(5) * matmul(C1, share_low(1:1,:))
    !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
    !u = u - alpha(6)  * (1-entrant) * (1-inc) * exp_dum1
    u = u - alpha(7)  * (1-entrant) * (1-inc) * exp_dum2
    u = u - alpha(8)  * (1-entrant) * (1-inc) * exp_dum3
    u = u - alpha(9)  * (1-entrant) * (1-inc) * exp_dum4
    u = u - alpha(10) * (1-entrant) * (1-inc) * exp_dum5
    u = u - alpha(11) * (1-entrant) * (1-inc) * exp_dum6
    u = u - alpha(12) * (1-entrant) * (1-inc) * logdist
    u = u - alpha(13) * (1-entrant) * (1-samecz)

  end function utility_teacher_eqm

  function utility_district(beta) result(u)
    double precision, dimension(nbeta)         :: beta
    double precision, dimension(nteach, ndist) :: u

    !note beta transformation in objective.f90
    u =     beta(1) * exp_dum1
    u = u + beta(2) * exp_dum2
    u = u + beta(3) * exp_dum3
    u = u + beta(4) * exp_dum4
    u = u + beta(5) * exp_dum5
    u = u + beta(6) * exp_dum6
    u = u + matmul(C1+addmin(1), share_low(1:1,:)) * dble(100) !coef normalized to 1
    u = u + beta(7) * matmul(C2+addmin(2), (1-share_low(1:1,:))) * dble(100)
    u = u + beta(8) * master

    !print statements to help hand calibration of betas
    !    write(*,*) 'c1*lambda', minval(matmul(C1+addmin(1), share_low(1:1,:)))
    !    write(*,*) 'c1*lambda', maxval(matmul(C1+addmin(1), share_low(1:1,:)))
    !    write(*,*) 'c2*(1-lambda) min',minval(beta(7) *  matmul(C2+addmin(2), (1-share_low(1:1,:))))
    !    write(*,*) 'c2*(1-lambda) max', maxval(beta(7) *  matmul(C2+addmin(2), (1-share_low(1:1,:))))
    !    write(*,*) 'exp min', minval(beta(1) * exp_dum1 + beta(2) * exp_dum2 + &
    !         beta(3) * exp_dum3 + beta(4) * exp_dum4 + &
    !         beta(5) * exp_dum5 + beta(6) * exp_dum6)
    !    write(*,*) 'exp max', maxval(beta(1) * exp_dum1 + beta(2) * exp_dum2 + &
    !         beta(3) * exp_dum3 + beta(4) * exp_dum4 + &
    !         beta(5) * exp_dum5 + beta(6) * exp_dum6)
    !    write(*,*) 'master min', minval(beta(8)*master)
    !    write(*,*) 'master max',maxval(beta(8)* master)
    !    write(*,*) 'u min', minval(u)
    !    write(*,*) 'u max', maxval(u)
    !    
    !   call exit(1)
  end function utility_district

  function Rcost(w1s,w2s, dem, gammas) result(rc)
    ! beware: gamma() is a fortran intrinsic
    double precision, intent(in) :: w1s, w2s, dem, gammas(ngamma)
    double precision             :: rc
    if (abs(w1s-1) < epsilon(0d0) .and. abs(w2s-0) < epsilon(0d0)) then
        rc=0
     else
        rc = dexp(gammas(1) + gammas(2) * dem) + &
             dexp(gammas(3) + gammas(4) * dem) * abs(dble(1)-w1s) + &
             dexp(gammas(5) + gammas(6) * dem) * w2s/dble(100)
        !rc = gammas(1) +gammas(2)* abs(dble(1)-w1s)+ gammas(3) *( w2s/dble(100))
    endif
  end function Rcost
  
end module utility_functions

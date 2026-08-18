! global_variables.f90
! created: Oct 2018
!
! Creates global variables:
! - model parameters
! - data

module global_variables
  implicit none

  ! nteach, filepath
  include 'nteach_filepath.inc'

  ! ** MPI variables **
  integer :: ierr, ntasks, mpi_id
  
  ! ** instruction variables **
  integer :: purpose, teachOff_decision, wage_decision, maxiter, outer_loop
  integer :: rcost_experiment, nomovecost_experiment
  integer :: h_maxiter, skip_first_inner_loop, skip_inner_loop, offer_eqbm
  integer :: report_weight_factors, starting_economy !omega2_restriction
  double precision :: simplex_length, outer_tol_pct, outer_tol_dif, h_tol_pct
  double precision :: h_tol_dif
  double precision :: h_tol_min=1 !inner loop lower bar for good belief
  double precision :: h_tol_min_upper, h_tol_min_lower
  

  !fixed instruction type variables
  double precision, parameter :: belief_floor=0, belief_ceiling=1
  double precision, parameter :: wagelower=28.777456, wageupper=86.731818
  
  ! ** Wage grid, read in instruction.txt **
  integer, parameter :: NWgrid1 = 6, NWgrid2 = 8
  double precision :: omega1_grid(NWgrid1) = (/0.9, 0.95, 1.0, 1.05, 1.1, 1.15/)
  double precision :: omega2_grid(NWgrid2) = (/0, 10, 30, 50, 75, 100, 200, 225/) 
  
  ! ** number of teachers and districts **
  !nteach is set by nteach_filepath_se.inc
  integer, parameter :: ndist  = 411
  integer            :: NcopyT, NcopyD, nEconomy ! read in instruction.txt
  integer            :: sim_nteach, sim_ndist ! nteach*NcopyT, ndist*NCopyD

  double precision :: subsidy_upper
  double precision, dimension(ndist) :: r_vec
  double precision, dimension(2)     :: s_vec

  ! ** dataframes **
  !wage variables
  double precision, dimension(nteach, ndist) :: wage, wageschedule, contribution
  double precision, dimension(ndist,  2)     :: Wgrid
  double precision, dimension(nteach)        :: meanW, sdW
  integer,          allocatable :: eqbm_omega2(:,:)
  double precision, allocatable :: sim_omegas(:,:,:)
  !teacher and district specific (wage, match, incumbent, commuting zone)
  integer,          dimension(nteach, ndist) :: match, inc, entrant, milwauk, samecz
  double precision, dimension(nteach, ndist) :: logdist
  !teacher specific (masters degree, cts experience, exp dummies, value added)
  integer, dimension(nteach, ndist) :: master, exp_con
  double precision, dimension(nteach, 1) :: C1, C2 !identical for each district
  double precision :: C1_median
  double precision, dimension(2) :: addmin !wedge to make c1 and c2 positive
  integer, dimension(nteach, 6) :: exp_dum
  integer, dimension(nteach, 1) :: exp_gr
  integer, dimension(nteach, ndist) :: exp_dum1, exp_dum2, exp_dum3, exp_dum4, exp_dum5, exp_dum6 !identical for each dist
  integer, dimension(nteach, ndist) :: tenured
  double precision, dimension(nteach, 4) :: va           
  !district specific (% low achieving, urban, suburban)
  double precision, dimension(nteach,  ndist) :: share_low, urban, suburban !identical for each teacher
  double precision, dimension(ndist) :: demshare, dem_abovemed, czten

  !budget and capacity and subsidized status
  double precision, dimension(1,  ndist) :: B, T
  integer, dimension(nteach) :: subsidized=0, subsidized_C1=0, subsidized_C2=0
  !shocks
  double precision, allocatable :: tshock(:,:,:) !(sim_nteach, ndist)
  double precision, allocatable :: dshock(:,:,:,:) !(sim_ndist,  NWgrid1*NWgrid2)
  !wage statistic
  double precision, dimension(nteach, ndist) :: wstat

  ! ** model parameter vars **
  ! alpha, beta, gamma, sigma, d_sigma
  integer, parameter :: nalpha = 13, nbeta = 8 , ngamma=6, nparam = nalpha + nbeta + ngamma + 2
  double precision, dimension(nparam) :: initial_param, step
  integer,          dimension(nparam) :: incl 
  ! theta, for acceptance beliefs h() 
  integer, parameter :: ntheta = 22, ntheta_wage = 40
  double precision, dimension(ntheta) :: theta, theta_prev, theta0, theta_sofar
  double precision, dimension(ntheta_wage) :: theta0_wage
  
  ! ** auxiliary parameters **
  integer, parameter  :: naux = 74, naux_other = 83, naux_omega = 56
  double precision :: best_L, D_sofar
  double precision, dimension(naux,1) :: aux_beta, aux_weight_factor
  double precision, dimension(naux,naux) :: weight_mat
  double precision, dimension(naux_other,1) :: aux_other, other_weight_factor
  double precision, dimension(naux_other,naux_other) :: other_weight_mat 
  double precision, dimension(naux_omega,1) :: aux_omega, omega_weight_factor
  double precision, dimension(naux_omega,naux_omega) :: omega_weight_mat
  !helpers for calculating aux params
  integer, dimension(5,ndist) :: lambda_quintiles, bt_quintiles

  ! ** matricies of ones to help w/ operations **
  integer, dimension(nteach, 1)     :: ones_nteach       = 1
  integer, dimension(1, ndist)      :: ones_ndist        = 1

  ! ** pot pourri, miscelaneous **
  integer :: nround !keep track of iteration count

  ! only needs to be global for the std err calc, but in the spirit of
  !    consolidating all code, these are just made global for all
  double precision, dimension(naux) :: auxvar
  double precision, dimension(naux_other) :: aux_othervar
  double precision, dimension(naux_omega) :: aux_omegavar
  !
  double precision, dimension(naux,1)       :: aux_beta_model,  aux_d
  double precision, dimension(naux_other,1) :: aux_other_model, aux_other_d
  double precision, dimension(naux_omega,1) :: aux_omega_model, aux_omega_d
  
end module global_variables

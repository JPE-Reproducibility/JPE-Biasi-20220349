  ! write_moments.f90
  ! created: Nov 2022
  !
  ! moved the moment writing functions here for better organization.
  !



module write_moments
  use global_variables
  implicit none

  private

  public write_best_param, write_latest_theta, write_all_aux_params, write_moment_weight_factors


contains

  !write current best parameters and likelihood (distance) value to .txt
  subroutine write_best_param(best_param, best_L, param0_in)
    double precision, dimension(nparam), intent(in) :: best_param
    double precision, dimension(nparam) :: best_param2
    double precision, intent(in) :: best_L
    double precision, dimension(:), intent(in) :: param0_in
    double precision :: latestval
    integer :: n, i
    character(len = 40) :: format1, format2, format3
    character(len = 35), dimension(nparam) :: param_desc


    param_desc(1)  = '  alpha 1,  urban                  '
    param_desc(2)  = '  alpha 2,  suburban               '
    param_desc(3)  = '  alpha 3,  Milwaukee dummy            '
    param_desc(4)  = '  alpha 4,   exp(lambda)       '
    param_desc(5)  = '  alpha 5,  C1 * lambda            '
    param_desc(6)  = '  alpha 6,  same district * exp1   '
    param_desc(7)  = '  alpha 7,  same district * exp2   '
    param_desc(8)  = '  alpha 8,  same district * exp3   '
    param_desc(9)  = '  alpha 9,  same district * exp4   '
    param_desc(10) = '  alpha 10, same district * exp5   '
    param_desc(11) = '  alpha 11, same district * exp6   '
    param_desc(12) = '  alpha 12, same district * logdist'
    param_desc(13) = '  alpha 13, same CZ                '
    param_desc(14) = '  beta 1,  exp factor 1            ' 
    param_desc(15) = '  beta 2,  exp factor 2            ' 
    param_desc(16) = '  beta 3,  exp factor 3            ' 
    param_desc(17) = '  beta 4,  exp factor 4            ' 
    param_desc(18) = '  beta 5,  exp factor 5            '
    param_desc(19) = '  beta 6,  exp factor 6            '
    param_desc(20) = '  beta 7,  (1-lambda) * c2         ' 
    param_desc(21) = '  beta 8,  master                  ' 
    param_desc(22) = '  sigma                            '
    param_desc(23) = '  gamma 1, r00, fixed cost         '
    param_desc(24) = '  gamma 2, r01, dem                '
    param_desc(25) = '  gamma 3, r11, abs(omega1-1)      '
    param_desc(26) = '  gamma 4, r12, dem x abs(omega1-1)'
    param_desc(27) = '  gamma 5, r21, omega2/100         '
    param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
    param_desc(29) = '  sigmaD                           '      


    format1 = '(A7, A30,    A30,    A30,    A5, A35)'
    format2 = '(I7, F30.15, F30.15, F30.15, I5, A35)'
    format3 = '(F30.15)'

    !transform experience factors for writeout as best_param2
    best_param2 = best_param
    ! alpha exp params
  !  do i=7, 11 !alpha 7 through 11
  !     best_param2(i) = best_param(i) - best_param(i-1)
  !  end do
    ! beta exp params
   ! do i=nalpha+2,nalpha+6 !beta 2 through 7
   !    best_param2(i) = best_param(i) - best_param(i-1)
   ! end do

    !latestvalue is akin to the 'initials' which are a transformation, and what is read into the program
    !  whereas parameter is the structural  parameter value
    open(1, file = 'latest_param_guess.txt', status = 'replace')
    write(1,format1) 'Include', 'Value to be read-in', 'stepsize', 'Model Parameter', 'n', 'description               '
    !loop over parameters to write them out
    n = 0
    do i=1, nparam
       if(incl(i) == 1) then
          n = n + 1
          latestval = initial_param(i) * step(i) * param0_in(n)
       else
          latestval = initial_param(i)
       end if
       write(1,format2) incl(i), latestval, step(i), best_param2(i), n, param_desc(i)
    end do
    write(1,*)
    write(1,*) 'Best L:'
    write(1,format3) best_L
    write(1,*) 'nround-1', nround-1
    close(1)

    !also save our latest belief params for this best guess
    call write_latest_theta()

  end subroutine write_best_param

  !theta is global so need no argument
  subroutine write_latest_theta()
    integer :: i
    character(len=40) :: format1, tmpstr

    !also write out belief params theta that correspond with best param
    format1 = '(I2)'
    open(1, file = 'latest_theta.txt', status = 'replace')
    do i=1, ntheta
       write(tmpstr,format1) i !convert to string
       write(1,*) theta(i), 'theta_'//trim(tmpstr)
    end do
    write(1,*) D_sofar, 'inner obj'
    do i=1, ntheta_wage
       write(tmpstr,format1) i !convert to string
       write(1,*) theta0_wage(i), 'theta_wage_'//trim(tmpstr)
    end do
    close(1)
  end subroutine write_latest_theta

  ! simplifying routine to write out our two txt files
  subroutine write_all_aux_params(l_aux_beta_model, l_aux_omega_model, l_aux_other_model)
    double precision, intent(in), dimension(naux,1)       :: l_aux_beta_model
    double precision, intent(in), dimension(naux_omega,1) :: l_aux_omega_model
    double precision, dimension(naux_other,1), intent(in) :: l_aux_other_model

    ! aux and omega aux
    call write_aux_param(l_aux_beta_model, l_aux_omega_model)
    ! 'other' aux
    call write_aux_other_param(l_aux_other_model)

  end subroutine write_all_aux_params


  ! writes both the aux and omega aux moments into the same txt file
  subroutine write_aux_param(l_aux_beta_model,l_aux_omega_model)
    double precision, intent(in), dimension(naux,1)       :: l_aux_beta_model
    double precision, intent(in), dimension(naux_omega,1) :: l_aux_omega_model
    character(len=70) :: f1, f2, f3, f4, f5, f6
    integer :: k

    f1 = '(A20,   A15)'
    f2 = '(F20.5, F15.5, A20)'
    if (validation == 1) f2 = '(F20.10, F15.10, A20)'
    f3 = '(A35,          A35,          A35,          A35)'
    f4 = '(A20,   A15,   A20,   A15,   A20,   A15,   A20,   A15)'
    f5 = '(F20.8, F15.8, F20.8, F15.8, F20.8, F15.8, F20.8, F15.8, A20)'
    f6 = '(F20.5, F15.5, A20,   I2,    A1)'

    open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')

    write(1,*) '"Small" match ols - offer subset from model'
    write(1,f1) 'Data', 'Model'
    write(1,f2) aux_beta(1,1),  l_aux_beta_model(1,1),  'wage            '
    write(1,f2) aux_beta(2,1),  l_aux_beta_model(2,1),  'exp(lambda)     '
    write(1,f2) aux_beta(3,1),  l_aux_beta_model(3,1),  'C1 * lambda     '
    write(1,f2) aux_beta(4,1),  l_aux_beta_model(4,1),  'inc             '
    write(1,f2) aux_beta(5,1),  l_aux_beta_model(5,1),  'inc * exp[1,3]  '
    write(1,f2) aux_beta(6,1),  l_aux_beta_model(6,1),  'inc * exp[4,5]  '
    write(1,f2) aux_beta(7,1),  l_aux_beta_model(7,1),  'inc * exp[6,10] '
    write(1,f2) aux_beta(8,1),  l_aux_beta_model(8,1),  'inc * exp[11,15]'
    write(1,f2) aux_beta(9,1),  l_aux_beta_model(9,1),  'samecz          '
    write(1,f2) aux_beta(10,1), l_aux_beta_model(10,1), 'urban           '
    write(1,f2) aux_beta(11,1), l_aux_beta_model(11,1), 'suburban        '
    write(1,f2) aux_beta(12,1), l_aux_beta_model(12,1), 'log(dist)       '
    write(1,f2) aux_beta(13,1), l_aux_beta_model(13,1), 'Milwaukee       '
    write(1,*) '"Big" match ols - offers from all districts'
    write(1,f1) 'Data', 'Model'
    write(1,f2) aux_beta(14,1), l_aux_beta_model(14,1), 'wage            '
    write(1,f2) aux_beta(15,1), l_aux_beta_model(15,1), 'exp(lambda)     '
    write(1,f2) aux_beta(16,1), l_aux_beta_model(16,1), 'C1 * lambda     '
    write(1,f2) aux_beta(17,1), l_aux_beta_model(17,1), 'inc             '
    write(1,f2) aux_beta(18,1), l_aux_beta_model(18,1), 'inc * exp[1,3]  '
    write(1,f2) aux_beta(19,1), l_aux_beta_model(19,1), 'inc * exp[4,5]  '
    write(1,f2) aux_beta(20,1), l_aux_beta_model(20,1), 'inc * exp[6,10] '
    write(1,f2) aux_beta(21,1), l_aux_beta_model(21,1), 'inc * exp[11,15]'
    write(1,f2) aux_beta(22,1), l_aux_beta_model(22,1), 'samecz          '
    write(1,f2) aux_beta(23,1), l_aux_beta_model(23,1), 'urban           '
    write(1,f2) aux_beta(24,1), l_aux_beta_model(24,1), 'suburban        '
    write(1,f2) aux_beta(25,1), l_aux_beta_model(25,1), 'log(dist)       '
    write(1,f2) aux_beta(26,1), l_aux_beta_model(26,1), 'Milwaukee       '
    write(1,*)
    write(1,f1) 'omega1 OLS                             '
    write(1,f1) 'Data', 'Model'
    write(1,f2) aux_omega(1,1),  l_aux_omega_model(1,1),  'Exp3          '
    write(1,f2) aux_omega(2,1),  l_aux_omega_model(2,1),  'Exp4          '
    write(1,f2) aux_omega(3,1),  l_aux_omega_model(3,1),  'Exp5          '
    write(1,f2) aux_omega(4,1),  l_aux_omega_model(4,1),  'Exp6          '
    write(1,f2) aux_omega(5,1),  l_aux_omega_model(5,1),  'master        '
    write(1,f2) aux_omega(6,1),  l_aux_omega_model(6,1),  'lambda        '
    write(1,f2) aux_omega(7,1),  l_aux_omega_model(7,1),  'tc            '
    write(1,f2) aux_omega(8,1),  l_aux_omega_model(8,1),  'tc_tenured    '
    write(1,f2) aux_omega(9,1),  l_aux_omega_model(9,1),  'budget_pc     '
    write(1,f2) aux_omega(10,1), l_aux_omega_model(10,1), 'capacity      '
    write(1,f2) aux_omega(11,1), l_aux_omega_model(11,1), 'urban         '
    write(1,f2) aux_omega(12,1), l_aux_omega_model(12,1), 'suburban      '
    write(1,f2) aux_omega(13,1), l_aux_omega_model(13,1), 'milwaukee     '
    write(1,f2) aux_omega(14,1), l_aux_omega_model(14,1), 'cz_tc         '
    write(1,f2) aux_omega(15,1), l_aux_omega_model(15,1), 'cz share ten  '
    write(1,f2) aux_omega(16,1), l_aux_omega_model(16,1), 'share dem vote'
    write(1,f2) aux_omega(17,1), l_aux_omega_model(17,1), 'intercept     '
    write(1,f1) 'omega2	OLS                              '
    write(1,f1) 'Data', 'Model'
    write(1,f2) aux_omega(18,1), l_aux_omega_model(18,1), 'Exp3          '
    write(1,f2) aux_omega(19,1), l_aux_omega_model(19,1), 'Exp4          '
    write(1,f2) aux_omega(20,1), l_aux_omega_model(20,1), 'Exp5          '
    write(1,f2) aux_omega(21,1), l_aux_omega_model(21,1), 'Exp6          '
    write(1,f2) aux_omega(22,1), l_aux_omega_model(22,1), 'master        '
    write(1,f2) aux_omega(23,1), l_aux_omega_model(23,1), 'lambda        '
    write(1,f2) aux_omega(24,1), l_aux_omega_model(24,1), 'tc            '
    write(1,f2) aux_omega(25,1), l_aux_omega_model(25,1), 'tc_tenured    '
    write(1,f2) aux_omega(26,1), l_aux_omega_model(26,1), 'budget_pc     '
    write(1,f2) aux_omega(27,1), l_aux_omega_model(27,1), 'capacity      '
    write(1,f2) aux_omega(28,1), l_aux_omega_model(28,1), 'urban         '
    write(1,f2) aux_omega(29,1), l_aux_omega_model(29,1), 'suburban      '
    write(1,f2) aux_omega(30,1), l_aux_omega_model(30,1), 'milwaukee     '
    write(1,f2) aux_omega(31,1), l_aux_omega_model(31,1), 'cz_tc         '
    write(1,f2) aux_omega(32,1), l_aux_omega_model(32,1), 'cz share ten  '
    write(1,f2) aux_omega(33,1), l_aux_omega_model(33,1), 'share dem vote'
    write(1,f2) aux_omega(34,1), l_aux_omega_model(34,1), 'intercept     '
    write(1,*) 'omega moments'
    write(1,f2) aux_omega(35,1), l_aux_omega_model(35,1), 'E(omega1)       '
    write(1,f2) aux_omega(36,1), l_aux_omega_model(36,1), 'E(omega2)       '
    write(1,f2) aux_omega(37,1), l_aux_omega_model(37,1), 'E(omega1*omega2)'
    write(1,f2) aux_omega(38,1), l_aux_omega_model(38,1), 'E(omega1^2)     '
    write(1,f2) aux_omega(39,1), l_aux_omega_model(39,1), 'E(omega2^2)     '
    write(1,*) 'omega fractions (probs)'
    do k=1,NWgrid1-1 ! 1 to 5
       write(1,f6) aux_omega(39+k,1), l_aux_omega_model(39+k,1), 'Pr_Omega1(',k,')    ' 
    enddo
    do k=1,NWgrid2-1 ! 1 to 7
       write(1,f6) aux_omega(44+k,1), l_aux_omega_model(44+k,1), 'Pr_Omega2(',k,')    '
    enddo
    write(1,*) 'omega old'
    write(1,f6) aux_omega(52,1), l_aux_omega_model(52,1),        'Pr_omega_Old    '
    write(1,*) 'omega x dem'
    write(1,f6) aux_omega(53,1), l_aux_omega_model(53,1),        'E(o1 x dem)     '
    write(1,f6) aux_omega(54,1), l_aux_omega_model(54,1),        'E(o2 x dem)     '
    write(1,f6) aux_omega(55,1), l_aux_omega_model(55,1),        'E(o1 | dem >=med'
    write(1,f6) aux_omega(56,1), l_aux_omega_model(56,1),        'E(o2 | dem >=med'
    write(1,*)
    

    write(1,*) 'OLS moments:'
    write(1,f3) 'E(exp)          ', 'E(master)       ', 'E(C1)           ', 'E(C2)           '

    write(1,*) 'Non-tenured Teachers Only'
    write(1,f4) 'Data','Model','Data','Model','Data','Model','Data','Model'
    write(1,f5) aux_beta(27,1), l_aux_beta_model(27,1), aux_beta(31,1), l_aux_beta_model(31,1), &
         aux_beta(35,1), l_aux_beta_model(35,1), aux_beta(39,1), l_aux_beta_model(39,1), 'Budget Left  '
    write(1,f5) aux_beta(28,1), l_aux_beta_model(28,1), aux_beta(32,1), l_aux_beta_model(32,1), &
         aux_beta(36,1), l_aux_beta_model(36,1), aux_beta(40,1), l_aux_beta_model(40,1), 'Capacity Left'
    write(1,f5) aux_beta(29,1), l_aux_beta_model(29,1), aux_beta(33,1), l_aux_beta_model(33,1), &
         aux_beta(37,1), l_aux_beta_model(37,1), aux_beta(41,1), l_aux_beta_model(41,1), 'Lambda       '
    write(1,f5) aux_beta(30,1), l_aux_beta_model(30,1), aux_beta(34,1), l_aux_beta_model(34,1), &
         aux_beta(38,1), l_aux_beta_model(38,1), aux_beta(42,1), l_aux_beta_model(42,1), 'Intercept    '

    write(1,*) 'Bottom 10% of Teachers'
    write(1,f5) aux_beta(43,1), l_aux_beta_model(43,1), aux_beta(47,1), l_aux_beta_model(47,1), &
         aux_beta(51,1), l_aux_beta_model(51,1), aux_beta(55,1), l_aux_beta_model(55,1), 'Budget Left  '
    write(1,f5) aux_beta(44,1), l_aux_beta_model(44,1), aux_beta(48,1), l_aux_beta_model(48,1), &
         aux_beta(52,1), l_aux_beta_model(52,1), aux_beta(56,1), l_aux_beta_model(56,1), 'Capacity Left'
    write(1,f5) aux_beta(45,1), l_aux_beta_model(45,1), aux_beta(49,1), l_aux_beta_model(49,1), &
         aux_beta(53,1), l_aux_beta_model(53,1), aux_beta(57,1), l_aux_beta_model(57,1), 'Lambda       '
    write(1,f5) aux_beta(46,1), l_aux_beta_model(46,1), aux_beta(50,1), l_aux_beta_model(50,1), &
         aux_beta(54,1), l_aux_beta_model(54,1), aux_beta(58,1), l_aux_beta_model(58,1), 'Intercept    '

    write(1,*) 'All Teachers'
    write(1,f5) aux_beta(59,1), l_aux_beta_model(59,1), aux_beta(63,1), l_aux_beta_model(63,1), &
         aux_beta(67,1), l_aux_beta_model(67,1), aux_beta(71,1), l_aux_beta_model(71,1), 'Budget Left  '
    write(1,f5) aux_beta(60,1), l_aux_beta_model(60,1), aux_beta(64,1), l_aux_beta_model(64,1), &
         aux_beta(68,1), l_aux_beta_model(68,1), aux_beta(72,1), l_aux_beta_model(72,1), 'Capacity Left'
    write(1,f5) aux_beta(61,1), l_aux_beta_model(61,1), aux_beta(65,1), l_aux_beta_model(65,1), &
         aux_beta(69,1), l_aux_beta_model(69,1), aux_beta(73,1), l_aux_beta_model(73,1), 'Lambda       '
    write(1,f5) aux_beta(62,1), l_aux_beta_model(62,1), aux_beta(66,1), l_aux_beta_model(66,1), &
         aux_beta(70,1), l_aux_beta_model(70,1), aux_beta(74,1), l_aux_beta_model(74,1), 'Intercept    '

    close(1)

  end subroutine write_aux_param


  subroutine write_aux_other_param(l_aux_other_model)
    double precision, dimension(naux_other,1), intent(in) :: l_aux_other_model
    !moments
    double precision, dimension(5,4) :: mom1_model, mom1, mom2_model, mom2
    double precision, dimension(2,4) :: mom3_model, mom3, mom4_model, mom4
    double precision                 :: mom5_model, mom5
    double precision, dimension(5)   :: mom6_model, mom6, mom7_model, mom7
    double precision, dimension(2)   :: mom8_model, mom8, mom9_model, mom9, mom10_model, mom10
    double precision, dimension(5)   :: mom11_model, mom11
    double precision, dimension(2,2) :: mom12_model, mom12
    double precision                 :: mom13_model, mom13
    !
    integer, dimension(ndist) :: excess_capacity
    integer :: i,j
    character(len=50) :: f1, f2, f3, f4, f5, f6
    character(len=20), dimension(5) :: mom11desc

    !1
    mom1_model = reshape(l_aux_other_model(1:20,1), (/ 5,4 /))
    mom1       = reshape(aux_other(1:20,1),       (/ 5,4 /))
    !2
    mom2_model = reshape(l_aux_other_model(21:40,1), (/ 5,4 /))
    mom2       = reshape(aux_other(21:40,1)      , (/ 5,4 /))
    !3
    mom3_model = reshape(l_aux_other_model(41:48,1), (/ 2,4 /))
    mom3       = reshape(aux_other(41:48,1)      , (/ 2,4 /))
    !4
    mom4_model = reshape(l_aux_other_model(49:56,1), (/ 2,4 /))
    mom4       = reshape(aux_other(49:56,1)      , (/ 2,4 /))
    !5
    mom5_model = l_aux_other_model(57,1)
    mom5 = aux_other(57,1)
    !6
    mom6_model = l_aux_other_model(58:62,1)
    mom6       = aux_other(58:62,1)
    !7
    mom7_model = l_aux_other_model(63:67,1)
    mom7       = aux_other(63:67,1)       
    !8
    mom8_model = l_aux_other_model(68:69,1)
    mom8       = aux_other(68:69,1)      
    !9
    mom9_model = l_aux_other_model(70:71,1)
    mom9       = aux_other(70:71,1)
    !10
    mom10_model = l_aux_other_model(72:73,1)
    mom10       = aux_other(72:73,1)
    !11
    mom11_model = l_aux_other_model(74:78,1)
    mom11       = aux_other(74:78,1)
    !12
    mom12_model = reshape(l_aux_other_model(79:82,1), (/ 2,2 /))
    mom12       = reshape(aux_other(79:82,1)      , (/ 2,2 /))
    !13
    mom13_model = l_aux_other_model(83,1)
    mom13       = aux_other(83,1)

    !set up output file
    f1 = '(A10,  A10,  A10,  A10,  A10,  A10,  A10,  A10  )'
    f2 = '(F10.5,F10.5,F10.5,F10.5,F10.5,F10.5,F10.5,F10.5)'
    f3 = '(A20,  A10,  A10,  A10,  A10,  A10,  A10,  A10)'
    f4 = '(A20,  F10.5,F10.5,F10.5,F10.5,F10.5,F10.5,F10.5)'
    f5 = '(A25, A8,   A8)'
    f6 = '(A25, F8.2, F8.2)'
    open(2, file = 'result/other_aux_params.txt', status = 'replace')

    !print all teachers moment comparison to text file
    write(2,*)
    write(2,*) ' **** All Teachers **** '
    write(2,*) 
    write(2,*) 'Lambda quintiles (low to high)'
    write(2,f1) 'exp data', 'exp model', 'c1 data', 'c1 model', 'c2 data', 'c2 model', ' MA data', ' MA model'
    do i=1,5
       write(2,f2) mom1(i,1), mom1_model(i,1), mom1(i,2), &
            mom1_model(i,2), mom1(i,3), mom1_model(i,3), mom1(i,4), mom1_model(i,4)
    end do
    write(2,*)
    write(2,*) 'Budget per teacher quintiles (low to high)'
    write(2,f1) 'exp data', 'exp model', 'c1 data', 'c1 model', 'c2 data', 'c2 model', ' MA data', ' MA model'
    do i=1,5
       write(2,f2) mom2(i,1), mom2_model(i,1), mom2(i,2), &
            mom2_model(i,2), mom2(i,3), mom2_model(i,3), mom2(i,4), mom2_model(i,4)
    end do
    write(2,*)
    write(2,*) 'Suburban (1st row) vs. non-suburban (2nd row)'
    write(2,f1) 'exp data', 'exp model', 'c1 data', 'c1 model', 'c2 data', 'c2 model', ' MA data', ' MA model'
    do i=1,2
       write(2,f2) mom3(i,1), mom3_model(i,1), mom3(i,2),&
            mom3_model(i,2), mom3(i,3), mom3_model(i,3), mom3(i,4), mom3_model(i,4)
    end do
    write(2,*)
    write(2,*) 'Urban (1st row) vs. non-urban (2nd row)'
    write(2,f1) 'exp data', 'exp model', 'c1 data', 'c1 model', 'c2 data', 'c2 model', ' MA data', ' MA model'
    do i=1,2
       write(2,f2) mom4(i,1), mom4_model(i,1), mom4(i,2),&
            mom4_model(i,2), mom4(i,3), mom4_model(i,3), mom4(i,4), mom4_model(i,4)
    end do


    ! *** % of districts with only tenured incumbents ***

    !now look between districts that have more slots than incumbents
    excess_capacity = 0 
    do j=1, ndist
       if (T(1,j) .gt. sum(inc(:,j) * tenured(:,j))) then
          excess_capacity(j) = 1
       end if
    end do

 !   !write to file
 !   write(2,*)
 !   write(2,*) '**** Fraction of districts who only employ tenured incumbents ****'
 !   write(2,*)
 !   write(2,*) 'Across all districts'
 !   write(2,f1) 'Data', 'Model'
 !   write(2,f2) mom5, mom5_model
 !   write(2,*)
 !   write(2,*) 'By lambda quintile (low to high)'
 !   write(2,f1) 'Data', 'Model'
 !   do i=1, 5
 !      write(2,f2) mom6(i), mom6_model(i)
 !   end do
 !   write(2,*)
 !   write(2,*) 'Budget per teacher quintiles (low to high)'
 !   write(2,f1) 'Data', 'Model'
 !   do i=1, 5
 !      write(2,f2) mom7(i), mom7_model(i)
 !   end do
 !   write(2,*)
 !   write(2,*) 'Suburban (1st row), non-suburban (2nd row)'
 !   write(2,f1) 'Data', 'Model'
 !   do i=1, 2
 !      write(2,f2) mom8(i), mom8_model(i)
 !   end do
 !   write(2,*)
 !   write(2,*) 'Urban (1st row), non-urban (2nd row)'
 !   write(2,f1) 'Data', 'Model'
 !   do i=1, 2
 !      write(2,f2) mom9(i), mom9_model(i)
 !   end do
 !   write(2,*)
 !   write(2,*) 'Slots > # tenured-incumbent (1st row), else (2nd row).'
 !   write(2,f1) 'Data', 'Model'
 !   do i=1, 2
 !      write(2,f2) mom10(i), mom10_model(i)
 !   end do
 !   write(2,*) '  Note: ',sum(excess_capacity)/real(ndist)*100,'% of districts have slots > tenured-inc'

    !set descriptions for output file
    mom11desc(1) = 'new hires/capacity'
    mom11desc(2) = 'exp'
    mom11desc(3) = 'v1'
    mom11desc(4) = 'v2'
    mom11desc(5) = 'master'

    write(2,*)
    write(2,*) '**** New Hires (including only districts with new hires) ****'
    write(2,*)
    write(2,f3) 'moment', 'data', 'model'
    do i=1, 5
       write(2,f4) mom11desc(i), mom11(i), mom11_model(i)
    end do


    ! adding information on over/under capacity for districts
    !write(2,*)
    !write(2,*) '**** Fraction of districts over/under capacity in MODEL ****'
    !write(2,*)
    !write(2,f5) 'description             ', 'over', 'under'
    !write(2,f6) 'capacity diff > 2       ', mom12_model(1,1), mom12_model(1,2)
    !write(2,f6) 'capacity diff > 20%     ', mom12_model(2,1), mom12_model(2,2)
    ! pr_stayer
    write(2,*)
    write(2,*)'**** Fraction of teachers stay in d0, data vs model ****'
    write(2,f2) mom13, mom13_model
    close(2)

  end subroutine write_aux_other_param




subroutine write_moment_weight_factors(l_aux_d, l_aux_omega_d, l_aux_other_d)
    double precision, intent(in), dimension(naux,1)       :: l_aux_d
    double precision, intent(in), dimension(naux_omega,1) :: l_aux_omega_d
    double precision, intent(in), dimension(naux_other,1)     :: l_aux_other_d

    integer :: i, k

    character(len=50), dimension(naux) :: desc_aux
    character(len=50), dimension(naux_omega) :: desc_aux_omega
    character(len=50), dimension(naux_other) :: desc_aux_other

    character(len=50) :: f1,f2

    !set formats:
    f1 = '(A8, A8, A20  , A20,   A30,   A30,   A50)'
    f2 = '(I8, I8, F20.8, F20.8, F30.8, F30.8, A50)'

    !set descriptions
    desc_aux(1)         = '       sub-offer-logit: wage                      '
    desc_aux(2)         = '       sub-offer-logit: exp(lambda)               '
    desc_aux(3)         = '       sub-offer-logit: C1 * lambda               '
    desc_aux(4)         = '       sub-offer-logit: inc                       '
    desc_aux(5)         = '       sub-offer-logit: inc * exp[1,3]            '
    desc_aux(6)         = '       sub-offer-logit: inc * exp[4,5]            '
    desc_aux(7)         = '       sub-offer-logit: inc * exp[6,10]           '
    desc_aux(8)         = '       sub-offer-logit: inc * exp[11,15]          '
    desc_aux(9)         = '       sub-offer-logit: samecz                    '
    desc_aux(10)        = '       sub-offer-logit: urban                     '
    desc_aux(11)        = '       sub-offer-logit: suburban                  '
    desc_aux(12)        = '       sub-offer-logit: log(dist)                 '
    desc_aux(13)        = '       sub-offer-logit: Milwaukee                 '
    desc_aux(14)        = '       all-offer-logit: wage                      '
    desc_aux(15)        = '       all-offer-logit: exp(lambda)               '
    desc_aux(16)        = '       all-offer-logit: C1 * lambda               '
    desc_aux(17)        = '       all-offer-logit: inc                       '
    desc_aux(18)        = '       all-offer-logit: inc * exp[1,3]            '
    desc_aux(19)        = '       all-offer-logit: inc * exp[4,5]            '
    desc_aux(20)        = '       all-offer-logit: inc * exp[6,10]           '
    desc_aux(21)        = '       all-offer-logit: inc * exp[11,15]          '
    desc_aux(22)        = '       all-offer-logit: samecz                    '
    desc_aux(23)        = '       all-offer-logit: urban                     '
    desc_aux(24)        = '       all-offer-logit: suburban                  '
    desc_aux(25)        = '       all-offer-logit: log(dist)                 '
    desc_aux(26)        = '       all-offer-logit: Milwaukee                 '
    desc_aux(27)        = '       Non-ten, E(exp), Budget Left               '
    desc_aux(28)        = '       Non-ten, E(exp), Capacity Left             '
    desc_aux(29)        = '       Non-ten, E(exp), Lambda                    '
    desc_aux(30)        = '       Non-ten, E(exp), Intercept                 '
    desc_aux(31)        = '       Non-ten, E(master), Budget Left            '
    desc_aux(32)        = '       Non-ten, E(master), Capacity Left          '
    desc_aux(33)        = '       Non-ten, E(master), Lambda                 '
    desc_aux(34)        = '       Non-ten, E(master), Intercept              '
    desc_aux(35)        = '       Non-ten, E(C1), Budget Left                '
    desc_aux(36)        = '       Non-ten, E(C1), Capacity Left              '
    desc_aux(37)        = '       Non-ten, E(C1), Lambda                     '
    desc_aux(38)        = '       Non-ten, E(C1), Intercept                  '
    desc_aux(39)        = '       Non-ten, E(C2), Budget Left                '
    desc_aux(40)        = '       Non-ten, E(C2), Capacity Left              '
    desc_aux(41)        = '       Non-ten, E(C2), Lambda                     '
    desc_aux(42)        = '       Non-ten, E(C2), Intercept                  '
    desc_aux(43)        = '       Bottom-ten, E(exp), Budget Left            '
    desc_aux(44)        = '       Bottom-ten, E(exp), Capacity Left          '
    desc_aux(45)        = '       Bottom-ten, E(exp), Lambda                 '
    desc_aux(46)        = '       Bottom-ten, E(exp), Intercept              '
    desc_aux(47)        = '       Bottom-ten, E(master), Budget Left         '
    desc_aux(48)        = '       Bottom-ten, E(master), Capacity Left       '
    desc_aux(49)        = '       Bottom-ten, E(master), Lambda              '
    desc_aux(50)        = '       Bottom-ten, E(master), Intercept           '
    desc_aux(51)        = '       Bottom-ten, E(C1), Budget Left             '
    desc_aux(52)        = '       Bottom-ten, E(C1), Capacity Left           '
    desc_aux(53)        = '       Bottom-ten, E(C1), Lambda                  '
    desc_aux(54)        = '       Bottom-ten, E(C1), Intercept               '
    desc_aux(55)        = '       Bottom-ten, E(C2), Budget Left             '
    desc_aux(56)        = '       Bottom-ten, E(C2), Capacity Left           '
    desc_aux(57)        = '       Bottom-ten, E(C2), Lambda                  '
    desc_aux(58)        = '       Bottom-ten, E(C2), Intercept               '
    desc_aux(59)        = '       All teach, E(exp), Budget Left             '
    desc_aux(60)        = '       All teach, E(exp), Capacity Left           '
    desc_aux(61)        = '       All teach, E(exp), Lambda                  '
    desc_aux(62)        = '       All teach, E(exp), Intercept               '
    desc_aux(63)        = '       All teach, E(master), Budget Left          '
    desc_aux(64)        = '       All teach, E(master), Capacity Left        '
    desc_aux(65)        = '       All teach, E(master), Lambda               '
    desc_aux(66)        = '       All teach, E(master), Intercept            '
    desc_aux(67)        = '       All teach, E(C1), Budget Left              '
    desc_aux(68)        = '       All teach, E(C1), Capacity Left            '
    desc_aux(69)        = '       All teach, E(C1), Lambda                   '
    desc_aux(70)        = '       All teach, E(C1), Intercept                '
    desc_aux(71)        = '       All teach, E(C2), Budget Left              '
    desc_aux(72)        = '       All teach, E(C2), Capacity Left            '
    desc_aux(73)        = '       All teach, E(C2), Lambda                   '
    desc_aux(74)        = '       All teach, E(C2), Intercept                '
    !omega moments      
    desc_aux_omega(1)   = '       omega1 reg, Exp3                           '
    desc_aux_omega(2)   = '       omega1 reg, Exp4                           '
    desc_aux_omega(3)   = '       omega1 reg, Exp5                           '
    desc_aux_omega(4)   = '       omega1 reg, Exp6                           '
    desc_aux_omega(5)   = '       omega1 reg, master                         '
    desc_aux_omega(6)   = '       omega1 reg, lambda                         '
    desc_aux_omega(7)   = '       omega1 reg, tc                             '
    desc_aux_omega(8)   = '       omega1 reg, tc_tenured                     '
    desc_aux_omega(9)   = '       omega1 reg, budget_pc                      '
    desc_aux_omega(10)  = '       omega1 reg, capacity                       '
    desc_aux_omega(11)  = '       omega1 reg, urban                          '
    desc_aux_omega(12)  = '       omega1 reg, suburban                       '
    desc_aux_omega(13)  = '       omega1 reg, milwaukee                      '
    desc_aux_omega(14)  = '       omega1 reg, cz_tc                          '
    desc_aux_omega(15)  = '       omega1 reg, cz share ten                   '
    desc_aux_omega(16)  = '       omega1 reg, share dem vote                 '
    desc_aux_omega(17)  = '       omega1 reg, intercept                      '
    desc_aux_omega(18)  = '       omega2 reg, Exp3                           '
    desc_aux_omega(19)  = '       omega2 reg, Exp4                           '
    desc_aux_omega(20)  = '       omega2 reg, Exp5                           '
    desc_aux_omega(21)  = '       omega2 reg, Exp6                           '
    desc_aux_omega(22)  = '       omega2 reg, master                         '
    desc_aux_omega(23)  = '       omega2 reg, lambda                         '
    desc_aux_omega(24)  = '       omega2 reg, tc                             '
    desc_aux_omega(25)  = '       omega2 reg, tc_tenured                     '
    desc_aux_omega(26)  = '       omega2 reg, budget_pc                      '
    desc_aux_omega(27)  = '       omega2 reg, capacity                       '
    desc_aux_omega(28)  = '       omega2 reg, urban                          '
    desc_aux_omega(29)  = '       omega2 reg, suburban                       '
    desc_aux_omega(30)  = '       omega2 reg, milwaukee                      '
    desc_aux_omega(31)  = '       omega2 reg, cz_tc                          '
    desc_aux_omega(32)  = '       omega2 reg, cz share ten                   '
    desc_aux_omega(33)  = '       omega2 reg, share dem vote                 '
    desc_aux_omega(34)  = '       omega2 reg, intercept                      '
    desc_aux_omega(35)  = '       E(omega1)                                  '
    desc_aux_omega(36)  = '       E(omega2)                                  '
    desc_aux_omega(37)  = '       E(omega1*omega2)                           '
    desc_aux_omega(38)  = '       E(omega1^2)                                '
    desc_aux_omega(39)  = '       E(omega2^2)                                '
    desc_aux_omega(40)  = '       pr(omega1=1)                               '
    desc_aux_omega(41)  = '       pr(omega1=2)                               '
    desc_aux_omega(42)  = '       pr(omega1=3)                               '
    desc_aux_omega(43)  = '       pr(omega1=4)                               '
    desc_aux_omega(44)  = '       pr(omega1=5)                               '
    desc_aux_omega(45)  = '       pr(omega2=1)                               '
    desc_aux_omega(46)  = '       pr(omega2=2)                               '
    desc_aux_omega(47)  = '       pr(omega2=3)                               '
    desc_aux_omega(48)  = '       pr(omega2=4)                               '
    desc_aux_omega(49)  = '       pr(omega2=5)                               '
    desc_aux_omega(50)  = '       pr(omega2=6)                               '
    desc_aux_omega(51)  = '       pr(omega2=7)                               '
    desc_aux_omega(52)  = '       pr(omegas OLD)                             '
    desc_aux_omega(53)  = '       E(omega1 x dem)                            '
    desc_aux_omega(54)  = '       E(omega2 x dem)                            '
    desc_aux_omega(55)  = '       E(omega1 | dem >= med)                     '
    desc_aux_omega(56)  = '       E(omega  | dem >= med)                     '
    !sim/calib moments
    desc_aux_other(1)   = '       Lambda quintiles (low):  exp               '
    desc_aux_other(2)   = '       Lambda quintiles:        exp               '
    desc_aux_other(3)   = '       Lambda quintiles:        exp               '
    desc_aux_other(4)   = '       Lambda quintiles:        exp               '
    desc_aux_other(5)   = '       Lambda quintiles (high): exp               '
    desc_aux_other(6)   = '       Lambda quintiles (low):  v1                '
    desc_aux_other(7)   = '       Lambda quintiles:        v1                '
    desc_aux_other(8)   = '       Lambda quintiles:        v1                '
    desc_aux_other(9)   = '       Lambda quintiles:        v1                '
    desc_aux_other(10)  = '       Lambda quintiles (high): v1                '
    desc_aux_other(11)  = '       Lambda quintiles (low):  v2                '
    desc_aux_other(12)  = '       Lambda quintiles:        v2                '
    desc_aux_other(13)  = '       Lambda quintiles:        v2                '
    desc_aux_other(14)  = '       Lambda quintiles:        v2                '
    desc_aux_other(15)  = '       Lambda quintiles (high): v2                '
    desc_aux_other(16)  = '       Lambda quintiles (low):  masters           '
    desc_aux_other(17)  = '       Lambda quintiles:        masters           '
    desc_aux_other(18)  = '       Lambda quintiles:        masters           '
    desc_aux_other(19)  = '       Lambda quintiles:        masters           '
    desc_aux_other(20)  = '       Lambda quintiles (high): masters           '
    desc_aux_other(21)  = '       budget/capacity (low):  exp                '
    desc_aux_other(22)  = '       budget/capacity:        exp                '
    desc_aux_other(23)  = '       budget/capacity:        exp                '
    desc_aux_other(24)  = '       budget/capacity:        exp                '
    desc_aux_other(25)  = '       budget/capacity (high): exp                '
    desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
    desc_aux_other(27)  = '       budget/capacity:        v1                 '
    desc_aux_other(28)  = '       budget/capacity:        v1                 '
    desc_aux_other(29)  = '       budget/capacity:        v1                 '
    desc_aux_other(30)  = '       budget/capacity (high): v1                 '
    desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
    desc_aux_other(32)  = '       budget/capacity:        v2                 '
    desc_aux_other(33)  = '       budget/capacity:        v2                 '
    desc_aux_other(34)  = '       budget/capacity:        v2                 '
    desc_aux_other(35)  = '       budget/capacity (high): v2                 '
    desc_aux_other(36)  = '       budget/capacity (low):  masters            '
    desc_aux_other(37)  = '       budget/capacity:        masters            '
    desc_aux_other(38)  = '       budget/capacity:        masters            '
    desc_aux_other(39)  = '       budget/capacity:        masters            '
    desc_aux_other(40)  = '       budget/capacity (high): masters            '
    desc_aux_other(41)  = '       suburban: exp                              '
    desc_aux_other(42)  = '       non-subu: exp                              '
    desc_aux_other(43)  = '       suburban: v1                               '
    desc_aux_other(44)  = '       non-subu: v1                               '
    desc_aux_other(45)  = '       suburban: v2                               '
    desc_aux_other(46)  = '       non-subu: v2                               '
    desc_aux_other(47)  = '       suburban: masters                          '
    desc_aux_other(48)  = '       non-subu: masters                          '
    desc_aux_other(49)  = '       urban:     exp                             '
    desc_aux_other(50)  = '       non-urban: exp                             '
    desc_aux_other(51)  = '       urban:     v1                              '
    desc_aux_other(52)  = '       non-urban: v1                              '
    desc_aux_other(53)  = '       urban:     v2                              '
    desc_aux_other(54)  = '       non-urban: v2                              '
    desc_aux_other(55)  = '       urban:     masters                         '
    desc_aux_other(56)  = '       non-urban: masters                         '
    desc_aux_other(57)  = '       fraction empl only ten-inc: All dist       '        
    desc_aux_other(58)  = '       fraction empl only ten-inc: lambda (low)   '
    desc_aux_other(59)  = '       fraction empl only ten-inc: lambda         '
    desc_aux_other(60)  = '       fraction empl only ten-inc: lambda         '
    desc_aux_other(61)  = '       fraction empl only ten-inc: lambda         '
    desc_aux_other(62)  = '       fraction empl only ten-inc: lambda (high)  '
    desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity' 
    desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity' 
    desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity' 
    desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity' 
    desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity' 
    desc_aux_other(68)  = '       fraction empl only ten-inc: suburban       '       
    desc_aux_other(69)  = '       fraction empl only ten-inc: non-subu       '       
    desc_aux_other(70)  = '       fraction empl only ten-inc: urban          '       
    desc_aux_other(71)  = '       fraction empl only ten-inc: non-urban      '       
    desc_aux_other(72)  = '       fraction empl only ten-inc: slots>ten-inc  '   
    desc_aux_other(73)  = '       fraction empl only ten-inc: slots<ten-inc  '   
    desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '
    desc_aux_other(75)  = '       dist w/ new hires: exp                     '
    desc_aux_other(76)  = '       dist w/ new hires: v1                      '
    desc_aux_other(77)  = '       dist w/ new hires: v2                      '
    desc_aux_other(78)  = '       dist w/ new hires: masters                 '
    desc_aux_other(79)  = '       Fraction >2   over capacity                '          
    desc_aux_other(80)  = '       Fraction >20% over capacity                '          
    desc_aux_other(81)  = '       Fraction >2   under capacity               '          
    desc_aux_other(82)  = '       Fraction >20% under capacity               '
    desc_aux_other(83)  = '       Fraction d=d0, stayers across teacher      '

    open(55,file='moment_weight_factors.txt', status='replace')
    write(55,f1) 'Target #', 'index', 'Unwtd Distance', 'Target Value', &
         'Weight', 'Mul Factor', 'Description of target:                     '

    !aux moments
    k=1
    do i=1, naux
       write(55,f2) k, i, l_aux_d(i,1), aux_beta(i,1),weight_mat(i,i)/aux_weight_factor(i,1), &
            aux_weight_factor(i,1), desc_aux(i)
       k=k+1
    end do

    !omega aux moments
    do i=1, naux_omega
       write(55,f2) k, i, l_aux_omega_d(i,1), aux_omega(i,1), omega_weight_mat(i,i)/omega_weight_factor(i,1), &
            omega_weight_factor(i,1), desc_aux_omega(i)
       k=k+1
    end do

    !'sim'/calib moments
    do i=1, naux_other
       write(55,f2) k, i, l_aux_other_d(i,1), aux_other(i,1), other_weight_mat(i,i)/other_weight_factor(i,1), &
            other_weight_factor(i,1), desc_aux_other(i)
       k=k+1
    end do


    close(55)


  end subroutine write_moment_weight_factors


  
  

end module write_moments

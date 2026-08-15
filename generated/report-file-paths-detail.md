## Filepaths Analysis Details

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/main.f90**

- Line 38, unix : ! entry/exit
- Line 76, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi
- Line 175, unix : !    - c1/c2
- Line 182, unix : open(1, file = 'result/entryexit_stats.txt', status = 'replace')
- Line 215, unix : ! If after first period we have to move things forward and draw entrants/exits
- Line 244, unix : ! adjust c1/c2, only needs to happen if changing experience group
- Line 281, unix : !  (altho this requires share_low, share_low isn't affected by changing c1/c2)
- Line 318, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 356, unix : ! Second, adjust exit prob b/c of wage_change
- Line 395, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 455, unix : ! Here we calculate the expected number of entrants/exits across economies
- Line 490, unix : ! save incumbents in the data b/c we will need to reallocate these arrays
- Line 536, unix : ! And we also have to save the district info... b/c these get expanded as well
- Line 624, unix : open(1, file = 'result/entryexit_stats.txt', action='write', position='append')
- Line 732, unix : ! for incumbents, b/c pop changes, we need to recalc baseline wage each period, so keep omegas
- Line 737, unix : ! for entrants, b/c pop is static, we can calculate a base wage now.
- Line 741, unix : ! Don't need to do this for incumbents b/c the pop will change so we will work with omegas for them

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/estimation_result/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/main.f90**

- Line 38, unix : ! entry/exit
- Line 76, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi
- Line 175, unix : !    - c1/c2
- Line 182, unix : open(1, file = 'result/entryexit_stats.txt', status = 'replace')
- Line 215, unix : ! If after first period we have to move things forward and draw entrants/exits
- Line 244, unix : ! adjust c1/c2, only needs to happen if changing experience group
- Line 281, unix : !  (altho this requires share_low, share_low isn't affected by changing c1/c2)
- Line 318, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 356, unix : ! Second, adjust exit prob b/c of wage_change
- Line 395, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 458, unix : ! Here we calculate the expected number of entrants/exits across economies
- Line 492, unix : ! save incumbents in the data b/c we will need to reallocate these arrays
- Line 538, unix : ! And we also have to save the district info... b/c these get expanded as well
- Line 626, unix : open(1, file = 'result/entryexit_stats.txt', action='write', position='append')
- Line 734, unix : ! for incumbents, b/c pop changes, we need to recalc baseline wage each period, so keep omegas
- Line 739, unix : ! for entrants, b/c pop is static, we can calculate a base wage now.
- Line 743, unix : ! Don't need to do this for incumbents b/c the pop will change so we will work with omegas for them

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_B19.do**

- Line 28, unix : forval col = 1/4 {
- Line 208, unix : forval col = 1/4 {
- Line 216, unix : forval row = 1/7 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/main.f90**

- Line 38, unix : ! entry/exit
- Line 76, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi
- Line 175, unix : !    - c1/c2
- Line 182, unix : open(1, file = 'result/entryexit_stats.txt', status = 'replace')
- Line 215, unix : ! If after first period we have to move things forward and draw entrants/exits
- Line 244, unix : ! adjust c1/c2, only needs to happen if changing experience group
- Line 281, unix : !  (altho this requires share_low, share_low isn't affected by changing c1/c2)
- Line 318, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 356, unix : ! Second, adjust exit prob b/c of wage_change
- Line 395, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 455, unix : ! Here we calculate the expected number of entrants/exits across economies
- Line 490, unix : ! save incumbents in the data b/c we will need to reallocate these arrays
- Line 536, unix : ! And we also have to save the district info... b/c these get expanded as well
- Line 624, unix : open(1, file = 'result/entryexit_stats.txt', action='write', position='append')
- Line 732, unix : ! for incumbents, b/c pop changes, we need to recalc baseline wage each period, so keep omegas
- Line 737, unix : ! for entrants, b/c pop is static, we can calculate a base wage now.
- Line 741, unix : ! Don't need to do this for incumbents b/c the pop will change so we will work with omegas for them

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/estimation_result/objective.f90**

- Line 276, unix : open(44, file = 'result/omega2_probs.txt', status='replace')

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/validation_result/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/read_data_params.f90**

- Line 57, unix : r_vec = 0 !this is set later, b/c we need to know lambda (share_low)
- Line 133, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 152, unix : !b5/b6/b7/b8 rely on svec
- Line 208, unix : param0(i)=1.0d-0/step(j)
- Line 514, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 520, unix : !skip first line b/c it is varname
- Line 525, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 531, unix : !weights for fraction over/under capacity
- Line 592, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 847, unix : ! Moved this to gen teacher data, b/c has nteach dimension
- Line 874, unix : idx = ndist/2   !integer division rounds
- Line 990, unix : !   b/c I randomly don't match some, there is no pattern of unmatching
- Line 1067, unix : !  for now, ignoring the 'pre' code, b/c irrelevant for forward iteration
- Line 1224, unix : !  we match as of 10/13/23
- Line 1255, unix : ! we match as of 10/13/23, except for one person, i=1870, who is an entrant, but somehow had a samecz value.
- Line 1348, unix : ! we are matching as of 10/13/23, although not in floats, some roundings are different
- Line 1369, unix : ! made this work as a portable function only using local variables here b/c
- Line 1498, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1513, unix : ! made this work as a portable function only using local variables here b/c
- Line 1660, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1861, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/inner_loop_one.f90**

- Line 111, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 255, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 260, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 263, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 269, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 273, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 282, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 283, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 284, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 307, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 317, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 352, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 354, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 358, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 593, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 600, unix : allocate(waget(nteach,rec_count/nteach))
- Line 604, unix : allocate(inct(nteach,rec_count/nteach))
- Line 608, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 618, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 619, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 620, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 634, unix : !pass/receive H across threads
- Line 641, unix : do j=1, rec_count/nteach
- Line 663, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 670, unix : !double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 680, unix : allocate(Ht_vary(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 706, unix : do j=1, rec_count/nteach!85,85
- Line 844, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 869, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 886, unix : !initialize vars help to print information to terminal/txt files...
- Line 893, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 899, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 903, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 907, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 911, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 916, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 931, unix : !XXX: in economy-by-economy version this is overwritten/is garbage at this point here
- Line 967, unix : ! reading main should be redundant, b/c period 1 is same as baseline so should be at same converged value
- Line 968, unix : !    but for consistency will just read in... only wage gets adj b/c subsidy
- Line 1033, unix : !     sure theta0 gets reset for this bug cehck, so remove the below 21/22 later.
- Line 1279, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1282, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1299, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1303, unix : open(1,file='result/eqbm_omegas.txt',action='write',position='append')
- Line 1501, unix : !now calc target H, mean/sd wage
- Line 1563, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1564, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1565, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1623, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1635, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1647, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1805, unix : !double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1807, unix : !double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1809, unix : !double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1811, unix : !integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1826, unix : allocate(waget_eqm(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 1827, unix : allocate(Ht_vary(nteach,rec_count/nteach), Ht_eqm(nteach,rec_count/nteach))
- Line 1828, unix : allocate(pr_omegast_eqm(NWgrid1,NWgrid2,rec_count/nteach))
- Line 1829, unix : allocate(omegast_eqm(2,rec_count/nteach))
- Line 1830, unix : allocate(offert_eqm(nteach,rec_count/nteach))
- Line 1854, unix : do j=1, rec_count/nteach
- Line 2152, unix : ! (sorry this is a bastardization b/c code was never meant to have forward iter feature)
- Line 2164, unix : ! Don't need to broadcast these b/c not economy specific right now, they are all determined in main
- Line 2210, unix : ! b/c of weirdness injected b/c we had to do the forward iteration, all of the logic is off

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/2_rigid/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/read_data_params.f90**

- Line 57, unix : r_vec = 0 !this is set later, b/c we need to know lambda (share_low)
- Line 133, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 152, unix : !b5/b6/b7/b8 rely on svec
- Line 208, unix : param0(i)=1.0d-0/step(j)
- Line 514, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 520, unix : !skip first line b/c it is varname
- Line 525, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 531, unix : !weights for fraction over/under capacity
- Line 592, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 847, unix : ! Moved this to gen teacher data, b/c has nteach dimension
- Line 874, unix : idx = ndist/2   !integer division rounds
- Line 990, unix : !   b/c I randomly don't match some, there is no pattern of unmatching
- Line 1067, unix : !  for now, ignoring the 'pre' code, b/c irrelevant for forward iteration
- Line 1224, unix : !  we match as of 10/13/23
- Line 1255, unix : ! we match as of 10/13/23, except for one person, i=1870, who is an entrant, but somehow had a samecz value.
- Line 1348, unix : ! we are matching as of 10/13/23, although not in floats, some roundings are different
- Line 1369, unix : ! made this work as a portable function only using local variables here b/c
- Line 1498, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1513, unix : ! made this work as a portable function only using local variables here b/c
- Line 1660, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1861, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/auxiliary_regressions/auxiliary_models_teachers_nobottom.do**

- Line 136, unix : forvalues n = 2/6 {
- Line 168, unix : forvalues n = 2/6 {
- Line 190, unix : forvalues n = 2/6 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 757, unix : !initialize vars help to print information to terminal/txt files...
- Line 763, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 774, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 777, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 781, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 790, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 894, unix : ! need to introduce something to avoid NAs here b/c we were making thetas == 0 so can't do pct change like this
- Line 1069, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1072, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1085, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1245, unix : !now calc target H, mean/sd wage
- Line 1297, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1298, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1299, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1351, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1361, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1372, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1482, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1483, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1500, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1501, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1502, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1503, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1534, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/aux_district_noninc3_JPE.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 34, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 757, unix : !initialize vars help to print information to terminal/txt files...
- Line 763, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 774, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 777, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 781, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 790, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 894, unix : ! need to introduce something to avoid NAs here b/c we were making thetas == 0 so can't do pct change like this
- Line 1069, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1072, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1085, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1245, unix : !now calc target H, mean/sd wage
- Line 1297, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1298, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1299, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1351, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1361, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1372, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1482, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1483, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1500, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1501, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1502, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1503, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1534, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/synthetic_data/code/00_project_globals.do**

- Line 4, unix : Public synthetic/simulated-data globals.
- Line 9, unix : do synthetic_data/code/make_simulated_data.do

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/main.f90**

- Line 38, unix : ! entry/exit
- Line 76, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi
- Line 175, unix : !    - c1/c2
- Line 182, unix : open(1, file = 'result/entryexit_stats.txt', status = 'replace')
- Line 215, unix : ! If after first period we have to move things forward and draw entrants/exits
- Line 244, unix : ! adjust c1/c2, only needs to happen if changing experience group
- Line 281, unix : !  (altho this requires share_low, share_low isn't affected by changing c1/c2)
- Line 318, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 356, unix : ! Second, adjust exit prob b/c of wage_change
- Line 395, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 455, unix : ! Here we calculate the expected number of entrants/exits across economies
- Line 490, unix : ! save incumbents in the data b/c we will need to reallocate these arrays
- Line 536, unix : ! And we also have to save the district info... b/c these get expanded as well
- Line 624, unix : open(1, file = 'result/entryexit_stats.txt', action='write', position='append')
- Line 732, unix : ! for incumbents, b/c pop changes, we need to recalc baseline wage each period, so keep omegas
- Line 737, unix : ! for entrants, b/c pop is static, we can calculate a base wage now.
- Line 741, unix : ! Don't need to do this for incumbents b/c the pop will change so we will work with omegas for them

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/summary.do**

- Line 169, unix : gen budget_pc = budget/cap
- Line 234, unix : gen budget_pc = budget/capacity

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/utility_functions.f90**

- Line 31, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 90, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/global_variables.f90**

- Line 104, unix : ! XX only need to add these if entry/exit is economy specific

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/utility_functions.f90**

- Line 31, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 90, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/perturbation/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/stderr/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/aux_district_all2_JPE.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 34, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/utility_functions.f90**

- Line 31, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 90, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/read_data_params.f90**

- Line 57, unix : r_vec = 0 !this is set later, b/c we need to know lambda (share_low)
- Line 133, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 152, unix : !b5/b6/b7/b8 rely on svec
- Line 208, unix : param0(i)=1.0d-0/step(j)
- Line 514, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 520, unix : !skip first line b/c it is varname
- Line 525, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 531, unix : !weights for fraction over/under capacity
- Line 592, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 847, unix : ! Moved this to gen teacher data, b/c has nteach dimension
- Line 874, unix : idx = ndist/2   !integer division rounds
- Line 990, unix : !   b/c I randomly don't match some, there is no pattern of unmatching
- Line 1067, unix : !  for now, ignoring the 'pre' code, b/c irrelevant for forward iteration
- Line 1224, unix : !  we match as of 10/13/23
- Line 1255, unix : ! we match as of 10/13/23, except for one person, i=1870, who is an entrant, but somehow had a samecz value.
- Line 1348, unix : ! we are matching as of 10/13/23, although not in floats, some roundings are different
- Line 1369, unix : ! made this work as a portable function only using local variables here b/c
- Line 1498, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1513, unix : ! made this work as a portable function only using local variables here b/c
- Line 1660, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1861, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/inner_loop_one.f90**

- Line 111, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 255, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 260, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 263, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 269, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 273, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 282, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 283, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 284, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 307, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 317, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 352, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 354, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 358, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 593, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 600, unix : allocate(waget(nteach,rec_count/nteach))
- Line 604, unix : allocate(inct(nteach,rec_count/nteach))
- Line 608, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 618, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 619, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 620, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 634, unix : !pass/receive H across threads
- Line 641, unix : do j=1, rec_count/nteach
- Line 663, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 670, unix : !double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 680, unix : allocate(Ht_vary(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 706, unix : do j=1, rec_count/nteach!85,85
- Line 844, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 869, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 886, unix : !initialize vars help to print information to terminal/txt files...
- Line 893, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 899, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 903, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 907, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 911, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 916, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 931, unix : !XXX: in economy-by-economy version this is overwritten/is garbage at this point here
- Line 967, unix : ! reading main should be redundant, b/c period 1 is same as baseline so should be at same converged value
- Line 968, unix : !    but for consistency will just read in... only wage gets adj b/c subsidy
- Line 1033, unix : !     sure theta0 gets reset for this bug cehck, so remove the below 21/22 later.
- Line 1279, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1282, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1299, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1303, unix : open(1,file='result/eqbm_omegas.txt',action='write',position='append')
- Line 1501, unix : !now calc target H, mean/sd wage
- Line 1563, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1564, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1565, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1623, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1635, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1647, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1805, unix : !double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1807, unix : !double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1809, unix : !double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1811, unix : !integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1826, unix : allocate(waget_eqm(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 1827, unix : allocate(Ht_vary(nteach,rec_count/nteach), Ht_eqm(nteach,rec_count/nteach))
- Line 1828, unix : allocate(pr_omegast_eqm(NWgrid1,NWgrid2,rec_count/nteach))
- Line 1829, unix : allocate(omegast_eqm(2,rec_count/nteach))
- Line 1830, unix : allocate(offert_eqm(nteach,rec_count/nteach))
- Line 1854, unix : do j=1, rec_count/nteach
- Line 2152, unix : ! (sorry this is a bastardization b/c code was never meant to have forward iter feature)
- Line 2164, unix : ! Don't need to broadcast these b/c not economy specific right now, they are all determined in main
- Line 2210, unix : ! b/c of weirdness injected b/c we had to do the forward iteration, all of the logic is off

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/belief_functions.f90**

- Line 124, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/inner_loop_one.f90**

- Line 111, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 255, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 260, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 263, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 269, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 273, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 282, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 283, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 284, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 307, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 317, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 352, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 354, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 358, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 593, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 600, unix : allocate(waget(nteach,rec_count/nteach))
- Line 604, unix : allocate(inct(nteach,rec_count/nteach))
- Line 608, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 618, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 619, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 620, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 634, unix : !pass/receive H across threads
- Line 641, unix : do j=1, rec_count/nteach
- Line 663, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 670, unix : !double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 680, unix : allocate(Ht_vary(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 706, unix : do j=1, rec_count/nteach!85,85
- Line 844, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 869, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 886, unix : !initialize vars help to print information to terminal/txt files...
- Line 893, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 899, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 903, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 907, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 911, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 916, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 931, unix : !XXX: in economy-by-economy version this is overwritten/is garbage at this point here
- Line 967, unix : ! reading main should be redundant, b/c period 1 is same as baseline so should be at same converged value
- Line 968, unix : !    but for consistency will just read in... only wage gets adj b/c subsidy
- Line 1033, unix : !     sure theta0 gets reset for this bug cehck, so remove the below 21/22 later.
- Line 1279, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1282, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1299, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1303, unix : open(1,file='result/eqbm_omegas.txt',action='write',position='append')
- Line 1501, unix : !now calc target H, mean/sd wage
- Line 1563, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1564, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1565, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1623, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1635, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1647, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1805, unix : !double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1807, unix : !double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1809, unix : !double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1811, unix : !integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1826, unix : allocate(waget_eqm(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 1827, unix : allocate(Ht_vary(nteach,rec_count/nteach), Ht_eqm(nteach,rec_count/nteach))
- Line 1828, unix : allocate(pr_omegast_eqm(NWgrid1,NWgrid2,rec_count/nteach))
- Line 1829, unix : allocate(omegast_eqm(2,rec_count/nteach))
- Line 1830, unix : allocate(offert_eqm(nteach,rec_count/nteach))
- Line 1854, unix : do j=1, rec_count/nteach
- Line 2152, unix : ! (sorry this is a bastardization b/c code was never meant to have forward iter feature)
- Line 2164, unix : ! Don't need to broadcast these b/c not economy specific right now, they are all determined in main
- Line 2210, unix : ! b/c of weirdness injected b/c we had to do the forward iteration, all of the logic is off

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/perturbation/read_data_params.f90**

- Line 112, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 184, unix : param0(i)=1.0d-0/step(j)
- Line 490, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 496, unix : !skip first line b/c it is varname
- Line 501, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 507, unix : !weights for fraction over/under capacity
- Line 568, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 591, unix : auxvar(i) = 1/weight_mat(i,i) ! for SE calc
- Line 595, unix : aux_omegavar(i) = 1/omega_weight_mat(i,i) ! for SE calc
- Line 599, unix : aux_othervar(i) = 1/other_weight_mat(i,i) ! for SE calc
- Line 814, unix : idx = ndist/2   !integer division rounds
- Line 1061, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/read_data_params.f90**

- Line 57, unix : r_vec = 0 !this is set later, b/c we need to know lambda (share_low)
- Line 133, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 152, unix : !b5/b6/b7/b8 rely on svec
- Line 208, unix : param0(i)=1.0d-0/step(j)
- Line 514, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 520, unix : !skip first line b/c it is varname
- Line 525, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 531, unix : !weights for fraction over/under capacity
- Line 592, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 847, unix : ! Moved this to gen teacher data, b/c has nteach dimension
- Line 874, unix : idx = ndist/2   !integer division rounds
- Line 990, unix : !   b/c I randomly don't match some, there is no pattern of unmatching
- Line 1067, unix : !  for now, ignoring the 'pre' code, b/c irrelevant for forward iteration
- Line 1224, unix : !  we match as of 10/13/23
- Line 1255, unix : ! we match as of 10/13/23, except for one person, i=1870, who is an entrant, but somehow had a samecz value.
- Line 1348, unix : ! we are matching as of 10/13/23, although not in floats, some roundings are different
- Line 1369, unix : ! made this work as a portable function only using local variables here b/c
- Line 1498, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1513, unix : ! made this work as a portable function only using local variables here b/c
- Line 1660, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1861, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/validation_result/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/estimation_result/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/build_model_dataset_info1.do**

- Line 150, unix : forvalues n = 1/6 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/belief_functions.f90**

- Line 124, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/global_variables.f90**

- Line 104, unix : ! XX only need to add these if entry/exit is economy specific

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/stderr/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 245, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 253, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 256, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 259, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 263, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 272, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 273, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 274, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 297, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 307, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 338, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 340, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 344, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 513, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 517, unix : allocate(waget(nteach,rec_count/nteach))
- Line 521, unix : allocate(inct(nteach,rec_count/nteach))
- Line 525, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 535, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 536, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 537, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 546, unix : !pass/receive H across threads
- Line 553, unix : do j=1, rec_count/nteach
- Line 574, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 581, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 608, unix : do j=1, rec_count/nteach!85,85
- Line 734, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 753, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 760, unix : !initialize vars help to print information to terminal/txt files...
- Line 766, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 774, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 777, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 780, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 784, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 793, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1050, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1053, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1066, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1226, unix : !now calc target H, mean/sd wage
- Line 1272, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1273, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1274, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1326, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1336, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1347, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1457, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1458, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1475, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1476, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1477, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1478, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1509, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/global_variables.f90**

- Line 104, unix : ! XX only need to add these if entry/exit is economy specific

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/1_baseline/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/auxiliary_models_teachers_info_matches.do**

- Line 27, unix : forvalues info_version = 0/3 {
- Line 83, unix : save $info/multinomial_info`info_version'.dta, replace
- Line 91, unix : forvalues info_version = 0/3 {
- Line 98, unix : forvalues n = 2/6 {
- Line 158, unix : forvalues n = 2/6 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/utility_functions.f90**

- Line 31, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 90, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 177, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 773, unix : !by lambda and b/t quintiles.
- Line 809, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/produce_exhibits.do**

- Line 52, unix : do $code/descriptives/Figure_4.do
- Line 56, unix : do $code/Figure_B9/Figure_B9.do
- Line 64, unix : do $code/descriptives/Table_5_Table_A1.do
- Line 67, unix : do $code/descriptives/Table_6.do
- Line 70, unix : do $code/descriptives/Table_7.do
- Line 73, unix : do $code/descriptives/Table_8.do
- Line 76, unix : do $code/descriptives/Table_A2.do
- Line 79, unix : do $code/descriptives/Table_A3_PanelA.do
- Line 80, unix : do $code/descriptives/Table_A3_PanelB.do
- Line 83, unix : do $code/descriptives/Table_B14.do
- Line 86, unix : do $code/descriptives/Table_B15.do
- Line 89, unix : do $code/descriptives/Table_B16.do
- Line 92, unix : do $code/descriptives/Table_B17.do
- Line 95, unix : do $code/descriptives/Table_B18.do
- Line 98, unix : do $code/descriptives/Table_B19.do
- Line 101, unix : do $code/descriptives/Table_B20.do
- Line 104, unix : do $code/descriptives/Table_B22.do
- Line 107, unix : do $code/descriptives/Table_B23.do
- Line 110, unix : do $code/descriptives/Table_B24.do
- Line 113, unix : do $code/descriptives/Table_B25.do

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/estimation_result/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 177, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 773, unix : !by lambda and b/t quintiles.
- Line 809, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/perturbation/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 177, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 773, unix : !by lambda and b/t quintiles.
- Line 809, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/belief_functions.f90**

- Line 124, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/synthetic_data/code/03_validate_synthetic_structure.do**

- Line 10, unix : Public validation for simulated/synthetic raw files.
- Line 20, unix : do synthetic_data/code/00_project_globals.do
- Line 23, unix : do code/00_project_globals.do
- Line 296, unix : forvalues yr = 2007/2016 {
- Line 349, unix : forvalues yr = 2006/2016 {
- Line 407, unix : do $code/build/oldteacher_roster_build.do
- Line 408, unix : do $code/build/staff_build.do
- Line 409, unix : do $code/build/teachers_build.do
- Line 410, unix : do $code/build/teachers_panel.do
- Line 411, unix : do $code/build/va_teacherside_build.do
- Line 420, unix : do $code/build/testscores_build.do
- Line 421, unix : do $code/build/valueadded_calculation.do
- Line 422, unix : do $code/build/valueadded_calculation_classmodel.do
- Line 423, unix : do $code/build/valueadded_calculation_stockstaiger_nocomparativeadv.do
- Line 424, unix : do $code/build/teachers_with_allva.do
- Line 425, unix : do $code/build/schedule_new.do
- Line 434, unix : do $code/build/gen_omegas.do
- Line 435, unix : do $code/build/gen_omegas_info.do
- Line 436, unix : do $code/build/build_model_dataset.do
- Line 508, unix : do $code/build/build_teachers_offer_set.do
- Line 513, unix : do $code/build/build_model_dataset_info0.do
- Line 514, unix : do $code/build/build_model_dataset_info1.do
- Line 515, unix : do $code/build/build_model_dataset_info2.do
- Line 516, unix : do $code/build/build_model_dataset_info3.do
- Line 517, unix : do $code/build/auxiliary_models_teachers_info_matches.do
- Line 571, unix : do $code/auxiliary_regressions/auxiliary_models_teachers_info.do
- Line 629, unix : do $code/build/omega_databuild.do
- Line 630, unix : do $code/build/budget_overtime.do
- Line 631, unix : do $code/build/build_model_dataset_pre2011.do
- Line 678, unix : do $code/descriptives/summary.do
- Line 679, unix : do $code/descriptives/summary_simulation.do
- Line 680, unix : do $code/auxiliary_regressions/aux_model_teachers_wages.do
- Line 681, unix : do $code/descriptives/Table_B15.do
- Line 682, unix : do $code/auxiliary_regressions/aux_other_moments.do
- Line 714, unix : do $code/auxiliary_regressions/auxiliary_models_districts.do
- Line 747, unix : do $code/descriptives/omega_analysis.do
- Line 748, unix : do $code/descriptives/data_patterns.do
- Line 749, unix : do $code/descriptives/appendix_figures.do
- Line 750, unix : do $code/descriptives/rothstein_test.do

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/stderr/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/synthetic_data/code/make_simulated_data.do**

- Line 11, unix : synthetic_data/raw/. It creates data from scratch and does not read any
- Line 16, unix : do synthetic_data/code/make_simulated_data.do
- Line 20, unix : do code/make_simulated_data.do

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/aux_model.f90**

- Line 76, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 202, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 822, unix : !by lambda and b/t quintiles.
- Line 858, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/schedule_new.do**

- Line 27, unix : forvalues e = 1/6 {
- Line 28, unix : forvalues m = 0/1 {
- Line 62, unix : forvalues e = 1/6 {
- Line 70, unix : forvalues exp = 1/6 {
- Line 77, unix : forvalues exp = 1/6 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/1_baseline/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 757, unix : !initialize vars help to print information to terminal/txt files...
- Line 763, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 774, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 777, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 781, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 790, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 894, unix : ! need to introduce something to avoid NAs here b/c we were making thetas == 0 so can't do pct change like this
- Line 1069, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1072, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1085, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1245, unix : !now calc target H, mean/sd wage
- Line 1297, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1298, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1299, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1351, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1361, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1372, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1482, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1483, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1500, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1501, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1502, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1503, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1534, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/utility_functions.f90**

- Line 31, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 90, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/inner_loop_one.f90**

- Line 111, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 255, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 260, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 263, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 269, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 273, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 282, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 283, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 284, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 307, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 317, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 352, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 354, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 358, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 593, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 600, unix : allocate(waget(nteach,rec_count/nteach))
- Line 604, unix : allocate(inct(nteach,rec_count/nteach))
- Line 608, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 618, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 619, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 620, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 634, unix : !pass/receive H across threads
- Line 641, unix : do j=1, rec_count/nteach
- Line 663, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 670, unix : !double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 680, unix : allocate(Ht_vary(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 706, unix : do j=1, rec_count/nteach!85,85
- Line 844, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 869, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 886, unix : !initialize vars help to print information to terminal/txt files...
- Line 893, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 899, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 903, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 907, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 911, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 916, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 931, unix : !XXX: in economy-by-economy version this is overwritten/is garbage at this point here
- Line 967, unix : ! reading main should be redundant, b/c period 1 is same as baseline so should be at same converged value
- Line 968, unix : !    but for consistency will just read in... only wage gets adj b/c subsidy
- Line 1033, unix : !     sure theta0 gets reset for this bug cehck, so remove the below 21/22 later.
- Line 1279, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1282, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1299, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1303, unix : open(1,file='result/eqbm_omegas.txt',action='write',position='append')
- Line 1501, unix : !now calc target H, mean/sd wage
- Line 1563, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1564, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1565, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1623, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1635, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1647, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1805, unix : !double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1807, unix : !double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1809, unix : !double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1811, unix : !integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1826, unix : allocate(waget_eqm(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 1827, unix : allocate(Ht_vary(nteach,rec_count/nteach), Ht_eqm(nteach,rec_count/nteach))
- Line 1828, unix : allocate(pr_omegast_eqm(NWgrid1,NWgrid2,rec_count/nteach))
- Line 1829, unix : allocate(omegast_eqm(2,rec_count/nteach))
- Line 1830, unix : allocate(offert_eqm(nteach,rec_count/nteach))
- Line 1854, unix : do j=1, rec_count/nteach
- Line 2152, unix : ! (sorry this is a bastardization b/c code was never meant to have forward iter feature)
- Line 2164, unix : ! Don't need to broadcast these b/c not economy specific right now, they are all determined in main
- Line 2210, unix : ! b/c of weirdness injected b/c we had to do the forward iteration, all of the logic is off

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/global_variables.f90**

- Line 104, unix : ! XX only need to add these if entry/exit is economy specific

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/perturbation/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/utility_functions.f90**

- Line 31, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 90, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/perturbation/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_B16.do**

- Line 28, unix : forvalues i = 1/6 {
- Line 167, unix : forvalues j = 1/3 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/aux_model.f90**

- Line 76, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 202, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 822, unix : !by lambda and b/t quintiles.
- Line 858, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/2_rigid/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/aux_district_noninc4_JPE.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 31, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/objective.f90**

- Line 196, unix : !    (with inc being economy-by-economy for foward iter, can't calclate this stuff anyways, and we don't need/want it)

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/aux_district_all1_JPE.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 34, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_B23.do**

- Line 40, unix : forvalues j = 1/17 {
- Line 56, unix : forvalues j = 1/17 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/validation_result/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 177, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 773, unix : !by lambda and b/t quintiles.
- Line 809, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/auxiliary_regressions/master.do**

- Line 73, unix : + va_nocomparativeadv.dta - contains teacher contribution w/o comparative advantage. Constructed in valueadded_calculation_nocomparativeadv.do
- Line 105, unix : do $code/build/va_teacherside_build.do
- Line 106, unix : do $code/build/testscores_build.do
- Line 114, unix : do $code/build/teachers_with_allva.do
- Line 117, unix : do $code/build/schedule_new.do
- Line 118, unix : do $code/build/gen_omegas.do
- Line 119, unix : do $code/build/gen_omegas_info.do
- Line 120, unix : do $code/build/build_model_dataset.do
- Line 121, unix : do $code/build/build_teachers_offer_set.do
- Line 122, unix : do $code/auxiliary_regressions/auxiliary_models_teachers.do
- Line 123, unix : do $code/auxiliary_regressions/aux_other_moments.do
- Line 124, unix : do $code/auxiliary_regressions/auxiliary_models_districts.do
- Line 125, unix : do $code/build/build_model_dataset_info0.do
- Line 126, unix : do $code/build/build_model_dataset_info1.do
- Line 127, unix : do $code/build/build_model_dataset_info2.do
- Line 128, unix : do $code/build/build_model_dataset_info3.do
- Line 129, unix : do $code/build/auxiliary_models_teachers_info_matches.do
- Line 131, unix : do $code/build/omega_databuild.do
- Line 132, unix : do $code/build/budget_overtime.do
- Line 134, unix : do $code/build/build_distance_matrix.do
- Line 137, unix : do $code/build/build_model_dataset_pre2011.do
- Line 138, unix : do $code/build/build_simulation_lndist.do
- Line 149, unix : do $code/descriptives/summary.do
- Line 152, unix : do $code/auxiliary_regressions/aux_model_teachers_wages.do
- Line 155, unix : do $code/descriptives/omega_analysis.do
- Line 161, unix : do $code/descriptives/data_patterns.do
- Line 174, unix : do $code/descriptives/appendix_figures.do
- Line 177, unix : do $code/descriptives/rothstein_test.do
- Line 180, unix : do $code/build/valueadded_calculation_classmodel.do
- Line 183, unix : do $code/auxiliary_regressions/auxmodels_teachers_varobust.do
- Line 186, unix : do $code/descriptives/c1c2_variation_studentlevel.do
- Line 189, unix : do $code/descriptives/achievement_race.do
- Line 192, unix : do $code/descriptives/schedule_summary.do
- Line 195, unix : do $code/descriptives/salary_variation.do
- Line 198, unix : do $code/auxiliary_regressions/auxiliary_models_teachers_info.do
- Line 201, unix : do $code/auxiliary_regressions/auxiliary_models_teachers_nobottom.do
- Line 204, unix : do $code/auxiliary_regressions/auxiliary_models_teachers_richprefs.do
- Line 211, unix : do $code/descriptives/Table_B15.do
- Line 214, unix : do $code/descriptives/summary_simulation.do
- Line 227, unix : do $code/descriptives/gen_omegas_3omegas.do
- Line 230, unix : do $code/descriptives/gen_omegas_tenured.do
- Line 233, unix : do $code/descriptives/gen_omegas_exp1cutoff.do
- Line 236, unix : do $code/descriptives/budget_shifts.do
- Line 245, unix : do $code/descriptives/lambda_map.do

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/auxiliary_regressions/auxmodels_teachers_varobust.do**

- Line 52, unix : forvalues n = 2/6 {
- Line 164, unix : forvalues n = 2/6 {
- Line 215, unix : forvalues n = 2/6 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/aux_district_all_mean2_JPE.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 20, unix : budget/teacher (1,000)&                     &                     &      0.0000         &      0.0000         &      0.0000         &                     &                     &      0.0000         &      0.0000         &      0.0000         \\
- Line 34, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/global_variables.f90**

- Line 104, unix : ! XX only need to add these if entry/exit is economy specific

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/rothstein_test.do**

- Line 35, unix : forvalues p = 1/3 {
- Line 36, unix : forvalues g = 3/7 {
- Line 138, unix : forvalues p = 1/3 {
- Line 139, unix : forvalues g = 3/7 {
- Line 147, unix : forvalues x = 1/25 {
- Line 172, unix : forvalues x = 2/26 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/global_variables.f90**

- Line 104, unix : ! XX only need to add these if entry/exit is economy specific

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/auxiliary_regressions/aux_model_teachers_wages.do**

- Line 16, unix : use $est/multinomial.dta, clear
- Line 121, unix : merge 1:1 id District using $est/multinomial.dta
- Line 175, unix : use $est/multinomial.dta, clear
- Line 220, unix : use $est/matched_movers.dta, clear

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/gen_omegas_tenured.do**

- Line 115, unix : forvalues A0 = 1/5 {
- Line 116, unix : forvalues A1 = 1/7 {
- Line 117, unix : forvalues A2 = 1/7 {
- Line 170, unix : forvalues A0 = 1/5 {
- Line 171, unix : forvalues A1 = 1/7 {
- Line 172, unix : forvalues A2 = 1/7 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/utility_functions.f90**

- Line 31, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 90, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/perturbation/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/Table_B8.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 36, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/main.f90**

- Line 38, unix : ! entry/exit
- Line 76, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi
- Line 175, unix : !    - c1/c2
- Line 182, unix : open(1, file = 'result/entryexit_stats.txt', status = 'replace')
- Line 215, unix : ! If after first period we have to move things forward and draw entrants/exits
- Line 244, unix : ! adjust c1/c2, only needs to happen if changing experience group
- Line 281, unix : !  (altho this requires share_low, share_low isn't affected by changing c1/c2)
- Line 318, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 356, unix : ! Second, adjust exit prob b/c of wage_change
- Line 395, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 455, unix : ! Here we calculate the expected number of entrants/exits across economies
- Line 490, unix : ! save incumbents in the data b/c we will need to reallocate these arrays
- Line 536, unix : ! And we also have to save the district info... b/c these get expanded as well
- Line 624, unix : open(1, file = 'result/entryexit_stats.txt', action='write', position='append')
- Line 732, unix : ! for incumbents, b/c pop changes, we need to recalc baseline wage each period, so keep omegas
- Line 737, unix : ! for entrants, b/c pop is static, we can calculate a base wage now.
- Line 741, unix : ! Don't need to do this for incumbents b/c the pop will change so we will work with omegas for them

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_B25.do**

- Line 51, unix : forvalues j = 1/4 {
- Line 65, unix : forvalues j = 1/4 {
- Line 118, unix : forvalues j = 1/4 {
- Line 132, unix : forvalues j = 1/4 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/stderr/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 177, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 773, unix : !by lambda and b/t quintiles.
- Line 809, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/appendix_figures.do**

- Line 86, unix : forvalues n = 1/6 {
- Line 199, unix : use $est/multinomial.dta, clear

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 187, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 784, unix : !by lambda and b/t quintiles.
- Line 820, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/read_data_params.f90**

- Line 57, unix : r_vec = 0 !this is set later, b/c we need to know lambda (share_low)
- Line 133, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 152, unix : !b5/b6/b7/b8 rely on svec
- Line 208, unix : param0(i)=1.0d-0/step(j)
- Line 514, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 520, unix : !skip first line b/c it is varname
- Line 525, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 531, unix : !weights for fraction over/under capacity
- Line 592, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 847, unix : ! Moved this to gen teacher data, b/c has nteach dimension
- Line 874, unix : idx = ndist/2   !integer division rounds
- Line 990, unix : !   b/c I randomly don't match some, there is no pattern of unmatching
- Line 1067, unix : !  for now, ignoring the 'pre' code, b/c irrelevant for forward iteration
- Line 1224, unix : !  we match as of 10/13/23
- Line 1255, unix : ! we match as of 10/13/23, except for one person, i=1870, who is an entrant, but somehow had a samecz value.
- Line 1348, unix : ! we are matching as of 10/13/23, although not in floats, some roundings are different
- Line 1369, unix : ! made this work as a portable function only using local variables here b/c
- Line 1498, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1513, unix : ! made this work as a portable function only using local variables here b/c
- Line 1660, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1861, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/inner_loop_one.f90**

- Line 111, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 255, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 260, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 263, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 269, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 273, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 282, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 283, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 284, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 307, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 317, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 352, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 354, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 358, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 593, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 600, unix : allocate(waget(nteach,rec_count/nteach))
- Line 604, unix : allocate(inct(nteach,rec_count/nteach))
- Line 608, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 618, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 619, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 620, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 634, unix : !pass/receive H across threads
- Line 641, unix : do j=1, rec_count/nteach
- Line 663, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 670, unix : !double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 680, unix : allocate(Ht_vary(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 706, unix : do j=1, rec_count/nteach!85,85
- Line 844, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 869, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 886, unix : !initialize vars help to print information to terminal/txt files...
- Line 893, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 899, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 903, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 907, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 911, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 916, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 931, unix : !XXX: in economy-by-economy version this is overwritten/is garbage at this point here
- Line 967, unix : ! reading main should be redundant, b/c period 1 is same as baseline so should be at same converged value
- Line 968, unix : !    but for consistency will just read in... only wage gets adj b/c subsidy
- Line 1033, unix : !     sure theta0 gets reset for this bug cehck, so remove the below 21/22 later.
- Line 1279, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1282, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1299, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1303, unix : open(1,file='result/eqbm_omegas.txt',action='write',position='append')
- Line 1501, unix : !now calc target H, mean/sd wage
- Line 1563, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1564, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1565, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1623, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1635, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1647, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1805, unix : !double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1807, unix : !double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1809, unix : !double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1811, unix : !integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1826, unix : allocate(waget_eqm(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 1827, unix : allocate(Ht_vary(nteach,rec_count/nteach), Ht_eqm(nteach,rec_count/nteach))
- Line 1828, unix : allocate(pr_omegast_eqm(NWgrid1,NWgrid2,rec_count/nteach))
- Line 1829, unix : allocate(omegast_eqm(2,rec_count/nteach))
- Line 1830, unix : allocate(offert_eqm(nteach,rec_count/nteach))
- Line 1854, unix : do j=1, rec_count/nteach
- Line 2152, unix : ! (sorry this is a bastardization b/c code was never meant to have forward iter feature)
- Line 2164, unix : ! Don't need to broadcast these b/c not economy specific right now, they are all determined in main
- Line 2210, unix : ! b/c of weirdness injected b/c we had to do the forward iteration, all of the logic is off

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/build_model_dataset_info0.do**

- Line 149, unix : forvalues n = 1/6 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/1_baseline/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/estimation_result/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 177, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 773, unix : !by lambda and b/t quintiles.
- Line 809, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/inner_loop_one.f90**

- Line 111, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 255, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 260, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 263, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 269, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 273, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 282, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 283, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 284, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 307, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 317, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 352, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 354, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 358, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 593, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 600, unix : allocate(waget(nteach,rec_count/nteach))
- Line 604, unix : allocate(inct(nteach,rec_count/nteach))
- Line 608, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 618, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 619, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 620, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 634, unix : !pass/receive H across threads
- Line 641, unix : do j=1, rec_count/nteach
- Line 663, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 670, unix : !double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 680, unix : allocate(Ht_vary(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 706, unix : do j=1, rec_count/nteach!85,85
- Line 844, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 869, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 886, unix : !initialize vars help to print information to terminal/txt files...
- Line 893, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 899, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 903, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 907, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 911, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 916, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 931, unix : !XXX: in economy-by-economy version this is overwritten/is garbage at this point here
- Line 967, unix : ! reading main should be redundant, b/c period 1 is same as baseline so should be at same converged value
- Line 968, unix : !    but for consistency will just read in... only wage gets adj b/c subsidy
- Line 1033, unix : !     sure theta0 gets reset for this bug cehck, so remove the below 21/22 later.
- Line 1279, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1282, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1299, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1303, unix : open(1,file='result/eqbm_omegas.txt',action='write',position='append')
- Line 1501, unix : !now calc target H, mean/sd wage
- Line 1563, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1564, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1565, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1623, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1635, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1647, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1805, unix : !double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1807, unix : !double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1809, unix : !double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1811, unix : !integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1826, unix : allocate(waget_eqm(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 1827, unix : allocate(Ht_vary(nteach,rec_count/nteach), Ht_eqm(nteach,rec_count/nteach))
- Line 1828, unix : allocate(pr_omegast_eqm(NWgrid1,NWgrid2,rec_count/nteach))
- Line 1829, unix : allocate(omegast_eqm(2,rec_count/nteach))
- Line 1830, unix : allocate(offert_eqm(nteach,rec_count/nteach))
- Line 1854, unix : do j=1, rec_count/nteach
- Line 2152, unix : ! (sorry this is a bastardization b/c code was never meant to have forward iter feature)
- Line 2164, unix : ! Don't need to broadcast these b/c not economy specific right now, they are all determined in main
- Line 2210, unix : ! b/c of weirdness injected b/c we had to do the forward iteration, all of the logic is off

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/c1c2_variation_studentlevel.do**

- Line 41, unix : qui forvalues n = 1/26 {
- Line 115, unix : forvalues p = 1/3 {
- Line 116, unix : forvalues g = 3/7 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/stderr/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/aux_district_all_mean1_JPE.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 34, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/master_synth.do**

- Line 90, unix : + va_nocomparativeadv.dta - contains teacher contribution w/o comparative advantage. Constructed in valueadded_calculation_nocomparativeadv.do
- Line 122, unix : do $code/build/va_teacherside_build.do
- Line 123, unix : do $code/build/testscores_build.do
- Line 131, unix : do $code/build/teachers_with_allva.do
- Line 134, unix : do $code/build/schedule_new.do
- Line 135, unix : do $code/build/gen_omegas.do
- Line 138, unix : do $code/build/gen_omegas_info.do
- Line 139, unix : do $code/build/build_model_dataset.do
- Line 140, unix : do $code/build/build_teachers_offer_set.do
- Line 141, unix : do $code/auxiliary_regressions/auxiliary_models_teachers.do
- Line 142, unix : do $code/auxiliary_regressions/aux_other_moments.do
- Line 143, unix : do $code/auxiliary_regressions/auxiliary_models_districts.do
- Line 144, unix : do $code/build/build_model_dataset_info0.do
- Line 145, unix : do $code/build/build_model_dataset_info1.do
- Line 146, unix : do $code/build/build_model_dataset_info2.do
- Line 147, unix : do $code/build/build_model_dataset_info3.do
- Line 148, unix : do $code/build/auxiliary_models_teachers_info_matches.do
- Line 150, unix : do $code/build/omega_databuild.do
- Line 151, unix : do $code/build/budget_overtime.do
- Line 153, unix : do $code/build/build_distance_matrix.do
- Line 154, unix : do $code/build/build_wageschedule_exitentry.do
- Line 155, unix : do $code/build/fix_estsample_age.do
- Line 158, unix : do $code/build/build_model_dataset_pre2011.do
- Line 159, unix : do $code/build/build_simulation_lndist.do
- Line 170, unix : do $code/descriptives/summary.do
- Line 173, unix : do $code/auxiliary_regressions/aux_model_teachers_wages.do
- Line 176, unix : do $code/descriptives/omega_analysis.do
- Line 182, unix : do $code/descriptives/data_patterns.do
- Line 195, unix : do $code/descriptives/appendix_figures.do
- Line 198, unix : do $code/descriptives/rothstein_test.do
- Line 201, unix : do $code/build/valueadded_calculation_classmodel.do
- Line 204, unix : do $code/auxiliary_regressions/auxmodels_teachers_varobust.do
- Line 207, unix : do $code/descriptives/c1c2_variation_studentlevel.do
- Line 210, unix : do $code/descriptives/achievement_race.do
- Line 213, unix : do $code/descriptives/schedule_summary.do
- Line 216, unix : do $code/descriptives/salary_variation.do
- Line 219, unix : do $code/auxiliary_regressions/auxiliary_models_teachers_info.do
- Line 222, unix : do $code/auxiliary_regressions/auxiliary_models_teachers_nobottom.do
- Line 225, unix : do $code/auxiliary_regressions/auxiliary_models_teachers_richprefs.do
- Line 232, unix : do $code/descriptives/Table_B15.do
- Line 235, unix : do $code/descriptives/summary_simulation.do
- Line 248, unix : do $code/descriptives/gen_omegas_3omegas.do
- Line 251, unix : do $code/descriptives/gen_omegas_tenured.do
- Line 254, unix : do $code/descriptives/gen_omegas_exp1cutoff.do
- Line 257, unix : do $code/descriptives/budget_shifts.do
- Line 266, unix : do $code/descriptives/lambda_map.do

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/1_baseline/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 177, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 773, unix : !by lambda and b/t quintiles.
- Line 809, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 187, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 784, unix : !by lambda and b/t quintiles.
- Line 820, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/main.f90**

- Line 38, unix : ! entry/exit
- Line 76, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi
- Line 175, unix : !    - c1/c2
- Line 182, unix : open(1, file = 'result/entryexit_stats.txt', status = 'replace')
- Line 215, unix : ! If after first period we have to move things forward and draw entrants/exits
- Line 244, unix : ! adjust c1/c2, only needs to happen if changing experience group
- Line 281, unix : !  (altho this requires share_low, share_low isn't affected by changing c1/c2)
- Line 318, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 356, unix : ! Second, adjust exit prob b/c of wage_change
- Line 395, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 455, unix : ! Here we calculate the expected number of entrants/exits across economies
- Line 490, unix : ! save incumbents in the data b/c we will need to reallocate these arrays
- Line 536, unix : ! And we also have to save the district info... b/c these get expanded as well
- Line 624, unix : open(1, file = 'result/entryexit_stats.txt', action='write', position='append')
- Line 732, unix : ! for incumbents, b/c pop changes, we need to recalc baseline wage each period, so keep omegas
- Line 737, unix : ! for entrants, b/c pop is static, we can calculate a base wage now.
- Line 741, unix : ! Don't need to do this for incumbents b/c the pop will change so we will work with omegas for them

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 187, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 784, unix : !by lambda and b/t quintiles.
- Line 820, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/aux_model.f90**

- Line 76, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 202, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 822, unix : !by lambda and b/t quintiles.
- Line 858, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/validation_result/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/data_patterns.do**

- Line 65, unix : forvalues n = 1/6 {
- Line 85, unix : forvalues n = 1/6 {
- Line 113, unix : forvalues y = 2009/2016 {
- Line 210, unix : forvalues y = 2009/2014 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/1_baseline/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/validation_result/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 187, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 784, unix : !by lambda and b/t quintiles.
- Line 820, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/2_rigid/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/aux_model.f90**

- Line 76, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 202, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 822, unix : !by lambda and b/t quintiles.
- Line 858, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/main.f90**

- Line 38, unix : ! entry/exit
- Line 76, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi
- Line 175, unix : !    - c1/c2
- Line 182, unix : open(1, file = 'result/entryexit_stats.txt', status = 'replace')
- Line 215, unix : ! If after first period we have to move things forward and draw entrants/exits
- Line 244, unix : ! adjust c1/c2, only needs to happen if changing experience group
- Line 281, unix : !  (altho this requires share_low, share_low isn't affected by changing c1/c2)
- Line 318, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 356, unix : ! Second, adjust exit prob b/c of wage_change
- Line 395, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 455, unix : ! Here we calculate the expected number of entrants/exits across economies
- Line 490, unix : ! save incumbents in the data b/c we will need to reallocate these arrays
- Line 536, unix : ! And we also have to save the district info... b/c these get expanded as well
- Line 624, unix : open(1, file = 'result/entryexit_stats.txt', action='write', position='append')
- Line 732, unix : ! for incumbents, b/c pop changes, we need to recalc baseline wage each period, so keep omegas
- Line 737, unix : ! for entrants, b/c pop is static, we can calculate a base wage now.
- Line 741, unix : ! Don't need to do this for incumbents b/c the pop will change so we will work with omegas for them

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/inner_loop_one.f90**

- Line 111, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 255, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 260, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 263, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 269, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 273, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 282, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 283, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 284, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 307, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 317, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 352, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 354, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 358, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 593, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 600, unix : allocate(waget(nteach,rec_count/nteach))
- Line 604, unix : allocate(inct(nteach,rec_count/nteach))
- Line 608, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 618, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 619, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 620, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 634, unix : !pass/receive H across threads
- Line 641, unix : do j=1, rec_count/nteach
- Line 663, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 670, unix : !double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 680, unix : allocate(Ht_vary(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 706, unix : do j=1, rec_count/nteach!85,85
- Line 844, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 869, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 886, unix : !initialize vars help to print information to terminal/txt files...
- Line 893, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 899, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 903, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 907, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 911, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 916, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 931, unix : !XXX: in economy-by-economy version this is overwritten/is garbage at this point here
- Line 967, unix : ! reading main should be redundant, b/c period 1 is same as baseline so should be at same converged value
- Line 968, unix : !    but for consistency will just read in... only wage gets adj b/c subsidy
- Line 1033, unix : !     sure theta0 gets reset for this bug cehck, so remove the below 21/22 later.
- Line 1276, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1279, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1296, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1300, unix : open(1,file='result/eqbm_omegas.txt',action='write',position='append')
- Line 1498, unix : !now calc target H, mean/sd wage
- Line 1560, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1561, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1562, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1620, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1632, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1644, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1802, unix : !double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1804, unix : !double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1806, unix : !double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1808, unix : !integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1823, unix : allocate(waget_eqm(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 1824, unix : allocate(Ht_vary(nteach,rec_count/nteach), Ht_eqm(nteach,rec_count/nteach))
- Line 1825, unix : allocate(pr_omegast_eqm(NWgrid1,NWgrid2,rec_count/nteach))
- Line 1826, unix : allocate(omegast_eqm(2,rec_count/nteach))
- Line 1827, unix : allocate(offert_eqm(nteach,rec_count/nteach))
- Line 1851, unix : do j=1, rec_count/nteach
- Line 2149, unix : ! (sorry this is a bastardization b/c code was never meant to have forward iter feature)
- Line 2161, unix : ! Don't need to broadcast these b/c not economy specific right now, they are all determined in main
- Line 2207, unix : ! b/c of weirdness injected b/c we had to do the forward iteration, all of the logic is off

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/global_variables.f90**

- Line 104, unix : ! XX only need to add these if entry/exit is economy specific

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/aux_district_all_mean3_JPE.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 20, unix : budget/teacher (1,000)&                     &                     &      0.0000         &      0.0000         &      0.0000         \\
- Line 34, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/belief_functions.f90**

- Line 124, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/main.f90**

- Line 38, unix : ! entry/exit
- Line 76, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi
- Line 175, unix : !    - c1/c2
- Line 182, unix : open(1, file = 'result/entryexit_stats.txt', status = 'replace')
- Line 215, unix : ! If after first period we have to move things forward and draw entrants/exits
- Line 244, unix : ! adjust c1/c2, only needs to happen if changing experience group
- Line 281, unix : !  (altho this requires share_low, share_low isn't affected by changing c1/c2)
- Line 318, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 356, unix : ! Second, adjust exit prob b/c of wage_change
- Line 395, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 455, unix : ! Here we calculate the expected number of entrants/exits across economies
- Line 490, unix : ! save incumbents in the data b/c we will need to reallocate these arrays
- Line 536, unix : ! And we also have to save the district info... b/c these get expanded as well
- Line 624, unix : open(1, file = 'result/entryexit_stats.txt', action='write', position='append')
- Line 732, unix : ! for incumbents, b/c pop changes, we need to recalc baseline wage each period, so keep omegas
- Line 737, unix : ! for entrants, b/c pop is static, we can calculate a base wage now.
- Line 741, unix : ! Don't need to do this for incumbents b/c the pop will change so we will work with omegas for them

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/1_baseline/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/read_data_params.f90**

- Line 57, unix : r_vec = 0 !this is set later, b/c we need to know lambda (share_low)
- Line 133, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 152, unix : !b5/b6/b7/b8 rely on svec
- Line 208, unix : param0(i)=1.0d-0/step(j)
- Line 514, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 520, unix : !skip first line b/c it is varname
- Line 525, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 531, unix : !weights for fraction over/under capacity
- Line 592, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 847, unix : ! Moved this to gen teacher data, b/c has nteach dimension
- Line 874, unix : idx = ndist/2   !integer division rounds
- Line 990, unix : !   b/c I randomly don't match some, there is no pattern of unmatching
- Line 1067, unix : !  for now, ignoring the 'pre' code, b/c irrelevant for forward iteration
- Line 1224, unix : !  we match as of 10/13/23
- Line 1255, unix : ! we match as of 10/13/23, except for one person, i=1870, who is an entrant, but somehow had a samecz value.
- Line 1348, unix : ! we are matching as of 10/13/23, although not in floats, some roundings are different
- Line 1369, unix : ! made this work as a portable function only using local variables here b/c
- Line 1498, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1513, unix : ! made this work as a portable function only using local variables here b/c
- Line 1660, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1861, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/aux_model.f90**

- Line 76, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 202, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 822, unix : !by lambda and b/t quintiles.
- Line 858, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/objective.f90**

- Line 196, unix : !    (with inc being economy-by-economy for foward iter, can't calclate this stuff anyways, and we don't need/want it)

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_7.do**

- Line 32, unix : forval col = 1/3 {
- Line 218, unix : forval col = 1/3 {
- Line 219, unix : forval row = 1/7 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/aux_model.f90**

- Line 76, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 202, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 822, unix : !by lambda and b/t quintiles.
- Line 858, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/gen_omegas_info.do**

- Line 87, unix : forvalues info = 0/3 {
- Line 110, unix : forvalues info = 0/3 {
- Line 135, unix : forvalues info = 0/3 {
- Line 174, unix : forvalues A0 = 1/5 {
- Line 175, unix : forvalues A1 = 1/7 {
- Line 216, unix : forvalues A0 = 1/5 {
- Line 217, unix : forvalues A1 = 1/7 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/estimation_result/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/aux_district_noninc1_JPE.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 34, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/gen_omegas.do**

- Line 102, unix : forvalues A0 = 1/5 {
- Line 103, unix : forvalues A1 = 1/7 {
- Line 144, unix : forvalues A0 = 1/5 {
- Line 145, unix : forvalues A1 = 1/7 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/objective.f90**

- Line 196, unix : !    (with inc being economy-by-economy for foward iter, can't calclate this stuff anyways, and we don't need/want it)

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/objective.f90**

- Line 196, unix : !    (with inc being economy-by-economy for foward iter, can't calclate this stuff anyways, and we don't need/want it)

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/Table_B12.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 49, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/auxiliary_regressions/aux_other_moments.do**

- Line 86, unix : forvalues q = 1/5 {
- Line 93, unix : forvalues q = 1/5 {
- Line 144, unix : forvalues q = 1/5 {
- Line 149, unix : forvalues q = 1/5 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/inner_loop_one.f90**

- Line 111, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 255, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 260, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 263, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 269, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 273, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 282, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 283, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 284, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 307, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 317, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 352, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 354, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 358, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 593, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 600, unix : allocate(waget(nteach,rec_count/nteach))
- Line 604, unix : allocate(inct(nteach,rec_count/nteach))
- Line 608, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 618, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 619, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 620, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 634, unix : !pass/receive H across threads
- Line 641, unix : do j=1, rec_count/nteach
- Line 663, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 670, unix : !double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 680, unix : allocate(Ht_vary(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 706, unix : do j=1, rec_count/nteach!85,85
- Line 844, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 869, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 887, unix : !initialize vars help to print information to terminal/txt files...
- Line 894, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 900, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 904, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 908, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 912, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 917, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 932, unix : !XXX: in economy-by-economy version this is overwritten/is garbage at this point here
- Line 968, unix : ! reading main should be redundant, b/c period 1 is same as baseline so should be at same converged value
- Line 969, unix : !    but for consistency will just read in... only wage gets adj b/c subsidy
- Line 1074, unix : !     sure theta0 gets reset for this bug cehck, so remove the below 21/22 later.
- Line 1327, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1330, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1347, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1351, unix : open(1,file='result/eqbm_omegas.txt',action='write',position='append')
- Line 1549, unix : !now calc target H, mean/sd wage
- Line 1611, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1612, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1613, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1671, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1683, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1695, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1853, unix : !double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1855, unix : !double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1857, unix : !double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1859, unix : !integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1874, unix : allocate(waget_eqm(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 1875, unix : allocate(Ht_vary(nteach,rec_count/nteach), Ht_eqm(nteach,rec_count/nteach))
- Line 1876, unix : allocate(pr_omegast_eqm(NWgrid1,NWgrid2,rec_count/nteach))
- Line 1877, unix : allocate(omegast_eqm(2,rec_count/nteach))
- Line 1878, unix : allocate(offert_eqm(nteach,rec_count/nteach))
- Line 1902, unix : do j=1, rec_count/nteach
- Line 2200, unix : ! (sorry this is a bastardization b/c code was never meant to have forward iter feature)
- Line 2212, unix : ! Don't need to broadcast these b/c not economy specific right now, they are all determined in main
- Line 2258, unix : ! b/c of weirdness injected b/c we had to do the forward iteration, all of the logic is off

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/paper_appendix/Online_Appendix_Sept2025.tex**

- Line 2, unix : % \graphicspath{ {/Users/bb779/Dropbox/Research/wisconsin_competition/out/} }
- Line 63, windows : \ifx\pdfoutput\relax\let\pdfoutput=\undefined\fi
- Line 64, windows : \newcount\msipdfoutput
- Line 65, windows : \ifx\pdfoutput\undefined\else
- Line 66, windows : \ifcase\pdfoutput\else
- Line 68, windows : \ifx\paperwidth\undefined\else
- Line 69, windows : \ifdim\paperheight=0pt\relax\else\pdfpageheight\paperheight\fi
- Line 70, windows : \ifdim\paperwidth=0pt\relax\else\pdfpagewidth\paperwidth\fi
- Line 71, windows : \fi\fi\fi
- Line 225, windows : $n\in\left\{  1,2\right\}  $
- Line 307, windows : ($\{v_{in}\}_{i,n\in\{1,2\}}$). Identification is achieved if the rank
- Line 339, windows : achievement of a student of type $n\in\{1,2\}$ is simply $v_{in}$. To estimate
- Line 342, unix : variable $j_{int}=K_{int}/K_{SG_{it}^{T}n}$ is i.i.d. with mean $1/J_{SG_{it}%
- Line 364, windows : _{kt}$. For each teacher $i$, we define, for $n\in\left\{  1,2\right\}  $%
- Line 430, windows : unknowns, where the unknowns are $\{v_{in}\}_{i,n\in\{1,2\}}$. Teacher
- Line 530, windows : is characterized by $\left(  x,c\right)  $ (Model 1) against their
- Line 631, windows : [c]{lccc}\hline\hline
- Line 677, windows : }i:d\left(  i\right)  =d
- Line 680, windows : $d$ $\left(  i:d\left(  i\right)  =d\right)  $, $W_{d}^{0}\left(
- Line 694, windows : \Omega^{o}=\left\{  0.9,0.95,1,1.05,1.1\right\}  \times\left\{
- Line 695, windows : 0,10,30,50,75,100,200\right\}  .
- Line 700, windows : _{d2}^{o})\in\Omega^{o}$ that best summarizes the distribution of teacher
- Line 701, windows : wages in that district $\left\{  i:d(i)=d\right\}  $, i.e.,
- Line 705, windows : ;\omega\right)  \right)  ^{2},\\
- Line 725, windows : deviation of predicted wages from actual wages in 2014, i.e., $\left\vert
- Line 728, windows : $w_{d}\left(  x_{i},c_{i};\omega\right)  $ yields a slope coefficient of 0.98
- Line 736, windows : \Omega=\left\{  0.9,0.95,1,1.05,1.1,1.15\right\}  \times\left\{
- Line 737, windows : 0,10,30,50,75,100,200,225\right\}  .
- Line 823, windows : &  +\left(  1-I\left(  d_{0}=0\right)  \right)  \left[  I\left(  d\neq
- Line 829, windows : teacher with $\left(  x,c\right)  ,$ i.e.,
- Line 850, windows : \cdot\right)  \right\}  $: Assuming that data were generated from an
- Line 879, windows : calculate each teacher's acceptance probabilities $h_{d}\left(  \cdot\right)
- Line 889, windows : vector $\zeta^{\ast}\left(  \Theta\right)  $.
- Line 908, windows : resulting $\left\{  \omega_d^\ast\left(  \Theta\right)  \right\}  _d$ will be
- Line 909, windows : compared with the observed $\left\{  \omega_d^o\right\}  _d$ in the outer loop.
- Line 920, windows : w_{d}\left(  x,c;\omega\right)  =\left\{
- Line 933, windows : where the pre-reform wage schedule $W_{d}^{0}\left(  x\right)  $ is a linear
- Line 951, windows : the square root of a quadratic function $\left(  Q\right)  ,$ governed by some
- Line 956, windows : Q\left(  x_{1},x_{2},c_{1},c_{2};\theta^{2}\right)  ,0\right\}  },\overline
- Line 996, windows : compute teacher acceptance probabilities $h_{d}\left(  \cdot\right)  $ from
- Line 1011, windows : ,\theta^{1\ast},\theta^{2\ast}\right\}  $ that bring the distance in Step 4
- Line 1012, windows : below a tolerance level. The vector $\left\{  \zeta^{\ast},\theta^{1\ast
- Line 1013, windows : },\theta^{2\ast}\right\}  $ renders the consistent belief $\left(
- Line 1172, windows : discriminate among teachers by factors other than $\left(  x,c\right)  $.
- Line 1196, windows : i,d\right)  $ matches to infer offers for other teachers if $i$'s
- Line 1228, windows : the distribution of $\left(  x,c\right)  $ in district $1$ does not
- Line 1229, windows : systematically dominate the distribution of $\left(  x,c\right)  $ in district
- Line 1240, windows : B\left(  c\right)  =c_{1}+bc_{2},
- Line 1252, windows : To maximize the expected total $B\left(  c\right)  $ among their hires,
- Line 1254, windows : those with higher $B\left(  c\right)  ,$ until it reaches its capacity;
- Line 1338, unix : assumptions about teachers' entry/exit decisions and the evolution of the
- Line 1376, unix : \subsection{Policy Impacts: Entry/Exit Margin and Repeated Games}
- Line 1385, unix : about teachers' entry/exit decisions and about how the market evolves over
- Line 1390, unix : To incorporate teachers' entry/exit decisions into our framework, we extend
- Line 1481, unix : \item Assuming a given entry/exit elasticity with respect to pay that is
- Line 1483, unix : entry/exit probability in response to the pay change calculated in 4 (a). This
- Line 1498, unix : Given the additional assumptions we have made (e.g., entry/exit elasticities),
- Line 1500, unix : policies when we take exit/entry into account in a static setting.
- Line 1507, unix : repeatedly over $T$ years.\footnote{In particular, when simulating entry/exit
- Line 1544, windows : rates $\left(  r_{0},r_{1}\right)  =\left(  0,7.0\right)  $.
- Line 1552, unix : described in Section \ref{oneshot} with three different entry/exit
- Line 1553, unix : elasticities (0.5, 1.0, and 1.5). Under the assumptions about entry/exit
- Line 1556, unix : increase with higher entry/exit elasticities.
- Line 1564, unix : repeatedly for 5 years) with an entry/exit elasticity of 1.0.\footnote{The
- Line 1578, unix : with additional assumptions, including externally set entry/exit elasticity
- Line 1608, windows : To study the role of districts' resistance cost $R\left(  \cdot\right)  $ by
- Line 1609, windows : itself, we re-simulated our bonus programs by setting $R\left(  \cdot\right)
- Line 1613, windows : $(2.3,3.1),$ if we set $R\left(  \cdot\right)  =0,$ this program will yield an
- Line 1624, windows : \pagebreak\clearpage
- Line 1636, windows : [c]{lcc}\hline\hline
- Line 1645, windows : R$^{2}$ & 0.677 & 0.625\\\hline\hline
- Line 1656, windows : [c]{lcc}\hline\hline
- Line 1669, windows : max & 0.1532 & 0.2362\\\hline\hline
- Line 1683, windows : [c]{lcccc}\hline\hline
- Line 1694, windows : \# school-grades & 1950 & 694 & 582 & 174\\\hline\hline
- Line 1707, windows : [c]{lcccc}\hline\hline
- Line 1737, windows : [c]{lcccc}\hline\hline
- Line 1784, windows : [c]{lcl}\hline\hline
- Line 1804, unix : &  & Table 2 (specification w/student\\
- Line 1805, windows : &  & controls)\\\hline\hline
- Line 1815, windows : [c]{lccc}\hline\hline
- Line 1828, unix : Students' Race/Ethnicity}%
- Line 1834, windows : [c]{lcc}\hline\hline
- Line 1838, windows : -0.067\ifmmode^\ast\ast\ast\else$^{\ast\ast\ast}$\fi\\
- Line 1841, windows : \ast\ast\else$^{\ast\ast\ast}$\fi\\
- Line 1844, windows : 0.081\ifmmode^\ast\ast\ast\else$^{\ast\ast\ast}$\fi\\
- Line 1858, windows : Observations & 3,360,517 & 3,635,942\\\hline\hline
- Line 1861, unix : obtained controlling for teachers'\ (T) and students' (S) race/ethnicity
- Line 1869, windows : [c]{llcc}\hline\hline
- Line 1885, windows : \pagebreak\clearpage
- Line 1895, windows : [c]{lccc}\hline\hline
- Line 1909, windows : \pagebreak\clearpage
- Line 1920, windows : [c]{lcccccccccc}\hline\hline
- Line 1979, windows : \\\hline\hline
- Line 1997, windows : &  & \\\hline\hline
- Line 2029, windows : $\left(  i,d\right)  $ for teachers with $c_{1i}$ or $c_{2i}$ below the 10th
- Line 2039, windows : \hline\hline
- Line 2049, windows : \hline\hline
- Line 2054, windows : \pagebreak\clearpage
- Line 2065, windows : [c]{lccc}\hline\hline
- Line 2073, windows : Aux 4 & 1.35\% & 0.04\% & 5.33\%\\\hline\hline
- Line 2089, windows : [c]{lcc}\hline\hline
- Line 2108, windows : [c]{lcccccccc}\hline\hline
- Line 2112, unix : {\small Entry/Exit Elasticity} & {\small -} & {\small 0.5} & {\small 1.0} &
- Line 2134, windows : [c]{lccccccc}\hline\hline
- Line 2138, unix : {\small Entry/Exit Elasiticity} & {\small -} & {\small 1.0} &  &  &  &
- Line 2160, windows : [c]{lccccc}\hline\hline
- Line 2198, windows : [c]{lcccc}\hline\hline
- Line 2220, windows : 2.98\\\hline\hline
- Line 2230, windows : [c]{lcccc}\hline\hline
- Line 2252, windows : 3.34\\\hline\hline
- Line 2257, windows : \pagebreak\clearpage
- Line 2266, windows : [c]{lccc}\hline\hline
- Line 2288, unix : {\small Budget/Capacity} {\small (\$1,000)} & {\small 52.4 (6.1)} &
- Line 2294, unix : {\small Share w/MA or above} & {\small 0.52 (0.26)} & {\small 0.57 (0.26)} &
- Line 2301, windows : \\\hline\hline
- Line 2312, windows : }\left(  \cdot\right)  =d)$}%
- Line 2314, windows : [c]{lccccccccc}\hline\hline
- Line 2340, windows : 0.13 & 0.12\\\hline\hline
- Line 2351, windows : [c]{lcccccc}\hline\hline
- Line 2447, windows : [c]{lccccccccc}\hline\hline
- Line 2491, windows : \pagebreak\clearpage
- Line 2500, unix : \includegraphics[width=0.7\textwidth]{figures/c1_c2_distr.pdf}\end{figure}
- Line 2507, unix : \includegraphics[width=0.8\textwidth]{figures/corr_c1_c2.png}\end{figure}\bigskip
- Line 2514, mixed : \includegraphics[width=0.6\textwidth]{figures/wage_schedule_pred.pdf}\newline%
- Line 2526, mixed : \includegraphics[width=0.8\textwidth]{figures/wagedeviations_3omega.png}\newline
- Line 2540, mixed : \includegraphics[width=0.8\textwidth]{figures/wagedeviations_tenured.png}
- Line 2556, mixed : \includegraphics[width=0.8\textwidth]{figures/wagedeviations_exp1cutoff.png}\newline
- Line 2569, mixed : \includegraphics[width=0.8\textwidth]{figures/math_switch}
- Line 2582, unix : \includegraphics[width=\textwidth]{figures/budget_allocated_math}
- Line 2585, unix : \caption{Reading/ELA, Grades 4-6}
- Line 2586, unix : \includegraphics[width=\textwidth]{figures/budget_allocated_lang}
- Line 2590, unix : \includegraphics[width=\textwidth]{figures/budget_allocated_grades_4_6}
- Line 2594, unix : \includegraphics[width=\textwidth]{figures/budget_allocated_grades_1_3}
- Line 2606, unix : \includegraphics[width=\linewidth]{figures/b_02.png}
- Line 2611, unix : \includegraphics[width=\linewidth]{figures/b_1.png}
- Line 2617, unix : \includegraphics[width=\linewidth]{figures/b_5.png}
- Line 2626, mixed : \includegraphics[width=0.7\textwidth]{figures/map.png}

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/validation_result/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_B18.do**

- Line 34, unix : forval col = 1/4 {
- Line 230, unix : forval col = 1/4 {
- Line 231, unix : forval row = 1/15 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/stderr/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/perturbation/main.f90**

- Line 52, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi
- Line 331, unix : ! And weirdness we have to do b/c.... avoid nan and how params reconstructed
- Line 355, unix : open(1, file='result/perturb_param.txt', status = 'replace')
- Line 361, unix : open(1, file='result/perturb_aux.txt', status = 'replace')
- Line 373, unix : open(1, file='result/perturb_aux_full.txt', status = 'replace')
- Line 381, unix : open(1, file='result/weight_mat.txt', status = 'replace')

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_B24.do**

- Line 42, unix : forvalues j = 1/13 {
- Line 56, unix : forvalues j = 1/13 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/belief_functions.f90**

- Line 124, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/stderr/read_data_params.f90**

- Line 112, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 184, unix : param0(i)=1.0d-0/step(j)
- Line 490, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 496, unix : !skip first line b/c it is varname
- Line 501, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 507, unix : !weights for fraction over/under capacity
- Line 568, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 591, unix : auxvar(i) = 1/weight_mat(i,i) ! for SE calc
- Line 595, unix : aux_omegavar(i) = 1/omega_weight_mat(i,i) ! for SE calc
- Line 599, unix : aux_othervar(i) = 1/other_weight_mat(i,i) ! for SE calc
- Line 814, unix : idx = ndist/2   !integer division rounds
- Line 1061, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/main.f90**

- Line 38, unix : ! entry/exit
- Line 76, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi
- Line 175, unix : !    - c1/c2
- Line 182, unix : open(1, file = 'result/entryexit_stats.txt', status = 'replace')
- Line 215, unix : ! If after first period we have to move things forward and draw entrants/exits
- Line 244, unix : ! adjust c1/c2, only needs to happen if changing experience group
- Line 281, unix : !  (altho this requires share_low, share_low isn't affected by changing c1/c2)
- Line 318, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 356, unix : ! Second, adjust exit prob b/c of wage_change
- Line 395, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 455, unix : ! Here we calculate the expected number of entrants/exits across economies
- Line 490, unix : ! save incumbents in the data b/c we will need to reallocate these arrays
- Line 536, unix : ! And we also have to save the district info... b/c these get expanded as well
- Line 624, unix : open(1, file = 'result/entryexit_stats.txt', action='write', position='append')
- Line 732, unix : ! for incumbents, b/c pop changes, we need to recalc baseline wage each period, so keep omegas
- Line 737, unix : ! for entrants, b/c pop is static, we can calculate a base wage now.
- Line 741, unix : ! Don't need to do this for incumbents b/c the pop will change so we will work with omegas for them

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/testscores_build.do**

- Line 68, unix : forvalues y = 2005/2013 {
- Line 78, unix : forvalues y = 2005/2013 {
- Line 88, unix : forvalues y = 2014/2016 {
- Line 98, unix : forvalues y = 2014/2016 {
- Line 145, unix : save $intdata/indtest_math.dta, replace
- Line 176, unix : forvalues y = 2006/2014 {
- Line 186, unix : forvalues y = 2006/2014 {
- Line 196, unix : forvalues y = 2015/2017 {
- Line 206, unix : forvalues y = 2015/2017 {
- Line 244, unix : save $intdata/indtest_math_old.dta, replace
- Line 252, unix : use $intdata/indtest_math.dta, clear
- Line 258, unix : merge 1:1 student year using $intdata/indtest_math_old.dta
- Line 271, unix : forvalues y = 2006/2013 {
- Line 282, unix : save $intdata/indtest_math_split_JPE.dta, replace
- Line 284, unix : rm $intdata/indtest_math_old.dta
- Line 285, unix : rm $intdata/indtest_math.dta

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/estimation_result/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/inner_loop_one.f90**

- Line 111, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 255, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 260, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 263, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 269, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 273, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 282, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 283, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 284, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 307, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 317, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 352, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 354, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 358, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 593, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 600, unix : allocate(waget(nteach,rec_count/nteach))
- Line 604, unix : allocate(inct(nteach,rec_count/nteach))
- Line 608, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 618, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 619, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 620, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 634, unix : !pass/receive H across threads
- Line 641, unix : do j=1, rec_count/nteach
- Line 663, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 670, unix : !double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 680, unix : allocate(Ht_vary(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 706, unix : do j=1, rec_count/nteach!85,85
- Line 844, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 869, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 886, unix : !initialize vars help to print information to terminal/txt files...
- Line 893, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 899, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 903, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 907, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 911, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 916, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 931, unix : !XXX: in economy-by-economy version this is overwritten/is garbage at this point here
- Line 967, unix : ! reading main should be redundant, b/c period 1 is same as baseline so should be at same converged value
- Line 968, unix : !    but for consistency will just read in... only wage gets adj b/c subsidy
- Line 1063, unix : !     sure theta0 gets reset for this bug cehck, so remove the below 21/22 later.
- Line 1309, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1312, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1329, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1333, unix : open(1,file='result/eqbm_omegas.txt',action='write',position='append')
- Line 1531, unix : !now calc target H, mean/sd wage
- Line 1593, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1594, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1595, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1653, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1665, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1677, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1835, unix : !double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1837, unix : !double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1839, unix : !double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1841, unix : !integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1856, unix : allocate(waget_eqm(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 1857, unix : allocate(Ht_vary(nteach,rec_count/nteach), Ht_eqm(nteach,rec_count/nteach))
- Line 1858, unix : allocate(pr_omegast_eqm(NWgrid1,NWgrid2,rec_count/nteach))
- Line 1859, unix : allocate(omegast_eqm(2,rec_count/nteach))
- Line 1860, unix : allocate(offert_eqm(nteach,rec_count/nteach))
- Line 1884, unix : do j=1, rec_count/nteach
- Line 2182, unix : ! (sorry this is a bastardization b/c code was never meant to have forward iter feature)
- Line 2194, unix : ! Don't need to broadcast these b/c not economy specific right now, they are all determined in main
- Line 2240, unix : ! b/c of weirdness injected b/c we had to do the forward iteration, all of the logic is off

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/schedule_summary.do**

- Line 25, unix : forvalues exp = 2/6{
- Line 29, unix : forvalues exp = 2/6{

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/inner_loop_one.f90**

- Line 111, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 255, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 260, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 263, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 269, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 273, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 282, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 283, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 284, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 307, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 317, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 352, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 354, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 358, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 593, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 600, unix : allocate(waget(nteach,rec_count/nteach))
- Line 604, unix : allocate(inct(nteach,rec_count/nteach))
- Line 608, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 618, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 619, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 620, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 634, unix : !pass/receive H across threads
- Line 641, unix : do j=1, rec_count/nteach
- Line 663, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 670, unix : !double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 680, unix : allocate(Ht_vary(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 706, unix : do j=1, rec_count/nteach!85,85
- Line 844, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 869, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 887, unix : !initialize vars help to print information to terminal/txt files...
- Line 894, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 900, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 904, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 908, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 912, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 917, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 932, unix : !XXX: in economy-by-economy version this is overwritten/is garbage at this point here
- Line 968, unix : ! reading main should be redundant, b/c period 1 is same as baseline so should be at same converged value
- Line 969, unix : !    but for consistency will just read in... only wage gets adj b/c subsidy
- Line 1074, unix : !     sure theta0 gets reset for this bug cehck, so remove the below 21/22 later.
- Line 1327, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1330, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1347, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1351, unix : open(1,file='result/eqbm_omegas.txt',action='write',position='append')
- Line 1549, unix : !now calc target H, mean/sd wage
- Line 1611, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1612, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1613, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1671, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1683, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1695, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1853, unix : !double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1855, unix : !double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1857, unix : !double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1859, unix : !integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1874, unix : allocate(waget_eqm(nteach,rec_count/nteach), waget_vary(nteach,rec_count/nteach))
- Line 1875, unix : allocate(Ht_vary(nteach,rec_count/nteach), Ht_eqm(nteach,rec_count/nteach))
- Line 1876, unix : allocate(pr_omegast_eqm(NWgrid1,NWgrid2,rec_count/nteach))
- Line 1877, unix : allocate(omegast_eqm(2,rec_count/nteach))
- Line 1878, unix : allocate(offert_eqm(nteach,rec_count/nteach))
- Line 1902, unix : do j=1, rec_count/nteach
- Line 2200, unix : ! (sorry this is a bastardization b/c code was never meant to have forward iter feature)
- Line 2212, unix : ! Don't need to broadcast these b/c not economy specific right now, they are all determined in main
- Line 2258, unix : ! b/c of weirdness injected b/c we had to do the forward iteration, all of the logic is off

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/validation_result/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_6.do**

- Line 175, unix : forval x = 1/5 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/estimation_result/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/stderr/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/read_data_params.f90**

- Line 57, unix : r_vec = 0 !this is set later, b/c we need to know lambda (share_low)
- Line 133, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 152, unix : !b5/b6/b7/b8 rely on svec
- Line 208, unix : param0(i)=1.0d-0/step(j)
- Line 514, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 520, unix : !skip first line b/c it is varname
- Line 525, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 531, unix : !weights for fraction over/under capacity
- Line 592, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 847, unix : ! Moved this to gen teacher data, b/c has nteach dimension
- Line 874, unix : idx = ndist/2   !integer division rounds
- Line 990, unix : !   b/c I randomly don't match some, there is no pattern of unmatching
- Line 1067, unix : !  for now, ignoring the 'pre' code, b/c irrelevant for forward iteration
- Line 1224, unix : !  we match as of 10/13/23
- Line 1255, unix : ! we match as of 10/13/23, except for one person, i=1870, who is an entrant, but somehow had a samecz value.
- Line 1348, unix : ! we are matching as of 10/13/23, although not in floats, some roundings are different
- Line 1369, unix : ! made this work as a portable function only using local variables here b/c
- Line 1498, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1513, unix : ! made this work as a portable function only using local variables here b/c
- Line 1660, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1861, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/gen_omegas_exp1cutoff.do**

- Line 116, unix : forvalues A0 = 1/5 {
- Line 117, unix : forvalues A1 = 1/7 {
- Line 118, unix : forvalues A2 = 1/7 {
- Line 171, unix : forvalues A0 = 1/5 {
- Line 172, unix : forvalues A1 = 1/7 {
- Line 173, unix : forvalues A2 = 1/7 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/2_rigid/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/objective.f90**

- Line 196, unix : !    (with inc being economy-by-economy for foward iter, can't calclate this stuff anyways, and we don't need/want it)

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/run_all_local.sh**

- Line 1, unix : #!/usr/bin/env bash
- Line 3, unix : # Portable local compiler/runner for the 31 Fortran model scenarios.
- Line 24, unix : --scenario PATH  Limit work to one path relative to code/fortran_model,
- Line 25, unix : for example 1_baseline or 3_basicCfs/new1.
- Line 31, unix : FORTRAN_LINK_FLAGS  Replacement BLAS/LAPACK linker flags
- Line 122, unix : 3_basicCfs/new1
- Line 123, unix : 3_basicCfs/new2
- Line 124, unix : 3_basicCfs/new3
- Line 125, unix : 3_basicCfs/new4
- Line 126, unix : 4_nomovecost/case1
- Line 127, unix : 4_nomovecost/case2
- Line 128, unix : 4_nomovecost/case2_new2
- Line 129, unix : 4_nomovecost/case_baseline
- Line 130, unix : 5_exitentry/baseline
- Line 131, unix : 5_exitentry/new1_05
- Line 132, unix : 5_exitentry/new1_1
- Line 133, unix : 5_exitentry/new1_15
- Line 134, unix : 5_exitentry/new2_05
- Line 135, unix : 5_exitentry/new2_1
- Line 136, unix : 5_exitentry/new2_15
- Line 137, unix : 6_forward/forward_baseline
- Line 138, unix : 6_forward/forward_new1
- Line 139, unix : 6_forward/forward_new2
- Line 140, unix : 7_higherbonus/new1_15
- Line 141, unix : 7_higherbonus/new1_2
- Line 142, unix : 7_higherbonus/new1_25
- Line 143, unix : 8_noRcost/new1
- Line 144, unix : 8_noRcost/new2
- Line 145, unix : 8_noRcost/new3
- Line 146, unix : 8_noRcost/new4

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new4/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/2_rigid/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/build_teachers_offer_set.do**

- Line 17, unix : forvalues n = 2/6 {
- Line 58, unix : use $est/multinomial.dta, clear
- Line 61, unix : forvalues n = 2/6 {
- Line 88, unix : save $est/matched_movers.dta, replace

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/utility_functions.f90**

- Line 31, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 90, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_A2.do**

- Line 42, unix : forvalues j = 1/13 {
- Line 56, unix : forvalues j = 1/13 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/perturbation/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 245, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 253, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 256, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 259, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 263, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 272, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 273, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 274, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 297, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 307, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 338, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 340, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 344, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 513, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 517, unix : allocate(waget(nteach,rec_count/nteach))
- Line 521, unix : allocate(inct(nteach,rec_count/nteach))
- Line 525, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 535, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 536, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 537, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 546, unix : !pass/receive H across threads
- Line 553, unix : do j=1, rec_count/nteach
- Line 574, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 581, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 608, unix : do j=1, rec_count/nteach!85,85
- Line 734, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 753, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 760, unix : !initialize vars help to print information to terminal/txt files...
- Line 766, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 774, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 777, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 780, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 784, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 793, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1050, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1053, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1066, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1226, unix : !now calc target H, mean/sd wage
- Line 1272, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1273, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1274, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1326, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1336, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1347, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1457, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1458, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1475, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1476, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1477, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1478, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1509, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/2_rigid/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/1_baseline/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/belief_functions.f90**

- Line 124, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/objective.f90**

- Line 196, unix : !    (with inc being economy-by-economy for foward iter, can't calclate this stuff anyways, and we don't need/want it)

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/validation_result/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 177, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 773, unix : !by lambda and b/t quintiles.
- Line 809, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/gen_omegas_3omegas.do**

- Line 116, unix : forvalues A0 = 1/5 {
- Line 117, unix : forvalues A1 = 1/7 {
- Line 118, unix : forvalues A2 = 1/7 {
- Line 172, unix : forvalues A0 = 1/5 {
- Line 173, unix : forvalues A1 = 1/7 {
- Line 174, unix : forvalues A2 = 1/7 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 187, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 784, unix : !by lambda and b/t quintiles.
- Line 820, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/build_model_dataset_info2.do**

- Line 150, unix : forvalues n = 1/6 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/global_variables.f90**

- Line 104, unix : ! XX only need to add these if entry/exit is economy specific

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/utility_functions.f90**

- Line 31, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 90, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/global_variables.f90**

- Line 104, unix : ! XX only need to add these if entry/exit is economy specific

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/1_baseline/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/2_rigid/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 177, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 773, unix : !by lambda and b/t quintiles.
- Line 809, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/2_rigid/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/objective.f90**

- Line 196, unix : !    (with inc being economy-by-economy for foward iter, can't calclate this stuff anyways, and we don't need/want it)

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/achievement_race.do**

- Line 73, unix : forvalues p = 1/3 {
- Line 74, unix : forvalues g = 3/7 {
- Line 82, unix : forvalues x = 1/25 {
- Line 107, unix : forvalues x = 2/26 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/paper_appendix/Draft_final.tex**

- Line 64, windows : \ifx\pdfoutput\relax\let\pdfoutput=\undefined\fi
- Line 65, windows : \newcount\msipdfoutput
- Line 66, windows : \ifx\pdfoutput\undefined\else
- Line 67, windows : \ifcase\pdfoutput\else
- Line 69, windows : \ifx\paperwidth\undefined\else
- Line 70, windows : \ifdim\paperheight=0pt\relax\else\pdfpageheight\paperheight\fi
- Line 71, windows : \ifdim\paperwidth=0pt\relax\else\pdfpagewidth\paperwidth\fi
- Line 72, windows : \fi\fi\fi
- Line 134, windows : rigid-pay\textquotedblright\ regime. Under rigid pay, districts cannot use
- Line 384, windows : steps-and-lanes\textquotedblright\ schedules, which express a teacher's salary
- Line 459, mixed : \includegraphics[width=0.9\textwidth]{figures/cvar.png}
- Line 481, mixed : \includegraphics[width=0.49\textwidth]{figures/moves.png}
- Line 482, mixed : \includegraphics[width=0.49\textwidth]{figures/moving_premium_overtime.png}
- Line 511, unix : \includegraphics[width=\textwidth]{figures/sorting_correlations_lambda_overtime.png}
- Line 539, windows : of the model, where $d_{0}\in\left\{  1,...,D\right\}  $ for incumbent
- Line 559, windows : follows:\newline1. Districts simultaneously choose their wage schedules
- Line 560, windows : $\left\{  w_{d}\left(  x,c\right)  \right\}  $ and job offers $\left\{
- Line 569, windows : with the same $\left(  x,c\right)  ,$ since the former are easier to attract
- Line 601, windows : $\Gamma\left(  \cdot\right)  $ is the cost of moving from $d_{0}$ to $d,$
- Line 604, windows : \Gamma\left(  d,d_{0},x\right)  =\left\{
- Line 619, windows : $\left(  d_{0}=0\right)  ,$ who are not attached to any district at the
- Line 630, windows : Among all received offers $\left(  o_{d}\left(  x,c,d_{0}\right)  =1\right)
- Line 636, windows : Let $d^{\ast}\left(  x,c,d_{0},\epsilon\right)  $ be the teacher's optimal choice.
- Line 653, windows : assumed the latter away.} We assume that $b\geq0$, i.e., district preferences
- Line 668, windows : wage schedule $W_{d}^{0}\left(  x\right)  $ and a teacher's contribution
- Line 669, windows : $TC\left(  \cdot\right)  $:
- Line 690, windows : wage-setting problem. In particular, if $\omega=\left(  1,0\right)  \in
- Line 715, windows : maximize the following total value from teachers it expects to hire:\newline%
- Line 731, windows : where $h_{d}\left(  x,c,d_{0},\omega\right)  $ is the probability that the
- Line 772, windows : of Act 10, we incorporate a resistance cost $R_{d}\left(  \cdot\right)  $ that
- Line 778, windows : To specify $R_{d}\left(  \cdot\right)  $ empirically, we let the institutional
- Line 787, windows : \omega\right)  ,$ the share of Democratic votes among district $d$'s residents
- Line 796, windows : $dem_{d}$ and specify $R_{d}\left(  \cdot\right)  $ as $R\left(
- Line 806, windows : x,c,d_{0},\omega\right)  \right\}  _{d}\right\}  $ such that\newline1) Given
- Line 809, windows : ,\epsilon\right)  $ solves the teacher's problem, for all $\left(
- Line 810, windows : x,c,d_{0},\epsilon\right)  $.\newline2) For all $d,$ given $\left\{
- Line 814, windows : $\left\{  h_{d}^{\ast}\left(  \cdot\right)  \right\}  _{d}$ is consistent with
- Line 815, windows : $\left\{  \left\{  d^{\ast}\left(  \cdot\right)  \right\}  ,\left\{
- Line 821, windows : acceptance probabilities $\left\{  h_{d}\left(  x,c,d_{0},\omega\right)
- Line 822, windows : \right\}  $: Given $\left\{  h_{d}\left(  \cdot\right)  \right\}  $, knowledge
- Line 824, windows : consistent belief about $\left\{  h_{d}\left(  x,c,d_{0},\omega\right)
- Line 826, windows : object $\left\{  h_{d}\left(  \cdot\right)  \right\}  $ is a daunting task for
- Line 830, windows : Alternatively, a district can derive $\left\{  h_{d}\left(  \cdot\right)
- Line 850, windows : &  +\left(  1-I\left(  d_{0}=0\right)  \right)  \left[  I\left(  d\neq
- Line 855, windows : counterpart $\left\{  h_d\left(  \cdot\right)  \right\}  $ defined in $\left(
- Line 863, windows : attributes $\left(  x,c\right)  $, according to the wage rules chosen by all
- Line 872, windows : simplified belief and replace $\left\{  h_{d}\left(  x,c,d_{0},\omega\right)
- Line 878, windows : $ and teachers' acceptance rule $h\left(  \cdot\right)  $ given by Equation
- Line 974, windows : models\textquotedblright\ that summarize the patterns in the data; and 2)
- Line 1035, windows : x,c\right)  $ and how wage schedules relate to districts' pre-determined
- Line 1038, windows : attributes $\left(  x,c\right)  ,$ a district should choose a wage schedule
- Line 1039, windows : that favors $\left(  x,c\right)  $. The need to do so is stronger when these
- Line 1057, windows : preferences for teachers are attributed to the resistance cost $R\left(
- Line 1058, windows : \cdot\right)  .$
- Line 1079, windows : preference parameter vector $b\geq0,$ a teacher $j$ is at least as preferable
- Line 1088, windows : matches ($\left(  i,d\right)  $ in this example) to infer offers for other
- Line 1093, windows : that $b\geq0,$ all options in $O_{i}^{s}$ are offered to teacher $i$,
- Line 1108, windows : number of teachers per district grows large, the lowest $\left(  x,c\right)  $
- Line 1109, windows : among teachers working in $d$ is the lowest $\left(  x,c\right)  $ that
- Line 1112, windows : some teacher. The lowest $\left(  x,c\right)  $ within each district
- Line 1135, windows : working in district $2.$ As long as the distribution of $\left(  x,c\right)  $
- Line 1137, windows : x,c\right)  $ in district $2$ in all dimensions, we can infer how much
- Line 1149, windows : that enter districts' payoff function), which involves A1 and A2 below. The second type of assumption relates to job posting and job application (A3 below). Notice that the specific functional form of $B\left(
- Line 1150, windows : \cdot\right)  $ is irrelevant here as long as $B\left(  \cdot\right)  $ is
- Line 1171, windows : teachers by factors other than $\left(  x,c\right)  $. If some job offers were
- Line 1172, windows : made for reasons other than $\left(  x,c\right)  $, then the inferred
- Line 1175, windows : However, as long as most job offers are based on $\left(  x,c\right)  $, the
- Line 1180, windows : models but do not use observed teacher-district $\left(  i,d\right)  $ matches
- Line 1264, windows : $\left\{  \left(  i,d\right)  \right\}  _{d}$ observations associated with
- Line 1284, unix : quintiles of budget per slot, and urban/suburban status), which supplement Aux 1b.
- Line 1302, windows : and }x_{1i}\geq3\right)  $. The next two terms are about teachers originally
- Line 1422, windows : achievement type $n\in\left\{  1,2\right\}  ,$ teacher $i$'s contribution is
- Line 1498, windows : \right)  $ and $\omega\in\Omega^{o}$ provide a good coverage of the observed
- Line 1500, windows : set $\Omega\supset\Omega^{o}$, to allow for the possibility that district
- Line 1502, windows : the same $\Omega=\left\{  0.9,0.95,1,1.05,1.1,1.15\right\}  \times\left\{
- Line 1503, windows : 0,10,30,50,75,100,200,225\right\}  $ throughout.
- Line 1508, windows : d(i)=d\right)  $:
- Line 1536, windows : over 10 years of experience $\left(  x_{1}\geq10\right)  $. Fifty-three
- Line 1560, windows : [c]{lcccccc}\hline\hline
- Line 1580, unix : Budget/Capacity (\$1,000) &  & 50.9 (6.6) &  &
- Line 1585, unix : Share w/MA or above &  & 0.56 (0.28) &  & 0.64
- Line 1592, windows : \ \ \ \ \ \ \ \ \ \ \ \  & 103 & \ \ \ \ \ \  & 103\\\hline\hline
- Line 1626, windows : \hline\hline
- Line 1663, windows : \hline\hline
- Line 1674, windows : continued to use their pre-reform wage schedules ($\omega=\left(  1,0\right)
- Line 1683, windows : depends only on $\left(  x,TC\right)  $ implies that 2) has very limited
- Line 1716, windows : \hline\hline
- Line 1753, unix : \multicolumn{2}{l}{Budget/Capacity (\$1{,}000)}
- Line 1760, windows : \hline\hline
- Line 1783, mixed : \includegraphics[width=0.7\textwidth]{figures/omega2_cdf_formatted.png}
- Line 1827, windows : \hline\hline
- Line 1860, unix : Experience/education, incumbent teachers
- Line 1872, unix : Distribution of residents' age/education
- Line 1880, windows : \hline\hline
- Line 1932, windows : \hline\hline
- Line 1978, windows : \hline\hline
- Line 2060, windows : $\omega=\left(  1,0\right)  $ is imposed on all districts.
- Line 2067, windows : \hline\hline
- Line 2081, windows : \hline\hline
- Line 2198, windows : rigidity, thereby changing the resistance cost function $R\left(
- Line 2199, windows : \cdot\right)  $. In Section 7.2.1 and Appendix B6.3, we examine how
- Line 2223, windows : $(r_{0},r_{1})=\left(  2.3,3.1\right)  \ $performs the best and improves
- Line 2248, windows : \hline\hline
- Line 2296, windows : \hline\hline
- Line 2322, windows : ^{2}\right)  =\left(  1.6,4.3\right)  ,$ New3 leads to a 0.15\% efficiency
- Line 2356, unix : close to being efficient and/or equal, so there is not much room for
- Line 2368, windows : potentially important factors: teachers' moving costs $\Gamma\left(
- Line 2369, windows : \cdot\right)  $ and districts' resistance costs $R\left(  \cdot\right)  $. To
- Line 2371, windows : Teachers have zero moving costs, i.e., $\Gamma\left(  \cdot\right)
- Line 2373, windows : districts face zero resistance costs, i.e., $R\left(  \cdot\right)
- Line 2396, windows : \hline\hline
- Line 2414, windows : \hline\hline
- Line 2472, unix : teacher's path of movements at both the extensive margin (entry/exit) and the
- Line 2492, windows : To study the role of districts' resistance cost $R\left(  \cdot\right)  $ by
- Line 2493, windows : itself, we re-simulated all our three bonus programs by setting $R\left(
- Line 2494, windows : \cdot\right)  =0$ while keeping all other parameters at their estimated
- Line 2497, windows : $(2.3,3.1),$ if we set $R\left(  \cdot\right)  =0,$ this program will yield an
- Line 2572, windows : c_{2}\right]  dF\left(  x,c,d_{0}\right)  \right\} \\
- Line 2595, windows : If the district makes an offer to $\left(  x,c\right)  $ and the offer is
- Line 2647, windows : We model the resistance cost a district faces $R_{d}\left(  \omega\right)  $
- Line 2648, windows : as the following \newline$R_{d}\left(  \omega\right)  =R\left(  \omega
- Line 2674, windows : {wl{18em}wc{4em}wc{4em}wc{4em}wc{4em}wc{4em}wc{4em}}\hline\hline
- Line 2699, windows : {wl{12em}wc{4em}wc{4em}wc{4em}wc{4em}}\hline\hline
- Line 2716, windows : $q_{d}$: large metro & 0.096 & 0.127 &  0.012 & 0.001\\\hline\hline
- Line 2731, windows : \hline\hline
- Line 2753, unix : Budget/Capacity (\$1,000) & 51.2 & 51.0 &  & &
- Line 2754, windows : 50.7 & 50.9\\\hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 187, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 784, unix : !by lambda and b/t quintiles.
- Line 820, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/validation_result/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/Table_B13.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/master.do**

- Line 78, unix : + va_nocomparativeadv.dta - contains teacher contribution w/o comparative advantage. Constructed in valueadded_calculation_nocomparativeadv.do
- Line 110, unix : do $code/build/va_teacherside_build.do
- Line 111, unix : do $code/build/testscores_build.do
- Line 119, unix : do $code/build/teachers_with_allva.do
- Line 122, unix : do $code/build/schedule_new.do
- Line 123, unix : do $code/build/gen_omegas.do
- Line 124, unix : do $code/build/gen_omegas_info.do
- Line 125, unix : do $code/build/build_model_dataset.do
- Line 126, unix : do $code/build/build_teachers_offer_set.do
- Line 127, unix : do $code/auxiliary_regressions/auxiliary_models_teachers.do
- Line 128, unix : do $code/auxiliary_regressions/aux_other_moments.do
- Line 129, unix : do $code/auxiliary_regressions/auxiliary_models_districts.do
- Line 130, unix : do $code/build/build_model_dataset_info0.do
- Line 131, unix : do $code/build/build_model_dataset_info1.do
- Line 132, unix : do $code/build/build_model_dataset_info2.do
- Line 133, unix : do $code/build/build_model_dataset_info3.do
- Line 134, unix : do $code/build/auxiliary_models_teachers_info_matches.do
- Line 136, unix : do $code/build/omega_databuild.do
- Line 137, unix : do $code/build/budget_overtime.do
- Line 139, unix : do $code/build/build_distance_matrix.do
- Line 140, unix : do $code/build/build_wageschedule_exitentry.do
- Line 141, unix : do $code/build/fix_estsample_age.do
- Line 144, unix : do $code/build/build_model_dataset_pre2011.do
- Line 145, unix : do $code/build/build_simulation_lndist.do
- Line 156, unix : do $code/descriptives/summary.do
- Line 159, unix : do $code/auxiliary_regressions/aux_model_teachers_wages.do
- Line 162, unix : do $code/descriptives/omega_analysis.do
- Line 168, unix : do $code/descriptives/data_patterns.do
- Line 181, unix : do $code/descriptives/appendix_figures.do
- Line 184, unix : do $code/descriptives/rothstein_test.do
- Line 187, unix : do $code/build/valueadded_calculation_classmodel.do
- Line 190, unix : do $code/auxiliary_regressions/auxmodels_teachers_varobust.do
- Line 193, unix : do $code/descriptives/c1c2_variation_studentlevel.do
- Line 196, unix : do $code/descriptives/achievement_race.do
- Line 199, unix : do $code/descriptives/schedule_summary.do
- Line 202, unix : do $code/descriptives/salary_variation.do
- Line 205, unix : do $code/auxiliary_regressions/auxiliary_models_teachers_info.do
- Line 208, unix : do $code/auxiliary_regressions/auxiliary_models_teachers_nobottom.do
- Line 211, unix : do $code/auxiliary_regressions/auxiliary_models_teachers_richprefs.do
- Line 218, unix : do $code/descriptives/Table_B15.do
- Line 221, unix : do $code/descriptives/summary_simulation.do
- Line 234, unix : do $code/descriptives/gen_omegas_3omegas.do
- Line 237, unix : do $code/descriptives/gen_omegas_tenured.do
- Line 240, unix : do $code/descriptives/gen_omegas_exp1cutoff.do
- Line 243, unix : do $code/descriptives/budget_shifts.do
- Line 252, unix : do $code/descriptives/lambda_map.do

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/belief_functions.f90**

- Line 124, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 177, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 773, unix : !by lambda and b/t quintiles.
- Line 809, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new4/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/global_variables.f90**

- Line 104, unix : ! XX only need to add these if entry/exit is economy specific

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/validation_result/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/belief_functions.f90**

- Line 124, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/aux_model.f90**

- Line 76, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 202, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 822, unix : !by lambda and b/t quintiles.
- Line 858, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_8.do**

- Line 161, unix : forval col = 1/3 {
- Line 166, unix : forval row = 1/3 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/build_model_dataset.do**

- Line 197, unix : forvalues n = 1/6 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/synthetic_data/code/02_make_synthetic_data.do**

- Line 8, unix : Public simulated/synthetic-data generator.
- Line 17, unix : do synthetic_data/code/00_project_globals.do
- Line 20, unix : do code/00_project_globals.do
- Line 79, unix : forvalues yr = 2006/2016 {
- Line 97, unix : forvalues k = 1/26 {
- Line 456, unix : forvalues yr = 2005/2016 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/objective.f90**

- Line 196, unix : !    (with inc being economy-by-economy for foward iter, can't calclate this stuff anyways, and we don't need/want it)

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/build_model_dataset_info3.do**

- Line 151, unix : forvalues n = 1/6 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/Table_B3.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 16, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_B22.do**

- Line 51, unix : forvalues j = 1/4 {
- Line 65, unix : forvalues j = 1/4 {
- Line 118, unix : forvalues j = 1/4 {
- Line 132, unix : forvalues j = 1/4 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/estimation_result/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_A3_PanelB.do**

- Line 10, unix : use $est/multinomial.dta

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/aux_district_all3_JPE.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 34, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_A3_PanelA.do**

- Line 44, unix : forvalues j = 1/5 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 187, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 784, unix : !by lambda and b/t quintiles.
- Line 820, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_B17.do**

- Line 24, unix : forvalues i = 1/2 {
- Line 157, unix : forvalues j = 1/3 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/utility_functions.f90**

- Line 31, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 90, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_1/read_data_params.f90**

- Line 57, unix : r_vec = 0 !this is set later, b/c we need to know lambda (share_low)
- Line 133, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 152, unix : !b5/b6/b7/b8 rely on svec
- Line 208, unix : param0(i)=1.0d-0/step(j)
- Line 514, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 520, unix : !skip first line b/c it is varname
- Line 525, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 531, unix : !weights for fraction over/under capacity
- Line 592, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 847, unix : ! Moved this to gen teacher data, b/c has nteach dimension
- Line 874, unix : idx = ndist/2   !integer division rounds
- Line 990, unix : !   b/c I randomly don't match some, there is no pattern of unmatching
- Line 1067, unix : !  for now, ignoring the 'pre' code, b/c irrelevant for forward iteration
- Line 1224, unix : !  we match as of 10/13/23
- Line 1255, unix : ! we match as of 10/13/23, except for one person, i=1870, who is an entrant, but somehow had a samecz value.
- Line 1348, unix : ! we are matching as of 10/13/23, although not in floats, some roundings are different
- Line 1369, unix : ! made this work as a portable function only using local variables here b/c
- Line 1498, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1513, unix : ! made this work as a portable function only using local variables here b/c
- Line 1660, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1861, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/objective.f90**

- Line 196, unix : !    (with inc being economy-by-economy for foward iter, can't calclate this stuff anyways, and we don't need/want it)

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/read_data_params.f90**

- Line 57, unix : r_vec = 0 !this is set later, b/c we need to know lambda (share_low)
- Line 133, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 152, unix : !b5/b6/b7/b8 rely on svec
- Line 208, unix : param0(i)=1.0d-0/step(j)
- Line 514, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 520, unix : !skip first line b/c it is varname
- Line 525, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 531, unix : !weights for fraction over/under capacity
- Line 592, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 847, unix : ! Moved this to gen teacher data, b/c has nteach dimension
- Line 874, unix : idx = ndist/2   !integer division rounds
- Line 990, unix : !   b/c I randomly don't match some, there is no pattern of unmatching
- Line 1067, unix : !  for now, ignoring the 'pre' code, b/c irrelevant for forward iteration
- Line 1224, unix : !  we match as of 10/13/23
- Line 1255, unix : ! we match as of 10/13/23, except for one person, i=1870, who is an entrant, but somehow had a samecz value.
- Line 1348, unix : ! we are matching as of 10/13/23, although not in floats, some roundings are different
- Line 1369, unix : ! made this work as a portable function only using local variables here b/c
- Line 1498, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1513, unix : ! made this work as a portable function only using local variables here b/c
- Line 1660, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1861, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/build_model_dataset_pre2011.do**

- Line 130, unix : forvalues n = 1/6 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/1_baseline/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 187, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 784, unix : !by lambda and b/t quintiles.
- Line 820, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new1/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case1/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/nrutil.f90**

- Line 762, unix : summ=1.0d0/a
- Line 784, unix : REAL(8), PARAMETER :: EPS=2.220446049250313D-012,FPMIN=1.0D-250/EPS
- Line 792, unix : c=1.0d0/FPMIN
- Line 793, unix : d=1.0d0/b
- Line 800, unix : c=b+an/c
- Line 802, unix : d=1.0d0/d

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new3/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/main.f90**

- Line 38, unix : ! entry/exit
- Line 76, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi
- Line 175, unix : !    - c1/c2
- Line 182, unix : open(1, file = 'result/entryexit_stats.txt', status = 'replace')
- Line 215, unix : ! If after first period we have to move things forward and draw entrants/exits
- Line 244, unix : ! adjust c1/c2, only needs to happen if changing experience group
- Line 281, unix : !  (altho this requires share_low, share_low isn't affected by changing c1/c2)
- Line 318, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 356, unix : ! Second, adjust exit prob b/c of wage_change
- Line 395, unix : !   !    (need to do this here b/c my depend on omegas, which are economy-specific)
- Line 455, unix : ! Here we calculate the expected number of entrants/exits across economies
- Line 490, unix : ! save incumbents in the data b/c we will need to reallocate these arrays
- Line 536, unix : ! And we also have to save the district info... b/c these get expanded as well
- Line 624, unix : open(1, file = 'result/entryexit_stats.txt', action='write', position='append')
- Line 732, unix : ! for incumbents, b/c pop changes, we need to recalc baseline wage each period, so keep omegas
- Line 737, unix : ! for entrants, b/c pop is static, we can calculate a base wage now.
- Line 741, unix : ! Don't need to do this for incumbents b/c the pop will change so we will work with omegas for them

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/perturbation/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/baseline/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case_baseline/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/aux_model.f90**

- Line 76, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 202, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 822, unix : !by lambda and b/t quintiles.
- Line 858, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/perturbation/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/estimation_result/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/read_data_params.f90**

- Line 57, unix : r_vec = 0 !this is set later, b/c we need to know lambda (share_low)
- Line 133, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 152, unix : !b5/b6/b7/b8 rely on svec
- Line 208, unix : param0(i)=1.0d-0/step(j)
- Line 514, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 520, unix : !skip first line b/c it is varname
- Line 525, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 531, unix : !weights for fraction over/under capacity
- Line 592, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 847, unix : ! Moved this to gen teacher data, b/c has nteach dimension
- Line 874, unix : idx = ndist/2   !integer division rounds
- Line 990, unix : !   b/c I randomly don't match some, there is no pattern of unmatching
- Line 1067, unix : !  for now, ignoring the 'pre' code, b/c irrelevant for forward iteration
- Line 1224, unix : !  we match as of 10/13/23
- Line 1255, unix : ! we match as of 10/13/23, except for one person, i=1870, who is an entrant, but somehow had a samecz value.
- Line 1348, unix : ! we are matching as of 10/13/23, although not in floats, some roundings are different
- Line 1369, unix : ! made this work as a portable function only using local variables here b/c
- Line 1498, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1513, unix : ! made this work as a portable function only using local variables here b/c
- Line 1660, unix : !   if checking match, make sure exit prob gets run on t=0 population before moving forward c1/c2, age.
- Line 1861, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/2_rigid/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new2/random.f90**

- Line 61, unix : zigwn(0) = zigq/zigm1
- Line 62, unix : zigwn(127) = zigdn/zigm1
- Line 70, unix : zigwn(i) = zigdn/zigm1
- Line 76, unix : zigwe(0) = zigq/zigm2
- Line 77, unix : zigwe(255) = zigde/zigm2
- Line 81, unix : zigde = -LOG( zigve/zigde + EXP( -zigde ) )
- Line 85, unix : zigwe(i) = zigde/zigm2
- Line 216, unix : d = a - 1.0d0/3.0d0
- Line 236, unix : Sample_Gamma=Sample_Gamma/b
- Line 304, unix : w=w/SUM(w)
- Line 342, unix : z = Sample_Exponential(1.0d0/c)
- Line 394, unix : w=w/SUM(w)
- Line 451, unix : z = Sample_Exponential(1.0d0/c1)
- Line 515, unix : Sample_Dirichlet = rg/sg
- Line 615, unix : zabs=zabs/std

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/omega_databuild.do**

- Line 164, unix : use $est/matched_movers.dta, clear
- Line 249, unix : use $est/multinomial.dta, clear

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_baseline/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/6_forward/forward_new1/belief_functions.f90**

- Line 124, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new2/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 187, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 784, unix : !by lambda and b/t quintiles.
- Line 820, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/1_baseline/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/knapsack_problem.f90**

- Line 48, unix : !if open budget/capacity, figure out how many offers to make
- Line 74, unix : !algorithm, move lambda 'window' up until low/high bracket the solution
- Line 120, unix : ! need to run again, b/c we don't know which lambda the solver ran last.

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/valueadded_calculation_classmodel.do**

- Line 35, unix : forvalues n = 1/26 {
- Line 36, unix : forvalues m = 1/26 {
- Line 78, unix : forvalues p = 1/3 {
- Line 79, unix : forvalues g = 3/7 {
- Line 90, unix : forvalues x = 1/25 {
- Line 117, unix : forvalues x = 2/26 {
- Line 144, unix : forvalues e = 1/6 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/valueadded_calculation_stockstaiger_nocomparativeadv.do**

- Line 50, unix : forvalues p = 1/3 {
- Line 51, unix : forvalues g = 3/7 {
- Line 59, unix : forvalues x = 1/25 {
- Line 83, unix : forvalues x = 2/26 {
- Line 109, unix : forvalues e = 1/6 {
- Line 172, unix : gen shrinkage = sigma_mu / (sigma_mu + (1/den))

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_05/aux_model.f90**

- Line 76, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 202, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 822, unix : !by lambda and b/t quintiles.
- Line 858, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/descriptives/Table_B20.do**

- Line 28, unix : forval col = 1/4 {
- Line 208, unix : forval col = 1/4 {
- Line 216, unix : forval row = 1/7 {

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/stderr/belief_functions.f90**

- Line 114, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_2/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 187, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 784, unix : !by lambda and b/t quintiles.
- Line 820, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_15/belief_functions.f90**

- Line 124, unix : ! for eqbm in cf we need more parameters b/c belief structure changes w/ cf design

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/estimation_result/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new2_05/objective.f90**

- Line 196, unix : !    (with inc being economy-by-economy for foward iter, can't calclate this stuff anyways, and we don't need/want it)

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/build/valueadded_calculation.do**

- Line 50, unix : forvalues p = 1/3 {
- Line 51, unix : forvalues g = 3/7 {
- Line 59, unix : forvalues x = 1/25 {
- Line 83, unix : forvalues x = 2/26 {
- Line 107, unix : forvalues e = 1/6 {
- Line 224, unix : gen shrinkage1 = sigma_mu1 / (sigma_mu1 + (1/den1))
- Line 225, unix : gen shrinkage0 = sigma_mu0 / (sigma_mu0 + (1/den0))
- Line 226, unix : gen shrinkage = sigma_mu / (sigma_mu + (1/den))

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_15/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/main.f90**

- Line 45, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/2_rigid/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/3_basicCfs/new1/aux_model.f90**

- Line 61, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 187, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 784, unix : !by lambda and b/t quintiles.
- Line 820, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new2/read_data_params.f90**

- Line 106, unix : !doing b1/b2/b3/b4 subsidy counterfactual
- Line 178, unix : param0(i)=1.0d-0/step(j)
- Line 482, unix : weight_mat(i,i) = 1/weight_vec(i)
- Line 488, unix : !skip first line b/c it is varname
- Line 493, unix : other_weight_mat(i,i) = 1/other_weight_mat(i,i)
- Line 499, unix : !weights for fraction over/under capacity
- Line 560, unix : omega_weight_mat(i,i) = 1/omega_weight_vec(i)
- Line 803, unix : idx = ndist/2   !integer division rounds
- Line 1050, unix : idx = ndist/2   !integer division rounds

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/8_noRcost/new3/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 754, unix : !initialize vars help to print information to terminal/txt files...
- Line 760, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 765, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 768, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 771, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 774, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 778, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 787, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 1044, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1047, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1060, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1220, unix : !now calc target H, mean/sd wage
- Line 1266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1320, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1330, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1341, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1451, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1452, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1469, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1470, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1471, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1472, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1503, unix : do j=1, rec_count/nteach

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_1/aux_model.f90**

- Line 76, unix : !  As of 12/15/22 we match. Also down below line ~550 is the code to set wage prob for aux testing
- Line 202, unix : !progressively stack all of our copies (this is hard b/c we don't know size)
- Line 822, unix : !by lambda and b/t quintiles.
- Line 858, unix : ! adding information on over/under capacity for districts

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/5_exitentry/new1_15/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/out_synth/tables/aux_district_noninc2_JPE.tex**

- Line 2, windows : \def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}
- Line 4, windows : \hline\hline
- Line 34, windows : \hline\hline

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/7_higherbonus/new1_25/write_moments.f90**

- Line 58, unix : param_desc(27) = '  gamma 5, r21, omega2/100         '
- Line 59, unix : param_desc(28) = '  gamma 6, r22, dem x omega2/100   '
- Line 153, unix : open(1, file = 'result/aux_and_omega_params.txt', status = 'replace')
- Line 350, unix : open(2, file = 'result/other_aux_params.txt', status = 'replace')
- Line 435, unix : mom11desc(1) = 'new hires/capacity'
- Line 450, unix : ! adding information on over/under capacity for districts
- Line 617, unix : !sim/calib moments
- Line 638, unix : desc_aux_other(21)  = '       budget/capacity (low):  exp                '
- Line 639, unix : desc_aux_other(22)  = '       budget/capacity:        exp                '
- Line 640, unix : desc_aux_other(23)  = '       budget/capacity:        exp                '
- Line 641, unix : desc_aux_other(24)  = '       budget/capacity:        exp                '
- Line 642, unix : desc_aux_other(25)  = '       budget/capacity (high): exp                '
- Line 643, unix : desc_aux_other(26)  = '       budget/capacity (low):  v1                 '
- Line 644, unix : desc_aux_other(27)  = '       budget/capacity:        v1                 '
- Line 645, unix : desc_aux_other(28)  = '       budget/capacity:        v1                 '
- Line 646, unix : desc_aux_other(29)  = '       budget/capacity:        v1                 '
- Line 647, unix : desc_aux_other(30)  = '       budget/capacity (high): v1                 '
- Line 648, unix : desc_aux_other(31)  = '       budget/capacity (low):  v2                 '
- Line 649, unix : desc_aux_other(32)  = '       budget/capacity:        v2                 '
- Line 650, unix : desc_aux_other(33)  = '       budget/capacity:        v2                 '
- Line 651, unix : desc_aux_other(34)  = '       budget/capacity:        v2                 '
- Line 652, unix : desc_aux_other(35)  = '       budget/capacity (high): v2                 '
- Line 653, unix : desc_aux_other(36)  = '       budget/capacity (low):  masters            '
- Line 654, unix : desc_aux_other(37)  = '       budget/capacity:        masters            '
- Line 655, unix : desc_aux_other(38)  = '       budget/capacity:        masters            '
- Line 656, unix : desc_aux_other(39)  = '       budget/capacity:        masters            '
- Line 657, unix : desc_aux_other(40)  = '       budget/capacity (high): masters            '
- Line 680, unix : desc_aux_other(63)  = '       fraction empl only ten-inc: budget/capacity'
- Line 681, unix : desc_aux_other(64)  = '       fraction empl only ten-inc: budget/capacity'
- Line 682, unix : desc_aux_other(65)  = '       fraction empl only ten-inc: budget/capacity'
- Line 683, unix : desc_aux_other(66)  = '       fraction empl only ten-inc: budget/capacity'
- Line 684, unix : desc_aux_other(67)  = '       fraction empl only ten-inc: budget/capacity'
- Line 691, unix : desc_aux_other(74)  = '       dist w/ new hires: new/capacity            '

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/stderr/main.f90**

- Line 52, unix : ! read the teacher/district data, needed in all threads so just reading in instead of mpi
- Line 320, unix : ! And weirdness we have to do b/c.... avoid nan and how params reconstructed
- Line 344, unix : open(1, file='result/perturb_param.txt', status = 'replace')
- Line 350, unix : open(1, file='result/perturb_aux.txt', status = 'replace')
- Line 362, unix : open(1, file='result/perturb_aux_full.txt', status = 'replace')
- Line 488, unix : open(1, file='result/G.txt', status = 'replace')
- Line 489, unix : open(2, file='result/W.txt', status = 'replace')
- Line 490, unix : open(3, file='result/bigOmega.txt', status = 'replace')
- Line 579, unix : open(1, file='result/se_param.txt', status = 'replace')
- Line 717, unix : Ainv = 1d0/na_trick
- Line 729, unix : Ainv = 1d0/na_trick

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/utility_functions.f90**

- Line 28, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need
- Line 81, unix : !moving cost, for entrants cost is irrelevant/unidentified in our model so no need

**/Users/florianoswald/actions-runner/_work/JPE-Biasi-20220349/JPE-Biasi-20220349/replication-package/replication_delivery/code/fortran_model/4_nomovecost/case2_new2/inner_loop_one.f90**

- Line 95, unix : !adjust uteach to avoid larg value, i.e. exp(uteach/sigma) = inf
- Line 239, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 244, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 247, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 250, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 253, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 257, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 266, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 267, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 268, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 291, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 301, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 332, unix : !Note, removed old, nonconvex obj_fn, as well as printing/diagnostic capability
- Line 334, unix : !   ./!old/inner_loop_one_has_extra_testing_print_function.f90
- Line 338, unix : !  AS SUGGESTED BY CHAO 6/14/19
- Line 507, unix : allocate(udistt(nteach,rec_count/nteach))
- Line 511, unix : allocate(waget(nteach,rec_count/nteach))
- Line 515, unix : allocate(inct(nteach,rec_count/nteach))
- Line 519, unix : allocate(tenuredt(nteach, rec_count/nteach))
- Line 529, unix : allocate(Ht(nteach,rec_count/nteach))
- Line 530, unix : allocate(model_offert(nteach,rec_count/nteach))
- Line 531, unix : if(wage_decision == 1) allocate(pr_model_Wgridt(nWgrid1,nWgrid2,rec_count/nteach))
- Line 540, unix : !pass/receive H across threads
- Line 547, unix : do j=1, rec_count/nteach
- Line 568, unix : ! This is an issue though for using h_logit_vary, b/c those global vars
- Line 575, unix : double precision, dimension(nteach,rec_count/nteach) :: Ht_vary, waget_vary
- Line 602, unix : do j=1, rec_count/nteach!85,85
- Line 728, unix : !sim omegas now global so aux model can see them w/out passing variable
- Line 747, unix : !matrix for the 50 economy beliefs, hardcoding b/c read in is also hardcoded...
- Line 756, unix : !initialize vars help to print information to terminal/txt files...
- Line 762, unix : open(1,file='result/eqbm_dist_contribution.txt',status='replace')
- Line 767, unix : open(1,file='result/eqbm_dist_hires.txt',status='replace')
- Line 770, unix : open(1,file='result/eqbm_dist_wages.txt',status='replace')
- Line 773, unix : open(1,file='result/eqbm_beliefs.txt',   status='replace')
- Line 776, unix : open(1,file='result/eqbm_teach_contribution.txt',status = 'replace')
- Line 780, unix : open(1,file='result/state_burden.txt', status='replace')
- Line 789, unix : open(1, file = 'result/teacher_welfare.txt', status='replace')
- Line 894, unix : ! need to introduce something to avoid NAs here b/c we were making thetas == 0 so can't do pct change like this
- Line 1069, unix : pr_model_match = pr_model_match + pr_match_eqm/nEconomy
- Line 1072, unix : pr_model_Wgrid = pr_model_Wgrid + pr_omegas_eqm_glob/nEconomy
- Line 1085, unix : open(1,file='result/eqbm_omegas.txt',status='replace')
- Line 1245, unix : !now calc target H, mean/sd wage
- Line 1297, unix : open(1,file='result/eqbm_dist_contribution.txt', action='write',position='append')
- Line 1298, unix : open(2,file='result/eqbm_dist_hires.txt', action='write',position='append')
- Line 1299, unix : open(3,file='result/eqbm_dist_wages.txt', action='write',position='append')
- Line 1351, unix : open(1,file='result/eqbm_beliefs.txt', action='write',position='append')
- Line 1361, unix : open(4,file='result/eqbm_teach_contribution.txt', action='write', position='append')
- Line 1372, unix : open(1,file='result/state_burden.txt', action='write',position='append')
- Line 1482, unix : open(1,file='result/teacher_welfare.txt', action='write',position='append')
- Line 1483, unix : ! sum teacher utility, across all offers/probability of being in that district
- Line 1500, unix : double precision, dimension(nteach,rec_count/nteach) :: waget_eqm, waget_vary, Ht_vary, Ht_eqm
- Line 1501, unix : double precision, dimension(NWgrid1,NWgrid2,rec_count/nteach) :: pr_omegast_eqm
- Line 1502, unix : double precision, dimension(2,rec_count/nteach)      :: omegast_eqm
- Line 1503, unix : integer,          dimension(nteach,rec_count/nteach) :: offert_eqm
- Line 1534, unix : do j=1, rec_count/nteach


*===============================================================================
* Table B14 (Parameter Perturbation Exercise)
* Extract Perturbation result for Table_B14
*===============================================================================

clear

* load all the param perturbations, and take difference
import delimited "$fortran_code/perturbation/result/perturb_aux_full.txt", delimiter(space, collapse)
drop v1 v30
*need to take difference to v2 (first column) to see the perturbation 
foreach vname of varlist v3-v29 {
	*replace `vname' = `vname' - v2
	replace `vname' = (`vname' - v2 ) / v2
}

*merge in weights
gen rownum = _n
tempfile perturb
save `perturb', replace

drop _all
import delimited "$fortran_code/perturbation/result/weight_mat.txt", delimiter(space, collapse)
drop v1 v3 
rename v2 weight 
*rename v1 weight
gen rownum = _n
merge 1:1 rownum using `perturb'
drop _merge

*we will look at WEIGHTED absolute simple difference
foreach vname of varlist v3-v29 {
	*replace `vname' = abs(`vname' * weight)
	replace `vname' = abs(`vname')
}


* naux 66, nauxomega = 50, ncalib 83   (66, 116)  
*  (for easy checking of numbers, see objective.f90 lines 575+, and the latest_aux_param.txt 
*      and calibration_moments.txt files for double checking values)
* now add group flags
gen group = 0
*aux 1a
replace group = 11 if rownum >= 1 & rownum <= 13      
*aux 1b
replace group = 12 if rownum >= 14 & rownum <= 26
*aux 2 (district level teacher caracteristics (x,c1,c2) by district groups, quintiles of lambda/budget, and urban/suburban status)
replace group = 2 if rownum >= 131 & rownum <= 186
*aux 3 (regressions of wage schedule on district conditions)
replace group = 3 if rownum >= 75  & rownum <= 108
*aux 4 (cross district wage moments, average and variance/cov of omega1,omega2)
replace group = 4 if rownum >= 109 & rownum <= 130
* idk where to categorize, these are incumbernt/new-hire/slot moments 
replace group = 5 if rownum >= 187


* change group flag if weight is zero, so not included in average
replace group = 0 if weight == 0


* Now can summarize by group
drop if group == 0
collapse (mean) v3-v29, by(group)




* rename so we know what is what
*rename v2   unperturbed_aux
rename v3   alpha1_urban
rename v4   alpha2_suburban
rename v5   alpha3_milwaukee
rename v6   alpha4_exp_lambda
rename v7   alpha5_c1_lambda
rename v8   alpha7_move_exp2
rename v9   alpha8_move_exp3
rename v10  alpha9_move_exp4
rename v11  alpha10_move_exp5
rename v12  alpha11_move_exp6
rename v13  alpha12_move_logdist
rename v14  alpha13_samecz
rename v15  beta2_exp2
rename v16  beta3_exp3
rename v17  beta4_exp4
rename v18  beta5_exp5
rename v19  beta6_exp6
rename v20  beta7_lambda_c2
rename v21  beta8_master
rename v22  sigma_teacher
rename v23  gamma1_fc
rename v24  gamma2_dem
rename v25  gamma3_o1
rename v26  gamma4_dem_o1
rename v27  gamma5_o2
rename v28  gamma6_dem_o2
rename v29  sigma_wage


*for easier reading sort so 11 and 12 are first
gen sortvar = group
replace sortvar = 1 if group == 12
replace sortvar = 0 if group == 11
sort sortvar 
drop sortvar


* Create summary columns by averaging within each category
egen teacher = rowmean(alpha* sigma_teacher)
egen district = rowmean(beta*)
egen gamma_wage = rowmean(gamma* sigma_wage)

* Keep only group and the three summary columns
keep group teacher district gamma_wage

* Convert to percentages, round to hundredths place, and add % symbol
foreach var of varlist teacher district gamma_wage {
	replace `var' = round(`var' * 100, 0.01)
	tostring `var', replace force format(%9.2f)
	replace `var' = `var' + "%"
}

* don't need the group=5 row
drop if group == 5

* Export to CSV
export delimited using "$out/tables/Table_B14.csv", replace



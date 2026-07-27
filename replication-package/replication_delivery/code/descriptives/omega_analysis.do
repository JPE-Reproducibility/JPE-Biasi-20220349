********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    omega_analysis.do
* Purpose: Analyze district omega choices.
********************************************************************************

clear all
set more off
set matsize 11000

global controls = "std_score_past disab_status el_status econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind"
global graph = "xlabel(,grid glp(dot) glc(gs10) tlc(gs10)) ylabel(,grid glp(dot) glc(gs10) tlc(gs10) angle(0)) plotregion(lp(blank))"
global graphy = "ylabel(,grid glp(dot) glc(gs10) tlc(gs10) angle(0)) plotregion(lp(blank))"


use "$intdata/omega_analysis_data_JPE.dta", clear
gen budget_pp = budget / capacity
gen attr_ratio_avg = attr_c / attr_median_exp
gen attr_int = attr_c * attr_totalexp2
gen logmedinc = ln(medianinc)
gen d2 = d * d
gen explambda = exp(d)
gen tc_lambda = tc * d
gen dhigh = d > 0.6
capt gen absalpha0 = abs(alpha0 - 1)

* Useful globals.
global distdem "sharepop_below15 sharepop_above64 ba_or_higher"
global econ "share_poverty logmedinc"
global students "econ_disadvantage"
global studentexp "econ_disadvantage explambda"
global studentsq "econ_disadvantage d d2"
global teachers "attr_totalexp2 attr_c"
global teachers_pct "attr_exp_10pct attr_c_10pct"
global teachers_ratio "attr_ratio"
global teachers_ratio_avg "attr_ratio_avg"
global teachers_int "attr_totalexp2 attr_c attr_int"
global lambdasq "d d2"
global lambdaexp "explambda"

* Label variables.
label var tc "TC"
label var tc_sd "sd TC"
label var tc_tenured "TC, tenured"
label var CZ_tc "TC, other teachers in CZ"
label var sharepop_below15 "Share pop below 15yo"
label var sharepop_15_24 "Share pop 15-24yo"
label var sharepop_25_64 "Share pop 25-64yo"
label var sharepop_above64 "Share pop 64+yo"
label var highschool "Share pop w/ HS degree"
label var ba_or_higher "Share pop w/ college+"
label var share_poverty "Share in poverty"
label var share_inc_above_200k "Share w/ income > $200K"
label var logmedinc "ln(median income)"
label var suburban "Suburban"
label var urban "Urban"
label var capacity "Capacity"
label var budget_pp "Budget pp"
label var democratic "Share democr"
label var econ_disadvantage "Share econ disadv students"
label var d "$ \lambda $"
label var attr_totalexp2 "Avg exp preferred Ts"
label var attr_c "Avg C preferred Ts"
label var attr_exp_10pct "10pctl exp preferred Ts"
label var attr_c_10pct "10pctl Avg C preferred Ts"
label var explambda "exp(lambda)"
label var d2 "$ \lambda $ sq"
label var attr_ratio "Avg C / median exp for preferred"
label var attr_ratio_avg "Avg (C / exp+1) for preferred"
label var attr_int "Avg C * avg exp for preferred"
label var tc_lambda "TC * lambda"
label var dhigh "lambda>0.6"

gen pp = alpha1 > 0
gen rigid = alpha0 == 1 & alpha1 == 0
gen lnalpha1 = ln(alpha1 + 1)
gen ratio_alpha = alpha1 / alpha0
gen lnratio_alpha = ln(alpha1 + 1) / alpha0
capture replace priven = 0 if priven == .
capture label var priven "Private sch enrl"

* Showing nothing matters except for share dem.

global base = "capacity budget_pp d tc tc_tenured Exp3 Exp4 Exp5 Exp6 master CZ_tc CZ_tenured urban suburban milwaukee"
global income = "logmedinc share_inc_above_200k share_poverty"
global pop = "sharepop_below15 sharepop_above64 ba_or_higher"

rename alpha0 omega1
rename alpha1 omega2
rename absalpha0 absdev_omega1

local var = "omega2"

* foreach var in omega1 omega2 absdev_omega1 {
eststo r1: reg `var' $base dem, rob
eststo r2: reg `var' $base $income dem, rob
eststo r3: reg `var' $base $income $pop dem, rob
capture log close
log using "$out/tables/Table_4.log", replace
esttab r*, replace label noabb b(3) se(3) ///
    star(* 0.1 ** 0.05 *** 0.01) stat(N r2)
log close	
* esttab r* using "$out/`var'_short.txt", replace label noabb b(3) se(3) ///
*     star(* 0.1 ** 0.05 *** 0.01) stat(N r2)
*}

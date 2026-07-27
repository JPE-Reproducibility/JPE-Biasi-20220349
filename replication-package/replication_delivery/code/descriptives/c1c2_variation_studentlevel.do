********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    c1c2_variation_studentlevel.do
* Purpose: Compare residual achievement variation explained by a single
*          contribution measure versus student-type-specific contributions.
********************************************************************************


global controls = "std_score_past disab_status el_status econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind"


********************************************************************************
* Teacher Contribution Inputs
********************************************************************************

* Build teacher-level c0/c1 measures from the teacher panel.
use "$intdata/teachers_panel_JPE.dta", clear
qui tab exp, gen(Exp)

gen xb0 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)
gen xb1 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)

collapse v0 xb0 v1 xb1, by(id)
gen c0 = v0 + xb0
gen c1 = v1 + xb1
keep id c0 c1
sort id

tempfile twotype_va
save `twotype_va', replace

* Attach single-measure and two-measure VA estimates to each teacher slot in
* the school-grade-year teacher-side file.
use "$intdata/va_teacherside_math_JPE.dta", clear
capt drop _merge

qui forvalues n = 1/26 {
    noisily disp `n'

    preserve
    use "$intdata/va_nocomparativeadv_JPE.dta", clear
    collapse v, by(id)
    keep id v
    duplicates drop
    drop if v == . | id == .
    rename id id`n'
    rename v c_`n'
    sort id`n'
    tempfile single_va
    save `single_va', replace
    restore

    sort id`n'
    merge m:1 id`n' using `single_va'
    drop if _merge == 2
    drop _merge

    preserve
    use `twotype_va', clear
    duplicates drop
    drop if c0 == . | c1 == . | id == .
    rename id id`n'
    rename c0 c0_`n'
    rename c1 c1_`n'
    sort id`n'
    tempfile type_va
    save `type_va', replace
    restore

    sort id`n'
    merge m:1 id`n' using `type_va'
    drop if _merge == 2
    drop _merge
}

sort district_code schoolcode grade year
tempfile teacher_team
save `teacher_team', replace


********************************************************************************
* Student Achievement Residuals
********************************************************************************

use "$intdata/indtest_math_split_JPE.dta", clear
gen lambda = std_score < 0.07
keep if std_score_past != . & year < 2017
drop if grade < 3 | grade > 8
replace lambda = . if std_score == .

sort district_code schoolcode grade year
merge m:1 district_code schoolcode grade year using `teacher_team'
keep if _merge == 3
drop _merge

egen sumc = rowtotal(c_*)
egen sumc0 = rowtotal(c0_*)
egen sumc1 = rowtotal(c1_*)

egen schoolid = group(district_code schoolcode)
foreach var in std_score_past disab_status el_status econ_disadvantage ///
    Sfemale Sblack Shispanic Sasian Sam_ind {
    bysort district_code schoolcode grade year: egen M`var' = mean(`var')
}

gen t = 1
bysort district_code schoolcode grade year: egen Msize = sum(t)
drop t

* Interact polynomials in lagged test scores with grade indicators.
forvalues p = 1/3 {
    forvalues g = 3/7 {
        gen past`p'_grade`g' = ((std_score_past)^`p') * (grade == `g')
        gen Mpast`p'_grade`g' = ((Mstd_score_past)^`p') * (grade == `g')
    }
}

keep if grade <= 6

gen res = .

qui reghdfe std_score c.std_score_past#i.grade past1* past2* ///
    c.past3* c.Mpast1* c.Mpast2* c.Mpast3* i.year i.disab_status ///
    i.el_status i.econ_disadvantage i.Sfemale i.Sblack i.Shispanic ///
    i.Sasian i.Sam_ind Mdisab_status Mel_status Mecon_disadvantage ///
    c.Mecon_disadvantage#i.econ_disadvantage MSfemale MSblack ///
    MShispanic MSasian MSam_ind Msize if lambda == 1, ///
    a(schoolid) resid
tempvar residual_low
predict `residual_low', resid
replace res = `residual_low' if lambda == 1

qui reghdfe std_score c.std_score_past#i.grade past1* past2* ///
    c.past3* c.Mpast1* c.Mpast2* c.Mpast3* i.year i.disab_status ///
    i.el_status i.econ_disadvantage i.Sfemale i.Sblack i.Shispanic ///
    i.Sasian i.Sam_ind Mdisab_status Mel_status Mecon_disadvantage ///
    c.Mecon_disadvantage#i.econ_disadvantage MSfemale MSblack ///
    MShispanic MSasian MSam_ind Msize if lambda == 0, ///
    a(schoolid) resid
tempvar residual_high
predict `residual_high', resid
replace res = `residual_high' if lambda == 0

qui reghdfe std_score c.std_score_past#i.grade past1* past2* ///
    c.past3* c.Mpast1* c.Mpast2* c.Mpast3* i.year i.disab_status ///
    i.el_status i.econ_disadvantage i.Sfemale i.Sblack i.Shispanic ///
    i.Sasian i.Sam_ind Mdisab_status Mel_status Mecon_disadvantage ///
    c.Mecon_disadvantage#i.econ_disadvantage MSfemale MSblack ///
    MShispanic MSasian MSam_ind Msize, a(schoolid) resid
predict res_all, resid


********************************************************************************
* Compare Residual Variation
********************************************************************************

gen score_c = std_score - sumc
gen score_c01 = std_score - sumc0 if lambda == 1
replace score_c01 = std_score - sumc1 if lambda == 0

gen res_c = res_all - sumc
gen res_c01 = res - sumc0 if lambda == 1
replace res_c01 = res - sumc1 if lambda == 0

replace score_c = score_c^2
replace score_c01 = score_c01^2
replace res_c = res_c^2
replace res_c01 = res_c01^2

gen nrst = 1
bysort district_code schoolcode grade year: egen lambda_share = mean(lambda)

collapse lambda_share (sum) res_c res_c01 score_c score_c01 nrst, ///
    by(district_code schoolcode grade year lambda)

sort district_code schoolcode grade year
replace res_c = res_c / nrst
replace res_c01 = res_c01 / nrst
replace score_c = score_c / nrst
replace score_c01 = score_c01 / nrst


********************************************************************************
* Table B7 Log Output
********************************************************************************

capture log close
log using "$out/tables/Table_B7.log", replace

qui sum res_c [aw = nrst], det
local mc: di %9.4f r(mean)
disp "c, all students = `mc'"
qui sum res_c01 [aw = nrst], det
local mc0: di %9.4f r(mean)
disp "(c1,c2), all students = `mc0'"
local diff: disp %3.1f 100*((`mc'/`mc0') - 1)
disp "Difference, all students = `diff'%"

preserve
keep if lambda == 1
qui sum res_c [aw = nrst], det
local mc: di %9.4f r(mean)
disp "c, tau_k=1 = `mc'"
qui sum res_c01 [aw = nrst], det
local mc0: di %9.4f r(mean)
disp "(c1,c2), tau_k=1 = `mc0'"
local diff: disp %3.1f 100*((`mc'/`mc0') - 1)
disp "Difference, tau_k=1 = `diff'%"
restore

preserve
keep if lambda == 0
qui sum res_c [aw = nrst], det
local mc: di %9.4f r(mean)
disp "c, tau_k=2 = `mc'"
qui sum res_c01 [aw = nrst], det
local mc0: di %9.4f r(mean)
disp "(c1,c2), tau_k=2 = `mc0'"
local diff: disp %3.1f 100*((`mc'/`mc0') - 1)
disp "Difference, tau_k=2 = `diff'%"
restore

capture log close

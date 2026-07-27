********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    teachers_with_allva.do
* Purpose: Build the teacher panel with all value-added estimates.
* Date:    June 2026
********************************************************************************


********************************************************************************
* Combine value-added estimates
********************************************************************************

* All years; fixed effects
use "$intdata/va_highlow_math_expdisc_JPE.dta", clear
capt drop vmean

* Construct weighted averages and rename teacher-type-specific estimates.
gen vmean = ((v0 * nr0) + (v1 * nr1)) / (nr0 + nr1)
gen vmean_u = ((mu0 * nr0) + (mu1 * nr1)) / (nr0 + nr1)
rename mu0 v0_u
rename mu1 v1_u
rename v0 v0
rename v1 v1
rename nr0 nr0
rename nr1 nr1
rename nr nr

drop v_* mu

sort id year

gen g2_1 = Mg2_1
gen g3_1 = Mg3_1
gen g4_1 = Mg4_1
gen g5_1 = Mg5_1
gen g6_1 = Mg6_1

gen g2_2 = Mg2_2
gen g3_2 = Mg3_2
gen g4_2 = Mg4_2
gen g5_2 = Mg5_2
gen g6_2 = Mg6_2

tempfile valueadded
save `valueadded', replace

********************************************************************************
* Merge with teacher information
********************************************************************************

use "$intdata/teachers_panel_nova_JPE.dta", replace

* Merge value-added estimates into the teacher panel.
sort id year
merge m:1 id year using `valueadded'
drop if _m == 2
drop _m


********************************************************************************
* Finalize and save
********************************************************************************

* Keep only the variables used downstream.
keep id year district_code schoolcode district_past* M* R* v0 v1 g*_* ///
    exp salary_round masterup cesa type totalexp2 all_elem math reading ///
    english highgrade lowgrade fte_tot mover_d exit entry birth
order id year district_code district_past* exp masterup salary_round cesa ///
    type v0 v1, first

save "$intdata/teachers_panel_JPE.dta", replace

********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    salary_variation.do
* Purpose: Regress teacher salaries on student-type-specific contribution
*          measures for Appendix Table B10.
********************************************************************************



********************************************************************************
* Prepare Teacher Contribution Measures
********************************************************************************

use "$intdata/teachers_panel_JPE.dta", clear
qui tab exp, gen(Exp)

gen xb0 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)
gen xb1 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)

gen c1 = v0 + xb0
gen c2 = v1 + xb1

egen schoolid = group(district_code schoolcode)


********************************************************************************
* Appendix Table B10
********************************************************************************

capture log close
log using "$out/tables/Table_B10.log", replace

reghdfe salary_round c1 c2 if year > 2012, a(totalexp2 masterup)
reghdfe salary_round c1 c2 if year > 2012, ///
    a(totalexp2 masterup district_code)
reghdfe salary_round c1 c2 if year > 2012, ///
    a(totalexp2 masterup district_code schoolid)

capture log close

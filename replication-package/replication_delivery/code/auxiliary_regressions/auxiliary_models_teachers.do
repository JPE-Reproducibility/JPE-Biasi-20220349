********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    auxiliary_models_teachers.do
* Purpose: Export incumbent-share auxiliary moments for model estimation.
********************************************************************************

set more off

use "$est/multinomial.dta", clear
keep if Match == 1

quietly summarize Inc, detail
local inc_mean = r(mean)
local inc_var = r(sd)^2

clear
set obs 2
gen value = .
replace value = `inc_mean' if _n == 1
replace value = `inc_var' if _n == 2

outsheet using "$est/inc_mean_var.csv", replace nonames

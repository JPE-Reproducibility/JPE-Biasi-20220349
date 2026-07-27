********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    budget_overtime.do
* Purpose: generates district panel containing budget per teacher
********************************************************************************


use "$intdata/teachers_panel_JPE.dta", clear
keep if v0 != . & v1 != . & totalexp != .
replace salary_round = salary_round / 1000
replace salary_round = 86.731818 if salary_round > 86.731818
replace salary_round = 28.777456 if salary_round < 28.777456

collapse salary_round , by(year district_code)
sort district_code year
rename salary_round budget_pp
save "$intdata/budget_overtime_JPE.dta", replace

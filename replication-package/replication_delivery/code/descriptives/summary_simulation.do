********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    summary_simulation.do
* Purpose: Produce 2010 teacher and district summary statistics for Table B21.
********************************************************************************

set more off

if "$sim" == "" {
    display as error "Global sim must point to simulation_data."
    exit 198
}
if "$out" == "" {
    display as error "Global out must point to the output folder."
    exit 198
}

capture mkdir "$out"
capture mkdir "$out/tables"


********************************************************************************
* Teacher Summary Statistics (Table B21, panel A)
********************************************************************************

capture log close table_b21a
log using "$out/tables/Table_B21A.log", name(table_b21a) replace nomsg

* Experience.
use "$sim/experiencecont_pre_NEW.dta", clear
summarize totalexp2
summarize totalexp2 if totalexp2 < 3
summarize totalexp2 if totalexp2 >= 10

egen tag = tag(id)
count if tag == 1
count if totalexp2 < 3 & tag == 1
count if totalexp2 >= 10 & tag == 1

* Master's degree.
use "$sim/master_pre_NEW.dta", clear
rename masterup master
merge 1:1 id using "$sim/experiencecont_pre_NEW.dta"
drop _merge
summarize master
summarize master if totalexp2 < 3
summarize master if totalexp2 >= 10

* Teacher contributions.
use "$sim/contributions_pre_NEW.dta", clear
merge 1:1 id using "$sim/experiencecont_pre_NEW.dta"
drop _merge
merge 1:1 id using "$sim/master_pre_NEW.dta"
drop _merge
gen c0 = xb0 + v0
gen c1 = xb1 + v1
summarize c0 c1
summarize c0 c1 if totalexp2 < 3
summarize c0 c1 if totalexp2 >= 10
corr c0 c1

log close table_b21a


********************************************************************************
* District Summary Statistics (Table B21, panel B)
********************************************************************************

capture log close table_b21b
log using "$out/tables/Table_B21B.log", name(table_b21b) replace nomsg

tempfile lambda_data

use "$sim/lambda_pre_NEW.dta", clear
reshape long d, i(n) j(district)
drop n
sort district
quietly save `lambda_data', replace

* Urban districts.
use "$sim/urban_pre_NEW.dta", clear
reshape long urban, i(n) j(district)
drop n
summarize urban
merge 1:1 district using `lambda_data'
keep if _merge != 1
drop _merge
summarize urban
quietly summarize d, detail
summarize urban if d <= `r(p25)'
quietly summarize d, detail
summarize urban if d > `r(p75)'

* Suburban districts.
use "$sim/suburban_pre_NEW.dta", clear
reshape long suburban, i(n) j(district)
drop n
summarize suburban
merge 1:1 district using `lambda_data'
keep if _merge != 1
drop _merge
summarize suburban
quietly summarize d, detail
summarize suburban if d <= `r(p25)'
quietly summarize d, detail
summarize suburban if d > `r(p75)'
summarize d, detail
summarize d if d <= `r(p25)'
summarize d, detail
summarize d if d > `r(p75)'

* Average teacher experience by incumbent district.
use "$sim/experiencecont_pre_NEW.dta", clear
merge 1:1 id using "$sim/incumbent_pre_NEW.dta"
drop _merge
gen district = .
quietly {
    foreach var of varlist Inc* {
        local district_id = substr("`var'", 4, .)
        replace district = `district_id' if `var' == 1
    }
}
drop Inc*
collapse totalexp2, by(district)
summarize totalexp2
merge 1:1 district using `lambda_data'
keep if _merge != 1
drop _merge
summarize totalexp2
quietly summarize d, detail
summarize totalexp2 if d <= `r(p25)'
quietly summarize d, detail
summarize totalexp2 if d > `r(p75)'

* Master's degree by incumbent district.
use "$sim/master_pre_NEW.dta", clear
rename masterup master
merge 1:1 id using "$sim/incumbent_pre_NEW.dta"
drop _merge
gen district = .
quietly {
    foreach var of varlist Inc* {
        local district_id = substr("`var'", 4, .)
        replace district = `district_id' if `var' == 1
    }
}
drop Inc*
collapse master, by(district)
summarize master
merge 1:1 district using `lambda_data'
keep if _merge != 1
drop _merge
summarize master
quietly summarize d, detail
summarize master if d <= `r(p25)'
quietly summarize d, detail
summarize master if d > `r(p75)'

* Teacher contributions by incumbent district.
use "$sim/contributions_pre_NEW.dta", clear
gen c0 = xb0 + v0
gen c1 = xb1 + v1
merge 1:1 id using "$sim/incumbent_pre_NEW.dta"
drop _merge
gen district = .
quietly {
    foreach var of varlist Inc* {
        local district_id = substr("`var'", 4, .)
        replace district = `district_id' if `var' == 1
    }
}
drop Inc*
collapse c0 c1, by(district)
summarize c0 c1
merge 1:1 district using `lambda_data'
keep if _merge != 1
drop _merge
summarize c0 c1
quietly summarize d, detail
summarize c0 c1 if d <= `r(p25)'
quietly summarize d, detail
summarize c0 c1 if d > `r(p75)'
quietly summarize d, detail
count if d <= `r(p25)'
quietly summarize d, detail
count if d > `r(p75)'

* District budgets.
use "$sim/budget_NEW.dta", clear
reshape long budget capacity, i(n) j(district)
drop n
summarize budget
gen budget_pc = budget / capacity
summarize budget_pc
summarize capacity
merge 1:1 district using `lambda_data'
keep if _merge != 1
drop _merge
summarize budget_pc capacity
quietly summarize d, detail
summarize budget_pc capacity if d <= `r(p25)'
quietly summarize d, detail
summarize budget_pc capacity if d > `r(p75)'

log close table_b21b

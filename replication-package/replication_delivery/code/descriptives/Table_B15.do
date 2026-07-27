* Table_B15.do
* Created: 1/21
* Author: John Stromme
*
* This file recreates the "dictator" results shown in Table B15

* Clear the current dataset without erasing programs defined by a calling
* master or validation script.
clear

* Set up the data
use "$est/multinomial.dta", clear

* Keep only matches
keep if Match == 1

* Calc contribution variable for each teacher
gen c0 = V0 + xb0
gen c1 = V1 + xb1

* Rename d to lambda
rename d lambda

* Store number of observations
local N = _N

* Save teacher and district vars
preserve

* --- Baseline calculation ---
gen tc_i = c0 * lambda + c1 * (1 - lambda)
gen ec_i = c0 * lambda
gen c2_i = c1 * (1 - lambda)

sum tc_i, meanonly
local bl_tc = r(sum)
sum ec_i, meanonly
local bl_ec = r(sum)
sum c2_i, meanonly
local bl_c2 = r(sum)

restore

* --- Efficiency focused (beta=1): sort districts by -lambda, teachers by -(c0 - 1*c1) ---
preserve

* Sort districts by descending lambda, keep rank
gsort -lambda
gen district_rank = _n
tempfile dist_ranked
save `dist_ranked'

* Sort teachers by descending (c0 - c1)
gen sortvar = c0 - 1 * c1
gsort -sortvar
gen teacher_rank = _n

* Merge back district lambda by rank
rename lambda lambda_old
drop district_rank
gen district_rank = teacher_rank
merge 1:1 district_rank using `dist_ranked', keepusing(lambda) nogen

gen tc_i = c0 * lambda + c1 * (1 - lambda)
gen ec_i = c0 * lambda
gen c2_i = c1 * (1 - lambda)

sum tc_i, meanonly
local eff_tc = r(sum)
sum ec_i, meanonly
local eff_ec = r(sum)
sum c2_i, meanonly
local eff_c2 = r(sum)

restore

* --- Equity focused (beta=0): sort districts by -lambda, teachers by -(c0 - 0*c1) = -c0 ---
preserve

gsort -lambda
gen district_rank = _n
tempfile dist_ranked2
save `dist_ranked2'

* Sort teachers by descending c0
gen sortvar = c0
gsort -sortvar
gen teacher_rank = _n

rename lambda lambda_old
drop district_rank
gen district_rank = teacher_rank
merge 1:1 district_rank using `dist_ranked2', keepusing(lambda) nogen

gen tc_i = c0 * lambda + c1 * (1 - lambda)
gen ec_i = c0 * lambda
gen c2_i = c1 * (1 - lambda)

sum tc_i, meanonly
local eq_tc = r(sum)
sum ec_i, meanonly
local eq_ec = r(sum)
sum c2_i, meanonly
local eq_c2 = r(sum)

restore

* --- Organize results ---
clear
set obs 3
gen measure = ""
replace measure = "TC" in 1
replace measure = "c1" in 2
replace measure = "c2" in 3

gen pct_dictator_1 = .
replace pct_dictator_1 = (`eff_tc' - `bl_tc') / `bl_tc' * 100 in 1
replace pct_dictator_1 = (`eff_ec' - `bl_ec') / `bl_ec' * 100 in 2
replace pct_dictator_1 = (`eff_c2' - `bl_c2') / `bl_c2' * 100 in 3

gen pct_dictator_2 = .
replace pct_dictator_2 = (`eq_tc' - `bl_tc') / `bl_tc' * 100 in 1
replace pct_dictator_2 = (`eq_ec' - `bl_ec') / `bl_ec' * 100 in 2
replace pct_dictator_2 = (`eq_c2' - `bl_c2') / `bl_c2' * 100 in 3

export delimited using "$out/tables/Table_B15.csv", replace

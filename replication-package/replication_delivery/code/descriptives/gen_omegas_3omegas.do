********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    gen_omegas_3omegas.do
* Purpose: Create the alpha grid for the three-omega wage specification.
********************************************************************************


********************************************************************************
* Wage-Function Inputs
********************************************************************************

use "$intdata/teachers_panel_JPE.dta", clear

* Exclude this district only for wage analyses.
drop if district_code == 2793 & year == 2010

* Merge in schedule parameters.
sort district_code
merge m:1 district_code using "$intdata/schedule_new_JPE.dta"
keep if _m == 3
drop _m

* Define lower and upper bounds for winsorized wages.
sum salary_round, det
local low = r(p1) - (0.3*r(sd))
disp `low'
qui sum salary_round, det
local high = r(max) + (0.2*r(sd))
disp `high'

gen mode = .

replace mode = CExp1_ba if exp == 1 & masterup == 0
replace mode = CExp1_ma if exp == 1 & masterup == 1
replace mode = CExp2_ba if exp == 2 & masterup == 0
replace mode = CExp2_ma if exp == 2 & masterup == 1
replace mode = CExp3_ba if exp == 3 & masterup == 0
replace mode = CExp3_ma if exp == 3 & masterup == 1
replace mode = CExp4_ba if exp == 4 & masterup == 0
replace mode = CExp4_ma if exp == 4 & masterup == 1
replace mode = CExp5_ba if exp == 5 & masterup == 0
replace mode = CExp5_ma if exp == 5 & masterup == 1
replace mode = CExp6_ba if exp == 6 & masterup == 0
replace mode = CExp6_ma if exp == 6 & masterup == 1
drop CE*


********************************************************************************
* Student Achievement Measure and Teacher Contributions
********************************************************************************

* Merge school-level low-achievement shares.
preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
gen d = std_score <= 0.07 & std_score != .
keep if year == 2011 | std_score == 2010 | std_score == 2009
collapse d, by(district_code)
sort district_code
save temp.dta, replace
restore

sort district_code
merge m:1 district_code using temp.dta
drop if _m == 2
drop _m
rm temp.dta

gen d_ = 1-d

* Construct lambda groups.
_pctile d, n(100)
local a = r(r50)
qui sum d if d <= `a', det
gen lambda = r(p50) if d >= 0 & d <= `a'
qui sum d if d > `a', det
replace lambda = r(p50) if d > `a'
replace lambda = . if d == .

qui tab exp, gen(Exp)
replace v0 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6) + v0
replace v1 = (g2_2 * Exp2) + (g3_2 * Exp3) + (g4_2 * Exp4) + ///
    (g5_2 * Exp5) + (g6_2 * Exp6) + v1

gen v0d = v0 * lambda
gen v1d = v1 * (1 - lambda)
gen comb = v0d + v1d

* Winsorize contribution components used in the grid search.
qui sum comb, det
replace comb = r(p95) if comb > r(p95) & comb != .
replace comb = r(p5) if comb <= r(p5) & comb != .
qui sum v0d, det
replace v0d = r(p95) if v0d > r(p95) & v0d != .
replace v0d = r(p5) if v0d <= r(p5) & v0d != .
qui sum v1d, det
replace v1d = r(p95) if v1d > r(p95) & v1d != .
replace v1d = r(p5) if v1d <= r(p5) & v1d != .

keep if year == 2014


********************************************************************************
* Grid Search for Three-Omega Parameters
********************************************************************************

gen wage = .
gen S_alpha0 = .
gen S_alpha1 = .
gen S_alpha2 = .
gen Min = .

forvalues A0 = 1/5 {
    forvalues A1 = 1/7 {
        forvalues A2 = 1/7 {
            gen SS_`A0'_`A1'_`A2' = .
        }
    }
}

gen V1d = v1d if exp > 1
bysort year: egen K = mean(v1d)
replace V1d = K if exp == 1
drop K

gen V0d = v0d if exp > 1
bysort year: egen K = mean(v0d)
replace V0d = K if exp == 1
drop K

qui levelsof district_code, local(Dist)
qui foreach d of local Dist {
    noisily disp "District n. `d'"

    local A0 = 1
    local A1 = 1
    local A2 = 1

    forvalues Alpha0 = 0.9(0.05)1.1 {
        local A1 = 1
        local A2 = 1
        foreach Alpha1 in 0 10000 30000 50000 75000 100000 200000 {
            local A2 = 1
            foreach Alpha2 in 0 10000 30000 50000 75000 100000 200000 {
                disp "A0 = `Alpha0', A1 = `Alpha1', A2 = `Alpha2'"
                replace wage = (`Alpha0' * mode) + (`Alpha1' * V0d) + ///
                    (`Alpha2' * V1d) if district_code == `d'
                replace wage = `high' if wage > `high' & wage != .
                replace wage = `low' if wage < `low' & wage != .
                gen dev = (salary_round - wage) ^ 2 if district_code == `d'
                qui sum dev if district_code == `d', det
                replace SS_`A0'_`A1'_`A2' = r(sum) ///
                    if district_code == `d'
                drop dev
                local A2 = `A2' + 1
            }
            local A1 = `A1' + 1
        }
        local A0 = `A0' + 1
    }

    egen x = rowmin(SS_*)
    replace Min = x if district_code == `d'
    drop x

    qui sum Min if district_code == `d', det
    local M = r(mean)

    forvalues A0 = 1/5 {
        forvalues A1 = 1/7 {
            forvalues A2 = 1/7 {
                qui sum SS_`A0'_`A1'_`A2' if district_code == `d', det
                local S = r(mean)
                if `M' == `S' {
                    noisily disp "Yes!"
                    noisily disp "`A0'"
                    noisily disp "`A1'"
                    noisily disp "`A2'"
                    replace S_alpha0 = `A0' if district_code == `d'
                    replace S_alpha1 = `A1' if district_code == `d'
                    replace S_alpha2 = `A2' if district_code == `d'
                }
            }
        }
    }
}

replace S_alpha0 = 0.9 if S_alpha0 == 1
replace S_alpha0 = 0.95 if S_alpha0 == 2
replace S_alpha0 = 1.0 if S_alpha0 == 3
replace S_alpha0 = 1.05 if S_alpha0 == 4
replace S_alpha0 = 1.1 if S_alpha0 == 5

replace S_alpha1 = 0 if S_alpha1 == 1
replace S_alpha1 = 10000 if S_alpha1 == 2
replace S_alpha1 = 30000 if S_alpha1 == 3
replace S_alpha1 = 50000 if S_alpha1 == 4
replace S_alpha1 = 75000 if S_alpha1 == 5
replace S_alpha1 = 100000 if S_alpha1 == 6
replace S_alpha1 = 200000 if S_alpha1 == 7

replace S_alpha2 = 0 if S_alpha2 == 1
replace S_alpha2 = 10000 if S_alpha2 == 2
replace S_alpha2 = 30000 if S_alpha2 == 3
replace S_alpha2 = 50000 if S_alpha2 == 4
replace S_alpha2 = 75000 if S_alpha2 == 5
replace S_alpha2 = 100000 if S_alpha2 == 6
replace S_alpha2 = 200000 if S_alpha2 == 7

preserve
sum salary_round, det
local low = r(p1) - (0.3*r(sd))
disp `low'
qui sum salary_round, det
local high = r(max) + (0.2*r(sd))
disp `high'
gen Wage = (S_alpha0 * mode) + (S_alpha1 * V0d) + (S_alpha2 * V1d)
replace Wage = `high' if wage > `high' & wage != .
replace Wage = `low' if wage < `low' & wage != .
gen S_dev = salary_round - Wage
keep id S_dev comb
save "$intdata/alphagrid_wages_8groups_3omegas_JPE.dta", replace
restore




********************************************************************************
* Summary Statistics for Three-Omega Wage Deviations (Figure B4)
********************************************************************************

use "$intdata/alphagrid_wages_8groups_3omegas_JPE.dta", clear
rename S_dev* SS_dev*
keep id SS_dev
sort id
merge 1:1 id using "$intdata/alphagrid_wages_8groups_JPE.dta"
twoway scatter S_ SS_, xtitle("wage deviations, 3 omegas") ///
    ytitle("wage deviations, 2 omegas") xlabel(-40000(20000)40000) ///
    ylabel(-40000(20000)40000)
graph export "$out/figures/Figure_B4.png", replace

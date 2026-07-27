********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    gen_omegas_info.do
* Purpose: Create alpha grids for imperfect-information robustness exercises.
********************************************************************************


global controls = "std_score_past disab_status el_status econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind"


********************************************************************************
* Wage Function Summary Statistics
********************************************************************************

use "$intdata/teachers_panel_JPE.dta", clear
* This district is excluded only when working with wages.
drop if district_code == 2793 & year == 2010

* Merge in schedule parameters.
sort district_code
merge m:1 district_code using "$intdata/schedule_new_JPE.dta"
keep if _m == 3
drop _m

* Generate scalars for wage bounds.
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

* Merge in share low achievers by district.
preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
gen d = std_score <= 0.07 & std_score != .
keep if year == 2011 | std_score == 2010 | std_score == 2009
collapse d, by(district_code)
sort district_code
tempfile low_achievers
save `low_achievers', replace
restore

sort district_code
merge m:1 district_code using `low_achievers'
drop if _m == 2
drop _m

gen d_ = 1 - d

* Lambda.
_pctile d, n(100)
local a = r(r50)
qui sum d if d <= `a', det
gen lambda = r(p50) if d >= 0 & d <= `a'
qui sum d if d > `a', det
replace lambda = r(p50) if d > `a'
replace lambda = . if d == .

qui tab exp, gen(Exp)


********************************************************************************
* Imperfect-Information Contribution Measures
********************************************************************************

* Generate four noisy versions of teacher contributions.
forvalues info = 0/3 {
    local multiplier = 0.5
    if `info' == 1 {
        local multiplier = 1
    }
    if `info' == 2 {
        local multiplier = 2
    }
    if `info' == 3 {
        local multiplier = 4
    }

    qui sum v0, det
    gen v0_`info' = v0 + `multiplier' * r(sd) * runiform()
    qui sum v1, det
    gen v1_`info' = v1 + `multiplier' * r(sd) * runiform()
}

gen c0 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6) + v0
gen c1 = (g2_2 * Exp2) + (g3_2 * Exp3) + (g4_2 * Exp4) + ///
    (g5_2 * Exp5) + (g6_2 * Exp6) + v1

forvalues info = 0/3 {
    gen c0_`info' = (g2_1 * Exp2) + (g3_1 * Exp3) + ///
        (g4_1 * Exp4) + (g5_1 * Exp5) + (g6_1 * Exp6) + v0_`info'
    gen c1_`info' = (g2_2 * Exp2) + (g3_2 * Exp3) + ///
        (g4_2 * Exp4) + (g5_2 * Exp5) + (g6_2 * Exp6) + v1_`info'
}

* Save all variants for the imperfect-information model-data builders.
preserve
keep if year == 2014
keep id c0* c1* v0* v1*
drop if c0 == . | c1 == .
sort id
save "$est/teachers_imperfect_info.dta", replace
restore

sort id year
tempfile base_data
save `base_data', replace


********************************************************************************
* Estimate Alpha Grids by Information Version
********************************************************************************

forvalues info = 0/3 {
    local title "0.5 * sigma"
    if `info' == 1 {
        local title "1 * sigma"
    }
    if `info' == 2 {
        local title "2 * sigma"
    }
    if `info' == 3 {
        local title "4 * sigma"
    }

    di as text "Imperfect-information version `info': `title'"

    use `base_data', clear
    keep id year district_code exp salary_round mode lambda c0_`info' c1_`info'
    rename c0_`info' c0
    rename c1_`info' c1

    gen c0d = c0 * lambda
    gen c1d = c1 * (1 - lambda)
    gen comb = c0d + c1d

    * Adjust c0d, c1d, and combined contribution at the tails.
    qui sum comb, det
    replace comb = r(p95) if comb > r(p95) & comb != .
    replace comb = r(p5) if comb <= r(p5) & comb != .
    qui sum c0d, det
    replace c0d = r(p95) if c0d > r(p95) & c0d != .
    replace c0d = r(p5) if c0d <= r(p5) & c0d != .
    qui sum c1d, det
    replace c1d = r(p95) if c1d > r(p95) & c1d != .
    replace c1d = r(p5) if c1d <= r(p5) & c1d != .

    gen wage = .
    gen S_alpha0 = .
    gen S_alpha1 = .
    gen Min = .

    forvalues A0 = 1/5 {
        forvalues A1 = 1/7 {
            gen SS_`A0'_`A1' = .
        }
    }

    gen Comb = comb if exp > 1
    bysort year: egen K = mean(comb)
    replace Comb = K if exp == 1
    drop K

    qui levelsof district_code, local(Dist)
    qui foreach d of local Dist {
        noisily disp "District n. `d'"

        local A0 = 1
        local A1 = 1

        forvalues Alpha0 = 0.9(0.05)1.1 {
            local A1 = 1
            foreach Alpha1 in 0 10000 30000 50000 75000 100000 200000 {
                disp "A0 = `Alpha0', A1 = `Alpha1'"
                replace wage = (`Alpha0' * mode) + (`Alpha1' * Comb) ///
                    if district_code == `d'
                replace wage = `high' if wage > `high' & wage != .
                replace wage = `low' if wage < `low' & wage != .
                gen dev = (salary_round - wage)^2 if district_code == `d'
                qui sum dev if district_code == `d', det
                replace SS_`A0'_`A1' = r(sum) if district_code == `d'
                drop dev
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
                qui sum SS_`A0'_`A1' if district_code == `d', det
                local S = r(mean)
                if `M' == `S' {
                    noisily disp "Yes!"
                    noisily disp "`A0'"
                    noisily disp "`A1'"
                    replace S_alpha0 = `A0' if district_code == `d'
                    replace S_alpha1 = `A1' if district_code == `d'
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

    preserve
    sum salary_round, det
    local low = r(p1) - (0.3*r(sd))
    disp `low'
    qui sum salary_round, det
    local high = r(max) + (0.2*r(sd))
    disp `high'
    gen Wage = (S_alpha0 * mode) + (S_alpha1 * Comb)
    replace Wage = `high' if wage > `high' & wage != .
    replace Wage = `low' if wage < `low' & wage != .
    gen S_dev = salary_round - Wage
    keep id Wage comb
    sort id
    save "$est/alphagrid_wages_8groups_info`info'.dta", replace
    restore

    collapse S_alpha*, by(district_code)
    sort district_code
    save "$est/alphagrid_8groups_lambdad_info`info'.dta", replace
}

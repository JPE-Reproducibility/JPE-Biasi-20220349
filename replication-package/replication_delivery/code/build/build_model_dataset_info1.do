********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    build_model_dataset_info1.do
* Purpose: Generate model-estimation inputs for imperfect-information variant 1.
********************************************************************************

local info_version 1


********************************************************************************
* Teacher Characteristics
********************************************************************************

* Share low achievers by district.
use "$intdata/indtest_math_split_JPE.dta", clear
drop if schoolcode == 8888
gen d = std_score <= 0.07 & std_score != .
keep if year == 2011 | std_score == 2010 | std_score == 2009
collapse d, by(district_code)
sort district_code
tempfile low_achievers
save `low_achievers', replace

use "$intdata/teachers_panel_JPE.dta", clear
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

* Merge the imperfect-information contribution variant.
drop v0 v1
sort id
merge m:1 id using "$est/teachers_imperfect_info.dta"
drop if _m == 2
drop _m
drop v0 v1

rename v0_`info_version' v0
rename v1_`info_version' v1
drop c0* c1* v0_* v1_*

gen xb0 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)
gen xb1 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)

* Resolve past district assignment.
gen Dpast = district_past2011
replace Dpast = district_past2012 if ///
    (district_past2012 != district_code & district_past2011 == .) & ///
    district_past2012 != .
replace Dpast = district_past2013 if ///
    (district_past2013 != district_code & district_past2011 == .) & ///
    district_past2013 != .
replace Dpast = 0 if Dpast == .

* Keep teachers with relevant contributions.
keep if v0 != . & v1 != . & d != .

* Generate teacher datasets.
keep id district_code Dpast v0 v1 xb0 xb1 d exp masterup salary_round ///
    type totalexp year schoolcode
qui reg id district_code Dpast v0 v1 xb0 xb1 d exp masterup ///
    salary_round type totalexp year
gen byte _model_complete = e(sample)
qui reg id district_code Dpast v0 v1 xb0 xb1 d exp masterup ///
    salary_round type year
gen byte _model_relaxed = e(sample)

* Retain exactly 6,600 model teachers when the 2014 pool can support it,
* without changing continuous experience values.
local model_target_obs = 6600
local using_synthetic = strpos(lower("$confdata"), "synthetic_data") > 0
if `using_synthetic' {
    do "$code/build/_synthetic_model_helpers.do"
    tempfile synthetic_districts
    _synthetic_model_districts using "`synthetic_districts'", target(411)
}

quietly count if _model_relaxed == 1 & year == 2014
if r(N) >= `model_target_obs' {
    preserve
    keep if _model_relaxed == 1 & year == 2014
    gsort -_model_complete id
    gen long _model_rank = _n
    keep if _model_rank <= `model_target_obs'
    keep id
    tempfile model_ids
    save `model_ids', replace
    restore

    merge m:1 id using `model_ids'
    keep if _merge == 3 & _model_relaxed == 1
    drop _merge
    quietly count if year == 2014
    assert r(N) == `model_target_obs'
}
else {
    keep if _model_complete == 1
}

* The public synthetic raw data are intentionally compact. Expand fake model
* rows across the 411-district model universe only in synthetic runs.
if `using_synthetic' {
    _synthetic_expand_model_years, years(2013 2014) ///
        target(`model_target_obs') districts("`synthetic_districts'")
}
drop _model_complete _model_relaxed

* Check the number of districts in the sample.
qui tab district_code if year == 2014
disp "Nr districts ="
disp r(r)

* Tag districts in this sample.
preserve
keep if year == 2014
keep district_code
duplicates drop
sort district_code
if `using_synthetic' {
    count
    assert r(N) == 411
}
tempfile tag
save `tag', replace
restore

* Prepare horizontal schedule.
preserve
use "$intdata/schedule_new_JPE.dta", clear
if `using_synthetic' {
    _synthetic_pad_current_districts, districts("`synthetic_districts'")
}
forvalues n = 1/6 {
    foreach t in ba ma {
        replace CExp`n'_`t' = CExp`n'_`t' / 1000
    }
}
if `using_synthetic' {
    _synth_fill_missing CExp*
}
sort district_code
merge 1:1 district_code using `tag'
keep if _m == 3
drop _m
sort district_code
rename *_ba *_0
rename *_ma *_1
sort district_code
reshape long CExp1_ CExp2_ CExp3_ CExp4_ CExp5_ CExp6_, ///
    i(district_code) j(masterup)
rename *_ *
egen fake = group(district_code masterup)
reshape long CExp, i(fake) j(exp)
drop fake
egen fake = group(exp masterup)
rename CExp mode
reshape wide mode, i(fake) j(district_code)
drop fake
sort exp masterup
tempfile schedule_temp
save `schedule_temp', replace
restore

* Prepare horizontal imperfect-information alpha grid for downstream use.
preserve
use "$est/alphagrid_8groups_lambdad_info`info_version'.dta", clear
if `using_synthetic' {
    _synthetic_pad_current_districts, districts("`synthetic_districts'")
}
sort district_code
merge 1:1 district_code using `tag'
keep if _m == 3
drop _m
rename S_* *_
if `using_synthetic' {
    _synth_cycle_alpha_support
}
gen n = 1
replace alpha1_ = alpha1_ / 1000
reshape wide alpha0_ alpha1_, i(n) j(district_code)
order alpha0* alpha1*, first
save "$est/alphagrid_12_info`info_version'.dta", replace
restore

* Merge wage schedule and the baseline alpha grid used for model inputs.
sort exp masterup
merge m:1 exp masterup using `schedule_temp'
keep if _m == 3
drop _m
if `using_synthetic' {
    _synth_fill_missing mode*
}
gen n = 1
sort n
merge m:1 n using "$est/alphagrid.dta"
keep if _m == 3
drop _m

* Tag only relevant districts.
sort district_code
merge m:1 district_code using `tag'
keep if _m == 3
drop _m

bysort year exp masterup: egen v0bar = mean(v0)
bysort year exp masterup: egen v1bar = mean(v1)

gen V0 = v0
replace V0 = v0bar if exp == 1

gen V1 = v1
replace V1 = v1bar if exp == 1

gen C0 = v0 + xb0
replace C0 = v0bar + xb0 if exp == 1

gen C1 = v1 + xb1
replace C1 = v1bar + xb1 if exp == 1

gen Wage = .
qui levelsof district_code, local(Dist)
foreach d of local Dist {
    qui sum d if district_code == `d'
    local z = r(mean)
    local y = 0
    qui count if district_code == `d' & year == 2014 & exp == 1 & V0 != .
    if `r(N)' > 0 {
        disp "yes"
    }
    gen wage`d' = (alpha0_`d' * mode`d') + ///
        ((alpha1_`d'/1000) * ((C0 * `z') + (C1 * (1 - `z'))))
    replace wage`d' = 86.731818 if wage`d' > 86.731818
    replace wage`d' = 28.777456 if wage`d' < 28.777456
    replace Wage = (alpha0_`d' * mode`d') + ///
        ((alpha1_`d'/1000) * ((C0 * `z') + (C1 * (1 - `z')))) ///
        if district_code == `d'
    replace Wage = 86.731818 if Wage > 86.731818
    replace Wage = 28.777456 if Wage < 28.777456
    drop alpha0_`d' mode`d' alpha1_`d'
}

* Save previous budget and previous number of slots for 2013.
preserve
keep if year == 2013
drop year
gen capacity_past = 1
collapse (sum) capacity_past budget_past = Wage, by(district_code)
sort district_code
save "$est/budget_past_long_info`info_version'.dta", replace
gen n = 1
keep n district_code capacity_past budget_past
reshape wide capacity_past budget_past, i(n) j(district_code)
save "$est/budget_past_info`info_version'.dta", replace
restore

preserve
keep if year == 2014
drop year
gen capacity = 1
collapse (sum) capacity budget = Wage, by(district_code)
sort district_code
save "$est/budget_long_info`info_version'.dta", replace
gen n = 1
keep n district_code capacity budget
reshape wide capacity budget, i(n) j(district_code)
save "$est/budget_info`info_version'.dta", replace
restore
drop Wage


********************************************************************************
* Teacher Characteristics for 2014
********************************************************************************

keep if year == 2014
drop year

sort exp masterup
merge m:1 exp masterup using `schedule_temp'
keep if _m == 3
drop _m
if `using_synthetic' {
    _synth_fill_missing mode*
}

sort n
merge m:1 n using "$est/alphagrid.dta"
keep if _m == 3
drop _m

* Export main information.
preserve
sort id
keep id district_code Dpast
qui reg *
count if e(sample)
rename district_code Dist_all
sort id
save "$est/info_all_info`info_version'.dta", replace
restore

* Export wages.
preserve
sort id
keep id wage*
qui reg *
count if e(sample)
sort id
save "$est/wage_info`info_version'.dta", replace
restore

* Export wage schedule.
preserve
sort id
keep id mode*
qui reg *
count if e(sample)
sort id
save "$est/wageschedule_info`info_version'.dta", replace
restore

* Export experience.
preserve
qui tab exp, gen(Exp)
sort id
keep id Exp* totalexp
qui reg *
count if e(sample)
sort id
save "$est/experience_info`info_version'.dta", replace
restore

* Export continuous experience.
preserve
keep id totalexp
qui reg *
count if e(sample)
sort id
save "$est/experiencecont_info`info_version'.dta", replace
restore

* Export master's degree indicator.
preserve
sort id
keep id masterup
qui reg *
count if e(sample)
sort id
save "$est/master_info`info_version'.dta", replace
restore

* Export contributions.
preserve
sort id
keep id V0 V1 v0 v1 xb0 xb1
qui reg *
count if e(sample)
sort id
save "$est/contributions_info`info_version'.dta", replace
restore

* Match variables.
qui levelsof district_code, local(Dist)
foreach d of local Dist {
    gen Match`d' = district_code == `d'
}
preserve
sort id
keep id Match*
qui reg *
count if e(sample)
sort id
save "$est/match_info`info_version'.dta", replace
restore

* Same-commuting-zone distance indicator.
rename district_code D
rename Dpast district_code
sort district_code
merge m:1 district_code using "$raw/district_county_cz.dta"
sum cz if district_code == 2525
replace cz = r(mean) if _m == 1
drop if _m == 2
drop _m
drop year county_id state_code state_code_cnty
rename cz cz_past
rename district_code Dpast
rename D district_code
sort district_code
merge m:1 district_code using "$raw/district_county_cz.dta"
sum cz if district_code == 2525
replace cz = r(mean) if _m == 1
drop if _m == 2
drop _m
drop year county_id state_code state_code_cnty
qui tab district_code
disp r(r)
qui levelsof district_code, local(Dist)
foreach d of local Dist {
    qui sum cz if district_code == `d'
    gen samecz`d' = cz_past == r(mean)
    replace samecz`d' = 0 if Dpast == 0
}
drop cz*

* Incumbent dummies.
qui levelsof district_code, local(Dist)
foreach d of local Dist {
    gen Inc`d' = Dpast == `d'
    replace Inc`d' = 0 if Dpast == 0
}
preserve
sort id
keep id Inc*
qui reg *
count if e(sample)
sort id
save "$est/incumbent_info`info_version'.dta", replace
restore

preserve
sort id
keep id samecz*
qui reg *
count if e(sample)
sort id
save "$est/samecz_info`info_version'.dta", replace
restore


********************************************************************************
* District Characteristics
********************************************************************************

* Lambda.
preserve
use "$intdata/indtest_math_split_JPE.dta", clear
drop if schoolcode == 8888
gen d = std_score <= 0.07 & std_score != .
keep if year == 2011 | std_score == 2010 | std_score == 2009
collapse d, by(district_code)
if `using_synthetic' {
    _synthetic_pad_current_districts, districts("`synthetic_districts'")
}
sort district_code
merge 1:1 district_code using `tag'
keep if _m == 3
drop _m
gen n = 1
keep n district_code d
reshape wide d, i(n) j(district_code)
save "$est/lambda_info`info_version'.dta", replace
restore

* Enrollment.
preserve
use "$intdata/indtest_math_split_JPE.dta", clear
drop if schoolcode == 8888
gen N = 1
keep if year == 2014
collapse (sum) N, by(district_code)
if `using_synthetic' {
    _synthetic_pad_current_districts, districts("`synthetic_districts'")
}
sort district_code
merge 1:1 district_code using `tag'
keep if _m == 3
drop _m
gen n = 1
keep n N district_code
reshape wide N, i(n) j(district_code)
save "$est/enrollment_info`info_version'.dta", replace
restore

* Urban.
preserve
gen urban = type == 1
keep if district_code != .
collapse urban, by(district_code)
gen n = 1
keep n district_code urban
reshape wide urban, i(n) j(district_code)
save "$est/urban_info`info_version'.dta", replace
restore

* Suburban.
preserve
gen suburban = type == 2
keep if district_code != .
collapse suburban, by(district_code)
gen n = 1
keep n district_code suburban
reshape wide suburban, i(n) j(district_code)
save "$est/suburban_info`info_version'.dta", replace
restore

* Share poor.
preserve
use "$est/urban_info`info_version'.dta", clear
reshape long urban, i(n) j(district_code)
drop n
sort district_code
gen n = _n
sort district_code
tempfile sharepoor_rank
save `sharepoor_rank', replace
restore

preserve
use "$intdata/indtest_math_split_JPE.dta", clear
drop if schoolcode == 8888
gen d = std_score <= 0.07 & std_score != .
keep if year == 2011 | std_score == 2010 | std_score == 2009
gen enrl = (grade == 4 | grade == 5 | grade == 6) & year == 2011
gen econ_low = d == 1 & econ_d == 1
collapse econ_disadv econ_low (sum) enrl, by(district_code)
if `using_synthetic' {
    _synthetic_pad_current_districts, districts("`synthetic_districts'")
}
sort district_code
merge 1:1 district_code using `sharepoor_rank'
keep if _m == 3
drop _m
drop district_code
order n, first
drop urban
sort n
xtile poor_vingtile = econ_d, n(20)
restore

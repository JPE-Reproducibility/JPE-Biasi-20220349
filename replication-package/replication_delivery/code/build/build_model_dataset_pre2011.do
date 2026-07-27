********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    build_model_dataset_pre2011.do
* Purpose: Generate the pre-2011 data files used in the model estimation.
********************************************************************************


********************************************************************************
* Teacher Characteristics
********************************************************************************

use "$intdata/teachers_panel_JPE.dta", clear

* Merge in share low achievers by school.
preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
gen d = std_score <= 0.07 & std_score != .
keep if year == 2011 | year == 2010 | year == 2009
collapse d, by(district_code)
sort district_code
save temp.dta, replace
restore
sort district_code
merge m:1 district_code using temp.dta
drop if _m == 2
drop _m
rm temp.dta

* Merge in share low achievers by school, in 2007-2009.
preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
gen dold = std_score <= 0.07 & std_score != .
keep if year == 2009 | year == 2008 | year == 2007
collapse dold, by(district_code)
sort district_code
save temp.dta, replace
restore
sort district_code
merge m:1 district_code using temp.dta
drop if _m == 2
drop _m
rm temp.dta

gen d_ = 1 - d

* Lambda
_pctile d, n(100)
local a = r(r50)
qui sum d if d <= `a', det
gen lambda = r(p50) if d >= 0 & d <= `a'
qui sum d if d > `a', det
replace lambda = r(p50) if d > `a'
replace lambda = . if d == .

_pctile dold, n(100)
local a = r(r50)
qui sum dold if dold <= `a', det
gen lambdaold = r(p50) if dold >= 0 & dold <= `a'
qui sum dold if dold > `a', det
replace lambdaold = r(p50) if dold > `a'
replace lambdaold = . if dold == .

qui tab exp, gen(Exp)

gen xb0 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)
gen xb1 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)

* Resolve past district assignment.
gen Dpast = district_past2007
replace Dpast = district_past2008 if ///
    (district_past2008 != district_code & district_past2007 == .) & ///
    district_past2008 != .
replace Dpast = district_past2009 if ///
    (district_past2009 != district_code & district_past2007 == .) & ///
    district_past2009 != .
replace Dpast = 0 if Dpast == .

* Keep teachers with relevant contributions.
keep if v0 != . & v1 !=. & d != .

* Generate teacher datasets.
keep id district_code Dpast v0 v1 xb0 xb1 d exp masterup salary_round ///
    type totalexp year schoolcode
qui reg id district_code Dpast v0 v1 xb0 xb1 d exp masterup salary_round ///
    type totalexp year
keep if e(sample)

* The public synthetic raw data are intentionally compact. Expand fake
* simulation rows across the 411-district model universe only in synthetic runs.
local model_target_obs = 6741
local using_synthetic = strpos(lower("$confdata"), "synthetic_data") > 0
if `using_synthetic' {
    do "$code/build/_synthetic_model_helpers.do"
    tempfile synthetic_districts
    _synthetic_model_districts using "`synthetic_districts'", target(411)
    _synthetic_expand_model_years, years(2009 2010) ///
        target(`model_target_obs') districts("`synthetic_districts'")
}

* Check the number of districts in the sample.
qui tab district_code if year == 2010
disp "Nr districts ="
disp r(r)

* Tag districts in this sample.
preserve
keep if year == 2010
keep district_code
duplicates drop
sort district_code
if `using_synthetic' {
    count
    assert r(N) == 411
}
save tag.dta, replace
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
merge 1:1 district_code using tag.dta
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
save schedule_temp.dta, replace
restore

* Merge wage schedule and alpha grid.
sort exp masterup
merge m:1 exp masterup using schedule_temp.dta
keep if _m == 3
drop _m
if `using_synthetic' {
    _synth_fill_missing mode*
}

* Tag only relevant districts.
sort district_code
merge m:1 district_code using tag.dta
keep if _m == 3
drop _m

bysort year exp masterup: egen v0bar = mean(v0)
bysort year exp masterup: egen v1bar = mean(v1)

gen V0 = v0
replace V0 = v0bar if exp == 1

gen V1 = v1
replace V1 = v1bar if exp == 1

gen C0 = (v0 + xb0)
replace C0 = (v0bar + xb0) if exp == 1

gen C1 = (v1 + xb1)
replace C1 = (v1bar + xb1) if exp == 1

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
    gen wage`d' = (1 * mode`d') + ///
        ((0/1000) * ((C0 * `z') + (C1 * (1 - `z'))))
    replace wage`d' = 86.731818 if wage`d' > 86.731818
    replace wage`d' = 28.777456 if wage`d' < 28.777456
    replace Wage = mode`d' if district_code == `d'
    replace Wage = 86.731818 if Wage > 86.731818
    replace Wage = 28.777456 if Wage < 28.777456
    drop mode`d'
}


* Save previous budget and previous number of slots.
preserve
keep if year == 2009
drop year
gen capacity_past = 1
collapse (sum) capacity_past budget_past = Wage, by(district_code)
sort district_code
save "$sim/budget_past_long_pre_NEW.dta", replace
gen n = 1
keep n district_code capacity_past budget_past
reshape wide capacity_past budget_past, i(n) j(district_code)
save "$sim/budget_past_pre_NEW.dta", replace
drop n
outsheet using "$sim/budget_past_pre_NEW.csv", replace noname
restore

preserve
keep if year == 2010
drop year
gen capacity = 1
collapse (sum) capacity budget = Wage, by(district_code)
sort district_code
save "$sim/budget_long_pre_NEW.dta", replace
gen n = 1
keep n district_code capacity budget
reshape wide capacity budget, i(n) j(district_code)
save "$sim/budget_NEW.dta", replace
drop n
outsheet using "$sim/budget_pre_NEW.csv", replace noname
restore
drop Wage


********************************************************************************
* Teacher Characteristics For 2010
********************************************************************************

keep if year == 2010
drop year

sort exp masterup
merge m:1 exp masterup using schedule_temp.dta
keep if _m == 3
drop _m
if `using_synthetic' {
    _synth_fill_missing mode*
}
rm schedule_temp.dta

* Export main information.
preserve
sort id
keep id district_code Dpast
qui reg *
count if e(sample)
rename district_code Dist_all
sort id
save "$sim/info_all_pre_NEW.dta", replace
restore

* Export wages.
preserve
sort id
keep id wage*
qui reg *
count if e(sample)
sort id
save "$sim/wage_pre_NEW.dta", replace
drop id
outsheet using "$sim/wage_pre_NEW.csv", replace noname
restore

* Export wage schedule.
preserve
sort id
keep id mode*
qui reg *
count if e(sample)
sort id
save "$sim/wageschedule_pre_NEW.dta", replace
drop id
outsheet using "$sim/wageschedule_pre_NEW.csv", replace noname
restore

* Export experience.
preserve
qui tab exp, gen(Exp)
sort id
keep id Exp* totalexp
qui reg *
count if e(sample)
sort id
save "$sim/experience_pre_NEW.dta", replace
drop id totalexp
outsheet using "$sim/experience_pre_NEW.csv", replace noname
restore

* Export continuous experience.
preserve
keep id totalexp
qui reg *
count if e(sample)
sort id
save "$sim/experiencecont_pre_NEW.dta", replace
drop id
outsheet using "$sim/experiencecont_pre_NEW.csv", replace noname
restore

* Export master's degree indicator.
preserve
sort id
keep id masterup
qui reg *
count if e(sample)
sort id
save "$sim/master_pre_NEW.dta", replace
drop id
outsheet using "$sim/master_pre_NEW.csv", replace noname
restore

* Export contributions.
preserve
sort id
keep id V0 V1 v0 v1 xb0 xb1
qui reg *
count if e(sample)
sort id
save "$sim/contributions_pre_NEW.dta", replace
drop id v0 v1
outsheet using "$sim/contributions_pre_NEW.csv", replace noname
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
save "$sim/match_pre_NEW.dta", replace
drop id
outsheet using "$sim/match_pre_NEW.csv", replace noname
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
save "$sim/incumbent_pre_NEW.dta", replace
drop id
outsheet using "$sim/incumbent_pre_NEW.csv", replace noname
restore

preserve
sort id
keep id samecz*
qui reg *
count if e(sample)
sort id
save "$sim/samecz_pre_NEW.dta", replace
drop id
outsheet using "$sim/samecz_pre_NEW.csv", replace noname
restore


********************************************************************************
* District Characteristics
********************************************************************************

* Lambda
preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
gen d = std_score <= 0.07 & std_score != .
keep if year == 2011 | std_score == 2010 | std_score == 2009
collapse d, by(district_code)
if `using_synthetic' {
    _synthetic_pad_current_districts, districts("`synthetic_districts'")
}
sort district_code
merge 1:1 district_code using tag.dta
keep if _m == 3
drop _m
gen n = 1
keep n district_code d
reshape wide d, i(n) j(district_code)
save "$sim/lambda_pre_NEW.dta", replace
drop n
outsheet using "$sim/lambda_pre_NEW.csv", replace noname
restore

* Lambda old
preserve
use "$sim/lambda_pre_NEW.dta", clear
reshape long d, i(n) j(district_code)
sort district_code
drop n
tempfile temp
save `temp', replace
restore

preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
gen dold = std_score <= 0.07 & std_score != .
keep if year == 2009 | std_score == 2008 | std_score == 2007
collapse dold, by(district_code)
sort district_code
merge 1:1 district_code using `temp'
keep if _m == 2 | _m == 3
drop _m
gen n = 1
keep n district_code d
reshape wide d, i(n) j(district_code)
save "$sim/lambdaold_pre_NEW.dta", replace
drop n
outsheet using "$sim/lambdaold_pre_NEW.csv", replace noname
restore

* Enrollment
preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
gen N = 1
keep if year == 2010
collapse (sum) N, by(district_code)
if `using_synthetic' {
    _synthetic_pad_current_districts, districts("`synthetic_districts'")
}
sort district_code
merge 1:1 district_code using tag.dta
keep if _m == 3
drop _m
gen n = 1
keep n N district_code
reshape wide N, i(n) j(district_code)
save "$sim/enrollment_pre_NEW.dta", replace
drop n
outsheet using "$sim/enrollment_pre_NEW.csv", replace noname
restore

* Urban
preserve
gen urban = type == 1
keep if district_code != .
collapse urban, by(district_code)
gen n = 1
keep n district_code urban
reshape wide urban, i(n) j(district_code)
save "$sim/urban_pre_NEW.dta", replace
drop n
outsheet using "$sim/urban_pre_NEW.csv", replace noname
restore

* Suburban
preserve
gen suburban = type == 2
keep if district_code != .
collapse suburban, by(district_code)
gen n = 1
keep n district_code suburban
reshape wide suburban, i(n) j(district_code)
save "$sim/suburban_pre_NEW.dta", replace
drop n
outsheet using "$sim/suburban_pre_NEW.csv", replace noname
restore

rm tag.dta

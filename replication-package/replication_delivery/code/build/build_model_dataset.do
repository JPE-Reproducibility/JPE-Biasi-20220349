********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    build_model_dataset.do
* Purpose: Generate the data files used in the model estimation.
********************************************************************************


********************************************************************************
* Teacher Characteristics
********************************************************************************

* Share Democratic
preserve
use "$raw/crosswalk_district_county.dta", clear
local new = _N + 4
set obs `new'
local z = _N - 3
replace district_code = 2527 in `z'
replace county = "Iowa" in `z'
local z = _N - 2
replace district_code = 3689 in `z'
replace county = "Marquette" in `z'
local z = _N - 1
replace district_code = 3913 in `z'
replace county = "Dodge" in `z'
local z = _N
replace district_code = 4998 in `z'
replace county = "Dodge" in `z'
sort county
tempfile county
save `county', replace

import excel using "$raw/wisconsin_elections.xlsx", firstrow clear
replace county = "Fond Du Lac" if county == "Fond du Lac"
replace county = "Saint Croix" if county == "St. Croix"
collapse (sum) dem* rep* tot* [aw = share], by(county)
sort county
merge 1:m county using `county'
drop _m
gen democratic = dem2014gov / tot2014gov
collapse democratic, by(district_code)
tempfile dem
save `dem', replace
restore

* Share low achievers by district.
preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
gen d = std_score <= 0.07 & std_score != .
keep if year == 2011 | year == 2010 | year == 2009
collapse d, by(district_code)
sort district_code
save temp.dta, replace
restore

use "$intdata/teachers_panel_JPE.dta", clear
sort district_code
merge m:1 district_code using temp.dta
drop if _m == 2
drop _m
rm temp.dta

gen d_ = 1 - d

* Retain a stable birth year for the forward repeated-game age input. This
* mirrors the original exit-prediction code, which collapsed to the minimum
* reported birth year for each teacher before matching to the model sample.
gen birth_estsample = birth
replace birth_estsample = . if birth_estsample > 1996
bysort id: egen birth_estsample_min = min(birth_estsample)
drop birth_estsample
rename birth_estsample_min birth_estsample

* Lambda
_pctile d, n(100)
local a = r(r50)
qui sum d if d <= `a', det
gen lambda = r(p50) if d >= 0 & d <= `a'
qui sum d if d > `a', det
replace lambda = r(p50) if d > `a'
replace lambda = . if d == .

qui tab exp, gen(Exp)

gen xb0 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)
gen xb1 = (g2_2 * Exp2) + (g3_2 * Exp3) + (g4_2 * Exp4) + ///
    (g5_2 * Exp5) + (g6_2 * Exp6)

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
keep if v0 != . & v1 !=. & d != .

* Generate teacher datasets.
keep id district_code Dpast v0 v1 xb0 xb1 d exp masterup salary_round ///
    type totalexp year schoolcode birth_estsample
qui reg id district_code Dpast v0 v1 xb0 xb1 d exp masterup salary_round ///
    type totalexp year
gen byte _model_complete = e(sample)
qui reg id district_code Dpast v0 v1 xb0 xb1 d exp masterup salary_round ///
    type year
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
save tag.dta, replace
restore

* Save share Democratic.
preserve
use `dem', clear
if `using_synthetic' {
    _synthetic_pad_current_districts, districts("`synthetic_districts'")
    _synth_fill_missing democratic
}
sort district_code
merge 1:1 district_code using tag.dta
keep if _m == 3
drop _m
gen n = 1
reshape wide democratic, i(n) j(district_code)
drop n
outsheet * using "$est/democratic.csv", replace noname
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

* Prepare horizontal alpha grid.
preserve
use "$intdata/alphagrid_8groups_lambdad_JPE.dta", clear
if `using_synthetic' {
    _synthetic_pad_current_districts, districts("`synthetic_districts'")
}
sort district_code
merge 1:1 district_code using tag.dta
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
save "$est/alphagrid.dta", replace
drop n
outsheet alpha0* using "$est/alpha1.csv", replace noname
outsheet alpha1* using "$est/alpha2.csv", replace noname
restore

* Prepare choice alpha grid.
preserve
use "$intdata/alphagrid_8groups_lambdad_JPE.dta", clear
keep S_alpha0
duplicates drop
sort S
count
expand 3 in `r(N)'
replace S_alpha0 = 0.85 if _n == `r(N)' - 1
replace S_alpha0 = 1.15 if _n == `r(N)'
sort S
outsheet S_alpha0 using "$est/alpha1_grid.csv", replace noname

use "$intdata/alphagrid_8groups_lambdad_JPE.dta", clear
keep S_alpha1
replace S_alpha1 = S_alpha1 / 1000
duplicates drop
if `using_synthetic' {
    clear
    input S_alpha1
    0
    10
    30
    50
    75
    100
    200
    end
}
sort S
count
expand 2 in `r(N)'
replace S = 250 if _n == `r(N)'
sort S
outsheet S_alpha1 using "$est/alpha2_grid.csv", replace noname
restore

* Merge wage schedule and alpha grid.
sort exp masterup
merge m:1 exp masterup using schedule_temp.dta
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
save "$est/budget_past_long.dta", replace
gen n = 1
keep n district_code capacity_past budget_past
reshape wide capacity_past budget_past, i(n) j(district_code)
save "$est/budget_past.dta", replace
drop n
outsheet using "$est/budget_past.csv", replace noname
restore

preserve
keep if year == 2014
drop year
gen capacity = 1
collapse (sum) capacity budget = Wage, by(district_code)
sort district_code
save "$est/budget_long.dta", replace
gen n = 1
keep n district_code capacity budget
reshape wide capacity budget, i(n) j(district_code)
save "$est/budget.dta", replace
drop n
outsheet using "$est/budget.csv", replace noname
restore
drop Wage


********************************************************************************
* Teacher Characteristics For 2014
********************************************************************************

keep if year == 2014
drop year

sort exp masterup
merge m:1 exp masterup using schedule_temp.dta
keep if _m == 3
drop _m
if `using_synthetic' {
    _synth_fill_missing mode*
}
rm schedule_temp.dta

sort n
merge m:1 n using "$est/alphagrid.dta"
keep if _m == 3
drop _m

* Export teacher ages for the forward repeated-game exercise. Following the
* original generator, calculate age in 2014, impute a missing age with the
* median among teachers at the same continuous-experience level, and round to
* integer years. IDs remain in this file because the forward-code preparation
* uses them to align ages with the 6,600-teacher estimation sample.
preserve
keep id birth_estsample totalexp2
gen age = 2014 - birth_estsample
quietly levelsof totalexp2 if missing(age), local(age_exp_levels)
foreach e of local age_exp_levels {
    quietly summarize age if totalexp2 == `e', detail
    if r(N) > 0 {
        replace age = r(p50) if missing(age) & totalexp2 == `e'
    }
}
replace age = round(age)
keep id age
sort id
outsheet using "$est/age_estsample.csv", replace
restore
drop birth_estsample

* Export main information.
preserve
sort id
keep id district_code Dpast
qui reg *
count if e(sample)
rename district_code Dist_all
sort id
save "$est/info_all.dta", replace
restore

* Export wages.
preserve
sort id
keep id wage*
qui reg *
count if e(sample)
sort id
save "$est/wage.dta", replace
drop id
outsheet using "$est/wage.csv", replace noname
restore

* Export wage schedule.
preserve
sort id
keep id mode*
qui reg *
count if e(sample)
sort id
save "$est/wageschedule.dta", replace
drop id
outsheet using "$est/wageschedule.csv", replace noname
restore

* Export experience.
preserve
qui tab exp, gen(Exp)
sort id
keep id Exp* totalexp
qui reg *
count if e(sample)
sort id
save "$est/experience.dta", replace
drop id totalexp
outsheet using "$est/experience.csv", replace noname
restore

* Export continuous experience.
preserve
keep id totalexp
qui reg *
count if e(sample)
sort id
save "$est/experiencecont.dta", replace
drop id
outsheet using "$est/experiencecont.csv", replace noname
restore

* Export master's degree indicator.
preserve
sort id
keep id masterup
qui reg *
count if e(sample)
sort id
save "$est/master.dta", replace
drop id
outsheet using "$est/master.csv", replace noname
restore

* Export contributions.
preserve
sort id
keep id V0 V1 v0 v1 xb0 xb1
qui reg *
count if e(sample)
sort id
save "$est/contributions.dta", replace
drop id v0 v1
outsheet using "$est/contributions.csv", replace noname
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
save "$est/match.dta", replace
drop id
outsheet using "$est/match.csv", replace noname
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
save "$est/incumbent.dta", replace
drop id
outsheet using "$est/incumbent.csv", replace noname
restore

preserve
sort id
keep id samecz*
qui reg *
count if e(sample)
sort id
save "$est/samecz.dta", replace
drop id
outsheet using "$est/samecz.csv", replace noname
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
save "$est/lambda.dta", replace
drop n
outsheet using "$est/lambda.csv", replace noname
restore

* Enrollment
preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
gen N = 1
keep if year == 2014
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
save "$est/enrollment.dta", replace
drop n
outsheet using "$est/enrollment.csv", replace noname
restore

* Urban
preserve
gen urban = type == 1
keep if district_code != .
collapse urban, by(district_code)
gen n = 1
keep n district_code urban
reshape wide urban, i(n) j(district_code)
save "$est/urban.dta", replace
drop n
outsheet using "$est/urban.csv", replace noname
restore

* Suburban
preserve
gen suburban = type == 2
keep if district_code != .
collapse suburban, by(district_code)
gen n = 1
keep n district_code suburban
reshape wide suburban, i(n) j(district_code)
save "$est/suburban.dta", replace
drop n
outsheet using "$est/suburban.csv", replace noname
restore

* Share poor
preserve
use "$est/urban.dta", clear
reshape long urban, i(n) j(district_code)
drop n
sort distr
gen n = _n
sort distr
save tt.dta, replace
restore

preserve
use "$intdata/indtest_math_split_JPE.dta", replace
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
merge 1:1 district_code using tt.dta
keep if _m == 3
drop _m
rm tt.dta
drop district_code
order n, first
drop urban
sort n
xtile poor_vingtile = econ_d, n(20)
outsheet using "$est/sharepoor.csv", names replace
restore



********************************************************************************
* Generate dataset used for multinomial logit (Teacher Aux 2)
********************************************************************************

use "$est/wage.dta", clear
* wisorize wage
reshape long wage, i(id) j(district)
replace wage = 86.731818 if wage > 86.731818
replace wage = 28.777456 if wage < 28.777456
reshape wide wage, i(id) j(district)
sort id
merge 1:1 id using "$est/experience.dta"
drop _m
sort id
merge 1:1 id using "$est/experiencecont.dta"
drop _m
sort id
merge 1:1 id using "$est/master.dta"
drop _m
sort id
merge 1:1 id using "$est/contributions.dta"
drop _m
sort id
merge 1:1 id using "$est/match.dta"
drop _m
sort id
merge 1:1 id using "$est/incumbent.dta"
drop _m
sort id
merge 1:1 id using "$est/samecz.dta"
drop _m

gen n = 1

merge m:1 n using "$est/lambda.dta"
drop _m
merge m:1 n using "$est/enrollment.dta"
drop _m
merge m:1 n using "$est/budget.dta"
drop _m
merge m:1 n using "$est/budget_past.dta"
drop _m
merge m:1 n using "$est/urban.dta"
drop _m
merge m:1 n using "$est/suburban.dta"
drop _m
merge m:1 n using "$est/alphagrid.dta"
drop _m

reshape long wage Match Inc samecz d N budget capacity budget_past capacity_past urban suburban alpha0_ alpha1_, i(id) j(District)

sort id District


gen c0d = (v0 + xb0) * d
gen c1d = (v1 + xb1) * (1 - d)
gen C0d = (V0 + xb0) * d
gen C1d = (V1 + xb1) * (1 - d)


bysort id: egen entr = sum(Inc)
replace entr = 1 - entr

save "$est/multinomial.dta", replace



********************************************************************************
* Distance 
********************************************************************************

use "$est/multinomial.dta", clear

preserve
use "$raw/district_distance_sdid.dta", clear
destring d1, replace
destring d2, replace
sort d1 d2
tempfile temp
save `temp', replace
restore

gen d1 = District if Inc == 1
gen d2 = District
tempvar d1
bysort id: egen `d1' = max(d1)
drop d1
gen d1 = `d1'

* Check that all districts are covered.
preserve
keep d2
duplicates drop
merge 1:m d2 using `temp'
tab d2 if _m == 1
restore

sort d1 d2
merge m:1 d1 d2 using `temp'
drop if _m == 2
drop _m
replace distance = 0 if distance == .
gen lndist = ln(distance)
replace lndist = 0 if lndist == .
keep id d1 d2 lndist
reshape wide lndist, i(id) j(d2)
drop id d1
outsheet * using "$est/lndist.csv", replace noname

rm tag.dta

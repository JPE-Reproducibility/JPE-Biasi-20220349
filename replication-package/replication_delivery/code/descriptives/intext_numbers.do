********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    intext_numbers.do
* Purpose: Reproduce numbers reported in the paper and Online Appendix.
* Creates: $out/tables/Intext_numbers.log
********************************************************************************

version 19

capt mkdir "$out"
capt mkdir "$out/tables"


********************************************************************************
* District Proficiency Ranges (paper p. 2, footnote 1)
********************************************************************************

preserve
import delimited using ///
    "$rootpath/data/public/proficiency_data/SY2021_FS175_DG583_LEA_data_files/SY2021_FS175_DG583_LEA.csv", ///
    varnames(1) stringcols(_all) bindquote(strict) encoding("UTF-8") ///
    case(lower) clear

keep if inlist(state, "CALIFORNIA", "TEXAS", "WISCONSIN") & ///
    subgroup == "All Students in LEA" & agegrade == "Grade 5" & ///
    academicsubject == "Mathematics" & outcome == "Percent Proficient"

gen str8 low_string = ustrregexs(1) if ustrregexm(value, "([0-9]+)")
gen str8 high_string = ustrregexs(2) ///
    if ustrregexm(value, "([0-9]+)[^0-9]+([0-9]+)")
replace high_string = low_string if low_string != "" & high_string == ""
destring low_string high_string, gen(low high)
drop if missing(low)
collapse (min) low (max) high, by(state)

qui su low if state == "WISCONSIN", meanonly
local wi_low = r(mean)
qui su high if state == "WISCONSIN", meanonly
local wi_high = r(mean)
qui su low if state == "CALIFORNIA", meanonly
local ca_low = r(mean)
qui su high if state == "CALIFORNIA", meanonly
local ca_high = r(mean)
qui su low if state == "TEXAS", meanonly
local tx_low = r(mean)
qui su high if state == "TEXAS", meanonly
local tx_high = r(mean)
restore


********************************************************************************
* Students Switching Districts (paper p. 17, footnote 17)
********************************************************************************

tempfile adoption
preserve
use "$est/multinomial.dta", clear
keep District alpha1_
duplicates drop
rename District district_code
gen adopting = alpha1_ > 0 if !missing(alpha1_)
keep district_code adopting
save `adoption'

use "$intdata/indtest_math_split_JPE.dta", clear
drop if schoolcode == 8888
merge m:1 district_code using `adoption', keep(master match) nogen
xtset student_key year

gen switched = district_code != L.district_code if !missing(L.district_code)
gen switched_adopting = switched == 1 & adopting == 1 & ///
    L.adopting == 0 if !missing(switched, adopting, L.adopting)

qui su switched if inrange(year, 2007, 2016) & inrange(grade, 4, 6)
local switched_mean = 100 * r(mean)

forvalues y = 2010/2013 {
    qui su switched if year == `y' & inrange(grade, 4, 6)
    local switched_`y' = 100 * r(mean)
    qui su switched_adopting if year == `y'
    local adopting_`y' = 100 * r(mean)
}
restore


********************************************************************************
* Public Elementary Districts With One School (paper p. 17)
********************************************************************************

tempfile school_count
preserve
use "$intdata/teachers_panel_JPE.dta", clear
drop if schoolcode == 8888
keep if (math == 1 | all_elem == 1) & !missing(v0) & ///
    fte_tot == 100 & year == 2014
keep district_code schoolcode
duplicates drop
gen n_schools = 1
collapse (sum) n_schools, by(district_code)
save `school_count'

use "$est/urban.dta", clear
reshape long urban, i(n) j(district_code)
keep district_code
merge 1:1 district_code using `school_count', keep(master match) nogen
qui count
local n_districts = r(N)
qui count if n_schools == 1
local n_one_school = r(N)
restore


********************************************************************************
* Sample Exclusions (paper p. 24, footnote 30)
********************************************************************************

preserve
use "$intdata/staff_large_withid_JPE.dta", clear
keep if inlist(year, 2010, 2014)
keep if position == 53 | position == 43
gen substitute = position == 43 | lt_substitute == "Y"
drop if subcontracted == "Y"
keep if inlist(hireagencytype, 3, 4) & inlist(workagencytype, 3, 4)
drop if hireagencycode > 7000 | missing(schoolcode)
drop if salary == 0 | dayscontract == 0 | fte == 0 | missing(fte)

drop id
rename filenumber id
gen math_record = inlist(area, 400, 412, 50) if !missing(area)
gen grade_record = inlist(highgrade, "04", "05", "06")
bys id year: egen math_teacher = max(math_record)
bys id year: egen grade_teacher = max(grade_record)
bys id year: egen substitute_teacher = max(substitute)
bys id year: egen fte_tot = total(fte)
bys id year: keep if _n == 1
gen part_time = fte_tot < 100
keep if math_teacher == 1 & grade_teacher == 1

foreach y in 2010 2014 {
    qui su substitute_teacher if year == `y'
    local substitute_`y' = 100 * r(mean)
    qui su part_time if year == `y'
    local part_time_`y' = 100 * r(mean)
}
restore


********************************************************************************
* Experience and Teacher Contributions (paper p. 27)
********************************************************************************

preserve
use "$est/contributions.dta", clear
merge 1:1 id using "$est/experiencecont.dta", nogen
gen c1 = xb0 + v0
gen c2 = xb1 + v1
qui corr c1 totalexp2
local corr_exp_c1 = r(rho)
qui corr c2 totalexp2
local corr_exp_c2 = r(rho)
restore


********************************************************************************
* Observed and Predicted Wages (paper p. 27, footnote 34)
********************************************************************************

preserve
use "$intdata/teachers_panel_JPE.dta", clear
keep if year == 2014
keep id salary_round
merge 1:1 id using "$intdata/alphagrid_wages_8groups_JPE.dta", ///
    keep(match) nogen
gen observed = salary_round / 1000
gen predicted = (salary_round - S_dev) / 1000
qui reg observed predicted
local wage_slope = _b[predicted]
local wage_se = _se[predicted]
local wage_r2 = e(r2)
restore

tempfile predicted_wage
preserve
use "$est/wage.dta", clear
unab wages : wage*
merge 1:1 id using "$est/match.dta", nogen
gen predicted = .
foreach w of local wages {
    local d : subinstr local w "wage" "", all
    replace predicted = `w' if Match`d' == 1
}
keep id predicted
save `predicted_wage'

use "$intdata/teachers_panel_JPE.dta", clear
keep if year == 2014
keep id salary_round mover_d
merge 1:1 id using `predicted_wage', keep(match) nogen
gen observed = salary_round / 1000
qui reg predicted observed if mover_d == 1
local mover_slope = _b[observed]
local mover_se = _se[observed]
local mover_r2 = e(r2)
restore


********************************************************************************
* Race Controls in Auxiliary Model 1a (paper p. 28, footnote 35)
********************************************************************************

tempfile teacher_race district_race
preserve
use "$intdata/teachers_new_JPE.dta", clear
keep if year == 2014
keep id female black hispanic asian
save `teacher_race'

use "$intdata/indtest_math_split_JPE.dta", clear
drop if schoolcode == 8888
keep if year == 2011
collapse (mean) Sfemale Sblack Shispanic Sasian, by(district_code)
save `district_race'

use "$est/matched_movers.dta", clear
capt drop v0 v1
duplicates drop
merge 1:1 id District using "$est/multinomial.dta", keep(match) nogen
merge m:1 id using `teacher_race', keep(match) nogen
rename District district_code
merge m:1 district_code using `district_race', keep(match) nogen
rename district_code District

egen miss = rowmiss(Match wage d C0d totalexp Inc samecz urban suburban ///
    female black hispanic asian Sfemale Sblack Shispanic Sasian)
keep if miss == 0
capt drop entr
bys id: egen entr = total(Inc)
replace entr = 1 - entr
gen explam = exp(d)
gen D0 = (1 - entr) * (1 - Inc)
gen D0exp = D0 * totalexp
gen CZ = (1 - entr) * (1 - samecz)
gen milw = District == 3619
gen female_match = female * Sfemale
gen black_match = black * Sblack
gen hispanic_match = hispanic * Shispanic
gen asian_match = asian * Sasian

xtset id District
qui xtreg Match wage explam C0d D0 D0exp CZ urban suburban milw, ///
    fe vce(cluster id)
local race_r2 = e(r2_w)
qui xtreg Match wage explam C0d D0 D0exp CZ urban suburban milw ///
    Sfemale female_match Sblack black_match Shispanic hispanic_match ///
    Sasian asian_match, fe vce(cluster id)
local race_controls_r2 = e(r2_w)
restore


********************************************************************************
* Offer-Set Robustness (Online Appendix p. 9)
********************************************************************************

tempfile class_va choice_grid seeds thresholds alternative baseline
preserve
use "$intdata/va_classmodel_JPE.dta", clear
keep id year v0 v1
rename v0 c0_class
rename v1 c1_class
gsort id -year
by id: replace c0_class = c0_class[_n - 1] if missing(c0_class)
by id: replace c1_class = c1_class[_n - 1] if missing(c1_class)
sort id year
by id: replace c0_class = c0_class[_n - 1] if missing(c0_class)
by id: replace c1_class = c1_class[_n - 1] if missing(c1_class)
keep if year == 2014
keep id c0_class c1_class
save `class_va'

use "$est/multinomial.dta", clear
merge m:1 id using `class_va', keep(match) nogen
gen exp = 1
forvalues n = 2/6 {
    replace exp = `n' if Exp`n' == 1
}
bys id: egen exit = max(Match)
replace exit = 1 - exit
bys id: egen INC = max(Inc)
bys exp masterup: egen c0bar = mean(c0_class) if Match == 1
bys exp masterup: egen c1bar = mean(c1_class) if Match == 1
bys id: egen c0_first = max(c0bar)
bys id: egen c1_first = max(c1bar)
replace c0_class = c0_first if exp == 1
replace c1_class = c1_first if exp == 1
gen C0d_class = c0_class * d
gen C1d_class = c1_class * (1 - d)

gen seed = ((Exp2 == 1 & Match == 1) | ///
    (Inc == 0 & Match == 1 & Exp1 == 0 & Exp2 == 0 & INC == 1) | ///
    (Inc == 1 & Match == 0 & Exp1 == 0 & Exp2 == 0 & INC == 1)) & ///
    exit == 0

by id: egen has_seed = max(seed)
save `choice_grid'

keep if seed
keep id District
duplicates drop
save `seeds'

use `choice_grid', clear
keep if has_seed == 1 & Match == 1
keep id District C0d_class C1d_class exp wage masterup
rename id seed_id
rename C0d_class seed_C0d
rename C1d_class seed_C1d
rename exp seed_exp
rename wage seed_wage
rename masterup seed_master
save `thresholds'

use `choice_grid', clear
keep if Match == 0
keep id District C0d_class C1d_class exp wage masterup
joinby District using `thresholds'
keep if C0d_class >= seed_C0d & C1d_class >= seed_C1d & ///
    exp >= seed_exp & wage <= seed_wage & masterup >= seed_master
keep id District
append using `seeds'
duplicates drop
gen choice2 = 1
save `alternative'

use "$est/matched_movers.dta", clear
keep id District
duplicates drop
gen choice1 = 1
save `baseline'

use "$est/multinomial.dta", clear
keep id District Match
merge 1:1 id District using `baseline', nogen
merge 1:1 id District using `alternative', nogen
replace choice1 = 0 if missing(choice1)
replace choice2 = 0 if missing(choice2)
replace choice1 = 1 if Match == 1
replace choice2 = 1 if Match == 1
gen only1 = choice1 > choice2
gen only2 = choice2 > choice1
collapse (max) only1 only2, by(id)
gen equal = only1 == 0 & only2 == 0
gen superset = only1 == 1 & only2 == 0
gen subset = only1 == 0 & only2 == 1
gen neither = only1 == 1 & only2 == 1

qui su equal
local set_equal = 100 * r(mean)
qui su superset
local set_superset = 100 * r(mean)
qui su subset
local set_subset = 100 * r(mean)
qui su neither
local set_neither = 100 * r(mean)
restore


********************************************************************************
* Wage-Schedule Fit (Online Appendix p. 12)
********************************************************************************

tempfile district_low
preserve
use "$intdata/indtest_math_split_JPE.dta", clear
drop if schoolcode == 8888
gen d = std_score <= 0.07 if !missing(std_score)
keep if year == 2011
collapse (mean) d, by(district_code)
save `district_low'

use "$intdata/teachers_panel_JPE.dta", clear
drop if year == 2010 & district_code == 2793
merge m:1 district_code using `district_low', keep(master match) nogen
qui tab exp, gen(Exp)
gen xb0 = g2_1 * Exp2 + g3_1 * Exp3 + g4_1 * Exp4 + ///
    g5_1 * Exp5 + g6_1 * Exp6
gen xb1 = g2_2 * Exp2 + g3_2 * Exp3 + g4_2 * Exp4 + ///
    g5_2 * Exp5 + g6_2 * Exp6
gen Dpast = district_past2009
replace Dpast = district_past2008 if missing(Dpast) & ///
    !missing(district_past2012)
replace Dpast = 0 if missing(Dpast)
keep if !missing(v0, v1, d)
qui reg id district_code Dpast v0 v1 xb0 xb1 d exp masterup ///
    salary_round type totalexp year
keep if e(sample) & year == 2010
merge m:1 district_code using "$intdata/schedule_new_JPE.dta", ///
    keep(match) nogen

gen schedule_wage = .
forvalues n = 1/6 {
    replace schedule_wage = CExp`n'_ba / 1000 if exp == `n' & masterup == 0
    replace schedule_wage = CExp`n'_ma / 1000 if exp == `n' & masterup == 1
}
replace schedule_wage = 86.731818 if schedule_wage > 86.731818 & ///
    !missing(schedule_wage)
replace schedule_wage = 28.777456 if schedule_wage < 28.777456 & ///
    !missing(schedule_wage)
qui corr salary_round schedule_wage
local schedule_corr = r(rho)
restore

preserve
use "$intdata/teachers_panel_JPE.dta", clear
keep if year == 2014
keep id salary_round
merge 1:1 id using "$intdata/alphagrid_wages_8groups_JPE.dta", ///
    keep(match) nogen
gen predicted = salary_round - S_dev
gen within = abs(S_dev) <= 10000 if !missing(salary_round, S_dev)
qui su within
local within_schedule = 100 * r(mean)
qui reg salary_round predicted, noconstant
local schedule_slope = _b[predicted]
local schedule_se = _se[predicted]
local schedule_r2 = e(r2)
restore


********************************************************************************
* Salary Variation Across Districts and Schools (Online Appendix p. 18)
********************************************************************************

preserve
use "$intdata/teachers_panel_JPE.dta", clear
qui tab exp, gen(Exp)
gen xb0 = g2_1 * Exp2 + g3_1 * Exp3 + g4_1 * Exp4 + ///
    g5_1 * Exp5 + g6_1 * Exp6
gen xb1 = g2_1 * Exp2 + g3_1 * Exp3 + g4_1 * Exp4 + ///
    g5_1 * Exp5 + g6_1 * Exp6
gen c1 = v0 + xb0
gen c2 = v1 + xb1
egen schoolid = group(district_code schoolcode)

qui reghdfe salary_round c1 c2 if year > 2012, ///
    absorb(totalexp2 masterup)
local rmse = e(rmse)
qui reghdfe salary_round c1 c2 if year > 2012, ///
    absorb(totalexp2 masterup district_code)
local rmse_district = e(rmse)
qui reghdfe salary_round c1 c2 if year > 2012, ///
    absorb(totalexp2 masterup district_code schoolid)
local rmse_school = e(rmse)

local district_reduction = 100 * (`rmse' - `rmse_district') / `rmse'
local school_reduction = 100 * ///
    (`rmse_district' - `rmse_school') / `rmse'
if abs(`school_reduction') < 1e-8 local school_reduction = 0
restore


********************************************************************************
* Student Composition Across Districts and Schools (Online Appendix p. 18)
********************************************************************************

preserve
use "$intdata/indtest_math_split_JPE.dta", clear
keep if year == 2011 & schoolcode != 8888
drop if missing(std_score, district_code, schoolcode)
gen low = std_score <= 0.07
egen schoolid = group(district_code schoolcode)

qui areg low, absorb(district_code)
local student_district_r2 = 100 * e(r2)
qui areg low, absorb(schoolid)
local student_school_r2 = 100 * e(r2) - `student_district_r2'

gen one = 1
collapse (mean) school_share=low ///
    (sum) low_count=low enrollment=one, by(district_code schoolcode)
bys district_code: egen district_low = total(low_count)
bys district_code: egen district_enrollment = total(enrollment)
gen district_share = district_low / district_enrollment
gen gap = abs(school_share - district_share)

qui areg school_share [aw=enrollment], absorb(district_code)
local school_district_r2 = e(r2)
qui su gap [aw=enrollment], detail
local gap_mean = r(mean)
local gap_sd = r(sd)
local gap_p25 = r(p25)
local gap_p50 = r(p50)
local gap_p75 = r(p75)
restore


********************************************************************************
* Write Only the Numbers Reported in the Paper
********************************************************************************

tempname outlog
file open `outlog' using "$out/tables/Intext_numbers.log", ///
    write text replace

file write `outlog' "District proficiency ranges (%): Wisconsin " ///
    %2.0f (`wi_low') "-" %2.0f (`wi_high') "; California " ///
    %2.0f (`ca_low') "-" %2.0f (`ca_high') "; Texas " ///
    %2.0f (`tx_low') "-" %2.0f (`tx_high') _n

file write `outlog' "Students switching districts, 2007-2016 average (%): " ///
    %4.1f (`switched_mean') _n
file write `outlog' "Students switching districts, 2010-2013 (%): " ///
    %4.1f (`switched_2010') ", " %4.1f (`switched_2011') ", " ///
    %4.1f (`switched_2012') ", " %4.1f (`switched_2013') _n
file write `outlog' "Moves from non-adopting to adopting districts, 2010-2013 (%): " ///
    %4.1f (`adopting_2010') ", " %4.1f (`adopting_2011') ", " ///
    %4.1f (`adopting_2012') ", " %4.1f (`adopting_2013') _n

file write `outlog' "Public elementary districts with one school: " ///
    %4.0f (`n_one_school') " of " %4.0f (`n_districts') _n

file write `outlog' "Substitute teachers, 2014 and 2010 (%): " ///
    %4.1f (`substitute_2014') ", " %4.1f (`substitute_2010') _n
file write `outlog' "Part-time teachers, 2014 and 2010 (%): " ///
    %4.1f (`part_time_2014') ", " %4.1f (`part_time_2010') _n

file write `outlog' "Correlation of experience with c1 and c2: " ///
    %5.2f (`corr_exp_c1') ", " %5.2f (`corr_exp_c2') _n

file write `outlog' "Observed-predicted wage fit, full sample: slope " ///
    %5.2f (`wage_slope') "; SE " %5.3f (`wage_se') ///
    "; R-squared " %5.2f (`wage_r2') _n
file write `outlog' "Observed-predicted wage fit, movers: slope " ///
    %5.2f (`mover_slope') "; SE " %5.2f (`mover_se') ///
    "; R-squared " %5.2f (`mover_r2') _n

file write `outlog' "Auxiliary Model 1a within R-squared, baseline and with race controls: " ///
    %5.3f (`race_r2') ", " %5.3f (`race_controls_r2') _n

file write `outlog' "Offer sets (%): equal " %4.0f (`set_equal') ///
    "; baseline superset " %4.0f (`set_superset') ///
    "; baseline subset " %4.0f (`set_subset') ///
    "; non-nested " %4.0f (`set_neither') _n

file write `outlog' "Wage-schedule correlation, 2010: " ///
    %5.2f (`schedule_corr') _n
file write `outlog' "Wage-schedule fit, 2014: within 10,000 dollars " ///
    %4.0f (`within_schedule') "%" "; slope " %5.2f (`schedule_slope') ///
    "; SE " %5.3f (`schedule_se') "; R-squared " ///
    %5.2f (`schedule_r2') _n

file write `outlog' "Root-MSE reduction from district and additional school fixed effects (%): " ///
    %4.1f (`district_reduction') ", " %4.1f (`school_reduction') _n

file write `outlog' "Student-level R-squared from district and additional school fixed effects (%): " ///
    %4.1f (`student_district_r2') ", " %4.1f (`student_school_r2') _n
file write `outlog' "School-share R-squared from district fixed effects: " ///
    %5.2f (`school_district_r2') _n
file write `outlog' "Absolute school-district gap: mean " ///
    %5.2f (`gap_mean') "; SD " %5.2f (`gap_sd') ///
    "; p25/p50/p75 " %5.2f (`gap_p25') "/" %5.2f (`gap_p50') ///
    "/" %5.2f (`gap_p75') _n

file close `outlog'

********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    testscores_build.do
* Purpose: Build individual-level math test-score panels, adjusting for
*          Fall versus Spring testing dates.
* Creates: indtest_math_JPE.dta
********************************************************************************


********************************************************************************
* Student Demographics
********************************************************************************

* Import demographics.
insheet using "$confdata/raw/testscores_indlev/student_demographics.csv", ///
    comma names clear

* Clean demographics.
gen year = substr(school_year,1,4)
destring year, replace
drop school_year

gen Sfemale = gender == "F"
replace Sfemale = . if gender == ""
drop gender

gen Sblack = race_ethnicity == "Black"
gen Shispanic = race_ethnicity == "Hispanic"
gen Sasian = race_ethnicity == "Asian"
gen Sam_ind = race_ethnicity == "Amer Indian"
drop race_ethn

keep student year S* econ_disadvantage el_status disab_status
sort student_key year
save "$intdata/dem.dta", replace


********************************************************************************
* Test Scores: Current-Year Assignment
********************************************************************************

* Import test scores.
insheet using "$confdata/raw/testscores_indlev/testscores.csv", comma names clear

* Clean test-score identifiers.
gen year = substr(school_year,1,4)
destring year, replace
drop school_year

gen schoolcode = substr(sch_acctbl_code,6,4)
destring schoolcode, replace
drop sch_acctbl_code

rename dist_acctbl_code district_code

* Keep grades 3-8 and the relevant tested subjects.
drop if grade == 10
keep if (year <= 2014 & ///
    (test_subject == "Reading" | test_subject == "Mathematics")) | ///
    (year > 2014 & ///
    (test_subject == "ELA" | test_subject == "Mathematics"))

* Standardize test scores.
gen std_score = .
foreach g in 3 4 5 6 7 8 {
    forvalues y = 2005/2013 {
        disp "grade `g', year `y', Reading"
        qui sum test_scaled_score if year == `y' & ///
            test_subject == "Reading" & grade == `g'
        replace std_score = (test_scaled_score - r(mean)) / r(sd) ///
            if year == `y' & test_subject == "Reading" & grade == `g'
    }
}

foreach g in 3 4 5 6 7 8 {
    forvalues y = 2005/2013 {
        disp "grade `g', year `y', Math"
        qui sum test_scaled_score if year == `y' & ///
            test_subject == "Mathematics" & grade == `g'
        replace std_score = (test_scaled_score - r(mean)) / r(sd) ///
            if year == `y' & test_subject == "Mathematics" & grade == `g'
    }
}

foreach g in 3 4 5 6 7 8 {
    forvalues y = 2014/2016 {
        disp "grade `g', year `y', ELA"
        qui sum test_scaled_score if year == `y' & ///
            test_subject == "ELA" & grade == `g'
        replace std_score = (test_scaled_score - r(mean)) / r(sd) ///
            if year == `y' & test_subject == "ELA" & grade == `g'
    }
}

foreach g in 3 4 5 6 7 8 {
    forvalues y = 2014/2016 {
        disp "grade `g', year `y', Math"
        qui sum test_scaled_score if year == `y' & ///
            test_subject == "Mathematics" & grade == `g'
        replace std_score = (test_scaled_score - r(mean)) / r(sd) ///
            if year == `y' & test_subject == "Mathematics" & grade == `g'
    }
}

* Remove observations without standardized test scores.
drop if std_score == .

drop test_scaled_score test_stderr test_prof
keep student_key district_code schoolcode year grade test_subject std_score
order student_key district_code schoolcode year grade, first
sort student_key year

* Merge demographic variables.
merge m:1 student_key year using "$intdata/dem.dta"
drop if _m == 2
drop _m

* Carry forward time-invariant demographic information.
bysort student_key (year): carryforward disab_status el_status ///
    econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind, replace
gsort student_key -year
bysort student_key: carryforward disab_status el_status econ_disadvantage ///
    Sfemale Sblack Shispanic Sasian Sam_ind, replace
drop if Sblack == .

keep if test_subject == "Mathematics"
drop test_subject
isid student_key year
sort district_code schoolcode year grade student_key

* Adjust assignment timing to account for Fall versus Spring testing.
tsset student year
gen schoolcode2 = l.schoolcode
replace schoolcode = schoolcode2 if schoolcode2 != . & year <= 2013
gen dist2 = l.district_code
replace district_code = dist2 if dist2 != . & year <= 2013
drop schoolcode2 dist2

tsset student year
gen std_score_past = l.std_score
replace grade = grade - 1 if year <= 2013
replace year = year + 1 if year > 2013
save $intdata/indtest_math.dta, replace


********************************************************************************
* Test Scores: Previous-Year Assignment
********************************************************************************

* Import test scores.
insheet using "$confdata/raw/testscores_indlev/testscores.csv", comma names clear

* Clean test-score identifiers.
gen year = substr(school_year,6,4)
destring year, replace
drop school_year

gen schoolcode = substr(sch_acctbl_code,6,4)
destring schoolcode, replace
drop sch_acctbl_code

rename dist_acctbl_code district_code

* Keep grades 3-8 and the relevant tested subjects.
drop if grade == 10
keep if (year <= 2014 & ///
    (test_subject == "Reading" | test_subject == "Mathematics")) | ///
    (year > 2014 & ///
    (test_subject == "ELA" | test_subject == "Mathematics"))

* Standardize test scores.
gen std_score = .
foreach g in 3 4 5 6 7 8 {
    forvalues y = 2006/2014 {
        disp "grade `g', year `y', Reading"
        qui sum test_scaled_score if year == `y' & ///
            test_subject == "Reading" & grade == `g'
        replace std_score = (test_scaled_score - r(mean)) / r(sd) ///
            if year == `y' & test_subject == "Reading" & grade == `g'
    }
}

foreach g in 3 4 5 6 7 8 {
    forvalues y = 2006/2014 {
        disp "grade `g', year `y', Math"
        qui sum test_scaled_score if year == `y' & ///
            test_subject == "Mathematics" & grade == `g'
        replace std_score = (test_scaled_score - r(mean)) / r(sd) ///
            if year == `y' & test_subject == "Mathematics" & grade == `g'
    }
}

foreach g in 3 4 5 6 7 8 {
    forvalues y = 2015/2017 {
        disp "grade `g', year `y', ELA"
        qui sum test_scaled_score if year == `y' & ///
            test_subject == "ELA" & grade == `g'
        replace std_score = (test_scaled_score - r(mean)) / r(sd) ///
            if year == `y' & test_subject == "ELA" & grade == `g'
    }
}

foreach g in 3 4 5 6 7 8 {
    forvalues y = 2015/2017 {
        disp "grade `g', year `y', Math"
        qui sum test_scaled_score if year == `y' & ///
            test_subject == "Mathematics" & grade == `g'
        replace std_score = (test_scaled_score - r(mean)) / r(sd) ///
            if year == `y' & test_subject == "Mathematics" & grade == `g'
    }
}

* Remove observations without standardized test scores.
drop if std_score == .

drop test_scaled_score test_stderr test_prof
keep student_key district_code schoolcode year grade test_subject std_score
order student_key district_code schoolcode year grade, first
sort student_key year

* Merge demographic variables.
merge m:1 student_key year using "$intdata/dem.dta"
drop if _m == 2
drop _m

* Carry forward time-invariant demographic information.
bysort student_key (year): carryforward disab_status el_status ///
    econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind, replace
gsort student_key -year
bysort student_key: carryforward disab_status el_status econ_disadvantage ///
    Sfemale Sblack Shispanic Sasian Sam_ind, replace
drop if Sblack == .

preserve
keep if test_subject == "Mathematics"
drop test_subject
isid student_key year

tsset student year
gen std_score_past = l.std_score

save $intdata/indtest_math_old.dta, replace
restore


********************************************************************************
* Combine Test-Timing Assignments
********************************************************************************

use $intdata/indtest_math.dta, clear
rename std_score std_score_new
rename std_score_past std_score_past_new

drop S* el* ec* disab*
sort student year
merge 1:1 student year using $intdata/indtest_math_old.dta
drop _m
rename std_score std_score_old
rename std_score_past std_score_past_old
egen std_score = rowmean(std_score_old std_score_new)
egen std_score_past = rowmean(std_score_past_old std_score_past_new)
drop *old *new
keep if std_score_past != .
drop if grade < 4 | year < 2006 | year > 2016
sort student year

* Re-standardize final scores by grade-year.
foreach g in 3 4 5 6 7 8 {
    forvalues y = 2006/2013 {
        disp "grade `g', year `y', ELA"
        qui sum std_score if year == `y' & grade == `g'
        replace std_score = (std_score - r(mean)) / r(sd) ///
            if year == `y' & grade == `g'
        qui sum std_score_past if year == `y' & grade == `g'
        replace std_score_past = (std_score_past - r(mean)) / r(sd) ///
            if year == `y' & grade == `g'
    }
}

save $intdata/indtest_math_split_JPE.dta, replace

rm $intdata/indtest_math_old.dta
rm $intdata/indtest_math.dta

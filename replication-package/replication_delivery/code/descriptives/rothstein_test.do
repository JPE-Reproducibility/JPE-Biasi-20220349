********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    rothstein_test.do
* Purpose: Produce the Rothstein/Chetty placebo and forecast bias tests for changes in teacher
*          contributions and student test-score residuals.
********************************************************************************


global controls = "std_score_past disab_status el_status econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind"


********************************************************************************
* Student Test-Score Residuals
********************************************************************************

use "$intdata/indtest_math_split_JPE.dta", clear
tsset student_key year
keep if std_score_past != . & year < 2017
drop if grade < 3 | grade > 8

* Generate school-grade-year means for student characteristics.
egen schoolid = group(district_code schoolcode)
foreach var in std_score_past disab_status el_status econ_disadvantage ///
    Sfemale Sblack Shispanic Sasian Sam_ind {
    bysort district_code schoolcode grade year: egen M`var' = mean(`var')
}

gen t = 1
bysort district_code schoolcode grade year: egen Msize = sum(t)
drop t

* Interact polynomials in lagged test scores with grade indicators.
forvalues p = 1/3 {
    forvalues g = 3/7 {
        gen past`p'_grade`g' = ((std_score_past)^`p') * (grade == `g')
        gen Mpast`p'_grade`g' = ((Mstd_score_past)^`p') * (grade == `g')
    }
}

* Residualize separately by low- and high-prior-score groups.
gen D = std_score_past >= 0.07
replace D = . if std_score_past == .

bysort district_code schoolcode: egen d = mean(D)
keep if grade <= 6

egen schgr = group(schoolid grade)
qui areg std_score c.std_score_past#i.grade past1* past2* c.past3* ///
    c.Mpast1* c.Mpast2* c.Mpast3* i.year i.disab_status ///
    i.el_status i.econ_disadvantage Sfemale Sblack Shispanic Sasian ///
    Sam_ind Mdisab_status Mel_status Mecon_disadvantage ///
    c.Mecon_disadvantage#i.econ_disadvantage MSfemale MSblack ///
    MShispanic MSasian MSam_ind Msize if D == 0, ///
    a(schoolid) cluster(schgr)
predict v if D == 0, resid

qui areg std_score c.std_score_past#i.grade past1* past2* c.past3* ///
    c.Mpast1* c.Mpast2* c.Mpast3* i.year i.disab_status ///
    i.el_status i.econ_disadvantage Sfemale Sblack Shispanic Sasian ///
    Sam_ind Mdisab_status Mel_status Mecon_disadvantage ///
    c.Mecon_disadvantage#i.econ_disadvantage MSfemale MSblack ///
    MShispanic MSasian MSam_ind Msize if D == 1, ///
    a(schoolid) cluster(schgr)
predict x, resid
replace v = x if D == 1
drop x

keep student year v
tsset student year
gen lv = l.v
sort student year
tempfile residuals
save `residuals', replace


********************************************************************************
* Teacher Contributions
********************************************************************************

use "$intdata/teachers_panel_JPE.dta", clear
tab exp, gen(Exp)

gen xb0 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)
gen xb1 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)
gen c0 = xb0 + v0
gen c1 = xb1 + v1

keep id year c0 c1
tempfile contributions
save `contributions', replace


********************************************************************************
* Student-Teacher-Year Panel
********************************************************************************

use "$intdata/indtest_math_split_JPE.dta", clear
tsset student_key year
keep if std_score_past != . & year < 2017
drop if grade < 3 | grade > 8
merge m:1 district_code schoolcode year grade using ///
    "$intdata/va_teacherside_math_JPE.dta"
keep if _m == 3
drop _m

* Count the number of schools per district in 2014.
preserve
keep if district_code < 8000
drop if grade < 3 | grade > 6
egen schid = group(district_code schoolcode)
keep if year == 2014
keep schid district_code
duplicates drop
gen nrsch = 1
collapse (sum) nrsch, by(district_code)
tab nrsch
sort district_code
tempfile school
save `school', replace
restore

* Generate school-grade-year means for student characteristics.
egen schoolid = group(district_code schoolcode)
foreach var in std_score_past disab_status el_status econ_disadvantage ///
    Sfemale Sblack Shispanic Sasian Sam_ind {
    bysort district_code schoolcode grade year: egen M`var' = mean(`var')
}

gen t = 1
bysort district_code schoolcode grade year: egen Msize = sum(t)
drop t

* Interact polynomials in lagged test scores with grade indicators.
forvalues p = 1/3 {
    forvalues g = 3/7 {
        gen past`p'_grade`g' = ((std_score_past)^`p') * (grade == `g')
        gen Mpast`p'_grade`g' = ((Mstd_score_past)^`p') * (grade == `g')
    }
}

* Reshape to the student-teacher-year level.
egen fakeid = group(student_key year)
forvalues x = 1/25 {
    disp "`x'"
    local z = `x' + 1

    preserve
    keep if id`x' != . & id`z' == .
    forvalues m = `z'/26 {
        drop id`m'
    }
    reshape long id, i(fakeid) j(n)
    drop fakeid
    sort student_key year n
    gen nrteachers = `x'
    save temp`x'.dta, replace
    restore
}

keep if id26 != .
reshape long id, i(fakeid) j(n)
drop fakeid
sort student_key year n
gen nrteachers = 26
save temp26.dta, replace

use temp1.dta, clear
forvalues x = 2/26 {
    append using temp`x'.dta
    rm temp`x'.dta
}
rm temp1.dta


********************************************************************************
* Rothstein Test
********************************************************************************

gen D = std_score_past >= 0.07
replace D = . if std_score_past == .

bysort district_code schoolcode: egen d = mean(D)
keep if grade <= 6

sort id year
merge m:1 id year using `contributions'
drop if _m == 2
drop _m

sort student year
merge m:1 student year using `residuals'
drop if _m == 2
drop _m

keep if grade <= 6

egen tagS = tag(student year)
egen tagT = tag(id schoolcode district_code grade year)
gen Itest = std_score if tagS == 1
gen Itestl = std_score_past if tagS == 1
gen Iv = v if tagS == 1
gen Ivl = lv if tagS == 1
gen Ic0 = c0 if tagT == 1
gen Ic1 = c1 if tagT == 1

collapse I* (sum) tag*, by(D grade schoolcode district_code year)
rename I* *

egen id = group(grade schoolcode district_code)
egen idD = group(D grade schoolcode district_code)
egen schyr = group(schoolcode district_code year)

tsset idD year
gen Dscore = test - l.test
gen Dc0 = c0 - l.c0
gen Dc1 = c1 - l.c1
gen Dscorel = testl - l.testl
gen Dv = v - l.v
gen Dvl = vl - l.vl
replace Dc0 = Dc0 * tagT
replace Dc1 = Dc1 * tagT

gen Y = 0
eststo r1: reghdfe Dv Dc0 Y if D == 0 [aw = tagS], ///
    a(schyr) cluster(id)
eststo r2: reghdfe Dv Dc1 Y if D == 1 [aw = tagS], ///
    a(schyr) cluster(id)
eststo r3: reghdfe Dvl Dc0 Y if D == 0 [aw = tagS], ///
    a(schyr) cluster(id)
eststo r4: reghdfe Dvl Dc1 Y if D == 1 [aw = tagS], ///
    a(schyr) cluster(id)

label var Dc0 "$\Delta c_0$"
label var Dc1 "$\Delta c_1$"


esttab r1 r2 r3 r4 using "$out/tables/Table_B3.tex", ///
    b(3) se(3) unstack nonote label replace se keep(Dc0 Dc1) ///
    indicate("School-by-year FE = Y") obslast ///
    mgroups("Residuals" "Lagged residuals", pattern(1 0 1 0) ///
        prefix(\multicolumn{@span}{c}{) suffix(}) span ///
        erepeat(\cmidrule(lr){@span})) ///
    nomtitle star(* 0.10 ** 0.05 *** 0.01) nogap ///
    stats(N N_clust, fmt(0 0) labels(`"N"' `"\# school-grades"')) ///
    substitute(\_ _)

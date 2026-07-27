********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    achievement_race.do
* Purpose: Estimate student achievement models with teacher-student
*          race/ethnicity interactions and construct race-adjusted VA measures.
********************************************************************************


global controls = "std_score_past disab_status el_status econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind"


********************************************************************************
* Prepare Teacher Experience and Race File
********************************************************************************

use "$intdata/teachers_new_JPE.dta", clear
keep id year asian hispanic black
sort id year
tempfile teacher_race
save `teacher_race', replace

use "$intdata/teachers_panel_nova_JPE.dta", replace
keep id year totalexp2 exp
sort id year
tempfile experience
save `experience', replace



use "$intdata/teachers_new_JPE.dta", clear
sort id year
merge 1:1 id year using `teacher_race'
drop if _m == 2
drop _m
merge 1:1 id year using `experience'
drop if _m == 2
drop _m

keep id year totalexp2 exp asian hispanic black
sort id year
tempfile experience
save `experience', replace


********************************************************************************
* Math Achievement Inputs
********************************************************************************

* Load student-level math records and merge teacher-side variables.
use "$intdata/indtest_math_split_JPE.dta", clear
tsset student_key year
keep if std_score_past != . & year < 2017
drop if grade < 3 | grade > 8
merge m:1 district_code schoolcode year grade using ///
    "$intdata/va_teacherside_math_JPE.dta"
keep if _m == 3
drop _m

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

* Merge teacher experience and race.
sort id year
merge m:1 id year using `experience'
keep if _m == 3
drop _m

* Define high- and low-prior-score groups.
gen D = std_score_past >= 0.07
replace D = . if std_score_past == .

bysort district_code schoolcode: egen d = mean(D)
gen lambda = 0.2 if d >= 0 & d <= 0.4
replace lambda = 0.5 if d > 0.4 & d <= 0.6
replace lambda = 0.8 if d > 0.6 & d <= 1
tab lambda, gen(L)
qui tab exp, gen(Exp)

keep if grade <= 6


********************************************************************************
* Residualize Outcomes with Race/Ethnicity Interactions
********************************************************************************

capture log close

gen hisphisp = hispanic * Shispanic
gen asas = asian * Sasian
gen blbl = black * Sblack

label var hispanic "Hisp T"
label var hisphisp "Hisp T * Hisp S"
label var asian "Asian T"
label var asas "Asian T * Asian S"
label var black "Black T"
label var blbl "Black T * Black S"
label var Shispanic "Hisp S"
label var Sasian "Asian S"
label var Sblack "Black S"

egen schgr = group(schoolid grade)

eststo r1: areg std_score c.std_score_past#i.grade past1* past2* ///
    c.past3* c.Mpast1* c.Mpast2* c.Mpast3* i.year i.disab_status ///
    i.el_status i.econ_disadvantage Sfemale Sblack Shispanic Sasian ///
    Sam_ind Mdisab_status Mel_status Mecon_disadvantage ///
    c.Mecon_disadvantage#i.econ_disadvantage MSfemale MSblack ///
    MShispanic MSasian MSam_ind Msize Exp2 Exp3 Exp4 Exp5 Exp6 ///
    black blbl hispanic hisphisp asian asas if D == 0, ///
    a(schoolid) cluster(schgr)

scalar define Mgamma2_1 = _b[Exp2]
scalar define Mgamma3_1 = _b[Exp3]
scalar define Mgamma4_1 = _b[Exp4]
scalar define Mgamma5_1 = _b[Exp5]
scalar define Mgamma6_1 = _b[Exp6]
scalar define R2_m1 = e(r2)

* Save residuals for low-prior-score students.
predict xb, resid
gen v = xb if D == 0
drop xb

eststo r2: areg std_score c.std_score_past#i.grade past1* past2* ///
    c.past3* c.Mpast1* c.Mpast2* c.Mpast3* i.year i.disab_status ///
    i.el_status i.econ_disadvantage Sfemale Sblack Shispanic Sasian ///
    Sam_ind Mdisab_status Mel_status Mecon_disadvantage ///
    c.Mecon_disadvantage#i.econ_disadvantage MSfemale MSblack ///
    MShispanic MSasian MSam_ind Msize Exp2 Exp3 Exp4 Exp5 Exp6 ///
    black blbl hispanic hisphisp asian asas if D == 1, ///
    a(schoolid) cluster(schgr)

esttab r1 r2 using "$out/tables/Table_B8.tex", unstack nonote label replace ///
    b(3) se(3) keep(Sasian asian asas Sblack black blbl Shispanic ///
    hispanic hisphisp) mgroups("$\tau$ = 1" "$\tau$ = 2", ///
    pattern(1 1)) obslast nomtitle star(* 0.10 ** 0.05 *** 0.01)

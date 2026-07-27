********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    valueadded_calculation_stockstaiger_nocomparativeadv.do
* Purpose: Calculate teacher value added using the KS method, without allowing
*          value added to vary by students' lagged test scores, and controlling
*          for teacher experience.
********************************************************************************

* Assumes the caller has set the working directory and the $data global.
global controls = "std_score_past disab_status el_status econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind"


********************************************************************************
* Prepare Teacher Experience File
********************************************************************************

use "$intdata/teachers_panel_nova_JPE.dta", replace
keep id year totalexp2 exp
sort id year
save "$intdata/experience.dta", replace



********************************************************************************
* Math Value Added
********************************************************************************

* Load student-level math test records and merge teacher-side variables.
use "$intdata/indtest_math_split_JPE.dta", clear
tsset student_key year
keep if std_score_past != . & year < 2017
drop if grade < 3 | grade > 8
merge m:1 district_code schoolcode year grade using "$intdata/va_teacherside_math_JPE.dta"
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

* Merge teacher experience.
sort id year
merge m:1 id year using "$intdata/experience.dta"
keep if _m == 3
drop _m

* Define prior-score groups retained for compatibility with downstream files.
* Recreate derived score-group variables so interrupted/prior runs cannot
* leave colliding scratch variables in this shared temporary-file workflow.
capture drop D d
gen D = std_score_past >= 0.07
replace D = . if std_score_past == .

bysort district_code schoolcode: egen d = mean(D)
gen lambda = 0.2 if d >= 0 & d <= 0.4
replace lambda = 0.5 if d > 0.4 & d <= 0.6
replace lambda = 0.8 if d > 0.6 & d <= 1
tab lambda, gen(L)
capture drop Exp1 Exp2 Exp3 Exp4 Exp5 Exp6
forvalues e = 1/6 {
    gen byte Exp`e' = exp == `e' if exp < .
}

keep if grade <= 6


********************************************************************************
* Residualize Outcomes
********************************************************************************

capture log close
qui areg std_score c.std_score_past#i.grade past1* past2* c.past3* ///
    c.Mpast1* c.Mpast2* c.Mpast3* i.year i.disab_status i.el_status ///
    i.econ_disadvantage i.Sfemale i.Sblack i.Shispanic i.Sasian ///
    i.Sam_ind Mdisab_status Mel_status Mecon_disadvantage ///
    c.Mecon_disadvantage#i.econ_disadvantage MSfemale MSblack ///
    MShispanic MSasian MSam_ind Msize Exp2 Exp3 Exp4 Exp5 Exp6, ///
    a(schoolid)
scalar define Mgamma2_1 = _b[Exp2]
scalar define Mgamma3_1 = _b[Exp3]
scalar define Mgamma4_1 = _b[Exp4]
scalar define Mgamma5_1 = _b[Exp5]
scalar define Mgamma6_1 = _b[Exp6]
scalar define R2_m1 = e(r2)

* Save residuals.
predict xb, resid
gen v = xb
drop xb

keep student_key year district_code schoolcode grade v id* D


********************************************************************************
* Construct Value-Added Estimates
********************************************************************************

* Construct variance components and counts.
bysort id year: egen v_ij = mean(v)
gen dev = v - v_ij
qui sum dev
scalar define sigma_e = r(Var)
drop dev

qui sum v
scalar define Var = r(Var)

gen nr = 1

collapse v_ij (sum) nr, by(id year)
tsset id year
corr v_ij l.v_ij, cov
scalar define sigma_mu = r(cov_12)
scalar define sigma_theta = Var - sigma_e - sigma_mu

gen h_ij = 1 / (sigma_theta + (sigma_e / nr))

bysort id: egen den = sum(h_ij)

gen w = h_ij / den

bysort id: egen mu = sum(w * v_ij)
gen shrinkage = sigma_mu / (sigma_mu + (1/den))

gen v = mu * shrinkage
keep id year mu* v* nr*
sort id year
gen Mg2_1 = Mgamma2_1
gen Mg3_1 = Mgamma3_1
gen Mg4_1 = Mgamma4_1
gen Mg5_1 = Mgamma5_1
gen Mg6_1 = Mgamma6_1

gen R2_m1 = R2_m1
save "$intdata/va_nocomparativeadv_JPE.dta", replace
rm "$intdata/experience.dta"

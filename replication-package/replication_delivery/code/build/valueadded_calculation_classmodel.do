********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    valueadded_calculation_classmodel.do
* Purpose: Calculate teacher value added under the class model, which does not
*          assume equal teacher contributions within a grade-school cell.
********************************************************************************


global controls = "std_score_past disab_status el_status econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind"


********************************************************************************
* Prepare Teacher Experience File
********************************************************************************

use "$intdata/teachers_panel_nova_JPE.dta", clear
gen master = masterup
keep id year totalexp2 exp master
sort id year
tempfile experience
save `experience', replace


********************************************************************************
* Build Teacher-Overlap File
********************************************************************************

use "$intdata/va_teacherside_math_JPE.dta", clear
egen fakeid = group(district_code schoolcode grade)
tsset fakeid year

gen overlap = 0
forvalues n = 1/26 {
    forvalues m = 1/26 {
        replace overlap = overlap + 1 if id`n' == l.id`m' & id`n' != .
        replace overlap = . if l.id1 == .
    }
}

drop fakeid
keep district_code schoolcode grade year overlap
sort district_code schoolcode grade year
tempfile overlap
save `overlap', replace


********************************************************************************
* Math Value-Added Inputs
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
merge m:1 district_code schoolcode year grade using `overlap'
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

* Tag observations with one teacher.
gen oneteacher = id2 == .

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
    gen nrt = 1 / nrteachers
    save temp`x'.dta, replace
    restore
}

keep if id26 != .
reshape long id, i(fakeid) j(n)
drop fakeid
sort student_key year n
gen nrteachers = 26
gen nrt = 1 / nrteachers
save temp26.dta, replace

use temp1.dta, clear
forvalues x = 2/26 {
    append using temp`x'.dta
    rm temp`x'.dta
}
rm temp1.dta

tempfile classpanel
save `classpanel', replace
use `classpanel', clear

* Merge teacher experience.
sort id year
merge m:1 id year using `experience'
keep if _m == 3
drop _m

* Define high- and low-prior-score groups.
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
    MShispanic MSasian MSam_ind Msize if D == 0, a(schoolid)

predict xbd, xbd
gen v = std_score - xbd if D == 0
drop xbd

qui areg std_score c.std_score_past#i.grade past1* past2* c.past3* ///
    c.Mpast1* c.Mpast2* c.Mpast3* i.year i.disab_status i.el_status ///
    i.econ_disadvantage i.Sfemale i.Sblack i.Shispanic i.Sasian ///
    i.Sam_ind Mdisab_status Mel_status Mecon_disadvantage ///
    c.Mecon_disadvantage#i.econ_disadvantage MSfemale MSblack ///
    MShispanic MSasian MSam_ind Msize if D == 1, a(schoolid)

predict xbd, xbd
replace v = std_score - xbd if D == 1
drop xbd

keep student_key year v id* D nrteachers nrt Exp* master overlap


********************************************************************************
* Construct Class-Model Value-Added Estimates
********************************************************************************

* Construct variance components and counts.
bysort id year: gen v1 = v if D == 1
bysort id year: gen v0 = v if D == 0
bysort id year: egen v_ij_1 = mean(v1)
bysort id year: egen v_ij_0 = mean(v0)

egen sigma_e1 = sd(v1 - v_ij_1)
egen sigma_e0 = sd(v0 - v_ij_0)
replace sigma_e1 = sigma_e1^2
replace sigma_e0 = sigma_e0^2

gen nr1 = 1 if D == 1
gen nr0 = 1 if D == 0

collapse v_ij* sigma* (min) nrteachers nrt overlap (sum) nr1 nr0, ///
    by(id year)
tsset id year

gen Lnrteachers = l.nrteachers
corr v_ij_1 l.v_ij_1, cov
gen sigma_mu1 = nrteachers * Lnrteachers * r(cov_12) / overlap
gen sigma_mu1_old = r(cov_12) / overlap
corr v_ij_0 l.v_ij_0, cov
gen sigma_mu0 = nrteachers * Lnrteachers * r(cov_12) / overlap
gen sigma_mu0_old = r(cov_12) / overlap

bysort id: egen NR0 = sum(nr0)
bysort id: egen NR1 = sum(nr1)

gen w1 = nr1 / NR1
gen w0 = nr0 / NR0

bysort id: egen mu1 = sum(w1 * v_ij_1)
bysort id: egen mu0 = sum(w0 * v_ij_0)

* Re-work the asymptotically unbiased estimator.
bysort id: egen R1_1 = sum(w1 / nrteachers)
bysort id: egen R1_0 = sum(w0 / nrteachers)
replace R1_1 = . if w1 == .
replace R1_0 = . if w0 == .

replace mu1 = mu1 / R1_1
replace mu0 = mu0 / R1_0

bysort id: egen Wsq1_J = sum(nrt)
bysort id: egen Wsq0_J = sum(nrt)
replace Wsq1_J = . if w1 == .
replace Wsq0_J = . if w0 == .

gen var1_calc = sigma_mu1 * Wsq1_J + sigma_e1 / (NR1 * R1_1)
gen var0_calc = sigma_mu0 * Wsq0_J + sigma_e0 / (NR0 * R1_0)

gen shrinkage1 = sigma_mu1 / var1_calc
gen shrinkage0 = sigma_mu0 / var0_calc

gen v1 = mu1 * shrinkage1
gen v0 = mu0 * shrinkage0

keep id year mu* v* *nr* shr* sigma_mu* sigma_e* overlap R* Wsq* NR*
save "$intdata/va_classmodel_JPE.dta", replace


********************************************************************************
* Compare Class Model with Aggregate Model
********************************************************************************


    rename v1 v1_class
    rename v0 v0_class
    rename mu1 mu1_class
    rename mu0 mu0_class

    gen c1_class = v1_class
    gen c0_class = v0_class
    sort id year
    merge 1:1 id year using "$intdata/va_highlow_math_expdisc_JPE.dta"
    drop _m
    merge 1:1 id year using `experience'
    drop _m

    preserve
    gsort id -year
    bysort id: carryforward c1_class c0_class, replace
    //keep if year == 2010
    log using "$out/tables/Table_B4.log", replace
	bysort exp: corr v0 c0_class
    bysort exp: corr v1 c1_class
	log close
    restore

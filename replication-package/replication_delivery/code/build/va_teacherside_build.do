********************************************************************************
* Teachers in Wisconsin
* File:    va_teacherside_build.do
* Purpose: Create the teacher-side roster used in value-added estimation.
* Creates: va_teacherside_math_JPE.dta
********************************************************************************

use "$intdata/teachers_new_JPE.dta", clear
drop if schoolcode == .
keep if mathematics == 1 | all_elem == 1
keep id schoolcode district_code year highgrade lowgrade
drop if district_code == .

* Standardize grade variables before expanding teacher-grade records.
foreach var in lowgrade highgrade {
	replace `var' = "-3" if `var' == "K3"
	replace `var' = "-4" if `var' == "K4"
	replace `var' = "-1" if `var' == "PK"
	replace `var' = "0"  if `var' == "KG"
	destring `var', replace
}

gen ok = lowgrade == highgrade
drop if ok == 1 & (lowgrade < 3 | lowgrade > 8)
drop if highgrade < 3 | lowgrade > 8

* Expand teachers who span multiple grades into teacher-grade records.
gen grade1 = lowgrade
gen grade2 = highgrade
egen fakeid = group(id year)
reshape long grade, i(fakeid) j(n)
drop n
duplicates drop
tsset fakeid grade
tsfill, full
gsort fakeid -grade
bysort fakeid: carryforward id year schoolcode district_code highgrade ///
	lowgrade, replace
bysort fakeid (grade): carryforward id year schoolcode district_code highgrade ///
	lowgrade, replace
gen tag = 1 if (lowgrade <= grade & highgrade >= grade)
drop if tag == .
drop if grade < 3 | grade > 8
drop tag ok lowgrade highgrade fakeid
sort district_code schoolcode year grade

* Reshape to one school-grade-year observation with teacher IDs in wide form.
egen fakeid = group(district_code schoolcode year grade)
bysort fakeid: gen n = _n
reshape wide id, i(fakeid) j(n)
drop fakeid
sort district_code schoolcode year grade
gen post = year > 2011

save "$intdata/va_teacherside_math_JPE.dta", replace

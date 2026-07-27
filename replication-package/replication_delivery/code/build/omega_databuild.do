********************************************************************************
* Teachers in Wisconsin
* File:    omega_databuild.do
* Purpose: Build district-level data for the analysis of omega choices.
* Creates: omega_analysis_data_JPE.dta
********************************************************************************


********************************************************************************
* Demographic and Economic Characteristics
********************************************************************************

* Crosswalk state id-census id
insheet using "$raw/crosswalk_census_state_id.csv", clear names
replace district_code = substr(district_code,4,4)
destring district_code, replace
keep district_code id
local new = _N + 2
set obs `new'
local z = _N
replace district_code = 4998 in `z'
replace id = 5513200 in `z'
local z = _N - 1
replace district_code = 3913 in `z'
replace id = 5510410 in `z'
rename id censusid
sort censusid
tempfile id
save `id', replace

* Income.
insheet using ///
	"$raw/nces_acs_2013-2017/EDGE_Export_101244429626/DP03.6_001_USSchoolDistrictAll_101244423682.txt", ///
	names clear delimiter("|")
keep if leaid > 5500000 & leaid < 5600000
keep leaid dp036_62est dp036_63est dp036_61pct
rename dp036_62est medianinc
rename dp036_63est meaninc
rename dp036_61pct share_inc_above_200k
rename leaid censusid
destring *, replace
drop if censusid == 5599999
sort censusid
merge 1:1 censusid using `id'
keep if _m == 3
drop _m
sort censusid
tempfile income
save `income', replace

* Poverty.
insheet using ///
	"$raw/nces_acs_2013-2017/EDGE_Export_101244639981/DP03.8_001_USSchoolDistrictAll_101244637329.txt", ///
	names clear delimiter("|")
keep if leaid > 5500000 & leaid < 5600000
keep leaid dp038_119pct
rename dp038_119pct share_poverty
rename leaid censusid
destring *, replace
drop if censusid == 5599999
sort censusid
merge 1:1 censusid using `income'
keep if _m == 3
drop _m
sort censusid
tempfile income
save `income', replace

* Education.
insheet using ///
	"$raw/nces_acs_2013-2017/EDGE_Export_1012447445/DP02.7_001_USSchoolDistrictAll_101244740697.txt", ///
	names clear delimiter("|")
keep if leaid > 5500000 & leaid < 5600000
keep leaid dp027_61pct dp027_67pct
rename dp027_61pct highschool
rename dp027_67pct ba_or_higher
rename leaid censusid
destring *, replace
drop if censusid == 5599999
sort censusid
merge 1:1 censusid using `income'
keep if _m == 3
drop _m
sort censusid
tempfile income
save `income', replace

* Age.
insheet using ///
	"$raw/nces_acs_2013-2017/EDGE_Export_101253245819/DP05.1_001_USSchoolDistrictAll_101253240998.txt", ///
	names clear delimiter("|")
keep if leaid > 5500000 & leaid < 5600000
keep leaid dp051_5pct dp051_6pct dp051_7pct dp051_8pct dp051_9pct ///
	dp051_10pct dp051_11pct dp051_12pct dp051_13pct dp051_14pct ///
	dp051_15pct dp051_16pct dp051_17pct
destring *, replace
gen sharepop_below15 = dp051_5pct + dp051_6pct + dp051_7pct
gen sharepop_15_24 = dp051_8pct + dp051_9
gen sharepop_25_64 = dp051_10pct + dp051_11pc + dp051_12pc + ///
	dp051_13pc + dp051_14pc
gen sharepop_above64 = dp051_15pct + dp051_16pc + dp051_17pc
drop dp*
rename leaid censusid
drop if censusid == 5599999
sort censusid
merge 1:1 censusid using `income'
keep if _m == 3
drop _m
sort censusid
tempfile income
save `income', replace


********************************************************************************
* Elections
********************************************************************************

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

sort district_code
merge 1:1 district_code using `income'
drop _m
sort district_code
save `income', replace


********************************************************************************
* Characteristics of Teachers Districts Would Like to Hire
********************************************************************************

preserve
use "$est/incumbent.dta",clear
reshape long Inc, i(id) j(District)
tempfile inc
save `inc', replace

use $est/matched_movers.dta, clear
keep id District exp d
duplicates drop
sort id District
merge 1:1 id District using `inc'
keep if _m == 3
drop _m
drop if Inc == 1 & exp >2
rename District district_code
keep id district_code d
sort id
merge m:1 id using "$est/experience.dta"
drop _m
sort id
merge m:1 id using "$est/contributions.dta"
drop _m
gen c = (xb0 + V0) * d + (xb1 + V1) * (1 - d)
drop d
gen ratio = c / totalexp2
collapse ratio totalexp2 c (p50) median_exp = totalexp2 ///
	(p10) exp_10pct = totalexp2 (p10) c_10pct = c, by(district_code)
rename * attr_*
rename attr_d* d*
tempfile attract
save `attract', replace
restore


********************************************************************************
* Contributions of Hired Teachers
********************************************************************************

preserve
use "$est/match.dta",clear
reshape long Match, i(id) j(district_code)
keep if Match == 1
drop Match
tempfile match
sort id
save `match', replace

use "$est/lambda.dta",clear
reshape long d, i(n) j(district_code)
drop n
tempfile lambda
sort district_code
save `lambda', replace

use "$est/contributions.dta", clear
sort id
merge 1:1 id using `match'
drop _m
sort district_code
merge m:1 district_code using `lambda'
drop _m
gen tc_hired = (xb0 + V0) * d + (xb1 + V1) * (1 - d)
collapse tc_hired, by(district_code)
tempfile hired
save `hired', replace
restore


********************************************************************************
* Additional Student Characteristics
********************************************************************************

preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
gen d = std_score <= 0.07 & std_score != .
gen Nr_students = 1
keep if year == 2014
collapse d econ_disadvantage (sum) Nr_students, by(district_code)
replace d = d * 100
replace econ_disadvantage = econ_disadvantage * 100
tempfile stud
sort district_code
save `stud', replace
restore


********************************************************************************
* Variables from Original Model
********************************************************************************

use $est/multinomial.dta, clear

* Generate variables used in district-level summaries.
g tenured = Exp1 == 0 & Exp2 == 0
g tc = C0d + C1d
g tc_tenured = tc * tenured
gen milwaukee = District == 3619

* Add Cooperative Educational Service Agency-style commuting-zone identifiers.
preserve
use "$raw/district_county_cz.dta", clear
keep district_code cz
rename district District
sort D
save cz.dta, replace
restore

sort District
merge m:1 District using cz.dta
sum cz if District == 2525
replace cz = r(mean) if _m == 1
drop if _m == 2
drop _m
rm cz.dta

gen czm = cz if Inc == 1 & Exp1 == 0
bysort id: egen czmatch = max(czm)
drop czm
gen otherincz = Inc == 0 & czmatch == cz & Exp1 == 0

preserve
keep if otherincz == 1
gen nr = 1
collapse Exp* tc* tenured d (sum) nr, by(District)
rename * CZ_*
rename CZ_District District
sort District
save othercz.dta, replace
restore

* Contributions.
gen C0 = V0 + xb0
gen C1 = V1 + xb1

* Summarize characteristics of each district's incumbent teachers.
tempvar X
bysort District: egen `X' = sd(tc) if Exp1 == 0 & Inc == 1
bysort District: egen tc_sd = max(`X')
replace tc_sd = 0 if tc_sd == .

foreach var in tenured tc_tenured tc  master Exp1 Exp2 Exp3 Exp4 Exp5 Exp6 C0 ///
	C1  wage {
	tempvar X
	tempvar Y
	bysort District: egen `X' = mean(`var') if Inc == 1
	bysort District: egen `Y' = max(`X')
	replace `var' = `Y'
	replace `var' = 0 if `var' == .
}

keep Exp* tenured tc* master *alpha* capacity budget milwaukee urban suburban ///
	d cz District wage C0 C1
duplicates drop

* Merge in characteristics of other teachers in the same zone.
sort District
merge 1:1 District using othercz.dta
drop _m
rm othercz.dta

* Calculate leave-one-out zone characteristics.
gen budget_pc = budget / (capacity)
preserve
keep urban suburban budget_pc d capacity District cz
foreach var in urban suburban budget_pc d capacity {
	gen CZc_`var' = .
	qui levelsof District, local(D)
	foreach d of local D {
		qui sum cz if District == `d'
		local cz = `r(mean)'
		qui sum `var' if cz == `cz' & District != `d'
		replace CZc_`var' = `r(mean)' if cz == `cz' & District == `d'
	}
	drop `var'
}
sort District
save cz.dta, replace
restore

sort cz
merge m:1 District using cz.dta
drop _m
rm cz.dta

* Add own wage schedule measures.
rename District district_code
sort district_code
merge 1:1 district using "$intdata/schedule_new_JPE.dta"
drop _m


********************************************************************************
* Final Assembly
********************************************************************************

replace CZ_nr = CZ_nr / capacity
bysort cz: gen CZ_nd = _N - 1
sort district_code
tempfile main
save `main', replace

use `income', clear
sort district_code
merge 1:1 district_code using `main'
drop if _m == 1
drop _m
sort district_code
merge 1:1 district_code using `attract'
drop _m
sort district_code
merge 1:1 district_code using `hired'
drop _m
sort district_code
merge 1:1 district_code using `stud'
drop _m
replace attr_c = 0 if attr_c == .
replace attr_totalexp = 0 if attr_totalexp == .

drop if budget == .

save "$intdata/omega_analysis_data_JPE.dta", replace

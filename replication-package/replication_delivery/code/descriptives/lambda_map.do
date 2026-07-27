********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    lambda_map.do
* Purpose: Generates map of lambda across districts.
********************************************************************************

* Prepare map files
cd "$raw/district_shapefiles"
spshape2dta "WI_School_Districts.shp", replace

* Get lambda for missing districts
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
drop if district_code >= 8000
gen d_ = std_score <= 0.07 & std_score != .
replace d_ = . if std_score == .
keep if year == 2010
collapse d_, by(district_code) 
sort district_code
tempfile lambda
save `lambda', replace

* Save lambda
use "$est/lambda.dta", replace
reshape long d, i(n) j(district_code)
keep district_code d
sort district_code
merge 1:1 district_code using `lambda'
replace d = d_ if d == .
drop d_
gen SDID = string(district_code,"%04.0f")

* adjustments to have old map match to new (accounts for district consolidation over time)
replace SDID = "2525" if SDID == "3913"
replace SDID = "2525" if SDID == "4998"
replace SDID = "2570" if SDID == "4820"
replace SDID = "2570" if SDID == "4843"

collapse d, by(SDID)

sort SDID
merge m:1 SDID using "WI_School_Districts.dta"
tempfile lambda
save `lambda', replace

* D quintiles
xtile dq = d, n(4)
tab dq
replace d = 0 if d == . 

spmap d using  "WI_School_Districts_shp.dta", id(_ID) clm(quantile) cln(4) fcolor(Blues) ndfc(gs8) ndl(none) legl("No data" "Q1" "Q2" "Q3" "Q4")
graph export "$out/figures/Figure_B10.png", replace


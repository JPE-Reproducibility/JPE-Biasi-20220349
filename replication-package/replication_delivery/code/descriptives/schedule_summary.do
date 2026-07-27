********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    schedule_summary.do
* Purpose: Summarize wage schedules pre-reform.
********************************************************************************

********************************************************************************
* Pre-Act 10 Wage Data
********************************************************************************

preserve
use "$est/lambda.dta", replace
reshape long d, i(n) j(district_code)
drop n d
tempfile list
save `list', replace
restore

use  "$intdata/schedule_new_JPE.dta", clear
sort district_code
merge 1:1 district_code using `list', keep(3) nogen

forvalues exp = 2/6{
	gen D`exp'_ba = CExp`exp'_ba - CExp1_ba
}

forvalues exp = 2/6{
	gen D`exp'_ma = CExp`exp'_ma - CExp`exp'_ba
}
egen Dexp_ma = rowmean(D*_ma)

label var CExp1_ba "\delta^0"
label var D2_ba "\delta^e [1,2]"
label var D2_ba "\delta^e [3,4]"
label var D2_ba "\delta^e [5,9]"
label var D2_ba "\delta^e [10,14]"
label var D2_ba "\delta^e >=15"
label var Dexp_ma "\delta^m(MA)"


capture log close
log using "$out/tables/Table_B9.log", replace
foreach v in CExp1_ba D2_ba D4_ba D5_ba D6_ba Dexp_ma {
    display "Variable: `: var label `v''"
    summarize `v'
}
log close

********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    aux_model_teachers_wages.do
* Purpose: Estimate auxiliary teacher-choice and wage-function models.
********************************************************************************

set more off


********************************************************************************
* Auxiliary Teacher Model: Full Choice Set
********************************************************************************

use $est/multinomial.dta, clear

********************************************************************************
* Omega Support Shares
********************************************************************************

* Share of districts at each support point of omega1 / alpha0.
preserve
keep District alpha0_
duplicates drop
quietly count
local ndistricts = r(N)
collapse (count) n = District, by(alpha0_)
tempfile omega1_observed
save `omega1_observed', replace
clear
input alpha0_
.9
.95
1
1.05
1.1
end
merge 1:1 alpha0_ using `omega1_observed', keep(master match) nogen
replace n = 0 if n == .
gen share = n / `ndistricts'
gen var = share * (1 - share) * `ndistricts' / (`ndistricts' - 1)
outsheet share using "$est/omega1_share.csv", replace nonames
outsheet var using "$est/omega1_var.csv", replace nonames
restore

* Share of districts at each support point of omega2 / alpha1.
preserve
keep District alpha1_
duplicates drop
quietly count
local ndistricts = r(N)
collapse (count) n = District, by(alpha1_)
tempfile omega2_observed
save `omega2_observed', replace
clear
input alpha1_
0
10
30
50
75
100
200
end
merge 1:1 alpha1_ using `omega2_observed', keep(master match) nogen
replace n = 0 if n == .
gen share = n / `ndistricts'
gen var = share * (1 - share) * `ndistricts' / (`ndistricts' - 1)
outsheet share using "$est/omega2_share.csv", replace nonames
outsheet var using "$est/omega2_var.csv", replace nonames
restore

* Winsorize wage.
replace wage = 86.731818 if wage > 86.731818
replace wage = 28.777456 if wage < 28.777456

* Merge in district-to-district distances.
preserve
use "$raw/district_distance_sdid.dta", clear
destring d1, replace
destring d2, replace
sort d1 d2
tempfile temp
save `temp', replace
restore

gen d1 = District if Inc == 1
gen d2 = District
tempvar d1
bysort id: egen `d1' = max(d1)
drop d1
gen d1 = `d1'

* Check that all districts are covered.
preserve
keep d2
duplicates drop
merge 1:m d2 using `temp'
tab d2 if _m == 1
restore

sort d1 d2
merge m:1 d1 d2 using `temp'
drop if _m == 2
drop _m
replace distance = 0 if distance == .

* Merge in Wisconsin area identifiers.
rename d2 district_code
sort district_code
merge m:1 district_code using "$raw/cesa.dta"
drop if _m == 2
drop _m
replace cesa = 6 if cesa == . // this should only be district_code = 2570

* Merge in other variables.
drop v0 v1
duplicates drop
sort id District
merge 1:1 id District using $est/multinomial.dta
keep if _m == 3
drop _m

capt drop Exp*
gen lamsq = d^2
gen explam = exp(d)

gen D0 = (1 - entr) * (1 - Inc)
gen D0_exp = D0 * totalexp2
gen CZ = (1 - entr) * (1 - samecz)
gen milw = District == 3619
gen Exp1 = totalexp2 < 2
gen Exp2 = totalexp2 == 2 | totalexp2 == 3
gen Exp3 = totalexp2 == 4 | totalexp2 == 5
gen Exp4 = totalexp2 >= 6 & totalexp2 <= 10
gen Exp5 = totalexp2 >= 11 & totalexp2 <= 15
gen Exp6 = totalexp2 > 15

gen lndist = ln(distance)
replace lndist = 0 if lndist == .
gen nont = totalexp2 <= 3
gen D0_nont = D0 * nont
gen D0_mid1 = D0 * Exp3
gen D0_mid2 = D0 * Exp4
gen D0_mid3 = D0 * Exp5

eststo r1: xtreg Match wage explam C0d D0 D0_nont D0_mid1 D0_mid2 ///
    D0_mid3 CZ urban suburban lndist milw, fe rob

* Save coefficients.
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaT1_JPE.csv", replace nonames
restore

* Save variances.
matrix B = vecdiag(e(V))'
preserve
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaT1_var_JPE.csv", replace nonames
restore


********************************************************************************
* Auxiliary Teacher Model: Restricted Choice Set
********************************************************************************
use $est/multinomial.dta, clear

* Merge in district-to-district distances.
preserve
use "$raw/district_distance_sdid.dta", clear
destring d1, replace
destring d2, replace
sort d1 d2
tempfile temp
save `temp', replace
restore

* Merge in Wisconsin area identifiers.
rename District district_code
sort district_code
merge m:1 district_code using "$raw/cesa.dta"
drop if _m == 2
drop _m
replace cesa = 6 if cesa == . // this should only be district_code = 2570
rename district_code District

gen d1 = District if Inc == 1
gen d2 = District
tempvar d1
bysort id: egen `d1' = max(d1)
drop d1
gen d1 = `d1'

* Check that all districts are covered.
preserve
keep d2
duplicates drop
merge 1:m d2 using `temp'
tab d2 if _m == 1
restore

sort d1 d2
merge m:1 d1 d2 using `temp'
drop if _m == 2
drop _m
replace distance = 0 if distance == .
sort id District
tempfile multinomial
save `multinomial', replace

use $est/matched_movers.dta, clear

* Winsorize wage.
replace wage = 86.731818 if wage > 86.731818
replace wage = 28.777456 if wage < 28.777456

* Merge in other variables.
drop v0 v1 wage
duplicates drop
sort id District
merge 1:1 id District using `multinomial'
keep if _m == 3
drop _m

* Winsorize wage.
replace wage = 86.731818 if wage > 86.731818
replace wage = 28.777456 if wage < 28.777456

capt drop Exp*
gen lamsq = d^2
gen explam = exp(d)

gen D0 = (1 - entr) * (1 - Inc)
gen D0_exp = D0 * totalexp2
gen CZ = (1 - entr) * (1 - samecz)
gen milw = District == 3619
gen Exp1 = totalexp2 < 2
gen Exp2 = totalexp2 == 2 | totalexp2 == 3
gen Exp3 = totalexp2 == 4 | totalexp2 == 5
gen Exp4 = totalexp2 >= 6 & totalexp2 <= 10
gen Exp5 = totalexp2 >= 11 & totalexp2 <= 15
gen Exp6 = totalexp2 > 15

gen lndist = ln(distance)
replace lndist = 0 if lndist == .
gen nont = totalexp2 <= 3
gen D0_nont = D0 * nont
gen D0_mid1 = D0 * Exp3
gen D0_mid2 = D0 * Exp4
gen D0_mid3 = D0 * Exp5

eststo r2: xtreg Match wage explam C0d D0 D0_nont D0_mid1 D0_mid2 ///
    D0_mid3 CZ urban suburban lndist milw, fe rob

* Save coefficients.
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaT2_JPE.csv", replace nonames
restore

* Save variances.
matrix B = vecdiag(e(V))'
preserve
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaT2_var_JPE.csv", replace nonames
restore

capture log close
log using "$out/tables/Table_2.log", replace
esttab r1 r2, b(4) se(4) nostar
log close


********************************************************************************
* Auxiliary Wage-Function Model
********************************************************************************

use "$intdata/omega_analysis_data_JPE.dta", clear
gen budget_pp = budget / capacity

reg alpha0_ Exp3 Exp4 Exp5 Exp6 masterup d tc tc_tenured budget_pp capacity ///
    urban suburban milwaukee CZ_tc CZ_tenured democratic, rob

* Save coefficients.
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/omega1_JPE.csv", replace nonames
restore

* Save variances.
matrix B = vecdiag(e(V))'
preserve
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/omega1_var_JPE.csv", replace nonames
restore

reg alpha1_ Exp3 Exp4 Exp5 Exp6 masterup d tc tc_tenured budget_pp capacity ///
    urban suburban milwaukee CZ_tc CZ_tenured democratic, rob

* Save coefficients.
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/omega2_JPE.csv", replace nonames
restore

* Save variances.
matrix B = vecdiag(e(V))'
preserve
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/omega2_var_JPE.csv", replace nonames
restore

* Alpha1/alpha2 moments consumed by the model estimation code. Keep the legacy
* row ordering and definitions from the original auxiliary wage script.
tempvar wage_aux_sample
gen `wage_aux_sample' = e(sample)

preserve
keep if `wage_aux_sample'
gen alpha0sq = alpha0_^2
gen alpha1sq = alpha1_^2
gen a12 = alpha0_ * alpha1_
gen a12sq = a12^2

qui sum alpha0_
local a0 = r(mean)
local Va0 = r(Var)
qui sum alpha1_
local a1 = r(mean)
local Va1 = r(Var)
qui sum a12
local a01 = r(mean)
local Va01 = r(mean)
qui sum alpha0sq
local a0sq = r(mean)
local Va0sq = r(Var)
qui sum alpha1sq
local a1sq = r(mean)
local Va1sq = r(Var)
qui sum a12sq
local a01sq = r(mean)
local Va01sq = r(Var)

clear
set obs 10
gen mean = .
replace mean = `a0' if _n == 1
replace mean = `a1' if _n == 2
replace mean = `a01' if _n == 3
replace mean = `a0sq' if _n == 4
replace mean = `a1sq' if _n == 5
replace mean = `Va0' if _n == 6
replace mean = `Va1' if _n == 7
replace mean = `Va01' if _n == 8
replace mean = `Va0sq' if _n == 9
replace mean = `Va1sq' if _n == 10
outsheet using "$est/alpha12_moments.csv", replace nonames
restore

preserve
keep if `wage_aux_sample'
gen I = alpha0_ == 1 & alpha1_ == 0
qui sum I, det
local share = r(mean)
local varshare = r(sd)^2

clear
set obs 2
gen mean = .
replace mean = `share' if _n == 1
replace mean = `varshare' if _n == 2
outsheet using "$est/omegas_1_0.csv", replace nonames
restore

* Other moments.
gen alpha0_dem = alpha0_ * democratic
gen alpha1_dem = alpha1_ * democratic
sum alpha0_dem
local alpha0_dem = `r(mean)'
sum alpha0_dem
local alpha0_demV = `r(sd)'
sum alpha1_dem
local alpha1_dem = `r(mean)'
sum alpha1_dem
local alpha1_demV = `r(sd)'
sum democratic, det
sum alpha0_ if democratic >= r(p50)
local alpha0_highdem = `r(mean)'
sum democratic, det
sum alpha0_ if democratic >= r(p50)
local alpha0_highdemV = `r(sd)'
sum democratic, det
sum alpha1_ if democratic >= r(p50)
local alpha1_highdem = `r(mean)'
sum democratic, det
sum alpha1_ if democratic >= r(p50)
local alpha1_highdemV = `r(sd)'

preserve
clear
set obs 4
gen name = ""
replace name = "E(omega1*dem)" in 1
replace name = "E(omega2*dem)" in 2
replace name = "E(omega1|dem>=median)" in 3
replace name = "E(omega2|dem>=median)" in 4
gen mean = .
replace mean = `alpha0_dem' in 1
replace mean = `alpha1_dem' in 2
replace mean = `alpha0_highdem' in 3
replace mean = `alpha1_highdem' in 4
gen variance = .
replace variance = `alpha0_demV'^2 in 1
replace variance = `alpha1_demV'^2 in 2
replace variance = `alpha0_highdemV'^2 in 3
replace variance = `alpha1_highdemV'^2 in 4
outsheet using "$est/omega_moments_JPE.csv", replace
restore

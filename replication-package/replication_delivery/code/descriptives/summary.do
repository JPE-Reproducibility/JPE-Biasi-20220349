********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    summary.do
* Purpose: Produce descriptive summary statistics for teachers and districts.
********************************************************************************


********************************************************************************
* Teacher Summary Statistics (Table 1, panel A)
********************************************************************************

capt log close
log using "$out/tables/Table_1A.log", replace
* Experience.
use "$est/experiencecont.dta", clear
sum totalexp2
sum totalexp2 if totalexp < 3
sum totalexp2 if totalexp >= 10

egen tag = tag(id)
count if totalexp2 < 3 & tag == 1
count if totalexp >= 10

* Master's degree.
use "$est/master.dta", clear
sort id
merge 1:1 id using "$est/experiencecont.dta"
drop _m
sum master
sum master if totalexp < 3
sum master if totalexp >= 10

* Teacher contributions.
use "$est/contributions.dta", clear
sort id
merge 1:1 id using "$est/experiencecont.dta"
drop _m
merge 1:1 id using "$est/master.dta"
drop _m
gen c0 = xb0 + v0
gen c1 = xb1 + v1
sum c0 c1
sum c0 c1 if totalexp < 3
sum c0 c1 if totalexp >= 10
corr c0 c1
log close

********************************************************************************
* District Summary Statistics (Table 1, panel B)
********************************************************************************

capt log close
log using "$out/tables/Table_1B.log", replace
preserve
use "$est/lambda.dta", clear
reshape long d, i(n) j(district)
sort district
save temp.dta, replace
restore

* Urban districts.
use "$est/urban.dta", clear
reshape long urban, i(n) j(district)
su urban
sort di
merge 1:1 di using temp.dta
drop _m
su urban
qui sum d, det
su urban if d <= `r(p25)'
qui sum d, det
su urban if d > `r(p75)'

* Suburban districts.
use "$est/suburban.dta", clear
reshape long suburban, i(n) j(district)
su suburban
sort di
merge 1:1 di using temp.dta
drop _m
su suburban
qui sum d, det
su suburban if d <= `r(p25)'
qui sum d, det
su suburban if d > `r(p75)'
su d, det
su d if d <= `r(p25)'
su d, det
su d if d > `r(p75)'

* Average teacher experience by incumbent district.
use "$est/experiencecont.dta", clear
sort id
merge 1:1 id using "$est/incumbent.dta"
gen DD = .
foreach v of varlist Inc* {
    local n = substr("`v'",4,4)
    replace DD = `n' if `v' == 1
}
drop Inc*
collapse totalexp2, by(DD)
su totalexp2
rename DD district
sort di
merge 1:1 di using temp.dta
drop _m
su totalexp2
qui su d, det
su totalexp2 if d <= `r(p25)'
qui su d, det
su totalexp2 if d > `r(p75)'

* Master's degree by incumbent district.
use "$est/master.dta", clear
sort id
merge 1:1 id using "$est/incumbent.dta"
gen DD = .
foreach v of varlist Inc* {
    local n = substr("`v'",4,4)
    replace DD = `n' if `v' == 1
}
drop Inc*
collapse master, by(DD)
su master
rename DD district
sort di
merge 1:1 di using temp.dta
drop _m
su master
qui su d, det
su master if d <= `r(p25)'
qui su d, det
su master if d > `r(p75)'

* Teacher contributions by incumbent district.
use "$est/contributions.dta", clear
gen c0 = xb0 + v0
gen c1 = xb1 + v1
sort id
merge 1:1 id using "$est/incumbent.dta"
gen DD = .
foreach v of varlist Inc* {
    local n = substr("`v'",4,4)
    replace DD = `n' if `v' == 1
}
drop Inc*
collapse c0 c1, by(DD)
su c0 c1
rename DD district
sort di
merge 1:1 di using temp.dta
drop _m
su c0 c1
qui su d, det
su c0 c1 if d <= `r(p25)'
qui su d, det
su c0 c1 if d > `r(p75)'
qui su d, det
count if d <= `r(p25)'
qui su d, det
count if d > `r(p75)'

* District budgets.
use "$est/budget.dta", clear
reshape long budget capacity, i(n) j(district)
su budget
gen budget_pc = budget/cap
su budget_pc
su capacity
sort di
merge 1:1 di using temp.dta
drop _m
su budget_pc capacity
qui sum d, det
su budget_pc capacity if d <= `r(p25)'
qui sum d, det
su budget_pc capacity if d > `r(p75)'
log close

********************************************************************************
* Summary Statistics for District Wage Schedules (Table 3)
********************************************************************************

* Merge district characteristics.
use "$est/contributions.dta", clear
gen c0 = xb0 + v0
gen c1 = xb1 + v1
sort id
merge 1:1 id using "$est/experiencecont.dta"
drop _m
merge 1:1 id using "$est/master.dta"
drop _m
merge 1:1 id using "$est/incumbent.dta"
gen DD = .
foreach v of varlist Inc* {
    local n = substr("`v'",4,4)
    replace DD = `n' if `v' == 1
}
drop Inc*
collapse c0 c1 totalexp master, by(DD)
su c0 c1
rename DD district
sort district
save temp2.dta, replace

use "$est/urban.dta", clear
reshape long urban, i(n) j(district)
sort district
merge 1:1 district using temp2.dta
drop _m
sort district
save temp2.dta, replace

use "$est/suburban.dta", clear
reshape long suburban, i(n) j(district)
sort district
merge 1:1 district using temp2.dta
drop _m
sort district
save temp2.dta, replace

use "$est/lambda.dta", clear
reshape long d, i(n) j(district)
sort district
merge 1:1 district using temp2.dta
drop _m
sort district
save temp2.dta, replace

use "$est/budget.dta", clear
reshape long budget capacity, i(n) j(district)
gen budget_pc = budget/capacity
sort district
merge 1:1 district using temp2.dta
drop _m
sort district
save temp2.dta, replace

* Number of other districts in the same commuting zone.
use "$raw/district_county_cz.dta", clear
rename district district
keep district cz
duplicates drop
bysort cz: gen Nrd_samecz = _N - 1
sort district
merge 1:1 district using temp2.dta
sum cz if district == 2525
replace cz = r(mean) if _m == 2
sum Nrd_samecz if district == 2525
replace Nrd_samecz = r(mean) if _m == 2
keep if _m != 1
drop _m
drop if district == .
sort district
save temp2.dta, replace

* Average contributions for teachers in the same commuting zone.
use "$est/contributions.dta", clear
gen c0 = xb0 + v0
gen c1 = xb1 + v1
sort id
merge 1:1 id using "$est/incumbent.dta"
drop _m
gen district = .
foreach v of varlist Inc* {
    local n = substr("`v'",4,4)
    replace district = `n' if `v' == 1
}
drop Inc*
sort district
rename dist district_code
merge m:1 district using "$raw/district_county_cz.dta"
sum cz if district == 2525
replace cz = r(mean) if _m == 1
drop if _m == 2
drop _m county_id state_code state_code_cnty year
rename district_code district
qui levelsof district, local(Dist)
gen c0_cz = .
gen c1_cz = .
foreach d of local Dist {
    qui sum cz if district == `d'
    sum c0 if district != `d' & cz == `r(mean)'
    replace c0_cz = `r(mean)' if district == `d'
    qui sum cz if district == `d'
    sum c1 if district != `d' & cz == `r(mean)'
    replace c1_cz = `r(mean)' if district == `d'
}
keep district c0_ c1_
duplicates drop
sort district
merge 1:1 district using temp2.dta
drop _m
sort district
save temp2.dta, replace

* Wage-schedule parameters.
use "$est/alphagrid.dta", clear
sort n
reshape long alpha0_ alpha1_, i(n) j(district)
sort district
merge 1:1 district using temp2.dta
drop _m
sort district
save temp2.dta, replace

gen Alpha1 = alpha1_ > 0
qui sum d, det
gen dlow = d <= `r(p25)'
qui sum d, det
gen dhigh = d >= `r(p75)'
qui sum d, det
gen dmed = d > `r(p50)'
qui sum capacity, det
gen capmed = capacity > `r(p50)'
qui sum budget_pc, det
gen budmed = budget_pc > `r(p50)'
gen rural = urban == 0 & suburban == 0
drop if district == .

* Table 3, panel A.
capt log close
log using "$out/tables/Table_3A.log", replace
su alpha0_ alpha1_
corr alpha0_ alpha1_
gen alpha10 = alpha0_ == 1 & alpha1_ == 0
su alpha10
su Alpha1
log close

* Table 3, panel C.
capt log close
log using "$out/tables/Table_3C.log", replace
estpost tabstat rural dmed budget_pc if alpha1_ != ., by(Alpha1)
estpost ttest rural dmed budget_pc if alpha1_ != ., by(Alpha1)
log close

* Table 3, panel B
capt log close
log using "$out/tables/Table_3B.log", replace
use "$est/multinomial.dta", clear
keep if Match == 1

sum wage
sum wage if Exp1 == 1 | Exp2 == 1
sum wage if Exp3 == 1
sum wage if Exp4 == 1
sum wage if Exp5 == 1 | Exp6 == 1
log close

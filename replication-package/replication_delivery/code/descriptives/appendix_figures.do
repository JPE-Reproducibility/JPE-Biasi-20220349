********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    appendix_figures.do
* Purpose: Produce Appendix B descriptive figures.
********************************************************************************



********************************************************************************
* Teacher Characteristics
********************************************************************************

use "$intdata/teachers_panel_JPE.dta", clear
drop if year == 2010 & district_code == 2793

* Merge school-level low-achievement shares.
preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
gen d = std_score <= 0.07 & std_score != .
keep if year == 2011 | std_score == 2010 | std_score == 2009
collapse d, by(district_code)
sort district_code
save temp.dta, replace
restore

sort district_code
merge m:1 district_code using temp.dta
drop if _m == 2
drop _m
rm temp.dta

gen d_ = 1-d

* Construct lambda groups.
_pctile d, n(100)
local a = r(r50)
qui sum d if d <= `a', det
gen lambda = r(p50) if d >= 0 & d <= `a'
qui sum d if d > `a', det
replace lambda = r(p50) if d > `a'
replace lambda = . if d == .

qui tab exp, gen(Exp)

gen xb0 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)
gen xb1 = (g2_2 * Exp2) + (g3_2 * Exp3) + (g4_2 * Exp4) + ///
    (g5_2 * Exp5) + (g6_2 * Exp6)

* Resolve prior-district variables.
gen Dpast = district_past2009
replace Dpast = district_past2008 if (district_past2009 == .) & ///
    district_past2012 != .
replace Dpast = 0 if Dpast == .

* Keep teachers with relevant contributions.
keep if v0 != . & v1 !=.  & d != .

* Construct the teacher sample used for appendix figures.
keep id district_code Dpast v0 v1 xb0 xb1 d exp masterup salary_round type ///
    totalexp year schoolcode
qui reg id district_code Dpast v0 v1 xb0 xb1 d exp masterup salary_round ///
    type totalexp year
keep if e(sample)

* Check the number of districts in the sample.
qui tab district_code if year == 2010
disp "Nr districts ="
disp r(r)

* Tag districts in this sample.
preserve
keep if year == 2010
keep district_code
duplicates drop
sort district_code
save tag.dta, replace
restore

* Prepare the horizontal wage schedule.
preserve
use "$intdata/schedule_new_JPE.dta", clear
forvalues n = 1/6 {
    foreach t in ba ma {
        replace CExp`n'_`t' = CExp`n'_`t' / 1000
    }
}
sort district_code
merge 1:1 district_code using tag.dta
keep if _m == 3
drop _m
sort district_code
rename *_ba *_0
rename *_ma *_1
sort district_code
reshape long CExp1_ CExp2_ CExp3_ CExp4_ CExp5_ CExp6_, ///
    i(district_code) j(masterup)
rename *_ *
egen fake = group(district_code masterup)
reshape long CExp, i(fake) j(exp)
drop fake
egen fake = group(exp masterup)
rename CExp mode
reshape wide mode, i(fake) j(district_code)
drop fake
sort exp masterup
save schedule_temp.dta, replace
restore

* Merge in the wage schedule and alpha grid.
sort exp masterup
merge m:1 exp masterup using schedule_temp.dta
keep if _m == 3
drop _m

* Keep relevant districts.
sort district_code
merge m:1 district_code using tag.dta
keep if _m == 3
drop _m

bysort year exp masterup: egen v0bar = mean(v0)
bysort year exp masterup: egen v1bar = mean(v1)

gen V0 = v0
replace V0 = v0bar if exp == 1

gen V1 = v1
replace V1 = v1bar if exp == 1

gen C0 = (v0 + xb0)
replace C0 = (v0bar + xb0) if exp == 1

gen C1 = (v1 + xb1)
replace C1 = (v1bar + xb1) if exp == 1

gen Wage = .
qui levelsof district_code, local(Dist)
foreach d of local Dist {
    qui sum d if district_code == `d'
    local z = r(mean)
    local y = 0
    qui count if district_code == `d' & year == 2014 & exp == 1 & V0 != .
    if `r(N)' > 0 {
        disp "yes"
    }
    gen wage`d' = (1 * mode`d') + ///
        ((0/1000) * ((C0 * `z') + (C1 * (1 - `z'))))
    replace wage`d' = 86.731818 if wage`d' > 86.731818
    replace wage`d' = 28.777456 if wage`d' < 28.777456
    replace Wage = mode`d' if district_code == `d'
    replace Wage = 86.731818 if Wage > 86.731818
    replace Wage = 28.777456 if Wage < 28.777456
    drop mode`d'
}


********************************************************************************
* Wage-Schedule Prediction (Figure B3)
********************************************************************************

preserve
corr Wage salary_r if year == 2010
replace salary_r = salary_r / 1000
local corr = round(`r(rho)',0.01)
reg salary_r Wage, noco
binscatter Wage salary_r if year == 2010, n(20) $graph ///
    xtitle("w{subscript:it}{superscript:0}") ///
    ytitle("W{subscript:id}{superscript:0}", orientation(horizontal)) ///
    text(45 70 "correlation = `corr'", )
graph export "$out/figures/Figure_B3.png", replace
restore

********************************************************************************
* Distribution of Teacher Contributions (Figure B1, Table B2)
********************************************************************************


use "$est/contributions.dta", clear
gen c1 = v0 + xb0
gen c2 = v1 + xb1

twoway (kdensity c1) (kdensity c2), xtitle(" ") ytitle("Density") ///
    legend(order(1 "c1" 2 "c2") pos(6) row(1))
graph export "$out/figures/Figure_B1.png", replace

capt log close
log using "$out/tables/Table_B2.log", replace
su c1 c2, det
log close

********************************************************************************
* Correlation between c1 and c2 (Figure B2)
********************************************************************************

use $est/multinomial.dta, clear

gen c0 = c0 / d
gen c1 = c1 / (1-d)
keep id c0 c1
duplicates drop

corr c0 c1
local corr: di %6.2f `r(rho)'
twoway (scatter c0 c1) (lfit c0 c1), ytitle("c{subscript:2}") xtitle("c{subscript:1}") legend(off) text(-0.1 0.1 "Correlation = `corr'")
graph export "$out/figures/Figure_B2.png", replace
su c0 c1, det

********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    auxiliary_models_teachers_nobottom.do
* Purpose: Estimate matched-mover auxiliary teacher-choice models with and
*          without bottom-tail contribution values.
********************************************************************************

clear all
set more off
set matsize 11000
set maxvar 32000

global controls = "std_score_past disab_status el_status econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind"


********************************************************************************
* Matched Sample in Paper
********************************************************************************

use "$est/matched_movers.dta", clear
drop v0 v1
duplicates drop
sort id District
merge 1:1 id District using "$est/multinomial.dta"
keep if _m == 3
drop _m


********************************************************************************
* Merge in Distance
********************************************************************************

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

* Check that we have all districts.
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
gen lndist = ln(distance)
replace lndist = 0 if lndist == .

capt drop Exp*

label var samecz "same CZ"
label var Inc "d = d0"
label var d "$\lambda$"
label var urban "urban"
label var suburban "suburban"
label var wage "wage (1,000)"
label var c0d "$(v_{1} + \beta_{1}x) \lambda$"
label var c1d "$(v_{2} + \beta_{2}x) (1 - \lambda$)$"
label var C0d "$(v_{1} + \beta_{1}x) \lambda$  (avg for exp = 1)"
label var C1d "$(v_{2} + \beta_{2}x) (1 - \lambda$)$ (avg for exp = 1)"
gen Inc_exp = (Inc == 1) * totalexp
gen Inc_expsq = (Inc == 1) * totalexp^2
label var Inc_exp "d = d0 * Exp"
label var Inc_expsq "d = d0 * Exp$^2$"
gen lamsq = d^2
label var lamsq "$\lambda^{2}$"
gen explam = exp(d)
label var explam "$e^\lambda$"

drop entr
capt bysort id: egen entr = sum(Inc)
capt replace entr = 1 - entr

gen D0 = (1 - entr) * (1 - Inc)
gen D0exp = D0 * totalexp
gen CZ = (1 - entr) * (1 - samecz)

label var D0 "$ d_{0} \neq d$"
label var D0exp "$ d_{0} \neq d * exp$"
label var CZ "$ CZ_{0} \neq CZ_{d}$"
label var explam "$ e^\lambda$"

gen milw = District == 3619
label var milw "Milwaukee"

gen mad = District == 3269
label var mad "Madison"

gen Exp1 = totalexp2 < 2
gen Exp2 = totalexp2 == 2 | totalexp2 == 3
gen Exp3 = totalexp2 == 4 | totalexp2 == 5
gen Exp4 = totalexp2 >= 6 & totalexp2 <= 10
gen Exp5 = totalexp2 >= 11 & totalexp2 <= 15
gen Exp6 = totalexp2 > 15

gen d_ = 1 - d
label var d_ " $ 1 - \lambda $"
gen expd_ = exp(d_)

eststo r1: xtreg Match wage explam C0d D0 c.D0#Exp2 c.D0#Exp3 ///
    c.D0#Exp4 c.D0#Exp5 CZ lndist urban suburban milw, fe rob


********************************************************************************
* Trimming Bottom 10 Percent of c1 or c2
********************************************************************************

use "$est/multinomial.dta", clear

egen tag = tag(id)
qui sum C0 if tag == 1, det
local b0 = `r(p10)'
qui sum C1 if tag == 1, det
local b1 = `r(p10)'
drop tag

gen exp = 1
forvalues n = 2/6 {
replace exp = `n' if Exp`n' == 1
}
bysort id: egen exit = max(Match)
replace exit = 1 - exit
bysort id: egen INC = max(Inc)

* keep the offers that happened for sure (the seeds)
keep if ((Exp2 == 1 & Match == 1) | (Inc == 0 & Match == 1 & Exp1 == 0 & Exp2 == 0 & INC == 1) | (Inc == 1 & Match == 0 & Exp1 == 0 & Exp2 == 0 & INC == 1)) & exit == 0 // spot movers in their current & previous district
		/* non-tenured 				tenured in new district		tenured in incumbent districts	BUT ONLY IF d0 != 0*/
keep id District C0 C1 exp wage Inc samecz d Match urban suburban masterup
drop if C0 < `b0' | C1 < `b1'
sort id
save temp.dta, replace

* Based on the mover seeds, construct Offer^sub. The original implementation
* reopened the full multinomial file once for every seed teacher. This
* set-based version applies the identical threshold conditions in one join,
* preventing multi-hour runtimes and application termination on clean runs.
preserve
keep if Match == 1
collapse (mean) District C0 C1 exp wage masterup, by(id)
drop id
rename (C0 C1 exp wage masterup) ///
    (seed_C0 seed_C1 seed_exp seed_wage seed_masterup)
duplicates drop
tempfile offer_seeds
save `offer_seeds', replace
restore

use "$est/multinomial.dta", clear
gen exp = 1
forvalues n = 2/6 {
    replace exp = `n' if Exp`n' == 1
}
keep if Match == 0
joinby District using `offer_seeds'
keep if C0 >= seed_C0 + 0.00000000000000001 & ///
    C1 >= seed_C1 + 0.00000000000000001 & ///
    exp >= seed_exp + 0.00000000000000001 & ///
    wage <= seed_wage + 0.00001 & masterup >= seed_masterup
drop seed_*
keep id District v0 v1 exp wage Inc samecz C0 C1 d Match urban suburban masterup
duplicates drop
tempfile qualifying_offers
save `qualifying_offers', replace

keep id
duplicates drop
tempfile qualifying_ids
save `qualifying_ids', replace

use "$est/multinomial.dta", clear
gen exp = 1
forvalues n = 2/6 {
    replace exp = `n' if Exp`n' == 1
}
merge m:1 id using `qualifying_ids', keep(match) nogen
keep if Match == 1
keep id District v0 v1 exp wage Inc samecz C0 C1 d Match urban suburban masterup
append using `qualifying_offers'

* Append the original seeds
append using temp.dta
rm temp.dta
duplicates drop
sort id District
save "$est/matched_movers_nobottom.dta", replace

drop v0 v1
duplicates drop
sort id District
merge 1:1 id District using "$est/multinomial.dta"
keep if _m == 3
drop _m


********************************************************************************
* Merge in Distance
********************************************************************************

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

* Check that we have all districts.
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
gen lndist = ln(distance)
replace lndist = 0 if lndist == .

capt drop Exp*

label var samecz "same CZ"
label var Inc "d = d0"
label var d "$\lambda$"
label var urban "urban"
label var suburban "suburban"
label var wage "wage (1,000)"
label var c0d "$(v_{1} + \beta_{1}x) \lambda$"
label var c1d "$(v_{2} + \beta_{2}x) (1 - \lambda$)$"
label var C0d "$(v_{1} + \beta_{1}x) \lambda$  (avg for exp = 1)"
label var C1d "$(v_{2} + \beta_{2}x) (1 - \lambda$)$ (avg for exp = 1)"
gen Inc_exp = (Inc == 1) * totalexp
gen Inc_expsq = (Inc == 1) * totalexp^2
label var Inc_exp "d = d0 * Exp"
label var Inc_expsq "d = d0 * Exp$^2$"
gen lamsq = d^2
label var lamsq "$\lambda^{2}$"
gen explam = exp(d)
label var explam "$e^\lambda$"

drop entr
bysort id: egen entr = sum(Inc)
replace entr = 1 - entr

gen D0 = (1 - entr) * (1 - Inc)
gen D0exp = D0 * totalexp
gen CZ = (1 - entr) * (1 - samecz)

label var D0 "$ d_{0} \neq d$"
label var D0exp "$ d_{0} \neq d * exp$"
label var CZ "$ CZ_{0} \neq CZ_{d}$"
label var explam "$ e^\lambda$"

gen milw = District == 3619
label var milw "Milwaukee"

gen mad = District == 3269
label var mad "Madison"

gen Exp1 = totalexp2 < 2
gen Exp2 = totalexp2 == 2 | totalexp2 == 3
gen Exp3 = totalexp2 == 4 | totalexp2 == 5
gen Exp4 = totalexp2 >= 6 & totalexp2 <= 10
gen Exp5 = totalexp2 >= 11 & totalexp2 <= 15
gen Exp6 = totalexp2 > 15

gen d_ = 1 - d
label var d_ " $ 1 - \lambda $"
gen expd_ = exp(d_)

eststo r2: xtreg Match wage explam C0d D0 c.D0#Exp2 c.D0#Exp3 ///
    c.D0#Exp4 c.D0#Exp5 CZ lndist urban suburban milw, fe rob


esttab r1 r2 using "$out/tables/Table_B12.tex", ///
    b(5) se(5) unstack nonote label replace se ///
    keep(wage explam C0d D0 1.Exp2#c.D0 1.Exp3#c.D0 1.Exp4#c.D0 ///
        1.Exp5#c.D0 CZ lndist urban suburban milw) ///
    obslast nomtitle ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    mgroups("Standard" "Removing bottom c1/c2", pattern(1) ///
        prefix(\multicolumn{@span}{c}{) suffix(}) ///
        span erepeat(\cmidrule(lr){@span})) nomtitle ///
    stats(N r2_p, fmt(0 3) labels(`"Observations"' `"R-squared"')) ///
    substitute(\_ _)

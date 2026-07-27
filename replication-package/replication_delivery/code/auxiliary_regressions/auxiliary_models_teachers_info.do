********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    auxiliary_models_teachers_info.do
* Purpose: Estimate auxiliary teacher-choice models under imperfect information.
********************************************************************************

clear all
set more off
set matsize 11000
set maxvar 32000

global controls = "std_score_past disab_status el_status econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind"

* Imperfect-information inputs are stored with the estimation/model data unless
* a caller has already pointed $info elsewhere.
if "$info" == "" {
    global info "$est"
}


********************************************************************************
* Assumption 1: Teachers and districts both make mistakes on C0, C1
********************************************************************************

* Baseline
use "$est/matched_movers.dta", clear
drop v0 v1
duplicates drop
merge 1:1 id District using "$est/multinomial.dta"
keep if _m == 3
drop _m

//capt drop Exp*
capt drop entr
gen explam = exp(d)
label var explam "$e^\lambda$"
bysort id: egen entr = sum(Inc)
replace entr = 1 - entr
gen D0 = (1 - entr) * (1 - Inc)
gen D0exp = D0 * totalexp
gen CZ = (1 - entr) * (1 - samecz)
gen milw = District == 3619

label var samecz "same CZ"
label var Inc "d = d0"
label var urban "urban"
label var suburban "suburban"
label var wage "wage (1,000)"
label var C0d "c1 * lambda"
label var C1d "c2 * lambda"
label var D0 "$ d_{0} \neq d$"
label var D0exp "$ d_{0} \neq d * exp$"
label var CZ "$ CZ_{0} \neq CZ_{d}$"
label var explam "$ e^\lambda$"
label var milw "Milwaukee"

eststo r1_base: xtreg Match wage explam C0d D0 c.D0#Exp2 c.D0#Exp3 ///
    c.D0#Exp4 c.D0#Exp5 CZ urban suburban milw, fe rob


* Version 0
use "$est/matched_movers_info0.dta", clear
collapse Match wage d C0 C1 urban suburban, by(id District)
merge 1:1 id District using "$info/multinomial_info0.dta"
keep if _m == 3
drop _m

//capt drop Exp*
capt drop entr
gen explam = exp(d)
label var explam "$e^\lambda$"
bysort id: egen entr = sum(Inc)
replace entr = 1 - entr
gen D0 = (1 - entr) * (1 - Inc)
gen D0exp = D0 * totalexp
gen CZ = (1 - entr) * (1 - samecz)
gen milw = District == 3619

label var samecz "same CZ"
label var Inc "d = d0"
label var urban "urban"
label var suburban "suburban"
label var wage "wage (1,000)"
label var C0d "c1 * lambda"
label var C1d "c2 * lambda"
label var D0 "$ d_{0} \neq d$"
label var D0exp "$ d_{0} \neq d * exp$"
label var CZ "$ CZ_{0} \neq CZ_{d}$"
label var explam "$ e^\lambda$"
label var milw "Milwaukee"

eststo r0_info: xtreg Match wage explam C0d D0 c.D0#Exp2 c.D0#Exp3 ///
    c.D0#Exp4 c.D0#Exp5 CZ urban suburban milw, fe rob


* Version 1
use "$est/matched_movers_info1.dta", clear
collapse Match wage d C0 C1 urban suburban, by(id District)
merge 1:1 id District using "$info/multinomial_info1.dta"
keep if _m == 3
drop _m

//capt drop Exp*
capt drop entr
gen explam = exp(d)
label var explam "$e^\lambda$"
bysort id: egen entr = sum(Inc)
replace entr = 1 - entr
gen D0 = (1 - entr) * (1 - Inc)
gen D0exp = D0 * totalexp
gen CZ = (1 - entr) * (1 - samecz)
gen milw = District == 3619

label var samecz "same CZ"
label var Inc "d = d0"
label var urban "urban"
label var suburban "suburban"
label var wage "wage (1,000)"
label var C0d "c1 * lambda"
label var C1d "c2 * lambda"
label var D0 "$ d_{0} \neq d$"
label var D0exp "$ d_{0} \neq d * exp$"
label var CZ "$ CZ_{0} \neq CZ_{d}$"
label var explam "$ e^\lambda$"
label var milw "Milwaukee"

eststo r1_info: xtreg Match wage explam C0d D0 c.D0#Exp2 c.D0#Exp3 ///
    c.D0#Exp4 c.D0#Exp5 CZ urban suburban milw, fe rob


* Version 2
use "$est/matched_movers_info2.dta", clear
collapse Match wage d C0 C1 urban suburban, by(id District)
merge 1:1 id District using "$info/multinomial_info2.dta"
keep if _m == 3
drop _m

//capt drop Exp*
capt drop entr
gen explam = exp(d)
label var explam "$e^\lambda$"
bysort id: egen entr = sum(Inc)
replace entr = 1 - entr
gen D0 = (1 - entr) * (1 - Inc)
gen D0exp = D0 * totalexp
gen CZ = (1 - entr) * (1 - samecz)
gen milw = District == 3619

label var samecz "same CZ"
label var Inc "d = d0"
label var urban "urban"
label var suburban "suburban"
label var wage "wage (1,000)"
label var C0d "c1 * lambda"
label var C1d "c2 * lambda"
label var D0 "$ d_{0} \neq d$"
label var D0exp "$ d_{0} \neq d * exp$"
label var CZ "$ CZ_{0} \neq CZ_{d}$"
label var explam "$ e^\lambda$"
label var milw "Milwaukee"

eststo r2_info: xtreg Match wage explam C0d D0 c.D0#Exp2 c.D0#Exp3 ///
    c.D0#Exp4 c.D0#Exp5 CZ urban suburban milw, fe rob


* Version 3
use "$est/matched_movers_info3.dta", clear
collapse Match wage d C0 C1 urban suburban, by(id District)
merge 1:1 id District using "$info/multinomial_info3.dta"
keep if _m == 3
drop _m

//capt drop Exp*
capt drop entr
gen explam = exp(d)
label var explam "$e^\lambda$"
bysort id: egen entr = sum(Inc)
replace entr = 1 - entr
gen D0 = (1 - entr) * (1 - Inc)
gen D0exp = D0 * totalexp
gen CZ = (1 - entr) * (1 - samecz)
gen milw = District == 3619

label var samecz "same CZ"
label var Inc "d = d0"
label var urban "urban"
label var suburban "suburban"
label var wage "wage (1,000)"
label var C0d "c1 * lambda"
label var C1d "c2 * lambda"
label var D0 "$ d_{0} \neq d$"
label var D0exp "$ d_{0} \neq d * exp$"
label var CZ "$ CZ_{0} \neq CZ_{d}$"
label var explam "$ e^\lambda$"
label var milw "Milwaukee"

eststo r3_info: xtreg Match wage explam C0d D0 c.D0#Exp2 c.D0#Exp3 ///
    c.D0#Exp4 c.D0#Exp5 CZ urban suburban milw, fe rob


esttab r1_base r0_info r1_info r2_info r3_info using "$out/tables/Table_B11.txt", ///
    b(4) se(4) unstack nonote label replace se ///
    keep(wage explam C0d D0 1.Exp2#c.D0 1.Exp3#c.D0 1.Exp4#c.D0 1.Exp5#c.D0 CZ urban suburban milw) ///
    obslast ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    mtitle("Baseline" "0.5*sigma" "sigma" "2*sigma" "4*sigma") ///
    stats(N r2_p, fmt(0 3) labels(`"Observations"' `"R-squared"')) ///
    substitute(\_ _)

********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    auxiliary_models_teachers_richprefs.do
* Purpose: Compare teacher characteristics by offer-set size and test richer
*          preference specifications in the matched-mover auxiliary model.
********************************************************************************

clear all
set more off
set matsize 11000
set maxvar 32000

global controls = "std_score_past disab_status el_status econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind"


********************************************************************************
* Compare Teachers With One Versus Many Offers
********************************************************************************

use "$est/matched_movers.dta", clear
drop v0 v1
duplicates drop
sort id District
merge 1:1 id District using "$est/multinomial.dta"
keep if _m == 3
drop _m

preserve
use "$est/multinomial.dta", clear
keep id totalexp2 master Exp1 Exp2 Exp3 Exp4 Exp5 Exp6 v0 v1 xb0 xb1 V0 V1
duplicates drop
sort id
tempfile temp
save `temp', replace
restore

* Tag those with multiple offers.
sort id
merge m:1 id using `temp'
gen set = _m == 3

* Run comparison.
keep id totalexp2 master Exp1 Exp2 Exp3 Exp4 Exp5 Exp6 v0 v1 xb0 xb1 V0 V1 set
duplicates drop

label var totalexp2 "Experience"
label var Exp1 "No Exp"
label var Exp2 "Exp 1-2"
label var Exp3 "Exp 3-4"
label var Exp4 "Exp 5-9"
label var Exp5 "Exp 10-14"
label var Exp6 "Exp >14"
label var master "Master's"
gen c0 = V0 + xb0
gen c1 = V1 + xb1
label var c0 "c1"
label var c1 "c2"

global var "totalexp2 master c0 c1"

estpost ttest $var, by(set)
esttab ., ///
    cells("mu_1(fmt(3)) mu_2(fmt(3)) b(fmt(3)) p(fmt(3))") ///
    collabels("1 off" "Many off" "Difference" "P-value") ///
    label nonumber

esttab using "$out/tables/Table_B13.tex", replace ///
    cells("mu_1(fmt(3)) mu_2(fmt(3)) b(fmt(3)) p(fmt(3))") ///
    collabels("One offer" "Many offers" "Difference" "P-value") ///
    label nonumber booktabs compress ///
    alignment(S S S S)


/*
********************************************************************************
* Teacher Preferences in Small Aux
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

gen C1d_ = (V1 + xb1) * d_
tsset id District

* Baseline.
eststo r1: xtreg Match wage explam C0d ///
    D0 c.D0#Exp2 c.D0#Exp3 c.D0#Exp4 c.D0#Exp5 ///
    CZ lndist urban suburban milw, fe rob
scalar r2_baseline = e(r2_o)
scalar r2w_baseline = e(r2)
scalar mse_baseline = e(rmse)^2

* Add preference for helping high-achieving students.
eststo r2: xtreg Match wage explam C0d C1d_ ///
    D0 c.D0#Exp2 c.D0#Exp3 c.D0#Exp4 c.D0#Exp5 ///
    CZ lndist urban suburban milw, fe rob
scalar r2_model1 = e(r2_o)
scalar r2w_model1 = e(r2)
scalar mse_model1 = e(rmse)^2

* Interact experience with e(lambda_d) and c1 x lambda_d.
eststo r3: xtreg Match wage explam C0d C1d_ ///
    D0 c.D0#Exp2 c.D0#Exp3 c.D0#Exp4 c.D0#Exp5 ///
    c.explam#c.Exp1 c.explam#c.Exp2 c.explam#c.Exp3 ///
    c.explam#c.Exp4 c.explam#c.Exp5 ///
    c.C0d#c.Exp1 c.C0d#c.Exp2 c.C0d#c.Exp3 c.C0d#c.Exp4 c.C0d#c.Exp5 ///
    CZ lndist urban suburban milw, fe rob
scalar r2_model2 = e(r2_o)
scalar r2w_model2 = e(r2)
scalar mse_model2 = e(rmse)^2

* Interact experience with the location controls.
eststo r4: xtreg Match wage explam C0d C1d_ ///
    D0 c.D0#Exp2 c.D0#Exp3 c.D0#Exp4 c.D0#Exp5 ///
    c.explam#c.Exp1 c.explam#c.Exp2 c.explam#c.Exp3 ///
    c.explam#c.Exp4 c.explam#c.Exp5 ///
    c.C0d#c.Exp1 c.C0d#c.Exp2 c.C0d#c.Exp3 c.C0d#c.Exp4 c.C0d#c.Exp5 ///
    CZ lndist urban suburban milw ///
    c.lndist#c.Exp1 c.urban#c.Exp1 c.suburban#c.Exp1 c.milw#c.Exp1 ///
    c.lndist#c.Exp2 c.urban#c.Exp2 c.suburban#c.Exp2 c.milw#c.Exp2 ///
    c.lndist#c.Exp3 c.urban#c.Exp3 c.suburban#c.Exp3 c.milw#c.Exp3 ///
    c.lndist#c.Exp4 c.urban#c.Exp4 c.suburban#c.Exp4 c.milw#c.Exp4 ///
    c.lndist#c.Exp5 c.urban#c.Exp5 c.suburban#c.Exp5 c.milw#c.Exp5, fe rob
scalar r2_model3 = e(r2_o)
scalar r2w_model3 = e(r2)
scalar mse_model3 = e(rmse)^2


********************************************************************************
* Build Table of R2 and MSE
********************************************************************************

preserve
clear
set obs 4
gen str15 Model = ""
gen double R2_within = .
gen double R2_overall = .
gen double MSE = .

replace Model = "Baseline" in 1
replace R2_within = r2w_baseline in 1
replace R2_overall = r2_baseline in 1
replace MSE = mse_baseline in 1

replace Model = "Model 1" in 2
replace R2_within = r2w_model1 in 2
replace R2_overall = r2_model1 in 2
replace MSE = mse_model1 in 2

replace Model = "Model 2" in 3
replace R2_within = r2w_model2 in 3
replace R2_overall = r2_model2 in 3
replace MSE = mse_model2 in 3

replace Model = "Model 3" in 4
replace R2_within = r2w_model3 in 4
replace R2_overall = r2_model3 in 4
replace MSE = mse_model3 in 4

list, noobs abbrev(20)

estpost tabstat R2_within R2_overall MSE, by(Model) nototal

esttab . using "$out/tables/Table_B13.tex", ///
    cells("R2_within(fmt(3)) R2_overall(fmt(3)) MSE(fmt(3))") ///
    noobs nomtitles nonumber ///
    label replace ///
    alignment(D{.}{.}{3}) ///
    varlabels(R2_within "Within $R^2$" R2_overall "Overall $R^2$" MSE "MSE")

restore

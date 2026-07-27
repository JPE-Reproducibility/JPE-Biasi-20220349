********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    auxmodels_teachers_varobust.do
* Purpose: Estimate auxiliary teacher-choice models using class-model
*          value-added measures as a robustness check.
********************************************************************************



********************************************************************************
* Prepare Class-Model Value Added
********************************************************************************

tempfile class_va distances

use "$intdata/va_classmodel_JPE.dta", clear
rename v0 c0_class
rename v1 c1_class
keep id year c0_class c1_class

gsort id -year
bysort id: carryforward c1_class c0_class, replace
gsort id year
bysort id: carryforward c1_class c0_class, replace

keep if year == 2014
drop year
sort id
save `class_va', replace

use "$raw/district_distance_sdid.dta", clear
destring d1, replace
destring d2, replace
sort d1 d2
save `distances', replace


********************************************************************************
* Auxiliary Teacher Model: Full Choice Set
********************************************************************************

use "$est/multinomial.dta", clear
sort id
merge m:1 id using `class_va'
keep if _m == 3
drop _m

* Experience group.
gen exp = 1
forvalues n = 2/6 {
    replace exp = `n' if Exp`n' == 1
}

bysort id: egen exit = max(Match)
replace exit = 1 - exit
bysort id: egen INC = max(Inc)

* Impute first-year class-model VA using matched teachers in the same
* experience-by-degree cell.
bysort exp masterup: egen c0bar = mean(c0_class) if Match == 1
bysort exp masterup: egen c1bar = mean(c1_class) if Match == 1

gen C0_class = c0_class
gen X = c0bar if exp == 1
bysort id: egen C0_class2 = max(X) if exp == 1
replace C0_class = C0_class2 if exp == 1
drop C0_class2 X

gen C1_class = c1_class
gen X = c1bar if exp == 1
bysort id: egen C1_class2 = max(X) if exp == 1
replace C1_class = C1_class2 if exp == 1
drop C1_class2 X

gen C0d_class = C0_class * d
gen C1d_class = C1_class * (1 - d)

* Winsorize wage.
replace wage = 86.731818 if wage > 86.731818
replace wage = 28.777456 if wage < 28.777456

save "$est/multinomial_varobust_JPE.dta", replace

* Merge in district-to-district distances.
gen d1 = District if Inc == 1
gen d2 = District
tempvar home_district
bysort id: egen `home_district' = max(d1)
replace d1 = `home_district'

* Check that all districts are covered.
preserve
keep d2
duplicates drop
merge 1:m d2 using `distances'
tab d2 if _m == 1
restore

sort d1 d2
merge m:1 d1 d2 using `distances'
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
merge 1:1 id District using "$est/multinomial_varobust_JPE.dta"
keep if _m == 3
drop _m

capt drop Exp*
gen lamsq = d^2
gen explam = exp(d)

gen D0 = (1 - entr) * (1 - Inc)
gen D0_exp = D0 * totalexp
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

eststo r1: xtreg Match wage explam C0d_class D0 D0_nont D0_mid1 ///
    D0_mid2 D0_mid3 CZ urban suburban lndist milw, fe rob


********************************************************************************
* Build Restricted Choice Set
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

* Keep offers that happened for sure: non-tenured movers, tenured movers in
* the new district, and tenured teachers in incumbent districts.
keep if ((Exp2 == 1 & Match == 1) | ///
    (Inc == 0 & Match == 1 & Exp1 == 0 & Exp2 == 0 & INC == 1) | ///
    (Inc == 1 & Match == 0 & Exp1 == 0 & Exp2 == 0 & INC == 1)) & ///
    exit == 0

keep id District C0 C1 exp wage Inc samecz d Match urban suburban masterup
drop if C0 < `b0' | C1 < `b1'
sort id

tempfile mover_seed mover_choices
save `mover_seed', replace

* Create an empty dataset with the same variables for accumulating choices.
preserve
drop if id > 0
save `mover_choices', replace
restore

* Based on movers, construct the restricted offer set.
qui levelsof id, local(ID)
local t = 1
qui foreach teacher_id of local ID {
    noisily disp "teacher n. `t'"

    sum District if id == `teacher_id' & Match == 1
    local dist = r(mean)
    qui sum C0 if id == `teacher_id' & Match == 1
    local C0 = r(mean) + 0.00000000000000001
    qui sum C1 if id == `teacher_id' & Match == 1
    local C1 = r(mean) + 0.00000000000000001
    qui sum exp if id == `teacher_id' & Match == 1
    local exp = r(mean) + 0.00000000000000001
    qui sum wage if id == `teacher_id' & Match == 1
    local wage = r(mean) + 0.00001
    qui sum masterup if id == `teacher_id' & Match == 1
    local masterup = r(mean)

    preserve
    use "$est/multinomial.dta", clear

    gen exp = 1
    forvalues n = 2/6 {
        replace exp = `n' if Exp`n' == 1
    }

    gen TAG = .
    replace TAG = 1 if C0 >= `C0' & C1 >= `C1' & exp >= `exp' & ///
        wage <= `wage' & masterup >= `masterup' & ///
        District == `dist' & Match == 0

    bysort id: egen TTAG = max(TAG)
    keep if TTAG == 1 & (TAG == 1 | Match == 1)
    noisily count

    keep id District v0 v1 exp wage Inc samecz C0 C1 d Match urban ///
        suburban masterup
    append using `mover_choices'
    sort id
    save `mover_choices', replace
    restore

    local t = `t' + 1
}

use `mover_choices', clear

* Append the original seeds.
append using `mover_seed'
duplicates drop
sort id District
save "$est/matched_movers_varobust_JPE.dta", replace


********************************************************************************
* Auxiliary Teacher Model: Restricted Choice Set
********************************************************************************

use "$est/multinomial_varobust_JPE.dta", clear

* Merge in Wisconsin area identifiers.
rename District district_code
sort district_code
merge m:1 district_code using "$raw/cesa.dta"
drop if _m == 2
drop _m
replace cesa = 6 if cesa == . // this should only be district_code = 2570
rename district_code District

* Merge in district-to-district distances.
gen d1 = District if Inc == 1
gen d2 = District
tempvar home_district2
bysort id: egen `home_district2' = max(d1)
replace d1 = `home_district2'

* Check that all districts are covered.
preserve
keep d2
duplicates drop
merge 1:m d2 using `distances'
tab d2 if _m == 1
restore

sort d1 d2
merge m:1 d1 d2 using `distances'
drop if _m == 2
drop _m
replace distance = 0 if distance == .
sort id District
tempfile multinomial
save `multinomial', replace

use "$est/matched_movers_varobust_JPE.dta", clear
keep id District

* Merge in other variables.
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
gen D0_exp = D0 * totalexp
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

eststo r2: xtreg Match wage explam C0d_class D0 D0_nont D0_mid1 ///
    D0_mid2 D0_mid3 CZ urban suburban lndist milw, fe rob

capt log close
log using "$out/tables/Table_B5.log", replace	
esttab r2 r1, se
log close

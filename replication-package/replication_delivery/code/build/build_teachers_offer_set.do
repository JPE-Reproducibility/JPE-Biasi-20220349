********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    build_teachers_offer_set.do
* Purpose: Builds inferred teacher offer sets for aux models.
********************************************************************************


********************************************************************************
* Auxiliary Teacher Model: Restricted Choice Set
********************************************************************************

use "$est/multinomial.dta", clear

gen exp = 1
forvalues n = 2/6 {
    replace exp = `n' if Exp`n' == 1
}
bysort id: egen exit = max(Match)
replace exit = 1 - exit
bysort id: egen INC = max(Inc)

* Keep seed offers for the restricted choice set.
keep if ((Exp2 == 1 & Match == 1) | ///
    (Inc == 0 & Match == 1 & Exp1 == 0 & Exp2 == 0 & INC == 1) | ///
    (Inc == 1 & Match == 0 & Exp1 == 0 & Exp2 == 0 & INC == 1)) & ///
    exit == 0
keep id District C0 C1 exp wage Inc samecz d Match urban suburban masterup

sort id
save temp.dta, replace

* Create and save an empty dataset.
preserve
drop if id > 0
save temp2.dta, replace
restore

* Build the restricted choice set from movers.
qui levelsof id, local(ID)
local t = 1
qui foreach id of local ID {
    noisily disp "teacher n. `t'"
    sum District if id == `id' & Match == 1
    local dist = r(mean)
    qui sum C0 if id == `id' & Match == 1
    local C0 = r(mean) + 0.00000000000000001
    qui sum C1 if id == `id' & Match == 1
    local C1 = r(mean) + 0.00000000000000001
    qui sum exp if id == `id' & Match == 1
    local exp = r(mean) + 0.00000000000000001
    qui sum wage if id == `id' & Match == 1
    local wage = r(mean) + 0.00001
    qui sum masterup if id == `id' & Match == 1
    local masterup = r(mean)
    preserve
    use $est/multinomial.dta, clear

    gen exp = 1
    forvalues n = 2/6 {
        replace exp = `n' if Exp`n' == 1
    }
    gen TAG = .
    replace TAG = 1 if C0 >= `C0' & C1 >= `C1' & exp >= `exp' & ///
        wage <= `wage' & masterup >= `masterup' & District == `dist' & ///
        Match == 0
    bysort id: egen TTAG = max(TAG)
    keep if TTAG == 1 & (TAG == 1 | Match == 1)
    noisily count
    keep id District v0 v1 exp wage Inc samecz C0 C1 d Match urban ///
        suburban masterup
    append using temp2.dta
    sort id
    save temp2.dta, replace
    restore
    local t = `t' + 1
}

use temp2.dta, clear

* Append the original seeds.
append using temp.dta
rm temp.dta
rm temp2.dta
duplicates drop
sort id District
save $est/matched_movers.dta, replace


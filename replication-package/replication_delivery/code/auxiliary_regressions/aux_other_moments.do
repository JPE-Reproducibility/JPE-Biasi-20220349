********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    aux_other_moments.do
* Purpose: Export variance weights for auxiliary "other" moments.
********************************************************************************

set more off

* Synthetic samples can leave some auxiliary-moment cells unsupported, so the
* corresponding variance estimates are missing. Fortran list-directed input
* skips blank CSV records and then loses alignment. Replace these synthetic-only
* missing weights with zero; preserve missing estimates in the restricted-data
* workflow so genuine support problems remain visible there.
local using_synthetic = strpos(lower("$confdata"), "synthetic_data") > 0

if "$est" == "" {
    local base "$code"
    if substr("`base'", strlen("`base'"), 1) == "/" {
        global est "`base'../model_data"
    }
    else {
        global est "`base'/../model_data"
    }
}
capture mkdir "$est"

capture log close aux_other_moments
log using "$est/aux_other_moments.log", name(aux_other_moments) replace

capture program drop _post_mean_var
program define _post_mean_var
    syntax varname [if], POST(name)

    capture quietly mean `varlist' `if'
    if _rc {
        post `post' (.)
    }
    else {
        tempname V
        matrix `V' = e(V)
        post `post' (`=`V'[1,1]')
    }
end


********************************************************************************
* Matched Teacher-District Data
********************************************************************************

use "$est/multinomial.dta", clear
keep if Match == 1

gen C0 = V0 + xb0
gen C1 = V1 + xb1

bysort District: gen NN = _N
gen budget_teacher = budget / NN
drop NN

rename totalexp2 exper
rename C1 C2
rename C0 C1
rename masterup master

tempname aux_post
tempfile aux_variances excess_capacity
postfile `aux_post' v1 using `aux_variances', replace


********************************************************************************
* Moments 1-4: Teacher Characteristics by District Groups
********************************************************************************

preserve
collapse exper C1 C2 master d urban suburban budget_teacher, by(District)

xtile perc_lambda = d, n(5)
xtile perc_budget = budget_teacher, n(5)
label var perc_lambda "lambda quintile"
label var perc_budget "budget quintile"

tabstat exper C1 C2 master, by(perc_lambda) statistics(mean)
foreach var in exper C1 C2 master {
    forvalues q = 1/5 {
        _post_mean_var `var' if perc_lambda == `q', post(`aux_post')
    }
}

tabstat exper C1 C2 master, by(perc_budget) statistics(mean)
foreach var in exper C1 C2 master {
    forvalues q = 1/5 {
        _post_mean_var `var' if perc_budget == `q', post(`aux_post')
    }
}

tabstat exper C1 C2 master, by(suburban) statistics(mean)
foreach var in exper C1 C2 master {
    foreach status in 1 0 {
        _post_mean_var `var' if suburban == `status', post(`aux_post')
    }
}

tabstat exper C1 C2 master, by(urban) statistics(mean)
foreach var in exper C1 C2 master {
    foreach status in 1 0 {
        _post_mean_var `var' if urban == `status', post(`aux_post')
    }
}
restore


********************************************************************************
* Moments 5-10: Districts with Only Tenured Incumbents
********************************************************************************

preserve
use "$est/multinomial.dta", clear
gen tenured = Exp3 == 1 | Exp4 == 1 | Exp5 == 1 | Exp6 == 1
gen incten = tenured * Inc
collapse (sum) Match incten, by(District)
gen excess_capacity = Match > incten
keep District excess_capacity
save `excess_capacity', replace
restore

preserve
gen untenured = (Exp1 == 1 | Exp2 == 1) | Inc == 0
collapse untenured urban suburban d budget_teacher, by(District)
gen onlyten = untenured == 0

xtile perc_lambda = d, n(5)
xtile perc_budget = budget_teacher, n(5)
label var perc_lambda "lambda quintile"
label var perc_budget "budget quintile"

merge 1:1 District using `excess_capacity'
drop _merge

_post_mean_var onlyten, post(`aux_post')

tabstat onlyten, by(perc_lambda) statistics(mean)
forvalues q = 1/5 {
    _post_mean_var onlyten if perc_lambda == `q', post(`aux_post')
}

tabstat onlyten, by(perc_budget) statistics(mean)
forvalues q = 1/5 {
    _post_mean_var onlyten if perc_budget == `q', post(`aux_post')
}

tabstat onlyten, by(suburban) statistics(mean)
foreach status in 1 0 {
    _post_mean_var onlyten if suburban == `status', post(`aux_post')
}

tabstat onlyten, by(urban) statistics(mean)
foreach status in 1 0 {
    _post_mean_var onlyten if urban == `status', post(`aux_post')
}

tabstat onlyten, by(excess_capacity) statistics(mean)
foreach status in 1 0 {
    _post_mean_var onlyten if excess_capacity == `status', post(`aux_post')
}
restore


********************************************************************************
* Moment 11: New Hires
********************************************************************************

preserve
gen tenured = Exp3 == 1 | Exp4 == 1 | Exp5 == 1 | Exp6 == 1
gen newhire = 1 - tenured * Inc
collapse newhire, by(District)
keep if newhire > 0
_post_mean_var newhire, post(`aux_post')
restore

preserve
gen tenured = Exp3 == 1 | Exp4 == 1 | Exp5 == 1 | Exp6 == 1
gen newhire = 1 - tenured * Inc
keep if newhire == 1

foreach var in exper C1 C2 master {
    _post_mean_var `var', post(`aux_post')
}
restore


********************************************************************************
* Export
********************************************************************************

postclose `aux_post'
use `aux_variances', clear
if `using_synthetic' {
    replace v1 = 0 if missing(v1)
}
export delimited using "$est/aux_other_var.txt", replace

capture log close aux_other_moments
capture program drop _post_mean_var

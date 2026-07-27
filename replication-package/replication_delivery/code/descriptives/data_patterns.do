********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    data_patterns.do
* Purpose: Produce descriptive figures on wages, mobility, and sorting patterns.
********************************************************************************

global graph = "xlabel(,grid glp(dot) glc(gs10) tlc(gs10)) ylabel(,grid glp(dot) glc(gs10) tlc(gs10) angle(0)) plotregion(lp(blank))"
global graphy = "ylabel(,grid glp(dot) glc(gs10) tlc(gs10) angle(0)) plotregion(lp(blank))"

graph set window fontface "Times New Roman"


********************************************************************************
* Wage-Function Summary Statistics
********************************************************************************

use "$intdata/teachers_panel_JPE.dta", clear
drop if schoolcode == 8888

replace salary_r = . if year == 2010 & district_code == 2793

* Merge school-level low-achievement shares.
preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
gen d = std_score <= 0.07 & std_score != .
replace d = . if std_score == .
keep if year == 2010
collapse d std_score econ_disadv, by(district_code)
sort district_code
save temp.dta, replace
restore

sort district_code
merge m:1 district_code using temp.dta
drop if _m == 2
drop _m
rm temp.dta

* Novice teachers and low-achievement students.
gen d_ = 1-d



********************************************************************************
* Dispersion in Teacher Pay Before Act 10 (Figure 1)
********************************************************************************

preserve
gen nr  = 1
drop if year == 2010 & district_code == 2793
reghdfe salary_r, a(district_code##year exp##masterup) resid
predict res, resid
keep if fte_tot == 100
collapse (mean) mean = salary_r (sd) sd = res (sum) nr, ///
    by(district_code year)
gen cv = sd / mean
keep if year >= 2009 & year <= 2014
tab year, gen(yr)
gen zero = 0
label var zero "2011"
eststo r1: reg cv yr1-yr2 yr3 yr4-yr6, rob noco
forvalues n = 1/6 {
    local z = `n' + 2008
    label var yr`n' "`z'"
}
coefplot (r1, recast(connect) ciopts(recast(rcap)) lw(thick) ms(square)) ///
    , vert drop(_cons) omitted xline(3.5, lc(red)) level(90) ///
    legend(off) xtitle("year", size(large)) ///
    ytitle("coefficient of variation in salaries", size(large)) ///
    $graph xsize(8) ylabel(, labsize(large)) xlabel(, labsize(large))
graph export "$out/figures/Figure_1.png", replace
restore


********************************************************************************
* Movements of Teachers Across Districts (Figure 2a)
********************************************************************************

preserve
keep if year >= 2009 & year <= 2014
tab year, gen(yr)
forvalues n = 1/6 {
    local z = `n' + 2008
    label var yr`n' "`z'"
}
eststo r1: reg mover yr1-yr2 yr3 yr4-yr6, noco cluster(district_code)
coefplot (r1, recast(connect) lw(thick) ms(square) ciopts(recast(rcap))) ///
    , vert drop( _cons) omitted xline(3.5, lc(red)) level(90) ///
    legend(off) xtitle("year", size(large)) ytitle("moving rate", size(large)) ///
    xlabel(, labsize(large)) ylabel(, labsize(large)) $graph xsize(5)
graph export "$out/figures/Figure_2a.png", replace

restore


********************************************************************************
* Pay Increase Upon Moving (Figure 2b)
********************************************************************************

preserve
tsset id year
bysort id: egen mover_ever = max(mover)
tsset id year
gen post = year > 2011
reghdfe salary_r, a(id year) resid
predict res2, resid
gen bump = salary_r - l.salary_r
gen bump_res = res2 - l.res2

forvalues y = 2009/2016 {
    gen Y`y' = year == `y'
    gen mY`y' = mover_d * Y`y'
    label var Y`y' "`y'"
    label var mY`y' "`y'"
}

gen zero = 0
label var zero "2011"
order Y* mY*, first
gen yeart = 2008 + _n if _n < 9

su bump if mover_d == 1 & year == 2011
local a = `r(mean)'
su bump if mover_d == 0 & year == 2011
local b = `r(mean)'

foreach var in coef1 coef2 up1 up2 down1 down2 {
    gen `var' = .
}

eststo r1: reghdfe salary_r Y2009-Y2010 zero Y2012-Y2016 ///
    if year > 2008  & mover_d == 1, cluster(district_code) a(id)
replace coef1 = `a' if yeart == 2011
replace up1 = coef1 + 1.96 * _se[_cons] if yeart == 2011
replace down1 = coef1 - 1.96 * _se[_cons] if yeart == 2011
foreach y in 2009 2010 2012 2013 2014 2015 2016 {
    replace coef1 = `a' + _b[Y`y'] if yeart == `y'
    replace up1 = coef1 + 1.96 * _se[Y`y'] if yeart == `y'
    replace down1 = coef1 - 1.96 * _se[Y`y'] if yeart == `y'
}

eststo r2: reghdfe salary_r Y2009-Y2010 zero Y2012-Y2016 ///
    if year > 2008  & mover_d == 0, cluster(district_code) a(id)
replace coef2 = `b' if yeart == 2011
replace up2 = coef2 + 1.96 * _se[_cons] if yeart == 2011
replace down2 = coef2 - 1.96 * _se[_cons] if yeart == 2011
foreach y in 2009 2010 2012 2013 2014 2015 2016 {
    replace coef2 = `b'  + _b[Y`y'] if yeart == `y'
    replace up2 = coef2 + 1.96 * _se[Y`y'] if yeart == `y'
    replace down2 = coef2 - 1.96 * _se[Y`y'] if yeart == `y'
}

twoway (rarea up1 down1 yeart, color(gs8 % 20)) ///
    (connected coef1 yeart, color(black)) ///
    (rarea up2 down2 yeart, color(gs12 % 20)) ///
    (connected coef2 yeart, color(gs8)) if yeart < 2015, ///
    ytitle("salary change ($1,000)", size(large)) xline(2011.5) ///
    xtitle("year", size(large)) ///
    legend(order(2 "Movers" 4 "Non-movers") ring(0) pos(5) size(large)) ///
    ylabel(, labsize(large)) xlabel(2009(1)2014, labsize(large)) xsize(5) ylabel(-2000(2000)8000)
graph export "$out/figures/Figure_2b.png", replace
restore


********************************************************************************
* Sorting Across Districts by Lambda, Budget, and Student Disadvantage (Figure 3)
********************************************************************************

preserve
use "$intdata/indtest_math_split_JPE.dta", replace
drop if schoolcode == 8888
collapse econ_disad, by(district_code year)
sort district_code
save temp.dta, replace
restore

preserve
keep if fte_tot == 100
gen post = year > 2011
keep if year >= 2009 & year <= 2016
sort district_code
merge m:1 district_code year using "$intdata/budget_overtime_JPE.dta"
drop if _m == 2
drop _m

qui tab exp, gen(Exp)
gen xb0 = (g2_1 * Exp2) + (g3_1 * Exp3) + (g4_1 * Exp4) + ///
    (g5_1 * Exp5) + (g6_1 * Exp6)
gen xb1 = (g2_2 * Exp2) + (g3_2 * Exp3) + (g4_2 * Exp4) + ///
    (g5_2 * Exp5) + (g6_2 * Exp6)

gen c0 = v0 + xb0
gen c1 = v1 + xb1
gen c12 = c0 + c1
drop Exp*
gen Exp1 = totalexp > = 3
gen Exp2 = totalexp > = 5
gen Exp3 = totalexp > = 10
gen NN = 1
collapse d budget_pp econ_dis totalexp Exp* master c12 (sum) NN ///
    if year >= 2009 & year <= 2014, by(district_code year post)

gen corr_l = .
gen corr_b = .
gen corr_c = .
bysort year: gen yeart = _n + 2008 if _n < 9
forvalues y = 2009/2014 {
    corr totalexp d if year == `y' [aw = NN]
    replace corr_l = `r(rho)' if yeart == `y'
    corr totalexp budget_pp if year == `y' [aw = NN]
    replace corr_b = `r(rho)' if yeart == `y'
    corr totalexp econ_dis if year == `y' [aw = NN]
    replace corr_c = `r(rho)' if yeart == `y'
}

drop if year > 2014
drop if yeart > 2014
graph bar corr_l corr_c corr_b, over(yeart, label(labsize(large))) ///
    ytitle("correlation w/average experience", size(large)) ///
    legend(order(1 "share low-achieving students" ///
        2 "share low SES students" 3 "budget per teacher") ring(0) ///
        size(large)) ///
    blabel(total, format(%3.2f) size(medium)) ///
    bar(1, fcolor(black) lcolor(black)) ///
    bar(2, fcolor(gs8) lcolor(gs8)) ///
    bar(3, fcolor(gs12) lcolor(gs12)) xsize(8.5) ///
    ylabel(-0.5(0.1)0.3, labsize(large))
graph export "$out/figures/Figure_3.png", replace
restore

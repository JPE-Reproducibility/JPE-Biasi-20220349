********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    budget_shifts.do
* Purpose: Produce appendix figures on teacher switches and budget shares.
********************************************************************************

global graph = "xlabel(,grid glp(dot) glc(gs10) tlc(gs10)) ylabel(,grid glp(dot) glc(gs10) tlc(gs10) angle(0)) plotregion(lp(blank))"
global graphy = "ylabel(,grid glp(dot) glc(gs10) tlc(gs10) angle(0)) plotregion(lp(blank))"


********************************************************************************
* Teacher Assignment Inputs
********************************************************************************

use "$intdata/teachers_new_JPE.dta", clear
keep if fte_tot >= 100

tsset id year
gen changemath = ((math == 1 | all_elem == 1) & ///
    (l.math == 0 &l.all_elem == 0)) | ///
    ((math == 0 & all_elem == 0) & (l.math == 1 | l.all_elem == 1))
replace changemath = . if l.math  == . & l.all_elem  == .

gen lowgr_n = lowgrade
gen highgr_n = highgrade
foreach var in lowgr_n highgr_n {
    replace `var' = "0" if `var' == "KG"
    replace `var' = "-1" if `var' == "K4"
    replace `var' = "-2" if `var' == "K3"
    replace `var' = "-3" if `var' == "PK"
    destring `var', replace
}

gen grade4_6 = lowgr_n <= 6 & highgr_n >= 4
gen grade1_6 = lowgr_n <= 6 & highgr_n >= 1


********************************************************************************
* Math Teaching Switches (Figure B7)
********************************************************************************

preserve
sum changemath
collapse changemath, by(year)

twoway (connected changemath year), ///
    ytitle("share teachers switching in our out of Math") ///
    legend(off) xline(2011) ylabel(0(0.005)0.02)
graph export "$out/figures/Figure_B7.png", replace
restore


********************************************************************************
* Budget Shares by Subject and Grade (Figure B8)
********************************************************************************

preserve
gen math = (math == 1 | all_elem == 1) & grade4_6 == 1
gen lang = (reading == 1 | all_elem == 1 | english == 1) & grade4_6 == 1
gen ourg = grade4_6 == 1
gen otherg = grade1_6 == 1 & grade4_6 == 0
gen sal_math = salary if math == 1
gen sal_lang = salary if lang == 1
gen sal_ourg = salary if ourg == 1
gen sal_otherg = salary if otherg == 1
collapse (sum) salary sal_*, by(district_code year)
gen share_math = sal_math / salary
gen share_lang = sal_lang / salary
gen share_ourg = sal_ourg / salary
gen share_otherg = sal_otherg / salary
collapse share_* ///
    (p75) p75_math = share_math p75_lang = share_lang ///
        p75_ourg = share_ourg p75_otherg = share_otherg ///
    (p25) p25_math = share_math p25_lang = share_lang ///
        p25_ourg = share_ourg p25_otherg = share_otherg, ///
    by(year)

twoway (rarea p25_math p75_math year, color(gs8%20)) ///
    (connected share_math year), ///
    ytitle("share budget, Math, grades 4-6") legend(off) xline(2011)
graph export "$out/figures/Figure_B8A.png", replace

twoway (rarea p25_lang p75_lang year, color(gs8%20)) ///
    (connected share_lang year), ///
    ytitle("share budget, Language, grades 4-6") legend(off) xline(2011)
graph export "$out/figures/Figure_B8B.png", replace

twoway (rarea p25_ourg p75_ourg year, color(gs8%20)) ///
    (connected share_ourg year), ///
    ytitle("share budget, Grades 4-6") legend(off) xline(2011)
graph export "$out/figures/Figure_B8C.png", replace

twoway (rarea p25_otherg p75_otherg year, color(gs8%20)) ///
    (connected share_otherg year), ///
    ytitle("share budget, Grades 1-3") legend(off) xline(2011)
graph export "$out/figures/Figure_B8D.png", replace
restore

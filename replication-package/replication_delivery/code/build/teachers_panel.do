********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    teachers_with_allva.do
* Purpose: Build the teacher panel with all value-added estimates.
* Date:    June 2026
********************************************************************************


********************************************************************************
* Additional cleaning
********************************************************************************

use "$intdata/teachers_new_JPE.dta", replace
keep id year totalexp birth salary fringe bachelor master specialist ///
    phd female mathematics english reading all_elem fte_tot mover_d ///
    mover_school exit exit_temp schoolcode lowgrade highgrade schoolname ///
    district_code workagencyname black hispanic asian birth

drop if fte < 100

* Define previous district as described in the paper.
tsset id year
gen district_past = l.district_code
gen district_past2007 = l.district_code if year == 2008
replace district_past2007 = l2.district_code if year == 2009
replace district_past2007 = l3.district_code if year == 2010
replace district_past2007 = l4.district_code if year == 2011
gen district_past2008 = l.district_code if year == 2009
replace district_past2008 = l2.district_code if year == 2010
replace district_past2008 = l3.district_code if year == 2011
replace district_past2008 = l4.district_code if year == 2012
gen district_past2009 = l.district_code if year == 2010
replace district_past2009 = l2.district_code if year == 2011
replace district_past2009 = l3.district_code if year == 2012
replace district_past2009 = l4.district_code if year == 2013
gen district_past2010 = l.district_code if year == 2011
replace district_past2010 = l2.district_code if year == 2012
replace district_past2010 = l3.district_code if year == 2013
replace district_past2010 = l4.district_code if year == 2014
gen district_past2011 = l.district_code if year == 2012
replace district_past2011 = l2.district_code if year == 2013
replace district_past2011 = l3.district_code if year == 2014
replace district_past2011 = l4.district_code if year == 2015
gen district_past2012 = l.district_code if year == 2013
replace district_past2012 = l2.district_code if year == 2014
replace district_past2012 = l3.district_code if year == 2015
gen district_past2013 = l.district_code if year == 2014
replace district_past2013 = l2.district_code if year == 2015
gen district_past2014 = l.district_code if year == 2015
replace district_past2014 = l2.district_code if year == 2016
gen district_past2015 = l.district_code if year == 2016

* Entry indicator
gen t = 1
tsset id year
bysort id: gen n = _n
gen entry = l.t == . & n == 1
drop t n
replace entry = . if year == 2006


* Normalize salaries by FTE and winsorize raw salary within year.
qui levelsof year, local(Year)
qui levelsof district_code, local(Dist)
gen salary_n = salary * 100 / fte_tot

foreach y of local Year {
    disp "`y'"
    qui su salary if year == `y', det
    replace salary = r(p1) if salary <= r(p1) & salary != . & year == `y'
    replace salary = r(p99) if salary >= r(p99) & salary != . & year == `y'
}


********************************************************************************
* Clean experience
********************************************************************************

* Correct obvious mistakes and address backward jumps in experience.
tsset id year
gen totalexp2 = totalexp
gen tooyoung = (year - birth - totalexp) < 20
replace totalexp2 = . if tooyoung == 1
drop tooyoung

tsset id year
gen expjump = totalexp2 - l.totalexp2
replace expjump = totalexp2 - l2.totalexp2 if expjump == .
replace expjump = totalexp2 - l3.totalexp2 if expjump == .
replace expjump = totalexp2 - l4.totalexp2 if expjump == .
gen Tag = 1 if expjump < 0 & expjump != .
bysort id Tag (year): gen T = _n if Tag != .
replace Tag = . if T > 1
drop T
bysort id (year): gen Ntag = _n if Tag == 1
bysort id: egen NTag = max(Ntag)
bysort id (year): gen t = _n
replace totalexp2 = . if t >= NTag & NTag != .
drop Tag Ntag NTag
gen totalexp3 = totalexp2
replace totalexp3 = l.totalexp3 + 1 if totalexp3 == .
bysort id: ipolate totalexp3 t, epolate gen(totalexp4)
drop totalexp2 totalexp3
rename totalexp4 totalexp2


********************************************************************************
* Restrict to the analysis sample
********************************************************************************

* Drop Milwaukee in 2015 because the wage data have obvious mistakes.
drop if year == 2015 & district_code == 3619

drop if schoolcode == 8888
keep if (highgrade == "01" | highgrade == "02" | highgrade == "03" | ///
    highgrade == "04" | highgrade == "05" | highgrade == "06")

********************************************************************************
* Add district classifications
********************************************************************************

* Merge CESA information.
sort district_code
merge m:1 district_code using "$raw/cesa.dta"
drop if _m == 2
drop _m

* District type: urban = 1, suburban = 2, rural = 3.
gen type = 3
foreach n in ///
    112 2450 413 422 665 721 1015 1092 1253 4970 1414 714 ///
    8131 1890 1900 2058 2184 2217 2296 2303 2460 2562 2604 ///
    2605 2758 2793 1376 2835 2842 3862 3129 1897 3381 3430 ///
    3437 3479 3528 3549 3612 3675 3787 3857 3925 2177 3983 ///
    4018 4060 4095 4312 5026 5278 5355 5369 5439 5621 5656 ///
    5663 3510 5817 5901 6181 6244 6328 6419 6470 {
    replace type = 2 if district_code == `n'
}
foreach n in ///
    147 8123 8105 8101 1554 1862 2289 2695 2849 3269 3619 ///
    3892 4179 4620 8107 5271 5780 8125 6174 6223 6300 8113 ///
    8132 {
    replace type = 1 if district_code == `n'
}

* Fix district codes that changed because of consolidation.
replace cesa = 11 if district_code == 6410
replace cesa = 2 if district_code == 5075
replace cesa = 2 if district_code == 5061
replace cesa = 6 if district_code == 4998
replace cesa = 6 if district_code == 3913
replace cesa = 6 if district_code == 2523
replace cesa = 11 if district_code == 1078
drop if cesa == .

gen masterup = master == 1 | phd == 1

* Express normalized salaries in 2015 dollars.
gen salary_round = salary_n
replace salary_round = salary_round * 1.14 if year == 2007
replace salary_round = salary_round * 1.10 if year == 2008
replace salary_round = salary_round * 1.10 if year == 2009
replace salary_round = salary_round * 1.09 if year == 2010
replace salary_round = salary_round * 1.05 if year == 2011
replace salary_round = salary_round * 1.03 if year == 2012
replace salary_round = salary_round * 1.02 if year == 2013
replace salary_round = salary_round * 1.00 if year == 2014



********************************************************************************
* Manual fixes of obvious data mistakes.
********************************************************************************

* Specific adjustments to 2014 salary outliers, assigned the closest most recent salary
qui sum salary if year == 2010 & id == 29925
replace salary = `r(mean)' if year == 2014 & id == 29925

qui sum salary if year == 2013 & id == 32097
replace salary = `r(mean)' if year == 2014 & id == 32097

qui sum salary if year == 2013 & id == 614231
replace salary = `r(mean)' if year == 2014 & id == 614231

qui sum salary if year == 2013 & id == 636414
replace salary = `r(mean)' if year == 2014 & id == 636414

qui sum salary if year == 2013 & id == 648811
replace salary = `r(mean)' if year == 2014 & id == 648811


* Some observations have FTE > 100 and an obvious part-time salary: Adjusted manually
replace fte_tot = 100 if id == 51368 & year >= 2008 & year <= 2010
replace salary_round = salary_round * 2 if id == 51368 & year >= 2008 & year <= 2010
replace fte_tot = 100 if id == 248118 & year >= 2006 & year <= 2011
replace salary_round = salary_round * 2 if id == 248118 & year >= 2006 & year <= 2011
replace fte_tot = 100 if id == 417854 & year >= 2006 & year <= 2011
replace salary_round = salary_round * 2 if id == 417854 & year >= 2006 & year <= 2011
replace fte_tot = 100 if id == 569465 & year >= 2006 & year <= 2010
replace salary_round = salary_round * 2 if id == 569465 & year >= 2006 & year <= 2010
replace fte_tot = 100 if id == 605541 & year >= 2006 & year <= 2011
replace salary_round = salary_round * 2 if id == 605541 & year >= 2006 & year <= 2011
replace salary_round = salary_round * 2 if id == 601945 & year == 2010
replace salary_round = salary_round * 2 if id == 604816 & year == 2010
replace salary_round = salary_round * 2 if id == 157360 & year >= 2006 & year <= 2010


* Manual fixes to experience.
replace totalexp2 = 2 if id == 714844 & year == 2014
replace totalexp2 = 2 if id == 721096 & year == 2014
replace totalexp2 = 3 if id == 723948 & year == 2014
replace totalexp2 = 2 if id == 740395 & year == 2014
replace totalexp2 = 2 if id == 745577 & year == 2014
replace totalexp2 = 2 if id == 747151 & year == 2014
replace totalexp2 = 2 if id == 738093 & year == 2014
replace totalexp2 = 2 if (id == 675928 | id == 693660 | id == 706866 | ///
    id == 706976 | id == 707846 | id == 695643 | id == 710421) & ///
    year == 2010


* Categorical experience variable.
gen exp = 1 if totalexp2 == 1
replace exp = 2 if totalexp2 > 1 & totalexp2 <= 3
replace exp = 3 if totalexp2 > 3 & totalexp2 <= 5
replace exp = 4 if totalexp2 > 5 & totalexp2 <= 10
replace exp = 5 if totalexp2 > 10 & totalexp2 <= 15
replace exp = 6 if totalexp2 > 15


********************************************************************************
* Finalize and save
********************************************************************************

* Keep only the variables used downstream.
keep id year district_code schoolcode district_past* ///
    exp salary_round masterup cesa type totalexp2 all_elem math reading ///
    english highgrade lowgrade fte_tot mover_d exit entry birth
order id year district_code district_past* exp masterup salary_round cesa ///
    type, first

save "$intdata/teachers_panel_nova_JPE.dta", replace

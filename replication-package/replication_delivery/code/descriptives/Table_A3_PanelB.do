*===============================================================================
* Table A3, Panel B (Model Fit: District Wage Schedules)
* Extract Table A3, Panel B values into CSV
*===============================================================================

clear all

* Need to first generate some vars from district observable characteristics
*   and grab the "data" side target values
use $est/multinomial.dta

keep District alpha0_ alpha1_ urban suburban d budget capacity
duplicates drop 

gen rural = (urban == 0 & suburban == 0)
gen budget_per_teacher = budget / capacity 

summ d, detail
gen above_med_d = d > r(p50)

gen district_id = _n

tempfile distdata 
save `distdata'

** NOW DO THE MODELING SIDE 
import delimited using "$fortran_code/estimation_result/result/omega2_probs.txt", delimiters(" ", collapse) clear
drop v1 v11 
rename o2_0 o2zeroprob
drop o2_*
gen oppweight = 1 - o2zeroprob

merge 1:1 district_id using `distdata', nogen

* RAW DATA TARGET
estpost tabstat rural above_med_d budget_per_teacher if alpha1_ == 0, stats(mean) columns(statistics)
est store omega0_data

estpost tabstat rural above_med_d budget_per_teacher if alpha1_ > 0, stats(mean) columns(statistics)
est store omega1_data

* MODEL RESULT
estpost summarize rural above_med_d budget_per_teacher [weight=o2zeroprob]
est store omega0_model

estpost summarize rural above_med_d budget_per_teacher [weight=oppweight]
est store omega1_model

* COMBINED TABLE
esttab omega0_data omega0_model omega1_data omega1_model using "$out/tables/Table_A3_PanelB.csv", ///
	cells("mean(fmt(3))") ///
	noobs ///
	label ///
	nonumber ///
	mtitles("Data o2=0" "Model o2=0" "Data o2>0" "Model o2>0") ///
	gaps ///
	replace

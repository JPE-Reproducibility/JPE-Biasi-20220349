********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    auxiliary_models_districts.do
* Purpose: Estimate district-side auxiliary models for model moments.
********************************************************************************

clear all
set more off
set matsize 11000
set maxvar 32000

capture mkdir "$out"
capture mkdir "$out/tables"


********************************************************************************
* District Regressions
********************************************************************************

use "$est/multinomial.dta", clear


* Standardize district contribution measures before forming district moments.
qui sum C0d, det
replace C0d = (C0d - r(mean)) / r(sd)

qui sum C1d, det
replace C1d = (C1d - r(mean)) / r(sd)


** residual capacity
gen stay = Match == 1 & Inc == 1 & totalexp2 > 3
bysort District: egen x = sum(stay)
gen capacity_left = capacity - x
drop x

gen x = wage if stay == 1
bysort District: egen xx = sum(x)
gen budget_left = budget - xx
drop x xx

gen budget_left_pp = budget_left / capacity_left
replace budget_left_pp = 0 if capacity_left == 0

gen tot = 1
gen comb = C0d + C1d
bysort id: egen comb_mean = mean(comb)

* relevant sample of teachers whose characteristics matter: non-incumbents
gen relevant = Match == 1 & (totalexp2 <= 3 | Inc == 0)

*replace capacity_left = capacity_left / capacity
gen contr_diff = V1 + xb1 - V0 - xb0
gen cap_d = capacity_left * d

gen avgcont = 0.5 * ((V0 + xb0) + (V1 + xb1))

gen milwaukee = District == 3619

tempfile district_base
save `district_base', replace


********************************************************************************
* New Teachers
********************************************************************************

keep if relevant == 1
collapse capacity_left budget_left budget_left_pp cap_d masterup totalexp2 V0 V1 xb0 xb1 d avgcont alpha* urban suburban milwaukee, by(District)

gen budgetpt_d = budget_left_pp * d
gen budget_d = budget_left * d

gen C0 = V0 + xb0
gen C1 = V1 + xb1

label var budget_left "free budget (1,000)"
label var budget_left_pp "free budget/teacher (1,000)"
label var capacity_left "free capacity"
label var budgetpt_d "free budget PT * $\lambda$"
label var budget_d "free budget * $\lambda$"
label var d "$\lambda$"
label var alpha0_ "$\alpha0$"
label var alpha1_ "$\alpha1$"
label var C0 "$c1$"
label var C1 "$c2$"
label var urban "urban"
label var suburban "suburban"
label var milwaukee "Milwaukee"

eststo r1: reg totalexp2 budget_left capacity_left d , rob
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaD1_1.csv", replace nonames
restore

** save variances
preserve
matrix B = vecdiag(e(V))'
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaD1_1_var.csv", replace nonames
restore


eststo r2: reg totalexp2 budget_left capacity_left d budgetpt_d, rob
eststo r3: reg totalexp2 budget_left_pp d , rob
eststo r4: reg totalexp2 budget_left_pp d budgetpt_d, rob
eststo r4b: reg totalexp2 budget_left_pp d budgetpt_d  urban suburban milwaukee, rob

eststo r5: reg masterup budget_left capacity_left d , rob
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaD1_2.csv", replace nonames
restore

** save variances
preserve
matrix B = vecdiag(e(V))'
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaD1_2_var.csv", replace nonames
restore

eststo r6: reg masterup budget_left capacity_left d budgetpt_d, rob
eststo r7: reg masterup budget_left_pp d , rob
eststo r8: reg masterup budget_left_pp d budgetpt_d, rob
eststo r8b: reg masterup budget_left_pp d budgetpt_d urban suburban milwaukee, rob

eststo r9: reg C0 budget_left capacity_left d , rob
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaD1_3.csv", replace nonames
restore

** save variances
preserve
matrix B = vecdiag(e(V))'
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaD1_3_var.csv", replace nonames
restore

eststo r10: reg C0 budget_left capacity_left d budgetpt_d, rob
eststo r11: reg C0 budget_left_pp d , rob
eststo r12: reg C0 budget_left_pp d budgetpt_d, rob
eststo r12b: reg C0 budget_left_pp d budgetpt_d urban suburban milwaukee, rob

eststo r13: reg C1 budget_left capacity_left d , rob
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaD1_4.csv", replace nonames
restore

** save variances
preserve
matrix B = vecdiag(e(V))'
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaD1_4_var.csv", replace nonames
restore

eststo r14: reg C1 budget_left capacity_left d budgetpt_d, rob
eststo r15: reg C1 budget_left_pp d , rob
eststo r16: reg C1 budget_left_pp d budgetpt_d, rob
eststo r16b: reg C1 budget_left_pp d budgetpt_d urban suburban milwaukee, rob

eststo r17: reg avgcont budget_left capacity_left d , rob
eststo r18: reg avgcont budget_left capacity_left d budgetpt_d, rob
eststo r19: reg avgcont budget_left_pp d , rob
eststo r20: reg avgcont budget_left_pp d budgetpt_d, rob
eststo r20b: reg avgcont budget_left_pp d budgetpt_d urban suburban milwaukee, rob

eststo r21: reg C0 budget_left_pp d alpha0_ alpha1_, rob
eststo r23: reg C1 budget_left_pp d alpha0_ alpha1_, rob
eststo r25: reg avgcont budget_left_pp d alpha0_ alpha1_, rob
eststo r25b: reg avgcont budget_left_pp d alpha0_ alpha1_ urban suburban milwaukee, rob

esttab	r1 r2 r3 r4 r4b r5 r6 r7 r8 r8b using "$out/tables/aux_district_noninc1_JPE.tex"	///
		, b(4) se(4) unstack nonote label replace se ///
		keep(budget_left budget_left_pp capacity_left d budgetpt_d urban suburban milwaukee) mgroups("experience" "Master's", pattern(1 0 0 0 0 1 0 0 0 0) ///
		prefix(\multicolumn{@span}{c}{) suffix(}) ///
		span erepeat(\cmidrule(lr){@span})) ///
		obslast  nomtitle star(* 0.10 ** 0.05 *** 0.01) ///
		stats(N r2, fmt(0 3) labels(`"Observations"' `"R-squared"')) substitute(\_ _ )



esttab	r9 r10 r11 r12 r12b r13 r14 r15 r16 r16b using "$out/tables/aux_district_noninc2_JPE.tex"	///
		, b(4) se(4) unstack nonote label replace se ///
		keep(budget_left budget_left_pp capacity_left d budgetpt_d urban suburban milwaukee) mgroups("$ c_{1}(x,v_{1})$" "$ c_{2}(x,v_{2})$", pattern(1 0 0 0 0 1 0 0 0 0) ///
		prefix(\multicolumn{@span}{c}{) suffix(}) ///
		span erepeat(\cmidrule(lr){@span})) ///
		obslast  nomtitle star(* 0.10 ** 0.05 *** 0.01) ///
		stats(N r2, fmt(0 3) labels(`"Observations"' `"R-squared"')) substitute(\_ _ )

esttab	r17 r18 r19 r20 r20b using "$out/tables/aux_district_noninc3_JPE.tex"	///
		, b(4) se(4) unstack nonote label replace se ///
		keep(budget_left budget_left_pp capacity_left d budgetpt_d urban suburban milwaukee) mgroups("avg contr", pattern(1 0 0 0 0) ///
		prefix(\multicolumn{@span}{c}{) suffix(}) ///
		span erepeat(\cmidrule(lr){@span})) ///
		obslast  nomtitle star(* 0.10 ** 0.05 *** 0.01) ///
		stats(N r2, fmt(0 3) labels(`"Observations"' `"R-squared"')) substitute(\_ _ )


esttab	r21 r23 r25 r25b using "$out/tables/aux_district_noninc4_JPE.tex"	///
		, b(4) se(4) unstack nonote label replace se ///
		keep(budget_left_pp d alpha0_ alpha1_  urban suburban milwaukee) mgroups("$ c_{1}(x,v_{1})$" "$ c_{2}(x,v_{2})$" "avg. contr", pattern(1  1 1 0) ///
		prefix(\multicolumn{@span}{c}{) suffix(}) ///
		span erepeat(\cmidrule(lr){@span})) ///
		obslast  nomtitle star(* 0.10 ** 0.05 *** 0.01) ///
		stats(N r2, fmt(0 3) labels(`"Observations"' `"R-squared"')) substitute(\_ _ )



********************************************************************************
* All Teachers: Lower-Tail Means
********************************************************************************

use `district_base', clear
keep if Match == 1
gen C0 = V0 + xb0
gen C1 = V1 + xb1

foreach var in totalexp2 masterup C0 C1 avgcont {
gen mean_`var' = .
}



qui levelsof District, local(Dist)
qui foreach d of local Dist {
foreach var in totalexp2 masterup C0 C1 avgcont {
qui sum `var' if District == `d', det
qui sum `var' if District == `d' & `var' <= r(p10), det
replace mean_`var' = r(mean) if District == `d'
}
}



collapse capacity_left budget_left* cap_d mean_* d alpha* C0 C1  urban suburban milwaukee (sum) Match, by(District)
*drop capacity_left
*rename Match capacity_left

gen budgetpt_d = budget_left_pp * d
gen budget_d = budget_left * d

label var budget_left "budget (1,000)"
label var budget_left_pp "budget/teacher (1,000)"
label var capacity_left "capacity"
label var budgetpt_d "budget PT * $\lambda$"
label var budget_d "budget * $\lambda$"
label var d "$\lambda$"
label var alpha0_ "$\alpha0$"
label var alpha1_ "$\alpha1$"
label var C0 "$c1$"
label var C1 "$c2$"
label var urban "urban"
label var suburban "suburban"
label var milwaukee "Milwaukee"

eststo r1: reg mean_totalexp2 budget_left capacity_left d, rob
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaD2_1.csv", replace nonames
restore

** save variances
preserve
matrix B = vecdiag(e(V))'
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaD2_1_var.csv", replace nonames
restore


eststo r2: reg mean_totalexp2 budget_left capacity_left d budgetpt_d, rob
eststo r3: reg mean_totalexp2 budget_left_pp d , rob
eststo r4: reg mean_totalexp2 budget_left_pp d budgetpt_d, rob
eststo r4b: reg mean_totalexp2 budget_left_pp d budgetpt_d urban suburban milwaukee, rob



eststo r5: reg mean_masterup budget_left capacity_left d, rob 
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaD2_2.csv", replace nonames
restore

** save variances
preserve
matrix B = vecdiag(e(V))'
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaD2_2_var.csv", replace nonames
restore

eststo r6: reg mean_masterup budget_left capacity_left d budgetpt_d, rob 
eststo r7: reg mean_masterup budget_left_pp d , rob
eststo r8: reg mean_masterup budget_left_pp d budgetpt_d, rob
eststo r8b: reg mean_masterup budget_left_pp d budgetpt_d urban suburban milwaukee, rob

eststo r9: reg mean_C0 budget_left capacity_left d, rob 
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaD2_3.csv", replace nonames
restore

** save variances
preserve
matrix B = vecdiag(e(V))'
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaD2_3_var.csv", replace nonames
restore

eststo r10: reg mean_C0 budget_left capacity_left d budgetpt_d, rob 
eststo r11: reg mean_C0 budget_left_pp d , rob
eststo r12: reg mean_C0 budget_left_pp d budgetpt_d, rob
eststo r12b: reg mean_C0 budget_left_pp d budgetpt_d urban suburban milwaukee, rob

eststo r13: reg mean_C1 budget_left capacity_left d, rob 
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaD2_4.csv", replace nonames
restore

** save variances
preserve
matrix B = vecdiag(e(V))'
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaD2_4_var.csv", replace nonames
restore

eststo r14: reg mean_C1 budget_left capacity_left d budgetpt_d, rob 
eststo r15: reg mean_C1 budget_left_pp d , rob
eststo r16: reg mean_C1 budget_left_pp d budgetpt_d, rob
eststo r16b: reg mean_C1 budget_left_pp d budgetpt_d urban suburban milwaukee, rob

eststo r17: reg mean_avgcont budget_left capacity_left d , rob
eststo r18: reg mean_avgcont budget_left capacity_left d budgetpt_d, rob
eststo r19: reg mean_avgcont budget_left_pp d , rob
eststo r20: reg mean_avgcont budget_left_pp d budgetpt_d, rob
eststo r20b: reg mean_avgcont budget_left_pp d budgetpt_d urban suburban milwaukee, rob

eststo r21: reg mean_C0 budget_left_pp d alpha0_ alpha1_, rob
eststo r22: reg mean_C0 budget_left_pp d alpha0_ alpha1_ budgetpt_d, rob
eststo r23: reg mean_C1 budget_left_pp d alpha0_ alpha1_, rob
eststo r24: reg mean_C1 budget_left_pp d alpha0_ alpha1_ budgetpt_d, rob
eststo r25: reg mean_avgcont budget_left_pp d alpha0_ alpha1_, rob
eststo r26: reg mean_avgcont budget_left_pp d alpha0_ alpha1_ budgetpt_d, rob

esttab	r1 r2 r3 r4 r4b r5 r6 r7 r8 r8b using "$out/tables/aux_district_all1_JPE.tex"	///
		, b(4) se(4) unstack nonote label replace se ///
		keep(budget_left budget_left_pp capacity_left d budgetpt_d urban suburban milwaukee) mgroups("experience" "Master's", pattern(1 0 0 0 0 1 0 0 0 0) ///
		prefix(\multicolumn{@span}{c}{) suffix(}) ///
		span erepeat(\cmidrule(lr){@span})) ///
		obslast  nomtitle star(* 0.10 ** 0.05 *** 0.01) ///
		stats(N r2, fmt(0 3) labels(`"Observations"' `"R-squared"')) substitute(\_ _ )


esttab	r9 r10 r11 r12 r12b r13 r14 r15 r16 r16b using "$out/tables/aux_district_all2_JPE.tex"	///
		, b(4) se(4) unstack nonote label replace se ///
		keep(budget_left budget_left_pp d capacity_left budgetpt_d urban suburban milwaukee) mgroups("$ c_{1}(x,v_{1})$" "$ c_{2}(x,v_{2})$", pattern(1 0 0 0 0 1 0 0 0 0) ///
		prefix(\multicolumn{@span}{c}{) suffix(}) ///
		span erepeat(\cmidrule(lr){@span})) ///
		obslast  nomtitle star(* 0.10 ** 0.05 *** 0.01) ///
		stats(N r2, fmt(0 3) labels(`"Observations"' `"R-squared"')) substitute(\_ _ )


esttab	r17 r18 r19 r20 r20b using "$out/tables/aux_district_all3_JPE.tex"	///
		, b(4) se(4) unstack nonote label replace se ///
		keep(budget_left budget_left_pp d capacity_left budgetpt_d urban suburban milwaukee) mgroups("avg. contr", pattern(1 0 0 0 0) ///
		prefix(\multicolumn{@span}{c}{) suffix(}) ///
		span erepeat(\cmidrule(lr){@span})) ///
		obslast  nomtitle star(* 0.10 ** 0.05 *** 0.01) ///
		stats(N r2, fmt(0 3) labels(`"Observations"' `"R-squared"')) substitute(\_ _ )


		


********************************************************************************
* All Teachers: Means
********************************************************************************

use `district_base', clear
keep if Match == 1

gen C0 = V0 + xb0
gen C1 = V1 + xb1

collapse capacity_left budget_left* cap_d masterup totalexp2 C0 C1 d avgcont alpha*  urban suburban milwaukee (sum) Match, by(District)
*drop capacity_left
*rename Match capacity_left

gen budgetpt_d = budget_left_pp * d
gen budget_d = budget_left * d

label var budget_left "budget (1,000)"
label var budget_left_pp "budget/teacher (1,000)"
label var capacity_left "capacity"
label var budgetpt_d "budget PT * $\lambda$"
label var budget_d "budget * $\lambda$"
label var alpha0_ "$\alpha0$"
label var alpha1_ "$\alpha1$"
label var budget_d "budget PT * $\lambda$"
label var d "$\lambda$"
label var urban "urban"
label var suburban "suburban"
label var milwaukee "Milwaukee"

eststo r1: reg totalexp2 budget_left capacity_left d, rob
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaD3_1.csv", replace nonames
restore

** save variances
preserve
matrix B = vecdiag(e(V))'
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaD3_1_var.csv", replace nonames
restore

eststo r2: reg totalexp2 budget_left capacity_left d budgetpt_d, rob
eststo r3: reg totalexp2 budget_left_pp d , rob
eststo r4: reg totalexp2 budget_left_pp d budgetpt_d, rob
eststo r4b: reg totalexp2 budget_left_pp d budgetpt_d urban suburban milwaukee, rob



eststo r5: reg masterup budget_left capacity_left d, rob 
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaD3_2.csv", replace nonames
restore

** save variances
preserve
matrix B = vecdiag(e(V))'
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaD3_2_var.csv", replace nonames
restore

eststo r6: reg masterup budget_left capacity_left d budgetpt_d, rob 
eststo r7: reg masterup budget_left_pp d , rob
eststo r8: reg masterup budget_left_pp d budgetpt_d, rob
eststo r8b: reg masterup budget_left_pp d budgetpt_d urban suburban milwaukee, rob

eststo r9: reg C0 budget_left capacity_left d, rob 
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaD3_3.csv", replace nonames
restore

** save variances
preserve
matrix B = vecdiag(e(V))'
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaD3_3_var.csv", replace nonames
restore

eststo r10: reg C0 budget_left capacity_left d budgetpt_d, rob 
eststo r11: reg C0 budget_left_pp d , rob
eststo r12: reg C0 budget_left_pp d budgetpt_d, rob
eststo r12b: reg C0 budget_left_pp d budgetpt_d urban suburban milwaukee, rob

eststo r13: reg C1 budget_left capacity_left d, rob 
matrix A = e(b)'
preserve
svmat A
keep A1
rename A1 A
drop if A == .
outsheet using "$est/betaD3_4.csv", replace nonames
restore

** save variances
preserve
matrix B = vecdiag(e(V))'
svmat B
keep B1
rename B1 B
drop if B == .
outsheet using "$est/betaD3_4_var.csv", replace nonames
restore

eststo r14: reg C1 budget_left capacity_left d budgetpt_d, rob 
eststo r15: reg C1 budget_left_pp d , rob
eststo r16: reg C1 budget_left_pp d budgetpt_d, rob
eststo r16b: reg C1 budget_left_pp d budgetpt_d urban suburban milwaukee, rob

eststo r17: reg avgcont budget_left capacity_left d , rob
eststo r18: reg avgcont budget_left capacity_left d budgetpt_d, rob
eststo r19: reg avgcont budget_left_pp d , rob
eststo r20: reg avgcont budget_left_pp d budgetpt_d, rob
eststo r20b: reg avgcont budget_left_pp d budgetpt_d urban suburban milwaukee, rob

eststo r21: reg C0 budget_left_pp d alpha0_ alpha1_, rob
eststo r22: reg C0 budget_left_pp d alpha0_ alpha1_ budgetpt_d, rob
eststo r23: reg C1 budget_left_pp d alpha0_ alpha1_, rob
eststo r24: reg C1 budget_left_pp d alpha0_ alpha1_ budgetpt_d, rob
eststo r25: reg avgcont budget_left_pp d alpha0_ alpha1_, rob
eststo r26: reg avgcont budget_left_pp d alpha0_ alpha1_ budgetpt_d, rob

esttab	r1 r2 r3 r4 r4b r5 r6 r7 r8 r8b using "$out/tables/aux_district_all_mean1_JPE.tex"	///
		, b(4) se(4) unstack nonote label replace se ///
		keep(budget_left budget_left_pp capacity_left d budgetpt_d urban suburban milwaukee) mgroups("experience" "Master's", pattern(1 0 0 0 0 1 0 0 0 0) ///
		prefix(\multicolumn{@span}{c}{) suffix(}) ///
		span erepeat(\cmidrule(lr){@span})) ///
		obslast  nomtitle star(* 0.10 ** 0.05 *** 0.01) ///
		stats(N r2, fmt(0 3) labels(`"Observations"' `"R-squared"')) substitute(\_ _ )


esttab	r9 r10 r11 r12 r12b r13 r14 r15 r16 r16b using "$out/tables/aux_district_all_mean2_JPE.tex"	///
		, b(4) se(4) unstack nonote label replace se ///
		keep(budget_left budget_left_pp d capacity_left budgetpt_d urban suburban milwaukee) mgroups("$ c_{1}(x,v_{1})$" "$ c_{2}(x,v_{2})$", pattern(1 0 0 0 0 1 0 0 0 0) ///
		prefix(\multicolumn{@span}{c}{) suffix(}) ///
		span erepeat(\cmidrule(lr){@span})) ///
		obslast  nomtitle star(* 0.10 ** 0.05 *** 0.01) ///
		stats(N r2, fmt(0 3) labels(`"Observations"' `"R-squared"')) substitute(\_ _ )


esttab	r17 r18 r19 r20 r20b using "$out/tables/aux_district_all_mean3_JPE.tex"	///
		, b(4) se(4) unstack nonote label replace se ///
		keep(budget_left budget_left_pp d capacity_left budgetpt_d urban suburban milwaukee) mgroups("avg. contr", pattern(1 0 0 0 0) ///
		prefix(\multicolumn{@span}{c}{) suffix(}) ///
		span erepeat(\cmidrule(lr){@span})) ///
		obslast  nomtitle star(* 0.10 ** 0.05 *** 0.01) ///
		stats(N r2, fmt(0 3) labels(`"Observations"' `"R-squared"')) substitute(\_ _ )






********************************************************************************
* Summary Statistics
********************************************************************************

use `district_base', clear
gen C0 = V0 + xb0
gen C1 = V1 + xb1
collapse d urban suburban alpha0_ alpha1_ budget budget_left capacity ///
    totalexp2 masterup C0 C1 avgcont (sum) Match (max) relevant, by(District)
replace budget_left = budget / (Match)
label var budget_left "budget per teacher"
label var urban "urban"
label var suburban "suburban"
label var alpha0_ "alpha0"
label var alpha1_ "alpha1"
label var Match "nr teachers"
label var totalexp2 "experience"
label var masterup "Master"
label var C0 "$ c_{1}$"
label var C1 "$ c_{2}$"
label var avgcont "avg. contr"

levelsof relevant, local(relevant_groups)
local n_relevant_groups : word count `relevant_groups'

if `n_relevant_groups' == 2 {
    eststo t1: estpost ttest urban suburban alpha0_ alpha1_ budget_left ///
        totalexp2 masterup C0 C1 avgcont Match, by(relevant)

    esttab t1 using "$out/tables/with_without_movers_JPE.tex", noobs booktabs ///
        cells("mu_1(fmt(a2)) mu_2 b(fmt(a2)star)" ". . se(par)") label ///
        star(* 0.10 ** 0.05 *** 0.01) ///
        collabels("w/out hires" "w/ hires" "Difference") replace nomtitle ///
        substitute(\_ _ )
}
else {
    display as text "Skipping with/without movers t-test: relevant has `n_relevant_groups' group(s)."
}

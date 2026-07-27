********************************************************************************
* Table 6: Flexible Pay vs Rigid Pay
* Produces: % difference (Flexible-Rigid)/|Rigid| for TC, C1, C2
*           and mean (sd) of lambda_d by subset
********************************************************************************

clear all

*** local directory of the results
local baseline_dir "$fortran_code/2_rigid/result"
local cf_dir "$fortran_code/1_baseline/result"

tempfile temp temp1 table6_results

****************************************************
* Load baseline (Rigid)
****************************************************

* Teacher stats
import delimited "`baseline_dir'/eqbm_dist_contribution.txt", delimiter(space, collapse) varnames(1)
drop v1 v16
rename avg_expect_cont contribute
rename avg_c1 c1
rename avg_c2 c2
rename avg_expect_exp exp
rename avg_expect_ma ma
rename budg_per_teach budg_per_teach
rename budget budget
save "`temp1'", replace
clear

* Omega choices
import delimited "`baseline_dir'/eqbm_omegas.txt", delimiter(space, collapse) varnames(1)
drop v1 v6
sort econ dist
save "`temp'", replace
use "`temp1'"
sort econ district_id
merge econ district_id using "`temp'"
drop _merge
rename omega1 omega1
rename omega2 omega2
sort econ district_id
save "`temp1'", replace

* Capacity/hires info
drop _all
import delimited "`baseline_dir'/eqbm_dist_hires.txt", delimiter(space, collapse) varnames(1)
drop v1 v7
drop capacity
rename expected_hires expected_hires
rename belief_expected_hires belief_expected_hires
sort econ dist
save "`temp'", replace
use "`temp1'"
sort econ district_id
merge econ district_id using "`temp'"
drop _merge
sort econ district_id
gen totalcontr = contribute * expected_hires
save "`temp1'", replace

preserve
clear

****************************************************
* Load counterfactual (Flexible / Full Eq)
****************************************************

* Teacher stats
import delimited "`cf_dir'/eqbm_dist_contribution.txt", delimiter(space, collapse) varnames(1)
drop v1 v16
rename avg_expect_cont contributenew
rename avg_c1 c1new
rename avg_c2 c2new
rename avg_expect_exp expnew
rename avg_expect_ma manew
rename budg_per_teach budg_per_teachnew
rename budget budgetnew
save "`temp1'", replace
clear

* Omega choices
import delimited "`cf_dir'/eqbm_omegas.txt", delimiter(space, collapse) varnames(1)
drop v1 v6
sort econ dist
save "`temp'", replace
use "`temp1'"
sort econ district_id
merge econ district_id using "`temp'"
drop _merge
rename omega1 omega1new
rename omega2 omega2new
sort econ district_id
save "`temp1'", replace

* Capacity/hires info
drop _all
import delimited "`cf_dir'/eqbm_dist_hires.txt", delimiter(space, collapse) varnames(1)
drop v1 v7
drop capacity
rename expected_hires expected_hiresnew
rename belief_expected belief_expected_hiresnew
sort econ dist
save "`temp'", replace
use "`temp1'"
sort econ district_id
merge econ district_id using "`temp'"
drop _merge
sort econ district_id
gen totalcontrnew = contributenew * expected_hiresnew
levelsof economy_id, local(econs)
save "`temp1'", replace

****************************************************
* Merge baseline and counterfactual
****************************************************

restore
sort econ district_id
merge econ district_id using "`temp1'"
sum _merge
drop _merge

* Keep only economies present in counterfactual
egen OK = anymatch(economy_id), values(`econs')
keep if OK
drop OK

* Merge in district characteristics (cz, lambda, etc.)
preserve
clear
import delimited "`baseline_dir'/eqbm_dist_contribution.txt", delimiter(space, collapse) varnames(1)
drop v1 v16
keep if economy_id == 1
keep district_id lambda
sort district_id
save "`temp1'", replace
restore
sort district_id
merge district_id using "`temp1'"
table _merge
drop _merge

keep if economy_id

****************************************************
* Define lambda quartiles
****************************************************

gen quartlam_1 = (lambda <= .4212679)
gen quartlam_2 = (lambda > .4212679 & lambda <= .5132743)
gen quartlam_3 = (lambda > .5132743 & lambda <= .5674157)
gen quartlam_4 = (lambda > .5674157)

****************************************************
* Create component variables
****************************************************

gen totalc1 = c1 * expected_hires * lambda
gen totalc2 = c2 * expected_hires * (1 - lambda)

gen totalc1new = c1new * expected_hiresnew * lambda
gen totalc2new = c2new * expected_hiresnew * (1 - lambda)

gen capacity_c1 = capacity * lambda
gen capacity_c2 = capacity * (1 - lambda)

****************************************************
* Loop over subsets: all, then 4 quartiles
****************************************************

preserve

forval x = 1/5 {

    * Collapse across economies to get district-level means
    collapse (mean) totalcontr totalcontrnew totalc1 totalc2 totalc1new totalc2new capacity capacity_c1 capacity_c2 quartlam* lambda, by(district_id)

    * Subset selection
    if `x' == 1 {
        local subsetname = "All Districts"
    }
    if `x' == 2 {
        keep if quartlam_4 == 1
        local subsetname = "4th quartile"
    }
    if `x' == 3 {
        keep if quartlam_3 == 1
        local subsetname = "3rd quartile"
    }
    if `x' == 4 {
        keep if quartlam_2 == 1
        local subsetname = "2nd quartile"
    }
    if `x' == 5 {
        keep if quartlam_1 == 1
        local subsetname = "1st quartile"
    }

    * Column 4: Compute mean and sd of lambda before final collapse
    quietly summarize lambda
    local mean_lambda = r(mean)
    local sd_lambda   = r(sd)

    * Collapse across districts to get totals
    collapse (sum) totalcontr totalcontrnew totalc1 totalc2 totalc1new totalc2new

    * Column 1: % difference in TC (all)
    gen pct_difftotalcont = (totalcontrnew - totalcontr) / abs(totalcontr)

    * Column 2: % difference in C1 (low-achieving)
    gen pct_difftotalc1 = (totalc1new - totalc1) / abs(totalc1)

    * Column 3: % difference in C2 (high-achieving)
    gen pct_difftotalc2 = (totalc2new - totalc2) / abs(totalc2)

    * Column 4: lambda mean and sd
    gen lambda_mean = `mean_lambda'
    gen lambda_sd   = `sd_lambda'

    * Label
    gen subset_name = "`subsetname'"
    gen order = `x'

    * Keep only final results
    keep subset_name order pct_difftotalcont pct_difftotalc1 pct_difftotalc2 lambda_mean lambda_sd
    order subset_name order pct_difftotalcont pct_difftotalc1 pct_difftotalc2 lambda_mean lambda_sd

    if `x' == 1 {
        save "`table6_results'", replace
    }
    if `x' > 1 {
        save "`temp'", replace
        use "`table6_results'", clear
        append using "`temp'"
        save "`table6_results'", replace
    }

    restore, preserve
}

****************************************************
* Display final table and export as CSV
****************************************************

use "`table6_results'", clear
sort order

* Convert fractions to percentages
replace pct_difftotalcont = pct_difftotalcont * 100
replace pct_difftotalc1   = pct_difftotalc1 * 100
replace pct_difftotalc2   = pct_difftotalc2 * 100
replace lambda_mean       = lambda_mean * 100
replace lambda_sd         = lambda_sd * 100

* Rename for clarity
rename pct_difftotalcont pct_diff_TC
rename pct_difftotalc1   pct_diff_C1
rename pct_difftotalc2   pct_diff_C2

* Generate combined lambda string column
gen lambda_display = string(lambda_mean, "%4.1f") + " (" + string(lambda_sd, "%4.1f") + ")"

* Keep and order columns for export
keep order subset_name pct_diff_TC pct_diff_C1 pct_diff_C2 lambda_display
order order subset_name pct_diff_TC pct_diff_C1 pct_diff_C2 lambda_display

list, noobs separator(1) abbreviate(20)

* Export to CSV
export delimited using "$out/tables/Table_6.csv", replace

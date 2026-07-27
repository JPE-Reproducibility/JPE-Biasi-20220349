*===============================================================================
* Table 8: Moving Costs, Resistance Costs, and Policy Impacts
* Produces a CSV with % change columns
*===============================================================================

clear all

*-------------------------------------------------------------------------------
* Define some extra local paths for where to find results
*-------------------------------------------------------------------------------

local baseline_dir "$fortran_code/4_nomovecost/case_baseline/result"
local case1_dir "$fortran_code/4_nomovecost/case1/result"
local case2_dir "$fortran_code/4_nomovecost/case2/result"
local case2_new2_dir "$fortran_code/4_nomovecost/case2_new2/result"

*-------------------------------------------------------------------------------
* Declare tempfiles
*-------------------------------------------------------------------------------
tempfile tf_base_contrib tf_base_hires tf_base
tempfile tf_case1_contrib tf_case1_hires tf_case1
tempfile tf_case2_contrib tf_case2_hires tf_case2
tempfile tf_case2new2_contrib tf_case2new2_hires tf_case2new2
tempfile tf_distinfo

*-------------------------------------------------------------------------------
* Initialize output matrix (3 rows x 3 columns)
*-------------------------------------------------------------------------------
matrix table8 = J(3, 3, .)

*-------------------------------------------------------------------------------
* Load and prepare a scenario dataset
*-------------------------------------------------------------------------------
capture program drop load_scenario
program define load_scenario
    args dir tf_contrib tf_hires tf_merged suffix

    clear
    import delimited "`dir'/eqbm_dist_contribution.txt", delimiter(space, collapse) varnames(1)
    drop v1 v16
    rename avg_expect_cont contribute`suffix'
    rename avg_c1 c1`suffix'
    rename avg_c2 c2`suffix'
    rename avg_expect_exp exp`suffix'
    sort econ district_id
    save "`tf_contrib'", replace

    clear
    import delimited "`dir'/eqbm_dist_hires.txt", delimiter(space, collapse) varnames(1)
    drop v1 v7
    drop capacity
    rename expected_hires expected_hires`suffix'
    sort econ dist
    save "`tf_hires'", replace

    use "`tf_contrib'", clear
    merge 1:1 econ district_id using "`tf_hires'"
    drop _merge
    gen totalcontr`suffix' = contribute`suffix' * expected_hires`suffix'
    sort econ district_id
    save "`tf_merged'", replace
end

*-------------------------------------------------------------------------------
* Load all scenarios
*-------------------------------------------------------------------------------
load_scenario "`baseline_dir'" "`tf_base_contrib'" "`tf_base_hires'" "`tf_base'" ""
load_scenario "`case1_dir'" "`tf_case1_contrib'" "`tf_case1_hires'" "`tf_case1'" "_c1s"
load_scenario "`case2_dir'" "`tf_case2_contrib'" "`tf_case2_hires'" "`tf_case2'" "_c2s"
load_scenario "`case2_new2_dir'" "`tf_case2new2_contrib'" "`tf_case2new2_hires'" "`tf_case2new2'" "_c2n"

*-------------------------------------------------------------------------------
* Merge all scenarios together
*-------------------------------------------------------------------------------
use "`tf_base'", clear
merge 1:1 econ district_id using "`tf_case1'"
drop _merge
merge 1:1 econ district_id using "`tf_case2'"
drop _merge
merge 1:1 econ district_id using "`tf_case2new2'"
drop _merge

* Merge in lambda/district info
preserve
clear
import delimited "`baseline_dir'/eqbm_dist_contribution.txt", delimiter(space, collapse) varnames(1)
drop v1 v16
keep if economy_id == 1
keep district_id lambda
sort district_id
save "`tf_distinfo'", replace
restore

sort district_id
merge m:1 district_id using "`tf_distinfo'"
drop _merge
keep if economy_id != .

*-------------------------------------------------------------------------------
* Create component totals for each scenario
*-------------------------------------------------------------------------------
* Baseline
gen totalc1 = c1 * expected_hires * lambda
gen totalc2 = c2 * expected_hires * (1 - lambda)

* Case1 (zero moving costs)
gen totalc1_c1s = c1_c1s * expected_hires_c1s * lambda
gen totalc2_c1s = c2_c1s * expected_hires_c1s * (1 - lambda)

* Case2 (zero resistance costs)
gen totalc1_c2s = c1_c2s * expected_hires_c2s * lambda
gen totalc2_c2s = c2_c2s * expected_hires_c2s * (1 - lambda)

* Case2 + New2
gen totalc1_c2n = c1_c2n * expected_hires_c2n * lambda
gen totalc2_c2n = c2_c2n * expected_hires_c2n * (1 - lambda)

*-------------------------------------------------------------------------------
* Compute table statistics
*-------------------------------------------------------------------------------
preserve

collapse (mean) totalcontr* totalc1* totalc2*, by(district_id)
collapse (sum) totalcontr* totalc1* totalc2*

* Column 1: (Case1 - Base) / |Base|
matrix table8[1, 1] = (totalcontr_c1s[1] - totalcontr[1]) / abs(totalcontr[1])
matrix table8[2, 1] = (totalc1_c1s[1] - totalc1[1]) / abs(totalc1[1])
matrix table8[3, 1] = (totalc2_c1s[1] - totalc2[1]) / abs(totalc2[1])

* Column 2: (Case2 - Base) / |Base|
matrix table8[1, 2] = (totalcontr_c2s[1] - totalcontr[1]) / abs(totalcontr[1])
matrix table8[2, 2] = (totalc1_c2s[1] - totalc1[1]) / abs(totalc1[1])
matrix table8[3, 2] = (totalc2_c2s[1] - totalc2[1]) / abs(totalc2[1])

* Column 3: (Case2_New2 - Case2) / |Case2|
matrix table8[1, 3] = (totalcontr_c2n[1] - totalcontr_c2s[1]) / abs(totalcontr_c2s[1])
matrix table8[2, 3] = (totalc1_c2n[1] - totalc1_c2s[1]) / abs(totalc1_c2s[1])
matrix table8[3, 3] = (totalc2_c2n[1] - totalc2_c2s[1]) / abs(totalc2_c2s[1])

restore

*-------------------------------------------------------------------------------
* Build and export CSV
*-------------------------------------------------------------------------------
clear
set obs 5

gen str80 row_label = ""
replace row_label = "TC_bar" in 1
replace row_label = "C1_bar" in 2
replace row_label = "C2_bar" in 3
replace row_label = "" in 4
replace row_label = "Note: Column 4 (New2-Base)/|Base| values can be found in Table 7." in 5

gen str20 col1 = ""
gen str20 col2 = ""
gen str20 col3 = ""

* Fill in numeric values from matrix (multiply by 100 for %)
forval col = 1/3 {
    if `col' == 1 local cvar "col1"
    if `col' == 2 local cvar "col2"
    if `col' == 3 local cvar "col3"

    forval row = 1/3 {
        local val = table8[`row', `col'] * 100
        local val_fmt : display %5.2f `val'
        replace `cvar' = "`val_fmt'" in `row'
    }
}

* Rename columns for clarity
rename col1 Case1_minus_Base
rename col2 Case2_minus_Base
rename col3 Case2New2_minus_Case2

export delimited using "$out/tables/Table_8.csv", replace

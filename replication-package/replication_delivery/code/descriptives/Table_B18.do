*===============================================================================
* Table B18 (State-Funded Bonuses)
*===============================================================================

clear all

*-------------------------------------------------------------------------------
* Define some extra local paths for where to find results
*-------------------------------------------------------------------------------

local baseline_dir "$fortran_code/1_baseline/result"

* Three counterfactual directories (new1 = max balance, new2 = c1 only, new3 = max eff)
local cf_dir_1 "$fortran_code/3_basicCfs/new1/result" 
local cf_dir_2 "$fortran_code/3_basicCfs/new2/result"
local cf_dir_3 "$fortran_code/3_basicCfs/new3/result"
local cf_dir_4 "$fortran_code/3_basicCfs/new4/result"

*-------------------------------------------------------------------------------
* Initialize output matrix (15 rows for data x 4 columns)
*-------------------------------------------------------------------------------
matrix table_detail = J(15, 4, .)

*-------------------------------------------------------------------------------
* Declare tempfiles
*-------------------------------------------------------------------------------
tempfile temp_base_contrib temp_base_hires temp_baseline
tempfile temp_cf_contrib temp_cf_hires temp_cf
tempfile temp_distinfo temp_working temp_collapsed

*-------------------------------------------------------------------------------
* Loop over the four counterfactuals
*-------------------------------------------------------------------------------
forval col = 1/4 {

    local cf_dir "`cf_dir_`col''"

    *---------------------------------------------------------------------------
    * Load baseline
    *---------------------------------------------------------------------------
    clear
    import delimited "`baseline_dir'/eqbm_dist_contribution.txt", delimiter(space, collapse) varnames(1)
    drop v1 v16
    rename avg_expect_cont contribute
    rename avg_c1 c1
    rename avg_c2 c2
    rename avg_expect_exp exp
    sort econ district_id
    save "`temp_base_contrib'", replace

    clear
    import delimited "`baseline_dir'/eqbm_dist_hires.txt", delimiter(space, collapse) varnames(1)
    drop v1 v7
    capture drop capacity
    rename expected_hires expected_hires
    sort econ dist
    save "`temp_base_hires'", replace

    use "`temp_base_contrib'", clear
    merge 1:1 econ district_id using "`temp_base_hires'"
    drop _merge
    gen totalcontr = contribute * expected_hires
    sort econ district_id
    save "`temp_baseline'", replace

    *---------------------------------------------------------------------------
    * Load counterfactual
    *---------------------------------------------------------------------------
    clear
    import delimited "`cf_dir'/eqbm_dist_contribution.txt", delimiter(space, collapse) varnames(1)
    drop v1 v16
    rename avg_expect_cont contributenew
    rename avg_c1 c1new
    rename avg_c2 c2new
    rename avg_expect_exp expnew
    sort econ district_id
    save "`temp_cf_contrib'", replace

    clear
    import delimited "`cf_dir'/eqbm_dist_hires.txt", delimiter(space, collapse) varnames(1)
    drop v1 v7
    capture drop capacity
    rename expected_hires expected_hiresnew
    rename belief_expected belief_expected_hiresnew
    sort econ dist
    save "`temp_cf_hires'", replace

    use "`temp_cf_contrib'", clear
    merge 1:1 econ district_id using "`temp_cf_hires'"
    drop _merge
    gen totalcontrnew = contributenew * expected_hiresnew
    levelsof economy_id, local(econs)
    sort econ district_id
    save "`temp_cf'", replace

    *---------------------------------------------------------------------------
    * Merge baseline and counterfactual
    *---------------------------------------------------------------------------
    use "`temp_baseline'", clear
    merge 1:1 econ district_id using "`temp_cf'"
    drop _merge

    * Keep only economies present in counterfactual
    egen OK = anymatch(economy_id), values(`econs')
    keep if OK
    drop OK

    * Merge in lambda/district info
    preserve
    clear
    import delimited "`baseline_dir'/eqbm_dist_contribution.txt", delimiter(space, collapse) varnames(1)
    drop v1 v16
    keep if economy_id == 1
    keep district_id lambda
    sort district_id
    save "`temp_distinfo'", replace
    restore

    sort district_id
    merge m:1 district_id using "`temp_distinfo'"
    drop _merge
    keep if economy_id != .

    * Create lambda quartiles
    gen quartlam = .
    replace quartlam = 4 if lambda > .5674157
    replace quartlam = 3 if lambda > .5132743 & lambda <= .5674157
    replace quartlam = 2 if lambda > .4212679 & lambda <= .5132743
    replace quartlam = 1 if lambda <= .4212679

    * Create component totals
    gen totalc1 = c1 * expected_hires * lambda
    gen totalc2 = c2 * expected_hires * (1 - lambda)
    gen totalc1new = c1new * expected_hiresnew * lambda
    gen totalc2new = c2new * expected_hiresnew * (1 - lambda)

    *---------------------------------------------------------------------------
    * Compute statistics
    *---------------------------------------------------------------------------
    
    * Save working dataset
    save "`temp_working'", replace

    * State-level (all districts)
    collapse (mean) totalcontr totalcontrnew totalc1 totalc2 totalc1new totalc2new quartlam, by(district_id)
    save "`temp_collapsed'", replace
    collapse (sum) totalcontr totalcontrnew totalc1 totalc2 totalc1new totalc2new

    matrix table_detail[1, `col'] = (totalcontrnew[1] - totalcontr[1]) / totalcontr[1] * 100
    matrix table_detail[2, `col'] = (totalc1new[1] - totalc1[1]) / totalc1[1] * 100
    matrix table_detail[3, `col'] = (totalc2new[1] - totalc2[1]) / totalc2[1] * 100

    * By quartile
    forval q = 4(-1)1 {
        use "`temp_collapsed'", clear
        keep if quartlam == `q'
        collapse (sum) totalcontr totalcontrnew totalc1 totalc2 totalc1new totalc2new

        local base_row = 3 + (4 - `q') * 3 + 1
        matrix table_detail[`base_row', `col']     = (totalcontrnew[1] - totalcontr[1]) / totalcontr[1] * 100
        matrix table_detail[`base_row' + 1, `col'] = (totalc1new[1] - totalc1[1]) / totalc1[1] * 100
        matrix table_detail[`base_row' + 2, `col'] = (totalc2new[1] - totalc2[1]) / totalc2[1] * 100
    }

    * Reload working dataset for next iteration
    use "`temp_working'", clear
}

*-------------------------------------------------------------------------------
* Build and export CSV
*-------------------------------------------------------------------------------
clear
set obs 17

gen str60 row_label = ""
gen str20 metric = ""

* State
replace row_label = "State" in 1
replace metric = "TC" in 1
replace row_label = "State" in 2
replace metric = "C1" in 2
replace row_label = "State" in 3
replace metric = "C2" in 3

* 4th quartile
replace row_label = "4th quartile lambda_d districts" in 4
replace metric = "TC" in 4
replace row_label = "4th quartile lambda_d districts" in 5
replace metric = "C1" in 5
replace row_label = "4th quartile lambda_d districts" in 6
replace metric = "C2" in 6

* 3rd quartile
replace row_label = "3rd quartile lambda_d districts" in 7
replace metric = "TC" in 7
replace row_label = "3rd quartile lambda_d districts" in 8
replace metric = "C1" in 8
replace row_label = "3rd quartile lambda_d districts" in 9
replace metric = "C2" in 9

* 2nd quartile
replace row_label = "2nd quartile lambda_d districts" in 10
replace metric = "TC" in 10
replace row_label = "2nd quartile lambda_d districts" in 11
replace metric = "C1" in 11
replace row_label = "2nd quartile lambda_d districts" in 12
replace metric = "C2" in 12

* 1st quartile
replace row_label = "1st quartile lambda_d districts" in 13
replace metric = "TC" in 13
replace row_label = "1st quartile lambda_d districts" in 14
replace metric = "C1" in 14
replace row_label = "1st quartile lambda_d districts" in 15
replace metric = "C2" in 15

* Bottom rows
replace row_label = "Bonus Rates (r0, r1)" in 16
replace metric = "" in 16
replace row_label = "Program cost ($1000 per teacher)" in 17
replace metric = "" in 17

gen str20 new1 = ""
gen str20 new2 = ""
gen str20 new3 = ""
gen str20 new4 = ""

* Fill in numeric values from matrix
forval col = 1/4 {
    forval row = 1/15 {
        local val = table_detail[`row', `col']
        local val_fmt : display %5.2f `val'
        replace new`col' = "`val_fmt'" in `row'
    }
}

* Bonus rates (hardcoded)
replace new1 = "(2.3, 3.1)" in 16
replace new2 = "(0, 7.0)" in 16
replace new3 = "(1.6, 4.3)" in 16
replace new4 = "(3.8, 0)" in 16

* Program cost (hardcoded)
replace new1 = "1.62" in 17
replace new2 = "1.62" in 17
replace new3 = "1.62" in 17
replace new4 = "1.62" in 17

export delimited using "$out/tables/Table_B18.csv", replace


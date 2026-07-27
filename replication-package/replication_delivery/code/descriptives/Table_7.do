*===============================================================================
* Table 7: State-Funded Bonuses
* Produces a CSV with % change from Base for new1, new2, new3
*===============================================================================

clear all

*-------------------------------------------------------------------------------
* Define some extra local paths for where to find results
*-------------------------------------------------------------------------------
local baseline_dir "$fortran_code/1_baseline/result"

* Three counterfactual directories (new1 = max eff, new2 = c1 only, new3 = max balance)
local cf_dir_1 "$fortran_code/3_basicCfs/new1/result" 
local cf_dir_2 "$fortran_code/3_basicCfs/new2/result"
local cf_dir_3 "$fortran_code/3_basicCfs/new3/result"

*-------------------------------------------------------------------------------
* Initialize output matrix (11 rows x 3 columns)
*-------------------------------------------------------------------------------
matrix table7 = J(11, 3, .)

*-------------------------------------------------------------------------------
* Declare tempfiles
*-------------------------------------------------------------------------------
tempfile temp_base_contrib temp_base_hires temp_baseline
tempfile temp_cf_contrib temp_cf_hires temp_cf temp_distinfo

*-------------------------------------------------------------------------------
* Loop over the three counterfactuals
*-------------------------------------------------------------------------------
forval col = 1/3 {

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
    save `temp_base_contrib', replace

    clear
    import delimited "`baseline_dir'/eqbm_dist_hires.txt", delimiter(space, collapse) varnames(1)
    drop v1 v7
    drop capacity
    rename expected_hires expected_hires
    sort econ dist
    save `temp_base_hires', replace

    use `temp_base_contrib', clear
    merge 1:1 econ district_id using `temp_base_hires'
    drop _merge
    gen totalcontr = contribute * expected_hires
    sort econ district_id
    save `temp_baseline', replace

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
    save `temp_cf_contrib', replace

    clear
    import delimited "`cf_dir'/eqbm_dist_hires.txt", delimiter(space, collapse) varnames(1)
    drop v1 v7
    drop capacity
    rename expected_hires expected_hiresnew
    rename belief_expected belief_expected_hiresnew
    sort econ dist
    save `temp_cf_hires', replace

    use `temp_cf_contrib', clear
    merge 1:1 econ district_id using `temp_cf_hires'
    drop _merge
    gen totalcontrnew = contributenew * expected_hiresnew
    levelsof economy_id, local(econs)
    sort econ district_id
    save `temp_cf', replace

    *---------------------------------------------------------------------------
    * Merge baseline and counterfactual
    *---------------------------------------------------------------------------
    use `temp_baseline', clear
    merge 1:1 econ district_id using `temp_cf'
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
    save `temp_distinfo', replace
    restore

    sort district_id
    merge m:1 district_id using `temp_distinfo'
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
    * Compute table statistics
    *---------------------------------------------------------------------------
    preserve

    * Row 1-3: All districts (collapse across economies first, then sum)
    collapse (mean) totalcontr totalcontrnew totalc1 totalc2 totalc1new totalc2new, by(district_id)
    collapse (sum) totalcontr totalcontrnew totalc1 totalc2 totalc1new totalc2new

    * Row 1: TC for all students - % change
    local pct_tc = (totalcontrnew[1] - totalcontr[1]) / totalcontr[1]
    matrix table7[1, `col'] = `pct_tc'

    * Row 2: C1 for low-achieving - % change
    local pct_c1 = (totalc1new[1] - totalc1[1]) / totalc1[1]
    matrix table7[2, `col'] = `pct_c1'

    * Row 3: C2 for high-achieving - % change
    local pct_c2 = (totalc2new[1] - totalc2[1]) / totalc2[1]
    matrix table7[3, `col'] = `pct_c2'

    restore

    * Rows 4-7: TC by lambda quartile
    forval q = 4(-1)1 {
        preserve
        collapse (mean) totalcontr totalcontrnew, by(district_id quartlam)
        keep if quartlam == `q'
        collapse (sum) totalcontr totalcontrnew
        local pct_q = (totalcontrnew[1] - totalcontr[1]) / totalcontr[1]
        local row = 4 + (4 - `q')
        matrix table7[`row', `col'] = `pct_q'
        restore
    }

    * Row 8: Bonus rates (hardcoded)
    * Will handle separately in CSV output

    *---------------------------------------------------------------------------
    * State burden statistics (Rows 9-11)
    *---------------------------------------------------------------------------
    preserve
    clear
    import delimited "`cf_dir'/state_burden.txt", delimiter(space, collapse) varnames(1)
    gen subperteach = state_subsidy / 6600
    collapse (mean) rewarded_state mean_reward_state subperteach

    * Row 9: Teachers receiving state bonuses (%)
    matrix table7[9, `col'] = rewarded_state[1] * 100

    * Row 10: Avg bonus for recipients ($1,000)
    matrix table7[10, `col'] = mean_reward_state[1]

    * Row 11: Program cost ($1,000 per teacher)
    matrix table7[11, `col'] = subperteach[1]

    restore
}

*-------------------------------------------------------------------------------
* Build and export CSV
*-------------------------------------------------------------------------------
clear
set obs 11

gen str60 row_label = ""
replace row_label = "TC for all students in the state (efficiency)" in 1
replace row_label = "C1 for low-achieving students in the state" in 2
replace row_label = "C2 for high-achieving students in the state" in 3
replace row_label = "TC in 4th quartile lambda_d districts" in 4
replace row_label = "TC in 3rd quartile lambda_d districts" in 5
replace row_label = "TC in 2nd quartile lambda_d districts" in 6
replace row_label = "TC in 1st quartile lambda_d districts" in 7
replace row_label = "Bonus Rates (r0, r1)" in 8
replace row_label = "Teachers receiving state bonuses (B>0) (%)" in 9
replace row_label = "Avg bonus for recipients E(B|B>0) ($1000)" in 10
replace row_label = "Program cost ($1000 per teacher)" in 11

gen str20 new1 = ""
gen str20 new2 = ""
gen str20 new3 = ""

* Fill in numeric values from matrix
forval col = 1/3 {
    forval row = 1/7 {
        local val = table7[`row', `col'] * 100
        local val_fmt : display %5.2f `val'
        replace new`col' = "`val_fmt'%" in `row'
    }
    * Row 9 (percentage)
    local val = table7[9, `col']
    local val_fmt : display %4.1f `val'
    replace new`col' = "`val_fmt'%" in 9

    * Row 10
    local val = table7[10, `col']
    local val_fmt : display %4.2f `val'
    replace new`col' = "`val_fmt'" in 10

    * Row 11: Program cost hardcoded
    replace new`col' = "1.62" in 11
}

* Row 8: Bonus rates (hardcoded bonus amounts)
replace new1 = "(2.3, 3.1)" in 8
replace new2 = "(0, 7.0)" in 8
replace new3 = "(1.6, 4.3)" in 8

* Rename columns for clarity
rename new1 pct_change_new1
rename new2 pct_change_new2
rename new3 pct_change_new3

export delimited using "$out/tables/Table_7.csv", replace

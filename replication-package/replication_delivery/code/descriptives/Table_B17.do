********************************************************************************
* Table B17: State-Funded Teacher Bonuses: Extensive Margin and Repeated Game
*    Produces a CSV with 2 columns 
*    Note: Cols 1 & 3 can be found in Table 7.
********************************************************************************

clear all

*-------------------------------------------------------------------------------
* Define some extra local paths for where to find results
*-------------------------------------------------------------------------------
local baseline "$fortran_code/6_forward/forward_baseline/result/"
local cf1 "$fortran_code/6_forward/forward_new1/result/"
local cf2 "$fortran_code/6_forward/forward_new2/result/"
* forward simulation goes to t=5  (i.e., t0-t5 is 6 items)
local tp = 6

* Matrix to store results: 3 rows (tc, c1, c2) x 2 columns
matrix results = J(3, 2, .)

********************************************************************************
* Loop over 2 counterfactuals
********************************************************************************
forvalues i = 1/2 {
    
    di "Processing counterfactual `i' of 2..."
    
    * --- Load baseline contribution file ---
    import delimited using "`baseline'eqbm_dist_contribution.txt", ///
    delim(" ", collapse) varnames(1) clear
	keep time_period economy_id district_id avg_expect_cont avg_c1 avg_c2 lambda
	rename avg_expect_cont contribute
	rename avg_c1 c1
	rename avg_c2 c2
	tempfile base_contr
	save `base_contr'
    
    * --- Load baseline omega file ---
    import delimited using "`baseline'eqbm_omegas.txt", ///
        delim(" ", collapse) varnames(1) clear
    keep time_period economy_id district_id
    tempfile base_omega
    save `base_omega'
    
    * --- Load baseline hires file ---
    import delimited using "`baseline'eqbm_dist_hires.txt", ///
        delim(" ", collapse) varnames(1) clear
    keep time_period economy_id district_id expected_hires
    tempfile base_hires
    save `base_hires'
    
    * --- Merge baseline files ---
    use `base_contr', clear
    merge 1:1 time_period economy_id district_id using `base_omega', nogen
    merge 1:1 time_period economy_id district_id using `base_hires', nogen
    
    gen double totalcontr = contribute * expected_hires
    gen double totalc1 = c1 * expected_hires * lambda
    gen double totalc2 = c2 * expected_hires * (1 - lambda)
    
    keep time_period economy_id district_id expected_hires lambda ///
        totalcontr totalc1 totalc2
    tempfile base_merged
    save `base_merged'
    
    * --- Load counterfactual contribution file ---
    import delimited using "`cf`i''eqbm_dist_contribution.txt", ///
        delim(" ", collapse) varnames(1) clear
    keep time_period economy_id district_id avg_expect_cont avg_c1 avg_c2
    rename avg_expect_cont cf_contribute
    rename avg_c1 cf_c1
    rename avg_c2 cf_c2
    tempfile cf_contr
    save `cf_contr'
    
    * --- Load counterfactual omega file (only need for merge key) ---
    import delimited using "`cf`i''eqbm_omegas.txt", ///
        delim(" ", collapse) varnames(1) clear
    keep time_period economy_id district_id
    tempfile cf_omega
    save `cf_omega'
    
    * --- Load counterfactual hires file ---
    import delimited using "`cf`i''eqbm_dist_hires.txt", ///
        delim(" ", collapse) varnames(1) clear
    keep time_period economy_id district_id expected_hires
    rename expected_hires cf_expected_hires
    tempfile cf_hires
    save `cf_hires'
    
    * --- Merge counterfactual files ---
    use `cf_contr', clear
    merge 1:1 time_period economy_id district_id using `cf_omega', nogen
    merge 1:1 time_period economy_id district_id using `cf_hires', nogen
    
    gen double cf_totalcontr = cf_contribute * cf_expected_hires
    
    keep time_period economy_id district_id cf_expected_hires ///
        cf_totalcontr cf_c1 cf_c2
    tempfile cf_merged
    save `cf_merged'
    
    * --- Merge baseline and counterfactual ---
    use `base_merged', clear
    merge 1:1 time_period economy_id district_id using `cf_merged', nogen
    
    * Use baseline lambda for cf type-specific totals
    gen double cf_totalc1 = cf_c1 * cf_expected_hires * lambda
    gen double cf_totalc2 = cf_c2 * cf_expected_hires * (1 - lambda)
    
    * Keep only the relevant time period
    keep if time_period == `tp'
    
    * Step 1: Average across economies (by district)
    collapse (mean) totalcontr cf_totalcontr expected_hires cf_expected_hires ///
        totalc1 cf_totalc1 totalc2 cf_totalc2, by(district_id)
    
    * Compute adjustment factor (adjust for numerical pop difference)
    egen double exphires = total(expected_hires)
    egen double cf_exphires = total(cf_expected_hires)
    
    * Adjust cf totals to be on even footing
    replace cf_totalcontr = cf_totalcontr * exphires / cf_exphires
    replace cf_totalc1 = cf_totalc1 * exphires / cf_exphires
    replace cf_totalc2 = cf_totalc2 * exphires / cf_exphires
    
    * Step 2: Sum across all districts
    collapse (sum) totalcontr cf_totalcontr totalc1 cf_totalc1 totalc2 cf_totalc2
    
    * Step 3: Compute percentage differences
    gen double pct_tc = (cf_totalcontr - totalcontr) / totalcontr
    gen double pct_c1 = (cf_totalc1 - totalc1) / totalc1
    gen double pct_c2 = (cf_totalc2 - totalc2) / totalc2
    
    * Store in matrix (multiply by 100 for percent)
    matrix results[1, `i'] = pct_tc[1] * 100
    matrix results[2, `i'] = pct_c1[1] * 100
    matrix results[3, `i'] = pct_c2[1] * 100
}

********************************************************************************
* Build output CSV
********************************************************************************
clear
set obs 3

gen str40 variable = ""
replace variable = "TC for all students" in 1
replace variable = "c1 for low-achieving students" in 2
replace variable = "c2 for high-achieving students" in 3


* Columns
gen double new1 = .
gen double new2 = .

forvalues j = 1/3 {
    replace new1 = results[`j', 1] in `j'
    replace new2 = results[`j', 2] in `j'
}

* Format to 2 decimal places for display
format new1 new2 %9.2f
	   
foreach v of varlist new1 new2 {
    gen str10 s_`v' = string(`v', "%9.2f")
    drop `v'
    rename s_`v' `v'
}

* Add note about where to find other Table B17 columns previously computed
local newobs = _N + 1
set obs `newobs'
replace variable = "Note: Baseline columns (columns 1 and 3 in Table B17) can be found in Table 7." in `newobs'

export delimited using "$out/tables/Table_B17.csv", replace

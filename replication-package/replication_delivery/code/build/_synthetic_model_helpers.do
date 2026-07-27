********************************************************************************
* Synthetic model-data helpers
********************************************************************************

capture program drop _synthetic_model_districts
program define _synthetic_model_districts
    syntax using/, Target(integer)

    preserve
    tempfile shape cz cesa distances dist1

    use "$raw/district_shapefiles/WI_School_Districts.dta", clear
    gen long district_code = real(SDID)
    keep district_code
    drop if district_code == .
    duplicates drop
    save `shape', replace

    use "$raw/district_county_cz.dta", clear
    keep district_code
    drop if district_code == .
    duplicates drop
    merge 1:1 district_code using `shape'
    keep if _merge == 3
    drop _merge
    save `cz', replace

    use "$raw/cesa.dta", clear
    keep district_code
    drop if district_code == .
    duplicates drop
    merge 1:1 district_code using `cz'
    keep if _merge == 3
    drop _merge
    save `cesa', replace

    use "$raw/district_distance_sdid.dta", clear
    destring d1, replace
    destring d2, replace
    save `distances', replace
    keep d1
    rename d1 district_code
    duplicates drop
    save `dist1', replace
    use `distances', clear
    keep d2
    rename d2 district_code
    duplicates drop
    merge 1:1 district_code using `dist1'
    keep if _merge == 3
    drop _merge
    merge 1:1 district_code using `cesa'
    keep if _merge == 3
    drop _merge

    sort district_code
    keep in 1/`target'
    count
    assert r(N) == `target'
    gen long _synthetic_district_rank = _n
    rename district_code _synthetic_district_code
    save "`using'", replace
    restore
end

capture program drop _synthetic_expand_model_years
program define _synthetic_expand_model_years
    syntax, Years(numlist integer) Target(integer) Districts(string)

    foreach model_year of numlist `years' {
        quietly count if year == `model_year'
        if r(N) > 0 {
            local base_obs = r(N)
            local copies = max(1, ceil(`target' / `base_obs'))
            quietly summarize id
            local max_id = r(max)

            preserve
            keep if year == `model_year'
            sort id
            gen long _synthetic_source_order = _n
            expand `copies'
            bysort _synthetic_source_order: gen long _synthetic_copy = _n
            sort _synthetic_copy _synthetic_source_order
            gen long _synthetic_rank = _n
            keep if _synthetic_rank <= `target'
            replace id = `max_id' + _synthetic_rank if _synthetic_copy > 1
            gen long _synthetic_district_rank = mod(_synthetic_rank - 1, 411) + 1
            merge m:1 _synthetic_district_rank using "`districts'", ///
                keep(match) nogen
            replace district_code = _synthetic_district_code
            _synth_apply_district_type
            replace schoolcode = 100000 + _synthetic_district_rank ///
                if schoolcode < .
            drop _synthetic_source_order _synthetic_copy _synthetic_rank ///
                _synthetic_district_rank _synthetic_district_code
            tempfile expanded_model_year
            save `expanded_model_year', replace
            restore

            drop if year == `model_year'
            append using `expanded_model_year'
            quietly count if year == `model_year'
            assert r(N) == `target'
            egen byte _synthetic_district_tag = tag(district_code) ///
                if year == `model_year'
            quietly count if _synthetic_district_tag == 1
            assert r(N) == 411
            drop _synthetic_district_tag
        }
    }
end

capture program drop _synth_apply_district_type
program define _synth_apply_district_type
    capture confirm variable type
    if _rc {
        gen byte type = 3
    }
    replace type = 3 if district_code < .

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
end

capture program drop _synthetic_pad_current_districts
program define _synthetic_pad_current_districts
    syntax, Districts(string)

    preserve
    use "`districts'", clear
    rename _synthetic_district_code district_code
    drop _synthetic_district_rank
    tempfile synthetic_district_codes
    save `synthetic_district_codes', replace
    restore

    merge 1:1 district_code using `synthetic_district_codes'

    ds district_code _merge, not
    local fillvars `r(varlist)'
    foreach v of local fillvars {
        capture confirm numeric variable `v'
        if !_rc {
            quietly summarize `v' if _merge == 3, meanonly
            if r(N) > 0 {
                replace `v' = r(mean) if _merge == 2
            }
            else {
                replace `v' = 0 if _merge == 2
            }
        }
        else {
            replace `v' = "" if _merge == 2
        }
    }

    keep if _merge == 2 | _merge == 3
    drop _merge
    sort district_code
    count
    assert r(N) == 411
end

capture program drop _synth_fill_missing
program define _synth_fill_missing
    syntax varlist(numeric)

    foreach v of varlist `varlist' {
        quietly summarize `v', meanonly
        if r(N) > 0 {
            replace `v' = r(mean) if missing(`v')
        }
        else {
            replace `v' = 0 if missing(`v')
        }
    }
end

capture program drop _synth_cycle_alpha_support
program define _synth_cycle_alpha_support
    sort district_code
    gen long _synthetic_alpha_rank = _n

    replace alpha0_ = .9 + .05 * mod(_synthetic_alpha_rank - 1, 5)
    replace alpha1_ = 0
    replace alpha1_ = 10000 if mod(_synthetic_alpha_rank - 1, 7) == 1
    replace alpha1_ = 30000 if mod(_synthetic_alpha_rank - 1, 7) == 2
    replace alpha1_ = 50000 if mod(_synthetic_alpha_rank - 1, 7) == 3
    replace alpha1_ = 75000 if mod(_synthetic_alpha_rank - 1, 7) == 4
    replace alpha1_ = 100000 if mod(_synthetic_alpha_rank - 1, 7) == 5
    replace alpha1_ = 200000 if mod(_synthetic_alpha_rank - 1, 7) == 6

    drop _synthetic_alpha_rank
end

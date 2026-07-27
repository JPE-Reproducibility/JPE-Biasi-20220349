********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    auxiliary_models_teachers_info_matches.do
* Purpose: Build restricted teacher offer sets for imperfect-information
*          auxiliary models.
********************************************************************************


global controls = "std_score_past disab_status el_status econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind"

* Imperfect-information inputs are stored with the estimation/model data unless
* a caller has already pointed $info elsewhere.
if "$info" == "" {
    global info "$est"
}

local using_synthetic = strpos(lower("$confdata"), "synthetic_data") > 0
local synthetic_mover_id_cap = 250


********************************************************************************
* Create datasets
********************************************************************************

forvalues info_version = 0/3 {
    di as text "Building main dataset for imperfect-information version `info_version'"
	use "$info/wage_info`info_version'.dta", clear
	sort id
	merge 1:1 id using "$info/experience_info`info_version'.dta"
	drop _m
	sort id
	merge 1:1 id using "$info/experiencecont_info`info_version'.dta"
	drop _m
	sort id
	merge 1:1 id using "$info/master_info`info_version'.dta"
	drop _m
	sort id
	merge 1:1 id using "$info/contributions_info`info_version'.dta"
	drop _m
	rename v0 v0tilde
	rename v1 v1tilde
	rename V0 V0tilde
	rename V1 V1tilde
	drop xb*
	sort id
	merge 1:1 id using "$est/contributions.dta"
	drop _m
	sort id
	merge 1:1 id using "$info/match_info`info_version'.dta"
	drop _m
	sort id
	merge 1:1 id using "$info/incumbent_info`info_version'.dta"
	drop _m
	sort id
	merge 1:1 id using "$info/samecz_info`info_version'.dta"
	drop _m

	gen n = 1

	merge m:1 n using "$info/lambda_info`info_version'.dta"
	drop _m
	merge m:1 n using "$info/enrollment_info`info_version'.dta"
	drop _m
	merge m:1 n using "$info/budget_info`info_version'.dta"
	drop _m
	merge m:1 n using "$info/budget_past_info`info_version'.dta"
	drop _m
	merge m:1 n using "$info/urban_info`info_version'.dta"
	drop _m
	merge m:1 n using "$info/suburban_info`info_version'.dta"
	drop _m
	merge m:1 n using "$est/alphagrid.dta"
	drop _m

	reshape long wage Match Inc samecz d N budget capacity budget_past capacity_past urban suburban alpha0_ alpha1_, i(id) j(District)

	sort id District

	gen C0d = (V0tilde + xb0) * d
	gen C1d = (V1tilde + xb1) * (1 - d)
	save $info/multinomial_info`info_version'.dta, replace
}


********************************************************************************
* Build Matched-Mover Sets by Imperfect-Information Version
********************************************************************************

forvalues info_version = 0/3 {
    di as text "Building matched movers for imperfect-information version `info_version'"

    use "$info/multinomial_info`info_version'.dta", clear

    * Experience group.
    gen exp = 1
    forvalues n = 2/6 {
        replace exp = `n' if Exp`n' == 1
    }

    bysort id: egen exit = max(Match)
    replace exit = 1 - exit
    bysort id: egen INC = max(Inc)

    * Keep offers that happened for sure: non-tenured movers, tenured movers in
    * the new district, and tenured teachers in incumbent districts.
    keep if ((Exp2 == 1 & Match == 1) | ///
        (Inc == 0 & Match == 1 & Exp1 == 0 & Exp2 == 0 & INC == 1) | ///
        (Inc == 1 & Match == 0 & Exp1 == 0 & Exp2 == 0 & INC == 1)) & ///
        exit == 0

    keep id District C0 C1 exp wage Inc samecz d Match urban suburban masterup
    sort id

    * The public synthetic data now carry the full 411-district choice set.
    * Keep the expensive restricted-offer-set loop bounded in synthetic runs;
    * real-data runs still use the complete matched-mover sample.
    if `using_synthetic' {
        bysort id: gen byte _synthetic_id_tag = _n == 1
        gen long _synthetic_id_rank = sum(_synthetic_id_tag)
        keep if _synthetic_id_rank <= `synthetic_mover_id_cap'
        drop _synthetic_id_tag _synthetic_id_rank
    }

    tempfile mover_seed mover_choices
    save `mover_seed', replace

    * Create an empty dataset with the same variables for accumulating choices.
    preserve
    drop if id > 0
    save `mover_choices', replace
    restore

    * Based on movers, construct the restricted offer set.
    qui levelsof id, local(ID)
    local t = 1
    qui foreach teacher_id of local ID {
        noisily disp "teacher n. `t'"

        sum District if id == `teacher_id' & Match == 1
        local dist = r(mean)
        qui sum C0 if id == `teacher_id' & Match == 1
        local C0 = r(mean)
        qui sum C1 if id == `teacher_id' & Match == 1
        local C1 = r(mean)
        qui sum exp if id == `teacher_id' & Match == 1
        local exp = r(mean)
        qui sum wage if id == `teacher_id' & Match == 1
        local wage = r(mean)
        qui sum masterup if id == `teacher_id' & Match == 1
        local masterup = r(mean)

        preserve
        use "$info/multinomial_info`info_version'.dta", clear

        gen exp = 1
        forvalues n = 2/6 {
            replace exp = `n' if Exp`n' == 1
        }

        gen TAG = .
        replace TAG = 1 if C0 >= `C0' & C1 >= `C1' & exp >= `exp' & ///
            wage <= `wage' & masterup >= `masterup' & ///
            District == `dist' & Match == 0

        bysort id: egen TTAG = max(TAG)
        keep if TTAG == 1 & (TAG == 1 | Match == 1)
        noisily count

        keep id District v0 v1 exp wage Inc samecz C0 C1 d Match urban ///
            suburban masterup
        append using `mover_choices'
        sort id
        save `mover_choices', replace
        restore

        local t = `t' + 1
    }

    use `mover_choices', clear

    * Append the original seeds.
    append using `mover_seed'
    duplicates drop
    sort id District
    save "$est/matched_movers_info`info_version'.dta", replace
}

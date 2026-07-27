********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    schedule_new.do
* Purpose: Build and analyze district-specific wage schedules.
********************************************************************************

global controls = "std_score_past disab_status el_status econ_disadvantage Sfemale Sblack Shispanic Sasian Sam_ind"


********************************************************************************
* Prepare Pre-Act 10 Wage Data
********************************************************************************

use "$intdata/teachers_panel_JPE.dta", clear

* Generate combined CESA-by-type identifier.
gen cesatype = type * 10000 + cesa

* Estimate pre-Act 10 wage schedules, fully district-specific.
keep if year <= 2011

* Generate fictitious teachers for district-by-experience cells that need them.
levelsof district_code, local(D)
foreach d of local D {
    forvalues e = 1/6 {
        forvalues m = 0/1 {
            qui tab id if exp == `e' & masterup == `m' & ///
                district_code == `d'
            if `r(r)' == 0 {
                disp "district = `d'"
                set obs `=_N+1'
                replace id = _N + 500000000000 if id == .
                replace exp = `e' if id == _N + 500000000000
                replace masterup = `m' if id == _N + 500000000000
                replace district_code = `d' if id == _N + 500000000000
            }
        }
    }
}

* Estimate district-specific wage schedule cells.
sort district_code
levelsof district_code, local(D)
foreach d of local D {
    gen E1_`d' = district_code == `d' & exp == 1
    gen E2_`d' = district_code == `d' & exp == 2
    gen E3_`d' = district_code == `d' & exp == 3
    gen E4_`d' = district_code == `d' & exp == 4
    gen E5_`d' = district_code == `d' & exp == 5
    gen E6_`d' = district_code == `d' & exp == 6

    gen M1_`d' = district_code == `d' & masterup == 1
}

qui reg salary_round E*_* M1_*, noco
gen mode = .

qui levelsof district_code, local(D)
foreach d of local D {
    forvalues e = 1/6 {
        replace mode = _b[E`e'_`d'] if district_code == `d' & ///
            exp == `e' & masterup == 0
        replace mode = _b[E`e'_`d'] + _b[M1_`d'] if ///
            district_code == `d' & exp == `e' & masterup == 1
    }
}

forvalues exp = 1/6 {
    gen CExp`exp'_ba = mode if exp == `exp' & masterup == 0
    gen CExp`exp'_ma = mode if exp == `exp' & masterup == 1
}

* Collapse to one wage-schedule row per district.
collapse (mean) C*, by(district_code)
forvalues exp = 1/6 {
    replace CExp`exp'_ba = . if CExp`exp'_ba == 0
    replace CExp`exp'_ma = . if CExp`exp'_ma == 0
}
sort district_code


********************************************************************************
* Fill Missing Wage-Schedule Cells
********************************************************************************

foreach Var in CExp1_ba CExp1_ma {
    levelsof district_code if `Var' == ., local(D)
    foreach var in CExp2_ba CExp2_ma CExp3_ba CExp3_ma CExp4_ba ///
        CExp4_ma CExp5_ba CExp5_ma CExp6_ba CExp6_ma {
        foreach d of local D {
            qui tab `Var' if district_code == `d'
            if `r(r)' == 0 {
                qui tab `var' if district_code == `d'
                if `r(r)' > 0 {
                    sum `var' if district_code == `d'
                    local z = `r(mean)'
                    disp "district = `d'"
                    qui levelsof district_code if `var' != . & ///
                        `Var' != . & district_code != `d', local(DD)
                    local gap = 1000000
                    foreach dd of local DD {
                        qui sum `var' if district_code == `dd'
                        local dev = abs(`z' - `r(mean)')
                        local y = `r(mean)'
                        if `dev' < `gap' {
                            disp `dev'
                            qui sum `Var' if district_code == `dd'
                            replace `Var' = `y' if district_code == `d'
                            local gap = `dev'
                        }
                    }
                }
            }
        }
    }
}

foreach Var in CExp2_ba CExp2_ma {
    levelsof district_code if `Var' == ., local(D)
    foreach var in CExp3_ba CExp3_ma CExp4_ba CExp4_ma CExp5_ba ///
        CExp5_ma CExp6_ba CExp6_ma {
        foreach d of local D {
            qui tab `Var' if district_code == `d'
            if `r(r)' == 0 {
                qui tab `var' if district_code == `d'
                if `r(r)' > 0 {
                    sum `var' if district_code == `d'
                    local z = `r(mean)'
                    disp "district = `d'"
                    qui levelsof district_code if `var' != . & ///
                        `Var' != . & district_code != `d', local(DD)
                    local gap = 1000000
                    foreach dd of local DD {
                        qui sum `var' if district_code == `dd'
                        local dev = abs(`z' - `r(mean)')
                        local y = `r(mean)'
                        if `dev' < `gap' {
                            disp `dev'
                            qui sum `Var' if district_code == `dd'
                            replace `Var' = `y' if district_code == `d'
                            local gap = `dev'
                        }
                    }
                }
            }
        }
    }
}

foreach Var in CExp3_ba CExp3_ma {
    levelsof district_code if `Var' == ., local(D)
    foreach var in CExp4_ba CExp4_ma CExp5_ba CExp5_ma CExp6_ba CExp6_ma {
        foreach d of local D {
            qui tab `Var' if district_code == `d'
            if `r(r)' == 0 {
                qui tab `var' if district_code == `d'
                if `r(r)' > 0 {
                    sum `var' if district_code == `d'
                    local z = `r(mean)'
                    disp "district = `d'"
                    qui levelsof district_code if `var' != . & ///
                        `Var' != . & district_code != `d', local(DD)
                    local gap = 1000000
                    foreach dd of local DD {
                        qui sum `var' if district_code == `dd'
                        local dev = abs(`z' - `r(mean)')
                        local y = `r(mean)'
                        if `dev' < `gap' {
                            disp `dev'
                            qui sum `Var' if district_code == `dd'
                            replace `Var' = `y' if district_code == `d'
                            local gap = `dev'
                        }
                    }
                }
            }
        }
    }
}

foreach Var in CExp4_ba CExp4_ma {
    levelsof district_code if `Var' == ., local(D)
    foreach var in CExp5_ba CExp5_ma CExp6_ba CExp6_ma {
        foreach d of local D {
            qui tab `Var' if district_code == `d'
            if `r(r)' == 0 {
                qui tab `var' if district_code == `d'
                if `r(r)' > 0 {
                    sum `var' if district_code == `d'
                    local z = `r(mean)'
                    disp "district = `d'"
                    qui levelsof district_code if `var' != . & ///
                        `Var' != . & district_code != `d', local(DD)
                    local gap = 1000000
                    foreach dd of local DD {
                        qui sum `var' if district_code == `dd'
                        local dev = abs(`z' - `r(mean)')
                        local y = `r(mean)'
                        if `dev' < `gap' {
                            disp `dev'
                            qui sum `Var' if district_code == `dd'
                            replace `Var' = `y' if district_code == `d'
                            local gap = `dev'
                        }
                    }
                }
            }
        }
    }
}

foreach Var in CExp5_ba CExp5_ma {
    levelsof district_code if `Var' == ., local(D)
    foreach var in CExp6_ba CExp6_ma {
        foreach d of local D {
            qui tab `Var' if district_code == `d'
            if `r(r)' == 0 {
                qui tab `var' if district_code == `d'
                if `r(r)' > 0 {
                    sum `var' if district_code == `d'
                    local z = `r(mean)'
                    disp "district = `d'"
                    qui levelsof district_code if `var' != . & ///
                        `Var' != . & district_code != `d', local(DD)
                    local gap = 1000000
                    foreach dd of local DD {
                        qui sum `var' if district_code == `dd'
                        local dev = abs(`z' - `r(mean)')
                        local y = `r(mean)'
                        if `dev' < `gap' {
                            disp `dev'
                            qui sum `Var' if district_code == `dd'
                            replace `Var' = `y' if district_code == `d'
                            local gap = `dev'
                        }
                    }
                }
            }
        }
    }
}

* The compact public synthetic panel has pre-Act 10 wage observations for only
* a small subset of districts. The model and forward repeated-game exercises,
* however, use the same 411-district choice set. Only for synthetic runs, add
* the missing canonical model districts and fill their schedule cells with the
* corresponding means among observed synthetic districts. Restricted-data
* runs retain their original district coverage and estimated schedules.
local using_synthetic = strpos(lower("$confdata"), "synthetic_data") > 0
if `using_synthetic' {
    do "$code/build/_synthetic_model_helpers.do"
    tempfile synthetic_districts
    _synthetic_model_districts using "`synthetic_districts'", target(411)
    _synthetic_pad_current_districts, districts("`synthetic_districts'")
    _synth_fill_missing CExp*_ba CExp*_ma

    isid district_code
    count
    assert r(N) == 411
    foreach v of varlist CExp*_ba CExp*_ma {
        assert !missing(`v')
    }
}

save "$intdata/schedule_new_JPE.dta", replace

* The forward repeated-game code expects the completed wage schedule alongside
* the other model inputs. Copy the canonical intermediate file so the two
* files remain exactly identical rather than maintaining a second build path.
copy "$intdata/schedule_new_JPE.dta" "$est/schedule_new.dta", replace

*********************************************************************************************************
*																										*
*			Equilibrium in the Market for Public School Teachers	(Biasi, Fu, Stromme JPE)			*
*			Master file for Stata Code																	*
*			June 2026																					*
*********************************************************************************************************

clear all
* Keep the public workflow within the limit supported by both Stata/SE and
* Stata/MP. The synthetic build does not require a larger variable ceiling.
set maxvar 32000
set seed 12345
set sortseed 12345
set scheme plotplain
set varabbrev on

********************************************************************************
* Install Required Stata Packages
********************************************************************************
foreach pkg in estout ftools reghdfe coefplot binscatter carryforward ///
    spmap sepscatter {
    capture noisily ssc install `pkg', replace
    if _rc {
        display as text "Could not refresh `pkg' from SSC; continuing with locally installed packages."
    }
}

********************************************************************************
* Locate the replication root
********************************************************************************
* Canonical invocation: start Stata in the replication root and run
*     do code/master_synth.do
* Running from code/ is also supported.
local launch_dir `"`c(pwd)'"'
capture confirm file `"`launch_dir'/code/master_synth.do"'
if _rc {
    capture confirm file `"`launch_dir'/master_synth.do"'
    if !_rc {
        quietly cd `"`launch_dir'/.."'
        local launch_dir `"`c(pwd)'"'
    }
}
capture confirm file `"`launch_dir'/code/master_synth.do"'
if _rc {
    display as error "Could not locate the replication root."
    display as error "Start Stata in the replication root and run: do code/master_synth.do"
    exit 601
}
global rootpath `"`launch_dir'"'
quietly cd "$rootpath"

global code = "$rootpath/code/"
global confdata = "$rootpath/synthetic_data"
global raw = "$rootpath/real_data"
global intdata = "$rootpath/intermediate_data"
global est = "$rootpath/model_data/"
global sim = "$rootpath/simulation_data/"
global out = "$rootpath/out_synth/"

* A clean public checkout may not contain generated working/output folders.
* Create them before build and exhibit scripts attempt to save files.
capture mkdir "$intdata"
capture mkdir "$est"
capture mkdir "$sim"
capture mkdir "$out"
capture mkdir "$out/tables"
capture mkdir "$out/figures"



********************************************************************************
* Description of datasets
********************************************************************************

/*
*---> Raw data
+ cesa.dta - contains crosswalk between Wisconsin CESA and school districts, manually created by authors using information from https://dpi.wi.gov/schooldirectory/public#About.
+ wisconsin_elections.xlsx --> publicly available data, access and crosswalk explained in real_data/readme_elections.rtf.
+ crosswalk_district_county.dta --> crosswalk districts to counties, prepared by the authors using data from Opportunity Insights.
+ crosswalk_census_state_id.csv --> crosswalk Census district ID to state district id, prepared by the authors using data from NCES.
+ district_county_cz.dta --> crosswalk districts to counties to commuting zones, prepared by the authors using data from Opportunity Insights.
+ district_distance_sdid.dta --> matrix of district distances, constructed by the authors using data from Google Maps.


*---> Intermediate data
+ teachers_new.dta - contains main teacher panel from raw WDPI Staff files
+ indtest_math_split.dta - contains student test scores from raw WDPI Staff files
+ va_teacherside_math.dta - contains list of teachers and grade assignments, in long form
+ va_highlow_math_expdisc.dta - contains main teacher contribution measures. Constructed in valueadded_calculation.do
+ va_nocomparativeadv.dta - contains teacher contribution w/o comparative advantage. Constructed in valueadded_calculation_nocomparativeadv.do
+ schedule_new.dta - generates pre-reform wage schedule. Constructed in schedule_new.do
+ alphagrid_8groups_lambdad.dta - generates the omegas for each district. Constructed in gen_omegas.do
+ omega_analysis_data.dta - dataset to perform wage aux regressions



*---> Analysis data
+ teachers_panel.dta - teacher panel used for analysis. Constructed in teachers_with_allva.do

*---> Estimation data
+ alphagrid_12.dta, budget_past_long.dta, budget_past.dta, budget_long.dta, budget.dta, info_all.dta, wage.dta, wageschedule.dta, experience.dta, experiencecont.dta, master.dta, contributions.dta, match.dta, incumbent.dta, samecz.dta, lambda.dta, enrollment.dta, urban.dta, suburban.dta, lndist.csv, multinomial.dta. Constructed in build_model_dataset.do

*---> Simulation data
+ budget_past_long_pre_NEW.dta, budget_past_pre_NEW.dta, budget_long_pre_NEW.dta, budget_NEW.dta, info_all_pre_NEW.dta, wage_pre_NEW.dta, wageschedule_pre_NEW.dta, experience_pre_NEW.dta, experiencecont_pre_NEW.dta, master_pre_NEW.dta, contributions_pre_NEW.dta, match_pre_NEW.dta, incumbent_pre_NEW.dta, samecz_pre_NEW.dta, lambda_pre_NEW.dta, lambdaold_pre_NEW.dta, enrollment_pre_NEW.dta, urban_pre_NEW.dta, suburban_pre_NEW.dta. Constructed in build_model_dataset_pre2011.do

*/



********************************************************************************
* Generating analysis datasets
********************************************************************************


* Generate teacher panel, without teacher contribution measures
do $code/build/oldteacher_roster_build.do // All staff file - old version
do $code/build/staff_build.do // All staff file - new version
do $code/build/teachers_build.do // All teachers file
do $code/build/teachers_panel.do // Final panel without VA

* Generate clean test score dataset and teacher info dataset to use for VA estimation
do $code/build/va_teacherside_build.do 
do $code/build/testscores_build.do 

* Estimate teacher contribution measures (Model 1, Model 2, and no comparative advantage)
do $code/build/valueadded_calculation.do // Model 1
do $code/build/valueadded_calculation_classmodel.do // Model 2
do $code/build/valueadded_calculation_stockstaiger_nocomparativeadv.do // No comparative advantage

* Generate final analysis panel
do $code/build/teachers_with_allva.do

* Generate model estimation data files (2014)
do $code/build/schedule_new.do
do $code/build/gen_omegas.do
set seed 12345
set sortseed 12345
do $code/build/gen_omegas_info.do
do $code/build/build_model_dataset.do
do $code/build/build_teachers_offer_set.do
do $code/auxiliary_regressions/auxiliary_models_teachers.do
do $code/auxiliary_regressions/aux_other_moments.do
do $code/auxiliary_regressions/auxiliary_models_districts.do
do $code/build/build_model_dataset_info0.do
do $code/build/build_model_dataset_info1.do
do $code/build/build_model_dataset_info2.do
do $code/build/build_model_dataset_info3.do
do $code/build/auxiliary_models_teachers_info_matches.do

do $code/build/omega_databuild.do
do $code/build/budget_overtime.do

do $code/build/build_distance_matrix.do
do $code/build/build_wageschedule_exitentry.do
do $code/build/fix_estsample_age.do

* Generate model simulation data files (2011)
do $code/build/build_model_dataset_pre2011.do
do $code/build/build_simulation_lndist.do




********************************************************************************
* Generating Tables and Figures - Main paper
********************************************************************************


* Tables 1, 3 
do $code/descriptives/summary.do

* Table 2
do $code/auxiliary_regressions/aux_model_teachers_wages.do

* Table 4
do $code/descriptives/omega_analysis.do

* Tables 5-8, Tables A1, A2, A3
* Note: These can be produced "produce_exhibits.do". They rely on fortran results

* Figures 1, 2, 3
do $code/descriptives/data_patterns.do

* Figure 4 - produced by "produce_exhibits.do"

********************************************************************************
* Generating Tables and Figures -  Appendix
********************************************************************************


* Table B1 
//do $code/build/valueadded_calculation.do 

* Table B2 
do $code/descriptives/appendix_figures.do 

* Table B3
do $code/descriptives/rothstein_test.do 

* Table B4
do $code/build/valueadded_calculation_classmodel.do 

* Table B5 
do $code/auxiliary_regressions/auxmodels_teachers_varobust.do 

* Table B7
do $code/descriptives/c1c2_variation_studentlevel.do 

* Table B8
do $code/descriptives/achievement_race.do 

* Table B9
do $code/descriptives/schedule_summary.do

* Table B10
do $code/descriptives/salary_variation.do

* Table B11
do $code/auxiliary_regressions/auxiliary_models_teachers_info.do 

* Table B12
do $code/auxiliary_regressions/auxiliary_models_teachers_nobottom.do 

* Table B13
do $code/auxiliary_regressions/auxiliary_models_teachers_richprefs.do 

* Table B14, B16-B20, B22-B25
* Note: These are produced by "produce_exhibits.do". They rely on fortran results

* Table B15
capture mkdir "$out/tables"
do $code/descriptives/Table_B15.do

* Table B21
do $code/descriptives/summary_simulation.do


* Figure B1 
//do $code/descriptives/appendix_figures.do 

* Figure B2 
//do $code/descriptives/appendix_figures.do 

* Figure B3
//do $code/descriptives/appendix_figures.do

* Figure B4
do $code/descriptives/gen_omegas_3omegas.do

* Figure B5
do $code/descriptives/gen_omegas_tenured.do

* Figure B6
do $code/descriptives/gen_omegas_exp1cutoff.do

* Figure B7
do $code/descriptives/budget_shifts.do

* Figure B8
//do $code/descriptives/budget_shifts.do

* Figure B9 
* Note: This is produced by "produce_exhibits.do".

* B10
do $code/descriptives/lambda_map.do


********************************************************************************
* Normalize synthetic log tables for reproducible public outputs
********************************************************************************

quietly {
    local synth_logfiles : dir "$out/tables" files "*.log"
    foreach synth_log of local synth_logfiles {
        local clean_synth_log "$out/tables/__clean_`synth_log'"
        capture erase "`clean_synth_log'"
        file open synth_in using "$out/tables/`synth_log'", read text
        file open synth_out using "`clean_synth_log'", write text

        local skip_log_path_continuation = 0
        file read synth_in line
        while r(eof) == 0 {
            local normalized_line = ustrregexra(`"`macval(line)'"', ///
                "/[^ ]*/St[0-9]+\.[0-9A-Za-z]+", "/TEMP/StTEMP")
            local write_synth_line = 1
            if `skip_log_path_continuation' & ///
                substr(strtrim(`"`macval(normalized_line)'"'), 1, 1) == ">" {
                local write_synth_line = 0
            }
            local skip_log_path_continuation = 0

            if `write_synth_line' {
                if strpos(`"`macval(normalized_line)'"', "       log:") == 1 {
                    file write synth_out ///
                        "       log:  deterministic synthetic exhibit log" _n
                    local skip_log_path_continuation = 1
                }
                else if strpos(`"`macval(normalized_line)'"', " opened on:") {
                    file write synth_out ///
                        " opened on:  deterministic synthetic run" _n
                }
                else if strpos(`"`macval(normalized_line)'"', " closed on:") {
                    file write synth_out ///
                        " closed on:  deterministic synthetic run" _n
                }
                else {
                    file write synth_out `"`macval(normalized_line)'"' _n
                }
            }
            file read synth_in line
        }

        file close synth_in
        file close synth_out
        copy "`clean_synth_log'" "$out/tables/`synth_log'", replace
        capture erase "`clean_synth_log'"
    }
}

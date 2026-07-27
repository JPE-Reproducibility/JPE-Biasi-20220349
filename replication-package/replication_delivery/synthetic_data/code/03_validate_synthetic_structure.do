version 19
clear all
set more off
* Remain portable across Stata/SE and Stata/MP.
set maxvar 32000
set seed 20260613
set sortseed 20260613

/*
Public validation for simulated/synthetic raw files.

This script checks file presence, structural compatibility, cross-file key
alignment, broad panel properties, and a smoke run of the required build block
using temporary intermediate outputs.
*/

if "$SYNTH_ROOT" == "" {
    capture confirm file "synthetic_data/code/00_project_globals.do"
    if !_rc {
        do synthetic_data/code/00_project_globals.do
    }
    else {
        do code/00_project_globals.do
    }
}

if "$REPL_ROOT" == "" {
    local REPL_ROOT "$SYNTH_ROOT/.."
}
else {
    local REPL_ROOT "$REPL_ROOT"
}

local SMOKE_ROOT "`c(tmpdir)'/wisconsin_competition_synth_stage2"
local SMOKE_INT "`SMOKE_ROOT'/intermediate_data"
local SMOKE_OUT "`SMOKE_ROOT'/out_synth"
local SMOKE_EST "`SMOKE_ROOT'/model_data"
local SMOKE_SIM "`SMOKE_ROOT'/simulation_data"

program define _require_file
    args f
    capture confirm file "`f'"
    if _rc {
        display as error "Missing required synthetic file: `f'"
        exit 601
    }
end

program define _check_old_staff_txt
    syntax, Year(integer)
    local yy = substr("`year'", 3, 2)
    quietly infix ///
        id              1   -   9   ///
    str lastname        10  -   29  ///
    str firstname       30  -   45  ///
    str gender          46  -   46  ///
    str race            47  -   47  ///
        birth           48  -   51  ///
    str highedu         52  -   52  ///
        dayscontract    62  -   64  ///
        localexp        66  -   68  ///
        totalexp        69  -   71  ///
        salary          72  -   78  ///
        fringe          79  -   85  ///
        staffcat        98  -   98  ///
        hireagencycode  101 -   104 ///
        workagencycode  105 -   108 ///
        hireagencytype  109 -   110 ///
        schoolcode      111 -   114 ///
        position        115 -   116 ///
        area            117 -   120 ///
    str lowgrade        121 -   122 ///
    str highgrade       123 -   124 ///
        lowgradecode    125 -   126 ///
        highgradecode   127 -   128 ///
    str bilingual       129 -   129 ///
        fte             130 -   132 ///
    str workagencyname  147 -   176 ///
    str schoolname      177 -   206 ///
    str gradelevel      207 -   207 ///
    str cesa            208 -   209 ///
        county          210 -   211 ///
        workagencytype  242 -   243 ///
    str zipcode         443 -   452 ///
    str lt_substitute   551 -   551 ///
    str subcontracted   552 -   552 ///
        using "$SYN_DIR_1/`yy'staff.txt", clear
    quietly ds
    local nvars : word count `r(varlist)'
    assert `nvars' == 34
    assert _N > 0
    assert id < .
    assert salary > 0
    assert dayscontract > 0
    assert fte > 0
    gen int year = `year'
end

program define _check_new_staff_txt
    syntax, Year(integer)
    local yy = substr("`year'", 3, 2)
    quietly infix ///
        id              1-10    ///
    str lastname        11-30   ///
    str firstname       31-46   ///
    str filenumber      47-52   ///
    str gender          53-53   ///
    str race            54-54   ///
        birth           55-58   ///
    str highedu         59-59   ///
        dayscontract    69-71   ///
        localexp        72-75   ///
        totalexp        76-78   ///
        salary          79-85   ///
        fringe          86-92   ///
        staffcat        105-105 ///
        hireagencycode  106-111 ///
        workagencycode  112-115 ///
        hireagencytype  116-117 ///
        schoolcode      118-121 ///
        position        122-123 ///
        area            124-127 ///
    str lowgrade        128-129 ///
    str highgrade       130-131 ///
        lowgradecode    132-133 ///
        highgradecode   134-135 ///
    str bilingual       136-136 ///
        fte             137-139 ///
    str workagencyname  140-183 ///
    str schoolname      184-213 ///
    str gradelevel      214-214 ///
    str cesa            215-216 ///
        county          217-218 ///
        workagencytype  249-250 ///
    str zipcode         450-459 ///
    str lt_substitute   557-557 ///
    str subcontracted   558-558 ///
        using "$SYN_DIR_1/`yy'staff.txt", clear
    quietly ds
    local nvars : word count `r(varlist)'
    assert `nvars' == 35
    assert _N > 0
    assert id < .
    assert salary > 0
    assert dayscontract > 0
    assert fte > 0
    gen int year = `year'
end

program define _assert_no_missing_current_data
    foreach v of varlist _all {
        assert !missing(`v')
    }
end

program define _check_output_csv
    args f rows cols delimiter

    if "`delimiter'" == "tab" {
        insheet using "`f'", tab clear
    }
    else {
        insheet using "`f'", clear
    }

    assert _N == `rows'
    assert c(k) == `cols'
    _assert_no_missing_current_data
end

program define _check_binary_pair_csv
    args f1 f2 rows cols delimiter

    _check_output_csv "`f1'" `rows' `cols' "`delimiter'"
    local actual_cols = c(k)
    forvalues j = 1/`actual_cols' {
        assert inlist(v`j', 0, 1)
        rename v`j' urban`j'
    }
    gen byte _row = _n
    tempfile first_file
    save `first_file', replace

    _check_output_csv "`f2'" `rows' `cols' "`delimiter'"
    forvalues j = 1/`actual_cols' {
        assert inlist(v`j', 0, 1)
    }
    gen byte _row = _n
    merge 1:1 _row using `first_file'
    assert _merge == 3
    drop _merge

    local rural_cells = 0
    forvalues j = 1/`actual_cols' {
        assert urban`j' + v`j' <= 1
        quietly count if urban`j' + v`j' == 0
        local rural_cells = `rural_cells' + r(N)
    }
    assert `rural_cells' > 0
end

********************************************************************************
* Required Files
********************************************************************************

foreach f in ///
    "$SYN_DIR_1/06staff.txt" ///
    "$SYN_DIR_1/07staff.txt" ///
    "$SYN_DIR_1/08staff.txt" ///
    "$SYN_DIR_1/09staff.txt" ///
    "$SYN_DIR_1/10staff.txt" ///
    "$SYN_DIR_1/11staff.txt" ///
    "$SYN_DIR_1/12staff.txt" ///
    "$SYN_DIR_1/13staff.txt" ///
    "$SYN_DIR_1/14staff.txt" ///
    "$SYN_DIR_1/15staff.csv" ///
    "$SYN_DIR_1/16staff.csv" ///
    "$SYN_DIR_1/temp.dta" ///
    "$SYN_DIR_2/dem.dta" ///
    "$SYN_DIR_2/student_demographics.csv" ///
    "$SYN_DIR_2/testscores.csv" ///
    "$SYNTH_ROOT/raw/teacher_data_linked/Linked_Staffing_Data_10202015.csv" {
    _require_file "`f'"
}

********************************************************************************
* Staff Structure and Panel Checks
********************************************************************************

tempfile staff_all staff_ids prev_ids cur_ids dem_csv

clear
save `staff_all', emptyok replace

foreach yr in 2006 2007 2008 2009 2010 2011 {
    _check_old_staff_txt, year(`yr')
    append using `staff_all'
    save `staff_all', replace
}

foreach yr in 2012 2013 2014 {
    _check_new_staff_txt, year(`yr')
    append using `staff_all'
    save `staff_all', replace
}

foreach yr in 2015 2016 {
    local yy = substr("`yr'", 3, 2)
    import delimited "$SYN_DIR_1/`yy'staff.csv", varnames(1) case(preserve) clear
    quietly ds
    local nvars : word count `r(varlist)'
    assert `nvars' == 49
    foreach v in IDNbr LastName FirstName FileNumber Gndr RaceEthn BirthYear ///
        CntrctDays LocalExp TotalExp TotSalary TotFringe StaffCat ///
        HireAgncyCd WorkAgncyCd HireAgncyTyp SchoolCd PositionCd ///
        AssgnAreaCd LowGrd HighGrd LGSortCd HGSortCd Bilingual AssgnFTE {
        confirm variable `v'
    }
    gen float id = IDNbr
    gen int year = `yr'
    gen float position = PositionCd
    gen float totalexp = TotalExp
    keep id year position totalexp
    append using `staff_all'
    save `staff_all', replace
}

use `staff_all', clear
bysort id year: gen byte first_idyear = _n == 1
bysort id year: gen int assignments = _N
bysort year: egen int n_idyears = total(first_idyear)
bysort year: egen int n_single = total(first_idyear & assignments == 1)
gen double single_share = n_single / n_idyears
assert inrange(single_share, .85, .95)
bysort year: egen int n_single_pos53 = ///
    total(first_idyear & assignments == 1 & position == 53)
gen double pos53_share = n_single_pos53 / n_single
assert inrange(pos53_share, .85, .95)

gen double exp_effective = cond(year <= 2014, totalexp / 10, totalexp)
preserve
keep if first_idyear
xtset id year
gen double exp_change = exp_effective - L.exp_effective
assert exp_change == 1 if exp_change < .
restore

preserve
keep id year
gen long staff_idx = id - 100000
gen int support_seq = mod(staff_idx, 1000)
drop if inrange(support_seq, 101, 126) | inrange(support_seq, 260, 289)
drop staff_idx support_seq
duplicates drop
save `staff_ids', replace
forvalues yr = 2007/2016 {
    use `staff_ids', clear
    keep if year == `=`yr' - 1'
    drop year
    duplicates drop
    save `prev_ids', replace

    use `staff_ids', clear
    keep if year == `yr'
    drop year
    duplicates drop
    merge 1:1 id using `prev_ids'
    quietly count if _merge == 3
    local both = r(N)
    quietly count if _merge == 2 | _merge == 3
    local prev = r(N)
    assert (`both' / `prev') >= .90
}
restore

use "$SYN_DIR_1/temp.dta", clear
foreach v in id lastname firstname filenumber gender race birth district_code ///
    year twolast twofirst {
    confirm variable `v'
}
assert _N > 0

********************************************************************************
* Student/Test-Score Structure and Merge Checks
********************************************************************************

use "$SYN_DIR_2/dem.dta", clear
foreach v in student_key disab_status el_status econ_disadvantage year ///
    Sfemale Sblack Shispanic Sasian Sam_ind {
    confirm variable `v'
}
isid student_key year
assert _N > 0

import delimited "$SYN_DIR_2/student_demographics.csv", varnames(1) ///
    case(preserve) clear
foreach v in SCHOOL_YEAR DIST_ACCTBL_CODE SCH_ACCTBL_CODE STUDENT_KEY GRADE ///
    GENDER RACE_ETHNICITY DISAB_STATUS EL_STATUS ECON_DISADVANTAGE {
    confirm variable `v'
}
isid STUDENT_KEY SCHOOL_YEAR
gen int year = real(substr(SCHOOL_YEAR, 1, 4))
save `dem_csv', replace

preserve
keep STUDENT_KEY year
duplicates drop
save `staff_ids', replace
forvalues yr = 2006/2016 {
    use `staff_ids', clear
    keep if year == `=`yr' - 1'
    drop year
    duplicates drop
    save `prev_ids', replace

    use `staff_ids', clear
    keep if year == `yr'
    drop year
    duplicates drop
    merge 1:1 STUDENT_KEY using `prev_ids'
    quietly count if _merge == 3
    local both = r(N)
    quietly count if _merge == 2 | _merge == 3
    local prev = r(N)
    assert (`both' / `prev') >= .90
}
restore

import delimited "$SYN_DIR_2/testscores.csv", varnames(1) case(preserve) clear
foreach v in SCHOOL_YEAR DIST_ACCTBL_CODE SCH_ACCTBL_CODE STUDENT_KEY GRADE ///
    TEST_NAME TEST_SUBJECT TEST_SCALED_SCORE TEST_STDERR TEST_PROF_LVL {
    confirm variable `v'
}
assert TEST_SCALED_SCORE > 0
assert TEST_STDERR > 0
merge m:1 STUDENT_KEY SCHOOL_YEAR using `dem_csv'
assert _merge == 3
drop _merge
bysort SCHOOL_YEAR GRADE TEST_SUBJECT: assert _N >= 2

********************************************************************************
* Smoke Run Required Build Block in a Temporary Intermediate Folder
********************************************************************************

capture which carryforward
if _rc {
    display as error "Required package carryforward is not installed; cannot smoke-run build block."
    exit 499
}

capture mkdir "`SMOKE_ROOT'"
capture mkdir "`SMOKE_INT'"
capture mkdir "`SMOKE_OUT'"
capture mkdir "`SMOKE_OUT'/tables"
capture mkdir "`SMOKE_OUT'/figures"
capture mkdir "`SMOKE_EST'"
capture mkdir "`SMOKE_SIM'"
global code "`REPL_ROOT'/code/"
global confdata "$SYNTH_ROOT"
global raw "`REPL_ROOT'/real_data"
global intdata "`SMOKE_INT'"
global est "`SMOKE_EST'"
global sim "`SMOKE_SIM'"
global synthdata "$SYNTH_ROOT"
global out "`SMOKE_OUT'"

do $code/build/oldteacher_roster_build.do
do $code/build/staff_build.do
do $code/build/teachers_build.do
do $code/build/teachers_panel.do
do $code/build/va_teacherside_build.do

use "$intdata/va_teacherside_math_JPE.dta", clear
confirm variable id26
quietly count if id26 < .
assert r(N) > 0
capture confirm variable id27
assert _rc != 0

do $code/build/testscores_build.do
do $code/build/valueadded_calculation.do
do $code/build/valueadded_calculation_classmodel.do
do $code/build/valueadded_calculation_stockstaiger_nocomparativeadv.do
do $code/build/teachers_with_allva.do
do $code/build/schedule_new.do
confirm file "$est/schedule_new.dta"
use "$intdata/schedule_new_JPE.dta", clear
isid district_code
assert _N == 411
foreach v of varlist CExp*_ba CExp*_ma {
    assert !missing(`v')
}
cf _all using "$est/schedule_new.dta"
do $code/build/gen_omegas.do
do $code/build/gen_omegas_info.do
do $code/build/build_model_dataset.do

use "$est/info_all.dta", clear
assert _N == 6600
egen tag_dist = tag(Dist_all)
quietly count if tag_dist & Dist_all < .
assert r(N) == 411

use "$est/match.dta", clear
assert _N == 6600
ds Match*
local nmatch : word count `r(varlist)'
assert `nmatch' == 411

foreach f in wage wageschedule match incumbent samecz lndist {
    _check_output_csv "$est/`f'.csv" 6600 411 tab
}
foreach f in alpha1 alpha2 democratic enrollment lambda urban suburban {
    _check_output_csv "$est/`f'.csv" 1 411 tab
}
_check_binary_pair_csv "$est/urban.csv" "$est/suburban.csv" 1 411 tab
foreach f in budget budget_past {
    _check_output_csv "$est/`f'.csv" 1 822 tab
}
foreach f in contributions {
    _check_output_csv "$est/`f'.csv" 6600 4 tab
}
foreach f in experience {
    _check_output_csv "$est/`f'.csv" 6600 6 tab
}
use "$est/experience.dta", clear
assert _N == 6600
quietly count if Exp1 == 1
assert r(N) >= 350
quietly count if Exp2 == 1
assert r(N) >= 500
keep id Exp2
tempfile model_exp_cells
save `model_exp_cells', replace
use "$est/incumbent.dta", clear
merge 1:1 id using `model_exp_cells', assert(match) nogen
egen double inc_sum = rowtotal(Inc*)
quietly count if Exp2 == 1 & inc_sum > 0
assert r(N) > 0
foreach f in experiencecont master {
    _check_output_csv "$est/`f'.csv" 6600 1 comma
}
_check_output_csv "$est/age_estsample.csv" 6600 2 tab
assert age == round(age)
assert age > 0
foreach spec in ///
    "alpha1_grid 7" ///
    "alpha2_grid 8" {
    gettoken f rows : spec
    _check_output_csv "$est/`f'.csv" `rows' 1 comma
}

use "$est/multinomial.dta", clear
quietly count if Match == 1
assert r(N) == 6600
egen tag_dist = tag(District)
quietly count if tag_dist
assert r(N) == 411

import delimited "$est/sharepoor.csv", varnames(1) clear
assert _N >= 19

use "$est/multinomial.dta", clear
foreach v in Exp1 Exp2 Exp3 Exp4 Exp5 Exp6 {
    confirm variable `v'
}

do $code/build/build_teachers_offer_set.do
confirm file "$est/matched_movers.dta"
use "$est/matched_movers.dta", clear
assert _N > 0

do $code/build/build_model_dataset_info0.do
do $code/build/build_model_dataset_info1.do
do $code/build/build_model_dataset_info2.do
do $code/build/build_model_dataset_info3.do
do $code/build/auxiliary_models_teachers_info_matches.do

foreach suffix in info0 info1 info2 info3 {
    use "$est/info_all_`suffix'.dta", clear
    assert _N == 6600
    egen tag_dist = tag(Dist_all)
    quietly count if tag_dist & Dist_all < .
    assert r(N) == 411

    use "$est/multinomial_`suffix'.dta", clear
    quietly count if Match == 1
    assert r(N) == 6600
    egen tag_dist = tag(District)
    quietly count if tag_dist
    assert r(N) == 411

    use "$est/matched_movers_`suffix'.dta", clear
    assert _N > 0

    use "$est/wageschedule_`suffix'.dta", clear
    assert _N == 6600
    ds mode*
    local nmode : word count `r(varlist)'
    assert `nmode' == 411
    _assert_no_missing_current_data
}

foreach suffix in base info0 info1 info2 info3 {
    preserve
    if "`suffix'" == "base" {
        use "$est/matched_movers.dta", clear
        capture drop v0
        capture drop v1
        duplicates drop
        merge 1:1 id District using "$est/multinomial.dta"
    }
    else {
        use "$est/matched_movers_`suffix'.dta", clear
        collapse Match wage d C0 C1 urban suburban, by(id District)
        merge 1:1 id District using "$est/multinomial_`suffix'.dta"
    }
    keep if _m == 3
    drop _m
    capture drop entr
    capture drop D0
    bysort id: egen entr = sum(Inc)
    replace entr = 1 - entr
    gen D0 = (1 - entr) * (1 - Inc)
    quietly count if Exp3 == 1 & D0 == 1
    assert r(N) > 0
    restore
}

global info "$est"
do $code/auxiliary_regressions/auxiliary_models_teachers_info.do
confirm file "$out/tables/Table_B11.txt"

capture program drop _assert_no_missing_current_data
program define _assert_no_missing_current_data
    foreach v of varlist _all {
        assert !missing(`v')
    }
end

capture program drop _check_output_csv
program define _check_output_csv
    args f rows cols delimiter

    if "`delimiter'" == "tab" {
        insheet using "`f'", tab clear
    }
    else {
        insheet using "`f'", clear
    }

    assert _N == `rows'
    assert c(k) == `cols'
    _assert_no_missing_current_data
end

capture program drop _check_binary_pair_csv
program define _check_binary_pair_csv
    args f1 f2 rows cols delimiter

    _check_output_csv "`f1'" `rows' `cols' "`delimiter'"
    local actual_cols = c(k)
    forvalues j = 1/`actual_cols' {
        assert inlist(v`j', 0, 1)
        rename v`j' urban`j'
    }
    gen byte _row = _n
    tempfile first_file
    save `first_file', replace

    _check_output_csv "`f2'" `rows' `cols' "`delimiter'"
    forvalues j = 1/`actual_cols' {
        assert inlist(v`j', 0, 1)
    }
    gen byte _row = _n
    merge 1:1 _row using `first_file'
    assert _merge == 3
    drop _merge

    local rural_cells = 0
    forvalues j = 1/`actual_cols' {
        assert urban`j' + v`j' <= 1
        quietly count if urban`j' + v`j' == 0
        local rural_cells = `rural_cells' + r(N)
    }
    assert `rural_cells' > 0
end

do $code/build/omega_databuild.do
do $code/build/budget_overtime.do
do $code/build/build_model_dataset_pre2011.do

use "$sim/info_all_pre_NEW.dta", clear
assert _N == 6741
egen tag_dist = tag(Dist_all)
quietly count if tag_dist & Dist_all < .
assert r(N) == 411

use "$sim/match_pre_NEW.dta", clear
assert _N == 6741
ds Match*
local nmatch : word count `r(varlist)'
assert `nmatch' == 411

foreach f in wage_pre_NEW wageschedule_pre_NEW match_pre_NEW incumbent_pre_NEW ///
    samecz_pre_NEW {
    _check_output_csv "$sim/`f'.csv" 6741 411 tab
}
foreach f in lambda_pre_NEW lambdaold_pre_NEW enrollment_pre_NEW urban_pre_NEW ///
    suburban_pre_NEW {
    _check_output_csv "$sim/`f'.csv" 1 411 tab
}
_check_binary_pair_csv "$sim/urban_pre_NEW.csv" ///
    "$sim/suburban_pre_NEW.csv" 1 411 tab
foreach f in budget_pre_NEW budget_past_pre_NEW {
    _check_output_csv "$sim/`f'.csv" 1 822 tab
}
foreach f in contributions_pre_NEW {
    _check_output_csv "$sim/`f'.csv" 6741 4 tab
}
foreach f in experience_pre_NEW {
    _check_output_csv "$sim/`f'.csv" 6741 6 tab
}
use "$sim/experience_pre_NEW.dta", clear
assert _N == 6741
keep id Exp6
tempfile sim_exp_cells
save `sim_exp_cells', replace
use "$sim/incumbent_pre_NEW.dta", clear
merge 1:1 id using `sim_exp_cells', assert(match) nogen
egen double inc_sum = rowtotal(Inc*)
quietly count if Exp6 == 1 & inc_sum == 0
assert r(N) > 0
foreach f in experiencecont_pre_NEW master_pre_NEW {
    _check_output_csv "$sim/`f'.csv" 6741 1 comma
}

do $code/descriptives/summary.do
do $code/descriptives/summary_simulation.do
do $code/auxiliary_regressions/aux_model_teachers_wages.do
do $code/descriptives/Table_B15.do
do $code/auxiliary_regressions/aux_other_moments.do
foreach spec in ///
    "omega1_share 5" ///
    "omega1_var 5" ///
    "omega2_share 7" ///
    "omega2_var 7" ///
    "alpha12_moments 10" ///
    "omegas_1_0 2" ///
    "omega_moments_JPE 4" {
    gettoken f rows : spec
    local delimiter comma
    if "`f'" == "omega_moments_JPE" {
        local delimiter tab
        _check_output_csv "$est/`f'.csv" `rows' 3 `delimiter'
    }
    else {
        _check_output_csv "$est/`f'.csv" `rows' 1 `delimiter'
    }
}
confirm file "$est/aux_other_var.txt"
file open aux_other_in using "$est/aux_other_var.txt", read text
local aux_other_lines = 0
file read aux_other_in aux_other_line
while r(eof) == 0 {
    local aux_other_lines = `aux_other_lines' + 1
    file read aux_other_in aux_other_line
}
file close aux_other_in
assert `aux_other_lines' == 79
import delimited using "$est/aux_other_var.txt", clear
assert _N == 78
assert v1 < .
do $code/auxiliary_regressions/auxiliary_models_districts.do
capture program drop _assert_no_missing_current_data
program define _assert_no_missing_current_data
    foreach v of varlist _all {
        assert !missing(`v')
    }
end

capture program drop _check_output_csv
program define _check_output_csv
    args f rows cols delimiter

    if "`delimiter'" == "tab" {
        insheet using "`f'", tab clear
    }
    else {
        insheet using "`f'", clear
    }

    assert _N == `rows'
    assert c(k) == `cols'
    _assert_no_missing_current_data
end

foreach f in betaD1_1 betaD1_2 betaD1_3 betaD1_4 ///
    betaD2_1 betaD2_2 betaD2_3 betaD2_4 ///
    betaD3_1 betaD3_2 betaD3_3 betaD3_4 {
    confirm file "$est/`f'.csv"
    _check_output_csv "$est/`f'.csv" 4 1 comma
    _check_output_csv "$est/`f'_var.csv" 4 1 comma
    capture confirm file "$est/`f'_JPE.csv"
    assert _rc != 0
}
do $code/descriptives/omega_analysis.do
do $code/descriptives/data_patterns.do
do $code/descriptives/appendix_figures.do
do $code/descriptives/rothstein_test.do

confirm file "$intdata/omega_analysis_data_JPE.dta"
use "$intdata/omega_analysis_data_JPE.dta", clear
assert _N > 0

foreach f in Table_1A.log Table_1B.log Table_2.log Table_4.log ///
    Table_B2.log Table_B3.tex Table_B15.csv Table_B21A.log Table_B21B.log {
    confirm file "$out/tables/`f'"
}

foreach f in Figure_1.png Figure_2a.png Figure_2b.png Figure_3.png {
    confirm file "$out/figures/`f'"
}

foreach f in roster_JPE.dta staff_large_withid_JPE.dta teachers_new_JPE.dta ///
    teachers_panel_nova_JPE.dta va_teacherside_math_JPE.dta ///
    indtest_math_split_JPE.dta va_highlow_math_expdisc_JPE.dta ///
    teachers_panel_JPE.dta schedule_new_JPE.dta ///
    alphagrid_8groups_lambdad_JPE.dta {
    confirm file "$intdata/`f'"
    use "$intdata/`f'", clear
    assert _N > 0
}

foreach f in wage.dta sharepoor.csv multinomial.dta {
    confirm file "$est/`f'"
}

display as text "Synthetic-structure validation passed."
display as text "Temporary build-smoke outputs: `SMOKE_INT'"

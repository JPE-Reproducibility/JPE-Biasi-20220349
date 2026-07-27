version 19
clear all
set more off
set seed 20260613
set sortseed 20260613

/*
Public simulated/synthetic-data generator.

This script creates small, internally consistent fake raw files from scratch.
It does not read confidential observations.
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

capture mkdir "$SYNTH_ROOT/raw"
capture mkdir "$SYN_DIR_1"
capture mkdir "$SYN_DIR_2"
capture mkdir "$SYNTH_ROOT/raw/teacher_data_linked"
capture mkdir "$SYN_DOC"

capture program drop _synth_normalize_dta_timestamp
program define _synth_normalize_dta_timestamp
    syntax using/, Timestamp(string)
    tempfile normalized
    quietly filefilter `"`using'"' `"`normalized'"', ///
        from(`"`timestamp'"') to("01 Jan 2026 00:00") replace
    quietly copy `"`normalized'"' `"`using'"', replace
end

capture program drop _synth_zero_saveold_padding
program define _synth_zero_saveold_padding
    syntax using/, Nvars(integer)

    local data_label_start = 10
    local data_label_end = `data_label_start' + 81 - 1
    local variable_label_start = ///
        4 + 2 + 4 + 81 + 18 + `nvars' + 33 * `nvars' + ///
        2 * (`nvars' + 1) + 49 * `nvars' + 33 * `nvars'
    local variable_label_end = `variable_label_start' + 81 * `nvars' - 1

    file open _synth_dta using `"`using'"', read write binary
    forvalues pos = `data_label_start'/`data_label_end' {
        file seek _synth_dta `pos'
        file write _synth_dta %1s `=char(0)'
    }
    forvalues pos = `variable_label_start'/`variable_label_end' {
        file seek _synth_dta `pos'
        file write _synth_dta %1s `=char(0)'
    }
    file close _synth_dta
end

local staff_years_txt_old "2006 2007 2008 2009 2010 2011"
local staff_years_txt_new "2012 2013 2014"
local staff_years_csv "2015 2016"
local dist_codes "413 422 665 2793 714 721 1015 1253 1376 1890 1900 2058 2177 2184 2217 2296 2303 2450 2460 3437 3479 3510 3528 3619 3857 3925 4018 4060 4312 5026 6174 6244 6300 6419"
local n_dist_codes : word count `dist_codes'
local area_codes "50 400 412 300 600 312 550 800"
local exp3_mover_seqs "30 38 47 57 68 80"

tempfile staff_all staff_one linked_roster demcsv testscores

********************************************************************************
* Synthetic Staff Records
********************************************************************************

clear
save `staff_all', emptyok replace

forvalues yr = 2006/2016 {
    clear
    set obs 430
    gen int year = `yr'
    gen int seq = _n
    gen int staff_idx = cond(seq <= 420, seq, 420 + (`yr' - 2006) * 10 + (seq - 420))
    replace staff_idx = 10000 + (`yr' - 2006) * 100 + seq ///
        if inlist(seq, 1, 7, 11, 16, 22, 29)
    foreach s of local exp3_mover_seqs {
        replace staff_idx = 20000 + seq if seq == `s' & year >= 2011
    }
    replace staff_idx = 30000 + (`yr' - 2006) * 1000 + seq ///
        if (inrange(seq, 101, 126) | inrange(seq, 260, 289)) & ///
        inlist(year, 2010, 2014)
    replace staff_idx = 38126 if seq == 126 & inrange(year, 2011, 2014)
    gen byte va_cluster_size = .
    gen int va_cluster_school = .
    local va_lo = 1
    forvalues k = 1/26 {
        local va_hi = `va_lo' + `k' - 1
        replace va_cluster_size = `k' if inrange(seq, `va_lo', `va_hi')
        replace va_cluster_school = 1900 + `k' if inrange(seq, `va_lo', `va_hi')
        local va_lo = `va_hi' + 1
    }

    gen byte n_assign = 1
    replace n_assign = 2 if mod(seq, 10) == 0
    replace n_assign = 14 if seq == 10
    replace n_assign = 6 if seq == 20
    replace n_assign = 1 if va_cluster_size < .
    replace n_assign = 2 if inrange(seq, 352, 394)
    replace n_assign = 14 if seq == 410
    replace n_assign = 6 if seq == 420
    expand n_assign
    bysort year seq: gen byte assign_n = _n
    bysort year seq: gen byte assign_total = _N

    gen float id = 100000 + staff_idx
    gen long filenum_n = 600000 + staff_idx
    replace filenum_n = 29925 if staff_idx == 2
    replace filenum_n = 32097 if staff_idx == 3
    replace filenum_n = 614231 if staff_idx == 4
    replace filenum_n = 636414 if staff_idx == 5
    replace filenum_n = 648811 if staff_idx == 6
    gen str6 filenumber = string(filenum_n, "%06.0f")

    gen str20 lastname = "S" + string(staff_idx, "%04.0f") + "-Unit X"
    gen str16 firstname = "P" + string(mod(staff_idx, 10000), "%04.0f") + "-Giv X"
    gen str1 gender = cond(mod(staff_idx, 2) == 0, "F", "M")
    gen str1 race = "W"
    replace race = "B" if mod(staff_idx, 5) == 1
    replace race = "H" if mod(staff_idx, 5) == 2
    replace race = "A" if mod(staff_idx, 5) == 3
    gen float birth = 1958 + mod(staff_idx, 28)
    replace birth = 1960 if inlist(seq, 1, 7, 11, 16, 22, 29)
    gen str1 highedu = string(4 + mod(staff_idx, 4), "%1.0f")

    gen int exp_eff = 1 + mod(staff_idx, 24) + (year - 2006)
    replace exp_eff = 1 if seq == 1
    replace exp_eff = 2 if seq == 7
    replace exp_eff = 4 if seq == 11
    replace exp_eff = 7 if seq == 16
    replace exp_eff = 12 if seq == 22
    replace exp_eff = 18 if seq == 29
    foreach s of local exp3_mover_seqs {
        replace exp_eff = year - 2010 if seq == `s' & year >= 2011
    }
    * Keep enough low-experience teachers in the VA-supporting synthetic cells.
    * These rows survive the model-data restrictions and are later expanded
    * across the 411-district synthetic model universe.
    replace exp_eff = 1 if ///
        (inrange(seq, 101, 113) | inrange(seq, 260, 268)) & ///
        inlist(year, 2010, 2014)
    replace exp_eff = 2 if ///
        (inrange(seq, 114, 126) | inrange(seq, 269, 289)) & ///
        inlist(year, 2010, 2014)
    replace exp_eff = year - 2011 if seq == 126 & ///
        inrange(year, 2011, 2014)
    replace exp_eff = 16 if seq == 288 & year == 2010
    gen float localexp = max(1, exp_eff - mod(staff_idx, 4))
    gen float totalexp = exp_eff
    replace localexp = localexp * 10 if year <= 2014
    replace totalexp = totalexp * 10 if year <= 2014

    gen float dayscontract = 180 + mod(staff_idx + assign_n, 12)
    gen float salary = 38000 + 900 * exp_eff + 200 * mod(staff_idx, 17) + 350 * (year - 2006)
    replace salary = round(salary)
    gen float fringe = round(9000 + salary * .18)
    gen byte staffcat = 1

    gen byte school_slot = mod(staff_idx + assign_n + year, `n_dist_codes') + 1
    replace school_slot = va_cluster_size if va_cluster_size < .
    gen float workagencycode = real(word("`dist_codes'", school_slot))
    gen float schoolcode = 1000 + school_slot
    replace workagencycode = 112 if seq == 10
    replace schoolcode = 1000 + assign_n if seq == 10
    replace workagencycode = real(word("`dist_codes'", assign_n)) if seq == 20
    replace schoolcode = 1100 + assign_n if seq == 20
    replace workagencycode = 112 if seq == 410
    replace schoolcode = 1800 + assign_n if seq == 410
    replace workagencycode = real(word("`dist_codes'", assign_n)) if seq == 420
    replace schoolcode = 1700 + assign_n if seq == 420
    replace workagencycode = real(word("`dist_codes'", va_cluster_size)) ///
        if va_cluster_size < .
    replace workagencycode = real(word("`dist_codes'", va_cluster_size + 6)) ///
        if inrange(va_cluster_size, 8, 20) & year <= 2013
    replace schoolcode = va_cluster_school if va_cluster_size < .
    replace workagencycode = ///
        real(word("`dist_codes'", mod((year - 2006) + seq, 8) + 1)) ///
        if inrange(seq, 395, 402)
    replace schoolcode = 2500 + (seq - 394) * 20 + (year - 2006) ///
        if inrange(seq, 395, 402)
    gen float hireagencycode = workagencycode
    gen float hireagencytype = cond(mod(staff_idx, 2) == 0, 3, 4)
    gen float workagencytype = hireagencytype

    gen float position = 53
    replace position = 43 if assign_total == 1 & mod(seq, 100) == 1
    replace position = 60 if assign_total == 1 & mod(seq, 10) == 1 & position == 53
    replace position = 60 if assign_total == 1 & inrange(seq, 395, 430)
    replace position = 53 if va_cluster_size < .
    replace position = 53 if inrange(seq, 395, 402)

    gen float area = real(word("`area_codes'", mod(staff_idx + assign_n, 8) + 1))
    replace area = 50 if seq == 10 & assign_n <= 7
    replace area = 400 if seq == 10 & assign_n > 7
    replace area = 400 if seq == 20
    replace area = 400 if seq == 410 | seq == 420
    replace area = 50 if va_cluster_size < .

    gen str2 lowgrade = "03"
    gen str2 highgrade = "05"
    replace highgrade = "06" if inlist(area, 300, 312, 400, 412, 600)
    replace highgrade = "08" if seq == 10 & assign_n > 7
    replace highgrade = "06" if va_cluster_size < .
    gen float lowgradecode = real(lowgrade)
    gen float highgradecode = real(highgrade)
    gen str1 bilingual = cond(mod(staff_idx, 9) == 0, "Y", "N")

    gen float fte = 100
    replace fte = 50 if assign_total == 2
    replace fte = 10 if seq == 10
    replace fte = 20 if seq == 20

    gen str30 workagencyname = "Synthetic District " + string(workagencycode, "%04.0f")
    gen str30 schoolname = "Synthetic School " + string(schoolcode, "%04.0f")
    gen str1 gradelevel = "E"
    gen str2 cesa = string(1 + mod(school_slot, 12), "%02.0f")
    gen float county = 1 + mod(school_slot, 20)
    gen str10 zipcode = "53" + string(100 + mod(school_slot, 800), "%03.0f")
    gen str1 lt_substitute = "N"
    gen str1 subcontracted = "N"

    append using `staff_all'
    save `staff_all', replace
}

use `staff_all', clear
order id lastname firstname filenumber gender race birth highedu dayscontract ///
    localexp totalexp salary fringe staffcat hireagencycode workagencycode ///
    hireagencytype schoolcode position area lowgrade highgrade lowgradecode ///
    highgradecode bilingual fte workagencyname schoolname gradelevel cesa ///
    county workagencytype zipcode lt_substitute subcontracted year
save `staff_all', replace
quietly count if year == 2006
local staff_file_rows = r(N)

preserve
keep id lastname firstname filenum_n gender race birth workagencycode year
duplicates drop id year, force
rename filenum_n filenumber
rename workagencycode district_code
gen float twolast = 0
gen float twofirst = 0
order id lastname firstname filenumber gender race birth district_code year ///
    twolast twofirst
label variable lastname "Last Name"
label variable firstname "First Name"
label variable filenumber "File Number"
label variable gender "Gndr"
label variable race "RaceEthn"
label variable birth "Birth Year"
label variable district_code "Work Agncy Cd"
local dta_ts_before "`c(current_date)' `=substr("`c(current_time)'", 1, 5)'"
saveold "$SYN_DIR_1/temp.dta", version(12) replace
local dta_ts_after "`c(current_date)' `=substr("`c(current_time)'", 1, 5)'"
_synth_normalize_dta_timestamp using "$SYN_DIR_1/temp.dta", ///
    timestamp("`dta_ts_before'")
if "`dta_ts_after'" != "`dta_ts_before'" {
    _synth_normalize_dta_timestamp using "$SYN_DIR_1/temp.dta", ///
        timestamp("`dta_ts_after'")
}
_synth_zero_saveold_padding using "$SYN_DIR_1/temp.dta", nvars(`c(k)')
local staff_temp_rows = _N
restore

********************************************************************************
* Fixed-width Staff TXT Files, 2006-2014
********************************************************************************

foreach yr of local staff_years_txt_old {
    local yy = substr("`yr'", 3, 2)
    preserve
    keep if year == `yr'
    sort id assign_n
    file open fw using "$SYN_DIR_1/`yy'staff.txt", write replace text
    forvalues i = 1/`=_N' {
        file write fw %9.0f (id[`i']) ///
            (substr(lastname[`i'] + "                    ", 1, 20)) ///
            (substr(firstname[`i'] + "                ", 1, 16)) ///
            (gender[`i']) (race[`i']) %4.0f (birth[`i']) (highedu[`i'])
        file write fw _column(62) %3.0f (dayscontract[`i'])
        file write fw _column(66) %3.0f (localexp[`i']) %3.0f (totalexp[`i']) ///
            %7.0f (salary[`i']) %7.0f (fringe[`i'])
        file write fw _column(98) %1.0f (staffcat[`i'])
        file write fw _column(101) %4.0f (hireagencycode[`i']) ///
            %4.0f (workagencycode[`i']) %2.0f (hireagencytype[`i']) ///
            %4.0f (schoolcode[`i']) %2.0f (position[`i']) %4.0f (area[`i']) ///
            (lowgrade[`i']) (highgrade[`i']) %2.0f (lowgradecode[`i']) ///
            %2.0f (highgradecode[`i']) (bilingual[`i']) %3.0f (fte[`i'])
        file write fw _column(147) ///
            (substr(workagencyname[`i'] + "                              ", 1, 30)) ///
            (substr(schoolname[`i'] + "                              ", 1, 30)) ///
            (gradelevel[`i']) (cesa[`i']) %2.0f (county[`i'])
        file write fw _column(242) %2.0f (workagencytype[`i'])
        file write fw _column(443) (substr(zipcode[`i'] + "          ", 1, 10))
        file write fw _column(551) (lt_substitute[`i']) (subcontracted[`i']) _n
    }
    file close fw
    restore
}

foreach yr of local staff_years_txt_new {
    local yy = substr("`yr'", 3, 2)
    preserve
    keep if year == `yr'
    sort id assign_n
    file open fw using "$SYN_DIR_1/`yy'staff.txt", write replace text
    forvalues i = 1/`=_N' {
        file write fw %10.0f (id[`i']) ///
            (substr(lastname[`i'] + "                    ", 1, 20)) ///
            (substr(firstname[`i'] + "                ", 1, 16)) ///
            (filenumber[`i']) (gender[`i']) (race[`i']) %4.0f (birth[`i']) ///
            (highedu[`i'])
        file write fw _column(69) %3.0f (dayscontract[`i']) ///
            %4.0f (localexp[`i']) %3.0f (totalexp[`i']) ///
            %7.0f (salary[`i']) %7.0f (fringe[`i'])
        file write fw _column(105) %1.0f (staffcat[`i'])
        file write fw _column(106) %6.0f (hireagencycode[`i']) ///
            %4.0f (workagencycode[`i']) %2.0f (hireagencytype[`i']) ///
            %4.0f (schoolcode[`i']) %2.0f (position[`i']) %4.0f (area[`i']) ///
            (lowgrade[`i']) (highgrade[`i']) %2.0f (lowgradecode[`i']) ///
            %2.0f (highgradecode[`i']) (bilingual[`i']) %3.0f (fte[`i'])
        file write fw _column(140) ///
            (substr(workagencyname[`i'] + "                                            ", 1, 44)) ///
            (substr(schoolname[`i'] + "                              ", 1, 30)) ///
            (gradelevel[`i']) (cesa[`i']) %2.0f (county[`i'])
        file write fw _column(249) %2.0f (workagencytype[`i'])
        file write fw _column(450) (substr(zipcode[`i'] + "          ", 1, 10))
        file write fw _column(557) (lt_substitute[`i']) (subcontracted[`i']) _n
    }
    file close fw
    restore
}

********************************************************************************
* Staff CSV Files, 2015-2016
********************************************************************************

foreach yr of local staff_years_csv {
    local yy = substr("`yr'", 3, 2)
    preserve
    keep if year == `yr'
    sort id assign_n
    gen long IDNbr = id
    gen str20 LastName = lastname
    gen str16 FirstName = firstname
    gen str6 FileNumber = filenumber
    replace FileNumber = "X00000" in 1
    gen str1 Gndr = gender
    gen str1 RaceEthn = race
    gen int BirthYear = birth
    gen str1 HighDegree = highedu
    replace HighDegree = "X" in 1
    gen str5 YearSession = string(year)
    gen int CntrctDays = dayscontract
    gen float LocalExp = localexp
    gen float TotalExp = totalexp
    gen long TotSalary = salary
    replace TotSalary = 0 in 1
    gen long TotFringe = fringe
    gen byte StaffCat = staffcat
    gen int HireAgncyCd = hireagencycode
    gen str4 WorkAgncyCd = string(workagencycode, "%04.0f")
    replace WorkAgncyCd = "NA" in 1
    gen byte HireAgncyTyp = hireagencytype
    gen str4 SchoolCd = string(schoolcode, "%04.0f")
    gen byte PositionCd = position
    gen int AssgnAreaCd = area
    gen str2 LowGrd = lowgrade
    gen str2 HighGrd = highgrade
    replace LowGrd = "KG" in 1
    replace HighGrd = "KG" in 1
    gen byte LGSortCd = lowgradecode
    gen byte HGSortCd = highgradecode
    gen str1 Bilingual = bilingual
    gen int AssgnFTE = fte
    gen str30 WorkLocationName = workagencyname
    gen str30 SchoolName = schoolname
    gen str1 GrdLevel = gradelevel
    gen str2 CESANumber = cesa
    replace CESANumber = "NA" in 1
    gen byte CntyNbr = county
    gen str30 CntyName = "Synthetic County " + string(county, "%02.0f")
    gen byte WorkAgncyTyp = workagencytype
    gen str30 SchoolMailingAddress1 = "Synthetic Address"
    gen str30 SchoolMailingAddress2 = ""
    gen str30 SchoolShippingAddress1 = "Synthetic Address"
    gen str30 SchoolShippingAddress2 = ""
    gen str17 MailCity = "Synthetic City"
    gen str2 MailSt = "WI"
    gen str10 MailZipCd = zipcode
    replace MailZipCd = "ZIP" in 1
    gen str17 ShipCity = "Synthetic City"
    gen str2 ShipSt = "WI"
    gen str10 ShipZipCd = zipcode
    replace ShipZipCd = "ZIP" in 1
    gen str12 Phone = "000-000-0000"
    gen str30 AdminName = "Synthetic Admin"
    gen str20 FormerLastNm = ""
    gen str1 LTSub = lt_substitute
    gen str1 SubCntrctd = subcontracted

    keep IDNbr LastName FirstName FileNumber Gndr RaceEthn BirthYear ///
        HighDegree YearSession CntrctDays LocalExp TotalExp TotSalary ///
        TotFringe StaffCat HireAgncyCd WorkAgncyCd HireAgncyTyp SchoolCd ///
        PositionCd AssgnAreaCd LowGrd HighGrd LGSortCd HGSortCd Bilingual ///
        AssgnFTE WorkLocationName SchoolName GrdLevel CESANumber CntyNbr ///
        CntyName WorkAgncyTyp SchoolMailingAddress1 SchoolMailingAddress2 ///
        SchoolShippingAddress1 SchoolShippingAddress2 MailCity MailSt ///
        MailZipCd ShipCity ShipSt ShipZipCd Phone AdminName FormerLastNm ///
        LTSub SubCntrctd
    export delimited using "$SYN_DIR_1/`yy'staff.csv", replace
    restore
}

********************************************************************************
* Linked Staffing Support File Required by oldteacher_roster_build.do
********************************************************************************

use `staff_all', clear
keep lastname firstname filenumber year race birth gender workagencycode id
duplicates drop id year workagencycode, force
rename lastname last_name
rename firstname first_name
gen str8 file_num = filenumber
gen str8 birth_year = string(birth, "%04.0f")
gen str1 sex = gender
gen str8 distidworksite = string(workagencycode, "%04.0f")
replace file_num = "NA" in 1
replace birth_year = "NA" in 1
replace distidworksite = "NA" in 1
keep last_name first_name file_num year race birth_year sex distidworksite
order last_name first_name file_num year race birth_year sex distidworksite
export delimited using ///
    "$SYNTH_ROOT/raw/teacher_data_linked/Linked_Staffing_Data_10202015.csv", ///
    replace
save `linked_roster', replace
local linked_rows = _N

********************************************************************************
* Synthetic Student Demographics and Test Scores
********************************************************************************

clear
save `demcsv', emptyok replace

forvalues yr = 2005/2016 {
    clear
    set obs 238
    gen int year = `yr'
    gen int obsseq = _n
    gen int student_idx = cond(obsseq <= 230, obsseq, ///
        230 + (`yr' - 2005) * 8 + (obsseq - 230))
    gen long STUDENT_KEY = 500000 + student_idx
    gen byte GRADE = 3 + mod(student_idx + (`yr' - 2005), 6)
    gen byte va_student_cluster = ceil(obsseq / 8) if obsseq <= 208
    replace GRADE = 3 + mod(obsseq - 1, 4) if va_student_cluster < .
    gen byte school_slot = mod(student_idx + `yr', `n_dist_codes') + 1
    gen int DIST_ACCTBL_CODE = real(word("`dist_codes'", school_slot))
    gen int schoolcode = 1000 + school_slot
    replace DIST_ACCTBL_CODE = ///
        real(word("`dist_codes'", va_student_cluster)) ///
        if va_student_cluster < .
    replace schoolcode = 1900 + va_student_cluster if va_student_cluster < .
    gen str9 SCH_ACCTBL_CODE = "SCH00" + string(schoolcode, "%04.0f")
    gen str9 SCHOOL_YEAR = string(year, "%04.0f") + "-" + ///
        string(year + 1, "%04.0f")
    gen str1 GENDER = cond(mod(student_idx, 2) == 0, "F", "M")
    gen str12 RACE_ETHNICITY = "White"
    replace RACE_ETHNICITY = "Black" if mod(student_idx, 5) == 1
    replace RACE_ETHNICITY = "Hispanic" if mod(student_idx, 5) == 2
    replace RACE_ETHNICITY = "Asian" if mod(student_idx, 5) == 3
    replace RACE_ETHNICITY = "Amer Indian" if mod(student_idx, 5) == 4
    gen byte DISAB_STATUS = mod(student_idx, 11) == 0
    gen byte EL_STATUS = mod(student_idx, 13) == 0
    gen byte ECON_DISADVANTAGE = mod(student_idx, 3) == 0
    keep SCHOOL_YEAR DIST_ACCTBL_CODE SCH_ACCTBL_CODE STUDENT_KEY GRADE ///
        GENDER RACE_ETHNICITY DISAB_STATUS EL_STATUS ECON_DISADVANTAGE
    append using `demcsv'
    save `demcsv', replace
}

use `demcsv', clear
order SCHOOL_YEAR DIST_ACCTBL_CODE SCH_ACCTBL_CODE STUDENT_KEY GRADE ///
    GENDER RACE_ETHNICITY DISAB_STATUS EL_STATUS ECON_DISADVANTAGE
sort STUDENT_KEY SCHOOL_YEAR
local dem_rows = _N
export delimited using "$SYN_DIR_2/student_demographics.csv", replace

preserve
gen int year = real(substr(SCHOOL_YEAR, 1, 4))
gen float Sfemale = GENDER == "F"
gen float Sblack = RACE_ETHNICITY == "Black"
gen float Shispanic = RACE_ETHNICITY == "Hispanic"
gen float Sasian = RACE_ETHNICITY == "Asian"
gen float Sam_ind = RACE_ETHNICITY == "Amer Indian"
rename STUDENT_KEY student_key
rename DISAB_STATUS disab_status
rename EL_STATUS el_status
rename ECON_DISADVANTAGE econ_disadvantage
keep student_key disab_status el_status econ_disadvantage year Sfemale ///
    Sblack Shispanic Sasian Sam_ind
order student_key disab_status el_status econ_disadvantage year Sfemale ///
    Sblack Shispanic Sasian Sam_ind
label variable student_key "STUDENT_KEY"
label variable disab_status "DISAB_STATUS"
label variable el_status "EL_STATUS"
label variable econ_disadvantage "ECON_DISADVANTAGE"
local dta_ts_before "`c(current_date)' `=substr("`c(current_time)'", 1, 5)'"
saveold "$SYN_DIR_2/dem.dta", version(12) replace
local dta_ts_after "`c(current_date)' `=substr("`c(current_time)'", 1, 5)'"
_synth_normalize_dta_timestamp using "$SYN_DIR_2/dem.dta", ///
    timestamp("`dta_ts_before'")
if "`dta_ts_after'" != "`dta_ts_before'" {
    _synth_normalize_dta_timestamp using "$SYN_DIR_2/dem.dta", ///
        timestamp("`dta_ts_after'")
}
_synth_zero_saveold_padding using "$SYN_DIR_2/dem.dta", nvars(`c(k)')
restore

use `demcsv', clear
expand 3
bysort STUDENT_KEY SCHOOL_YEAR: gen byte subj_n = _n
gen str14 TEST_SUBJECT = "Mathematics"
replace TEST_SUBJECT = "Reading" if subj_n == 2
replace TEST_SUBJECT = "ELA" if subj_n == 3
gen str7 TEST_NAME = "SYNTEST"
gen int base_year = real(substr(SCHOOL_YEAR, 1, 4))
gen int student_idx = STUDENT_KEY - 500000
gen byte va_cluster = ceil(student_idx / 8) if inrange(student_idx, 1, 208)
gen byte within_va_cluster = mod(student_idx - 1, 8) + 1 if va_cluster < .
gen int TEST_SCALED_SCORE = 350 + 12 * GRADE + 3 * (base_year - 2005) + ///
    mod(STUDENT_KEY, 41)
replace TEST_SCALED_SCORE = 410 + 9 * GRADE + 2 * (base_year - 2005) + ///
    2 * va_cluster + ///
    cond((mod(va_cluster, 2) == 1 & within_va_cluster <= 4) | ///
    (mod(va_cluster, 2) == 0 & within_va_cluster > 4), 200, -200) ///
    if va_cluster < .
replace TEST_SCALED_SCORE = TEST_SCALED_SCORE + 8 if TEST_SUBJECT == "Reading"
replace TEST_SCALED_SCORE = TEST_SCALED_SCORE + 12 if TEST_SUBJECT == "ELA"
gen int TEST_STDERR = 12 + mod(STUDENT_KEY + GRADE, 7)
gen str19 TEST_PROF_LVL = "Basic"
replace TEST_PROF_LVL = "Proficient" if mod(STUDENT_KEY + GRADE, 3) == 0
replace TEST_PROF_LVL = "Advanced" if mod(STUDENT_KEY + GRADE, 7) == 0
keep SCHOOL_YEAR DIST_ACCTBL_CODE SCH_ACCTBL_CODE STUDENT_KEY GRADE ///
    TEST_NAME TEST_SUBJECT TEST_SCALED_SCORE TEST_STDERR TEST_PROF_LVL
order SCHOOL_YEAR DIST_ACCTBL_CODE SCH_ACCTBL_CODE STUDENT_KEY GRADE ///
    TEST_NAME TEST_SUBJECT TEST_SCALED_SCORE TEST_STDERR TEST_PROF_LVL
sort STUDENT_KEY SCHOOL_YEAR TEST_SUBJECT
local testscores_rows = _N
export delimited using "$SYN_DIR_2/testscores.csv", replace
save `testscores', replace

********************************************************************************
* Public Manifest and Notes
********************************************************************************

file open mf using "$SYN_DOC/synthetic_data_manifest.csv", write replace text
file write mf "source_folder_number,relative_file_path,file_format,synthetic_rows,number_variables,broad_unit,candidate_keys,notes" _n
foreach yr of local staff_years_txt_old {
    local yy = substr("`yr'", 3, 2)
    file write mf "1,raw/staff/`yy'staff.txt,txt,`staff_file_rows',34,staff district-school-position-year,id year schoolcode workagencycode,Synthetic fixed-width staff file" _n
}
foreach yr of local staff_years_txt_new {
    local yy = substr("`yr'", 3, 2)
    file write mf "1,raw/staff/`yy'staff.txt,txt,`staff_file_rows',35,staff district-school-position-year,id filenumber year schoolcode workagencycode,Synthetic fixed-width staff file" _n
}
foreach yr of local staff_years_csv {
    local yy = substr("`yr'", 3, 2)
    file write mf "1,raw/staff/`yy'staff.csv,csv,`staff_file_rows',49,staff district-school-position-year,IDNbr FileNumber YearSession SchoolCd WorkAgncyCd,Synthetic staff CSV file" _n
}
file write mf "1,raw/staff/temp.dta,dta,`staff_temp_rows',11,staff-year,id filenumber year district_code,Synthetic staff linkage support dta" _n
file write mf "1,raw/teacher_data_linked/Linked_Staffing_Data_10202015.csv,csv,`linked_rows',8,staff-year linkage,file_num year distidworksite,Synthetic support file required by oldteacher_roster_build.do" _n
file write mf "2,raw/testscores_indlev/dem.dta,dta,`dem_rows',10,student-year,student_key year,Synthetic demographic dta matching the CSV" _n
file write mf "2,raw/testscores_indlev/student_demographics.csv,csv,`dem_rows',10,student-year,STUDENT_KEY SCHOOL_YEAR,Synthetic demographics CSV" _n
file write mf "2,raw/testscores_indlev/testscores.csv,csv,`testscores_rows',10,student-subject-year,STUDENT_KEY SCHOOL_YEAR TEST_SUBJECT,Synthetic test-score CSV" _n
file close mf

file open notes using "$SYN_DOC/synthetic_data_notes.md", write replace text
file write notes "# Synthetic Data Notes" _n _n
file write notes "These files are generated from scratch by `code/02_make_synthetic_data.do`. They are not sampled from or perturbations of confidential records." _n _n
file write notes "## Staff Files" _n _n
file write notes "- Unit: individual working in a district-school-position-year." _n
file write notes "- Fake staff IDs repeat across consecutive years for about 96 percent of staff IDs by construction." _n
file write notes "- About 90 percent of staff person-years have one district-school-position record; about 90 percent of those one-record person-years have position 53." _n
file write notes "- Position, assignment-area, district, and school codes are synthetic code-support values held internally consistent across years." _n
file write notes "- Total and local experience generally increase mechanically within staff histories after accounting for the pre-2015 raw scaling used by the build scripts; designated low-experience VA-support rows are held in low bins so model-data experience cells stay populated." _n
file write notes "- The first row of each staff CSV is a synthetic import sentinel that is dropped by the legacy staff build because it has zero salary; it exists only to make Stata infer string types for fields that are string in earlier fixed-width years." _n
file write notes "- A few synthetic file-number sentinels are included solely so hard-coded legacy manual-fix branches in the public build scripts have nonempty conditions; these are not confidential records." _n
file write notes "- Synthetic school-grade-year clusters cover exactly 1 through 26 eligible teachers so downstream VA scripts that expect all teacher-count buckets and `id1` through `id26`, but no wider teacher columns, can run." _n
file write notes "- Those VA-supporting clusters are spread across 26 synthetic districts and deliberately include both low- and high-prior-score students so district-level model files can form 20 quantiles." _n
file write notes "- A few VA-cluster teachers are synthetic entrants with low, middle, and high experience so the model-data scripts see all six expected experience-bin dummies." _n
file write notes "- A small subset of those VA-cluster teachers enter in 2011 and move districts by 2014 so imperfect-information auxiliary regressions have nonempty low-experience mover cells." _n
file write notes "- Synthetic active districts are chosen from public district codes with at least one other active district in their commuting zone so leave-one-out CZ summaries are defined." _n
file write notes "- A small cohort of synthetic non-VA teachers changes districts across years so mover/non-mover descriptive figures have nonempty cells, including 2011." _n
file write notes "- VA-supporting student cells span grades 3 through 6 within school-years, with low- and high-prior-score variants in each grade, so Rothstein-style school-by-year fixed-effect checks retain non-singleton cells." _n
file write notes "- One synthetic support CSV is written to `raw/teacher_data_linked/` because `oldteacher_roster_build.do` requires it before `staff_build.do` can run." _n _n
file write notes "## Test-Score and Demographic Files" _n _n
file write notes "- Unit: student-year in `student_demographics.csv` and `dem.dta`; student-subject-year in `testscores.csv`." _n
file write notes "- Fake student IDs repeat across years for about 97 percent of students in consecutive school years." _n
file write notes "- Demographic and test-score rows fully match on synthetic student ID and school year." _n
file write notes "- Grade, subject, school, and district cells are populated so the standardization and merge code has nonempty cells." _n _n
file write notes "## Main Assumptions" _n _n
file write notes "- The raw 2008-2010 staff files are written with lowercase filenames to match the existing build script's `08staff.txt`, `09staff.txt`, and `10staff.txt` references." _n
file write notes "- Generic race, gender, subject, and proficiency labels are included only where the existing build code explicitly branches on those public categories." _n
file write notes "- Synthetic estimates are not intended to reproduce the paper's confidential-data estimates." _n
file close notes

display as text "Synthetic raw data generated."
display as text "Staff output folder:      $SYN_DIR_1"
display as text "Test-score output folder: $SYN_DIR_2"
display as text "Manifest:                 $SYN_DOC/synthetic_data_manifest.csv"
display as text "Notes:                    $SYN_DOC/synthetic_data_notes.md"

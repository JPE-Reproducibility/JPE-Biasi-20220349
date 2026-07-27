********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    teachers_build.do
* Purpose: Build the teacher-year panel from cleaned staff records, 2006-2016.
* Creates: teachers_new_JPE.dta
********************************************************************************

********************************************************************************
* Restrict Staff Records to Teachers
********************************************************************************

use "$intdata/staff_large_withid_JPE.dta", clear

* Keep teachers and short-term substitute teachers.
keep if position == 53 | position == 43
gen st_substitute = position == 43
drop position

* Drop contracted employees.
drop if subcontracted == "Y"
drop subcontracted

* Flag long-term substitutes.
rename lt_substitute LT
gen lt_substitute = LT == "Y"
drop LT

* Keep public school district or school employees hired by districts or schools.
keep if (hireagencytype == 3 | hireagencytype == 4) & ///
    (workagencytype == 3 | workagencytype == 4)

* Drop CESAs, charters, special schools, and records without school codes.
drop if hireagencycode > 7000
drop if schoolcode == .

* Drop observations with zero salary, contract days, or FTE.
drop if salary == 0
drop if days == 0
drop if fte == 0 | fte == .

* Replace staff-record id with the file-number identifier.
rename id id_old
rename filenum id


********************************************************************************
* Teacher Demographics and Assignment Dummies
********************************************************************************

* Education and gender.
gen female = gender == "F"
replace female = . if gender == "NA" | gender == ""
drop gender

gen bachelor = highedu == "4"
replace bachelor = . if highedu == ""
gen master = highedu == "5"
replace bachelor = . if highedu == ""
gen specialist = highedu == "6"
replace specialist = . if highedu == ""
gen phd = highedu == "7"
replace bachelor = . if highedu == ""
drop highedu

* Race and ethnicity.
gen black = race == "B"
replace black = . if race == ""
gen hispanic = race == "H"
replace hispanic = . if race == ""
gen asian = race == "A"
replace asian = . if race == ""
drop race

* Assignment-subject indicators.
gen mathematics = area == 400 | area == 412
replace mathematics = . if area == .
bysort id year (mathematics): replace mathematics = mathematics[_N]

gen english = area == 300 | area == 395
replace english = . if area == .
bysort id year (english): replace english = english[_N]

gen art = area == 550
replace art = . if area == .
bysort id year (art): replace art = art[_N]

gen science = area == 600 | area < 700
replace science = . if area == .
bysort id year (science): replace science = science[_N]

gen reading = area == 312 | area == 316
replace reading = . if area == .
bysort id year (reading): replace reading = reading[_N]

gen title1 = area == 412 | area == 312
replace title1 = . if area == .
bysort id year (title1): replace title1 = title1[_N]

gen all_elem = area == 50
replace all_elem = . if area == .
bysort id year (all_elem): replace all_elem = all_elem[_N]

gen crosscat = area == 800
replace crosscat = . if area == .
bysort id year (crosscat): replace crosscat = crosscat[_N]
drop area


********************************************************************************
* FTE and Assignment Counts
********************************************************************************

* Total FTE, district FTE, school FTE, and subject-specific FTE.
bysort id year: egen fte_tot = sum(fte)
bysort id year workagencycode: egen fte_district = sum(fte)
bysort id year schoolcode workagencycode: egen fte_school = sum(fte)

bysort id year: egen fte_math = sum(fte) if mathematics == 1
bysort id year (fte_math): replace fte_math = fte_math[_N]

bysort id year: egen fte_eng = sum(fte) if english == 1
bysort id year (fte_eng): replace fte_eng = fte_eng[_N]

bysort id year: egen fte_read = sum(fte) if reading == 1
bysort id year (fte_read): replace fte_read = fte_read[_N]

bysort id year: egen fte_art = sum(fte) if art == 1
bysort id year (fte_art): replace fte_art = fte_art[_N]

bysort id year: egen fte_science = sum(fte) if science == 1
bysort id year (fte_science): replace fte_science = fte_science[_N]

bysort id year: egen fte_title1 = sum(fte) if title1 == 1
bysort id year (fte_title1): replace fte_title1 = fte_title1[_N]

bysort id year: egen fte_crosscat = sum(fte) if crosscat == 1
bysort id year (fte_crosscat): replace fte_crosscat = fte_crosscat[_N]

bysort id year: egen fte_all_elem = sum(fte) if all_elem == 1
bysort id year (fte_all_elem): replace fte_all_elem = fte_all_elem[_N]

* Total number of assignments.
bysort id year: gen nr_assignments_total = _N

* Total number of schools.
bysort id year workagencycode schoolcode: gen nr_schools = _n == 1
bysort id year: replace nr_schools = sum(nr_schools)
bysort id year: replace nr_schools = nr_schools[_N]

* Total number of districts.
bysort id year workagencycode: gen nr_districts = _n == 1
bysort id year: replace nr_districts = sum(nr_districts)
bysort id year: replace nr_districts = nr_districts[_N]

* Drop substitutes.
drop if lt_sub == 1 | st_sub == 1


********************************************************************************
* Prepare Teacher-District-Year Panel
********************************************************************************

keep id id_old lastname firstname female birth year dayscontract localexp ///
    totalexp salary fringe workagencyname workagencycode schoolcode schoolname ///
    county bachelor master specialist phd black hispanic asian mathematics ///
    english art science reading title1 all_elem crosscat fte_tot fte_school ///
    fte_district fte_math fte_eng fte_read fte_art fte_science fte_title1 ///
    fte_crosscat fte_all_elem nr_assignments_total nr_schools nr_districts ///
    lowgrade highgrade

* Adjust one duplicate where district-level contract days differ within teacher-year.
bysort id year workagencycode (dayscontract): gen days1 = dayscontract[1]
bysort id year workagencycode (dayscontract): gen days2 = dayscontract[_N]
gen tag = days1 != days2
bysort id year: replace dayscontract = sum(dayscontract) if tag == 1
bysort id year: replace salary = sum(salary) if tag == 1
bysort id year: replace fringe = sum(fringe) if tag == 1
drop days1 days2 tag

bysort id year workagencycode (dayscontract): ///
    replace dayscontract = dayscontract[_N]
bysort id year (salary): replace salary = salary[_N]
bysort id year (fringe): replace fringe = fringe[_N]
bysort id year workagencycode (localexp): replace localexp = localexp[_N]
bysort id year (totalexp): replace totalexp = totalexp[_N]
duplicates drop

* Ensure demographics are constant within teacher-year.
foreach var in female birth bachelor master specialist phd black hispanic asian {
    bysort id year: egen `var'2 = mode(`var')
    drop `var'
    rename `var'2 `var'
}

foreach var in lastname firstname {
    * Select the same spelling regardless of the incoming observation order.
    bysort id year (`var'): replace `var' = `var'[_N]
}

* Reshape so that one school is one teacher-district-year.
egen school_id_unique = group(workagencycode schoolcode)
egen fakeid = group(id year workagencycode)

* Rank schools by FTE and break exact FTE ties with stable school attributes.
* The official school code is the substantive tie-breaker; the remaining
* fields only order duplicate records for the same school deterministically.
tempvar max_school_fte min_tied_schoolcode
bysort id year workagencycode: egen `max_school_fte' = max(fte_school)
bysort id year workagencycode: egen `min_tied_schoolcode' = ///
    min(cond(fte_school == `max_school_fte', schoolcode, .))
gsort id year workagencycode -fte_school schoolcode schoolname county ///
    lowgrade highgrade
by id year workagencycode: assert ///
    schoolcode[1] == `min_tied_schoolcode'
by id year workagencycode: gen t = _n
drop `max_school_fte' `min_tied_schoolcode'
drop id_old
reshape wide fte_school school_id_unique schoolcode schoolname county ///
    lowgrade highgrade, i(fakeid) j(t)
drop fakeid


********************************************************************************
* Cross-School Mobility
********************************************************************************

egen fakeid = group(id workagencycode)
tsset fakeid year
gen mover_school = school_id_unique1 != l.school_id_unique1
replace mover_school = . if l.school_id_unique1 == .
replace mover_school = . if school_id_unique1 == .

qui forvalues n = 1 / 14 {
    forvalues m = 1 / 14 {
        replace mover_school = 0 if ///
            (school_id_unique`n' == l.school_id_unique`m') & ///
            school_id_unique`n' != . & l.school_id_unique`m' != .
    }
}

bysort id year (mover_school): replace mover_school = mover_school[_N]


********************************************************************************
* Teacher-Year Panel and Cross-District Mobility
********************************************************************************

keep id lastname firstname female birth year dayscontract localexp totalexp ///
    salary fringe workagencyname workagencycode schoolcode1 schoolname1 ///
    county1 bachelor master specialist phd black hispanic asian mathematics ///
    english art science reading title1 all_elem crosscat fte_tot fte_school1 ///
    fte_district fte_math fte_eng fte_read fte_art fte_science fte_title1 ///
    fte_crosscat fte_all_elem nr_assignments_total nr_schools nr_districts ///
    mover_school lowgrade1 highgrade1
duplicates drop
rename fte_school1 fte_school

egen fakeid = group(id year)

* Preserve the existing ascending district-FTE rank and break exact ties by
* official district code. This makes suffix assignment independent of Stata
* edition, processor count, sort seed, and incoming observation order.
tempvar min_district_fte min_tied_districtcode
bysort fakeid: egen `min_district_fte' = min(fte_district)
bysort fakeid: egen `min_tied_districtcode' = ///
    min(cond(fte_district == `min_district_fte', workagencycode, .))
sort fakeid fte_district workagencycode
by fakeid: assert workagencycode[1] == `min_tied_districtcode'
by fakeid: gen t = _n
drop `min_district_fte' `min_tied_districtcode'
reshape wide dayscontract localexp fte_district fte_school schoolcode1 ///
    schoolname1 lowgrade1 highgrade1 workagencyname workagencycode county, ///
    i(fakeid) j(t)
drop fakeid

* Cross-district mover indicator.
tsset id year
gen mover_d = workagencycode1 != l.workagencycode1
replace mover_d = . if l.workagencycode1 == .
replace mover_d = . if workagencycode1 == .

qui forvalues n = 1 / 6 {
    forvalues m = 1 / 6 {
        replace mover_d = 0 if (workagencycode`n' == l.workagencycode`m') & ///
            workagencycode`n' != . & l.workagencycode`m' != .
    }
}

* Exit indicators.
gen x = 1
tsset id year
gen exit = f.x == .
gen exit_temp = exit
replace exit = 0 if f2.x == 1
replace exit = 0 if f3.x == 1
replace exit = . if year == 2016
drop x


********************************************************************************
* Labels, Variable Names, and Experience Adjustment
********************************************************************************

order id lastname firstname year birth totalexp salary fringe bachelor master ///
    specialist phd female mathematics english art science reading title1 ///
    all_elem crosscat fte_tot fte_math fte_eng fte_read fte_art fte_science ///
    fte_title1 fte_crosscat fte_all_elem nr_assignments_total nr_schools ///
    nr_districts mover_d mover_school exit exit_temp, first

label variable id "Teacher unique ID"
label variable mathematics "Teaches Mathematics"
label variable english "Teaches English"
label variable art "Teaches Art"
label variable science "Teaches Science"
label variable reading "Teaches Reading"
label variable title1 "Title 1 Teacher"
label variable all_elem "Teaches All subject - Elementary"
label variable crosscat "Teaches cross-category"
label variable fte_tot "Total FTE"
label variable fte_math "Math FTE (across all schools and districts)"
label variable fte_eng "English FTE (across all schools and districts)"
label variable fte_read "Reading FTE (across all schools and districts)"
label variable fte_art "Art FTE (across all schools and districts)"
label variable fte_science "Science FTE (across all schools and districts)"
label variable fte_crosscat "Cross-category FTE (across all schools and districts)"
label variable fte_title1 "Title 1 FTE (across all schools and districts)"
label variable fte_all_elem "All subjects - Elementary FTE (across all schools and districts)"
label variable nr_assignments_total "Nr of assignments, total"
label variable nr_schools "Nr. schools taught"
label variable nr_districts "Nr. districts taught"
label variable mover_d "Cross-district mover"
label variable mover_school "Cross-school mover"
label variable exit "Exiter, does not reappear"
label variable exit_temp "Exiter, might reappear"
label variable schoolname11 "School name (or district where applicable)"
label variable schoolcode11 "School ID (Wisconsin system)"
label variable fte_school1 "FTE at school"
label variable county11 "County of school"
label variable dayscontract1 "Contract days at district"
label variable localexp1 "Experience with district"
label variable fte_district1 "FTE at district"
label variable workagencyname1 "District name"
label variable workagencycode1 "District ID"

label variable schoolname12 "School name, district 2 (or district where applicable)"
label variable schoolcode12 "School ID, district 2 (Wisconsin system)"
label variable fte_school2 "FTE at school, district 2"
label variable county12 "County of school 2"
label variable dayscontract2 "Contract days at district, district 2"
label variable localexp2 "Experience with district, district 2"
label variable fte_district2 "FTE at district 2"
label variable workagencyname2 "District 2 name"
label variable workagencycode2 "District 2 ID"

label variable schoolname13 "School name, district 3 (or district where applicable)"
label variable schoolcode13 "School ID, district 3 (Wisconsin system)"
label variable fte_school3 "FTE at school, district 3"
label variable county13 "County of school 3"
label variable dayscontract3 "Contract days at district, district 3"
label variable localexp3 "Experience with district, district 3"
label variable fte_district3 "FTE at district 3"
label variable workagencyname3 "District 3 name"
label variable workagencycode3 "District 3 ID"

foreach var in schoolname schoolcode county lowgrade highgrade {
    rename `var'11 `var'
    rename `var'12 `var'2
    rename `var'13 `var'3
}

foreach var in dayscontract localexp fte_district fte_school workagencyname ///
    workagencycode {
    rename `var'1 `var'
}

rename workagencycode district_code

* Adjust experience.
replace totalexp = round(totalexp/10) if year <= 2014
replace localexp = round(localexp/10) if year <= 2014
gen exp = year - birth - 22
replace totalexp = localexp if totalexp > 50 & totalexp > exp
replace totalexp = . if totalexp > 50 & totalexp > exp
bysort id: ipolate totalexp year, gen(expi)
replace totalexp = expi if totalexp == .
replace totalexp = round(totalexp)
replace totalexp = localexp if totalexp == .
drop exp expi

isid id year
sort id year
save "$intdata/teachers_new_JPE.dta", replace

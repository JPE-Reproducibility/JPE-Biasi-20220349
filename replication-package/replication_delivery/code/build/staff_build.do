********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    staff_build.do
* Purpose: Clean raw staff records and construct staff identifiers.
* Creates: staff_large.dta and staff_large_withid_JPE.dta
********************************************************************************

* Drop staff records with missing or zero contract days, FTE, or salary.


********************************************************************************
* Import Fixed-Width Staff Files, 2006-2011
********************************************************************************

foreach y in 06 07 08 09 10 11 {
    qui infix ///
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
        using "$confdata/raw/staff/`y'staff.txt", clear
    * Legacy compatibility: the 2008-2010 fixed-width files lack terminal
    * newlines. The historical target data omit the unterminated final record.
    if inlist("`y'", "08", "09", "10") {
        drop in L
    }
    drop if id == . | salary == 0 | salary == . | ///
        dayscontract == . | dayscontract == 0 | fte == 0 | fte == .
    gen year = 2000 + `y'
    save "$intdata/`y'staff.dta", replace
}


********************************************************************************
* Import Fixed-Width Staff Files, 2012-2014
********************************************************************************

foreach y in 12 13 14 {
    qui infix ///
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
        using "$confdata/raw/staff/`y'staff.txt", clear
    drop if id == . | salary == 0 | salary == . | ///
        dayscontract == . | dayscontract == 0 | fte == 0 | fte == .
    gen year = 2000 + `y'
    save "$intdata/`y'staff.dta", replace
}


********************************************************************************
* Import CSV Staff Files, 2015-2016
********************************************************************************

foreach y in 15 16 {
    insheet using "$confdata/raw/staff/`y'staff.csv", names clear
    rename idnbr id
    rename lastname lastname
    rename firstname firstname
    rename filenumber filenumber
    rename gndr gender
    rename raceethn race
    rename birthyear birth
    rename highdegree highedu
    rename cntrctdays dayscontract
    rename localexp localexp
    rename totalexp totalexp
    rename totsalary salary
    rename totfringe fringe
    rename staffcat staffcat
    rename hireagncycd hireagencycode
    rename workagncycd workagencycode
    rename hireagncytyp hireagencytype
    rename schoolcd schoolcode
    rename positioncd position
    rename assgnareacd area
    rename lowgrd lowgrade
    rename highgrd highgrade
    rename lgsortcd lowgradecode
    rename hgsortcd highgradecode
    rename bilingual bilingual
    rename assgnfte fte
    rename worklocationname workagencyname
    rename schoolname schoolname
    rename grdlevel gradelevel
    rename cesanumber cesa
    rename cntynbr county
    rename workagncytyp workagencytype
    rename mailzipcd zipcode
    rename ltsub lt_substitute
    rename subcntrctd subcontracted
    destring schoolcode, replace
    destring workagencycode, replace force
    destring hireagencytype, replace force
    destring workagencytype, replace force
    drop if id == . | salary == 0 | salary == . | ///
        dayscontract == . | dayscontract == 0 | fte == 0 | fte == .
    keep id lastname firstname filenumber gender race birth highedu ///
        dayscontract localexp totalexp salary fringe staffcat ///
        hireagencycode workagencycode hireagencytype schoolcode position ///
        area lowgrade highgrade lowgradecode highgradecode bilingual fte ///
        workagencyname schoolname gradelevel cesa county workagencytype ///
        zipcode lt_substitute subcontracted
    gen year = 2000 + `y'
    save "$intdata/`y'staff.dta", replace
}


********************************************************************************
* Append Annual Staff Files
********************************************************************************

foreach y in 06 07 08 09 10 11 12 13 14 15 {
    disp `y'
    append using "$intdata/`y'staff.dta"
}

sort id year, stable

save "$intdata/staff_large_JPE.dta", replace

foreach y in 06 07 08 09 10 11 12 13 14 15 16 {
    rm "$intdata/`y'staff.dta"
}


********************************************************************************
* Prepare Staff Names and File Numbers
********************************************************************************

use "$intdata/staff_large_JPE.dta", clear
destring filenum, replace
replace filenum = . if filenum == 0
rename workagencycode district_code
keep id last first gender birth year filenum race district_code
sort last first gender birth year

* Keep only the first element of multi-word last names.
split lastname, gen(Last)
replace lastname = Last1 if Last2 != "" & Last1 != "Van" & ///
    Last1 != "de" & Last1 != "Mc" & Last1 != "O"
gen twolast = Last2 != ""
drop Last*
replace lastname = proper(lastname)

split lastname, gen(Last) parse("-")
replace lastname = Last1 if Last2 != ""
replace lastname = Last2 if Last1 == "A"
replace twolast = 1 if Last2 != ""
drop Last*

* Keep only the first element of multi-word first names.
split firstname, gen(First)
replace firstname = First1 if First2 != ""
gen twofirst = First2 != ""
drop First*
replace firstname = proper(firstname)

split firstname, gen(First) parse("-")
replace firstname = First1 if First2 != ""
replace firstname = First2 if First1 == "A"
replace twofirst = 1 if First2 != ""
drop First*

* Manual name corrections.
replace firstname = "Katherine" if lastname == "Allred" & firstname == "Kate"
replace firstname = "Kathryn" if lastname == "Alcorta" & firstname == "Kathy"
replace firstname = "Kathryn" if lastname == "Debeir" & firstname == "Kathy"
replace firstname = "Kathryn" if lastname == "Semon" & firstname == "Kathy"
replace firstname = "Kathryn" if lastname == "Westfahl" & firstname == "Kathy"
replace firstname = "Catherine" if lastname == "Wickler" & firstname == "Cathy"
replace firstname = "Guadelupe" if lastname == "Ancel" & firstname == "Guadalupe"
replace firstname = "Andrzejewski" if lastname == "Andrzejews" & ///
    firstname == "Katherine"
replace firstname = "Maria" if lastname == "Anderson" & firstname == "Mara"
replace firstname = "Kristine" if firstname == "Kris" & lastname == "Arenson"
replace firstname = "Timothy" if firstname == "Tim" & lastname == "Baumgart"
replace firstname = "Erika" if firstname == "Ericka" & lastname == "Beaumont"
replace firstname = "Joseph" if firstname == "Joaeph"
replace firstname = "Guarinia" if firstname == "Guarina"
replace firstname = "Gretchen" if firstname == "Grechen"
replace firstname = "Norbert" if firstname == "Nobert"
replace firstname = "Judith" if firstname == "Judy"
replace firstname = "Judith" if firstname == "Judi"
replace firstname = "Nicole" if firstname == "Nichole"
replace firstname = "Susan" if firstname == "Sue"
replace firstname = "Juliet" if firstname == "Julie" & lastname == "Draxler"
replace firstname = "Rosemarie" if firstname == "Rose" & lastname == "Cortenbach"
replace firstname = "Katherine" if lastname == "Cowan" & firstname == "Kate"
replace firstname = "Theresa" if firstname == "Therese" & lastname == "Fuller"
replace firstname = "Timothy" if firstname == "Tim" & lastname == "Gardner"
replace firstname = "Johnette" if firstname == "J" & lastname == "Gunderson"
replace firstname = "Janet" if firstname == "Jan" & lastname == "Hansford"
replace firstname = "Melissa" if firstname == "Melisa"
replace firstname = "Sally" if firstname == "Sallyjoyce"
replace firstname = "Daniel" if firstname == "Dan" & lastname == "Hegewald"
replace firstname = "Mary" if firstname == "Marylu" & lastname == "Heldt"
replace firstname = "Jessica" if firstname == "Jesica"
replace firstname = "Kathleen" if firstname == "Kathy" & lastname == "Hennings"
replace firstname = "Mary" if firstname == "Maryann" & lastname == "Hinds"
replace firstname = "Dolores" if firstname == "Delores"
replace firstname = "Charisse" if firstname == "Charise"
replace firstname = "Carl" if firstname == "C" & lastname == "Huth"
replace firstname = "Kristine" if firstname == "Kris" & lastname == "Jack"
replace firstname = "Luann" if firstname == "Lu" & lastname == "Jacobson"
replace firstname = "Patricia" if firstname == "Patsy" & lastname == "Johnson"
replace firstname = "Joann" if firstname == "Jo" & lastname == "Johnson"
replace firstname = "Kate" if firstname == "Kathryn" & lastname == "Jones"
replace firstname = "Patrick" if firstname == "Pat" & lastname == "Keehner"
replace firstname = "Daniel" if firstname == "Dan" & lastname == "King"
replace firstname = "Vicki" if firstname == "Vikki"
replace firstname = "Geralyn" if firstname == "Geri" & lastname == "Knautz"
replace firstname = "Mary" if firstname == "Maryellen" & lastname == "Lachance"
replace firstname = "Katherine" if firstname == "Katie" & lastname == "Lachance"
replace firstname = "Sarah" if firstname == "Sara" & lastname == "Lafriske"
replace firstname = "Christopher" if firstname == "Christoper" & lastname == "Lambert"
replace firstname = "Jo" if firstname == "Joann" & lastname == "Leary"
replace firstname = "Kathryn" if firstname == "Lee" & lastname == "Kathy"
replace firstname = "Frederick" if firstname == "Fred" & lastname == "Leece"
replace firstname = "Jacqueline" if firstname == "Jacquline" & lastname == "Leis"
replace firstname = "Timothy" if firstname == "Tim" & lastname == "Lewis"
replace firstname = "Dianne" if firstname == "Diane" & lastname == "Luba"
replace firstname = "Edwin" if firstname == "Ed" & lastname == "Lucas"
replace firstname = "Allan" if firstname == "Al" & lastname == "Lundquist"
replace firstname = "Bradely" if firstname == "Bradley"
replace firstname = "Kathleen" if lastname == "Mclellan" & firstname == "Kathy"
replace firstname = "Ann" if firstname == "Annmarie" & lastname == "Meissner"
replace firstname = "Darlene" if lastname == "D" & lastname == "Mell"
replace firstname = "Daniel" if firstname == "Dan" & lastname == "Miller"
replace firstname = "Jackie" if firstname == "Jacqulynn" & lastname == "Mitchell"
replace firstname = "Bonnie" if firstname == "Bonnita" & lastname == "Modjeski"
replace firstname = "Frederick" if firstname == "Fred" & lastname == "Morley"
replace firstname = "Anna" if firstname == "Anne" & lastname == "Morrison"
replace firstname = "Kimberly" if firstname == "Kimberley" & lastname == "Muonio"
replace firstname = "Linda" if firstname == "Lynda" & lastname == "Nelson"
replace firstname = "Samuel" if firstname == "Sam" & lastname == "Northey"
replace firstname = "Thomas" if firstname == "Tom" & lastname == "Ojanpera"
replace firstname = "Angie" if firstname == "Angela"
replace firstname = "Wilfred" if firstname == "Welfred" & lastname == "Ortiz"
replace firstname = "Mary" if firstname == "May" & lastname == "Palzkill"
replace firstname = "Kenneth" if firstname == "Ken" & lastname == "Paris"
replace firstname = "Mary" if firstname == "Maryann" & lastname == "Penglase"
replace firstname = "Laura" if firstname == "Laurajo" & lastname == "Peters"
replace firstname = "Myragene" if firstname == "Myrgene" & lastname == "Pettit"
replace firstname = "Donna" if firstname == "D" & lastname == "Polzin"
replace firstname = "Patricia" if firstname == "Patti"
replace firstname = "Jo" if firstname == "Joanne" & lastname == "Revels"
replace firstname = "Marissa" if firstname == "Marisa" & lastname == "Romanelli"
replace firstname = "Allison" if firstname == "Allyson" & lastname == "Ryan"
replace firstname = "Gregory" if firstname == "Greg" & lastname == "Sauve"
replace firstname = "Jeffrey" if firstname == "Jeffery"
replace firstname = "Debra" if firstname == "Deb" & lastname == "Schroeder"
replace firstname = "James" if firstname == "Jim" & lastname == "Schuchardt"
replace firstname = "Janet" if firstname == "Jan" & lastname == "Schuldt"
replace firstname = "Kimberly" if firstname == "Kim" & lastname == "Serene"
replace firstname = "Theresa" if firstname == "Teresa" & lastname == "Shelton"
replace firstname = "Julia" if firstname == "Jubie" & lastname == "Simonson"
replace firstname = "Naomi" if firstname == "Namoi"
replace firstname = "Elizabeth" if firstname == "E" & lastname == "Spear"
replace firstname = "Margaret" if firstname == "Peg" & lastname == "Stachowiak"
replace firstname = "Mary" if firstname == "Maryann" & lastname == "Stellick"
replace firstname = "Douglas" if firstname == "Doug" & lastname == "Straus"
replace firstname = "Jenelle" if firstname == "Jenell"
replace firstname = "Jane" if firstname == "Jan" & lastname == "Wagner"
replace firstname = "Timothy" if firstname == "Tim" & lastname == "Wall"
replace firstname = "Jessie" if firstname == "Jesse" & lastname == "Warner"
replace firstname = "Catherine" if firstname == "Catharine" & lastname == "Wellman"
replace firstname = "Allan" if firstname == "Allen" & lastname == "Wendland"
replace firstname = "Eric" if firstname == "Erica" & lastname == "Wenninger"
replace firstname = "Dustin" if firstname == "Dustian"
replace firstname = "Keshum" if firstname == "Keushum"
replace firstname = "Timothy" if firstname == "Tim" & lastname == "Zander"

* Manual record-level corrections.
replace filenum = 646059 if (lastname == "Johnson" & ///
    firstname == "Christine" & birth == 1979)
replace firstname = "Jonathan" if (lastname == "Jonathon" & ///
    firstname == "Thompson" & birth == 1976 & filenum == 661623)
replace lastname = "Thompson" if (lastname == "Jonathon" & ///
    firstname == "Jonathan" & birth == 1976 & filenum == 661623)
replace firstname = "Billie" if (lastname == "Billie" & ///
    firstname == "Rau" & birth == 1977 & filenum == 637687)
replace lastname = "Rau" if (lastname == "Billie" & ///
    firstname == "Billie" & birth == 1977 & filenum == 637687)
replace filenum = 707967 if (lastname == "Worzella" & firstname == "Jeff")
replace lastname = subinstr(lastname," Jr","",1)
replace lastname = subinstr(lastname," Iii","",1)
replace lastname = subinstr(lastname," Ii","",1)

* Carry forward observed file numbers.
gsort last first birth gender race -year
bysort last first birth gender race: carryforward filenum, replace

preserve
keep if filenum != .
sort id year
save temp.dta, replace
restore

drop if filenum != .
duplicates drop


merge m:m last first gender birth year district_code using "$intdata/roster_JPE.dta"

bysort last first gender birth district_code (year): ///
    carryforward filenum2, replace
drop if _m == 2
drop _m
gsort last first birth gender race -year
bysort last first birth gender race: carryforward filenum2, replace
bysort last first birth gender race (year): carryforward filenum2, replace
drop filenumber
rename filenum2 filenumber
append using temp.dta
gsort last first birth gender race -year
bysort last first birth gender race: carryforward filenum, replace
bysort last first birth gender race (year): carryforward filenum, replace

* Assign an artificial file number where no file number is observed.
egen group = group(last first birth race gender)
replace filenumber = 1000000000000 + group if filenumber == .
drop group two* district_code
keep id year filenumber
sort id year

preserve
use "$intdata/staff_large_JPE.dta", clear
drop filenumber
save temp.dta, replace
restore

duplicates drop id year, force
merge 1:m id year using temp.dta
drop _m


sort filenumber year, stable

save "$intdata/staff_large_withid_JPE.dta", replace
rm temp.dta

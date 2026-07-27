********************************************************************************
* Equilibrium in the Market for Public School Teachers
* Biasi, Fu, and Stromme (JPE)
*
* File:    oldteacher_roster_build.do
* Purpose: Clean legacy teacher roster data for staff-record linkage.
* Creates: roster.dta
********************************************************************************


import delimited ///
    "$confdata/raw/teacher_data_linked/Linked_Staffing_Data_10202015.csv", ///
    clear
keep last_name first_name file_num year race birth sex distidworksite

destring file_num, gen(filenum) force
drop file_num

gen gender = "F" if sex == "F"
replace gender = "M" if sex == "M"
drop sex

destring birth_year, gen(birth) force
drop birth_year

replace race = "" if race == "NA"

rename first_name firstname
rename last_name lastname

destring distidworksite, gen(district_code) force


********************************************************************************
* Standardize Names
********************************************************************************

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


********************************************************************************
* Carry Forward Linkage Information
********************************************************************************

* Keep only the years needed for the staff-linkage panel.
keep if year >= 2006

* Carry forward file numbers and demographics within name-district histories.
replace filenum = . if filenum == 0
gsort lastname firstname birth gender district_code -year
bysort lastname firstname birth gender district_code: ///
    carryforward filenum race gender, replace
bysort lastname firstname birth gender district_code (year): ///
    carryforward filenum race gender, replace
rename filenum filenum2

sort last first birth gender district_code


********************************************************************************
* Manual Name Corrections
********************************************************************************

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

duplicates drop
save "$intdata/roster_JPE.dta", replace

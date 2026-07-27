*===============================================================================
* Table A2 (Model Fit: OLS of Teacher-District Match)
*   Extract Table A2 values into CSV
*===============================================================================

clear all

* Read file line by line
local fn "$fortran_code/estimation_result/result/aux_and_omega_params.txt"

file open myfile using "`fn'", read text
file read myfile line

local nlines = 500
set obs `nlines'
gen str244 rawline = ""

local i = 0
while r(eof)==0 {
    local i = `i' + 1
    replace rawline = `"`macval(line)'"' in `i'
    file read myfile line
}
file close myfile

keep in 1/`i'
gen linenum = _n

* Find section headers
gen is_small = regexm(rawline, `"Small"')
gen is_big = regexm(rawline, `"Big"')

summ linenum if is_small == 1
local small_start = r(min)

summ linenum if is_big == 1
local big_start = r(min)

* Extract values into locals
* Data starts at header + 2 (skipping "Data Model" line)

forvalues j = 1/13 {
    local linepos = `small_start' + 1 + `j'
    local thisline = rawline[`linepos']
    local sd`j' : word 1 of `thisline'
    local sm`j' : word 2 of `thisline'
    local nw : word count `thisline'
    local sl`j' ""
    forvalues k = 3/`nw' {
        local wk : word `k' of `thisline'
        local sl`j' "`sl`j'' `wk'"
    }
    local sl`j' = strtrim("`sl`j''")
}

forvalues j = 1/13 {
    local linepos = `big_start' + 1 + `j'
    local thisline = rawline[`linepos']
    local bd`j' : word 1 of `thisline'
    local bm`j' : word 2 of `thisline'
}

* Build output with correct ordering
* Source: 1=wage, 2=exp(lambda), 3=C1*lambda, 4=inc, 5=inc*exp[1,3],
*   6=inc*exp[4,5], 7=inc*exp[6,10], 8=inc*exp[11,15], 9=samecz,
*   10=urban, 11=suburban, 12=log(dist), 13=Milwaukee
* Table A2: same but log(dist) before urban/suburban
* Mapping: 1,2,3,4,5,6,7,8,9,12,10,11,13

clear
set obs 13

gen str40 label = ""
gen double small_data = .
gen double small_model = .
gen double big_data = .
gen double big_model = .

local order "1 2 3 4 5 6 7 8 9 12 10 11 13"

local row = 1
foreach s of local order {
    replace small_data = real("`sd`s''") in `row'
    replace small_model = real("`sm`s''") in `row'
    replace big_data = real("`bd`s''") in `row'
    replace big_model = real("`bm`s''") in `row'
    replace label = "`sl`s''" in `row'
    local row = `row' + 1
}

* Rename labels to match Table A2
replace label = "d != d0" if label == "inc"
replace label = "d != d0 x exp [1,2]" if regexm(label, "exp\[1,3\]")
replace label = "d != d0 x exp [3,4]" if regexm(label, "exp\[4,5\]")
replace label = "d != d0 x exp [5,9]" if regexm(label, "exp\[6,10\]")
replace label = "d != d0 x exp [10,14]" if regexm(label, "exp\[11,15\]")
replace label = "z_d != z_d0" if label == "samecz"
replace label = "ln(distance)" if label == "log(dist)"
replace label = "q_d: urban" if label == "urban"
replace label = "q_d: suburban" if label == "suburban"
replace label = "q_d: large metro" if label == "Milwaukee"
replace label = "c1 x lambda" if label == "C1 * lambda"

* Rename columns 
rename small_data inferred_data 
rename small_model inferred_model 
rename big_data all_data
rename big_model all_model

* Export
export delimited label inferred_data inferred_model all_data all_model ///
    using "$out/tables/Table_A2.csv", replace

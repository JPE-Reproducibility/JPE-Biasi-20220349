*===============================================================================
* Table B23 (Model Fit: OLS of District Wage Schedule)
*   Extract Table B23 values into CSV
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
gen is_omega1 = regexm(rawline, "omega1 OLS")
gen is_omega2 = regexm(rawline, "omega2")  & regexm(rawline, "OLS")

summ linenum if is_omega1 == 1
local omega1_start = r(min)

summ linenum if is_omega2 == 1 & linenum > `omega1_start'
local omega2_start = r(min)

* Extract omega1 values (17 rows: header + 1 skip + 17 data lines)
forvalues j = 1/17 {
    local linepos = `omega1_start' + 1 + `j'
    local thisline = rawline[`linepos']
    local o1d`j' : word 1 of `thisline'
    local o1m`j' : word 2 of `thisline'
    * Get label (remaining words)
    local nw : word count `thisline'
    local o1l`j' ""
    forvalues k = 3/`nw' {
        local wk : word `k' of `thisline'
        local o1l`j' "`o1l`j'' `wk'"
    }
    local o1l`j' = strtrim("`o1l`j''")
}

* Extract omega2 values (17 rows)
forvalues j = 1/17 {
    local linepos = `omega2_start' + 1 + `j'
    local thisline = rawline[`linepos']
    local o2d`j' : word 1 of `thisline'
    local o2m`j' : word 2 of `thisline'
}

* Build output
* Source ordering: 1=Exp3, 2=Exp4, 3=Exp5, 4=Exp6, 5=master, 6=lambda,
*   7=tc, 8=tc_tenured, 9=budget_pc, 10=capacity, 11=urban, 12=suburban,
*   13=milwaukee, 14=cz_tc, 15=cz share ten, 16=share dem vote, 17=intercept
*
* Table B23 ordering (excluding intercept):
*   Exp3, Exp4, Exp5, Exp6, master, tc, tc_tenured,
*   lambda, budget_pc, capacity, urban, suburban, milwaukee, share dem vote,
*   cz_tc, cz share ten
* Mapping: 1,2,3,4,5,7,8,6,9,10,11,12,13,16,14,15

clear
set obs 16

gen str40 label = ""
gen double omega1_data = .
gen double omega1_model = .
gen double omega2_data = .
gen double omega2_model = .

local order "1 2 3 4 5 7 8 6 9 10 11 12 13 16 14 15"

local row = 1
foreach s of local order {
    replace omega1_data = `o1d`s'' in `row'
    replace omega1_model = `o1m`s'' in `row'
    replace omega2_data = `o2d`s'' in `row'
    replace omega2_model = `o2m`s'' in `row'
    local row = `row' + 1
}

* Assign labels matching Table B23
replace label = "Fr(experience 3-4)" in 1
replace label = "Fr(experience 5-9)" in 2
replace label = "Fr(experience 10-14)" in 3
replace label = "Fr(experience >= 15)" in 4
replace label = "Fr(MA or above)" in 5
replace label = "Average TC" in 6
replace label = "Average TC among Tenured" in 7
replace label = "lambda_d" in 8
replace label = "budget per teacher" in 9
replace label = "capacity" in 10
replace label = "urban" in 11
replace label = "suburban" in 12
replace label = "large metro" in 13
replace label = "share Democratic votes (2012)" in 14
replace label = "Average TC (nearby)" in 15
replace label = "Share of Tenured (nearby)" in 16

* Export
export delimited label omega1_data omega1_model omega2_data omega2_model ///
    using "$out/tables/Table_B23.csv", replace

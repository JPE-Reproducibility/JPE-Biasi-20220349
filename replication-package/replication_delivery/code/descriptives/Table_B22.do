*===============================================================================
* Table B22 (Model Fit: Average District Employee Characteristics)
*   Extract Table B22 values into CSV
*===============================================================================

clear all

* Read file line by line
local fn "$fortran_code/estimation_result/result/other_aux_params.txt"

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
gen is_allteachers = regexm(rawline, `"All Teachers"')
gen is_lambda = regexm(rawline, `"Lambda quintiles"')
gen is_budget = regexm(rawline, `"Budget per teacher quintiles"')
gen is_suburban = regexm(rawline, `"Suburban .1st row. vs. non-suburban"')
gen is_urban = regexm(rawline, `"Urban .1st row. vs. non-urban"')
gen is_fraction = regexm(rawline, `"Fraction of districts who only"')

summ linenum if is_lambda == 1
local lambda_start = r(min)

summ linenum if is_budget == 1
local budget_start = r(min)

summ linenum if is_suburban == 1
local suburban_start = r(min)

summ linenum if is_urban == 1
local urban_start = r(min)

* Extract Lambda quintile values (skip header line, take first 4 of 5 quintiles)
* Columns: exp_data exp_model v1_data v1_model v2_data v2_model deg_data deg_model
forvalues j = 1/4 {
    local linepos = `lambda_start' + 1 + `j'
    local thisline = rawline[`linepos']
    local lam_exp_d`j' : word 1 of `thisline'
    local lam_exp_m`j' : word 2 of `thisline'
    local lam_v1_d`j'  : word 3 of `thisline'
    local lam_v1_m`j'  : word 4 of `thisline'
    local lam_v2_d`j'  : word 5 of `thisline'
    local lam_v2_m`j'  : word 6 of `thisline'
    local lam_deg_d`j' : word 7 of `thisline'
    local lam_deg_m`j' : word 8 of `thisline'
}

* Extract Budget quintile values (first 4 of 5 quintiles)
forvalues j = 1/4 {
    local linepos = `budget_start' + 1 + `j'
    local thisline = rawline[`linepos']
    local bud_exp_d`j' : word 1 of `thisline'
    local bud_exp_m`j' : word 2 of `thisline'
    local bud_v1_d`j'  : word 3 of `thisline'
    local bud_v1_m`j'  : word 4 of `thisline'
    local bud_v2_d`j'  : word 5 of `thisline'
    local bud_v2_m`j'  : word 6 of `thisline'
    local bud_deg_d`j' : word 7 of `thisline'
    local bud_deg_m`j' : word 8 of `thisline'
}

* Extract Suburban (1st data row after header)
local linepos = `suburban_start' + 1 + 1
local thisline = rawline[`linepos']
local sub_exp_d : word 1 of `thisline'
local sub_exp_m : word 2 of `thisline'
local sub_v1_d  : word 3 of `thisline'
local sub_v1_m  : word 4 of `thisline'
local sub_v2_d  : word 5 of `thisline'
local sub_v2_m  : word 6 of `thisline'
local sub_deg_d : word 7 of `thisline'
local sub_deg_m : word 8 of `thisline'

* Extract Urban (1st data row after header)
local linepos = `urban_start' + 1 + 1
local thisline = rawline[`linepos']
local urb_exp_d : word 1 of `thisline'
local urb_exp_m : word 2 of `thisline'
local urb_v1_d  : word 3 of `thisline'
local urb_v1_m  : word 4 of `thisline'
local urb_v2_d  : word 5 of `thisline'
local urb_v2_m  : word 6 of `thisline'
local urb_deg_d : word 7 of `thisline'
local urb_deg_m : word 8 of `thisline'

* Build output dataset
clear
set obs 10

gen str40 district_group = ""
gen str20 subgroup = ""
gen double exp_data = .
gen double exp_model = .
gen double deg_data = .
gen double deg_model = .
gen double ten_c1_data = .
gen double ten_c1_model = .
gen double ten_c2_data = .
gen double ten_c2_model = .

* Lambda quintiles (rows 1-4)
forvalues j = 1/4 {
    replace district_group = "lambda_d" in `j'
    replace subgroup = "Quintile `j'" in `j'
    replace exp_data = `lam_exp_d`j'' in `j'
    replace exp_model = `lam_exp_m`j'' in `j'
    replace deg_data = `lam_deg_d`j'' in `j'
    replace deg_model = `lam_deg_m`j'' in `j'
    replace ten_c1_data = 10 * `lam_v1_d`j'' in `j'
    replace ten_c1_model = 10 * `lam_v1_m`j'' in `j'
    replace ten_c2_data = 10 * `lam_v2_d`j'' in `j'
    replace ten_c2_model = 10 * `lam_v2_m`j'' in `j'
}

* Budget quintiles (rows 5-8)
forvalues j = 1/4 {
    local row = 4 + `j'
    replace district_group = "budget_capacity" in `row'
    replace subgroup = "Quintile `j'" in `row'
    replace exp_data = `bud_exp_d`j'' in `row'
    replace exp_model = `bud_exp_m`j'' in `row'
    replace deg_data = `bud_deg_d`j'' in `row'
    replace deg_model = `bud_deg_m`j'' in `row'
    replace ten_c1_data = 10 * `bud_v1_d`j'' in `row'
    replace ten_c1_model = 10 * `bud_v1_m`j'' in `row'
    replace ten_c2_data = 10 * `bud_v2_d`j'' in `row'
    replace ten_c2_model = 10 * `bud_v2_m`j'' in `row'
}

* Urban (row 9)
replace district_group = "Urban" in 9
replace subgroup = "" in 9
replace exp_data = `urb_exp_d' in 9
replace exp_model = `urb_exp_m' in 9
replace deg_data = `urb_deg_d' in 9
replace deg_model = `urb_deg_m' in 9
replace ten_c1_data = 10 * `urb_v1_d' in 9
replace ten_c1_model = 10 * `urb_v1_m' in 9
replace ten_c2_data = 10 * `urb_v2_d' in 9
replace ten_c2_model = 10 * `urb_v2_m' in 9

* Suburban (row 10)
replace district_group = "Suburban" in 10
replace subgroup = "" in 10
replace exp_data = `sub_exp_d' in 10
replace exp_model = `sub_exp_m' in 10
replace deg_data = `sub_deg_d' in 10
replace deg_model = `sub_deg_m' in 10
replace ten_c1_data = 10 * `sub_v1_d' in 10
replace ten_c1_model = 10 * `sub_v1_m' in 10
replace ten_c2_data = 10 * `sub_v2_d' in 10
replace ten_c2_model = 10 * `sub_v2_m' in 10

* Export
export delimited district_group subgroup exp_data exp_model deg_data deg_model ///
    ten_c1_data ten_c1_model ten_c2_data ten_c2_model ///
    using "$out/tables/Table_B22.csv", replace

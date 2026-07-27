*===============================================================================
* Table A3, Panel A (Model Fit: District Wage Schedules)
* Extract Table A3, Panel A values into CSV
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

* Find key lines
gen is_omega_moments = regexm(rawline, "omega moments")
gen is_omega_old = regexm(rawline, "omega old")
gen is_pr_omega2_1 = regexm(rawline, "Pr_Omega2\( 1\)")

summ linenum if is_omega_moments == 1
local om_start = r(min)

summ linenum if is_omega_old == 1
local om_old_line = r(min)

summ linenum if is_pr_omega2_1 == 1
local pr_o2_1_line = r(min)

* Extract omega moments (5 data lines after header)
forvalues j = 1/5 {
    local linepos = `om_start' + `j'
    local thisline = rawline[`linepos']
    local omv1_`j' : word 1 of `thisline'
    local omv2_`j' : word 2 of `thisline'
}

* Extract omega old (data is on the NEXT line after "omega old" header)
local linepos = `om_old_line' + 1
local thisline = rawline[`linepos']
local old_d : word 1 of `thisline'
local old_m : word 2 of `thisline'

* Extract Pr_Omega2(1) (data is on the line itself: "0.49878 0.41879 Pr_Omega2( 1)")
local thisline = rawline[`pr_o2_1_line']
local pr2_d : word 1 of `thisline'
local pr2_m : word 2 of `thisline'

* Build output
clear
set obs 4

gen str40 label_left = ""
gen double left_data = .
gen double left_model = .
gen str40 label_right = ""
gen double right_data = .
gen double right_model = .

* Row 1: E(omega1) | E(omega2)
replace label_left = "E(omega1)" in 1
replace left_data = `omv1_1' in 1
replace left_model = `omv2_1' in 1
replace label_right = "E(omega2)" in 1
replace right_data = `omv1_2' in 1
replace right_model = `omv2_2' in 1

* Row 2: E(omega1^2) | E(omega2^2)
replace label_left = "E(omega1^2)" in 2
replace left_data = `omv1_4' in 2
replace left_model = `omv2_4' in 2
replace label_right = "E(omega2^2)" in 2
replace right_data = `omv1_5' in 2
replace right_model = `omv2_5' in 2

* Row 3: E(omega1*omega2) | (blank)
replace label_left = "E(omega1*omega2)" in 3
replace left_data = `omv1_3' in 3
replace left_model = `omv2_3' in 3
replace label_right = "" in 3

* Row 4: Fr((omega1,omega2)=(1,0)) | Fr(omega2=0)
replace label_left = "Fr((omega1,omega2)=(1,0))" in 4
replace left_data = `old_d' in 4
replace left_model = `old_m' in 4
replace label_right = "Fr(omega2=0)" in 4
replace right_data = `pr2_d' in 4
replace right_model = `pr2_m' in 4

* Round to hundredths
replace left_data = round(left_data, 0.01)
replace left_model = round(left_model, 0.01)
replace right_data = round(right_data, 0.01)
replace right_model = round(right_model, 0.01)

format left_data left_model right_data right_model %9.2f


* Export
export delimited label_left left_data left_model label_right right_data right_model ///
    using "$out/tables/Table_A3_PanelA.csv", replace

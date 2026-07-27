*===============================================================================
* Format Table 5 from initial_param_guess.txt and se_param.txt
*===============================================================================
clear all

*--- STEP 1: Read initial_param_guess.txt line by line ---
tempname fh
file open `fh' using "$fortran_code/estimation_result/initial_param_guess.txt", read text

local nlines = 0
file read `fh' line
* Skip header line
file read `fh' line

while r(eof) == 0 {
    if `"`line'"' != "" & strpos(`"`line'"', "Best") == 0 {
        local ++nlines
        local mparam_`nlines' = word(`"`line'"', 4)
        local desc_`nlines' ""
        local w = 6
        local wd = word(`"`line'"', `w')
        while `"`wd'"' != "" {
            local desc_`nlines' `"`desc_`nlines'' `wd'"'
            local ++w
            local wd = word(`"`line'"', `w')
        }
        local desc_`nlines' = strtrim(`"`desc_`nlines''"')
    }
    file read `fh' line
}
file close `fh'

set obs `nlines'
gen double model_param = .
gen str200 description = ""
gen param_order = _n

forval i = 1/`nlines' {
    replace model_param = real("`mparam_`i''") in `i'
    replace description = `"`desc_`i''"' in `i'
}

*--- STEP 2: Read se_param.txt ---
local se_all ""
tempname fh2
file open `fh2' using "$fortran_code/stderr/result/se_param.txt", read text
file read `fh2' line
while r(eof) == 0 {
    local se_all `"`se_all' `line'"'
    file read `fh2' line
}
file close `fh2'
local se_all = strtrim(`"`se_all'"')

local nwords = wordcount(`"`se_all'"')
local npairs = `nwords' / 2

gen double se = .

forval p = 1/`npairs' {
    local pos_est = (`p' - 1) * 2 + 1
    local pos_se  = `pos_est' + 1
    local est_val = word(`"`se_all'"', `pos_est')
    local sev = word(`"`se_all'"', `pos_se')
    
    local est_num = real("`est_val'")
    local se_num = real("`sev'")
    
    replace se = `se_num' if abs(model_param - `est_num') / max(abs(model_param), 1e-10) < 1e-6 & se == .
}

*--- STEP 3: Assign table structure ---
gen int panel = .
gen int side = .
gen int order = .
gen str60 parameter = ""

* Panel A
replace panel = 1 if strpos(description, "alpha")
replace panel = 1 if strpos(description, "sigma") & !strpos(description, "sigmaD")

* Panel A Left side
replace side = 1 if panel == 1 & (strpos(description, "urban") | ///
    strpos(description, "suburban") | strpos(description, "Milwaukee") | ///
    strpos(description, "lambda") | strpos(description, "C1") | ///
    strpos(description, "sigma"))

* Panel A Right side
replace side = 2 if panel == 1 & side == .

* Panel B
replace panel = 2 if strpos(description, "beta") | strpos(description, "c2") | ///
    strpos(description, "master")

* Panel B Left
replace side = 1 if panel == 2 & (strpos(description, "exp factor 1") | ///
    strpos(description, "c2") | strpos(description, "master"))
* Panel B Right
replace side = 2 if panel == 2 & side == .

* Panel C
replace panel = 3 if strpos(description, "gamma") | strpos(description, "sigmaD")
replace side = 1 if panel == 3

* --- Orders ---
* Panel A Left
replace order = 1 if panel == 1 & side == 1 & strpos(description, "exp(lambda)")
replace order = 2 if panel == 1 & side == 1 & strpos(description, "C1 * lambda")
replace order = 3 if panel == 1 & side == 1 & strpos(description, "urban")
replace order = 4 if panel == 1 & side == 1 & strpos(description, "suburban")
replace order = 5 if panel == 1 & side == 1 & strpos(description, "Milwaukee")
replace order = 6 if panel == 1 & side == 1 & strpos(description, "sigma")

* Panel A Right
replace order = 1 if panel == 1 & side == 2 & strpos(description, "exp1")
replace order = 2 if panel == 1 & side == 2 & strpos(description, "exp2")
replace order = 3 if panel == 1 & side == 2 & strpos(description, "exp3")
replace order = 4 if panel == 1 & side == 2 & strpos(description, "exp4")
replace order = 5 if panel == 1 & side == 2 & strpos(description, "exp5")
replace order = 6 if panel == 1 & side == 2 & strpos(description, "exp6")
replace order = 7 if panel == 1 & side == 2 & strpos(description, "same CZ")
replace order = 8 if panel == 1 & side == 2 & strpos(description, "logdist")

* Panel B Left
replace order = 1 if panel == 2 & side == 1 & strpos(description, "exp factor 1")
replace order = 2 if panel == 2 & side == 1 & strpos(description, "c2")
replace order = 3 if panel == 2 & side == 1 & strpos(description, "master")

* Panel B Right
replace order = 1 if panel == 2 & side == 2 & strpos(description, "exp factor 2")
replace order = 2 if panel == 2 & side == 2 & strpos(description, "exp factor 3")
replace order = 3 if panel == 2 & side == 2 & strpos(description, "exp factor 4")
replace order = 4 if panel == 2 & side == 2 & strpos(description, "exp factor 5")
replace order = 5 if panel == 2 & side == 2 & strpos(description, "exp factor 6")

* Panel C
* Panel C
replace order = 1 if panel == 3 & strpos(description, "gamma 1")
replace order = 2 if panel == 3 & strpos(description, "gamma 3")
replace order = 3 if panel == 3 & strpos(description, "gamma 5")
replace order = 4 if panel == 3 & strpos(description, "gamma 2")
replace order = 5 if panel == 3 & strpos(description, "gamma 4")
replace order = 6 if panel == 3 & strpos(description, "gamma 6")
replace order = 7 if panel == 3 & strpos(description, "sigmaD")

*--- STEP 4: Create display labels ---
replace parameter = "e^lambda_d" if panel == 1 & side == 1 & order == 1
replace parameter = "c1 x lambda_d" if panel == 1 & side == 1 & order == 2
replace parameter = "q_d: urban" if panel == 1 & side == 1 & order == 3
replace parameter = "q_d: suburban" if panel == 1 & side == 1 & order == 4
replace parameter = "q_d: large metro" if panel == 1 & side == 1 & order == 5
replace parameter = "sigma_epsilon" if panel == 1 & side == 1 & order == 6

replace parameter = "I(d!=d0) x Yrs exp: 1-2" if panel == 1 & side == 2 & order == 1
replace parameter = "I(d!=d0) x Yrs exp: 3-4" if panel == 1 & side == 2 & order == 2
replace parameter = "I(d!=d0) x Yrs exp: 5-9" if panel == 1 & side == 2 & order == 3
replace parameter = "I(d!=d0) x Yrs exp: 10-14" if panel == 1 & side == 2 & order == 4
replace parameter = "I(d!=d0) x Yrs exp: >=15 (a)" if panel == 1 & side == 2 & order == 5
replace parameter = "I(d!=d0) x Yrs exp: >=15 (b)" if panel == 1 & side == 2 & order == 6
replace parameter = "I(z_d != z_d0)" if panel == 1 & side == 2 & order == 7
replace parameter = "ln(distance in miles)" if panel == 1 & side == 2 & order == 8

replace parameter = "c1 [normalized]" if panel == 2 & side == 1 & order == 1
replace parameter = "c2" if panel == 2 & side == 1 & order == 2
replace parameter = "MA or above" if panel == 2 & side == 1 & order == 3
replace parameter = "Yrs exp: 1-2" if panel == 2 & side == 2 & order == 1
replace parameter = "Yrs exp: 3-4" if panel == 2 & side == 2 & order == 2
replace parameter = "Yrs exp: 5-9" if panel == 2 & side == 2 & order == 3
replace parameter = "Yrs exp: 10-14" if panel == 2 & side == 2 & order == 4
replace parameter = "Yrs exp: >=15" if panel == 2 & side == 2 & order == 5

replace parameter = "Xi_00 (fixed cost)" if panel == 3 & order == 1
replace parameter = "Xi_10 (omega_1 deviation)" if panel == 3 & order == 2
replace parameter = "Xi_20 (omega_2 deviation)" if panel == 3 & order == 3
replace parameter = "Xi_01 (dem)" if panel == 3 & order == 4
replace parameter = "Xi_11 (dem x omega_1 deviation" if panel == 3 & order == 5
replace parameter = "Xi_12 (dem x omega_2 deviation)" if panel == 3 & order == 6
replace parameter = "sigmaD" if panel == 3 & order == 7

*--- STEP 5: Negate same district/CZ parameters for I(d!=d0) presentation ---
replace model_param = -model_param if panel == 1 & side == 2 & ///
    (strpos(description, "same district") | strpos(description, "same CZ"))

*--- STEP 6: Format to decimal places ---
gen double estimate = model_param

* SE: all to hundredths (2 decimal places)
gen str20 se_fmt = ""
replace se_fmt = string(se, "%9.2f") if !missing(se)

* Estimates: default to hundredths (2 decimal places)
gen str20 est_fmt = ""
replace est_fmt = string(estimate, "%9.2f") if !missing(estimate)

* Override: "MA or above" estimate to 6 decimal places
replace est_fmt = string(estimate, "%12.6f") if parameter == "MA or above"

* Override: Panel B Right (Yrs exp) estimates to 3 decimal places (thousandths)
replace est_fmt = string(estimate, "%9.3f") if panel == 2 & side == 2

* Handle normalized zero
replace est_fmt = "0" if estimate == 0

*--- STEP 7: Export ---
gen str10 table = ""
replace table = "Table 5" if panel == 1 | panel == 2
replace table = "Table A1" if panel == 3

gen str10 panel_desc = ""
replace panel_desc = "A" if panel == 1
replace panel_desc = "B" if panel == 2
replace panel_desc = "--" if panel == 3

keep table panel_desc panel side order parameter est_fmt se_fmt
rename est_fmt estimate
rename se_fmt se
sort panel side order

drop panel side order
order table panel_desc parameter estimate se
export delimited using "$out/tables/Table_5_Table_A1.csv", replace

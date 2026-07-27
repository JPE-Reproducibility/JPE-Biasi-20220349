

* build_wageschedule_exitentry.do
* Created: 11/22
* Author: JStromme
*
* This file splits out wageschedule by ba and ma, which is necessary for 
*     the forward/exit-entry exercise

clear all

* Use the "tag" file as a district filter, if needed
*    i.e., so we only keep dists we have in the model from schedule_new
*tempfile tmp_districts
*use "$raw/district_id_tag.dta", clear
*save `tmp_districts', replace

* Load main schedule and filter
use "$est/schedule_new.dta", clear
*merge m:1 district_code using `tmp_districts', keep(match) nogenerate
rename district_code District

* BA wage schedule
preserve
keep District CExp1_ba CExp2_ba CExp3_ba CExp4_ba CExp5_ba CExp6_ba
foreach v of varlist CExp*_ba {
    replace `v' = `v' / 1000
}
export delimited using "$est/wageschedule_ba.csv", replace
restore

* MA wage schedule
preserve
keep District CExp1_ma CExp2_ma CExp3_ma CExp4_ma CExp5_ma CExp6_ma
foreach v of varlist CExp*_ma {
    replace `v' = `v' / 1000
}
export delimited using "$est/wageschedule_ma.csv", replace

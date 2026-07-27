*===============================================================================
* Figure 4: CDF of omega2 by lambda
*===============================================================================

clear all

*-------------------------------------------------------------
* 1. Import and reshape lambda
*-------------------------------------------------------------
import delimited "$est/lambda.csv", varnames(nonames) clear
gen id = _n

* Pivot from wide to long
reshape long v, i(id) j(col)
drop id col
rename v lambda
gen obs = _n
tempfile lambda
save `lambda'

*-------------------------------------------------------------
* 2. Import and reshape omega1 (alpha1)
*-------------------------------------------------------------
import delimited "$est/alpha1.csv", varnames(nonames) clear
gen id = _n

reshape long v, i(id) j(col)
drop id col
rename v omega1
gen obs = _n
tempfile omega1
save `omega1'

*-------------------------------------------------------------
* 3. Import and reshape omega2 (alpha2)
*-------------------------------------------------------------
import delimited "$est/alpha2.csv", varnames(nonames) clear
gen id = _n

reshape long v, i(id) j(col)
drop id col
rename v omega2
gen obs = _n
tempfile omega2
save `omega2'

*-------------------------------------------------------------
* 4. Merge all three together
*-------------------------------------------------------------
use `lambda', clear
merge 1:1 obs using `omega1', nogen
merge 1:1 obs using `omega2', nogen
drop obs

*-------------------------------------------------------------
* 5. Create high/low lambda groups based on median
*-------------------------------------------------------------
summarize lambda, detail
local med = r(p50)

gen Group = cond(lambda > `med', 2, 1)
label define grp 1 "Low Lambda" 2 "High Lambda"
label values Group grp

*-------------------------------------------------------------
* 6. Compute CDF of omega2 by Group
*-------------------------------------------------------------
* Count observations per Group-omega2 cell
contract Group omega2, freq(ct)

* Compute CDF within each group
sort Group omega2
by Group: gen CDF = sum(ct)
by Group: replace CDF = CDF / CDF[_N]

*-------------------------------------------------------------
* 7. Reshape wide for graphing
*-------------------------------------------------------------
drop ct
reshape wide CDF, i(omega2) j(Group)

*-------------------------------------------------------------
* 8. Graph
*-------------------------------------------------------------
graph set window fontface "Times New Roman"

twoway ///
  (connected CDF1 omega2, color(black) msymbol(Sh) lwidth(thick) msize(large)) ///
  (connected CDF2 omega2, color(gs8) lp(dash) msymbol(T) lwidth(thick) msize(large)), ///
  ytitle("CDF({&omega}{subscript:2})", size(large)) ///
  xtitle("{&omega}{subscript:2}", size(large)) ///
  legend(order(1 "{&lambda} in bottom 50%" 2 "{&lambda} in top 50%") ///
    ring(0) pos(5) size(large)) ///
  scheme(plotplain) yline(1) xsize(7) ///
  ylabel(.4(.1)1, labsize(large)) xlabel(,labsize(large))

graph export "$out/figures/Figure_4_omega2_cdf.png", replace

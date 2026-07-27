** Graph "Figure B9" the simple exercise to illustrate identification

* Set dir to the overall replication folder

use "$code/Figure_B9/cutoffs_id_exercise.dta", clear


twoway scatter c2 c1, colorvar(d_dist1_1) scheme(plotplain)

sepscatter c2 c1, separate(d_dist1_1) scheme(plotplain) ytitle("C2") xtitle("C1") title("District Matches for b = 0.2") legend(order( 2 "District 1" 1 "District 2") ring(0) pos(5)) mc(navy cranberry) ms(S Oh) xsize(5)

graph export "$out/figures/Figure_B9_b_02.png", replace

sepscatter c2 c1, separate(d_dist1_2) scheme(plotplain) ytitle("C2") xtitle("C1") title("District Matches for b = 1") legend(order( 2 "District 1" 1 "District 2") ring(0) pos(5)) mc(navy cranberry) ms(S Oh) xsize(5)

graph export "$out/figures/Figure_B9_b_1.png", replace

sepscatter c2 c1, separate(d_dist1_3) scheme(plotplain) ytitle("C2") xtitle("C1") title("District Matches for b = 5") legend(order( 2 "District 1" 1 "District 2") ring(0) pos(5)) mc(navy cranberry) ms(S Oh) xsize(5)

graph export "$out/figures/Figure_B9_b_5.png", replace

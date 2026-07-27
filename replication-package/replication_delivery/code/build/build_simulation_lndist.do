* build_simulation_lndist.do
* Created: 11/22
* Author: JStromme
*
* This file creates log-distances for the simulation/validation set teachers

clear all

* ============================================================================
* Build the Pre/validation/simulation version of lndist
* ============================================================================

* Load distances into Mata
use "$raw/district_distance_sdid.dta", clear
destring d1, replace force
destring d2, replace force
mata: dist_d1 = st_data(., "d1")
mata: dist_d2 = st_data(., "d2")
mata: dist_val = st_data(., "distance")

* Load validation tags
use "$raw/district_id_tag_validation.dta", clear
mata: tags_val = st_data(., "district_code")

* Load incumbent pre matrix
use "$sim/incumbent_pre_NEW.dta", clear
capture drop id
mata: inc_pre = st_data(., .)

mata:
    ndist_val = rows(tags_val)
    nteach_val = rows(inc_pre)
    
    dist_matrix_val = J(ndist_val, ndist_val, 0)
    for (k = 1; k <= rows(dist_d1); k++) {
        idx1 = 0
        idx2 = 0
        for (a = 1; a <= ndist_val; a++) {
            if (dist_d1[k] == tags_val[a]) idx1 = a
            if (dist_d2[k] == tags_val[a]) idx2 = a
        }
        if (idx1 > 0 & idx2 > 0) {
            dist_matrix_val[idx1, idx2] = dist_val[k]
        }
    }
    
    lndist_pre = J(nteach_val, ndist_val, 0)
    for (i = 1; i <= nteach_val; i++) {
        inc_idx = 0
        for (c = 1; c <= cols(inc_pre); c++) {
            if (inc_pre[i, c] == 1) {
                inc_idx = c
                break
            }
        }
        if (inc_idx > 0 & inc_idx <= ndist_val) {
            for (j = 1; j <= ndist_val; j++) {
                dd = dist_matrix_val[inc_idx, j]
                if (dd > 0 & dd != .) {
                    lndist_pre[i, j] = ln(dd)
                }
            }
        }
    }
    
    unlink("$sim/lndist_pre.csv")
    fh = fopen("$sim/lndist_pre.csv", "w")
    for (i = 1; i <= nteach_val; i++) {
        line = ""
        for (j = 1; j <= ndist_val; j++) {
            if (j == 1) line = strofreal(lndist_pre[i, j], "%21.14g")
            else line = line + " " + strofreal(lndist_pre[i, j], "%21.14g")
        }
        fput(fh, line)
    }
    fclose(fh)
end


* build_distance_matrix.do
* Created: 11/22
* Author: JStromme
*
* This file creates log-distance matrices between all districts

clear all

* ============================================================================
* Create District-to-district log-distance matrix
* ============================================================================

* Load distances into Mata
use "$raw/district_distance_sdid.dta", clear
destring d1, replace force
destring d2, replace force
mata: dist_d1 = st_data(., "d1")
mata: dist_d2 = st_data(., "d2")
mata: dist_val = st_data(., "distance")

* Load tags
use "$raw/district_id_tag.dta", clear
mata: tags = st_data(., "district_code")

mata:
    ndist = rows(tags)
    
    dist_matrix = J(ndist, ndist, 0)
    for (k = 1; k <= rows(dist_d1); k++) {
        idx1 = 0
        idx2 = 0
        for (a = 1; a <= ndist; a++) {
            if (dist_d1[k] == tags[a]) idx1 = a
            if (dist_d2[k] == tags[a]) idx2 = a
        }
        if (idx1 > 0 & idx2 > 0) {
            dist_matrix[idx1, idx2] = dist_val[k]
        }
    }
    
    logdist_dd = J(ndist, ndist, 0)
    for (i = 1; i <= ndist; i++) {
        for (j = 1; j <= ndist; j++) {
            if (i != j) {
                dd = dist_matrix[i, j]
                if (dd > 0 & dd != .) {
                    logdist_dd[i, j] = ln(dd)
                }
            }
        }
    }
    
    unlink("$est/logdist_btwn_districts.csv")
    fh = fopen("$est/logdist_btwn_districts.csv", "w")
    for (i = 1; i <= ndist; i++) {
        line = ""
        for (j = 1; j <= ndist; j++) {
            if (j == 1) line = strofreal(logdist_dd[i, j], "%21.14g")
            else line = line + " " + strofreal(logdist_dd[i, j], "%21.14g")
        }
        fput(fh, line)
    }
    fclose(fh)
    
end

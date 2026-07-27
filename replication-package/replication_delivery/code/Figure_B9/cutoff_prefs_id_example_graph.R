# cutoff_prefs_id_example_graph.R
# Created: Fall 2024
# Author: JStromme
#
# This is a simulation exercise to illustrate part of the ID argument
#   The results are shown in Figure B9, which is produced by stata for
#   consistent formatting
#

rm(list = ls()) # clear environment

# Locate the replication root without changing the caller's working directory.
# Under Rscript, use this file's location. When sourced interactively, accept
# the replication root, its parent, code/, or this script's directory as the
# starting working directory.
script_arg <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)

if (length(script_arg) > 0L) {
  script_path <- normalizePath(
    sub("^--file=", "", script_arg[[1L]]),
    mustWork = TRUE
  )
  replication_root <- normalizePath(
    file.path(dirname(script_path), "..", ".."),
    mustWork = TRUE
  )
} else {
  candidate_roots <- unique(c(
    getwd(),
    file.path(getwd(), "replication"),
    file.path(getwd(), ".."),
    file.path(getwd(), "..", "..")
  ))
  is_replication_root <- vapply(
    candidate_roots,
    function(path) {
      file.exists(file.path(
        path, "code", "Figure_B9", "cutoff_prefs_id_example_graph.R"
      ))
    },
    logical(1L)
  )

  if (!any(is_replication_root)) {
    stop(
      "Could not locate the replication root. Run this script with Rscript ",
      "or source it from the replication folder, its parent, code/, or ",
      "code/Figure_B9/."
    )
  }

  replication_root <- normalizePath(
    candidate_roots[which(is_replication_root)[[1L]]],
    mustWork = TRUE
  )
}

required_packages <- c("haven", "extRemes", "MASS")

# R ignores a user-library path that does not yet exist. Create it before
# checking packages so first-time installations do not require write access
# to the system R library.
user_library <- Sys.getenv("R_LIBS_USER")
if (nzchar(user_library) && !dir.exists(user_library)) {
  dir.create(user_library, recursive = TRUE)
}
if (nzchar(user_library) && dir.exists(user_library)) {
  .libPaths(c(user_library, .libPaths()))
}

for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg, repos = "https://cloud.r-project.org")
  }
}

library(haven)
library(extRemes)
library(MASS)

# setup for sim
set.seed(29)
nteach <- 750

# generate teacher contributions
mu_vec <- c(0,0)
vcov_mat <- matrix(c(1,0.3,0.3,1),2,2)
c_mat <- mvrnorm(nteach,mu_vec, vcov_mat)

df <- as.data.frame(c_mat)
names(df) <- c('c1','c2')

#  Generate district 1 prefs over teachers:
b1 <- 0.2
b2 <- 1.0
b3 <- 5


## Districts have no shock, just a cutoff, teachers have shock   -----------
df$d_d1prefs_1 <-  df$c1 + b1*df$c2 #deterministic version
df$d_d1prefs_2 <-  df$c1 + b2*df$c2 #deterministic version
df$d_d1prefs_3 <-  df$c1 + b3*df$c2 #deterministic version

# set a cutoff:
cutoff <- mean(df$d_d1prefs_2)

# Now teachers have a pref shock, but also like dist 1 more
df$tpref <- 1 + revd(nteach, 0, 1, 0) # rnorm(nteach, 0,0.7) doing type 1 ev now

# if teachers prefer a dist they go there if they are above cutoff:
df$d_dist1_1 <- (df$tpref > 0) & (df$d_d1prefs_1 > cutoff)
df$d_dist1_2 <- (df$tpref > 0) & (df$d_d1prefs_2 > cutoff)
df$d_dist1_3 <- (df$tpref > 0) & (df$d_d1prefs_3 > cutoff)


# PLOTS ARE DONE IN STATA, SEE Figure_B9.do, which is run by produce_exhibits.dta

# Save dataset for stata
write_dta(
  df,
  file.path(
    replication_root,
    "code",
    "Figure_B9",
    "cutoffs_id_exercise.dta"
  )
)

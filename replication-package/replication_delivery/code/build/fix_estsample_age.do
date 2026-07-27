* fix_estsample_age.do
* Created: 11/22
* Author: JStromme
*
* There were a couple of inconsistencies in the data on age. So we found the
*     mode in these cases and are plugging those in

clear all

* Fix inconsistent ages across the data
* We found the mode for them and are plugging those in

clear all

* Load original age file
import delimited "$est/age_estsample.csv", clear

* Fix specific ages (capture ensures no error if id doesn't exist)
capture replace age = 2014 - 1955 if id == 1429
capture replace age = 2014 - 1955 if id == 12981
capture replace age = 2014 - 1955 if id == 13641
capture replace age = 2014 - 1969 if id == 13975
capture replace age = 2014 - 1958 if id == 14630
capture replace age = 2014 - 1955 if id == 67829
capture replace age = 2014 - 1964 if id == 97131
capture replace age = 2014 - 1962 if id == 98078
capture replace age = 2014 - 1969 if id == 124200
capture replace age = 2014 - 1967 if id == 182741
capture replace age = 2014 - 1971 if id == 276666
capture replace age = 2014 - 1978 if id == 614546
capture replace age = 2014 - 1982 if id == 670048
capture replace age = 2014 - 1987 if id == 731449
capture replace age = 2014 - 1985 if id == 732616

* Save the new version
export delimited "$est/age_estsample_johnfortran.csv", replace

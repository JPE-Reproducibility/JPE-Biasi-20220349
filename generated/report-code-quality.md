## Code Quality

### Stata

[CRITICAL] `merge m:m` uses positional row-matching within key groups, not relational join semantics. Use `joinby` for a true many-to-many join, or identify the correct unique key and use `1:m`/`m:1`. (staff_build.do, line 368)
  → merge m:m last first gender birth year district_code using "$intdata/roster_JPE.dta"

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 105)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 113)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 122)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 157)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 167)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 191)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 213)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 231)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 270)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 280)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 306)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 316)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 329)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 339)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 349)
  → keep if `wage_aux_sample'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_model_teachers_wages.do, line 391)
  → keep if `wage_aux_sample'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_other_moments.do, line 53)
  → keep if Match == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_other_moments.do, line 178)
  → keep if newhire > 0

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (aux_other_moments.do, line 185)
  → keep if newhire == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 99)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 109)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 125)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 135)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 150)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 160)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 175)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 185)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 247)
  → keep if Match == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 295)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 305)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 323)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 333)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 348)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 358)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 373)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 383)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 440)
  → keep if Match == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 471)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 481)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 498)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 508)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 523)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 533)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 548)
  → drop if A == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_districts.do, line 558)
  → drop if B == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers.do, line 12)
  → keep if Match == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_info.do, line 32)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_info.do, line 67)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_info.do, line 102)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_info.do, line 137)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_info.do, line 172)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_nobottom.do, line 27)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_nobottom.do, line 61)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_nobottom.do, line 147)
  → drop if C0 < `b0' | C1 < `b1'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_nobottom.do, line 171)
  → keep if Match == 0

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_nobottom.do, line 173)
  → keep if C0 >= seed_C0 + 0.00000000000000001 & ///

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_nobottom.do, line 194)
  → keep if Match == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_nobottom.do, line 209)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_nobottom.do, line 243)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_richprefs.do, line 27)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_richprefs.do, line 86)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_richprefs.do, line 120)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxmodels_teachers_varobust.do, line 28)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxmodels_teachers_varobust.do, line 47)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxmodels_teachers_varobust.do, line 103)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxmodels_teachers_varobust.do, line 111)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxmodels_teachers_varobust.do, line 120)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxmodels_teachers_varobust.do, line 180)
  → drop if C0 < `b0' | C1 < `b1'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxmodels_teachers_varobust.do, line 225)
  → keep if TTAG == 1 & (TAG == 1 | Match == 1)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxmodels_teachers_varobust.do, line 257)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxmodels_teachers_varobust.do, line 279)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxmodels_teachers_varobust.do, line 293)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (_synthetic_model_helpers.do, line 15)
  → drop if district_code == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (_synthetic_model_helpers.do, line 21)
  → drop if district_code == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (_synthetic_model_helpers.do, line 24)
  → keep if _merge == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (_synthetic_model_helpers.do, line 30)
  → drop if district_code == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (_synthetic_model_helpers.do, line 33)
  → keep if _merge == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (_synthetic_model_helpers.do, line 50)
  → keep if _merge == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (_synthetic_model_helpers.do, line 53)
  → keep if _merge == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (_synthetic_model_helpers.do, line 79)
  → keep if year == `model_year'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (_synthetic_model_helpers.do, line 86)
  → keep if _synthetic_rank <= `target'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (_synthetic_model_helpers.do, line 101)
  → drop if year == `model_year'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (_synthetic_model_helpers.do, line 172)
  → keep if _merge == 2 | _merge == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_info_matches.do, line 122)
  → keep if _synthetic_id_rank <= `synthetic_mover_id_cap'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (auxiliary_models_teachers_info_matches.do, line 168)
  → keep if TTAG == 1 & (TAG == 1 | Match == 1)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (budget_overtime.do, line 11)
  → keep if v0 != . & v1 != . & totalexp != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 51)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 53)
  → keep if year == 2011 | year == 2010 | year == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 62)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 129)
  → keep if _model_relaxed == 1 & year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 132)
  → keep if _model_rank <= `model_target_obs'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 139)
  → keep if _merge == 3 & _model_relaxed == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 145)
  → keep if _model_complete == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 183)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 207)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 235)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 291)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 299)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 305)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 362)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 387)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 396)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 527)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 537)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 586)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 588)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 595)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 608)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 610)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 617)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 630)
  → keep if district_code != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 643)
  → keep if district_code != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 666)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 668)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 677)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset.do, line 789)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 20)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 29)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 49)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 97)
  → keep if _model_relaxed == 1 & year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 100)
  → keep if _model_rank <= `model_target_obs'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 107)
  → keep if _merge == 3 & _model_relaxed == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 113)
  → keep if _model_complete == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 159)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 188)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 204)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 212)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 218)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 273)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 296)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 304)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 399)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 409)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 454)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 456)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 463)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 474)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 476)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 483)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 494)
  → keep if district_code != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 505)
  → keep if district_code != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 527)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 529)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info0.do, line 538)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 20)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 29)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 49)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 98)
  → keep if _model_relaxed == 1 & year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 101)
  → keep if _model_rank <= `model_target_obs'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 108)
  → keep if _merge == 3 & _model_relaxed == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 114)
  → keep if _model_complete == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 160)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 189)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 205)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 213)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 219)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 274)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 297)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 305)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 400)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 410)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 455)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 457)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 464)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 475)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 477)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 484)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 495)
  → keep if district_code != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 506)
  → keep if district_code != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 528)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 530)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info1.do, line 539)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 20)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 29)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 49)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 98)
  → keep if _model_relaxed == 1 & year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 101)
  → keep if _model_rank <= `model_target_obs'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 108)
  → keep if _merge == 3 & _model_relaxed == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 114)
  → keep if _model_complete == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 160)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 189)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 205)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 213)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 219)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 274)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 297)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 305)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 400)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 410)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 455)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 457)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 464)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 475)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 477)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 484)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 495)
  → keep if district_code != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 506)
  → keep if district_code != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 528)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 530)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info2.do, line 539)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 21)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 30)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 50)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 99)
  → keep if _model_relaxed == 1 & year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 102)
  → keep if _model_rank <= `model_target_obs'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 109)
  → keep if _merge == 3 & _model_relaxed == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 115)
  → keep if _model_complete == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 161)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 190)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 206)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 214)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 220)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 275)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 298)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 306)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 401)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 411)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 456)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 458)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 465)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 476)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 478)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 485)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 496)
  → keep if district_code != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 507)
  → keep if district_code != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 529)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 531)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_info3.do, line 540)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 19)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 21)
  → keep if year == 2011 | year == 2010 | year == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 28)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 35)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 37)
  → keep if year == 2009 | year == 2008 | year == 2007

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 44)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 92)
  → keep if e(sample)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 140)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 163)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 172)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 228)
  → keep if year == 2010

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 253)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 366)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 376)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 425)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 427)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 434)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 456)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 458)
  → keep if year == 2009 | std_score == 2008 | std_score == 2007

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 462)
  → keep if _m == 2 | _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 475)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 477)
  → keep if year == 2010

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 484)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 497)
  → keep if district_code != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_model_dataset_pre2011.do, line 510)
  → keep if district_code != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (build_teachers_offer_set.do, line 69)
  → keep if TTAG == 1 & (TAG == 1 | Match == 1)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas.do, line 21)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas.do, line 51)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas.do, line 53)
  → keep if year == 2011 | year == 2010 | year == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas.do, line 60)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas.do, line 90)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_info.do, line 24)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_info.do, line 54)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_info.do, line 56)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_info.do, line 65)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_info.do, line 121)
  → drop if c0 == . | c1 == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 35)
  → keep if leaid > 5500000 & leaid < 5600000

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 42)
  → drop if censusid == 5599999

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 45)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 55)
  → keep if leaid > 5500000 & leaid < 5600000

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 60)
  → drop if censusid == 5599999

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 63)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 73)
  → keep if leaid > 5500000 & leaid < 5600000

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 79)
  → drop if censusid == 5599999

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 82)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 92)
  → keep if leaid > 5500000 & leaid < 5600000

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 104)
  → drop if censusid == 5599999

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 107)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 169)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 171)
  → drop if Inc == 1 & exp >2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 199)
  → keep if Match == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 232)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 235)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 270)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 280)
  → keep if otherincz == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 363)
  → drop if _m == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (omega_databuild.do, line 377)
  → drop if budget == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (staff_build.do, line 59)
  → drop if id == . | salary == 0 | salary == . | ///

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (staff_build.do, line 108)
  → drop if id == . | salary == 0 | salary == . | ///

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (staff_build.do, line 160)
  → drop if id == . | salary == 0 | salary == . | ///

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (staff_build.do, line 359)
  → keep if filenum != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (staff_build.do, line 364)
  → drop if filenum != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (staff_build.do, line 372)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (teachers_build.do, line 41)
  → drop if fte == 0 | fte == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (teachers_panel.do, line 21)
  → drop if fte < 100

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (teachers_panel.do, line 116)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (teachers_panel.do, line 117)
  → keep if (highgrade == "01" | highgrade == "02" | highgrade == "03" | ///

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (teachers_panel.do, line 127)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (teachers_panel.do, line 156)
  → drop if cesa == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (teachers_with_allva.do, line 58)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (testscores_build.do, line 126)
  → drop if Sblack == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (testscores_build.do, line 128)
  → keep if test_subject == "Mathematics"

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (testscores_build.do, line 234)
  → drop if Sblack == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (testscores_build.do, line 237)
  → keep if test_subject == "Mathematics"

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (testscores_build.do, line 265)
  → keep if std_score_past != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (testscores_build.do, line 266)
  → drop if grade < 4 | year < 2006 | year > 2016

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (va_teacherside_build.do, line 9)
  → drop if schoolcode == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (va_teacherside_build.do, line 10)
  → keep if mathematics == 1 | all_elem == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (va_teacherside_build.do, line 12)
  → drop if district_code == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (va_teacherside_build.do, line 24)
  → drop if ok == 1 & (lowgrade < 3 | lowgrade > 8)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (va_teacherside_build.do, line 25)
  → drop if highgrade < 3 | lowgrade > 8

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (va_teacherside_build.do, line 42)
  → drop if tag == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (va_teacherside_build.do, line 43)
  → drop if grade < 3 | grade > 8

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation.do, line 33)
  → keep if std_score_past != . & year < 2017

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation.do, line 34)
  → drop if grade < 3 | grade > 8

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation.do, line 36)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation.do, line 63)
  → keep if id`x' != . & id`z' == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation.do, line 75)
  → keep if id26 != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation.do, line 93)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation.do, line 111)
  → keep if grade <= 6

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_classmodel.do, line 56)
  → keep if std_score_past != . & year < 2017

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_classmodel.do, line 57)
  → drop if grade < 3 | grade > 8

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_classmodel.do, line 60)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_classmodel.do, line 63)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_classmodel.do, line 95)
  → keep if id`x' != . & id`z' == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_classmodel.do, line 108)
  → keep if id26 != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_classmodel.do, line 130)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_classmodel.do, line 148)
  → keep if grade <= 6

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_stockstaiger_nocomparativeadv.do, line 33)
  → keep if std_score_past != . & year < 2017

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_stockstaiger_nocomparativeadv.do, line 34)
  → drop if grade < 3 | grade > 8

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_stockstaiger_nocomparativeadv.do, line 36)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_stockstaiger_nocomparativeadv.do, line 63)
  → keep if id`x' != . & id`z' == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_stockstaiger_nocomparativeadv.do, line 75)
  → keep if id26 != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_stockstaiger_nocomparativeadv.do, line 93)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (valueadded_calculation_stockstaiger_nocomparativeadv.do, line 113)
  → keep if grade <= 6

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_6.do, line 135)
  → keep if economy_id == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_6.do, line 145)
  → keep if economy_id

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_6.do, line 185)
  → keep if quartlam_4 == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_6.do, line 189)
  → keep if quartlam_3 == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_6.do, line 193)
  → keep if quartlam_2 == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_6.do, line 197)
  → keep if quartlam_1 == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_7.do, line 111)
  → keep if economy_id == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_7.do, line 120)
  → keep if economy_id != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_7.do, line 162)
  → keep if quartlam == `q'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_8.do, line 88)
  → keep if economy_id == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_8.do, line 97)
  → keep if economy_id != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_B18.do, line 113)
  → keep if economy_id == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_B18.do, line 122)
  → keep if economy_id != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_B18.do, line 156)
  → keep if quartlam == `q'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_B19.do, line 109)
  → keep if economy_id == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_B19.do, line 118)
  → keep if economy_id != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_B19.do, line 160)
  → keep if quartlam == `q'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_B20.do, line 109)
  → keep if economy_id == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_B20.do, line 118)
  → keep if economy_id != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (Table_B20.do, line 160)
  → keep if quartlam == `q'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (achievement_race.do, line 35)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (achievement_race.do, line 38)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (achievement_race.do, line 54)
  → keep if std_score_past != . & year < 2017

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (achievement_race.do, line 55)
  → drop if grade < 3 | grade > 8

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (achievement_race.do, line 58)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (achievement_race.do, line 87)
  → keep if id`x' != . & id`z' == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (achievement_race.do, line 99)
  → keep if id26 != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (achievement_race.do, line 116)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (achievement_race.do, line 130)
  → keep if grade <= 6

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (appendix_figures.do, line 16)
  → drop if year == 2010 & district_code == 2793

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (appendix_figures.do, line 21)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (appendix_figures.do, line 23)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (appendix_figures.do, line 31)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (appendix_figures.do, line 67)
  → keep if e(sample)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (appendix_figures.do, line 93)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (appendix_figures.do, line 116)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (appendix_figures.do, line 122)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (budget_shifts.do, line 18)
  → keep if fte_tot >= 100

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (c1c2_variation_studentlevel.do, line 49)
  → drop if v == . | id == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (c1c2_variation_studentlevel.do, line 59)
  → drop if _merge == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (c1c2_variation_studentlevel.do, line 65)
  → drop if c0 == . | c1 == . | id == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (c1c2_variation_studentlevel.do, line 76)
  → drop if _merge == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (c1c2_variation_studentlevel.do, line 91)
  → keep if std_score_past != . & year < 2017

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (c1c2_variation_studentlevel.do, line 92)
  → drop if grade < 3 | grade > 8

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (c1c2_variation_studentlevel.do, line 97)
  → keep if _merge == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (c1c2_variation_studentlevel.do, line 122)
  → keep if grade <= 6

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (c1c2_variation_studentlevel.do, line 204)
  → keep if lambda == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (c1c2_variation_studentlevel.do, line 216)
  → keep if lambda == 0

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 20)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 27)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 30)
  → keep if year == 2010

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 38)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 53)
  → drop if year == 2010 & district_code == 2793

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 56)
  → keep if fte_tot == 100

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 60)
  → keep if year >= 2009 & year <= 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 83)
  → keep if year >= 2009 & year <= 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 174)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 181)
  → keep if fte_tot == 100

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 183)
  → keep if year >= 2009 & year <= 2016

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 186)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 219)
  → drop if year > 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (data_patterns.do, line 220)
  → drop if yeart > 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_3omegas.do, line 22)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_3omegas.do, line 57)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_3omegas.do, line 59)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_3omegas.do, line 67)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_3omegas.do, line 103)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_exp1cutoff.do, line 22)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_exp1cutoff.do, line 57)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_exp1cutoff.do, line 59)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_exp1cutoff.do, line 67)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_exp1cutoff.do, line 103)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_tenured.do, line 21)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_tenured.do, line 56)
  → drop if schoolcode == 8888

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_tenured.do, line 58)
  → keep if year == 2011 | std_score == 2010 | std_score == 2009

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_tenured.do, line 66)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (gen_omegas_tenured.do, line 102)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (lambda_map.do, line 16)
  → drop if district_code >= 8000

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (lambda_map.do, line 19)
  → keep if year == 2010

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 20)
  → keep if std_score_past != . & year < 2017

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 21)
  → drop if grade < 3 | grade > 8

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 47)
  → keep if grade <= 6

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 103)
  → keep if std_score_past != . & year < 2017

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 104)
  → drop if grade < 3 | grade > 8

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 107)
  → keep if _m == 3

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 113)
  → drop if grade < 3 | grade > 6

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 115)
  → keep if year == 2014

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 152)
  → keep if id`x' != . & id`z' == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 164)
  → keep if id26 != .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 187)
  → keep if grade <= 6

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 191)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 196)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (rothstein_test.do, line 199)
  → keep if grade <= 6

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (summary.do, line 253)
  → keep if _m != 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (summary.do, line 255)
  → drop if district == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (summary.do, line 277)
  → drop if _m == 2

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (summary.do, line 321)
  → drop if district == .

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (summary.do, line 344)
  → keep if Match == 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (summary_simulation.do, line 88)
  → keep if _merge != 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (summary_simulation.do, line 102)
  → keep if _merge != 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (summary_simulation.do, line 129)
  → keep if _merge != 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (summary_simulation.do, line 153)
  → keep if _merge != 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (summary_simulation.do, line 178)
  → keep if _merge != 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (summary_simulation.do, line 199)
  → keep if _merge != 1

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (02_make_synthetic_data.do, line 282)
  → keep if year == `yr'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (02_make_synthetic_data.do, line 314)
  → keep if year == `yr'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (02_make_synthetic_data.do, line 351)
  → keep if year == `yr'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (03_validate_synthetic_structure.do, line 282)
  → keep if first_idyear

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (03_validate_synthetic_structure.do, line 292)
  → drop if inrange(support_seq, 101, 126) | inrange(support_seq, 260, 289)

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (03_validate_synthetic_structure.do, line 298)
  → keep if year == `=`yr' - 1'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (03_validate_synthetic_structure.do, line 304)
  → keep if year == `yr'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (03_validate_synthetic_structure.do, line 351)
  → keep if year == `=`yr' - 1'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (03_validate_synthetic_structure.do, line 357)
  → keep if year == `yr'

[ADVISORY] Sample drop (`drop if` / `keep if`) not preceded by a comment within 2 lines — consider adding a comment explaining the criterion. (03_validate_synthetic_structure.do, line 558)
  → keep if _m == 3


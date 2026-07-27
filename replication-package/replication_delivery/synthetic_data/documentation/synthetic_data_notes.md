# Synthetic Data Notes

These files are generated from scratch by `code/02_make_synthetic_data.do`. They are not sampled from or perturbations of confidential records.

## Staff Files

- Unit: individual working in a district-school-position-year.
- Fake staff IDs repeat across consecutive years for about 96 percent of staff IDs by construction.
- About 90 percent of staff person-years have one district-school-position record; about 90 percent of those one-record person-years have position 53.
- Position, assignment-area, district, and school codes are synthetic code-support values held internally consistent across years.
- Total and local experience generally increase mechanically within staff histories after accounting for the pre-2015 raw scaling used by the build scripts; designated low-experience VA-support rows are held in low bins so model-data experience cells stay populated.
- The first row of each staff CSV is a synthetic import sentinel that is dropped by the legacy staff build because it has zero salary; it exists only to make Stata infer string types for fields that are string in earlier fixed-width years.
- A few synthetic file-number sentinels are included solely so hard-coded legacy manual-fix branches in the public build scripts have nonempty conditions; these are not confidential records.
- Synthetic school-grade-year clusters cover exactly 1 through 26 eligible teachers so downstream VA scripts that expect all teacher-count buckets and `id1` through `id26`, but no wider teacher columns, can run.
- Those VA-supporting clusters are spread across 26 synthetic districts and deliberately include both low- and high-prior-score students so district-level model files can form 20 quantiles.
- A few VA-cluster teachers are synthetic entrants with low, middle, and high experience so the model-data scripts see all six expected experience-bin dummies.
- A small subset of those VA-cluster teachers enter in 2011 and move districts by 2014 so imperfect-information auxiliary regressions have nonempty low-experience mover cells.
- Synthetic active districts are chosen from public district codes with at least one other active district in their commuting zone so leave-one-out CZ summaries are defined.
- A small cohort of synthetic non-VA teachers changes districts across years so mover/non-mover descriptive figures have nonempty cells, including 2011.
- VA-supporting student cells span grades 3 through 6 within school-years, with low- and high-prior-score variants in each grade, so Rothstein-style school-by-year fixed-effect checks retain non-singleton cells.
- One synthetic support CSV is written to `raw/teacher_data_linked/` because `oldteacher_roster_build.do` requires it before `staff_build.do` can run.

## Test-Score and Demographic Files

- Unit: student-year in `student_demographics.csv` and `dem.dta`; student-subject-year in `testscores.csv`.
- Fake student IDs repeat across years for about 97 percent of students in consecutive school years.
- Demographic and test-score rows fully match on synthetic student ID and school year.
- Grade, subject, school, and district cells are populated so the standardization and merge code has nonempty cells.

## Main Assumptions

- The raw 2008-2010 staff files are written with lowercase filenames to match the existing build script's `08staff.txt`, `09staff.txt`, and `10staff.txt` references.
- Generic race, gender, subject, and proficiency labels are included only where the existing build code explicitly branches on those public categories.
- Synthetic estimates are not intended to reproduce the paper's confidential-data estimates.

---
editor_options: 
  markdown: 
    wrap: 72
---

# Data and Code for: Equilibrium in the Market for Public School Teachers: District Wage Strategies and Teacher Comparative Advantage

Barbara Biasi, Chao Fu, and John Stromme

This README documents the replication package for the Journal of
Political Economy paper "Equilibrium in the Market for Public School
Teachers: District Wage Strategies and Teacher Comparative Advantage."

## Overview

The code in this replication package constructs teacher-, student-,
district-, model-estimation, and simulation datasets and generates the
tables and figures listed below and displayed in the paper and Online Appendix. 

The original analysis relies on
confidential Wisconsin Department of Public Instruction (WDPI) data and
cannot be redistributed in this public archive. The public replication package hence includes fixed synthetic input data in
`synthetic_data/raw/`.
These files are fictitious data created to match the file names, folder
structure, variable names, storage formats, and key relationships needed
by the replication code. They are not sampled from, perturbed from, or
otherwise derived from confidential WDPI records. Results produced from
these synthetic data verify the code path and file dependencies but
 do not reproduce the published numerical estimates.

Public replicators should run
`code/master_synth.do`.
It reads the synthetic raw inputs from
`synthetic_data/` and the public proficiency input from `data/public/`,
constructs intermediate/model/simulation files locally, and writes
synthetic-run exhibits to
`out_synth/`.
The confidential-data driver is
`code/master.do`;
it is not needed for the public synthetic-data replication. In this
package,
`out_synth/`
is the output-simulated folder: it contains the expected tables and
figures from the public simulated-data run.
`out/` is
reserved for actual restricted-data outputs from
`code/master.do`
and will not be generated in the public replication.

## Data Availability and Provenance Statements

### Statement About Rights

The confidential WDPI staff, roster, demographic, and test-score data used in
the paper cover 2006--2016. The authors first obtained access in November 2017
under a Data User Agreement with WDPI. WDPI did not provide a formal version
number, extract identifier, or release number for the delivery. These
restricted data are not distributed with this replication package.

Researchers who want access to the confidential data can submit a request to
WDPI at:

<https://dpi.wi.gov/wise/data-requests/confidential-data-application>

There is no application or access fee. Access requires IRB approval and a
signed Data User Agreement, is subject to WDPI review and approval, and may
take several months. The Data User Agreement requires the confidential data to
be destroyed after the project is completed. Redistribution of confidential
WDPI microdata is not permitted.

In June 2026, the JPE Data Editor approved the use of synthetic data for the
public replication in place of the confidential WDPI files.

`real_data/`
contains shareable auxiliary inputs that are either constructed by the
authors or publicly available. These files are included in the public
replication archive subject to the applicable source terms and agreements.
`data/public/`
contains an unmodified public ED Data Express district-level mathematics
assessment file, its provider README, and its provider data notes. These files
support the calculation of the district proficiency ranges discussed in the
paper.
`synthetic_data/raw/`
contains the fictitious WDPI-style inputs distributed for the public
replication.

### Summary of Availability

| Data source                                                                                 | Location expected by code                                                                                                                                                                                                                   | Publicly provided? | Notes                                                                                                                                                                                                                                                                                                                                                                                                |
|-----------------|-----------------|----------------:|-----------------------|
| WDPI staff, roster, and student test-score files                                            | File names listed below                                                                                                                                                                                                                     |                 No | Confidential/restricted data covering 2006--2016. First accessed in November 2017; no formal version or release number was provided. Access is free but requires IRB approval, a signed DUA, and WDPI approval, which may take several months.                                                                                                                                                         |
| Auxiliary district crosswalks, distance files, shapefiles, elections, and NCES/ACS extracts | `real_data/`                                                                                                                                                                    |                Yes | Shareable files constructed by the authors or publicly available.                                                                                                                                                                                                                                                                                                                                    |
| District mathematics proficiency data                                                       | `data/public/proficiency_data/SY2021_FS175_DG583_LEA_data_files/`                                                                                                                |                Yes | Unmodified public 2020--2021 LEA-level mathematics assessment data from the U.S. Department of Education's ED Data Express Data Library (File Specification 175, Data Group 583), plus the provider README and data notes. Used by `code/descriptives/intext_numbers.do`.                                                                                                                               |
| Synthetic public replication data                                                           | `synthetic_data/raw/`                                                                                                                                                           |                Yes | Fixed fictitious WDPI-style raw files distributed with the public package. Together with the included auxiliary inputs in `real_data/` and public proficiency input in `data/public/`, these are sufficient to run `code/master_synth.do`. The simulation script is also included at `synthetic_data/code/make_simulated_data.do` so public replicators can inspect or regenerate the fictitious inputs if needed. |
| Generated intermediate/model/simulation data                                                | `intermediate_data/`, `model_data/`, `simulation_data/` |                 No | Created locally when `code/master_synth.do` runs. They should not be treated as source data.                                                                                                                                                                                                                                             |
| Expected simulated-run outputs                                                              | `out_synth/`                                                                                                                                                                    |                Yes | Tables and figures generated from the simulated inputs. This is the package's output-simulated folder.                                                                                                                                                                                                                                                                                               |
| Actual restricted-data outputs                                                              | `out/`                                                                                                                                                                          |                 No | Reserved for outputs from the confidential-data workflow. Public replicators will not generate this folder from the public simulated data.                                                                                                                                                                                                                                                              |

### Preservation and Licensing

The final public replication package will be preserved in the JPE/Harvard
Dataverse. The authors' local copies of the confidential WDPI data will be
destroyed when required by the governing Data User Agreement. The underlying
administrative records remain in the custody of WDPI, which will continue to
accept applications from qualified researchers for restricted access for at
least five years following publication. During that period, the authors will
preserve the replication code, synthetic data, codebook, provenance
documentation, and access instructions. The authors will also provide
reasonable assistance in response to requests for clarification and
replication, including assistance to approved researchers seeking to obtain a
substantially similar extract and run the analysis code.

The authors' code in
`code/`
and
`synthetic_data/code/`
is released under the MIT License. The authors' original synthetic data and
documentation are released under the Creative Commons Attribution 4.0
International License (CC BY 4.0). Third-party auxiliary inputs are not
relicensed, including files under `real_data/` and `data/public/`, and remain
subject to their original source terms. See
`LICENSE`
for details.

## Raw Datasets Used in the Analysis

The following list contains all the raw files used in the analysis. WDPI staff, roster, and student
files are confidential and not provided. Files under
`real_data/`
are shareable auxiliary inputs constructed by the authors or publicly
available. Files under
`data/public/`
are unmodified public source files distributed with their provider
documentation.

| Raw input | Source/provenance from local evidence |
|------------------------|------------------|
| `Linked_Staffing_Data_10202015.csv` | Confidential WDPI linked staffing data. |
| `06staff.txt` through `14staff.txt` | Confidential WDPI staff files. |
| `15staff.csv`, `16staff.csv` | Confidential WDPI staff files. |
| `student_demographics.csv` | Confidential WDPI student demographics. |
| `testscores.csv` | Confidential WDPI student test scores. |
| `data/public/proficiency_data/SY2021_FS175_DG583_LEA_data_files/SY2021_FS175_DG583_LEA.csv` | U.S. Department of Education, ED Data Express, 2020--2021 *Performance on Statewide Mathematics Assessment*, LEA level, File Specification 175, Data Group 583, as of May 25, 2022. The file is an unmodified provider download with 1,394,390 data records. |
| `data/public/proficiency_data/SY2021_FS175_DG583_LEA_data_files/SY2021_FS175_DG583_LEA_README.txt` | Provider README supplied with the ED Data Express download. |
| `data/public/proficiency_data/SY2021_FS175_DG583_LEA_data_files/SY2021_FS175_DG583_LEA_data_notes.csv` | Provider data notes supplied with the ED Data Express download, including the provider's caution about 2020--2021 assessment participation during the COVID-19 pandemic. |
| `real_data/cesa.dta` | CESA-district crosswalk manually created by authors using [WDPI CESA information](https://dpi.wi.gov/about-dpi/cesa). |
| `real_data/wisconsin_elections.xlsx` | Daily Kos Elections statewide election results and county-congressional-district crosswalk, accessed in 2022; see `real_data/readme_elections.rtf` and the formal citations below. |
| `real_data/crosswalk_district_county.dta` | District-county crosswalk prepared by authors using the Opportunity Insights county-commuting-zone-state crosswalk documented below. |
| `real_data/crosswalk_census_state_id.csv` | Census district ID to state district ID crosswalk prepared by authors using [NCES EDGE School District Boundaries](https://nces.ed.gov/programs/edge/Geographic/DistrictBoundaries). The exact source vintage was not recorded. |
| `real_data/district_county_cz.dta` | District-county-commuting-zone crosswalk prepared by authors using the Opportunity Insights county-commuting-zone-state crosswalk documented below. |
| `real_data/district_distance_sdid.dta` | District-to-district distance matrix constructed by authors using Google Maps in September 2022. |
| `real_data/nces_acs_2013-2017/EDGE_Export_101244429626/DP03.6_001_USSchoolDistrictAll_101244423682.txt` | NCES/ACS 2013--2017 school-district income extract. The original download date was not recorded. |
| `real_data/nces_acs_2013-2017/EDGE_Export_101244639981/DP03.8_001_USSchoolDistrictAll_101244637329.txt` | NCES/ACS 2013--2017 school-district poverty extract. The original download date was not recorded. |
| `real_data/nces_acs_2013-2017/EDGE_Export_1012447445/DP02.7_001_USSchoolDistrictAll_101244740697.txt` | NCES/ACS 2013--2017 school-district education extract. The original download date was not recorded. |
| `real_data/nces_acs_2013-2017/EDGE_Export_101253245819/DP05.1_001_USSchoolDistrictAll_101253240998.txt` | NCES/ACS 2013--2017 school-district age extract. The original download date was not recorded. |
| `real_data/district_shapefiles/WI_School_Districts.*` | WDPI *School Districts, Wisconsin*, edition 8.0, revised June 26, 2024 and valid for the 2024--2025 school year, plus converted Stata files. Downloaded in 2025 from the [WDPI GIS Maps](https://dpi.wi.gov/wisedash/public/gis-maps) page. |
| `real_data/cz_id.csv` | District-commuting-zone crosswalk prepared by authors using the Opportunity Insights county-commuting-zone-state crosswalk documented below. |
| `real_data/district_id_tag.dta` and `real_data/district_id_tag_validation.dta` | Data-district-id to model-district-id crosswalks prepared by authors. |

### Public District Proficiency Data Codebook

The ED Data Express file is an LEA-level extract of 2020--2021 statewide
mathematics assessment performance. A row identifies a reported result for an
LEA, student population or subgroup, and grade. The in-text-number script uses
the rows for `All Students in LEA`, `Grade 5`, and the states California,
Texas, and Wisconsin. The provider reports some percentages exactly and
others as disclosure ranges or one-sided bounds. The script therefore parses
the reported `Value` strings rather than treating every row as an exact point
estimate. For every qualifying numeric report, it extracts the first numeric
endpoint and, for an interval, the second numeric endpoint; an exact or
one-sided report uses its stated numeric value as both endpoints. It then
takes the smallest lower and largest upper endpoint by state. The resulting
ranges are 5--94% in Wisconsin, 5--89% in California, and 6--90% in Texas.

| Raw variable | Description |
|--------------|-------------|
| `School Year` | School year covered by the record; this extract reports 2020--2021. |
| `State` | State name. |
| `NCES LEA ID` | Seven-digit NCES local education agency identifier. |
| `LEA` | Local education agency name. |
| `School` | School name when applicable; blank in this LEA-level extract. |
| `NCES SCH ID` | NCES school identifier when applicable; blank in this LEA-level extract. |
| `Data Group` | EDFacts data-group identifier; `583` denotes the assessment-performance group used here. |
| `Data Description` | Provider description of the reported measure. |
| `Value` | Reported percentage or provider code. Numeric percentages can be exact (for example, `42%`), interval-censored (for example, `40-44%`), or one-sided (for example, `<=10%` or `>=90%`); suppression and missing-value codes can also occur. |
| `Numerator` | Numerator when released by the provider; not populated for the proficiency-percentage records used here. |
| `Denominator` | Number of students underlying the reported percentage. |
| `Population` | Population represented by the record; `All Students` for the rows used here. |
| `Subgroup` | Reporting subgroup; the calculation keeps `All Students in LEA`. |
| `Characteristics` | Additional subgroup characteristic when applicable. |
| `Age/Grade` | Student age or grade; the calculation keeps `Grade 5`. |
| `Academic Subject` | Assessed subject; `Mathematics` in this extract. |
| `Outcome` | Reported outcome; `Percent Proficient` in this extract. |
| `Program Type` | Program classification when applicable. |

The provider notes that 2020--2021 assessment participation varied because of
the COVID-19 pandemic; results may not be representative and should not be
assumed comparable with other years. See
`SY2021_FS175_DG583_LEA_data_notes.csv`
for the full provider note.

### Restricted WDPI Data Codebook

The confidential WDPI inputs are not distributed, but the following codebook
documents the variables obtained from WDPI and expected by the build code. It
is intended to let an approved researcher determine whether a newly obtained
extract is substantially similar. Variable names shown in parentheses are the
canonical lower-case names used by the Stata build after import. Blank fields,
provider missing-value codes, and `NA` should be treated as missing unless a
more specific rule is stated below.

#### Annual staff files

The unit of observation in `06staff.txt` through `14staff.txt` and
`15staff.csv` through `16staff.csv` is a staff member--district--school--
position--assignment--year record. A staff member can therefore have multiple
records in a year. The legacy files are fixed-width; their column positions
are specified in `code/build/staff_build.do`. The 2015--2016 files use the raw
CSV headers shown below. The file year supplies the analysis year.

| Raw/canonical variable | Description and coding expected by the build |
|------------------------|------------------------------------------------|
| `IDNbr` (`id`) | Provider staff identifier. Numeric in the annual files; used with names and demographics to construct longitudinal links. |
| `LastName`, `FirstName` (`lastname`, `firstname`) | Staff surname and given name used only for record linkage and name reconciliation. String; confidential direct identifiers. |
| `FileNumber` (`filenumber`) | Longitudinal staff file number, available in the later files and recovered from the linked-staffing file when necessary. String or numeric identifier; leading zeros may occur. |
| `Gndr` (`gender`) | Provider gender code. The analysis recognizes `F` and `M`; blank or `NA` is missing. |
| `RaceEthn` (`race`) | Provider race/ethnicity code. The analysis uses `B` for Black, `H` for Hispanic, and `A` for Asian; other valid provider codes are retained until the analysis-specific indicators are created. |
| `BirthYear` (`birth`) | Four-digit year of birth used for linkage and experience-consistency checks. |
| `HighDegree` (`highedu`) | Highest-degree code. Codes used by the analysis are `4` bachelor's, `5` master's, `6` specialist, and `7` doctorate. |
| `YearSession` | Calendar/session year in the CSV files. The build assigns `year` from the annual filename so that all annual formats are handled consistently. |
| `CntrctDays` (`dayscontract`) | Number of contract days for the staff assignment. Records with zero or missing contract days are excluded. |
| `LocalExp` (`localexp`) | Provider-reported years of experience in the local agency. Numeric, with missing values allowed. |
| `TotalExp` (`totalexp`) | Provider-reported total years of experience. Numeric, with missing values allowed. |
| `TotSalary` (`salary`) | Total annual salary associated with the record, in nominal dollars as supplied. Zero and missing values are excluded. |
| `TotFringe` (`fringe`) | Total fringe benefits associated with the record, in nominal dollars as supplied. |
| `StaffCat` (`staffcat`) | Provider staff-category code. |
| `HireAgncyCd`, `WorkAgncyCd` (`hireagencycode`, `workagencycode`) | Official codes for the hiring and work agencies. The work-agency code becomes the analysis district identifier. |
| `HireAgncyTyp`, `WorkAgncyTyp` (`hireagencytype`, `workagencytype`) | Provider hiring- and work-agency-type codes. The teacher build retains district- and school-employee types `3` and `4`. |
| `SchoolCd` (`schoolcode`) | Official school code within the work agency. Numeric after import; missing school codes are excluded from the teacher panel. |
| `PositionCd` (`position`) | Provider position code. Codes used to define the teacher sample are `53` for teacher and `43` for short-term substitute teacher. |
| `AssgnAreaCd` (`area`) | Provider assignment-area/subject code. The build uses these codes to create mathematics, English, reading, art, science, Title I, elementary, and cross-categorical assignment indicators. |
| `LowGrd`, `HighGrd` (`lowgrade`, `highgrade`) | Lowest and highest grade served, stored as provider text codes. |
| `LGSortCd`, `HGSortCd` (`lowgradecode`, `highgradecode`) | Numeric sort codes corresponding to the lowest and highest grades served. |
| `Bilingual` (`bilingual`) | Provider bilingual-assignment indicator, normally `Y`/`N` or blank. |
| `AssgnFTE` (`fte`) | Assignment full-time-equivalent percentage; `100` represents one full-time assignment. Zero and missing FTE records are excluded. |
| `WorkLocationName` (`workagencyname`) | Name of the work agency or district. String. |
| `SchoolName` (`schoolname`) | School name. String. |
| `GrdLevel` (`gradelevel`) | Provider school/assignment grade-level code. |
| `CESANumber` (`cesa`) | Cooperative Educational Service Agency code. String or numeric provider code. |
| `CntyNbr` (`county`) | Provider county code. |
| `CntyName` | Provider county name. Present in the CSV files but not retained by the analysis build. |
| `SchoolMailingAddress1`, `SchoolMailingAddress2`, `SchoolShippingAddress1`, `SchoolShippingAddress2`, `MailCity`, `MailSt`, `ShipCity`, `ShipSt`, `ShipZipCd` | Work-location mailing and shipping address components. Present in the CSV files but not retained by the analysis build. |
| `MailZipCd` (`zipcode`) | Work-location mailing ZIP code. String so leading zeros are preserved. |
| `Phone`, `AdminName`, `FormerLastNm` | Work-location phone, administrator name, and former staff surname. Present in the CSV files but not retained by the analysis build. |
| `LTSub` (`lt_substitute`) | Long-term-substitute indicator; `Y` denotes a long-term substitute. |
| `SubCntrctd` (`subcontracted`) | Subcontracted-employee indicator; records coded `Y` are excluded from the teacher panel. |

The address, telephone, administrator, county-name, and former-name variables
are documented for completeness but are not retained by `staff_build.do` and
are not required in a substantially similar analysis extract.

#### Linked staffing file

`Linked_Staffing_Data_10202015.csv` is a staff-year/worksite linkage file used
to recover longitudinal file numbers before the annual staff files are
combined.

| Raw variable | Description and coding expected by the build |
|--------------|------------------------------------------------|
| `last_name`, `first_name` | Staff surname and given name used for linkage. String; confidential direct identifiers. |
| `file_num` | Longitudinal staff file number. Converted to numeric when possible; zero, `NA`, and nonnumeric values are treated as missing. |
| `year` | Four-digit calendar/session year. The build retains 2006 and later. |
| `race` | Provider race/ethnicity code; `NA` is treated as missing. |
| `birth_year` | Four-digit year of birth used for linkage. |
| `sex` | Provider sex/gender code. The build recognizes `F` and `M`. |
| `distidworksite` | Official district/worksite identifier, converted to numeric when possible. |

#### Student-demographic file

The unit of observation in `student_demographics.csv` is a student-school
year. The expected key is `STUDENT_KEY` and `SCHOOL_YEAR`.

| Raw variable | Description and coding expected by the build |
|--------------|------------------------------------------------|
| `SCHOOL_YEAR` | School-year string in `YYYY-YYYY` form. The first year is used as the initial analysis year. |
| `DIST_ACCTBL_CODE` | Official accountable-district code. |
| `SCH_ACCTBL_CODE` | Official accountable-school code. |
| `STUDENT_KEY` | De-identified longitudinal student identifier shared with the test-score file. |
| `GRADE` | Provider grade code. The test-score analysis uses grades 3--8. |
| `GENDER` | Provider gender code. `F` creates the female indicator; blank is missing. |
| `RACE_ETHNICITY` | Provider race/ethnicity label. Labels used by the analysis include `Black`, `Hispanic`, `Asian`, and `Amer Indian`; other provider categories may be present. |
| `DISAB_STATUS` | Disability-status indicator or provider status code; numeric/blank values are retained and carried across student years when missing. |
| `EL_STATUS` | English-learner-status indicator or provider status code; numeric/blank values are retained and carried across student years when missing. |
| `ECON_DISADVANTAGE` | Economic-disadvantage indicator or provider status code; numeric/blank values are retained and carried across student years when missing. |

#### Student test-score file

The unit of observation in `testscores.csv` is a student--subject--school-year
test record. The expected key is `STUDENT_KEY`, `SCHOOL_YEAR`, and
`TEST_SUBJECT`, allowing one record per tested subject in a student-year.

| Raw variable | Description and coding expected by the build |
|--------------|------------------------------------------------|
| `SCHOOL_YEAR` | School-year string in `YYYY-YYYY` form. The build uses both the first and second year to align fall and spring tests. |
| `DIST_ACCTBL_CODE` | Official accountable-district code; renamed `district_code`. |
| `SCH_ACCTBL_CODE` | Official accountable-school code. The build extracts the numeric school code from this string. |
| `STUDENT_KEY` | De-identified longitudinal student identifier shared with the demographic file. |
| `GRADE` | Tested grade. The analysis retains grades 3--8 and excludes grade 10. |
| `TEST_NAME` | Provider assessment/program name. String. |
| `TEST_SUBJECT` | Tested subject. The build expects `Reading`/`Mathematics` in earlier school years and `ELA`/`Mathematics` in later school years, according to the year alignment implemented in `testscores_build.do`. |
| `TEST_SCALED_SCORE` | Numeric provider scaled score. The build standardizes this within grade, year, and subject. |
| `TEST_STDERR` | Numeric standard error supplied with the test score. It is imported but not used in the final standardized-score panel. |
| `TEST_PROF_LVL` | Provider proficiency-level label, such as basic, proficient, or advanced categories. It is imported but not used in the final standardized-score panel. |

The public `synthetic_data/raw/staff/temp.dta` and
`synthetic_data/raw/testscores_indlev/dem.dta` files are validation/support
copies, not additional confidential source datasets. The production build
constructs its working demographic file from `student_demographics.csv`.

## Synthetic Public Data

The public archive replaces the confidential WDPI staff and student
inputs with fixed synthetic files under
`synthetic_data/raw/`.
These files are fictitious records with the same broad structure expected by
the build scripts.

| Synthetic input                                                                                                                                                                      | Unit of observation                 | Notes                                                                                                                                   |
|-------------------------------|------------------|-----------------------|
| `synthetic_data/raw/staff/06staff.txt` through `14staff.txt` | Staff district-school-position-year | Fixed-width fictitious staff files matching the legacy WDPI staff-file layout.                                                          |
| `synthetic_data/raw/staff/15staff.csv`, `16staff.csv`        | Staff district-school-position-year | CSV fictitious staff files matching the later WDPI staff-file layout.                                                                   |
| `synthetic_data/raw/staff/temp.dta`                                                                                      | Staff-year linkage support          | Fictitious support copy checked by the synthetic-data validator; it is not read by the production synthetic master.                    |
| `synthetic_data/raw/teacher_data_linked/Linked_Staffing_Data_10202015.csv`                                               | Staff-year linkage support          | Fictitious linked-staffing support file required by `oldteacher_roster_build.do`. |
| `synthetic_data/raw/testscores_indlev/student_demographics.csv`                                                          | Student-year                        | Fictitious student demographics.                                                                                                        |
| `synthetic_data/raw/testscores_indlev/dem.dta`                                                                           | Student-year                        | Stata-format support copy checked by the synthetic-data validator; the production build creates its working demographics file from the CSV. |
| `synthetic_data/raw/testscores_indlev/testscores.csv`                                                                    | Student-subject-year                | Fictitious math, reading, and ELA test-score records.                                                                                   |

The synthetic staff files are designed so staff IDs overlap heavily
across years, staff observations are district-school-position-year
records, most person-years have one district-school-position, and most
one-position person-years are teachers. Synthetic test-score and
demographic files share fictitious student IDs and school years, with student
records repeated across years. The synthetic data also include nonempty
cells needed by value-added, teacher-choice, event-time, subgroup,
wage-schedule, and map/figure code.

The synthetic inputs are distributed as final fictitious raw files. The
simulation script used to generate them is included for transparency at
`synthetic_data/code/make_simulated_data.do`.
That script creates the fictitious WDPI-style raw inputs from scratch, does
not read confidential records, calls
`synthetic_data/code/02_make_synthetic_data.do`,
and then runs
`synthetic_data/code/03_validate_synthetic_structure.do`
to check the simulated data's structure and key relationships. Running
it overwrites files under
`synthetic_data/raw/`
and refreshes the public manifest/notes. Additional documentation is in
`synthetic_data/documentation/synthetic_data_notes.md`
and
`synthetic_data/documentation/synthetic_data_manifest.csv`;
both files are included in the public archive.

## Repository Structure

The main folders and files in the replication folder are:

| Path                                                                                                     | Purpose                                                                                                                                                                                                             |
|-------------------------|----------------------------------------------|
| `README.md`                                  | This replication guide.                                                                                                                                                                                             |
| `LICENSE`                                    | License terms for the authors' code, synthetic data, and documentation, with third-party materials excluded from the license grant.                                                                                |
| `code/`                                      | Stata, R, and Fortran code for data construction, analysis, model, and exhibit generation.                                                                                                                          |
| `code/master_synth.do`                       | Public Stata driver using the fixed synthetic WDPI-style inputs and writing exhibits to `out_synth/`.                                                                                                               |
| `code/master.do`                             | Main Stata driver. Defines globals and calls build/exhibit scripts.                                                                                                                                                 |
| `code/produce_exhibits.do`                   | Secondary Stata driver. After the master and Fortran results are produced, calls exhibit scripts to complete the remaining outputs.                                                                                                 |
| `code/build/`                                | Stata scripts that construct roster, staff, teacher panel, test-score, value-added, wage-schedule, model-estimation, and simulation input files.                                                                    |
| `code/descriptives/`                         | Stata scripts for descriptive tables, figures, appendix robustness tables, and map/figure construction.                                                                                                             |
| `code/auxiliary_regressions/`                | Stata scripts for auxiliary teacher-choice and wage regressions and robustness variants.                                                                                                                            |
| `code/fortran_model/`                        | Fortran code to run the model and all counterfactual and other modeling analyses.                                                                                                                                   |
| `code/fortran_model/common_f90s/`            | Shared Fortran modules, stored once; the `entry/` branch is used by entry/forward scenarios and `non_entry/` by all other scenarios.                                                                                |
| `code/fortran_model/run_all_local.sh`        | Portable compiler/runner for all 30 Fortran scenarios on macOS and Unix-like systems. It compiles only unless the replicator explicitly supplies `--run`.                                                           |
| `code/fortran_model/example_slurm_batchfile` | Common Slurm submission script used for the submitted scenario runs; its site-specific settings must be adapted before use on another cluster.                                                                      |
| `original_fortran_instruction_files/`        | Archived full-run `instruction.txt` files for all 30 Fortran scenarios, with paths matching the active scenario directories.                                                                                        |
| `code/Figure_B9/`                            | Figure B9 Stata code and R simulation helper for the identification illustration.                                                                                                                                   |
| `data/public/`                               | Unmodified third-party public source data used to calculate in-text statistics, with provider documentation.                                                                                                      |
| `intermediate_data/`                         | Working intermediate Stata datasets. Current files may be derived from restricted inputs.                                                                                                                           |
| `model_data/`                                | Model-estimation inputs and CSV exports generated by `build_model_dataset.do` and related scripts. Current files may be derived from restricted inputs. |
| `simulation_data/`                           | Pre-Act 10 simulation input files generated by `build_model_dataset_pre2011.do`. Current files may be derived from restricted inputs.                   |
| `out/`                                       | Actual restricted-data exhibit outputs from `code/master.do`. This folder is not generated by the public simulated-data replication.                    |
| `out_synth/`                                 | Expected simulated-run outputs from `code/master_synth.do` using the public synthetic data. This is the package's output-simulated folder.              |
| `real_data/`                                 | Shareable auxiliary inputs that are either constructed by the authors or publicly available.                                                                                                                        |
| `synthetic_data/raw/`                        | Fixed public synthetic inputs that replace the confidential WDPI staff and student files.                                                                                                                           |
| `synthetic_data/code/make_simulated_data.do` | Public Stata script that regenerates and validates the simulated WDPI-style raw inputs from scratch.                                                                                                                |
| `synthetic_data/documentation/`              | Public manifest and notes describing the simulated raw inputs. Private profiling logs and Stage 1 planning notes are not required for the public archive.                                                           |

## Computational Requirements

### Software

| Software        | Requirement/evidence                                                                                                                                                                                                                 |
|-------------------|-----------------------------------------------------|
| Stata 19        | Stata/SE or Stata/MP can run the public synthetic workflow. The confidential driver requests a larger variable ceiling and therefore requires Stata/MP. The public workflow was tested with StataNow/MP 19.5 for Apple Silicon, 21 May 2025 revision. `code/master.do` and `code/master_synth.do` verify or install the required SSC packages before running. An Internet connection is needed on the first run unless they are already installed. |
| Stata packages  | The tested SSC versions are `estout` 3.33, `esttab` 2.1.4, `ftools` 2.50.0, `reghdfe` 6.13.1, `coefplot` 1.8.8, `binscatter` 7.02, `carryforward` 4.5, `spmap` 1.3.2, `sepscatter` 1.1.0, `blindschemes` 1.3.0, and `require` 1.3.1. `blindschemes` provides the `plotplain` graph scheme, while `require` is used by `reghdfe` to manage dependencies. The drivers install current SSC releases rather than enforcing these exact versions. |
| R               | Required only for `code/Figure_B9/cutoff_prefs_id_example_graph.R`. The analysis used R 4.2.3. The helper was also tested with R 4.5.1, `haven` 2.5.5, `extRemes` 2.2.1, and `MASS` 7.3-65. It creates the configured user library when needed and installs missing packages from CRAN. |
| Fortran and MPI | The model was originally run with GNU Fortran (GCC) 11.5.0 20240719 (Red Hat 11.5.0-14) and `mpiexec` (OpenRTE) 4.1.1. The distributed code was also compiled successfully on Apple Silicon with GNU Fortran 16.1.0 and Open MPI 5.0.9. |
| BLAS/LAPACK     | BLAS and LAPACK are required by the Fortran model. The portable runner links Homebrew OpenBLAS on macOS and `-lblas -llapack` on other Unix-like systems. `FORTRAN_LINK_FLAGS` can override this choice. |
| Shell/OS        | Command-line examples use a Unix-like shell. The portable Fortran runner requires Bash. Start Stata in the repository root as instructed below. The Stata drivers locate the replication root from Stata's current working directory; no machine-specific path edits are required. |

### Tested Hardware, Runtime, and Storage

The public Stata workflow and local compilation checks were run on a MacBook
Pro (Mac16,6) with an Apple M4 Max processor (16 CPU cores), 128 GB of memory,
and macOS 26.5.2. The installed Stata/MP license used two Stata cores.

In two clean validation runs on this machine, optional synthetic-input
regeneration took approximately 1 hour 31 minutes to 1 hour 43 minutes, and
`code/master_synth.do` took approximately 2 hours 43 minutes to 2 hours 53
minutes. The Figure B9 R helper took less than three seconds. The complete
30-scenario Fortran stage took approximately 12 hours 29 minutes with eight
MPI ranks, and the final exhibit step took less than five seconds.

Using the included synthetic raw inputs, the required Stata, R, Fortran, and
final-exhibit pipeline therefore took approximately 15 hours 13 minutes.
Including optional synthetic-input regeneration increased the total to
approximately 16 hours 44 minutes. Replicators should allow an overnight or
full-day run; hardware and MPI configuration can materially affect runtime.

The complete working tree occupied approximately 3.8 GB after the Stata
workflow generated its intermediate and model data. Replicators should allow
for an additional approximately 269 MB for the uncompressed public ED Data
Express proficiency file and should allow at least 5 GB of free disk space.
More space may be needed for Fortran logs, platform-specific build files, or
additional validation copies.

### Controlled Randomness

`code/master_synth.do`
sets both `set seed 12345` and `set sortseed 12345` to control Stata
randomness. The synthetic master also normalizes opened/closed timestamps in Stata table
logs so repeated public runs produce the same substantive synthetic tables and
figures. The simulated-data generator
`synthetic_data/code/make_simulated_data.do`
sets both `set seed 20260613` and `set sortseed 20260613`.
The generator also normalizes Stata
`.dta`
timestamps and unused padding in the two public support
`.dta`
files, so regenerated simulated raw inputs are byte-for-byte stable
across reruns.

The Figure B9 R helper sets its own R seed.

For the Fortran code, each
`main.f90`
sets the random-number generator to the same four fixed seed values.

## Description of Programs and Execution Order

The public driver, `code/master_synth.do`, calls the core scripts in this
order. The confidential driver, `code/master.do`, follows the analogous
restricted-data workflow.

1.  Build teacher panel without contribution measures:
    `oldteacher_roster_build.do`,
    `staff_build.do`,
    `teachers_build.do`,
    `teachers_panel.do`.
2.  Build test-score and teacher-side value-added inputs:
    `va_teacherside_build.do`,
    `testscores_build.do`.
3.  Estimate teacher contribution measures:
    `valueadded_calculation.do`,
    `valueadded_calculation_classmodel.do`,
    `valueadded_calculation_stockstaiger_nocomparativeadv.do`.
4.  Construct final analysis panel:
    `teachers_with_allva.do`.
5.  Generate model-estimation inputs:
    `schedule_new.do`,
    `gen_omegas.do`,
    `gen_omegas_info.do`,
    `build_model_dataset.do`,
    `build_teachers_offer_set.do`,
    `auxiliary_models_teachers.do`,
    `aux_other_moments.do`,
    `auxiliary_models_districts.do`,
    `build_model_dataset_info0.do`,
    `build_model_dataset_info1.do`,
    `build_model_dataset_info2.do`,
    `build_model_dataset_info3.do`,
    `auxiliary_models_teachers_info_matches.do`,
    `omega_databuild.do`,
    `budget_overtime.do`,
    `build_distance_matrix.do`,
    `build_wageschedule_exitentry.do`,
    `fix_estsample_age.do`.
6.  Generate pre-Act 10 simulation inputs:
    `build_model_dataset_pre2011.do`,
    `build_simulation_lndist.do`.
7.  Generate the in-text calculations:
    `descriptives/intext_numbers.do`, which writes
    `out_synth/tables/Intext_numbers.log` in the public workflow and
    `out/tables/Intext_numbers.log` in the confidential workflow. The program
    contains only calculations for numerical statements derived from package
    data. Contextual facts supported by external citations and author-chosen
    specification values are not included in the program or log.
8.  Generate the main-paper and appendix exhibits that do not require
    completed Fortran model results or the Figure B9 R helper.

Subsequently, run the Figure B9 R helper and the 30 Fortran model scenarios.

Lastly, `code/produce_exhibits.do` produces Figure 4, Figure B9, and the
remaining generated exhibits; Table B6 is the manual exception documented in
the exhibit map.

## Instructions to Replicators

### 1. Set Up the Folder

Clone or unpack the replication package and start from the repository
root.

```
cd replication
mkdir -p intermediate_data model_data simulation_data \
  out_synth/tables out_synth/figures
```
The public archive should contain
`synthetic_data/raw/`,
`real_data/`,
`data/public/`,
and `code/`.
The synthetic raw data are already included; the generator is included
only so the Data Editor can inspect or regenerate them if needed.

### 2. Confirm the Stata Working Directory

For the public synthetic-data replication, use
`code/master_synth.do`.
No path edits are required. Start Stata in the repository root. The drivers
set
`$rootpath`
from Stata's current working directory and verify the expected driver path
before any build code runs. If Stata did not start there, change directories
once:

```
cd ".../replication"
```

The drivers also accept being launched from the repository's
`code/`
directory and automatically return to the repository root. Do not change the
relative structure under
`synthetic_data/raw/`.

The public driver then defines the remaining globals from the detected root:

```
global code = "$rootpath/code/"
global confdata = "$rootpath/synthetic_data"
global raw = "$rootpath/real_data"
global intdata = "$rootpath/intermediate_data"
global est = "$rootpath/model_data/"
global sim = "$rootpath/simulation_data/"
global out = "$rootpath/out_synth/"
```
For a confidential-data run, use
`code/master.do`
and point
`$confdata`
to the approved local WDPI data location. Confidential data are not part
of the public archive.

### 3. Confirm or Regenerate Synthetic Input Data

The synthetic public package should include the fictitious staff and student
files listed in the "Synthetic Public Data" section above. Keep the
shareable auxiliary inputs in
`real_data/`.

To regenerate the simulated raw inputs from scratch, run the public
simulation script from the repository root:

```
do synthetic_data/code/make_simulated_data.do
```
This recreates
`synthetic_data/raw/`,
refreshes
`synthetic_data/documentation/synthetic_data_manifest.csv`
and
`synthetic_data/documentation/synthetic_data_notes.md`,
and runs structural validation plus a scratch build-workflow smoke check. Run
this optional regeneration only after the SSC packages checked by the master
have been installed. It does not create the exhibit outputs; those are
generated by the synthetic master in the next step.

### 4. Run the Synthetic Stata Build

From Stata:

```
do code/master_synth.do
```
From a Unix-like shell, if Stata is available on the command line:

```
stata-mp -b do code/master_synth.do
```
Replace
`stata-mp`
with the local Stata executable name if needed.

The synthetic run writes tables to
`out_synth/tables/`
and figures to
`out_synth/figures/`.
Immediately before the first exhibit script, the master runs
`code/descriptives/intext_numbers.do` and writes
`out_synth/tables/Intext_numbers.log`. The concise results-only log reports
only the calculated values corresponding to statements in the paper and
Online Appendix. Its first line calculates the district proficiency ranges
from the included ED Data Express file. Citation-only contextual facts and
author-chosen specification values are omitted.
It also regenerates local working files in
`intermediate_data/`,
`model_data/`,
and
`simulation_data/`.
The included `out_synth/` folder contains the expected outputs written
directly by `code/master_synth.do`. Running the Figure B9 helper, the Fortran
models, and `code/produce_exhibits.do` adds the remaining exhibits to the same
folder. The public workflow should not write to
`out/`.

### 5. Run R Simulation Script

Run the R code that produces the simulation underlying Figure B9. The helper
locates the replication root from its own file path, so it can be invoked from
the repository root without editing the script or changing the working
directory. It installs missing packages in the configured R user library:

```
Rscript code/Figure_B9/cutoff_prefs_id_example_graph.R
```

### 6. Run Fortran Model Code

All model-estimation and counterfactual code is under
`code/fortran_model/`. Shared modules are stored once in
`code/fortran_model/common_f90s/`. The runner compiles the `entry/` branch for
the `5_exitentry` and `6_forward` scenarios and the `non_entry/` branch for
all other scenarios. Each scenario directory retains its driver, makefile,
configuration, belief inputs, and expected results so that the directory maps
directly to one model exercise and can be run independently.

The portable runner first verifies that `mpifort` is installed and then
compiles all 30 scenarios. Compilation is the default so that invoking the
script cannot accidentally begin the potentially long calculations:

```
code/fortran_model/run_all_local.sh --compile-only
```

On macOS with Homebrew, the required compiler and MPI tools can be installed
with:

```
brew install gcc open-mpi openblas
```

On Debian/Ubuntu, the corresponding system packages are commonly installed
with:

```
sudo apt-get install gfortran openmpi-bin libopenmpi-dev \
  libblas-dev liblapack-dev
```

After compilation, run every scenario with an explicit MPI rank count:

```
code/fortran_model/run_all_local.sh --run --ranks <ranks>
```

On the tested 128 GB Apple M4 Max machine, eight MPI ranks are recommended.
The largest executable declares approximately 6.3 GB of static data per rank,
so this setting provides useful parallelism while retaining substantial memory
headroom. Rank counts for other systems should be chosen according to
available memory.

To compile or run only one scenario, add its path relative to
`code/fortran_model/`:

```
code/fortran_model/run_all_local.sh --run --ranks <ranks> \
  --scenario 1_baseline
```

The runner changes into each scenario directory before execution, as required
by the relative input paths in the model code. Standard output and error are
written to the scenario's `result/run_main.log`; numerical result text files
remain in the same `result/` directory.

Each scenario also retains its original makefile, written for a Slurm
cluster. Its compile target requires `mpifort` plus BLAS and LAPACK:

```
make compile_mpi_slurm
```

The common Slurm script actually used for the submitted scenario runs is
included at `code/fortran_model/example_slurm_batchfile`. It was reused across
the scenarios, requested 128 MPI tasks and 200 GB of memory on partition `fu`,
wrote the job log to `result/run_main.log`, set site-specific UCX/OpenMPI
transport options, and launched `mpiexec run_main`. It did not specify a wall
time. Another cluster user must adapt the partition, resource request, loaded
modules or software environment, and transport settings. To use it with a
scenario makefile, copy it into that scenario as `run_main.batch`, create the
result directory, and submit through the makefile; for example, from the
repository root:

```bash
cp code/fortran_model/example_slurm_batchfile \
   code/fortran_model/1_baseline/run_main.batch
mkdir -p code/fortran_model/1_baseline/result
cd code/fortran_model/1_baseline
make run_mpi_slurm
```

Do not use these cluster-specific settings without reviewing them. Users
without Slurm should use `run_all_local.sh` as described above. The scenario
makefiles also contain Linux-specific library paths and compiler flags; the
portable runner bypasses those settings.

#### Fortran instruction files

The Fortran `read_instructions` routine opens the scenario's
`instruction.txt` and reads the leading numeric value or values on each line,
sequentially. Text following those values is annotation for the reader, not a
separate configuration input. The baseline public file
`code/fortran_model/1_baseline/instruction.txt` has the following 19 records.
The "full value" column refers to the matching file under
`original_fortran_instruction_files/`; a dash means that the public and full
values are identical.

| Line | Fortran field | Public value | Full value | Purpose |
|---:|---|---:|---:|---|
| 1 | `purpose` | 10 | — | Selects the program mode; 10 solves the baseline equilibrium. |
| 2 | `teachOff_decision` | 1 | — | Switches teacher/offer decisions on (1) or off (0), subject to purpose-specific overrides. |
| 3 | `wage_decision` | 1 | — | Switches wage decisions on (1) or off (0), subject to purpose-specific overrides. |
| 4 | `skip_first_inner_loop` | 0 | — | If 1, skips the first inner loop; 0 does not skip it. |
| 5 | `report_weight_factors` | 1 | — | If 1, enables the weight-factor diagnostic in the applicable first outer-loop round. |
| 6 | `simplex_length` | 0.25 | — | Sets the initial Nelder-Mead simplex length. |
| 7 | `maxiter` | 2 | 1000 | Sets the outer-loop/equilibrium maximum iteration count. |
| 8 | `outer_tol_pct` | 0.005 | — | Sets the percentage-difference convergence tolerance for outer-loop parameters. |
| 9 | `outer_tol_dif` | 0.005 | — | Is read for instruction-format compatibility but is not used by the shipped active execution paths. |
| 10 | `h_maxiter` | 2 | 300 | Sets the inner belief-optimization maximum iteration count. |
| 11 | `h_tol_pct` | 0.1 | — | Sets the percentage-difference convergence tolerance for belief parameters. |
| 12 | `h_tol_dif` | 0.1 | — | Is read for instruction-format compatibility but is not used by the shipped active execution paths. |
| 13 | `rcost_experiment` | 0 | — | Activates the zero-resistance-cost counterfactual when set to 1. |
| 14 | `nomovecost_experiment` | 0 | — | Activates the no-moving-cost counterfactual when set to 1. |
| 15 | `NcopyT` | 5 | — | Sets the number of teacher copies used in simulation/estimation. |
| 16 | `NcopyD` | 3 | — | Is read and used to form an unused district-copy count; it does not affect the shipped execution paths. |
| 17 | `Neconomy` | 2 | 50 | Sets the number of simulated economies for equilibrium/counterfactual runs. |
| 18 | `starting_economy` | 1 | — | Sets the first simulated economy, allowing earlier economies to be skipped. |
| 19 | `s_vec` | 0.0 0.0 | — | Sets the two-element subsidy vector across student types; the paper's `(r0,r1)` parameterization equals `(s2,s1-s2)`. |

`purpose` is a nonconsecutive mode code, not an ordered list of steps. The
values used by the 30 shipped configurations are `-2` (perturbation), `-1`
(standard errors), `1` (evaluate parameters and write moments), `7` (rigid
wage), `10` (baseline equilibrium), and `18` (subsidized equilibrium). The
source also retains several unused legacy/development branches. No
`purpose = 6` branch is implemented or required, so there is no missing sixth
step. Purpose 7 turns teacher/offer decisions on and wage decisions off;
purposes -1 and -2 turn teacher/offer decisions on and skip the inner loop.

The entry and forward-iteration readers use the same first 19-record layout;
their implementation reads record 19 into `svec_gradient` and constructs
`s_vec` at run time. They then read six additional records:

| Additional field | Purpose |
|---|---|
| `T_max` | Number of model periods. |
| `max_period_initbeliefs` | Last period for which beliefs are supplied from an input file. |
| `flag_entry` | Switch controlling teacher entry. |
| `flag_exit` | Switch controlling teacher exit. |
| `wage_elas` | Wage elasticity used in the entry/forward model. |
| `ncopy_entr` | Number of entrant copies used in the simulation. |

`T_max` is 2 in the seven `5_exitentry` scenarios and 6 in the three
`6_forward` scenarios; these period counts are the same in the public and
archived instruction files.

For non-entry scenarios, `nteach_filepath.inc` supplies the compile-time
teacher count, the validation flag, and the repository-relative input path.
Shared starting files are named `initial_param_guess*.txt` and
`initial_theta*.txt` under `common_f90s/`. Entry and forward scenarios store
period-specific belief inputs locally as `mainbelief_50.txt`,
`wagebelief_50.txt`, and variants such as `_t2`, `_t3`, and subsequent
periods.

In total, there are 30 scenario directories, each to be run in order
to produce all modeling results. They are separated out and pre-set for
easy replication. The scenarios are independent: none requires the generated
results from another scenario as an input.

For a faster public synthetic-data replication, 25 active `instruction.txt`
files set `maxiter`, `h_maxiter`, and `Neconomy` to 2. Five scenarios retain
the full settings of 1000, 300, and 50: `2_rigid`, `estimation_result`,
`perturbation`, `stderr`, and `validation_result`. These five full settings
are intentional for the public run and should not be reduced.

The original full-run configuration files are distributed under
`original_fortran_instruction_files/`. All 30 archived files use
`maxiter = 1000`, `h_maxiter = 300`, and `Neconomy = 50`; their relative paths
match the runnable scenarios. Exactly 25 public files differ from their
archived counterparts, and only those three computational-size fields differ.
To run a full configuration, copy its archived file over the corresponding
public testing configuration before invoking the runner with `--run`. For
example:

```bash
cp original_fortran_instruction_files/1_baseline/instruction.txt \
   code/fortran_model/1_baseline/instruction.txt
bash code/fortran_model/run_all_local.sh --run --ranks 8 \
  --scenario 1_baseline
```

The runner does not select the full configurations automatically. Because
they require many more iterations and simulated economies, their execution
time is substantially longer than the reduced-run estimates reported above.
Use a fresh package copy to return to the reduced public configurations after
running a full configuration.

The model drivers initialize the random-number generator with the same fixed
seed values. Different compilers, BLAS/MPI implementations, processor counts,
or reduction orders can nevertheless produce last-digit floating-point
differences; fixed seeds do not imply byte-for-byte equality across computing
environments. The distributed Fortran `result/*.txt` files are based on the
public synthetic workflow or have otherwise been cleared for public
distribution.

### 7. Run Remaining Exhibits

While
`master.do`/`master_synth.do`
produce some exhibits, many exhibits depend on the Fortran results and are
produced by another Stata file. Once all of the
above results have been run,
`code/produce_exhibits.do`
can be run in Stata to complete the full suite of exhibits.

The Figure B10 map script leaves Stata in the shapefile directory. Before
running the final driver, return to the replication root:

```
cd ".../replication"
do code/produce_exhibits.do
```

## Exhibit Map

The entries below report the code and outputs found in this working
tree. Output paths refer to the public simulated-data run under
`out_synth/`.
The confidential master writes its direct outputs to `out/`. The supplied
`produce_exhibits.do` is configured for `out_synth/`; it must be pointed to
`out/` before generating the corresponding restricted-data outputs. The Data
Editor will not generate restricted-data outputs.

### In-Text Numbers

-   Code:
    `code/descriptives/intext_numbers.do` (calculation-based numerical
    statements only; citation-only contextual facts and author-chosen
    specification values are omitted).
-   Main input for item 1:
    `data/public/proficiency_data/SY2021_FS175_DG583_LEA_data_files/SY2021_FS175_DG583_LEA.csv`
-   Item 8 (173 of 411 public elementary districts with one school) is a
    descriptive calculation from the 2014 teacher panel. The program applies
    the elementary-teacher model-sample restrictions, counts distinct schools
    within each district, limits the result to the 411 model-estimation
    districts, and reports the resulting count. It does not require
    re-estimating the auxiliary models.
-   Output:
    `out_synth/tables/Intext_numbers.log` for the public workflow and
    `out/tables/Intext_numbers.log` for the confidential workflow.

### Main Paper Tables

#### Table 1: Teacher and District Characteristics (2014)

-   Code/status:
    `code/descriptives/summary.do`
-   Main input datasets:
    `model_data/experiencecont.dta`,
    `model_data/master.dta`,
    `model_data/contributions.dta`,
    `model_data/lambda.dta`,
    `model_data/urban.dta`,
    `model_data/suburban.dta`,
    `model_data/incumbent.dta`,
    `model_data/budget.dta`
-   Output path:
    `out_synth/tables/Table_1A.log`;
    `out_synth/tables/Table_1B.log`

#### Table 2: OLS of Teacher-District Match (2014)

-   Code/status:
    `code/auxiliary_regressions/aux_model_teachers_wages.do`
-   Main input datasets:
    `model_data/multinomial.dta`,
    `model_data/matched_movers.dta`,
    `real_data/district_distance_sdid.dta`,
    `real_data/cesa.dta`
-   Output path:
    `out_synth/tables/Table_2.log`;
    also writes
    `model_data/betaT1_JPE.csv`,
    `model_data/betaT1_var_JPE.csv`,
    `model_data/betaT2_JPE.csv`,
    `model_data/betaT2_var_JPE.csv`

#### Table 3: District Wage Schedules (2014)

-   Code/status:
    `code/descriptives/summary.do`
-   Main input datasets:
    `model_data/contributions.dta`,
    `model_data/experiencecont.dta`,
    `model_data/master.dta`,
    `model_data/incumbent.dta`,
    `model_data/urban.dta`,
    `model_data/suburban.dta`,
    `model_data/lambda.dta`,
    `model_data/budget.dta`,
    `model_data/alphagrid.dta`,
    `model_data/multinomial.dta`;
    `real_data/district_county_cz.dta`
-   Output path:
    `out_synth/tables/Table_3A.log`;
    `out_synth/tables/Table_3B.log`;
    `out_synth/tables/Table_3C.log`

#### Table 4: Explaining District Reward for Teacher Contribution `omega_d2` (2014)

-   Code/status:
    `code/descriptives/omega_analysis.do`
-   Main input datasets:
    `intermediate_data/omega_analysis_data_JPE.dta`
-   Output path:
    `out_synth/tables/Table_4.log`
-   Upstream model-moment outputs:
    `code/auxiliary_regressions/aux_model_teachers_wages.do` writes
    `model_data/omega1_JPE.csv`,
    `model_data/omega1_var_JPE.csv`,
    `model_data/omega2_JPE.csv`,
    `model_data/omega2_var_JPE.csv`,
    `model_data/omega_moments_JPE.csv`

#### Table 5: Parameter Estimates

-   Code/status:
    `code/descriptives/Table_5_Table_A1.do`
-   Main input datasets:
    `code/fortran_model/common_f90s/initial_param_guess.txt`,
    `code/fortran_model/stderr/result/se_param.txt`
-   Output path:
    `out_synth/tables/Table_5_Table_A1.csv`

#### Table 6: Flexible Pay vs Rigid Pay

-   Code/status:
    `code/descriptives/Table_6.do`
-   Main input datasets:
    `code/fortran_model/1_baseline/result`,
    `code/fortran_model/2_rigid/result`
-   Output path:
    `out_synth/tables/Table_6.csv`

#### Table 7: State-Funded Bonuses

-   Code/status:
    `code/descriptives/Table_7.do`
-   Main input datasets:
    `code/fortran_model/1_baseline/result`,
    `code/fortran_model/3_basicCfs/new1/result`,
    `code/fortran_model/3_basicCfs/new2/result`,
    `code/fortran_model/3_basicCfs/new3/result`
-   Output path:
    `out_synth/tables/Table_7.csv`

#### Table 8: Moving Costs, Resistance Costs, and Policy Impacts

-   Code/status:
    `code/descriptives/Table_8.do`
-   Main input datasets:
    `code/fortran_model/1_baseline/result`,
    `code/fortran_model/4_nomovecost/case1/result`,
    `code/fortran_model/4_nomovecost/case2/result`,
    `code/fortran_model/4_nomovecost/case2_new2/result`
-   Output path:
    `out_synth/tables/Table_8.csv`

### Main Paper Figures

#### Figure 1: Variation in Teacher Salaries

-   Code/status:
    `code/descriptives/data_patterns.do`
-   Main input datasets:
    `intermediate_data/teachers_panel_JPE.dta`,
    `intermediate_data/indtest_math_split_JPE.dta`
-   Output path:
    `out_synth/figures/Figure_1.png`

#### Figure 2: Rates of Teacher Movements Across Districts

-   Code/status:
    `code/descriptives/data_patterns.do`
-   Main input datasets:
    `intermediate_data/teachers_panel_JPE.dta`
-   Output path:
    `out_synth/figures/Figure_2a.png`;
    `out_synth/figures/Figure_2b.png`

#### Figure 3: Variation in Teacher Salaries (sorting correlations)

-   Code/status:
    `code/descriptives/data_patterns.do`
-   Main input datasets:
    `intermediate_data/teachers_panel_JPE.dta`,
    `intermediate_data/indtest_math_split_JPE.dta`,
    `intermediate_data/budget_overtime_JPE.dta`
-   Output path:
    `out_synth/figures/Figure_3.png`

#### Figure 4: Cumulative Distribution Function of `omega_2` by Groups of `lambda_d`

-   Code/status:
    `code/descriptives/Figure_4.do`
-   Main input datasets:
    `model_data/lambda.csv`,
    `model_data/alpha1.csv`,
    `model_data/alpha2.csv`
-   Output path:
    `out_synth/figures/Figure_4_omega2_cdf.png`

### Paper Appendix A Tables

#### Table A1: Other Parameter Estimates: Wage Setting Cost `R(omega, dem_d)`

-   Code/status:
    `code/descriptives/Table_5_Table_A1.do`
-   Main input datasets:
    `code/fortran_model/common_f90s/initial_param_guess.txt`,
    `code/fortran_model/stderr/result/se_param.txt`
-   Output path:
    `out_synth/tables/Table_5_Table_A1.csv`

#### Table A2: Model Fit: OLS of Teacher-District Match (post-Act 10)

-   Code/status:
    `code/descriptives/Table_A2.do`
-   Main input datasets:
    `code/fortran_model/estimation_result/result/aux_and_omega_params.txt`
-   Output path:
    `out_synth/tables/Table_A2.csv`
-   Synthetic-data note:
    the reduced public model makes the inferred-model regression numerically
    singular, so that column is missing in the distributed reference output.
    The remaining columns are populated.

#### Table A3: Model Fit: District Wage Schedules

-   Code/status:
    `code/descriptives/Table_A3_PanelA.do`,
    `code/descriptives/Table_A3_PanelB.do`
-   Main input datasets:
    `code/fortran_model/estimation_result/result/aux_and_omega_params.txt`,
    `code/fortran_model/estimation_result/result/omega2_probs.txt`,
    `model_data/multinomial.dta`
-   Output path:
    `out_synth/tables/Table_A3_PanelA.csv`,
    `out_synth/tables/Table_A3_PanelB.csv`

### Online Appendix B Tables

#### Table B1: Estimated parameters of teacher effectiveness

-   Code/status:
    `code/build/valueadded_calculation.do`
-   Main input datasets:
    `intermediate_data/teachers_panel_nova_JPE.dta`,
    `intermediate_data/indtest_math_split_JPE.dta`,
    `intermediate_data/va_teacherside_math_JPE.dta`
-   Output path:
    `out_synth/tables/Table_B1.log`;
    also writes
    `intermediate_data/va_highlow_math_expdisc_JPE.dta`

#### Table B2: Distribution of teacher effectiveness

-   Code/status:
    `code/descriptives/appendix_figures.do`
-   Main input datasets:
    `model_data/contributions.dta`
-   Output path:
    `out_synth/tables/Table_B2.log`

#### Table B3: Test for Forecast Unbiasedness and Non-Random Teacher Sorting

-   Code/status:
    `code/descriptives/rothstein_test.do`
-   Main input datasets:
    `intermediate_data/indtest_math_split_JPE.dta`,
    `intermediate_data/teachers_panel_JPE.dta`,
    `intermediate_data/va_teacherside_math_JPE.dta`
-   Output path:
    `out_synth/tables/Table_B3.tex`

#### Table B4: Correlation of Teacher Effectiveness between Model 1 and Model 2

-   Code/status:
    `code/build/valueadded_calculation_classmodel.do`
-   Main input datasets:
    `intermediate_data/teachers_panel_nova_JPE.dta`,
    `intermediate_data/va_teacherside_math_JPE.dta`,
    `intermediate_data/indtest_math_split_JPE.dta`,
    `intermediate_data/va_highlow_math_expdisc_JPE.dta`
-   Output path:
    `out_synth/tables/Table_B4.log`;
    also writes
    `intermediate_data/va_classmodel_JPE.dta`

#### Table B5: Auxiliary Models Aux 1a and Aux 1b, Under Achievement Models 1 and 2

-   Code/status:
    `code/auxiliary_regressions/auxmodels_teachers_varobust.do`
-   Main input datasets:
    `intermediate_data/va_classmodel_JPE.dta`,
    `model_data/multinomial.dta`,
    `real_data/district_distance_sdid.dta`,
    `real_data/cesa.dta`
-   Output path:
    `out_synth/tables/Table_B5.log`;
    also writes
    `model_data/multinomial_varobust_JPE.dta`,
    `model_data/matched_movers_varobust_JPE.dta`

#### Table B6: Comparison of Signal-to-Noise Ratios with Estimates of Math Teacher Value-Added in the Literature

-   Code/status:
    No standalone replication script. The table is generated using estimates from the literature.
-   Main inputs:
    Author calculations for the paper's value-added measures and comparisons
    reported in the cited literature; no separate input dataset is read by the
    replication workflow.
-   Output path:
    No standalone generated file; the table is rendered as part of the online
    appendix.

#### Table B7: Sum of Squared Test Score Residuals Under `c` and Under `(c1,c2)`

-   Code/status:
    `code/descriptives/c1c2_variation_studentlevel.do`
-   Main input datasets:
    `intermediate_data/teachers_panel_JPE.dta`,
    `intermediate_data/va_teacherside_math_JPE.dta`,
    `intermediate_data/va_nocomparativeadv_JPE.dta`,
    `intermediate_data/indtest_math_split_JPE.dta`
-   Output path:
    `out_synth/tables/Table_B7.log`

#### Table B8: Achievement Production Function: Controlling for Teachers and Students' Race/Ethnicity

-   Code/status:
    `code/descriptives/achievement_race.do`
-   Main input datasets:
    `intermediate_data/teachers_new_JPE.dta`,
    `intermediate_data/teachers_panel_nova_JPE.dta`,
    `intermediate_data/indtest_math_split_JPE.dta`,
    `intermediate_data/va_teacherside_math_JPE.dta`
-   Output path:
    `out_synth/tables/Table_B8.tex`

#### Table B9: Cross-District Summary of Pre-Reform Wage Schedules

-   Code/status:
    `code/descriptives/schedule_summary.do`
-   Main input datasets:
    `model_data/lambda.dta`,
    `intermediate_data/schedule_new_JPE.dta`
-   Output path:
    `out_synth/tables/Table_B9.log`

#### Table B10: Variation in Salaries Across and Within Districts, 2013-2016

-   Code/status:
    `code/descriptives/salary_variation.do`
-   Main input datasets:
    `intermediate_data/teachers_panel_JPE.dta`
-   Output path:
    `out_synth/tables/Table_B10.log`

#### Table B11: Estimates of Aux 1a Assuming Noisy Measures of `(c1,c2)`

-   Code/status:
    `code/auxiliary_regressions/auxiliary_models_teachers_info.do`
-   Main input datasets:
    `model_data/matched_movers.dta`,
    `model_data/multinomial.dta`,
    `model_data/matched_movers_info0-3.dta`,
    `model_data/multinomial_info0-3.dta`
-   Output path:
    `out_synth/tables/Table_B11.txt`

#### Table B12: OLS of Teacher-District Matches (Aux 1a): Baseline and Excluding Bottom-Tail Matches

-   Code/status:
    `code/auxiliary_regressions/auxiliary_models_teachers_nobottom.do`
-   Main input datasets:
    `model_data/matched_movers.dta`,
    `model_data/matched_movers_nobottom.dta`,
    `model_data/multinomial.dta`,
    `real_data/district_distance_sdid.dta`
-   Output path:
    `out_synth/tables/Table_B12.tex`

#### Table B13: Teachers With One vs Many Offers: Comparison

-   Code/status:
    `code/auxiliary_regressions/auxiliary_models_teachers_richprefs.do`
-   Main input datasets:
    `model_data/matched_movers.dta`,
    `model_data/multinomial.dta`,
    `real_data/district_distance_sdid.dta`
-   Output path:
    `out_synth/tables/Table_B13.tex`

#### Table B14: Parameter Permutation Exercise: Change in Estimates of Auxiliary Models from Parameter Perturbation

-   Code/status:
    `code/descriptives/Table_B14.do`
-   Main input datasets:
    `code/fortran_model/perturbation/result/perturb_aux_full.txt`,
    `code/fortran_model/perturbation/result/weight_mat.txt`
-   Output path:
    `out_synth/tables/Table_B14.csv`

#### Table B15: Allocating Teachers at Will

-   Code/status:
    `code/descriptives/Table_B15.do`
-   Main input datasets:
    `model_data/multinomial.dta`
-   Output path:
    `out_synth/tables/Table_B15.csv`

#### Table B16: State-Funded Teacher Bonuses: Extensive Margin

-   Code/status:
    `code/descriptives/Table_B16.do`
-   Main input datasets:
    `code/fortran_model/5_exitentry/baseline/result`,
    `code/fortran_model/5_exitentry/new1_05/result`,
    `code/fortran_model/5_exitentry/new1_1/result`,
    `code/fortran_model/5_exitentry/new1_15/result`,
    `code/fortran_model/5_exitentry/new2_05/result`,
    `code/fortran_model/5_exitentry/new2_1/result`,
    `code/fortran_model/5_exitentry/new2_15/result`
-   Output path:
    `out_synth/tables/Table_B16.csv`

#### Table B17: State-Funded Teacher Bonuses: Extensive Margin and Repeated Game

-   Code/status:
    `code/descriptives/Table_B17.do`
-   Main input datasets:
    `code/fortran_model/6_forward/forward_baseline/result`,
    `code/fortran_model/6_forward/forward_new1/result`,
    `code/fortran_model/6_forward/forward_new2/result`
-   Period rule: period 6, the terminal period in all three forward scenarios.
-   Output path:
    `out_synth/tables/Table_B17.csv`

#### Table B18: State-Funded Bonuses

-   Code/status:
    `code/descriptives/Table_B18.do`
-   Main input datasets:
    `code/fortran_model/1_baseline/result`,
    `code/fortran_model/3_basicCfs/new1/result`,
    `code/fortran_model/3_basicCfs/new2/result`,
    `code/fortran_model/3_basicCfs/new3/result`,
    `code/fortran_model/3_basicCfs/new4/result`
-   Output path:
    `out_synth/tables/Table_B18.csv`

#### Table B19: Program Effects With Higher Bonus Rates

-   Code/status:
    `code/descriptives/Table_B19.do`
-   Main input datasets:
    `code/fortran_model/1_baseline/result`,
    `code/fortran_model/3_basicCfs/new1/result`,
    `code/fortran_model/7_higherbonus/new1_15/result`,
    `code/fortran_model/7_higherbonus/new1_2/result`,
    `code/fortran_model/7_higherbonus/new1_25/result`
-   Output path:
    `out_synth/tables/Table_B19.csv`

#### Table B20: Program Effects with `R(.) = 0`

-   Code/status:
    `code/descriptives/Table_B20.do`
-   Main input datasets:
    `code/fortran_model/1_baseline/result`,
    `code/fortran_model/8_noRcost/new1/result`,
    `code/fortran_model/8_noRcost/new2/result`,
    `code/fortran_model/8_noRcost/new3/result`,
    `code/fortran_model/8_noRcost/new4/result`
-   Output path:
    `out_synth/tables/Table_B20.csv`

#### Table B21: Teacher and District Characteristics (2010)

-   Code/status:
    `code/descriptives/summary_simulation.do`
-   Main input datasets:
    `simulation_data/experiencecont_pre_NEW.dta`,
    `simulation_data/master_pre_NEW.dta`,
    `simulation_data/contributions_pre_NEW.dta`,
    `simulation_data/lambda_pre_NEW.dta`,
    `simulation_data/urban_pre_NEW.dta`,
    `simulation_data/suburban_pre_NEW.dta`,
    `simulation_data/incumbent_pre_NEW.dta`,
    `simulation_data/budget_NEW.dta`
-   Output path:
    `out_synth/tables/Table_B21A.log`;
    `out_synth/tables/Table_B21B.log`

#### Table B22: Model Fit: Average District Employee Characteristics

-   Code/status:
    `code/descriptives/Table_B22.do`
-   Main input datasets:
    `code/fortran_model/estimation_result/result/other_aux_params.txt`
-   Output path:
    `out_synth/tables/Table_B22.csv`

#### Table B23: Model Fit: OLS of District Wage Schedule

-   Code/status:
    `code/descriptives/Table_B23.do`
-   Main input datasets:
    `code/fortran_model/estimation_result/result/aux_and_omega_params.txt`
-   Output path:
    `out_synth/tables/Table_B23.csv`

#### Table B24: Model Validation: OLS of Teacher-District Match (pre-Act 10)

-   Code/status:
    `code/descriptives/Table_B24.do`
-   Main input datasets:
    `code/fortran_model/validation_result/result/aux_and_omega_params.txt`
-   Output path:
    `out_synth/tables/Table_B24.csv`
-   Synthetic-data note:
    the reduced public data do not identify these validation regressions, so
    the numeric cells are missing in the distributed reference output. This
    is expected for the fictitious data and does not occur in the
    confidential-data estimates reported in the paper.

#### Table B25: Model Validation: Average District Employee Characteristics (pre-Act 10)

-   Code/status:
    `code/descriptives/Table_B25.do`
-   Main input datasets:
    `code/fortran_model/validation_result/result/other_aux_params.txt`
-   Output path:
    `out_synth/tables/Table_B25.csv`

### Online Appendix B Figures

#### Figure B1: Distribution of Teacher Effectiveness

-   Code/status:
    `code/descriptives/appendix_figures.do`
-   Main input datasets:
    `model_data/contributions.dta`
-   Output path:
    `out_synth/figures/Figure_B1.png`

#### Figure B2: Relationship Between `c1` and `c2`

-   Code/status:
    `code/descriptives/appendix_figures.do`
-   Main input datasets:
    `model_data/multinomial.dta`
-   Output path:
    `out_synth/figures/Figure_B2.png`

#### Figure B3: Relationship Between `W_d^0(x_i)` and `w_it^0`

-   Code/status:
    `code/descriptives/appendix_figures.do`
-   Main input datasets:
    `intermediate_data/teachers_panel_JPE.dta`,
    `intermediate_data/indtest_math_split_JPE.dta`,
    `intermediate_data/schedule_new_JPE.dta`
-   Output path:
    `out_synth/figures/Figure_B3.png`

#### Figure B4: Relationship Between Wage Deviations Under Two- and Three-Omega Rules

-   Code/status:
    `code/descriptives/gen_omegas_3omegas.do`
-   Main input datasets:
    `intermediate_data/teachers_panel_JPE.dta`,
    `intermediate_data/schedule_new_JPE.dta`,
    `intermediate_data/indtest_math_split_JPE.dta`,
    `intermediate_data/alphagrid_wages_8groups_JPE.dta`
-   Output path:
    `out_synth/figures/Figure_B4.png`;
    also writes
    `intermediate_data/alphagrid_wages_8groups_3omegas_JPE.dta`

#### Figure B5: Relationship Between Wage Deviations, Untenured Teachers

-   Code/status:
    `code/descriptives/gen_omegas_tenured.do`
-   Main input datasets:
    `intermediate_data/teachers_panel_JPE.dta`,
    `intermediate_data/schedule_new_JPE.dta`,
    `intermediate_data/indtest_math_split_JPE.dta`,
    `intermediate_data/alphagrid_8groups_lambdad_JPE.dta`,
    `intermediate_data/alphagrid_wages_8groups_JPE.dta`
-   Output path:
    `out_synth/figures/Figure_B5.png`;
    also writes
    `intermediate_data/alphagrid_wages_8groups_tenured_JPE.dta`

#### Figure B6: Relationship Between Wage Deviations, No-Experience Teachers

-   Code/status:
    `code/descriptives/gen_omegas_exp1cutoff.do`
-   Main input datasets:
    `intermediate_data/teachers_panel_JPE.dta`,
    `intermediate_data/schedule_new_JPE.dta`,
    `intermediate_data/indtest_math_split_JPE.dta`,
    `intermediate_data/alphagrid_8groups_lambdad_JPE.dta`,
    `intermediate_data/alphagrid_wages_8groups_JPE.dta`
-   Output path:
    `out_synth/figures/Figure_B6.png`;
    also writes
    `intermediate_data/alphagrid_wages_8groups_exp1cutoff_JPE.dta`

#### Figure B7: Share of Teachers Who Switch In and Out of Math Teaching, By Year

-   Code/status:
    `code/descriptives/budget_shifts.do`
-   Main input datasets:
    `intermediate_data/teachers_new_JPE.dta`
-   Output path:
    `out_synth/figures/Figure_B7.png`

#### Figure B8: Share of Districts' Budgets Spent on Teacher Salaries, by Grade and Subject

-   Code/status:
    `code/descriptives/budget_shifts.do`
-   Main input datasets:
    `intermediate_data/teachers_new_JPE.dta`
-   Output path:
    `out_synth/figures/Figure_B8A.png`;
    `out_synth/figures/Figure_B8B.png`;
    `out_synth/figures/Figure_B8C.png`;
    `out_synth/figures/Figure_B8D.png`

#### Figure B9: Identification Illustrated

-   Code/status:
    `code/Figure_B9/Figure_B9.do`;
    helper
    `code/Figure_B9/cutoff_prefs_id_example_graph.R`
    creates the input
-   Main input datasets:
    `code/Figure_B9/cutoffs_id_exercise.dta`
-   Output path:
    `out_synth/figures/Figure_B9_b_02.png`;
    `out_synth/figures/Figure_B9_b_1.png`;
    `out_synth/figures/Figure_B9_b_5.png`

#### Figure B10: Distribution of `lambda` Across Wisconsin Districts

-   Code/status:
    `code/descriptives/lambda_map.do`
-   Main input datasets:
    `real_data/district_shapefiles/WI_School_Districts.*`,
    `intermediate_data/indtest_math_split_JPE.dta`,
    `model_data/lambda.dta`
-   Output path:
    `out_synth/figures/Figure_B10.png`

## Data References

Wisconsin Department of Public Instruction. 2006--2016. Wisconsin
administrative staff, roster, student-demographic, and test-score records
[restricted-use data]. Madison, WI. Data first accessed November 2017 under a
Data User Agreement; WDPI did not assign a formal version or release number.
Access information: "Confidential Data Application."
<https://dpi.wi.gov/wise/data-requests/confidential-data-application>.

Wisconsin Department of Public Instruction. n.d. "Cooperative Educational
Service Agencies." <https://dpi.wi.gov/about-dpi/cesa>. Used by the authors to
construct
`real_data/cesa.dta`.

Wisconsin Department of Public Instruction. 2024. "School Districts,
Wisconsin." Edition 8.0, revised June 26, 2024; valid for the 2024--2025 school
year. Downloaded in 2025 from "GIS Maps."
<https://dpi.wi.gov/wisedash/public/gis-maps>. Provider metadata are included
in
`real_data/district_shapefiles/WI_School_Districts.shp.xml`.

National Center for Education Statistics and U.S. Census Bureau. n.d.
"American Community Survey--Education Tabulation (ACS-ED), 2013--2017:
School-District Profile Tables." U.S. Department of Education, Institute of
Education Sciences. <https://nces.ed.gov/programs/edge/demographic/acsedtables>.
The original download date was not recorded. Provider record layouts and
ReadMe files are included beside each extract under
`real_data/nces_acs_2013-2017/`.

National Center for Education Statistics. n.d. "School District Boundaries."
Education Demographic and Geographic Estimates (EDGE), U.S. Department of
Education, Institute of Education Sciences.
<https://nces.ed.gov/programs/edge/Geographic/DistrictBoundaries>. Used to
prepare
`real_data/crosswalk_census_state_id.csv`;
the exact source vintage was not recorded.

Bergeron, Augustin, Raj Chetty, David Cutler, Benjamin Scuderi, Michael
Stepner, and Nicholas Turner. 2022. "Replication Data for: The Association
Between Income and Life Expectancy in the United States, 2001--2014." Harvard
Dataverse, V1. <https://doi.org/10.7910/DVN/VVW76J>. In particular, the authors
used the dataset's
`cty_cz_st_crosswalk`
county-commuting-zone-state crosswalk to prepare the district and commuting-zone
crosswalks distributed here.

Daily Kos Elections. 2021. "Daily Kos Elections' Statewide Election Results by
Congressional and Legislative Districts." March 23, 2021.
<https://www.dailykos.com/stories/2013/07/09/1220127/-Daily-Kos-Elections-2012-election-results-by-congressional-and-legislative-districts>.
Accessed in 2022.

Daily Kos Elections. n.d. "Daily Kos Elections Statewide Election Results by
Congressional Districts Used from 2012--2020." Google Sheets.
<https://docs.google.com/spreadsheets/d/17yr9mcAtuUdNjI9NEPYKxXsEldzzQ2ZaDwEAbnPRyS4/>.
Accessed in 2022.

Daily Kos Elections. n.d. "Daily Kos Elections Counties--Congressional
District Overlaps (117th Congress)." Google Sheets.
<https://docs.google.com/spreadsheets/d/18adZpIghSQQTZLrUNzEdn78ng7mnk2l4-h6IYPsv34I/>.
Accessed in 2022.

Google LLC. 2022. "Google Maps." <https://www.google.com/maps>. Accessed in
September 2022 and used by the authors to construct
`real_data/district_distance_sdid.dta`.

U.S. Department of Education. 2022. "Performance on Statewide Mathematics
Assessment, School Year 2020--2021: LEA." *ED Data Express Data Library*.
File Specification 175, Data Group 583, as of May 25, 2022.
<https://eddataexpress.ed.gov/download/data-library?page=3>. The original
provider files are distributed under
`data/public/proficiency_data/SY2021_FS175_DG583_LEA_data_files/`.

## Citation and Contact

Paper citation:

Biasi, Barbara, Chao Fu, and John Stromme. "Equilibrium in the Market
for Public School Teachers: District Wage Strategies and Teacher
Comparative Advantage." Journal of Political Economy,
forthcoming/accepted. Final volume,
issue, year, pages, and DOI are TBD.

Replication materials citation:

Biasi, Barbara, Chao Fu, and John Stromme. Replication package for
"Equilibrium in the Market for Public School Teachers: District Wage
Strategies and Teacher Comparative Advantage." JPE/Harvard Dataverse. DOI,
version, and release date are TBD.

Contact for questions:

Barbara Biasi, Yale School of Management and NBER,
[barbara.biasi@yale.edu](mailto:barbara.biasi@yale.edu).

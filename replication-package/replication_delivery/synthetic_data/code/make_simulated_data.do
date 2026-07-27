version 19
clear all
set more off
set seed 20260613
set sortseed 20260613

/*
Public simulated-data generator.

This script regenerates the fake WDPI-style raw inputs distributed in
synthetic_data/raw/. It creates data from scratch and does not read any
confidential WDPI records.

The script can be run either from the repository root:

    do synthetic_data/code/make_simulated_data.do

or from the synthetic_data folder:

    do code/make_simulated_data.do
*/

local pwd "`c(pwd)'"
capture confirm file "`pwd'/synthetic_data/code/02_make_synthetic_data.do"
if !_rc {
    global REPL_ROOT "`pwd'"
    global SYNTH_ROOT "`pwd'/synthetic_data"
}
else {
    capture confirm file "`pwd'/code/02_make_synthetic_data.do"
    if !_rc {
        global SYNTH_ROOT "`pwd'"
        global REPL_ROOT "`pwd'/.."
    }
    else {
        display as error "Run this script from the repository root or from synthetic_data/."
        exit 601
    }
}

global SYN_DIR_1 "$SYNTH_ROOT/raw/staff"
global SYN_DIR_2 "$SYNTH_ROOT/raw/testscores_indlev"
global SYN_CODE "$SYNTH_ROOT/code"
global SYN_DOC "$SYNTH_ROOT/documentation"
global SYN_LOG "$SYNTH_ROOT/logs"

capture mkdir "$SYNTH_ROOT/raw"
capture mkdir "$SYN_DIR_1"
capture mkdir "$SYN_DIR_2"
capture mkdir "$SYNTH_ROOT/raw/teacher_data_linked"
capture mkdir "$SYN_DOC"

do "$SYN_CODE/02_make_synthetic_data.do"
do "$SYN_CODE/03_validate_synthetic_structure.do"

display as text "Public simulated-data generation and validation complete."
display as text "Simulated raw inputs: $SYNTH_ROOT/raw"
display as text "Public manifest:      $SYN_DOC/synthetic_data_manifest.csv"

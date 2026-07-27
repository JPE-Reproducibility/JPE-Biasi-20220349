version 19

/*
Public synthetic/simulated-data globals.

This file can be run either from the repository root or from synthetic_data/.
The preferred public entry point is:

    do synthetic_data/code/make_simulated_data.do
*/

local pwd "`c(pwd)'"
capture confirm file "`pwd'/synthetic_data/code/00_project_globals.do"
if !_rc {
    global REPL_ROOT "`pwd'"
    global SYNTH_ROOT "`pwd'/synthetic_data"
}
else {
    capture confirm file "`pwd'/code/00_project_globals.do"
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
capture mkdir "$SYN_DOC"
capture mkdir "$SYN_LOG"

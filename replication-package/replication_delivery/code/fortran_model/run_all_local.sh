#!/usr/bin/env bash
#
# Portable local compiler/runner/cleaner for the Fortran model scenarios.
# By default it compiles every scenario without
# starting the potentially long model calculations.
#
# Shared sources live in ./common_f90s (next to this script); each scenario
# directory contains only main.f90 (plus its own makefile).
#
# Usage examples:
# ./run_all_local.sh                                # compile all
# ./run_all_local.sh --clean                        # clean build artifacts, everywhere
# ./run_all_local.sh --clean --scenario 3_basicCfs/new1 #clean specific scenario only
# ./run_all_local.sh --run --ranks 4 --scenario 1_baseline # compile and run a specific scenario
# ./run_all_local.sh --run --ranks 4  # compile and run all scenarios

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
common_dir="$script_dir/common_f90s"
mode="compile"
ranks=2
selected_scenario=""

usage() {
  cat <<'EOF'
Usage:
  run_all_local.sh [--compile-only | --run | --clean | --distclean]
                   [--ranks N] [--scenario PATH]

Modes (mutually exclusive; last one wins):
  --compile-only   Compile the selected scenario(s) but do not run them.
                   This is the default.
  --run            Compile and then run the selected scenario(s) with MPI.
  --clean          Remove build artefacts (*.mod *.o *.log *.out run_main)
                   from the selected scenario(s). Equivalent to running
                   `make clean` in each scenario directory. Leaves result/
                   untouched. Does not require a compiler to be installed.
  --distclean      Like --clean, but also removes each scenario's result/
                   directory. Destroys run output; use with care.

Options:
  --ranks N        Use N MPI ranks when --run is selected (default: 2).
  --scenario PATH  Limit work to one scenario path relative to this script,
                   for example 1_baseline or 3_basicCfs/new1.
  -h, --help       Show this help.

Environment overrides:
  MPIFORT             MPI Fortran compiler command (default: mpifort)
  MPIEXEC             MPI launcher command (default: mpiexec)
  FORTRAN_FLAGS       Replacement compile flags
  FORTRAN_LINK_FLAGS  Replacement BLAS/LAPACK linker flags
EOF
}

# ---- argument parsing --------------------------------------------
while [[ $# -gt 0 ]]; do
  case "$1" in
    --compile-only) mode="compile";   shift ;;
    --run)          mode="run";       shift ;;
    --clean)        mode="clean";     shift ;;
    --distclean)    mode="distclean"; shift ;;
    --ranks)
      [[ $# -ge 2 ]] || { echo "Missing value after --ranks." >&2; exit 2; }
      ranks="$2"; shift 2 ;;
    --scenario)
      [[ $# -ge 2 ]] || { echo "Missing value after --scenario." >&2; exit 2; }
      selected_scenario="${2%/}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
done

if ! [[ "$ranks" =~ ^[1-9][0-9]*$ ]]; then
  echo "--ranks must be a positive integer." >&2
  exit 2
fi

is_build_mode=0
[[ "$mode" == "compile" || "$mode" == "run" ]] && is_build_mode=1

# ---- toolchain checks (build modes only) -------------------------
compiler="${MPIFORT:-mpifort}"
mpi_runner="${MPIEXEC:-mpiexec}"

if [[ "$is_build_mode" -eq 1 ]]; then
  command -v "$compiler" >/dev/null 2>&1 || {
    echo "MPI Fortran compiler not found: $compiler" >&2; exit 127; }

  if [[ "$mode" == "run" ]]; then
    command -v "$mpi_runner" >/dev/null 2>&1 || {
      echo "MPI launcher not found: $mpi_runner" >&2; exit 127; }
  fi

  [[ -d "$common_dir" ]] || {
    echo "Shared source directory not found: $common_dir" >&2; exit 1; }
fi

# ---- flags -------------------------------------------------------
# -J. -I. : write/read .mod files in the scenario (build) directory,
# matching MODFLAGS in the per-scenario makefiles.
mod_flags=(-J. -I.)

if [[ -n "${FORTRAN_FLAGS:-}" ]]; then
  read -r -a compile_flags <<< "$FORTRAN_FLAGS"
elif [[ "$(uname -s)" == "Darwin" ]]; then
  compile_flags=(-O3 -fcheck=all -fbacktrace)
else
  compile_flags=(-O3 -fcheck=all -fbacktrace -mcmodel=medium)
fi

if [[ -n "${FORTRAN_LINK_FLAGS:-}" ]]; then
  read -r -a link_flags <<< "$FORTRAN_LINK_FLAGS"
elif [[ "$(uname -s)" == "Darwin" ]]; then
  link_flags=(-L/opt/homebrew/opt/openblas/lib -lopenblas)
else
  link_flags=(-L/usr/lib64/ -lblas -llapack)
fi

# ---- shared sources ----------------------------------------------
# Compile order matters. "SUBTYPE/" marks files that live in the
# entry / non_entry subdirectory of common_f90s.
common_sources=(
  nrutil.f90
  simplex_salvador.f90
  simplex_salvador_inner.f90
  simplex_salvador_equilibrium.f90
  simplex_salvador_equilibrium_w.f90
  random.f90
  qsort_mod.f90
  SUBTYPE/global_variables.f90
  timer.f90
  statistical_models.f90
  aux_model.f90
  SUBTYPE/read_data_params.f90
  knapsack_problem.f90
  SUBTYPE/utility_functions.f90
  SUBTYPE/belief_functions.f90
  SUBTYPE/inner_loop_one.f90
  write_moments.f90
  SUBTYPE/objective.f90
)

scenarios=(
  1_baseline
  2_rigid
  3_basicCfs/new1
  3_basicCfs/new2
  3_basicCfs/new3
  3_basicCfs/new4
  4_nomovecost/case1
  4_nomovecost/case2
  4_nomovecost/case2_new2
  5_exitentry/baseline
  5_exitentry/new1_05
  5_exitentry/new1_1
  5_exitentry/new1_15
  5_exitentry/new2_05
  5_exitentry/new2_1
  5_exitentry/new2_15
  6_forward/forward_baseline
  6_forward/forward_new1
  6_forward/forward_new2
  7_higherbonus/new1_15
  7_higherbonus/new1_2
  7_higherbonus/new1_25
  8_noRcost/new1
  8_noRcost/new2
  8_noRcost/new3
  8_noRcost/new4
  estimation_result
  perturbation
  stderr
  validation_result
)

subtype_for() {
  case "$1" in
    5_*|6_*) echo "entry" ;;
    *)       echo "non_entry" ;;
  esac
}

# ---- main loop ---------------------------------------------------
matched=0
for scenario in "${scenarios[@]}"; do
  if [[ -n "$selected_scenario" && "$scenario" != "$selected_scenario" ]]; then
    continue
  fi

  matched=$((matched + 1))
  scenario_dir="$script_dir/$scenario"

  # Cleaning a directory that does not exist is a no-op, not an error.
  if [[ "$mode" == "clean" || "$mode" == "distclean" ]]; then
    if [[ ! -d "$scenario_dir" ]]; then
      echo "Skipping $scenario (directory not present)"
      continue
    fi
    echo "Cleaning $scenario"
    (
      cd "$scenario_dir"
      rm -f ./*.mod ./*.o ./*.log ./*.out run_main
      if [[ "$mode" == "distclean" ]]; then
        rm -rf result
      fi
    )
    continue
  fi

  [[ -d "$scenario_dir" ]] || {
    echo "Scenario directory not found: $scenario_dir" >&2; exit 1; }
  [[ -f "$scenario_dir/main.f90" ]] || {
    echo "main.f90 not found in: $scenario_dir" >&2; exit 1; }

  subtype="$(subtype_for "$scenario")"

  # Expand the shared source list into absolute paths for this subtype.
  sources=()
  for src in "${common_sources[@]}"; do
    path="$common_dir/${src/SUBTYPE\//$subtype/}"
    [[ -f "$path" ]] || { echo "Source file not found: $path" >&2; exit 1; }
    sources+=("$path")
  done
  sources+=("$scenario_dir/main.f90")

  echo "Compiling $scenario (subtype: $subtype)"
  (
    cd "$scenario_dir"
    "$compiler" "${compile_flags[@]}" "${mod_flags[@]}" "${sources[@]}" \
      -o run_main "${link_flags[@]}"

    if [[ "$mode" == "run" ]]; then
      mkdir -p result
      echo "Running $scenario with $ranks MPI rank(s)"
      GFORTRAN_UNBUFFERED_PRECONNECTED=1 \
        "$mpi_runner" -n "$ranks" ./run_main > result/run_main.log 2>&1
    fi
  )
done

if [[ "$matched" -eq 0 ]]; then
  echo "Unknown scenario: $selected_scenario" >&2
  exit 2
fi

echo "Completed $mode step for $matched scenario(s)."

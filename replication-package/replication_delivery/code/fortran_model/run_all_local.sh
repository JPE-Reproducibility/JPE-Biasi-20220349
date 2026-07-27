#!/usr/bin/env bash
#
# Portable local compiler/runner for the 31 Fortran model scenarios.
# Run this script from any directory. By default it compiles every scenario
# without starting the potentially long model calculations.

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mode="compile"
ranks=2
selected_scenario=""

usage() {
  cat <<'EOF'
Usage:
  run_all_local.sh [--compile-only] [--run] [--ranks N] [--scenario PATH]

Options:
  --compile-only   Compile the selected scenario(s) but do not run them.
                   This is the default.
  --run            Compile and then run the selected scenario(s) with MPI.
  --ranks N        Use N MPI ranks when --run is selected (default: 2).
  --scenario PATH  Limit work to one path relative to code/fortran_model,
                   for example 1_baseline or 3_basicCfs/new1.
  -h, --help       Show this help.

Environment overrides:
  MPIFORT             MPI Fortran compiler command (default: mpifort)
  MPIEXEC             MPI launcher command (default: mpiexec)
  FORTRAN_LINK_FLAGS  Replacement BLAS/LAPACK linker flags
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --compile-only)
      mode="compile"
      shift
      ;;
    --run)
      mode="run"
      shift
      ;;
    --ranks)
      [[ $# -ge 2 ]] || { echo "Missing value after --ranks." >&2; exit 2; }
      ranks="$2"
      shift 2
      ;;
    --scenario)
      [[ $# -ge 2 ]] || { echo "Missing value after --scenario." >&2; exit 2; }
      selected_scenario="${2%/}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if ! [[ "$ranks" =~ ^[1-9][0-9]*$ ]]; then
  echo "--ranks must be a positive integer." >&2
  exit 2
fi

compiler="${MPIFORT:-mpifort}"
mpi_runner="${MPIEXEC:-mpiexec}"

command -v "$compiler" >/dev/null 2>&1 || {
  echo "MPI Fortran compiler not found: $compiler" >&2
  exit 127
}

if [[ "$mode" == "run" ]]; then
  command -v "$mpi_runner" >/dev/null 2>&1 || {
    echo "MPI launcher not found: $mpi_runner" >&2
    exit 127
  }
fi

compile_flags=(-O3 -fcheck=all -fbacktrace)

if [[ -n "${FORTRAN_LINK_FLAGS:-}" ]]; then
  read -r -a link_flags <<< "$FORTRAN_LINK_FLAGS"
elif [[ "$(uname -s)" == "Darwin" ]]; then
  link_flags=(-framework Accelerate)
else
  link_flags=(-lblas -llapack)
fi

sources=(
  nrutil.f90
  simplex_salvador.f90
  simplex_salvador_inner.f90
  simplex_salvador_equilibrium.f90
  simplex_salvador_equilibrium_w.f90
  random.f90
  qsort_mod.f90
  global_variables.f90
  timer.f90
  statistical_models.f90
  aux_model.f90
  read_data_params.f90
  knapsack_problem.f90
  utility_functions.f90
  belief_functions.f90
  inner_loop_one.f90
  write_moments.f90
  objective.f90
  main.f90
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
  4_nomovecost/case_baseline
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

matched=0
for scenario in "${scenarios[@]}"; do
  if [[ -n "$selected_scenario" && "$scenario" != "$selected_scenario" ]]; then
    continue
  fi

  matched=$((matched + 1))
  scenario_dir="$script_dir/$scenario"
  [[ -d "$scenario_dir" ]] || {
    echo "Scenario directory not found: $scenario_dir" >&2
    exit 1
  }

  echo "Compiling $scenario"
  (
    cd "$scenario_dir"
    "$compiler" "${compile_flags[@]}" "${sources[@]}" \
      -o run_main "${link_flags[@]}"

    if [[ "$mode" == "run" ]]; then
      mkdir -p result
      echo "Running $scenario with $ranks MPI rank(s)"
      "$mpi_runner" -n "$ranks" ./run_main > result/run_main.log 2>&1
    fi
  )
done

if [[ "$matched" -eq 0 ]]; then
  echo "Unknown scenario: $selected_scenario" >&2
  exit 2
fi

echo "Completed $mode step for $matched scenario(s)."

# makefile to run fortran
# Needs lapack and blas libraries (see LDFLAGS)
# Also needs gcc mpifort compiler

# ---- directories -------------------------------------------------
COMMON = ../../common_f90s
SUBTYPE = non_entry

# -J. -I. : write/read .mod files in the LOCAL build directory
MODFLAGS = -J. -I.

# ---- sources -----------------------------------------------------
modules = $(COMMON)/nrutil.f90 \
          $(COMMON)/simplex_salvador.f90 \
          $(COMMON)/simplex_salvador_inner.f90 \
          $(COMMON)/simplex_salvador_equilibrium.f90 \
          $(COMMON)/simplex_salvador_equilibrium_w.f90 \
          $(COMMON)/random.f90   \
          $(COMMON)/qsort_mod.f90 \
          $(COMMON)/$(SUBTYPE)/global_variables.f90 \
          $(COMMON)/timer.f90    \
          $(COMMON)/statistical_models.f90 \
          $(COMMON)/aux_model.f90 \
          $(COMMON)/$(SUBTYPE)/read_data_params.f90 \
          $(COMMON)/knapsack_problem.f90 \
          $(COMMON)/$(SUBTYPE)/utility_functions.f90 \
          $(COMMON)/$(SUBTYPE)/belief_functions.f90 \
          $(COMMON)/$(SUBTYPE)/inner_loop_one.f90 \
          $(COMMON)/write_moments.f90 \
          $(COMMON)/$(SUBTYPE)/objective.f90


FFLAGS  = -O3 -fcheck=all -fbacktrace -mcmodel=medium
LDFLAGS = -L/usr/lib64/ -lblas -llapack

FFLAGS_APPLE  = -O3 -fcheck=all -fbacktrace 
LDFLAGS_APPLE = -L/opt/homebrew/opt/openblas/lib -lopenblas

# ---- targets -----------------------------------------------------
clean:
	rm -f *.mod *.o *.log *.out run_main

compile_mpi_slurm:
	mpifort $(FFLAGS) $(MODFLAGS) $(modules) main.f90 -o run_main $(LDFLAGS)

# slurm also needs a batchfile setup
run_mpi_slurm: compile_mpi_slurm
	sbatch run_main.batch

# Running on apple silicon
compile_mpi_apple:
	mpifort $(FFLAGS_APPLE) $(MODFLAGS) $(modules) main.f90 -o run_main $(LDFLAGS_APPLE)

run_mpi_apple: compile_mpi_apple
	set -o pipefail; GFORTRAN_UNBUFFERED_PRECONNECTED=1 \
	  mpirun -np 4 ./run_main 2>&1 | tee result/run_main.log

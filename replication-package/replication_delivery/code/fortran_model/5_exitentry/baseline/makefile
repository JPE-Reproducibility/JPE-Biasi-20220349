# makefile to run fortran
# Needs lapack and blas libraries, as well as mpifort compiler
#
#
modules = nrutil.f90   \
          simplex_salvador.f90 \
          simplex_salvador_inner.f90 \
          simplex_salvador_equilibrium.f90 \
			 simplex_salvador_equilibrium_w.f90 \
          random.f90   \
          qsort_mod.f90 \
          global_variables.f90 \
          timer.f90    \
          statistical_models.f90 \
          aux_model.f90 \
          read_data_params.f90 \
          knapsack_problem.f90 \
          utility_functions.f90 \
          belief_functions.f90 \
          inner_loop_one.f90 \
			 write_moments.f90 \
          objective.f90

clean:
	rm -f *.mod *.log *.out

# slurm also needs a batchfile setup
compile_mpi_slurm:
	mpifort -O3 -fcheck=all -fbacktrace -mcmodel=medium ${modules} main.f90 -o run_main -L/usr/lib64/ -lblas -llapack

run_mpi_slurm: compile_mpi_slurm
	sbatch run_main.batch


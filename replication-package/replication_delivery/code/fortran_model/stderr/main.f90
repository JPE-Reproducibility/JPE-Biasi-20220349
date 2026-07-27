! main.f90
! created: Oct 2018
!
! Main run file for estimation
!  also contains calc_wstat
!
program main
  ! subprogram modules
  use global_variables     
  use read_data_params   !read from txt files
  use inner_loop_one
  use aux_model
  use utility_functions
  use objective
  ! helper modules
  !use simplex
  use simplex_salvador
  use mpi
  use random

  use timer

  implicit none

  integer :: i, j, k, a1, a2, slave_flag
  double precision :: tval  !param0 is structural parameters, _big adds in the belief params
  double precision, allocatable, dimension(:) :: param0, param0_big
  ! standard err variables
  integer :: jj, nauxparams, ridx, ntparam, ndparam, sigmaind
  double precision :: r_se, perturb_min
  double precision, allocatable, dimension(:) :: initial_param_se, param_se, r_se_list, perturb_min_list
  double precision, allocatable, dimension(:,:) :: W_se, G_se, parammat, auxmat, bigOmega, outer, inner, var, semat
  !double precision, allocatable, dimension(:,:) :: Gt_se, outert, innert, vart, sematt
  !double precision, allocatable, dimension(:,:) :: Gd_se, outerd, innerd, vard, sematd
  !double precision, allocatable, dimension(:,:) :: G2_se, outer2, inner2, var2, semat2
  double precision, allocatable, dimension(:,:) :: wmat, twmat


  !use if we want to time anything for benchmarking
  call initialize_timer()

  ! Set up MPI
  call mpi_init(ierr)
  call mpi_comm_size(mpi_comm_world, ntasks, ierr) !get number of tasks
  call mpi_comm_rank(mpi_comm_world, mpi_id, ierr) !get id of each task
  write(*,*) 'process ', mpi_id+1, 'of ', ntasks, 'is alive,', ' mpi_id:',mpi_id

  call mpi_barrier(mpi_comm_world, ierr)

  call read_instructions()

  ! read the teacher/district data, needed in all threads so just reading in instead of mpi
  if (validation == 0) then
     call read_data() 
  else
     !validation == 1
     call read_data_pre()
  end if

  !compute the wage statistic for each teacher (i.d. x,v pair)
  call calc_wstat()

  !set seeds
  call set_seed(1,2,3,4)

  !draw shocks
  if (purpose >= 10) then
     ! tshock and dshock, nEconomy
     allocate(dshock(nEconomy,ndist,NWgrid1,NWgrid2))
     allocate(tshock(nEconomy,nteach,ndist))
     do k=1, nEconomy
        !dshock
        do j=1, ndist
           do a1=1,NWgrid1
              do a2=1,NWgrid2
                 dshock(k,j,a1,a2) = Sample_EV1()
              end do
           end do
        end do
        !tshock
        do j=1, ndist
           do i=1, nteach
              tshock(k,i,j) = Sample_EV1()
           enddo
        end do
     end do
     !allocate global sim_omega
     allocate(sim_omegas(nEconomy,2,ndist))
  else
     !tshock only, ncopyt
     allocate(tshock(nCopyT,nteach,ndist))
     do j=1, ndist
        do i=1, nteach
           do k=1, nCopyT
              tshock(k,i,j) = Sample_EV1()
           enddo
        end do
     enddo
  end if

  if (mpi_id == 0) then

     !set budget and capacity constraint vectors
     B(1,:) = sum(match * wage, dim = 1)
     T(1,:) = sum(match, dim = 1)

     !read in data from txt files
     call read_theta() !read in beliefs
     call read_auxiliary_params()
     call read_model_params(param0)
     call read_weight_matrixes()
     

     if (purpose == 5) then
        ! estimate, but outer loop has stuct AND belief param
        allocate(param0_big(size(param0) + ntheta))
        param0_big(1:size(param0)) = param0
        param0_big(size(param0)+1:size(param0) + ntheta) = theta

        ! run outer loop - search over parameters
        ! (x,ftol,func,print,itmax,dtol,simplex_length)
        nround = 0 !keep track of number of function calls
        open(22,file='gmmrecord.txt',status='replace')
        close(22)
        !call Nelder_Mead(param0_big, outer_tol_pct, objective_function, 0, maxiter, outer_tol_dif, simplex_length)
        call nelder_meade(param0_big,outer_tol_pct,objective_function,0,maxiter,simplex_length)

        param0 = param0_big(1:size(param0))
        theta  = param0_big(size(param0)+1:size(param0_big)) 

        write(*,*) 'finished outer loop'

     else if (purpose==2 .or. purpose==4) then
        !running outer loop
        ! (x,ftol,func,print,itmax,dtol,simplex_length)
        nround = 0 !keep track of number of function calls
        open(22,file='gmmrecord.txt',status='replace')
        close(22)
        !call Nelder_Mead(param0, outer_tol_pct, objective_function, 1, maxiter, outer_tol_dif, simplex_length)
        call nelder_meade(param0,outer_tol_pct,objective_function,0,maxiter,simplex_length)

     else if (purpose == -1) then !calculating standard error
        ! need to loop over all parameters and save betas, then we can compute numerical derivatives
        !    take care also to adjust the transformed params

        ! List of 'r' values for SE, r here being perturbation
        !allocate(r_se_list(6))
        !r_se_list = (/ 0.04, 0.05, 0.06, 0.07, 0.08, 0.09/) !/ 0.002, 0.005, 0.01, 0.05, 0.1, 0.15/
       ! r_se_list = r_se_list * (-1) 
        !allocate(perturb_min_list(6))
        allocate(r_se_list(1))
        r_se_list = (/0.07/)
        allocate(perturb_min_list(1))
        perturb_min_list = 0.01

        !allocate(r_se_list(2))
        !allocate(perturb_min_list(2))
        !r_se_list = (/ 0.0, 0.0 /)
        !perturb_min_list = 0

        print*, 'running se perturbations'
        print*, 'r:   ', r_se_list
        print*, 'mins:', perturb_min_list

        allocate(initial_param_se(nparam), param_se(nparam))
        allocate(parammat(nparam,sum(incl)+1))
        allocate(auxmat(naux+naux_omega+naux_other,sum(incl)+1))

        allocate(semat(sum(incl),size(r_se_list)+1))
        !allocate(semat2(sum(incl)-1,size(r_se_list)+1))

        !also now need to find dimensions to allocate teacher and district subsets
        !teachers
        !ntparam = 0
        !do i=1, nalpha
        !   if (incl(i) == 1) ntparam = ntparam + 1
        !end do
        !!also need teacher sigma term
        !if(incl(nalpha+nbeta+1) == 1) ntparam = ntparam + 1
        !
        !allocate(sematt(ntparam,size(r_se_list)+1))

        !districts
        !ndparam = 0
        !do i=nalpha+1, nparam
        !   !everything else, being sure to remove teacher sigma term
        !   if( i .ne. nalpha+nbeta+1) then
        !      if (incl(i) == 1) ndparam = ndparam + 1
        !   else
        !      !save index of the teacher sigma term in incl terms so we can use later
        !      sigmaind = ntparam-1 + ndparam+1
        !   end if
        !end do
        !
        !allocate(sematd(ndparam,size(r_se_list)+1))




        !first call to double check baseline and so we know beta_hat(theta)
        !  (note initial_param has params, param0 right now just takes out scaling)
        ! (note this is important to run first, because we skip
        !   first inner loop iteration so we maintain same belief params as well)
        tval = objective_function(param0)
        auxmat(1:naux,1:1) = aux_beta_model
        auxmat(naux+1:naux+naux_omega,1:1) = aux_omega_model
        auxmat(naux+naux_omega+1:naux+naux_omega+naux_other,1:1) = aux_other_model

        !get vector of ``paper'' model params, i.e. the ones we will perturb
        initial_param_se = initial_param
        !alpha params 
        initial_param_se(5)  = exp(initial_param_se(5))  !c1 * lambda
        initial_param_se(12) = exp(initial_param_se(12)) !logdist move cost
        initial_param_se(13) = exp(initial_param_se(13)) !cz move cost
        !  (experience params for moving costs stack and are exp)
        initial_param_se(6) = 0 !first exp factor is omitted (entrants)
        do i=7,11
           initial_param_se(i) = exp(initial_param_se(i)) + initial_param_se(i-1)
        end do
        !beta params
        initial_param_se(nalpha+7) = exp(initial_param_se(nalpha+7)) !c1 * lambda      
        initial_param_se(nalpha+8) = exp(initial_param_se(nalpha+8)) !master           
        !  (beta exp params stack)
        initial_param_se(nalpha+1) = 0 !first exp factor is omitted (entrants)
        do i=nalpha+2,nalpha+6 !beta 2 through 7
           initial_param_se(i) = exp(initial_param_se(i)) + initial_param_se(i-1)
        end do
        !sigma and sigmaD
        initial_param_se(nalpha+nbeta+1) = exp(initial_param_se(nalpha+nbeta+1))
        initial_param_se(nalpha+nbeta+1+ngamma+1) = exp(initial_param_se(nalpha+nbeta+1+ngamma+1))


        parammat(:,1) = initial_param_se
        !parammat(:,1) = initial_param

        ! First column of output is our paramater values for easy reference to gauge significance
        j=1
        do i=1, nparam
           if (incl(i) == 1) then
              semat(j,1) = initial_param_se(i)
              j = j+1
           end if
        end do

        !no master subset
        !semat2(1:14,1) = semat(1:14,1)
        !semat2(15:19,1) = semat(16:20,1)

        !district and teacher subsets
        !sematt(1:ntparam-1,1) = semat(1:ntparam-1,1)
        !sematt(ntparam,1) = semat(sigmaind,1)

        !sematd(1:(sigmaind-ntparam),1) = semat(ntparam:(sigmaind-1),1)
        !sematd((sigmaind-ntparam+1):ndparam,1) = semat(sigmaind+1:sum(incl),1)

        ! loop over each perturbation amount. Within each perturbation:
        !      loop pover each parameter, perturb, transform params into model-speak,
        !       sim model and calc aux model, save aux model values
        do ridx = 1, size(r_se_list)
           !option to have varying min perturb across our r tries
           perturb_min = perturb_min_list(ridx)
           r_se = r_se_list(ridx)
           print*, 'r_se=',r_se
           print*, 'perturb min=', perturb_min
           !loop over main params
           k=1
           do i=1, nparam
              if( incl(i) .eq. 1) then
                 param_se = initial_param_se
                 !perturb
                 print*, 'param perturbation'
                 if ((r_se > 0 .and. i == 10) .or. (r_se < 0 .and. i == 11)) then
                    !exp5 and exp6 parameters are close together for alphas, so we always need
                    !   to negative perturb 5 and positive perturb 6
                 !   param_se(i) = param_se(i) - sign(max(abs(param_se(i) * r_se), perturb_min), r_se)
                     param_se(i) = param_se(i) - sign(max(abs(param_se(i) * step(i) * r_se), perturb_min), r_se)
                else
                    !param_se(i) = param_se(i) + sign(max(abs(param_se(i) * r_se), perturb_min), r_se)
                    param_se(i) = param_se(i) + sign(max(abs(param_se(i) * step(i) * r_se), perturb_min), r_se)                
				end if
                  !respect bounds for exp parameters in district utility
                 if (r_se > 0 .and. (i >= nalpha+1 .and. i <= nalpha+5)) then
                     if (param_se(i) > param_se(i+1)) param_se(i) = (initial_param_se(i+1)+initial_param_se(i))*0.5 
				else if (r_se < 0 .and. (i >= nalpha+2 .and. i <= nalpha+6)) then
					if (param_se(i) < param_se(i-1)) param_se(i) = max(0.001,(initial_param_se(i-1)+initial_param_se(i))*0.5)
                 end if
				 if (i==nalpha+8 .and. param_se(i)<0) param_se(i)=initial_param_se(i)*0.5
				 
                 ! negative perturbation instead of positive
                 ! param_se(i) = param_se(i) - max(abs(param_se(i) * r_se), perturb_min)
                 !if (i >= nalpha+2 .and. i <= nalpha+6) then
                 !   if (param_se(i) <= param_se(i-1)) param_se(i) = param_se(i-1) + 0.000001
                 !end if

                 !start by checking/checking "model" param, (i.e. nontransform)
                 parammat(:,k+1) = param_se

                 !transform... some of this redundant but easier to code together
                 !alpha params
                 param_se(5) = log(param_se(5))
                 param_se(12) = log(param_se(12))
                 param_se(13) = log(param_se(13))
                 !   and the exp for moving cost
                 do j = 11, 7, -1
                    param_se(j) = log(param_se(j) - param_se(j-1))
                 end do
                 param_se(6)  = 0 !redundant, but restating entrants are omitted
                 !beta params
                 param_se(nalpha+7) = log(param_se(nalpha+7)) !c1 * lambda
                 param_se(nalpha+8) = log(param_se(nalpha+8)) !master           
                 !  (beta exp params stack)
                 do j=nalpha+6,nalpha+2,-1
                    param_se(j) = log(param_se(j) - param_se(j-1))
                 end do
                 param_se(nalpha+1) = 0 !redundant, but restating entrants are omitted
                 !sigma and sigmaD
                 param_se(nalpha+nbeta+1)        = log(param_se(nalpha+nbeta+1))
                 param_se(nalpha+nbeta+1+ngamma+1) = log(param_se(nalpha+nbeta+1+ngamma+1))

                 ! And weirdness we have to do b/c.... avoid nan and how params reconstructed
                 if (param_se(nalpha+1) == 0) param_se(nalpha+1) = -50.175662699999997

                 !temp save what transformed params we're running for a bug check
                 !parammat(:,k+1) = param_se

                 !find aux values
                 initial_param = param_se
                 tval = objective_function(param0)
                 !save aux params in our matrix
                 auxmat(1:naux,k+1:k+1) = aux_beta_model
                 auxmat(naux+1:naux+naux_omega,k+1:k+1) = aux_omega_model
                 auxmat(naux+naux_omega+1:naux+naux_omega+naux_other,k+1:k+1) = aux_other_model

                 !save matrix of param values for bug checking
                 !parammat(:,k+1) = initial_param_se
                 k = k + 1
              end if
              
           end do

           ! For the first perturbation, some output to double check stuff is working
           if (ridx == 1) then
              !save parammat to check perturbations
              open(1, file='result/perturb_param.txt', status = 'replace')
              do i=1, nparam
                 write(1,*) (parammat(i,j),j=1,sum(incl)+1)
              end do
              close(1)
              ! save resulting aux model values perturbations, only for those that get weight
              open(1, file='result/perturb_aux.txt', status = 'replace')
              do i=1, naux
                 if (weight_mat(i,i) > 0) write(1,*) (auxmat(i,k),k=1,sum(incl)+1)
              end do
              do i=1, naux_omega
                 if (omega_weight_mat(i,i) > 0) write(1,*) (auxmat(i + naux,k),k=1,sum(incl)+1)
              end do
              do i=1, naux_other
                 if (other_weight_mat(i,i) > 0) write(1,*) (auxmat(i + naux + naux_omega,k),k=1,sum(incl)+1)
              end do
              close(1)
              ! save aux model values perturbations for every moment, regardless of if get weight
              open(1, file='result/perturb_aux_full.txt', status = 'replace')
              do i=1, naux+naux_omega+naux_other
                 write(1,*) (auxmat(i,j),j=1,sum(incl)+1)
              end do
              close(1)
           end if

           !calculate std errors
           ! first need to remove the weight zero items from our vector and W matrix
           ! sum W==0 and then allocate new matrices
           nauxparams = 0
           do i=1, naux
              if (weight_mat(i,i) > 0) nauxparams = nauxparams + 1
           end do
           do i=1, naux_omega
              if (omega_weight_mat(i,i) > 0) nauxparams = nauxparams + 1
           end do
           do i=1, naux_other
              if (other_weight_mat(i,i) > 0) nauxparams = nauxparams + 1
           end do
           print*, 'n aux params:', nauxparams
           !allocate with correct size, removing weight zero aux params, and incl=0 params
           allocate(W_se(nauxparams,nauxparams), G_se(nauxparams,sum(incl)), bigOmega(nauxparams,nauxparams))
           allocate(outer(sum(incl),sum(incl)), inner(sum(incl),sum(incl)))
           allocate(var(sum(incl),sum(incl)))
           W_se = 0 !(naux x naux)
           G_se = 0 !(naux x nparam (included))
           bigOmega = 0 !(naux x naux)
           !j keeps track of full matrix index, jj full param index
           j=1
           do i=1, naux
              if (weight_mat(i,i) > 0) then
                 W_se(j,j) = weight_mat(i,i)
                 !numerical derivs for G
                 jj = 1
                 do k=1, nparam
                    if ( incl(k) .eq. 1) then
                       G_se(j,jj) = (auxmat(i,jj+1) - auxmat(i,1)) / (parammat(k,jj+1) - initial_param_se(k))
  					   jj = jj + 1
                    end if
                 end do
                 ! diagonal of bigOmega is variance of aux est
                 bigOmega(j,j) = auxvar(i)
                 j = j + 1
              end if
           end do
           do i=1, naux_omega
              if (omega_weight_mat(i,i) > 0) then
                 W_se(j,j) = omega_weight_mat(i,i)
                 !numerical derivs for G
                 jj = 1
                 do k=1, nparam
                    if ( incl(k) .eq. 1) then
						G_se(j,jj) = (auxmat(naux+i,jj+1) - auxmat(naux+i,1)) / (parammat(k,jj+1) - initial_param_se(k))
                      jj = jj + 1
                    end if
                 end do
                 ! diagonal of bigOmega is variance of aux est
                 bigOmega(j,j) = aux_omegavar(i)
                 j = j + 1
              end if
           end do
           do i=1, naux_other
              if (other_weight_mat(i,i) > 0) then
                 W_se(j,j) = other_weight_mat(i,i)
                 !numerical derivs for G
                 jj = 1
                 do k=1, nparam
                    if ( incl(k) .eq. 1) then
                       G_se(j,jj) = (auxmat(naux+i,jj+1) - auxmat(naux+i,1)) / (parammat(k,jj+1) - initial_param_se(k))
                        jj = jj + 1
                    end if
                 end do
                 ! diagonal of bigOmega is variance of aux est
                 bigOmega(j,j) = aux_othervar(i)
                 j = j + 1
              end if
           end do

           ! Trying block diagonal for big Omega (partly "hardcoded", b/c W_se could change b/c of what has incl==1)
           !  if we do this, read in var-cov matrices and replace in our weight matrix
           !! small ols
           !open(1, file=trim(filepath)//'/model_data/betaT1_varcov_ols.csv', status = 'old')
           !! note to self, with FE, stata still puts "intercept" as final parameter so we need to exclude last row/column
           !allocate(twmat(nalpha+2,nalpha+2),wmat(nalpha+1,nalpha+1))
           !read(1,*) twmat
           !twmat = transpose(twmat)
           !wmat = twmat(1:nalpha+1, 1:nalpha+1)
           !close(1)
           !bigOmega(1:nalpha+1, 1:nalpha+1) = wmat
           !! big ols
           !open(1, file=trim(filepath)//'/model_data/betaT2_varcov_ols.csv', status = 'old')
           !read(1,*) twmat
           !twmat = transpose(twmat)
           !wmat = twmat(1:nalpha+1, 1:nalpha+1)
           !close(1)
           !bigOmega(nalpha+2:nalpha+2+nalpha,nalpha+2:nalpha+2+nalpha) = wmat
           !deallocate(twmat, wmat)
           !! omega1
           !allocate(twmat(16,16), wmat(16, 16))
           !open(1, file=trim(filepath)//'/model_data/wage_aux_alpha1_varcov.csv', status = 'old')
           !read(1,*) twmat
           !wmat = transpose(twmat)
           !close(1)
           !bigOmega(2*(nalpha+1)+1:2*(nalpha+1)+16, 2*(nalpha+1)+1:2*(nalpha+1)+16) = wmat
           !! omega2
           !open(1, file=trim(filepath)//'/model_data/wage_aux_alpha2_varcov.csv', status = 'old')
           !read(1,*) twmat
           !wmat = transpose(twmat)
           !close(1)
           !bigOmega(2*(nalpha+1)+16+1:2*(nalpha+1)+16+16, 2*(nalpha+1)+16+1:2*(nalpha+1)+16+16) = wmat
           !deallocate(twmat, wmat)

           ! then we can compute se
           ! outer = inv(G'WG)
           outer = inv_se(matmul(matmul(transpose(G_se),W_se),G_se))
           ! inner = G'W diag(var) WG
           inner = matmul(matmul(matmul(transpose(G_se),W_se),bigOmega), matmul(W_se,G_se))
           ! V = outer inner outer
           var = matmul(matmul(outer,inner),outer)

           do i=1, sum(incl)
              semat(i,ridx+1) = sqrt(var(i,i))
           end do

           !write out matrix components so we can see what the hell is going on...
           open(1, file='result/G.txt', status = 'replace')
           open(2, file='result/W.txt', status = 'replace')
           open(3, file='result/bigOmega.txt', status = 'replace')
           do i=1, nauxparams
              write(1,*) (G_se(i,j), j=1,sum(incl))
              write(2,*) (W_se(i,j), j=1,nauxparams)
              write(3,*) (bigOmega(i,j), j=1, nauxparams)
           end do
           close(1)
           close(2)
           close(3)

           !           ! alternative, dropping the ma variable
           !           allocate(G2_se(nauxparams,sum(incl)-1))
           !           allocate(outer2(sum(incl)-1,sum(incl)-1), inner2(sum(incl)-1,sum(incl)-1))
           !           allocate(var2(sum(incl)-1,sum(incl)-1))
           !
           !           !hardcoding for faster code writing since this is not an essential part of code
           !           G2_se(:,1:14) = G_se(:,1:14)
           !           G2_se(:,15:19) = G_se(:,16:20)
           !
           !           ! outer = inv(G'WG)
           !           outer2 = inv_se(matmul(matmul(transpose(G2_se),W_se),G2_se))
           !           ! inner = G'W diag(var) WG
           !           inner2 = matmul(matmul(matmul(transpose(G2_se),W_se),bigOmega), matmul(W_se,G2_se))
           !           ! V = outer inner outer
           !           var2 = matmul(matmul(outer2,inner2),outer2)
           !
           !           do i=1, sum(incl)-1
           !              semat2(i,ridx+1) = sqrt(var2(i,i))
           !           end do
           !           
           !           deallocate(G2_se, outer2, inner2, var2)
           !           
           !
           !           ! Also alternatively, lets compute SEs for teacher side and district side separately to see
           !           !   what this looks like to dig in
           !
           !           !allocate(W_se(nauxparams,nauxparams), G_se(nauxparams,sum(incl)), bigOmega(nauxparams,nauxparams))
           !           !allocate(outer(sum(incl),sum(incl)), inner(sum(incl),sum(incl)))
           !           !allocate(var(sum(incl),sum(incl)))
           !           !teachers
           !           allocate(Gt_se(nauxparams,ntparam))
           !           allocate(outert(ntparam, ntparam), innert(ntparam, ntparam))
           !           allocate(vart(ntparam,ntparam))
           !
           !           Gt_se(:,1:ntparam-1) = G_se(:,1:ntparam-1)
           !           Gt_se(:,ntparam) = G_se(:,sigmaind)
           !
           !           ! outer = inv(G'WG)
           !           outert = inv_se(matmul(matmul(transpose(Gt_se),W_se),Gt_se))
           !           ! inner = G'W diag(var) WG
           !           innert = matmul(matmul(matmul(transpose(Gt_se),W_se),bigOmega), matmul(W_se,Gt_se))
           !           ! V = outer inner outer
           !           vart = matmul(matmul(outert,innert),outert)
           !
           !           do i=1, ntparam
           !              sematt(i,ridx+1) = sqrt(vart(i,i))
           !           end do
           !           
           !           deallocate(Gt_se, outert, innert, vart)
           !
           !           !districts
           !           allocate(Gd_se(nauxparams,ndparam))
           !           allocate(outerd(ndparam, ndparam), innerd(ndparam, ndparam))
           !           allocate(vard(ndparam,ndparam))
           !
           !           !sematd(1:(sigmaind-ntparam),1) = semat(ntparam:(sigmaind-1),1)
           !           !sematd((sigmaind-ntparam+1):ndparam,1) = semat(sigmaind+1:sum(incl),1)
           !           Gd_se(:,1:(sigmaind-ntparam)) = G_se(:,ntparam:sigmaind-1)
           !           Gd_se(:,(sigmaind-ntparam+1):ndparam) = G_se(:, sigmaind+1:sum(incl))
           !
           !           ! outer = inv(G'WG)
           !           outerd = inv_se(matmul(matmul(transpose(Gd_se),W_se),Gd_se))
           !           ! inner = G'W diag(var) WG
           !           innerd = matmul(matmul(matmul(transpose(Gd_se),W_se),bigOmega), matmul(W_se,Gd_se))
           !           ! V = outer inner outer
           !           vard = matmul(matmul(outerd,innerd),outerd)
           !
           !           do i=1, ndparam
           !              sematd(i,ridx+1) = sqrt(vard(i,i))
           !           end do
           !
           !deallocate(Gd_se, outerd, innerd, vard)
           
           deallocate(W_se, G_se, bigOmega, outer, inner, var)


        end do ! ridx. i.e. each perturbation

        !write out ses
        open(1, file='result/se_param.txt', status = 'replace')
        do i=1, sum(incl)
           write(1,*) (semat(i,j),j=1,size(r_se_list)+1)
        end do
        close(1)

        !        !write out our no ma ses
        !        open(1, file='se2_param.txt', status = 'replace')
        !        do i=1, sum(incl)-1
        !           write(1,*) (semat2(i,j),j=1,size(r_se_list)+1)
        !        end do
        !        close(1)
        !
        !        !write out se for just teacher and district subsets
        !        open(1, file='set_param.txt',status = 'replace')
        !        do i=1, ntparam
        !           write(1,*) (sematt(i,j),j=1,size(r_se_list)+1)
        !        end do
        !        close(1)
        !        open(1, file='sed_param.txt',status = 'replace')
        !        do i=1, ndparam
        !           write(1,*) (sematd(i,j),j=1,size(r_se_list)+1)
        !        end do
        !        close(1)        

        deallocate(initial_param_se, param_se)

     else
        !no outer loop, run obj once
        tval = objective_function(param0)
     end if

     !once code is finished, need to tell slave processes to quit running
     call mpi_bcast(0,1,mpi_int,0,mpi_comm_world,ierr)


     deallocate(param0)
  end if


  !if slave processe, then help solve dist problem in inner loop until told to stop
  if(mpi_id .ne. 0) then
     do
        call mpi_bcast(slave_flag,1,mpi_int,0,mpi_comm_world,ierr)
        if (slave_flag==0) exit
        call run_slave_inner_loop_one()
     end do
  end if

  if (mpi_id .eq. 0) then
     deallocate(tshock)
     if (purpose >= 10) then
        deallocate(dshock)
        deallocate(sim_omegas)
     end if
  end if
  deallocate(eqbm_omega2)

  if (mpi_id == 0) then
     print*, "--------------"
     print*, "END OF PROGRAM"
  end if

  !close out mpi
  call mpi_finalize(ierr)


contains

  ! calculate wage statistic, used to help with district beliefs on teach acceptance
  subroutine calc_wstat()
    implicit none
    double precision, dimension(nteach,ndist) :: mean_wage, sd_wage
    double precision, dimension(nteach) :: var_wage

    mean_wage = 0d0
    sd_wage   = 0d0
    var_wage  = 0d0
    
    do j=1, ndist !calc mean for each teacher
       do i=1, nteach
          mean_wage(i,1) = mean_wage(i,1) + wage(i,j) / ndist
       enddo
    enddo
    do j=2, ndist !apply mean wage across all districts
       do i=1, nteach
          mean_wage(i,j) = mean_wage(i,1)
       enddo
    enddo
    do j=1, ndist !calc variance for each teacher
       do i=1, nteach
          var_wage(i) = var_wage(i) + (wage(i,j) - mean_wage(i,1))**2 * 1/(ndist-1)
       enddo
    enddo
    do j=1, ndist !take sd and apply sd across all districts
       do i=1, nteach
          sd_wage(i,j) = sqrt(var_wage(i))
       enddo
    enddo

    !global variables
    wstat = (wage - mean_wage) / sd_wage
    meanW = mean_wage(:,1)
    sdW   = sd_wage(:,1)

  end subroutine calc_wstat


  ! Returns the inverse of a matrix calculated by finding the LU
  ! decomposition.  Depends on LAPACK.
  ! Taken from:
  ! http://fortranwiki.org/fortran/show/Matrix+inversion
  function inv_se(A) result(Ainv)
    real(8), dimension(:,:), intent(in)     :: A
    real(8), dimension(size(A,1),size(A,2)) :: Ainv

    real(8), dimension(size(A,1)) :: work  ! work array for LAPACK
    integer, dimension(size(A,1)) :: ipiv   ! pivot indices
    integer :: n, info
    real :: na_trick

    ! External procedures defined in LAPACK
    external DGETRF
    external DGETRI

    na_trick = 0

    ! Store A in Ainv to prevent it from being overwritten by LAPACK
    Ainv = A
    n = size(A,1)

    ! DGETRF computes an LU factorization of a general M-by-N matrix A
    ! using partial pivoting with row interchanges.
    call DGETRF(n, n, Ainv, n, ipiv, info)

    if (info /= 0) then
       !stop 'Matrix in standard error is numerically singular!'
       print*, 'Matrix in standard error is numerically singular!'
       Ainv = 1d0/na_trick

    else


       ! DGETRI computes the inverse of a matrix using the LU factorization
       ! computed by DGETRF.
       call DGETRI(n, Ainv, n, ipiv, work, n, info)

       if (info /= 0) then
          !stop 'Matrix inversion failed in standard error calc!'
          print*, 'Matrix inversion failed in standard error calc!'
          Ainv = 1d0/na_trick
       end if
    end if

  end function inv_se
end program main

! statistical_models.f90
! created: Oct 2018
!
! Incorporates statistical models that we need
! 1. OLS (requires lapack)
!
module statistical_models
  use global_variables
  implicit none

  private

  public :: linreg 


contains
 
  ! Run linear regression
  function linreg(y,X) result(beta)
    double precision, dimension(:,:), intent(in)     :: y
    double precision, dimension(:,:), intent(in)     :: X
    double precision, dimension(size(X,2),size(y,2)) :: beta_mat
    double precision, dimension(size(X,2))           :: beta

    ! inv(X'X) * X'y
    beta_mat = matmul(inv(matmul(transpose(X),X)),matmul(transpose(X),y))
    beta = beta_mat(:,1)

    ! ADDED ONLY FOR THE REPLICATION FILES FOR JPE
    !   the synthetic data is resulting in some NAs, so to keep replication running
    !   am replacing the NAs with zeros
    ! If you get the real data and input it and wan to work with the model for real
    !   it should run just fine but also you may want to remove this so you are aware
    !   if you do get NAs
    print*, "due to singularity, we have NAs, replacing with -1"
    print*, "this allows replication code to run on synthetic data. (see statistical_models.f90)"
    where (isnan(beta)) beta = -1.0d0
    
  end function linreg

  
  ! Returns the inverse of a matrix calculated by finding the LU
  ! decomposition.  Depends on LAPACK.
  ! Taken from:
  ! http://fortranwiki.org/fortran/show/Matrix+inversion
  function inv(A) result(Ainv)
    real(8), dimension(:,:), intent(in)     :: A
    real(8), dimension(size(A,1),size(A,2)) :: Ainv
  
    real(8), dimension(size(A,1)) :: work  ! work array for LAPACK
    integer, dimension(size(A,1)) :: ipiv   ! pivot indices
    integer :: n, info
  
    ! External procedures defined in LAPACK
    external DGETRF
    external DGETRI
  
    ! Store A in Ainv to prevent it from being overwritten by LAPACK
    Ainv = A
    n = size(A,1)
  
    ! DGETRF computes an LU factorization of a general M-by-N matrix A
    ! using partial pivoting with row interchanges.
    call DGETRF(n, n, Ainv, n, ipiv, info)
  
    if (info /= 0) then
       !error stop 'Matrix in linreg is numerically singular!'
       print*, 'Matrix in linreg is numerically singular!'
       Ainv = -huge(1d0)
       return
    end if
  
    ! DGETRI computes the inverse of a matrix using the LU factorization
    ! computed by DGETRF.
    call DGETRI(n, Ainv, n, ipiv, work, n, info)
  
    if (info /= 0) then
       !error stop 'Matrix inversion failed in linreg!'
       print*, 'Matrix inversion failed in linreg!'
       Ainv = -huge(1d0)
       return
    end if
  end function inv

end module statistical_models


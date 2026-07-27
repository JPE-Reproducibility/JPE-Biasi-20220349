! qsort_mod.f90
! created: oct 2018
!
! Iterative quicksort routine
! written: Jstromme
! Based off of http://alienryderflex.com/quicksort/
!
! Moved to iterative to avoid stack overflow issues with recursive version
! and openmp

module qsort_mod
  implicit none
  private
  public :: qsort, qsort_2d

contains
  subroutine qsort(A)
    double precision, intent(in out), dimension(:) :: A
    integer :: i, L, R, swap
    integer, dimension(300) :: beg, endi
    double precision :: piv
    
    beg(1)  = 1
    endi(1) = size(A) + 1
    
    i = 1
    
    do while (i >= 1)
       L = beg(i)
       R = endi(i)-1
       if (L < R) then
          piv = A(L)
          do while (L < R)
             
             do while (A(R) >= piv .and. L < R)
                R = R - 1
             end do
             if (L < R) then
                A(L) = A(R)
                L = L + 1
             end if
             
             do while (A(L) <= piv .and. L < R)
                L = L + 1
             end do
             if (L < R) then
                A(R) = A(L)
                R = R - 1
             end if
             
          end do
          
          A(L) = piv
          beg(i+1) = L+1
          endi(i+1) = endi(i)
          endi(i) = L
          i = i+1
        
          if (endi(i) - beg(i) > endi(i-1) - beg(i-1)) then
             swap = beg(i)
             beg(i) = beg(i-1)
             beg(i-1) = swap
             
             swap = endi(i)
             endi(i) = endi(i-1)
             endi(i-1) = swap
          end if
       else
          i = i - 1
       end if
    end do
  
  end subroutine qsort
!!!! two-dimension matrix sorting by 1st column
!!!!  it would be asy to make it by column j, instead... but I dont care for now
  subroutine qsort_2d(A)
    double precision, intent(in out), dimension(:,:) :: A
    integer :: i, L, R, swap
    integer, dimension(300) :: beg, endi
    double precision, dimension(size(A,2)) :: piv
    
    beg(1)  = 1
    endi(1) = size(A,1) + 1
    
    i = 1
    
    do while (i >= 1)
       L = beg(i)
       R = endi(i)-1
       if (L < R) then
          piv = A(L,:)
          do while (L < R)
             
             do while (A(R,1) >= piv(1) .and. L < R)
                R = R - 1
             end do
             if (L < R) then
                A(L,:) = A(R,:)
                L = L + 1
             end if
             
             do while (A(L,1) <= piv(1) .and. L < R)
                L = L + 1
             end do
             if (L < R) then
                A(R,:) = A(L,:)
                R = R - 1
             end if
             
          end do
          
          A(L,:) = piv
          beg(i+1) = L+1
          endi(i+1) = endi(i)
          endi(i) = L
          i = i+1
          
          if (endi(i) - beg(i) > endi(i-1) - beg(i-1)) then
             swap = beg(i)
             beg(i) = beg(i-1)
             beg(i-1) = swap
             
             swap = endi(i)
             endi(i) = endi(i-1)
             endi(i-1) = swap
          end if
       else
          i = i - 1
       end if
    end do
  end subroutine qsort_2d


end module qsort_mod


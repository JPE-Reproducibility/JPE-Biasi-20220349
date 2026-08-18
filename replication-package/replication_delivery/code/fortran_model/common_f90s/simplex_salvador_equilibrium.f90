!nelder mead minimzer from F_code_salvador
! same as simplex_salvador.f90 except with included extra arguments
!    to make coding cleaner. Only change is extra arguments get passed through
!    to func
module simplex_salvador_equilibrium
  implicit none

contains
  recursive subroutine nelder_meade_eqm(x,ftol,func,id,itmax,simplex_length,obj_tol,arg)
    use nrutil, only : assert_eq,imaxloc,iminloc,nrerror,swap
    implicit none
    interface
       function func(x,arg)
         implicit none
         real(8), dimension(:), intent(in) :: x, arg
         real(8) :: func
       end function func
    end interface

    
    real(8), intent(in) :: ftol, obj_tol
    integer, intent(in) :: id
    real(8), dimension(:), intent(inout) :: x
    
    integer, intent(in) :: itmax
    double precision, intent(in) :: simplex_length
    double precision, dimension(:), intent(in) :: arg
    
    real(8), parameter :: tiny=1.0e-12
    integer :: ihi,ndim,i,j,iter
    real(8) :: psum(size(x)),p(size(x)+1,size(x)),y(size(x)+1),pb(size(x)),ver

    real(8) :: step
    !initialize the simplex
    !first vertex
    do j=1,size(x)
       pb(j)=x(j)
       p(1,j)=x(j)
    end do
    y(1)=func(pb,arg)
    if (y(1) .lt. obj_tol) then
       if(id==0) write(*,*) 'stopped because objective value below specified tolerance'
       return
    end if
    !adjust each parameter slightly for other vertexes
    do i=2,size(x)+1
       do j=1,size(x)
          if (i-1==j) then
             if (simplex_length == 0) then
                step = 0
                if (j==1)  step = 0.050
                if (j==2)  step = 0.200
                if (j==3)  step = 0.200
                if (j==4)  step = 0.200
                if (j==5)  step = 0.200
                if (j==6)  step = 0.200
                if (j==7)  step = 0.100
                if (j==8)  step = 0.200
                if (j==9)  step = 0.200
                if (j==10) step = 0.200
                if (j==11) step = 0.200
                if (j==12) step = 0.200
                if (j==13) step = 0.200
                if (j==14) step = 0.200
                if (j==15) step = 0.100
                if (j==16) step = 0.100
                if (j==17) step = 0.100
                if (j==18) step = 0.200
                if (j==19) step = 0.200
                if (j==20) step = 0.200
                if (j==21) step = 0.200
                if (j==22) step = 0.200
                !ver=abs(x(j))*0.1d0
                if (step==0) then
                   print*, 'issue in simplex hardcode, be careful'
                   call exit(1)
                end if
                ver = abs(x(j))*step
             else
                ver=simplex_length
             end if
             
             if (ver<1.0d-5) ver=0.25d0
             !             ver=1.0d0
             pb(j) = x(j) + ver
             p(i,j) = x(j) + ver
          else
             pb(j) = x(j)
             p(i,j) = x(j)                
          end if
       end do
       print*, 'param ', i-1
       y(i)=func(pb,arg)
       if (y(i) .lt. obj_tol) then
          if(id==0) write(*,*) 'stopped because objective value below specified tolerance'
          x = pb
          return
       end if
    end do
       
    call amoeba_private
  contains

    subroutine amoeba_private
      implicit none
      integer :: i,ilo,inhi
      real(8) :: rtol,ysave,ytry,ytmp,tim
      integer :: tin,tout,hz
      ndim=assert_eq(size(p,2),size(p,1)-1,size(y)-1,'amoeba')
      iter=0
      psum(:)=sum(p(:,:),dim=1)
      do
         ilo=iminloc(y(:))
         x=p(ilo,:)
         if (y(ilo) .lt. obj_tol) then
            if(id==0) write(*,*) 'stopped because objective value below specified tolerance'
            return
         end if
         ihi=imaxloc(y(:))
         ytmp=y(ihi)
         y(ihi)=y(ilo)
         inhi=imaxloc(y(:))
         y(ihi)=ytmp
         if (id==0) then
            !open(6424,file="point.out")
            !do j=1,ndim
            !   write(6424,'(f32.16)') x(j)
            !end do
            !close(6424)
            if (iter>0) then
               call system_clock(count=tout) 
               tout=tout-tin
               tim=dble(tout)/dble(hz)
               write(*,'(a,i10,a,f32.16,a,f16.8)') &
                    'iterations',iter,' best value',y(ilo),' time',tim
            end if
         end if
         call system_clock(count_rate=hz) 
         call system_clock(count=tin)        
         rtol=2.0d0*abs(y(ihi)-y(ilo))/(abs(y(ihi))+abs(y(ilo))+tiny)
         if (rtol < ftol) then
            call swap(y(1),y(ilo))
            call swap(p(1,:),p(ilo,:))
            if (id==0) write(*,*) "stopped by tolerance"
            return
         end if
         if (iter >= itmax) then
            if (id==0) write(*,*) 'itmax exceeded in amoeba'
            !write(*,*) id,"itmax"
            return
         end if
         ytry=amotry(-1.0d0) !reflect
         iter=iter+1
         if (ytry <= y(ilo)) then
            ytry=amotry(2.0d0)
            iter=iter+1
         else if (ytry >= y(inhi)) then
            ysave=y(ihi)
            ytry=amotry(0.5d0)
            iter=iter+1
            if (ytry >= ysave) then
               p(:,:)=0.5d0*(p(:,:)+spread(p(ilo,:),1,size(p,1)))
               do i=1,ndim+1
                  if (i /= ilo) y(i)=func(p(i,:),arg)
               end do
               iter=iter+ndim
               psum(:)=sum(p(:,:),dim=1)
            end if
         end if
      end do
      if (id==0) then
         !open(6424,file="point.out")
         !do j=1,ndim
         !   write(6424,'(f32.16)') x(j)
         !end do
         !close(6424)
      end if
    end subroutine amoeba_private

    function amotry(fac)
      implicit none
      real(8), intent(in) :: fac
      real(8) :: amotry
      real(8) :: fac1,fac2,ytry
      real(8), dimension(size(p,2)) :: ptry
      fac1=(1.0d0-fac)/ndim
      fac2=fac1-fac
      ptry(:)=psum(:)*fac1-p(ihi,:)*fac2
      ytry=func(ptry,arg)
      if (ytry < y(ihi)) then
         y(ihi)=ytry
         psum(:)=psum(:)-p(ihi,:)+ptry(:)
         p(ihi,:)=ptry(:)
      end if
      amotry=ytry
    end function amotry
  end subroutine nelder_meade_eqm
end module simplex_salvador_equilibrium

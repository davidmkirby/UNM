
!this subroutine calculate 2d area over input domain with jacobian

subroutine Trapezoidal2d(fun,xr,yr,xs,ys,nr,ns,hr,hs,integral)
  integer, intent(in) :: nr,ns
  real(kind = 8), intent(in):: hr,hs
  real(kind = 8), intent(in), dimension(0:nr,0:ns)::xr,yr,xs,ys,fun
  real(kind = 8), dimension(0:nr,0:ns)::fun_integ
  real(kind = 8), intent(out):: integral
  integer :: ii,jj

  !function in another grid system
  fun_integ = ((xr*ys)-(xs*yr))*fun
  
  integral =0d0

  do i = 1,nr-1
     do j = 1,ns-1
        integral = integral+ (fun_integ(i,j))
     end do
     
  end do

  do i = 1,nr-1
     integral= integral + 0.5d0*(fun_integ(i,0))
    integral = integral + 0.5d0*(fun_integ(i,ns))
  end do
  
  do j = 1,ns-1
     integral = integral + 0.5d0*(fun_integ(0,j))
     integral = integral + 0.5d0*(fun_integ(nr,j))
  end do
  integral = integral +0.25d0*(fun_integ(0,0))
  integral = integral +0.25d0*(fun_integ(0,ns))
  integral = integral +0.25d0*(fun_integ(nr,0))
  integral = integral +0.25d0*(fun_integ(nr,ns))
  integral = integral * hs*hr
end subroutine trapezoidal2d

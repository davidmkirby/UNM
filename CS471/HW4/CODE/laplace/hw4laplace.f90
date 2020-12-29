program hwk4laplace
 use xycoord  
  implicit none
  integer :: nr,ns,i,j, k
  integer, dimension(1:5):: nsi, nri
  real(kind = 8) :: hr,hs, integral
  real(kind = 8), dimension(:), allocatable :: r,s
  real(kind = 8), dimension(:,:), allocatable :: u,ur,us,ux,uy
  real(kind = 8), dimension(:,:), allocatable :: xc,yc,xr,xs,yr,ys
  real(kind = 8), dimension(:,:), allocatable ::rx,sx,ry,sy,fun_integ,uxr,uxs,uyr,uys,uxx,uyy

 nsi = (/5,35,75,90,95 /)
  nri = (/5,20,45,75,80 /)
  do k = 1,5
     
     nr = nsi(k)
     ns = nsi(k)

   !! allocating array
     allocate(r(0:nr),s(0:ns),u(0:nr,0:ns),ur(0:nr,0:ns),us(0:nr,0:ns))
     allocate(xc(0:nr,0:ns),yc(0:nr,0:ns))
     allocate(xr(0:nr,0:ns),yr(0:nr,0:ns),xs(0:nr,0:ns),ys(0:nr,0:ns))
     allocate(rx(0:nr,0:ns),ry(0:nr,0:ns),sx(0:nr,0:ns),sy(0:nr,0:ns))
     allocate(ux(0:nr,0:ns),uy(0:nr,0:ns),fun_integ(0:nr,0:ns))
     allocate(uxr(0:nr,0:ns),uxs(0:nr,0:ns),uxx(0:nr,0:ns))
     allocate(uyr(0:nr,0:ns),uys(0:nr,0:ns),uyy(0:nr,0:ns))

     hr = 2.d0/dble(nr)
     hs = 2.d0/dble(ns)
     do i = 0,nr
        r(i) = -1.d0 + dble(i)*hr
     end do
     do i = 0,ns
        s(i) = -1.d0 + dble(i)*hs
     end do

     
     do j = 0,ns
        do i = 0,nr
           xc(i,j) = x_coord(r(i),s(j))
           yc(i,j) = y_coord(r(i),s(j))
        end do
     end do
     
     if (k .eq. 5) then
        call  printdble2d(xc,nr,ns,'x.txt')
        call  printdble2d(yc,nr,ns,'y.txt')
     end if
     
     !creating function to be integrated 
     do j = 0,ns
        do i = 0,nr
           ! fun 1 
           !u(i,j) = sin(xc(i,j))*cos(yc(i,j))
           ! fun 2 
           !u(i,j) = exp(xc(i,j)+yc(i,j))
           !fun 3
           u(i,j) = xc(i,j)**2+yc(i,j)**2
        end do
     end do

     ! Differentiate in the r-direction
     do i = 0,ns
        call differentiate(u(0:nr,i),ur(0:nr,i),hr,nr)
     end do
     ! Differentiate in the s-direction
     do i = 0,nr
        call differentiate(u(i,0:ns),us(i,0:ns),hs,ns)
     end do



     !Metric from differentiation
     do i = 0,ns
        call differentiate(xc(0:nr,i),xr(0:nr,i),hr,nr)
        call differentiate(yc(0:nr,i),yr(0:nr,i),hr,nr)
     end do
     ! Differentiate in the s-direction. xs, ys
     do i = 0,nr
        call differentiate(xc(i,0:ns),xs(i,0:ns),hs,ns)
        call differentiate(yc(i,0:ns),ys(i,0:ns),hs,ns)
     end do
     ! Find metric
     call metric(xr,xs,yr,ys,rx,ry,sx,sy,nr,ns)

     !computing ux and uy
     ux = (rx*ur)+(sx*us)
     uy = (ry*ur)+(sy*us)

     !2nd Derivative
     ! Differentiate in the r-direction
     do i = 0,ns
        call differentiate(ux(0:nr,i),uxr(0:nr,i),hr,nr)
        call differentiate(uy(0:nr,i),uyr(0:nr,i),hr,nr)
     end do
     ! Differentiate in the s-direction
     do i = 0,nr
        call differentiate(ux(i,0:ns),uxs(i,0:ns),hs,ns)
        call differentiate(uy(i,0:ns),uys(i,0:ns),hs,ns)
     end do

     !Laplancian terms
     uxx = rx*uxr + sx*uxs;
     uyy = ry*uyr + sy*uys;
     
     !errors
     !fun 1
     !fun_integ = (uxx+uyy-(-2d0*sin(xc)*cos(yc)))**2
     !fun 2
     !fun_integ = (uxx+uyy-(2d0*exp(xc+yc)))**2
     !fun 3
     fun_integ = (uxx+uyy-(4d0))**2
     call trapezoidal2d(fun_integ,xr,yr,xs,ys,nr,ns,hr,hs,integral)
     integral = sqrt(integral)
     write(*,*) sqrt(maxval(xr*ys - xs*ry)*hs*hr), integral, 1d0
     !call trapezoidal2d(xr,yr,xs,ys,nr,ns,hr,hs,integral)
     !write(*,*) 'Value of Integral',integral

     deallocate(r,s,u,ur,us,xc,yc,xr,xs,ys,yr,rx,ry,sx,sy,ux,uy,fun_integ)
     deallocate(uxr,uxs,uyr,uys,uxx,uyy)
     
  end do

end program



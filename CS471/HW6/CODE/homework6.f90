program homework6
  use xycoord ! use the module xycoord to set the mapping
  use omp_lib
  implicit none
  integer :: nr,ns,i,j, ii,jj, kk,k
  real(kind = 8) :: hr,hs, integral,start, finish
  real(kind = 8), dimension(1:16)::time
   integer, dimension(1:16)::grid
  real(kind = 8), dimension(:), allocatable :: r,s
  real(kind = 8), dimension(:,:), allocatable :: u,ur,us,ux,uy
    real(kind = 8), dimension(:,:), allocatable :: xc,yc,xr,xs,yr,ys
  real(kind = 8), dimension(:,:), allocatable ::rx,sx,ry,sy,fun_integ

    grid= (/200,283,346,400,447,490,529,566,600,632,663,693,721,748,775,800/) 
     do kk = 1,16
        nr = grid(kk)
        ns = grid(kk)

     ! Allocate memory for the various arrays
     allocate(r(0:nr),s(0:ns),u(0:nr,0:ns),ur(0:nr,0:ns),us(0:nr,0:ns))
     allocate(xc(0:nr,0:ns),yc(0:nr,0:ns))
     allocate(xr(0:nr,0:ns),yr(0:nr,0:ns),xs(0:nr,0:ns),ys(0:nr,0:ns))
     allocate(rx(0:nr,0:ns),ry(0:nr,0:ns),sx(0:nr,0:ns),sy(0:nr,0:ns))
     allocate(ux(0:nr,0:ns),uy(0:nr,0:ns),fun_integ(0:nr,0:ns))

     hr = 2.d0/dble(nr)
     hs = 2.d0/dble(ns)

     !$ call OMP_set_num_threads(kk)

     start = omp_get_wtime()
     !$OMP PARALLEL DO PRIVATE(i)
     do i = 0,nr
        r(i) = -1.d0 + dble(i)*hr
     end do
 !$OMP END PARALLEL DO
     !$OMP PARALLEL DO PRIVATE(i)
     do i = 0,ns
        s(i) = -1.d0 + dble(i)*hs
     end do
 !$OMP END PARALLEL DO
    !$OMP PARALLEL DO PRIVATE(j,i)
     do j = 0,ns
        do i = 0,nr
           xc(i,j) = x_coord(r(i),s(j))
           yc(i,j) = y_coord(r(i),s(j))
        end do
     end do
     !$OMP END PARALLEL DO
     

     !Function for integration
     !$OMP PARALLEL DO PRIVATE(j,i)
     do j = 0,ns
        do i = 0,nr
           ! fn 1 
           u(i,j) = sin(xc(i,j))*cos(yc(i,j))
           
        end do
     end do
     !$OMP END PARALLEL DO


     
     ! Differentiate with respect to r-direction
     !$OMP PARALLEL DO PRIVATE(i)
     do i = 0,ns
        call differentiate(u(0:nr,i),ur(0:nr,i),hr,nr)
     end do
     !$OMP END PARALLEL DO

     
     ! Differentiate with respect to s-direction
     !$OMP PARALLEL DO PRIVATE(i)
     do i = 0,nr
        call differentiate(u(i,0:ns),us(i,0:ns),hs,ns)
     end do
     !$OMP END PARALLEL DO


     !compute metric
     !Find xr,yr

     !$OMP PARALLEL DO PRIVATE(i)
     do i = 0,ns
        call differentiate(xc(0:nr,i),xr(0:nr,i),hr,nr)
        call differentiate(yc(0:nr,i),yr(0:nr,i),hr,nr)
     end do
     !$OMP END PARALLEL DO

     !$OMP PARALLEL DO PRIVATE(i)
     ! Differentiate with respect to s-direction. xs, ys
     do i = 0,nr
        call differentiate(xc(i,0:ns),xs(i,0:ns),hs,ns)
        call differentiate(yc(i,0:ns),ys(i,0:ns),hs,ns)
     end do
     !$OMP END PARALLEL DO
     
     ! Find metric
     call metric(xr,xs,yr,ys,rx,ry,sx,sy,nr,ns)

     !Differentiation 
     !$OMP WORKSHARE
     ux = (rx*ur)+(sx*us)
     uy = (ry*ur)+(sy*us)
     !$OMP END WORKSHARE
     
     !Computing errors
     !$OMP WORKSHARE
     !fun 1
     fun_integ = (ux+uy-(cos(xc)*cos(yc)-sin(xc)*sin(yc)))**2
     !$OMP END WORKSHARE
    
     
     call trapezoidal2d(fun_integ,xr,yr,xs,ys,nr,ns,hr,hs,integral)
     integral = sqrt(integral)
     finish = omp_get_wtime()
     time(kk) = finish - start

     write(*,*) kk, time(kk)

     deallocate(r,s,u,ur,us,xc,yc,xr,xs,ys,yr,rx,ry,sx,sy,ux,uy,fun_integ)
  end do !master loop
  

  
end program

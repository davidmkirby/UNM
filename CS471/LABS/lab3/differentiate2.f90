! This program differentiates functions (up to m-th derivative)
! using a finite difference stencil with maximum width
! computed by Bengt Fornberg's weights subroutine (Fornberg_weights.f90)
! on an equidistant grid

program differentiate2
  implicit none
  real(kind = 8), parameter :: pi = acos(-1.d0)
  integer :: n,i,j,m
  real(kind = 8) :: h,z
  real(kind = 8), dimension(:), allocatable :: x,f,df,df_exact
  real(kind = 8), dimension(:,:), allocatable :: c

  m = 1  !the highest derivative (here 1)
  do n  = 4,100
     ! Allocate memory for various arrays
     allocate(x(0:n),f(0:n),df(0:n),df_exact(0:n))
     allocate(c(0:n,0:m))
     ! Set up the grid.
     h = 2.d0/dble(n)
     do i = 0,n
        x(i) = -1.d0+dble(i)*h
     end do
     ! The function and the exact derivative
     f = exp(cos(pi*x))
     df_exact = -pi*sin(pi*x)*exp(cos(pi*x))
     ! Find the difference stencil that uses all grid points
     do i = 0,n
        df(i) = 0.d0
        z = x(i)
        call Fornberg_weights(z,x,n,m,c)
        do j = 0,n
           df(i) = df(i) + c(j,1)*f(j)
        end do
     end do
     write(*,'(ES12.4)') maxval(abs(df-df_exact))
     ! Deallocate the arrays
     deallocate(x,f,df,df_exact,c)
  end do
end program differentiate2

!  Homework3.f90 
!
!  FUNCTIONS:
!  Homework3 - Entry point of console application.
!

!****************************************************************************
!
!  PROGRAM: Homework3
!
!  PURPOSE:  Entry point for the console application.
!
!****************************************************************************

    program HW3
    use Trapezoidal
    use functions
    use gauss_quadrature 
    

    implicit none

    real(kind = 8) :: integral, x0, xf
    integer :: n1, n2
    x0 = -1.0
    xf = 1.0
    n1 = 10000
    n2 = 100
    integral = Trapezoid_integral(fun_1, x0, xf, n1)
    
    print *, 'Integral using trapezoid is ', integral
     

    integral = gaussquad_integral(fun_1, n2)
    print *, 'Integral using gauss quadrature is', integral
    
    end program HW3



  

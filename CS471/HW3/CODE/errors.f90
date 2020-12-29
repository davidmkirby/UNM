! errors.f90 
!
! 
! This program calculate error vs number of sub-interval 
! error is calculated based absolute value of difference of integral on next iteration and integral on now iteration
! error tolerance is 10**(-10)
! 
! 
    program errors
    use gauss_quadrature 
    use Trapezoidal 
    use functions
    implicit none 
    !tol=tolerance, h=step size, It represents integral value in current iteration using Trapezoidal rule
    ! Ig represents integral vaule in current iteration using gaussian quadrature 
    ! pre means previous iteration _1 means k =pi and _2 means k pi**2
    real(kind = 8) :: x_l, x_r,tol, It_1, It_2, Ig_1, Ig_2, Itpre_1, Itpre_2, Igpre_1,Igpre_2
    integer ::n
    x_l = -1d0
    x_r = 1d0
    Itpre_1 = 1.00d3
    Itpre_2 = 1.00d3
    Igpre_1 = 1.00d3
    Igpre_2 = 1.00d3
    tol = 10000d0 !intial choosing high tolerance 
  


      n = 1
      do while (tol > 10d-10)
      ! calling function for value of for k=pi and k=pi**2
      It_1= Trapezoid_integral(fun_1, x_l, x_r, n)
      It_2= Trapezoid_integral(fun_2, x_l, x_r, n)
      Ig_1 = gaussquad_integral(fun_1, n)
      Ig_2 = gaussquad_integral(fun_2, n)
     
      write(*,*) n,",",abs(It_1-Itpre_1) ,",", abs(It_2-Itpre_2),",",abs(Ig_1-Igpre_1) ,",", abs(Ig_2-Igpre_2)
      tol = max(abs(It_1 - Itpre_1),abs(It_2-Itpre_2),abs(Ig_1-Igpre_1) , abs(Ig_2-Igpre_2))
      Itpre_1= It_1
      Itpre_2= It_2
      Igpre_1= Ig_1
      Igpre_2= Ig_2
      n = n+1
      end do
   end program errors


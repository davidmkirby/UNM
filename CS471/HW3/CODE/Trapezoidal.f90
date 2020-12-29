!  Trapezoidal.f90 
!
! This function calculate the integral of function on interval [x0,xf] using trapezoid using n sub- interval 
    
module Trapezoidal
    contains
     pure function Trapezoid_integral(f, x0, xf, n) result(integral)
        implicit none
        
        ! Inputs
        real(kind = 8), intent(in) :: x0, xf
        integer, intent(in) :: n
        
        interface
            pure function f(x) result(y)
                import
                real(kind = 8), dimension(:), intent(in) :: x
                real(kind = 8), dimension(size(x)) :: y
            end function
        end interface
        
        real(kind = 8) :: integral !intializing output 
        
        
        real(kind = 8), dimension(n+1) :: x, y
        real(kind = 8) :: h
        integer :: k
        
        ! Trapezoidal code 
        h = (xf - x0)/n
        x = (/((k*h),k=0,n)/)
        y = h * f(x)
        y(1) = y(1) / 2
        y(n+1) = y(n+1) / 2
        
        integral= sum(y)
        
     end function
    
end module

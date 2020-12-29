!functions.f90


! There are two function we use in the problem 
! fun_1 represents pure function exp(cos(pi * x))  
! fun_2 represents pure function exp(cos((pi**2) * x))   
    module functions
      
     
     real(kind = 8), parameter :: pi = acos(-1d0)
     save 
     contains
      pure function fun_1(x) result(y)
        real(kind = 8), dimension(:), intent(in) :: x
        real(kind = 8), dimension(size(x)) :: y
        y = exp(cos(pi * x))
      end function
    
      pure function fun_2(x) result(y)
        real(kind = 8), dimension(:), intent(in) :: x
        real(kind = 8), dimension(size(x)) :: y
        y = exp(cos((pi**2) * x))
      end function
    
    end module


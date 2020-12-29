
! gauss_quadrature.f90
! This fortran file has function to compute gauss quadrature named as pure function quass_integral 
! For the case w(z)=1, we use Legendre polynomials and obtain the weights and nodes by a call to the subroutine lglnodes
    
    module gauss_quadrature  
    
    private :: lglnodes
    
    contains
    
    pure function gaussquad_integral(fun, n) result(integral)
        implicit none
        
      
        integer, intent(in) :: n !number of subinterval

        interface
            pure function fun(x) result(y)
                import
                real(kind = 8), dimension(:), intent(in) :: x
                real(kind = 8), dimension(size(x)) :: y
            end function
        end interface
      
        real(kind = 8) :: integral  ! intializing the integral

        
        real(kind = 8), dimension(n+1) :: x, w ! dimension
        ! gauss quadrature sum 
        call lglnodes(x,w,n)
        integral = sum(fun(x) * w)
        
    end function
    
    pure subroutine lglnodes(x,w,n)
    !
    !
    ! F90 translation of lglnodes.m
    !
    ! Computes the Legendre-Gauss-Lobatto nodes, weights and the LGL Vandermonde
    ! matrix. The LGL nodes are the zeros of (1-x^2)*P'_N(x). Useful for numerical
    ! integration and spectral methods.
    !
    ! Reference on LGL nodes and weights:
    !   C. Canuto, M. Y. Hussaini, A. Quarteroni, T. A. Tang, "Spectral Methods
    !   in Fluid Dynamics," Section 2.3. Springer-Verlag 1987
    !
    ! Written by Greg von Winckel - 04/17/2004
    ! Contact: gregvw@chtm.unm.edu
    !
    ! Translated and modified not to output the Vandermonde matrix
    ! by Daniel Appelo.
    !
    ! Made minor modifications for integration into homework 3 code
    ! by David Collins
    !
        implicit none
        integer, intent(in) :: n
        integer:: n1
        real(kind = 8), intent(out) :: w(0:n),x(0:n)
        real(kind = 8) :: xold(0:n)
        real(kind = 8), parameter :: pi = acos(-1.d0)
        integer :: i,k
        real(kind = 8) :: P(1:n+1,1:n+1),eps
        ! Truncation + 1
        N1=N+1
        eps = 2.2204d-16

        ! Use the Chebyshev-Gauss-Lobatto nodes as the first guess
        do i = 0,n
            x(i) = -cos(pi*dble(i)/dble(N))
        end do

        ! The Legendre Vandermonde Matrix
        !  P=zeros(N1,N1);

        ! Compute P_(N) using the recursion relation
        ! Compute its first and second derivatives and
        ! update x using the Newton-Raphson method.

        xold = 2.d0

        do i = 1,100 ! Ridic!
            xold = x

            P(:,1) = 1.d0
            P(:,2) = x

            do  k=2,n
                P(:,k+1)=( dble(2*k-1)*x*P(:,k)-dble(k-1)*P(:,k-1) )/dble(k);
            end do
            x = xold-( x*P(:,N1)-P(:,N) )/( dble(N1)*P(:,N1) )
            if (maxval(abs(x-xold)).lt. eps ) exit
        end do

        w=2.d0/(dble(N*N1)*P(:,N1)**2)

    end subroutine lglnodes
    
    end module

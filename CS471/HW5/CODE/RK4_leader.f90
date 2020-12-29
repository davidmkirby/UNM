module RK4_leader
       
use values
 
contains

!Runge kutta method for the leader 
    real(kind=8) function kf(ct,b1t)
    implicit none
    real(kind=8),intent(in):: ct,b1t 
    real(kind=8) :: k1,k2,k3,k4
    real(kind=8) :: a,b,c
    k1 = gamma1*(ct-b1t)
     a = b1t+ k1*dt/2.d0 
    k2 = gamma1*(ct - a)
     b = b1t+ k2*dt/2.d0 
    k3 = gamma1*(ct - b)
    c = b1t+ k3*dt
    k4 = gamma1*(ct - c)
    kf = (k1+2.d0*k2+2*k3+k4)/6.d0
    end function kf
end module RK4_leader


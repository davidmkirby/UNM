module feederbird
use values
contains

   subroutine feeder(C1_x,C1_y)
    real(kind=8),intent(out) ::C1_x(0:nt),C1_y(0:nt)
    real(kind=8) :: t,pi,alpha
    integer:: i
    character(20)::f
    t = 0.d0
    pi = acos(-1.d0)
    alpha = 10.0d0
    
    f = 'feed.txt'  
    open(unit=1,file=f)
   
    do i = 0,nt
       t = t + i*pi/180
       C1_x(i) = sin(alpha*t*0.0d0)
       C1_y(i) = cos(alpha*t*0.0d0)
       write(1,*) C1_x(i),C1_y(i)   
    end do
    close(1)    

   end subroutine feeder
end module feederbird

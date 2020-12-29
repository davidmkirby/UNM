program flockingbird


  use values
  use RK4_leader
  use frames
  use repelforce
  use feederbird
implicit none

   real(kind=8),allocatable :: B_x(:,:),B_y(:,:)
  real(kind=8):: C1_x(0:nt),C1_y(0:nt)
  real(kind=8):: Bbar,Bbar1,Bbarx,Bbary,Bbarx1,Bbary1
  real(kind=8)::x,y
  real(kind=8) :: repel
  real(kind=8)::b1(1:nbirds),b2(1:nbirds)
  character(20) ::c
  integer :: i,j,k



  allocate(B_x(1:nbirds,0:nt),B_y(1:nbirds,0:nt))!,C1_x(0:nt),C1_y(0:nt))

! initial leader coordinates (0,0) index


  Bbarx = 0.d0
  Bbary = 0.d0

  
  do j =1,nbirds
   call random_number(x)
   call random_number(y) 
   B_x(j,0) = x
   B_y(j,0) = y
   Bbarx = Bbarx + B_x(j,0) 
   Bbary = Bbary + B_y(j,0)
  end do

!Initial average x and y coordinates

   Bbarx = Bbarx/nbirds
   Bbary = Bbary/nbirds


! initial bird feeders coordinates  

  call feeder(C1_x,C1_y)

   
    k = 0 
! xy-position evolution for leader
  do i=1,nt 
     B_x(1,i) = B_x(1,i-1) + dt*kf(C1_x(i-1),B_x(1,i-1))
     B_y(1,i) = B_y(1,i-1) + dt*kf(C1_y(i-1),B_y(1,i-1))   
 !position evolution of remaining birds
     do j=1,nbirds
       b1(j) = B_x(j,i-1)
       b2(j) = B_y(j,i-1)
     end do


      do j=2,nbirds
         call repels(b1(:),B_x(j,i-1),repel)
         B_x(j,i) = B_x(j,i-1) + dt*mf(B_x(1,i-1),B_x(j,i-1),C1_x(i-1),Bbarx,Bbarx1,repel)
         call repels(b1(:),B_y(j,i-1),repel)
         B_y(j,i) = B_y(j,i-1) + dt*mf(B_y(1,i-1),B_y(j,i-1),C1_y(i-1),Bbary,Bbary1,repel)
        
      end do
      
      call b_bar(b1,C1_x(0),Bbar,Bbar1,repel)
      Bbarx = Bbar
      Bbarx1 = Bbar1

      call b_bar(b2,C1_y(0),Bbar,Bbar1,repel)
      Bbary = Bbar 
      Bbary1 = Bbar1

     

      k = k+1
  end do
   close(1)

  c = 'xy.txt'
  call frame(B_x,B_y,c,nbirds,nt)
 
  

end program flockingbird


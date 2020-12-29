module repelforce
!This program consist of the repel force for the flocking birds and finally smiley bird. 

use RK4_leader

contains
  
! bbar is the average slope 
     subroutine b_bar(bt,c1t,Bbar,Bbar1,repel)
     implicit none
     real(kind=8),intent(in)::bt(1:nbirds) 
     real(kind=8),intent(in)::c1t,repel
     integer::i     
     real(kind=8),intent(out) :: Bbar,Bbar1

     Bbar = bt(1) !average position 
     Bbar1 = kf(c1t,bt(1)) !average slop of the leader 
     
     do i = 2,nbirds
       Bbar= Bbar + bt(i)
       Bbar1 = Bbar1 + mf(bt(1),bt(i),c1t,Bbar,Bbar1,repel)
     end do
     Bbar = Bbar/nbirds
     Bbar1 = Bbar1/nbirds

    end subroutine b_bar
!repealing force term 

    subroutine repels(bt,bkt,repel)
    implicit none
     real(kind=8),intent(in) :: bt(1:nbirds),bkt
     real(kind=8),intent(out)::repel
     integer:: k,j
     !intilizing repel force term 
       repel = 0.d0
       do j=1,nbirds
          if(abs(bt(j)-bkt).le.0.2)then
            repel = repel + rho*(bkt-bt(j))/((bkt-bt(j))**2 + delta)
          end if
       end do
    end subroutine repels

!runge-kutta method 
    real(kind=8) function mf(bt1,bkt,c1t,Bbar,Bbar1,repel)
    implicit none
    real(kind=8),intent(in):: bt1,bkt,c1t
    real(kind=8),intent(in):: Bbar,Bbar1,repel
    real(kind=8):: k11,a1,ak,ad,k22,b1,bk,bd,k33,c1,ck,cd,k44
    k11 = gamma2*(bt1-bkt) + kappa*(Bbar-bkt) + repel 
    a1 = bt1 + kf(c1t,bt1)*dt/2.d0
    ak = bkt+ k11*dt/2.d0
    ad = Bbar + Bbar1*dt/2.d0
    k22 = gamma2*(a1 - ak) + kappa*(ad-ak) + repel
    b1 = bt1 + kf(c1t,bt1)*dt/2.d0
    bk = bkt+ k22*dt/2.d0
    bd = Bbar + Bbar1*dt/2.d0
    k33 = gamma2*(b1 - bk) + kappa*(bd-bk) +repel
    c1 = bt1 + kf(c1t,bt1)*dt
    ck = bkt+ k33*dt
    cd = Bbar + Bbar1*dt
    k44 = gamma2*(c1 - ck) + kappa*(cd-ck)+repel
    mf = (k11+2.d0*k22+2*k33+k44)/6.d0   
 end function mf
 end module



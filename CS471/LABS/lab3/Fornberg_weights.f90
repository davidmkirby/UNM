subroutine Fornberg_weights(z,x,n,m,c)
! 
! F90 translation of weights subroutine on page 688 of
! Bengt Fornberg, "Calculation of weights in finite difference formulas",
! SIAM Review, Vol. 40, No. 3, pp. 685–691, 1998. 
!
! It computes the Fornber's weights for the stencil with maximul width
!
!
! Translated and modified by Mohammad Motamed at UNM, Sep. 30, 2017.  
!
!==============================================================
! Input Parameters
!       z             location of the point at which we approximate derivatives
!       x(0:n)      grid point locations, found in x(0:n)
!       n             one less than total number of grid points
!       m            highest derivative for which weights are sought
!
! Output Parameter
!       c(0:n,0:m)   weights at grid locations x(0:n) for derivatives
!                          of order 0:m
!==============================================================
implicit none
integer :: n,m, mn
real(kind = 8) :: z,c1,c2,c3,c4,c5
integer :: i,j,k
real(kind = 8) :: x(0:n)
real(kind = 8) :: c(0:n,0:m)

c1=1.d0
c4=x(0)-z
c=0.d0
c(0,0)=1.d0
do i=1,n
   mn=min(i,m)
   c2=1.d0
   c5=c4
   c4=x(i)-z
   do j=0,i-1
      c3=x(i)-x(j)
      c2=c2*c3
      if (j==i-1) then
         do k=mn,1,-1
            c(i,k)=c1*(k*c(i-1,k-1)-c5*c(i-1,k))/c2
         end do
         c(i,0)=-c1*c5*c(i-1,0)/c2
      end if
      do k=mn,1,-1
         c(j,k)=(c4*c(j,k)-k*c(j,k-1))/c3
      end do
      c(j,0)=c4*c(j,0)/c3
   end do
   c1=c2
end do

end subroutine Fornberg_weights

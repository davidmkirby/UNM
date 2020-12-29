!this subroutine compute rx,ry,sx,sy taking xr,xs,yr,ys as input 
subroutine metric(xr,xs,yr,ys,rx,ry,sx,sy,nr,ns)
   
  implicit none

  integer, intent(in) :: nr,ns 
  real(kind=8), dimension(0:nr,0:ns), intent(in) :: xr,xs,yr,ys
  real(kind=8), dimension(0:nr,0:ns), intent(out) :: rx,ry,sx,sy
  real(kind=8) :: determinantJ
  integer:: i,j

  do i = 0,nr
     do j = 0, ns
        DeterminantJ = xr(i,j)*ys(i,j)-xs(i,j)*yr(i,j)
        rx(i,j) = ys(i,j)/ DeterminantJ
        sx(i,j) = -yr(i,j)/ DeterminantJ
        ry(i,j) = -xs(i,j)/ DeterminantJ
        sy(i,j) = xr(i,j)/ DeterminantJ
     end do
  end do

end subroutine metric

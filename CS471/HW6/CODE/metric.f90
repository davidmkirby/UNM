!this subroutine compute rx,ry,sx,sy taking xr,xs,yr,ys as input 
subroutine metric(xr,xs,yr,ys,rx,ry,sx,sy,nr,ns);
   
  integer, intent(in) :: nr,ns 
  double precision, dimension(0:nr,0:ns), intent(in) :: xr,xs,yr,ys
  double precision, dimension(0:nr,0:ns), intent(out) :: rx,ry,sx,sy
  double precision :: determinantJ
  integer:: i,j

  do i = 0,nr
     do j = 0, ns
        determinantJ = xr(i,j)*ys(i,j)-xs(i,j)*yr(i,j)
        rx(i,j) = ys(i,j)/determinantJ
        sx(i,j) = -yr(i,j)/determinantJ
        ry(i,j) = -xs(i,j)/determinantJ
        sy(i,j) = xr(i,j)/determinantJ
     end do
  end do

end subroutine metric

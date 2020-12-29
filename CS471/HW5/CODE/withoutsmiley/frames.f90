module frames
  contains
!this program help us to write coordinate of birds in one file 
    subroutine frame(bx,by,f,nbirds,nt)
      implicit none
      real(kind=8),intent(in) ::bx(1:nbirds,0:nt),by(1:nbirds,0:nt)
      integer,intent(in) :: nbirds,nt
      integer :: i,j
      character(20)::f
      open(unit=1,file=f)
      do j=1,nbirds
       do i=1,nt
        write(1,*) bx(j,i),by(j,i)
       end do
      end do
     close(1)
     write(*,*) 'nbirds', nbirds,'nt',nt
   end subroutine frame
end module

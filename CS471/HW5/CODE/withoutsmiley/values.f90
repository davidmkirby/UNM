module values
        integer,parameter:: nt = 100,nbirds = 100
        real(kind=8),parameter::dt = 0.01d0,tmax = dt*nt
        real(kind=8), parameter::gamma1 = 1.0d0,gamma2 = 1.0d0,kappa =1.0d0,delta=1.0d0,rho =3.0d0      
end module


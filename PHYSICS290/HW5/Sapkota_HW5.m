close all 
clear all
%% problem 1
% the motion driven by osciliator
k=1;    
m=1;
% xp=[x , v] this is our function x(2)=dx/dt and x(1)=x
xp=@(t,x) [x(2);-(k./m)*x(1)+(1./m)*sin(t)]; 
% here t and x are input to xp 
%t is scalar and x is a 2x1 vector =[x1;x2] 
%Hence xp is also a 2x1 vector 
t0=0; % initial time
T=25; % final time 
Dt=0.1; %step size
n=round((T-t0)./Dt); % no of step size or sub interval 
t=(t0:Dt:T); % This create vector of the discrete grid points
x=zeros(2,length(t)); % to prelocate our solution 
x(:,1)=[15;0]; %initial x0=10 and v0=0 from the rest
for i=1:n
   K1=xp(t(i),x(:,i)); %K1
   K2=xp(t(i)+0.5*Dt,x(:,i)+0.5*Dt*K1); %K2
   K3=xp(t(i)+0.5*Dt,x(:,i)+0.5*Dt*K2); %K3q
   
   K4=xp(t(i)+0.5*Dt,x(:,i)+0.5*Dt*K3); %K4
   x(:,i+1)=x(:,i)+(1/6)*Dt*(K1+2*K2+2*K3+K4); %assigning the value to our solution x(:,i+1)
end
% plot to show no of cycle of oscillation by ploting x(t) vs t
figure
plot(t,x(1,:),'m-')
xlabel('t')
ylabel('x(t)')

%% Problem 2
% alpha particle scattering 
g=9.8;
b0=10.^(-15);
Dt=10.^(-16);
bf=10.^(-11);
b=[b0:Dt:bf];
nn=length(b);
% x=[x y v vx vy]
x=zeros(5,nn); 
% initial condition 
v0=5*10^7;
x(:,1)=[10.^(-12);0;v0;v0;0]; 

deltaV=@(x,y) g*Dt./(x.^2+y.^2); % solving the columb force equation
a(1)=deltaV(x(1,1),x(1,2));
t(1)=0;
beta=b.*x(4,1).^2/g;
exacttheta=2*acot(beta);

for ii=2:nn
    % this is the K1 as velocity
    K1=a*(ii-1);
    %K2
    K2=deltaV(x(1,ii-1)+Dt/2*x(4,ii-1),x(2,ii-1)+Dt/2*x(5,ii-1));
    %K3
    K3=deltaV(x(1,ii-1)+Dt/2*x(4,ii-1),x(2,ii-1)+Dt/2*x(5,ii-1));
    %K4
    K4=deltaV(x(1,ii-1)+Dt*x(4,ii-1),x(2,ii-1)+Dt*x(5,ii-1));
    Keff=(1/6)*(K1+2*K2+2*K3+K4);
    x(4,ii)=x(4,ii-1)+Keff*Dt*cos(exacttheta(ii)); % updating vx
    x(5,ii)=x(5,ii-1)+Keff*Dt*sin(exacttheta(ii)); % Updating vy
    x(3,ii)=sqrt((x(4,ii)).^2+(x(5,ii)).^2); % v at particular 
    znum(ii)=b(ii)*(x(3,ii)).^2./g;
    thetanum(ii)=2*acot(znum(ii));
end
semilogx(b,thetanum,'or')
hold on 
semilogx(b,exacttheta,'k')

xlabel('Impact Parameter(m)')
ylabel('Scattering Angle(radian)')
legend('Simulated','Theory')

%% Problem 3
% Demonstration of the error is smaller in RK4 then RK1
% expoential growth
Cons=2;
Fp=@(F)Cons*F; %this is the derivative of F(t) at F

%Integration time and time step
T=10;
h=.1;
T0=0;
Tvec=(T0:h:T); %time vector

%Intialize results array for RK1
FRK1=zeros(length(Tvec),1);

%Set initial values
FRK10=10;
FRK1(1)=FRK10;
%This is the integration for RK1
for tt=2:length(Tvec)
    
    FRK1(tt)=FRK1(tt-1)+Fp(FRK1(tt-1))*h;
end
% This is the setup for the RK4
FRK4=zeros(length(Tvec),1);
FRK40=10;
FRK4(1)=FRK40;
for tt=2:length(Tvec)
    
    %k1
    K1=Fp(FRK4(tt-1));
    %k2
    K2=Fp(FRK4(tt-1)+K1*h/2);
    %k3
    K3=Fp(FRK4(tt-1)+K2*h/2);
    %k4
    K4=Fp(FRK4(tt-1)+K3*h);
    
    Keff=1/6*(K1 +2*K2 +2*K3+K4);
    FRK4(tt)=FRK4(tt-1)+Keff*h;
end
% illustration from the figure
figure
plot(Tvec,FRK4,'c')
hold on
plot(Tvec,FRK1,'m')
xlabel('T')
ylabel('F(t)')
hold on
ExactT=linspace(T0,T,1000);
ExactF=10*exp(Cons*ExactT);
hold on
plot(ExactT,ExactF,'r')
legend('RK4','RK1','ExactF')
% error calculation 
ErrorinRK4=FRK4(end)-10*exp(Cons*Tvec(end))
ErrorinRK1=FRK1(end)-10*exp(Cons*Tvec(end))

%% Problem 4
% simple simulation of mercury orbit
%ecentricity of mercury
ece=0.206;
% start at perihelion
t0=pi;
timestep=pi/10000;
T=4.147*2*pi; %full time for one year for earth
ptime=0.01;

figure()
for ii=t0:timestep:T
    r=0.294/(1-e*cos(ii)); % 0.294 is calculated from semimajor axis and eccentricity it is in polar form
    [x,y]=pol2cart(t,r); % this convert our co-ordinate back to cartesin system
    plot(x,y)



















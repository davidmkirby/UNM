%% problem 1
syms x %create symbolic variable
y=sin(x); % y is function of x
fplot(y,[0 2*pi]) % figure using the fplot



%% problem 2
syms x % create symbolic variable 
f=@(n)simplify((-1).^n*exp(x.^2)*diff(exp(-x.^2),n)); % symbolic function handle using diff,simplify and matlabFunction 
b=4; % upper boundaries for x
a=-4; % lower boundaries for y
figure  % figure for the 10 hermite polynomial 
fplot(f(0),[a b])
hold on 
fplot(f(1),[a b])
fplot(f(2),[a b])
fplot(f(3),[a b])
fplot(f(4),[a b])
fplot(f(5),[a b])
fplot(f(6),[a b])
fplot(f(7),[a b])
fplot(f(8),[a b])
fplot(f(9),[a b])
ylim([-20 20]); % setting boundaries for the y axis 
legend('n=0','n=1','n=2','n=3','n=4','n=5','n=6','n=6','n=7','n=8','n=9') % appropriate legend for determining hermite 
title('Hermite Physicists Polynomials') % title of the plot
xlabel('x') % labelling the x-axis
ylabel('H_n(x)') % Hermite polynomial 

%% problem 3 
% psiX (x) = Nn*Hn*sqrt(a)*x*exp(?a*x.^2/2)) energy eigen function for 1
% d... harmonic oscillator
% constant a=(m*k/hbar).^(1/2)
% Nn normalization constant= (a/pi).^(1/4)*sqrt(1/(2.^n*n!))
% Hn is the nth hermite physicist polynomial taken from the problem 2
syms x
m=1;
k=1;
hbar=1;
omega=sqrt(k/m);
En=@(n)hbar*omega(n+.5);
a=(m*k/hbar.^2).^(1/2); % k=1,hbar=1,m=1
Nn= @(n)(a/pi).^(1/4)*sqrt(1/(2.^n*factorial(n)));%normalization constant
f=@(n)simplify((-1).^n*exp(x.^2)*diff(exp(-x.^2),n)); % hermite polynomial 
Hn=@(n)f(n);
%Energy Eigenstate calculator
psiX=@(n)Nn(n)*Hn(n)*sqrt(a)*x*exp(-a*(x.^2)/2)
NSampling=100;      %Sampling of wavefunctions 
NExp=20;            %Max energy eigenstate used in expansion
End=10;
X=linspace(-End,End,NSampling);
DX=X(2)-X(1);

figure
for nn=1:NExp
    hold on
    fplot(psiX(nn),[-End End])
end

%Show our wave packet
X0=0;
Sigma=0.1;
Psi0=normpdf(X,X0,Sigma);
figure
plot(X,Psi0,'Linewidth',2)
xlabel('X')
ylabel('\phsi(X)')


%Projection of wave packet onto energy eigenstates
C=zeros(NExp,1);
a=[];
L=matlabFunction(psiX);
for ii=1:NExp
    a(ii)=L(ii)
end
for nn=1:NExp
   C(nn)=dot(PsiX(nn),Psi0)*DX; 
end

%Rebuild wave packet and compare
P=0;
for nn=1:NExp
   P=P+C(nn)*PsiX(nn);
end

hold on
plot(X,P,'r--','Linewidth',2)
legend('Raw','Expansion')

%% problem 4 & 5
% individual file and code is submitted





%% Extra credit 1


% 3D Ising Model



clc
close all
clear all

Beta=1;         %1/KbT
J=-.2;            %Interaction Strength
B=2;            %Magnetic Field
N=8;           %Number of spins

%Start with random orientation
Spins=double(randn(N,N,N)>0);
Spins(Spins==0)=-1;

%Plot Spins
x=(1:N)';
y=(1:N)';
z=(1:N)';
[X,Y,Z]=meshgrid(x,y,z);
z=Spins(x,y,z);
FigHu=figure;
FigHu.Position=[200,300,900,400];
quiver3(X,Y,Z,X*0,Y*0,z,'linewidth',2)
V=sprintf('Beta=%g, J=%g, B=%g',Beta,J,B);
title(V)

%Run Markov Chain Monte Carlo
NChain=100000;
for ii=0:NChain
    ii=ii+1;    %counter for display
    
    %Make Test Jump
    %PickSite and Flips Spin
    IDX=ceil(N*rand);
    IDY=ceil(N*rand);
    IDZ=ceil(N*rand);
    SpinsTest=Spins;
    SpinsTest(IDX,IDY,IDZ)=-Spins(IDX,IDY,IDZ);
    
    %Energy from nearest neighbor interactions
    E_Spin3D=J*(sum(sum(sum(Spins(1:end-1,:,:).*Spins(2:end,:,:)))))+...
        sum(sum(sum(Spins(1,:,:).*Spins(end,:,:))))+...
        sum(sum(sum(Spins(:,1:end-1,:).*Spins(:,2:end,:))))+...
        sum(sum(sum(Spins(:,1,:).*Spins(:,end,:))))+...
        sum(sum(sum(Spins(:,:,1:end-1).*Spins(:,:,2:end))))+...
        sum(sum(Spins(:,:,1).*Spins(:,:,end)));
    
    E_SpinTest3D=J*(sum(sum(sum(SpinsTest(1:end-1,:,:).*SpinsTest(2:end,:,:)))))+...
        sum(sum(sum(SpinsTest(1,:,:).*SpinsTest(end,:,:))))+...
        sum(sum(sum(SpinsTest(:,1:end-1,:).*SpinsTest(:,2:end,:))))+...
        sum(sum(sum(SpinsTest(:,1,:).*SpinsTest(:,end,:))))+...
        sum(sum(sum(SpinsTest(:,:,1:end-1).*SpinsTest(:,:,2:end))))+...
        sum(sum(sum(SpinsTest(:,:,1).*SpinsTest(:,:,end))));

    %Energy from Interactions with feild
    E_Field=-B*sum(Spins(:));
    E_FieldTest=-B*sum(SpinsTest(:));
    
    %Total Energy (Hamiltonian)
    H=E_Spin3D+E_Field;
    HTest=E_SpinTest3D+E_FieldTest;
    
    %Test acceptance probability for Metropolis-Hastings
    Alpha=exp(-Beta*(HTest-H));
    
    %Metropolis-Hastings rule
    if rand()< (Alpha)
        Spins(IDX,IDY,IDZ)=-Spins(IDX,IDY,IDZ);
    end
    
        ShowIter=1000;
    %Show every ShowIter interations
    if ii/ShowIter==round(ii/ShowIter)
        figure(FigHu);
        hold off
        x=(1:N)';
        y=(1:N)';
        z=(1:N)';
        [X,Y,Z]=meshgrid(x,y,z);
        z=Spins(x,y,z);
        quiver3(X,Y,Z,X*0,Y*0,z,'linewidth',2)
        title(V)
        hold on
        quiver3(0,0,0,0,0,B,'linewidth',2)
        legend('Spins','Field')
        pause(.1)
    end
end




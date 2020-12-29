%% Problem 1
% create class to find minimum value of the function using different method
%use of newton method to find the minumum value of the function 

Mymin=Sapkota_HW6_Minifunclass();
Mymin.f=@(x)cos(x); % function 
Mymin.fp1=@(x)-sin(x); % function 1st derivative 
Mymin.fp2=@(x)-cos(x); % function 2nd derivative
Mymin.X0=3*pi/4; %intial condition guess
Mymin.Newton() % calling function from class to calculate minimum value

%% Problem 2 
% Use of Secant Method to find the minimum value of the function 
Mymin=Sapkota_HW6_Minifunclass(); % calling for the class 
Mymin.f=@(x)cos(x); % function 
Mymin.fp1=@(x)-sin(x); % function 1st derivative 
Mymin.fp2=@(x)-cos(x); % function 2nd derivative
Mymin.X0=3*pi/4; %intial condition guess
Mymin.Secant()

%% Problem 3
% Using Golden Search Method to find the minimum value of the Function
Mymin=Sapkota_HW6_Minifunclass();
Mymin.f=@(x) cos(x);
%The Golden Ratio b/a
Mymin.Theta=(1+sqrt(5))/2; % This value is fixed for golden search method
%Setup our intial intrvals
Mymin.X(1)=1;
Mymin.X(3)=5;
Mymin.cons=1/(1+Mymin.Theta); % constant got from a/(a+b)
Mymin.X(2)=(Mymin.X(3)-Mymin.X(1))*Mymin.cons+Mymin.X(1);
Mymin.X=[Mymin.X(1) Mymin.X(2) Mymin.X(3)]; % array X=[X(1) X(2) X(3)]
Mymin.F=Mymin.f(Mymin.X); % F=[F(1) F(2) F(3)]
Mymin.Goldensear() 





%% Problem 4
% finding square root of 10 using newton method
Mymin=Sapkota_HW6_Minifunclass(); % calling for the classs
Mymin.f=@(x)0.5*x.^2-sqrt(10)*x;  %function
Mymin.fp1=@(x)x-sqrt(10); %function derivative
Mymin.fp2=@(x)1; %1function second derivative
Mymin.X0=10; %intial guess
Mymin.Newton() 

%% Problem 5
% finding Solution to x=tanx using newton method
f=@(x)tan(x)-x;  %function
fp1=@(x)(sec(x)).^2-1; %function derivative
% Make a starting guess. 
% the solution depend upon intial value you
% tan is transcental function 
X0=4.7;
N=0;    %keep track of number of iterations required
X=X0;   %X starts at initial guess, X0
Y=f(X);
clc
%Loop until we are within Ytol of zero
for i=1:1000
    %This is Newton update formula
    X=X-f(X)/fp1(X);
 
end
X

 






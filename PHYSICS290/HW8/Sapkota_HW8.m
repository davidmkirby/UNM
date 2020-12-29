%% Problem 1
clear all
clc
%loading data from the inClass8Data.Mat
load('InClass8Data.mat')
%calling class for computation
Myfit=fitClassSkeleton();
Myfit.Tvec=Tvec; % Tvec for the class from the Data
Myfit.Data=Data; % Data for the class from the file
Myfit.title="3 Parameter fit"; %title for the particular fit
%Theta0=[y0 v0 a0] from the guess work
Myfit.Theta0=[Data(1) (Data(2)-Data(1))/(Tvec(2)-Tvec(1)) -9.8 ];
%y=y0+v0*t+1/2*a0.^2 formula for the function
Myfit.FuncH=@(Theta,Tvec)Theta(1)+Theta(2)*Tvec+0.5*Theta(3)*Tvec.^2;
Myfit.fitData(); % calling fit data for plotting 


Myfit=fitClassSkeleton();
Myfit.Tvec=Tvec;
Myfit.Data=Data;
Myfit.title="2 Parameter fit";
%Theta0=[y0 v0] from the guess work
Myfit.Theta0=[Data(1) (Data(2)-Data(1))/(Tvec(2)-Tvec(1))];
%y=y0+v0*t+ formula for the function
Myfit.FuncH=@(Theta,Tvec)Theta(1)+Theta(2)*Tvec;
Myfit.fitData(); % calling the function for computation


%% Problem 2
load('InClass8Data.mat')
% 3 parameter
Myfit=fitClassSkeleton();
Myfit.Tvec=Tvec;
Myfit.Data=Data;
%intial value
Myfit.Theta0=[Data(1) (Data(2)-Data(1))/(Tvec(2)-Tvec(1)) -9.8 ];
Myfit.FuncH=@(Theta,Tvec)Theta(1)+Theta(2)*Tvec+0.5*Theta(3)*Tvec.^2;
Myfit.Stderr();%calling function to calculate standard deviation
%Standard Deviation in Acceleration
standinA=Myfit.SEinA
%Standard Deviation in Velocity
standinV=Myfit.SEinV
%Standard Deviation in Distance
standinY=Myfit.SEinY



% 2 parameter
Myfit=fitClassSkeleton();
Myfit.Tvec=Tvec;
Myfit.Data=Data;
Myfit.Theta0=[Data(1) (Data(2)-Data(1))/(Tvec(2)-Tvec(1))];
Myfit.FuncH=@(Theta,Tvec)Theta(1)+Theta(2)*Tvec;
Myfit.Stderr();
%Standard Deviation in Velocity
standinV=Myfit.SEinV
%Standard Deviation in Distance
standinY=Myfit.SEinY



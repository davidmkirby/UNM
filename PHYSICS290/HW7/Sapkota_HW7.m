%%  Problem 1 
%generating random value for x
x = randn(1000,1);     
%Predefining the bins
nbins = 50;             
xbins = 100;
%figure to show identical by calling to new function 
figure                  %creat a new figure window to show identical 
SapkotaHW7_hist(x)           %call to new function of SapkotaHW7_hist 
figure
SapkotaHW7_hist(x,nbins)
figure
SapkotaHW7_hist(x,xbins)
figure
counts = SapkotaHW7_hist(x)
figure
[counts,centers] = SapkotaHW7_hist(x)

%% Problem 2
n=zeros(1000,1);
for aa=1:1000;
    n(aa)=sum(rand(12,1))-6;
end

hist(n)

% central limit theorem tells that when independent random variable are
% added their properly normolized sum tends towards normal distribution
% even original values are not normally distributed
%The variance is 1/12(b-a)^2 in our problem 2
%b=6, a=0 variance=3

%% Problem no 3
clear all
clc 
% f(A)=A*T -Y(T)=0 solve this to find A using T and A values '' critical
% points''
Data=importdata('HW7_Data.mat');
Tvec=Data.T;
Yvec=Data.Y;
figure
findcri=Sapkota_HW6_Minifunclass(); % use of my class from HW_6 for newton method
findcri.X0=2; % intial guess
findcri.f=@(x)(x.^2)-6.227*x;
findcri.fp1=@(x)x*2-6.227;
findcri.fp2=@(x)2;
findcri.Newton();
close all
A=3.1135; % This is the value that i get from newton method
figure
scatter(Tvec,Yvec)
hold on 
Yres=@(x)A*x;
plot(Tvec,Yres(Tvec));
xlabel('TVec')
ylabel('Y')

%% problem 4
n=1000; %no of step
Ra=randi([1,10],1,n);
length=10; % length of the square 
xvec=zeros(1,n);
yvec=zeros(1,n);
xvec(1)=1;
yvec(1)=1;
figure % this part is the just the plot of the square region
plot([-length length],[length length],'r','linewidth',3)
hold on 
plot([length length],[length -length],'r','linewidth',3)
plot([length -length],[-length -length],'r','linewidth',3)
plot([-length -length],[-length length],'r','linewidth',3)

%intial point
plot(xvec(1),yvec(1),'mo')
hold on

for aa=2:n
    %This is for the x axis movement
    if xvec(aa-1)== -length %coming from the negative side of the square
        xvec(aa)=xvec(aa-1)+1;
    elseif xvec(aa-1)== length %coming from the positive side of the square
        xvec(aa)=xvec(aa-1)-1;
    elseif rem(Ra(aa),2)==0
        xvec(aa)=xvec(aa-1)+1;
    else
        xvec(aa)=xvec(aa-1)-1;
    end
    %similarly for the y co-ordinate
      if yvec(aa-1)== -length
        yvec(aa)=yvec(aa-1)+1;
    elseif yvec(aa-1)== length
        yvec(aa)=yvec(aa-1)-1;
    elseif rem(Ra(aa),2)== 0
        yvec(aa)=yvec(aa-1)+1;
    else
        yvec(aa)=yvec(aa-1)-1;
      end
      % plot for the movement of the dot
      plot(xvec(aa),yvec(aa),'y*')
      plot([xvec(aa-1) xvec(aa)], [yvec(aa-1) yvec(aa)])
      pause(0.00001)
      end
    







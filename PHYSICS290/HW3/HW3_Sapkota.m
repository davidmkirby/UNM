%% Problem 1
clc
f=@(X)cos(X); % This is an anonymous function 
N=20;
% help HW3_Sapkota_myIntFunc for problem 2,3,4
%% Problem 2
sumintegral1 = HW3_Sapkota_myIntFunc(f,N,'Trapezoid');
%% Problem 3
sumintergral2 = HW3_Sapkota_myIntFunc(f,N,'Midpoint');

%% Problem 4
sumintegral3= HW3_Sapkota_myIntFunc(f,N,'Simpson');

 %% problem 5 Extra credit Error analysis
 hold off

N=20:20:100;
errTrapezoid=[]; %creating the error zero matrix
errMidpoint=[];
errSimpson=[];
exactint=0;
subinterval=[];
for aa=1:5
    errTrapezoid(aa)=exactint-HW3_Sapkota_myIntFunc(f,N(aa),'Trapezoid'); % error in each N for trapezoid
    errMidpoint(aa)=exactint-HW3_Sapkota_myIntFunc(f,N(aa),'Midpoint'); % error in each N for Midpoint
    errSimpson(aa)=exactint-HW3_Sapkota_myIntFunc(f,N(aa),'Simpson');% error in each N for simpson
    subinterval(aa)=pi/N(aa);
end
figure
loglog(subinterval,errTrapezoid,'bv-',N,errMidpoint,'gv-',N,errSimpson,'rv-')
hold on

xlabel('subinterval')
ylabel('error')
set(gca,'fontsize', 10); 
legend('Error in Trapezoid','Error in Midpoint','Error in Simpson','N^2','N^2','N^4')


 

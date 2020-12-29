close all
clear all 
% program to plot relative error vs sub-interval 
x = load('data.txt');
set(gca,'fontsize',20)
loglog(x(:,1),x(:,2:5),'*',x(:,1),x(:,1).^-3,x(1:50,1),10.3.^(-0.35.*x(1:50,1)),x(1:20,1),2.45.^(-1.8.*x(1:20,1)),'--','linewidth',1)
xlabel('Number of Sub - Interval(n)')
ylabel('Relative Error')
legend('Trapezoidal, k = \pi','Trapezoidal, k = \pi^2','Gauss-Quadrature, k = \pi','Gauss-Quadrature, k = \pi^2','1/n^3','10.3^{-0.35n}','2.45^{-1.8n}')
title('LOGLOG plot of Error vs Number of Sub Interval')
  grid on;
axis = [0 1500 10^-18 10];


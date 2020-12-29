clear all
close all
randn('seed',100) 
[X,Y]=data(100,1.5);
%we will create matrix which can be used later in calculation
x_center = 0;
y_center = 0;
center = transpose(repmat([x_center; y_center], 1, length(X)));
%we do 90 degree counter-clockwise rotation matrix 
theta = pi/2;       
v = X(:,1:2);

%%
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
so = R*v';           % apply the rotation about the origin
vo = so';
%%

X(:,1) = vo(:,1);
X(:,2) = vo(:,2);

i1=find(Y==1);
i2=find(Y==-1);
figure(1)
figure(1)
 plot(X(1,i1),X(2,i1),'s')
 hold all 
 plot(X(1,i2),X(2,i2),'r*')
xlabel('x[n-1]')
ylabel('x[n]')

hold on
%%

%Training_the_Datasets          
x_2=X(1,:);
x_3=X(2,:);
%Non-Linear Transformation(3rd Order)
Volterra_eqn_train=[ones(1,100);x_2;x_3;x_2.^2;x_3.^2;x_2.*x_3;(x_2.^2).*x_3;(x_3.^2).*x_2;x_2.^3;x_3.^3];
pi= Volterra_eqn_train * Volterra_eqn_train';
w=pinv(pi)*Volterra_eqn_train*Y';
y=w'*Volterra_eqn_train;
%Testing_the_datasets
%Grid/ Xn_2 and Xn_3 Vectors
[Xn_2,Xn_3] = meshgrid(linspace(-3,3,100), linspace(-3,3,100));    
x_2=Xn_2(:)';
x_3=Xn_3(:)';
%3rd Order/ Tranformation
volterra_eqn_test=[ones(1,100.^2);x_2;x_3;x_2.^2;x_3.^2;x_2.*x_3;(x_2.^2).*x_3;(x_3.^2).*x_2;x_2.^3;x_3.^3];
y_n=w'*volterra_eqn_test; 
%Buffering Vector into Matrix
b = buffer(y_n,size(Xn_2,1),0); 
%Contour Plot for Matrix
contour(Xn_2,Xn_3,b,[0 0],'LineWidth',3,'Color','k')


 
function [X,y]=data(N,a)
N=N+1;
y=sign(randn(1,N));
x=filter([1 a],1,y)+0.2*randn(size(y));
X=buffer(x,2,1,'nodelay'); %Convolution
y=y(2:end)
end

%Generating Random Numbers with a Seed 
randn('seed',100) 
clear all
y=sign(randn(1,101));
a=1.5;
x=filter([1 a],1,y)+0.2*randn(size(y));
%to determine Symbol 
X=buffer(x,2,1,'nodelay'); 
i1=find(y(2:end)==1);
i2=find(y(2:end)==-1);
%Mat_Ploting the Dataset 
figure(1)
 plot(X(1,i1),X(2,i1),'s')
 hold all 
 plot(X(1,i2),X(2,i2),'r*')
 %Labeling Names
 xlabel('x[n-1]')
 ylabel('x[n]')
Y=y(2:end);
 
%Training_the_Datasets 
Gamma=10;
x_2=X(1,:);

K_1=(X'*X+1).^3;
Alpha=pinv(K_1'*K_1)*Y';
y=Alpha'*K_1;
 
%Testing_the_datasets
%Grid/ Xn_2 and Xn_3 Vectors
[G1,G2] = meshgrid(linspace(-4,4,100), linspace(-4,4,100));    
x_2=G1(:)';
y_1=G2(:)';
x_3=[x_2' y_1']';
%Dot Products B\W Data for Test_sets 
K_2=(X'*x_3+ 1).^3;
Y1=Alpha'*K_2;
%Array_Reshap_Dimesions Size
R=reshape(Y1,size(G1));
 
%Contour Plot for Matrix
contour(G1,G2,R,[0 0],'LineWidth',3,'Color','Green')

saveas(gcf,'kernalclassificat.pdf')                 

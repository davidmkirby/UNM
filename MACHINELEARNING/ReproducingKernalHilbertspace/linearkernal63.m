%Generating Random Numbers with a Seed 
randn('seed',54432) 
clear all
y=sign(randn(1,101));
a=1.5;
x=filter([1 a],1,y)+0.2*randn(size(y));
%to determine Symbol 
X=buffer(x,2,1,'nodelay'); 
i1=find(y(2:end)==1);
i2=find(y(2:end)==-1);
%Mat_Plot the Dataset 
figure(1)
 plot(X(1,i1),X(2,i1),'s')
 hold all 
 plot(X(1,i2),X(2,i2),'r*')
 %Labeling Names
 xlabel('x[n-1]')
 ylabel('x[n]')

saveas(gcf,'trainingdata.pdf')
 %%

Y=y(2:end);
%Mapping into Kernel
[G1,G2] = meshgrid(linspace(-3,3,100), linspace(-3,3,100)); 
%Training_the_Model
x_1=X(1,:);
%Testing_the_model
x_1=G1(:)';
y_1=G2(:)';
x_3=[x_1' y_1']';
%HD_Kernel_RBF_Function/ From_Library. 
K_Exp_1=kernelmatrix('lin',X,X,1);
%Non-Linear_SVM_Classfier
SVM=svmtrain(Y',[(1:length(Y))',K_Exp_1], '-s 0 -t 4 -c  100')
idx=SVM.sv_indices';
coff=SVM.sv_coef';
 
Alpha=zeros(1,100);
j=0
for i=1:51
    j=idx(i)
    Alpha(j)=coff(i);
    j+1
end 
y=Alpha*K_Exp_1;
 
%Dot Products B\W Data for Test_sets 
%Matrix_RBF_Function
K_Exp_2=kernelmatrix('lin',X,x_3,1);
Y_1=Alpha*K_Exp_2;
%Array_Reshap_Dimesions Size
R=reshape(Y_1,size(G1));
 
%Contour Plot for Matrix
contour(G1,G2,R,[0 0],'LineWidth',3,'Color','k')
 saveas(gcf,'linearclassifer.pdf')

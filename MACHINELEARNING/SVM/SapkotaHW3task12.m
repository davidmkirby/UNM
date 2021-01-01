c=[1,1;2,1.5;2,1;3,1.5];
N=10;
X=[];
sigma=1 ;
for i=1:4
X=[X;sigma*randn(N,2)+repmat(c(i,:),N,1)];
end
Y=[ones(1,2*N) -ones(1,2*N)]';
c_param=[0.1 1 10 100 ];
for j=1:length(c_param)
libsvm_options=['-s' ' ' num2str(0) ' ' '-t' ' ' num2str(0) ' ' '-c' ' ' num2str(c_param(j))];
model=svmtrain(Y,X,libsvm_options);
predict=svmpredict(Y,X,model,'-b -0 ');

b=model.rho;
w=model.SVs'*model.sv_coef;

YY=-(w(1)*X(:,1)-b)/w(2);
YY_plus=-(w(1)*X(:,1)-b-1)/w(2);
YY_minus=-(w(1)*X(:,1)-b+1)/w(2);
error=0;
for i =1: length(Y)
   if Y(i)~= predict(i)
       error=error+1;
   end
end
error=(error/length(Y))*100;
plot(X(1:end/2,1),X(1:end/2,2),'+')
hold all
plot(X(end/2+1:end,1),X(end/2+1:end,2),'o')
hold on
plot(X(:,1),YY_plus,'-b','linewidth',2)
plot(X(:,1),YY_minus,'-r','linewidth',2)
plot(X(:,1),YY,'-g','linewidth',2)
title(['\sigma = ' num2str(sigma),' c = ' num2str(c_param(j)) ])
ylim([-4 4])
hold off
pause 
end



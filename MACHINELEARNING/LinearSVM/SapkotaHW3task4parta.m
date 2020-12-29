clear all

for k=1:length(logspace(-1.5,1,100))
c_param=logspace(-1.5,1,100);
for j=1:100
c_param(k)
[X_train,Y_train]=data(100,1);

libsvm_options=['-s' ' ' num2str(0) ' ' '-t' ' ' num2str(0) ' ' '-c' ' ' num2str(c_param(k))]
model=svmtrain(Y_train,X_train,libsvm_options);
predict_train=svmpredict(Y_train,X_train,model,'-b 0 ');

[X_pred, Y_pred]=data(1000,1);
predict=svmpredict(Y_pred,X_pred,model,'-b -0 ');


error_trainscalar=0;
for i =1: length(Y_train)
   if Y_train(i)~= predict_train(i)
       error_trainscalar=error_trainscalar+1;
   end
end
error_train(j)=(error_trainscalar)/length(Y_train)*100;


errorscalar=0;
for i =1: length(Y_pred)
   if Y_pred(i)~= predict(i)
       errorscalar=errorscalar+1;
   end
end

error(j)=(errorscalar/length(Y_pred))*100;
end
% error_train=sum(error_train)/100
error_train_indexed(k)=sum(error_train)/length(error_train);
error_indexed(k)=sum(error)/length(error);
diff_error(k)=-error_train_indexed(k)+error_indexed(k);

end
semilogx(c_param,error_train_indexed,'-b','linewidth',2)
hold on
semilogx(c_param,error_indexed,'-g','linewidth',2)
semilogx(c_param,diff_error,'-r','linewidth',2)
legend('Training Error','Test Error','Difference of two Error')
xlabel('C')
ylabel('Error')
saveas(gcf,'varyingC.jpeg')
hold off


function [X,Y]=data(N,sigma)
w=ones(1,10)/sqrt(10);
w1=w.*[ 1 1 1 1 1 -1 -1 -1 -1 -1];
w2=w.*[-1 -1 0 1 1 -1 -1 0 1 1];
w2=w2/norm(w2);
x(1,:)=zeros(1,10);
x(2,:)=x(1,:)+sigma*w1;
x(3,:)=x(1,:)+sigma*w2;
x(4,:)=x(3,:)+sigma*w1;
X1=x+sigma*repmat(w,4,1)/2;
X2=x-sigma*repmat(w,4,1)/2;
X1=repmat(X1,2*N,1);
X2=repmat(X2,2*N,1);
X=[X1;X2];

Y=[ones(4*2*N,1);-ones(4*2*N,1)];
Z=randperm(8*2*N);
Z=Z(1:N);
X=X(Z,:)+0.2*sigma*randn(size(X(Z,:)));
Y=Y(Z);
end
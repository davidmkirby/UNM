clear all
close all

load out.txt
figure()
loglog(out(:,1),out(:,2),'r','linewidth',2);
hold on;
loglog(out(:,1),out(:,1).^2,':k','linewidth',2);
xlabel('h_{effective}')
ylabel('Max Error')
legend('Error','h_{effective}^2')
title('Function-3 grid-3')
hold off;
print('error-inlaplace3.jpg','-djpeg');

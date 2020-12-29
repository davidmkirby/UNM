clear all
close all

load out.txt
figure()
loglog(out(:,1),out(:,2),'r','linewidth',2);
hold on;
loglog(out(:,1),out(:,1).^2,':k','linewidth',2);
xlabel('h_{effective}')
ylabel('Error')
legend('Error','h_{effective}^2')
title('Function-2 Error')
hold off;
print('error-in-6.jpg','-djpeg');

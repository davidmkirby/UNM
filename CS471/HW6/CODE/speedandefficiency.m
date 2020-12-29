% time plot for strong scalling 
clear all
close all
load strong20.txt;
load strong800.txt;

loglog(strong20(:,1),strong20(:,2),'-.r*','linewidth',2);
hold on 

loglog(strong800(:,1),strong800(:,2),'-.b*','linewidth',2);
axis equal
xlabel('Np');
ylabel('Time take');
legend('Grid size=20',' Grid size = 800');
title('loglog plot of Strong Scalling timing vs core');
print('timing-strongscaling.jpeg','-djpeg');

hold off
%% strong speed up 

loglog(strong20(:,1),strong20(1,2)./strong20(:,2),'-.r*','linewidth',2);
hold on 

loglog(strong800(:,1),strong800(1,2)./strong800(:,2),'-.b*','linewidth',2);

axis equal
xlabel('Np');
ylabel('SpeedUp');
legend('Grid size=20-strong scale',' Grid size = 800-strong scale');
title('loglog plot of speed up vs no. of core');
print('Speedupstrong.jpeg','-djpeg');

hold off
%% strong scalling efficiency

loglog(strong20(:,1),strong20(1,2)./(strong20(:,2).*strong20(:,1)),'-.r*','linewidth',2);
hold on 

loglog(strong800(:,1),strong800(1,2)./(strong800(:,2).*strong800(:,1)),'-.b*','linewidth',2);

axis equal
xlabel('Np');
ylabel('Efficiency');
legend('Grid size=20-strong scale',' Grid size = 800-strong scale');
title('loglog plot of Efficiency vs no. of cores');
print('Efficiencystrong.jpeg','-djpeg');
hold off
%%
% time plot for weak scalling 
load weak200.txt;
loglog(weak200(:,1),weak200(:,2),'-.g*','linewidth',2);
xlabel('Np');
ylabel('Time take');
axis equal 
title('loglog plot of Weak scaling timing vs cores');
print('timing-weakscaling.jpeg','-djpeg');


%% weak scalling speedup
loglog(weak200(:,1),weak200(1,2)./weak200(:,2),'-.g*','linewidth',2);
axis equal
xlabel('Np');
ylabel('SpeedUp');
legend('Grid size= sqrt(Np)*200');
title('loglog plot of speed up vs no. of cores');
print('Speedupweak.jpeg','-djpeg');
hold off
%% weak scalling efficiency
loglog(weak200(:,1),weak200(1,2)./(weak200(:,2).*weak200(:,1)),'-.g*','linewidth',2);
axis equal
xlabel('Np');
ylabel('Efficiency');
legend('Grid size= sqrt(Np)*200');
title('loglog plot of Efficiency vs no. of cores');
print('Efficiencyweak.jpeg','-djpeg');
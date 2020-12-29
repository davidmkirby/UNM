clear all
close all
load strong2000.txt;
loglog(strong2000(:,1),strong2000(:,2),'-.r*','linewidth',2);

axis equal
xlabel('Np');
ylabel('SpeedUp');
legend('Grid size=2000-strong scale');
title('loglog plot of timing vs Np');
print('timing2000.jpeg','-djpeg');
hold off 
%%
loglog(strong2000(:,1),strong2000(1,2)./strong2000(:,2),'-.r*','linewidth',2);
axis equal
xlabel('Np');
ylabel('SpeedUp');
legend('Grid size=2000-strong scale');
title('loglog plot of speed up vs Np');
print('Speedup2000.jpeg','-djpeg');

%%
loglog(strong2000(:,1),strong2000(1,2)./(strong2000(:,2).*strong2000(:,1)),'-.r*','linewidth',2);

axis equal
xlabel('Np');
ylabel('Efficiency');
legend('Grid size=2000-strong scale');
title('loglog plot of Efficiency vs Np');
print('Efficiency2000.jpeg','-djpeg');

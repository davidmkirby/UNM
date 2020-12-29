clear all
close all
load x.txt 
load y.txt 

plot(x,y,'k',x',y','k')
axis equal
title('Function-0 Grid')
print('grid_6.jpeg','-djpeg');



clear 
clf

x = linspace(-1,1,120);
y = exp(1/2-sin(5*pi*x));

plot(x,y)
print -depsc2 lab1.eps
%Following code is utilized to perform regression using gaussian process
%software
% Audthor- Susan Sapkota 
% Assignment 7.1
clear all;
meanfunc = [];                             % empty: don't use a mean function
covfunc = {@covSum,{@covLIN,@covConst}};   % Linear covariance function
likfunc = @likGauss;                       % Gaussian likelihood
hyp = struct('mean', [],'cov', 0, 'lik', -1);
N=50;
x=rand(N,1);
y=0.5*x+0.5+0.1*randn(size(x));
hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
xs=(0:0.1:1)';
[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);
f = [mu+2*sqrt(s2); flipdim(mu-2*sqrt(s2),1)];
hold on
f1 = [mu+sqrt(s2); flipdim(mu-sqrt(s2),1)];
fill([xs; flipdim(xs,1)], f,[7 7 7]/8)
p1 = plot([xs; flipdim(xs,1)], f,"--")
hold on;
fill([xs; flipdim(xs,1)], f1, [7 7 7]/8)
hold on;
plot(xs, mu,"-o","MarkerEdgeColor","k","MarkerFaceColor","k",'Color','k');
hold on
plot(x, y, 'o')
hold on
p2 = plot([xs; flipdim(xs,1)], f1,"--",'linewidth',2)
hold on
leg1 = legend([p1 p2],'$2-\sigma  $ band','$1-\sigma $ band')
set(leg1,'Interpreter','latex');
xlabel('X')
ylabel('y')

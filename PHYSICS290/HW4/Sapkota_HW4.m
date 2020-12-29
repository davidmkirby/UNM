%% Problem 1
T=30;
Dt=0.01;

%Spring Mass system
k=20;
m=10;
vp=@(x)-(k/m)*x; % function for v
Fp=@(v) v; % function for x

%Setup
T0=0;
Tvec=(T0:Dt:T);
X=zeros(length(Tvec),1);
V=zeros(length(Tvec),1);

X0=15;
V0=0;

X(1)=X0;
V(1)=V0;

% we update both velocity and position while integration
for tt=2:length(Tvec)
    X(tt)=X(tt-1)+Fp(V(tt-1))*Dt;
    V(tt)=V(tt-1)+vp(X(tt-1))*Dt;
    diff(tt)=X0-X(tt); % to calculate the frequency
end
figure
% calculated value plot
plot(Tvec,X)
xlabel('t')
ylabel('X(t)')
% exact plot
ExactT=linspace(T0,T,10000);
ExactX=X0*cos(sqrt(k/m)*ExactT);
hold on
plot(ExactT,ExactX)
legend('Numerical','Exact')
% calculating where the object come to same position and calculating the
% time period to get frequency
idx=find(abs(diff)<10e-3);
T_period=idx(5)*Dt*2;
CalculatedF=1/T_period

ExactF=sqrt(m/k)./(2*pi)


%% Problem 2
T=30;
Dt=0.1;

%Spring Mass system
k=20;
m=10;
vp=@(x)-(k/m)*x;
Fp=@(v) v;



% NEW: Creating VideoWriter object
vidObj = VideoWriter('peaks.avi');
open(vidObj);%open the file for writing
axis tight %setting the axis
set(gca,'nextplot','replacechildren');


for aa=linspace(1,10,100)
    %T0=0;
    %figure(1)
    Tvec=(aa:Dt:T+aa);
    X=zeros(length(Tvec),1);
    V=zeros(length(Tvec),1);
    
    X0=15;
    V0=0;
    
    X(1)=X0;
    V(1)=V0;
    
    % we update both velocity and position while integration
    for tt=2:length(Tvec)
        X(tt)=X(tt-1)+Fp(V(tt-1))*Dt;
        V(tt)=V(tt-1)+vp(X(tt-1))*Dt;
        figure(1)
    plot(Tvec,X)
    xlabel('t')
    ylabel('X(t)')
    currFrame = getframe();
    writeVideo(vidObj,currFrame);
    hold off
    pause(Dt);
    end
      
end
close(vidObj);


%% Problem 3
% demonstrate use of log log both x-axis and y-axis logarithmic scale
t=logspace(1,2,100); % creating grid with log on x-axis
y=exp(t);
figure(1)
loglog(t,y) %plot
hold off
% Demonstrate use of semilogx
% logarithmic scale for the x-axis only
x = 10:100000;
y = log(x);
figure(2)
semilogx(x,y,'r')
hold off

% Demonstrate use of semilogy
% logarithmic scale for the y-axis only
x=0:10;
y=exp(x);
figure(3)
semilogy(x,y,'m');


%% Problem 4

Fp=@(F)-F; %differential equation
%final time
T=12;
Dt=.0001; %step size
T0=0;

Tvec=(T0:Dt:T);
%Intialize results array
F=zeros(length(Tvec),1);
F0=24; %intial value
F(1)=F0;

%This is the integration

for tt=2:length(Tvec)
    F(tt)=F(tt-1)+Fp(F(tt-1))*Dt; %assigning the value for the array F
end
e=[]; % desired
for ii=1:length(Tvec)
    a=0;
    %f(x)=a.^(-x)
    %log(f(x))=-xlog(a)
    %a=10.^[log(f(x))./(-x)]
    a=log(F(ii))./(-Tvec(ii));
    e(ii)=10.^a;
end
mean(e)






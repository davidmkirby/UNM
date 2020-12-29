clear all
clc
N=100;
Spins=double(randn(N,N)>0);
Spins(Spins==0)=-1;
M=IsingModel2Class()
M.Beta=10; %1/KbT
M.J=-0.2;          %Interaction Strength
M.B=0;            %Magnetic Field
M.N=N;%Number of spins
M.Spins=Spins;
M.gui()
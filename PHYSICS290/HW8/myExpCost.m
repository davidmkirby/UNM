function [SSE,Model] = myExpCost(Theta,Data,Tvec)
N=Theta(1);
Tau=Theta(2);
B=Theta(3);
Model=N*exp(-Tvec/Tau)+B;
SSE=sum((Data-Model).^2);
end


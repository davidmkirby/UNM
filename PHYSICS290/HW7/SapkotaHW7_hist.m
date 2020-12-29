function [a,b] = SapkotaHW7_hist(x,y)
%Switching our case if there is one or two input 
switch nargin
    case 1
        hist(x)
    case 2
        hist(x,50)
    
end
switch nargout
    case 1
        a=hist(x) 
    case 2
        [a,b]=hist(x)
    
end
end

classdef fitClassSkeleton < handle
    
    properties
        FuncH
        Theta0
        Data
        Tvec
        FoundTheta
    end
    
    methods
        
        function fitData(obj)
            
            myCost=@(Theta,Data,FuncH,Tvec)...
                sum( (Data-FuncH(Theta,Tvec)).^2);
             
            OPT=optimset();
            
            obj.FoundTheta=fminsearch(myCost,obj.Theta0,...
                OPT,obj.Data,obj.FuncH,obj.Tvec);
        end
    end
end


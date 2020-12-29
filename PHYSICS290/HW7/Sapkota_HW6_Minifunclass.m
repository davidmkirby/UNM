classdef Sapkota_HW6_Minifunclass < handle
    % this class is used to find minimum value of the function
    % using Newton or Secant or Golden Search Method
    
    properties
        f; % given function
        fp1; % function 1st derivative
        fp2; % function 2nd derivative
        X0; % valid guess work near that minimum
        Y; % approximate for the minimum with that guess
         X; % array X=[X(1) X(2) X(3)]
        cons; %value that is calculated with golden ratio. this simply form of a/(a+b)
        F; %F=f(X) 
        Theta; % golden ratio 
        Tvec;
    end
    
    methods
        function Newton(obj) %Newton method function
            Ytol=eps; %iteration tolerence from far side
            N=0; % Number of iteration used to calculate
            X=obj.X0; % intial guess
            Y=obj.fp1(X);
            clc
            Tvec=linspace(0,pi,1000);
            %extra credit problem 
            figure()
            plot(Tvec,obj.f(Tvec))
            hold on
            
            while abs(Y)>Ytol % carryout loop until Ytolerence value
                N=N+1; % increment of the iteration
                
              %This is Newton update formula
                X=X-obj.fp1(X)/obj.fp2(X);
                Y=obj.fp1(X);
                plot([X-1 X],[obj.f(X-1) 0],'linewidth',2 )
                pause(1);
                [X Y]
            end
            X
        end
        function Secant(obj) %Secant method function
            Ytol=eps; %iteration tolerence from far side
            N=0; % Number of iteration used to calculate
            X=obj.X0; % intial guess
            X_old=obj.X0+pi/8;  % This is our X_n-1 for the first step
            Y=obj.fp1(X);
            clc
            figure
        Tvec=linspace(0,pi,1000);
         plot(Tvec,obj.f(Tvec))
       xlabel('Tvec')
      ylabel('fp(Tvec)')
      hold on
            
            while abs(Y)>Ytol % carryout loop until Ytolerence value
                N=N+1; % increment of the iteration
                plot([X_old, X],[obj.f(X_old), obj.f(X)],'m','linewidth',2)
                pause(1);
                XTemp=X; % for storing X_old
                %This is Secant update formula
                X=X-obj.fp1(X)*(X-X_old)/(obj.fp1(X)-obj.fp1(X_old));
                X_old=XTemp;
                
                Y=obj.fp1(X);
            end
            X
        end
          function [X] = GoldenSearch(obj,X,F,f)

% Check if interval is right or left

if (X(2)-X(1))>( X(3)-X(2))
    IntervalSide='Right';
else
    IntervalSide='Left';
end

switch IntervalSide
    case 'Right' 
        % Calculate new X4 value
        X4=X(2)-obj.cons*(X(2)-X(1));
        % Calculate new F4 value
        F4=f(X4);
        
        if F(2)<F4 % Check if F3<F4
            % Return New Interval
            X=[X4,X(2),X(3)];
            obj.F=[F4,F(2),F(3)];
        else
            % Return New Interval
            X=[X(1),X4,X(2)];
            obj.F=[F(1),F4,F(2)];
        end
        
    case 'Left' 
        % Calculate new X4 value
        X4=X(2)+obj.cons*(X(3)-X(2));
        % Calculate new F4 value
        F4=f(X4);
        
        % Check if F3<F4
        if F(2)<F4
            % Return New Interval
            X=[X(1),X(2),X4];
            obj.F=[F(1),F(2),F4];
        else
            % Return New Interval
            X=[X(2),X4,X(3)];
            obj.F=[F(2),F4,F(3)];
        end
       
end


end
        
        function Goldensear(obj)
            

%Set tolerance for convergence.  
TolrX=5*eps;

IntSize=obj.X(3)-obj.X(1);

%Setup the iterative loop and run until convergence
Cnt=1;
% extra credit
figure()
    Tvec=linspace(0,2*pi,1000);
    plot(Tvec,obj.f(Tvec))
    hold on
while IntSize>TolrX
    obj.X = obj.GoldenSearch(obj.X,obj.F,obj.f);
    IntSize=obj.X(3)-obj.X(1);
    Cnt=Cnt+1;
     
    plot([obj.X(1) obj.X(1)],[0 obj.f(obj.X(1))],'r' )
    plot([obj.X(2) obj.X(2)],[0 obj.f(obj.X(2))],'m','linewidth',1 )
    plot([obj.X(3) obj.X(3)],[0 obj.f(obj.X(3))],'k' )
    hold on
    pause(0.1);
end
obj.X(1)

        end
        
        
    end
    
    
end



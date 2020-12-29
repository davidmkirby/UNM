function [sumintegral] = HW3_Sapkota_myIntFunc(FuncHandle,N, Method)
% HW3_Integral calculate integral over given interval of the given function
% here function use Midpoint, Simpsons or Trapezoid method in 20 interval
% Function call: [sumintegral] = HW3_Integral(FuncHandle,N,Method)
%   INPUTS
% FuncHandle:  this handle the function to be integrated
% L: lower limit of our integral
% U: upper bound of our integral
%N:no of size interval
% Method: String Variable to choose which method 'MidPoint', 'Trapezoid' or 'Simpson'
%   OUTPUT
% Integral: The calculated integral
% Function also generate the plot showing the subinterval use

switch Method % using switch to choose the method to integrate
    case 'Trapezoid' % if string = Trapezoid it calculate the integral using Trapezoid rule
        L=0; %start of integration interval
        U=pi; %end of integration interval
        X=linspace(0,pi,100);
        Y=FuncHandle(X);
        %plotting the original function
        plot(X,Y);
        xlabel('X');
        ylabel('cos(x)');
        hold on
        H=(U-L)/N; %step-size
        XH=0; % intializing point
        sumintegral=0; % intializing the sum as zero
        for aa= 1:N
            YH=FuncHandle(XH); %calling the function 
            hold on
            % ploting the actual trapezoid in the sub-interval
            plot([XH, XH],[0,YH],'r','linewidth',3); %create the line at XH from o to YH
            plot([XH, XH+H],[YH,FuncHandle(XH+H)],'r','linewidth',3); 
            plot([XH+H, XH+H],[FuncHandle(XH+H),0],'r','linewidth',3);
            plot([XH, XH+H],[0,0],'r','linewidth',3);
            sumintegral=sumintegral+1/2*(FuncHandle(XH)+FuncHandle(XH+H))*H; %adding the area of each trapezoid
            aa=aa+1;
            XH=XH+H;
        end
        sumintegral
        
    case 'Midpoint' % if string = Midpoint it calculate the integral using Midpoint rule
        
        X=linspace(0,pi,100);
        Y=FuncHandle(X); %calling the function
        plot(X,Y);
        xlabel('X');
        ylabel('cos(x)');
        hold on
        L=0; % Lower limit of integration
        U=pi; % upper limit of integration
        H=(U-L)/N; %stepsize
        XH=0; %intializing
        sumintegral=0; %intializing sum
        %plotting the rectangle from the midpoint point
        for aa= 1:N
            plot([XH, XH],[0,FuncHandle(XH+H)],'g','linewidth',3);
            plot([XH, XH+H],[FuncHandle(XH+H/2),FuncHandle(XH+H/2)],'g','linewidth',3);
            plot([XH+H, XH+H],[FuncHandle(XH+H/2),0],'g','linewidth',3);
            plot([XH, XH+H],[0,0],'g','linewidth',3);
            XH=XH+H; % increasing the stepsize
            sumintegral=sumintegral+FuncHandle(XH+H)*H; % adding the area of the sub rectangle
            aa=aa+1;
        end
        sumintegral
        
    case 'Simpson'
        
        
        %Our derived approximation from class
        myPolapprox=@(X,H,Y1,Y2)1/H*(4*Y1-Y2)*X+1/H^2*(2*Y2-4*Y1)*X.^2;
        
        L=0; %start of integration interval
        U=pi; %end of integration interval
        
        
        IntStart=linspace(L,U,N+1); %creating the vector from 0 to Pi with N+1 points
        H=IntStart(2)-IntStart(1); %step size
        
        %plot exact function
        X=linspace(L,U,100);
        figure
        plot(X,FuncHandle(X),'-.g*','linewidth',1);
        hold on
        xlabel('X');
        ylabel('Exact Poly');
        
        %plot Simpson rule appoximtation in each interval
      
        for aa=1:N
            Y1=FuncHandle(IntStart(aa)+H/2)-FuncHandle(IntStart(aa)); %midpoint
            Y2=FuncHandle(IntStart(aa)+H)-FuncHandle(IntStart(aa)); %endpoint
            X=linspace(0,H,100);
            plot(X+IntStart(aa),myPolapprox(X,H,Y1,Y2)+FuncHandle(IntStart(aa)), 'r-','linewidth',1);
        end
        
        %calculate sum of the area using formula
        Interval= (U-L)/N;
        Starts = linspace(L,U-Interval,N);
        Ends = linspace(L+Interval,U,N);
        Mids = (Starts + Ends)/2;
        
        sumintegral=0;
        for bb = 1:N
            
            Startfun1=FuncHandle(Starts(bb));
            Midfun2=FuncHandle(Mids(bb));
            Endfun=FuncHandle(Ends(bb));
            
            %sum of the areas under the polynomial:
            sumintegral=sumintegral+(Ends(bb)-Starts(bb))/6*(Startfun1+4*Midfun2+Endfun); %suming the sum to integral
        end
        sumintegral
        
end


end


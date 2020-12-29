classdef susanHw9class
    
    
    properties
        Model=@(Theta,Tvec)Theta(1)+Theta(2)*Tvec+0.5*Theta(3)*Tvec.^2;
        Sigma
        Theta0
        Likelihood
        FigGUI
        A
        B
        C
        NJumps %Number of jumps in our MCMC chain
        %Make jump  parameters.
        JumpSigma
        Tvec
        Data
    end
    
    methods
        function MCMC(obj)
            % likelihood formula
            obj.Likelihood=@(Theta,Y,T)prod( 1/sqrt(2*pi*obj.Sigma^2)*exp(-(Y-obj.Model(Theta,T)).^2/(2*obj.Sigma^2) ));

            %Theta=[yo vo a]   These are fit parameters

            Chain=zeros(obj.NJumps,length(obj.Theta0));
            Chain(1,:)=obj.Theta0;
            %MCMC with Metropolis Hastings
            %web('https://en.wikipedia.org/wiki/Metropolis%E2%80%93Hastings_algorithm')
            for nn=2:obj.NJumps
                
                Theta = Chain(nn-1,:);
                %Make a test jump
                Theta_Test=Theta+obj.JumpSigma.*randn(1,length(obj.Theta0));
                
                %Accept rate:
                alpha=obj.Likelihood(Theta_Test,obj.Data,obj.Tvec)/obj.Likelihood(Theta,obj.Data,obj.Tvec);
                
                if alpha>rand() %accept and move to next position
                    Chain(nn,:)=Theta_Test;
                else
                    Chain(nn,:)=Theta; %reject and use old position
                end
                
            end
            
            %plot model on data
            FoundTheta=mean(Chain);
            ModelFound=obj.Model(FoundTheta,obj.Tvec);
            
            subplot(2,2,2)
            x = obj.Tvec;
            y2=obj.Data;
            plot(x,y2,'ro')
            hold on
            y2 = ModelFound;
            plot(x,y2,'b')
            xlabel('Time (s)')
            ylabel('Y (m)')
            title('Subplot 2: Curve Fit')
            % Residual figure plot
            subplot(2,2,3)
            x= obj.Tvec;
            y3=y2-obj.Data;
            plot(x,y3,'m*')
            xlabel('Time (s)')
            ylabel('Y (m)-Data')
            title('Subplot 3: Residual plot')
         
        end
        function gui(obj)
            %gui Simple, Ugly GUI for MyAdd
            
            %See if we already have a figure for this class
            Z=findall(0,'Tag','AddGUI');
            if ~isempty(Z);return;end
            
            %Create figure
            F = figure('Position',[100 100 600 500]);
            F.Tag='AddGUI';
            %Plot intitial guess
            ModelFound=obj.Model(obj.Theta0,obj.Tvec);
            % Raw figure plot
            subplot(2,2,1)
            x = obj.Tvec;
            y1 = obj.Data;
            plot(x,y1,'ro')
            title('Subplot 1: fit model')
            
            xlabel('Time (s)')
            ylabel('Y (m)')
            
            hold on
            
            subplot(2,2,1)
            x = obj.Tvec;
            y1 =ModelFound;
            plot(x,y1,'m')
            
            %Save figure to object property
            obj.FigGUI=F;
            
            
            % Setup UI CONTROLS----------------------------------------------
            TextBoxA = uicontrol('Style','edit','String','TEst',...
                'Position',[10 300 100 50]);
            TextBoxC = uicontrol('Style','text','String','NJumps',...
                'Position',[10 300 100 15]);
            TextBoxB = uicontrol('Style','edit','String','TEst',...
                'Position',[10 250 100 50]);
            TextBoxD = uicontrol('Style','text','String','JumpSigma',...
                'Position',[10 250 100 15]);
            
            
            Button = uicontrol('Style', 'pushbutton', 'String', 'Start',...
                'Position', [10 100 100 50],...
                'Callback', @runAddAB);
            hold on
            
            % -----------------------------------------------------------------
            
            %Intialize UI controls with current object
            property2gui()
            
            
            function runAddAB(~,~)
                %Callback of Button
                gui2property()
                obj.MCMC()
                property2gui()
            end
            
            %Write object properties into GUI unicontrols
            function property2gui()
                TextBoxA.String=num2str(obj.NJumps);
                TextBoxB.String=num2str(obj.JumpSigma);
                
            end
            
            %Get values from UI controls and set object properties
            function gui2property()
                obj.NJumps=str2double(TextBoxA.String);
                obj.JumpSigma=str2double(TextBoxB.String);
                
            end
            
        end
        
        
    end
end


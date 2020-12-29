classdef IsingModel2Class
    % 2D Ising Model
    % Same rules as the 1D Ising model. Neighbors are the 4 closest spins.
    % In 2D there is phase transition at -1/(Beta*J)=2/log(1+sqrt(2))
    
    properties
        Beta         %1/KbT
        J            %Interaction Strength
        B            %Magnetic Field
        N            %Number of spins
        
        Spins
        FigH
        FigGUI
    end
    
    methods
        %------------------------- Energy Function -----------------------------
        function[H,HTest] = Energy(obj,Spins,SpinsTest,J,MagneticField)
            %Energy from nearest neighbor interactions
            E_Spin=J*(sum(sum(Spins(1:end-1,:).*Spins(2:end,:)))+... %Y neighbor
                sum(Spins(1,:).*Spins(end,:))+... %Y periodic BC
                sum(sum(Spins(:,1:end-1).*Spins(:,2:end)))+... %X neighbor
                sum(Spins(:,1).*Spins(:,end))); %X periodic BC
            
            E_SpinTest=J*(sum(sum(SpinsTest(1:end-1,:).*SpinsTest(2:end,:)))+... %Y neighbor
                sum(SpinsTest(1,:).*SpinsTest(end,:))+... %Y periodic BC
                sum(sum(SpinsTest(:,1:end-1).*SpinsTest(:,2:end)))+... %X neighbor
                sum(SpinsTest(:,1).*SpinsTest(:,end))); %X periodic BC
            
            %Energy from Interactions with feild
            E_Field=-MagneticField*sum(Spins(:));
            E_FieldTest=-MagneticField*sum(SpinsTest(:));
            
            %Total Energy (Hamiltonian)
            H=E_Spin+E_Field;
            HTest=E_SpinTest+E_FieldTest;
        end
        
        function MCMC(obj)
            Button = uicontrol('Style', 'pushbutton', 'String', 'Stop',...
                'Position', [ 130 100 100 50],...
                'Callback', @Stop);
            function Stop(~,~)
                Go=2; % Callback function to stop the ieterations
                
            end
            %Plot Spins
            %obj.FigH=figure;
            %FigH.Position=[200,200,900,400];
            imshow(obj.Spins,[],'InitialMagnification',400)
            s=sprintf('Beta=%g, J=%g, B=%g',obj.Beta,obj.J,obj.B);
            title(s)
            
            %Setup so we stop when figure is closed
            %obj.FigH.CloseRequestFcn=@myStop;
            Go=1;
            
            
            
            %Run Markov Chain Monte Carlo
            NChain=1000000;
            nn=0;
            while Go==1
                
                nn=nn+1;    %counter for display
                
                %Make test jump
                
                %Pick site and flip spin
                IDX=ceil(obj.N*rand);
                IDY=ceil(obj.N*rand);
                SpinsTest=obj.Spins;
                SpinsTest(IDX,IDY)=-obj.Spins(IDX,IDY);
                
                [H,HTest] = obj.Energy(obj.Spins,SpinsTest,obj.J,obj.B);        %Calling for energy function
                %Test acceptance probability for Metropolis-Hastings
                Alpha=exp(-obj.Beta*(HTest-H));
                
                %Metropolis-Hastings rule
                if rand()< (Alpha)
                    obj.Spins(IDX,IDY)=-obj.Spins(IDX,IDY);
                end
                
                ShowIter=1000;
                %Show every ShowIter interations
                if (nn/ShowIter==round(nn/ShowIter))
                    pause(.01);if ~Go;break;end % Time to process closed figure
                    %figure(obj.FigH);
                    try
                        imshow(obj.Spins,[],'InitialMagnification',400)
                    catch
                    end
                    pause(.01)
                end
            end
        end
        
        
        function  gui(obj)
            
            %See if we already have a figure for this class
            Z=findall(0,'Tag','Ising');
            if ~isempty(Z);return;end
            
            %Create figure
            F = figure('Position',[100 100 1000 500]);
            F.Tag='Ising';
            
            %Save figure to object property
            obj.FigGUI=F;
            
            % Setup UI CONTROLS----------------------------------------------
            TextBox1 = uicontrol('Style','edit','String','TEst',...
                'Position',[10 350 100 50]);
            Txt1 = uicontrol('Style','text',...
                'Position',[130 330 100 50],...
                'String','Beta');
            
            TextBox2 = uicontrol('Style','edit','String','test',...
                'Position',[10 300 100 50]);
            Txt2 = uicontrol('Style','text',...
                'Position',[130 280 100 50],...
                'String','J');
            
            TextBox3 = uicontrol('Style','edit','String','TEst',...
                'Position',[10 250 100 50]);
            
            Txt3 = uicontrol('Style','text',...
                'Position',[130 230 100 50],...
                'String','B');
            
            
            
            Button = uicontrol('Style', 'pushbutton', 'String', 'Ising Model',...
                'Position', [10 100 100 50],...
                'Callback', @ising);
            
            Button = uicontrol('Style', 'pushbutton', 'String', 'Close',...
                'Position', [ 250 100 100 50],...
                'Callback', @myClose);
            
            % -----------------------------------------------------------------
            
            %Intialize UI controls with current object
            property2gui()
            
            
            function ising(~,~)
                %Callback of Button
                gui2property()
                obj.MCMC() % Runs the ising model by button push
                property2gui()
            end
            
            %Write object properties into GUI unicontrols
            function property2gui()
                TextBox1.String=num2str(obj.Beta);
                TextBox2.String=num2str(obj.J);
                TextBox3.String=num2str(obj.B);
                
            end
            
            %Get values from UI controls and set object properties
            function gui2property()
                obj.Beta=str2double(TextBox1.String);
                obj.J=str2double(TextBox2.String);
                obj.B=str2double(TextBox3.String);
                
            end
            function myClose(~,~)
                Go=0;
                delete(obj.FigH) % Callback function to close the figure
            end
            
            
            
        end
        
    end
end


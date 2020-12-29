function  gui(obj)
 
%See if we already have a figure for this class
Z=findall(0,'Tag','Ising');
if ~isempty(Z);return;end

%Create figure
F = figure('Position',[100 100 400 400]);
F.Tag='Ising';

%Save figure to object property
obj.figGUI=F;

% Setup UI CONTROLS----------------------------------------------
TextBoxA = uicontrol('Style','edit','String','TEst',...
    'Position',[10 350 100 50]);
TxtA = uicontrol('Style','text',...
        'Position',[130 330 100 50],...
        'String','Beta(1/kbT)');

TextBoxB = uicontrol('Style','edit','String','test',...
    'Position',[10 300 100 50]);
TxtB = uicontrol('Style','text',...
        'Position',[130 280 100 50],...
        'String','J');

TextBoxC = uicontrol('Style','edit','String','TEst',...
    'Position',[10 250 100 50]);

TxtC = uicontrol('Style','text',...
        'Position',[130 230 100 50],...
        'String','B');
TextBoxD = uicontrol('Style','edit','String','TEst',...
    'Position',[10 200 100 50]);

TxtD = uicontrol('Style','text',...
        'Position',[130 180 100 50],...
        'String','# of Spins');


Button = uicontrol('Style', 'pushbutton', 'String', 'Ising Model',...
    'Position', [10 100 100 50],...
    'Callback', @runIsing);
Button = uicontrol('Style', 'pushbutton', 'String', 'Stop',...
    'Position', [ 130 100 100 50],...
    'Callback', @Stop);
Button = uicontrol('Style', 'pushbutton', 'String', 'Close',...
    'Position', [ 250 100 100 50],...
    'Callback', @Close);

% -----------------------------------------------------------------

%Intialize UI controls with current object 
property2gui()


    function runIsing(~,~)
        %Callback of Button
        gui2property()
        obj.ising_model() % Runs the ising model by button push 
        property2gui()
    end

    %Write object properties into GUI unicontrols
    function property2gui()
        TextBoxA.String=num2str(obj.Beta);
        TextBoxB.String=num2str(obj.J);
        TextBoxC.String=num2str(obj.B);
        TextBoxD.String=num2str(obj.N);
    end

    %Get values from UI controls and set object properties
    function gui2property()
        obj.Beta=str2double(TextBoxA.String);
        obj.J=str2double(TextBoxB.String);
        obj.B=str2double(TextBoxC.String);
        obj.N=str2double(TextBoxD.String);
    end

    function Stop(~,~)
       obj.Go = 1.8; % Callback function to stop the ieterations
    end
    function Close(~,~)
       close(obj.figISI) % Callback function to close the figure
    end

end

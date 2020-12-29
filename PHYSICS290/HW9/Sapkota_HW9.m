%% Problem # 2
clear all
clc
%loading data from the inClass8Data.Mat
load('InClass8Data.mat')
Mycurvefit=susanHw9class()
Mycurvefit.Tvec=Tvec; % Tvec for the class from the Data
Mycurvefit.Data=Data; % Data for the class from the file
Mycurvefit.Theta0=[Data(1) (Data(2)-Data(1))/(Tvec(2)-Tvec(1)) -9.8 ]; % intial value 
Mycurvefit.Sigma=5; % fixed standard devition 
% calling class to curve fit
Mycurvefit.gui()
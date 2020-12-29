
%%  Problem 1
% To create an anonymous function that divides the first input by second and Demonstrate its use.
Divanonymous= @(Num1,Num2) (Num1./Num2); % anonymous function and . do each element operation.
Num1=input('Enter your first number= '); % taking first input from user 
Num2=input('Enter your second number= '); % taking second input from user
Output=Divanonymous(Num1,Num2)


%%  Problem 2
%Writing a m.file function that uses for loop to add element of array
InputArray=input('Enter your array to find sum of element in proper syntax=');
[Sum]=Sapkota_HW2_function(InputArray) % calling from the sapkota_HW2_function to find sum


%%  Problem 3
%code that reproduce same figure is given
X=linspace(0,6,100); %This create uniformly spaced array.
Y1=exp(-5*X);  %our First function to plot
Y2=sin(X*5);   %Our Second function to plot   

Fi=figure(); % This function create figure
Axe=axes();  % by this command we create axes
p1=plot(X,Y1); %ploting Y1 with respect to X

Axe.XLabel.String='Time (s)'; %this change our x-axis to Time (s)
Axe.YLabel.String='Signal (V)'; %this change our y-axis to Signal (V)
p1.LineWidth=2; % This is the size of the first plot run
p1.LineStyle='-';
p1.Marker='+'; %This makes + mark for every value of y for x
p1.Color='m'; %This gives color
t=title('Experiment 1'); % This gives title to experiment

hold on; %this command help to plot another figure on same plot
p2=plot(X,Y2); %plotting Y2 vs X
p2.Color='c';   %gives color
p2.LineStyle='-';
p2.LineWidth=4;  %gives width of line
legend('run 1', 'run 2'); %this generate legend to the figure
Axe.XLabel.FontSize=18; %gives font size for x-axis
Axe.YLabel.FontSize=8; %gives font sizee for the y-axis
Axe.FontWeight='bold'; %this makes axis font size bold


%%  Problem 4
% To show all the rows and column of matrix created by A=magic(5) sum to same number
% use of the for loop to show all row and column add up same number
A=magic(5); %generate the random matrix 5*5
siA=size(A); % gives size of the matrix A
rowsum=zeros(5,1);
for aa=1:siA(1,1) %using for loop to go row-wise to add all element
    elmentsum=0; %initializing the element sum by row
for bb=1:siA(1,2) % using loop to run on different column of same row to add each row element of same row.
   elmentsum=elmentsum+A(aa,bb); % adding element row wise 
   bb=bb+1; 
end
rowsum(aa,1)=elmentsum; % assigning the sum of row to rowsum 
aa=aa+1;
end
rowsum

columnsum=zeros(1,5); %initializing the sum of column as zero all element in matrix
for cc=1:siA(1,2) % using for loop to change the column after adding all the element of each column
    elementsum=0; %intializing the column element sum zero in each iteration
    for dd=1:siA(1,1) % using for loop to add all element of same column
        elementsum=elementsum+A(dd,cc); % adding element of the all column
        dd=dd+1;
    end
    columnsum(1,cc)=elementsum; % assigning the each column sum to columnsum 
    cc=cc+1;
end
columnsum
  

% Another Method to same task
% use of the sum matlab inbuilt function to compute sum columnwise and row
rowsum1=sum(A,2) % this command do row-wise operation.thus add all the element of row 
columnsum1=sum(A) %this command do column-wise operation. thus add all the elemnt of column.







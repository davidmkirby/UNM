%%Problem 1
clc % This clears the command window
Ba='Susan Sapkota';
fprintf('My name is %s\n',Ba); %This display my name using fprintf followed by carriage return

%%Problem 2
A=zeros(10,1); % to create 10*1 zero matrices
%using for end loop to change the element of the array matrix
for b=1:10
    A(b,1)=b;
end
A

%% Problem 3
% to count the number of even number in problem 2
%using for loop to check no of even number from all the element of the A
x=0;
for c=1:10 
    Aa= mod(A(c,1),2); % to find remainder when individual element of Aa is divided by 2.
    if Aa==0 % using if statement to check the remainder for even or odd
        x=x+1;%to count the no of even if if statement is true
    end
end
fprintf('The number of even number in array A is %d\n',x);

%%Problem 4
%using while loop for first 10 even numbers
start = 0;
count = 0;
while (count < 10) % using while loop to count the loop for ten even number
    start = start + 1 ;
   if ((mod(start,2) == 0)) % using if statement to check whether number is perfectly disible by 2
       fprintf('%d\n',start);
       count = count+1;
   end
end





    
    
    
    

        
    









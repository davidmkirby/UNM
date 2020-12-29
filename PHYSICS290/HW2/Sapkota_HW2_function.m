function [Sum] = Sapkota_HW2_function(InputArray)
%Sapkota_HW2_function calculate sum of all element of InputArray
% Function call: [Sum] = Sapkota_HW2_function(InputArray)
% INPUTS 
% InputArray can be any size of matrix

bb=size(InputArray); % this size command help to find matrix size
Sum=0; %intializing the sum to zero 
for ii= 1:bb(1,1) %using for loop till the ii value goes to maximum size of row. row wise
    for jj=1:bb(1,2) %using for loop till the jj value goes to maximum size of column. column-wise
        Sum=Sum+InputArray(ii,jj); %carrying out the sum
        jj=jj+1;
    end
    ii=ii+1;
end

end


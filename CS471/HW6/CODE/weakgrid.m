% weak scalling grid point 

A= zeros(1,16);
for i=1:16
    a= round(200*(i)^(1/2));
    A(:,i)= A(:,i)+a;
end 
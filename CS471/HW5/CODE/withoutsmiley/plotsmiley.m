clear all;
close all;

load xy.txt
load feed.txt
%load smelly.txt
nbirds = 100;
nt = round(length(xy)/nbirds);
k=1;

for i = 1:nbirds
 for j =1:nt
   x(i,j) = xy(k,1);
   y(i,j) = xy(k,2);
   k = k+1;
 end
end
     
xlim([-1 2])
ylim([-1 2])
color(1) = 'g';
for i =2:nbirds;
    color(i) = 'k';
end

for j = 1:nt
    feed(j,1),feed(j,2);
    feeder = viscircles([feed(j,1),feed(j,2)],0.005,'Color','r');
    %sbird = viscircles([smelly(j,1),smelly(j,2)],0.008,'Color','y');
    for i=1:nbirds
      center = [x(i,j) y(i,j)];
      circ(i) = viscircles(center,0.01,'Color',color(i));    
    end
%    pause(0.001)
    print([num2str(j,'birds_%5.5d.jpg')],'-djpeg');
   
    delete (circ)
    delete (feeder)
   % delete (sbird)
end



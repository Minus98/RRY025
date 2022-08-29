%  badcircle.m
%
%  John Conway, ERR041, Sept 2000
%
% An example of how NOT TO(!) 
% create a 256x256 image consisting
% of a circle of radius 40 pixels inside
% of which the value is 1, and outside the value
% is 0.
%
% First initialise the image
%
circle = zeros(256,256);
%
% Execute a double loop and find pixels with
% radius less than 40.
%
for i=1:256
 for j=1:256
%
  rad = sqrt((i-129).^2 + (j-129).^2);
%
  if (rad<40)
     circle(i,j) =1; 
  else
     circle(i,j) =0; 
  end
end
end 
%
imshow(circle, [ ])

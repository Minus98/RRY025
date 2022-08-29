% makecircle.m
%
% John Conway, ERR041, Sept 2000.
% 
% Example of how to efficiently create 
% a 256x256 image consisting
% of a circle of radius 40 pixels inside
% of which the value is 1, and outside the value
% is 0.
%
% First initialise the image
%
circle = zeros(256,256);
%
% Create a vector of length 256, with values 
% from -128 to 127
%
V=linspace(-128, 127, 256);
%
%  Create two 256x256 images, XX has
%  a value which just depends on the 
%  distance from the center in the x-direction
%  and YY the difference in the y-direction.
% 
[XX, YY]=meshgrid(V);
%
% Now form the RR a 256x256 matrix where each 
% pixel has as its value the distance in pixels from the 
% image centre. Note the XX.^2 means take the square of each 
% element in the matrix, XX^2 would just matrix multiply 
% the matrix XX by itself.
%
RR=sqrt(XX.^2 + YY.^2);
%
% Find the pixels in which the radius from the centre is 
% less than 'rad', store the coordinates in vector 'index'
% 
rad=40;
index=find(RR<rad);
%
% set these pixels to have the value 1.
% 
circle(index)=1;
%
figure(1)
clf
imshow(circle, [ ])





function output=difim(input);
%
% John Conway, Image Processing, ERR041
%    Sept 2000
%
% Raster scans an image replacing 
% all value except first with the difference
% between than pixel and the previous one
%
figure
subplot(2,1,1)
imshow(input,[]);
title('Input - Original Image')
[s1 s2]=size(input);
s3 = s1*s2;
%
vec1=double(reshape(input', [1 s3]));
vec2 = diff(vec1);
vec1(2:s3)=vec2(1:s3-1);
temp = reshape(vec1, [s2 s1]);
output = temp';
subplot(2,1,2)
imshow(output,[]);
title('Output - Image after differencing adjacent pixels on a line')


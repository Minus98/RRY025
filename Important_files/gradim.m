function output=difim(input)
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
imshow(input,[])
title('Input Image')
[s1 s2]=size(input);
s3 = s1*s2;
vec1=double(reshape(input', [1 s3]));
vec2=zeros(1,s3);
%
vec2(1) = vec1(1);
vec2(2) = vec1(2);
%
for i=3:s3
 vec2(i) = vec1(i) - 2*vec1(i-1) + vec1(i-2);
end
%
output =flipud(rot90( reshape(vec2', [s2 s1])));
%
subplot(2,1,2)
imshow(output,[])
title('Output - Error image after removing gradient predictor')

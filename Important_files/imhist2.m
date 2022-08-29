function imhist2(input,bins)
%
% plots histogram of an image ublike 'imhist'
% showing positive and negative values
%
[s1 s2] = size(input);
s3 = s1*s2;
vec = double(reshape(input, [1 s3]));
hist(vec, bins);
xlabel('pixel value')
ylabel('number of pixels')

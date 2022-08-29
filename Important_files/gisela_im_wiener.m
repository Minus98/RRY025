%%  Simulate a Motion Blur
% Simulate a blurred image that you might get from camera motion.  Create a
% point-spread function, |PSF|, corresponding to the linear motion across
% 15 pixels (|LEN=15|), at an angle of 27 degrees (|THETA=27|). To simulate
% the blur, convolve the filter with the image using |imfilter|. 

%%
clear all
close all
clc

I = imread('gisela_boat.tif');
figure, imshow(I);
title('Original Image');
%%
LEN = 15;
THETA = 27;
PSF = fspecial('motion',LEN,THETA);
blurred = imfilter(I,PSF,'circular','conv');
figure, imshow(blurred);
imwrite(blurred, 'gisela_blurred.tif')

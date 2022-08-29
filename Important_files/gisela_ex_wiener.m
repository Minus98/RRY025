%% Deblurring Images Using the Wiener Filter
% Wiener deconvolution can be used effectively when the frequency
% characteristics of the image and additive noise are known, to at least
% some degree. 

close all
clear all
clc

%% Read Image

I = imread('gisela_blurred.tif');
figure, imshow(I);
[M,N] = size(I);

%%

LEN = 15;
THETA = 27;
PSF = fspecial('motion',LEN,THETA); % Point Spread Function
OTF = fft2(PSF,M,N); % Optical Transfer Function
figure, imshow(fftshift(abs(OTF)));
title('Optical Transfer Function')

OTF_abs = abs(OTF);
figure
surf([-255:256]/256,[-255:256]/512,fftshift(OTF_abs))
shading interp, camlight, colormap jet
xlabel('Optical Transfer Function')

% %% 
% h = fspecial('motion',LEN,THETA);
% % Read image and convert to double for FFT
% cam = im2double(imread('gisela_boat.tif'));
% hf = fft2(h,size(cam,1),size(cam,2));
% cam_blur = real(ifft2(hf.*fft2(cam)));
% figure, imshow(cam_blur)

%%  Restore the Blurred Image
% To see the importance of knowing the true PSF in deblurring, perform
% three restorations. For the first restoration, |wnr1|, using the true PSF

wnr1 = deconvwnr(I,PSF);
figure, imshow(wnr1);
title('Restored, True PSF');

%% 
% For the second restoration, |wnr2|, use an estimated PSF that simulates
% motion twice as long as the blur length (|LEN|).

wnr2 = deconvwnr(I,fspecial('motion',2*LEN,THETA));
figure, imshow(wnr2);
title('Restored, "Long" PSF');

%%
% For the third restoration, |wnr3|, use an estimated PSF that simulates an
% angle of the motion twice as steep as the blur angle (|THETA|).

wnr3 = deconvwnr(I,fspecial('motion',LEN,2*THETA));
figure, imshow(wnr3);
title('Restored, Steep');

%% Simulate Additive Noise 
% Simulate additive noise by using normally distributed random numbers and
% add it to the blurred image. 

noise = 0.1*randn(size(I));
blurredNoisy = imadd(I,im2uint8(noise));
figure, imshow(blurredNoisy);
title('Blurred & Noisy');

%% Restore the Blurred and Noisy Image
% Restore the blurred and noisy image using an inverse filter, assuming
% zero-noise. Notice that the noise present in the original data is amplified
% significantly. 

wnr4 = deconvwnr(blurredNoisy,PSF);
figure, imshow(wnr4);
title('Inverse Filtering of Noisy Data');

%%
% To control the noise amplification, provide the noise-to-signal power
% ratio, |NSR|.

NSR = sum(noise(:).^2)/sum(im2double(I(:)).^2);
wnr5 = deconvwnr(blurredNoisy,PSF,NSR);
figure, imshow(wnr5);
title('Restored with NSR');

%%
% Vary the |NSR| value to affect the restoration results. The small |NSR|
% value amplifies noise. 

wnr6 = deconvwnr(blurredNoisy,PSF,NSR/2);
figure, imshow(wnr6);
title('Restored with NSR/2');

%% Use Autocorrelation to Improve Image Restoration
% To improve the restoration of the blurred and noisy images, supply the
% full spectrum of the signal, which is also called autocorrelation function
% (ACF) for the noise, |NCORR|, and the signal, |ICORR|. 

NP = abs(fft2(noise)).^2;
NPOW = sum(NP(:))/prod(size(noise)); % noise power
NCORR = fftshift(real(ifft2(NP))); % noise ACF, centered
IP = abs(fft2(im2double(I))).^2;
IPOW = sum(IP(:))/prod(size(I)); % original image power
ICORR = fftshift(real(ifft2(IP))); % image ACF, centered

wnr7 = deconvwnr(blurredNoisy,PSF,NCORR,ICORR);
figure, imshow(wnr7);
title('Restored with ACF');

%%
% Explore the restoration given limited statistical information: the power
% of the noise, |NPOW|, and a 1-dimensional autocorrelation function of the
% true image, |ICORR1|.

ICORR1 = ICORR(:,ceil(size(I,1)/2));
wnr8 = deconvwnr(blurredNoisy,PSF,NPOW,ICORR1);
figure, imshow(wnr8);
title('Restored with NP & 1D-ACF');

%% Influence of the Image power spectrum

boat = im2double(imread('gisela_boat.tif'));
couple = im2double(imread('gisela_couple.tiff'));
figure
subplot(1,2,1)
imshow(boat)
colormap(gray(256))
title('boat')
subplot(1,2,2)
imshow(couple)
title('couple')

bf = abs(fft2(boat)).^2;
cf = abs(fft2(couple)).^2;
figure
subplot(1,2,1)
surf([-255:256]/256,[-255:256]/256,log(fftshift(bf)+1e-6))
shading interp, colormap gray
title('Boat power spectrum')
subplot(1,2,2)
surf([-255:256]/256,[-255:256]/256,log(fftshift(cf)+1e-6))
shading interp, colormap gray
title('Couple power spectrum')

ICORRtrue = fftshift(real(ifft2(abs(fft2(boat)).^2)));

wnr9 = deconvwnr(blurredNoisy,PSF,NCORR,ICORRtrue);
figure
subplot(1,2,1)
imshow(wnr9)
colormap(gray(256))
title('restored image with exact spectrum')
ICORRcouple = fftshift(real(ifft2(abs(fft2(couple)).^2)));
wnr10 = deconvwnr(blurredNoisy,PSF,NCORR,ICORRcouple);
subplot(1,2,2)
imshow(wnr10)
colormap(gray(256))
title('restored image with couple spectrum')

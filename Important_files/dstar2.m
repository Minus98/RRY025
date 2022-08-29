function dstar2
%
% ERR041 Laasperiod 1 99/00
% John Conway
% 
%
rms=input(' Input rms noise value ')
if (rms==0) 
   rms=0.001
else
end
%
psfcut = input(' Input inverse filter cutoff value ')
if (psfcut==0)
   psfcut = 0.0001
else
end 
%
clf
sep=2;
usig=4;
true = zeros(64,64);
true(32-sep,32) = 1;
true(32+sep,32) = 1;
%
subplot(2,2,1);
imshow(true,128);colorbar;
title('True Image')
%
% First do convolution of image with psf
% via the fourier domain
%
ftrue = fftshift(fft2(fftshift(true)));
%
for u=1:64
for v=1:64
%
%
   a = exp(-((u-32)^2)/(2*(usig^2)));
   b = exp(-((v-32)^2)/(2*(usig^2)));
   fpsf(u,v)  =  a*b;
   fdirty(u,v) = fpsf(u,v)*ftrue(u,v);
%
end
end
%
%  Calculate PSF and (I*PSF)
%
psf=res1(real(fftshift(ifft2(fftshift(fpsf)))));
dirty= res1(real(fftshift(ifft2(fftshift(fdirty)))));
%
%  Now Add gaussian noise to give (I*PSF + N)
% 
var = rms.^2;
input=imnoise(dirty,'gaussian',0,var);
finput = fftshift(fft2(fftshift(input)));
%
subplot(2,2,2);
imshow(psf,128);colorbar;
title('Point Spread Function')
%
subplot(2,2,3);
imshow(dirty,128);colorbar;
title('Convolved Image')
%
subplot(2,2,4);
imshow(input,128);colorbar;
title('Convolved  Image+Noise')
zoom
%
pause
clf
%
% Now apply the inverse Filter
%
for u=1:64
for v=1:64
%
%  Strictly do pseudo-inverse, need
%  a small value i.e. psfcut=1E-11
%  even if no additive noise
%  to avoid numerical errors
% 
if abs(fpsf(u,v))>psfcut
   fcorr(u,v)  = finput(u,v)/fpsf(u,v); 
  else
   fcorr(u,v)  = 0;
end
end
end
corr=res1(real(fftshift(ifft2(fftshift(fcorr)))));
%
subplot(1,2,1);
imshow(true,128);colorbar;
title('True Image')
%
subplot(1,2,2);
imshow(corr,128);colorbar;
title('Pseudoinvere Restored Image')


















% ERR041 Laasperiod 1 99/00
% John Conway
% 
%
clf
sig=2;
usig = 128/sig;
sep=2;
true = zeros(128,128);
true(64-sep,64) = 1;
true(64+sep,64) = 1;
subplot(2,2,1);
imshow(true,128);colorbar;
title('True Image')
%
%
for i=1:128
for j=1:128
%
%
   a = exp(-((i-64-sep)^2)/(2*(sig^2)));
   b = exp(-((i-64+sep)^2)/(2*(sig^2)));
   c = exp(-((j-64)^2)/(2*(sig^2)));
   d = exp(-((i-64)^2)/(2*(sig^2)));
  im1(i,j)  =  a*c;
  im2(i,j)  =  b*c;
  dirty(i,j) = im1(i,j) + im2(i,j);   
  psf(i,j) = c*d;
%
end
end
%
subplot(2,2,2);
imshow(psf,128);colorbar;
title('Point Spread Function')
%
subplot(2,2,3);
imshow(dirty,128);colorbar;
title('Distored Image')
%
pause
clf
%
ftrue = fftshift(fft2(fftshift(true)));
aftrue = res1(abs(ftrue));
fdirty = fftshift(fft2(fftshift(dirty)));
afdirty = res1(abs(fdirty));
fpsf = fftshift(fft2(fftshift(psf)));
fpsf = res1(abs(fpsf));
%
for u=1:128
for v=1:128
%  a = exp(-((u-64)^2)/(2*(usig^2)));
%  b = exp(-((v-64)^2)/(2*(usig^2)));
%  otf(u,v) = a*b;
%  inv(u,v) = 1/otf(u,v);
  finv(u,v) = 1/fpsf(u,v);
  corr(u,v) = fdirty(u,v) * finv(u,v);
end
end
acorr = abs(corr)/abs(corr(64,64));
%
subplot(2,2,1);
imshow(aftrue,128);colorbar
title('Amp FT of True Image')
subplot(2,2,2);
imshow(fpsf,128);colorbar
title('Amp FT of PSF (OTF)')
subplot(2,2,3);
imshow(afdirty,[0 0.1]);colorbar
title('Amp FT of Distorted Image')
subplot(2,2,4);
imshow(finv,[1 4]);colorbar
title('Inverse Filter H=1/OTF')
%
pause
clf
icorr=res1(real(fftshift(ifft2(fftshift(corr)))));
% subplot(2,2,1)
% imshow(true,128);colorbar
% subplot(2,2,2)
% imshow(aftrue,128);colorbar
subplot(1,2,1);
imshow(acorr,128);colorbar
title('FT after multiplication by 1/H')
subplot(1,2,2)
imshow(icorr,128);colorbar
title('Inverse FT - Restored Image')












camera=imread('cameraman.tif');
subplot(2,2,1)
imshow(camera,[ ]);
zoom;
%
xv=linspace(-128,129,256);
[XX, YY] = meshgrid(xv);
RR = sqrt(XX.^2 + YY.^2);
RR(129,129) = 1;
%
off = 0.01;
r0 = 3 ;
otf1 = 256*256*(off + ((1-off)*(r0./RR)));
%
index=find(RR<r0); 
otf1(index) = 256*256;
%
lotf1 = log(1+10*otf1);
subplot(2,2,2);
imshow(lotf1,[ ]);
title(' Log of OTF')
%
psf = real(fftshift(ifft2(fftshift(otf1))));
lpsf = log(1+psf);
subplot(2,2,3);
imshow(lpsf,[]);
title(' Log of PSF')
%
% do convolution 
%
ftcam = fftshift(fft2(camera));
mult = fftshift(otf1.*ftcam);
dcamera = real(ifft2(mult));
%
subplot(2,2,4);
imshow(dcamera,[]);
title(' Distorted Image')












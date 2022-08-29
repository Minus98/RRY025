camera=imread('cameraman.tif');
clf
figure(2)
clf
figure(1)
clf
%
% subplot(1,2,1)
% imshow(camera,[ ]);
zoom;
%
xv=linspace(-128,129,256);
[XX, YY] = meshgrid(xv);
RR = sqrt(XX.^2 + YY.^2);
RR(129,129) = 1;
%
%%%%   Define OTF1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
off = 0.01;
r0 = 3 ;
otf1 = 256*256*(off + ((1-off)*(r0./RR)));
%
index=find(RR<r0); 
otf1(index) = 256*256;
%
lotf1 = log(1+10*otf1);
% subplot(2,2,2);
% imshow(lotf2,[ ]);
% title(' Log of OTF')
%
psf10 = real(fftshift(ifft2(fftshift(otf1))));
lpsf1 = log(100+psf10);
psf1= fftshift(psf10);
%
%%%%%%% Define OTF2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
off = 0.1;
r0 = 10;
otf2 = otf1;
%
index=find(RR<(r0/2)); 
otf2(index) = 256*256;
index=find(RR>(r0/2)); 
otf2(index) = 256*256/1.414;
index=find(RR>r0); 
otf2(index) = 256*256/2;
index=find(RR>2*r0); 
otf2(index) = 256*256/4;
index=find(RR>4*r0);
otf2(index) = 256*256/8; 
%
lotf2 = log(1+10*otf2);
% subplot(2,2,2);
% imshow(lotf2,[ ]);
% title(' Log of OTF')
%
psf20 = real(fftshift(ifft2(fftshift(otf2))));
lpsf2 = log(100+psf20);
psf2= fftshift(psf20);
%
% subplot(2,2,3);
% imshow(lpsf2,[]);
% title(' Log of PSF 2')
%
%%%%%%%%%%%%  do convolution %%%%%%%%%%%%%%%%%%%%%
%
ftcam = fftshift(fft2(camera));
mult = fftshift(otf2.*ftcam);
dcamera = real(ifft2(mult));
dcamera2 =zeros(256,256);
dcamera2 = dcamera(5:250,5:250);
%
subplot(1,2,1);
imshow(dcamera2,[]);
title(' Distorted Image')
%
disp('                               ')
disp('In cameraman image take  profile across an edge')
disp('Crossing from bright sky to the mans black coat')
disp('                               ')
disp('Using mouse click first on ')
disp('left button to start slice ')
disp('and right button to end slice ')
disp('                               ')
slim=improfile;
subplot(1,2,2);
plot(slim);
drawnow
title(' Profile across edge')
pause(2)
%
figure(2)
%
subplot(2,3,1);
imshow(lpsf1,[]);
title(' Log of PSF 1')
%
subplot(2,3,4);
imshow(lpsf2,[]);
title(' Log of PSF 2')
%
%
edge=zeros(256,256);
edge(:,1:128) = 1;
%
fedge = fftshift(fft2(edge));
mult1 = fftshift(otf1.*fedge);
edgepsf1 = real(ifft2(mult1));
mult2 = fftshift(otf2.*fedge);
edgepsf2 = real(ifft2(mult2));
%
subplot(2,3,2);
imshow(edgepsf1,[]);
title('Edge convolved with PSF1')
%
subplot(2,3,5);
imshow(edgepsf2,[]);
title('Edge convolved with PSF2')
%
subplot(2,3,2);
disp('                               ')
disp('Take profile across edge*psf1')
disp('Crossing from white to black')
disp('                               ')
disp('Using mouse first')
disp('click on left button to start slice ')
disp('and right button to end slice ')
disp('                               ')
slpsf1=improfile;
subplot(2,3,3);
plot(slpsf1);
title('take profile across edge*psf1')
%
subplot(2,3,5);
disp('                               ')
disp('Take profile across edge*psf2')
disp('Crossing from white to black')
disp('                               ')
disp('Using mouse first')
disp('click on left button to start slice ')
disp('and right button to end slice ')
disp('                               ')
slpsf1=improfile;
subplot(2,3,6);
plot(slpsf1);
title('take profile across edge*psf2')









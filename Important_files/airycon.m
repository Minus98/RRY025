% airypsf.m   Creates airy intensity PSF and plots to screen
%
clf
%
% Create matrix rad; value of each element is
% the radius from the centre
% 
xaxis=linspace(-5,5,31);
[XX,YY]=meshgrid(xaxis);
rad = sqrt(XX.*XX  + YY.*YY);
%
% Create the electric filed PSF (epsf) of a circular
% aperture - using analytic extpression.
%
epsf=(2/pi)*besselj(1,(pi*rad))./rad;
epsf(16,16)=1;
%
% Intensity PSF(psf) is amplitude squared of the the 
% electric field PSF
%
psf = epsf.^2;
normpsf = sum(sum(psf));
%
% Start plotting, first linear, then log plot
% 
subplot(1,2,1)
imshow(psf,[0 1]);
zoom;
title('Airy Diffraction pattern-Linear plot')
%
subplot(1,2,2)
lpsf = (1/4)*log10(10000*psf + 1);
imshow(lpsf);
title('Airy Diffraction pattern-Log plot')
% truesize(fg1,[255 255]); 
pause
clf
%
% Create star field image
%
smin=0.005;
smax=1;
fmin=smin^(-1.5);
fmax=smax^(-1.5);
stars1=rand(64,64);
stars2=(fmax + stars1*(fmin-fmax)).^(-2/3) ;
index=find(stars2<0.1);
stars2(index) = 0;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Convolve star field with psf and plot
%
subplot(2,2,1);
imshow(stars2,[0 0.3]);
title('Star Field - True Image, linear')
zoom;
%
%
stars3=conv2(stars2,psf,'same');
%
subplot(2,2,2);
imshow(stars3,[0 0.5]);
title('Star Field - Observed Image, linear')
%
lstars2=(1/4)*log10(10000*stars2 + 1);
subplot(2,2,3);
imshow(lstars2,[0 1]);
title('Star Field - True Image, log')
zoom;
%
lstars3=(1/4)*log10(10000*stars3 + 1);
subplot(2,2,4);
imshow(lstars3,[0 1]);
zoom;
title('Star Field - Observed Image, log')
pause
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Load saturn image
%
sat=imread('saturn.tif');
saturn1 = ind2gray(sat,gray(256));
saturn2=imresize(saturn1,0.25);
%
% Convolve with psf
%
saturn3=conv2(saturn2,psf,'same')/normpsf;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Plot versions of Saturn image
%
subplot(2,2,1)
imshow(saturn2,[0 1])
title('Saturn Image - True, linear')
%
subplot(2,2,2)
imshow(saturn3,[0 1])
title('Saturn Image- Observed, linear')
%
lsat2 = (1/4)*log10(10000*saturn2 + 1);
subplot(2,2,3)
imshow(lsat2,[0 1])
title('Saturn Image - True, log')
%
lsat3 = (1/4)*log10(10000*saturn3 + 1);
subplot(2,2,4)
imshow(lsat3,[0 1])
title('Saturn Image - Observed, log')
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





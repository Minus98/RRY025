% difspike.m   Creates airy intensity PSF and plots to screen
%
% 
rad0= 40;   % radius of telescope aperture
rad1=  4;    % radius of telescope secondary
width = 3;  % width of supporting struts
%
clf
%
% Create matrix rad; value of each element is
% the radius from the centre
% 
xaxis=linspace(-64,64,129);
[XX,YY]=meshgrid(xaxis);
rad = sqrt(XX.*XX  + YY.*YY);
%
XX2 = XX*cos(2*pi/3) + YY*sin(2*pi/3);
YY2 = -XX*sin(2*pi/3) + YY*cos(2*pi/3);
%
XX3 = XX*cos(4*pi/3) + YY*sin(4*pi/3);
YY3 = -XX*sin(4*pi/3) + YY*cos(4*pi/3); 
%
circle1=ones(129,129);
index=find(rad>rad0);
circle1(index)= 0;
%
circle2=ones(129,129);
index=find(rad<rad1);
circle2(index)= 0;
circle = circle1.*circle2;
%
%
strip1= ones(129,129);
index= find(abs(XX)<width);
strip1(index) = 0;
%
strip2= ones(129,129);
index= find(abs(XX2)<width);
strip2(index) = 0;
%
strip3= ones(129,129);
index= find(abs(XX3)<width);
strip3(index) = 0;
%
comb1 = strip1.*strip2.*strip3.*circle;
subplot(2,2,1)
imshow(comb1)
title('Telescope Aperture')
%
% calculate electric field Airy pattern of circular 
% unblocked aperture
% 
arad = 1024/(2*pi*rad0);
airy1=(2*arad/pi)*besselj(1,(pi*rad/arad))./rad;
airy1(65,65) = 1; 
%
% calculate electric field Airy pattern of blocking
% by secondary mirror
% 
if (rad1>0)
%
 arad = 1024/(2*pi*rad1);
 airy2=((rad1/rad0).^2)*(2*arad/pi)*besselj(1,(pi*rad/arad))./rad;
 airy2(65,65) = (rad1/rad0).^2; 
%
else
 airy2=0
end
%
if (width>0) 
%
% Calculate diffraction patterns of struts
% analytically
%
 x0=1024/width;
 y0=1024/(2*rad0);
%
 x1=1024/width;
 y1=1024/(2*rad1);
%
%
 facta = ((2*rad0*width)/(pi*rad0.^2));
 temp1 = (sin(2*pi*XX/x0)./(2*pi*XX/x0));
 temp1(:,65) = 1;
 temp2 =  (sin(2*pi*YY/y0)./(2*pi*YY/y0));
 temp2(65,:) = 1;
 fstrip1a=facta*temp1.*temp2;
%
 factb = ((2*rad1*width)/(pi*rad0.^2))
 temp1 = (sin(2*pi*XX/x1)./(2*pi*XX/x1));
 temp1(:,65) = 1;
 temp2 =  (sin(2*pi*YY/y1)./(2*pi*YY/y1));
 temp2(65,:) = 1;
 fstrip1b=factb*temp1.*temp2;
%
 fstrip1 = fstrip1a - fstrip1b;
%
%
 temp1 = (sin(2*pi*XX2/x0))./(2*pi*XX2/x0);
 temp1(65,65) = 1;
 temp2 =  (sin(2*pi*YY2/y0))./(2*pi*YY2/y0);
 temp2(65,65) = 1;
 fstrip2a=facta*temp1.*temp2;
%
 factb = ((2*rad1*width)/(pi*rad0.^2));
 temp1 = (sin(2*pi*XX2/x1)./(2*pi*XX2/x1));
 temp1(:,65) = 1;
 temp2 =  (sin(2*pi*YY2/y1)./(2*pi*YY2/y1));
 temp2(65,:) = 1;
 fstrip2b=factb*temp1.*temp2;
%
 fstrip2 = fstrip2a - fstrip2b;
%
 temp1 = (sin(2*pi*XX3/x0))./(2*pi*XX3/x0);
 temp1(65,65) = 1;
 temp2 =  (sin(2*pi*YY3/y0))./(2*pi*YY3/y0);
 temp2(65,65) = 1;
 fstrip3a=facta*temp1.*temp2;
%
 factb = ((2*rad1*width)/(pi*rad0.^2));
 temp1 = (sin(2*pi*XX3/x1)./(2*pi*XX3/x1));
 temp1(:,65) = 1;
 temp2 =  (sin(2*pi*YY3/y1)./(2*pi*YY3/y1));
 temp2(65,:) = 1;
 fstrip3b=factb*temp1.*temp2;
%
 fstrip3 = fstrip3a - fstrip3b;
%
else
 fstrip1=0;
 fstrip2=0;
 fstrip3=0;
end
%
% Create power PSF
%
allspike = fstrip1+fstrip2+fstrip3;
epsf = airy1 - airy2  - allspike;
psf = epsf.^2; 
%
subplot(2,2,3);
imshow(psf, [0 0.1])
title('Power PSF, linear plot (0.0 - 0.1)')
%
subplot(2,2,4)
lpsf = (1/5)*log10(1E5*psf+1);
imshow(lpsf, [0 1]);
title('Power PSF, log plot');
%
% subplot(2,2,2)
%
comb2=zeros(512,512);
comb2(192:320,192:320)=comb1;
ftcomb = abs(fftshift(fft2(fftshift(comb2))))/4176;
spsf = ftcomb.*ftcomb;
% imshow(spsf,[0 0.01]);
logspsf = (1/4)*log10(10000*spsf+1);
imshow(logspsf, [0 1]);
title('Power PSF from DFT, Log Plot')
%
disp('click on figures to zoom in')
%









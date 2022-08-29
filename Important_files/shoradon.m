%
% Select input image
% 
ctrl=input('Select input. 1-One small square, 2-Three small squares, 3. Big square, 4. Rectangle 5. Human Slice ');
%
switch ctrl
%
case(1) 
%
 rad = input('Give radial distance to small square (range 0-60) ');
 phi = input('Give position angle (0-360) ');
 phir = (pi/180).*phi;
 [xps, yps] = pol2cart(phir,rad);
 xps2 = 64+round(xps);
 yps2 = 64+round(yps);
 sqs=zeros(128,128);
 sqs(xps2:xps2+2,yps2:yps2+2)=1;
 p= sqs;
%
case(2)
%
 sqs=zeros(128,128);
 sqs(32:34,42:44)=1;
 sqs(50:52,15:17)=1;
 sqs(100:102,100:102)=1;
 p=sqs;
%
case(3)
%
 sqs=zeros(128,128);
 sqs(32:96,32:96)=1;
 p=sqs;
%
case(4)
%
 sqs=zeros(128,128);
 sqs(8:120,32:96)=1;
 p=sqs;
%
otherwise
%
 p=phantom(128);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(1)
clf
rp = radon(p,0);
[nn, mm]=size(rp);
ed = round((nn-128)/2);
p1 = zeros(nn,nn);
p1(ed:ed+128-1,ed:ed+128-1)=p;
subplot(2,1,1)
imax=max(max(p1));
imshow(flipud(p1),[0 imax/2]);
title('Original Image')
%
% nproj= input('Number of projections ');
nproj=180;
disp('Taking 180 projections. One every degree from');
disp('0 to 179 degrees');
theta = linspace(0, (180-180/nproj), nproj);
rp = radon(p,theta);
[nn, mm]=size(rp);
xint = linspace(-nn/2,(nn/2)+1,nn);
minx = min(xint);
maxx = max(xint);
%
subplot(2,1,2)
imshow(theta,xint,rp,[])
axis square
axis on
title('Radon Transform')
xlabel('Projection Angle (degrees)');
ylabel('Intercept (pixels)');
%










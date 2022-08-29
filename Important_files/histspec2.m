close all
clear all
load('imdemos.mat');
imag = quarter;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% First do standard histogram equalistion
%
% 
nhist = imhist(imag)./numel(imag);
%
% chist is cumulative normalised input 
% histogram
%
chist = cumsum(nhist);
%
tfunc = uint8(255.*chist); 
imagb = uint8(double(imag) + 1);
imag2 = tfunc(imagb);
%
figure(1)
subplot(2,3,1)
imshow(imag,[0 255])
title('Original Image')
subplot(2,3,2)
imshow(imag2,[0 255])
title('Standard Equalisation')
subplot(2,3,4)
imhist(imag)
subplot(2,3,5)
imhist(imag2);
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Do histogram specifictaion
%
maxcoin= input('Upper limit of brightness (between 0-255), defining coin');
coinarea = chist(maxcoin);
%
maxbright = input('Peak brightness (between 0-255), of stretched coin image');
%
amp1 = coinarea./maxbright;
amp2 = (1-coinarea)./(255-maxbright);
newhist = zeros(1,256);
newhist(1:maxbright) = amp1;
newhist((maxbright+1):255) = amp2;
%
% chist2 is target cumlative histogram
%
chist2 = cumsum(newhist);
figure(2)
subplot(1,1,1) 
plot(linspace(0,1,256), newhist)
title('Target normalised  Histogram')
% subplot(2,1,2)
% title('Target Cumulative Histogram');
% plot(linspace(0,1,256), chist2)
%
%
tfunc2 = zeros(1,256);
%
for ii=1:256
  intval = chist(ii);
  diff = abs(chist2-intval);
  minval = min(diff);
  minind = find(diff==minval);
  tfunc2(ii) = minind(1)-1;
end
%
imagout= uint8(tfunc2(imag));
%
figure(1)
subplot(2,3,3)
imshow(imagout,[0 255])
title('Histogram Specification Result')
subplot(2,3,6)
imhist(imagout)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Displays
%
figure(3)
bar(nhist,'y')
axis([0 256 0 0.2]);
hold on
title('Input image histogram')
bar(nhist(1:maxcoin+1),'b')
%
figure(4)
bar(newhist,'y')
axis([0 256 0 0.2]);
hold on
title('target image histogram')
bar(newhist(1:maxbright),'b')



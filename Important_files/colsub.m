%
% colsub.m 
%
% Takes a colour image, decomposes it into its RGB or YIQ
% colour components. Compresses images by subsampling two
% colour planes, then reconstructs image from compressed data.
%
% John Conway, August 2000
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
flowers= imread('flowers.tif');
title('Original Image')
figure(1);
zoom;
imshow(flowers,[]);
red=flowers(:,:,1);
green=flowers(:,:,2);
blue=flowers(:,:,3);
%
% find image size
%
[ims1, ims2] = size(blue);
%
% Display components
%
disp('Now loading/displaying colour image - after its loaded ')
disp('press return to display colour components')
pause
%
figure(2);
zoom;
subplot(3,2,1)
imshow(red,[])
title('Red Component')
subplot(3,2,3)
imshow(green,[])
title('Green Component')
subplot(3,2,5)
imshow(blue,[])
title('Blue Component')
%
% Convert to NTSC colour space
%
yiq = rgb2ntsc(flowers);
y=yiq(:,:,1);
i=yiq(:,:,2);
q=yiq(:,:,3);
%
% Display components
%
figure(2)
subplot(3,2,2)
imshow(y,[])
title('Y - Component')
subplot(3,2,4)
imshow(i,[])
title('I - Component')
subplot(3,2,6)
imshow(q,[])
title('Q -Component')
zoom
%
disp('Enter degree of subsampling on x,y axes, either 2,4,8,16 etc ')
comp=input('to be applied to the green,blue and I,Q images ');
fact = 1./comp;
%
% Subsample red,green,blue components
%
sred = imresize(red, fact);
sgreen = imresize(green, fact);
sblue = imresize(blue, fact);
%
% Subsample y,i,q components
%
sy = imresize(y, fact);
si = imresize(i, fact);
sq = imresize(q, fact);
%
[sims1, sims2] = size(sy);
%
% Make versions for displays
%
sgreen2 = zeros(ims1,ims2);
sblue2 = zeros(ims1,ims2);
sgreen2(1:sims1, 1:sims2) = sgreen(1:sims1, 1:sims2);
sblue2(1:sims1, 1:sims2) = sblue(1:sims1, 1:sims2);
%
si2 = zeros(ims1,ims2);
sq2 = zeros(ims1,ims2);
si2(1:sims1, 1:sims2) = si(1:sims1, 1:sims2);
sq2(1:sims1, 1:sims2) = sq(1:sims1, 1:sims2);
% 
% Display subsampled colorspaces
%
disp('Displaying subsampled components (patience!)')
%
figure(3)
zoom
subplot(3,2,1)
imshow(red,[])
title('Red Component')
subplot(3,2,3)
imshow(sgreen2,[])
title('Subsampled Green Component')
subplot(3,2,5)
imshow(sblue2,[])
title('Subsampled Blue Component')
truesize
%
subplot(3,2,2)
imshow(y,[])
title('Y - Component')
subplot(3,2,4)
imshow(si2,[])
title('Subsampled I - Component')
subplot(3,2,6)
imshow(sq2,[])
title('Subsampled Q -Component')
truesize
zoom
%
disp('If these subsampled data set were transmitted to someone ');
disp('over the internet both the subsampled RGB and subsampled YIQ ');
compress2 =( 1 + 2*(fact^2))/3;
fprintf('data set would require a factor of %4.2f', compress2);
disp(' fewer bits than transmitting the colour image uncompressed');
disp(' ');
%
%
disp('Press return to display restored images from subsampled data (patience!)')
pause
%
disp('          ')
disp('After the data is received the subsampled colour components must')
disp('be re-interpolated to full size ')
disp('and for YIQ be  converted back to RGB at each pixel before displaying ')
disp('This is what the program is doing now ')
disp('          ')
%
% interpolate back red,green,blue components
%
% ssred = imresize(sred, [362 500], 'bicubic');
% ssgreen = imresize(sgreen, [362 500], 'bicubic');
% ssblue = imresize(sblue, [362 500], 'bicubic');
%
ssred = imresize(sred, [362 500], 'bilinear');
ssgreen = imresize(sgreen, [362 500], 'bilinear');
ssblue = imresize(sblue, [362 500], 'bilinear');
%
r1flowers=uint8(zeros(362,500,3));
r1flowers(:,:,1)=red(:,:);
r1flowers(:,:,2)=ssgreen(:,:);
r1flowers(:,:,3)=ssblue(:,:);
%
% interpolate back  y,i,q components
%
% ssy = imresize(sy, [362 500], 'bicubic');
% ssi = imresize(si, [362 500], 'bicubic');
% ssq = imresize(sq, [362 500], 'bicubic');
%
ssy = imresize(sy, [362 500], 'bilinear');
ssi = imresize(si, [362 500], 'bilinear');
ssq = imresize(sq, [362 500], 'bilinear');
%
r2flowers=zeros(362,500,3);
r2flowers(:,:,1)= y(:,:);
r2flowers(:,:,2)= ssi(:,:);
r2flowers(:,:,3)= ssq(:,:);
r3flowers=(ntsc2rgb(r2flowers));
r3flow=double(r3flowers);
%
figure(4)
subplot(1,2,1)
imshow(r1flowers,[])
title('RGB compressed Image')
zoom on
disp('Figure No4 gives RGB and YIQ compressed Images')
%
subplot(1,2,2)
imshow(r3flow,[])
title('YIQ compressed Image')
zoom on
%
disp('Use mouse and left button to zoom in ')
disp('and look at details. Which method of compression')
disp('RGB subsampled or YIQ subsampled has better quality?')
figure(4)
%











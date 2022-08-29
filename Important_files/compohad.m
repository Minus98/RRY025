function compohad(input,fact);
%
% John Conway, ERR041
%
% Compresses a transform by a factor 'fact'
% using the ordered Hadamard  transform and keeping  the top left corner of 
% input image  zeroing the rest.
%
load('oh256.mat');
figure(1)
subplot(1,1,1) 
imshow(input, [])
title('Input Image')
zoom
%
din = oh256'*double(input)*oh256;
im = min(min(din));
ldin = log(0.0001 + abs(din));
%
figure(2)
subplot(2,1,1) 
imshow(ldin, [])
zoom
title('Log of Hadamard Transform')
drawnow;
%
[s1, s2]=size(input);
npix = s1*s2/fact;
keep = sqrt(npix);
%
bdin = din ;
xx = 1:s1;
yy = 1:s2;
[XX, YY] = meshgrid(xx,yy);
index=find(XX>keep);
bdin(index)=0;
index=find(YY>keep);
bdin(index)=0;
im = min(min(din));
lbdin = log(0.0001 + abs(bdin));
%
subplot(2,1,2) 
imshow(lbdin, [])
title('Kept Hadamard Components')
zoom
drawnow;
%
rest = oh256*bdin*oh256;
%
figure(3)
subplot(1,1,1) 
imshow(rest, [])
title('Reconstructed Image')
 zoom;
disp(' Mean square error of Reconstructed image')
ms = mse(input,rest)

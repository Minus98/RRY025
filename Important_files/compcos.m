function compcos(input,fact);
%
% John Conway, ERR041
%
% Compresses a transform by a factor 'fact'
% using the cosine transform and keeping  the top left corner of 
% input image  zeroing the rest.
%
figure(1)
subplot(1,1,1) 
imshow(input, [])
title('Input Image')
zoom
%
din = dct2(input);
ldin = log(10 + din);
%
figure(2)
subplot(2,1,1) 
imshow(ldin, [])
zoom
title('Log of DCT')
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
lbdin = log(10 + bdin);
%
subplot(2,1,2) 
imshow(lbdin, [])
title('Kept DCT')
zoom
drawnow;
%
rest = idct2(bdin);
%
figure(3)
subplot(1,1,1) 
imshow(rest, [])
title('Reconstructed Image')
 zoom;
disp(' Mean square error of Reconstructed image')
ms = mse(input,rest)

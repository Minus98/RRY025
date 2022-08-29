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
fin = fft2(input);
lfin = log(10 + abs(fin));
%
figure(2)
subplot(2,1,1) 
imshow(lfin, [])
zoom
title('Log of DFT amplitude')
drawnow;
%
[s1, s2]=size(input);
npix = s1*s2/fact;
keep = (sqrt(npix))/2;
%
mask1=ones(s1,s2);
mask2=ones(s1,s2);
xx = 1:s1;
yy = 1:s2;
[XX, YY] = meshgrid(xx,yy);
index=find(XX>(keep+1));
mask1(index)=0;
index=find(YY>(keep+1));
mask1(index)=0;
%
index=find(XX>(keep));
mask2(index)=0;
index=find(YY>(keep));
mask2(index)=0;
%
mask3 = 0.5*(mask1 +rot90(mask2))';
bfin = fin.*mask3;
lbfin = log(10 + abs(bfin));
%
subplot(2,1,2) 
imshow(lbfin, [])
title('Kept DFT')
zoom
drawnow;
%
rest = 2*real(ifft2(bfin));
%
figure(3)
subplot(1,1,1) 
imshow(rest, [])
title('Reconstructed Image')
zoom;
disp(' Mean square error of Reconstructed image')
ms = mse(input,rest)





function cosshow(input);
%
% John Conway, ERR041
%
% Compresses a transform by a factor 'fact'
% using the cosine transform and keeping  the top left corner of 
% input image  zeroing the rest.
%
figure(1)
subplot(2,2,1) 
imshow(input, [])
title('Input Image')
zoom
%
din = dct2(input);
ldin = log(10 + din);
%
subplot(2,2,2) 
imshow(ldin, [])
zoom
title('Log of DCT')
drawnow;
%
fin = fft2(input);
lrfin = log(10 + abs(real(fin)));
subplot(2,2,3) 
imshow(lrfin, [])
title('Log of Real Part of DFT')
subplot(2,2,4) 
lifin = log(10 + abs(imag(fin)));
imshow(lrfin, [])
title('Log of Imaginary Part of DFT')
%
figure(2)
subplot(2,1,1) 
imshow(fftshift(ldin), [])
lafin = log(10 + abs(fin));
title('Shifted Log of DCT')
subplot(2,1,2) 
imshow(fftshift(lafin), [])
title('Shifted Log of amp of DFT')




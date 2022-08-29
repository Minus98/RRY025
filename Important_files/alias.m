clf
t=0:0.2:20;
[x,y]=meshgrid(t,t);
I = 0.5+0.25*sin(2*sqrt(x.^2 + y.^2))+...
0.25*sin(16*sqrt(x.^2+y.^2));
subplot(2,2,1); imshow(I,64);
title('I = 0.5+0.25*sin(2*sqrt(x.^2 + y.^2))+0.25*sin(16*sqrt(x.^2+y.^2));')
F=mat2gray(log(abs(fftshift(fft2(I)))));
rF = res(F);
subplot(2,2,2), imshow(rF,64);
title('Log Amp FT')
pause;
J=imresize(I,0.5,'bilinear',0);
subplot(2,2,3); imshow(J,64);
title('subsampled and reconstructed')
FJ=mat2gray(log(abs(fftshift(fft2(J)))));
rFJ = res(FJ);
subplot(2,2,4), imshow(rFJ,64);
title('Log Amp FT')

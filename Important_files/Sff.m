%
%
%
clear; close all;
%loading images and displaying 
load picard.mat;
load riker.mat;
load data.mat;
load beverly.mat;
load troi.mat;
load geordi.mat;
figure(1);
subplot(2,3,1)
imshow(p,'notrue');colormap(gray);title('Picard')
pause(1);
subplot(2,3,2)
imshow(r,'notrue');colormap(gray);title('Riker')
pause(1);
subplot(2,3,3)
imshow(d,'notru');colormap(gray);title('Data')
pause(1);
subplot(2,3,4)
imshow(b,'notru');colormap(gray);title('Crusher')
pause(1);
subplot(2,3,5)
imshow(t,'notru');colormap(gray);title('Troi')
pause(1);
subplot(2,3,6)
imshow(g,'notru');colormap(gray);title('Geordi')
pause;
%
fp=abs(fftshift(fft2(fftshift(p))));
fr=abs(fftshift(fft2(fftshift(r))));
fd=abs(fftshift(fft2(fftshift(d))));
fb=abs(fftshift(fft2(fftshift(b))));
ft=abs(fftshift(fft2(fftshift(t))));
fg=abs(fftshift(fft2(fftshift(g))));
%
pp=fp.*fp;
pr=fr.*fr;
pd=fd.*fd;
pb=fb.*fb;
pt=ft.*ft;
pg=fg.*fg;
%
lp = log(1+pp);
lp = lp/(max(max(lp)));
lr = log(1+pr);
lr = lr/(max(max(lr)));
ld = log(1+pd);
ld = ld/(max(max(ld)));
lb = log(1+pb);
lb = lb/(max(max(lb)));
lt = log(1+pt);
lt = lt/(max(max(lt)));
lg = log(1+pg);
lg = lg/(max(max(lg)));
%
clf
subplot(2,3,1)
imshow(lp)
title('Log Power -Picard')
subplot(2,3,2)
imshow(lr)
title('Log Power -Riker')
subplot(2,3,3)
imshow(ld)
title('Log Power -Data')
subplot(2,3,4)
imshow(lb)
title('Log Power -Crusher')
subplot(2,3,5)
imshow(lt)
title('Log Power -Troi')
subplot(2,3,6)
imshow(lg)
title('Log Power -Geordi')
pause;
%
sff = (pp +pr+pd+pb+pt+pg)/6;
lsff = log(1 + sff);
lsff = lsff/(max(max(lsff)));
clf
subplot(1,1,1);
imshow(lsff);
title('Ensemble Log Power Spectrum - Sff')








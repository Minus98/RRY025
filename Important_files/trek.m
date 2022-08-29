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
% subplot(2,3,6)
% imshow(g,'notru');colormap(gray);title('Geordi')
disp(' press return to continue ')
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
% subplot(2,3,6)
% imshow(lg)
% title('Log Power -Geordi')
disp(' press return to continue ')
pause;
%
%<sff = (pp +pr+pd+pb+pt+pg)/6;
sff = (pp +pr+pd+pb+pt)/5;
maxsff=max(max(sff))
lsff = log(1 + sff);
lsff = lsff/(max(max(lsff)));
clf
subplot(1,1,1);
imshow(lsff);
title('Ensemble Log Power Spectrum - Sff')
disp(' press return to continue ')
pause
%
% Now do Wiener filter example
% 
clf
%
%
harray = zeros(48,48);
num = 1/9;
harray(20,25) = num;
harray(21,25) = num;
harray(22,25) = num;
harray(23,25) = num;
harray(24,25) = num;
harray(25,25) = num;
harray(26,25) = num;
harray(27,25) = num;
harray(28,25) = num;
%
% hrow=[0 0 0 1 0 0 0 ];
% hcol=[1 1 1 1 1 1 1 ];
% hcol = hcol/7;
%
rms=input(' Input rms noise per pixel ')
%
%
% Take FT of true image
%
fg =fftshift(fft2(fftshift(g)));
%
% Take FT of PSF
%
fha=fftshift(fft2(fftshift(harray)));
%
% Multiply FT of image by transfer function
%
fcg = fha.*fg;
%
% IFFT to give image convolved by PSF 
%
cg=fftshift(ifft2(fftshift(fcg)));
rcg =real(cg);
%
% Add noise to image
%
var = rms.^2;
ng = imnoise(rcg,'gaussian',0,var);
%
subplot(2,1,1)
imshow(ng,[0 max(max(ng))]);title('Distorted image + noise')
%
subplot(2,1,2)
imshow(harray,[0 max(max(harray))]);title('PSF')
zoom
disp(' press return to continue ')
pause;
%
%
clf
%
subplot(2,2,1)
imshow(lsff,[0 max(max(lsff))]);title('Log of Sff')
%
subplot(2,2,2)
snn=zeros(48,48);
% 
snn=ones(48,48).*48*48*rms.*rms;
lsnn=log(1+snn);
imshow(lsnn,[0 2*max(max(lsff))]);title('Log of Snn')
%
subplot(2,2,3)
fh = fftshift(fft2(fftshift(harray)));
afh = abs(fh);
imshow(afh,[0 max(max(afh))]);title('FT of PSF, H(u,v)')
%
subplot(2,2,4)
wf = ((conj(fh)).*sff)./( ((afh.*afh).*sff) + snn );
lwf = log(abs(wf) + 1);
imshow(abs(wf),[0 max(max(abs(wf)))]);title('Wiener Filter')
%
disp(' press return to continue ')
pause
clf
%
subplot(2,2,1)
imshow(ng,[0 max(max(ng))]);title('Distorted image + noise')
%
fcg= fftshift(fft2(fftshift(ng)));
lafcg = log(abs(fcg) + 1);
subplot(2,2,2)
imshow(lafcg,[0 max(max(lafcg))]);title('FT of Distorted image +noise')
%
rfg = fcg .* wf;
lrfg = log(1+abs(rfg));
subplot(2,2,3)
imshow(lrfg,[0 max(max(lrfg))]);title('After multiplying by Wiener Filter')
%
subplot(2,2,4)
imshow(lg,[0 max(max(lg))]);title('FT of True Image')
pause
clf
subplot(2,2,1)
imshow(rcg,[0 max(max(rcg))]);title('Distorted image')
subplot(2,2,2)
rg= abs(fftshift(ifft2(fftshift(rfg))));
imshow(rg,[0 max(max(rg))]);title('Restored image')
subplot(2,1,2)
imshow(g,[0 max(max(g))]);title('True Image')
zoom















%
%
%
clf;
clear;
%loading images and displaying 
load i0.mat;
load i1.mat;
load i2.mat;
load i3.mat;
load i4.mat;
load i5.mat;
load i6.mat;
load i7.mat;
load i8.mat;
load i9.mat;
figure(1);
subplot(4,3,1);
imshow(i0);
subplot(4,3,2);
imshow(i1);
subplot(4,3,3);
imshow(i2);
subplot(4,3,4);
imshow(i3);
subplot(4,3,5);
imshow(i4);
subplot(4,3,6);
imshow(i5);
subplot(4,3,7);
imshow(i6);
subplot(4,3,8);
imshow(i7);
subplot(4,3,9);
imshow(i8);
subplot(4,3,10);
imshow(i9);
%
[m n]=size(i0)
N=m*n
%
% convert to
% a vector
% representation
%
p0=reshape(i0',1,N);
p1=reshape(i1',1,N);
p2=reshape(i2',1,N);
p3=reshape(i3',1,N);
p4=reshape(i4',1,N);
p5=reshape(i5',1,N);
p6=reshape(i6',1,N);
p7=reshape(i7',1,N);
p8=reshape(i8',1,N);
p9=reshape(i9',1,N);
%
mean=(p0+p1+p2+p3+p4+p5+p6+p7+p8+p9)/10;
rmean=reshape(mean',5,5);
pause;
clf;
subplot(1,10,1)
imshow(p0');
title('0')
subplot(1,10,2)
imshow(p1');
title('1')
subplot(1,10,3)
imshow(p2');
title('2')
subplot(1,10,4)
imshow(p3');
title('3')
subplot(1,10,5)
imshow(p4');
title('4')
subplot(1,10,6)
imshow(p5');
title('5')
subplot(1,10,7)
imshow(p6');
title('6')
subplot(1,10,8)
imshow(p7');
title('7')
subplot(1,10,9)
imshow(p8');
title('8')
subplot(1,10,10)
imshow(p9');
title('9')
%
Y(1,:)=p0;
Y(2,:)=p1;
Y(3,:)=p2;
Y(4,:)=p3;
Y(5,:)=p4;
Y(6,:)=p5;
Y(7,:)=p6;
Y(8,:)=p7;
Y(9,:)=p8;
Y(10,:)=p9;
%
% calculate image covariance matrix
imcov=cov(Y);
%
pause;
clf;
subplot(1,1,1);
imax=max(max(imcov));
imin=min(min(imcov));
imshow(imcov,[imin imax]);colorbar
pause
clf
%
%
% Find Eigenvector matrix
%
[v d] = eig(imcov);
imax=max(max(v));
imin=min(min(v));
subplot(1,1,1)
imshow(v,[imin imax]);colorbar; 
title('KLT Matrix')
%
d1=reshape(v(:,1),5,5);
d2=reshape(v(:,2),5,5);
d3=reshape(v(:,3),5,5);
d4=reshape(v(:,4),5,5);
d5=reshape(v(:,5),5,5);
d6=reshape(v(:,6),5,5);
d7=reshape(v(:,7),5,5);
d8=reshape(v(:,8),5,5);
d9=reshape(v(:,9),5,5);
d10=reshape(v(:,10),5,5);
d11=reshape(v(:,11),5,5);
d12=reshape(v(:,12),5,5);
d13=reshape(v(:,13),5,5);
d14=reshape(v(:,14),5,5);
d15=reshape(v(:,15),5,5);
d16=reshape(v(:,16),5,5);
d17=reshape(v(:,17),5,5);
d18=reshape(v(:,18),5,5);
d19=reshape(v(:,19),5,5);
d20=reshape(v(:,20),5,5);
d21=reshape(v(:,21),5,5);
d22=reshape(v(:,22),5,5);
d23=reshape(v(:,23),5,5);
d24=reshape(v(:,24),5,5);
d25=reshape(v(:,25),5,5);
%
pause 
clf
%
subplot(5,5,1)
imshow(d25)
subplot(5,5,2)
imshow(d24)
subplot(5,5,3)
imshow(d23)
subplot(5,5,4)
imshow(d22)
subplot(5,5,5)
imshow(d21)
subplot(5,5,6)
imshow(d20)
subplot(5,5,7)
imshow(d19)
subplot(5,5,8)
imshow(d18)
subplot(5,5,9)
imshow(d17)
subplot(5,5,10)
imshow(d16)
subplot(5,5,11)
imshow(d15)
subplot(5,5,12)
imshow(d14)
subplot(5,5,13)
imshow(d13)
subplot(5,5,14)
imshow(d12)
subplot(5,5,15)
imshow(d11)
subplot(5,5,16)
imshow(d10)
subplot(5,5,17)
imshow(d9)
subplot(5,5,18)
imshow(d8)
subplot(5,5,19)
imshow(d7)
subplot(5,5,20)
imshow(d6)
subplot(5,5,21)
imshow(d5)
subplot(5,5,22)
imshow(d4)
subplot(5,5,23)
imshow(d3)
subplot(5,5,24)
imshow(d2)
subplot(5,5,25)
imshow(d1)
pause
clf
%
%
% take KLT of digit 3
%
k3=v*p3'
rk3=reshape(k3,5,5);
frk3=[5, 4, 1, 2, 1; 
      3, 4, 2, 0, 0; 
      2, 1, 1, 0, 0.2;
     0.5, 0.3, 0, 0.1, 0.1;
      0,  0.1, 0, 0.05, 0.03]
imax=max(max(frk3));
imin=min(min(frk3));
subplot(1,2,1)
imshow(i3);colorbar;
subplot(1,2,2)
imshow(frk3,[imin imax]);colorbar;
pause
clf
%
%
sum =rmean'
%subplot(1,1,1)
%imshow(sum); title('Mean Image')
%pause(4)
sum = sum + k3(25)*d25';
subplot(1,1,1)
imshow(sum); title('Mean + 1 Component')
pause(1)
sum = sum + k3(24)*d24';
subplot(1,1,1)
imshow(sum); title('2 Components')
pause(1)
sum = sum + k3(23)*d23';
subplot(1,1,1)
imshow(sum); title('3 Components')
pause(1)
sum = sum + k3(22)*d22';
subplot(1,1,1)
imshow(sum); title('4 Components')
pause(1)
sum = sum + k3(21)*d21';
subplot(1,1,1)
imshow(sum); title('5 Components')
pause(1)
sum = sum + k3(20)*d20';
subplot(1,1,1)
imshow(sum); title('6 Components')
pause(1)
sum = sum + k3(19)*d19';
subplot(1,1,1)
%imshow(sum); title('7 Components')
%pause(1)
sum = sum + k3(18)*d18';
subplot(1,1,1)
%imshow(sum); title('8 Components')
%pause(1)
sum = sum + k3(17)*d17';
subplot(1,1,1)
%imshow(sum); title('9 Components')
%pause(1)
sum = sum + k3(16)*d16';
subplot(1,1,1)
% imshow(sum); title('10 Components')
% pause(1)
sum = sum + k3(15)*d15';
sum = sum + k3(14)*d14';
sum = sum + k3(13)*d13';
sum = sum + k3(12)*d12';
sum = sum + k3(11)*d11';
% imshow(sum); title('15 Components')
% pause(4)
sum = sum + k3(10)*d10';
sum = sum + k3(9)*d9';
sum = sum + k3(8)*d8';
sum = sum + k3(7)*d7';
sum = sum + k3(6)*d6';
sum = sum + k3(5)*d5';
sum = sum + k3(4)*d4';
sum = sum + k3(3)*d3';
sum = sum + k3(2)*d2';
sum = sum + k3(1)*d1';
% imshow(sum); title('25 Components')
% pause 
% clf
%
%
% take KLT of digit 2
%
%k2=v*p2'
%rk2=reshape(k2,5,5);
%imax=max(max(rk2));
%imin=min(min(rk2));
%pause
%clf
%subplot(1,2,1)
%imshow(i2,[imin imax]);colorbar;
%subplot(1,2,2)
%imshow(rk2,[imin imax]);colorbar






















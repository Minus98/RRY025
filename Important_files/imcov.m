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
%forming covariance matrix;
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















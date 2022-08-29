%EE528 Spring 97 Class Demo
%Shreekanth Mandayam, E CPE, ISU
%
clear; close all;
%loading images and displaying 
load picard.mat;
load riker.mat;
load data.mat;
load beverly.mat;
load troi.mat;
load geordi.mat;
figure(1);imshow(p,'notrue');colormap(gray);title('Picard')
pause(1);
figure(2);imshow(r,'notrue');colormap(gray);title('Riker')
pause(1);
figure(3);imshow(d,'notru');colormap(gray);title('Data')
pause(1);
figure(4);imshow(b,'notru');colormap(gray);title('Crusher')
pause(1);
figure(5);imshow(t,'notru');colormap(gray);title('Troi')
pause(1);
%figure(6);imshow(g,'notru');colormap(gray);title('Geordi')


[m n]=size(p);
N=m*n;
%forming mean vector
meanx(1,1)=mean(mean(p));
meanx(2,1)=mean(mean(r));
meanx(3,1)=mean(mean(d));
meanx(4,1)=mean(mean(b));
meanx(5,1)=mean(mean(t));
%meanx(6,1)=mean(mean(g));

%forming covariance matrix;
p1=reshape(p',1,N);
r1=reshape(r',1,N);
d1=reshape(d',1,N);
b1=reshape(b',1,N);
t1=reshape(t',1,N);
g1=reshape(g',1,N);
X(1,:)=p1;
X(2,:)=r1;
X(3,:)=d1;
X(4,:)=b1;
X(5,:)=t1;
%X(6,:)=g1;

C=0;
for i=1:N;
 C=C+X(:,i)*(X(:,i))';
end;
C=C/N
 
%computing eigenvalues and eigenvectors
[V,D]=eig(C);
D

%Computing Transform
for i=1:N;
 Y(:,i)=(V')*(X(:,i)-meanx);
end;

%Show the 3 Principal Transformed Images
im1=reshape(Y(5,:),m,n);
im2=reshape(Y(4,:),m,n);
im3=reshape(Y(3,:),m,n);
im4=reshape(Y(2,:),m,n);
im5=reshape(Y(1,:),m,n);

%Sorting and arranging
A(:,1)=V(:,5);
A(:,2)=V(:,4);
A(:,3)=V(:,3);
%A=V;
A=A';

%Stored Ys correspond to these principal images
Ys(1,:)=Y(5,:);
Ys(2,:)=Y(4,:);
Ys(3,:)=Y(3,:);
%Ys(4,:)=Y(2,:);

%Ys=Y;

%Reconstruction
for i=1:N;
 Xr(:,i)=(A)'*Ys(:,i)+meanx;
end;



%Display Principal Images
figure; imshow(im1','not');colormap(gray); title('Principal Component 1')
pause(1)
figure; imshow(im2','not');colormap(gray); title('Principal Component 2')
pause(1)
figure; imshow(im3','not');colormap(gray); title('Principal Component 3')
pause(1)
figure; imshow(im4','not');colormap(gray); title('Principal Component 4')
pause(1)
figure; imshow(im5','not');colormap(gray); title('Principal Component 5')



pause

%Display results;
for i=1:1;
 figure(5+i)
 subplot(1,2,1);
 imshow(p,'not');colormap(gray); title('Original Image')
 im=reshape(Xr(i,:),m,n);
 subplot(1,2,2);
 imshow(im','not');colormap(gray); title('Reconstructed image from 3 Principal Components')
 pause
end; 

for i=2:2;
 figure(5+i)
 subplot(1,2,1);
 imshow(r,'not');colormap(gray); title('Original Image')
 im=reshape(Xr(i,:),m,n);
 subplot(1,2,2);
 imshow(im','not');colormap(gray); title('Reconstructed image from 3 Principal Components')
 pause
end; 

for i=3:3;
 figure(5+i)
 subplot(1,2,1);
 imshow(d,'not');colormap(gray); title('Original Image')
 im=reshape(Xr(i,:),m,n);
 subplot(1,2,2);
 imshow(im','not');colormap(gray); title('Reconstructed image from 3 Principal Components')
 pause
end; 

for i=4:4;
 figure(5+i)
 subplot(1,2,1);
 imshow(b,'not');colormap(gray); title('Original Image')
 im=reshape(Xr(i,:),m,n);
 subplot(1,2,2);
 imshow(im','not');colormap(gray); title('Reconstructed image from 3 Principal Components')
pause;
end; 


for i=5:5;
 figure(5+i)
 subplot(1,2,1);
 imshow(t,'not');colormap(gray); title('Original Image')
 im=reshape(Xr(i,:),m,n);
 subplot(1,2,2);
 imshow(im','not');colormap(gray); title('Reconstructed image from 3 Principal Components')
 pause 
end; 










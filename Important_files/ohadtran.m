figure(1)
clf
%
load('picard64.mat');
p64= picard64;
load('ordhad64');
%
% normalise transform matrix
%
mat = oh/64;
clear oh;
%
sum = zeros(64,64);
samp = zeros(64,64);
samp(1,1) = 1;
%
%
% Take 2D Hadamard Transform 
%
hp = mat'*p64*mat;
%
% Calculate starting mean square error (MSE)
%
ve = reshape(hp, 64*64, 1);
mse = ve'*ve;
clear ve;
msv= zeros(round(1+64*64/10),1);
%
% Plot DC image
%
sum = (1/64)*hp(1,1);
imshow(sum, [0 1])
mse =  mse - (hp(1,1))^2;
msv(1) = mse;
count=1;
%
% Scan across diagonals
% adding in weighted basis images
% calculating and plotting MSE
%
%
for d=3:65
 for v=1:d-1;
%
  count = count+1;
%
  u = d - v; 
%
  x = mat(:,v);
  y = mat(:,u);  
  [XX, YY] = meshgrid(x,y);
  f = XX.*YY;
  sum = sum + f*hp(u,v);
%
  subplot(2,2,1)
  imshow(sum,[ ])
  title(' Reconstructed Image')  
  drawnow
%
  subplot(2,2,2)
  imshow(picard64,[0 1])
  title(' Original Image ')  
  drawnow
%
  samp(u,v) = 1;
  subplot(2,2,3)
  imshow(samp,[0 1])
  title(' Coefficent Images used ')  
  drawnow
%
  mse =  mse - (hp(u,v))^2;
  msv(count) = mse;
  subplot(2,2,4);
  plot(msv);
  title(' Reconstructed Image Mean Square  Error')  
  ylabel(' Mean Square Error');
  xlabel(' Number of basis Images');
  drawnow
%
 end
end 
%
%
for d=65:-1:2;
 for vv=d-1:-1:1;
%
  count = count+1;
%
  uu = d - vv; 
%
  u = 65 -uu;
  v = 65 -vv;
%
  x = mat(:,v);
  y = mat(:,u);  
  [XX, YY] = meshgrid(x,y);
  f = XX.*YY;
  sum = sum + f*hp(u,v);
%
  subplot(2,2,1)
  imshow(sum,[ ])
  title(' Reconstructed Image')  
  drawnow
%
  samp(u,v) = 1;
  subplot(2,2,2)
  title(' True  Image')  
  imshow(picard64,[0 1])
  drawnow
%
  samp(u,v) = 1;
  subplot(2,2,3)
  title(' Coefficient Images used ')  
  imshow(samp,[0 1])
  drawnow
%
  mse =  mse - (hp(u,v))^2;
  msv(count) = mse;
  subplot(2,2,4);
  plot(msv);
  title(' Reconstructed Image Mean Square  Error')  
  ylabel(' Mean Square Error');
  xlabel(' Number of basis Images');
  drawnow
%
 end
end 
%

%
%









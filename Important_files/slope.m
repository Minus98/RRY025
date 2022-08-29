% ERR041 Laasperiod 1 00/01
% John Conway
% 
%
clf;
for i=1:128
for j=1:128
  im1(i,j)  = 0.5;
  im2(i,j)  = 0.5  + 0.25*((i-63)/64);
  im3(i,j)  = 0.5  + 0.25*((j-63)/64);
  im4(i,j)  = 0.5 +  0.25*(((i-63)/128) +  ((j-63)/128));
end
end
ft1 = fftshift(abs(fft2(im1)));
%
figure(1);
subplot(2,2,1);
imshow(im1,[0 1]);colorbar('horiz');title('Constant Brightness(im1)');
%
subplot(2,2,2);
imshow(im2,[0 1]);colorbar('horiz');title('Vertical Slope Function (im2)');
%
subplot(2,2,3);
imshow(im3,[0 1]);colorbar('horiz');title('Horizontal Slope Function (im3)');
%
subplot(2,2,4);
imshow(im4,[0 1]);colorbar('horiz');title('Diagonal Slope Function (im4)');
%







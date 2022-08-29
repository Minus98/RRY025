% ERR041 Laasperiod 1 00/01
% John Conway
% 
%
clear
clf;
for i=1:128
for j=1:128
  fcos1(i,j) = cos(2*pi*i/32) * cos(2*pi*j/64); 
%  fcos2(i,j) = cos(0.6123*pi+(2*pi*i/32)) * cos(0.324*pi+(2*pi*j/64)); 
  fcos2(i,j) = cos(2*pi*i/32.3) * cos(2*pi*j/64.3); 
end
end
%
subplot(2,1,1);
imshow(fcos1,[-1 1]);colorbar('horiz');title('cos(2*pi*i/32) * cos(2*pi*j/64); ');
%
%
% subplot(2,2,2);
% colormap(gray);
% imshow(fc1,[0 1]);colorbar('horiz');title('FT Amplitude') 
%
% subplot(2,2,3);
% imshow(fcos2,[-1 1]);colorbar('horiz');title('An Aperiodic Function');
% pause;
%
%
% subplot(2,2,4);
% colormap(gray);
% imshow(fc2,[0 1]);colorbar('horiz');title('FT Amplitude') 
% pause;
% clf;
%
subplot(2,1,2);
imshow(fcos2,[-1 1]);colorbar('horiz');title('cos(2*pi*i/32.3)*cos(2*pi*j/64.3)');
%
%
% subplot(2,2,4);
% colormap(gray);
% imshow(fc3,[0 1]);colorbar('horiz');title('FT Amplitude') 
% pause;
%
whos
disp('Take the centered  DFT of the two functions fcos1 and fcos2')
disp('what do you expect in each case?')






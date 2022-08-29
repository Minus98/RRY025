load('camera.mat')
cam = X;
subplot(2,2,1); 
imshow(cam, [0 255]);
psf = 0.05*ones(1,20);
ccam = conv2(cam,psf,'full');
subplot(2,2,2);
imshow(ccam, [0 255]);
siz = size(cam);
%
rest= zeros(1,siz(1));
for  m=1:siz(1);
 m1 = rem(m,20);
%
 if (m1==0);
   rest(m) = 1;
 else 
%
  if (m1==1)
   rest(m) = -1;
  else
   rest(m) = 0;
  end
%
 end
%
end
%
rcam = conv2(ccam,rest,'full');
subplot(2,1,2) 
imshow(rcam, [0 20]);

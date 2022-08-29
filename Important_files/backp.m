%
% Select input image
% 
ctrl=input('Select input. 1-One square, 2-Three squares, 3.Human slice ')
%
switch ctrl
%
case(1) 
%
 sqs=zeros(128,128);
 sqs(43:45,43:45)=1;
 p= sqs;
%
case(2)
%
 sqs=zeros(128,128);
 sqs(32:34,42:44)=1;
 sqs(50:52,15:17)=1;
 sqs(100:102,100:102)=1;
 p=sqs;
%
otherwise
%
 p=phantom(128);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(1)
clf
rp = radon(p,0);
[nn, mm]=size(rp);
ed = round((nn-128)/2);
p1 = zeros(nn,nn);
p1(ed:ed+128-1,ed:ed+128-1)=p;
subplot(2,2,1)
imax=max(max(p1));
imshow(flipud(p1),[0 imax/2]);
title('Original Image')
%
nproj= input('Number of projections ');
dopause = input('Enter >0 to pause at each backprojection ');
theta = linspace(0, (180-180/nproj), nproj);
rp = radon(p,theta);
[nn, mm]=size(rp);
xint = linspace(-nn/2,(nn/2)+1,nn);
minx = min(xint);
maxx = max(xint);
%
subplot(2,2,2)
imshow(theta,xint,rp,[])
axis square
axis on
title('Radon Transform')
xlabel('Projection Angle (degrees)');
ylabel('Intercept (pixels)');
hold on;
%
rpp=flipud(rp);
sum = zeros(nn,nn);
%
for i=1:nproj;
%
% hold off
subplot(2,2,2)
% imshow(theta,xint,rpp,[])
% axis square
% axis on
% title('Radon Transform')
% xlabel('Projection Angle (degrees)');
% ylabel('Intercept (pixels)');
% hold on;
xp = [theta(i) theta(i)];
yp = [minx maxx];
plot(xp,yp,'r-');
%
 [xx,yy]=meshgrid(rp(:,i));
 rxx = flipud(imrotate(xx,theta(i),'crop'));
 subplot(2,2,3);
 imshow(rxx,[]);
 drawnow;
 title('Backprojection of the Nth projection')
 sum = sum + rxx;
 subplot(2,2,4);
 imshow(sum,[]);
 drawnow;
 title('Sum of the first N backprojections ')
%
 if (dopause>0)
%
   display('Press return to add next deprojection')
   pause
 else
   if (nproj<20) 
   pause(1)
   else
   end
 end
%
end









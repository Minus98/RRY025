clf
load topo;
[x,y,z] = sphere(40);
I = mat2gray(topo);
%
stations;
rad(1:15) = sqrt( statpos(1:15,1).^2 + statpos(1:15,2).^2 + statpos(1:15,3).^2 )
statpos2=statpos;
statpos2(:,1)= -statpos(:,1)./rad(:)
statpos2(:,2)= statpos(:,2)./rad(:)
statpos2(:,3)= statpos(:,3)./rad(:)
%
statz(1:15) = statpos2(1:15,3);
%
fighand=figure(1);
%
ra=45
dec=input('Enter Declination in degrees ')
%
for i =0:400
%
 ang=-2*pi*(i/400.0);
 xx = x*cos(ang) + y*sin(ang);
 yy = -x*sin(ang) + y*cos(ang);
% subplot(2,1,1)
% warp(xx,-yy,z,topo)
 warp(xx,-yy,z,gray2ind(I,size(topomap1,1)),topomap1)
 view(ra,dec);
 axis image
 hold on
 statxx(1:15)  = statpos2(1:15,1)*cos(-ang) + statpos2(1:15,2)*sin(-ang);
 statyy(1:15)  = -statpos2(1:15,1)*sin(-ang) + statpos2(1:15,2)*cos(-ang);
 plot3(statxx,statyy,statz,'r*');
%
% use either drawnow or movie method
% 
 drawnow
% M=getframe(fighand);
 hold off
%
% subplot(2,1,2)
% plot(statxx,statyy,'b+')
% axis image
% hold on
% drawnow
% hold off
%
end
%
% undelete for moview method
%
% movie(fighand,M,12);
%






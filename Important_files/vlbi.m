clf
load topo;
btopo=im2bw(topo);
[x,y,z] = sphere(40);
I = mat2gray(topo);
%
stations2;
insize=size(statpos);
ns=insize(1)
nbas=ns*(ns-1)/2;
rad=zeros(1,ns);
rad(1:ns) = sqrt( statpos(1:ns,1).^2 + statpos(1:ns,2).^2 + statpos(1:ns,3).^2 )
statpos2=statpos;
statpos2(:,1)= -statpos(:,1)./rad(:)
statpos2(:,2)= statpos(:,2)./rad(:)
statpos2(:,3)= statpos(:,3)./rad(:)
%
statxx = zeros(ns,1);
statyy = zeros(ns,1);
statz = zeros(ns,1);
%
statxx(1:ns,1)= statpos2(1:ns,1);
statyy(1:ns,1)= statpos2(1:ns,2);
statz(1:ns,1) = statpos2(1:ns,3);
%
fighand=figure(1);
%
ra=0
dec=input('Enter Declination in degrees ')
rdec = dec*pi/180;
axislimits=[-1 1 -1 1]
%
subplot(1,2,1)
% whand = warp(xx,-yy,z,gray2ind(I,size(topomap1,1)),topomap1)
whand = warp(x,-y,z,btopo)
set(whand,'Edgecolor','yellow')
 view(ra,dec);
 axis image
 set(whand,'erasemode','normal')
% set(whand,'erasemode','xor')
 hold on
 pl=plot3(statxx,statyy,statz,'r*');
 set(pl,'erasemode','normal')
% set(pl,'erasemode','xor')
 hold off
%
 basu = zeros(nbas,1);
 basv = zeros(nbas,1);
%
subplot(1,2,2)
basu(1) = statxx(1) - statxx(1);
basv(1) = cos(rdec)*(statz(1) - statz(1)) + sin(rdec)*(statyy(1) - statyy(1))
plot(basu(1),basv(1),'r.')
axis image
axis([-2 2 -2 2])
hold on
%
for i =0:200
%
 subplot(1,2,1)
 ang=-2*pi*(i/200.0);
 xx = x*cos(ang) + y*sin(ang);
 yy = -x*sin(ang) + y*cos(ang);
 set(whand,'xdata',xx,'ydata',-yy,'zdata',z)
%
 statxx(1:ns)  = statpos2(1:ns,1)*cos(-ang) + statpos2(1:ns,2)*sin(-ang);
 statyy(1:ns)  = -statpos2(1:ns,1)*sin(-ang) + statpos2(1:ns,2)*cos(-ang);
%
% calculate antennas y'-coord, to see if an antenna is up
%
 statyp  = cos(rdec)*statyy + sin(rdec)*statz;
%
% plot antennas on rotating globe.
%
 set(pl,'xdata',statxx,'ydata',statyy,'zdata',statz)
 drawnow
%
 nb = 0;
%
for i=1:ns 
%
 if (statyp(i)>0)
%
  for j=i+1:ns
%
   if (statyp(j)>0)
      nb = nb+1;
 basu(nb) = statxx(j) - statxx(i);
 basv(nb) = cos(rdec)*(statz(j) - statz(i)) - sin(rdec)*(statyy(j) - statyy(i));
%   
   else
   end
%
  end
%
 else
 end
%
end
%
 subplot(1,2,2)
 plot(basu(1:nb),basv(1:nb),'r.')
 plot(-basu,-basv,'r.')
 axis image
 axis([-2 2 -2 2])
%
% use either drawnow or movie method
% 
% M=getframe(fighand);
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









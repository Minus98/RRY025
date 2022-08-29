clf
ys =   log(rmax/rmin)
tanp = pspiral*(2*pi)/ys
m =    1/tanp
[s,x1,x2] = spline3(m,ys,f);
grand = randn(200);
%
%
alpha
%phi0 = 2*pi*rmin/(3*asep) 
phi0 =  2*pi*rmin/(3*asep)
phi0 = phi0*(1+alpha)*(asep/rmin)^(alpha/(1+alpha)) 
maxphi = 2*pi*(pspiral + pcircle) + phi0
% 
xx = linspace(0,maxphi,1000);
xx2 = xx - phi0;
xxt = xx/(2*pi);
%
% Calculate Radius versus phi of tracks
%
npoint=1000
%
for i = 1:npoint
%
  if (xx2(i)<0.0) 
    rr(i) = rmin*((xx(i)/phi0)^(1+alpha)) ;
    yy(i) = log(rr(i)/rmin);
  else
   if (xx2(i)<x1)  & (xx2(i)<x2) 
     yy(i) = m*xx2(i);
   elseif (xx2(i)>x1) & (xx2(i)<x2)  
     yy(i) = s(1)*xx2(i).^(3) + s(2)*xx2(i).^(2) + s(3)*xx2(i) + s(4);
   else
    yy(i) = ys;
   end
   rr(i) = rmin*exp(yy(i));
  end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Calculate pad density versus phi
%
%
for i = 1:npoint
%
  if (xx2(i)<0.0) 
    if (rr(i)>asep)
     fact = (rr(i)/asep)^(-alpha/(1+alpha));
    else
     fact = 1;
    end
    dphi(i) = (rr(i)/asep)*fact;
  else
   if (xx2(i)<x1)  & (xx2(i)<x2) 
     dphi(i) = spads/(2*pi*pspiral);
   elseif (xx2(i)>x1) & (xx2(i)<x2)  
     dphi(i) = cpads/(2*pi*pcircle);
   else
     dphi(i) = cpads/(2*pi*pcircle);
   end
   rr(i) = rmin*exp(yy(i));
  end
%
end
%
%
%
%%%%%%%%%%  Calculate pad positions %%%%%%%%%%%%%
%
% vectors pxx and prr contain azimuth and radius 
% of geometrically perfect (no randomness) pad 
% positions.
%
sum=0;
isum=0;
osum=0;
n=0;
for i = 1:(npoint-1)
  sum = sum  + dphi(i)*(xx(i+1)-xx(i));
  isum = round(sum+0.5) - 1 ;
  if (isum>osum) 
    n=n+1;
    pxx(n) = xx(i);
    prr(n) = rr(i);
    osum=isum;
  else
  end
end
%
% place final pad position at end of arm
% 
pxx(n+1) = xx(npoint);
prr(n+1) = rr(npoint);
%
npad = n+1
% 
%%%%%%%%%%% Add noise to pad positions %%%%%
%
apxx = 0;
aprr = 0;
m=0
for j=1:3
 for i=1:npad
  m = m + 1;
  apxx(i,j) = pxx(i) + (j-1)*(2*pi/3) +(pnoise*grand(m));
  aprr(i,j) = prr(i)*(1 +  (rnoise*grand(m+500)));
 end
end 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Loop over plots
%
clf
runcycle =  input('Number of arrays to plot, 1 or 2?- ');
for cycle=1:runcycle
%
stpad1 =  input('Start pad - ');
endpad1 = input('End pad - ');
stpad2 =  input('Extra pad 1- ');
endpad2 = stpad2;
stpad3 =  input('Extra pad 2- ');
endpad3 = stpad3;
week =input('Week Number- ');
%
% Calculate antenna positions
%
% stpad =   input('starting pad to occupy on arm')
% endpad =   input('final pad to occupy on arm')
%
%
% atel is number of antennas per arm
%
% loop over arms
%
aaxx=0;
aarr=0;
%
for j=1:3
%
n=0;
%
for i=stpad1:endpad1
  n = n +1;
  aaxx(n,j) = apxx(i,j);
  aarr(n,j) = aprr(i,j);
end
%
if (endpad2>0) 
 for i=stpad2:endpad2
   n = n + 1;
   aaxx(n,j) = apxx(i,j);
   aarr(n,j) = aprr(i,j);
 end
else
end
%
if (endpad3>0) 
 for i=stpad3:endpad3
   n = n + 1;
   aaxx(n,j) = apxx(i,j);
   aarr(n,j) = aprr(i,j);
 end
else
end
%
if (endpad4>0) 
 for i=stpad4:endpad4
   n = n + 1;
   aaxx(n,j) = apxx(i,j);
   aarr(n,j) = aprr(i,j);
 end
else
end
%
end
%
% Number of antennas per arm
%
atel = n
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Calculate x,y positions of antennas 
%
xpos=0;
ypos=0;
n=0
%
for j=1:3
 for i=1:atel
  n = n + 1;
  xpos(i+((j-1)*atel)) = aarr(i,j)*cos(aaxx(i,j) ) ;
  ypos(i+((j-1)*atel)) = aarr(i,j)*sin(aaxx(i,j) ) ;
 end 
end
%
% Add central antenna
%
n = n + 1
xpos(n) = 0.0;
ypos(n) = 0.0;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Calculate baselines
%
bmax = 0;
n=0;
%
bxpos =0;
bypos =0;
bleng=0;
for i = 2:(3*atel)+1
 for j = 1:i-1 
   n = n + 1;
   bxpos(n) = xpos(i) - xpos(j); 
   bypos(n) = ypos(i) - ypos(j);
   bleng = sqrt((bxpos(n)).^2 + (bypos(n)).^2);
%
    if (bleng<10) 
      bleng
      i
      j 
      xpos(i)
      ypos(j)
    else
    end
%
    if (bleng>bmax)
      bmax = bleng;
    else
    end 
 end
end
nbas = n 
%
%%%%%%%%%%%%% Do plots %%%%%%%%%%%%%%%%%%%%%%%%%%%
%
t= 1+(2*(cycle-1));%
%
subplot(2,2,t);
grid off
%
% plot spiral path
%
grid off
[xxr1,yyr1]=pol2cart(xx,rr);
[xxr2,yyr2]=pol2cart(xx+(2*pi/3),rr);
[xxr3,yyr3]=pol2cart(xx+(4*pi/3),rr);
plot(xxr1,yyr1);
axis equal
axis([-(0.6*bmax) (0.6*bmax) -(0.6*bmax) (0.6*bmax)])
hold on
plot(xxr2,yyr2);
plot(xxr3,yyr3);
%
% plot pad positions
%
[xap,yap]=pol2cart(apxx,aprr);
plot(xap,yap,'bo');;
plot(0,0,'o');
%
% plot antenna positions
%
la=plot(xpos,ypos,'o');
%
msize = (233/bmax)*8.5
if (msize<4)
  msize=4
else
end
%
set(la,'Markerfacecolor','b')
set(la,'Markeredgecolor','b')
set(la,'Markersize',msize)
%
xlabel('x(m)')
ylabel('y(m)')
%
word0 = num2str(week);
word1 = 'Occ Pads ';
word2 = num2str(stpad1);
word3 = num2str(endpad1);
word4 = num2str(stpad2);
word5 = num2str(stpad3);
%
if (stpad2>0)
  if (stpad3>0) 
   sent = ['Week ' word0 ' ' word1 ' ' word4 ',' word5  ',' word2 '-' word3];
  else
   sent = ['Week ' word0 ' ' word1 ' ' word4 ','  word2 '-' word3];
  end 
else
 sent = ['Week ' word0 ' ' word1 word2 '-' word3];
end 
title(sent)
%
hold off
%
% plot uv coverage
%
t= 2+(2*(cycle-1));
subplot(2,2,t)
luv=plot(bxpos,bypos,'.')
set(luv,'Markersize',2)
axis equal
axis([-(1.2*bmax) (1.2*bmax) -(1.2*bmax) (1.2*bmax)])
hold on
luv2=plot(-bxpos,-bypos,'.')
set(luv2,'Markersize',2)
word1 = 'UV; Occ Pads ';
%
if (stpad2>0)
  if (stpad3>0) 
   sent = ['Week ' word0 ' ' word1 ' ' word4 ',' word5  ',' word2 '-' word3];
  else
   sent = ['Week ' word0 ' ' word1 ' ' word4 ','  word2 '-' word3];
  end 
else
 sent = ['Week ' word0 ' ' word1 word2 '-' word3];
end 
%
title(sent);
xlabel('u(m)')
ylabel('v(m)')
hold off
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% reset parameters
%
% end big loop cycling over different antenna placements
% in same figure
zoom
end
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
pause
doft =input('Calculate Fourier transform? (enter >0) - ');
%
if (doft>0) 
%
clf
%
% do Fourier transform
%
lambda = 1E-5;
umax = 3*bmax./lambda;
ucell = 2*umax./511.0;
uvgrid=zeros(512,512);
%
for i=1:nbas
%
u= bxpos(i)./lambda;
v= bypos(i)./lambda;
j = round(((u+umax)/ucell)+0.5) + 1;
k = round(((v+umax)/ucell)+0.5) + 1;
uvgrid(j,k) = uvgrid(j,k)+1;
%
u= -bxpos(i)./lambda;
v= -bypos(i)./lambda;
j = round(((u+umax)/ucell)+0.5) + 1;
k = round(((v+umax)/ucell)+0.5) + 1;
uvgrid(j,k) = uvgrid(j,k)+1;
%
end
%
subplot(2,2,1);
imshow(uvgrid)
%
rbeam=real(fftshift(fft2(fftshift(uvgrid))));
rbeam = rbeam/(2*nbas);
ibeam= imag(fftshift(fft2(fftshift(uvgrid))));
ibeam = ibeam/(2*nbas);
subplot(2,2,2);
imshow(rbeam,[-0.1,0.1])
maxrbeam=max(max(rbeam))
minrbeam=min(min(rbeam))
% imshow(ibeam,[-0.1,0.1])
maxibeam=max(max(ibeam))
minibeam=min(min(ibeam))
%
subplot(2,2,3);
plot(rbeam(257,:))
subplot(2,2,4);
plot(rbeam(:,257))
else
end
clear all











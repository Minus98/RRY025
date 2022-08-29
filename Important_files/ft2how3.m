clear
clf
umax=20;
xx = linspace(-64,64,129);
xx2 = linspace(-umax,umax,129);
[XX, YY] = meshgrid(xx);
RR = sqrt(XX.^2 +  YY.^2);
[UU, VV] = meshgrid(xx2);
UVRR = sqrt(UU.^2 +  VV.^2);
phi=0;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp('                                                       ')
disp('This program calculates the continuous Fourier') 
disp('transform of some simple shapes and shows graphically how ') 
disp('the value of the  Fourier transform at spatial frequencies u,v is')
disp('related to  the integral of f(x,y) * k_{u,v)(x,y), where')
disp('k_{u,v)(x,y) is the kernel function corresponding to spatial')
disp('frequencies u,v')
disp('                                                       ')
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Choose shape 
nshape  = input('Choose shape. 1-Circular tophat , 2-Rectangular hat ');
%
if (nshape==2)
%
 aa  = input('Length of Major axis, pixels (1-60) '); 
 bb  = input('Length of Minor axis, pixels (1-60) '); 
 phi  = input('Position angle of Major axis, degrees ');
disp('                                                       ')
%
else
end
%
if (nshape==1)
%
rad  = input('radius of circular tophat, pixels (1-60) '); 
disp('                                                       ')
else
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Create rotated coordinate systems
%
 XXR = XX*cos(pi*phi/180) + YY*sin(pi*phi/180);
 YYR = -XX*sin(pi*phi/180) + YY*cos(pi*phi/180);
%
 UUR = UU*cos(pi*phi/180) + VV*sin(pi*phi/180);
 VVR = -UU*sin(pi*phi/180) + VV*cos(pi*phi/180);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 u = input('Enter spatial frequency u_{o} (cycles across image) ');
 v = input('Enter spatial frequency v_{o} (cycles across image) ');
disp('                                                       ')
%
 ur = u*cos(pi*phi/180) + v*sin(pi*phi/180);
 vr = -u*sin(pi*phi/180) + v*cos(pi*phi/180);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if (nshape==2) 
%
% Create rectangular tophat function
%
 recthat = zeros(129,129);
 index=find( (abs(XXR)<(aa./2)) & (abs(YYR) < (bb./2)));
 recthat(index) = 1;
 zzf=recthat;
%
%    Calculate Fourier transforms
%
 temp1 =(sin(pi*aa*UUR./128)+eps)./(pi*aa*UUR./128+eps); 
 temp2 =(sin(pi*bb*VVR./128)+eps)./(pi*bb*VVR./128+eps); 
 ftr= temp1.*temp2;
 fti=zeros(129,129);
%
%    Calculate value of FT at point u,v
%
 temp1 =(sin(2*pi*aa*ur./128)+eps)./(2*pi*aa*ur./128+eps); 
 temp2 =(sin(2*pi*bb*vr./128)+eps)./(2*pi*bb*vr./128+eps); 
 rvaluv = temp1*temp2;
 ivaluv = 0;
%
 disp('The real value of the FT at u_{o},v_{o} is ')
 disp(rvaluv)  
 disp('The imaginary value of the FT at u_{o},v_{o} is ') 
 disp(ivaluv) 
else
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if (nshape==1) 
%
% Create circular tophat function
%
 tophat = zeros(129,129);
 index=find(abs(RR)<rad);
 tophat(index) = 1;
 zzf=tophat;
%
 rfthat=((2./pi).*besselj(1,(2*rad*pi*UVRR./128))+eps)./(2*rad*UVRR./128+eps);
 ftr= rfthat;
 fti=zeros(129,129);
%
%    Calculate value of FT at point u,v
%
 rad2 = sqrt(u.^2 + v.^2);
 rvaluv=((2./pi)*besselj(1,(2*rad*pi*rad2./128))+eps)./(2*rad*rad2./128+eps);
 ivaluv = 0;
%
 disp('The real value of the FT at u_{o},v_{o} is ')
 disp(rvaluv)  
 disp('The imaginary value of the FT at u_{o},v_{o} is ') 
 disp(ivaluv) 
%
else
end 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
temp =((u*XX) + (v*YY))/128; 
fmat = exp(-2*pi*i*temp);
%
freal = real(fmat);
fimag = imag(fmat);
%
zzr = freal.*zzf;
zzi = fimag.*zzf;
%
disp('                                      ')
disp('Plotting functions as grayscales ')
disp('Black is -1 and white +1')
%
%
zzf2=flipud(zzf);
subplot(4,2,1);
imshow(zzf2, [-1 1]);
title('Function f(x,y)')
subplot(4,2,2);
imshow(zzf2, [-1 1]);
title('Function f(x,y)')
subplot(4,2,3);
imshow(flipud(freal), [-1 1]);
title('Real Part of Kernel K_{u_{o},v_{o}}(x,y)')
subplot(4,2,4);
imshow(flipud(fimag), [-1 1]);
title('Imag Part of Kernel K_{u_{o},v_{o}}(x,y)')
subplot(4,2,5);
zzr2=flipud(zzr);
imshow(zzr2, [-1 1]);
title('Real Part of  f(x,y) x K_{u_{o},v_{o}}(x,y)')
subplot(4,2,6);
zzi2 = flipud(zzi);
imshow(zzi2, [-1 1]);
title('Imag Part of f(x,y) x K_{u_{o},v_{o}}(x,y)')
subplot(4,2,7);
imshow(flipud(ftr), [-1 1]);
hold on
u2 = 65+(u.*(64./umax));
v2 = 65-(v.*(64./umax));
plot(u2,v2,'b*')
title('Real FT - Dot indicates spatial frequencies u_{o},v_{o}')
subplot(4,2,8);
imshow(fti, [-1 1]);
hold on
plot(u2,v2,'b*')
title('Imag FT - Dot indicates spatial frequencies u_{o},v_{o}')
%
disp('                                      ')
cont=input('Press 2 to  show 3D plot . 1 to continue')
pause
clf
%
if (cont==2)
%
colormap('pink')
subplot(4,2,1);
surf(XX,YY,zzf);
title('Function f(x,y)')
shading interp
subplot(4,2,2);
surf(XX,YY,zzf);
title('Function f(x,y)')
shading interp
subplot(4,2,3);
surf(XX,YY,freal);
shading interp
title('Real Part of Kernel K_{u_{o},v_{o}}(x,y)')
subplot(4,2,4);
surf(XX,YY,fimag);
title('Imag Part of Kernel K_{u_{o},v_{o}}(x,y)')
shading interp
subplot(4,2,5);
surf(XX,YY,zzr);
shading interp 
title('Real Part of  f(x,y) x K_{u_{o},v_{o}}(x,y)')
subplot(4,2,6);
surf(XX,YY,zzi);
shading interp
title('Imag Part of  f(x,y) x K_{u_{o},v_{o}}(x,y)')
subplot(4,2,7);
surf(UU,VV,ftr);
shading interp
hold on
plot3(u,v,rvaluv,'b*');
title('Real FT - Dot indicates spatial frequencies u_{o},v_{o}')
subplot(4,2,8);
surf(UU,VV,fti);
shading interp
hold on
plot3(u,v,ivaluv,'b*');
title('Imag FT - Dot indicates spatial frequencies u_{o},v_{o}')
%
else
end











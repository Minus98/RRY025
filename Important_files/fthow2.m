clf
clear all
x101 = [linspace(-50,50,101)];
z101 = zeros(101);
xx=[linspace(-320,319,640)];
yy=[linspace(0,0,270) linspace(1,1,100) linspace(0,0,270)];
%
%
subplot(4,2,1); p1=plot(xx,yy);
set(p1,'Markersize',0.5)
axis([-320 320 -0.1 1.1])
title('Input Function, f(t), t in microseconds')
%xlabel('micro sec')
grid on
hold on
% 
subplot(4,2,2); p2=plot(xx,yy); 
set(p2,'Markersize',0.5)
axis([-320 320 -0.1 1.1])
title('Input Function, f(t), t in microseconds')
%xlabel('micro sec')
grid on
%
u= input('Value of u (kHz) [0-50] ');
%
%
for i = 1:640
   kcos(i) = cos(2*pi*( (u*xx(i)/1000) ));
   ksin(i) = sin(2*pi*( (u*xx(i)/1000) ));
   preal(i) = yy(i) * kcos(i);
   pimag(i) = yy(i) * ksin(i);
end
%
for i=  1:101
   ii  = i - 51;
   xn  = 100*(sin(2*pi*50*ii/1000));
   xd  = 2*pi*50*ii/1000;
%
  if ( ii == 0)
   sinc(i)  = 100;
  else
   sinc(i) = xn./xd;
  end
%
end
%
 uu = 51+u;
int = sinc(uu);
%
disp('Press return to continue')
%
subplot(4,2,3); p3=plot(xx,kcos);
set(p3,'Markersize',0.5)
axis([-320 320 -1.1 1.1]) 
title('Real Kernel Function, Cos(2piut)')
%xlabel('micro sec')
grid on
%
subplot(4,2,4); p4=plot(xx,ksin); 
set(p4,'Markersize',0.5)
axis([-320 320 -1.1 1.1])
title('Imag Kernel Function, Sin(2piut)')
%xlabel('micro sec')
grid on
%
pause
%
subplot(4,2,5); plot(xx,preal);
axis([-320 320 -1.1 1.1])
title('Product, f(t)Cos(2piut)')
%xlabel('micro sec')
grid on
%
subplot(4,2,6); plot(xx,pimag);
axis([-320 320 -1.1 1.1])
title('Product, f(t)Sin(2piut)')
%xlabel('micro sec')
grid on
%
subplot(4,2,7); plot(x101,sinc,'r--');
title(' FT (Real) - value at blue point is Integral of above plot')
xlabel('kHz')
axis([-50 50 -100 110])
hold on
stem(u,int)
grid on
%
subplot(4,2,8); plot(x101,z101,'r--');
title('FT (Imag) - value at blue point is Integral of above plot')
xlabel('kHz')
axis([-50 50 -100 110])
hold on
stem(u,0)
grid on













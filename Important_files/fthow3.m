clf
clear all
orient tall
%
%freq_slider=uicontrol('Style','slider',...
% 'Units','normalized',...
% 'Position',[.12 .12 .6 .04],...
% 'Value',freq,'Max',max_freq,'Min',min_freq,...
% 'Callback','sigdemo2(''setfreq'',1); sigdemo2(''redraw'');');
%
% h1 = uicontrol('Position',[200, 10 250, 17])
% set(h1,'Callback','get(h1,''value'')');
% set(h1,'Style','slider');
% set(h1,'Max',50);
% u = round(ans)
%
x101 = [linspace(-50,50,101)];
z101 = zeros(101);
xx=[linspace(-320,319,640)];
yy=[linspace(0,0,270) linspace(-1,1,100) linspace(0,0,270)];
%
%
subplot(4,2,1); p1=plot(xx,yy); 
axis([-320 320 -1.1 1.1])
title('Input Function, f(t), t in microseconds')
set(p1,'Markersize',0.5)
%xlabel('micro sec')
grid on
hold on
% 
subplot(4,2,2); p2=plot(xx,yy);
set(p2,'Markersize',0.5) 
axis([-320 320 -1.1 1.1])
title('Input Function, f(t), t in microseconds')
%xlabel('micro sec')
grid on
%
%
u= input('Value of u (kHz) ')
u = round(u)
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
   xn1  = 2*(sin(2*pi*50*ii/1000));
   xn2  = 2*(2*pi*ii*50/1000)*(cos(2*pi*50*ii/1000));
   xd  = (2*pi*50*ii/1000).^2;
   if (xd==0)
     ft(i) = 0;
   else 
     ft(i) = (xn1-xn2)./xd;
   end
%
end
%
uu = 51+u;
int = ft(uu);
%
%
subplot(4,2,3); plot(xx,kcos);
axis([-320 320 -1.1 1.1]) 
title('Real Kernel Function, Cos(2piux)')
%xlabel('micro sec')
grid on
%
subplot(4,2,4); plot(xx,ksin); 
axis([-320 320 -1.1 1.1])
title('Imag Kernel Function, Sin(2piux)')
%xlabel('micro sec')
grid on
%
% pause
%
subplot(4,2,5); plot(xx,preal);
axis([-320 320 -1.1 1.1])
title('Product, f(x,y)Cos(2piux)')
%xlabel('micro sec')
grid on
%
subplot(4,2,6); plot(xx,pimag);
axis([-320 320 -1.1 1.1])
title('Product, f(x,y)Sin(2piux)')
%xlabel('micro sec')
grid on
%
subplot(4,2,7); plot(x101,z101,'r--');
title(' FT (Real)')
xlabel('kHz')
axis([-50 50 -1 1])
hold on
stem(u,0)
grid on
%
subplot(4,2,8); plot(x101,ft,'r--');
title('FT (Imag)')
xlabel('kHz')
axis([-50 50 -1 1])
hold on
stem(u,int)
grid on












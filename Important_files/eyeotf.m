%
j0 =500;
omega0 = 0.1;
%
xlin =[0:1:700];
ylin =[0:1:700];
%
con = (ylin/700).^3;
%
for j=1:600
   omega(j) = omega0 * exp(j/j0);
   ex(j) = cos(j*omega(j));
end
%
echart = 0.5 + 0.5*con'*ex;
%
imshow(echart)
% truesize
xlabel('Log Spatial Frequency') 
ylabel('1/local contrast')
%


 

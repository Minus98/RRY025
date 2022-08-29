function  [s,x1,x2] = spline3(m,ys,f)
%
% calculates 4 polynomial coefficients s\(stored in 
% vector s) of a spline function which interpolates between 
% y = mx and y = ys (constant), the interpolations
% function spans a range of f in x, the polynomial 
% is valid between x1 and x2  
%
% input paramters
% tanp = 4.55
% ys = 1
% f = 1.2;
%
xs = ys/m;
x1= xs*f^(-0.5);
x2= xs*f^(0.5); 
v = [ys; m*x1; 0; m];
M = [x2^3 x2^2 x2^1 1
x1^3 x1^2 x1 1
3*x2^2 2*x2 1 0
3*x1^2 2*x1 1 0
];
% solve matrix equation v = Ms
% s is solution vectore of polunomial coeeficents
s=M\v;

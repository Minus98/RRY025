axis= [1 0 0; 0 1 0; 0 0 1]
%
x = [0 
theta1=45;
alpha1=45;
%
theta = theta1*pi/180;
alpha = alpha1*pi/180;
%
plot3(axis,'b')
hold on
%
rot1 = [ cos(theta)  sin(theta)  0;
         -sin(theta)  cos(theta)  0;
	    0          0         1];
%
rot2 = [ 1  0 0;
         0 cos(alpha)  sin(alpha);
         0 -sin(alpha)  cos(alpha)];
%
basis = rota*rot2*axis;
plot3(basis,'b')


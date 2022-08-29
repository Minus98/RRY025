function  f = haarbas(u,v,N)
%
% John Conway, ERR041, Sept 2000
%
% Works out the u'th, v'th 
% 2D Haar basis image 
% of size NxN where N=2^{n}
%
h = haar(N);
x = h(:,u);
y = h(:,v);  
[XX, YY] = meshgrid(x,y);
f = XX.*YY;

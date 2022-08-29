function  f = ohadbas(u,v,N)
%
% John Conway, ERR041, Sept 2000
%
% Works out the u'th, v'th 
% 2D ordered Hadamard basis image 
% of size NxN where N=2^{n}
%
g = ordhad(N);
x = g(:,u);
y = g(:,v);  
[XX, YY] = meshgrid(x,y);
f = XX.*YY;

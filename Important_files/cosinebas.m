function  f = cosinebas(u,v,N)
%
% John Conway, ERR041, Sept 2000
%
% Works out the u'th, v'th 
% 2D Cosine basis image 
% of size NxN 
%
g = cosine(N);
x = g(:,u);
y = g(:,v);  
[XX, YY] = meshgrid(x,y);
f = XX.*YY;

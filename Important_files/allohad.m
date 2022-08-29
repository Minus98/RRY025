function allohad(N)
%
% Creates plot of all the 2D ordered 
% ordered Hadamard functions for images
% of size NxN where N=2^{n}
%
figure(1)
clf;
mp = 1/N;
%
for l=1:N
 for m=1:N
%
 np = (m-1)*N+l;
 subplot(N,N,np);
 f = ohadbas(l,m,N); 
% image(f);
imshow(f, [-mp mp])
% title( 'disp(u,v)')
 drawnow
%
end
end

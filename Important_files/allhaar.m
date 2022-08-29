function allhaar(N)
%
% John Conway, ERR041, Sept 2000
%
% Creates plot of all the
% haar basis images for images
% of size NxN where n=2^{N}
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
 f = haarbas(l,m,N); 
 imshow(f, [-mp mp ])
 drawnow
%
end
end

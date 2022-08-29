[U,S,V] = svd(Y);
dim = max(max(size(Y))
%
% What is eigenvalue spectrum?
%
tS=diag(S);
clf;
subplot(1,1,1);
plot(tS);
pause;
clf;
%
%  Show all the eigenvector images
%
% for i= 1:dim
% M(:,:,i) = U(:,i)*(V(:,i))';
% minm = min(min(M(:,:,i)));
% maxm = max(max(M(:,:,i)));
% subplot(6,8,i);
% imshow(M(:,:,i),[minm maxm])
%>end
%
% display the reconstruction
% as a function of number of 
% eigenimages summed
%
pause
clf
subplot(1,1,1)
s1 = zeros(dim,dim); 
%
for i=1:dim
s1 = s1 +(tS(i)*M(:,:,i));
pause(1)
mins = min(min(s1));
maxs = max(max(s1));
imshow(s1,[mins maxs]);
end

















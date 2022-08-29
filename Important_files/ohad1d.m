function ohad1d(N)
%
% Plots of all the 1D 
% ordered Hadamard functions basis 
% function of length  N where n=2^{N}
%
figure(1)
clf;
f=ordhad(N);
%
for j=1:N
%;
 subplot(N,1,j);
 bar(f(j,:))
 drawnow
%
end
end

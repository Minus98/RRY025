function out = ohad(input); 
%
% ERR041, John Conway 
%
% Does 2D ordered Hadamard transforms for 
% 256x256 images using an already computed
% transform matrix.
%
[s1, s2] = size(input)
out=zeros(256,256);
%
if (s1==256)
 if (s2==256)
%
  load('oh256.mat');
  out = oh256'*double(input)*oh256;
%
 else
 disp(' Sorry this m-file only works for 256x256 images')
 end
else
disp(' Sorry this m-file only works for 256x256 images')
end 

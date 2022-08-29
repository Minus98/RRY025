function out = iohad2(input); 
%
%  Does 2D inverse ordered Hadamard transform
%  for 256x256 images. Using precalculated transform
%  matrix
%
[s1, s2] = size(input)
out=zeros(256,256);
%
if (s1==256)
 if (s2==256)
%
  load('oh256.mat');
  out = oh256*double(input)*oh256';
%
 else
 disp(' Sorry this m-file only works for 256x256 images')
 end
else
disp(' Sorry this m-file only works for 256x256 images')
end 

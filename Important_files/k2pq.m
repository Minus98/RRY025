function [p, q] = k2pq(k)
%
% decomposes input integer value k
%  into p, q where
%   k = 2^p + q -1
%
  if (k<=1) 
     p=0
     q=k
  else
     p = floor(log(k)/log(2))
     q = 1 + k- 2^p 
  end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function h = ordhad(N)
%
% ordhad.m 
%
% John Conway, ERR041, Sept 2000
% 
% computes normalised ordered Hadamard  basis 
% functions for size N
%
n= round(log(N)/log(2));
%
if ( (N - 2.^n) == 0)  
% 
 g = ones(N,N);
 sum = 0;
%
 for u=0:N-1;
  for x=0:N-1;
%
   for i=0:n-1
%
    sum = sum + bith(i,x).* pparm(n,i,u); 
%   
  end
%
  g(x+1,u+1) = (-1).^sum;
  sum = 0;
%
  end
 end
%
% Normalise basis functions
%
  h = g./sqrt(N);
%
else
 disp(' Program only computes basis functions ')
 disp(' for size N=2^n ')
end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function out=pparm(n,i,u)
%
% calculates p-parmeter
% according to Gozalez and Woods p 141.
% needed to calculate ordered Hadamard 
% transform
%
if (i==0) 
     out = bith(n-1,u);
else
     out = bith(n-1-i+1,u) - bith(n-2-i+1,u);
end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function out = bith(k,z)
%
% returns k'th bit of binary 
%  representation of number z.
%  where the LSB is bit 0 etc
%
N = 2.^k;
div = floor(z./N);
out = rem(div,2);






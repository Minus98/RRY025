function h=walsh(N)
%
% walsh.m 
%
% John Conway, ERR041, Sept 2000
% 
% computes normalised Walsh functions, of
% size N=2^{n}, puts each of the 
% 1D basis function into columns
% of the NxN output matrix
%
n= round(log(N)/log(2));
%
if ( (N - 2.^n) == 0);
%
 N = 2.^n;
 g = ones(N,N);
%
 for u=0:N-1;
  for x=0:N-1;
%
   for i=0:n-1
%
   g(x+1,u+1) = g(x+1,u+1)* ( (-1).^(bith(i,x)* bith(n-1-i,u)) );
%
   end
  end
 end
%
% Normalise before outputing
%
   h = g./sqrt(N);
%
%
else
   disp( 'This program only calculates basis functions ')
   disp( ' when n = s^{n}  ')
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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



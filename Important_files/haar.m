function g=haar(N);
%
% haar.m 
%
% John Conway, ERR041, Sept 2000
% 
% computes normalised 1D Haar functions, of
% length N=2^{n}, puts each of these N
% basis function into one column
% of the NxN output matrix
%
n= round(log(N)/log(2));
%
if ( (N - 2.^n) == 0);
%
%
 h = zeros(N,N);
%
 k=0;
 h(k+1,:) = 1/sqrt(N);
%
%
 for k=1:N-1;
% 
  [p, q] = k2pq(k);
  lim1 = (q-1)/2^p;
  lim2 = (q-0.5)/2^p;
  lim3 =  q/2^p;  
%
  for zz=0:N-1;
%
   z = zz/N;
%
   if ((z>=lim1)&(z<lim3))
%
    if (z<lim2) 
      h(k+1,zz+1) = 2^(p/2)/sqrt(N);
    else
      h(k+1,zz+1) = -2^(p/2)/sqrt(N);
    end
%
   else
    h(k+1,zz+1) = 0;
   end
%
  end
 end
%
%
% put basis functions in columns of matrix and
% normalise
% 
 g = h'./sqrt(N);
%
else
   disp( 'This program only calculates basis functions ')
   disp( ' when n = s^{n}  ')
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function [p, q] = k2pq(k)
%
% decomposes input integer value k
%  into p, q where
%   k = 2^p + q -1
%
  if (k<=1) 
     p=0;
  q=k;
  else
  p = floor(log(k)/log(2));
     q = 1 + k- 2^p;
  end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function c=cosine(N)
%
% cosine.m 
%
% John Conway, ERR041, Sept 2000
% 
% computes normalised 1D cosine basis functions, of
% length N=2^{n}, puts each of these N
% basis function into one row
% of the NxN output matrix
%
%
c = (dctmtx(N))';
%



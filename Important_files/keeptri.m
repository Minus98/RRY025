function output = keeptri(input,diag);
%
% John Conway, ERR041
%
% Keeps the first 'diag' diagonals
% in top left corner of input image and zeros the rest.
%
[s1, s2]=size(input);
output = input;
xx = 1:s1;
yy = 1:s2;
[XX, YY] = meshgrid(xx,yy);
DD = XX + YY -1;
index=find(DD>diag);
output(index)=0;


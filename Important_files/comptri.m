function output = comptri(input,fact);
%
% John Conway, ERR041
%
% Compresses a transform by a factor 'fact'
% by keeping the top left corner of input image 
% zeroing the rest.
%
[s1, s2]=size(input);
%
if (fact>1.999)
 npix = s1*s2/fact;
 diag = sqrt(2*npix);
else
 fact2 =  1 - (1/fact) 
 npix = fact2*s1*s2;
 diag2 = sqrt(2*npix);
 diag = 2*s1 -diag2;
end
%
output = input;
xx = 1:s1;
yy = 1:s2;
[XX, YY] = meshgrid(xx,yy);
DD = XX + YY -1;
index=find(DD>diag);
output(index)=0;


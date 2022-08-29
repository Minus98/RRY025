function output = compdia(input,fact);
%
% John Conway, ERR041
%
% Compresses a transform by a factor 'fact'
% by keeping the four  corners of the  transform
% and zeroing the rest. Used for compression via DFT
%
[s1, s2]=size(input);
%
if (fact>1.999)
 npix = 2*s1*s2/fact;
 diag = sqrt(2*npix);
else
 disp(' Does not work for compression factors <2') 
end
%
output = input;
xx = 1:s1;
yy = 1:s2;
[XX, YY] = meshgrid(xx,yy);
DD = XX + YY -1;
index=find(DD>diag);
output(index)=0;


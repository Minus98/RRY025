function template = raduv(input)
% Input: 
%           image of size (rows,cols)
% Output:
%           Template for a filter in the UV-plane with same dimensions 
%           as the input image.
%           The value of each pixel is the distance to the center as
%           a fraction of the maximum distance in both directions, i.e.
%           sqrt((distance in u / max dist in u)^2 + 
%                (distance in v / max dist in v)^2)
%           
[rows,cols] = size(input);
maxu = cols/2;
maxv = rows/2;
u = linspace(1, 2*maxu, 2*maxu) - maxu;
v = linspace(1, 2*maxv, 2*maxv) - maxv;
[uu,vv] = meshgrid(u,v);
template = sqrt(uu.^2/maxu^2 + vv.^2/maxv^2);

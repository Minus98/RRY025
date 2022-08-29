function output = raduv(input)
%   
% outputs tmplate file, giving the uv radius to ant point in the
% FT
%
% Inputs
%      input - input image of size (nn,mm)
% Outputs
%      out1 - output template for FT, same size as input, giving
%             distance to each uv point from DC point of centred FT
%             (nn/2+1,mm/2 +1) as fraction of distance to edge
%      out2 - a ones image smae size as output 
% 
[nn,mm] = size(input);
%
dv = 1./nn;
du = 1./mm;
u = linspace(-2.*du.*(mm./2), 2.*du.*(mm./2 -1), mm);
v = linspace(-2.*dv.*(nn./2), 2.*dv.*(nn./2 -1), nn);
[uu,vv] = meshgrid(u,v);
output = sqrt(uu.^2 + vv.^2);
%
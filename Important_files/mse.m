function t = mse(in1, in2);
[s1 s2] = size(in1);
npix = s1*s2;
dif = double(in2)-double(in1);
vdif = reshape(double(dif), 1, npix);
t = dot(vdif, vdif)/npix;


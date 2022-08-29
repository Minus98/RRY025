function  entropy = iment(input);
%
% Works out the histogram entropy of
% an image
%
[s1 s2] = size(input);
npix = s1*s2;
imax = double(max(max(input)));
imin = double(min(min(input)));
nbins = imax - imin + 1;
[hv, xx] = imhist(input,nbins);
prob = hv/npix;
%
% Find bins with zero elements 
% and set to 1, ,avoid log(0) 
% problems but doesn't change entropy
% sum
%
index=find(prob==0);
prob(index) = 1;
eprob = -prob.*log2(prob);
entropy = sum(eprob);

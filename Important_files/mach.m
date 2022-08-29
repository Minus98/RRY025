mach1 = linspace(0,1,512);
mach2 = 0.3+ 0.07*floor(10*mach1);
yaxis  = ones(1,256);
mach3 = yaxis'*mach2;
imshow(mach3);


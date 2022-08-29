function calcent(input)
%
% John Conway, ERR041, Image processing
%
% Displays input image and its histogram
% (allowing negative values), and calculate
% image histogram entropy
%
figure(1)
clf;
subplot(2,1,1)
imshow(input, [])
title('Input Image')
axis image
colorbar;
drawnow;
%
subplot(2,1,2)
imhist2(input,40)
title('Image Histogram')
drawnow;
%
ent = iment(input);
display('The histogram  entropy is')
ent
display('bits/pixel')

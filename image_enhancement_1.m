%% Exercise 2
close all

pout = imread('Important_files/pout.tif');
figure; 
imshow(pout,[])

hist = imhist(pout);
hist = hist / numel(pout);

trans = cumsum(hist);
figure;
plot(trans)
eqpout = trans(pout+1);

figure; 
imshow(eqpout,[])
%plot(hist)

%% Exercise 3

close all

data = load('Important_files/quarter.mat');

figure;
hist = imhist(data.quarter);
plot(hist)

figure;
imshow(data.quarter,[])

coinlim = input('Maximum gray level (0-255) associated with coin: ');
coinrang = input('Maximum gray level (0-255) for coin in output image: ');

lower_span = find(data.quarter <= coinlim);
upper_span = find(data.quarter >= coinlim);

hist = hist / numel(data.quarter);

cum_hist = cumsum(hist);

target_hist = zeros(256,1);

for level = 1:256
    target_hist(level) = new_pdf(level, coinrang, length(lower_span), length(upper_span));
end

figure;
plot(target_hist)

cum_target_hist = cumsum(target_hist);

function p = new_pdf(value, coinrang, lower_size, upper_size)
    if value <= coinrang
        p = lower_size/((lower_size + upper_size) * coinrang);
    else
        p = upper_size/((lower_size + upper_size) * (256-coinrang));
    end
end

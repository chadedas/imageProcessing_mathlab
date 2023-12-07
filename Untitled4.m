clear;
close all;
RGB = imread('imageProcess/image.jpg');
[IND, map] = rgb2ind(RGB, 4);
L1 = IND + 1;
L1(IND > 1) = 0;
maxValue = max(max(IND));
maxValue = cast(maxValue,'int8')
figure;
for i = 1:double    (maxValue) 
    L = IND + 1;
    L(IND < i) = 0;
    L(IND > i) = 0;
    L(IND == i) = 1;
    
    subplot(2, 2, i), imshow(L*255), title(['L = ' num2str(i)]);
    imwrite(L, sprintf('imageProcess/rgb2ind%d.jpg', i), 'quality', 100);
    x(:,:,1) = L;
end
invert = 1 - x;
bw = a < 50;
imshow(RGB)
title("Image with Circles")
stats = regionprops("table",RGB,"Centroid", ...
    "MajorAxisLength","MinorAxisLength")

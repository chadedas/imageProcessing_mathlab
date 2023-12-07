RGB = imread('imageProcess/image.jpg');
[IND,map] = rgb2ind(RGB,4);
figure
imagesc(IND)
colormap(map)
axis image
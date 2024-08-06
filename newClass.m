clear
close all

IMG = imread('imageProcess/image.jpg');

imHSV = rgb2hsv(IMG);

imf = (imHSV(:,:,1));
imf(imf<0.31)=0;
imf(imf>0.35)=0;
imf(imf>0)=1;

imCar = (imHSV(:,:,1));
imCar(imCar<0.000)=0;
imCar(imCar>0.086)=0;
imCar(imCar>0.000)=1;

imBall = (imHSV(:,:,1));
imBall(imBall<0.149)=0;
imBall(imBall>0.153)=0;
imBall(imBall>0.000)=1;

imGoal = (imHSV(:,:,1));
imGoal(imGoal<0.518)=0;
imGoal(imGoal>0.667)=0;
imGoal(imGoal>0.000)=1;

% figure,
% subplot(2,2,1),imshow(imf),title('Field');
% subplot(2,2,2),imshow(imCar),title('Car');
% subplot(2,2,3),imshow(imBall),title('Football');
% subplot(2,2,4),imshow(imGoal),title('Goal');

invert = imCar + imBall + imGoal;
[L, n] = bwlabel(invert,8);

figure,
% subplot(2,2,1),imshow(invert);

stats = regionprops(L,'boundingBox','Area');

subplot(1,1,1),imagesc(L);

hold on
buffer = 6;

for i = 1:numel(stats)
    boundingBox = stats(i).BoundingBox;

    boundingBox(1:2) = boundingBox(1:2) - buffer;
    boundingBox(3:4) = boundingBox(3:4) + 2*buffer;
    
    boundingBox(1:2) = max(boundingBox(1:2), [1 1]);
    boundingBox(3:4) = min(boundingBox(3:4), [size(invert,2) size(invert,1)]);
    
    croppedObject = imcrop(invert, boundingBox);

    rectangle('Position', boundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
end
hold off
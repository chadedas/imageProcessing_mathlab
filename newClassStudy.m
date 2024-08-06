clear
close all

% Load the first image
pic1 = imread("imageProcess/pic1.jpg");
imgray = rgb2gray(pic1);
imDB = im2double(pic1);

% Display original and processed images
rows = 2;
cols = 4;
figure,
subplot(rows, cols, 1), imshow(pic1), title("Color");
subplot(rows, cols, 3), imshow(imgray), title("Gray");
subplot(rows, cols, 4), imshow(imgray + 50), title("G+50");
subplot(rows, cols, 2), imshow(imgray - 50), title("G-50");
subplot(rows, cols, 5), imshow(imgray + imgray), title("G+G");
subplot(rows, cols, 6), imshow(imgray / 2), title("G/2");
subplot(rows, cols, 7), imshow(imgray * 2), title("G*2");
subplot(rows, cols, 8), imshow(imgray .* imgray), title("G*G");

% Load the second image
pic2 = imread("imageProcess/pic2.jpg");
imgray1 = rgb2gray(fliplr(pic2));
imDB1 = im2double(fliplr(pic2));

% Resize the second image to match the dimensions of the first image
imgray1_resized = imresize(imgray1, size(imgray));

% Display original and processed images for the second image
figure,
subplot(rows, cols, 1), imshow(pic2), title("Color");
subplot(rows, cols, 3), imshow(imgray1_resized), title("Gray");
subplot(rows, cols, 4), imshow(imgray1_resized + 50), title("G+50");
subplot(rows, cols, 2), imshow(imgray1_resized - 50), title("G-50");
subplot(rows, cols, 5), imshow(imgray1_resized + imgray1_resized), title("G+G");
subplot(rows, cols, 6), imshow(imgray1_resized / 2), title("G/2");
subplot(rows, cols, 7), imshow(imgray1_resized * 2), title("G*2");
subplot(rows, cols, 8), imshow(imgray1_resized .* imgray1_resized), title("G*G");

% Perform bitwise XOR operation on the resized grayscale images
imgray_xor = bitxor(imgray, imgray1_resized);
imgray_xor_only = bitand(imgray, imgray);

% Display XOR result
figure,
%subplot(2, 4, 1), imshow(imgray_xor), title("XOR");
%subplot(2, 4, 2), imshow(bitand(imgray, imgray1_resized)), title("AND");
%subplot(2, 4, 3), imshow(bitor(imgray, imgray1_resized)), title("OR");
%subplot(2, 4, 4), imshow(bitcmp(imgray1_resized)), title("NOT");
%subplot(2, 4, 5), imshow(pic1), title("PIC 1");
%subplot(2, 4, 6), imshow(fliplr(pic2)), title("PIC 2");
%subplot(2, 4, 7), imshow((pic2)), title("PIC 2");
%subplot(2, 4, 8), imshow(bitcmp(imgray_xor_only)), title("NOT");

subplot(1, 4, 1), imshow(pic2), title("Original");
subplot(1, 4, 2), imshow(fliplr(pic2)), title("fliplr");
subplot(1, 4, 3), imshow(flipud(pic2)), title("flipud");
subplot(1, 4, 4), imshow(flipud(fliplr(pic2))), title("flipud + fliplr");
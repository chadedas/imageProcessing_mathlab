clear
close all

% A — Input array
%vector | matrix | multidimensional array | table | timetable

pic2 = imread("imageProcess/pic2.jpg");


subplot(1, 4, 1), imshow(pic2), title("Original");
subplot(1, 4, 2), imshow(fliplr(pic2)), title("fliplr");
subplot(1, 4, 3), imshow(flipud(pic2)), title("flipud");
subplot(1, 4, 4), imshow(flipud(fliplr(pic2))), title("flipud + fliplr");


%imrotate
% ค่า - หมุนตามเข็ม , ค่าบวก หมุนทวนเข็ม
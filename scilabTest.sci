pic = imread('duck.jpg');
//imshow(test1);

grayPic = rpg2gray(pic);
//imshow(grayPic);
subplot(2,2,1), imshow(pic), title('Original');
subplot(2,2,2), imshow(grayPic), title('grayPic');

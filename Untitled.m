clear
close all

PIC = imread('image.jpg');

%figure,imhist(PIC(:,:,1),128);
%figure,imhist(PIC(:,:,2),128);
%figure,imhist(PIC(:,:,3),128);

PICHSV = rgb2hsv(PIC);
figure,imshow(PICHSV(:,:,1));
%figure,subplot(1,2,1),imshow(PIC),
%subplot(1,2,2),imshow(PICHSV(:,:,1));

imb = (PICHSV(:,:,1));
imb(imb<0.119)=0;
imb(imb>1)=0;
imb(imb>0)=1;
%figure,imshow(imb);

imf = (PICHSV(:,:,1));
imf(imf<0.31)=0;
imf(imf>0.35)=0;
imf(imf>0)=1;
%figure,imshow(imf);

img = (PICHSV(:,:,1));
img(img<0.825)=0;
img(img>0.840)=0;
img(img>0)=1;

imr = (PICHSV(:,:,1));
imr(imr<0.154)=0;
imr(imr>0.2)=0;
imr(imr>0)=1;
figure,imshow(imb);
%figure,imshow(imr);
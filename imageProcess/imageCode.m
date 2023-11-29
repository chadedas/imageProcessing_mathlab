clear
close all

imrgb = imread('image.jpg');

imhsv = rgb2hsv(imrgb);

%เอาไว้แยกสนาม
imf = (imhsv(:,:,1));
imf(inf<0.33)=0;
imf(imf>0.33)=0;
imf(imf>0)=1;
%figure,imshow(imf);

%เอาไว้แยกรถ 
imc = (imhsv(:,:,1));
imc(imc<0.97)=0;
imc(imc>0.99)=0;
imc(imc>0)=1;
%figure,imshow(imc);

%เอาไว้แยกประตู
imgo = (imhsv(:,:,1));
imgo(imgo<-1)=0;
imgo(imgo>0.3)=0;
imgo(imgo>0)=1;
%figure,imshow(imgo);

%เอาไว้แยกลูกบอล
imfb = (imhsv(:,:,1));
imfb(imfb<0.13)=0;
imfb(imfb>0.15)=0;
imfb(imfb>0)=1;
%figure,imshow(imfb);

figure,subplot(2,2,1),imshow(imf),title('ImF');
subplot(2,2,2),imshow(imc),title('ImC');
subplot(2,2,3),imshow(imgo),title('Imgo');
subplot(2,2,4),imshow(imfb),title('Imfb');
%imhsv(16:589,37:610,1)
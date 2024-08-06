% นำเข้ารูปภาพของรอยนิ้วมือที่ต้องการเปรียบเทียบ
target_image = imread('Chard1.jpg');

% นำเข้ารูปภาพของรอยนิ้วมือในฐานข้อมูล
database_image = imread('Chard.jpg');

% ทำการแปลงภาพเป็นภาพขาวดำ
target_image_bw = rgb2gray(target_image);
database_image_bw = rgb2gray(database_image);

% ทำการทำสเกลของรูปภาพเพื่อลดขนาดข้อมูล
target_image_resized = imresize(target_image_bw, [100 100]);
database_image_resized = imresize(database_image_bw, [100 100]);

% นำรูปภาพที่ทำสเกลได้มาแสดงผล
imshow(target_image_resized);
title('Target Fingerprint');
figure;
imshow(database_image_resized);
title('Database Fingerprint');

% ทำการเปรียบเทียบระหว่างรอยนิ้วมือที่ต้องการกับรอยนิ้วมือในฐานข้อมูล
similarity_score = corr2(target_image_resized, database_image_resized);

% แสดงค่าความคล้ายคลึง
disp(['Similarity Score: ', num2str(similarity_score)]);
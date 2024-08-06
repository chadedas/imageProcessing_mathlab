function detect_fingerprint_edges(image_path)
% อ่านรูปภาพลายนิ้วมือ
fingerprint = imread(image_path);

% แปลงรูปภาพเป็นระดับสีเทาหากยังไม่ได้ทำ
if size(fingerprint, 3) == 3
    fingerprint_gray = rgb2gray(fingerprint);
else
    fingerprint_gray = fingerprint;
end

% ตรวจจับขอบโดยใช้ตัวตรวจจับขอบแบบ Canny
edges = edge(fingerprint_gray, 'Canny');

% นับจำนวนขอบ
num_edges = nnz(edges);

% ตรวจสอบช่วงขอบที่ต้องการ
if num_edges >= 24000 && num_edges <= 25000
    disp('Aom');
elseif num_edges >= 2600 && num_edges <= 27000
    disp('Chard');
elseif num_edges >= 120000 && num_edges <= 130000
    disp('Few');
elseif num_edges >= 87000 && num_edges <= 89000
    disp('Kookkik');
elseif num_edges >= 86000 && num_edges <= 86999
    disp('Pear');
elseif num_edges >= 110000 && num_edges <= 119999
    disp('View');
else
    disp("I don't know");
end

% แสดงภาพเดิมและขอบที่ตรวจจับได้
figure;
subplot(1, 2, 1);
imshow(fingerprint_gray);
title('รูปภาพลายนิ้วมือเดิม');
subplot(1, 2, 2);
imshow(edges);
title('ขอบที่ตรวจจับได้');

% แสดงจำนวนขอบ
disp(['จำนวนขอบที่ตรวจจับได้: ', num2str(num_edges)]);
end
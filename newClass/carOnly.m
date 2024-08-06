clear
close all

% สร้างฟิลด์ฟุตบอล
fieldSizeX = 800;
fieldSizeY = 450;
field = uint8(zeros(fieldSizeY, fieldSizeX, 3));
field(:, :, 1) = 0;
field(:, :, 2) = 200;
field(:, :, 3) = 0;

% สร้างรถ
car = uint8(zeros(32, 50, 3));
car(:, 1:25, 1) = 0;    % สีแดงส่วนหลัง
car(:, 1:25, 2) = 0;
car(:, 1:25, 3) = 255;

car(:, 26:end, 1) = 255;    % สีน้ำเงินส่วนหน้า
car(:, 26:end, 2) = 0;
car(:, 26:end, 3) = 0;

% สร้างบอล
[x, y] = meshgrid(1:16, 1:16);
center = [8, 8];
radius = 7.5;
mask = uint8((x - center(1)).^2 + (y - center(2)).^2 <= radius^2);
ball = cat(3, 255 * mask, 255 * mask, zeros(16, 16, 'uint8'));
ball(:,:, 2) = 200;

% สร้างประตู
goalWidth = 120;
goalHeight = 20;
goal = uint8(zeros(goalHeight, goalWidth, 3));
goal(:, :, 1) = 255;
goal(:, :, 2) = 20;
goal(:, :, 3) = 192;

% ฟังก์ชันตรวจสอบการทับซ้อน
checkOverlap = @(pos1, size1, pos2, size2) ...
    pos1(1) < pos2(1) + size2(1) && pos1(1) + size1(1) > pos2(1) && ...
    pos1(2) < pos2(2) + size2(2) && pos1(2) + size1(2) > pos2(2);

% ตั้งค่าความเร็วของรถและบอล
carSpeed = 2;
ballSpeed = 3;

% บอลสุ่มบนฟิลด์
randRowB = randi([1, fieldSizeY - 16 + 1]);
randColB = randi([1, fieldSizeX - 16 + 1]);

field(randRowB:randRowB + 15, randColB:randColB + 15, :) = ball;

% รถสุ่มบนฟิลด์
randRowC = randi([1, fieldSizeY - 20 + 1]);
randColC = randi([1, fieldSizeX - 32 + 1]);

% ตรวจสอบการทับซ้อนกับบอล
while checkOverlap([randRowC, randColC], size(car), [randRowB, randColB], size(ball))
    randRowC = randi([1, fieldSizeY - 20 + 1]);
    randColC = randi([1, fieldSizeX - 32 + 1]);
end

field(randRowC:randRowC + 31, randColC:randColC + 49, :) = car;

% ประตูสุ่มบนฟิลด์
side = randi([1, 4]);
switch side
    case 1 % ประตูด้านบน
        goalX = randi([1, fieldSizeX - goalWidth + 1]);
        goalY = 1;

    case 2 % ประตูด้านขวา
        goalX = fieldSizeX - goalHeight + 1;
        goalY = randi([1, fieldSizeY - goalWidth + 1]);
        goal = imrotate(goal, 90);
    case 3 % ประตูด้านล่าง
        goalX = randi([1, fieldSizeX - goalWidth + 1]);
        goalY = fieldSizeY - goalHeight + 1;
        goal = imrotate(goal, 180);
    case 4 % ประตูด้านซ้าย
        goalY = randi([1, fieldSizeY - goalWidth + 1]);
        goalX = 1;
        goal = imrotate(goal, 90);
end

% ตรวจสอบการทับซ้อนกับบอลและรถ
while checkOverlap([goalY, goalX], size(goal), [randRowB, randColB], size(ball)) || ...
        checkOverlap([goalY, goalX], size(goal), [randRowC, randColC], size(car))

    switch side
        case 1 % ประตูด้านบน
            goalX = randi([1, fieldSizeX - goalWidth + 1]);
            goalY = 1;
        case 2 % ประตูด้านขวา
            goalX = fieldSizeX - goalHeight + 1;
            goalY = randi([1, fieldSizeY - goalWidth + 1]);
            goal = imrotate(goal, 90);
        case 3 % ประตูด้านล่าง
            goalX = randi([1, fieldSizeX - goalWidth + 1]);
            goalY = fieldSizeY - goalHeight + 1;
            goal = imrotate(goal, 180);
        case 4 % ประตูด้านซ้าย
            goalY = randi([1, fieldSizeY - goalWidth + 1]);
            goalX = 1;
            goal = imrotate(goal, 270);
    end
end

field(goalY:goalY + size(goal, 1) - 1, goalX:goalX + size(goal, 2) - 1, :) = goal;

% แสดงฟิลด์เริ่มต้น
h = imshow(field);
title('ตำแหน่งบอลสุ่ม');

% ตั้งค่าขนาดของภาพเต็ม
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);


% ตั้งค่าตัวแปรลำดับ
sequenceNumber = 1;

% บันทึกรูปภาพในโฟลเดอร์ "Car"
savePath = 'careiei'; % กำหนดชื่อโฟลเดอร์ที่ต้องการบันทึกรูป
if ~exist(savePath, 'dir')
    mkdir(savePath);
end

% หาชื่อไฟล์ล่าสุด
files = dir(fullfile(savePath, 'soccer_field_with_bbox_and_lines_*.png'));

if isempty(files)
    % ถ้าไม่มีไฟล์เลย ให้ใช้ลำดับเริ่มต้นที่ 1
    sequenceNumber = 1;
else
    % ถ้ามีไฟล์ หาลำดับไฟล์ล่าสุดและเพิ่มลำดับไป 1
    latestFile = files(end).name;
    sequenceNumber = str2double(extractBetween(latestFile, 'soccer_field_with_bbox_and_lines_', '.png')) + 1;
end

% Calculate bounding boxes for car and goal
carBoundingBox = [randColC, randRowC, size(car, 2), size(car, 1)];
goalBoundingBox = [goalX, goalY, size(goal, 2), size(goal, 1)];

% Calculate circular bounding box for the ball
ballCenterX = randColB + size(ball, 2) / 2;
ballCenterY = randRowB + size(ball, 1) / 2;
ballRadius = radius;
ballBoundingBox = [ballCenterX - ballRadius, ballCenterY - ballRadius, 2 * ballRadius, 2 * ballRadius];



% Connect centers of bounding boxes with lines
hold on;

% Calculate slopes of the lines
slope_car_ball = (ballBoundingBox(2) + ballBoundingBox(4)/2 - carBoundingBox(2) - carBoundingBox(4)/2) / ...
                 (ballBoundingBox(1) + ballBoundingBox(3)/2 - carBoundingBox(1) - carBoundingBox(3)/2);

slope_ball_goal = (goalBoundingBox(2) + goalBoundingBox(4)/2 - ballBoundingBox(2) - ballBoundingBox(4)/2) / ...
                  (goalBoundingBox(1) + goalBoundingBox(3)/2 - ballBoundingBox(1) - ballBoundingBox(3)/2);

% Calculate angles in degrees
angle_car_ball = atan2d(slope_ball_goal - slope_car_ball, 1 + slope_car_ball * slope_ball_goal);
angle_ball_goal = atan2d(slope_car_ball - slope_ball_goal, 1 + slope_car_ball * slope_ball_goal);

% Ensure angles are within the range of 0 to 360 degrees
angle_car_ball = mod(angle_car_ball, 360);
angle_ball_goal = mod(angle_ball_goal, 360);

% Display the angles
disp(['Angle between car and ball: ' num2str(angle_car_ball) ' degrees']);
disp(['Angle between ball and goal: ' num2str(angle_ball_goal) ' degrees']);

% Display the angles on the field
hold on;


% คำนวณพิกัดของรถ, บอล, และประตู
carCenterX = randColC + size(car, 2) / 2;
carCenterY = randRowC + size(car, 1) / 2;

ballCenterX = randColB + size(ball, 2) / 2;
ballCenterY = randRowB + size(ball, 1) / 2;

goalCenterX = goalX + size(goal, 2) / 2;
goalCenterY = goalY + size(goal, 1) / 2;

% คำนวณระยะห่างระหว่างวัตถุ
distanceCarBall = sqrt((carCenterX - ballCenterX)^2 + (carCenterY - ballCenterY)^2);
distanceBallGoal = sqrt((ballCenterX - goalCenterX)^2 + (ballCenterY - goalCenterY)^2);



% คำนวณจุดกึ่งกลางของรถ
carCenterX = randColC + size(car, 2) / 2;
carCenterY = randRowC + size(car, 1) / 2;

% คำนวณจุดกึ่งกลางของบอล
ballCenterX = randColB + size(ball, 2) / 2;
ballCenterY = randRowB + size(ball, 1) / 2;

% คำนวณจุดกึ่งกลางของประตู
goalCenterX = goalX + size(goal, 2) / 2;
goalCenterY = goalY + size(goal, 1) / 2;

% แสดงข้อความตำแหน่งบนรูป
text(carCenterX, carCenterY, ['Car (' num2str(round(carCenterX)) ', ' num2str(round(carCenterY)) ')'], 'Color', '0,0,0', 'FontSize', 12, 'HorizontalAlignment', 'center');
text(ballCenterX, ballCenterY, ['Ball (' num2str(round(ballCenterX)) ', ' num2str(round(ballCenterY)) ')'], 'Color', '0,0,0', 'FontSize', 12, 'HorizontalAlignment', 'center');
text(goalCenterX, goalCenterY, ['Goal (' num2str(round(goalCenterX)) ', ' num2str(round(goalCenterY)) ')'], 'Color', '0,0,0', 'FontSize', 12, 'HorizontalAlignment', 'center');


hold off;

% Update the title
title('Car');

% บันทึกรูปภาพ
imwrite(field, fullfile(savePath, ['soccer_field_with_bbox_and_lines_' num2str(sequenceNumber) '.png']));

% สร้างไฟล์ MATLAB สำหรับโค้ดนี้
%save(fullfile(savePath, ['soccer_field_with_bbox_and_lines_' num2str(sequenceNumber) '.mat']), 'fieldSizeX', 'fieldSizeY', 'car', 'ball', 'goalWidth', 'goalHeight', 'side', 'goalX', 'goalY');

disp(['รูปถูกบันทึกในโฟลเดอร์ "' savePath '"']);

% เคลื่อนที่รถเพื่อหยิบบอลและวิ่งไปทางประตู
while ~(abs(carCenterX - ballCenterX) < 2 && abs(carCenterY - ballCenterY) < 2) % ตรวจสอบว่ารถอยู่ใกล้บอลหรือไม่
    % คำนวณทิศทางของรถไปยังบอล
    carDirectionX = sign(ballCenterX - carCenterX);
    carDirectionY = sign(ballCenterY - carCenterY);
    
    % เคลื่อนที่รถ
    randRowC = randRowC + carSpeed * carDirectionY;
    randColC = randColC + carSpeed * carDirectionX;
    
    % อัพเดทตำแหน่งของรถ
    carCenterX = randColC + size(car, 2) / 2;
    carCenterY = randRowC + size(car, 1) / 2;
    
    % อัพเดทฟิลด์
    field = uint8(zeros(fieldSizeY, fieldSizeX, 3));
    field(:, :, 1) = 0;
    field(:, :, 2) = 200;
    field(:, :, 3) = 0;
    field(randRowB:randRowB + 15, randColB:randColB + 15, :) = ball;
    field(randRowC:randRowC + 31, randColC:randColC + 49, :) = car;
    field(goalY:goalY + size(goal, 1) - 1, goalX:goalX + size(goal, 2) - 1, :) = goal;
    
     % บันทึกรูปภาพ
    imwrite(field, fullfile(savePath, ['soccer_field_with_bbox_and_lines_' num2str(sequenceNumber) '.png']));
    
    % แสดงภาพฟิลด์
    set(h, 'CData', field);
    drawnow;
    
    % เพิ่มลำดับรูป
    sequenceNumber = sequenceNumber + 1;
end

% หลังจากหยิบบอลแล้ว รถจะวิ่งไปทางประตู
while ~(abs(carCenterX - goalCenterX) < 2 && abs(carCenterY - goalCenterY) < 2) % ตรวจสอบว่ารถอยู่ใกล้ประตูหรือไม่
    % คำนวณทิศทางของรถไปยังประตู
    carDirectionX = sign(goalCenterX - carCenterX);
    carDirectionY = sign(goalCenterY - carCenterY);
    
    % เคลื่อนที่รถ
    randRowC = randRowC + carSpeed * carDirectionY;
    randColC = randColC + carSpeed * carDirectionX;
    
    % อัพเดทตำแหน่งของรถ
    carCenterX = randColC + size(car, 2) / 2;
    carCenterY = randRowC + size(car, 1) / 2;
    
    % อัพเดทฟิลด์
    field = uint8(zeros(fieldSizeY, fieldSizeX, 3));
    field(:, :, 1) = 0;
    field(:, :, 2) = 200;
    field(:, :, 3) = 0;
    field(randRowB:randRowB + 15, randColB:randColB + 15, :) = ball;
    field(randRowC:randRowC + 31, randColC:randColC + 49, :) = car;
    field(goalY:goalY + size(goal, 1) - 1, goalX:goalX + size(goal, 2) - 1, :) = goal;
    
     % บันทึกรูปภาพ
    imwrite(field, fullfile(savePath, ['soccer_field_with_bbox_and_lines_' num2str(sequenceNumber) '.png']));
    
    % แสดงภาพฟิลด์
    set(h, 'CData', field);
    drawnow;
    
    % เพิ่มลำดับรูป
    sequenceNumber = sequenceNumber + 1;
end

% Load all saved images
imageFiles = dir(fullfile(savePath, '*.png'));
numImages = length(imageFiles);

% Read each image and store in a cell array
images = cell(1, numImages);
for i = 1:numImages
    images{i} = imread(fullfile(savePath, imageFiles(i).name));
end

% Create a GIF
gifFilename = fullfile(savePath, 'animation.gif');
for i = 1:numImages
    [A,map] = rgb2ind(images{i},256);
    if i == 1
        imwrite(A,map,gifFilename,'gif','LoopCount',Inf,'DelayTime',0.1);
    else
        imwrite(A,map,gifFilename,'gif','WriteMode','append','DelayTime',0.1);
    end
end

% Save each frame of the GIF as a separate image in a folder
gifFramesFolder = fullfile(savePath, 'gif_frames');
if ~exist(gifFramesFolder, 'dir')
    mkdir(gifFramesFolder);
end

% Read the GIF
info = imfinfo(gifFilename);

% Separate frames
for i = 1:numImages
    frame = imread(gifFilename, i);
    imwrite(frame, fullfile(gifFramesFolder, ['frame_' num2str(i) '.png']));
end

disp(['GIF image and frames separated into folder: ' gifFramesFolder]);

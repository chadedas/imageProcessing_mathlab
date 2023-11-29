clear;
close all;
addpath('function');
savepath;

fieldData = struct(...
    'randomX', 0, ...
    'randomY', 0, ...
    'locationSaveX', 0, ...
    'locationSaveY', 0, ...
    'fieldSizeX', 512, ...
    'fieldSizeY', 512, ...
    'ballSizeX', 16, ...
    'ballSizeY', 16, ...
    'robotSizeX', 30, ...
    'robotSizeY', 32, ...
    'goalSizeX', 70, ...
    'goalSizeY', 20, ...
    'border', 20 ...
);
%colorObj= ColorData(fieldData.field.Color, fieldData.ball, 102, 150, 0);
%colorObj.createOBJ();

%processedData = colorObj.getProcessedData();
%figure, imshow(processedData);



%figure, imshow(colorObj.Field);

%สนามบอล%
field = uint8(zeros(fieldData.fieldSizeX, fieldData.fieldSizeY, 3));
field(:, :, 1) = 0;
field(:, :, 2) = 255; % เปลี่ยนค่าสี Green เป็น 200
field(:, :, 3) = 0;

%สร้างหุ่นยนต์
robot = uint8(zeros(fieldData.robotSizeX, fieldData.robotSizeY, 3));
robot(:, :, 1) = 255;
robot(:, :, 2) = 255;
robot(:, :, 3) = 0;

%สร้างball
ball = uint8(zeros(fieldData.ballSizeX, fieldData.ballSizeY, 3));
ball(:, :, 1) = 0; % เปลี่ยนค่าสี Red เป็น 150
ball(:, :, 2) = 255;
ball(:, :, 3) = 255; % เปลี่ยนค่าสี Blue เป็น 150

%สร้างgoal
goal = uint8(zeros(fieldData.goalSizeX, fieldData.goalSizeY, 3));
goal(:, :, 1) = 255;
goal(:, :, 2) = 0; % เปลี่ยนค่าสี Green เป็น 150
goal(:, :, 3) = 255;


field((fieldData.fieldSizeX/2)-(fieldData.ballSizeX/2):(fieldData.fieldSizeY/2)+((fieldData.ballSizeY/2)-1), ...
    (fieldData.fieldSizeX/2)-(fieldData.ballSizeX/2):(fieldData.fieldSizeY/2)+((fieldData.ballSizeY/2)-1),1) = ball(:,:,1);

field((fieldData.fieldSizeX/2)-(fieldData.ballSizeX/2):(fieldData.fieldSizeY/2)+((fieldData.ballSizeY/2)-1), ...
    (fieldData.fieldSizeX/2)-(fieldData.ballSizeX/2):(fieldData.fieldSizeY/2)+((fieldData.ballSizeY/2)-1),2) = ball(:,:,2);

field((fieldData.fieldSizeX/2)-(fieldData.ballSizeX/2):(fieldData.fieldSizeY/2)+((fieldData.ballSizeY/2)-1), ...
    (fieldData.fieldSizeX/2)-(fieldData.ballSizeX/2):(fieldData.fieldSizeY/2)+((fieldData.ballSizeY/2)-1),3) = ball(:,:,3);

    fieldData = saveLocation(fieldData);
    
while (true)
        fieldData = generateRandomField(fieldData);
        
        
    if (fieldData.randomX >= (fieldData.border+fieldData.robotSizeX/2) && fieldData.randomX <= ((fieldData.fieldSizeX-fieldData.robotSizeX/2)-fieldData.border) && fieldData.randomY >= (fieldData.border+fieldData.robotSizeY/2) && fieldData.randomY <= ((fieldData.fieldSizeY-fieldData.robotSizeY/2)-fieldData.border))
        field(fieldData.randomX-(fieldData.robotSizeX/2):(fieldData.randomX+(fieldData.robotSizeX/2))-1,(fieldData.randomY-(fieldData.robotSizeY/2)):(fieldData.randomY+(fieldData.robotSizeY/2))-1,1)=robot(:,:,1);
        field(fieldData.randomX-(fieldData.robotSizeX/2):(fieldData.randomX+(fieldData.robotSizeX/2))-1,(fieldData.randomY-(fieldData.robotSizeY/2)):(fieldData.randomY+(fieldData.robotSizeY/2))-1,2)=robot(:,:,2);
        field(fieldData.randomX-(fieldData.robotSizeX/2):(fieldData.randomX+(fieldData.robotSizeX/2))-1,(fieldData.randomY-(fieldData.robotSizeY/2)):(fieldData.randomY+(fieldData.robotSizeY/2))-1,3)=robot(:,:,3);
        fieldData = saveLocation(fieldData);
        break;
    else
        fprintf('Genaretion location again!!\n');
    end 
    
end
   
while (true)
    fieldData = generateRandomField(fieldData);
if (fieldData.locationSaveX ~= fieldData.randomX && fieldData.locationSaveY ~= fieldData.randomY)
    
    if (fieldData.randomX >= (fieldData.border + fieldData.goalSizeX/2) && fieldData.randomX <= (fieldData.border + fieldData.goalSizeX/2) + (fieldData.goalSizeX)) && ...
       (fieldData.randomY >= (fieldData.border + fieldData.goalSizeY/2) && fieldData.randomY <= (fieldData.border + fieldData.goalSizeY/2) + (fieldData.goalSizeY))
        fieldData = saveLocation(fieldData);
        break;
    elseif (fieldData.randomX <= (fieldData.fieldSizeX - fieldData.goalSizeX/2) - fieldData.border && (fieldData.randomX >= (fieldData.border + fieldData.goalSizeX/2))) && ...
           (fieldData.randomY >= (fieldData.border + fieldData.goalSizeY/2) && fieldData.randomY <= (fieldData.border + fieldData.goalSizeY/2) + (fieldData.goalSizeY))
        fieldData = saveLocation(fieldData);
        break;
    elseif (fieldData.randomX <= (fieldData.fieldSizeX - fieldData.goalSizeX/2) - fieldData.border && (fieldData.randomX >= (fieldData.border + fieldData.goalSizeX/2))) && ...
           (fieldData.randomY <= (fieldData.fieldSizeY - fieldData.goalSizeY/2) - fieldData.border && fieldData.randomY >= (fieldData.fieldSizeY - fieldData.goalSizeY/2) - fieldData.border - (fieldData.goalSizeY))
        fieldData = saveLocation(fieldData);
        break;
    elseif (fieldData.randomX <= (fieldData.fieldSizeX - fieldData.goalSizeX/2) - fieldData.border && fieldData.randomX >= (fieldData.fieldSizeX - fieldData.goalSizeX/2) - fieldData.border - (fieldData.goalSizeX)) && ...
           (fieldData.randomY <= (fieldData.fieldSizeY - fieldData.goalSizeY/2) - fieldData.border && fieldData.randomY >= ((fieldData.fieldSizeY - fieldData.goalSizeY/2) - fieldData.border) - (fieldData.goalSizeY))
        fieldData = saveLocation(fieldData);
        break;
    else
        fprintf('Generation location again!!\n');
    end
end

end 
	field(fieldData.randomX-(fieldData.goalSizeX/2):(fieldData.randomX+(fieldData.goalSizeX/2))-1,(fieldData.randomY-(fieldData.goalSizeY/2)):(fieldData.randomY+(fieldData.goalSizeY/2))-1,1)=goal(:,:,1);
	field(fieldData.randomX-(fieldData.goalSizeX/2):(fieldData.randomX+(fieldData.goalSizeX/2))-1,(fieldData.randomY-(fieldData.goalSizeY/2)):(fieldData.randomY+(fieldData.goalSizeY/2))-1,2)=goal(:,:,2);
	field(fieldData.randomX-(fieldData.goalSizeX/2):(fieldData.randomX+(fieldData.goalSizeX/2))-1,(fieldData.randomY-(fieldData.goalSizeY/2)):(fieldData.randomY+(fieldData.goalSizeY/2))-1,3)=goal(:,:,3);
    imwrite(field,'imageProcess/image.jpg', 'quality',100);
    processImage();
    
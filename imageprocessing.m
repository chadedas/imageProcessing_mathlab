%ทุกการรันโค้ด ให้ปิดหน้าโปรแกรมแบะ
clear;
close all;
addpath('function');
savepath;

%ที่ต้องทำคือห้ามให้สีทับกัน ก็คือเช็คระยะของตำแหน่ง บวกด้วยระยะสี
%ห่างกันได้ห้ามน้อยกว่า 2pixel
%size%

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
    'goalSizeY', 10, ...
    'border', 20 ...
);

%สนามบอล%
field=uint8(zeros(fieldData.fieldSizeX,fieldData.fieldSizeY,3));
field(:,:,1)=0;
field(:,:,2)=170;
field(:,:,3)=0;

%สร้างหุ่นยนต์
robot=uint8(zeros(fieldData.robotSizeX,fieldData.robotSizeY,3));
robot(:,:,1)=0;
robot(:,:,2)=0;
robot(:,:,3)=255;

%สร้างball
ball=uint8(zeros(fieldData.ballSizeX,fieldData.ballSizeY,3));
ball(:,:,1)=255;
ball(:,:,2)=12;
ball(:,:,3)=45;

%สร้างgoal
goal=uint8(zeros(fieldData.goalSizeX,fieldData.goalSizeY,3));
goal(:,:,1)=255;
goal(:,:,2)=255;
goal(:,:,3)=45;
        
%นำ ball ไปไว้จุดศูนย์กลางของ field ตอนเริ่มต้น
field((fieldData.fieldSizeX/2)-(fieldData.ballSizeX/2):(fieldData.fieldSizeY/2)+((fieldData.ballSizeY/2)-1), ...
    (fieldData.fieldSizeX/2)-(fieldData.ballSizeX/2):(fieldData.fieldSizeY/2)+((fieldData.ballSizeY/2)-1),1) = ball(:,:,1);

field((fieldData.fieldSizeX/2)-(fieldData.ballSizeX/2):(fieldData.fieldSizeY/2)+((fieldData.ballSizeY/2)-1), ...
    (fieldData.fieldSizeX/2)-(fieldData.ballSizeX/2):(fieldData.fieldSizeY/2)+((fieldData.ballSizeY/2)-1),2) = ball(:,:,2);

field((fieldData.fieldSizeX/2)-(fieldData.ballSizeX/2):(fieldData.fieldSizeY/2)+((fieldData.ballSizeY/2)-1), ...
    (fieldData.fieldSizeX/2)-(fieldData.ballSizeX/2):(fieldData.fieldSizeY/2)+((fieldData.ballSizeY/2)-1),3) = ball(:,:,3);

    fieldData = saveLocation(fieldData);
    
while (true)
    %สุ่มเลข ระหว่าง border ถึง ขนาด field-border แกน X และ แกน Y
    %field-boder คือระยะที่ไม่เกินขอบ border (ซึ่งหมายถึงอยู่ภายในขอบ border)
        fieldData = generateRandomField(fieldData);
        
    %เลขที่สุ่มได้จะต้องไม่เกินขอบ border บวกกับขนาดของ robot แกน X และ แกน Y
    if (fieldData.randomX >= (fieldData.border+fieldData.robotSizeX/2) && fieldData.randomX <= ((fieldData.fieldSizeX-fieldData.robotSizeX/2)-fieldData.border) && fieldData.randomY >= (fieldData.border+fieldData.robotSizeY/2) && fieldData.randomY <= ((fieldData.fieldSizeY-fieldData.robotSizeY/2)-fieldData.border))
        %นำ robot ที่สร้าง ลงไปในพื้นที่สนาม field ตามค่าที่สุ่มได้
        field(fieldData.randomX-(fieldData.robotSizeX/2):(fieldData.randomX+(fieldData.robotSizeX/2))-1,(fieldData.randomY-(fieldData.robotSizeY/2)):(fieldData.randomY+(fieldData.robotSizeY/2))-1,1)=robot(:,:,1);
        field(fieldData.randomX-(fieldData.robotSizeX/2):(fieldData.randomX+(fieldData.robotSizeX/2))-1,(fieldData.randomY-(fieldData.robotSizeY/2)):(fieldData.randomY+(fieldData.robotSizeY/2))-1,2)=robot(:,:,2);
        field(fieldData.randomX-(fieldData.robotSizeX/2):(fieldData.randomX+(fieldData.robotSizeX/2))-1,(fieldData.randomY-(fieldData.robotSizeY/2)):(fieldData.randomY+(fieldData.robotSizeY/2))-1,3)=robot(:,:,3);
        fieldData = saveLocation(fieldData);
        break;
    else
        %หากเลขที่สุ่มไม่เข้าเงื่อนไขให้แสดงผล  Genaretion location again!!
        %จากนั้นทำการสุ่มค่าใหม่จนกว่าจะได้
        fprintf('Genaretion location again!!\n');
    end 
    
end
   
while (true)
    
    %สุ่มเลข ระหว่าง border ถึง ขนาด field-border แกน X และ แกน Y
    %field-boder คือระยะที่ไม่เกินขอบ border (ซึ่งหมายถึงอยู่ภายในขอบ border)
    fieldData = generateRandomField(fieldData);
    
    %เลขที่ได้ต้องไม่ใช่ตำแหน่งเดียวกันกับสิ่งก่อนหน้านี้
    %(ป้องกันการทับที่)
    if (fieldData.locationSaveX ~= fieldData.randomX && fieldData.locationSaveY ~= fieldData.randomY)
        
        % goal คือประตูบอล จะถูกสุ่มตำแหน่งในขอบเขตที่นับจากขอบ +
        % ขนาดของประตู
        %ตำแหน่ง X คือตำแหน่งที่ประตูสามารถสุ่มได้ / 0 คือพื้นที่สนาม field
        %000000000000000000
        %0XXXXXXXXXXXXXXXX0
        %0X00000000000000X0
        %0X00000000000000X0
        %0X00000000000000X0
        %0XXXXXXXXXXXXXXXX0
        %000000000000000000
        
        %เงื่อนไขถ้าอยู่ในตำแหน่ง X ดังรูปให้ออกลูปและใช้ตำแหน่งนี้ทันที
        %000000000000000000
        %0XXXXXXXXXXXXXXXX0
        %000000000000000000
        %000000000000000000
        %000000000000000000
        %000000000000000000
        %000000000000000000
        if (fieldData.randomX >= (fieldData.border+fieldData.goalSizeX/2) && fieldData.randomX <= (fieldData.border+fieldData.goalSizeX/2)+(fieldData.goalSizeX))
            if fieldData.randomY >= (fieldData.border+fieldData.goalSizeY/2) && fieldData.randomY <= (fieldData.border+fieldData.goalSizeY/2)+(fieldData.goalSizeY)
                fieldData = saveLocation(fieldData);
                break;
            else
                fprintf('Genaretion location again!!\n');
            end
        end
        
        %เงื่อนไขถ้าอยู่ในตำแหน่ง X ดังรูปให้ออกลูปและใช้ตำแหน่งนี้ทันที
        %000000000000000000
        %000000000000000000
        %000000000000000000
        %000000000000000000
        %000000000000000000
        %0XXXXXXXXXXXXXXXX0
        %000000000000000000
        if fieldData.randomX <= (fieldData.fieldSizeX-fieldData.goalSizeX/2)-fieldData.border && (fieldData.randomX >= (fieldData.border+fieldData.goalSizeX/2))
           if fieldData.randomY >= (fieldData.border+fieldData.goalSizeY/2) && fieldData.randomY <= (fieldData.border+fieldData.goalSizeY/2)+(fieldData.goalSizeY)
               fieldData = saveLocation(fieldData);
               break;
            else
               fprintf('Genaretion location again!!\n');
           end
           
        %เงื่อนไขถ้าอยู่ในตำแหน่ง X ดังรูปให้ออกลูปและใช้ตำแหน่งนี้ทันที
        %000000000000000000
        %0000000000000000X0
        %0000000000000000X0
        %0000000000000000X0
        %0000000000000000X0
        %0000000000000000X0
        %000000000000000000
           if fieldData.randomY <= (fieldData.fieldSizeY-fieldData.goalSizeY/2)-fieldData.border && fieldData.randomY >= (fieldData.fieldSizeY-fieldData.goalSizeY/2)-fieldData.border-(fieldData.goalSizeY)
               fieldData = saveLocation(fieldData); 
               break;
           else
                fprintf('Genaretion location again!!\n');
           end  
        end
        
        %เงื่อนไขถ้าอยู่ในตำแหน่ง X ดังรูปให้ออกลูปและใช้ตำแหน่งนี้ทันที
        %000000000000000000
        %0X0000000000000000
        %0X0000000000000000
        %0X0000000000000000
        %0X0000000000000000
        %0X0000000000000000
        %000000000000000000
        if fieldData.randomX <= (fieldData.fieldSizeX-fieldData.goalSizeX/2)-fieldData.border && fieldData.randomX >= (fieldData.fieldSizeX-fieldData.goalSizeX/2)-fieldData.border-(fieldData.goalSizeX)
                if fieldData.randomY <= (fieldData.fieldSizeY-fieldData.goalSizeY/2)-fieldData.border && fieldData.randomY >= ((fieldData.fieldSizeY-fieldData.goalSizeY/2)-fieldData.border)-(fieldData.goalSizeY)
                    fieldData = saveLocation(fieldData);
                    break;
                else
                    fprintf('Genaretion location again!!\n');
                end
         end
     end
end 
    %นำ goal ที่สร้าง ลงไปในพื้นที่สนาม field ตามค่าที่สุ่มได้
	field(fieldData.randomX-(fieldData.goalSizeX/2):(fieldData.randomX+(fieldData.goalSizeX/2))-1,(fieldData.randomY-(fieldData.goalSizeY/2)):(fieldData.randomY+(fieldData.goalSizeY/2))-1,1)=goal(:,:,1);
	field(fieldData.randomX-(fieldData.goalSizeX/2):(fieldData.randomX+(fieldData.goalSizeX/2))-1,(fieldData.randomY-(fieldData.goalSizeY/2)):(fieldData.randomY+(fieldData.goalSizeY/2))-1,2)=goal(:,:,2);
	field(fieldData.randomX-(fieldData.goalSizeX/2):(fieldData.randomX+(fieldData.goalSizeX/2))-1,(fieldData.randomY-(fieldData.goalSizeY/2)):(fieldData.randomY+(fieldData.goalSizeY/2))-1,3)=goal(:,:,3);
	figure,imshow(field);

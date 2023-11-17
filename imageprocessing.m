
clear;
close all;

randomX = uint16(0);
randomY = uint16(0);

%ที่ต้องทำคือห้ามให้สีทับกัน ก็คือเช็คระยะของตำแหน่ง บวกด้วยระยะสี
%ห่างกันได้ห้ามน้อยกว่า 2pixel
%size%

%ขนาดสนามบอล
fieldSizeX = 512;
fieldSizeY = 512;

%ขนาดบอล
ballSizeX = 16;
ballSizeY = 16;

%ขนาดหุ่นยนต์
robotSizeX = 30;
robotSizeY = 32;

%ขนาดโกล
goalSizeX = 100;
goalSizeY = 32;

%ระยะจากขอบสนามบอลที่ห้ามเกิน
border = 20;

%สนามบอล%
field=uint8(zeros(fieldSizeX,fieldSizeY,3));
field(:,:,1)=0;
field(:,:,2)=170;
field(:,:,3)=0;

%สร้างหุ่นยนต์
robot=uint8(zeros(robotSizeX,robotSizeY,3));
robot(:,:,1)=0;
robot(:,:,2)=0;
robot(:,:,3)=255;

%สร้างball
ball=uint8(zeros(ballSizeX,ballSizeY,3));
ball(:,:,1)=255;
ball(:,:,2)=12;
ball(:,:,3)=45;

%สร้างgoal
goal=uint8(zeros(goalSizeX,goalSizeY,3));
goal(:,:,1)=255;
goal(:,:,2)=255;
goal(:,:,3)=45;

field((fieldSizeX/2)-(ballSizeX/2):(fieldSizeY/2)+((ballSizeY/2)-1),(fieldSizeX/2)-(ballSizeX/2):(fieldSizeY/2)+((ballSizeY/2)-1),1)=ball(:,:,1);
field((fieldSizeX/2)-(ballSizeX/2):(fieldSizeY/2)+((ballSizeY/2)-1),(fieldSizeX/2)-(ballSizeX/2):(fieldSizeY/2)+((ballSizeY/2)-1),2)=ball(:,:,2);
field((fieldSizeX/2)-(ballSizeX/2):(fieldSizeY/2)+((ballSizeY/2)-1),(fieldSizeX/2)-(ballSizeX/2):(fieldSizeY/2)+((ballSizeY/2)-1),3)=ball(:,:,3);

%ห้ามเกินขอบ ระยะ = border;

while (true)
    randomX = border + ((fieldSizeX-border)-border) .* rand();
    randomX = uint16(round(randomX));
    randomY = border + ((fieldSizeY-border)-border) .* rand();
    randomY = uint16(round(randomY));
    
        fprintf('randomX = %i\n', randomX);
        fprintf('randomY = %i\n', randomY);
    
    if (randomX >= (border+robotSizeX/2) && randomX <= ((fieldSizeX-robotSizeX/2)-border) && randomY >= (border+robotSizeY/2) && randomY <= ((fieldSizeY-robotSizeY/2)-border))
        field(randomX-(robotSizeX/2):(randomX+(robotSizeX/2))-1,(randomY-(robotSizeY/2)):(randomY+(robotSizeY/2))-1,1)=robot(:,:,1);
        field(randomX-(robotSizeX/2):(randomX+(robotSizeX/2))-1,(randomY-(robotSizeY/2)):(randomY+(robotSizeY/2))-1,2)=robot(:,:,2);
        field(randomX-(robotSizeX/2):(randomX+(robotSizeX/2))-1,(randomY-(robotSizeY/2)):(randomY+(robotSizeY/2))-1,3)=robot(:,:,3);
        locationSaveX = randomX;
        locationSaveY = randomY;
        break;
    else
        fprintf('Genaretion location again!!\n');
    end 
    
end
            
while (true)
    randomX = border + ((fieldSizeX-border)-border) .* rand();
    randomX = uint16(round(randomX));
    randomY = border + ((fieldSizeY-border)-border) .* rand();
    randomY = uint16(round(randomY));
    fprintf('randomX = %i\n', randomX);
    fprintf('randomY = %i\n', randomY);
    
    if (locationSaveX ~= randomX && locationSaveY ~= randomY)
        if (randomX >= (border+goalSizeX/2) && randomX <= (border+goalSizeX/2)+(goalSizeX))
            if randomY >= (border+goalSizeY/2) && randomY <= (border+goalSizeY/2)+(goalSizeY)
                locationSaveX = randomX;
                locationSaveY = randomY;
                break;
                                else
                    fprintf('Genaretion location again!!\n');
            end
        end
        if randomX <= (fieldSizeX-goalSizeX/2)-border && (randomX >= (border+goalSizeX/2))
           if randomY >= (border+goalSizeY/2) && randomY <= (border+goalSizeY/2)+(goalSizeY)
               locationSaveX = randomX;
               locationSaveY = randomY;
               break;
                               else
                    fprintf('Genaretion location again!!\n');
           end
            
           if randomY <= (fieldSizeY-goalSizeY/2)-border && randomY >= (fieldSizeY-goalSizeY/2)-border-(goalSizeY)
           break;
                           else
                    fprintf('Genaretion location again!!\n');
           end  
        end
        if randomX <= (fieldSizeX-goalSizeX/2)-border && randomX >= (fieldSizeX-goalSizeX/2)-border-(goalSizeX)
                if randomY <= (fieldSizeY-goalSizeY/2)-border && randomY >= ((fieldSizeY-goalSizeY/2)-border)-(goalSizeY)
                    locationSaveX = randomX;
                    locationSaveY = randomY;
                    break;
                else
                    fprintf('Genaretion location again!!\n');
                end
         end
     end
end 


                        field(randomX-(goalSizeX/2):(randomX+(goalSizeX/2))-1,(randomY-(goalSizeY/2)):(randomY+(goalSizeY/2))-1,1)=goal(:,:,1);
                        field(randomX-(goalSizeX/2):(randomX+(goalSizeX/2))-1,(randomY-(goalSizeY/2)):(randomY+(goalSizeY/2))-1,2)=goal(:,:,2);
                        field(randomX-(goalSizeX/2):(randomX+(goalSizeX/2))-1,(randomY-(goalSizeY/2)):(randomY+(goalSizeY/2))-1,3)=goal(:,:,3);
                        figure,imshow(field);

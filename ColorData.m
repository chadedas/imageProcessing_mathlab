classdef ColorData
    properties 
        Name
        radius
        SizeX
        SizeY
        NumberR
        NumberG
        NumberB
        Field
        FieldSizeX
        FieldSizeY
    end
    
    methods
        % Constructor
        function obj = ColorData(field, item, numberR, numberG, numberB)
            obj.Name = item.Name;
            obj.radius = 'radius';
            obj.SizeX = item.SizeX;
            obj.SizeY = item.SizeY;
            obj.NumberR = numberR;
            obj.NumberG = numberG;
            obj.NumberB = numberB;
            obj.Field = field;  % ใช้ field ตรงนี้
            obj.FieldSizeX = size(field, 1);  % ปรับขนาด field ให้เป็น [FieldSizeX, FieldSizeY, 3]
            obj.FieldSizeY = size(field, 2);
        end
        
        function createOBJ(obj)
                obj.radius = uint8(zeros(obj.SizeX, obj.SizeY, 3));
                obj.radius(:,:,1) = obj.NumberR;
                obj.radius(:,:,2) = obj.NumberG;
                obj.radius(:,:,3) = obj.NumberB; 
                obj.placeInField();
        end
            
        function placeInField(obj)
                obj.Field((obj.FieldSizeX/2)-(obj.SizeX/2):(obj.FieldSizeY/2)+((obj.SizeY/2)-1), ...
                (obj.FieldSizeX/2)-(obj.SizeX/2):(obj.FieldSizeY/2)+((obj.SizeY/2)-1),1) = obj.radius(:,:,1);
                obj.Field((obj.FieldSizeX/2)-(obj.SizeX/2):(obj.FieldSizeY/2)+((obj.SizeY/2)-1), ...
                (obj.FieldSizeX/2)-(obj.SizeX/2):(obj.FieldSizeY/2)+((obj.SizeY/2)-1),2) = obj.radius(:,:,2);
                obj.Field((obj.FieldSizeX/2)-(obj.SizeX/2):(obj.FieldSizeY/2)+((obj.SizeY/2)-1), ...
                (obj.FieldSizeX/2)-(obj.SizeX/2):(obj.FieldSizeY/2)+((obj.SizeY/2)-1),3) = obj.radius(:,:,3);
        end
        
        function processedData = getProcessedData(obj)
            processedData = obj.Field;
        end
    end
end

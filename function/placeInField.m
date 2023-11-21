function field = placeInField(field, item, sizeX, sizeY)
    % ตำแหน่งที่ควรวาง robot ใน field
    % กำหนดค่าใน field ด้วยค่าจาก robot
    field(x, y, 1) = item(:, :, 1);
    field(x, y, 2) = item(:, :, 2);
    field(x, y, 3) = item(:, :, 3);
    
end


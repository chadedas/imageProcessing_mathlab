function field = placeInField(field, item, fieldData)
    % กำหนดตำแหน่งใน field ตามข้อมูลใน fieldData
    x_range = (fieldData.randomX-(fieldData.(item).SizeX/2)):(fieldData.randomX+(fieldData.(item).SizeX/2))-1;
    y_range = (fieldData.randomY-(fieldData.(item).SizeY/2)):(fieldData.randomY+(fieldData.(item).SizeY/2))-1;

    % กำหนดค่าใน field ตาม item ที่รับมา
    field(x_range, y_range, :) = fieldData.(item).Color;
end

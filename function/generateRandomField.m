function fieldData = generateRandomField(fieldData)
    fieldData.randomX = uint16(round(fieldData.border + ((fieldData.fieldSizeX - fieldData.border) - fieldData.border) .* rand()));
    fieldData.randomY = uint16(round(fieldData.border + ((fieldData.fieldSizeY - fieldData.border) - fieldData.border) .* rand()));
    fprintf('randomX = %i\n', fieldData.randomX);
    fprintf('randomY = %i\n', fieldData.randomY);
end


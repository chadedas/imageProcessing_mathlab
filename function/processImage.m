function processImage()

    % Load image
    imrgb = imread('imageProcess/image.jpg');
    
    % Convert to HSV
    imhsv = rgb2hsv(imrgb);

% Separate field
imf = separateColor(imhsv, 0.2, 0.8); % ปรับ lowerThresh และ upperThresh ตามความเหมาะสม

% Separate car
imc = separateColor(imhsv, 0.5, 0.9); % ปรับ lowerThresh และ upperThresh ตามความเหมาะสม

% Separate goal
imgo = separateColor(imhsv, -1, 0.3);

% Separate ball
imfb = separateColor(imhsv, 0.1, 0.2); % ปรับ lowerThresh และ upperThresh ตามความเหมาะสม

    % Display results
    figure;
    subplot(2,2,1), imshow(imf), title('ImF');
    subplot(2,2,2), imshow(imc), title('ImC');
    subplot(2,2,3), imshow(imgo), title('Imgo');
    subplot(2,2,4), imshow(imfb), title('Imfb');

end

function result = separateColor(imhsv, lowerThresh, upperThresh)
    result = imhsv(:,:,1);
    result(result < lowerThresh) = 0;
    result(result > upperThresh) = 0;
    result(result > 0) = 1;
end

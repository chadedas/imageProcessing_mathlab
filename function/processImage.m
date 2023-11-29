function processImage()

    % Load image
    imrgb = imread('imageProcess/image.jpg');
    
    % Convert to HSV
    imhsv = rgb2hsv(imrgb);
    imf = separateColor(imhsv, 0.33, 0.35);

% Separate car
    imc = separateColor(imhsv, 0.154, 0.2);

% Separate goal
    imgo = separateColor(imhsv, 0.825, 0.840);

% Separate ball
    imfb = separateColor(imhsv, 0.34, 0.55);

    % Display results
    figure;
    invert = imc + imgo + imfb;
    subplot(2,3,1), imshow(imf), title('Field');
    subplot(2,3,2), imshow(invert), title('invert');

    subplot(2,3,3), imshow(imc), title('Robot');
    subplot(2,3,4), imshow(imgo), title('Goal');
    subplot(2,3,5), imshow(imfb), title('Football');
end

function result = separateColor(imhsv, lowerThresh, upperThresh)
    result = imhsv(:,:,1);
    result(result < lowerThresh) = 0;
    result(result > upperThresh) = 0;
    result(result > 0) = 1;
end

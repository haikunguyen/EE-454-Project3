%This function returns the thresholded image of the input image.
function [imageThresh] = thresholding(image, threshold)
    [rows, columns] = size(image); %get dimensions of image array
    %iterate through values in image array
    for x = 1:rows
        for y = 1:columns
            if image(x,y) > threshold %if value exceeds threshold make white (255)
                image(x,y) = 255;
            else
                image(x,y) = 0; %if value is below threshold make black (0)
            end
        end
    end
    
    imageThresh = image;
end


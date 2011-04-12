function [x, y] = findMosquitoInImage(img)

    % based on util_findlaser.m from the Image Acqustion Toolbox Laser tracking demo

    grayscale = uint8((uint16(img(:,:,1)) + uint16(img(:,:,2)) + uint16(img(:,:,3)))/3);
    candidates = (grayscale < 100);
    props = regionprops(bwlabel(candidates), 'Area', 'Centroid', 'MajorAxisLength');
    
    area = [props.Area];
    majorAxis = [props.MajorAxisLength];
    area(area > 5000 | majorAxis > 100) = 0; % max area of the mosquito of size 50 is about 3000
    [num_pixels, index] = max(area);
    
    threshold = 5;
    if (num_pixels > threshold)
        % Area that is big enough exists
        x = props(index).Centroid(1);
        y = props(index).Centroid(2);
    else 
        % No mosquito found in the image
        x = NaN;
        y = NaN;
    end

end

function [x, y] = findMosquitoInImage(img)

    % based on util_findlaser.m from the Image Acqustion Toolbox Laser tracking demo

    grayscale = uint8((uint16(img(:,:,1)) + uint16(img(:,:,2)) + uint16(img(:,:,3)))/3);

    %threshold = 1.25 * double(min(grayscale(:)));
    %candidates = (grayscale <= threshold);
    candidates = (grayscale < 50);
    
    props = regionprops(bwlabel(candidates), 'Area', 'Centroid');
    
    area = [props.Area];
    [num_pixels, index] = max(area);
    
    % TODO: to avoid recognizing border instead of mosquito,
    % check maximum mosquito area
    
    threshold = 5;
    if (num_pixels > threshold)
        % Area of laser is big enough, get region info.
        x = props(index).Centroid(1);
        y = props(index).Centroid(2);
    else 
        % Area of laser is too small to get past the threshold.
        x = NaN;
        y = NaN;

end

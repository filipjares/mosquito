function [azimuth, inclination] = mosquitoPxPositionToAzimuthAndElevation(x, y)

    imageCenterX = 320;
    imageCenterY = 240;
    
    if ~isnan(x) & ~isnan(y)
        azimuth = atan( (x-imageCenterX) * 100/397.6 / 540 );
        inclination = -atan( (y - imageCenterY) * 100/397.6 / 540 );
    else
        azimuth = NaN;
        inclination = NaN;
    end

end

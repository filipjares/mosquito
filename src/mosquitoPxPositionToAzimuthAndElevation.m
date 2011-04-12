function [azimuth, inclination] = mosquitoPxPositionToAzimuthAndElevation(x, y)

    % constants
    imageCenterX = 320;
    imageCenterY = 240;
    d = 540;  % camera - monitor distance [mm]
    a = 100/397.6; % coefficient [mm/pixel]
    
    % computation
    if ~isnan(x) & ~isnan(y)
        dx = x-imageCenterX;
        dy = y - imageCenterY;
        d2 = sqrt(d^2 + dx);
        azimuth = atan( dx * a / d );
        inclination = atan( dy * a / d2 );
    else
        azimuth = NaN;
        inclination = NaN;
    end

end

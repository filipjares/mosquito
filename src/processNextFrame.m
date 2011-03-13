function processNextFrame(vid, event)

    global ser x y;

    img = peekdata(vid, 1);
    img = deBayerize(img);
    
    [newX, newY] = findMosquitoInImage(img);
    % mosquito's azimuth and inclination are relative to the camera frame
    [mAzimuth, mInclination] = mosquitoPxPositionToAzimuthAndElevation(newX, newY);
    
    % TODO: use correct transformations
    if ~isnan(mAzimuth) & ~isnan(mInclination)
        x = x + mAzimuth * 100;     % TODO: remove this magic number
        y = y - mInclination * 100; % TODO: remove this magic number
        ptmove(ser, x, y);
        str = sprintf('Mosquito found at [%d, %d].', x, y);
        disp(str);
    else
        disp('Nothing found');
    end

    imshow(img);
    disp('processed one image');

end
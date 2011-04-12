function processNextFrame(vid, event)

    pNF = tic;

    global ser x y;
    global routineDuration;
    
    global k;
    k = k+1;
    
    global huntStarted;

    [img time meta] = getdata(vid, 1);
    if (any(size(img) ~= [960 1280]))
        disp('getdata failed');
        return;
    end
    img = deBayerize(img);
    
    fMII = tic;
    [newX, newY] = findMosquitoInImage(img);
    fMIIDuration = toc(fMII);
    % mosquito's azimuth and inclination are relative to the camera frame
    [mAzimuth, mInclination] = mosquitoPxPositionToAzimuthAndElevation(newX, newY);
    
    % TODO: use correct transformations
    if ~isnan(mAzimuth) & ~isnan(mInclination)
        huntStarted = true;
        x = x + mAzimuth * 30;     % TODO: remove this magic number
        y = y - mInclination * 30; % TODO: remove this magic number
        ptmove(ser, x, y);
        str = sprintf('Mosquito found at [%.2f, %.2f] in picture at [%.2f, %.2f].', x, y, newX, newY);
        disp(str);
    else
        disp('Nothing found');
    end
    
    logData(k, img, time, meta, [x y], [newX newY], fMIIDuration);

    %imshow(addCrosshairToThePicture(img));
    %hold on; plot(newX, newY, 'bo'); hold off;
    
    routineDuration(k) = toc(pNF);

end
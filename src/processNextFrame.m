function processNextFrame(vid, event)

    global ser x y;
    global n gdata;

    img = peekdata(vid, 1);
    if (any(size(img) ~= [960 1280]))
        disp('peekdata failed');
        return;
    end
    img = deBayerize(img);
    n = n + 1;
    if (n < 120)
        disp('saving image to gdata');
        gdata(:,:,:,n) = img(:,:,:);
    else
        disp('did not save anything to gdata');
    end
    
    [newX, newY] = findMosquitoInImage(img);
    % mosquito's azimuth and inclination are relative to the camera frame
    [mAzimuth, mInclination] = mosquitoPxPositionToAzimuthAndElevation(newX, newY);
    
    % TODO: use correct transformations
    if ~isnan(mAzimuth) & ~isnan(mInclination)
        x = x + mAzimuth * 100;     % TODO: remove this magic number
        y = y - mInclination * 100; % TODO: remove this magic number
        ptmove(ser, x, y);
        str = sprintf('Mosquito found at [%.2f, %.2f] in picture at [%.2f, %.2f].', x, y, newX, newY);
        disp(str);
    else
        disp('Nothing found');
    end

    imshow(addCrosshairToThePicture(img));
    hold on; plot(newX, newY, 'bo'); hold off;
    disp('processed one image');

end
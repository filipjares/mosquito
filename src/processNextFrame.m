function processNextFrame(vid, event)

    pNF = tic;                  % will measure this function's call duration
    global routineDuration;

    global ser x y;             % serial port object and actual pan-tilt position
    global k;                   % number of pictures acquired
    global huntStarted;         % was mosquito ever found?
    
    global previous_errx;        % previous error of regulation
    global previous_erry; 
    global integralx;            
    global integraly; 
    
    global P I;
    
    % take picture
    [img time meta] = getdata(vid, 1);
    if (any(size(img) ~= [960 1280]))
        disp('getdata failed');
        return;
    end
    k = k+1;
    if (k < 5)
        % first pictures often contain old data
        return;
    end
    img = deBayerize(img);
    
    % find mosquito in the taken image
    fMII = tic;                 % measure findMosquitoInImage duration
    [newX, newY] = findMosquitoInImage(img);
    fMIIDuration = toc(fMII);
    
    % mosquito's azimuth and inclination are relative to the camera frame
    [mAzimuth, mInclination] = mosquitoPxPositionToAzimuthAndElevation(newX, newY);
    
    % TODO: use correct transformations
    previous_errx = 0;
    previous_erry = 0;
    integralx = 0;
    integraly = 0;
    T = 2; %???
    if ~isnan(mAzimuth) & ~isnan(mInclination)
        integralx = integralx + mAzimuth*T;
        integraly = integraly + mInclination*T;
        
        huntStarted = true;
        x = x + mAzimuth * P + I*integralx;     % TODO: remove this magic number
        y = y + mInclination * P+I*integraly; % TODO: remove this magic number
        previous_errx = mAzimuth;
        previous_erry = mInclination;
        ptmove(ser, x, y);
        str = sprintf('Mosquito found at [%.2f, %.2f] in picture at [%.2f, %.2f].', x, y, newX, newY);
        disp(str);
    else
        disp('Nothing found');
    end
    
    % save the image itself and other useful information to global variables
    logData(k, img, time, meta, [x y], [newX newY], fMIIDuration);
    routineDuration(k) = toc(pNF);

    %imshow(addCrosshairToThePicture(img));
    %hold on; plot(newX, newY, 'bo'); hold off;

end
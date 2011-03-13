function [data time meta] = followReferencePositionAndTakePictures(vid, r)

    if nargin < 1
        error('Invalid function call. Argument containing reference required.');
    end
    
    if size(r,2) ~= 2
        error('Invalid argument dimensions');
    end
    
    % framesCount = size(r,1)*4;

    ser = servoInit();  
    
    % init video object
    % vid = videoinput('winvideo',1,'Y800_1280x960');
    triggerconfig(vid, 'Manual');
    set(vid, 'FramesPerTrigger', Inf);
    set(vid, 'TriggerRepeat', Inf);
    start(vid);
    
    % move camera to initial position and wait
    ptmove(ser, r(1,1), r(1,2));
    pause(2);
   
    trigger(vid);
    tic;
    for i = 1:size(r,1);
        ptmove(ser, r(i,1), r(i,2));
        pause(0.05);
    end
    S = toc;
    S
    stop(vid);
    
    wait(vid, vid.FramesAcquired*0.1, 'logging');
    [data time meta] = getdata(vid, vid.FramesAcquired);
    data = deBayerize(data);

    % do the cleanup
    wait(vid, 5, 'running');
    % delete(vid);
    servoClose(ser);

end

function [data time meta] = moveToPositionAndTakePictures(x, y, framesCount)
    % Moves camera to specified position and returns the picture(s).
    % Data is either single image (in case of framesCount being 1)
    % or array of images (recording the movement of the camera).
    % In the latter case indexing of the returned array goes as follows:
    % (X, Y, RGB, imageNo), that is it is the same as indexing of the
    % data part returned by the getdata function of the Image Acquistion
    % Toolbox.
    % When omitted, default value of x and y is the center position for
    % "Komar 2", that is [x, y] = [121, 123]. Default value for
    % framesCount is 1

    if (nargin < 2)
        x = 121;
        y = 123;
    end
    if (nargin < 3)
        framesCount = 1;
    end
    
    % TODO: don't init the serial connection object if available
    ser = servoInit();  
    
    % init video object
    vid = videoinput('winvideo',1,'Y800_1280x960');
    triggerconfig(vid, 'Manual');
    set(vid, 'FramesPerTrigger', framesCount);
    set(vid, 'TriggerRepeat', 0);
    start(vid);
    
    % move camera to specified position, wait two seconds
    ptmove(ser, x, y);
    pause(0.1);
    % take a picture and show it
    trigger(vid);
    wait(vid, 5, 'logging');
%     if (framesCount > 1)
%         data = zeros(480, 640, 3, framesCount);
%         for i = 1:framesCount
%             img = getOneImage(vid);
%             data(:,:,:, i) = img(:,:,:);
%         end
%     else
%         img = getOneImage(vid);
%         data = img;
%     end
    [data time meta] = getdata(vid, framesCount);
    data = deBayerize(data);

    % do the cleanup
    delete(vid);
    servoClose(ser);

end

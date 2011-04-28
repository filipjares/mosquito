function playResults(start, stop)

    global gdata;

    if (nargin < 2)
        stop = size(gdata,4);
    end
    if (nargin < 1)
        start = 1;
    end

    for i=start:stop
        showRecordedImage(i);
    end

end

function playResults(start, stop)

    global n;

    if (nargin < 2)
        stop = n;
    end
    if (nargin < 1)
        start = 1;
    end

    for i=start:stop
        showRecordedImage(i);
    end

end

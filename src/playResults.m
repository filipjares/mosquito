function playResults(start, stop)

    global n gtime;

    if (nargin < 2)
        stop = n;
    end
    if (nargin < 1)
        start = 1;
    end

    for i=start:stop
        showRecordedImage(i);
        pause(mean(diff(gtime(1:n))));
    end

end

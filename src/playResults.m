function playResults(start, stop)

    global N n gtime;

    if (nargin < 2)
        stop = min(n,N);
    end
    if (nargin < 1)
        start = 1;
    end

    for i=start:stop
        showRecordedImage(i);
        pause(mean(diff(gtime(1:stop))));
    end

end

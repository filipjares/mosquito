function logData(k, img, time, meta, pos, mosquitoInImage, mosquitoInImageDuration)

    global N n nk gdata gtime gmeta gPos gMosquitoInImage findMosquitoInImageDuration;

    n = n+1;
    
    if (n <= N)
        disp('saving image to gdata');
        nk(n) = k;
        gdata(:,:,:,n) = img(:,:,:);
        gtime(n) = time;
        gmeta{n} = meta;
        
        gPos(n,:) = pos;
        gMosquitoInImage(n,:) = mosquitoInImage;
        findMosquitoInImageDuration(n,:) = mosquitoInImageDuration;
    else
        disp('did not save anything to gdata');
    end

end
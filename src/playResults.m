for i=1:size(gdata,4)
	imshow(addCrosshairToThePicture(gdata(:,:,:,i)));
    str = sprintf('%.0f, camera: (%.0f, %.0f)', i, gPos(i, 1), gPos(i, 2));
    xlabel(str);
    hold on;
    plot(gMosquitoInImage(i,1), gMosquitoInImage(i,2), 'yo', 'LineWidth', 3);
    plot(gMosquitoInImage(i,1), gMosquitoInImage(i,2), 'bo');
    hold off;
    pause(0.2);
end
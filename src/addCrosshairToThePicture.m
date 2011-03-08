function img = addCrosshairToThePicture(im, thickness)

    if (nargin < 2)
        thickness = 1;
    end
    img = im;
    
    % indexes in the middle of image
    centerX = size(im, 2)/2;
    centerY = size(im, 1)/2;
    verticalLineIndexes = [centerX-thickness:centerX+thickness];
    horizontalLineIndexes = [centerY-thickness:centerY+thickness];
    
%     switch ndims(im)
%         case 3
%             img(:, verticalLineIndexes, [1 2]) = 0;
%             img(:, verticalLineIndexes, 3) = 255;
%             img(horizontalLineIndexes, :, [1 2]) = 0;
%             img(horizontalLineIndexes, :, 3) = 255;
%         case 4
            img(:, verticalLineIndexes, [1 2], :) = 0;
            img(:, verticalLineIndexes, 3, :) = 255;
            img(horizontalLineIndexes, :, [1 2], :) = 0;
            img(horizontalLineIndexes, :, 3, :) = 255;
%     end
    
end

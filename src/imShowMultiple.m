function imShowMultiple(images)
    % Shows images (uses imshow/subplot+imshow). In fact this function is redundant
    % as there is imaqmontage in the Image Acquistion Toolbox which does something
    % similar in a better way.

    if (~isa(images, 'uint8'))
        images = uint8(images);
    end
    
    switch ndims(images)
        case 3
            subplot(1,1,1);
            imshow(images);
        case 4
            imgCount = size(images,4);
            for i = 1:imgCount
                img = zeros(size(images,1), size(images,2), size(images,3), 'uint8');
                img(:,:,:) = images(:,:,:, i);
                subplot(1, imgCount, i);
                %subimage(img);
                imshow(img);
            end
        otherwise
            error('Invalid argument size. Supported is size of 3 (single image) and 4 (sequence of images)');
    end

end

function imShowMultiple(images)

    images = uint8(images); % TODO: this could be conditional
    
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
    end

end

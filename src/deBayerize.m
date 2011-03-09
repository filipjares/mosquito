function img = deBayerize(im)
    % Returns de-bayerized version of the image (image sequence) given in argument.

    switch ndims(im)
        case {2, 3}
            img = zeros([size(im, 1)/2, size(im, 2)/2, 3], 'uint8');
        case 4
            img = zeros([size(im, 1)/2, size(im, 2)/2, 3, size(im, 4)], 'uint8');
        otherwise
            error('Invalid argument size. Supported is size of 3 (single image) and 4 (sequence of images)');
    end
    img(:,:,1,:) = im(2:2:end,1:2:end,1,:);
    img(:,:,2,:) = im(1:2:end,1:2:end,1,:)/2 + im(2:2:end,2:2:end,1,:)/2;
    img(:,:,3,:) = 6.5 * im(1:2:end,2:2:end,1,:);

end
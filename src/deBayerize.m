function img = deBayerize(im)


    % TODO: deBayerize sequence of images as well

    img = zeros(size(im)./2, 'uint8');
    img(:,:,1) = im(2:2:end,1:2:end);
    img(:,:,2) = im(1:2:end,1:2:end)/2 + im(2:2:end,2:2:end)/2;
    img(:,:,3) = 6.5 * im(1:2:end,2:2:end);

end
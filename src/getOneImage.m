function IMG = getOneImage(vid)

    im = getdata(vid,1); % precteni snimku z bufferu
    IMG = deBayerize(im);

end
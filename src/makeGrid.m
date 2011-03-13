function grid = makeGrid()

%   vodorovný rozměr obrazovky 	378 	mm
% 	svislý rozměr obrazovky 	303 	mm
% 	vodorovný rozměr obrazovky 	1280 	pixelů
% 	svislý rozměr obrazovky 	1024 	pixelů
% 	kolmá vzdálenost svislé rotační osy od obrazovky 	540 	mm
% 	ohnisková vzdálenost objektivu 	16 	mm 

    rx = 1280/378;
    ry = 1024/303;
    
    grid = ones(1024,1280,3);
    
    for x = round(linspace(640-150*rx, 640+150*rx, 7))
        grid(:,[x-1:x+1],:) = 0;
    end
    
    for y = round(linspace(512-150*ry, 512+150*ry, 7))
        grid([y-1:y+1],:,:) = 0;
    end
      
    grid([1:3 end-2:end],:,:) = 0;
    grid(:,[1:3 end-2:end],:) = 0;
    
end
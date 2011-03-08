% Define points to be measured

x0 = 90;    % horizontal lower bound
y0 = 100;    % vertical lower bound
xM = 160;   % horizontal upper bound
yM = 150;   % vertical upper bound
dX = 10;     % horizontal increment
dY = 10;     % vertical increment

X = x0:dX:xM;
Y = y0:dY:yM;

imgCount = length(X)*length(Y);

%% Camera initialization, use manual trigger, acquiring single frames

vid = videoinput('winvideo',1,'Y800_1280x960');

%get(vid, 'FramesAcquired');
%get(vid, 'FramesAvailable');

triggerconfig(vid, 'Manual');
set(vid, 'FramesPerTrigger', 1);
set(vid, 'TriggerRepeat', imgCount - 1);

%% Pan-Tilt unit initialization:

ser = servoInit();

%% Start the video stream

start(vid);
images = zeros(480, 640, 3, imgCount, 'uint8');
positions = zeros(imgCount, 2);

for j = 1:length(Y);
	for i = 1:length(X);
        k = length(X)*(j-1)+i;
        x = X(i);
        y = Y(j);
		ptmove(ser, x, y); % 127, 127 je zhruba centralni pozice
        if i == 1
            pause(2);
        else
            pause(0.5);
        end
		trigger(vid);
		wait(vid, 1, 'logging');
        img = getOneImage(vid);
        images(:,:,:, k) = img;
        positions(k, :) = [x y];
        %imshow(img);
    end
end

%% Cleanup - Camera

stop(vid);
delete(vid);

%% Cleanup - Pan-Tilt Unit

servoClose(ser);


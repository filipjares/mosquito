
%%

global ser;
global x y;

% TODO: this will be removed
x = 121;
y = 124;

vid = videoinput('winvideo',1,'Y800_1280x960');
ser = servoInit();
ptmove(ser, x, y);

%%

triggerconfig(vid, 'Manual');
vid.FramesPerTrigger = 1;
vid.TriggerRepeat = Inf;
% vid.FramesAcquiredFcnCount = 10;
% vid.FramesAcquiredFcn = @processAcquiredFrames;
vid.TimerPeriod = 0.5;
vid.TimerFcn = @processNextFrame;

%%

start(vid);
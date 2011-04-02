
%%

global ser;
global x y;
global n gdata;

gdata = uint8(zeros(480,640,3,20));
n = 0;

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
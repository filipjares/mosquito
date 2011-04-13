
%% Global variables declaration and initialization

global ser;                         % pan-tilt serial port object
global x y;                         % current pan-tilt unit position

initLoggingVariables;

%% Camera and Pan-tilt unit initialization

% set initial camera (pan-tilt) position
x = 121;
y = 124;

vid = videoinput('winvideo',1,'Y800_1280x960');
ser = servoInit();
ptmove(ser, x, y);

%% Video triggering and callback setup

triggerconfig(vid, 'immediate');
vid.FramesPerTrigger = 1;
vid.TriggerRepeat = Inf;
vid.FrameGrabInterval = 2;
vid.FramesAcquiredFcnCount = 1;
vid.FramesAcquiredFcn = @processNextFrame;
%vid.TimerPeriod = 0.5;
%vid.TimerFcn = @processNextFrame;

%% Start it

start(vid);
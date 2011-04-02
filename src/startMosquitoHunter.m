
%%

global ser;
global x y;

global N n gdata gtime gmeta gPos gMosquitoInImage;

N = 40;
gdata = uint8(zeros(480,640,3,N));
% TODO: init gtime, gmeta, ... properly
gtime = zeros(N, 1);
gPos = zeros(N, 2);
gMosquitoInImage = zeros(N, 2);
n = 0;

global routineDuration findMosquitoInImageDuration;
global k nk;
nk = zeros(500,1);
k = 0;
routineDuration = zeros(N, 1);
findMosquitoInImageDuration = zeros(N, 1);

% TODO: this will be removed
x = 121;
y = 124;

vid = videoinput('winvideo',1,'Y800_1280x960');
ser = servoInit();
ptmove(ser, x, y);

%%

triggerconfig(vid, 'immediate');
vid.FramesPerTrigger = 1;
vid.TriggerRepeat = Inf;
vid.FrameGrabInterval = 2;
vid.FramesAcquiredFcnCount = 1;
vid.FramesAcquiredFcn = @processNextFrame;
%vid.TimerPeriod = 0.5;
%vid.TimerFcn = @processNextFrame;

%%

start(vid);
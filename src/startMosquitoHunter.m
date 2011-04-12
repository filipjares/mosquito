
%% Global variables declaration and initialization

global ser;                         % pan-tilt serial port object
global x y;                         % current pan-tilt unit position

global N n gdata gtime gmeta gPos gMosquitoInImage;

N = 40;                             % total number of images to log
gdata = uint8(zeros(480,640,3,N));  % for pictures logging
% TODO: init gmeta properly
gtime = zeros(N, 1);                % time instants of particular snapshots
gPos = zeros(N, 2);                 % camera (pan-tilt unit) positions
gMosquitoInImage = zeros(N, 2);     % positions of the mosquito in particular pictures
n = 0;                              % number of pictures logged

global routineDuration findMosquitoInImageDuration;
global k nk;
k = 0;                              % number of pictures acquired
nk = zeros(500,1);                  % n to k mapping
routineDuration = zeros(N, 1);      % duration of particular processNextFrame calls
findMosquitoInImageDuration = zeros(N, 1);  % duratio of particular findMosquitoInImage calls

global huntStarted;                 % was mosquito ever found in any image?
huntStarted = false;                % is used to determine whether to log images

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
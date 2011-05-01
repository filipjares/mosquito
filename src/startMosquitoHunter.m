
%% Global variables declaration and initialization

global ser;                         % pan-tilt serial port object
global x y;                         % current pan-tilt unit position

initLoggingVariables;

%% Init PID constants

% make them global in order to have them saved into the workspace
% (and save them into the .mat file together with the logged data)
global Px Py Ix Iy;

    %Px=20; %pro refresh 150
    %Py=20;
    %P=25; %pro refresh 100
    Px=25;
    Py=25;
    %Ix=1.6;
    %Iy=1.6;
    Ix=10;
    Iy=10;

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

%% Global variables declaration and initialization

global ser;                         % pan-tilt serial port object
global x y;                         % current pan-tilt unit position
global xLimLo xLimHi yLimLo yLimHi; % pan-tilt movement saturation

initLoggingVariables;

%% Init PID constants

% make them global in order to have them saved into the workspace
% (and save them into the .mat file together with the logged data)
global Px Py Ix Iy;

    %Px=20; %pro refresh 150
    %Py=20;
    %P=25; %pro refresh 100
    Px=20;
    Py=25;
    %Ix=1.6;
    %Iy=1.6;
    Ix=10;
    Iy=28;

%% Camera and Pan-tilt unit initialization

% camera movement saturation limits:
xLimLo = 96;
xLimHi = 155;
yLimLo = 90;
yLimHi = 150;

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

%% Start the mosquito
global URL;
URL = 'http://147.32.84.120/komar1/komar.cgi?refresh=100&size=20&accel=300&asize=25';

% obdoba "ostre odevzdavaci verze" (zmensujici se a zrychlujici komar)
% urlread URL; % TODO: this does not work, dont' know why
urlread 'http://147.32.84.120/komar2/komar.cgi?refresh=100&size=20&accel=300&asize=25';


%% Start the hunter

start(vid);
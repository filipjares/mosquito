% init variables used for logging

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
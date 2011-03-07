%% Pripravit kameru

vid = videoinput('winvideo',1,'Y800_1280x960');
%vid = videoinput('winvideo',1,'Y800_640x480');

% zmenit vlastnosti obrazu jde bud rucne
% inspect(getselectedsource(vid));
% nebo pres skript pomoci 
% set(getselectedsource(vid), 'PropertyName', 'PropertyValue');

%% zahajeni nekonecneho video streamu
set(vid,'TriggerRepeat',Inf);
vid.FrameGrabInterval = 1;
start(vid);

%% Cist data

im = getdata(vid,1); % precteni snimku z bufferu

im_debay(:,:,1) = im(2:2:end,1:2:end);
im_debay(:,:,2) = im(1:2:end,1:2:end)/2 + im(2:2:end,2:2:end)/2;
im_debay(:,:,3) = 6.5 * im(1:2:end,2:2:end);

%% Inicializace Pan-Tilt jednotky:

ser = serial('COM1');
set(ser,'BaudRate',57600);
fopen(ser);

%% Pohyb Pan-Tilt jednotky:

ptmove(ser, 127, 127); % 127, 127 je zhruba centralni pozice

%% Zastaveni logovani dat z kamery

stop(vid);

%% Smazani objektu kamery

delete(vid);

%% Uklid spojeni s Pan-Tilt jednotkou

fclose(ser);
delete(ser);


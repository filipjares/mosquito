function [position, current] = smove(ser, speed, pantilt, pos)
    % Low-level function to tell one single pan-tilt unit servo drive
    % to move to position specified by pos using the speed (0 for the
    % highest speed, 4 for the lowest), drive is selected using the
    % argument pantilt (0 for pan, 1 for tilt).
    %
    % It returns position and current returned by the controller.

    b1 = uint8(hex2dec('ff'));
    b2 = uint8(bitshift(uint8(speed), 5) + uint8(pantilt));
    b3 = min(max(uint8(pos), uint8(0)), uint8(254));
    b4 = uint8(bitand(bitxor(b2, b3), uint8(hex2dec('7f'))));
    fwrite(ser, [b1 b2 b3 b4]);
    response = fread(ser, 2);
    position = response(2);
    current = response(1);
end
function ssyncmove(ser, speed, panpos, tiltpos)
    % Low-level function to tell the pan-tilt unit to
    % move to position specified by panpos, tiltpos
    % using the speed (0 for the highest, 4 for the lowest).
    % Moves both drives simultaneously.

    b1 = uint8(hex2dec('ff'));
    b2 = uint8(bitshift(uint8(speed), 5) + uint8(31));
    b3 = uint8(2); % last motor id (it does not work with 1 here (?))
    b4 = min(max(uint8(panpos), uint8(0)), uint8(254));
    b5 = min(max(uint8(tiltpos), uint8(0)), uint8(254));
    b6 = uint8(bitand(bitxor(b4, b5), uint8(hex2dec('7f'))));
    fwrite(ser, [b1 b2 b3 b4 b5 b6]);
end
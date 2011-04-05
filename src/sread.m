function [position, current] = sread(ser, pantilt)
    % Low-level function to read the current position of the
    % pan-tilt unit. The pantilt parameter specifies whether
    % you are interested in pan (0) or tilt (1) drive position.

    b1 = uint8(hex2dec('ff'));
    b2 = uint8(bitshift(uint8(5), 5) + uint8(pantilt));
    b3 = uint8(0);
    b4 = uint8(bitand(bitxor(b2, b3), uint8(hex2dec('7f'))));
    fwrite(ser, [b1 b2 b3 b4]);
    response = fread(ser, 2);
    position = response(2);
    current = response(1);
end
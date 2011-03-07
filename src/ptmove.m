function ptmove(ser, pan_pos, tilt_pos, speed)
    if nargin<4
        speed = 3;
    end

    sermove(ser, speed, 0, pan_pos);
    sermove(ser, speed, 1, tilt_pos);
end

function sermove(ser, speed, pantilt, pos)
    b1 = uint8(hex2dec('ff'));
    b2 = uint8(bitshift(uint8(speed), 5) + uint8(pantilt));
    b3 = min(max(uint8(pos), uint8(0)), uint8(254));
    b4 = uint8(bitand(bitxor(b2, b3), uint8(hex2dec('7f'))));
    fwrite(ser, [b1 b2 b3 b4]);
end

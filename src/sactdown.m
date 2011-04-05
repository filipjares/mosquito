function [position, current] = sactdown(ser, pantilt)
    % This low-level fuction should remove torque of
    % specified motor, which should then move due to
    % external force. It does not work as expected.

    b1 = uint8(hex2dec('ff'));
    b2 = uint8(bitshift(uint8(6), 5) + uint8(pantilt));
    b3 = uint8(bitshift(uint8(1), 4));
    b4 = uint8(bitand(bitxor(b2, b3), uint8(hex2dec('7f'))));
    fwrite(ser, [b1 b2 b3 b4]);
    response = fread(ser, 2);
    position = response(2);
    current = response(1);
end
function ptmove(ser, pan_pos, tilt_pos, speed)
    if nargin<4
        speed = 3;
    end

    % smove(ser, speed, 0, pan_pos);
    % smove(ser, speed, 1, tilt_pos);
    
    % this call could be faster:
    ssyncmove(ser, speed, pan_pos, tilt_pos);
end

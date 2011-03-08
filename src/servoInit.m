function ser = servoInit()

    % TODO: test whether port is open, ...
    
    ser = serial('COM1');
    set(ser,'BaudRate',57600);
    fopen(ser);

end
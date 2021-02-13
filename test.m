clear all
% configuration
port = serialport('COM3',9600);
for i = 1:100
    i
    if (mod(i,5) ==0)
        write(port,i,'uint8');
        data = readline(port)
    end
    pause(0.2)
end


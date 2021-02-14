clear all
% add path
addpath('.\tools');

% configuration
port = serialport('COM3',9600);
duration = 0.2;

for i = 1:100
    if (mod(i,5) ==0)
        i
        writeline(port, '$01,SETM,100,100,100,150,100,255');
        raw_gps_data = readline(port)
    end
    pause(0.2)
end


clear all
% configuration
port = serialport('COM3',9600);
configureTerminator(port,"CR/LF");
flush(port);


configureCallback(port,"terminator",@readData);
pause(10)
configureCallback(port,"off");

function readData(src, ~)
persistent i;
if isempty(i)
        i = 0;
end
data = readline(src)
i = i+1;

end
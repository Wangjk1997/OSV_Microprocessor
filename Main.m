% clear all
% add path
addpath('.\tools');
addpath('.\eventHandler');
% configuration
% global port;
global duration;

% port = serialport('COM3',9600);
duration = 0.2;
time = 10;

t = timer;
t.ExecutionMode = 'fixedRate';
t.Period = 0.2;
t.TasksToExecute = time/duration;
t.TimerFcn = @event_handler;
start(t);




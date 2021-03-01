clear all
% add path
addpath('.\tools');
addpath('.\eventHandler');
% configuration
global duration;
global stateHistory;
global rawdataHistory;
global fHistory;
global duty_cyclesHistory;

stateHistory = [];
rawdataHistory = [];
fHistory = [];
duty_cyclesHistory = [];
duration = 0.2;
time = 35;

t = timer;
t.ExecutionMode = 'fixedRate';
t.Period = duration;
t.TasksToExecute = time/duration;
t.TimerFcn = @event_handler;
% t.TimerFcn = @event_handler_test;
start(t);

tmp = clock;
filename = ".\data\workspace" +num2str(tmp(2))+num2str(tmp(3))+num2str(tmp(4))+num2str(tmp(5));
save(filename);
disp('Control End' )




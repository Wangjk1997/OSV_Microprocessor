clear all
% add path
addpath('.\tools');
addpath('.\eventHandler');
% configuration
global duration;
global pxHistory;
global pyHistory;
global yawHistory;
global rawdataHistory;
global duty_cyclesHistory;

pxHistory = [];
pyHistory = [];
yawHistory = [];
rawdataHistory = [];
fHistory = [];
duty_cyclesHistory = [];
duration = 0.1;
time = 25;

t = timer;
t.ExecutionMode = 'fixedRate';
t.Period = duration;
t.TasksToExecute = time/duration;
t.TimerFcn = @event_handler;
% t.TimerFcn = @event_handler_test;
t.StopFcn = @save_workspace;
start(t);




clear all
% add path
addpath('.\tools');
addpath('.\eventHandler');
% configuration
global duration;
global stateHistory;
global rawdataHistory;

stateHistory = [];
rawdataHistory = [];
duration = 0.2;
time = 20;

t = timer;
t.ExecutionMode = 'fixedRate';
t.Period = 0.2;
t.TasksToExecute = time/duration;
t.TimerFcn = @event_handler;
% t.TimerFcn = @event_handler_test;
start(t);




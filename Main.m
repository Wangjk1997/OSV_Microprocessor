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
global axHistory;
global ayHistory;
global omegaHistory;

pxHistory = [];
pyHistory = [];
yawHistory = [];
rawdataHistory = [];
duty_cyclesHistory = [];
axHistory = [];
ayHistory = [];
omegaHistory = [];

duration = 0.01;
time = 25;

t = timer;
t.ExecutionMode = 'fixedRate';
t.Period = duration;
t.TasksToExecute = time/duration;
t.TimerFcn = @event_handler;
% t.TimerFcn = @event_handler_test;
t.StopFcn = @save_workspace;
start(t);




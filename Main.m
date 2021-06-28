
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
global port;

pxHistory = [];
pyHistory = [];
yawHistory = [];
rawdataHistory = [];
duty_cyclesHistory = [];
axHistory = [];
ayHistory = [];
omegaHistory = [];

duration = 0.05;
time = 180;

t = timer;
t.ExecutionMode = 'fixedRate';
t.Period = duration;
t.TasksToExecute = time/duration;
t.TimerFcn = @event_handler;
% t.TimerFcn = @event_handler_test;
t.StopFcn = @save_workspace;
start(t);
delete t;



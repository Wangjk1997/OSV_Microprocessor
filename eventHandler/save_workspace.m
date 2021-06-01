function save_workspace(~,~)
    global pxHistory;
    global pyHistory;
    global yawHistory;
    global rawdataHistory;
    global duty_cyclesHistory;
    global axHistory;
    global ayHistory;
    global omegaHistory;
    global port;
    global duration;
    
    
%     px_history = pxHistory;
%     py_history = pyHistory;
%     yaw_history =  yawHistory;
%     rawdata_history =  rawdataHistory;
%     dutycycle_history =  duty_cyclesHistory;
    pxHistory;
    pyHistory;
    yawHistory;
    rawdataHistory;
    duty_cyclesHistory;
    axHistory;
    ayHistory;
    omegaHistory;
    
    % save workspace
    tmp = clock;
    filename = ".\data\workspace" +num2str(tmp(2))+num2str(tmp(3))+num2str(tmp(4))+num2str(tmp(5));
    save(filename);
    
    % turn off thrusters
    command_string = '$01,SETM,255,255,255,255,255,255';
    writeline(port, command_string);
    
    % plot figures
    figure(1);
    plot((1:length(pxHistory)) * duration, pxHistory);
    title("px");
    
    figure(2);
    plot((1:length(pyHistory)) * duration, pyHistory);
    title("py");
    
    figure(3);
    plot((1:length(yawHistory)) * duration, yawHistory);
    title("yaw");
    
    figure(4);
    plot((1:length(axHistory)) * duration, axHistory);
    title("ax");
    
    figure(5);
    plot((1:length(ayHistory)) * duration, ayHistory);
    title("ay");
    
    figure(6);
    plot((1:length(omegaHistory)) * duration, omegaHistory);
    title("omega")
    
    disp('Control End' )
end
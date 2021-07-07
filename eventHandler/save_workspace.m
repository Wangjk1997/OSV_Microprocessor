function save_workspace(~,~)
    global pxHistory;
    global pyHistory;
    global pxHistory_GPS;
    global pyHistory_GPS;
    global yawHistory;
    global rawdataHistory;
    global duty_cyclesHistory;
    global axHistory;
    global ayHistory;
    global omegaHistory;
    global port;
    global duration;
    
    pxHistory;
    pyHistory;
    pxHistory_GPS;
    pyHistory_GPS;
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
    p1 = plot((1:length(pxHistory)) * duration, pxHistory);
    hold on
    p2 = plot((1:length(pxHistory_GPS)) * duration, pxHistory_GPS);
    title("Position in x direction")
    xlabel("time/s")
    ylabel("position/m")
%     legend([p1,p2],{'Data from the GPS','Data from data fusion'})
    
    figure(2);
    p3 = plot((1:length(pyHistory)) * duration, pyHistory);
    hold on
    p4 = plot((1:length(pyHistory_GPS)) * duration, pyHistory_GPS);
    title("Position in y direction");
    xlabel("time/s")
    ylabel("position/m")
%     legend([p3,p4],{'Data from the GPS','Data from data fusion'})
    
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
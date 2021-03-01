function save_workspace(~,~)
    global pxHistory;
    global pyHistory;
    global yawHistory;
    global rawdataHistory;
    global fHistory;
    global duty_cyclesHistory;
    
    px_history = pxHistory;
    py_history = pyHistory;
    yaw_history =  yawHistory;
    rawdata_history =  rawdataHistory;
    f_history =  fHistory;
    dutycycle_history =  duty_cyclesHistory;
    tmp = clock;
    filename = ".\data\workspace" +num2str(tmp(2))+num2str(tmp(3))+num2str(tmp(4))+num2str(tmp(5));
    save(filename);
    disp('Control End' )
end
function event_handler_test(~,~)
    global duration;
    global stateHistory;
    global rawdataHistory;
    
    persistent port;
    persistent currentState;
    persistent pid_px_gn_n;
    persistent pid_py_gn_n;
    persistent pid_yaw;
    persistent ref_px_gn_n;
    persistent ref_py_gn_n;
    persistent ref_yaw;
    persistent animation_frame_left;
    persistent animation_frame_right;
    persistent command_string;
    
    %Sending command and receiving GPS data
    %Initialized first command
    if(isempty(command_string))
        command_string = '$01,SETM,100,100,100,100,100,100';
        port = serialport("COM3",230400);
        return;
    end
    writeline(port, command_string);
    raw_gps_data = readline(port);
    rawdataHistory = [rawdataHistory; raw_gps_data];
    position = location(raw_gps_data);
    px_left = position(1);
    py_left = position(2);
    pz_left = position(3);
    px_right = position(4);
    py_right = position(5);
    pz_right = position(6);
    
    if(isempty(currentState))
        currentState = RigidBodyState_plane(duration, px_left, py_left, px_right, py_right);
        animation_frame_left = animatedline('Marker', 'o', 'color', 'b', 'LineStyle', 'none', 'MaximumNumPoints', 1);
        animation_frame_right = animatedline('Marker', 'o', 'color', 'r', 'LineStyle', 'none', 'MaximumNumPoints', 1);
        axis([-3,3,-3,3]);
        xlim manual;
        xlabel('North');
        ylabel('East');
        return;
    end
    
    %update rigidbody state
    currentState = RigidBodyState_plane(duration, px_left, py_left, px_right, py_right, currentState);
    stateHistory = [stateHistory, currentState];
    
    % plot real time positions
    addpoints(animation_frame_left, px_left, py_left);
    addpoints(animation_frame_right, px_right, py_right);
    drawnow;
end
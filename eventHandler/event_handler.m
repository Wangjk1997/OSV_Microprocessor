function event_handler(~,~)
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
    persistent frame_index;
    
    %Sending command and receiving GPS data
    %Initialized first command
    if(isempty(frame_index))
        frame_index = 1;
        command_string = '$01,SETM,255,255,255,255,255,255';
        port = serialport("COM3",230400);
        return;
    end
    frame_index = frame_index + 1;
    writeline(port, command_string);
    raw_gps_data = readline(port);
    rawdataHistory = [rawdataHistory; raw_gps_data];
    position = location(raw_gps_data, 1);
%     position = location_original(raw_gps_data);
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
        axis([-5,5,-5,5]);
        xlim manual;
        return;
    end
    
    %update rigidbody state
    currentState = RigidBodyState_plane(duration, px_left, py_left, px_right, py_right, currentState);
    stateHistory = [stateHistory, currentState];
    
%     % calculate force
%     user_tau=[ux;uy;uz;0;0;tz];
%     tau=actuation_vector_saturation(user_tau);
%     % mixer: convert control effort to thrust
%     f = mixer_positive(tau);
%     % convert force to duty cycle
%     duty_cycles=thrust2dutyCycle(f);
%     % check that the duty cycle generated is in the boundary of [-1, 1]
%     duty_cycles=duty_cycle_saturation(duty_cycles);
%     % Map to actual direction and order of the motors in our physical
%     % installation
%     duty_cycles = direction_and_order_mapping(duty_cycles);
%     command_string = "$01,SETM,"+ tmp + ',' + tmp + ',' + tmp + ',' + tmp + ",255,255";
    
    % plot real time positions
    addpoints(animation_frame_left, px_left, py_left);
    addpoints(animation_frame_right, px_right, py_right);
    drawnow;
end
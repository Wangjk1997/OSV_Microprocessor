function event_handler(~,~)
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
    
    persistent currentState;
    persistent pid_px_bn_n;
    persistent pid_py_bn_n;
    persistent pid_yaw;
    persistent ref_px_bn_n;
    persistent ref_py_bn_n;
    persistent ref_yaw;
%     persistent animation_frame_left;
%     persistent animation_frame_right;
    persistent command_string;
    persistent frame_id;
    
    %send command and receivie GPS data
    %initialize first command
    if(isempty(frame_id))
        frame_id = 1;
        command_string = '$01,SETM,255,255,255,255,255,255';
        port = serialport("COM3",230400);
        return;
    end
    if(frame_id < 15)
        readline(port);
        frame_id = frame_id + 1;
        return;
    end
    writeline(port, command_string);
    raw_data = readline(port);
    rawdataHistory = [rawdataHistory; raw_data];
    [gps_data, IMU_data] = rawDataProcessing(raw_data);
    
    position = location(gps_data, 0.57);
    
    px_left = position(1);
    py_left = position(2);
    pz_left = position(3);
    px_right = position(4);
    py_right = position(5);
    pz_right = position(6);
    
    ax = IMU_data(2);
    ay = IMU_data(1);
    omega = IMU_data(6);
    
    if(isempty(currentState))
        currentState = RigidBodyState_plane(duration, px_left, py_left, px_right, py_right);
        %initialize reference
        ref_px_bn_n = currentState.p_bn_n(1);
        ref_py_bn_n = currentState.p_bn_n(2);
        ref_yaw = currentState.psi;

        %initialize PID parameters and controllers
        kp_px_bn_n = 0.2;
        ki_px_bn_n = 0;
        kd_px_bn_n = 0.2;
        
        kp_py_bn_n = 0.2;
        ki_py_bn_n = 0;
        kd_py_bn_n = 0.2;
        
        kp_yaw = 0.089/50;
        ki_yaw = 0;
        kd_yaw = 0.009/50;
%         kp_yaw = 0;
%         ki_yaw = 0;
%         kd_yaw = 0;
        
        pid_px_bn_n = PIDController(kp_px_bn_n, ki_px_bn_n, kd_px_bn_n, duration, 0.4, -0.4);
        pid_py_bn_n = PIDController(kp_py_bn_n, ki_py_bn_n, kd_py_bn_n, duration, 0.4, -0.4);
        pid_yaw = PIDController(kp_yaw, ki_yaw, kd_yaw,duration, 0.2, -0.2);
      

        % initialize Kalman Filter for yaw angle
        
        
%         % plotting settings
%         animation_frame_left = animatedline('Marker', 'o', 'color', 'b', 'LineStyle', 'none', 'MaximumNumPoints', 1);
%         animation_frame_right = animatedline('Marker', 'o', 'color', 'r', 'LineStyle', 'none', 'MaximumNumPoints', 1);
%         axis([-5,5,-5,5]);
%         axis equal;
%         xlim manual;
%         xlabel('North');
%         ylabel('East');
        return;
    end
    
    % update rigidbody state
    currentState = RigidBodyState_plane(duration, px_left, py_left, px_right, py_right, currentState);
    
    % update PID Controller
    [pid_px_bn_n, duty_px] = pid_px_bn_n.calculate(ref_px_bn_n - currentState.p_bn_n(1));
    [pid_py_bn_n, duty_py] = pid_py_bn_n.calculate(ref_py_bn_n - currentState.p_bn_n(2));
    [pid_yaw, duty_tz] = pid_yaw.calculate((ref_yaw - currentState.psi) * 180/pi);
    
    % update Log
    pxHistory = [pxHistory, currentState.p_bn_n(1)];
    pyHistory = [pyHistory, currentState.p_bn_n(2)];
    yawHistory = [yawHistory, currentState.psi];
    axHistory = [axHistory, ax];
    ayHistory = [ayHistory, ay];
    omegaHistory = [omegaHistory, omega];
    
    % convert force and torque to cmd
    duty_cycle_PID = [duty_px;duty_py;0;0;0;duty_tz];
    duty_cycle = mixer_positive_dutyCycle(duty_cycle_PID);
    duty_cycle = duty_cycle_saturation(duty_cycle);
    command_string = convertCMD(duty_cycle);
    duty_cyclesHistory = [duty_cyclesHistory, duty_cycle];
    

%     % plot real time positions
%     addpoints(animation_frame_left, px_left, py_left);
%     addpoints(animation_frame_right, px_right, py_right);
%     drawnow;
    
    % update frame id
    frame_id = frame_id + 1;
end
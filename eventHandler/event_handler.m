function event_handler(~,~)
    global duration;
    global stateHistory;
    global rawdataHistory;
    global fHistory;
    global duty_cyclesHistory;
    
    persistent port;
    persistent currentState;
    persistent pid_px_bn_n;
    persistent pid_py_bn_n;
    persistent pid_yaw;
    persistent ref_px_bn_n;
    persistent ref_py_bn_n;
    persistent ref_yaw;
    persistent animation_frame_left;
    persistent animation_frame_right;
    persistent command_string;
    
    %send command and receivie GPS data
    %initialize first command
    if(isempty(command_string))
        command_string = '$01,SETM,255,255,255,255,255,255';
        port = serialport("COM3",230400);
        return;
    end
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
        %initialize reference
        ref_px_bn_n = currentState.p_bn_n(1);
        ref_py_bn_n = currentState.p_bn_n(2);
        ref_yaw = currentState.psi;
%         ref_px_bn_n = 0.5;
%         ref_py_bn_n = 1;
%         ref_yaw = 0;
        
        %initialize PID parameters and controllers
        kp_px_bn_n = 0.02;
        ki_px_bn_n = 0;
        kd_px_bn_n = 0;
        
        kp_py_bn_n = 0.02;
        ki_py_bn_n = 0;
        kd_py_bn_n = 0;
        
        kp_yaw = 0.0089/50;
        ki_yaw = 0;
        kd_yaw = 0.01/50;
        
        pid_px_bn_n = PIDController(kp_px_bn_n, ki_px_bn_n, kd_px_bn_n, duration, 0.0594*0.8*sqrt(2), -0.0594*0.8*sqrt(2));
        pid_py_bn_n = PIDController(kp_py_bn_n, ki_py_bn_n, kd_py_bn_n, duration, 0.0594*0.8*sqrt(2), -0.0594*0.8*sqrt(2));
        pid_yaw = PIDController(kp_yaw, ki_yaw, kd_yaw,duration, 0.0594*2*0.053*0.2, -0.0594*2*0.053*0.2);
      
        % plotting settings
        animation_frame_left = animatedline('Marker', 'o', 'color', 'b', 'LineStyle', 'none', 'MaximumNumPoints', 1);
        animation_frame_right = animatedline('Marker', 'o', 'color', 'r', 'LineStyle', 'none', 'MaximumNumPoints', 1);
        axis([-5,5,-5,5]);
        axis equal;
        xlim manual;
        xlabel('North');
        ylabel('East');
        return;
    end
    
    % update rigidbody state
    currentState = RigidBodyState_plane(duration, px_left, py_left, px_right, py_right, currentState);
    stateHistory = [stateHistory, currentState];
    
    % updata PID Controller
    [pid_px_bn_n, ux] = pid_px_bn_n.calculate(ref_px_bn_n - currentState.p_bn_n(1));
    [pid_py_bn_n, uy] = pid_py_bn_n.calculate(ref_py_bn_n - currentState.p_bn_n(2));
    [pid_yaw, tz] = pid_yaw.calculate((ref_yaw - currentState.psi) * 180/pi);
    X = currentState.p_bn_n(1);
    Y = currentState.p_bn_n(2);
    PSI = currentState.psi;
    
    % convert force and torque to cmd
    user_tau = [ux;uy;0;0;0;tz];
    tau = actuation_vector_saturation(user_tau);
    f = mixer_positive(tau)
    duty_cycles = thrust2dutyCycle(f);
    duty_cycles = duty_cycle_saturation(duty_cycles);
    command_string = convertCMD(duty_cycles);
    fHistory = [fHistory, f];
    duty_cyclesHistory = [duty_cyclesHistory, duty_cycles];
    
    
    % plot real time positions
    addpoints(animation_frame_left, px_left, py_left);
    addpoints(animation_frame_right, px_right, py_right);
    drawnow;
end
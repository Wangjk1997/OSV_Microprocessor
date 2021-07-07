function event_handler(~,~)
    global duration;
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
    
    persistent currentState;
    persistent pid_px_bn_n;
    persistent pid_py_bn_n;
    persistent pid_yaw;
    persistent ref_px_bn_n;
    persistent ref_py_bn_n;
    persistent ref_yaw;
    persistent KF_x;
    persistent KF_y;
    persistent command_string;
    persistent frame_id;
    
    %send command and receivie GPS data
    %initialize first command
    if(isempty(frame_id))
        frame_id = 1;
        command_string = '$01,SETM,255,255,255,255,255,255';
        return;
    end
    if(frame_id < 15)
        command_string = '$01,SETM,255,255,255,255,255,255';
        writeline(port, command_string);
        readline(port);
        frame_id = frame_id + 1;
        return;
    end
    writeline(port, command_string);
    raw_data = readline(port);
    rawdataHistory = [rawdataHistory; raw_data];
    
    [gps_data, IMU_data] = rawDataProcessing(raw_data);
    
    position = location(gps_data);
    
    px_GPS = position(1);
    py_GPS = position(2);
    pz_GPS = position(3);
    
    ax = IMU_data(2);
    ay = IMU_data(1);
    omega = IMU_data(4);
    % Mapping [0,360) to [-180,180);
    if (IMU_data(7) > 180 && IMU_data(7) < 360)
        theta = (IMU_data(7) - 360);
    else
        theta = IMU_data(7);
    end
    
    % Initialization
    if(isempty(currentState))
        currentState = RigidBodyState_plane(duration, px_GPS, py_GPS, theta);
        %initialize reference
        ref_px_bn_n = currentState.p_bn_n(1);
        ref_py_bn_n = currentState.p_bn_n(2);
        ref_yaw = currentState.theta;

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
      

        % initialize Kalman Filter
        A = [1, duration; 0, 1];
        B = [(duration^2)/2; duration];
        H = [1,0];
        q = 1;
        Q = [q*(duration^3)/3, q*(duration^2)/2;q*(duration^2)/2, q*duration];
        r = 0.05;
        R = r/duration;
%         KF_x = KalmanFilter(A, B, Q, R, H, [currentState.p_bn_n(1);0], [0,0;0,0]);
%         KF_y = KalmanFilter(A, B, Q, R, H, [currentState.p_bn_n(2);0], [0,0;0,0]);
        KF_x = KalmanFilter(A, B, Q, R, H, [0;0], [0,0;0,0]);
        KF_y = KalmanFilter(A, B, Q, R, H, [0;0], [0,0;0,0]);
        return;
    end
    
    % update Kalman Filter
    KF_x = KF_x.time_update(ax);
    KF_y = KF_y.time_update(ay);
    if (mod(frame_id, 2) == 0)
        KF_x = KF_x.measurement_update(px_GPS);
        KF_y = KF_y.measurement_update(py_GPS);
    end
    
    % update rigidbody state
    currentState = RigidBodyState_plane(duration,KF_x.x(1), KF_y.x(1), theta, currentState);
    
    % update PID Controller
    [pid_px_bn_n, duty_px] = pid_px_bn_n.calculate(ref_px_bn_n - currentState.p_bn_n(1));
    [pid_py_bn_n, duty_py] = pid_py_bn_n.calculate(ref_py_bn_n - currentState.p_bn_n(2));
    [pid_yaw, duty_tz] = pid_yaw.calculate((ref_yaw - currentState.theta) * 180/pi);
    
    % update Log
    pxHistory_GPS = [pxHistory_GPS, px_GPS];
    pyHistory_GPS = [pyHistory_GPS, py_GPS];
    pxHistory = [pxHistory, currentState.p_bn_n(1)];
    pyHistory = [pyHistory, currentState.p_bn_n(2)];
    yawHistory = [yawHistory, currentState.theta];
    axHistory = [axHistory, ax];
    ayHistory = [ayHistory, ay];
    omegaHistory = [omegaHistory, omega];
    
    % convert force and torque to cmd
    duty_cycle_PID = [duty_px;duty_py;0;0;0;duty_tz];
    duty_cycle = mixer_positive_dutyCycle(duty_cycle_PID);
    duty_cycle = duty_cycle_saturation(duty_cycle);
    command_string = convertCMD(duty_cycle);
    duty_cyclesHistory = [duty_cyclesHistory, duty_cycle];
    
    % update frame id
    frame_id = frame_id + 1;
end
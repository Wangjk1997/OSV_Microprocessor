function event_handler(~,~)
    global port;
    
    persistent currentState;
    persistent pid_px_gn_n;
    persistent pid_py_gn_n;
    persistent pid_yaw;
    persistent ref_px_gn_n;
    persistent ref_py_gn_n;
    persistent ref_yaw;
    persistent animation_frame_left;
    persistent animation_frame_right;
    
    
    %Sending command and receiving GPS data
    command_string = '$01,SETM,255,255,255,255,255,255';
    writeline(port, command_string);
    raw_gps_data = readline(port);
%     [px_left, py_left, pz_left, px_right, py_right, pz_right] = location(raw_gps_data);
    position = location(raw_gps_data)
    px_left = position(1);
    py_left = position(2);
    pz_left = position(3);
    px_right = position(4);
    py_right = position(5);
    pz_right = position(6);
    disp(datetime(now,'ConvertFrom','datenum'));
    
    if(isempty(animation_frame_left))
%         figure(1)
        animation_frame_left = animatedline('Marker', 'o', 'color', 'b', 'LineStyle', 'none', 'MaximumNumPoints', 5);
        animation_frame_right = animatedline('Marker', 'o', 'color', 'r', 'LineStyle', 'none', 'MaximumNumPoints', 5);
        axis([-10,10,-10,10]);
        xlim manual;
    end
    addpoints(animation_frame_left, px_left, py_left);
    addpoints(animation_frame_right, px_right, py_right);
    drawnow;
end
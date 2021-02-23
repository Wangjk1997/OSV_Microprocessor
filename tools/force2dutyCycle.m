function dutyCycle = force2dutyCycle(force)
    % use the latest thrust measurements
    % thrust map for z direction
    d_z = [-1;
        -.8;
        -.6;
        -.4;
        -.2;
        0;
        .2;
        .4;
        .6;
        .8;
        1
        ];
    f_z = 9.8 * 0.001 * [-1.87;
        -1.43;
        -0.991;
        -0.551;
        -0.11;
        0;
        .22;
        1.1;
        2.2;
        3.3;
        4.63];
    % thrust map for xy plane
    d_xy = [0,.2,.3,.4,.5,.6,.7,.8,.9,1];
    f_xy = 9.8 * 0.001 * [0,0.33,0.771,1.43,2.09,2.75,3.52,4.52,5.18,6.06];
    % clip force into the boundary boundary defined by our measurements
    force_xy = force(1:4);
    force_z = force(5:6);
    force_z_limited = max(min(force_z, ones(2,1)*max(f_z)), ones(2,1)*min(f_z));
    force_xy_limited = max(min(force_xy, ones(4,1)*max(f_xy)), ones(4,1)*min(f_xy));
    dutyCycle_xy = interp1(f_xy,d_xy,force_xy_limited);
    dutyCycle_z = interp1(f_z,d_z,force_z_limited);
    dutyCycle = [dutyCycle_xy; dutyCycle_z];
end

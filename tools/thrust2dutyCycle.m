function dutyCycle = thrust2dutyCycle(tau)
%% Function for convert thrust to corresponding duty cycles according to our measurements
% INPUT: force --6 by 1 vector containing the thrust required for each motor: [F1,F2,F3,F4,F5,F6]
%       --F1: thrust required for motor 1, in Newton (N), upper-right motor in x-y plane
%       --F2: thrust required for motor 2, in Newton (N), lower-right motor in x-y plane
%       --F3: thrust required for motor 3, in Newton (N), lower-left motor in x-y plane
%       --F4: thrust required for motor 4, in Newton (N), upper-left motor in x-y plane
%       --F5: thrust required for motor 5, in Newton (N), right vertical
%       motor
%       --F6: thrust required for motor 6, in Newton (N), left vertical
%       motor
%
% OUTPUT: dutyCycle --6 by 1 vector containing the duty cycle for each
% motor: [d1, d2, d3, d4, d5, d6]
%       --d1: duty cycle count required for motor 1, 0<d1<250
%       --d2: duty cycle count required for motor 2, 0<d2<250
%       --d3: duty cycle count required for motor 3, 0<d3<250
%       --d4: duty cycle count required for motor 4, 0<d4<250
%       --d5: duty cycle count required for motor 5, 0<d5<250
%       --d6: duty cycle count required for motor 6, 0<d6<250
%
% Use example: dutyCycle = force2dutyCycle(tau)

    %% Define measurements for vertical (z axis) and horizontal (x-y plane) thrusters
    
    % duty cycle for vertical thrusters
    d_z = [-1;-.8;-.6;-.4;-.2;0;.2;.4;.6;.8;1];
    
    % measured thrust for vertical thrusters, in Newton (N)
    f_z = 9.8 * 0.001 * [-1.87;-1.43;-0.991;-0.551;-0.11;0;.22;1.1;2.2;3.3;4.63];

    % duty cycle for horizontal thrusters
    d_xy = [0,.2,.3,.4,.5,.6,.7,.8,.9,1];
    
    % measured thrust for horizontal thrusters, in Newton (N)
    f_xy = 9.8 * 0.001 * [0,0.33,0.771,1.43,2.09,2.75,3.52,4.52,5.18,6.06];

    %% Extract all thrust values for horizontal (motor 1-4) and vertical (motor 5-6) thrusters
    % force_xy is a 4 by 1 array containing all required thrust for horizontal motors
    force_xy = tau(1:4);
    
    % force_z is a 2 by 1 array containing all required thrust for vertical motors 
    force_z = tau(5:6);
    
    %% clip force into the boundary boundary defined by our measurements
    force_z_limited = max(min(force_z, ones(2,1)*max(f_z)), ones(2,1)*min(f_z));
    force_xy_limited = max(min(force_xy, ones(4,1)*max(f_xy)), ones(4,1)*min(f_xy));
    
    %% convert duty cycle to thrust by linear interpolation of our measurements
    dutyCycle_xy = interp1(f_xy,d_xy,force_xy_limited);
    dutyCycle_z = interp1(f_z,d_z,force_z_limited);
    
    %% Return the resulta after the conversion
    dutyCycle = [dutyCycle_xy; dutyCycle_z];
end

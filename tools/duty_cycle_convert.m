function duty_cycle = duty_cycle_convert(duty_cycle_PID)
%% Function for converting the duty cycle calculated by PID controller to the duty cycle used by each motor.
% INPUT = duty cycle calculated by PID controller in form [fx,fy,fz,tx,ty,tz]
% fx belongs to [-0.8, 0.8];
% fy belongs to [-0.8, 0.8];
% fz equals 0;
% tx equals 0;
% ty equals 0;
% tz belongs to [-0.2, 0.2];

% OUTPUT = duty cycle for each motor in form [d1,d2,d3,d4,d5,d6]
% d1 duty cycle for motor 1
% d2 duty cycle for motor 2
% d3 duty cycle for motor 3
% d4 duty cycle for motor 4
% d5 duty cycle for motor 5
% d6 duty cycle for motor 6

d1 = 0;
d2 = 0;
d3 = 0;
d4 = 0;
d5 = 0;
d6 = 0;
if(fx > 0)
    d2 = d2 + abs(fx)
    d
else
    
end

end
function cmd = convertCMD(duty_cycles)
% INPUT: duty_cycles --6 by 1 vector representing the duty cycle for each
% motor: [d1, d2, d3, d4, d5, d6]
%       --d1: duty cycle count required for motor 1, -1<d1<1
%       --d2: duty cycle count required for motor 2, -1<d2<1
%       --d3: duty cycle count required for motor 3, -1<d3<1
%       --d4: duty cycle count required for motor 4, -1<d4<1
%       --d5: duty cycle count required for motor 5, -1<d5<1
%       --d6: duty cycle count required for motor 6, -1<d6<1
% OUTPUT: cmd -- a string in format: '$01,SETM,255,255,255,255,255,255'
%       each value should be a integer belong to [0, 511].
    cmd = '$01,SETM';
    for i = 1:6
        motor_value = floor(duty_cycles(i) * 256 + 256);
        cmd = cmd + ',' + motor_value;
    end
end
function duty_cycles = duty_cycle_saturation(duty_cycles)
%% Function to make sure duty cycles fall in the range of [-1,1]
% INPUT: duty_cycles --6 by 1 vector representing the required
% duty cycle for each motor: [d1, d2, d3, d4, d5, d6]
%       --d1: duty cycle count required for motor 1, 0<d1<250
%       --d2: duty cycle count required for motor 2, 0<d2<250
%       --d3: duty cycle count required for motor 3, 0<d3<250
%       --d4: duty cycle count required for motor 4, 0<d4<250
%       --d5: duty cycle count required for motor 5, 0<d5<250
%       --d6: duty cycle count required for motor 6, 0<d6<250
%
%
% OUTPUT: duty_cycles --6 by 1 vector representing the saturated duty cycle
% vector: [d1, d2, d3, d4, d5, d6]
%       --d1: duty cycle count required for motor 1, 0<d1<250
%       --d2: duty cycle count required for motor 2, 0<d2<250
%       --d3: duty cycle count required for motor 3, 0<d3<250
%       --d4: duty cycle count required for motor 4, 0<d4<250
%       --d5: duty cycle count required for motor 5, 0<d5<250
%       --d6: duty cycle count required for motor 6, 0<d6<250
%
%
%
%% Define the boundary of the duty cycle
duty_cycle_max = [1,1,1,1,1,1]';
duty_cycle_min = [-1,-1,-1,-1,-1,-1]';

%% Make sure the duty cycles stay within the range
duty_cycles = max(duty_cycles, duty_cycle_min);
duty_cycles = min(duty_cycles, duty_cycle_max);
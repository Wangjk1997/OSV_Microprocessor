function duty_cycles = direction_and_order_mapping(duty_cycles)
%% Function for mapping the duty cycles generated to match up with actual directions and orders of motors
% INPUT: duty_cycles --6 by 1 vector representing the duty cycle for each
% motor: [d1, d2, d3, d4, d5, d6]
%       --d1: duty cycle count required for motor 1, -1<d1<1
%       --d2: duty cycle count required for motor 2, -1<d2<1
%       --d3: duty cycle count required for motor 3, -1<d3<1
%       --d4: duty cycle count required for motor 4, -1<d4<1
%       --d5: duty cycle count required for motor 5, -1<d5<1
%       --d6: duty cycle count required for motor 6, -1<d6<1
%
% OUTPUT: duty_cycles --6 by 1 vector representing the duty cycles for each
% motor after direction and order mapping: [d1, d2, d3, d4, d5, d6]
%       --d1: duty cycle count required for motor 1, -1<d1<1
%       --d2: duty cycle count required for motor 2, -1<d2<1
%       --d3: duty cycle count required for motor 3, -1<d3<1
%       --d4: duty cycle count required for motor 4, -1<d4<1
%       --d5: duty cycle count required for motor 5, -1<d5<1
%       --d6: duty cycle count required for motor 6, -1<d6<1
%
%
%% Map to real directions (for all 6 motors, -1 means propelling forward (optimized direction))
% Define the direction mapping matrix
direction_matrix = diag([-1,-1,-1,-1,-1,-1]);


%% Map to real orders
% Motor 1: upper-right horizontal motor in our convention, upper-left horizontal motor in actual
% configuration, corresponds with motor 4 in actual configuration
% Motor 2: lower-right horizontal motor in our convention, upper-right horizontal motor in actual
% configuration, corresponds with motor 1 in actual configuration
% Motor 3: lower-left horizontal motor in our convention, right vertical
% motor in actual configuration, corresponds with motor 5 in actual
% configuration
% Motor 4: upper-left horizontal motor in our convention, left vertical
% motor in actual configuration, corresponds with motor 6 in actual
% configuration
% Motor 5: right vertical motor in our convention, lower-right horizontal
% motor in actual configuration, corresponds with motor 2 in actual
% configuration
% Motor 6: left vertical motor in our convention, lower-left horizontal
% motor in actual configuration, corresponds with motor 3 in actual
% configuration

% Define the order mapping matrix
order_matrix = [0, 0, 0, 1, 0, 0;
                1, 0, 0, 0, 0, 0;
                0, 0, 0, 0, 1, 0;
                0, 0, 0, 0, 0, 1;
                0, 1, 0, 0, 0, 0;
                0, 0, 1, 0, 0, 0];

%% Apply the direction and order mapping accordingly
duty_cycles = order_matrix * direction_matrix * duty_cycles;


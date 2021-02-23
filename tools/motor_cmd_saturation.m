function motor_cmd_duty_cycles = motor_cmd_saturation(motor_cmd_duty_cycles)
duty_cycle_max = [1,1,1,1,1,1]';
duty_cycle_min = [-1,-1,-1,-1,-1,-1]';
motor_cmd_duty_cycles = max(motor_cmd_duty_cycles, duty_cycle_min);
motor_cmd_duty_cycles = min(motor_cmd_duty_cycles, duty_cycle_max);
function motor_cmd_duty_cycles = motor_cmd_mapping(motor_duty_cycles)

mapping_matrix = diag([-1,-1,-1,-1,-1,-1]);
motor_cmd_duty_cycles = mapping_matrix*motor_duty_cycles;
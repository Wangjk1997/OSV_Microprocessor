function duty_cycle = motor_order(duty_cycle)
motor1 = duty_cycle(1);
motor2 = duty_cycle(2);
motor3 = duty_cycle(3);
motor4 = duty_cycle(4);
motor5 = duty_cycle(5);
motor6 = duty_cycle(6);
duty_cycle = [motor4, motor1, motor5, motor6, motor2, motor3]';
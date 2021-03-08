function duty_cycle = mixer_positive_dutyCycle(duty_cycle_PID)
% extract desired control output
fx = duty_cycle_PID(1);
fy = duty_cycle_PID(2);
tz = duty_cycle_PID(6);
% mixer matrix multiplication
d1 = -fx*heaviside(-fx) + fy*heaviside(fy) + tz*heaviside(tz);
d2 = fx*heaviside(fx) + fy*heaviside(fy) - tz*heaviside(-tz);
d3 = fx*heaviside(fx) - fy*heaviside(-fy) + tz*heaviside(tz);
d4 = -fx*heaviside(-fx) - fy*heaviside(-fy) - tz*heaviside(-tz);
duty_cycle = [d1, d2, d3, d4, 0, 0]';

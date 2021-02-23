function f = mixer_positive(tau)
% extract desired control output
fx = tau(1);
fy = tau(2);
fz = tau(3);
tz = tau(6);
dc = 0.053;
% mixer matrix multiplication
f1 = -sqrt(2)/2*fx*heaviside(-fx) + sqrt(2)/2*fy*heaviside(fy) + tz*heaviside(tz)/dc/2;
f2 = sqrt(2)/2*fx*heaviside(fx) + sqrt(2)/2*fy*heaviside(fy) - tz*heaviside(-tz)/dc/2;
f3 = sqrt(2)/2*fx*heaviside(fx) - sqrt(2)/2*fy*heaviside(-fy) + tz*heaviside(tz)/dc/2;
f4 = -sqrt(2)/2*fx*heaviside(-fx) - sqrt(2)/2*fy*heaviside(-fy) - tz*heaviside(-tz)/dc/2;
f5 = -fz/2;
f6 = -fz/2;
f = [f1, f2, f3, f4, f5, f6]';

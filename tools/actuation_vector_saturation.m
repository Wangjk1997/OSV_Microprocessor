function tau = actuation_vector_saturation(user_tau)
% diamond force constraint
% function for constraining user/controller input force by force end loop
% define single motor maximum force
fmax_xy = 0.0594;
fmax_z_up = 0.0454;
fmax_z_down = -0.0183;

thrust_ratio = 0.8; % change if you want to adjust maximum usable thrust
torque_ratio = 0.2; % change if you want to adjust maximum usable thrust
f_max_xy = fmax_xy * thrust_ratio * sqrt(2); % maximum force along x or y direction
f_z_max_up = fmax_z_up*2; % maximum force along -z direction, up
f_z_max_down = fmax_z_down*2; % maximum force along +z direction, down
tau_max =  0.0594 * torque_ratio * 2 * 0.053;
fx = user_tau(1);
fy = user_tau(2);
fz = user_tau(3);
tauz = user_tau(6);

if fy ~= 0
   theta = atan(fx/fy);
else
   theta = 0;
end

% saturation for fx and fy by diamond shape
ratio_xy = sqrt(fx^2 + fy^2) / f_max_xy*(sqrt((cosd(theta))^2 + (1 - cosd(theta))^2));
if ratio_xy > 1
    fx = fx / ratio_xy;
    fy = fy / ratio_xy;
end

% saturation for fz
if fz > 0
    ratio_z = abs(fz / f_z_max_down);
else
    % if fz < 0
    ratio_z = abs(fz / f_z_max_up);
end


if ratio_z > 1
    fz = fz / ratio_z;
end


% saturation for tau_z
ratio_tau = abs(tauz / tau_max);

if ratio_tau > 1
    tauz = tauz / ratio_tau;
end
tau = user_tau;
tau(1) = fx;
tau(2) = fy;
tau(3) = fz;
tau(6) = tauz;

classdef RigidBodyState_plane
    properties
        p_left;
        p_right;
        p_bn_n;
        p_bn_b;
        v_bn_b;
		v_bn_n;
        psi;
        psi_dot;
        R_bn;
        duration; %this should be changed if the samlping frequency is different;
    end
    methods
        function obj = RigidBodyState_plane(duration, px_left, py_left, px_right, py_right, previousState)
            if nargin == 1
                obj.p_left = zeros(2,1);
                obj.p_right = zeros(2,1);
                obj.p_bn_n = zeros(2,1);
                obj.p_bn_b = zeros(2,1);
                obj.v_bn_b = zeros(2,1);
                obj.v_bn_n = zeros(2,1);
                obj.psi = 0;
                obj.psi_dot = 0;
                obj.R_bn = zeros(2,2);
                obj.duration = duration;
            elseif nargin == 5
                obj.p_left = [px_left, py_left]';
                obj.p_right = [px_right, py_right]';
                obj.p_bn_n = (obj.p_left + obj.p_right)/2;
                obj.v_bn_b = zeros(2,1);
                obj.v_bn_n = zeros(2,1);
                obj.psi = atan2((obj.p_right(2) - obj.p_left(2)), (obj.p_right(1) - obj.p_left(1)));
                obj.psi_dot = 0;
                obj.R_bn = [cos(obj.psi), -sin(obj.psi); sin(obj.psi), cos(obj.psi)];
                obj.p_bn_b = obj.R_bn' * obj.p_bn_n;
                obj.duration = duration;
            else
                obj.p_left = [px_left, py_left]';
                obj.p_right = [px_right, py_right]';
                obj.p_bn_n = (obj.p_left + obj.p_right)/2;
                obj.duration = duration;
                obj.psi = atan2((obj.p_right(2) - obj.p_left(2)), (obj.p_right(1) - obj.p_left(1)));
                obj.R_bn = [cos(obj.psi), -sin(obj.psi); sin(obj.psi), cos(obj.psi)];
                obj.p_bn_b = obj.R_bn' * obj.p_bn_n;
                obj.v_bn_n = 1 / obj.duration * (obj.p_bn_n - previousState.p_bn_n);
                obj.v_bn_b = 1 / obj.duration * obj.R_bn' * (obj.p_bn_n - previousState.p_bn_n);
                obj.psi_dot = 1 / obj.duration * (obj.psi - previousState.psi);
            end
        end
    end
end
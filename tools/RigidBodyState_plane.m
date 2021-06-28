classdef RigidBodyState_plane
    properties
        p_bn_n;
        p_bn_b;
        v_bn_n;
        v_bn_b;	
        theta;
        theta_dot;
        R_bn;
        duration; %this should be changed if the samlping frequency is different;
    end
    properties(Constant)
        p_bm_m = [0;0];
    end
    methods
        function obj = RigidBodyState_plane(duration, px, py,theta, previousState)
            if nargin == 1
                obj.p_bn_n = zeros(2,1);
                obj.p_bn_b = zeros(2,1);
                obj.v_bn_b = zeros(2,1);
                obj.v_bn_n = zeros(2,1);
                obj.theta = 0;
                obj.theta_dot = 0;
                obj.R_bn = zeros(2,2);
                obj.duration = duration;
            elseif nargin == 4
                obj.theta = theta;
                obj.R_bn = [cos(obj.theta), -sin(obj.theta); cos(obj.theta), sin(obj.theta)];
                obj.p_bn_n = obj.R_bn*obj.p_bm_m + [px;py];
                obj.v_bn_n = zeros(2,1);
                obj.v_bn_b = zeros(2,1);
                obj.theta_dot = 0;
                obj.p_bn_b = obj.R_bn' * obj.p_bn_n;
                obj.duration = duration;
            else
                obj.theta = theta;
                obj.R_bn = [cos(obj.theta), -sin(obj.theta); cos(obj.theta), sin(obj.theta)];
                obj.p_bn_n = obj.R_bn*obj.p_bm_m + [px;py];
                obj.duration = duration;
                obj.p_bn_b = obj.R_bn' * obj.p_bn_n;
                obj.v_bn_n = 1 / obj.duration * (obj.p_bn_n - previousState.p_bn_n);
                obj.v_bn_b = 1 / obj.duration * obj.R_bn' * (obj.p_bn_n - previousState.p_bn_n);
                obj.theta_dot = 1 / obj.duration * (obj.theta - previousState.theta);
            end
        end
    end
end
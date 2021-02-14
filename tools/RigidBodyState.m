classdef RigidBodyState
    properties
        p_ml_l;
        p_bn_n;
        p_gn_n;
        v_bn_b;
		v_bn_n;
        v_gn_b;
        v_gn_n;
        Theta;
        w_bn_b;
        R_bn;
        q;
        duration; %this should be changed if the samlping frequency is different;
    end
    properties(Constant)
        r_gb_b = [0,0,0.09705]';
        p_ln_n = zeros(3,1);
        R_ln = [[1,0,0];[0,0,1];[0,-1,0]];
        p_bm_m = [0,-0.22,0]';
        p_gm_m = [0, -0.22-0.09705,0]';
        R_bm = [[1,0,0];[0,0,-1];[0,1,0]];
        
    end
    methods
        function obj = RigidBodyState(duration,px,py,pz,qx,qy,qz,qw,previousState)
            if nargin == 1
                obj.p_ml_l = zeros(3,1);
                obj.p_bn_n = zeros(3,1);
                obj.p_gn_n = zeros(3,1);
                obj.v_bn_b = zeros(3,1);
                obj.v_bn_n = zeros(3,1);
                obj.v_gn_b = zeros(3,1);
                obj.v_gn_n = zeros(3,1);
                obj.Theta = zeros(3,1);
                obj.w_bn_b = zeros(3,1);
                obj.R_bn = zeros(3,3);
                obj.q = zeros(4,1);
                obj.duration = duration;
            elseif nargin == 8 
                obj.p_ml_l = [px,py,pz]';
                obj.q = [qx,qy,qz,qw]';
                R_ml = [[1 - 2 * (qy * qy + qz * qz), 2 * (qx * qy - qz * qw), 2 * (qx * qz + qy * qw)];[2 * (qx * qy + qz * qw), (1 - 2 * (qx * qx + qz * qz)), 2 * (qy * qz - qx * qw)];[2 * (qx * qz - qy * qw), 2 * (qy * qz + qx * qw), (1 - 2 * (qx * qx + qy * qy))]];
                p_bl_l = obj.p_ml_l + R_ml * obj.p_bm_m;
                p_gl_l = obj.p_ml_l + R_ml * obj.p_gm_m;
                obj.p_bn_n = obj.p_ln_n + obj.R_ln * p_bl_l;
                obj.p_gn_n = obj.p_ln_n + obj.R_ln * p_gl_l;
                obj.R_bn = obj.R_ln * R_ml * obj.R_bm;
                tmp = rotm2eul(obj.R_bn);
                obj.Theta = [tmp(3); tmp(2); tmp(1)];
                obj.duration = duration;
                obj.v_bn_b = zeros(3,1);
                obj.v_bn_n = zeros(3,1);
                obj.v_gn_b = zeros(3,1);
                obj.v_gn_n = zeros(3,1);
                obj.w_bn_b = zeros(3,1);
            else
                obj.p_ml_l = [px,py,pz]';
                obj.q = [qx,qy,qz,qw]';
                R_ml = [[1 - 2 * (qy * qy + qz * qz), 2 * (qx * qy - qz * qw), 2 * (qx * qz + qy * qw)];[2 * (qx * qy + qz * qw), (1 - 2 * (qx * qx + qz * qz)), 2 * (qy * qz - qx * qw)];[2 * (qx * qz - qy * qw), 2 * (qy * qz + qx * qw), (1 - 2 * (qx * qx + qy * qy))]];
                p_bl_l = obj.p_ml_l + R_ml * obj.p_bm_m;
                p_gl_l = obj.p_ml_l + R_ml * obj.p_gm_m;
                obj.p_bn_n = obj.p_ln_n + obj.R_ln * p_bl_l;
                obj.p_gn_n = obj.p_ln_n + obj.R_ln * p_gl_l;
                obj.R_bn = obj.R_ln * R_ml * obj.R_bm;
                tmp = rotm2eul(obj.R_bn);
                obj.Theta = [tmp(3); tmp(2); tmp(1)];
                obj.duration = duration;
                obj.v_bn_b = 1 / obj.duration * obj.R_bn' * (obj.p_bn_n - previousState.p_bn_n);
                obj.v_bn_n = 1 / obj.duration * (obj.p_bn_n - previousState.p_bn_n);
                obj.v_gn_b = 1 / obj.duration * obj.R_bn' * (obj.p_gn_n - previousState.p_gn_n);
                obj.v_gn_n = 1 / obj.duration * (obj.p_gn_n - previousState.p_gn_n);
                [J,J11,J22] = eulerang(obj.Theta(1), obj.Theta(2), obj.Theta(3));
                Theta_dot = 1/ obj.duration *(obj.Theta - previousState.Theta);
                obj.w_bn_b = eye(3)/J22 * Theta_dot;
            end
        end
    end
end
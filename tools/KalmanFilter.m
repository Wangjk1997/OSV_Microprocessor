classdef KalmanFilter
    properties
        A_d;
        B_d;
        Q_d;
        R_d;
        H;
        x;
        P;
    end
    methods
        function obj = KalmanFilter(A, B, Q, R, H, initialState, initialVariance)
            if nargin == 5
                obj.A_d = A;
                obj.B_d = B;
                obj.Q_d = Q;
                obj.R_d = R;
                obj.H = H;
                size_A = size(A);
                obj.x = zeros(size_A(1),1);
                obj.P = zeros(size(Q));
            elseif nargin == 6
                obj.A_d = A;
                obj.B_d = B;
                obj.Q_d = Q;
                obj.R_d = R;
                obj.H = H;
                obj.x = initialState;
                obj.P = zeros(size(Q));
            else
                obj.A_d = A;
                obj.B_d = B;
                obj.Q_d = Q;
                obj.R_d = R;
                obj.H = H;
                obj.x = initialState;
                obj.P = initialVariance;
            end
        end
        
        function obj = time_update(obj, u)
            obj.x = obj.A_d * obj.x + obj.B_d * u;
            obj.P = obj.A_d * obj.P * (obj.A_d)' + obj.Q_d;
        end
        
        function obj = measurement_update(obj, z)
            K = obj.P * obj.H' * inv(obj.H * obj.P * obj.H' + obj.R_d);
            obj.x = obj.x + K*(z - obj.H * obj.x);
            obj.P = obj.P - K * obj.H * obj.P;
        end
    end
end
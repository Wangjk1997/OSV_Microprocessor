classdef PIDController
    properties
        kp;
        ki;
        kd;
        iError;
        previousError;
        duration;
        MAX;
        MIN;
    end
    methods
        function obj = PIDController(p,i,d,Ts,max,min)
            obj.kp = p;
            obj.ki = i;
            obj.kd = d;
            obj.iError = 0;
            obj.previousError = 0;
            obj.duration = Ts;
            obj.MAX = max;
            obj.MIN = min;
        end
        function [obj,u] = calculate(obj,currentError)
            pError = currentError;
            iError = obj.iError + obj.duration * currentError;
            dError = (currentError - obj.previousError) / obj.duration;
            tmp = obj.kp * pError + obj.ki * iError + obj.kd * dError;
            u = saturation(tmp,obj.MAX,obj.MIN);
            obj.iError = iError;
            obj.previousError = currentError;
        end
    end
end

function output = saturation(val, MAX, MIN)
    if (val > MAX)
        output = MAX;
    elseif (val < MIN)
        output = MIN;
    else
        output = val;
    end
end


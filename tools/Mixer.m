function Cmd = Mixer(ux, tz, uz)
    mixerMatrix = [[1,1,0];[1,-1,0];[0,0,1];[0,0,1];[0,0,0];[0,0,0]];
%     startByte = uint8(255);
    force = mixerMatrix * [ux,tz,uz]';
%     direction = zeros(6,1);
%     cmd = zeros(1,7);
%     sum = 0;
%     for i = 1:6
%         if force(i) > 0
%             direction(i) = 1;
%             cmd(i) = uint8(force(i));
%         else
%             direction(i) = 0;
%             cmd(i) = uint8(-force(i));
%         end
%         sum = sum + cmd(i);
%     end
%     cmd(7) = uint8(0b00100000 * direction(1) + 0b00010000 * direction(2) + 0b00001000 * direction(3) + 0b00000100 * direction(4) + 0b00000010 * direction(5) + 0b00000001 * direction(6));
%     endByte = uint8(mod(sum + cmd(7),4) + 251);
    Cmd = zeros(6,1);
    Cmd(1) = force2dutyCycle_x(force(1));
    Cmd(2) = force2dutyCycle_x(force(2));
    Cmd(3) = force2dutyCycle_z(force(3));
    Cmd(4) = force2dutyCycle_z(force(4));
    Cmd(5) = force(5);
    Cmd(6) = force(6);
%     Cmd = [startByte,cmd,endByte];
end

% 1g per Volt every single motor, motor voltage = 3.2 * duty cycle.
%GTSR OSV manual test code
%Junkai Wang
%Based on MUR_manual_six_motors_high_res.m Qiuyang Tao

clear;clc;close all; 

% Serial communication initialization
port = serialport("COM3",230400);

% Stop all motors
writeline(port, '$01,SETM,300,300,300,300,300,300');

% loop, please refer to the convention manual for command format
while(true)
  val = getkey;
  %For OSV
  if val == 119 %w
      writeline(port,'$01,SETM,100,100,100,100,100,100');
  elseif val == 115 %s
      writeline(port,'$01,SETM,200,200,200,200,200,200');
  elseif val == 97 %a
      writeline(port,'$01,SETM,300,300,300,300,300,300');
  elseif val == 100 %d
      writeline(port,'$01,SETM,400,400,400,400,400,400');
  elseif val == 30 % up
      writeline(port,'$01,SETM,255,255,255,255,255,255'); 
  elseif val == 31 % down
      writeline(port,'$01,SETM,255,255,255,255,255,255'); 
  elseif val == 99 % c close serial port
      clear port
      break;
  else
      writeline(port,'$01,SETM,255,255,255,255,255,255');
  end   
  readline(port)ad
end



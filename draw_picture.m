clc;
axis([-4,4,-4,4]);
xlim([-4,4])
ylim([-4,4])
% axis square 当前坐标系图形设置为方形，刻度范围不一定一样，但是一定是方形的。
% axis equal 将横轴纵轴的定标系数设成相同值，即单位长度相同，刻度是等长的，但不一定是方形的。
axis equal;
grid on;
h = animatedline('Marker', 'o', 'color', 'b', 'LineStyle', 'none', 'MaximumNumPoints',4);
h1 = animatedline('Marker', 'o', 'color', 'r', 'LineStyle', 'none', 'MaximumNumPoints',4);
xlim manual
t = 6*pi*(0:0.02:1);
for n = 1:length(t)
 addpoints(h, 2*cos(t(1:n)),sin(t(1:n)));
 addpoints(h1, 2*cos(t(1:n))+1,sin(t(1:n))+1);
 % 一般是为了动态观察变化过程 pause（a）暂停a秒后执行下一条指令
 pause(0.05);
 % 可以用drawnow update加快动画速度
 drawnow update;
end
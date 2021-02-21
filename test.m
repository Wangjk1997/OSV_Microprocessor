clear all
addpath('.\tools');
addpath('.\eventHandler');
duration = 0.2;
currentstate = RigidBodyState_plane(duration,sqrt(3)+sqrt(3),1+1,-sqrt(3)+sqrt(3),-1+1);
figure(1);
hold on
axis on
xlim([-5,5])
ylim([-5,5])
xlabel('X');
ylabel('Y');
plot(currentstate.p_left(1),currentstate.p_left(2),'*');
plot(currentstate.p_right(1),currentstate.p_right(2),'*');
plot(currentstate.p_bn_n(1),currentstate.p_bn_n(2),'*');
currentstate.psi/pi*180
currentstate.R_bn
currentstate.p_bn_b

state = currentstate
history = [state, currentstate]
% currentstate.psi
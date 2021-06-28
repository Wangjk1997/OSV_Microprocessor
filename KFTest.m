
addpath('.\tools');
A = [1, duration; 0, 1];
B = [(duration^2)/2; duration];
H = [1,0];
q = 0.01;
Q = [q*(duration^3)/3, q*(duration^2)/2;q*(duration^2)/2, q*duration];
r = 0.01;
R = r/duration;
estimate_x = [];
estimate_y = [];
KF_x = KalmanFilter(A, B, Q, R, H, [0;0], [0,0;0,0]);
KF_y = KalmanFilter(A, B, Q, R, H, [0;0], [0,0;0,0]);
for i = 1:length(pxHistory)
    KF_x = KF_x.time_update(axHistory(i));
    KF_y = KF_y.time_update(ayHistory(i));
    if (mod(i,2) == 0)
        KF_x = KF_x.measurement_update(pxHistory(i));
        KF_y = KF_y.measurement_update(pyHistory(i));
    end
    estimate_x = [estimate_x, KF_x.x];
    estimate_y = [estimate_y, KF_y.x];
end
figure(1)
p1 = plot(0.05*(1:length(pxHistory)),pxHistory);
hold on
p2 = plot(0.05*(1:length(estimate_x(1,:))),estimate_x(1,:));
title("Position in x direction")
xlabel("time/s")
ylabel("position/m")
legend([p1,p2],{'Data from the GPS','Data from data fusion'})
x0=100; y0=100;
width=400; height=220;
set(gcf,'units','points','position',[x0,y0,width,height])
print('-dpng','-r300','Px.png')
figure(2)
plot(estimate_x(2,:))
title("Estimated vx")

figure(3)
p3 = plot(0.05*(1:length(pyHistory)),pyHistory);
title("Position in y direction")
hold on
p4 = plot(0.05*(1:length(estimate_y(1,:))),estimate_y(1,:));
xlabel("time/s")
ylabel("position/m")
legend([p3,p4],{'Data from the GPS','Data from data fusion'})
x0=100; y0=100;
width=400; height=220;
set(gcf,'units','points','position',[x0,y0,width,height])
print('-dpng','-r300','Py.png')
figure(4)
plot(estimate_y(2,:))
title("Estimated vy")

figure(5)
p5 = plot(pxHistory,pyHistory)
hold on
p6 = plot(estimate_x(1,:), estimate_y(1,:))
axis equal
legend([p5,p6],{'Data from the GPS','Data from data fusion'})
title("Trajectory")
xlabel("Position in x direction/m");
ylabel("Position in y direction/m")
x0=100; y0=100;
width=400; height=220;
set(gcf,'units','points','position',[x0,y0,width,height])
print('-dpng','-r300','Pxy.png')

figure(6)
p7 = plot(0.05*(1:length(yawHistory)),yawHistory);
title("Yaw Angle")

xlabel("time/s");
ylabel("Yaw Angle/°");
% ylim([10,30])
x0=100; y0=100;
width=400; height=220;
set(gcf,'units','points','position',[x0,y0,width,height])
print('-dpng','-r300','yaw.png')
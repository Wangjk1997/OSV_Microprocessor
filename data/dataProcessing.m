leng = 347;
figure(1)
plot(0.2*(1:leng), pxHistory)
hold on
plot(0.2*(1:leng), pyHistory)
xlabel('Time/s')
ylabel('Position/m')
title('P_{b/n}^n')
legend({'p_x', 'p_y'})
x0=100; y0=100;
width=400; height=220;
set(gcf,'units','points','position',[x0,y0,width,height])
print('-dpng','-r300','IMG_position.png')

figure(2)
plot(0.2*(1:leng), duty_cyclesHistory(1,:))
hold on
plot(0.2*(1:leng), duty_cyclesHistory(2,:))
xlabel('Time/s')
ylabel('Duty Cycle')
title('Duty Cycle')
legend({'f_1', 'f_2'})
set(gcf,'units','points','position',[x0,y0,width,height])
print('-dpng','-r300','IMG_motor12.png')

figure(3)
plot(0.2*(1:leng), duty_cyclesHistory(3,:))
hold on
plot(0.2*(1:leng), duty_cyclesHistory(4,:))
xlabel('Time/s')
ylabel('Duty Cycle')
title('Duty Cycle')
legend({'f_3', 'f_4'})
set(gcf,'units','points','position',[x0,y0,width,height])
print('-dpng','-r300','IMG_motor34.png')

figure(4)
plot(0.2*(1:leng), yawHistory)
xlabel('Time/s')
ylabel('yaw/rad')
title('Yaw Angle')
ylim([-pi/3,pi/3])
set(gcf,'units','points','position',[x0,y0,width,height])
print('-dpng','-r300','IMG_yaw.png')
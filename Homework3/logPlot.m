clear all; close all; clc;

[time, x, y, theta] = textread('log_serial.txt', ...
    '%f %f %f %f', 'delimiter', ';', 'headerlines',1);



[time, state] = textread('log_serial_serial_serial.txt', ...
    '%f %d', 'delimiter', ';', 'headerlines',1);

[timeLab, xLab, yLab, thetaLab] = textread('lablogRun1.txt', ...
    '%f %f %f %f', 'delimiter', ';', 'headerlines',1);

[timeex16, desex16, thetaex16, dpex16] = textread('task16Log.txt', ...
    '%f %f %f %f', 'delimiter', ';', 'headerlines',1);

[timeex16, dg17, dp17] = textread('task17Log.txt', ...
    '%f %f %f', 'delimiter', ';', 'headerlines',1);

subplot(1,2,1)
plot(dg17)
title('Distance error propagation (d_{g})')
ylabel('Error [cm]')
xlabel('Sample')
subplot(1,2,2)
plot(dp17)
title('Angle error propagation (d_{p})')
ylabel('Error [cm]')
xlabel('Sample')
% plot(x,y)
% 
% figure
% stairs(state)
% 
figure
plot(xLab, yLab)
axis([-0.5 3 -1.5 2.2])

% figure
% subplot(1,2,1)
% plot(desex16)
% hold on
% plot(thetaex16)
% title('Angle change')
% legend('\theta_{g}', '\theta[k]')
% ylabel('Angle [deg]')
% xlabel('Sample')
% 
% subplot(1,2,2)
% plot(dpex16)
% hold on
% plot([0 80], [0 0])
% title('Change in d_{p}[k]')
% legend('d_{p}')
% ylabel('Error [cm]')
% xlabel('Sample')

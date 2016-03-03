clear all; close all; clc;

[time, x, y, theta] = textread('log_serial.txt', ...
    '%f %f %f %f', 'delimiter', ';', 'headerlines',1);



[time, state] = textread('log_serial_serial_serial.txt', ...
    '%f %d', 'delimiter', ';', 'headerlines',1);

[timeLab, xLab, yLab, thetaLab] = textread('lablogRun2.txt', ...
    '%f %f %f %f', 'delimiter', ';', 'headerlines',1);

plot(x,y)

figure
plot(state)

figure
plot(xLab, yLab)
axis([-0.5 3 -1.5 2.2])
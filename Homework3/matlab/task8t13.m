%% Task 8

close all; clear all; clc;

% Forward and Rotates first row is removed to be able to read. Probably not
% relevant.  %[t, x, y, theta]
indata = dlmread('logtask8.txt', ';');
forward_t = indata(:,1); % time
forward_x = indata(:,2);
forward_y = indata(:,3);
forward_theta = indata(:,4);

plot(forward_t, forward_theta)
ylabel('angle \theta [degrees]')
xlabel('time [s]')
print ('.\images\task8_angleplot', '-dpng')
close all;
plot(forward_t, forward_x, forward_t, forward_y)
xlabel('time [s]')
ylabel('distance [m]')
legend('x', 'y')
print ('.\images\task8_posplot', '-dpng')


%% Task 10
close all; clear all; clc;

% Forward and Rotates first row is removed to be able to read. Probably not
% relevant.  %[t, x, y, theta]
indata = dlmread('logtask10step.txt', ';');
forward_t = indata(:,1); % time
forward_x = indata(:,2);
forward_y = indata(:,3);
forward_theta = indata(:,4);

plot(forward_t, forward_x, forward_t, forward_y)
xlabel('time [s]')
ylabel('distance [m]')
legend('x', 'y')
print ('.\images\task10_stepplot', '-dpng')

indata = dlmread('logtask10still.txt', ';');
forward_t = indata(:,1); % time
forward_x = indata(:,2);
forward_y = indata(:,3);
forward_theta = indata(:,4);

plot(forward_t, forward_x, forward_t, forward_y)
xlabel('time [s]')
ylabel('distance [m]')
legend('x', 'y')
print ('.\images\task10_stillplot', '-dpng')

%% Task 11

close all; clear all; clc;

% Forward and Rotates first row is removed to be able to read. Probably not
% relevant.  %[t, x, y, theta]
indata = dlmread('logtask11.txt', ';');
t = indata(:,1); % time
theta = indata(:,2);
d0 = indata(:,3);

plot(t, theta)
xlabel('time [s]')
ylabel('angle \theta [degrees]')
print ('.\images\task11_angleplot', '-dpng')

plot(t, d0)
xlabel('time [s]')
ylabel('distance [m]')
print ('.\images\task11_d0plot', '-dpng')

%% Task 13
close all; clear all; clc;

indata = dlmread('logtask13.txt', ';');
t = indata(:,1); % time
x = indata(:,2);
y = indata(:,3);

plot(t, x, t, y);
legend('x','y')
xlabel('time [s]')
ylabel('position [m]')
print ('.\images\task13_positionplot', '-dpng')
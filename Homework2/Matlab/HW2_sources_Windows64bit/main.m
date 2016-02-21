
%% Task 2
clear all, clc, close all

C1 = 10;
C2 = C1;
C3 = C2;
T1 = 20;
T2 = 29;
T3 = 35;
disp('The schedulability U is:')
disp(C1/T1 + C2/T2 + C3/T3)

n = 3;
n*(2^(1/n)-1)
%% Task 1-5 printing function
% Sätt init_pend_three med executiontime och schedulingPolicy
% Se till att du printar med rätt namn
% Also uncomment the print
filename = 'Task_3_edf_performance'; 

sim('inv_pend_three');

Theta1 = Theta.signals.values(:,1);
Theta2 = Theta.signals.values(:,2);
Theta3 = Theta.signals.values(:,3);
plot(tout, Theta1, tout, Theta2, tout, Theta3);
legend('Pendulum 1', 'Pendulum 2' , 'Pendulum 3');
xlabel('Time [s]')
ylabel('\theta [rad]')
grid on;
filename = strcat('.\images\',filename)
%print(filename,  '-dpng')

%% Plotta stability area


syms K t h
%max{0.5-1/klh} < t/h < min{1/klh}
K = 0:0.1:2;
for K = 0:0.1:2
    x1 = 1/(K*h);
    x2 = 1/2-1/(K*h);
    
end
ezplot(x1)
hold on
ezplot(x2)
title ('Regions of stability')
xlabel('h')
ylabel('\tau/h')
print ('.\images\NET_stabilityarea', '-dpng');
%% Hitta instabil delay
close all; clear all;clc;
sim('inv_pend_delay');
time = tout;
data1 = simout.Data(:,1);
data2 = simout.Data(:,2);
data3 = simout.Data(:,3);
plot(time, data1, time, data2, time, data3);
legend('Delay = 0.01', 'Delay = 0.04', 'Delay = 0.045');
xlabel('Time [s]');
ylabel('\Theta [rad]');
print ('.\images\NET_timedelays', '-dpng');
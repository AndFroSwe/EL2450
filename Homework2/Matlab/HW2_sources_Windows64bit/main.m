
%% Task 2
clear all, clc, close all

C1 = 6;
C2 = 6;
C3 = 6;
T1 = 20;
T2 = 29;
T3 = 35;
disp('The schedulability U is:')
disp(C1/T1 + C2/T2 + C3/T3)

n = 3;
n*(2^(1/n)-1)
%% Task 3
% Sätt init_pend_three rätt
% executionTime = 0.006;
clear all, clc, close all
sim('inv_pend_three');
Theta1 = Theta.signals.values(:,1);
Theta2 = Theta.signals.values(:,2);
Theta3 = Theta.signals.values(:,3);
plot(tout, Theta1, tout, Theta2, tout, Theta3);
legend('Pendulum 1', 'Pendulum 2' , 'Pendulum 3');
xlabel('Time [s]')
ylabel('\theta [rad]')
grid on;
print('.\images\Task_3_dm_performance',  '-dpng')

%% Task 4
% Sätt init_pend_three rätt
% executionTime = 0.01;
clear all, clc, close all
sim('inv_pend_three');
Theta1 = Theta.signals.values(:,1);
Theta2 = Theta.signals.values(:,2);
Theta3 = Theta.signals.values(:,3);
plot(tout, Theta1, tout, Theta2, tout, Theta3);
legend('Pendulum 1', 'Pendulum 2' , 'Pendulum 3');
xlabel('Time [s]')
ylabel('\theta [rad]')
grid on;
print('.\images\Task_5_dm_performance',  '-dpng')

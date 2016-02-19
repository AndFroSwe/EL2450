
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
% S�tt init_pend_three med executiontime och schedulingPolicy
% Se till att du printar med r�tt namn
clear all, clc, close all

filename = 'Task_5_edf_performance'; 

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
print(filename,  '-dpng')

%% Task 4
% Plot the schedule
sch = []; % Schedules
sch_small = Schedule.signals.values(:,1)';
sch_med = Schedule.signals.values(:,2)';
sch_big = Schedule.signals.values(:,3)';
sch = [sch_small; sch_med; sch_big];

% Plot all in same plot
figure
hold on
grid on
for i = 1:3
    plot(time, sch(i,:))
end
title('Schedule for pendulums with 6 ms computation time')
xlabel('t [s]')
legend('Small pendulum', 'Medium pendulum', 'Big pendulum')

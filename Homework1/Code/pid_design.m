%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hybrid and Embedded control systems
% Homework 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all, close all, clc
init_tanks;
g = 9.82;
Tau = 1/alpha1*sqrt(2*tank_h10/g);
K = 60*beta*Tau;
Gamma = alpha1^2/alpha2^2;

s = tf('s');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Continuous Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uppertank=tf([K],[Tau 1]); % Transfer function for upper tank
lowertank=tf([Gamma],[Gamma*Tau 1]); % Transfer function for upper tank
G=lowertank*uppertank; % Transfer function from input to lower tank level

% CalculatePID paramaeters
chi = 0.5;
omega0 = 0.2;
zeta = 0.7;

[K_pid, Ti, Td, N] = polePlacePID(chi, omega0, zeta, Tau, Gamma, K)

F = K_pid*(1 + 1/(Ti*s) + Td*N*s/(N + s)); % Transfer function for the controller

Go = F*G;
Gc = F*G/(1 + F*G); % Closed system

figure
step(Gc)
title('Step function of closed system')
figure
bode(Gc)
figure
pzmap(Gc)
stepinfo(Gc)

sim('tanks')
figure
subplot(4,1,1)
plot(ref.Time, ref.Data)
title('Ref')
subplot(4,1,2)
plot(h1.Time, h1.Data)
title('h1')
subplot(4,1,3)
plot(h2.Time, h2.Data)
title('h2')
subplot(4,1,4)
plot(pump.Time, pump.Data)
title('Pump')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Digital Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ts = 1; % Sampling time

% Discretize the continous controller, save it in state space form
% [Aa,Ba,Ca,Da] = ; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Discrete Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Gd = 1; % Sampled system model
Fd = 1; % Transfer function for discrete designed controller
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hybrid and Embedded control systems
% Homework 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%
clear all, close all, clc
init_tanks;
g = 9.82;
Tau = 1/alpha1*sqrt(2*tank_h10/g);
K = 60*beta*Tau;
Gamma = alpha1^2/alpha2^2;
simtime = 200;

s = tf('s');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Continuous Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uppertank=tf([K],[Tau 1]);          % Transfer function for upper tank
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
ZOH = 0.92*4;

figure(1)
step(Gc)
title('Step function of closed system')
figure(2)
bode(Gc)
figure(3)
pzmap(Gc)
stepinfo(Gc)

sim('tanks')
figure(4)
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
Ts = 4  ; % Sampling time

% Discretize the continous controller, save it in state space form
% [Aa,Ba,Ca,Da] = ; 
% Run several times over different sampling frequencies
% Figure 5 contains all h1 data
% Figure 6 contains all h2 data
% Figure 7 contains all pump data
% Loop over different sampling times and print performance
for i = 1:length(Ts)
    F_dg = c2d(F, Ts, 'zoh');
    [Ad,Bd,Cd,Dd] = tf2ss(F_dg.num{1}, F_dg.den{1});
    % Simulate system
    sim('tanks_discrete')
    % Plot the simulated data
    figure(5)
    subplot(length(Ts),1,i)
    title('
    subplot(4,1,2)
    plot(h1_d.Time, h1_d.Data)
    title('h1_d')
    subplot(4,1,3)
    plot(h2_d.Time, h2_d.Data)
    title('h2_d')
    subplot(4,1,4)
    plot(pump_d.Time, pump_d.Data)
    title('Pump_d')
end

%%%% Plot both discrete and continuous h2 in same plot
figure
plot(h2.Time, h2.Data);
hold on
plot(h2_d.Time, h2_d.Data);
legend('Continuous', 'Discrete')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Discrete Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ts = 4;
sim('tanks_discrete')
G_d = c2d(G, Ts, 'zoh')
[Ad,Bd,Cd,Dd] = tf2ss(G_d.num{1}, G_d.den{1});


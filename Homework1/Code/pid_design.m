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
Ts = 4; % Sampling time

% Discretize the continous controller, save it in state space form
% [Aa,Ba,Ca,Da] = ; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Discrete Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Discrete experimental corner - Want to avoid the simulations
clc; close all;


Gd = c2d(G, Ts, 'zoh'); % Sampled system model
Fd = 1;% c2d(F, Ts, 'zoh'); % Transfer function for discrete designed controller

%Gets and prints ai and bi for q 12
fprintf('Question 12\n\n')
counter = 1;
for i = Gd.num{1}
    fprintf('a%d = %d\n',counter,i)
    counter = counter +1;
end
counter = 1;
for i = Gd.den{1}
    fprintf('b%d = %d\n',counter,i)
    counter = counter +1;
end
fprintf('Question 13\n\n')
fprintf('Somewhere\n\n')


%Gpoles = pole(G);
Gdpoles = pole(Gd); %Using built in function to calculate poles
%exp(Ts*Gpoles(1)) %Numerically calculate poles. The build-in gives the same results. 
Gdc = Fd*Gd/(1 + Fd*Gd); % Closed system
fprintf('Question 14\n\n')

counter = -1;
for i = Gdc.den{1}
    fprintf('d%d = %d\n',counter,i)
    counter = counter +1;
end
fprintf('\nQuestion 15\n\n')
%Next step is to symbolically set Gc = Gdc
%And solve so Gdc gets the same poles as Gc. 
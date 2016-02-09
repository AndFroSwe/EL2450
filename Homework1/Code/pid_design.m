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
simtime = 200;

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
zeta = 0.8;

[K_pid, Ti, Td, N] = polePlacePID(chi, omega0, zeta, Tau, Gamma, K)

F = K_pid*(1 + 1/(Ti*s) + Td*N*s/(N + s)); % Transfer function for the controller

% Define closed and open system equations
Go = F*G;
Gc = F*G/(1 + F*G); % Closed system

% Info for continuous system
figure
step(Gc)
title('Step function of closed system')
figure
bode(Gc)
figure
pzmap(Gc)
stepinfo(Gc)

% Simulate the continuous system with ZOH for q7
% Figure 200: h1
% Figure 201: h2
% Figure 202: pump
ZOH_all = 1:2:10;

for i = 1:length(ZOH_all)
    ZOH = ZOH_all(i);
    % Simulate system
    sim('tanks')
    % h1
    figure(200)
    subplot(length(ZOH_all), 1, i)
    plot(h1.Time, h1.Data)
    title(sprintf('h1 for ZOH=%1.1f', ZOH))
    % h2
    figure(201)
    subplot(length(ZOH_all), 1, i)
    plot(h2.Time, h2.Data)
    hold on
    plot(ref.Time, ref.Data)
    hold off
    title(sprintf('h2 for ZOH=%1.1f', ZOH))
    % pump
    figure(202)
    subplot(length(ZOH_all),1,i)
    plot(pump.Time, pump.Data)
    title(sprintf('Pump for ZOH=%1.1f', ZOH))
end
% Send figures to images folder
print(200, '-dpng', '.\images\h1_samplings')
print(201, '-dpng', '.\images\h2_samplings')
print(202, '-dpng', '.\images\pump_samplings')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Digital Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 Ts_all = [0.1 2 3 4]; % Sampling time
 quant = 200/(2^60); % quantization level

% Simulate and plot for several sampling times for q8 
% Figure 100: h1
% Figure 101: h2
% Figure 102: pump

% % Discretize the continous controller, save it in state space form
for i = 1:length(Ts_all)
    Ts = Ts_all(i);
    F_dg = c2d(F, Ts, 'zoh');
    [Ad,Bd,Cd,Dd] = tf2ss(F_dg.num{1}, F_dg.den{1});
    % Simulate system
    sim('tanks_discrete')
    % h1
    figure(100)
    subplot(length(Ts_all), 1, i)
    plot(h1_d.Time, h1_d.Data)
    title(sprintf('h1 for Ts=%1.1f', Ts))
    % h2
    figure(101)
    subplot(length(Ts_all), 1, i)
    plot(h2_d.Time, h2_d.Data)
    hold on
    plot(ref.Time, ref.Data)
    hold off
    title(sprintf('h2 for Ts=%1.1f', Ts))
    % pump
    figure(102)
    subplot(length(Ts_all),1,i)
    plot(pump_d.Time, pump_d.Data)
    title(sprintf('Pump for Ts=%1.1f', Ts))
    
end
% Send figures to images folder
print(100, '-dpng', '.\images\h1_samplings_ss')
print(101, '-dpng', '.\images\h2_samplings_ss')
print(102, '-dpng', '.\images\pump_samplings_ss')
%close all

%Create a picture with all three h1, h2, and pump
%For comparison with Q17
Ts = 4


disp('Question 10')
[Gm,Pm,Wcg,Wc] = margin(Go);
fprintf('The crossover frequency Wc=%f rad/sec\n', Wc)
fprintf('Sampling at 20*Wc=%f rad/sec\n', 20*Wc)
fprintf('Sampling time 2*pi/(20Wc)=%f s\n', 2*pi/(20*Wc))



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Discrete Control design
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Q11, set sampling time to 4s
Ts = 4;
%Gdcshit = c2d(Gc, Ts, 'zoh') %It is really bad tbh
%[Ad, Bd, Cd, Dd] = tf2ss(Gdcshit.num{1}, Gdcshit.den{1})
%sim('tanks_discrete')
%for i = 1:length(Ts_all)
    F_dg = c2d(F, Ts, 'zoh');
    [Ad,Bd,Cd,Dd] = tf2ss(F_dg.num{1}, F_dg.den{1});
    % Simulate system
    sim('tanks_discrete')
    % h1
    figure(420)
    subplot(3, 1, 1)
    plot(h1_d.Time, h1_d.Data)
    title(sprintf('h1 for Ts=%1.1f', Ts))
    % h2
    subplot(3, 1, 2)
    plot(h2_d.Time, h2_d.Data)
    hold on
    plot(ref.Time, ref.Data)
    hold off
    title(sprintf('h2 for Ts=%1.1f', Ts))
    % pump
    subplot(3,1,3)
    plot(pump_d.Time, pump_d.Data)
    title(sprintf('Pump for Ts=%1.1f', Ts))
    
%
print(420, '-dpng', '.\images\4s_samplings')

% h1
figure(600)
subplot(3, 1, 1)
plot(h1_d.Time, h1_d.Data)
title(sprintf('h1 for Ts=%1.1f', Ts))
% h2
subplot(3, 1, 2)
plot(h2_d.Time, h2_d.Data)
hold on
plot(ref.Time, ref.Data)
hold off
title(sprintf('h2 for Ts=%1.1f', Ts))
% pump
subplot(3,1,3)
plot(pump_d.Time, pump_d.Data)
title(sprintf('Pump for Ts=%1.1f', Ts))

print(600, '-dpng', '.\images\all_q11')
quant = 200/(2^6);
all_quants = [3, 4, 6, 10]


Gd = c2d(G, Ts, 'zoh') % Sampled system model

%Gets and prints ai and bi for q 12
fprintf('Question 12\n\n')
counter = 0;
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
fprintf('Within the unit circle\n\n')

%Gdpoles = pole(Gd); %Using built in function to calculate poles
%exp(Ts*Gpoles(1)) %Numerically calculate poles. The build-in gives the same results. 
%Gdc = Fd*Gd/(1 + Fd*Gd); % Closed system
fprintf('Question 14\n\n')

Gcminimized = minreal(Gc); %Remove unecessary poles
Gcdiscretepoles = pole(Gcminimized); %Get the poles
fprintf('Gc discrete poles:\n');
for i = 1:length(Gcdiscretepoles) 
    Gcdiscretepoles(i) = exp(Ts*Gcdiscretepoles(i)); %Covert to discrete poles
end
%Gcpoles = pole(minimized);
% minimized.den{1}(2);
Gcdiscretepoles
A = [Gcdiscretepoles(1) 0 0 0; 
    0 Gcdiscretepoles(2) 0 0;
    0 0 Gcdiscretepoles(3) 0; 
    0 0 0 Gcdiscretepoles(4)]; %prepare matrix
polyied = poly(A); %Create polynomial which is our d-values in q14
for i = 1:length(polyied)
    fprintf('d%d: %d\n', i-2, polyied(i))
end

fprintf('\nQuestion 15\n\n')
fprintf('Symbolically set up the digital closed loop system\n')
fprintf('Calculate so this system gets the same poles as resulting in q 14\n')
a1 = Gd.num{1}(2);
a2 = Gd.num{1}(3);
b1 = Gd.den{1}(2);
b2 = Gd.den{1}(3);
d0 = polyied(2);
d1 = polyied(3);
d2 = polyied(4);
d3 = polyied(5);

A = [1 a1 0 0;
     b1-1 a2 a1 0;
     b2-b1 0 a2 a1;
     -b2 0 0 a2];
 B = [d0-b1+1;
     d1-b2+b1;
     d2+b2;
     d3];
C = A\B;
r = C(1);
c0 = C(2);
c1 = C(3);
c2 = C(4);
fprintf('Constants for Fd are:\n')
fprintf('r = %d\n', r);
fprintf('c0 = %d\n', c0);
fprintf('c1 = %d\n', c1);
fprintf('c2 = %d\n', c2);
fprintf('\n');

fprintf('Question 16\n\n');
Fd = filt([c0 c1 c2], [1 r-1 -r], Ts);
Gdo = Gd*Fd;
Gdc = Gd*Fd/(1+ Gd*Fd);
fprintf('Gc:\n')
exp(Ts*pole(minreal((Gc))))
fprintf('Gdc:\n')
pole(minreal(Gdc))
%[Ad, Bd, Cd, Dd] = tf2ss(Gdc.num{1}, Gdc.den{1});

for i = 1:length(all_quants)
    quant = 200/2^all_quants(i);
    %F_d4s = c2d(F, Ts, 'zoh');  % Discrete controller with 4s sampling
    [Ad,Bd,Cd,Dd] = tf2ss(Fd.num{1}, Fd.den{1});    % ss representation
    sim('tanks_quant')   % Simulate the system
    % h1
    figure(300)
    subplot(length(all_quants), 1, i)
    plot(h1_d.Time, h1_d.Data)
    title(sprintf('h1 for bit = %d', all_quants(i)))
    % h2
    figure(301)
    subplot(length(all_quants), 1, i)
    plot(h2_d.Time, h2_d.Data)
    hold on
    plot(ref.Time, ref.Data)
    hold off
    title(sprintf('h2 for bit = %d', all_quants(i)))
    % pump
    figure(302)
    subplot(length(all_quants),1,i)
    plot(pump_d.Time, pump_d.Data)
    title(sprintf('Pump for bit = %d', all_quants(i)))
end
print(300, '-dpng', '.\images\h1_quant_samplings')
print(301, '-dpng', '.\images\h2_quant_samplings')
print(302, '-dpng', '.\images\pump_quant_samplings')
fprintf('Question 17\n')
% Compare with Q 11
% Simulate system
quant = 1/2^10
sim('tanks_quant')
% h1
figure(500)
subplot(3, 1, 1)
plot(h1_d.Time, h1_d.Data)
title(sprintf('h1 for Ts=%1.1f', Ts))
% h2
subplot(3, 1, 2)
plot(h2_d.Time, h2_d.Data)
hold on
plot(ref.Time, ref.Data)
hold off
title(sprintf('h2 for Ts=%1.1f', Ts))
% pump
subplot(3,1,3)
plot(pump_d.Time, pump_d.Data)
title(sprintf('Pump for Ts=%1.1f', Ts))

print(500, '-dpng', '.\images\all_q17')

fprintf('Question 18\n')
quantlevel = 100/1024;
fprintf('%d\n', quantlevel)
fprintf('Question 19\n')
fprintf('done\n')

fprintf('Question 20\n')
fprintf('The performance degrades around %d\n', 6)


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

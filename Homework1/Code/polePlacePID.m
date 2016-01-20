% Computes PID parameters, given some information on where the
% closed-loop poles of the system should be.
function [K, Ti, Td, N] = polePlacePID(chi, omega0, zeta,tau,gamma,k)

chi = -1*chi;
K = -(1+2*gamma+4*chi*tau*gamma+gamma^2+2*chi^2*zeta*omega0*tau^3*gamma^2-2*chi*omega0^2*tau^3*gamma^2-4*zeta*omega0*tau*gamma+4*chi*tau*gamma^2+4*chi^2*tau^2*gamma^2-4*zeta*omega0*tau*gamma^2+4*zeta^2*omega0^2*tau^2*gamma^2-2*chi*omega0^2*tau^3*gamma^3-3*gamma^3*tau^4*chi^2*omega0^2-8*chi*tau^2*gamma^2*zeta*omega0+2*chi^2*zeta*omega0*tau^3*gamma^3+4*chi^3*zeta*omega0*tau^4*gamma^3-4*chi^2*zeta^2*omega0^2*tau^4*gamma^3+4*chi*omega0^3*tau^4*gamma^3*zeta)/(k*gamma*(-4*zeta*omega0*tau*gamma+4*chi*tau*gamma^2+2*gamma+4*chi*tau*gamma-4*zeta*omega0*tau*gamma^2+4*zeta^2*omega0^2*tau^2*gamma^2+4*chi^2*tau^2*gamma^2-8*chi*tau^2*gamma^2*zeta*omega0+gamma^2+1))
Ti = -(1+2*gamma+4*chi*tau*gamma+gamma^2+2*chi^2*zeta*omega0*tau^3*gamma^2-2*chi*omega0^2*tau^3*gamma^2-4*zeta*omega0*tau*gamma+4*chi*tau*gamma^2+4*chi^2*tau^2*gamma^2-4*zeta*omega0*tau*gamma^2+4*zeta^2*omega0^2*tau^2*gamma^2-2*chi*omega0^2*tau^3*gamma^3-3*gamma^3*tau^4*chi^2*omega0^2-8*chi*tau^2*gamma^2*zeta*omega0+2*chi^2*zeta*omega0*tau^3*gamma^3+4*chi^3*zeta*omega0*tau^4*gamma^3-4*chi^2*zeta^2*omega0^2*tau^4*gamma^3+4*chi*omega0^3*tau^4*gamma^3*zeta)/(tau^3*omega0^2*chi^2*(-gamma-1-2*chi*tau*gamma+2*zeta*omega0*tau*gamma)*gamma^2)
Td = -tau*(1+4*gamma+6*chi*tau*gamma+12*chi^3*tau^3*gamma^4+6*tau*gamma^4*chi+4*chi^4*tau^4*gamma^4+13*tau^2*gamma^4*chi^2+2*omega0^2*tau^2*gamma^3+omega0^2*tau^2*gamma^2-18*gamma^3*zeta*omega0*tau+26*gamma^3*chi^2*tau^2+18*gamma^3*chi*tau+omega0^2*tau^2*gamma^4+6*gamma^2+4*gamma^3-4*gamma^4*chi*omega0^3*tau^4*zeta+2*gamma^4*chi*omega0^2*tau^3+gamma^4*tau^4*chi^2*omega0^2-56*gamma^3*chi*tau^2*zeta*omega0-8*zeta^3*omega0^3*tau^3*gamma^4-4*omega0^3*tau^3*gamma^3*zeta+12*tau^2*gamma^4*zeta^2*omega0^2+4*omega0^4*tau^4*gamma^4*zeta^2-4*omega0^3*tau^3*gamma^4*zeta-6*tau*gamma^4*zeta*omega0+24*gamma^3*zeta^2*omega0^2*tau^2-42*gamma^4*chi^2*zeta*omega0*tau^3-20*gamma^4*chi^3*zeta*omega0*tau^4+40*chi*tau^3*gamma^4*zeta^2*omega0^2-28*tau^2*gamma^4*chi*zeta*omega0-16*chi*zeta^3*omega0^3*tau^4*gamma^4+12*gamma^3*chi^3*tau^3+32*gamma^4*chi^2*zeta^2*omega0^2*tau^4+40*gamma^3*chi*tau^3*zeta^2*omega0^2-8*gamma^3*zeta^3*omega0^3*tau^3-6*zeta*omega0*tau*gamma+18*chi*tau*gamma^2+13*chi^2*tau^2*gamma^2-18*zeta*omega0*tau*gamma^2+12*zeta^2*omega0^2*tau^2*gamma^2+2*chi*omega0^2*tau^3*gamma^3-28*chi*tau^2*gamma^2*zeta*omega0-42*chi^2*zeta*omega0*tau^3*gamma^3+gamma^4)/(-1-3*gamma-6*chi*tau*gamma+6*gamma^3*zeta*omega0*tau-12*gamma^3*chi^2*tau^2-6*gamma^3*chi*tau-3*gamma^2-gamma^3+8*gamma^4*zeta^2*omega0^4*tau^5*chi+16*gamma^4*chi^3*tau^5*zeta^2*omega0^2-14*gamma^4*chi^2*tau^5*omega0^3*zeta+6*gamma^4*chi^3*tau^5*omega0^2-8*gamma^4*chi*omega0^3*tau^4*zeta+2*gamma^4*chi*omega0^2*tau^3+7*gamma^4*tau^4*chi^2*omega0^2+24*gamma^3*chi*tau^2*zeta*omega0-12*gamma^3*zeta^2*omega0^2*tau^2-2*gamma^4*chi^2*zeta*omega0*tau^3-8*gamma^4*chi^3*zeta*omega0*tau^4-8*gamma^3*chi^3*tau^3+8*gamma^4*chi^2*zeta^2*omega0^2*tau^4-24*gamma^3*chi*tau^3*zeta^2*omega0^2-8*gamma^4*chi^4*tau^5*zeta*omega0-8*gamma^4*zeta^3*omega0^3*tau^5*chi^2+8*gamma^3*zeta^3*omega0^3*tau^3-2*chi^2*zeta*omega0*tau^3*gamma^2+2*chi*omega0^2*tau^3*gamma^2+6*zeta*omega0*tau*gamma-12*chi*tau*gamma^2-12*chi^2*tau^2*gamma^2+12*zeta*omega0*tau*gamma^2-12*zeta^2*omega0^2*tau^2*gamma^2+4*chi*omega0^2*tau^3*gamma^3+7*gamma^3*tau^4*chi^2*omega0^2+24*chi*tau^2*gamma^2*zeta*omega0+20*chi^2*zeta*omega0*tau^3*gamma^3-8*chi^3*zeta*omega0*tau^4*gamma^3+8*chi^2*zeta^2*omega0^2*tau^4*gamma^3-8*chi*omega0^3*tau^4*gamma^3*zeta)
N = (-gamma-1-2*chi*tau*gamma+2*zeta*omega0*tau*gamma)/(tau*gamma)


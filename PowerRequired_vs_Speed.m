% Written by : Mendel SAVADOGO
% LinkedIn : www.linkedin.com/in/bruno-mendel-savadogo
% Last modification date : 01/07/2025
% Description : MATLAB code source for SLUF ***PowerRequired_vs_Speed.m***
% PowerRequired_vs_Speed.m
clear; close all

% given constants
CD0 = 0.016;       % zero‑lift drag
K   = 0.045;       % induced drag factor
S   = 50;          % wing area [m^2]
W   = 160e3;       % weight [N]
rho = 1.225;       % sea‑level density

% stall speed for Cl_max = 1.5
Cl_max = 1.5;
V_stall = sqrt(W/(0.5*rho*S*Cl_max));

% Build speed vector
V = linspace(V_stall, 200, 1000);

% drag components (as before)
A = CD0 * 0.5 * rho * S;
B = K * W^2 / (0.5 * rho * S);
D_profile = A .* V.^2;
D_induced = B .* V.^(-2);
D_total   = D_profile + D_induced;

% power required
P_required = D_total .* V;   % P = D * V

% find minimum‑power speed
[~, idx] = min(P_required);
V_mp = V(idx);
P_min = P_required(idx);

% Plot
figure(3)
plot(V, P_required, 'LineWidth',1.5)
hold on; grid on, grid minor

plot(V_mp, P_min, 'ro', 'MarkerFaceColor','r')
text(V_mp, P_min*1.05, sprintf('  V_{mp}=%.1f m/s', V_mp), ...
     'VerticalAlignment','bottom')

xlabel('True Airspeed V (m/s)')
ylabel('Power Required P (W)')
title('Power Required vs Speed in SLUF')
xlim([0 200])

% overlay drag curves for context (comment out if unwanted):
yyaxis right
plot(V, D_total, '--', 'DisplayName','Drag (N)')
ylabel('Drag D (N)')
legend('Power Required','Min‑Power Point','Location','northwest')

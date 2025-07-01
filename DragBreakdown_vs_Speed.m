% Written by : Mendel SAVADOGO
% LinkedIn : www.linkedin.com/in/bruno-mendel-savadogo
% Last modification date : 01/07/2025
% Description : MATLAB code source for SLUF ***PowerRequired_vs_Speed.m***
clear; clf;

% given constants
CD0 = 0.016;        % zero‑lift drag
K   = 0.045;        % induced drag factor
S   = 50;           % wing area [m^2]
W   = 160e3;        % weight [N]
alt = 0;            % altitude [km]

% air density at sea level
rho = 1.225;        

% stall speed
Cl_max = 1.5;
V_stall = sqrt(W./(0.5*rho*S*Cl_max));

% speed vector
V = linspace(V_stall, 200, 1000);

% drag components
A = CD0 * 0.5 * rho * S;
B = K * W^2 / (0.5 * rho * S);
D_profile = A .* V.^2;
D_induced = B .* V.^(-2);
D_total   = D_profile + D_induced;

% Minimum‑drag speed & drag
V_md = (B/A)^(1/4);
D_md = A*V_md^2 + B*V_md^(-2);

figure(2)
hold on
grid on,
grid minor
plot(V, D_induced, 'DisplayName','Induced Drag')
plot(V, D_profile, 'DisplayName','Profile Drag')
plot(V, D_total,   'DisplayName','Total Drag')

% annotate minimum drag
plot(V_md, D_md, 'vk', 'MarkerFaceColor','k', 'DisplayName','Min Drag')
text(V_md, D_md*1.05, '  V_{md}', 'VerticalAlignment','bottom')

xlabel('True Airspeed V (m/s)')
ylabel('Drag D (N)')
title(sprintf('Drag vs Speed (CD0=%.3f, K=%.3f, S=%.1fm^2, W=%.0fkN)',...
      CD0, K, S, W/1e3))
xlim([0 200]); ylim([0 2e4])
legend('Location','northeast')

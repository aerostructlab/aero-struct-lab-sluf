% Written by : Mendel SAVADOGO
% LinkedIn : www.linkedin.com/in/bruno-mendel-savadogo
% Last modification date : 01/07/2025
% Description : MATLAB code source for SLUF ***DragPolar_Cessna172.m***
% DragPolar_Cessna172.m
clear
close all

% discrete data (from ResearchGate) at 
% https://www.researchgate.net/figure/Figure-A10-Drag-polar-for-the-Cessna-172S-This-plot-is-created-for-NACA-2412-airfoil_fig25_328578766

Cd_data = [0.033099, 0.035185, 0.035214, 0.041961, 0.051143,...
           0.064192, 0.080106, 0.096683, 0.104613, 0.11364,...
           0.121425, 0.130259, 0.138232];
Cl_data = [0.1454, -0.09219, 0.38303, 0.6238, 0.86305, 1.09772,...
           1.31082, 1.45757, 1.51784, 1.55342, 1.58437, 1.60452, 1.58455];

% save CSV if desired
T = table(Cl_data.', Cd_data.', 'VariableNames', {'Cl','Cd'});
writetable(T, 'CessnaDragPolar.csv');

% Plot raw data
figure(1); hold on, grid on
grid minor
plot(Cd_data, Cl_data, 'kx', 'DisplayName','Data for Cessna172')

% drag‑model parameters
Cd0 = 0.033;
Cl0 = 0.14;
K   = 0.035;

% model curve
Cl_vec = linspace(min(Cl_data)-0.2, max(Cl_data)+0.2, 1000);
Cd_vec = Cd0 + K*(Cl_vec - Cl0).^2;
plot(Cd_vec, Cl_vec, 'r-', 'LineWidth',1.5, 'DisplayName','Ideal model')

% compute max L/D point
Cl_md = sqrt(Cd0/K + Cl0^2);
Cd_md = Cd0 + K*(Cl_md - Cl0)^2;
plot(Cd_md, Cl_md, 'ob', 'MarkerFaceColor','b', 'DisplayName','(L/D)_{max}')

% tangent line from origin
t = linspace(0, Cl_md*2, 2);
plot(t*Cd_md/Cl_md, t, 'b--', 'DisplayName','Tangent')

xlim([0 0.14]); ylim([-0.5 2])
xlabel('C_D'); ylabel('C_L')
title('Drag Polar: Data vs. Model')
legend('Location','best')

%% Simulation of PV–Battery Hybrid Power System
% Author: Sujit Kumar Chaudhary
% Email: iamsujit33@gmail.com
% Date: October 2025
% Description: MATLAB code to model PV system with MPPT and battery integration

clc; clear; close all;

%% PV Array Parameters
N_series = 1;          % Modules in series per string
N_parallel = 5;        % Number of parallel strings
Voc = 36.3;            % Open circuit voltage [V]
Isc = 7.84;            % Short circuit current [A]
Vmp = 29;              % Voltage at max power point [V]
Imp = 7.35;            % Current at max power point [A]
Pmax = Vmp * Imp;      % Maximum power [W]
T_cell = 45;           % Cell temperature [°C]

fprintf("PV Max Power: %.2f W at Vmp = %.2f V, Imp = %.2f A\n", Pmax, Vmp, Imp);

%% Simulation Parameters
Irradiance = [0 100 300 600 300 100 0];   % W/m^2
TimeSteps  = [0 2 4 6 8 10 12];           % sec
V_ref      = 50;                          % DC bus voltage reference [V]

%% Battery Parameters
Batt_nomV = 24;          % Nominal voltage [V]
Batt_Ah = 50;            % Rated capacity [Ah]
Batt_SOC_init = 0.45;    % Initial state-of-charge (45%)
Batt_Vfull = 27.9;       % Fully charged voltage [V]
Batt_Vcut = 18;          % Cut-off voltage [V]

fprintf("Battery: %.1f V, %.1f Ah, Initial SOC = %.0f %%\n", ...
    Batt_nomV, Batt_Ah, Batt_SOC_init*100);

%% MPPT Control Parameters (P&O Method)
duty_init = 0.05;
duty = duty_init;
duty_min = 0; duty_max = 0.75;
deltaD = 0.01;

% Tracking variables
Vold = 0; Pold = 0; duty_old = duty;

%% Run Simulation Across Irradiance Profile
SOC = Batt_SOC_init;   % Initialize SOC
SOC_history = zeros(1,length(TimeSteps));
Duty_history = zeros(1,length(TimeSteps));
Vpv_history = zeros(1,length(TimeSteps));
Ppv_history = zeros(1,length(TimeSteps));

for k = 1:length(TimeSteps)
    % Scale PV output according to irradiance ratio
    G_ratio = Irradiance(k)/1000; % Normalize to STC
    Vpv = Vmp;                    % Approximate PV voltage
    Ipv = Imp * G_ratio;          % Scale current with irradiance
    Ppv = Vpv * Ipv;              % Power output
    
    % MPPT Algorithm (Perturb & Observe)
    dV = Vpv - Vold;
    dP = Ppv - Pold;
    
    if dP ~= 0
        if dV < 0
            duty = duty_old - deltaD;
        else
            duty = duty_old + deltaD;
        end
    else
        if dV < 0
            duty = duty_old + deltaD;
        else
            duty = duty_old - deltaD;
        end
    end
    
    % Bound duty cycle
    duty = min(max(duty, duty_min), duty_max);
    
    % Battery Charging/Discharging
    Load_power = 150; % Constant load demand
    Pnet = Ppv - Load_power;
    SOC = SOC + (Pnet/(Batt_nomV*Batt_Ah*3600)); % update SOC
    
    % Limit SOC between 0–1
    SOC = min(max(SOC,0),1);
    
    % Store values
    SOC_history(k) = SOC*100;
    Duty_history(k) = duty;
    Vpv_history(k) = Vpv;
    Ppv_history(k) = Ppv;
    
    % Update persistent values
    Vold = Vpv; Pold = Ppv; duty_old = duty;
end

%% Plot Results
figure;
subplot(2,2,1);
plot(TimeSteps, Irradiance, 'k-o','LineWidth',2); grid on;
xlabel('Time (s)'); ylabel('Irradiance (W/m^2)');
title('Solar Irradiance Profile');

subplot(2,2,2);
plot(TimeSteps, Ppv_history, 'r-o','LineWidth',2); grid on;
xlabel('Time (s)'); ylabel('PV Power (W)');
title('PV Output Power vs Time');

subplot(2,2,3);
plot(TimeSteps, Duty_history, 'b-o','LineWidth',2); grid on;
xlabel('Time (s)'); ylabel('Duty Cycle');
title('MPPT Duty Cycle Response');

subplot(2,2,4);
plot(TimeSteps, SOC_history, 'g-o','LineWidth',2); grid on;
xlabel('Time (s)'); ylabel('SOC (%)');
title('Battery State of Charge');

sgtitle('PV–Battery Hybrid System Simulation Results');

fprintf("Final SOC: %.2f %%\n", SOC*100);
fprintf("Final Duty Cycle: %.3f\n", duty);

clc; 
clear; 
close all;
%% User Input
P_R = input('Enter Rated Power : '); 
pf = input('Enter Power Factor : ');
Vr = input('Enter Receiving End Voltage (line-to-line, in V)18: '); 
f = input('Enter Frequency (in Hz): ');
R_per_km = input('Enter Resistance per km (in ohm/km): '); 
length = input('Enter Transmission Line Length (in km): '); 
D = input('Enter Spacing between conductors (in meters): '); 
d = input('Enter Conductor Diameter (in meters): ');

%% Derived Parameters 
r = d/2;
rr = 0.7788 * r;
R = R_per_km * length;

%% Inductance and Capacitance Calculation
L = ((2e-7) * log(D / rr) ) * length; % Inductance in H
C1 = ((2 * pi * 8.854e-12) /(log(D / r)))* length; % Capacitance in F
%% Reactance Calculation
Xl = 2 * pi * f * L; % Inductive reactance
Xc = 1 / (2 * pi * f * C1); % Capacitive reactance
%% Impedance and Admittance Calculation 
Z = R + 1i * Xl; % Series impedance
Bc = 1 / Xc;
Y = 1i * Bc; % Shunt admittance
%% Receiving-end Calculations 
Vr_ph = Vr / sqrt(3);
Ir = (P_R) / (sqrt(3) * Vr * pf); 
Ir1 = Ir * (pf - 1i * sin(acos(pf)));

%% Type Selection
fprintf('\nSelect Transmission Line Model:\n'); 
fprintf('1. Short Transmission Line\n'); 
fprintf('2. Nominal-T Method\n');
fprintf('3. Nominal-Pi Method\n'); 
fprintf('4. Long Transmission Line\n');
Type = input('Enter your choice (1/2/3/4): ');

if Type == 1
%% Short Transmission Line Approximation 
Vs_P = Vr_ph + Z * Ir1;
Voltage_reg = (abs(Vs_P) - abs(Vr_ph)) / abs(Vr_ph) * 100; 
P_Sp = (P_R/3) + (R * Ir * Ir);
Efficiency = (P_R/3) / P_Sp * 100; 
fprintf('\nShort Transmission Line:\n'); 
fprintf('Efficiency = %.2f%%\n', Efficiency);
fprintf('Voltage Regulation = %.2f%%\n', Voltage_reg);

elseif Type == 2
%% Nominal-T Method
A = 1 + (Y * Z) / 2;
B = Z * (1 + (Y * Z) / 4);
C = Y;
D = A;
Vs_P = A * Vr_ph + B * Ir1; 
Is_P = C * Vr_ph + D * Ir1; 
P_Sp = (P_R/3) + (R * Ir * Ir);
Efficiency = (P_R/3) / P_Sp * 100;
Voltage_reg = (abs(Vs_P) - abs(Vr_ph)) / abs(Vr_ph) * 100; 
fprintf('\nNominal-T Method:\n');
fprintf('Efficiency = %.2f%%\n', Efficiency); 
fprintf('Voltage Regulation = %.2f%%\n', Voltage_reg);

elseif Type == 3
%% Nominal-Pi Method
A = 1 + (Y * Z) / 2;
B = Z;
C = Y * (1 + (Y * Z) / 4);
D = A;
Vs_P = A * Vr_ph + B * Ir1; 
Is_P = C * Vr_ph + D * Ir1; 
P_Sp = (P_R/3) + (R * Ir * Ir);
Efficiency = (P_R/3) / P_Sp * 100;
Voltage_reg = (abs(Vs_P) - abs(Vr_ph)) / abs(Vr_ph) * 100; 
fprintf('\nNominal-Pi Method:\n');
fprintf('Efficiency = %.2f%%\n', Efficiency); 
fprintf('Voltage Regulation = %.2f%%\n', Voltage_reg);

elseif Type == 4
%% Long Transmission Line 
gamma = sqrt(Y * Z);
Zc = sqrt(Z / Y);
A = cosh(gamma * length);
B = Zc * sinh(gamma * length);
C = (1 / Zc) * sinh(gamma * length);
D = A;
Vs_P = A * Vr_ph + B * Ir1; 
Is_P = C * Vr_ph + D * Ir1; 
P_Sp = (P_R/3) + (R * Ir * Ir);
Efficiency = (P_R/3) / P_Sp * 100;
Voltage_reg = (abs(Vs_P) - abs(Vr_ph)) / abs(Vr_ph) * 100; 
fprintf('\nLong Transmission Line:\n'); 
fprintf('Efficiency = %.2f%%\n', Efficiency); 
fprintf('Voltage Regulation = %.2f%%\n', Voltage_reg);
else 
fprintf('Invalid Selection. Please restart and choose a valid option.\n');
end

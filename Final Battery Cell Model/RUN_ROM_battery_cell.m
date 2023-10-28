clear all
close all
clc

%%Choose what model are you going to run
Battery_Model = 5; % 1: FDM Model without Degradation (FDM)
                   % 2: FDM Model with Linearized Degradation (FDM LM)
                   % 3: FDM Model with Nonlinear Degradation (FDM NM)
                   % 4: Pade Model without Degradation (Pade)
                   % 5: Pade Model with Degradation (Pade-D)
                   % 6: Optimization Model (O-B Model)

%%Choose which parameters are you going to use (Skip this part if you choose the no degradation model)        
%________________________________________________________________________________________________

Parameters = 'SD'; %SD: General Parameters
                   %BD: Increased Parameters (Boosted Parameters)
load([Parameters,'.mat'])

%%select which order model are you going to simulate
%________________________________________________________________________________________________

%FDM Model
FDM_N = 33;

%________________________________________________________________________________________________

%FDM LM Model (Lin)
FDM_LM_N = 50;

%________________________________________________________________________________________________

%FDM NM Model
%load NM Map
NM_map = ['degradation_map_',Parameters,'.mat']; %'degradation_map_SD.mat'; -> Nonlinear map using general (standard parameters)
                                                %'degradation_map_BD.mat'; -> Nonlinear map using increased parameters
                             
FDM_NM_N = 50;

%________________________________________________________________________________________________

%Pade Model
%Pade Model Coefficients
load('Pade_coefficients.mat')

Pade = 6;
PN = Pade_6_n; %negative electrode pade approximation coefficients
PP = Pade_6_p; %positive electrode pade approximation coefficients

%________________________________________________________________________________________________

%Pade-D Model
%Pade-D Model Coefficients
load(['Pade_D_coefficients_',Parameters,'.mat'])

Pade_D = 3;
PN_D = Pade_3_n_D; %negative electrode pade approximation coefficients
PP_D = Pade_3_p_D; %positive electrode pade approximation coefficients

%________________________________________________________________________________________________

%O-B model
%O-B Model design variables
load(['design_variables_data_',Parameters,'.mat'])

ROM_order = 3;
theta_n = n3; %negative electrode design variables data
theta_p = p3; %positive electrode design variables data

%________________________________________________________________________________________________
%%input current
t = [0 1000 7000];
u = [1 1 1];

file_name = 'UDDS_current_profile_8340.mat'; 
test_data = load(file_name); 
% t = test_data.time;
% u = test_data.UDDS_current_profile;

%________________________________________________________________________________________________

%%Parameter
%Negative
n.R_n = 3.5*10^(-4); 
n.D_n = 5.29*10^(-11);
n.L_n = 3.4*10^-3;
n.A_n = 1818; 
n.e_n = 0.55;
n.a_n = 3*n.e_n/n.R_n; 
n.c_max_n = 31.07*10^(-3);
n.theta_0n = 0;
n.theta_100n = 0.8;
n.R_film_n = 0.001;
n.alpha_n = 0.5;

%Positive
p.R_p = 3.65*10^(-6); 
p.D_p = 1.18*10^(-14);
p.L_p = 7.0*10^-3;
p.A_p = 1771; 
p.e_p = 0.41;
p.a_p = 3*p.e_p/p.R_p; 
p.c_max_p = 22.806*10^(-3);
p.theta_0p = 0.76;
p.theta_100p = 0.03;
p.R_film_p = 0;

c.F = 96487; 
c.T_ref = 298.15;
c.T_inf = 298.15;
c.R_c = 0;
c.R_u = 8.314;
c.c_e = 1.2*10^(-3);
c.k_ref_p = 1.0614*10^(-4);
c.k_ref_n = 0.079;
c.E_a_p = 25*10^(3);
c.E_a_n = 40*10^(3);
a_p = 3*p.e_p/p.R_p;
a_n = 3*n.e_n/n.R_n;

d.K_p = 0.0575;
d.R_sei = 0.001;
d.M_p = 0.162;
d.rho_p = 1690*10^(-6); 
d.U_ref_s = 0.4;

%________________________________________________________________________________________________

n_Li = p.e_p*p.A_p*p.L_p*p.theta_0p*p.c_max_p + n.e_n*n.A_n*n.L_n*n.theta_0n*n.c_max_n; %number of moles
Q_nom =c.F*p.e_p*p.A_p*p.L_p*(p.theta_0p-p.theta_100p)*p.c_max_p; %nominal capacity

x1_initial = 1*Q_nom; %charge level

C_avg_p = (-1/(c.F*p.e_p*p.A_p*p.L_p))*x1_initial + p.theta_0p*p.c_max_p;
C_avg_n = (1/(n.e_n*n.A_n*n.L_n))*(n_Li-(p.e_p*p.A_p*p.L_p*C_avg_p));

%________________________________________________________________________________________________
%Initiial Condition
%FDM Model Initial Condition
initial_p = repmat(C_avg_p, 1, FDM_N-1);
initial_n = repmat(C_avg_n, 1, FDM_N-1);

%FDM LM Model Initial Condition
initial_p_lm = repmat(C_avg_p, 1, FDM_LM_N-1);
initial_n_lm = repmat(C_avg_n, 1, FDM_LM_N-1);

%FDM NM Model Initial Condition
initial_p_nm = repmat(C_avg_p, 1, FDM_NM_N-1);
initial_n_nm = repmat(C_avg_n, 1, FDM_NM_N-1);

%Pade Model Initial Condition
x_initial_n_pade = zeros(1,Pade);
x_initial_n_pade(1,1) = C_avg_n/PN(1);
x_initial_p_pade = zeros(1,Pade);
x_initial_p_pade(1,1) = C_avg_p/PP(1);

%Pade-D Model Initial Condition
x_initial_n_pade_D = zeros(1,Pade_D);
x_initial_n_pade_D(1,1) = C_avg_n/PN_D(1);
x_initial_p_pade_D = zeros(1,Pade_D);
x_initial_p_pade_D(1,1) = C_avg_p/PP_D(1);

%O-B Model Initial Condition
x_initial_n = zeros(1,ROM_order);
x_initial_n(1,1) = C_avg_n;
x_initial_p = zeros(1,ROM_order);
x_initial_p(1,1) = C_avg_p;
%________________________________________________________________________________________________
%If you want to linearized the side reaction current density in different
%value you have to change below parameters.
c.c_bar = n.c_max_n*0.5;
c.u_bar = 0;

syms c_s_n I

theta_nn = c_s_n/n.c_max_n;

U_ref_n = 0.7222 + 0.1387*theta_nn + 0.029*theta_nn^(1/2) - (0.0172/theta_nn) + (0.0019/theta_nn^(1.5)) + 0.2808*exp(0.9-15*theta_nn) - 0.7984*exp(0.4465*theta_nn-0.4108);

k_n = 0.079;%(c.k_ref_n*exp((c.E_a_n/c.R_u)*((1/T)-(1/c.T_ref))));

A = n.a_n*k_n*((c.c_e)^(n.alpha_n))*((n.c_max_n - c_s_n)^(n.alpha_n))*(c_s_n^(n.alpha_n))*(exp(((n.alpha_n*c.F)/(c.R_u*c.T_inf))*(d.U_ref_s - U_ref_n)));
B = n.a_n*k_n*((c.c_e)^(n.alpha_n))*((n.c_max_n - c_s_n)^(n.alpha_n))*(c_s_n^(n.alpha_n))*(exp(((-n.alpha_n*c.F)/(c.R_u*c.T_inf))*(d.U_ref_s - U_ref_n)));

J_tot_n = I/(n.A_n*n.L_n);

%side reaction current density
J_s = J_tot_n - ((2*B+n.a_n*d.i_o_s)*(J_tot_n) + n.a_n*d.i_o_s*sqrt((J_tot_n.^2)+4*A*(B+d.i_o_s*n.a_n)))/(2*(B+n.a_n*d.i_o_s));

%alpha - linearized side reaction current density equation coefficient
d.alpha = double(subs(diff(J_s,c_s_n),[c_s_n,I],[c.c_bar,c.u_bar]));

%beta - linearized side reaction current density equation coefficient
d.beta = double(subs(diff(J_s,I),[c_s_n,I],[c.c_bar,c.u_bar]));

%J_bar - linearized side reaction current density equation coefficient
d.J_bar = double(subs(J_s,[c_s_n,I],[c.c_bar,c.u_bar]));

%________________________________________________________________________________________________

t_final = 2000;

ans = sim('battery_cell_model.slx',t_final)

save OB_N_3_fs.mat
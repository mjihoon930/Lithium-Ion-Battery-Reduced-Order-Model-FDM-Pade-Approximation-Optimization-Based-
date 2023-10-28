function [D] = side_reaction_coefficients(in)
 
syms c_s_n I

persistent  n c d

t = in(1);

if t==0  
    n = evalin('base','n');
    c = evalin('base','c');
    d = evalin('base','d');
end

theta_n = c_s_n/n.c_max_n;

U_ref_n = 0.7222 + 0.1387*theta_n + 0.029*theta_n^(1/2) - (0.0172/theta_n) + (0.0019/theta_n^(1.5)) + 0.2808*exp(0.9-15*theta_n) - 0.7984*exp(0.4465*theta_n-0.4108);

k_n = 0.079;%(c.k_ref_n*exp((c.E_a_n/c.R_u)*((1/T)-(1/c.T_ref))));

A = n.a_n*k_n*((c.c_e)^(n.alpha_n))*((n.c_max_n - c_s_n)^(n.alpha_n))*(c_s_n^(n.alpha_n))*(exp(((n.alpha_n*c.F)/(c.R_u*c.T_inf))*(d.U_ref_s - U_ref_n)));
B = n.a_n*k_n*((c.c_e)^(n.alpha_n))*((n.c_max_n - c_s_n)^(n.alpha_n))*(c_s_n^(n.alpha_n))*(exp(((-n.alpha_n*c.F)/(c.R_u*c.T_inf))*(d.U_ref_s - U_ref_n)));

J_tot_n = I/(n.A_n*n.L_n);

%side reaction current density
J_s = J_tot_n - ((2*B+n.a_n*d.i_o_s)*(J_tot_n) + n.a_n*d.i_o_s*sqrt((J_tot_n.^2)+4*A*(B+d.i_o_s*n.a_n)))/(2*(B+n.a_n*d.i_o_s));

%alpha - linearized side reaction current density equation coefficient
D(1) = double(subs(diff(J_s,c_s_n),[c_s_n,I],[c.c_bar,c.u_bar]));

%beta - linearized side reaction current density equation coefficient
D(2) = double(subs(diff(J_s,I),[c_s_n,I],[c.c_bar,c.u_bar]));

%J_bar - linearized side reaction current density equation coefficient
D(3) = double(subs(J_s,[c_s_n,I],[c.c_bar,c.u_bar]));

end
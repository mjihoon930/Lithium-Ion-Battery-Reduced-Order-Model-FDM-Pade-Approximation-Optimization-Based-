function out =state_eqns_fdm_lm_n(in)

persistent n c d FDM_LM_N

t=in(1);

if t==0
    
    c = evalin('base','c');
    n = evalin('base','n');
    d = evalin('base','d');
    FDM_LM_N = evalin('base','FDM_LM_N');
    
end

u = in(2); %current

dr = n.R_n/FDM_LM_N;

A = matrix_A_n(FDM_LM_N); %state space model A matrix

C_n=in(3:end); %state vector of negative concentration

C = A*C_n;
C(end) = n.D_n*((dr*(FDM_LM_N-1)-dr)*C_n(end-1))/(dr*(FDM_LM_N-1)*dr^2) + (n.D_n/(dr*(FDM_LM_N-1)*dr^2))*(-2*dr*(FDM_LM_N-1) + (dr*(FDM_LM_N-1)+dr)*(1/(1-(dr*d.alpha/(n.a_n*n.D_n*c.F)))))*C_n(end) + ((n.D_n*(dr*(FDM_LM_N-1)+dr))/(dr*(FDM_LM_N-1)*dr*(n.D_n*n.a_n*c.F-dr*d.alpha)))*((-1/(n.A_n*n.L_n))+d.beta)*u + ((n.D_n*(dr*(FDM_LM_N-1)+dr))/(dr*(FDM_LM_N-1)*dr))*(-1/(n.D_n*n.a_n*c.F-dr*d.alpha))*(-d.J_bar+d.alpha*c.c_bar+d.beta*c.u_bar); %last state equation of the state space model

out = C;
end



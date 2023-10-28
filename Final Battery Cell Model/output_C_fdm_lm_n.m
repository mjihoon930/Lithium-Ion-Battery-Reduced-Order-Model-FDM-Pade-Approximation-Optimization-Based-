function [Y] = output_C_fdm_lm_n(in)

persistent n c d FDM_LM_N

t=in(1);


if t==0
    
    c = evalin('base','c');
    n = evalin('base','n');
    d = evalin('base','d');
    FDM_LM_N = evalin('base','FDM_LM_N');
    
end

dr_n = n.R_n/FDM_LM_N;

%State Space Model C matrix
for i=FDM_LM_N-1
    C(1,i)=0;
    if i==FDM_LM_N-1
        C(1,i)=1;
    end
end

u=in(2); %current
c_n = in(3:end); %state vector of the negative concentration

%C*c_n is the concentration at N-1

%Negative Surface concentration
Y(1) = C*c_n*(1/(1-(dr_n*d.alpha/(n.D_n*n.a_n*c.F)))) + dr_n*((d.beta-(1/(n.A_n*n.L_n)))/((n.D_n*n.a_n*c.F)-dr_n*d.alpha))*u + dr_n*((d.J_bar-d.alpha*c.c_bar-d.beta*c.u_bar)/((n.D_n*n.a_n*c.F)-dr_n*d.alpha));
end
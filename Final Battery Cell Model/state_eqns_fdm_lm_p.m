function out =state_eqns_fdm_lm_p(in)

persistent FDM_LM_N

t=in(1);


if t==0
    
    FDM_LM_N = evalin('base','FDM_LM_N');
    
end

u = in(2);

A = matrix_A_p(FDM_LM_N); %positive electrode state space model A matrix
B = matrix_B_p(FDM_LM_N); %positive electrode state space model B matrix

C=in(3:end); %state vector of the positive concentration

out = A*C+B*u;


end
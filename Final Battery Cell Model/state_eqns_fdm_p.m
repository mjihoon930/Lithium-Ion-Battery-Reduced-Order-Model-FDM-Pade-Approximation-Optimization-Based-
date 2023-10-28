function out =state_eqns_fdm_p(in)

persistent FDM_N

t=in(1);


if t==0
    
    FDM_N = evalin('base','FDM_N');
    
end

u = in(2);

A = matrix_A_p(FDM_N); %positive electrode state space model A matrix
B = matrix_B_p(FDM_N); %positive electrode state space model B matrix

C=in(3:end); %state vector of the positive concentration

out = A*C+B*u;


end
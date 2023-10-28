function out =state_eqns_fdm_nm_p(in)

persistent FDM_NM_N

t=in(1);


if t==0
    
    FDM_NM_N = evalin('base','FDM_NM_N');

end

u = in(2); %current

A = matrix_A_p(FDM_NM_N);
B = matrix_B_p(FDM_NM_N);

C_p=in(3:end); %state vector of positive concentration

out = A*C_p+B*u;


end
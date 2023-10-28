function out =state_eqns_fdm_nm_n(in)

persistent n FDM_NM_N NM_map

t=in(1);

if t==0
    
    n = evalin('base','n');
    FDM_NM_N = evalin('base','FDM_NM_N');
    NM_map = evalin('base','NM_map');

end

I = in(2); %current

dr = n.R_n/FDM_NM_N;

A = matrix_A_n(FDM_NM_N); %State Space model A matrix

C_n=in(3:end); %state vector of concentration

%Nonlinear Map
load(NM_map);
g = interp2(u,cN1,csn_out,I,C_n(end));

%State Space model
C = A*C_n;
C(end) = (n.D_n/(dr*(FDM_NM_N-1)*dr^2))*((dr*(FDM_NM_N-1)+dr)*g-2*(dr*(FDM_NM_N-1))*C_n(end)+(dr*(FDM_NM_N-1)-dr)*C_n(end-1)); %Last State Equation of the state space model

out = C;

end



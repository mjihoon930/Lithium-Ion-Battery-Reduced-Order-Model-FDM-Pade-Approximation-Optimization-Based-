function Y = output_C_fdm_nm_p(in)

persistent p c FDM_NM_N

t=in(1);


if t==0
    
    c = evalin('base','c');
    p = evalin('base','p');
    FDM_NM_N = evalin('base','FDM_NM_N');

end

dr_p = p.R_p/FDM_NM_N;

%State Space Model C matrix
for i=1:FDM_NM_N-1
    C(1,i)=0;
    if i==FDM_NM_N-1
        C(1,i)=1;
    end
end

u=in(2);
c_p = in(3:end); %state vector of positive concentration

D = dr_p/(p.D_p*p.a_p*p.L_p*c.F*p.A_p); %state space model D matrix

%Positive surface concentration
Y = C*c_p + D*u;
end
function Y = output_C_FDM_p(in)

persistent p c FDM_N

t=in(1);

if t==0
    
    c = evalin('base','c');
    p = evalin('base','p');
    FDM_N = evalin('base','FDM_N');
    
end

dr_p = p.R_p/FDM_N;

%state space model C matrix
for i=1:FDM_N-1
    C(1,i)=0;
    if i==FDM_N-1
        C(1,i)=1;
    end
end

u=in(2); %current
c_p = in(3:end); %state vector of the positive concentration

D = dr_p/(p.D_p*p.a_p*p.L_p*c.F*p.A_p); %positive electrode state space model D matrix

Y = C*c_p + D*u; %positive surface concentration
end
function Y = output_C_FDM_n(in)

persistent n c FDM_N

t=in(1);

if t==0
    
    c = evalin('base','c');
    n = evalin('base','n');
    FDM_N = evalin('base','FDM_N');
    
end

dr_n = n.R_n/FDM_N;

%state space model C matrix
for i=1:FDM_N-1
    C(1,i)=0;
    if i==FDM_N-1
        C(1,i)=1;
    end
end

u=in(2); %current
c_n = in(3:end); %state vector of the negative concentration

D = -dr_n/(n.D_n*n.a_n*n.L_n*c.F*n.A_n); %negative electrode state space model D matrix

Y = C*c_n + D*u; %negative surface concentration

end
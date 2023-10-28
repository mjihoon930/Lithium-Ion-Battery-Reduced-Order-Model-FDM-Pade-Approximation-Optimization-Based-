function [out] = state_eqns_pade_d_n(in)
persistent d n C_avg_n a_n c Pade_D PN_D
t=in(1);

if t==0
    
    d = evalin('base','d');
    n = evalin('base','n');
    c = evalin('base','c');
    a_n = evalin('base','a_n');
    C_avg_n = evalin('base','C_avg_n');
    Pade_D = evalin('base', 'Pade_D');
    PN_D = evalin('base', 'PN_D');
    
end

u = in(2);
x = in(3:end); %state vector

%input of the state space model
U = (1/(n.D_n*a_n*c.F))*((u/(n.A_n*n.L_n)) - d.J_bar - d.alpha*C_avg_n + d.alpha*d.c_bar - d.beta*u + d.beta*d.u_bar);

%negative electrode state space model A & B matrix
for i = 1:Pade_D
    
    B(i,1) = 0;
    if i == Pade_D
        B(i,1) = 1/PN_D(end);
    end
    
    for j = 1:Pade_D
        
        if j==i+1
        A(i,j) = 1;
        else
            A(i,j) = 0;
        end
         A(Pade_D,1) = -1/PN_D(end);
             for k = 1:Pade_D-1
             A(Pade_D,k+1) = - PN_D(Pade_D+k+1)/PN_D(end);
             end
    end
end

%state equations
out = A*x + B*U;

end
function C_n = output_C_pade_D_n(in)

persistent  d n c a_n C_avg_n Pade_D PN_D

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

%State Space Model C matrix
for i=2:Pade_D
    C(1,1)=(PN_D(1) - PN_D(end - Pade_D)/PN_D(end));
    C(1,i)=(PN_D(i) - (PN_D(end - Pade_D)*PN_D(i+Pade_D))/PN_D(end));
end

%State Space Model D matrix
D = PN_D(end - Pade_D)/PN_D(end);

C_n = C*x+D*U; %negative surface concentration

end
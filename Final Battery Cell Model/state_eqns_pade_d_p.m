function [out] = state_eqns_pade_d_p(in)

persistent Pade_D PP_D

t=in(1);

if t==0
    
    Pade_D = evalin('base', 'Pade_D');
    PP_D = evalin('base', 'PP_D');
    
end

u = in(2);
x = in(3:end); %state vector

%negative electrode state space model A & B matrix
for i = 1:Pade_D
    
    B(i,1) = 0;
    if i == Pade_D
        B(i,1) = 1/PP_D(end);
    end
    
    for j = 1:Pade_D
        
        if j==i+1
        A(i,j) = 1;
        else
            A(i,j) = 0;
        end
         A(Pade_D,2) = -1/PP_D(end);
         if Pade_D > 2
             for k = 1:Pade_D-2
             A(Pade_D,k+2) = - PP_D(Pade_D+k)/PP_D(end);
             end
         end
    end
end

%state equations
out = A*x + B*u;


end
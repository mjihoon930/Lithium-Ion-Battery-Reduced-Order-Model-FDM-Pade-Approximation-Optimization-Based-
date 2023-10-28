function out = state_eqns_pade_p(in)

persistent Pade PP

t=in(1);

if t==0
    
    Pade = evalin('base', 'Pade');
    PP = evalin('base', 'PP');
    
end

u = in(2);
x = in(3:2+Pade); %state vector 

%negative electrode state space model A & B matrix
for i = 1:Pade
    
    B(i,1) = 0;
    if i == Pade
        B(i,1) = 1/PP(end);
    end
    
    for j = 1:Pade
        
        if j==i+1
        A(i,j) = 1;
        else
            A(i,j) = 0;
        end
         A(Pade,2) = -1/PP(end);
         if Pade > 2
             for k = 1:Pade-2
             A(Pade,k+2) = - PP(Pade+k)/PP(end);
             end
         end
    end
end

%state equations
out = A*x + B*u;

end
function C_p = output_C_pade_p(in)

persistent  Pade PP

t=in(1);

if t==0

    Pade = evalin('base', 'Pade');
    PP = evalin('base', 'PP');

end


x = in(2:end); %state vector 

%State Space Model C matrix
for i=1:Pade
    C(1,i)=PP(i);
end

C_p = C*x; %negative surface concentration

end
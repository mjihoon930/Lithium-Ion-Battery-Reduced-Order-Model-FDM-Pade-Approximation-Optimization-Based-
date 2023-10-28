function C_p = output_C_pade_D_p(in)

persistent  Pade_D PP_D

t=in(1);

if t==0

    Pade_D = evalin('base', 'Pade_D');
    PP_D = evalin('base', 'PP_D');

end


x = in(2:end); %state vector 

%State Space Model C matrix
for i=1:Pade_D
    C(1,i)=PP_D(i);
end

C_p = C*x; %negative surface concentration

end
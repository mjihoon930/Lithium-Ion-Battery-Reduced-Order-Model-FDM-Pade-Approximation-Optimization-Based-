function C_n = output_C_pade_n(in)

persistent  Pade PN

t=in(1);

if t==0

    Pade = evalin('base', 'Pade');
    PN = evalin('base', 'PN');

end


x = in(2:end); %state vector 

%State Space Model C matrix
for i=1:Pade
    C(1,i)=PN(i);
end

C_n = C*x; %negative surface concentration

end
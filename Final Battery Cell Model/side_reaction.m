function J_s = side_reaction(in)

persistent  c d

t = in(1);

if t==0  

    c = evalin('base','c');
    d = evalin('base','d');

end

u = in(2); %current
c_s_n = in(3); %negative surface concentration

J_s = d.J_bar + d.alpha*(c_s_n-c.c_bar) + d.beta*(u-c.u_bar); %linearized side reaction current density
end
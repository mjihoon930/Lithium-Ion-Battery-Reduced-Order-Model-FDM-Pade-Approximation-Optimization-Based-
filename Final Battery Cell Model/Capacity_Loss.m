function Q_loss = Capacity_Loss(in)

persistent n

t=in(1);

if t==0
    
    n = evalin('base','n');
    
end

J_s=in(2);
Q_loss = in(3);

Q_loss = -n.L_n*n.A_n*J_s;

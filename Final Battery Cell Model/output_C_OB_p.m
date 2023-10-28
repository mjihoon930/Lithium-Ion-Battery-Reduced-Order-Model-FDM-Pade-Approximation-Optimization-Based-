function C = output_C_OB_p(in)

persistent theta_p ROM_order

t=in(1);

if t==0
    
    theta_p = evalin('base','theta_p');
    ROM_order = evalin('base','ROM_order');

end

%state space model C matrix
for i  = 2:ROM_order
    
    C_p(1,1) = 1;
    C_p(1,i) = theta_p((i-1) + ((ROM_order*(ROM_order+1))/2) + ROM_order); % positive electrode C matrix

end

%state space model D matrix
D_p = theta_p(end); % positive electrode D matrix

u = in(2); %current
x_p = in(3:end); %positive electrode state vector of the state space model

C = C_p*x_p + D_p*u; %state space model of the postiive electrode

end
function C = output_C_OB_n(in)

persistent theta_n ROM_order

t=in(1);

if t==0
    
    theta_n = evalin('base','theta_n');
    ROM_order = evalin('base','ROM_order');

end

%state space model C matrix
for i  = 2:ROM_order
    
    C_n(1,1) = 1;
    C_n(1,i) = theta_n((i-1) + ((ROM_order*(ROM_order+1))/2) + ROM_order); % negative electrode C matrix

end

%state space model D matrix
D_n = theta_n(end); % negative electrode D matrix

u = in(2); %current
x_n = in(3:end); %negative electrode state vector of the state space model

C = C_n*x_n + D_n*u; %state space model of the negative electrode

end
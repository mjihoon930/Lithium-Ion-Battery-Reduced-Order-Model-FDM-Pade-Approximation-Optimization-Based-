function [out] = state_eqns_p_OB(in)
persistent theta_p ROM_order
t=in(1);

if t==0
    theta_p = evalin('base','theta_p');
    ROM_order = evalin('base','ROM_order');
end

u = in(2);
x = in(3:2+ROM_order); %positive electrode state vector of the state space model

theta_last = 0;
    for i  = 1:ROM_order
        for j = 1:ROM_order
            if i<=j
                A(i,j) = theta_p(1,theta_last+1); %state space model A matrix
                theta_last = theta_last + 1;
            else
                A(i,j) = 0;
            end
            B(j,1) = theta_p(j+(ROM_order*(ROM_order+1))/2); %state space model B matrix
        end
    end
    
[out] = A*x + B*u;

end
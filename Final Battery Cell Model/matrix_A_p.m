function M = matrix_A_p(N)

p.R_p = 3.65*10^(-6); 
p.D_p = 1.18*10^(-14);
p.L_p = 7.0*10^-3;
p.A_p = 1771; 
p.e_p = 0.41;
p.a_p = 3*p.e_p/p.R_p; 
p.c_max_p = 22.806*10^(-3);
p.theta_0p = 0.76;
p.theta_100p = 0.03;
p.R_film_p = 0;

dr = p.R_p/N;

for i = 1:N-1
    r(i) = dr*(i);
    for j = 1:N-1
        if j <= i - 2
            A(i,j) = 0;
        elseif j >= i + 2
            A(i,j) = 0;
        else
            if i==j
               A(i,j) = (-2*p.D_p)/(dr^(2));
                if i== N-1 && j==N-1
                A(i,j) = -(p.D_p*(r(N-1)-dr))/(r(N-1)*(dr)^2);
                end
            elseif j==i+1
                    A(i,j) = (p.D_p*(r(i)+dr))/(r(i)*(dr)^2);
            elseif i==j+1
                    A(i,j) = (p.D_p*(r(i)-dr))/(r(i)*(dr)^2);
            end
        end
    end
end

M = A;

end
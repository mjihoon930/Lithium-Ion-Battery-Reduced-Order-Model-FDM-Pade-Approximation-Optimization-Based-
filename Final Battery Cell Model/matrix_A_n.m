function M = matrix_A_n(N)

n.R_n = 3.5*10^(-4); 
n.D_n = 5.29*10^(-11);
n.L_n = 3.4*10^-3;
n.A_n = 1818; 
n.e_n = 0.55;
n.a_n = 3*n.e_n/n.R_n; 
n.c_max_n = 31.07*10^(-3);
n.theta_0n = 0;
n.theta_100n = 0.8;
n.R_film_n = 0.001;

dr = n.R_n/N;

for i = 1:N-1
    r(i) = dr*(i);
    for j = 1:N-1
        if j <= i - 2
            A(i,j) = 0;
        elseif j >= i + 2
            A(i,j) = 0;
        else
            if i==j
               A(i,j) = (-2*n.D_n)/(dr^(2));
                if i== N-1 && j==N-1
                A(i,j) = -(n.D_n*(r(N-1)-dr))/(r(N-1)*(dr)^2);
                end
            elseif j==i+1
                    A(i,j) = (n.D_n*(r(i)+dr))/(r(i)*(dr)^2);
            elseif i==j+1
                    A(i,j) = (n.D_n*(r(i)-dr))/(r(i)*(dr)^2);
            end
        end
    end
end

M = A;

end
function M = matrix_B_n(N)

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
c.F = 96487; 

dr = n.R_n/N;

for i = 1:N-1
    
    r(i) = dr*(i);
    B(i,1) = 0;
    
    if i == N-1
        B(i,1) = -(r(N-1)+dr)/(r(N-1)*dr*n.a_n*c.F*n.A_n*n.L_n);
    end
    
M = B;

end
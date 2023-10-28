function M = matrix_B_p(N)

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
c.F = 96487; 

dr = p.R_p/N;

for i = 1:N-1
    r(i) = dr*(i);
    B(i,1) = 0;
    
    if i == N-1
        B(i,1) = (r(N-1)+dr)/(r(N-1)*dr*p.a_p*c.F*p.A_p*p.L_p);
    end
    
M=B;
    
end
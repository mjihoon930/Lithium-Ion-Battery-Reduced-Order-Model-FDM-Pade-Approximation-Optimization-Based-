function Y = input_c(in)

t=in(1);

%Pulse input
Y = -7.*(exp(-0.1*t) + exp(-0.018*t));  

for i = 1:4
    if t > 400*i
    Y = -7.*(exp(-0.1*(t-400*i)) + exp(-0.018*(t-400*i)));
    end
end

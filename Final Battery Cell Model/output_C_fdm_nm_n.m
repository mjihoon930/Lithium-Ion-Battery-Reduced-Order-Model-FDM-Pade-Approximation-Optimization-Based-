function Y = output_C_fdm_nm_n(in)

persistent FDM_NM_N NM_map

t=in(1);


if t==0
    
    FDM_NM_N = evalin('base','FDM_NM_N');
    NM_map = evalin('base','NM_map');

end

%State Space Model C matrix
for i=FDM_NM_N-1
    C(1,i)=0;
    if i==FDM_NM_N-1
        C(1,i)=1;
    end
end

I=in(2);
c_n = in(3:end); %state vector of concentration

load(NM_map);
Y = interp2(u,cN1,csn_out,I,c_n(end)); %Negative Surface Concentration

end
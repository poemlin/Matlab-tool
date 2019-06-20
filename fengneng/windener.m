function [ msmw,memw,ewt ] = windener( k,c )
msmw = 1.29/2*c^3*gamma(1+3/k);
syms V
memw = k*1.29/2/(exp(-(2/c)^k)-exp(-(20/c)^k))/c^k*double(int(V^(k+2)*exp(-((V/c)^k)),V,3,20));
L=24*31;
ewt = L*(exp(-(3/c)^k)-exp(-(20/c)^k));

end


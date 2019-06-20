function [k,c ] = pjfshbzc( wind )
wind = wind(:);
S = std(wind);
mV = mean(wind);
k = (S/mV)^(-1.086);
c = mV/(gamma(1+1/(k)));
end


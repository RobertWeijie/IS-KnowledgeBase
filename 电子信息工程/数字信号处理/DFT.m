function [v] = DFT(k,y)
v=0;
    for i=0:1:204
        v=v+y(i+1)*exp(-j*2*pi/205*k*i);
    end
v=abs(v);
end


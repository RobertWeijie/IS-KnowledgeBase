function [s] = Sampling(y)
    V(1)=DFT(18,y);
    V(2)=DFT(20,y);
    V(3)=DFT(22,y);
    V(4)=DFT(24,y);
    V(5)=DFT(31,y);
    V(6)=DFT(34,y);
    V(7)=DFT(38,y);
    V(8)=DFT(42,y);
    if V(1)>=80&&V(5)>=80
        s='1';
    elseif V(1)>=80&&V(6)>=80
        s='2';
    elseif V(1)>=80&&V(7)>=80
        s='3';
    elseif V(1)>=80&&V(8)>=80
        s='A';
    elseif V(2)>=80&&V(5)>=80
        s='4';
    elseif V(2)>=80&&V(6)>=80
        s='5';
    elseif V(2)>=80&&V(7)>=80
        s='6';
    elseif V(2)>=80&&V(8)>=80
        s='B';
    elseif V(3)>=80&&V(5)>=80
        s='7';
    elseif V(3)>=80&&V(6)>=80
        s='8';
    elseif V(3)>=80&&V(7)>=80
        s='9';
    elseif V(3)>=80&&V(8)>=80
        s='C';
    elseif V(4)>=80&&V(5)>=80
        s='#';
    elseif V(4)>=80&&V(6)>=80
        s='0';
    elseif V(4)>=80&&V(7)>=80
        s='*';
    elseif V(4)>=80&&V(8)>=80
        s='D';
    else
        s='E';
    end
end


function [S] = IdentifyNum(x)
%     clear
    m=length(x);
%     global flag
    l=1;
    b=0;
    sum=0;
    for i=1:1:100
        sum=sum+x(i)^2;
    end
    s(1)=sum/100;
    for i=2:1:(m-99)
        s(i)=(100*s(i-1)-x(i-1)^2+x(i+99)^2)/100;
    end
     if s(1)<0.65
         h=0;
     else
         h=1;
     end
    for i=1:1:(m-99)
        if s(i)<0.65
            h=0;
        end
        if (h==0)&&(s(i)>0.8)&&(s(i)>=s(i-1)&&s(i)>=s(i+1))
            S(l)=Sampling(x(i+100:1:i+304)); %富裕100个点取205个点到304，即100-304共205个点
            if S(l)=='E'||l>8
                S='已不能识别';
%                 flag=1;
                break
            end
            l=l+1;
            h=1;
        end
    end
%     if strcmp(s(1),'E')
%         S='已不能识别';

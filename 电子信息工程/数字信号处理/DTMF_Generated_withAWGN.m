function [f] = DTMF_Generated_withAWGN(PIC_Title,FileName,number,dB)
% number=input('������Ҫ��ת�����źţ�16���ַ���ɣ���ĸΪ��д��:','s');
l=length(number);  %��ȡ���ų���
space=245*rand(1,l+1)+10; %��������������
signal=190*rand(1,l)+60;  %���������������
for i=1:1:l
    if number(i)=='1'                  %���ɲ���������˫��Ƶ�źţ�Ƶ�ʵ�λΪkHz
        f(1,i)=0.697; f(2,i)=1.209;
    elseif number(i)=='2'
        f(1,i)=0.697; f(2,i)=1.336;
    elseif number(i)=='3'
        f(1,i)=0.697; f(2,i)=1.477;
    elseif number(i)=='4'
        f(1,i)=0.770; f(2,i)=1.209;
    elseif number(i)=='5'
        f(1,i)=0.770; f(2,i)=1.336;
    elseif number(i)=='6'
        f(1,i)=0.770; f(2,i)=1.477;
    elseif number(i)=='7'
        f(1,i)=0.852; f(2,i)=1.209;
    elseif number(i)=='8'
        f(1,i)=0.852; f(2,i)=1.336;
    elseif number(i)=='9'
        f(1,i)=0.852; f(2,i)=1.477;
    elseif number(i)=='0'
        f(1,i)=0.941; f(2,i)=1.336;
    elseif number(i)=='A'
        f(1,i)=0.697; f(2,i)=1.633;
    elseif number(i)=='B'
        f(1,i)=0.770; f(2,i)=1.633;
    elseif number(i)=='C'
        f(1,i)=0.852; f(2,i)=1.633;
    elseif number(i)=='D'
        f(1,i)=0.941; f(2,i)=1.633;
    elseif number(i)=='#'
        f(1,i)=0.941; f(2,i)=1.209;
    elseif number(i)=='*'
        f(1,i)=0.941; f(2,i)=1.477;
    end
end
    a=0;
    n=1;
    for  j=1:1:l
        for t=a:0.125:a+space(1,j)
            y(n)=0;
            n=n+1;
        end
        a=a+space(1,j);
        for t=a:0.125:a+signal(1,j)
            y(n)=cos(2*pi*f(1,j)*t)+cos(2*pi*f(2,j)*t);
            n=n+1;
        end
        a=a+signal(1,j);
    end
    for t=a:0.125:a+space(1,l+1)
        y(n)=0;
        n=n+1;
    end
    y=awgn(y,dB);                  %�����˹������������ȿɵ�
    dlmwrite(FileName,y);	  %��������д�롰DTMF_Data.txt��
    figure('NumberTitle','off','Name',PIC_Title);
    plot(y)                         %�����ź�ͼ��
end

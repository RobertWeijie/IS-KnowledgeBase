%��������16-QAM��ʽ������յ��ķ������У����ط������кͱ�����

function [re_bitter_stream,re_symbol_seq]=demodulation_16qam(re_data)

%re_data�����ջ������FFT�������,�����ź�
Num_symbol=length(re_data);
%��ʼ��
re_symbol_seq = zeros(1,Num_symbol);
re_bitter_streamI = zeros(1,2*Num_symbol);
re_bitter_streamQ = zeros(1,2*Num_symbol);

demodI=real(re_data); %�ָ���������ͼʵ��
demodQ=imag(re_data); %�ָ���������ͼ�鲿

%�о�����
for i=1:Num_symbol
    tmpI = 0;
    tmpQ = 0;
    if(demodI(i)<-2)     %I֧·�о�  00
        re_bitter_streamI(2*i-1:2*i)=[0 0];
        tmpI = -3;
    else if(demodI(i)<0)   %  01
            re_bitter_streamI(2*i-1:2*i)=[0 1];
            tmpI = -1;
        else if(demodI(i)<2)    %  11
                re_bitter_streamI(2*i-1:2*i)=[1 1];
                tmpI = 1;
            else     %  10
                re_bitter_streamI(2*i-1:2*i)=[1 0];
                tmpI = 3;
            end
        end
    end
    
    if(demodQ(i)<-2)     %Q֧·�о�  00
        re_bitter_streamQ(2*i-1:2*i)=[0 0];
        tmpQ = -3;
    else if(demodQ(i)<0)   %  01
            re_bitter_streamQ(2*i-1:2*i)=[0 1];
            tmpQ = -1;
        else if(demodQ(i)<2)    %  11
                re_bitter_streamQ(2*i-1:2*i)=[1 1];
                tmpQ = 1;
            else     %  10
                re_bitter_streamQ(2*i-1:2*i)=[1 0];
                tmpQ = 3;
            end
        end
    end
    
    re_symbol_seq(i) = tmpI + 1j*tmpQ;
end

d1 = reshape(re_bitter_streamI,2,Num_symbol);
d2 = reshape(re_bitter_streamQ,2,Num_symbol);

re_bitter_stream = reshape([d1;d2],1,Num_symbol*4);%���յ��ı�����ת����һ������


% ����-�������ͼ
%   0000           0100    (-3i)   1100           1000  
%                            |
%                            |
%                            |
%                            |
%                            |
%   0001           0101    (-1i)   1101           1001  
%                            |
%                            |
% ��(-3)������������(-1)������*������(1)������������(-3)����
%                            |
%                            |
%   0011           0111    (1i)    1111           1011  
%                            |
%                            |
%                            |
%                            |
%                            |
%   0010           0110    (3i)    1110           1010 
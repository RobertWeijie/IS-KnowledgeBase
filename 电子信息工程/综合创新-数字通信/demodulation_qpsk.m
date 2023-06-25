%��������QPSK��ʽ������յ��ķ������У����ط������кͱ�����

function [re_bitter_stream,re_symbol_seq]=demodulation_qpsk(re_data)

%re_data�����ջ������FFT�������,�����ź�
Num_symbol=length(re_data);
%���ݳ�ʼ��
re_symbol_seq = zeros(1,Num_symbol);
re_bitter_streamI = zeros(1,Num_symbol);
re_bitter_streamQ = zeros(1,Num_symbol);
demodI=real(re_data);%�ָ���������ͼʵ��
demodQ=imag(re_data);%�ָ���������ͼ�鲿

for i=1:Num_symbol
    tmpI = 0;
    tmpQ = 0;
    if demodI(i) < 0 
        re_bitter_streamI(i) = 0;
        tmpI = -1;
    else 
        re_bitter_streamI(i) = 1;
        tmpI = 1;
    end
    if demodQ(i) < 0
        re_bitter_streamQ(i) = 0;
        tmpQ = -1;
    else
        re_bitter_streamQ(i) = 1;
        tmpQ = 1;
    end
    re_symbol_seq(i) = tmpI + 1j*tmpQ;
end


re_bitter_stream = reshape([re_bitter_streamI;re_bitter_streamQ],1,Num_symbol*2);
%���ܵ��ı�����ת����һ������

% ����-�������ͼ
%      00         (-i)        10  
%                  |
%                  |
%                  |
%                  |
% ����(-1)����������*����������(1)����
%                  |
%                  |
%                  |
%                  |
%      01         (i)         11
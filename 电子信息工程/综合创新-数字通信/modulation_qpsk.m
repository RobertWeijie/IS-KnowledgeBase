%��������QPSK��ʽ���Ʊ����������ص��ƺ�ķ�������

function [symbol_seq]=modulation_qpsk(bitter_stream)
%bitter_streamΪ����ı�����,symbol_seqΪӳ���ķ�������
%���ݳ�ʼ��
L=length(bitter_stream)/2;
symbol_seqI=zeros(1,L);
symbol_seqQ=zeros(1,L);

tmpI = 0;
tmpQ = 0;
for i=1:L
    switch bitter_stream(2*i-1)   %symbol_seqI
        case 0      
            tmpI = -1;
        case 1      
            tmpI = 1;
        otherwise
    end
    switch bitter_stream(2*i)   %symbol_seqQ
        case 0     
            tmpQ = -1;
        case 1      
            tmpQ = 1;
        otherwise
    end
    symbol_seqI(i) = tmpI;
    symbol_seqQ(i) = tmpQ;
end
symbol_seq = symbol_seqI + 1j * symbol_seqQ;
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




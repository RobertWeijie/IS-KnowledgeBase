%��������16-QAM��ʽ���Ʊ����������ص��ƺ�ķ�������

function [symbol_seq]=modulation_16qam(bitter_stream)
%bitter_streamΪ����ı�����,symbol_seqΪӳ���ķ�������
L=length(bitter_stream)/4;%I,Q֧·����ĳ���
symbol_seqI=ones(1,L);
symbol_seqQ=ones(1,L);


tmpI = 0;
tmpQ = 0;
for i=1:L
    switch (bitter_stream(4*i-3))*2+bitter_stream(4*i-2)   %symbol_seqI
        case 0     %  00 
            tmpI=-3;
        case 1     %  01 
            tmpI=-1;
        case 3     %  11 
            tmpI=1;
        case 2     %  10
            tmpI=3;
        otherwise
    end
    switch (bitter_stream(4*i-1))*2+bitter_stream(4*i)    %symbol_seqQ
        case 0     %  00 
            tmpQ=-3;
        case 1     %  01
            tmpQ=-1;
        case 3     %  11
            tmpQ=1;
        case 2     %  10 
            tmpQ=3;
        otherwise
    end
    symbol_seqI(i) = tmpI;
    symbol_seqQ(i) = tmpQ;
end

symbol_seq = symbol_seqI + 1j * symbol_seqQ;

end

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



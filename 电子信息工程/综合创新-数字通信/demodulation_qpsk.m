%函数：按QPSK方式解调接收到的符号序列，返回符号序列和比特流

function [re_bitter_stream,re_symbol_seq]=demodulation_qpsk(re_data)

%re_data，接收机解调和FFT后的星座,复数信号
Num_symbol=length(re_data);
%数据初始化
re_symbol_seq = zeros(1,Num_symbol);
re_bitter_streamI = zeros(1,Num_symbol);
re_bitter_streamQ = zeros(1,Num_symbol);
demodI=real(re_data);%恢复出的星座图实部
demodQ=imag(re_data);%恢复出的星座图虚部

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
%接受到的比特流转换成一个序列

% 调制-解调星座图
%      00         (-i)        10  
%                  |
%                  |
%                  |
%                  |
% ——(-1)—————*—————(1)——
%                  |
%                  |
%                  |
%                  |
%      01         (i)         11
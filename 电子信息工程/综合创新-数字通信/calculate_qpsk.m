%函数：通过输入信噪比、多径信道数目、蒙特卡洛仿真次数、循环前缀比值来计算QPSK的误码率和无符号率

function [BER,SER] = calculate_qpsk(SNR,L,M,CP)

%一、变量定义
N = 1024;%单周期符号个数
SsN0 = 10^(SNR/10); %将信噪比转换为线性比值

%二、生成传输数据
Num_bitter = N * 2 * M;
bt = randi([0 1],1,Num_bitter);  %生成二进制比特流

%三、将待传输数据调制并转化为时域信号，并加入循环前缀
x1 = modulation_qpsk(bt);%16-QAM调制
symbol_seq = x1; %记录传输前的符号序列
x1 = x1/sqrt(10);%符号平均功率归一化
x1 = reshape(x1,N,M);%串并转换，符号矩阵为1024行M列
x2 = ifft(x1); %通过对每一列做ifft，来得到信号的时域表示
x3 = [x2(N-N/CP+1:N,:);x2];%将每一列的后256（或其他）个符号提到前面作为循环前缀
x3 = x3.';%转置待发送的符号矩阵，方便后面的卷积函数conv运算，此时x3为M行1024列矩阵

%四、通过信道(多径信道L）
h = sqrt(1/2/L)*(randn(M,L)+1j*randn(M,L));%生成频率选择性信道，h为M行L列矩阵，每一行都是不同的信道
y = zeros(M,N+N/CP+L-1);%接收信号的存储矩阵
for k = 1:M
    y(k,:) = conv(x3(k,:),h(k,:));%对每一行信号和相应的信道做卷积运算
end

%五、加入噪声
p = sum(sum(abs(y.*y)))/(M*(N+N/CP+L-1));%计算接收信号的平均功率
sigma = sqrt(p/SsN0);%通过原信号功率和信噪比计算噪声的标准差
y = y + (sqrt((sigma^2)/2)*(randn(size(y))+1j*randn(size(y)))); %在接受信号中加入复高斯白噪声

%六、加窗截取接收信号，并转换为频域信息
y2 = y(:,N/CP+1:N+N/CP);%加窗截取，去掉循环前缀部分
y3 = fft(y2,N,2);%对接受信号的每一行做fft运算，得到原信号的频谱
H = fft(h,N,2);%对每一行信道做fft，得到信道的频谱
y4 = y3./H;%信道均衡
y4 = y4*sqrt(10);%将有误差的符号矩阵做归一化
y4 = y4.'; y4 = reshape(y4,1,N*M);%先转置，再reshape，得到符号序列

%七、解调信号，统计误码率
[receive_bt,re_symbol_seq] = demodulation_qpsk(y4);%解调
SER = (N*M - sum(re_symbol_seq == symbol_seq)) / N / M;%计算误符号率
BER = (Num_bitter - sum(receive_bt == bt)) / Num_bitter;%计算误比特率

end
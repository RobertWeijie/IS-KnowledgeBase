%脚本：用于仿真出不同循环前缀下误码率随多径信道数目L的变化曲线

L = 2:2:1000;%多径信道数目
SNR = 20;
len = length(L);
ber1 = zeros(1,len);%16QAM的误码率
ber2 = zeros(1,len);%QPSK的误码率
R = 1;%蒙特卡洛循环次数
CP = 2:4;%默认仿真了1/4 1/8 1/16 
CP = 2.^CP;%符号周期对循环前缀的比值
for k = CP
    len2 = len/k*4;
    %改变循环次数 ，优化性能， 结果可视化好
    if k == 8 
        len2 = len2 + 40;
    else if k == 16
            len2 = len2 + 45;
        end
    end
    
    for i = 1:len2
        [tmp1,] = calculate_16qam(SNR,L(i),R*k/4,k);
        ber1(i) = tmp1;%叠加之后取平均
        [tmp2,] = calculate_qpsk(SNR,L(i),R*k/4,k);
        ber2(i) = tmp2;%叠加之后取平均
    end
    plot(L(1:len2),ber1(1:len2),'-');
    hold on;
    plot(L(1:len2),ber2(1:len2),'-');
    hold on;

    ber1 = zeros(size(ber1));
    ber2 = zeros(size(ber2));
end
xlabel('多径信道L');
ylabel('误码率BER');
title('误码率与多径信道数目的关系');
grid on;
legend('16-qam 1/4','qpsk 1/4','16-qam 1/8','qpsk 1/8','16-qam 1/16','qpsk 1/16');



%脚本：用于仿真出误码率随信噪比SNR的变化曲线

L = 6;%多径信道数目
SNR = 0:1:25;%SNR序列
len = length(SNR);
ber1 = zeros(1,len);%16 QAM的误码率
ber2 = zeros(1,len);%QPSK的误码率
R = 10;%蒙特卡洛循环次数
for i = 1:length(SNR)
    [tmp1,] = calculate_16qam(SNR(i),L,R,4);
    [tmp2,] = calculate_qpsk(SNR(i),L,R,4);
    ber1(i) = tmp1;
    ber2(i) = tmp2;
end

plot(SNR,log10(ber1),'o-');
hold on;
plot(SNR,log10(ber2),'o-');

xlabel('信噪比SNR');
ylabel('误码率BER');
title('误码率与信噪比的关系');
grid on;
legend('16qam','qpsk');

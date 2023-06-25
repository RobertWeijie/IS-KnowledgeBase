%�ű������ڷ�����������������SNR�ı仯����

L = 6;%�ྶ�ŵ���Ŀ
SNR = 0:1:25;%SNR����
len = length(SNR);
ber1 = zeros(1,len);%16 QAM��������
ber2 = zeros(1,len);%QPSK��������
R = 10;%���ؿ���ѭ������
for i = 1:length(SNR)
    [tmp1,] = calculate_16qam(SNR(i),L,R,4);
    [tmp2,] = calculate_qpsk(SNR(i),L,R,4);
    ber1(i) = tmp1;
    ber2(i) = tmp2;
end

plot(SNR,log10(ber1),'o-');
hold on;
plot(SNR,log10(ber2),'o-');

xlabel('�����SNR');
ylabel('������BER');
title('������������ȵĹ�ϵ');
grid on;
legend('16qam','qpsk');

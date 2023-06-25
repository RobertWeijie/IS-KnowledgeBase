%�ű������ڷ������ͬѭ��ǰ׺����������ྶ�ŵ���ĿL�ı仯����

L = 2:2:1000;%�ྶ�ŵ���Ŀ
SNR = 20;
len = length(L);
ber1 = zeros(1,len);%16QAM��������
ber2 = zeros(1,len);%QPSK��������
R = 1;%���ؿ���ѭ������
CP = 2:4;%Ĭ�Ϸ�����1/4 1/8 1/16 
CP = 2.^CP;%�������ڶ�ѭ��ǰ׺�ı�ֵ
for k = CP
    len2 = len/k*4;
    %�ı�ѭ������ ���Ż����ܣ� ������ӻ���
    if k == 8 
        len2 = len2 + 40;
    else if k == 16
            len2 = len2 + 45;
        end
    end
    
    for i = 1:len2
        [tmp1,] = calculate_16qam(SNR,L(i),R*k/4,k);
        ber1(i) = tmp1;%����֮��ȡƽ��
        [tmp2,] = calculate_qpsk(SNR,L(i),R*k/4,k);
        ber2(i) = tmp2;%����֮��ȡƽ��
    end
    plot(L(1:len2),ber1(1:len2),'-');
    hold on;
    plot(L(1:len2),ber2(1:len2),'-');
    hold on;

    ber1 = zeros(size(ber1));
    ber2 = zeros(size(ber2));
end
xlabel('�ྶ�ŵ�L');
ylabel('������BER');
title('��������ྶ�ŵ���Ŀ�Ĺ�ϵ');
grid on;
legend('16-qam 1/4','qpsk 1/4','16-qam 1/8','qpsk 1/8','16-qam 1/16','qpsk 1/16');



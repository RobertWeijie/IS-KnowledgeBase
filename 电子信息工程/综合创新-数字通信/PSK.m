clear;
clc;

%参数设置
T = 1;%符号间隔
fc=40/T;%载波频率
N=10000;%符号数
Ns=100;
fs=1000;
SNR_dB = -5:30;%信噪比
SNR = 10.^(SNR_dB/10);%线性
s = randi([0,1],1,N);%原始信号
t = linspace(0,Ns,Ns*fs);%离散时间序列

%星座图
% BPSK
d1 = 1; 
A1= [-1;1]*d1;
figure(1);
scatter(real(A1),imag(A1),'filled'); %画出星座图
title('BPSK星座图');
% QPSK
d2=sqrt(2)/2;
A2= [1+1j*1;-1+1j*1;-1+1j*-1;1+1j*-1]*d2;
figure(2);
scatter(real(A2),imag(A2),'filled');%画出星座图
title('QPSK星座图');

% ----------------格雷码
Maptable1=[0;1];
Maptable2=[0,0;0,1;1,1;1,0];

    
% ----------------映射
% BPSK
for i=1:1:N
    for p=1:2
        if s(i)==Maptable1(p,:)
             X1(i)=A1(p);
             break;
        end
    end
end
% QPSK
for i=1:2:N
    for p=1:4
        if s(i:i+1)==Maptable2(p,:)
            X2((i+1)/2)=A2(p);
            break;
        end
    end
end    


% --------------调制
for i=1:Ns
    index=(i-1)*fs+1:i*fs; %第i个符号的离散时间序号
    Am1(index)=X1(i);
   
    Am2(index) = abs(X2(i));%QPSK幅度
    Ph(index) = atan(imag(X2(i))/real(X2(i)));%QPSK相位 
    g(index)=1;%方波脉冲成型  
    W1(index)= Am1(i).*g(index).*cos(2*pi*fc.*t(index));
    W2(index)= Am2(i).*g(index).*cos(2*pi*fc.*t(index)+Ph(index));
end
figure(3);
plot(t,W1);%BPSK调制后的图
ylim([-1.5,1.5]);
xlim([0,50]);
title('BPSK调制信号');

figure(4);
plot(t,W2);%QPSK调制后的图
ylim([-1.5,1.5]);
xlim([0,5]);
title('QPSK调制信号');

% 加噪声
for j=1:length(SNR_dB)
    Ps=1; 
    Pn=Ps/SNR(j); 
    BST_A=0;BBT_A=0;BST_R=0;BBT_R=0; 
    QST_A = 0;QBT_A = 0;QST_R = 0;QBT_R = 0;
    for m = 1:100 
        s = randi([0,1],1,N);%原始信号
        X2 = zeros(1,N/2);
        Y2 = zeros(1,N/2);
        Z2 = zeros(1,N/2);
        % BPSK
        for i=1:1:N
            for p=1:2
                if s(i)==Maptable1(p,:)
                     X1(i)=A1(p);
                     break;
                end
            end
        end
        % QPSK
        for i=1:2:N
            for p=1:4
                if s(i:i+1)==Maptable2(p,:)
                    X2((i+1)/2)=A2(p);
                    break;
                end
            end
        end    
%         AWGN
        Z1 = sqrt(Pn/2)*(randn(size(X1))+1i*randn(size(X1)));
        Z2 = sqrt(Pn/2)*(randn(size(X2))+1i*randn(size(X2)));
        Y1 = 1.*X1+Z1;
        Y2 = 1.*X2+Z2;
%         瑞利信道
        h1 = sqrt(1/2)*(randn(size(X1))+1i*randn(size(X1)));
        Yr1 = h1.*X1+Z1;
        Xr1 = Yr1./h1;%信道均衡
        h2 = sqrt(1/2)*(randn(size(X2)) + 1i*randn(size(X2)));
        Yr2 = h2.*X2 + Z2;
        Xr2 = Yr2./h2;
        
%         误码率及误比特率
%         AWGN
% BPSK
        for k=1:length(Y1) 
            if real(Y1(k))>0
                n1(k)=1;
            else 
                n1(k)=0; 
            end
        end  
        BSER_A(j) = length(find(s ~= n1))/N;%误码率
        BBER_A(j) = length(find(s ~= n1))/N; %误比特率
% QPSK        
        p = 1;
        sn1 = 0;
        en1 = 0;
        sn2 = 0;
        en2 = 0;
        for k=1:length(Y2) %判决
            if real(Y2(k))<0
                m1(p+1)=1;
            else
                m1(p+1)=0;
            end
            if imag(Y2(k))<0
                m1(p)=1; 
            else
                m1(p)=0;
            end
            if isequal(s(p+1),m1(p+1))
                if isequal(s(p),m1(p))
                else
                    sn1 = sn1+1;
                    en1 = en1+1;
                end
            else
                sn1 = sn1+1;
                en1 = en1+1;
                if isequal(s(p),m1(p))
                else
                en1 = en1+1;
                end
            end
            p=p+2;
        end
        QSER_A(j)=sn1./N;
        QBER_A(j)=en1./length(Y2);
        
%         瑞利
% BPSK
        for k=1:length(Xr1)
            if real(Xr1(k))>0
                n2(k)=1;
            else 
                n2(k)=0;
            end
        end
        BSER_R(j) = length(find(s ~= n2))/N;
        BBER_R(j) = length(find(s ~= n2))/N;
%QPSK
        q = 1;
        for k=1:length(Xr2) 
            if real(Xr2(k))<0
                m2(q+1)=1;
            else
                m2(q+1)=0;
            end
            if imag(Xr2(k))<0
                m2(q)=1; 
            else
                m2(q)=0;
            end
            if isequal(s(q+1),m2(q+1))
                if isequal(s(q),m2(q))
                else
                    sn2 = sn2+1;%误码数
                    en2 = en2+1;%误比特数量
                end
            else
                sn2 = sn2+1;
                en2 = en2+1;
                if isequal(s(q),m2(q))
                else
                en2 = en2+1;
                end
            end
            q=q+2;
        end
        QSER_R(j)=sn2./N;
        QBER_R(j)=en2./length(Xr2);

        QST_A = QST_A+QSER_A(j);
        QBT_A = QBT_A+QBER_A(j);
        QST_R = QST_R+QSER_R(j);
        QBT_R = QBT_R+QBER_R(j);
        BST_A = BST_A+BSER_A(j);
        BBT_A = BBT_A+BBER_A(j);
        BST_R = BST_R+BSER_R(j);
        BBT_R = BBT_R+BBER_R(j);
    end
    
    BSER_A(j) = BST_A./100;
    BBER_A(j) = BBT_A./100;
    BSER_R(j) = BST_R./100;
    BBER_R(j) = BBT_R./100;
    QSER_A(j) = QST_A./100;
    QBER_A(j) = QBT_A./100;
    QSER_R(j) = QST_R./100;
    QBER_R(j) = QBT_R./100;
    
    %理论值
    syms x;
    BTA(j) = int((1/sqrt(2*pi))*exp((-x.^2)/2),x,-inf,-sqrt(2.*SNR(j)));
    BTR(j) = 1/2*(1-(1./sqrt(1+1./SNR(j))));     
    
    QTB_A(j) = 2.*(int((1/sqrt(2*pi))*exp((-x.^2)/2),x,-inf,-sqrt(1.*SNR(j))))-((int((1/sqrt(2*pi))*exp((-x.^2)/2),x,-inf,-sqrt(1.*SNR(j))))^2);
    QTS_A(j) = (int((1/sqrt(2*pi))*exp((-x.^2)/2),x,-inf,-sqrt(1.*SNR(j))))-1/2.*((int((1/sqrt(2*pi))*exp((-x.^2)/2),x,-inf,-sqrt(1.*SNR(j))))^2);
    QTB_R(j) = (1-(1./(sqrt(1+2./SNR(j)))));
    QTS_R(j) = 1/2*(1-(1./(sqrt(1+2./SNR(j)))));
end

figure(5);
scatter(real(X1),imag(X1),'g*');
hold on;
scatter(real(Y1),imag(Y1),'b.');
axis([-4 4 -4 4]);
title('BPSK-AWGN信道星座图');
hold on;

figure(6);
scatter(real(X1),imag(X1),'g*');
hold on;
scatter(real(Yr1),imag(Yr1),'b.');
axis([-4 4 -4 4]);
title('BPSK-瑞利信道均衡前星座图');
hold on;
 
figure(7);
scatter(real(X1),imag(X1),'g*');
hold on;
scatter(real(Xr1),imag(Xr1),'b.');
axis([-4 4 -4 4]);
title('BPSK-瑞利信道均衡后星座图');
hold on;
         
figure(8);
scatter(real(X2),imag(X2),'r*');
hold on;
scatter(real(Y2),imag(Y2),'b.');
axis([-4 4 -4 4]);
title('QPSK-AWGN信道星座图');
hold on;
            
figure(9);
scatter(real(X2),imag(X2),'r*');
hold on;
scatter(real(Yr2),imag(Yr2),'b.');
axis([-4 4 -4 4]);
title('QPSK-瑞利信道均衡前星座图');
hold on;

figure(10);
scatter(real(X2),imag(X2),'r*');
hold on;
scatter(real(Xr2),imag(Xr2),'b.');
axis([-4 4 -4 4]);
title('QPSK-瑞利信道均衡后星座图');
hold on;

figure(11)
semilogy(SNR_dB,BSER_A,'gO');hold on;
semilogy(SNR_dB,BTA,'r');hold on;
semilogy(SNR_dB,BSER_R,'bO');hold on;
semilogy(SNR_dB,BTR,'k');hold off;
axis([-5,30,10^-5,1]);
title('BPSK-SER');  xlabel('SNR(dB)');ylabel('SER');
legend({'BPSK-AWGN实际值','BPSK-AWGN理论值','BPSK-瑞利实际值','BPSK-瑞利理论值'});
    
figure(12)
semilogy(SNR_dB,BBER_A,'gO');hold on;
semilogy(SNR_dB,BTA,'r');hold on;
semilogy(SNR_dB,BBER_R,'bO');hold on;
semilogy(SNR_dB,BTR,'k');hold off;
axis([-5,30,10^-5,1]);
title('BPSK-BER');xlabel('SNR(dB)');ylabel('BER');
legend({'BPSK-AWGN实际值','BPSK-AWGN理论值','BPSK-瑞利信道BER实际值','BPSK-瑞利理论值'});

figure(13)
semilogy(SNR_dB,QSER_A,'gO');hold on;
semilogy(SNR_dB,QTS_A,'r');hold on;
semilogy(SNR_dB,QSER_R,'bO');hold on;
semilogy(SNR_dB,QTS_R,'k');hold off;
axis([-5,30,10^-5,1]);
title('QPSK-BER');  xlabel('SNR(dB)');ylabel('BER');
legend({'QPSK-AWGN实际值','QPSK-AWGN理论值','QPSK-瑞利实际值','QPSK-瑞利理论值'});
    
figure(14)
semilogy(SNR_dB,QBER_A,'gO');hold on;
semilogy(SNR_dB,QTB_A,'r');hold on;
semilogy(SNR_dB,QBER_R,'bO');hold on;
semilogy(SNR_dB,QTB_R,'k');hold off;
axis([-5,30,10^-5,1]);
title('QPSK-SER');xlabel('SNR(dB)');ylabel('SER');
legend({'QPSK-AWGN实际值','QPSK-AWGN理论值','QPSK-瑞利实际值','QPSK-瑞利理论值'});
        
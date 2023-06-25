% ================================初始化部分==============================

T = 1; %符号间隔
fc = 40/T; %载波频率
fs = 1000; %采样点数
n = 10000; %符号数
t = linspace(0,n/2,n/2*fs); %生成离散时间序列
SNR_dB = -8:35;%信噪比(dB)
SNR = 10.^(SNR_dB/10);%线性信噪比         
Ps = 1; %Ps=1/2*d^2;
Pn = Ps./SNR;%噪声方差

% ----------------------（1） 生成二进制基带数据--------------------------

source = round(rand(1,n));

% ================================4ask部分================================
%-----------------------（2） 4ask调制 映射 星座图------------------------

M = 4;
d = sqrt(2/7);
A = [0:M-1]*d;
figure(1);
scatter(real(A),imag(A),'filled'); %绘制星座图
title('4ASK星座图');

% --------------------------(3) 载波调制 绘制波形-------------------------

ask_output = zeros(1,n/2*fs);%调制的信号
X = zeros(1,n/2);%ASK映射后
Y = zeros(1,n/2);%加高斯白噪声后
maptable = [0 0;0 1;1 1;1 0];          %格雷码映射
for i = 1:2:n
    for m = 1:4
        if isequal(source(i:i+1),maptable(m,:))
            X((i+1)/2) = A(m);
            break;
        end
    end
end
for i = 1:n/2
    index = (i-1)*fs+1:i*fs; 
    g(index) = 1;
    ask_output(index) = X(i).*g(index).*cos(2*pi*fc.*t(index));%载波信号调制
end
figure(2);
plot(t,ask_output);%绘制调制后图像
xlim([0,10]);
ylim([-2,2]);
title('4ASK调制信号'); 
 
%------------------------- （4）AWGN信道星座图----------------------------

X1 = zeros(1,n/2);%AWGN信道判决后的符号串
Z = sqrt(Pn(15)/2).*(randn(size(X))+1i.*randn(size(X)));%6dB信噪比的噪声函数
Y = 1.*X+Z;%AWGN信道加噪声
figure(3);
plot(real(X),imag(X),'r*');
hold on;
plot(real(Y),imag(Y),'b.');
title('SNR为6dB时4ASK-AWGN信道星座图');
hold on;

%-------------------------（5）AWGN误码率 误符号率------------------------

SER1 = zeros(1,length(SNR_dB));%AWGN信道误符号率真实值
BER1 = zeros(1,length(SNR_dB));%AWGN信道误比特率真实值
T_SER1 = zeros(1,length(SNR_dB));%AWGN信道误符号率理论值
T_BER1 = zeros(1,length(SNR_dB));%AWGN信道误比特率理论值
times = 100;%蒙特卡洛循环次数

for j = 1:44
    
    SER1_sum = 0;
    BER1_sum = 0;
    
    for time = 1:times %蒙特卡洛循环
       
        source = round(rand(1,n));%随机生成二进制数据并调制輻 
        X = zeros(1,n/2);%ASK映射后
        Y = zeros(1,n/2);%加高斯白噪声后
        maptable = [0 0;0 1;1 1;1 0];          %格雷码映射
        for i = 1:2:n
            for m = 1:4
                if isequal(source(i:i+1),maptable(m,:))
                    X((i+1)/2) = A(m);
                    break;
                end
            end
        end
        Z = sqrt(Pn(j)/2).*(randn(size(X))+1i.*randn(size(X)));%噪声函数
        Y = 1.*X + Z;%AWGN信道下给调制后的信号加噪声
        for i = 1:length(Y)
            dist = abs(Y(i)-A);      %计算y到星座图各点距离
            [~,ind] = min(dist);       %找最近的点
            X11(i) = A(ind);
            X1(2*i-1:2*i) = maptable(ind,:);     %估计s,X
        end
        [F_Num,SER1(j)] = symerr(X,X11);
        [M_Num,BER1(j)] = biterr(source,X1);
        SER1_sum=SER1_sum+SER1(j);
        BER1_sum=BER1_sum+BER1(j);
    end
    SER1(j) = SER1_sum/times;
    BER1(j) = BER1_sum/times;

    
end

T_SER1 = 0.75.*erfc(sqrt(SNR./14));    %AWGN误符号率理论值
T_BER1 = T_SER1./2;%AWGN误符号率理论值
    
figure(4)

semilogy(SNR_dB,SER1,'gO'); hold on;
semilogy(SNR_dB,T_SER1,'r');hold off;
axis([-8,25,10^-4,1]);
title('SER~SNR仿真曲线');  
xlabel('SNR(dB)');ylabel('误符号率SER');
legend({'4ASK-AWGN信道SER实际值','4ASK-AWGN信道SER理论值'});

figure(5)
semilogy(SNR_dB,BER1,'gO');hold on;
semilogy(SNR_dB,T_BER1,'r');hold off;
axis([-8,25,10^-4,1]);
title('BER~SNR仿真曲线');
xlabel('SNR(dB)');ylabel('误码率BER');
legend({'4ASK-AWGN信道BER实际值','4ASK-AWGN信道BER理论值'});
    
%----------------------（6）瑞利衰落信道均衡前后星座图--------------------

Yr = zeros(1,n/2);%瑞利衰落信道的符号
X2 = zeros(1,n/2);%瑞利衰落信道判决后的符号串
j = 44;
Z = sqrt(Pn(j)/2).*(randn(size(X))+1i.*randn(size(X)));
Y = 1.*X + Z;%AWGN信道下给调制后的信号加噪声
h = sqrt(1/2).*(randn(size(X))+1i.*randn(size(X)));
Yr = h.*X+Z;%瑞利衰落信道下给调制后的信号加噪声
Xr = Yr./h;%信道均衡
figure(6);%星座图
plot(real(X),imag(X),'r*');
hold on;
plot(real(Yr),imag(Yr),'b.');
axis([-4 4 -2 2]);
title('4ASK-瑞利衰落衰落信道均衡前星座图');
hold on;
figure(7);%星座图
plot(real(X),imag(X),'r*');
hold on;
plot(real(Xr),imag(Xr),'b.');
axis([-4 4 -2 2]);
title('4ASK-瑞利衰落衰落信道均衡后星座图');
hold on;

%-------------------（7）瑞利衰落衰落信道误码率 误符号率------------------

SER2 = zeros(1,length(SNR_dB));%瑞利衰落信道误符号率
BER2 = zeros(1,length(SNR_dB));%瑞利衰落信道误比特率
% T_SER2 = zeros(1,length(SNR_dB));%瑞利衰落信道误符号率理论值
% T_BER2 = zeros(1,length(SNR_dB));%瑞利衰落信道误比特率理论值
for j = 1:44
    
    SER2_sum = 0;
    BER2_sum = 0;
    
    for time = 1:times 
        
        source = round(rand(1,n));%随机生成二进制数据并调制輻 
        X = zeros(1,n/2);%ASK映射后
        Y = zeros(1,n/2);%加高斯白噪声后
        maptable = [0 0;0 1;1 1;1 0];          %格雷码映射
        for i = 1:2:n
            for m = 1:4
                if isequal(source(i:i+1),maptable(m,:))
                    X((i+1)/2) = A(m);
                    break;
                end
            end
        end
        Z = sqrt(Pn(j)/2).*(randn(size(X))+1i.*randn(size(X)));%噪声函数
        Y = X+Z;%AWGN信道下给调制后的信号加噪声
        h = sqrt(1/2).*(randn(size(X))+1i.*randn(size(X)));
        Yr = h.*X+Z;%瑞利衰落信道下给调制后的信号加噪声
        Xr = Yr./h;%信道均衡
   
        for i = 1:length(Xr)
            dist = abs(Xr(i)-A);      %计算y到星座图各点距离
            [~,ind] = min(dist);       %找最近的点
            X22(i) = A(ind);
            X2(2*i-1:2*i) = maptable(ind,:);     %估计s,X
        end
     
        [F_Num,SER2(j)] = symerr(X,X22);
        [M_Num,BER2(j)] = biterr(source,X2);

         SER2_sum=SER2_sum+SER2(j);
        BER2_sum=BER2_sum+BER2(j);
      
    end
   
    SER2(j) = SER2_sum/times;
    BER2(j) = BER2_sum/times;
  
    
    
end

T_SER2 = 0.5.*(1-(1./sqrt(1+21./SNR)));
T_BER2 = 0.5.*T_SER2;

figure(8)

semilogy(SNR_dB,SER2,'gO'); hold on;
semilogy(SNR_dB,T_SER2,'r'); hold off;
axis([0,35,10^-4,1]);
title('SER~SNR仿真曲线');  
xlabel('SNR(dB)');ylabel('误符号率SER');
legend({'4ASK-瑞利衰落衰落信道SER实际值','4ASK-瑞利衰落衰落信道SER理论值'});
    
figure(9)

semilogy(SNR_dB,BER2,'gO'); hold on;
semilogy(SNR_dB,T_BER2,'r'); hold off;
axis([0,35,10^-4,1]);
title('BER~SNR仿真曲线');
xlabel('SNR(dB)');ylabel('误码率BER');
legend({'4ASK-瑞利衰落衰落信道BER实际值','4ASK-瑞利衰落衰落信道BER理论值'});
% ================================初始化部分==============================

T = 1; %符号间隔
fc = 40/T; %载波频率
fs = 1000; %采样点数
n = 10000; %符号数
Bt_StrNumber = n;%一个比特对应了一个符号
t = linspace(0,n,n*fs); %生成离散时间序列
SNR_dB = -8:35;%信噪比(dB)
SNR = 10.^(SNR_dB/10);%线性信噪比         
Ps = 0.5; %Ps=1/2*d^2;
Pn = Ps./SNR;%噪声方差

% ----------------------（1） 生成二进制基带数据--------------------------

source = round(rand(1,n));

% ================================2ask部分================================
%-----------------------（2） 2ask调制 映射 星座图------------------------

M = 2;
d = 1;
A = [0:M-1]*d;
figure(1);
scatter(real(A),imag(A),'filled'); %绘制星座图
title('2ASK星座图');

% --------------------------(3) 载波调制 绘制波形-------------------------

ask_output = zeros(1,n*fs);%调制的信号
X = zeros(1,n);%ASK映射后
Y = zeros(1,n);%加高斯白噪声后
maptable = [0;1];    %格雷码映射
for i = 1:1:n
    for m = 1:M
        if isequal(source(i),maptable(m,:))
            X(i) = A(m);
            break;
        end
    end
end
for i = 1:n
    index = (i-1)*fs+1:i*fs; 
    g(index) = 1;
    ask_output(index) = X(i).*g(index).*cos(2*pi*fc.*t(index));%载波信号调制
end
figure(2);
plot(t,ask_output);%绘制调制后图像
xlim([0,10]);
ylim([-2,2]);
title('2ASK调制信号'); 
 
%------------------------- （4）AWGN信道星座图----------------------------

X1 = zeros(1,n);%AWGN信道判决后的符号串
Bt_Str1 = zeros(1,Bt_StrNumber);%AWGN信道比特串
ReBt_Str1 = zeros(1,Bt_StrNumber);%AWGN信道恢复编码的比特串
Z = sqrt(Pn(15)/2).*(randn(1,n)+1i.*randn(1,n));%6dB信噪比的噪声函数
Y = X+Z;%AWGN信道加噪声
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

Bt_Str1 = source; %比特映射
for j = 1:44
    
    SER1_sum = 0;
    BER1_sum = 0;
    
    for time = 1:times %蒙特卡洛循环
       
        source = round(rand(1,n));%随机生成二进制数据并调制
        maptable = [0;1];    %格雷码映射
        for i = 1:1:n
            for m = 1:M
                if isequal(source(i),maptable(m,:))
                    X(i) = A(m);
                    break;
                end
            end
        end
       
        Z = sqrt(Pn(j)/2).*(randn(1,n)+1i.*randn(1,n));%噪声函数
        Y = X+Z;%AWGN信道下加噪声
        for k = 1:n 
            if Y(k) >= 0.5
                X1(k) = 1;
            else 
                X1(k) = 0; 
            end
        end
        Bt_Str1 = source; %比特映射
        SError_Num1 = length(find(source ~= X1));%误码个数
        SER1(j) = SError_Num1/n;%单个噪声下的误码率
        ReBt_Str1 = X1; %符号恢复成二进制比特
        BError_Num1=length(find(Bt_Str1 ~= ReBt_Str1));%误比特个数
        BER1(j) = BError_Num1/n;%单个噪声下的误比特率
        SER1_sum = SER1_sum+SER1(j);%循环叠加
        BER1_sum = BER1_sum+BER1(j);
    end
    SER1(j) = SER1_sum/times;
    BER1(j) = BER1_sum/times;

    T_SER1(j)=1/2*erfc(sqrt(SNR(j)/2));%理论值
end
figure(4)

semilogy(SNR_dB,SER1,'gO'); hold on;
semilogy(SNR_dB,T_SER1,'r');hold off;
axis([-8,16,10^-4,1]);
title('SER~SNR仿真曲线');  
xlabel('SNR(dB)');ylabel('误符号率SER');
legend({'2ASK-AWGN信道SER实际值','2ASK-AWGN信道SER理论值'});

figure(5)
semilogy(SNR_dB,BER1,'gO');hold on;
semilogy(SNR_dB,T_SER1,'r');hold off;
axis([-8,16,10^-4,1]);
title('BER~SNR仿真曲线');
xlabel('SNR(dB)');ylabel('误码率BER');
legend({'2ASK-AWGN信道BER实际值','2ASK-AWGN信道BER理论值'});
    
%----------------------（6）瑞利衰落信道均衡前后星座图--------------------%

Yr = zeros(1,n);%瑞利衰落信道的符号
X2 = zeros(1,n);%瑞利衰落信道判决后的符号串
Bt_Str2 = zeros(1,Bt_StrNumber);%瑞利衰落衰落信道比特串
ReBt_Str2 = zeros(1,Bt_StrNumber);%瑞利衰落衰落信道恢复编码的比特串
j = 44;
h = sqrt(1/2).*(randn(size(X))+1i.*randn(size(X)));
Yr = h.*X+Z;%瑞利衰落信道下给调制后的信号加噪声
Xr = Yr./h;%信道均衡
figure(6);%星座图
plot(real(X),imag(X),'r*');
hold on;
plot(real(Yr),imag(Yr),'b.');
title('2ASK-瑞利衰落衰落信道均衡前星座图');
hold on;
figure(7);%星座图
plot(real(X),imag(X),'r*');
hold on;
plot(real(Xr),imag(Xr),'b.');
axis([-4 4 -2 2]);
title('2ASK-瑞利衰落衰落信道均衡后星座图');
hold on;

%-------------------（7）瑞利衰落衰落信道误码率 误符号率------------------%

SER2 = zeros(1,length(SNR_dB));%瑞利衰落信道误符号率
BER2 = zeros(1,length(SNR_dB));%瑞利衰落信道误比特率
T_SER2 = zeros(1,length(SNR_dB));%瑞利衰落信道误符号率理论值
T_BER2 = zeros(1,length(SNR_dB));%瑞利衰落信道误比特率理论值
Bt_Str2 = source; %比特映射
for j = 1:44
    
    SER2_sum = 0;
    BER2_sum = 0;
    
    for time = 1:times 
        
        source = round(rand(1,n));%随机生成二进制数据并调制
        maptable = [0;1];    %格雷码映射
        for i = 1:1:n
            for m = 1:M
                if isequal(source(i),maptable(m,:))
                    X(i) = A(m);
                    break;
                end
            end
        end
        Bt_Str2 = source; %比特映射
        Z = sqrt(Pn(j)/2).*(randn(1,n)+1i.*randn(1,n));%噪声函数
        Y = X+Z;%AWGN信道下给调制后的信号加噪声
        h = sqrt(1/2).*(randn(size(X))+1i.*randn(size(X)));
        Yr = h.*X+Z;%瑞利衰落信道下给调制后的信号加噪声
        Xr = Yr./h;%信道均衡
   
        for k = 1:n %判决
            if Xr(k) >= 0.5
                X2(k) = 1;
            else 
                X2(k) = 0; 
            end
        end
     
        SError_Num2 = length(find(source ~= X2));%误码个数
        SER2(j) = SError_Num2/n;%单个噪声下的误码率

        ReBt_Str2 = X2; %符号恢复成二进制比特
        BError_Num2=length(find(Bt_Str2 ~= ReBt_Str2));%误比特个数
        BER2(j) = BError_Num2/n;%单个噪声下的误比特率
      
        SER2_sum = SER2_sum+SER2(j);%循环叠加
        BER2_sum = BER2_sum+BER2(j);
    end
   
    SER2(j) = SER2_sum/times;
    BER2(j) = BER2_sum/times;
  
    T_SER2(j) = (1/2)*(1-(1/sqrt(1+2/SNR(j)))); %瑞利衰落衰落误符号率理论值
    
end

figure(8)

semilogy(SNR_dB,SER2,'gO');
hold on;
semilogy(SNR_dB,T_SER2,'r');
hold off;
axis([-8,35,10^-4,1]);
title('SER~SNR仿真曲线');  
xlabel('SNR(dB)');ylabel('误符号率SER');
legend({'2ASK-瑞利衰落衰落信道SER实际值','2ASK-瑞利衰落衰落信道SER理论值'});
    
figure(9)

semilogy(SNR_dB,BER2,'gO');hold on;
semilogy(SNR_dB,T_SER2,'r');hold off;
axis([-8,35,10^-4,1]);
title('BER~SNR仿真曲线');
xlabel('SNR(dB)');ylabel('误码率BER');
legend({'2ASK-瑞利衰落衰落信道BER实际值','2ASK-瑞利衰落衰落信道BER理论值'});
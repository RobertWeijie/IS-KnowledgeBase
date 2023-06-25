clear
%% 初始化
T=1;                    %比特周期
f0=40/T; 
f1=40/T+1/T;            %f0,f1 载波的两个频率
step=0.2;               
tot=1/step;
N=1e6;                  %比特数
t=0:step:N-step;        %时间
Ps=1;                   %信号能量
SNR_dB=-10:15;          %信噪比（dB）取值范围

wave0=cos(2*pi*f0*t);
wave1=cos(2*pi*f0*t);

wave0_delay=cos(2*pi*f0*t+pi/4);          
wave1_delay=cos(2*pi*f1*t+pi/4);          % 两个载波  载波wave0->0, wave1->1


%% 信噪比循环

error=zeros(1,length(SNR_dB));        % error 误码率数组

for count=1:length(SNR_dB)             %SNR_dB（count）表示某一信噪比
   
    basedata=round(rand(1,N));         %产生基带数据
    
    

    basedata_1=zeros(1,length(t));        %basedata_1用于保存扩展之后的基带数据
    
    for p=1:length(t)
        pos=ceil(p/tot);
        basedata_1(p)=basedata(pos);      %将数据扩展为与时间同维度数组
    end

    signal_M=basedata_1.*wave1_delay+(1-basedata_1).*wave0_delay;  
    % 比特为1时乘以载波wave1_delay，比特为0时乘以载波wave1_delay，signal_M为生成的调制信号
    

   
    SNR=10^(SNR_dB(count)/10);                           %计算线性信噪比
    Pn=Ps/SNR;                                           
    noise=randn(1,length(signal_M))*(sqrt(Pn));          %根据信噪比生成噪声
    signal_N=signal_M+noise;                             %signal_N 加入噪声后的信号

    
    Ddata=zeros(1,N);                      %Ddata 解调之后的二进制数据
    
    Zk0=signal_N.*wave0_delay;
    Zk1=signal_N.*wave1_delay;            %相关运算
    
    for s=1:N                                 
        
        pos_s=(s-1)/step+1;         
        pos_e=s/step;                    %pos_s，pos_e 第s个比特相关运算的积分限
        Ddata(s)=sum(Zk0(1,pos_s:pos_e))<sum(Zk1(1,pos_s:pos_e));
 
    end                                                                %每个比特依次解调
                                  
    error(count)=length(find(Ddata-basedata))/length(basedata);        %比较原二进制数据与解调后的二进制数据，计算误码率

end


%% 给出各步的曲线


step=0.001;
tot=1/step;
N=1e4;
t=0:step:N-step;
SNR_ex=3;                             
wave0_delay=cos(2*pi*f0*t+pi/4);          
wave1_delay=cos(2*pi*f1*t+pi/4); 

basedata=round(rand(1,N));
figure(1);
stem(basedata,'filled');
axis([1 100 0 1]);
title('二进制基带数据');
ylabel('幅度');                       %绘制二进制数据曲线

basedata_1=zeros(1,length(t));
    
    for p=1:length(t)
        pos=ceil(p/tot);
        basedata_1(p)=basedata(pos);      
    end

    signal_M=basedata_1.*wave1_delay+(1-basedata_1).*wave0_delay;   %生成新的调制信号
    
figure(2);
plot(t,signal_M);
axis([0 5 -1 1]);
title('2FSK调制信号');
ylabel('幅度');                         %绘制调制信号曲线

SNR_1=10^(SNR_ex/10); 
Pn=Ps/SNR_1;                                          
noise=randn(1,length(signal_M))*(sqrt(Pn));   %加入噪声
signal_N=signal_M+noise;                             

figure(3);
plot(t,signal_N);
axis([0 10 -3 3]);
title('接收信号');                     %给出在一个信噪比下的接受信号
ylabel('幅度');


    a=zeros(1,length(SNR_dB));
    for k=1:length(SNR_dB)
        
    m=SNR_dB(k);
    snr1=10^(m/10);
    snr=sqrt(snr1*2);
    f=@(x)exp(-x.^2/2).*(erf((snr-x)/sqrt(2))+1);
    a(k)=integral(f,-inf,inf)*sqrt(pi/2)/2/pi;              %理论值计算，a是相干解调正确的概率
    
    end
    
    
    figure(4);
    semilogy(SNR_dB,error,SNR_dB,1-a);
    legend('2FSK误比特率','2FSK理论误比特率');
    xlabel('符号信噪比 (dB)');
    ylabel('误比特率');                       %  绘制误比特率和理论误比特率的对比曲线
    

   




   
    
  
    











clear all;
%% 采样为8125Hz的采样信号
f0 = 3500; %模拟频率
Fs = 8125; %采样频率
Ts=1/Fs;   %采样周期
N=80000;   %采样点数
ts=(0:N-1)/Fs; %采样时间
t=(0:N-1)/Fs/10; %精准时间
fy = cos(2*pi*f0*t); %精准数据
subplot(6,1,1);
plot(t,fy);
axis([0 0.01 -2 2]);
title('原始数据');
f = cos(2*pi*f0*ts); %采样后数据
subplot(6,1,2);
stem(ts,f);
axis([0 0.01 -2 2]);
title('采样率为8125Hz的采样信号');
sound(f,Fs);     %播放第一个声音
%% 信号隔点抽取的新序列
for i=1:N/2
    f1(i)=f(i*2);
    ts1(i)=ts(i*2);
end
subplot(6,1,3);
stem(ts1,f1);    
axis([0 0.01 -2 2]);
title('信号隔点抽取的新序列');
sound(f1,Fs);   %播放第二个声音
%% 采样率为16250Hz的采样信号
Fs2=8125*2;
ts2=(0:N-1)/Fs2; %采样时间
f2 = cos(2*pi*f0*ts2); %采样后数据
subplot(6,1,4);
stem(ts2,f2);
axis([0 0.01 -2 2]);
title('采样为16250Hz的采样信号');
sound(f2,Fs2);     %播放第三个声音
%% 信号恢复
x = 0;
for n = 1:length(f)
    x = x + f(n) * sinc((t-(n-1)*Ts)/Ts);
end
subplot(6,1,5);
plot(t,x);
axis([0 0.01 -2 2]);
title('恢复数据');
%% 重新采样
Fs3=8000;
Ts=1/Fs3;   %采样周期
ts3=(0:N-1)/Fs3; %采样时间
f3 = cos(2*pi*f0*ts3); %采样后数据
subplot(6,1,6);
stem(ts3,f3);
axis([0 0.01 -2 2]);
title('重新以8000Hz频率采样的信号');
sound(f3,Fs3);     %播放第四个声音

%% 计算误差
E=0;
for n = 1:length(f)
    E = E + (f3(n)-f(n))^2;
end
E=E/length(f);

disp(strcat(['误差为' num2str(E)]));
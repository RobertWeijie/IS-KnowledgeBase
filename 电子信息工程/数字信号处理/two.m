clear all;
%% 采样
f0 = 3500; %模拟频率
f1 = 3800;
Fs = 8125; %采样频率
Ts=1/Fs;   %采样周期
N=80000;   %采样点数
ts=(0:N-1)/Fs; %采样时间
t=(0:N-1)/Fs/10; %精准时间
xt = cos(2*pi*f0*t)+cos(2*pi*f1*t); %精准数据
subplot(3,1,1);
plot(t,xt);
axis([0 0.02 -2 2]);
title('原始数据');
xn = cos(2*pi*f0*ts)+cos(2*pi*f1*ts); %采样后数据
xdn = cos(2*pi*f0*ts);   %用来比较误差
subplot(3,1,2);
stem(ts,xn);
axis([0 0.02 -2 2]);
title('采样率为8125Hz的采样信号');
sound(xn,Fs);  %播放第一个声音
%% 滤波播放

Hd=fir2;       %调用滤波器
y=filter(Hd,xt); %y为对xt的滤波结果
subplot(3,1,3);
plot(t,y);
axis([0 0.02 -2 2]);
title('滤波后信号');

Hd=fir2;
yn=filter(Hd,xn); %yn为对xn的滤波结果
sound(yn,Fs); %播放第二个声音
%% 计算误差
E=0;
for n = 1:length(yn)
    E = E + (yn(n)-xdn(n))^2;
end
E=E/length(yn);

disp(strcat(['误差为' num2str(E)]));



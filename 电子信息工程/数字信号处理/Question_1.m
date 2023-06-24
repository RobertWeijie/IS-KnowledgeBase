clc
clear
close all
%清屏
f0=3500;%信号频率
fs=8125;%采样频率
n = 1:1:80001;
x=0:0.01:31;
% x=cos(2*pi*3500*t);
x_n = cos(2*pi*3500*(n-1)*1/fs);%针对x(t)取得的离散信号
y_n = zeros(1,40001);
for i = 0:1:40000
    y_n(i+1) = x_n(i*2+1);%对40001个数进行更新
end
x_n_2 = cos(2*pi*3500*(n-1)*0.5/fs);
% plot(n,x_n);
% plot(1:40001,y_n);
% plot(n,x_n_2);
sound(x_n,fs); %x[n]声音播放
sound(y_n,fs/2); %y[n]声音播放
sound(x_n_2,2*fs); %2倍采样频率的x[n]声音播放
fs_new = 8000;%新的采样频率
z_n = zeros(1,80001); %z[n]
for k = 1:1:80001  %通过内插公式求取z[n]
    t = (k-1)/fs_new;
    M = 1000;
    for j = (M*(-1)):1:M
        if ((t-j/8125) == 0)%解决分母为0的情况
            z_n(k) = z_n(k) + cos(2*pi*3500*j/8125);
        else
            z_n(k) = z_n(k) + cos(2*pi*3500*j/8125) * sin(pi*(t-j/8125)*8125) / (pi*(t-j/8125)*8125);
        end
    end
end
sound(z_n,fs_new); %z[n]声音播放
hold on;
xlim([0,5])
ylim([-1,1])
% plot(n,z_n);
% plot(n,x_n);
plot(x,cos(2*pi*3500*(x-1)*1/fs));
stem(n,z_n);
% stem(n,x_n);
sum = 0;
for l = 1:1:80000
    sum = sum + (z_n(l)-x_n(l))^2;
end
s = sum/80000; %统计z[n]与x[n]之间的误差
disp(s); %展示计算出来的误差




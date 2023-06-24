clc
clear
close all
%清屏
f0 = 3500;          
f1 = 3800;          
t = 0:0.001:1; %时间范围
x_t = cos(2*pi*f0*t)+cos(2*pi*f1*t); %双频正弦信号表达式

fs=8125;              %采样频率:8125Hz
N=80000;                %定义采样点数
dt=1/fs;             %采样间隔
T=(0:N)*dt;        %定义采样的每个时间点
x_n = cos(2*pi*f0*T)+cos(2*pi*f1*T);
x_n_1 = cos(2*pi*f0*T);
T_delay_1=(1:N)*dt;        %考虑延迟1个dt
x_n_2 = cos(2*pi*f0*T_delay_1);
sound(x_n,fs);      %x_n声音

Hd=fir;            %调用滤波器:Kaiser窗滤波器
y_n=filter(Hd,x_n);  %y_n为对x_n的滤波结果
sound(y_n,fs);      %y_n声音

%不考虑延迟的情况
sum = 0;
for i = 1:N
    sum = sum+(x_n_1(i)-y_n(i))^2;
end  
s = sum/N; 
disp(strcat(['不考虑延迟，误差为' num2str(s)]));  %展示计算出来的误差


%考虑延迟为1个采样周期计算误差
sum = 0;
for i = 1:N
    sum = sum+(x_n_2(i)-y_n(i))^2;
end  
s = sum/N; %统计y[n]与xd[n]之间的误差
disp(strcat(['考虑延迟，误差为' num2str(s)]));  %展示计算出来的误差

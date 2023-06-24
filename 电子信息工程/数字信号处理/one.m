clear all;
%% ����Ϊ8125Hz�Ĳ����ź�
f0 = 3500; %ģ��Ƶ��
Fs = 8125; %����Ƶ��
Ts=1/Fs;   %��������
N=80000;   %��������
ts=(0:N-1)/Fs; %����ʱ��
t=(0:N-1)/Fs/10; %��׼ʱ��
fy = cos(2*pi*f0*t); %��׼����
subplot(6,1,1);
plot(t,fy);
axis([0 0.01 -2 2]);
title('ԭʼ����');
f = cos(2*pi*f0*ts); %����������
subplot(6,1,2);
stem(ts,f);
axis([0 0.01 -2 2]);
title('������Ϊ8125Hz�Ĳ����ź�');
sound(f,Fs);     %���ŵ�һ������
%% �źŸ����ȡ��������
for i=1:N/2
    f1(i)=f(i*2);
    ts1(i)=ts(i*2);
end
subplot(6,1,3);
stem(ts1,f1);    
axis([0 0.01 -2 2]);
title('�źŸ����ȡ��������');
sound(f1,Fs);   %���ŵڶ�������
%% ������Ϊ16250Hz�Ĳ����ź�
Fs2=8125*2;
ts2=(0:N-1)/Fs2; %����ʱ��
f2 = cos(2*pi*f0*ts2); %����������
subplot(6,1,4);
stem(ts2,f2);
axis([0 0.01 -2 2]);
title('����Ϊ16250Hz�Ĳ����ź�');
sound(f2,Fs2);     %���ŵ���������
%% �źŻָ�
x = 0;
for n = 1:length(f)
    x = x + f(n) * sinc((t-(n-1)*Ts)/Ts);
end
subplot(6,1,5);
plot(t,x);
axis([0 0.01 -2 2]);
title('�ָ�����');
%% ���²���
Fs3=8000;
Ts=1/Fs3;   %��������
ts3=(0:N-1)/Fs3; %����ʱ��
f3 = cos(2*pi*f0*ts3); %����������
subplot(6,1,6);
stem(ts3,f3);
axis([0 0.01 -2 2]);
title('������8000HzƵ�ʲ������ź�');
sound(f3,Fs3);     %���ŵ��ĸ�����

%% �������
E=0;
for n = 1:length(f)
    E = E + (f3(n)-f(n))^2;
end
E=E/length(f);

disp(strcat(['���Ϊ' num2str(E)]));
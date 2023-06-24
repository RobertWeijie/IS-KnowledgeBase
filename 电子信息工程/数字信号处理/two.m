clear all;
%% ����
f0 = 3500; %ģ��Ƶ��
f1 = 3800;
Fs = 8125; %����Ƶ��
Ts=1/Fs;   %��������
N=80000;   %��������
ts=(0:N-1)/Fs; %����ʱ��
t=(0:N-1)/Fs/10; %��׼ʱ��
xt = cos(2*pi*f0*t)+cos(2*pi*f1*t); %��׼����
subplot(3,1,1);
plot(t,xt);
axis([0 0.02 -2 2]);
title('ԭʼ����');
xn = cos(2*pi*f0*ts)+cos(2*pi*f1*ts); %����������
xdn = cos(2*pi*f0*ts);   %�����Ƚ����
subplot(3,1,2);
stem(ts,xn);
axis([0 0.02 -2 2]);
title('������Ϊ8125Hz�Ĳ����ź�');
sound(xn,Fs);  %���ŵ�һ������
%% �˲�����

Hd=fir2;       %�����˲���
y=filter(Hd,xt); %yΪ��xt���˲����
subplot(3,1,3);
plot(t,y);
axis([0 0.02 -2 2]);
title('�˲����ź�');

Hd=fir2;
yn=filter(Hd,xn); %ynΪ��xn���˲����
sound(yn,Fs); %���ŵڶ�������
%% �������
E=0;
for n = 1:length(yn)
    E = E + (yn(n)-xdn(n))^2;
end
E=E/length(yn);

disp(strcat(['���Ϊ' num2str(E)]));



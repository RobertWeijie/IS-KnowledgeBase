% ================================��ʼ������==============================

T = 1; %���ż��
fc = 40/T; %�ز�Ƶ��
fs = 1000; %��������
n = 10000; %������
t = linspace(0,n/2,n/2*fs); %������ɢʱ������
SNR_dB = -8:35;%�����(dB)
SNR = 10.^(SNR_dB/10);%���������         
Ps = 1; %Ps=1/2*d^2;
Pn = Ps./SNR;%��������

% ----------------------��1�� ���ɶ����ƻ�������--------------------------

source = round(rand(1,n));

% ================================4ask����================================
%-----------------------��2�� 4ask���� ӳ�� ����ͼ------------------------

M = 4;
d = sqrt(2/7);
A = [0:M-1]*d;
figure(1);
scatter(real(A),imag(A),'filled'); %��������ͼ
title('4ASK����ͼ');

% --------------------------(3) �ز����� ���Ʋ���-------------------------

ask_output = zeros(1,n/2*fs);%���Ƶ��ź�
X = zeros(1,n/2);%ASKӳ���
Y = zeros(1,n/2);%�Ӹ�˹��������
maptable = [0 0;0 1;1 1;1 0];          %������ӳ��
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
    ask_output(index) = X(i).*g(index).*cos(2*pi*fc.*t(index));%�ز��źŵ���
end
figure(2);
plot(t,ask_output);%���Ƶ��ƺ�ͼ��
xlim([0,10]);
ylim([-2,2]);
title('4ASK�����ź�'); 
 
%------------------------- ��4��AWGN�ŵ�����ͼ----------------------------

X1 = zeros(1,n/2);%AWGN�ŵ��о���ķ��Ŵ�
Z = sqrt(Pn(15)/2).*(randn(size(X))+1i.*randn(size(X)));%6dB����ȵ���������
Y = 1.*X+Z;%AWGN�ŵ�������
figure(3);
plot(real(X),imag(X),'r*');
hold on;
plot(real(Y),imag(Y),'b.');
title('SNRΪ6dBʱ4ASK-AWGN�ŵ�����ͼ');
hold on;

%-------------------------��5��AWGN������ �������------------------------

SER1 = zeros(1,length(SNR_dB));%AWGN�ŵ����������ʵֵ
BER1 = zeros(1,length(SNR_dB));%AWGN�ŵ����������ʵֵ
T_SER1 = zeros(1,length(SNR_dB));%AWGN�ŵ������������ֵ
T_BER1 = zeros(1,length(SNR_dB));%AWGN�ŵ������������ֵ
times = 100;%���ؿ���ѭ������

for j = 1:44
    
    SER1_sum = 0;
    BER1_sum = 0;
    
    for time = 1:times %���ؿ���ѭ��
       
        source = round(rand(1,n));%������ɶ��������ݲ�����ݗ 
        X = zeros(1,n/2);%ASKӳ���
        Y = zeros(1,n/2);%�Ӹ�˹��������
        maptable = [0 0;0 1;1 1;1 0];          %������ӳ��
        for i = 1:2:n
            for m = 1:4
                if isequal(source(i:i+1),maptable(m,:))
                    X((i+1)/2) = A(m);
                    break;
                end
            end
        end
        Z = sqrt(Pn(j)/2).*(randn(size(X))+1i.*randn(size(X)));%��������
        Y = 1.*X + Z;%AWGN�ŵ��¸����ƺ���źż�����
        for i = 1:length(Y)
            dist = abs(Y(i)-A);      %����y������ͼ�������
            [~,ind] = min(dist);       %������ĵ�
            X11(i) = A(ind);
            X1(2*i-1:2*i) = maptable(ind,:);     %����s,X
        end
        [F_Num,SER1(j)] = symerr(X,X11);
        [M_Num,BER1(j)] = biterr(source,X1);
        SER1_sum=SER1_sum+SER1(j);
        BER1_sum=BER1_sum+BER1(j);
    end
    SER1(j) = SER1_sum/times;
    BER1(j) = BER1_sum/times;

    
end

T_SER1 = 0.75.*erfc(sqrt(SNR./14));    %AWGN�����������ֵ
T_BER1 = T_SER1./2;%AWGN�����������ֵ
    
figure(4)

semilogy(SNR_dB,SER1,'gO'); hold on;
semilogy(SNR_dB,T_SER1,'r');hold off;
axis([-8,25,10^-4,1]);
title('SER~SNR��������');  
xlabel('SNR(dB)');ylabel('�������SER');
legend({'4ASK-AWGN�ŵ�SERʵ��ֵ','4ASK-AWGN�ŵ�SER����ֵ'});

figure(5)
semilogy(SNR_dB,BER1,'gO');hold on;
semilogy(SNR_dB,T_BER1,'r');hold off;
axis([-8,25,10^-4,1]);
title('BER~SNR��������');
xlabel('SNR(dB)');ylabel('������BER');
legend({'4ASK-AWGN�ŵ�BERʵ��ֵ','4ASK-AWGN�ŵ�BER����ֵ'});
    
%----------------------��6������˥���ŵ�����ǰ������ͼ--------------------

Yr = zeros(1,n/2);%����˥���ŵ��ķ���
X2 = zeros(1,n/2);%����˥���ŵ��о���ķ��Ŵ�
j = 44;
Z = sqrt(Pn(j)/2).*(randn(size(X))+1i.*randn(size(X)));
Y = 1.*X + Z;%AWGN�ŵ��¸����ƺ���źż�����
h = sqrt(1/2).*(randn(size(X))+1i.*randn(size(X)));
Yr = h.*X+Z;%����˥���ŵ��¸����ƺ���źż�����
Xr = Yr./h;%�ŵ�����
figure(6);%����ͼ
plot(real(X),imag(X),'r*');
hold on;
plot(real(Yr),imag(Yr),'b.');
axis([-4 4 -2 2]);
title('4ASK-����˥��˥���ŵ�����ǰ����ͼ');
hold on;
figure(7);%����ͼ
plot(real(X),imag(X),'r*');
hold on;
plot(real(Xr),imag(Xr),'b.');
axis([-4 4 -2 2]);
title('4ASK-����˥��˥���ŵ����������ͼ');
hold on;

%-------------------��7������˥��˥���ŵ������� �������------------------

SER2 = zeros(1,length(SNR_dB));%����˥���ŵ��������
BER2 = zeros(1,length(SNR_dB));%����˥���ŵ��������
% T_SER2 = zeros(1,length(SNR_dB));%����˥���ŵ������������ֵ
% T_BER2 = zeros(1,length(SNR_dB));%����˥���ŵ������������ֵ
for j = 1:44
    
    SER2_sum = 0;
    BER2_sum = 0;
    
    for time = 1:times 
        
        source = round(rand(1,n));%������ɶ��������ݲ�����ݗ 
        X = zeros(1,n/2);%ASKӳ���
        Y = zeros(1,n/2);%�Ӹ�˹��������
        maptable = [0 0;0 1;1 1;1 0];          %������ӳ��
        for i = 1:2:n
            for m = 1:4
                if isequal(source(i:i+1),maptable(m,:))
                    X((i+1)/2) = A(m);
                    break;
                end
            end
        end
        Z = sqrt(Pn(j)/2).*(randn(size(X))+1i.*randn(size(X)));%��������
        Y = X+Z;%AWGN�ŵ��¸����ƺ���źż�����
        h = sqrt(1/2).*(randn(size(X))+1i.*randn(size(X)));
        Yr = h.*X+Z;%����˥���ŵ��¸����ƺ���źż�����
        Xr = Yr./h;%�ŵ�����
   
        for i = 1:length(Xr)
            dist = abs(Xr(i)-A);      %����y������ͼ�������
            [~,ind] = min(dist);       %������ĵ�
            X22(i) = A(ind);
            X2(2*i-1:2*i) = maptable(ind,:);     %����s,X
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
title('SER~SNR��������');  
xlabel('SNR(dB)');ylabel('�������SER');
legend({'4ASK-����˥��˥���ŵ�SERʵ��ֵ','4ASK-����˥��˥���ŵ�SER����ֵ'});
    
figure(9)

semilogy(SNR_dB,BER2,'gO'); hold on;
semilogy(SNR_dB,T_BER2,'r'); hold off;
axis([0,35,10^-4,1]);
title('BER~SNR��������');
xlabel('SNR(dB)');ylabel('������BER');
legend({'4ASK-����˥��˥���ŵ�BERʵ��ֵ','4ASK-����˥��˥���ŵ�BER����ֵ'});
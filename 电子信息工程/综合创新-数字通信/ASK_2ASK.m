% ================================��ʼ������==============================

T = 1; %���ż��
fc = 40/T; %�ز�Ƶ��
fs = 1000; %��������
n = 10000; %������
Bt_StrNumber = n;%һ�����ض�Ӧ��һ������
t = linspace(0,n,n*fs); %������ɢʱ������
SNR_dB = -8:35;%�����(dB)
SNR = 10.^(SNR_dB/10);%���������         
Ps = 0.5; %Ps=1/2*d^2;
Pn = Ps./SNR;%��������

% ----------------------��1�� ���ɶ����ƻ�������--------------------------

source = round(rand(1,n));

% ================================2ask����================================
%-----------------------��2�� 2ask���� ӳ�� ����ͼ------------------------

M = 2;
d = 1;
A = [0:M-1]*d;
figure(1);
scatter(real(A),imag(A),'filled'); %��������ͼ
title('2ASK����ͼ');

% --------------------------(3) �ز����� ���Ʋ���-------------------------

ask_output = zeros(1,n*fs);%���Ƶ��ź�
X = zeros(1,n);%ASKӳ���
Y = zeros(1,n);%�Ӹ�˹��������
maptable = [0;1];    %������ӳ��
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
    ask_output(index) = X(i).*g(index).*cos(2*pi*fc.*t(index));%�ز��źŵ���
end
figure(2);
plot(t,ask_output);%���Ƶ��ƺ�ͼ��
xlim([0,10]);
ylim([-2,2]);
title('2ASK�����ź�'); 
 
%------------------------- ��4��AWGN�ŵ�����ͼ----------------------------

X1 = zeros(1,n);%AWGN�ŵ��о���ķ��Ŵ�
Bt_Str1 = zeros(1,Bt_StrNumber);%AWGN�ŵ����ش�
ReBt_Str1 = zeros(1,Bt_StrNumber);%AWGN�ŵ��ָ�����ı��ش�
Z = sqrt(Pn(15)/2).*(randn(1,n)+1i.*randn(1,n));%6dB����ȵ���������
Y = X+Z;%AWGN�ŵ�������
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

Bt_Str1 = source; %����ӳ��
for j = 1:44
    
    SER1_sum = 0;
    BER1_sum = 0;
    
    for time = 1:times %���ؿ���ѭ��
       
        source = round(rand(1,n));%������ɶ��������ݲ�����
        maptable = [0;1];    %������ӳ��
        for i = 1:1:n
            for m = 1:M
                if isequal(source(i),maptable(m,:))
                    X(i) = A(m);
                    break;
                end
            end
        end
       
        Z = sqrt(Pn(j)/2).*(randn(1,n)+1i.*randn(1,n));%��������
        Y = X+Z;%AWGN�ŵ��¼�����
        for k = 1:n 
            if Y(k) >= 0.5
                X1(k) = 1;
            else 
                X1(k) = 0; 
            end
        end
        Bt_Str1 = source; %����ӳ��
        SError_Num1 = length(find(source ~= X1));%�������
        SER1(j) = SError_Num1/n;%���������µ�������
        ReBt_Str1 = X1; %���Żָ��ɶ����Ʊ���
        BError_Num1=length(find(Bt_Str1 ~= ReBt_Str1));%����ظ���
        BER1(j) = BError_Num1/n;%���������µ��������
        SER1_sum = SER1_sum+SER1(j);%ѭ������
        BER1_sum = BER1_sum+BER1(j);
    end
    SER1(j) = SER1_sum/times;
    BER1(j) = BER1_sum/times;

    T_SER1(j)=1/2*erfc(sqrt(SNR(j)/2));%����ֵ
end
figure(4)

semilogy(SNR_dB,SER1,'gO'); hold on;
semilogy(SNR_dB,T_SER1,'r');hold off;
axis([-8,16,10^-4,1]);
title('SER~SNR��������');  
xlabel('SNR(dB)');ylabel('�������SER');
legend({'2ASK-AWGN�ŵ�SERʵ��ֵ','2ASK-AWGN�ŵ�SER����ֵ'});

figure(5)
semilogy(SNR_dB,BER1,'gO');hold on;
semilogy(SNR_dB,T_SER1,'r');hold off;
axis([-8,16,10^-4,1]);
title('BER~SNR��������');
xlabel('SNR(dB)');ylabel('������BER');
legend({'2ASK-AWGN�ŵ�BERʵ��ֵ','2ASK-AWGN�ŵ�BER����ֵ'});
    
%----------------------��6������˥���ŵ�����ǰ������ͼ--------------------%

Yr = zeros(1,n);%����˥���ŵ��ķ���
X2 = zeros(1,n);%����˥���ŵ��о���ķ��Ŵ�
Bt_Str2 = zeros(1,Bt_StrNumber);%����˥��˥���ŵ����ش�
ReBt_Str2 = zeros(1,Bt_StrNumber);%����˥��˥���ŵ��ָ�����ı��ش�
j = 44;
h = sqrt(1/2).*(randn(size(X))+1i.*randn(size(X)));
Yr = h.*X+Z;%����˥���ŵ��¸����ƺ���źż�����
Xr = Yr./h;%�ŵ�����
figure(6);%����ͼ
plot(real(X),imag(X),'r*');
hold on;
plot(real(Yr),imag(Yr),'b.');
title('2ASK-����˥��˥���ŵ�����ǰ����ͼ');
hold on;
figure(7);%����ͼ
plot(real(X),imag(X),'r*');
hold on;
plot(real(Xr),imag(Xr),'b.');
axis([-4 4 -2 2]);
title('2ASK-����˥��˥���ŵ����������ͼ');
hold on;

%-------------------��7������˥��˥���ŵ������� �������------------------%

SER2 = zeros(1,length(SNR_dB));%����˥���ŵ��������
BER2 = zeros(1,length(SNR_dB));%����˥���ŵ��������
T_SER2 = zeros(1,length(SNR_dB));%����˥���ŵ������������ֵ
T_BER2 = zeros(1,length(SNR_dB));%����˥���ŵ������������ֵ
Bt_Str2 = source; %����ӳ��
for j = 1:44
    
    SER2_sum = 0;
    BER2_sum = 0;
    
    for time = 1:times 
        
        source = round(rand(1,n));%������ɶ��������ݲ�����
        maptable = [0;1];    %������ӳ��
        for i = 1:1:n
            for m = 1:M
                if isequal(source(i),maptable(m,:))
                    X(i) = A(m);
                    break;
                end
            end
        end
        Bt_Str2 = source; %����ӳ��
        Z = sqrt(Pn(j)/2).*(randn(1,n)+1i.*randn(1,n));%��������
        Y = X+Z;%AWGN�ŵ��¸����ƺ���źż�����
        h = sqrt(1/2).*(randn(size(X))+1i.*randn(size(X)));
        Yr = h.*X+Z;%����˥���ŵ��¸����ƺ���źż�����
        Xr = Yr./h;%�ŵ�����
   
        for k = 1:n %�о�
            if Xr(k) >= 0.5
                X2(k) = 1;
            else 
                X2(k) = 0; 
            end
        end
     
        SError_Num2 = length(find(source ~= X2));%�������
        SER2(j) = SError_Num2/n;%���������µ�������

        ReBt_Str2 = X2; %���Żָ��ɶ����Ʊ���
        BError_Num2=length(find(Bt_Str2 ~= ReBt_Str2));%����ظ���
        BER2(j) = BError_Num2/n;%���������µ��������
      
        SER2_sum = SER2_sum+SER2(j);%ѭ������
        BER2_sum = BER2_sum+BER2(j);
    end
   
    SER2(j) = SER2_sum/times;
    BER2(j) = BER2_sum/times;
  
    T_SER2(j) = (1/2)*(1-(1/sqrt(1+2/SNR(j)))); %����˥��˥�������������ֵ
    
end

figure(8)

semilogy(SNR_dB,SER2,'gO');
hold on;
semilogy(SNR_dB,T_SER2,'r');
hold off;
axis([-8,35,10^-4,1]);
title('SER~SNR��������');  
xlabel('SNR(dB)');ylabel('�������SER');
legend({'2ASK-����˥��˥���ŵ�SERʵ��ֵ','2ASK-����˥��˥���ŵ�SER����ֵ'});
    
figure(9)

semilogy(SNR_dB,BER2,'gO');hold on;
semilogy(SNR_dB,T_SER2,'r');hold off;
axis([-8,35,10^-4,1]);
title('BER~SNR��������');
xlabel('SNR(dB)');ylabel('������BER');
legend({'2ASK-����˥��˥���ŵ�BERʵ��ֵ','2ASK-����˥��˥���ŵ�BER����ֵ'});
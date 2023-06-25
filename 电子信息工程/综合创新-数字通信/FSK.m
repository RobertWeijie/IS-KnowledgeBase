clear
%% ��ʼ��
T=1;                    %��������
f0=40/T; 
f1=40/T+1/T;            %f0,f1 �ز�������Ƶ��
step=0.2;               
tot=1/step;
N=1e6;                  %������
t=0:step:N-step;        %ʱ��
Ps=1;                   %�ź�����
SNR_dB=-10:15;          %����ȣ�dB��ȡֵ��Χ

wave0=cos(2*pi*f0*t);
wave1=cos(2*pi*f0*t);

wave0_delay=cos(2*pi*f0*t+pi/4);          
wave1_delay=cos(2*pi*f1*t+pi/4);          % �����ز�  �ز�wave0->0, wave1->1


%% �����ѭ��

error=zeros(1,length(SNR_dB));        % error ����������

for count=1:length(SNR_dB)             %SNR_dB��count����ʾĳһ�����
   
    basedata=round(rand(1,N));         %������������
    
    

    basedata_1=zeros(1,length(t));        %basedata_1���ڱ�����չ֮��Ļ�������
    
    for p=1:length(t)
        pos=ceil(p/tot);
        basedata_1(p)=basedata(pos);      %��������չΪ��ʱ��ͬά������
    end

    signal_M=basedata_1.*wave1_delay+(1-basedata_1).*wave0_delay;  
    % ����Ϊ1ʱ�����ز�wave1_delay������Ϊ0ʱ�����ز�wave1_delay��signal_MΪ���ɵĵ����ź�
    

   
    SNR=10^(SNR_dB(count)/10);                           %�������������
    Pn=Ps/SNR;                                           
    noise=randn(1,length(signal_M))*(sqrt(Pn));          %�����������������
    signal_N=signal_M+noise;                             %signal_N ������������ź�

    
    Ddata=zeros(1,N);                      %Ddata ���֮��Ķ���������
    
    Zk0=signal_N.*wave0_delay;
    Zk1=signal_N.*wave1_delay;            %�������
    
    for s=1:N                                 
        
        pos_s=(s-1)/step+1;         
        pos_e=s/step;                    %pos_s��pos_e ��s�������������Ļ�����
        Ddata(s)=sum(Zk0(1,pos_s:pos_e))<sum(Zk1(1,pos_s:pos_e));
 
    end                                                                %ÿ���������ν��
                                  
    error(count)=length(find(Ddata-basedata))/length(basedata);        %�Ƚ�ԭ����������������Ķ��������ݣ�����������

end


%% ��������������


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
title('�����ƻ�������');
ylabel('����');                       %���ƶ�������������

basedata_1=zeros(1,length(t));
    
    for p=1:length(t)
        pos=ceil(p/tot);
        basedata_1(p)=basedata(pos);      
    end

    signal_M=basedata_1.*wave1_delay+(1-basedata_1).*wave0_delay;   %�����µĵ����ź�
    
figure(2);
plot(t,signal_M);
axis([0 5 -1 1]);
title('2FSK�����ź�');
ylabel('����');                         %���Ƶ����ź�����

SNR_1=10^(SNR_ex/10); 
Pn=Ps/SNR_1;                                          
noise=randn(1,length(signal_M))*(sqrt(Pn));   %��������
signal_N=signal_M+noise;                             

figure(3);
plot(t,signal_N);
axis([0 10 -3 3]);
title('�����ź�');                     %������һ��������µĽ����ź�
ylabel('����');


    a=zeros(1,length(SNR_dB));
    for k=1:length(SNR_dB)
        
    m=SNR_dB(k);
    snr1=10^(m/10);
    snr=sqrt(snr1*2);
    f=@(x)exp(-x.^2/2).*(erf((snr-x)/sqrt(2))+1);
    a(k)=integral(f,-inf,inf)*sqrt(pi/2)/2/pi;              %����ֵ���㣬a����ɽ����ȷ�ĸ���
    
    end
    
    
    figure(4);
    semilogy(SNR_dB,error,SNR_dB,1-a);
    legend('2FSK�������','2FSK�����������');
    xlabel('��������� (dB)');
    ylabel('�������');                       %  ����������ʺ�����������ʵĶԱ�����
    

   




   
    
  
    











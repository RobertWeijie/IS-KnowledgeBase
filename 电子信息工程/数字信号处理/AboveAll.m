clear,clc
disp("����һ�⡿��������8��˫��Ƶ�źŵ���ɢ�ź�")
disp("��ˣ������롰8����һ����")
num=input('������Ҫ��ת�����źţ�16���ַ���ɣ���ĸΪ��д��:','s');
DTMF_Generated("����һ�⡿���ɵ��ź�",'Question1_Data.txt',num);
disp("DTMF�źż�ͼ��������������")
pause()

disp("���ڶ��⡿��N=205��ĸ�����㷨��ʶ�����8���������")
temp=load("Question1_Data.txt");
disp(IdentifyNum(temp))
disp("������ϣ�������������")
pause()

disp("�������⡿����һ�����8λ���ĵ绰�������źţ�������ʶ��")
disp("��ˣ�����������8λ�źţ���16���ַ���ɣ�")
num=input('������Ҫ��ת�����źţ�16���ַ���ɣ���ĸΪ��д��:','s');
DTMF_Generated("�������⡿���ɵ��ź�",'Question3_Data.txt',num);
temp=load("Question3_Data.txt");
disp(IdentifyNum(temp))
disp("������ϣ�������������")
pause()

disp("�������⡿�ڡ������⡿����8λ���绰�������źŻ����ϵ���һ��50Hz�Ĺ�Ƶ�����źţ��Դ˽���ʶ��")
DTMF_Generated_with50HzSignal("�������⡿���ɵ��ź�",'Question4_Data.txt',num);
temp=load("Question4_Data.txt");
disp(IdentifyNum(temp))
disp("������ϣ�������������")
pause()

disp("�������⡿�ڡ������⡿����8λ���绰�������źŻ����ϵ��Ӱ������źţ��Դ˽���ʶ��")
list=[10,5,3,2,1,0];
for i=1:6
    DTMF_Generated_withAWGN(['�������⡿���ɵ��ź�+',num2str(list(i)),'dB������'],['Question5_Data-',num2str(list(i)),'dB.txt'],num,list(i));
    temp=load(['Question5_Data-',num2str(list(i)),'dB.txt']);
    disp(['����',num2str(list(i)),'dB������ʶ����'])
    S=IdentifyNum(temp);
    disp(S)
end
disp("����������������")
pause()

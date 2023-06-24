clear,clc
disp("【第一题】产生数字8的双音频信号的离散信号")
disp("因此，请输入“8”这一符号")
num=input('输入需要被转换的信号（16种字符组成，字母为大写）:','s');
DTMF_Generated("【第一题】生成的信号",'Question1_Data.txt',num);
disp("DTMF信号见图，点击任意键继续")
pause()

disp("【第二题】用N=205点的戈泽尔算法，识别出“8”这个符号")
temp=load("Question1_Data.txt");
disp(IdentifyNum(temp))
disp("输出如上，点击任意键继续")
pause()

disp("【第三题】产生一理想的8位数的电话拨号音信号，并加以识别")
disp("因此，请随意输入8位信号（由16种字符组成）")
num=input('输入需要被转换的信号（16种字符组成，字母为大写）:','s');
DTMF_Generated("【第三题】生成的信号",'Question3_Data.txt',num);
temp=load("Question3_Data.txt");
disp(IdentifyNum(temp))
disp("输出如上，点击任意键继续")
pause()

disp("【第四题】在【第三题】理想8位数电话拨号音信号基础上叠加一个50Hz的工频干扰信号，对此进行识别")
DTMF_Generated_with50HzSignal("【第四题】生成的信号",'Question4_Data.txt',num);
temp=load("Question4_Data.txt");
disp(IdentifyNum(temp))
disp("输出如上，点击任意键继续")
pause()

disp("【第五题】在【第三题】理想8位数电话拨号音信号基础上叠加白噪声信号，对此进行识别")
list=[10,5,3,2,1,0];
for i=1:6
    DTMF_Generated_withAWGN(['【第五题】生成的信号+',num2str(list(i)),'dB白噪声'],['Question5_Data-',num2str(list(i)),'dB.txt'],num,list(i));
    temp=load(['Question5_Data-',num2str(list(i)),'dB.txt']);
    disp(['叠加',num2str(list(i)),'dB噪声的识别结果'])
    S=IdentifyNum(temp);
    disp(S)
end
disp("点击任意键结束程序")
pause()

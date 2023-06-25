function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 07-Oct-2020 15:34:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global basedata signal_M t signal_N;
N=1e5;

T=1;                    %比特周期
f0=40/T; 
f1=40/T+1/T; 
step=0.001;
tot=1/step;
t=0:step:N-step;
SNR_ex=3;    
Ps=1;
wave0_delay=cos(2*pi*f0*t+pi/4);          
wave1_delay=cos(2*pi*f1*t+pi/4); 
basedata=round(rand(1,N));

basedata_1=zeros(1,length(t));
    
    for p=1:length(t)
        pos=ceil(p/tot);
        basedata_1(p)=basedata(pos);      
    end

    signal_M=basedata_1.*wave1_delay+(1-basedata_1).*wave0_delay;
    
    SNR_1=10^(SNR_ex/10); 
    Pn=Ps/SNR_1;                                          
    noise=randn(1,length(signal_M))*(sqrt(Pn));   %加入噪声
    signal_N=signal_M+noise;



% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

T=1;                    %比特周期
f0=40/T; 
f1=40/T+1/T;            %载波的两个频率
step=0.2;               %步长
tot=1/step;
N=1e6;                  %比特数
t=0:step:N-step;        
Ps=1;
SNR_dB=-10:15;           %信噪比（dB）取值范围


wave0_delay=cos(2*pi*f0*t+pi/4);          
wave1_delay=cos(2*pi*f1*t+pi/4);          % 两个载波  载波wave0->0, wave1->1

error=zeros(1,length(SNR_dB));        % error 误码率数组

for count=1:length(SNR_dB)             %SNR_dB（count）表示某一信噪比
   
    basedata=round(rand(1,N));         %产生基带数据
    
    

    basedata_1=zeros(1,length(t));        %basedata_1用于保存扩展之后的基带数据
    
    for p=1:length(t)
        pos=ceil(p/tot);
        basedata_1(p)=basedata(pos);      %将数据扩展为与时间同维度数组
    end

    signal_M=basedata_1.*wave1_delay+(1-basedata_1).*wave0_delay;  
    % 比特为1时乘以载波wave1_delay，比特为0时乘以载波wave1_delay，signal_M为生成的调制信号
    

   
    SNR=10^(SNR_dB(count)/10);                           %计算线性信噪比
    Pn=Ps/SNR;                                           
    noise=randn(1,length(signal_M))*(sqrt(Pn));          %根据信噪比生成噪声
    signal_N=signal_M+noise;                             %signal_N 加入噪声后的信号

    
    Ddata=zeros(1,N);                      %Ddata 解调之后的二进制数据
    
    Zk0=signal_N.*wave0_delay;
    Zk1=signal_N.*wave1_delay;            %相关运算
    
    for s=1:N                                 
        
        pos_s=(s-1)/step+1;         
        pos_e=s/step;                    %pos_s，pos_e 第s个比特相关运算的积分限
        Ddata(s)=sum(Zk0(1,pos_s:pos_e))<sum(Zk1(1,pos_s:pos_e));
 
    end                                                                %每个比特依次解调
                                  
    error(count)=length(find(Ddata-basedata))/length(basedata);        %比较原二进制数据与解调后的二进制数据，计算误码率

end
a=zeros(1,length(SNR_dB));
    for k=1:length(SNR_dB)
        
    m=SNR_dB(k);
    snr1=10^(m/10);
    snr=sqrt(snr1*2);
    f=@(x)exp(-x.^2/2).*(erf((snr-x)/sqrt(2))+1);
    a(k)=integral(f,-inf,inf)*sqrt(pi/2)/2/pi;              %理论值计算，a是相干解调正确的概率
    
    end
    
    semilogy(SNR_dB,error,SNR_dB,1-a);
    legend('2FSK误比特率','2FSK理论误比特率','location','southwest');
    xlabel('符号信噪比 (dB)');
    ylabel('误比特率');

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


global basedata;

stem(basedata,'filled');
axis([1 100 0 1]);
title('二进制基带数据');
ylabel('幅度'); 


% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

global signal_M;
global t;    

plot(t,signal_M);
axis([0 5 -1 1]);
title('2FSK调制信号');
ylabel('幅度');

% Hint: place code in OpeningFcn to populate axes3


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

global t;
global signal_N;

plot(t,signal_N);
axis([0 10 -3 3]);
title('接收信号');                     %给出在一个信噪比下的接受信号
ylabel('幅度');

% Hint: place code in OpeningFcn to populate axes4

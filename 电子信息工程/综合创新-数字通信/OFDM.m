%GUI����ͨ�����ò�����������ͼ

function varargout = OFDM(varargin)
% OFDM MATLAB code for OFDM.fig
%      OFDM, by itself, creates a new OFDM or raises the existing
%      singleton*.
%
%      H = OFDM returns the handle to a new OFDM or the handle to
%      the existing singleton*.
%
%      OFDM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OFDM.M with the given input arguments.
%
%      OFDM('Property','Value',...) creates a new OFDM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OFDM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OFDM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OFDM

% Last Modified by GUIDE v2.5 11-Oct-2019 19:29:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OFDM_OpeningFcn, ...
                   'gui_OutputFcn',  @OFDM_OutputFcn, ...
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


% --- Executes just before OFDM is made visible.
function OFDM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OFDM (see VARARGIN)

% Choose default command line output for OFDM
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OFDM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OFDM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_M_Callback(hObject, eventdata, handles)
% hObject    handle to edit_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_M as text
%        str2double(get(hObject,'String')) returns contents of edit_M as a double


% --- Executes during object creation, after setting all properties.
function edit_M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
hObject.String = '1';
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L as text
%        str2double(get(hObject,'String')) returns contents of edit_L as a double


% --- Executes during object creation, after setting all properties.
function edit_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
hObject.String = '6';
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_SNR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SNR as text
%        str2double(get(hObject,'String')) returns contents of edit_SNR as a double


% --- Executes during object creation, after setting all properties.
function edit_SNR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SNR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
hObject.String = '20';
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_qpsk.
function radiobutton_qpsk_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_qpsk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_qpsk


% --- Executes on button press in radiobutton_16qam.
function radiobutton_16qam_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_16qam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_16qam


% --- Executes on button press in pushbutton_paint.
function pushbutton_paint_Callback(hObject, eventdata, handles)

M = str2double(get(handles.edit_M,'String'));
L = str2double(get(handles.edit_L,'String'));
SNR = str2double(get(handles.edit_SNR,'String'));
flag = get(handles.popupmenu_mod,'Value');
SER = 0;
BER = 0;
if flag == 1
    

N = 1024;
SsN0 = 10^(SNR/10);
%R = 10;%���ؿ���ѭ������
% SsN0 = 10^(SNR*(exp(SNR-10))/10);
%Ƶ��ѡ�����ŵ�����ɢϵͳ����

%���ɴ������ݣ���ȡ2���ƣ�4���ƣ�16�����е�һ�֣�
Num_bitter = N * 4 * M;
bt = randi([0 1],1,Num_bitter);  %���ɶ�����������

%�����������ݵ��Ʋ�ת��Ϊʱ���ź� �����뱣����� (ѭ��ǰ׺)
% x1 = qammod(symbol_seq,16)/sqrt(10); %��һ��
x1 = modulation_16qam(bt);
symbol_seq = x1; %��������
x1 = x1/sqrt(10);
x1 = reshape(x1,N,M);

x2 = ifft(x1); %�õ��źŵ�ʱ���ʾ
x3 = [x2(3*N/4+1:N,:);x2];
x3 = x3.';
signal = reshape(x3,1,M*(5*N/4));
% p = sum(abs(signal).^2)/length(signal);%����ԭ�źŵĹ���
% sigma = sqrt(p/SsN0);%ͨ��ԭ�źŹ��ʺ�����ȼ��������ı�׼��
% signal = signal + (sqrt((sigma^2)/2)*(randn(1,length(signal))+1j*randn(1,length(signal)))); %�ڽ����ź��м��븴��˹������

%���ն��ź�ģ��(�ྶ�ŵ� ���Ը�˹��������
h = sqrt(1/2/L)*(randn(M,L)+1j*randn(M,L));%�ŵ���һ��
y = zeros(M,N*5/4+L-1);
for k = 1:M
    y(k,:) = conv(x3(k,:),h(k,:));
end
%y = conv(h,signal);%����ԭ�ź�
% p = sum(abs(y).^2)/length(y);%����ԭ�źŵĹ���
p = sum(sum(abs(y.*y)))/(M*(N*5/4+L-1));
sigma = sqrt(p/SsN0);%ͨ��ԭ�źŹ��ʺ�����ȼ��������ı�׼��
y = y + (sqrt((sigma^2)/20)*(randn(size(y))+1j*randn(size(y)))); %�ڽ����ź��м��븴��˹������
y2 = y(:,N/4+1:N*5/4);
y3 = fft(y2,N,2);
H = fft(h,N,2);
y4 = y3./H;
y4 = y4*sqrt(10);
y4 = y4.';
y4 = reshape(y4,1,N*M);
axes(handles.axes2);
plot(imag(y4),real(y4),'.');
axis([-4 4 -4 4]);
%ͳ��������
[receive_bt,re_symbol_seq] = demodulation_16qam(y4);
SER = (N*M - sum(re_symbol_seq == symbol_seq)) / N / M;
BER = (Num_bitter - sum(receive_bt == bt)) / Num_bitter;


else
    
%ȫ�ֱ�������
N = 1024;
%Ƶ��ѡ�����ŵ�����ɢϵͳ����

%���ɴ�������
Num_bitter = N * 2 * M;
bt = randi([0 1],1,Num_bitter);  %���ɶ�����������

%�����������ݵ��Ʋ�ת��Ϊʱ���ź� 
x1 = modulation_qpsk(bt);%ͨ��16-QAM���� ���ɷ�������
symbol_seq = x1;
x1 = x1/sqrt(2);
x1 = reshape(x1,N,M);%����ת��




x2 = ifft(x1); %�õ��źŵ�ʱ���ʾ
x3 = [x2(3*N/4+1:N,:);x2]; %���뱣�����
signal = reshape(x3,1,M*(5*N/4));%����ת�����õ�ʱ���ź�����

%���ն��ź�ģ��(�ྶ�ŵ� ���Ը�˹��������
h = sqrt(1/L/2)*(randn(1,L)+1j*randn(1,L));%����CN��0��1/L���ŵ�
y = conv(h,signal);
p = sum(abs(y).^2)/length(y);%�������ԭ�źŵĹ���
sigma = sqrt(p/(10^(SNR/10)));%���������ı�׼��
y = y + (sqrt(sigma^2/2)*(randn(1,length(y))+1j*randn(1,length(y)))); %�ڽ����ź��м��븴��˹������
y2 = zeros(M,N);
for i = 1:M
    y2(i,:) = y(1,N/4+N*5/4*(i-1)+1:N/4+N*5/4*(i-1)+N);%��ȡ�ź�
end

y3 = fft(y2,N,2);%�õ������źŵ�Ƶ����Ϣ
H = fft(h,N);
for i = 1:M
    y4(1+(i-1)*N:i*N) = y3(i,:)./H;%�ŵ�����
end
y4 = y4*sqrt(2);
axes(handles.axes2);
plot(imag(y4),real(y4),'.');
axis([-2 2 -2 2]);
hold on;
%ͳ��������

[receive_bt,re_symbol_seq] = demodulation_qpsk(y4);%����������ͷ�������
SER = (N*M - sum(re_symbol_seq == symbol_seq)) / N / M;%�����������
BER = (Num_bitter - sum(receive_bt == bt)) / Num_bitter; %����������




end

set(handles.text_ser,'String',num2str(SER));
set(handles.text_ber,'String',BER);
clear all;
% hObject    handle to pushbutton_paint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu_mod.
function popupmenu_mod_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_mod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_mod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_mod


% --- Executes during object creation, after setting all properties.
function popupmenu_mod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_mod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function xingzuo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xingzuo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate xingzuo


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in pushbutton_clear.
function pushbutton_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
cla reset;
clear all;

t=0:0.001:0.6;  
X=sin(2*pi*50*t)+sin(2*pi*120*t);  
y=X+1.5*randn(1,length(t));  
Y=fft(y,512);  
P=Y .*conj(Y)/512;  
f=1000*(0:255)/512;  
figure(1)  
subplot(1,2,1);
plot(t,y,'b');  
xlabel('t');ylabel('y');  
axis([0,0.6,0,8]);  
subplot(1,2,2);
plot(f,P(1:256),'r');  
xlabel('f');ylabel('Y');  
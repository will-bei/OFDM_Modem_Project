%% Part a

x0=[];          % empty array for OFDM with Guard interval
y0=[];          % empty array for OFDM with cyclic prefixes
for k=1:100
    fxx=zeros(1,128);
    dat=(floor(4*rand(1,54))-1.5)/1.5+j*(floor(4*rand(1,54))-1.5)/1.5;
    fxx(65+(-27:27))=[dat(1:27) 0 dat(28:54)];
    xx=ifft(fftshift(fxx));
    x0=[x0 zeros(1,32) xx];
    y0=[y0 xx(97:128) xx];
end

figure(1)
subplot(2,1,1)
plot(0:640, real(x0(1:641)),'b','linewidth',2)
hold on
for k=1:160:640
    plot(k:k+31,real(x0(k:k+31)),'r','linewidth',2)
end
hold off
grid on
set(gca,'XTick',[0:32:640])
axis([0 640 -0.2 0.2])
title('Real Part 128 Point OFDM Signal, with 32 Sample Guard Intervals')
xlabel('Time Index')
ylabel('Amplitude')
subplot(2,1,2)
plot(0:640, real(y0(1:641)),'b','linewidth',2)
hold on
for k=1:160:640
    plot(k:k+31,real(y0(k:k+31)),'r','linewidth',2)
end
hold off
grid on
set(gca,'XTick',[0:32:640])
axis([0 640 -0.2 0.2])
title('Real Part 128 Point OFDM Signal, with 32 Sample Cyclic Prefix Intervals')
xlabel('Time Index')
ylabel('Amplitude')
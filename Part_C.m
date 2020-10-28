%% Part c
data=[];
for k=1:100
    shifted_dat=fft(x0(33+(k-1)*160:33+127+(k-1)*160));
    data=[data shifted_dat(end-64:end) shifted_dat(1:63)];
end

%%
subplot(211)
for k=0:99
    plot(real(data(1+k*128:128+k*128)),'r','Marker','.','LineStyle','none')
    hold on
end
hold off
grid on
xlabel('Time Index')
ylabel('Amplitude')
title('Real Part Demodulated Overlaid OFDM Data Without Distortion')
subplot(212)
plot(data,'r','Marker','o','LineStyle','none');
grid on
axis([-1.5 1.5 -1.5 1.5])
axis('square')
title('Constellation Diagram of Demodulated OFDM Data Without Distortion')

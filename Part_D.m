%% Part D
data_distort=[];
impulse=[1   0   0.2   0   0   0   0   0   0   j*0.1   ];
distort_x0=filter(impulse,1,x0);
for k=1:100
    shifted_dat=fft(distort_x0(33+(k-1)*160:33+127+(k-1)*160));
    data_distort=[data_distort shifted_dat(end-64:end) shifted_dat(1:63)];
end

%%
subplot(211)
for k=0:99
    plot(real(data_distort(1+k*128:128+k*128)),'r','Marker','o','LineStyle','none')
    hold on
end
hold off
grid on
xlabel('Time Index')
ylabel('Amplitude')
title('Real Part Demodulated Overlaid OFDM Data With Distortion')
subplot(212)
plot(data_distort,'r','Marker','o','LineStyle','none');
grid on
axis([-1.5 1.5 -1.5 1.5])
axis('square')
title('Constellation Diagram of Demodulated OFDM Data With Distortion')



%% Part b
ww=kaiser(16000,8)'; % create kaiser window(based on the demo, stopband is -60dB when beta is 8)
ww=ww/sum(ww);
fh0=fftshift(fft(x0.*ww,2048));

% generate power spectrum plot
plot(-0.5:1/2048:0.5-1/2048,20*log10(abs(fh0)));
grid on
title('Spectrum, 2048 Point FFT of the Windowed Time Series')
xlabel('Normalized Frequency')
ylabel('Log Magnitude (dB)')


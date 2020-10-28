%% Part G

% insert second preamble

% 2nd preamble data contains only ones
preamble_2nd = [];
fxx=zeros(1,128);
dat=ones(1,54);
fxx(65+(-27:27))=[dat(1:27) 0 dat(28:54)];
xx=ifft(fftshift(fxx));
preamble_2nd=[zeros(1,32) preamble xx(97:128) xx y0];
%awgn
%preamble_2nd = preamble_2nd + normrnd(0, 0.01, 1, length(preamble_2nd));

% plot signal
plot(0:640, abs(preamble_2nd(1:641)),'b','linewidth',2)
grid on
set(gca,'XTick',[0:32:640])
axis([0 640 0 0.2])
title('OFDM packet with long Preamble with noise');
ylabel('Amplitude')
xlabel('Time Index')

% add channel distortion
data_distort_preamble = [];
impulse=[1   0   0.2   0   0   0   0   0   0   j*0.1   ];
distort_preamble2nd=filter(impulse,1,preamble_2nd);


    shifted_dat=fft(distort_preamble2nd(33+32+210:33+32+210+127));
    data_distort_preamble=[shifted_dat(end-63:end) shifted_dat(1:64)];
frequency_response_fix=ones(1,128)./(data_distort_preamble+ones(1,128)-fxx);

%%
stem(real(data_distort_preamble));

grid on

title('Channel Distortion Estimation (Real Part)')
xlabel('Time/Frequency Index')
ylabel('Magnitude')
%%
data_distort_msg = [];
for k=1:100
    shifted_dat=fft(distort_preamble2nd(403+(k-1)*160:403+127+(k-1)*160));
    temp_dat=[shifted_dat(end-63:end) shifted_dat(1:64)].*frequency_response_fix;
    data_distort_msg=[data_distort_msg temp_dat];
end


%%
subplot(211)
for k=0:99
    plot(real(data_distort_msg(1+k*128:128+k*128)),'r','Marker','o','LineStyle','none')
    hold on
end
hold off
grid on
xlabel('Time Index')
ylabel('Amplitude')
title('Real Part Demodulated Overlaid OFDM Data With Distortion Compensation')
subplot(212)
plot(data_distort_msg,'r','Marker','o','LineStyle','none');
grid on
axis([-1.5 1.5 -1.5 1.5])
axis('square')
title('Constellation Diagram of Demodulated OFDM Data With Distortion Compensation')


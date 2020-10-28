%% part F

% init. with 50 samples delay
preamble = zeros(1,50);
fxx=zeros(1,128);
% zero pack spectrum
dat = zeros(1,54);
for nn = 4:4:52
    dat(nn)=(floor(4*rand)-1.5)/1.5+j*(floor(4*rand)-1.5)/1.5;
end 
fxx(65+(-27:27))=[dat(1:27) 0 dat(28:54)];
xx=54/24*ifft(fftshift(fxx));
preamble=[preamble xx(97:128) xx];

noisypreamble = preamble;
% adding noise
for k = 1:length(preamble)
    noisypreamble(k) = preamble(k) + normrnd(0, 0.01);
end

% append data to end of preamble
noisypreamble = [noisypreamble y0];

% noisy preamble
subplot(4,1,1)
plot(0:640, abs(noisypreamble(1:641)),'b','linewidth',2)
grid on
set(gca,'XTick',[0:32:640])
axis([0 640 0 0.2])
title('Preamble with noise');
ylabel('Magnitude')
xlabel('Time Index')

% noisy preamble w/ delay
delayed_preamble = [zeros(1,32) noisypreamble];
subplot(4,1,2)
plot(0:640, abs(delayed_preamble(1:641)),'b','linewidth',2)
grid on
set(gca,'XTick',[0:32:640])
axis([0 640 0 0.2])
title('Preamble with noise');
ylabel('Magnitude')
xlabel('Time Index')

% calculate cross and auto correlation
delay = zeros(1,33);
cross_reg=zeros(1,32);
auto_reg=zeros(1,32);
cross_sv=zeros(1,370);
auto_sv=zeros(1,370);

for i=33:length(noisypreamble)
    delay=[noisypreamble(i) delay(1:32)];
    p1=delay(1).*conj(delay(33));
    p2=delay(33).*conj(delay(33));
    % calculate cross and auto correlation
    cross_reg=[p1 cross_reg(1:31)];
    auto_reg=[p2 auto_reg(1:31)];
    cross=sum(cross_reg);
    auto=sum(auto_reg);
    angle_sv(i)=angle(cross);
    cross_sv(i)=cross;
    auto_sv(i)=auto;
    ratio=cross/(auto+0.5);
    % get ratio as a marker for preamble
    ratio_sv(i)=ratio;
    flag=0;
    if abs(ratio)>0.5
        flag=1;
    end
    flag_sv(i)=flag;  
end
preamble_index=(flag==1);
preamble_angle=angle_sv(preamble_index);
rotation_rate=mean(preamble_angle);

subplot(4,1,3)
hold on;
plot(1:200, abs(cross_sv(1:200)));
plot(1:200, abs(auto_sv(1:200)));
hold off;
title('Auto correlation and Cross correlation');
xlabel('Time Index')
subplot(4,1,4)
hold on;
plot(1:200, abs(cross_sv(1:200)./(auto_sv(1:200) + 0.005)));
yline(0.5, 'LineStyle','--');
hold off;
title('Ratio of crosscorrelation to autocorrelation (\delta = 0.005)')
axis([0 200 0 1])
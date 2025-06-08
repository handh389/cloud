%% 해양실험 2-3 regular wave

clear all; close all; clc;

dtime = 0.001;
time = 0:dtime:4;

fs = 1/dtime; %sampling rate, 초당 샘플수 
bl = length(time); %block length, 선택된 샘플수
d = bl/fs; %duration, 측정시간
df = fs/bl; %frequency resolution, 주파수 해상도
fn = fs/2; %nyquist frequency, 나이퀴스트 주파수
freq = 0:df:1/dtime;

f1 = 2; a1 = 2/2; phi1 = deg2rad(10);  
f2 = 5; a2 = 2.4/2; phi2 = deg2rad(80);

wave1 = a1*cos(2*pi*f1*time+phi1);
wave2 = a2*cos(2*pi*f2*time+phi2);
wave = wave1 + wave2;
m = max(wave);

figure(1);
set(gcf, 'color', 'w', 'position', [500, 150, 800, 300]);
plot(time, wave1, 'b--', 'linewidth', 1.3); hold on;
plot(time, wave2, 'r--', 'linewidth', 1.3); hold on;
plot(time, wave, 'k-', 'linewidth', 1.3); hold on;
grid on;
set(gca, 'tickdir', 'out');
xlabel('Time(sec)', 'fontsize', 13);
ylabel('\eta(t)', 'fontsize', 13);
legend('\eta_1(t)', '\eta_2(t)', '\eta_1(t)+\eta_2(t)',...
    'location', 'northeast', 'orientation', 'horizental' );
ylim([-3.5, 3.5]);

fy = fft(wave);
fa = abs(fy)*2/bl; %바로 normalize;
fcos = real(fy)*2/bl;
fsin = imag(fy)*2/bl;
n = floor(bl/2); %어차피 절반은 중복된 내용
phase = angle(fy)*180/pi;

figure(2);
set(gcf, 'color', 'w', 'position', [500, 155, 800, 300]);
stem(freq(1:n+1), fa(1:n+1), 'linewidth', 1.3);
xlim([1,20]); ylim([0, 1.4]);
xlabel('Frequency(Hz)', 'fontsize', 13);
ylabel('Amplitude(m)', 'fontsize', 13);
grid on; hold on;
text(1.2, 1.1, '(1.995, 1)'); hold on;
text(4.2, 1.3, '(4.9988, 1.2)'); hold on;

figure(3);
set(gcf, 'color', 'w', 'position', [500, 160, 800, 300]);
stem(freq(1:n+1), phase(1:n+1), 'linewidth', 1.3);
xlim([1,20]);
ylim([-180, 180]);
xlabel('Frequency(Hz)');
ylabel('Wave phase angle(^o)');
set(gca, 'ytick', [-180:60:180]);
grid on;
text(5, 83, '(80.9014)'); hold on;
text(2, -13, '(10.3721)'); hold on;

fa2 = fa(1:n);
[fa2_sort, ind_sort] = sort(fa2, 'descend');
freq_sort = freq(ind_sort);
phase_sort = phase(ind_sort); 
fcos_sort = fcos(ind_sort);
fsin_sort = fsin(ind_sort);


%% data 이용 
clear all; close all; clc;
load data_regular_wave.mat;

figure(1);
set(gcf, 'color', 'w', 'position', [500, 150, 800, 300]);
plot(time, Wave, 'k-', 'linewidth', 0.5);
xlim([0,20]); ylim([-20, 20]);
xlabel('Time(sec)', 'fontsize', 13);
ylabel('\eta(t)', 'fontsize', 13);
grid on;

%푸리에 변환
dtime = 0.01;
bl = length(time);
fs = 1/dtime;
df = fs/bl
freq = 0:df:fs

fy = fft(Wave);
fa = abs(fy)*2/bl;
fcos = real(fy)*2/bl;
fsin = imag(fy)*2/bl;
n = floor(bl/2);
phase = angle(fy)*180/pi

figure(2);
set(gcf, 'color', 'w', 'position', [500, 150, 800, 300]);
stem(freq(1:n+1), fa(1:n+1));
xlim([0,20]); ylim([0,8]);
xlabel('Frequency(Hz)', 'fontsize', 13);
ylabel('Amplitude', 'fontsize', 13);
grid on;
text(5.8, 7.3, '(6.993, 6.9464)'); hold on;
text(0.5, 5.3,'(0.500, 5.0025)'); hold on;
text(9.8, 5.3, '(10.9989, 4.8998)'); hold on;
text(7.7, 3.3, '(8.9991, 2.9605)'); hold on;
text(14.8, 1.5, '(15.9984, 1.1486)'); hold on;

figure(3);
set(gcf, 'color', 'w', 'position', [500, 150, 800, 300]);
stem(freq(1:n+1), phase(1:n+1), 'linewidth', 0.5);
xlim([0,18]);
ylim([-180, 180]);
xlabel('Frequency(Hz)', 'fontsize', 13);
ylabel('Wave phase angle(^o)', 'fontsize', 13);
set(gca, 'ytick', [-180:60:180]);
grid on;
text(6, 30, '(12.6103)'); hold on;
text(0.1, 28, '(10.8946)'); hold on;
text(10, 99, '(79.8140)'); hold on;
text(8, 54, '(36.2412)'); hold on;
text(15, 128, '(108.8335)'); hold on;

fa2 = fa(1:n);
[fa2_sort, ind_sort] = sort(fa2, 'descend');
freq_sort = freq(ind_sort);
phase_sort = phase(ind_sort); 
fcos_sort = fcos(ind_sort);
fsin_sort = fsin(ind_sort);
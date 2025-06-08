%% AA인덱스 - 1. 태양활동데이터로 부터 최대 진폭 갖는 주기 찾기
clear all; close all; clc;
load Solar_irradiance_Wm-2.mat;

datetime = char(datetime(dates, 'convertfrom', 'datenum')); %yyyymmdd 형태의 날짜 %datevec도 사용 가능

dt = 1/12;
t = 0 : dt : length(dates)*dt;
n = length(t);
df = 1/t(end);
freq = 0 : df : 1/dt;

f = fft(solar_irr);
p0 = abs(f); p = p0*2/n;
c0 = abs(real(f)); c = c0*2/n;
s0 = abs(imag(f)); s = s0*2/n;

nf = floor(n/2+1);
p = p(2:nf); c = c(2:nf); s = s(2:nf);
freq = freq(2:nf);

figure(1);
set(gcf, 'color', 'w', 'position', [200,150, 600, 600]);
subplot(2,1,1);
plot(dates, solar_irr, 'k');
xlim([dates(1),dates(end)]);
datetick('x');
xlabel('Year'); ylabel('Solar Irradiance(Wm^-2)');
title('Solar Irradiance By Year','FontSize',14,'FontWeight','bold');
set(gca, 'tickdir', 'out');

subplot(2,1,2);
stem(freq , p, 'b');
xlim([0,6]);
xlabel('Frequency(1/yr)'); ylabel('Amplitude');
title('Fourier Transform of Solar Irradiance','FontSize',14,'FontWeight','bold');
set(gca, 'tickdir', 'out');
[p_sort, index_sort] = sort(p, 'descend');
freq_sort = freq(index_sort);c_sort = c(index_sort);s_sort = s(index_sort);
hold on;
[peak, location] = findpeaks(p, 'minpeakprominence' , 0.047);
plot(freq(location), peak, 'v' , 'markeredgecolor', 'b', 'markerfacecolor', 'b');
peak_p = p(location); peak_c = c(location); peak_s = s(location);
grid on; hold on;
for i = 1 : length(peak);
    text(freq(location(i))-0.1, peak(i)+0.03, num2str(round(1/freq(location(i)),1)));
end
%% AA인덱스 - 2. 지구 자기장 활동 지수 데이터(AA index) 가장 잘 묘사하는 주기
clear all; close all; clc;
load AA_index.mat;

datetime = char(datetime(dates, 'convertfrom', 'datenum')); %yyyymmdd 형태의 날짜 %datevec도 사용 가능

dt = 1/12;
t = 0 : dt : length(dates)*dt;
n = length(t);
df = 1/t(end);
freq = 0 : df : 1/dt;

f = fft(AA);
p0 = abs(f); p = p0*2/n;
c0 = abs(real(f)); c = c0*2/n;
s0 = abs(imag(f)); s = s0*2/n;

nf = floor(n/2+1);
p = p(2:nf); c = c(2:nf); s = s(2:nf);
freq = freq(2:nf);

figure(1);
set(gcf, 'color', 'w', 'position', [200,150, 600, 600]);
subplot(2,1,1);
plot(dates, AA, 'k');
xlim([dates(1),dates(end)]);
datetick('x');
xlabel('Year'); ylabel('AA Index');
title('AA Index by Year','FontSize',14,'FontWeight','bold');

subplot(2,1,2);
stem(freq , p, 'b');
xlabel('Frequency(1/yr)'); ylabel('Amplitude');
title('Fourier Transform of AA Index','FontSize',14,'FontWeight','bold');
[p_sort, index_sort] = sort(p, 'descend');
freq_sort = freq(index_sort);c_sort = c(index_sort);s_sort = s(index_sort);

[peak, location] = findpeaks(p, 'minpeakprominence', 1.27);
peak_p = p(location); peak_c = c(location); peak_s = s(location);
grid on; hold on;
for i = 1 : length(peak);
    text(freq(location(i))-0.1, peak(i)+0.3, num2str(round(1/freq(location(i)),1)));
end
plot(freq(location), peak, 'v' , 'markeredgecolor', 'b', 'markerfacecolor', 'b');
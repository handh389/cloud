%% 해양실험 2-7 TIDE
%태안 tide
clear all; close all; clc;
[time, tidal_height] = textread('태안_DT_457_2019_KR.txt', '%19c%3s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s', 'delimiter',' ','headerlines',4);
time = datetime(time);
tidal_height = str2double(tidal_height); %조위 cm
%% 태안 11월 23일 데이터만 추출
find1123 = find(time >= datetime(2019, 11, 23) & time <= datetime(2019, 11,24));
time1123 = time(find1123); timenumber1123 = datenum(time1123);
tidal_height1123 = tidal_height(find1123)/100; %조위 m로 변환
%% 태안 11월 23일 데이터 도시
figure(1); clf;
set(gcf, 'color', 'w', 'position', [200, 150, 700, 350]);
plot(timenumber1123, tidal_height1123, 'k');
xlim([min(timenumber1123), max(timenumber1123)]); ylim([0,10]);
hhmm1123 = [datetime(2019, 11, 23, 0, 0, 0) : hours(3) : datetime(2019, 11, 24, 0, 0, 0)];
hhmmnumber1123 = datenum(hhmm1123); % x축에 시계열을 놓기 위하여 datenum로 변환하고 tick도 설정
char1123 = char(hhmm1123); timetick1123 = char1123(:, 12:16);
set(gca, 'xtick', hhmmnumber1123, 'xticklabel', timetick1123, 'ytick', [0:1:10]);
set(gca, 'tickdir', 'out');
xlabel('Time (Hour:Minute)', 'fontsize', 12); 
ylabel('Tidal Height (m)', 'fontsize', 12);
title('Tidal Height of Tae-an, South Korea (November 23, 2019)', 'fontweight', 'bold', 'fontsize', 14);
%% 태안 11월 23일 만조, 간조 찾기
[peaktide1123, location] = findpeaks(abs(tidal_height1123-4), 'minpeakprominence', 0.1);
maxtime1123 = time1123(location);
%% 태안 10월, 11월 데이터 추출
find1011 = find(time >= datetime(2019, 10, 24) & time <= datetime(2019, 11, 24));
time1011 = time(find1011); timenumber1011 = datenum(time1011);
tidal_height1011 = tidal_height(find1011)/100;
tidal_height1011 = inpaint_nans(tidal_height1011, 3); %nan값을 보간한다.
%최신버전 matlab은 fillmissing함수 이용하여 보간가능
%% 태안 10월, 11월 데이터 도시
figure(2);clf;
set(gcf, 'color', 'w', 'position', [200, 150, 700, 350]);
plot(timenumber1011, tidal_height1011, 'k');
xlim([min(timenumber1011), max(timenumber1011)]); ylim([0,10]);
hhmm1011 = [datetime(2019, 10, 24, 0, 0, 0) : days(5) : datetime(2019, 11, 24, 0, 0, 0)];
hhmmnumber1011 = datenum(hhmm1011); 
char1011 = char(hhmm1011); timetick1011 = char1011(:, 6:10);
set(gca, 'xtick', hhmmnumber1011, 'xticklabel', timetick1011, 'ytick', [0:1:10]);
set(gca, 'tickdir', 'out');
xlabel('Time (Month-Day)', 'fontsize', 12); 
ylabel('Tidal Height (m)', 'fontsize', 12);
title('Tidal Height of Tae-an, South Korea (October 24 ~November 23, 2019)', 'fontweight', 'bold', 'fontsize', 14);
%% 태안 10월, 11월 만조, 간조 찾기
[peaktide1011, location] = findpeaks(abs(tidal_height1011-4), 'minpeakprominence', 0.5);
%극소값도 구하기 위해 대충 중간지점을 빼고 절댓값해서 findpeaks함수를 사용했다
peaktide1011 = sort(tidal_height1011(location));
HLW1011 = mean(peaktide1011(1:95));
HMW1011 = mean(peaktide1011(96:end));
%% 태안 11월 23일 푸리에 변환
dt1123 = 1/60; %1분 단위를 시간으로 변환
t1123 =0 : dt1123 : length(time1123)*dt1123;
n1123 = length(t1123);
df1123 = 1/t1123(end);
freq1123 = 0 : df1123 : 1/dt1123;

f1123 = fft(tidal_height1123);
p01123 = abs(f1123); p1123 = p01123*2/n1123; 
c01123 = abs(real(f1123)); c1123 = c01123*2/n1123;
s01123 = abs(imag(f1123)); s1123 = s01123*2/n1123;
nf1123 = floor(n1123/2+1);
p1123 = p1123(2:nf1123); c1123 = c1123(2:nf1123); s1123 = s1123(2:nf1123);
freq1123 = freq1123(2:nf1123);

figure(3); clf;
set(gcf, 'color', 'w', 'position', [200, 150, 700, 350]);
stem(freq1123, p1123, 'b'); hold on; xlim([0,0.5]); ylim([0,3]);
xlabel('Frequency(1/hour)', 'fontsize', 12); ylabel('Amplitude(m)', 'fontsize', 12);
title('FFT Tidal Height of Tae-an, South Korea (November 23, 2019)','FontSize',14,'FontWeight','bold');
set(gca, 'tickdir', 'out');
[peak1123, location1123] = findpeaks(p1123, 'minpeakprominence', 1);  
peak1123_p = p1123(location1123); peak1123_freq = freq1123(location1123);
plot(peak1123_freq, peak1123_p+0.1, 'v', 'markeredgecolor', 'b', 'markerfacecolor', 'b');
text(peak1123_freq-0.07, peak1123_p+0.22, ['Amplitude: ' num2str(peak1123_p), ' m']);
text(peak1123_freq-0.07, peak1123_p+0.36, ['Period: ' num2str(1/peak1123_freq), ' hour']);
%% 태안 10, 11월 푸리에 변환
dt1011 = 1/60; %1분 단위를 1시간으로 변환
t1011 =0 : dt1011 : length(time1011)*dt1011;
n1011 = length(t1011);
df1011 = 1/t1011(end);
freq1011 = 0 : df1011 : 1/dt1011;

f1011 = fft(tidal_height1011);
p01011 = abs(f1011); p1011 = p01011*2/n1011; 
c01011 = abs(real(f1011)); c1011 = c01011*2/n1011;
s01011 = abs(imag(f1011)); s1011 = s01011*2/n1011;
nf1011 = floor(n1011/2+1);
p1011 = p1011(2:nf1011); c1011 = c1011(2:nf1011); s1011 = s1011(2:nf1011);
freq1011 = freq1011(2:nf1011);
clear period1011;
figure(4); clf;
set(gcf, 'color', 'w', 'position', [200, 150, 700, 350]);
stem(freq1011, p1011, 'b');hold on; xlim([0,0.30]); ylim([0,3]);
xlabel('Frequency(1/hour)', 'fontsize', 12); ylabel('Amplitude(m)', 'fontsize', 12);
title('FFT Tidal Height of Tae-an, South Korea (October 24 ~ November 23, 2019)','FontSize',14,'FontWeight','bold');
set(gca, 'tickdir', 'out', 'xtick', [0:0.05:0.30]);
[peak1011, location1011] = findpeaks(p1011, 'minpeakprominence', 0.013);  
peak1011_p = p1011(location1011); peak1011_freq = freq1011(location1011);
for i = 1 : length(peak1011);
    plot(peak1011_freq(i), peak1011_p(i)+0.1, 'v', 'markeredgecolor', 'b', 'markerfacecolor', 'b');
    text(peak1011_freq(i)-0.001, peak1011_p(i)+0.22, num2str(i));
    period1011(i) = 1/peak1011_freq(i); 
end
period1011 = period1011'   
%% 흑산도 tide
clear all; close all; clc;

[time, tidal_height] = textread('흑산도_DT_16_2019_KR.txt', '%19c%3s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s', 'delimiter',' ','headerlines',4);
time = datetime(time);
tidal_height = str2double(tidal_height);
%% 흑산도 11월 23일 데이터만 추출
find1123 = find(time >= datetime(2019, 11, 23) & time <= datetime(2019, 11,24));
time1123 = time(find1123); timenumber1123 = datenum(time1123);
tidal_height1123 = tidal_height(find1123)/100; %조위 m로 변환
tidal_height1123 = inpaint_nans(tidal_height1123, 3); %nan값을 보간한다.
%% 흑산도 11월 23일 데이터 도시
figure(1); clf;
set(gcf, 'color', 'w', 'position', [200, 150, 700, 350]);
plot(timenumber1123, tidal_height1123, 'k');
xlim([min(timenumber1123), max(timenumber1123)]); ylim([0,10]);
hhmm1123 = [datetime(2019, 11, 23, 0, 0, 0) : hours(3) : datetime(2019, 11, 24, 0, 0, 0)];
hhmmnumber1123 = datenum(hhmm1123); % x축에 시계열을 놓기 위하여 datenum로 변환하고 tick도 설정
char1123 = char(hhmm1123); timetick1123 = char1123(:, 12:16);
set(gca, 'xtick', hhmmnumber1123, 'xticklabel', timetick1123, 'ytick', [0:1:10]);
set(gca, 'tickdir', 'out');
xlabel('Time (Hour:Minute)', 'fontsize', 12); 
ylabel('Tidal Height (m)', 'fontsize', 12);
title('Tidal Height of Heuk-san-do, South Korea (November 23, 2019)', 'fontweight', 'bold', 'fontsize', 14);
%% 흑산도 11월 23일 만조, 간조 찾기
[peaktide1123, location] = findpeaks(abs(tidal_height1123-2), 'minpeakprominence', 0.1);
maxtime1123 = time1123(location);
%% 흑산도 10월, 11월 데이터 추출
find1011 = find(time >= datetime(2019, 10, 24) & time <= datetime(2019, 11, 24));
time1011 = time(find1011); timenumber1011 = datenum(time1011);
tidal_height1011 = tidal_height(find1011)/100;
tidal_height1011 = inpaint_nans(tidal_height1011, 3); %nan값을 보간한다.
%% 흑산도 10월, 11월 데이터 도시
figure(2);clf;
set(gcf, 'color', 'w', 'position', [200, 150, 700, 350]);
plot(timenumber1011, tidal_height1011, 'k');
xlim([min(timenumber1011), max(timenumber1011)]); ylim([0,10]);
hhmm1011 = [datetime(2019, 10, 24, 0, 0, 0) : days(5) : datetime(2019, 11, 24, 0, 0, 0)];
hhmmnumber1011 = datenum(hhmm1011); 
char1011 = char(hhmm1011); timetick1011 = char1011(:, 6:10);
set(gca, 'xtick', hhmmnumber1011, 'xticklabel', timetick1011, 'ytick', [0:1:10]);
set(gca, 'tickdir', 'out');
xlabel('Time (Month-Day)', 'fontsize', 12); 
ylabel('Tidal Height (m)', 'fontsize', 12);
title('Tidal Height of Heuk-san-do, South Korea (October 24 ~November 23, 2019)', 'fontweight', 'bold', 'fontsize', 14);
%% 흑산도 10월, 11월 만조, 간조 찾기
[peaktide1011, location1011] = findpeaks(abs(tidal_height1011-2), 'minpeakprominence', 0.2);
peaktide1011 = sort(tidal_height1011(location1011));
HLW1011 = mean(peaktide1011(1:100));
HMW1011 = mean(peaktide1011(101:end));
%% 흑산도 11월 23일 푸리에 변환
dt1123 = 1/60; %1분 단위를 시간으로 변환
t1123 =0 : dt1123 : length(time1123)*dt1123;
n1123 = length(t1123);
df1123 = 1/t1123(end);
freq1123 = 0 : df1123 : 1/dt1123;

f1123 = fft(tidal_height1123);
p01123 = abs(f1123); p1123 = p01123*2/n1123; 
c01123 = abs(real(f1123)); c1123 = c01123*2/n1123;
s01123 = abs(imag(f1123)); s1123 = s01123*2/n1123;
nf1123 = floor(n1123/2+1);
p1123 = p1123(2:nf1123); c1123 = c1123(2:nf1123); s1123 = s1123(2:nf1123);
freq1123 = freq1123(2:nf1123);

figure(3); clf;
set(gcf, 'color', 'w', 'position', [200, 150, 700, 350]);
stem(freq1123, p1123, 'b'); hold on; xlim([0,0.5]); ylim([0,3]);
xlabel('Frequency(1/hour)', 'fontsize', 12); ylabel('Amplitude(m)', 'fontsize', 12);
title('FFT Tidal Height of Heuk-san-do, South Korea (November 23, 2019)','FontSize',14,'FontWeight','bold');
set(gca, 'tickdir', 'out');
[peak1123, location1123] = findpeaks(p1123, 'minpeakprominence', 1);  
peak1123_p = p1123(location1123); peak1123_freq = freq1123(location1123);
plot(peak1123_freq, peak1123_p+0.1, 'v', 'markeredgecolor', 'b', 'markerfacecolor', 'b');
text(peak1123_freq-0.07, peak1123_p+0.22, ['Amplitude: ' num2str(peak1123_p), ' m']);
text(peak1123_freq-0.07, peak1123_p+0.36, ['Period: ' num2str(1/peak1123_freq), ' hour']);
%% 흑산도 10, 11월 푸리에 변환
dt1011 = 1/60; %1분 단위를 1시간으로 변환
t1011 =0 : dt1011 : length(time1011)*dt1011;
n1011 = length(t1011);
df1011 = 1/t1011(end);
freq1011 = 0 : df1011 : 1/dt1011;

f1011 = fft(tidal_height1011);
p01011 = abs(f1011); p1011 = p01011*2/n1011; 
c01011 = abs(real(f1011)); c1011 = c01011*2/n1011;
s01011 = abs(imag(f1011)); s1011 = s01011*2/n1011;
nf1011 = floor(n1011/2+1);
p1011 = p1011(2:nf1011); c1011 = c1011(2:nf1011); s1011 = s1011(2:nf1011);
freq1011 = freq1011(2:nf1011);
clear period1011;
figure(4); clf;
set(gcf, 'color', 'w', 'position', [200, 150, 700, 350]);
stem(freq1011, p1011, 'b');hold on; xlim([0,0.3]); ylim([0,3]);
xlabel('Frequency(1/hour)', 'fontsize', 12); ylabel('Amplitude(m)', 'fontsize', 12);
title('FFT Tidal Height of Heuk-san, South Korea (October 24 ~ November 23, 2019)','FontSize',14,'FontWeight','bold');
set(gca, 'tickdir', 'out', 'xtick', [0:0.05:0.3]);
[peak1011, location1011] = findpeaks(p1011, 'minpeakprominence', 0.01);  
peak1011_p = p1011(location1011); peak1011_freq = freq1011(location1011);
for i = 1 : length(peak1011);
    plot(peak1011_freq(i), peak1011_p(i)+0.1, 'v', 'markeredgecolor', 'b', 'markerfacecolor', 'b');
    text(peak1011_freq(i)-0.001, peak1011_p(i)+0.22, num2str(i));
    period1011(i) = 1/peak1011_freq(i)   
end
period1011 = period1011'
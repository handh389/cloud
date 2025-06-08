%% 해양실험2-2  
clear all;
close all;
clc;

[dep, v, t1, t2] = textread('data01.txt', '%f%f%f%f');
%유속 v는 cm/s단위

figure(1);
set(gcf, 'color', 'w');
plot(v, dep, 'o-', 'color', 'k', 'linewidth', 1.5);
hold on;
plot([0,0], [min(dep), max(dep)],'k--');
hold on;
axis ij; ;%수심은 아래로 갈수록 깊어짐
xlim([-200, 200]);
set(gca, 'xaxislocation', 'top', 'xticklabels', abs([-200:50:200]));
%x축 양의 방향이 북, 음의 방향이 남;
xlabel('Velocity of Flow(cm/s)', 'FontSize', 10, 'color', 'k');
ylabel('Depth(m)', 'fontsize', 10, 'color', 'k');
set(gca,'TickDir','out');
title('Velocity of Florida Current by Depth', 'fontweight', 'bold', 'fontsize', 16);
text(183,-80, 'North'); 
text(-218, -80, 'South');

figure(2);
set(gcf, 'color', 'w');
plot(t1, dep, 'o-', 'color', 'm', 'linewidth', 1.5);
hold on;
plot(t2, dep, 'o-', 'color', 'b', 'linewidth', 1.5);
hold on;
axis ij;
xlabel('Temperature(ºC)', 'FontSize', 10, 'color', 'k');
set(gca, 'xaxislocation', 'top');
ylabel('Depth(m)', 'fontsize', 10, 'color', 'k');
set(gca,'TickDir','out');
title('Temperature of Florida Current by Depth', 'fontweight', 'bold', 'fontsize', 16);
legend('west of the measurement point', 'east of the measurement point', 'location', 'southeast');

%%
clear all;
close all;
clc;

[time, v] = textread('data02.txt', '%f%f');

%평균유속 구하기
for i=2:length(v)-1
    v_mean(i) = (v(i-1)+v(i+1))/2
    v_mean(1)=nan;
    v_mean(length(v))=nan;
end

%평균유속과의 anomaly를 이용하여 조석류 구하기
for j=2:length(v)-1;
    v_tide(j) = v(j)-v_mean(j);
    v_tide(1) = nan;
    v_tide(length(v)) = nan;
end

    
figure(3);
set(gcf, 'color', 'w', 'position', [500, 300, 900, 300]);
plot(time, v, 'o-', 'color', 'b', 'linewidth', 1.5);
hold on;
plot(time, v_mean, 'o-', 'color', 'm', 'linewidth', 1.5);
hold on;
plot([0,132],[mean(v), mean(v)],'k--'); 
hold on;
text(102, 17, 'mean velocity of flow');
xlim([0,132]);
xlabel('time(hour)', 'fontsize', 10);
ylabel('velocity of flow(cm/s)', 'fontsize', 10);
title('Velocity of Flow by Time', 'fontweight', 'bold', 'fontsize', 16);
legend('velocity of flow', 'without tide', 'location', 'southeast')

figure(4);
set(gcf, 'color', 'w', 'position', [500, 300, 900, 300]);
plot(time, v_tide, 'o-', 'color', 'k', 'linewidth', 1.5);
xlim([0,132]);
xlabel('time(hour)', 'fontsize', 10);
ylabel('tide speed(cm/s)', 'fontsize', 10);
title('Tide Speed by Time', 'fontweight', 'bold', 'fontsize', 16);

%% 푸리에 변환 이용하기
dt = 6;
t = 6:dt:126;
dfreq = 1/t(end);
freq = 0: dfreq: 1/dt;
n = length(t);

f = fft(v_tide(2:length(v_tide)-1));
p0 = abs(f); %푸리에 변환 값의 복소수 크기
p = p0*(2/n); %푸리에 변환 값 크기의 크기 변환

figure(5);
set(gcf, 'color', 'w', 'position', [500, 300, 900, 300]);
stem(freq(1:length(freq)-1), p);
xlim([0, 0.08]);
ylim([0,12]);
[p_sort, index_sort] = sort(p, 'descend'); 
freq_sort = freq(index_sort);
xlabel('frequency(1/s)');
ylabel('amplitude');
title('Fourier Transform of Tide Speed','FontSize',14,'FontWeight','bold');
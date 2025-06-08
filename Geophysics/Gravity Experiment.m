%% 중력 탐사
clear all; close all; clc;

[location, time, g_value]...
    = textread('지물_중력탐사_데이터.csv', '%*s%*s%s%4c%f', 'delimiter', ',', 'headerlines', 1);

%계기 보정하기
drift_value = g_value(6)-g_value(1); %옥상에서 마지막에서 잰 값과 처음 잰 값의 차이
hour = str2num(time(:, 1:2)); minute = str2num(time(:, 3:4)); 
for i = 1 : 6;
    time_d(i) = datetime(2020,10,13,hour(i), minute(i), 0); 
    time_diff(i) = minutes(time_d(i)-time_d(1)); %각각 측정한 시간과 처음 측정한 시간의 차이
end
 drift_constant = drift_value /time_diff(6); %분당 계기 값 변화량
 for i = 1 : 6;   
     drift_correction(i) = drift_constant * time_diff(i); %계기 보정
 end
 for i = 1 : 6; 
 g_value2(i) = g_value(i) - drift_correction(i); %계기 보정한 값 빼기
 end
 
g_m = G866transfer(g_value2); %중력 측정값 mgal로 변환
for i = 1 : length(g_m)-1;
    g_m_diff(i) = g_m(i+1) - g_m(i); %층별 중력 측정값 차이
end
for i = 1 : length(g_m)-1
    height1(i) = g_m_diff(i)/0.3086; %후리에어 변환 이용하여 층별 높이 측정
end
for i = 1 : length(g_m)-1
    height2(i) = g_m_diff(i)/0.2635; %후리에어 변환 이용하여 층별 높이 측정
end


height_m = [3.636+3.623+3.683+3.701, 3.636+3.623+3.683, 3.636+3.626, 3.636, 0, 3.636+3.623+3.683+3.701];
%%
figure(1);
set(gcf, 'color', 'w');
scatter(height_m, g_m, 'markeredgecolor', 'b', 'markerfacecolor' ,'b'); hold on;
trend = polyfit(height_m, g_m, 1);
fit_x = 0:1:15;
fit_y = trend(1)*fit_x + trend(2);
plot(fit_x, fit_y, 'linewidth', 1.5, 'color', 'm'); hold on;
text(3, 3620.5, 'y = -0.2635x + 3623');
set(gca, 'xtick', [0:3:15]);
set(gca, 'ytick', [3619:1:3623]);
xlabel('Height Based On 1F(m))', 'fontsize', 12);
ylabel('g_m(mgal)', 'fontsize', 12);
title('g_m by Floor', 'fontweight', 'bold', 'fontsize', 14);
%%
figure(2);
set(gcf, 'color', 'w');
for i = 1:length(g_m);
    g_F1(i) = g_m(i) + 0.3086*height_m(i);
end
for i = 1:length(g_m);
    g_F2(i) = g_m(i) + 0.2635*height_m(i);
end
plot(height_m(1:5), g_F1(1:5), 'o-', 'color', 'b', 'linewidth', 1.5); hold on;
plot(height_m(1:5), g_F2(1:5), 'o-', 'color', 'm', 'linewidth', 1.5); hold on;
legend('\Deltag_F(free-air anomaly)', 'Modified \Deltag_F(free-air anomaly)', 'location', 'Northwest');
set(gca, 'xtick', [0:3:15]);
set(gca, 'ytick', [3622.9:0.2:3623.7]);
xlabel('Height Based On 1F(m))', 'fontsize', 12);
ylabel('\Deltag_F(free-air anomaly)', 'fontsize', 12);
title('Free-air Anomaly by Height', 'fontweight', 'bold', 'fontsize', 14);
%%
%콘크리트 밀도 2400kg/m^3
for i = 1:5;
    g_bp(i) = (5-i)*0.2*(2400*0.04193*10^(-3));
    g_B1(i) = g_F1(i) - g_bp(i);
end
for i = 1:5;
    g_bp(i) = (5-i)*0.2*(2400*0.04193*10^(-3));
    g_B2(i) = g_F2(i) - g_bp(i);
end
figure(3);
set(gcf, 'color', 'w');
plot(height_m(1:5), g_B1, 'o-', 'color', 'b', 'linewidth', 1.5); hold on;
plot(height_m(1:5), g_F1(1:5), 'o-', 'color', 'm', 'linewidth', 1.5); hold on;
ylim([3622.8,3623.7]);
set(gca, 'xtick', [0:3:15]);
set(gca, 'ytick', [3622.9:0.2:3623.7]);
xlabel('Height Based On 1F(m))', 'fontsize', 12);
ylabel('\Deltag', 'fontsize', 12);
legend('\Deltag_B(Bouguer Gravity Anomaly)', '\Deltag_F(Free-air Gravity Anomaly)', 'location', 'northwest');
title('Free-air Anomaly & Bouguer Anomaly', 'fontweight', 'bold', 'fontsize', 14);

figure(4);
set(gcf, 'color', 'w');
plot(height_m(1:5), g_B2, 'o-', 'color', 'b', 'linewidth', 1.5); hold on;
plot(height_m(1:5), g_F2(1:5),'o-', 'color', 'm', 'linewidth', 1.5); hold on;
ylim([3622.8,3623.7]);
set(gca, 'xtick', [0:3:15]);
set(gca, 'ytick', [3622.9:0.2:3623.7]);
xlabel('Height Based On 1F(m))', 'fontsize', 12);
ylabel('\Deltag', 'fontsize', 12);
legend('Midofied \Deltag_B(Bouguer Gravity Anomaly)', 'Modified \Deltag_F(Free-air Gravity Anomaly)', 'location', 'northwest');
title('Modified Free-air Anomaly & Bouguer Anomaly', 'fontweight', 'bold','fontsize', 14);


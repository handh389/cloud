%% 
clear all;
close all;
clc;

[date, mean_temperature, MAX_temperature, min_temperature, mean_humidity, windspeed, MAX_windspeed, precipitation ]...
    =textread('data_month.txt', '%9c%f%f%f%f%f%f%f', 'headerlines',2);
day=str2num(date(:, 8:9));

figure(1);
set(gcf,'position',[60, 75, 700, 500]);

[yy, data1, data2]=plotyy(day, mean_temperature, day, mean_humidity);
hold on;
set(data1, 'linewidth', 2);
set(data2, 'linewidth', 2);
data3=plot(day, windspeed, 'g', 'linewidth', 2);
hold on;
data4=plot(day, precipitation, 'm','linewidth', 2);
hold on;
axis(yy(1), [1 31 -5 30]);
set(yy(1), 'ytick', [-5:5:30]);
axis(yy(2), [1 31 30 100]);
set(yy(2), 'ytick', [30:10:100]);
xlabel('Day', 'fontsize', 15);
ylabel(yy(1), 'Temp(¨¬C), Prec(mm), Wind Speed(m/s)', 'fontsize', 15);
ylabel(yy(2), 'Humidity(%)', 'fontsize', 15);
legend([data1, data2, data3, data4], 'Mean Temperature', 'Humidity', 'Wind Speed', 'Precipitation');
set(legend, 'location', 'northwest'); 
title('Analysis of March 1996 Data','FontSize',14,'FontWeight','bold')
%%
clear all;
close all;
clc;

[date, num, mean_temperature, humidity, windspeed, winddirection, precipitation]...
    =textread('data_day.txt', '%16c%f%f%f%f%f%f', 'headerlines',2);

figure(2);
set(gcf,'position',[60, 75, 700, 500]);

math_winddirection=450-winddirection;
rad_winddirection=math_winddirection*2*pi/180;
[x,y]=pol2cart(rad_winddirection, windspeed);

[yy, data1, data2]=plotyy(num, mean_temperature, num, humidity);
hold on;
set(data1, 'linewidth', 2);
set(data2, 'linewidth', 2);
data3=feather(-x, -y, 'g');
data3 = data3(1);
hold on;
data4=plot(num, precipitation, 'm','linewidth', 2);
hold on;
xaxislabel=['6 March'; '7 March'; '8 March'; '9 March'];
set(yy, 'xtick', [0:432/3:432], 'xticklabel', xaxislabel);

axis(yy(1), [0, 432, -5, 20]);
set(yy(1), 'ytick', [-5:2:20]);
axis(yy(2), [0, 432, 30, 105]);
set(yy(2), 'ytick', [30:10:105]);
ylabel(yy(1), 'Temp(¨¬C), Prec(mm), Wind Speed(m/s)', 'fontsize', 15);
ylabel(yy(2), 'Humidity(%)', 'fontsize', 15);
legend([data1, data2, data3, data4], 'Mean Temperature', 'Humidity', 'Wind Speed', 'Precipitation');
set(legend, 'location', 'northwest');
title('Analysis of 6~8 March 1996 Data','FontSize',14,'FontWeight','bold')



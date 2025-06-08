%% 지구물리2_ 실험6. Thermoremanent magnetization
clear all; close all; clc;

data_paleo = load ('paleomagneticdata_nanotesla.mat');
data_age = load ('oceanic_crust_age_10ka.mat');
data_coast = load ('coast_line.mat');

pma = data_paleo.pma; lon_p = data_paleo.lon; lat_p = data_paleo.lat;
age = data_age.age; lon_a = data_age.lon; lat_a = data_age.lat;
lon_c = data_coast.lon; lat_c = data_coast.lat;

figure(1);
set(gcf, 'color', 'w', 'position', [200, 150, 700, 300]);
imagesc(lon_p, lat_p, pma); 
load div256.mat; colormap(div256);
colorbar; caxis([-100, 100]); hold on;
a = colorbar; a.Label.String = 'Paleomagnetism(nT)'
plot(lon_c, lat_c, 'color', 'y', 'linewidth', 2); hold on;
xlim([-50, -10]); ylim([20, 40]);
lon_1 = -30; lon_2 = -26.7; lat_1 = 26.9; lat_2 = 31.5
plot([lon_1, lon_2], [lat_1, lat_2], 'y', 'linewidth', 2);
set(gca, 'xtick', [-50:10:-10]); set(gca, 'ytick', [20:5:40]);
set(gca, 'xticklabel', ['50^oW'; '40^oW'; '30^oW'; '20^oW'; '10^oW']);
set(gca, 'yticklabel', ['70^oN'; '65^oN'; '60^oN'; '55^oN'; '50^oN']);
xlabel('Latitude', 'fontsize', 12); ylabel('Longitude', 'fontsize', 12);

line_lon = [lon_1 : (lon_2-lon_1)/1000 : lon_2];
line_lat = [lat_1 : (lat_2-lat_1)/1000 : lat_2];
[line_lon_g, line_lat_g] = meshgrid(line_lon, line_lat);
line_pma = interp2(lon_p, lat_p, pma, line_lon, line_lat);
L = line_pma>0;

figure(2);
set(gcf, 'color', 'w', 'position', [200, 150, 800, 300]);
plot(line_lon(L), line_pma(L), 'm', 'linewidth', 1.5);hold on;
plot(line_lon(~L), -line_pma(~L), 'b', 'linewidth', 1.5);hold on;
xlim([-30, -26.5]); ylim([0, 500]); 
set(gca, 'xtick', [-30:0.5:-26.5], 'ytick', [0:100:500]);
set(gca, 'xticklabel', ['30.0^oW'; '29.5^oW'; '29.0^oW'; '28.5^oW'; '28.0^oW'; '27.5^oW'; '27.0^oW'; '26.5^oW']);
xlabel('Latitude', 'fontsize', 12); ylabel('Paleomagnetism(nT)', 'fontsize', 12);
title('Paleomagnetism of Analysis Area in North Atlantic', 'fontweight', 'bold', 'fontsize', 14);
legend('Normal Polarity', 'Reverse Polarity');
[peak, location] = findpeaks(abs(line_pma), 'minpeakprominence' , 2.3);
for i = 1 : length(peak);
    plot(line_lon(location(i)), peak(i), 'v','markeredgecolor', 'k', 'markerfacecolor', 'k');
    hold on;
    text(line_lon(location(i)), peak(i)+30, num2str(i));
end
grid on;
set(gca, 'tickdir', 'out');

figure(3);
set(gcf, 'color', 'w', 'position', [200, 150, 800, 300]);
imagesc(lon_a, lat_a, age);
load div256.mat; colormap(div256);
colorbar; caxis([0, 3*10^4]); hold on;
a = colorbar; a.Label.String = 'Crust Age(10ka)'
plot(lon_c, lat_c, 'color', 'y', 'linewidth', 2); hold on;
xlim([-50, -10]); ylim([20, 40]);
plot([lon_1, lon_2], [lat_1, lat_2], 'y', 'linewidth', 2);
set(gca, 'xtick', [-50:10:-10]); set(gca, 'ytick', [20:5:40]);
set(gca, 'xticklabel', ['50^oW'; '40^oW'; '30^oW'; '20^oW'; '10^oW']);
set(gca, 'yticklabel', ['70^oN'; '65^oN'; '60^oN'; '55^oN'; '50^oN']);
xlabel('Latitude', 'fontsize', 12); ylabel('Longitude', 'fontsize', 12);
%%
figure(4);
line_age = interp2(lon_a, lat_a, age, line_lon, line_lat);
set(gcf, 'color', 'w', 'position', [200, 150, 800, 300]);
yyaxis left;
plot(line_lon, line_age, 'color', [47/255,157/255,39/255], 'linewidth', 1.5);hold on;
trend_w = polyfit(line_lon(1:523), line_age(1:523), 1); %기울기와 y절편
trend_e = polyfit(line_lon(523:end), line_age(523:end), 1);
text(-30.0, 1450, ['slope : ' num2str(trend_w(1))], 'fontweight', 'bold'); hold on;
text(-27.2, 1450, ['slope : ' num2str(trend_e(1))], 'fontweight', 'bold'); hold on;
set(gca, 'ycolor', [47/255,157/255,39/255]);
ylabel('Crust Age(10ka)'); 

yyaxis right;
plot(line_lon(L), line_pma(L), 'm', 'linewidth', 1.5);hold on;
plot(line_lon(~L), -line_pma(~L), 'b', 'linewidth', 1.5);hold on;
for i = 1 : length(peak);
    plot(line_lon(location(i)), peak(i), 'v','markeredgecolor', 'k', 'markerfacecolor', 'k');
    hold on;
    text(line_lon(location(i)), peak(i)+30, num2str(i));
    plot([line_lon(location(i)),line_lon(location(i))],[0, 2500], '--', 'color', [93/255,93/255,93/255], 'linewidth', 0.1);
end
set(gca, 'ycolor', 'k');
ylim([0, 500]); set(gca, 'ytick', [0:100:500]);
ylabel('Paleomagnetism(nT)', 'fontsize', 12);

xlim([-30, -26.5]);  set(gca, 'xtick', [-30:0.5:-26.5]);
set(gca, 'xticklabel', ['30.0^oW'; '29.5^oW'; '29.0^oW'; '28.5^oW'; '28.0^oW'; '27.5^oW'; '27.0^oW'; '26.5^oW']);
set(gca, 'tickdir', 'out');
xlabel('Latitude', 'fontsize', 12); grid on;
title('Crust Age of Analysis Area in North Atlantic Compared With Paleomagnetism', 'fontweight', 'bold', 'fontsize', 14);
legend('Crust Age','Normal Polarity', 'Reverse Polarity');

%%
line_lon_peak = line_lon(location)';
line_lon_peak10 = line_lon_peak - line_lon_peak(10);
line_age_peak = line_age(location)';
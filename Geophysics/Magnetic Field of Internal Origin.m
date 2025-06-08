%% 지물실험 2-7 Magnetic field of internal origin
clear all; close all; clc;
coast_line = load('coast_lines.mat'); %colat(여위도), lon(경도)
exp7 = load('exp7.mat'); %lat(여위도), lon(경도), M_field(지구 자기장 평균값), M_field_SH(구면조화함수)

coast_colat = coast_line.colat;  coast_lon = coast_line.lon;
lat = exp7.lat;  lon = exp7.lon;
M_field = exp7.M_field;  M_field_SH = exp7.M_field_SH;
degree = M_field_SH(:,1); order = M_field_SH(:,2);
g = M_field_SH(:,3);  h = M_field_SH(:,4);
%% degree별 energy density spectrum
degree_u = unique(degree);
for i = 0 : 60;
    L = M_field_SH(:, 1) == i;
    g = M_field_SH(L, 3);
    h = M_field_SH(L, 4);
    power_spectrum(i+1) = sum(g.^2 + h.^2);
end

figure(1);
set(gcf, 'color', 'w');
semilogy(degree_u, power_spectrum, 'o', 'markersize', 5, 'markeredgecolor', 'k'); hold on;
xlabel('Degree, n', 'fontsize', 12); ylabel('Energy Density(nT^2)', 'fontsize', 12);
title('Energy Density Spectrum (2010~2019)', 'fontsize', 14, 'fontweight', 'bold');
%% energy density spectrum 구간 나누기
x = degree_u; y = log10(power_spectrum);
for j = 0 : 60;
    x1 = x(1:j+1); y1 = y(1:j+1)';
    x2 = x(j+2:end); y2 = y(j+2:end)';
    trend1 = polyfit(x1, y1, 1); line1 = polyval(trend1, x1); %polyfit으로 추세선의 계수를 구하고 
    trend2 = polyfit(x2, y2, 1); line2 = polyval(trend2, x2); %polyval로 추세선의 함수값 구한다.
    rms1 = rms(y1(:)-line1(:)); rms2 = rms(y2(:)-line2(:)); %추세선과 에너지 스펙트럼의 오차 rms
    rms_total(j+1)=rms1 + rms2;
end
find = find(rms_total==min(rms_total)); %rms가 최소가 되는 지점 찾는다 %16번째이니 degree는 15
x11 = x(1:find); y11 = y(1:find)';
x22 = x(find+1:end); y22 = y(find+1:end)';
trend11 = polyfit(x11, y11, 1); line11 = polyval(trend11, x11); 
trend22 = polyfit(x22, y22, 1); line22 = polyval(trend22, x22);
%%
figure(2);
set(gcf, 'color', 'w');
plot(x11, y11, 'o', 'markersize', 5, 'markeredgecolor', 'r'); hold on;
plot(x22, y22, 'o', 'markersize', 5, 'markeredgecolor', 'b'); hold on;
plot(x11, line11, 'r-'); hold on;
plot(x22, line22, 'b-'); hold on;
text(8,6, ['slope : ' num2str(trend11(1)) ' (n\leq15)'], 'fontsize', 12); hold on;
text(30,1, ['slope : ' num2str(trend22(1)) ' (n>15)'], 'fontsize', 12); hold on;
xlabel('Degree, n', 'fontsize', 12); ylabel('Energy Density(log(nT^2))', 'fontsize', 12);
title('Energy Density Spectrum (2010~2019)', 'fontsize', 14, 'fontweight', 'bold');
%% 첫번째 구간의 자기장
L = M_field_SH(:,1) <= find-1;
P1 = M_field_SH(L,:);
P1_grid = plm2xyz(P1, 1); %구면 조화 함수 형태를 위도, 경도에 따른 형태로 1도 간격으로 그린다.
figure(3);
set(gcf, 'color', 'w', 'position', [200, 150, 800, 400]);
imagesc(P1_grid); hold on;
[c,h]=contour(lon, lat, P1_grid, [2*10^4: 0.5*10^4: 7*10^4], 'k'); hold on;
clabel(c,h, 'labelspacing', 300); 
load hsl256.mat;
colormap(hsl256); colorbar; caxis([2*10^4, 7*10^4]);
a=colorbar; a.Label.String = 'Geomagnetic Field(nT)';
a.Label.FontSize = 12;
plot(coast_lon, coast_colat, 'k', 'linewidth', 1.2); hold on;
xlim([0,360]); ylim([0,180]);
xlabel('Longitude', 'fontsize', 12); ylabel('Latitude', 'fontsize', 12);
set(gca, 'ytick', [0:30:180], 'xtick', [0:60:360]);
set(gca, 'xticklabel', [' 0^o  '; ' 60^oE'; '120^oE'; '180^o '; '120^oW'; '60^oW '; '  0^o ']);
set(gca, 'yticklabel', ['90^oN'; '60^oN'; '30^oN';' 0^o ';'30^oS'; '60^oS'; '90^oS']);
title('Geomagnetic Field Based On Degree Below 15 (2010~2019)', 'fontweight', 'bold', 'fontsize', 14); 

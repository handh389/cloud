%% 지물실험 2-8 Geomagnetic Dipole
clear all; close all; clc;

longitude = 0.1:0.1:360;
colatitude = 0.1:0.1:180;
g10 = -29556.8; %nT
g11 = -1671.8;
h11 = 5080.0;

for i = 1 : length(longitude);
    for j = 1 : length(colatitude);
        phi = longitude(i); 
        theta = colatitude(j);
        B_r(round(theta*10), round(phi*10)) = 2*g10*cosd(theta)+2*(g11*cosd(phi)+h11*sind(phi))*sind(theta);
        B_t(round(theta*10), round(phi*10)) = g10*sind(theta)-(g11*cosd(phi)+h11*sind(phi))*cosd(theta);
        B_p(round(theta*10), round(phi*10)) = g11*sind(phi)-h11*cosd(phi); 
    end
end
B_total = sqrt(B_r.^2 + B_t.^2 + B_p.^2);

coast_line = load('coast_lines.mat'); %colat(여위도), lon(경도)
coast_colat = coast_line.colat;  coast_lon = coast_line.lon; 

findmax = find(B_total == max(B_total(:))); 
%%
lon1 = round(findmax(1,1)/1800)/10; lonEW1 = lon1;
colat1 = rem(findmax(1,1), 1800)/10; lat1 = 90-colat1;
lon2 = (round(findmax(2,1)/1800)+1)/10; lonEW2 = 360-lon2;
colat2 = rem(findmax(2,1), 1800)/10; lat2 = 90-colat2;
%%
figure(1); clf; clc;
set(gcf, 'color', 'w', 'position', [200, 150, 800, 350]);
imagesc(longitude, colatitude, B_total); hold on;
load div256.mat; colormap(div256); colorbar; caxis([29000, 60000]);
plot(coast_lon, coast_colat, 'k', 'linewidth', 1); hold on;
[c, h] = contour(longitude, colatitude, B_total, [30000 : 5000: 60000], 'color', 'y'); clabel(c,h, 'fontsize',7,'fontweight', 'bold', 'labelspacing', 500, 'color', 'y'); hold on;
text(lon1-6, colat1-2, '★', 'color', 'y', 'fontweight', 'bold', 'fontsize', 15); hold on;
text(lon2-6, colat2-2, '★', 'color', 'y', 'fontweight', 'bold', 'fontsize', 15); hold on;
text(lon1-31, colat1 - 12, '79.7^oS ,108.2^oE', 'color','y', 'fontweight', 'bold');
text(lon2-31, colat2 + 12, '79.7^oN ,71.8^oW', 'color','y', 'fontweight', 'bold');
xlim([0, 360]); ylim([0, 180])
set(gca, 'xtick', [0:60:360], 'ytick', [0:30:180]);
xticklabel = ['  0^o '; ' 60^oE'; '120^oE'; '180^o '; '120^oW'; ' 60^oW'; '  0^o '];
yticklabel = ['90^oN'; '60^oN'; '30^oN'; ' 0^o '; '30^oS'; '60^oS'; '90^oS'];
a=colorbar; a.Label.String = 'Magnetic Field Value(nT)';
a.Label.FontSize = 12;
set(gca, 'xticklabel', xticklabel, 'yticklabel', yticklabel);
xlabel('Longitude', 'fontsize', 12); ylabel('Latitude', 'fontsize', 12); 
title('World Magnetic Field Due to Geocentric Dipole', 'fontsize', 14', 'fontweight', 'bold');
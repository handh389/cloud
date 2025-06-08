%% PFM_TERMPROJECT_2016-19161_한동환_CASE2
clear all; close all; clc;
% water saturation이 0.6인 경우
u0 = 5; % 초기 속도 5m/s
R = 0.1;
data_6 = csvread('saturation6.csv');
ddata_6 = csvread('dsaturation6.csv');
data_6 = flipud(data_6); % 실제 관 모양과 같게 데이터 테이블의 모양 변화
ddata_6 = flipud(ddata_6);

data_06 = ones(21, 10000);
ddata_06 = ones(21, 10000);
for i = 1 : 11;
    data_06(i, :) = data_6(i, :);
    ddata_06(i, :) = ddata_6(i, :);
end
for i = 12 : 21;
    data_06(i, :) = data_6(22-i, :);
    ddata_06(i, :) = ddata_6(22-i, :);
end

r= ones(21, 10000);
for i = 1 : 11;
    r(i, :) = 0.1 - 0.01 * (i-1);
end
for i = 12 : 21;
    r(i, :) = -r(22-i, :);
end

z = ones(21, 10000);
for i = 1 : 10000;
    z(:, i) = (i - 1) * 4;
end
uz_06 = 2 * u0 .* (1 - (r/R).^2) .* data_06;
ur_06 = - R * u0 .* ddata_06 .* ((r/R).^2 - 0.5*(r/R).^4);
ur_06(11:21, :) = -ur_06(11:21, :); % 중심축을 기준으로 위아래 대칭이어야 하기 때문

figure(1);
set(gcf, 'color', 'w', 'position', [200, 200, 1000, 200]);
load hsl256.mat;
colormap(hsl256);
imagesc(data_06);
colorbar;  caxis([0,1]);
xlabel('Distance : z (km)'); ylabel('Radius : r(cm)');
set(gca,'xtick', [0 : 1000 : 10000], 'ytick', [1 : 5 : 21]); 
set(gca, 'xticklabel',[0: 4 :40]); set(gca, 'yticklabel', [10 : -5 : -10]);
title('f when water saturation is 0.6', 'fontweight', 'bold', 'fontsize', 14);

figure(2);
set(gcf, 'color', 'w', 'position', [200, 200, 1000, 200]);
quiver(z, r*100, uz_06, ur_06, 'k');
xlabel('Distance : z (km)'); ylabel('Radius : r(cm)');
set(gca, 'xticklabel',[0: 4 :36]); set(gca, 'yticklabel', [-10 : 5 : 10]);
title('velocity vector when water saturation is 0.6', 'fontweight', 'bold', 'fontsize', 14);

figure(3);
set(gcf, 'color', 'w', 'position', [200, 200, 1000, 200]);
colormap(hsl256);
imagesc(uz_06);
colorbar; 
xlabel('Distance : z (km)'); ylabel('Radius : r(cm)');
set(gca,'xtick', [0 : 1000 : 10000], 'ytick', [1 : 5 : 21]); 
set(gca, 'xticklabel',[0: 4 :40]); set(gca, 'yticklabel', [10 : -5 : -10]);
title('u_z when water saturation is 0.6', 'fontweight', 'bold', 'fontsize', 14);
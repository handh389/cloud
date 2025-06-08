%% PFM_TERMPROJECT_2016-19161_�ѵ�ȯ_CASE1
clear all; close all; clc;
% water saturation�� 0.5�� ���
u0 = 5; % �ʱ� �ӵ� 5m/s
R = 0.1;
data_5 = csvread('saturation5.csv');
ddata_5 = csvread('dsaturation5.csv');
data_5 = flipud(data_5); % ���� �� ���� ���� ������ ���̺��� ��� ��ȭ
ddata_5 = flipud(ddata_5);

data_05 = ones(21, 10000);
ddata_05 = ones(21, 10000);
for i = 1 : 11;
    data_05(i, :) = data_5(i, :);
    ddata_05(i, :) = ddata_5(i, :);
end
for i = 12 : 21;
    data_05(i, :) = data_5(22-i, :);
    ddata_05(i, :) = ddata_5(22-i, :);
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
uz_05 = 2 * u0 .* (1 - (r/R).^2) .* data_05;
ur_05 = - R * u0 .* ddata_05 .* ((r/R).^2 - 0.5*(r/R).^4);
ur_05(11:21, :) = -ur_05(11:21, :); % �߽����� �������� ���Ʒ� ��Ī�̾�� �ϱ� ����

figure(1);
set(gcf, 'color', 'w', 'position', [200, 200, 1000, 200]);
load hsl256.mat;
colormap(hsl256);
imagesc(data_05);
colorbar;  caxis([0,1]);
xlabel('Distance : z (km)'); ylabel('Radius : r(cm)');
set(gca,'xtick', [0 : 1000 : 10000], 'ytick', [1 : 5 : 21]); 
set(gca, 'xticklabel',[0: 4 :40]); set(gca, 'yticklabel', [10 : -5 : -10]);
title('f when water saturation is 0.5', 'fontweight', 'bold', 'fontsize', 14);

figure(2);
set(gcf, 'color', 'w', 'position', [200, 200, 1000, 200]);
quiver(z, r*100, uz_05, ur_05, 'k');
xlabel('Distance : z (km)'); ylabel('Radius : r(cm)');
set(gca, 'xticklabel',[0: 4 :36]); set(gca, 'yticklabel', [-10 : 5 : 10]);
title('velocity vector when water saturation is 0.5', 'fontweight', 'bold', 'fontsize', 14);

figure(3);
set(gcf, 'color', 'w', 'position', [200, 200, 1000, 200]);
colormap(hsl256);
imagesc(uz_05);
colorbar; 
xlabel('Distance : z (km)'); ylabel('Radius : r(cm)');
set(gca,'xtick', [0 : 1000 : 10000], 'ytick', [1 : 5 : 21]); 
set(gca, 'xticklabel',[0: 4 :40]); set(gca, 'yticklabel', [10 : -5 : -10]);
title('u_z when water saturation is 0.5', 'fontweight', 'bold', 'fontsize', 14);
%% ������ 2-2
%2010, 2014, 2015���� ���º���
clear all;close all;clc;
year = input('year=?(2010, 2014, 2015)');
month = input('month=?(6,7,8)');
load(['a' num2str(year) '.mat']);
sst = struct2array(load(['a' num2str(year) '.mat'], ['sst_' num2str(year) '0' num2str(month)]));

k2c = 273.15*ones(length(lon), length(lat)); %Ķ���� ������ �ٲپ��ش�.
sst_c = sst-k2c;
mask = isnan(sst_c); %nan���� �������� �µ��� -4���� ���߾ �׸��׸� �� �ٴٿ� ����
sst_c(mask) = -4;

figure(1);
set(gcf, 'color', 'w', 'position', [500, 100, 550, 400]);
imagesc(lon, lat, sst_c');  
hold on;
[c,h] = contour(lon, lat, sst_c', [-6:2:34], 'k');
axis xy; hold on;
plot([190, 240],[-5,-5], 'k-',[190, 240],[5,5], 'k-', [190, 190], [-5, 5], 'k-', [240,240], [-5, 5], 'k-', 'linewidth', 2 );
hold on; %���ϴ� ���ñ��� ǥ��
xlim([120,300]); ylim([-90, 90]);
set(gca, 'tickdir', 'out');
load hsl256.mat; hsl256(1:2,:) = 236/256;
colormap(hsl256); colorbar; caxis([24,30]);
set(gca, 'xtick', [120:60:300],'xticklabels',['120^oE'; '180^o '; '120^oW'; ' 60^oW'; ]);
%xticklabel�� ������ �� char�� �̷���� ���� ���� ũ�⸦ ��ġ ���Ѿ� �ϹǷ�
%������� �����̽��ٷ� ó���Ѵ�.
set(gca, 'ytick', [-90:30:90], 'yticklabels', ['90^oS'; '60^oS'; '30^oS'; ' 0^o '; '30^oN'; '60^oN'; '90^oN';]);
title(['SST of Pacific Ocean (0' num2str(month) ', ' num2str(year) ')'], 'fontsize', 14, 'fontweight', 'bold'); 
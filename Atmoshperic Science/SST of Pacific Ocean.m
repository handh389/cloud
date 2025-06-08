%% 대기실험 2-2
%2010, 2014, 2015년의 수온분포
clear all;close all;clc;
year = input('year=?(2010, 2014, 2015)');
month = input('month=?(6,7,8)');
load(['a' num2str(year) '.mat']);
sst = struct2array(load(['a' num2str(year) '.mat'], ['sst_' num2str(year) '0' num2str(month)]));

k2c = 273.15*ones(length(lon), length(lat)); %캘빈을 섭씨로 바꾸어준다.
sst_c = sst-k2c;
mask = isnan(sst_c); %nan값인 육지들의 온도를 -4도로 맞추어서 그림그릴 때 바다와 구별
sst_c(mask) = -4;

figure(1);
set(gcf, 'color', 'w', 'position', [500, 100, 550, 400]);
imagesc(lon, lat, sst_c');  
hold on;
[c,h] = contour(lon, lat, sst_c', [-6:2:34], 'k');
axis xy; hold on;
plot([190, 240],[-5,-5], 'k-',[190, 240],[5,5], 'k-', [190, 190], [-5, 5], 'k-', [240,240], [-5, 5], 'k-', 'linewidth', 2 );
hold on; %엘니뇨 감시구역 표시
xlim([120,300]); ylim([-90, 90]);
set(gca, 'tickdir', 'out');
load hsl256.mat; hsl256(1:2,:) = 236/256;
colormap(hsl256); colorbar; caxis([24,30]);
set(gca, 'xtick', [120:60:300],'xticklabels',['120^oE'; '180^o '; '120^oW'; ' 60^oW'; ]);
%xticklabel을 설정할 때 char로 이루어진 항의 열의 크기를 일치 시켜야 하므로
%빈공간을 스페이스바로 처리한다.
set(gca, 'ytick', [-90:30:90], 'yticklabels', ['90^oS'; '60^oS'; '30^oS'; ' 0^o '; '30^oN'; '60^oN'; '90^oN';]);
title(['SST of Pacific Ocean (0' num2str(month) ', ' num2str(year) ')'], 'fontsize', 14, 'fontweight', 'bold'); 
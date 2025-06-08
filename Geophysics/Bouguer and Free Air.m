%% 부게판, 후리에어 보정
clear all; close all; clc;
[longitude, height, gravity_m, sample_g_F, sample_g_B]...
    =textread('bouguer_freeair_data.csv', '%f%f%f%f%f', 'delimiter', ',', 'headerlines', 2);

% g_B = g_m + g_fa - g_bp;
% g_F = g_m + g_fa;

%후리에어 보정 구하기
for i = 1 : length(height);
    if height(i)<0;
        g_fa(i) = 0;
    else
        g_fa(i) = 0.3086 * height(i); 
    end
end     

%후리에어 이상 구하기
for i = 1 : length(height);
    g_F(i) = gravity_m(i) + g_fa(i);
end

%부게 보정을 구하기에 앞서 rho값 구하기
for i = 1 : length(height);
    sample_g_bp(i) = -sample_g_B(i) + sample_g_F(i); %샘플 부게 보정
    rho(i) = sample_g_bp(i)/(height(i)*0.04193*10^(-3)); %rho 구하기
end
%rho가 바다에서 약 1.64*10^3, 육지에서 약 2.67*10^3 이 나왔다.
%일반적인 바닷물의 밀도는 약 1030이기 때문에 해양에서는 1030을 뺀 값을 쓴 것이다.

%부게 보정 구하기
for i = 1 : length(height);
    if height(i)<0 ; 
        g_bp(i) = (0.04193*10^(-3))*(1.64*10^3)*height(i);
    else
        g_bp(i) = (0.04193*10^(-3))*(2.67*10^3)*height(i);
    end
end

%부게 이상 구하기
for i = 1 : length(height);
    g_B(i) = gravity_m(i) + g_fa(i) - g_bp(i);
end
%%
%지형 그리기
figure(1);
set(gcf, 'color', 'w');
sealevel = zeros(length(height));
area(longitude, sealevel, 'basevalue', -7000, 'facecolor', [217/255, 229/255, 255/255]);hold on;
area(longitude, height, 'basevalue', -7000, 'facecolor', [219/255, 188/255, 104/255]); hold on;
plot([-80, -45], [0,0], 'k-'); hold on;
xlim([min(longitude), max(longitude)]); ylim([-7000, 5000]);
set(gca, 'xtick', [-75:5:-40], 'xticklabels', ['75^oW'; '70^oW'; '65^oW'; '60^oW'; '55^oW'; '50^oW'; ]);
set(gca, 'ytick', [-7000:1000:5000], 'yticklabels', [-7:1:5]);
set(gca, 'tickdir', 'out');
xlabel('longitude', 'fontsize', 12); ylabel('height(km)', 'fontsize', 12);
title('Topography of S.America Near Andes', 'fontweight', 'bold', 'fontsize', 14);
%%
% 후리에어 이상과 부게 이상 그리기
figure(2);
set(gcf, 'color' ,'w');
plot(longitude, g_B, 'o-', 'color', 'b', 'linewidth', 1.5); hold on; %부게이상
plot(longitude, g_F, 'o-', 'color', 'm', 'linewidth', 1.5); hold on; %후리에어 이상
xlim([min(longitude), max(longitude)]); ylim([1000, 2000]);
set(gca, 'xtick', [-75:5:-40], 'xticklabels', ['75^oW'; '70^oW'; '65^oW'; '60^oW'; '55^oW'; '50^oW'; ]);
set(gca, 'ytick', [1000:100:2000]);
set(gca, 'tickdir', 'out');
legend('\Deltag_B(Bouguer Gravity Anomaly)', '\Deltag_F(Free-air Gravity Anomaly)');
xlabel('longitude', 'fontsize', 12); ylabel('\Deltag(mgal)', 'fontsize', 12);
title('\Deltag_B, \Deltag_F of S.America Near Andes', 'fontweight', 'bold', 'fontsize', 14);
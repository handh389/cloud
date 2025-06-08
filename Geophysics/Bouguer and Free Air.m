%% �ΰ���, �ĸ����� ����
clear all; close all; clc;
[longitude, height, gravity_m, sample_g_F, sample_g_B]...
    =textread('bouguer_freeair_data.csv', '%f%f%f%f%f', 'delimiter', ',', 'headerlines', 2);

% g_B = g_m + g_fa - g_bp;
% g_F = g_m + g_fa;

%�ĸ����� ���� ���ϱ�
for i = 1 : length(height);
    if height(i)<0;
        g_fa(i) = 0;
    else
        g_fa(i) = 0.3086 * height(i); 
    end
end     

%�ĸ����� �̻� ���ϱ�
for i = 1 : length(height);
    g_F(i) = gravity_m(i) + g_fa(i);
end

%�ΰ� ������ ���ϱ⿡ �ռ� rho�� ���ϱ�
for i = 1 : length(height);
    sample_g_bp(i) = -sample_g_B(i) + sample_g_F(i); %���� �ΰ� ����
    rho(i) = sample_g_bp(i)/(height(i)*0.04193*10^(-3)); %rho ���ϱ�
end
%rho�� �ٴٿ��� �� 1.64*10^3, �������� �� 2.67*10^3 �� ���Դ�.
%�Ϲ����� �ٴ幰�� �е��� �� 1030�̱� ������ �ؾ翡���� 1030�� �� ���� �� ���̴�.

%�ΰ� ���� ���ϱ�
for i = 1 : length(height);
    if height(i)<0 ; 
        g_bp(i) = (0.04193*10^(-3))*(1.64*10^3)*height(i);
    else
        g_bp(i) = (0.04193*10^(-3))*(2.67*10^3)*height(i);
    end
end

%�ΰ� �̻� ���ϱ�
for i = 1 : length(height);
    g_B(i) = gravity_m(i) + g_fa(i) - g_bp(i);
end
%%
%���� �׸���
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
% �ĸ����� �̻�� �ΰ� �̻� �׸���
figure(2);
set(gcf, 'color' ,'w');
plot(longitude, g_B, 'o-', 'color', 'b', 'linewidth', 1.5); hold on; %�ΰ��̻�
plot(longitude, g_F, 'o-', 'color', 'm', 'linewidth', 1.5); hold on; %�ĸ����� �̻�
xlim([min(longitude), max(longitude)]); ylim([1000, 2000]);
set(gca, 'xtick', [-75:5:-40], 'xticklabels', ['75^oW'; '70^oW'; '65^oW'; '60^oW'; '55^oW'; '50^oW'; ]);
set(gca, 'ytick', [1000:100:2000]);
set(gca, 'tickdir', 'out');
legend('\Deltag_B(Bouguer Gravity Anomaly)', '\Deltag_F(Free-air Gravity Anomaly)');
xlabel('longitude', 'fontsize', 12); ylabel('\Deltag(mgal)', 'fontsize', 12);
title('\Deltag_B, \Deltag_F of S.America Near Andes', 'fontweight', 'bold', 'fontsize', 14);
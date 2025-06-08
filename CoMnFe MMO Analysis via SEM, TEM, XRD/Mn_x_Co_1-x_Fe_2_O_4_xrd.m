%% XRD Analysis
clear all; close all; clc;

% Sample 1~3
% Sample 1 : Mn0.25 Co0.75 Fe2 O4
% Sample 2 : Mn0.75 Co0.25 Fe2 O4
% Sample 3 : Co Fe2 O4
% Each samples have 3001 datas

%%%%%%%%%%%%%%%%%%%%%%%%%%% DON'T TOUCH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

full_data = zeros(3001, 3);
for sample_num = 1 : 3;
    % Data Loading
    txtfile_name = ['sample' num2str(sample_num) '_XRD_data.txt'];
    [two_theta, intensity_raw] = textread(txtfile_name, '%f%f', ...
        'delimiter', ' ', 'headerlines', 2);
    
    % Baseline Correction
    intensity_wo_baseline = bf(smooth(intensity_raw));
    
    % Normalize
    max_data = max(intensity_wo_baseline);
    intensity_normalized = (intensity_wo_baseline) / max_data;
    
    % Data Saving
    for i = 1 : 3001;
        full_data(i, sample_num) = intensity_normalized(i);
    end
end


%% Calculated CoFe2O4 XRD Loading
[calculated_two_theta, calculated_intensity] = ...
    textread('calculated_Co_Fe_2_O_4_XRD.txt', '%f%f', 'delimiter', ' ');
%% 
load full_data.mat;
load two_theta.mat;
miller_index = ['(220)'; '(311)'; '(400)'; '(511)'; '(440)']; 

XRD_peaks = zeros(5,3);

% Ploting
% Sample 1,2,3 overall
figure(1); clf;
set(gcf, 'color', 'w', 'position', [150, 10, 600, 250]);
plot(two_theta, full_data(:, 2), 'color', [255/255, 108/255, 108/255], 'linewidth' ,1); hold on;
plot(two_theta, full_data(:, 1), 'color', [127/255, 126/255, 255/255], 'linewidth' ,1); hold on;
plot(two_theta, full_data(:, 3), 'color', [35/255, 164/255, 26/255], 'linewidth' ,1); hold on;
grid on;
xlim([20, 80]); ylim([0, 1]);
lgd = legend('x=0.25', 'x=0.75', 'x=1');
lgd.FontSize = 9;
lgd.Location = 'northeast';
xlabel('2\theta(degree)', 'fontsize', 12);
ylabel('Normalized Intensity', 'fontsize', 12);
%title('(a) XRD Data of Co_xMn_1_-_xFe_2O_4', 'fontsize', 14, 'fontweight', 'bold', 'position', [28, 1.03]);

% Sample3 & Comparision w/ calculated CoFe2O4
figure(2); clf;
set(gcf, 'color', 'w', 'position', [160, 10, 600, 250]);
plot(two_theta, full_data(:, 3), 'color', [35/255, 164/255, 26/255], 'linewidth' ,1); hold on;
grid on;
%plot(calculated_two_theta, calculated_intensity/100, 'linestyle', ':', 'color', [35/255, 164/255, 26/255], 'linewidth' ,1);
lgd = legend('x=1');
lgd.FontSize = 9;
lgd.Location = 'northeast';
[pks3, locs3] = findpeaks(full_data(:, 3), 'minpeakprominence' , 0.4);
for i = 1 : length(pks3);
    plot(two_theta(locs3(i)), pks3(i), 'v','markeredgecolor', 'm', 'markerfacecolor', 'm', 'markersize', 8);
    hold on;
    txt = [miller_index(i,:)];
    text(two_theta(locs3(i))-4, pks3(i)-0.04, txt, 'color', 'm', 'fontweight', 'bold');
    hold on;
    XRD_peaks(i, 3) = two_theta(locs3(i));
end
xlim([20, 80]); ylim([0, 1]);
xlabel('2\theta(degree)', 'fontsize', 12);
ylabel('Normalized Intensity', 'fontsize', 12);
%title('(b) XRD Analysis of CoFe_2O_4', 'fontsize', 14, 'fontweight', 'bold', 'position', [26.5, 1.03]);

% Sample1 & Comparision w/ calculated CoFe2O4
figure(3); clf;
set(gcf, 'color', 'w', 'position', [170, 10, 600, 250]);
plot(two_theta, full_data(:, 1), 'color', [127/255, 126/255, 255/255], 'linewidth' ,1); hold on;
grid on;
stem(two_theta(locs3), [1,1,1,1,1], 'marker', '.','linestyle', '-', 'color', [35/255, 164/255, 26/255], 'linewidth' ,1);
lgd = legend('x=0.75', 'x=1(peak)');
lgd.FontSize = 9;
lgd.Location = 'northeast';
[pks1, locs1] = findpeaks(full_data(:, 1), 'minpeakprominence' , 0.15);
for i = 2 : length(pks1);
    plot(two_theta(locs1(i)), pks1(i), 'v','markeredgecolor', 'm', 'markerfacecolor', 'm', 'markersize', 8);
    hold on;
    txt = [miller_index(i-1,:)];
    text(two_theta(locs1(i))-4, pks1(i)-0.04, txt, 'color', 'm', 'fontweight', 'bold');
    hold on;
    XRD_peaks(i-1, 1) = two_theta(locs1(i));
end
xlim([20, 80]); ylim([0, 1]);
xlabel('2\theta(degree)', 'fontsize', 12);
ylabel('Normalized Intensity', 'fontsize', 12);
%title('(c) XRD Analysis of Co_0_._7_5Mn_0_._2_5Fe_2O_4', 'fontsize', 14, 'fontweight', 'bold', 'position', [32, 1.03]);

% Sample2 & Comparision w/ calculated CoFe2O4
figure(4); clf;
set(gcf, 'color', 'w', 'position', [150, 10, 600, 250]);
plot(two_theta, full_data(:, 2), 'color', [255/255, 108/255, 108/255], 'linewidth' ,1); hold on;
grid on;
stem(two_theta(locs2), [1,1,1,1,1], 'marker', '.','linestyle', '-', 'color', [35/255, 164/255, 26/255], 'linewidth' ,1);
lgd = legend('x=0.25', 'x=1(peak)');
lgd.FontSize = 9;
lgd.Location = 'northeast';
[pks2, locs2] = findpeaks(full_data(:, 2), 'minpeakprominence' , 0.15);
for i = 1 : length(pks2);
    plot(two_theta(locs2(i)), pks2(i), 'v','markeredgecolor', 'm', 'markerfacecolor', 'm', 'markersize', 8);
    hold on;
    txt = [miller_index(i,:)];
    text(two_theta(locs2(i))-4, pks2(i)-0.04, txt, 'color', 'm', 'fontweight', 'bold');
    hold on;
    XRD_peaks(i, 2) = two_theta(locs2(i));
end
xlim([20, 80]); ylim([0, 1]);
xlabel('2\theta(degree)', 'fontsize', 12);
ylabel('Normalized Intensity', 'fontsize', 12);
%title('(d) XRD Analysis of Co_0_._2_5Mn_0_._7_5Fe_2O_4', 'fontsize', 14, 'fontweight', 'bold', 'position', [32, 1.03]);

%% Peaks analysis
load XRD_peaks.mat;

peak1 = XRD_peaks(:,1);
peak2 = XRD_peaks(:,2);
peak3 = XRD_peaks(:,3);

% How big?
% x=0.25(sample2) : 0.706845846nm
% x=0.75(sample1) : 0.70396425nm
% x=1(sample3) : 0.700007267nm

% sample1(x=0.75) vs sample3(x=1)
comparision13 = peak3 ./ peak1;
% sample1 is 1.0029 times bigger than sample3

% sample2(x=0.25) vs sample3(x=1)
comparision23 = peak3 ./ peak2;
% sample2 is 1.0052 times bigger than sample3

% As the ratio of Mn goes higher, the lattice parameter(size) of the sample
% goes smaller.

%% Size Comparison
x1 = [0.25; 0.75; 1];
data1 = [7.06845846; 7.0396425; 7.00007267];

figure(1); clf;
set(gcf, 'color', 'w', 'position', [150, 10, 500, 300]);

stem(x1(1), data1(1), 'color', [255/255, 108/255, 108/255], 'linewidth', 25, 'marker', '.'); hold on;
stem(x1(2), data1(2), 'color', [127/255, 126/255, 255/255], 'linewidth', 25, 'marker', '.'); hold on;
stem(x1(3), data1(3), 'color', [35/255, 164/255, 26/255], 'linewidth', 25, 'marker', '.'); hold on;
xlim([0, 1.1]); ylim([6.7, 7.2]);
xlabel('ratio of Co', 'fontsize', 12);
ylabel('lattice parameter(nm)', 'fontsize', 12);
set(gca, 'xtick', [0, 0.25, 0.5, 0.75, 1]);



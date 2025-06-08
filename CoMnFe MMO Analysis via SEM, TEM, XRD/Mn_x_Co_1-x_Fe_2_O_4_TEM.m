%% TEM Analysis
clear all; close all; clc;

% Sample 1~3
% Sample 1 : Mn0.25 Co0.75 Fe2 O4
% Sample 2 : Mn0.75 Co0.25 Fe2 O4
% Sample 3 : Co Fe2 O4

% Data Loading
size1 = textread('sample1_TEM_size.csv', '%*s%*s%*s%f', 'delimiter', ',', 'headerlines', 2);
size3 = textread('sample3_TEM_size.csv', '%*s%*s%*s%f', 'delimiter', ',', 'headerlines', 2);
%%
% Plot
figure(1); clf;
set(gcf, 'color', 'w', 'position', [150, 10, 2000, 350]); 

subplot(1, 4, 1);
imshow(imread('sample3_TEM.tif'));
title('(a) CoFe_2O_4', 'fontsize', 14, 'fontweight', 'bold','position', [200, 0.5]);

subplot(1, 4, 2);
imshow(imread('sample1_TEM.tif'));
title('(b) Mn_0_._2_5Co_0_._7_5Fe_2O_4', 'fontsize', 14, 'fontweight', 'bold','position', [500, 0.5]);

subplot(1, 4, 3);
imshow(imread('sample2_TEM.tif'));
title('(c) Mn_0_._7_5Co_0_._2_5Fe_2O_4', 'fontsize', 14, 'fontweight', 'bold','position', [500, 0.5]);
%%
figure(1); clf;
set(gcf, 'color', 'w', 'position', [150, 10, 500, 300]); 
h2 = histogram(size1); h2.Normalization = 'probability'; h2.BinWidth = 0.5; 
h2.EdgeColor = [127/255, 126/255, 255/255]; h2.FaceColor = [127/255, 126/255, 255/255]; hold on;
h1 = histogram(size3);  h1.Normalization = 'probability'; h1.BinWidth = 0.5;
h1.EdgeColor = [35/255, 164/255, 26/255]; h1.FaceColor = [35/255, 164/255, 26/255]; hold on;
lgd = legend('x=0.75', 'x=1');
lgd.FontSize = 9;
lgd.Location = 'northeast';
grid on;
xlabel('Diameter(nm)', 'fontsize', 12); ylabel('possibility');
ylim([0, 0.4]);
%title('(d)', 'fontsize', 14, 'fontweight', 'bold','position', [2.9, 0.38]);
%% Statistic View
% x=1 (sample3)
% mean : 6.5718, std : 1.4194

% x=0.75 (sample1)
% mean : 6.6375, std : 0.5743 

% sample1 is 1.009 times bigger than sample3
%% Plane Practice

% miller_index = ['(220)'; '(311)'; '(400)'; '(511)'; '(440)']; 

% y, z
[y, z] = meshgrid(0:1, 0:1);

% 220
x220_1 = (-2*y + 1) / 2;
x220_2 = (-2*y + 2) / 2;

% 311
x311_1 = (-y - z +3) / 3;
x311_2 = (-y - z +2) / 3;

%400
x400_1 = 1/4 + 0*y;
x400_2 = 2/4 + 0*y;

%511
x511_1 = (-y - z + 3) / 5;
x511_2 = (-y - z + 2) / 5;

%440
x440_1 = (-4*y + 3) / 4;
x440_2 = (-4*y + 2) / 4;

% plot
figure(2); clf;
set(gcf, 'color', 'w', 'position', [150, 10, 2000, 300]);

subplot(1, 5, 1);
surf(x220_1, y, z, 'EdgeColor', 'y', 'FaceColor', 'y', 'FaceAlpha',0.3); hold on;
surf(x220_2, y, z, 'EdgeColor', 'y', 'FaceColor', 'y', 'FaceAlpha',0.3); hold on;
xlim([0,1]); ylim([0,1]);
title('(a) (220)', 'fontsize', 14, 'fontweight', 'bold','position', [0, 1.1, 1.2]);

subplot(1, 5, 2);
surf(x311_1, y, z, 'EdgeColor', 'r', 'FaceColor', 'r', 'FaceAlpha',0.2); hold on;
surf(x311_2, y, z, 'EdgeColor', 'r', 'FaceColor', 'r', 'FaceAlpha',0.2); hold on;
xlim([0,1]); ylim([0,1]);

subplot(1, 5, 3);
surf(x400_1, y, z, 'EdgeColor', 'g', 'FaceColor', 'g', 'FaceAlpha',0.2); hold on;
surf(x400_2, y, z, 'EdgeColor', 'g', 'FaceColor', 'g', 'FaceAlpha',0.2); hold on;
xlim([0,1]); ylim([0,1]);

subplot(1, 5, 4);
surf(x511_1, y, z, 'EdgeColor', 'b', 'FaceColor', 'b', 'FaceAlpha',0.2); hold on;
surf(x511_2, y, z, 'EdgeColor', 'b', 'FaceColor', 'b', 'FaceAlpha',0.2); hold on;
xlim([0,1]); ylim([0,1]);

subplot(1, 5, 5);
surf(x440_1, y, z, 'EdgeColor', 'c', 'FaceColor', 'c', 'FaceAlpha',0.2); hold on;
surf(x440_2, y, z, 'EdgeColor', 'c', 'FaceColor', 'c', 'FaceAlpha',0.2); hold on;
xlim([0,1]); ylim([0,1]);

%% TEM Diffraction Analysis

% Plot
figure(3); clf;
set(gcf, 'color', 'w', 'position', [150, 10, 2000, 500]);

% x=1 (sample3)
subplot(1, 3, 1);
imshow(imread('sample3_TEM_diffraction_font.jpg'));
title('(a) x = 1', 'fontsize', 14, 'fontweight', 'bold','position', [0, 0.5]);

% x=0.75 (sample1)
subplot(1, 3, 2);
imshow(imread('sample1_TEM_diffraction_font.jpg'));
title('(b) x = 0.75', 'fontsize', 14, 'fontweight', 'bold','position', [100, 0.5]);

% x=0.25 (sample2)
subplot(1, 3, 3);
imshow(imread('sample2_TEM_diffraction_font.jpg'));
title('(c) x = 0.25', 'fontsize', 14, 'fontweight', 'bold','position', [100, 0.5]);

%% Lattice Parameter(error is big)

% miller_index = ['(311)'; '(400)'; '(440)']; 

% Data Load
[a_TEM1, a_TEM2, a_TEM3] = textread('TEM_diffraction_analysis.csv', '%*s%*s%*s%*s%*s%*s%*s%f%f%f', 'delimiter', ',', 'headerlines', 1);

% a_TEM3 (x = 1) lattice parameter
% mean 6.7684 nm

% a_TEM1 (x = 0.75) lattice parameter
% mean 6.9821 nm  ( 1.032 times bigger than x=1)

% a_TEM2 (x = 0.25) lattice parameter
% mean 7.0551 nm  ( 1.042 times bigger than x=1)

%% Vegard's law
% XRD
% x=0.25(sample2) : 0.706845846nm
% x=0.75(sample1) : 0.70396425nm
% x=1(sample3) : 0.700007267nm
x1 = [0.25, 0.75, 1];
data1 = [7.06845846, 7.0396425 ,7.00007267];

% TEM Measure
% x=0.75 (sample1)
% mean : 6.6375, std : 0.5743 
% x=1 (sample3)
% mean : 6.5718, std : 1.4194
x2 = [0.75, 1];
data2 = [6.6375, 6.5718];

% TEM Diffraction
% a_TEM2 (x = 0.25) lattice parameter
% mean 7.0551 nm  ( 1.042 times bigger than x=1)
% a_TEM1 (x = 0.75) lattice parameter
% mean 6.9821 nm  ( 1.032 times bigger than x=1)
% a_TEM3 (x = 1) lattice parameter
% mean 6.7684 nm
x3 = [0.25, 0.75, 1];
data3 = [7.0551,6.9821,6.7684]

figure(1); clf;
set(gcf, 'color', 'w', 'position', [150, 10, 500, 300]);
plot(x1, data1, 'o', 'color',' b'); hold on;
p1 = polyfit(x1, data1, 1);
f1 = polyval(p1, x1);

plot(x2, data2, 'o', 'color',' r'); hold on;
p2 = polyfit(x2, data2, 1);
f2 = polyval(p2, x2);

plot(x3, data3, 'o', 'color',' g'); hold on;
p3 = polyfit(x3, data3, 1);

lgd = legend('by XRD', 'by TEM image', 'by TEM diffraction', 'location', 'southwest');
lgd.FontSize = 10;

plot(x1, f1, '-', 'color', 'b', 'linewidth', 1.5); hold on;
plot(x2, f2, '-', 'color', 'r', 'linewidth', 1.5); hold on;
f3 = polyval(p3, x3);
plot(x3, f3, '-', 'color', 'g', 'linewidth', 1.5); hold on;

xlabel('ratio of Co');
ylabel('lattice parameter(nm)', 'fontsize', 12);
ylim([6.4, 7.4]);

%% Size comparison
x2 = [0.7, 0.95];
data2 = [6.6375, 6.5718];
x3 = [0.3, 0.8, 1.05];
data3 = [7.0551,6.9821,6.7684]


figure(1); clf;
set(gcf, 'color', 'w', 'position', [150, 10, 500, 300]);

stem(x2(1), data2(1), 'color', [127/255, 126/255, 255/255], 'linewidth', 20, 'marker', '.'); hold on;
stem(x2(2), data2(2), 'color', [35/255, 164/255, 26/255], 'linewidth', 20, 'marker', '.'); hold on;

stem(x3(1), data3(1), 'color', [255/255, 108/255, 108/255], 'linewidth', 20, 'marker', '.'); hold on;
stem(x3(2), data3(2), 'color', [127/255, 126/255, 255/255], 'linewidth', 20, 'marker', '.'); hold on;
stem(x3(3), data3(3), 'color', [35/255, 164/255, 26/255], 'linewidth', 20, 'marker', '.'); hold on;

xlim([0, 1.1]); ylim([6, 7.1]);
set(gca, 'xtick', [0, 0.25, 0.5, 0.75, 1]);

xlabel('ratio of Co', 'fontsize', 12);
ylabel('lattice parameter(nm)', 'fontsize', 12);



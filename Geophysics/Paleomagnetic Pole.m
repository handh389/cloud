%% 지물 실험 2-9 Paleomagnetic Pole
clear all; close all; clc;
load Exp9.mat;

p = acotd(tand(INC)/2);
for i= 1 : length(p)
    if p(i) < 0;
        p(i) = p(i)+180;
    end
end
VGP_lat = asind(sind(lat).*cosd(p)+cosd(lat).*sind(p).*cosd(DEC));

figure(1); clf;
set(gcf, 'color', 'w', 'position', [200, 200, 700, 400]);
plot(DEPTH, VGP_lat, 'o', 'markeredgecolor', 'b');
xlim([8700, 9800]); ylim([-90, 90]);
xlabel('Depth(m)', 'fontsize', 12); ylabel('Latitude(^o)', 'fontsize', 12);
set(gca, 'xticklabel', [87:1:98]);
yticklabel =  ['90^oS'; '60^oS'; '30^oS'; ' 0^o '; '30^oN'; '60^oN'; '90^oN'];
set(gca, 'ytick', [-90:30:90], 'yticklabel', yticklabel);grid on;
title('Latitude of VGP by Depth of Marine Deposit in Eq. Pacific Ocean', 'fontweight', 'bold', 'fontsize', 14);

%%
figure(2); clf;
set(gcf, 'color', 'w', 'position', [200, 200, 700, 400]);
yyaxis left;
plot(DEPTH, VGP_lat, 'o', 'markeredgecolor', 'b');
ylim([-90, 90]);
yticklabel =  ['90^oS'; '60^oS'; '30^oS'; ' 0^o '; '30^oN'; '60^oN'; '90^oN'];
set(gca, 'ytick', [-90:30:90], 'yticklabel', yticklabel, 'ycolor', 'b');
xlabel('Depth(m)', 'fontsize', 12); ylabel('Latitude(^o)', 'fontsize', 12);
grid on;
yyaxis right;
plot(DEPTH, INTENSITY, 'r'); hold on;
xlim([8700, 9800]); ylim([0, 180]);
set(gca, 'ytick', [0:30:180], 'ycolor', 'r');
grid on;
set(gca, 'xticklabel', [87:1:98]); 
ylabel('Mean Intensity of Magnetic Field(\muT)', 'fontsize', 12);
title('Comparing Latitude of VGP with Magnetic Field Intensity', 'fontweight', 'bold', 'fontsize', 14);
find_succ = find(abs(VGP_lat)<55);
find_rev = find(VGP_lat<-55);
plot([DEPTH(find_rev(1)), DEPTH(find_rev(1))], [0, 180], 'k-');
plot([DEPTH(find_rev(end-1)), DEPTH(find_rev(end-1))], [0,180], 'k-');
plot([DEPTH(find_succ(end)), DEPTH(find_succ(end))], [0,180], 'k-');
d1 = DEPTH(find_rev(1));
d2 = DEPTH(find_rev(end-1));
d3 = DEPTH(find_succ(end));
%%
clear all; close all; clc;

for phi = 1 : 1 : 360;
   p(phi) = acosd(0.492+0.15*cosd(phi-180+115)); 
   D(phi) = acosd((1.96-cosd(p(phi)))/(sqrt(3)*sind(p(phi)))) 
   I(phi) = atand(2/tand(p(phi))); 
end
%%
figure(1); clf;
longitude = -179:1:180
set(gcf, 'color', 'w', 'position', [200, 200, 700, 400]);
plot(longitude, D, 'o-', 'color', 'b');
xlim([-180,180]);
set(gca, 'xtick', [-180:60:180]);
xticklabel = ['180^o '; '120^oW'; ' 60^oW'; '  0^o '; ' 60^oE'; '120^oE'; '180^o '];
set(gca, 'xticklabel', xticklabel);
xlabel('Longitude', 'fontsize', 12); 
ylabel('Declination(^o)', 'fontsize', 12);
grid on;
title('Declination by Longitude at 30^oN', 'fontweight', 'bold', 'fontsize', 14);

figure(2); clf;
longitude = -179:1:180
set(gcf, 'color', 'w', 'position', [200, 200, 700, 400]);
plot(longitude, I, 'o-', 'color', 'm');
xlim([-180,180]);
set(gca, 'xtick', [-180:60:180]);
xticklabel = ['180^o '; '120^oW'; ' 60^oW'; '  0^o '; ' 60^oE'; '120^oE'; '180^o '];
set(gca, 'xticklabel', xticklabel);
xlabel('Longitude', 'fontsize', 12); 
ylabel('Inclination(^o)', 'fontsize', 12);
grid on;
title('Inclination by Longitude at 30^oN', 'fontweight', 'bold', 'fontsize', 14);
clear all;
close all;
[height, S90, S85, S80, S75, S70, S65, S60, S55, S50, S45, S40, S35, S30, S25, S20, S15, S10, S05, EQ, N05, N10, N15, N20, N25, N30, N35, N40, N45, N50, N55, N60, N65, N70, N75, N80, N85, N90] = ...
    textread('temperature.txt', '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'headerlines', 1);

figure(1);
plot(S10, height);
hold on;
plot(S30, height);
hold on;
plot(S50, height);
hold on;
plot(S70, height);
hold on;
plot(S90, height);
hold on;
plot([-120,40],[15,15],'k:');
plot([-120,40],[50,50],'k:');
plot([-120,40],[80,80],'k:');
xlabel('Temperature(¡ÆC)', 'fontsize', 10, 'fontname', 'times new roman');
ylabel('Height(km)', 'fontsize', 10) 
title('Temperature(¡ÆC) of Summer Hemisphere','fontsize', 20, 'fontname','times new roman');
legend('S10', 'S30', 'S50', 'S70', 'S90');
text(-115,15,'Tropopause','fontsize',10,'Color','k')
text(-115,50,'Stratopause','fontsize',10,'Color','k')
text(-115,80,'Mesopause','fontsize',10,'Color','k')

figure(2);
plot(N10, height);
hold on;
plot(N30, height);
hold on;
plot(N50, height);
hold on;
plot(N70, height);
hold on;
plot(N90, height);
hold on;
plot([-120,40],[15,15],'k:');
plot([-120,40],[50,50],'k:');
plot([-120,40],[83,83],'k:');
xlabel('Temperature(¡ÆC)', 'fontsize', 10);
ylabel('Height(km)', 'fontsize', 10) 
title('Temperature(¡ÆC) of Winter Hemisphere','fontsize', 20);
legend('N10', 'N30', 'N50', 'N70', 'N90');
text(-115,15,'Tropopause','fontsize',10,'Color','k')
text(-115,50,'Stratopause','fontsize',10,'Color','k')
text(-115,83,'Mesopause','fontsize',10,'Color','k')

figure(3);
latitude=[-90:5:90];
table =  textread('temperature.txt');
table(:,1) = [];
table(1,:) = [];
[xi, yi] = meshgrid(min(latitude): 1 :max(latitude), 0:1:100);
table2 = interp2(latitude, height, table, xi, yi);
[c,h]=contourf(xi, yi, table2, [-120:10:10], 'k');
clabel(c,h);
colormap(cool);
hold on;
colorbar;
set(gca,'xtick',[-90:30:90],'xticklabel',[-90:30:90], 'xticklabel',{'S90¡Æ';'S60¡Æ';'S30¡Æ';'Equator';'N30¡Æ';'N60¡Æ';'N90¡Æ'});
set(gca,'ytick',[0:10:100],'yticklabel',[0:10:100]);
xlabel('Latitude(¡Æ)','FontSize',10,'Color','k')
ylabel('Height(km)','FontSize',10,'Color','k')
title('Temperature(¡Æ) of Atmosphere','FontSize',20)
text(-75,86,'C','fontsize',20,'Color','k','fontweight', 'bold')
text(-85,50,'W','fontsize',20,'Color','k', 'fontweight', 'bold')
%%
clear all
close all
figure(4);
latitude = [-90:5:90];
height = [0:5:100];
table3 = textread('wind.txt');
table3(:,1) = [];
table3(1,:) = [];
[xi, yi] = meshgrid(min(latitude): 1 :max(latitude), 0:1:100);
table4 = interp2(latitude, flipud(height'), table3, xi, yi);
[c,h]=contourf(xi, yi, table4, [-51:5:82], 'k');
clabel(c,h);
colormap(jet);
hold on;
colorbar;
set(gca,'xtick',[-90:30:90],'xticklabel',[-90:30:90], 'xticklabel',{'S90¡Æ';'S60¡Æ';'S30¡Æ';'Equator';'N30¡Æ';'N60¡Æ';'N90¡Æ'});
set(gca,'ytick',[0:10:100],'yticklabel',[0:10:100]);
xlabel('Latitude(¡Æ)','FontSize',10,'Color','k');
ylabel('Height(km)','FontSize',10,'Color','k');
title('Wind Speed(m/s) of Atmosphere','FontSize',20);
text(-45,62,'E','fontsize',20,'Color','w','fontweight', 'bold');
text(30,64,'W','fontsize',20,'Color','w', 'fontweight', 'bold');
text(-58,12,'JS','fontsize',20,'Color','k','fontweight', 'bold');
text(20,14,'JS','fontsize',20,'Color','k','fontweight', 'bold');


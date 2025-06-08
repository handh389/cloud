%% 동해 104

clear all;
close all;
clc;

[area, line_stattion_no, latitude, longitude, date,  depth, temp, sal] =textread('동해 104.txt', '%s%6c%f%f%16c%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s',  'headerlines', 1);
month=str2num(date(:, 6:7));

findp = find(month==2 );
depth2_104=depth(findp);
latitude2_104=latitude(findp);
temp2_104=temp(findp);
sal2_104=sal(findp);
pres2_104=sw_pres(depth2_104, latitude2_104);
pt2_104=sw_ptmp(sal2_104, temp2_104, pres2_104, 0);

findp = find(month==4);
depth4_104=depth(findp);
latitude4_104=latitude(findp);
temp4_104=temp(findp);
sal4_104=sal(findp);
pres4_104=sw_pres(depth4_104, latitude4_104);
pt4_104=sw_ptmp(sal4_104, temp4_104, pres4_104, 0);

findp = find(month==6);
depth6_104=depth(findp);
latitude6_104=latitude(findp);
temp6_104=temp(findp);
sal6_104=sal(findp);
pres6_104=sw_pres(depth6_104, latitude6_104);
pt6_104=sw_ptmp(sal6_104, temp6_104, pres6_104, 0);

findp = find(month==8);
depth8_104=depth(findp);
latitude8_104=latitude(findp);
temp8_104=temp(findp);
sal8_104=sal(findp);
pres8_104=sw_pres(depth8_104, latitude8_104);
pt8_104=sw_ptmp(sal8_104, temp8_104, pres8_104, 0);

findp = find(month==10);
depth10_104=depth(findp);
latitude10_104=latitude(findp);
temp10_104=temp(findp);
sal10_104=sal(findp);
pres10_104=sw_pres(depth10_104, latitude10_104);
pt10_104=sw_ptmp(sal10_104, temp10_104, pres10_104, 0);

findp = find(month==12);
depth12_104=depth(findp);
latitude12_104=latitude(findp);
temp12_104=temp(findp);
sal12_104=sal(findp);
pres12_104=sw_pres(depth12_104, latitude12_104);
pt12_104=sw_ptmp(sal12_104, temp12_104, pres12_104, 0);

data2_104=plot(sal2_104, pt2_104, 'o','markeredgecolor','y','markerfacecolor','y'); hold on;
data4_104=plot(sal4_104, pt4_104, 'o','markeredgecolor','m','markerfacecolor','m'); hold on;
data6_104=plot(sal6_104, pt6_104, 'o','markeredgecolor','c','markerfacecolor','c'); hold on;
data8_104=plot(sal8_104, pt8_104, 'o','markeredgecolor','r','markerfacecolor','r'); hold on;
data10_104=plot(sal10_104, pt10_104, 'o','markeredgecolor','g','markerfacecolor','g'); hold on;
data12_104=plot(sal12_104, pt12_104, 'o','markeredgecolor','b','markerfacecolor','b'); hold on;

xlim=get(gca, 'xlim');
ylim=get(gca, 'ylim');

[x,y]=meshgrid([xlim(1):0.01:xlim(2)],[ylim(1):0.01:ylim(2)]);
dens_grid=sw_dens0(x,y);
[c,h]=contour(x,y,dens_grid-1000,[20:1:30],'k:');
[x,y] = meshgrid([xlim(1):.01:xlim(2)],[ylim(1):.1:ylim(2)]);
dens_grid = sw_dens0(x,y);
[c,h] = contour(x,y,dens_grid-1000,[20:1:30],'k:');
clabel(c,h);
xlabel('Salinity (psu)', 'fontsize',14)
ylabel('Temperature (ºc)', 'fontsize',14)
legend([data2_104, data4_104, data6_104, data8_104, data10_104, data12_104], 'Feb', 'Apr', 'Jun', 'Aug', 'Oct', 'Dec','location','southwest')
title('T-S Diagram East Sea line 104(Korea)', 'fontsize', 20, 'fontweight' , 'bold');
%% 남해 205
clear all;
close all;
clc;

[area, line_stattion_no, latitude, longitude, date,  depth, temp, sal] =textread('남해 205.txt', '%s%6c%f%f%16c%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s',  'headerlines', 1);
month=str2num(date(:, 6:7));

findp = find(month==2);
depth2_205=depth(findp);
latitude2_205=latitude(findp);
temp2_205=temp(findp);
sal2_205=sal(findp);
pres2_205=sw_pres(depth2_205, latitude2_205);
pt2_205=sw_ptmp(sal2_205, temp2_205, pres2_205, 0);

findp = find(month==4);
depth4_205=depth(findp);
latitude4_205=latitude(findp);
temp4_205=temp(findp);
sal4_205=sal(findp);
pres4_205=sw_pres(depth4_205, latitude4_205);
pt4_205=sw_ptmp(sal4_205, temp4_205, pres4_205, 0);

findp = find(month==6);
depth6_205=depth(findp);
latitude6_205=latitude(findp);
temp6_205=temp(findp);
sal6_205=sal(findp);
pres6_205=sw_pres(depth6_205, latitude6_205);
pt6_205=sw_ptmp(sal6_205, temp6_205, pres6_205, 0);

findp = find(month==8);
depth8_205=depth(findp);
latitude8_205=latitude(findp);
temp8_205=temp(findp);
sal8_205=sal(findp);
pres8_205=sw_pres(depth8_205, latitude8_205);
pt8_205=sw_ptmp(sal8_205, temp8_205, pres8_205, 0);

findp = find(month==10);
depth10_205=depth(findp);
latitude10_205=latitude(findp);
temp10_205=temp(findp);
sal10_205=sal(findp);
pres10_205=sw_pres(depth10_205, latitude10_205);
pt10_205=sw_ptmp(sal10_205, temp10_205, pres10_205, 0);

findp = find(month==12);
depth12_205=depth(findp);
latitude12_205=latitude(findp);
temp12_205=temp(findp);
sal12_205=sal(findp);
pres12_205=sw_pres(depth12_205, latitude12_205);
pt12_205=sw_ptmp(sal12_205, temp12_205, pres12_205, 0);

data2_205=plot(sal2_205, pt2_205, 'o','markeredgecolor','y','markerfacecolor','y'); hold on;
data4_205=plot(sal4_205, pt4_205, 'o','markeredgecolor','m','markerfacecolor','m'); hold on;
data6_205=plot(sal6_205, pt6_205, 'o','markeredgecolor','c','markerfacecolor','c'); hold on;
data8_205=plot(sal8_205, pt8_205, 'o','markeredgecolor','r','markerfacecolor','r'); hold on;
data10_205=plot(sal10_205, pt10_205, 'o','markeredgecolor','g','markerfacecolor','g'); hold on;
data12_205=plot(sal12_205, pt12_205, 'o','markeredgecolor','b','markerfacecolor','b'); hold on;

xlim=get(gca, 'xlim');
ylim=get(gca, 'ylim');

[x,y]=meshgrid([xlim(1):0.01:xlim(2)],[ylim(1):0.01:ylim(2)]);
dens_grid=sw_dens0(x,y);
[c,h]=contour(x,y,dens_grid-1000,[20:1:30],'k:');
[x,y] = meshgrid([xlim(1):.01:xlim(2)],[ylim(1):.1:ylim(2)]);
dens_grid = sw_dens0(x,y);
[c,h] = contour(x,y,dens_grid-1000,[20:1:30],'k:');
clabel(c,h);
xlabel('Salinity (psu)', 'fontsize',14)
ylabel('Temperature (ºc)', 'fontsize',14)
legend([data2_205, data4_205, data6_205, data8_205, data10_205, data12_205], 'Feb', 'Apr', 'Jun', 'Aug', 'Oct', 'Dec','location','southwest')
title('T-S Diagram South Sea line 205(Korea)', 'fontsize', 20, 'fontweight' , 'bold');

%% 서해 309

clear all;
close all;
clc;

[area, line_stattion_no, latitude, longitude, date,  depth, temp, sal] =textread('서해 309.txt', '%s%6c%f%f%16c%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s',  'headerlines', 1);
month=str2num(date(:, 6:7));

findp = find(month==2);
depth2_309=depth(findp);
latitude2_309=latitude(findp);
temp2_309=temp(findp);
sal2_309=sal(findp);
pres2_309=sw_pres(depth2_309, latitude2_309);
pt2_309=sw_ptmp(sal2_309, temp2_309, pres2_309, 0);

findp = find(month==4 );
depth4_309=depth(findp);
latitude4_309=latitude(findp);
temp4_309=temp(findp);
sal4_309=sal(findp);
pres4_309=sw_pres(depth4_309, latitude4_309);
pt4_309=sw_ptmp(sal4_309, temp4_309, pres4_309, 0);

findp = find(month==6 );
depth6_309=depth(findp);
latitude6_309=latitude(findp);
temp6_309=temp(findp);
sal6_309=sal(findp);
pres6_309=sw_pres(depth6_309, latitude6_309);
pt6_309=sw_ptmp(sal6_309, temp6_309, pres6_309, 0);

findp = find(month==8);
depth8_309=depth(findp);
latitude8_309=latitude(findp);
temp8_309=temp(findp);
sal8_309=sal(findp);
pres8_309=sw_pres(depth8_309, latitude8_309);
pt8_309=sw_ptmp(sal8_309, temp8_309, pres8_309, 0);

findp = find(month==10 );
depth10_309=depth(findp);
latitude10_309=latitude(findp);
temp10_309=temp(findp);
sal10_309=sal(findp);
pres10_309=sw_pres(depth10_309, latitude10_309);
pt10_309=sw_ptmp(sal10_309, temp10_309, pres10_309, 0);

findp = find(month==12 );
depth12_309=depth(findp);
latitude12_309=latitude(findp);
temp12_309=temp(findp);
sal12_309=sal(findp);
pres12_309=sw_pres(depth12_309, latitude12_309);
pt12_309=sw_ptmp(sal12_309, temp12_309, pres12_309, 0);

data2_309=plot(sal2_309, pt2_309, 'o','markeredgecolor','y','markerfacecolor','y'); hold on;
data4_309=plot(sal4_309, pt4_309, 'o','markeredgecolor','m','markerfacecolor','m'); hold on;
data6_309=plot(sal6_309, pt6_309, 'o','markeredgecolor','c','markerfacecolor','c'); hold on;
data8_309=plot(sal8_309, pt8_309, 'o','markeredgecolor','r','markerfacecolor','r'); hold on;
data10_309=plot(sal10_309, pt10_309, 'o','markeredgecolor','g','markerfacecolor','g'); hold on;
data12_309=plot(sal12_309, pt12_309, 'o','markeredgecolor','b','markerfacecolor','b'); hold on;

xlim=get(gca, 'xlim');
ylim=get(gca, 'ylim');

[x,y]=meshgrid([xlim(1):0.01:xlim(2)],[ylim(1):0.01:ylim(2)]);
dens_grid=sw_dens0(x,y);
[c,h]=contour(x,y,dens_grid-1000,[20:1:30],'k:');
[x,y] = meshgrid([xlim(1):.01:xlim(2)],[ylim(1):.1:ylim(2)]);
dens_grid = sw_dens0(x,y);
[c,h] = contour(x,y,dens_grid-1000,[20:1:30],'k:');
clabel(c,h);
xlabel('Salinity (psu)', 'fontsize',14)
ylabel('Temperature (ºc)', 'fontsize',14)
legend([data2_309, data4_309, data6_309, data8_309, data10_309, data12_309], 'Feb', 'Apr', 'Jun', 'Aug', 'Oct', 'Dec','location','southwest')
title('T-S Diagram West Sea line 309(Korea)', 'fontsize', 20, 'fontweight' , 'bold');


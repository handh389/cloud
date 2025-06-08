% April

clear all;
close all;
clc;

[area, line_stattion_no, latitude, longitude, date,  depth, temp, sal] =textread('2014³â ÀÚ·á.txt', '%s%6c%f%f%16c%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s',  'headerlines', 1);

line_no=str2num(line_stattion_no(:, 1:3));
station_no=str2num(line_stattion_no(:, 5:6)); 
month = str2num(date(:, 6:7)); 

load coast_korea.mat;
load etopo5_korea.mat;
load hsl256.mat;

findp = find(month==4);
line4 = line_no(findp);
station4 = station_no(findp);
longitude4 = longitude(findp);
latitude4 = latitude(findp);
temp4 = temp(findp);
sal4 = sal(findp);

xi = [min(longitude4)-0.5: 0.01 : max(longitude4)+0.5];
yi = [min(latitude4)-1: 0.01: max(latitude4)+1]'; 
temp44 = griddata(longitude4, latitude4, temp4, xi, yi, 'cubic');
sal44 = griddata(longitude4, latitude4, sal4, xi, yi, 'cubic');

topo2 = interp2(lonk, latk, topo, xi, yi);
temp44(topo2>0) = NaN;
sal44(topo2>0) = NaN;

figure(1);
set(gcf, 'color', 'w');

hsl256(1:2,:)=1;
colormap(hsl256);
imagesc(xi, yi, temp44);
colorbar;
caxis([0 30]);
axis xy;
hold on;
[c,h]=contourf(xi, yi, temp44, [0:1:30]);
clabel(c,h);
plot(lonc,latc,'k');
hold on;
title('Sea Surface Temperature(¡ÆC) of Korea(April, 2014)', 'fontweight', 'bold');
xlabel('Longitude(¡ÆN)');
ylabel('Latitude(¡ÆE)');

east4=find(line4==307 | line4==308 | line4==309 | line4==310 | line4==311 | line4==312);
east4tmax=max(temp4(east4));
east4tmin=min(temp4(east4));
lon4etmax=longitude4(find(temp4==east4tmax));
lat4etmax=latitude4(find(temp4==east4tmax));
lon4etmin=longitude4(find(temp4==east4tmin));
lat4etmin=latitude4(find(temp4==east4tmin));
text(lon4etmax-0.2, lat4etmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon4etmax, lat4etmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon4etmin-0.2, lat4etmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon4etmin, lat4etmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

west4=find(line4==102 | line4==103 | line4==104 | line4==105 | line4==106 | line4==107 | line4==208 | line4==209);
west4tmax=max(temp4(west4));
west4tmin=min(temp4(west4));
lon4wtmax=longitude4(find(temp4==west4tmax));
lat4wtmax=latitude4(find(temp4==west4tmax));
lon4wtmin=longitude4(find(temp4==west4tmin));
lat4wtmin=latitude4(find(temp4==west4tmin));
text(lon4wtmax-0.2, lat4wtmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon4wtmax, lat4wtmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon4wtmin-0.2, lat4wtmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon4wtmin, lat4wtmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

south4=find(line4==203 | line4==204 | line4==205 | line4==206 | line4==207 | line4==313 | line4==314 | line4==400);
south4tmax=max(temp4(south4));
south4tmin=min(temp4(south4));
lon4stmax=longitude4(find(temp4==south4tmax));
lat4stmax=latitude4(find(temp4==south4tmax));
lon4stmin=longitude4(find(temp4==south4tmin));
lat4stmin=latitude4(find(temp4==south4tmin));
text(lon4stmax-0.2, lat4stmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon4stmax, lat4stmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon4stmin-0.2, lat4stmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon4stmin, lat4stmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

figure(2);
set(gcf, 'color', 'w');

hsl256(1:2,:)=1;
colormap(hsl256);
imagesc(xi, yi, sal44);
colorbar;
caxis([28 36]);
axis xy;
hold on;
[c,h]=contourf(xi, yi, sal44, [28:0.5:36]);
clabel(c,h);
plot(lonc,latc,'k');
hold on;
title('Sea Surface Salinity(psu) of Korea(April, 2014)', 'fontweight', 'bold');
xlabel('Longitude(¡ÆN)');
ylabel('Latitude(¡ÆE)');

east4smax=max(sal4(east4));
east4smin=min(sal4(east4));
lon4esmax=longitude4(find(sal4==east4smax));
lat4esmax=latitude4(find(sal4==east4smax));
lon4esmin=longitude4(find(sal4==east4smin));
lat4esmin=latitude4(find(sal4==east4smin));
text(lon4esmax-0.2, lat4esmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon4esmax, lat4esmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon4esmin-0.2, lat4esmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon4esmin, lat4esmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

west4smax=max(sal4(west4));
west4smin=min(sal4(west4));
lon4wsmax=longitude4(find(sal4==west4smax));
lat4wsmax=latitude4(find(sal4==west4smax));
lon4wsmin=longitude4(find(sal4==west4smin));
lat4wsmin=latitude4(find(sal4==west4smin));
text(lon4wsmax-0.2, lat4wsmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon4wsmax, lat4wsmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon4wsmin-0.2, lat4wsmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon4wsmin, lat4wsmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

south4smax=max(sal4(south4));
south4smin=min(sal4(south4));
lon4ssmax=longitude4(find(sal4==south4smax));
lat4ssmax=latitude4(find(sal4==south4smax));
lon4ssmin=longitude4(find(sal4==south4smin));
lat4ssmin=latitude4(find(sal4==south4smin));
text(lon4ssmax-0.2, lat4ssmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon4ssmax, lat4ssmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon4ssmin-0.2, lat4ssmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon4ssmin, lat4ssmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

% August
findp = find(month==8);
line8 = line_no(findp);
station8 = station_no(findp);
longitude8 = longitude(findp);
latitude8 = latitude(findp);
temp8 = temp(findp);
sal8 = sal(findp);

xi = [min(longitude8)-0.5: 0.01 : max(longitude8)+0.5];
yi = [min(latitude8)-1: 0.01: max(latitude8)+1]'; 
temp88 = griddata(longitude8, latitude8, temp8, xi, yi, 'cubic');
sal88 = griddata(longitude8, latitude8, sal8, xi, yi, 'cubic');

topo2 = interp2(lonk, latk, topo, xi, yi);
temp88(topo2>0) = NaN;
sal88(topo2>0) = NaN;

figure(3);
set(gcf, 'color', 'w');

hsl256(1:2,:)=1;
colormap(hsl256);
imagesc(xi, yi, temp88);
colorbar;
caxis([0 30]);
axis xy;
hold on;
[c,h]=contourf(xi, yi, temp88, [0:1:30]);
clabel(c,h);
plot(lonc,latc,'k');
hold on;
title('Sea Surface Temperature(¡ÆC) of Korea(August, 2014)', 'fontweight', 'bold');
xlabel('Longitude(¡ÆN)');
ylabel('Latitude(¡ÆE)');

east8=find(line8==307 | line8==308 | line8==309 | line8==310 | line8==311 | line8==312);
east8tmax=max(temp8(east8));
east8tmin=min(temp8(east8));
lon8etmax=longitude8(find(temp8==east8tmax));
lat8etmax=latitude8(find(temp8==east8tmax));
lon8etmin=longitude8(find(temp8==east8tmin));
lat8etmin=latitude8(find(temp8==east8tmin));
text(lon8etmax-0.2, lat8etmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon8etmax, lat8etmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon8etmin-0.2, lat8etmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon8etmin, lat8etmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

west8=find(line8==102 | line8==103 | line8==104 | line8==105 | line8==106 | line8==107 | line8==208 | line8==209);
west8tmax=max(temp8(west8));
west8tmin=min(temp8(west8));
lon8wtmax=longitude8(find(temp8==west8tmax));
lat8wtmax=latitude8(find(temp8==west8tmax));
lon8wtmin=longitude8(find(temp8==west8tmin));
lat8wtmin=latitude8(find(temp8==west8tmin));
text(lon8wtmax-0.2, lat8wtmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon8wtmax, lat8wtmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon8wtmin-0.2, lat8wtmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon8wtmin, lat8wtmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

south8=find(line8==203 | line8==204 | line8==205 | line8==206 | line8==207 | line8==313 | line8==314 | line8==400);
south8tmax=max(temp8(south8));
south8tmin=min(temp8(south8));
lon8stmax=longitude8(find(temp8==south8tmax));
lat8stmax=latitude8(find(temp8==south8tmax));
lon8stmin=longitude8(find(temp8==south8tmin));
lat8stmin=latitude8(find(temp8==south8tmin));
text(lon8stmax-0.2, lat8stmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon8stmax, lat8stmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon8stmin-0.2, lat8stmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon8stmin, lat8stmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

figure(4);
set(gcf, 'color', 'w');

hsl256(1:2,:)=1;
colormap(hsl256);
imagesc(xi, yi, sal88);
colorbar;
caxis([28 36]);
axis xy;
hold on;
[c,h]=contourf(xi, yi, sal88, [28:0.5:36]);
clabel(c,h);
plot(lonc,latc,'k');
hold on;
title('Sea Surface Salinity(psu) of Korea(August, 2014)', 'fontweight', 'bold');
xlabel('Longitude(¡ÆN)');
ylabel('Latitude(¡ÆE)');

east8smax=max(sal8(east8));
east8smin=min(sal8(east8));
lon8esmax=longitude8(find(sal8==east8smax));
lat8esmax=latitude8(find(sal8==east8smax));
lon8esmin=longitude8(find(sal8==east8smin));
lat8esmin=latitude8(find(sal8==east8smin));
text(lon8esmax-0.2, lat8esmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon8esmax, lat8esmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon8esmin-0.2, lat8esmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon8esmin, lat8esmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

west8smax=max(sal8(west8));
west8smin=min(sal8(west8));
lon8wsmax=longitude8(find(sal8==west8smax));
lat8wsmax=latitude8(find(sal8==west8smax));
lon8wsmin=longitude8(find(sal8==west8smin));
lat8wsmin=latitude8(find(sal8==west8smin));
text(lon8wsmax-0.2, lat8wsmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon8wsmax, lat8wsmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon8wsmin-0.2, lat8wsmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon8wsmin, lat8wsmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

south8smax=max(sal8(south8));
south8smin=min(sal8(south8));
lon8ssmax=longitude8(find(sal8==south8smax));
lat8ssmax=latitude8(find(sal8==south8smax));
lon8ssmin=longitude8(find(sal8==south8smin));
lat8ssmin=latitude8(find(sal8==south8smin));
text(lon8ssmax-0.2, lat8ssmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon8ssmax, lat8ssmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon8ssmin-0.2, lat8ssmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon8ssmin, lat8ssmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

%December
findp = find(month==12);
line12 = line_no(findp);
station12 = station_no(findp);
longitude12 = longitude(findp);
latitude12 = latitude(findp);
temp12 = temp(findp);
sal12 = sal(findp);

xi = [min(longitude12)-0.5: 0.01 : max(longitude12)+0.5];
yi = [min(latitude12)-1: 0.01: max(latitude12)+1]'; 
temp1212 = griddata(longitude12, latitude12, temp12, xi, yi, 'cubic');
sal1212 = griddata(longitude12, latitude12, sal12, xi, yi, 'cubic');

topo2 = interp2(lonk, latk, topo, xi, yi);
temp1212(topo2>0) = NaN;
sal1212(topo2>0) = NaN;

figure(5);
set(gcf, 'color', 'w');

hsl256(1:2,:)=1;
colormap(hsl256);
imagesc(xi, yi, temp1212);
colorbar;
caxis([0 30]);
axis xy;
hold on;
[c,h]=contourf(xi, yi, temp1212, [0:1:30]);
clabel(c,h);
plot(lonc,latc,'k');
hold on;
title('Sea Surface Temperature(¡ÆC) of Korea(December, 2014)', 'fontweight', 'bold');
xlabel('Longitude(¡ÆN)');
ylabel('Latitude(¡ÆE)');

east12=find(line12==307 | line12==308 | line12==309 | line12==310 | line12==311 | line12==312);
east12tmax=max(temp12(east12));
east12tmin=min(temp12(east12));
lon12etmax=longitude12(find(temp12==east12tmax));
lat12etmax=latitude12(find(temp12==east12tmax));
lon12etmin=longitude12(find(temp12==east12tmin));
lat12etmin=latitude12(find(temp12==east12tmin));
text(lon12etmax-0.2, lat12etmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon12etmax, lat12etmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon12etmin-0.2, lat12etmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon12etmin, lat12etmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

west12=find(line12==102 | line12==103 | line12==104 | line12==105 | line12==106 | line12==107 | line12==208 | line12==209);
west12tmax=max(temp12(west12));
west12tmin=min(temp12(west12));
lon12wtmax=longitude12(find(temp12==west12tmax));
lat12wtmax=latitude12(find(temp12==west12tmax));
lon12wtmin=longitude12(find(temp12==west12tmin));
lat12wtmin=latitude12(find(temp12==west12tmin));
text(lon12wtmax-0.2, lat12wtmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon12wtmax, lat12wtmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon12wtmin-0.2, lat12wtmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon12wtmin, lat12wtmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

south12=find(line12==203 | line12==204 | line12==205 | line12==206 | line12==207 | line12==313 | line12==314 | line12==400);
south12tmax=max(temp12(south12));
south12tmin=min(temp12(south12));
lon12stmax=longitude12(find(temp12==south12tmax));
lat12stmax=latitude12(find(temp12==south12tmax));
lon12stmin=longitude12(find(temp12==south12tmin));
lat12stmin=latitude12(find(temp12==south12tmin));
text(lon12stmax-0.2, lat12stmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon12stmax, lat12stmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon12stmin-0.2, lat12stmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon12stmin, lat12stmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

figure(6);
set(gcf, 'color', 'w');

hsl256(1:2,:)=1;
colormap(hsl256);
imagesc(xi, yi, sal1212);
colorbar;
caxis([28 36]);
axis xy;
hold on;
[c,h]=contourf(xi, yi, sal1212, [28:0.5:36]);
clabel(c,h);
plot(lonc,latc,'k');
hold on;
title('Sea Surface Salinity(psu) of Korea(December, 2014)', 'fontweight', 'bold');
xlabel('Longitude(¡ÆN)');
ylabel('Latitude(¡ÆE)');

east12smax=max(sal12(east12));
east12smin=min(sal12(east12));
lon12esmax=longitude12(find(sal12==east12smax));
lat12esmax=latitude12(find(sal12==east12smax));
lon12esmin=longitude12(find(sal12==east12smin));
lat12esmin=latitude12(find(sal12==east12smin));
text(lon12esmax-0.2, lat12esmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon12esmax, lat12esmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon12esmin-0.2, lat12esmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon12esmin, lat12esmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

west12smax=max(sal12(west12));
west12smin=min(sal12(west12));
lon12wsmax=longitude12(find(sal12==west12smax));
lat12wsmax=latitude12(find(sal12==west12smax));
lon12wsmin=longitude12(find(sal12==west12smin));
lat12wsmin=latitude12(find(sal12==west12smin));
text(lon12wsmax-0.2, lat12wsmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon12wsmax, lat12wsmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon12wsmin-0.2, lat12wsmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon12wsmin, lat12wsmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

south12smax=max(sal12(south12));
south12smin=min(sal12(south12));
lon12ssmax=longitude12(find(sal12==south12smax));
lat12ssmax=latitude12(find(sal12==south12smax));
lon12ssmin=longitude12(find(sal12==south12smin));
lat12ssmin=latitude12(find(sal12==south12smin));
text(lon12ssmax-0.2, lat12ssmax-0.3, 'MAX', 'fontweight', 'bold', 'fontsize', 14)
plot(lon12ssmax, lat12ssmax, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);
text(lon12ssmin-0.2, lat12ssmin-0.3, 'min', 'fontweight', 'bold', 'fontsize', 14)
plot(lon12ssmin, lat12ssmin, 'o', 'markeredgecolor','k','markerfacecolor','k','markersize',10);

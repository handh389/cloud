clear all;
close all;
clc;

load coast_korea.mat
load etopo5_korea.mat
load hsl256.mat

[area, line_station_no, latitude, longitude, date, seatemp, salinity, pressure, airtemp]=textread('13鰍 切戟.txt','%s%6c%f%f%16c%*s%f%s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%f%f%*s%*s%*s%*s%*s','delimiter','\t','whitespace','','headerlines',1);
line_no=str2num(line_station_no(:, 1:3));
station_no=str2num(line_station_no(:, 5:6));
month=str2num(date(:, 6:7));
day=str2num(date(:, 9:10));
dayday2=31+day;
dayday8=242+day;

find2=find(month==2);
latitude2=latitude(find2);
longitude2=longitude(find2);
T_s2=seatemp(find2);
T_a2=airtemp(find2);
P2=pressure(find2);
line_no2=line_no(find2);
station_no2=station_no(find2);


for i= 1:161;
    Q_s0(i)=354+180*cos((((360/365)*dayday2(i))-173)*pi/180);
    Q_s(i)=Q_s0(i)*(1-0.3)*(1-0.7*0.31);
    ea(i)=0.6*10^(9.4051-(2353/(T_a2(i)+273)));
    Qb_2(i)=0.958*5.67*10^(-8)*(T_a2(i)+273)^(4)*(0.39-0.058*sqrt(ea(i)))*(1-0.65*(0.31)^2);
    
    if T_s2(i)<T_s2(i);
        Cd=0.83*10^(-3);
    else T_s2(i)>T_a2(i);
        Cd=1.10*10^(-3);
         
    Q_h(i)=1.26*1000*6.26*Cd*((T_s2(i))-(T_a2(i)));
    qa(i)=0.622*ea(i)/((P2(i))-0.378*ea(i));
    es(i)=1.0*10^(9.4051-(2353/(T_s2(i)+273)));
    qs(i)=0.622*es(i)/((P2(i))-0.378*es(i));
    Q_e(i)=1.26*10^(-3)*6.26*2.26*10^(6)*(qs(i)-qa(i));
    end
end

find8=find(month==8);
latitude8=latitude(find8);
longitude8=longitude(find8);
T_s8=seatemp(find8);
T_a8=airtemp(find8);
P8=pressure(find8);
line_no8=line_no(find8);
station_no8=station_no(find8);


for i= 1:190;
    Q_s08(i)=354+180*cos((((360/365)*dayday8(i))-173)*pi/180);
    Q_s8(i)=Q_s08(i)*(1-0.3)*(1-0.7*0.47);
    ea8(i)=0.6*10^(9.4051-(2353/(T_a8(i)+273)));
    Qb_8(i)=0.958*5.67*10^(-8)*(T_a8(i)+273)^(4)*(0.39-0.058*sqrt(ea8(i)))*(1-0.65*(0.31)^2);
    
    if T_s8(i)<T_s8(i);
        Cd=0.83*10^(-3);
    else T_s8(i)>T_a8(i);
        Cd=1.10*10^(-3);
         
    Q_h8(i)=1.26*1000*6.26*Cd*((T_s8(i))-(T_a8(i)));
    qa8(i)=0.622*ea8(i)/((P8(i))-0.378*ea8(i));
    es8(i)=1.0*10^(9.4051-(2353/(T_s8(i)+273)));
    qs8(i)=0.622*es8(i)/((P8(i))-0.378*es8(i));
    Q_e8(i)=1.26*10^(-3)*6.26*2.26*10^(6)*(qs8(i)-qa8(i));
    end
end


storage2= Q_s-Qb_2-Q_h-Q_e;
storage8= Q_s8-Qb_8-Q_h8-Q_e8;


Q_s = transpose(Q_s);
Qb_2 = transpose(Qb_2);
Q_h = transpose(Q_h);
Q_e = transpose(Q_e);

Q_s8 = transpose(Q_s8);
Qb_8 = transpose(Qb_8);
Q_h8 = transpose(Q_h8);
Q_e8 = transpose(Q_e8);


Qs_2mi = min(Q_s);
Qs_2Ma = max(Q_s);

Qb_2mi = min(Qb_2);
Qb_2Ma = max(Qb_2);

Qh_2mi = min(Q_h);
Qh_2Ma = max(Q_h);

Qe_2mi = min(Q_e);
Qe_2Ma = max(Q_e);

storage2mi = min(storage2);
storage2Ma = max(storage2);


Qs_8mi = min(Q_s8);
Qs_8Ma = max(Q_s8);

Qb_8mi = min(Qb_8);
Qb_8Ma = max(Qb_8);

Qh_8mi = min(Q_h8);
Qh_8Ma = max(Q_h8);

Qe_8mi = min(Q_e8);
Qe_8Ma = max(Q_e8);

storage8mi = min(storage8);
storage8Ma = max(storage8);

xi = [124.0:0.01:132.5]; yi = [32.5:0.01:38.5];


Q_ss = griddata(longitude2, latitude2, Q_s, xi, yi', 'cubic');
Qbb_2 = griddata(longitude2, latitude2, Qb_2, xi, yi', 'cubic');
Q_hh = griddata(longitude2, latitude2, Q_h, xi, yi', 'cubic');
Q_ee = griddata(longitude2, latitude2, Q_e, xi, yi', 'cubic');
storage22 = griddata(longitude2, latitude2, storage2, xi, yi', 'cubic');

Q_ss8 = griddata(longitude8, latitude8, Q_s8, xi, yi', 'cubic');
Qbb_8 = griddata(longitude8, latitude8, Qb_8, xi, yi', 'cubic');
Q_hh8 = griddata(longitude8, latitude8, Q_h8, xi, yi', 'cubic');
Q_ee8 = griddata(longitude8, latitude8, Q_e8, xi, yi', 'cubic');
storage88 = griddata(longitude8, latitude8, storage8, xi, yi', 'cubic');


topo2=interp2(lonk,latk,topo,xi,yi');

Q_ss(topo2>=0)=NaN;
Qbb_2(topo2>=0)=NaN;
Q_hh(topo2>=0)=NaN;
Q_ee(topo2>=0)=NaN;
storage22(topo2>=0)=NaN;

Q_ss8(topo2>=0)=NaN;
Qbb_8(topo2>=0)=NaN;
Q_hh8(topo2>=0)=NaN;
Q_ee8(topo2>=0)=NaN;
storage88(topo2>=0)=NaN;

figure(1)

set(gcf,'color','w');
color2=hsl256;
colormap(color2);
imagesc(xi,yi,Q_ss,[Qs_2mi Qs_2Ma]);
hold on;
colorbar;
a = colorbar;
a.Label.String = 'Qs(W/m^2)';
plot(longitude2, latitude2, '.k');
axis xy;
hold on;
[c,h] = contour(xi, yi, Q_ss,[Qs_2mi:((Qs_2Ma-Qs_2mi)/10):Qs_2Ma],'k');
hold on;
clabel(c, h, 'labelspacing', 300);
hold on;
plot(lonc, latc, 'k', 'linewidth', 1.5);
title(['Sea Surface Solar Radiation Energy(FEB 2013)'],'fontsize',14);
xlabel('Longitude (━E)');
ylabel('Latitude (━N)');

%%
figure(2)

set(gcf,'color','w');
color2=hsl256;
colormap(color2);
imagesc(xi,yi,Qbb_2,[Qb_2mi Qb_2Ma]);
hold on;
axis xy;
colorbar;
a = colorbar;
a.Label.String = 'Qb(W/m^2)';
plot(longitude2, latitude2, '.k');
hold on;
[c,h] = contour(xi, yi, Qbb_2,[Qb_2mi:((Qb_2Ma-Qb_2mi)/10):Qb_2Ma],'k');
hold on;
clabel(c, h, 'labelspacing', 300);
hold on;
plot(lonc, latc, 'k', 'linewidth', 1.5);
title(['Sea Surface Earth Radiation Energy(FEB 2013)'],'fontsize', 14);
xlabel('Longitude (━E)');
ylabel('Latitude (━N)');


figure(3)

set(gcf,'color','w');
color2=hsl256;
colormap(color2);
imagesc(xi,yi,Q_hh,[Qh_2mi Qh_2Ma]);
hold on;
axis xy;
colorbar;
a = colorbar;
a.Label.String = 'Qh(W/m^2)';
plot(longitude2, latitude2, '.k');
hold on;
[c,h] = contour(xi, yi, Q_hh,[Qh_2mi:((Qh_2Ma-Qh_2mi)/10):Qh_2Ma], 'k');
hold on;
clabel(c, h, 'labelspacing', 300);
hold on;
plot(lonc, latc, 'k', 'linewidth', 1.5);
title(['Sea Surface Sensible heat(FEB 2013)'],'fontsize',14);
xlabel('Longitude (━E)');
ylabel('Latitude (━N)');

figure(4)

set(gcf,'color','w');
color2=hsl256;
colormap(color2);
imagesc(xi,yi,Q_ee,[Qe_2mi Qe_2Ma]);
hold on;
axis xy;
colorbar;
a = colorbar;
a.Label.String = 'Qe(W/m^2)';
plot(longitude2, latitude2, '.k');
hold on;
[c,h] = contour(xi, yi, Q_ee,[Qe_2mi:((Qe_2Ma-Qe_2mi)/10):Qe_2Ma], 'k');
hold on;
clabel(c, h, 'labelspacing', 300);
hold on;
plot(lonc, latc, 'k', 'linewidth', 1.5);
title(['Sea Surface Latent heat(FEB 2013)'],'fontsize',14);
xlabel('Longitude (━E)');
ylabel('Latitude (━N)');

figure(5)

set(gcf,'color','w');
color2=hsl256;
colormap(color2);
imagesc(xi,yi,storage22,[storage2mi storage2Ma]);
hold on;
axis xy;
colorbar;
a = colorbar;
a.Label.String = 'Qt(W/m^2)';
plot(longitude2, latitude2, '.k');
hold on;
[c,h] = contour(xi, yi, storage22,[storage2mi:((storage2Ma-storage2mi)/10):storage2Ma], 'k');
hold on;
clabel(c, h, 'labelspacing', 300);
hold on;
plot(lonc, latc, 'k', 'linewidth', 1.5);
title(['Sea Surface Storage heat(FEB 2013)'],'fontsize',14);
xlabel('Longitude (━E)');
ylabel('Latitude (━N)');

figure(6)

set(gcf,'color','w');
color2=hsl256;
colormap(color2);
imagesc(xi,yi,Q_ss8,[Qs_8mi Qs_8Ma]);
hold on;
axis xy;
colorbar;
a = colorbar;
a.Label.String = 'Qs(W/m^2)';
plot(longitude8, latitude8, '.k');
hold on;
[c,h] = contour(xi, yi, Q_ss8,[Qs_8mi:((Qs_8Ma-Qs_8mi)/10):Qs_8Ma],'k');
hold on;
clabel(c, h, 'labelspacing', 300);
hold on;
plot(lonc, latc, 'k', 'linewidth', 1.5);
title(['Sea Surface Solar Radiation Energy(AUG 2013)'],'fontsize',14);
xlabel('Longitude (━E)');
ylabel('Latitude (━N)');


figure(7)

set(gcf,'color','w');
color2=hsl256;
colormap(color2);
imagesc(xi,yi,Qbb_8,[Qb_8mi Qb_8Ma]);
hold on;
axis xy;
colorbar;
a = colorbar;
a.Label.String = 'Qb(W/m^2)';
plot(longitude8, latitude8, '.k');
hold on;
[c,h] = contour(xi, yi, Qbb_8,[Qb_8mi:((Qb_8Ma-Qb_8mi)/10):Qb_8Ma],'k');
hold on;
clabel(c, h, 'labelspacing', 300);
hold on;
plot(lonc, latc, 'k', 'linewidth', 1.5);
title(['Sea Surface Earth Radiation Energy(AUG 2013)'],'fontsize', 14);
xlabel('Longitude (━E)');
ylabel('Latitude (━N)');

figure(8)

set(gcf,'color','w');
color2=hsl256;
colormap(color2);
imagesc(xi,yi,Q_hh8,[Qh_8mi Qh_8Ma]);
hold on;
axis xy;
colorbar;
a = colorbar;
a.Label.String = 'Qh(W/m^2)';
plot(longitude8, latitude8, '.k');
hold on;
[c,h] = contour(xi, yi, Q_hh8,[Qh_8mi:((Qh_8Ma-Qh_8mi)/10):Qh_8Ma], 'k');
hold on;
clabel(c, h, 'labelspacing', 300);
hold on;
plot(lonc, latc, 'k', 'linewidth', 1.5);
title(['Sea Surface Sensible heat(AUG 2013)'],'fontsize',14);
xlabel('Longitude (━E)');
ylabel('Latitude (━N)');


figure(9)

set(gcf,'color','w');
color2=hsl256;
colormap(color2);
imagesc(xi,yi,Q_ee8,[Qe_8mi Qe_8Ma]);
hold on;
axis xy;
colorbar;
a = colorbar;
a.Label.String = 'Qe(W/m^2)';
plot(longitude8, latitude8, '.k');
hold on;
[c,h] = contour(xi, yi, Q_ee8,[Qe_8mi:((Qe_8Ma-Qe_8mi)/10):Qe_8Ma], 'k');
hold on;
clabel(c, h, 'labelspacing', 300);
hold on;
plot(lonc, latc, 'k', 'linewidth', 1.5);
title(['Sea Surface Latent heat(AUG 2013)'],'fontsize',14);
xlabel('Longitude (━E)');
ylabel('Latitude (━N)');


figure(10)

set(gcf,'color','w');
color2=hsl256;
colormap(color2);
imagesc(xi,yi,storage88,[storage8mi, storage8Ma]);
hold on;
axis xy;
colorbar;
a = colorbar;
a.Label.String = 'Qt(W/m^2)';
plot(longitude8, latitude8, '.k');
hold on;
[c,h] = contour(xi, yi, storage88,[storage8mi:((storage8Ma-storage8mi)/10):storage8Ma], 'k');
hold on;
clabel(c, h, 'labelspacing', 300);
hold on;
plot(lonc, latc, 'k', 'linewidth', 1.5);
title(['Sea Surface Storage heat(AUG 2013)'],'fontsize',14);
xlabel('Longitude (━E)');
ylabel('Latitude (━N)');
    
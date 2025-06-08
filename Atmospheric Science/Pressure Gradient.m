%% 대기2 - 실험1. 기압경도와 그 계산

clear all;
close all;
clc;

pressure = csvread('pressure data(140905).csv'); %일기도 상의 압력 데이터(위도 경도 4도 단위)
pressure = pressure *100 %hpa을 pa로 변환
latitude = [30:4:50]; %위도 4도 단위
longitude = [120:4:140]; %경도 4도 단위
latitude = fliplr(latitude); %위도는 아래가 더 작으므로 위아래 변환

latitude_i = [30:1:50]; %위도 1도 단위
longitude_i = [120:1:140]; %경도 1도 단위
latitude_i = fliplr(latitude_i); %위도는 아래가 더 작으므로 위아래 변환
pressure_i = griddata(longitude, latitude', pressure, longitude_i, latitude_i', 'cubic');
% 압력 1도 단위로 내삽
%%

%위도와 경도를 2차원적으로 표로 표현
for i =1: length(latitude); %위도 경도 4도 단위
    for j = 1: length(longitude);
    table_latitude(i,j) = latitude(i);
    table_longitude(i,j) = longitude(j);
    end
end
for i =1: length(latitude_i); %위도 경도 1도 단위
    for j = 1: length(longitude_i);
    table_latitude_i(i,j) = latitude_i(i);
    table_longitude_i(i,j) = longitude_i(j);
    end
end


%위도 경도 사이의 거리 구하기        
for i = 1: length(latitude)-1; %위도 기준 거리(4도단위)
    for j = 1: length(longitude);
        dist_latitude(i,j) = sw_dist([table_latitude(i,j), table_latitude(i+1,j)], ...
            [table_longitude(i,j), table_longitude(i+1,j)], 'km');
        dist_latitude(i,j) = dist_latitude(i,j)*1000 %m로 변환
        %sw_dist가 m단위는 안되므로 km를 거쳐서 m로 변환
    end
end
for i = 1: length(latitude); %경도 기준 단위(4도 단위)
    for j = 1 : length(longitude)-1;
        dist_longitude(i,j) = sw_dist([table_latitude(i,j), table_latitude(i,j+1)], ...
            [table_longitude(i,j), table_longitude(i,j+1)], 'km');
        dist_longitude(i,j) = dist_longitude(i,j)*1000 %m로 변환
    end
end
for i = 1: length(latitude_i)-1; %위도 기준 거리(1도단위)
    for j = 1: length(longitude_i);
         dist_latitude_i(i,j) = sw_dist([table_latitude_i(i,j), table_latitude_i(i+1,j)], ...
            [table_longitude_i(i,j), table_longitude_i(i+1,j)], 'km');
        dist_latitude_i(i,j) = dist_latitude_i(i,j)*1000 %m로 변환
    end
end
for i = 1: length(latitude_i); %경도 기준 단위(1도 단위)
    for j = 1 : length(longitude_i)-1;
        dist_longitude_i(i,j) = sw_dist([table_latitude_i(i,j), table_latitude_i(i,j+1)], ...
            [table_longitude_i(i,j), table_longitude_i(i,j+1)], 'km');
        dist_longitude_i(i,j) = dist_longitude_i(i,j)*1000 %m로 변환
    end
end


%기압 경도 구하기
%위도 방향 기준 4도 단위
press_grad_lat = nan(length(latitude), length(longitude));
for i = 2: length(latitude)-1;
    for j = 1:length(longitude);
         press_grad_lat(i,j) = -(1/1.293)*(pressure(i-1,j)-pressure(i+1,j))...
             /(dist_latitude(i-1,j)+dist_latitude(i,j));
          %0°C 1기압에서 공기의 밀도 1.293
    end
end
%경도 방향 기준 4도 단위
press_grad_lon = nan(length(latitude), length(longitude));
for i = 1:length(latitude);
    for j = 2: length(longitude)-1;
        press_grad_lon(i,j) = -(1/1.293)*(pressure(i,j+1)-pressure(i,j-1))...
             /(dist_longitude(i,j-1)+dist_longitude(i,j));
    end
end
%위도 방향 기준 1도 단위
press_grad_lat_i = nan(length(latitude_i), length(longitude_i));
for i = 2: length(latitude_i)-1;
    for j = 1:length(longitude_i);
         press_grad_lat_i(i,j) = -(1/1.293)*(pressure_i(i-1,j)-pressure_i(i+1,j))...
             /(dist_latitude_i(i-1,j)+dist_latitude_i(i,j));
          %0°C 1기압에서 공기의 밀도 1.293
    end
end
%경도 방향 기준 1도 단위
press_grad_lon_i = nan(length(latitude_i), length(longitude_i));
for i = 1:length(latitude_i);
    for j = 2: length(longitude_i)-1;
        press_grad_lon_i(i,j) = -(1/1.293)*(pressure_i(i,j+1)-pressure_i(i,j-1))...
             /(dist_longitude_i(i,j-1)+dist_longitude_i(i,j));
    end
end 
%%
figure(1);%위도 방향 기준 4도 단위 등치선
set(gcf, 'color', 'w');
%imagesc(longitude, latitude, press_grad_lat); 
axis xy;
hold on;
[c,h] = contourf(longitude, latitude, press_grad_lat, [-1*10^(-3):0.0001:1*10^(-3)], 'k');
%행렬에서는 max,min안에 (:)해야한다.
clabel(c,h, 'labelspacing', 300)
hold on;
load hsl256;
hsl256(1:2,:)=1; 
colormap(hsl256);
colorbar;
a=colorbar;
a.Label.String = 'Pressure Gradient Force(m/s^2)';
caxis([-1*10^(-3),1*10^(-3)]);
axis([124, 136, 34, 46]);
title('Pressure Gradient Force(Latitude Direction)','FontSize',14,'FontWeight','bold');
xlabel('Longitude (ºE)');
ylabel('Latitude (ºN)');
hold on

    
%%
figure(2);%경도 방향 기준 4도 단위 등치선
set(gcf, 'color', 'w');
%imagesc(longitude, latitude, press_grad_lon); 
axis xy;
hold on;
[c,h] = contourf(longitude, latitude, press_grad_lon, [-1*10^(-3):0.0001:1*10^(-3)], 'k');
clabel(c,h, 'labelspacing', 300);
load hsl256;
colormap(hsl256);
colorbar;
a=colorbar;
a.Label.String = 'Pressure Gradient Force (m/s^2)';
caxis([-1*10^(-3),1*10^(-3)]);
axis([124, 136, 34, 46]);
title('Pressure Gradient Force(Longitude Direction)','FontSize',14,'FontWeight','bold');
xlabel('Longitude (ºE)');
ylabel('Latitude (ºN)');
hold on

%%
figure(3);%위도 방향 기준 1도 단위 등치선
set(gcf, 'color', 'w');
%imagesc(longitude_i, latitude_i, press_grad_lat_i);
axis xy;
hold on;
[c,h] = contourf(longitude_i, latitude_i, press_grad_lat_i, [-1*10^(-3):0.0001:1*10^(-3)], 'k');
clabel(c,h, 'labelspacing', 300);
load hsl256;
colormap(hsl256);
colorbar;
a=colorbar;
a.Label.String = 'Pressure Gradient Force (m/s^2)';
caxis([-1*10^(-3),1*10^(-3)]);
axis([124, 136, 34, 46]);
title('Pressure Gradient Force(Latitude Direction)','FontSize',14,'FontWeight','bold');
xlabel('Longitude (ºE)');
ylabel('Latitude (ºN)');
hold on

%%
figure(4);%경도 방향 기준 1도 단위 등치선
set(gcf, 'color', 'w');
%imagesc(longitude_i, latitude_i, press_grad_lon_i);
axis xy;
hold on;
[c,h] = contourf(longitude_i, latitude_i, press_grad_lon_i, [-1*10^(-3):0.0001:1*10^(-3)], 'k');
clabel(c,h, 'labelspacing', 300)
load hsl256;
colormap(hsl256);
colorbar;
a=colorbar;
a.Label.String = 'Pressure Gradient Force (m/s^2)';
caxis([-1*10^(-3),1*10^(-3)]);
axis([124, 136, 34, 46]);
title('Pressure Gradient Force(Longitude Direction)','FontSize',14,'FontWeight','bold');
xlabel('Longitude (ºE)');
ylabel('Latitude (ºN)');
hold on

%%
figure(5);%4도 단위 벡터 그림
set(gcf, 'color', 'w');
quiver(longitude, latitude,press_grad_lon,press_grad_lat,'k');
axis xy;
axis([122, 138, 32, 48]);
title('Pressure Gradient Force Vector','FontSize',14,'FontWeight','bold');
xlabel('Longitude (ºE)');
ylabel('Latitude (ºN)');
hold on

%%
figure(6);%1도 단위 벡터 그림
set(gcf, 'color', 'w');
quiver(longitude_i, latitude_i, press_grad_lon_i,press_grad_lat_i,'k');
axis xy;
axis([122, 138, 32, 48]);
title('Pressure Gradient Force Vector','FontSize',14,'FontWeight','bold');
xlabel('Longitude (ºE)');
ylabel('Latitude (ºN)');
hold on


%% 종관규모 분석

omega = 7.29*10^(-5); %지구 각속도(rad/s);
f = 2*omega*sin(deg2rad(40));
u = (1./f).*press_grad_lat_i;
v = -(1./f).*press_grad_lon_i;
figure(7);
set(gcf, 'color', 'w');
quiver(longitude_i, latitude_i, u, v,'k');
axis xy;
axis([122, 138, 32, 48]);
title('Sypnotic Scale Analysis of Motion Equation','FontSize',14,'FontWeight','bold');
xlabel('Longitude (ºE)');
ylabel('Latitude (ºN)');
hold on





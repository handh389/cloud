%% ���2 - ����1. ��а浵�� �� ���

clear all;
close all;
clc;

pressure = csvread('pressure data(140905).csv'); %�ϱ⵵ ���� �з� ������(���� �浵 4�� ����)
pressure = pressure *100 %hpa�� pa�� ��ȯ
latitude = [30:4:50]; %���� 4�� ����
longitude = [120:4:140]; %�浵 4�� ����
latitude = fliplr(latitude); %������ �Ʒ��� �� �����Ƿ� ���Ʒ� ��ȯ

latitude_i = [30:1:50]; %���� 1�� ����
longitude_i = [120:1:140]; %�浵 1�� ����
latitude_i = fliplr(latitude_i); %������ �Ʒ��� �� �����Ƿ� ���Ʒ� ��ȯ
pressure_i = griddata(longitude, latitude', pressure, longitude_i, latitude_i', 'cubic');
% �з� 1�� ������ ����
%%

%������ �浵�� 2���������� ǥ�� ǥ��
for i =1: length(latitude); %���� �浵 4�� ����
    for j = 1: length(longitude);
    table_latitude(i,j) = latitude(i);
    table_longitude(i,j) = longitude(j);
    end
end
for i =1: length(latitude_i); %���� �浵 1�� ����
    for j = 1: length(longitude_i);
    table_latitude_i(i,j) = latitude_i(i);
    table_longitude_i(i,j) = longitude_i(j);
    end
end


%���� �浵 ������ �Ÿ� ���ϱ�        
for i = 1: length(latitude)-1; %���� ���� �Ÿ�(4������)
    for j = 1: length(longitude);
        dist_latitude(i,j) = sw_dist([table_latitude(i,j), table_latitude(i+1,j)], ...
            [table_longitude(i,j), table_longitude(i+1,j)], 'km');
        dist_latitude(i,j) = dist_latitude(i,j)*1000 %m�� ��ȯ
        %sw_dist�� m������ �ȵǹǷ� km�� ���ļ� m�� ��ȯ
    end
end
for i = 1: length(latitude); %�浵 ���� ����(4�� ����)
    for j = 1 : length(longitude)-1;
        dist_longitude(i,j) = sw_dist([table_latitude(i,j), table_latitude(i,j+1)], ...
            [table_longitude(i,j), table_longitude(i,j+1)], 'km');
        dist_longitude(i,j) = dist_longitude(i,j)*1000 %m�� ��ȯ
    end
end
for i = 1: length(latitude_i)-1; %���� ���� �Ÿ�(1������)
    for j = 1: length(longitude_i);
         dist_latitude_i(i,j) = sw_dist([table_latitude_i(i,j), table_latitude_i(i+1,j)], ...
            [table_longitude_i(i,j), table_longitude_i(i+1,j)], 'km');
        dist_latitude_i(i,j) = dist_latitude_i(i,j)*1000 %m�� ��ȯ
    end
end
for i = 1: length(latitude_i); %�浵 ���� ����(1�� ����)
    for j = 1 : length(longitude_i)-1;
        dist_longitude_i(i,j) = sw_dist([table_latitude_i(i,j), table_latitude_i(i,j+1)], ...
            [table_longitude_i(i,j), table_longitude_i(i,j+1)], 'km');
        dist_longitude_i(i,j) = dist_longitude_i(i,j)*1000 %m�� ��ȯ
    end
end


%��� �浵 ���ϱ�
%���� ���� ���� 4�� ����
press_grad_lat = nan(length(latitude), length(longitude));
for i = 2: length(latitude)-1;
    for j = 1:length(longitude);
         press_grad_lat(i,j) = -(1/1.293)*(pressure(i-1,j)-pressure(i+1,j))...
             /(dist_latitude(i-1,j)+dist_latitude(i,j));
          %0��C 1��п��� ������ �е� 1.293
    end
end
%�浵 ���� ���� 4�� ����
press_grad_lon = nan(length(latitude), length(longitude));
for i = 1:length(latitude);
    for j = 2: length(longitude)-1;
        press_grad_lon(i,j) = -(1/1.293)*(pressure(i,j+1)-pressure(i,j-1))...
             /(dist_longitude(i,j-1)+dist_longitude(i,j));
    end
end
%���� ���� ���� 1�� ����
press_grad_lat_i = nan(length(latitude_i), length(longitude_i));
for i = 2: length(latitude_i)-1;
    for j = 1:length(longitude_i);
         press_grad_lat_i(i,j) = -(1/1.293)*(pressure_i(i-1,j)-pressure_i(i+1,j))...
             /(dist_latitude_i(i-1,j)+dist_latitude_i(i,j));
          %0��C 1��п��� ������ �е� 1.293
    end
end
%�浵 ���� ���� 1�� ����
press_grad_lon_i = nan(length(latitude_i), length(longitude_i));
for i = 1:length(latitude_i);
    for j = 2: length(longitude_i)-1;
        press_grad_lon_i(i,j) = -(1/1.293)*(pressure_i(i,j+1)-pressure_i(i,j-1))...
             /(dist_longitude_i(i,j-1)+dist_longitude_i(i,j));
    end
end 
%%
figure(1);%���� ���� ���� 4�� ���� ��ġ��
set(gcf, 'color', 'w');
%imagesc(longitude, latitude, press_grad_lat); 
axis xy;
hold on;
[c,h] = contourf(longitude, latitude, press_grad_lat, [-1*10^(-3):0.0001:1*10^(-3)], 'k');
%��Ŀ����� max,min�ȿ� (:)�ؾ��Ѵ�.
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
xlabel('Longitude (��E)');
ylabel('Latitude (��N)');
hold on

    
%%
figure(2);%�浵 ���� ���� 4�� ���� ��ġ��
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
xlabel('Longitude (��E)');
ylabel('Latitude (��N)');
hold on

%%
figure(3);%���� ���� ���� 1�� ���� ��ġ��
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
xlabel('Longitude (��E)');
ylabel('Latitude (��N)');
hold on

%%
figure(4);%�浵 ���� ���� 1�� ���� ��ġ��
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
xlabel('Longitude (��E)');
ylabel('Latitude (��N)');
hold on

%%
figure(5);%4�� ���� ���� �׸�
set(gcf, 'color', 'w');
quiver(longitude, latitude,press_grad_lon,press_grad_lat,'k');
axis xy;
axis([122, 138, 32, 48]);
title('Pressure Gradient Force Vector','FontSize',14,'FontWeight','bold');
xlabel('Longitude (��E)');
ylabel('Latitude (��N)');
hold on

%%
figure(6);%1�� ���� ���� �׸�
set(gcf, 'color', 'w');
quiver(longitude_i, latitude_i, press_grad_lon_i,press_grad_lat_i,'k');
axis xy;
axis([122, 138, 32, 48]);
title('Pressure Gradient Force Vector','FontSize',14,'FontWeight','bold');
xlabel('Longitude (��E)');
ylabel('Latitude (��N)');
hold on


%% �����Ը� �м�

omega = 7.29*10^(-5); %���� ���ӵ�(rad/s);
f = 2*omega*sin(deg2rad(40));
u = (1./f).*press_grad_lat_i;
v = -(1./f).*press_grad_lon_i;
figure(7);
set(gcf, 'color', 'w');
quiver(longitude_i, latitude_i, u, v,'k');
axis xy;
axis([122, 138, 32, 48]);
title('Sypnotic Scale Analysis of Motion Equation','FontSize',14,'FontWeight','bold');
xlabel('Longitude (��E)');
ylabel('Latitude (��N)');
hold on





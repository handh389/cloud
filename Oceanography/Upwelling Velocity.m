%% �ؾ�2 ����1. Upwelling Velocity
clear all;
close all;
clc;

%nc������ ��� �̷�������� �ľ�
ncdisp('upwell exp data.nc');
info = ncinfo('upwell exp data.nc');

%������ ��������
longitude =  ncread('upwell exp data.nc', 'longitude');
latitude = ncread('upwell exp data.nc', 'latitude');
time = ncread('upwell exp data.nc', 'time');
sst = ncread('upwell exp data.nc', 'sst');
u10 = ncread('upwell exp data.nc','u10');
v10 = ncread('upwell exp data.nc', 'v10');

%�浵-����-�ð� ���� �����͸� ����-�浵-�ð� ������ ����
sst = permute(sst, [2,1,3]);
u10 = permute(u10, [2,1,3]);
v10 = permute(v10, [2,1,3]);

%% ���� ���� �� �����ϱ�&�Ϲ̴��
mask = isnan(sst); %sst�� �������� nan�� �״� �̷��� ������ ã�´�.
u10(mask) = nan;
v10(mask) = nan;

load land_america.mat;
latitude_america = Land(1).Lat %1�� �Ϲ�, %2�� ����, ...
longitude_america = Land(1).Lon

%% 
omega = 7.29*10^(-5); %���� ���ӵ�(rad/s);
f = 2*omega*sin(deg2rad(latitude)); %�̷� ���� ������ ���� f���� ���´�. 
rho = 1024 %�ؼ� �е�(kg/m^3);
f = repmat(f, 1, length(longitude), length(time)); 
%������ ���� f��, u10�� ���� �������� �����. 
%������ ������ f�� ������ ���� ���ĵǾ������ϱ� �浵, �ð����� ������ָ�ȴ�.

[longitude_m, latitude_m] = meshgrid(longitude, latitude); 
%����, �浵�� �����͵��� ����, �浵 ������ �°� 2���������� ǥ��

%%
curl_tau = nan(length(latitude), length(longitude), length(time));
tau_x = nan(length(latitude), length(longitude), length(time));
tau_y = nan(length(latitude), length(longitude), length(time));

% tau����� �ð�k�� ���� ������ ����Ѵ�.
for k = 1:length(time);
    u10_k = u10(:, :, k);
    v10_k = v10(:, :, k);
    [tau_xk, tau_yk] = windstress(u10_k, v10_k);  
    %climate data tool box���� �ٿ� �޾ƾ� �۵�
    %windstress�� pa������ ������ش�.
    
    tau_x(:,:,k) = tau_xk;
    tau_y(:,:,k) = tau_yk;
    curl_tau(:,:,k) = cdtcurl(latitude_m, longitude_m, tau_xk, tau_yk);
    %���������� climate data tool box���� �ٿ� �޾ƾ� �۵�
    %curl�� ������ش�.
    %islatlon�� �߰������� �˻��ؼ� �ٿ�޾Ƴ��ƾ� cdtcurl�� �۵��Ѵ�.
end

we = (1/rho)*(1/f).*curl_tau*24*3600 %we���
%�߰�������, ������ m/s�� ���� m/day�� ��ȯ

%%
season = input('season? (spring:3, summer:6, fall:9, winter:12)');
if season == 3;
    month = [3:5];
else if season == 6;
        month = [6:8];
    else if season == 9;
            month = [9:11];
        else if season == 12;
                month = [12, 1:2];
            end
        end
    end
end

we_data_monthly = we(:, :, month); %�־��� ������ ���� we��(161*201*3);
we_data_avg = nanmean(we_data_monthly, 3); %(nan�� ����)�־��� ������ ��� we��(161*201*1);

u10_monthly = u10(:,:,month);
v10_monthly = v10(:,:,month);
u10_avg = nanmean(u10_monthly, 3);
v10_avg = nanmean(v10_monthly, 3);


figure(1);
set(gcf, 'color', 'w');
imagesc(longitude, latitude, we_data_avg);
hold on;
axis xy;
load div256.mat; 
div256(1:2,:)=0.65;
colormap(div256);
colorbar;
a=colorbar;
a.Label.String = 'upwelling velocity(m/day)';
caxis([-2.5,2.5]);
hold on;
quiversc(longitude_m, latitude_m, u10_avg, v10_avg, 'k', 'density', 30);
plot(longitude_america, latitude_america, 'k');
hold on;
title(['Upwelling Velocity of West America(2019 ' num2str(month(1,1)) '~' num2str(month(1,3)) ')'], ...
    'FontSize',14,'FontWeight','bold');
xlabel('Longitude (��W)');
ylabel('Latitude (��N)');
hold on

%% �̼����ؾ� ǳ��
figure(2);
set(gcf, 'color', 'w');
windspeed = sqrt((u10_avg).^2+(v10_avg).^2);
imagesc(longitude, latitude, windspeed);
axis xy;
hold on;
[c, h]=contourf(longitude, latitude, windspeed, [0:1:10], 'k');
hold on;
clabel(c, h);
load hsl256;
hsl256(1:2,:)=0.65;
colormap(hsl256);
hold on;
plot(longitude_america, latitude_america, 'k');
hold on;
axis([-150, -100, 10, 50]);
colorbar;
a=colorbar;
a.Label.String = 'windspeed(m/s)';
caxis([-1,10]);
title(['Wind Speed of West America(2019 ' num2str(month(1,1)) '~' num2str(month(1,3)) ')'], ...
    'FontSize',14,'FontWeight','bold');
xlabel('Longitude (��W)');
ylabel('Latitude (��N)');
hold on

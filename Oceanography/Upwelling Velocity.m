%% 해양2 실험1. Upwelling Velocity
clear all;
close all;
clc;

%nc파일이 어떻게 이루어졌는지 파악
ncdisp('upwell exp data.nc');
info = ncinfo('upwell exp data.nc');

%데이터 가져오기
longitude =  ncread('upwell exp data.nc', 'longitude');
latitude = ncread('upwell exp data.nc', 'latitude');
time = ncread('upwell exp data.nc', 'time');
sst = ncread('upwell exp data.nc', 'sst');
u10 = ncread('upwell exp data.nc','u10');
v10 = ncread('upwell exp data.nc', 'v10');

%경도-위도-시간 순의 데이터를 위도-경도-시간 순으로 변경
sst = permute(sst, [2,1,3]);
u10 = permute(u10, [2,1,3]);
v10 = permute(v10, [2,1,3]);

%% 육지 위의 값 제거하기&북미대륙
mask = isnan(sst); %sst는 육지에서 nan일 테니 이러한 점들을 찾는다.
u10(mask) = nan;
v10(mask) = nan;

load land_america.mat;
latitude_america = Land(1).Lat %1이 북미, %2가 남미, ...
longitude_america = Land(1).Lon

%% 
omega = 7.29*10^(-5); %지구 각속도(rad/s);
f = 2*omega*sin(deg2rad(latitude)); %이로 인해 위도에 따른 f값이 나온다. 
rho = 1024 %해수 밀도(kg/m^3);
f = repmat(f, 1, length(longitude), length(time)); 
%위도에 따른 f을, u10과 같은 차원으로 만든다. 
%어차피 기존의 f가 위도에 따라 정렬되어있으니까 경도, 시간만을 고려해주면된다.

[longitude_m, latitude_m] = meshgrid(longitude, latitude); 
%위도, 경도를 데이터들의 위도, 경도 차원에 맞게 2차원적으로 표현

%%
curl_tau = nan(length(latitude), length(longitude), length(time));
tau_x = nan(length(latitude), length(longitude), length(time));
tau_y = nan(length(latitude), length(longitude), length(time));

% tau계산을 시간k에 따라 나눠서 계산한다.
for k = 1:length(time);
    u10_k = u10(:, :, k);
    v10_k = v10(:, :, k);
    [tau_xk, tau_yk] = windstress(u10_k, v10_k);  
    %climate data tool box에서 다운 받아야 작동
    %windstress를 pa단위로 계산해준다.
    
    tau_x(:,:,k) = tau_xk;
    tau_y(:,:,k) = tau_yk;
    curl_tau(:,:,k) = cdtcurl(latitude_m, longitude_m, tau_xk, tau_yk);
    %마찬가지로 climate data tool box에서 다운 받아야 작동
    %curl을 계산해준다.
    %islatlon을 추가적으로 검색해서 다운받아놓아야 cdtcurl이 작동한다.
end

we = (1/rho)*(1/f).*curl_tau*24*3600 %we계산
%추가적으로, 단위가 m/s인 것을 m/day로 변환

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

we_data_monthly = we(:, :, month); %주어진 계절의 월별 we값(161*201*3);
we_data_avg = nanmean(we_data_monthly, 3); %(nan값 제외)주어진 계절의 평균 we값(161*201*1);

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
xlabel('Longitude (ºW)');
ylabel('Latitude (ºN)');
hold on

%% 미서부해안 풍속
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
xlabel('Longitude (ºW)');
ylabel('Latitude (ºN)');
hold on

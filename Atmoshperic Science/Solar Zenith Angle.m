%% 대기실험 2-3 단파복사에 대한 구름의 역할
clear all; close all; clc;
load cagex.mat;

%지표에서의 태양복사 에너지
for i = 1:468;
    sza(i) = rad2deg(acos(cos_za(i)));
end
figure(1);
set(gcf, 'color', 'w');
plot(sza, srf_nf, '.', 'markersize' , 10);
xlim([0, 90]);
xlabel('Solar Zenith Angle(^o)', 'fontsize', 12);
ylabel('Surface Net Flux', 'fontsize', 12);
title('Surface Net Flux by Solor Zenith Angle(1994.4)', 'fontsize', 14, 'fontweight' ,'bold');

%대기 상층부에서의 태양복사 에너지
for i = 1:468;
    K(i) = sc(i)*(1-albedo(i))*cos_za(i);
end
figure(2);
set(gcf, 'color', 'w');
plot(sza, K, '.', 'markersize', 10);
xlim([0, 90]);
xlabel('Solar Zenith Angle(^o)', 'fontsize', 12);
ylabel('Upper Atmo Net Flux', 'fontsize', 12);
title('Upper Atmo Net Flux by Solar Zenith Angle(1994.4)', 'fontsize', 14, 'fontweight' ,'bold');

%대기 상부에서 지표면에서의 값을 뺀 에너지
for i = 1:468;
    K_srf(i)=K(i)-srf_nf(i);
end
figure(3);
set(gcf, 'color', 'w');
plot(sza, K_srf, '.', 'markersize', 10);
xlim([0,90]);
xlabel('Solar Zenith Angle(^o)', 'fontsize', 12);
ylabel('Upper Atmo Net Flux - Srf Net Flux', 'fontsize', 12);
title('U. Atmo Net Flux-Srf Net Flux by Solar Zenith Angle(1994.4)', 'fontsize', 14, 'fontweight' ,'bold');

%% 시간에 따른 대기 상부에서의 flux - 지표면에서의 flux, 반사도
for m = 1:26; %26일 동안 측정
    for n= 16:-1:0; 
        time(18*m-17) = datetime(1994, 4, 4+m, 9, 9, 0); %26일 동안 맨 처음 측정한 시간 9시 9분
        time(18*m-n) = time(18*m-n-1) + minutes(30); %9시 9분부터 17시 39분까지
    end 
end

figure(4); 
set(gcf, 'color', 'w', 'position', [500,150,1200, 400]);
for m=1:26; %중간에 측정을 안한 시간이 직선으로 표시되는 문제가 생겨 이를 날짜별로 각각 플랏에 그린다
    yyaxis left;
    plot(time(18*m-17:18*m), K_srf(18*m-17:18*m), 'b-', 'linewidth', 1.5);
    ylabel('Upper Atmo Net Flux - Srf Net Flux', 'color', 'b', 'fontsize', 12);
    set(gca, 'ycolor', 'b');
    hold on;
    yyaxis right;
    plot(time(18*m-17:18*m), albedo(18*m-17:18*m), 'r-', 'linewidth', 1.5);
    ylabel('Albedo', 'color', 'r', 'fontsize', 12);
    set(gca, 'ycolor', 'r');
    hold on;
end
xlabel('Time(mm-dd)', 'fontsize', 12);
date_t2 = [datetime(1994, 4, 5) : day(2): datetime(1994, 5, 1)]; %x축에 2일 간격으로 표시하기 위함
date_n2 = datenum(date_t2); %xtick에는 datetime형식으로 안들어가므로 datenum로 변환
chardate = char(date_t2) ; %xticklabel은 char형태로 들어가므로 변환
set(gca, 'xtick', date_n2, 'xticklabel', chardate(:,6:10)); 
xlim([date_n2(1),date_n2(end)]); 
set(gca, 'tickdir', 'out');
title('Upper Atmo Net Flux - Srf Net Flux & Albedo by date(1994. 4)', 'fontweight', 'bold', 'fontsize', 14);

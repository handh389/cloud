%% ������ 2-3 ���ĺ��翡 ���� ������ ����
clear all; close all; clc;
load cagex.mat;

%��ǥ������ �¾纹�� ������
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

%��� �����ο����� �¾纹�� ������
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

%��� ��ο��� ��ǥ�鿡���� ���� �� ������
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

%% �ð��� ���� ��� ��ο����� flux - ��ǥ�鿡���� flux, �ݻ絵
for m = 1:26; %26�� ���� ����
    for n= 16:-1:0; 
        time(18*m-17) = datetime(1994, 4, 4+m, 9, 9, 0); %26�� ���� �� ó�� ������ �ð� 9�� 9��
        time(18*m-n) = time(18*m-n-1) + minutes(30); %9�� 9�к��� 17�� 39�б���
    end 
end

figure(4); 
set(gcf, 'color', 'w', 'position', [500,150,1200, 400]);
for m=1:26; %�߰��� ������ ���� �ð��� �������� ǥ�õǴ� ������ ���� �̸� ��¥���� ���� �ö��� �׸���
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
date_t2 = [datetime(1994, 4, 5) : day(2): datetime(1994, 5, 1)]; %x�࿡ 2�� �������� ǥ���ϱ� ����
date_n2 = datenum(date_t2); %xtick���� datetime�������� �ȵ��Ƿ� datenum�� ��ȯ
chardate = char(date_t2) ; %xticklabel�� char���·� ���Ƿ� ��ȯ
set(gca, 'xtick', date_n2, 'xticklabel', chardate(:,6:10)); 
xlim([date_n2(1),date_n2(end)]); 
set(gca, 'tickdir', 'out');
title('Upper Atmo Net Flux - Srf Net Flux & Albedo by date(1994. 4)', 'fontweight', 'bold', 'fontsize', 14);

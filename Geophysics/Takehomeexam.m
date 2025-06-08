%% take home exam_2016-19161_�ѵ�ȯ
clear all; close all; clc;
load data_pr5.mat;

%������ �е�: 3000kg/m^3 %������ �е�: 1.293kg/m^3�̱� ������ ������ ���̰� Ŀ 0�̶� �ٻ� 
%�ͳ��Ǳ��̸� z, �ͳ��� �������� R�̶�� �� ��, 
%�Ǹ��� �� �𵨿��� delta_g=2*pi*G*delta_rho/z*R^2/(1+(x/z)^2)

delta_rho = -3000; %�� �������� ��Ÿ rho
G = 6.6743 * 10^(-11); %�����η� ���
find20 = find(x==-20); %�� ���� ������ ������ ��

%g�� ���� x=0�� ���Ͽ� ��Ī�̾�� �ϴµ�(x^2�� x�� ��ȣ�� ���ص� ����) �� �ͼ� ��Ī�� �̷��� �ʴ´�.
%��Ī�� �̷��� �ʴ� �� g���� ����.
for i = 1 : find20-1;
    difference_g(i) = g(length(x)+1-i)-g(i); 
end
%�� �� �Ŀ� �� ���� ���� 4.1935�� ����
%�� �� ���� ������ �� ���� ������ ��ȯ ���ش�. 
for i = 1 : find20-1;
    g_correct(i) = g(i);
end
for i = find20 : length(x);
    g_correct(i) = g(i)-4.1935;
end
plot(x, g_correct); 

%����� ���Ǹ� ���Ͽ� x=0�� ������ x=1�� ������ ���Ͽ� z�� R�� ���Ѵ�.
find0 = find(x==0); find1 = find(x==1);
g_0 = g_correct(find0);, g_1 = g_correct(find1);
z = sqrt(g_1/(g_0-g_1));  %z=5m
R = sqrt(g_0*10^(-8)*z/(2*pi*G*delta_rho)); 
%R=2m, �����η� ����� ������ ���߾� g���� m/s^2���� ��ȯ�ϱ� ���Ͽ� 10^(-8) ���Ͽ���.

%���� z = 5m, R = 2m�� �´��� �˻굵 �غ���.
for i = 1 : length(x);
    g_confirm(i) = 2 * pi * G * delta_rho * R^2 / z * (1/(1 + (x(i)/z)^2)) * 10^8;
end
% �˻��� ��� ��ġ�Ѵ�.

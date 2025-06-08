%% take home exam_2016-19161_한동환
clear all; close all; clc;
load data_pr5.mat;

%지층의 밀도: 3000kg/m^3 %공기의 밀도: 1.293kg/m^3이기 때문에 지층과 차이가 커 0이라 근사 
%터널의깊이를 z, 터널의 반지름을 R이라고 할 때, 
%실린더 형 모델에서 delta_g=2*pi*G*delta_rho/z*R^2/(1+(x/z)^2)

delta_rho = -3000; %비가 오기전의 델타 rho
G = 6.6743 * 10^(-11); %만유인력 상수
find20 = find(x==-20); %비가 오기 전까지 측정한 곳

%g는 원래 x=0에 대하여 대칭이어야 하는데(x^2은 x의 부호가 변해도 일정) 비가 와서 대칭을 이루지 않는다.
%대칭을 이루지 않는 두 g값을 뺀다.
for i = 1 : find20-1;
    difference_g(i) = g(length(x)+1-i)-g(i); 
end
%비가 온 후와 비가 오기 전은 4.1935로 일정
%비가 온 후의 값들을 비가 오기 전으로 변환 해준다. 
for i = 1 : find20-1;
    g_correct(i) = g(i);
end
for i = find20 : length(x);
    g_correct(i) = g(i)-4.1935;
end
plot(x, g_correct); 

%계산의 편의를 위하여 x=0인 지점과 x=1인 지점을 비교하여 z와 R을 구한다.
find0 = find(x==0); find1 = find(x==1);
g_0 = g_correct(find0);, g_1 = g_correct(find1);
z = sqrt(g_1/(g_0-g_1));  %z=5m
R = sqrt(g_0*10^(-8)*z/(2*pi*G*delta_rho)); 
%R=2m, 만유인력 상수의 단위에 맞추어 g값도 m/s^2으로 변환하기 위하여 10^(-8) 곱하였다.

%실제 z = 5m, R = 2m가 맞는지 검산도 해본다.
for i = 1 : length(x);
    g_confirm(i) = 2 * pi * G * delta_rho * R^2 / z * (1/(1 + (x(i)/z)^2)) * 10^8;
end
% 검산한 결과 일치한다.

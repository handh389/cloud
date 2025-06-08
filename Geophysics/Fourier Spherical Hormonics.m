%% 푸리에 급수 Spherical Harmonics 실험
%Assignment1
clear all;
close all;
clc;

load assignment1.mat;

dt = 0.001;
n= length(t);
df = 1/t(end);
freq = 0: df: 1/dt;

figure(1); 
plot(t, variation); %variation이 어떻게 이루어졌는지 확인
close all;

f = fft(variation); %고속 푸리에 변환
p0 = abs(f); %푸리에 변환 값의 복소수 크기
c0 = abs(real(f)); %e^(it)=cos(t)+i*sin(t)
s0 = abs(imag(f));

p = p0*(2/n); %푸리에 변환 값 크기의 크기 변환
c = c0*(2/n);
s = s0*(2/n);

nf = floor(n/2+1); %어차피 fft함수는 t의 앞과 뒤쪽에서
                   %양방향으로 구해주므로 절반은 필요없다
                   %뒤의 절반은 날린다
p = p(1:nf);
c = c(1:nf);
s = s(1:nf);
freq = freq(1:nf);

figure(2);
set(gcf, 'color', 'w');
stem(freq(1:nf), p(1:nf));
xlim([0,5]);  
xlabel('frequency(1/s)');
ylabel('amplitude');
title('Assignment1','FontSize',14,'FontWeight','bold');

[p_sort, index_sort] = sort(p, 'descend'); %두번째껀 정렬 인덱스, sort하기 전에 몇번째 꺼였는지를 알려준다.
freq_sort = freq(index_sort);
c_sort = c(index_sort);
s_sort = s(index_sort);

%%
%assignment2
clear all;
close all;
clc;

load assignment2;
dday = 0.0417;
n= length(day);
df = 1/day(end);
freq = 0: df: 1/dday;

figure(3);
plot(day, variation);
close all;

f=fft(variation);
p0 = abs(f); 
c0 = abs(real(f)); %e^(it)=cos(t)+i*sin(t)
s0 = abs(imag(f));

p = p0*(2/n); 
c = c0*(2/n);
s = s0*(2/n);

nf = floor(n/2+1); 
p = p(1:nf);
c = c(1:nf);
s = s(1:nf);
freq = freq(1:nf);

figure(4);
set(gcf, 'color', 'w');
stem(freq(1:nf), p(1:nf));
xlim([0,2.5]);
xlabel('frequency(1/day)');
ylabel('amplitude');
title('Assignment2','FontSize',14,'FontWeight','bold');

[p_sort, index_sort] = sort(p, 'descend'); 
freq_sort = freq(index_sort);
c_sort = c(index_sort);
s_sort = s(index_sort);

for i = 1: length(freq_sort);
    period_sort(i) = 1/freq_sort(i)*24;
end
period_sort = period_sort'
freq_sort = freq_sort'


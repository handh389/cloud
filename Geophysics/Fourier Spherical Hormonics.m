%% Ǫ���� �޼� Spherical Harmonics ����
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
plot(t, variation); %variation�� ��� �̷�������� Ȯ��
close all;

f = fft(variation); %��� Ǫ���� ��ȯ
p0 = abs(f); %Ǫ���� ��ȯ ���� ���Ҽ� ũ��
c0 = abs(real(f)); %e^(it)=cos(t)+i*sin(t)
s0 = abs(imag(f));

p = p0*(2/n); %Ǫ���� ��ȯ �� ũ���� ũ�� ��ȯ
c = c0*(2/n);
s = s0*(2/n);

nf = floor(n/2+1); %������ fft�Լ��� t�� �հ� ���ʿ���
                   %��������� �����ֹǷ� ������ �ʿ����
                   %���� ������ ������
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

[p_sort, index_sort] = sort(p, 'descend'); %�ι�°�� ���� �ε���, sort�ϱ� ���� ���° ���������� �˷��ش�.
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


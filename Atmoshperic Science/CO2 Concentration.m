[year, month, decimal_date, average, interpolated, trend, day]=textread('co2_195803_201803_maunaloa.txt', '%f%f%f%f%f%f%f', 'headerlines', 72);

figure(1);
plot(decimal_date, interpolated);
axis([1958 2019 310 420]);
title('CO_2 Change(Manua Loa 1958~2018)', 'Fontsize', 14)
xlabel('Time(year)','Fontsize',12);
ylabel('CO_2 Concentration(ppm)','Fontsize',12);
hold on


figure(2);
x=decimal_date(1:118,1);
y=interpolated(1:118,1);
x1=[decimal_date(1,1):0.1:2050];
plot(decimal_date, interpolated);
hold on
A=polyfit(x,y,1);
hold on
plot(decimal_date,polyval(A,decimal_date),'r');
A2=A(1,1)*x1+A(1,2);
A3=A2(1,918);
plot(x1,A2,'r');
hold on;
B=0.5*A(1,1);
C=average(1,1)-B*decimal_date(1,1);
K=B*x1+C;
K1=K(1,918);
plot(x1,K,'c');
hold on;
D=1.5*A(1,1);
F=average(1,1)-D*decimal_date(1,1);
L=D*x1+F;
L1=L(1,918);
plot(x1,L,'k');
text(2050,380,'(A)','color','r','fontsize',15);
text(2050,340,'(B)','color','c','fontsize',15);
text(2050,410,'(C)','color','k','fontsize',15);
title('CO_2 Change prediction(Manua Loa 1958~2050)', 'Fontsize', 14);
xlabel('Time(year)','Fontsize',12);
ylabel('CO_2 Concentration(ppm)','Fontsize',12);

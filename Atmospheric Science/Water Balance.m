clear all;
close all;
clc;

[month, p, pe, p_pe, st, delta_st, ae d, s]...
    =textread('대기실험7_201619161_한동환.txt', '%f%f%f%f%f%f%f%f%f', 'headerlines',1);

plot(month, p, 'b');
hold on;
plot(month, pe, 'k');
hold on;
plot(month, ae, 'm');
hold on;
axis([1 12 0 200]);
hold on
text(7,155,'S','FontSize',14, 'FontWeight', 'bold','Color','b');
text(1.5,70,'D','FontSize',14, 'FontWeight', 'bold','Color','r');
text(10.5,90,'D','FontSize',14,'FontWeight','bold','Color','r');
legend('Precipitation','Potential Evapotranspiration','Actual Evapotranspiration','location','SE');
xlabel('month', 'Fontsize',12);
ylabel('Quantity of Water(mm)','Fontsize',12);
title('Water Balance for a year', 'Fontsize',14,'Fontweight','bold');

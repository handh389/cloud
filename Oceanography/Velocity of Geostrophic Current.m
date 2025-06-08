clear all;
close all;
clc;

load coast_korea.mat;
load etopo5_korea.mat;

[area, line_station_no, latitude, longitude, date,  depth, temp, sal] =textread('2013년 전해역, 전수심.txt', '%s%6c%f%f%16c%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s',  'headerlines', 1);
line_no=str2num(line_station_no(:, 1:3));
station_no=str2num(line_station_no(:, 5:6));
month=str2num(date(:,6:7));

strmon=['JAN';'FEB';'MAR';'APR';'MAY';'JUN';'JUL';'AUG';'SEP';'OCT';'NOV';'DEC'];
fi=find(sal==0 & temp==0);
temp(fi)=NaN;
sal(fi)=NaN;
clear fi;

monthi=input('MONTH(2 or 8)=? ');
finda=find(month==monthi-1 | month==monthi);
line=line_no(finda); 
station=station_no(finda); 
latitude=latitude(finda); 
longitude=longitude(finda);
depth=depth(finda); 
temp=temp(finda); 
sal=sal(finda);

st=sw_dens0(sal,temp)-1000;
pres=sw_pres(depth,latitude);
svan=sw_svan(sal,temp,pres);

svan_mean(1)=svan(1);
for i=2:1:size(svan);
    if (depth(i) < depth(i-1))
        svan_mean(i)=svan(i);
    else
        svan_mean(i)=(svan(i-1)+svan(i))/2;
    end
end
svan_mean=svan_mean';

dp=diff(pres)*10000;
for j=1:1:size(dp)
    if (dp(j) <0);
        dp(j) = 0;
    end
end
dp=[0;dp];

dh=svan_mean.*dp;
findc=find(depth==0);
for k=1:1:size(findc)-1
    d(k)=sum(dh(findc(k):1:(findc(k+1)-1)));
end
d(k+1)=sum(dh(findc(k+1):end));

d=d';

final=find(depth==0);
loni=longitude(final); 
lati=latitude(final);
linei=line(final);
stationi=station(final);

figure(1)
set(gcf,'position',[50, 30, 510, 600]);
plot(lonc, latc, 'k');
xlabel('Longitude (^oE)');
ylabel('Latitude (^oN)');
axis([123 133 31 43]);
ut = []; vt = []; lont = []; latt = []; velt = [];
for i = min(linei) : max(linei)
    fi = find(linei==i);
     if length(fi) > 0 
        dhano = d(fi);
        lond = loni(fi);
        latd = lati(fi);
        
        
        [l angle]= sw_dist(latd,lond,'km');
        l=l*1000;
        f=sw_f(latd);
        
        for k=1:length(lond)-1
            lonp(k,1)=mean([lond(k+1) lond(k)]);
            latp(k,1)=mean([latd(k+1) latd(k)]);
            vel(k,1)=10*(dhano(k+1)-dhano(k))/(f(k)*l(k));
        end
        
        [u v]=pol2cart(deg2rad(angle-90), -vel);     ut = [ut;u];
        vt = [vt;v];
        lont = [lont;lonp];
        latt = [latt;latp];
        velt = [velt;vel];
       hold on; 
       plot(lond, latd, 'k.');
       clear lonp latp vel
     end
end
hold on
ut(~isfinite(ut))=0;
vt(~isfinite(vt))=0;
velt(~isfinite(velt))=0;
quiver(lont,latt,ut,vt,2,'Linewidth',1,'color','[1,0,1]');
title(['Velocity of Geostrophic Current(' strmon(monthi,:) ' 2013)'],'fontsize',15)


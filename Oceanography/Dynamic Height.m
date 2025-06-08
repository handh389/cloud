clear all;
close all;
clc;

[area, line_station_no, latitude, longitude, date,  depth, temp, sal] =textread('2013년 전해역, 전수심.txt', '%s%6c%f%f%16c%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s',  'headerlines', 1);
line_no=str2num(line_station_no(:, 1:3));
station_no=str2num(line_station_no(:, 5:6));
month=str2num(date(:,6:7));

load coast_korea.mat;
load etopo5_korea.mat;
strmon=['Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec'];


f0=find(sal==0 & temp==0);
temp(f0)=NaN;
sal(f0)=NaN;
clear f0;

monthi=input('MONTH(2 or 8)=?');
fi=find(month==(monthi)-1 | month==monthi);
linefind=line_no(fi);
stationfind=station_no(fi);
latitudefind=latitude(fi);
longitudefind=longitude(fi);
depthfind=depth(fi);
tempfind=temp(fi);
salfind=sal(fi);

st=sw_dens0(salfind, tempfind)-1000;
pres=sw_pres(depthfind, latitudefind);
svan=sw_svan(salfind, tempfind, pres);

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

findc=find(depthfind==0);
for k=1:1:size(findc)-1
    d(k)=sum(dh(findc(k):1:(findc(k+1)-1)));
end
d(k+1)=sum(dh(findc(k+1):end));

d=d';
data_mon=[linefind, stationfind, depthfind, tempfind, salfind, st, svan, svan_mean, dh];

final=find(depthfind==0);
loni=longitude(final);
lati=latitude(final);

xi=[124.0:0.01:132.5]; 
yi=[32.5:0.01:38.5];
di=griddata(loni,lati,d,xi,yi');
topo2=interp2(lonk,latk,topo,xi,yi');
di(topo2>=0)=NaN;

figure(1); set(gcf,'Color','w');
color2=colormap(jet(256)); color2=[1 1 1; color2];

colormap(color2); imagesc(xi,yi,di); colorbar; axis xy; hold on;
plot(loni,lati,'.k'); hold on;
[c,h]=contour(xi,yi,di,'k');
clabel(c,h,'labelspacing',200); hold on;
plot(lonc,latc,'k','linewidth',1.5);
title(['Dynamic Height (' strmon(monthi,:) ')'],'fontsize',20)
xlabel('Longitude(^oE)');
ylabel('Latitude(^oN)');


clear all;
close all;
clc;

[area, line_station_no, latitude, longitude, date,  depth, temp, sal] =textread('2013년 전해역, 전수심.txt', '%s%6c%f%f%16c%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s',  'headerlines', 1);
month=str2num(date(:, 6:7));
line=str2num(line_station_no(:, 1:3));
station=str2num(line_station_no(:, 5:6));

load coast_korea.mat;
load etopo5_korea.mat;
strmon=['Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec'];

fi=find(temp == 0 & sal == 0);
temp(fi)=NaN;
sal(fi)=NaN;
clear fi;

monthi=input('MONTH(2 or 8)=? ');
finda=find(month==monthi-1|month==monthi);
line=line(finda); 
station=station(finda); 
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

f0=find(depth==0);
lon0=longitude(f0);
lat0=latitude(f0);
line0=line(f0);
station0=station(f0);

depth0 =[];
for i = 1:size(f0,1)
    fi = find(line == line0(i) & station == station0(i));
    depth0(i,1)=max(depth(fi));
end

figure(1);
set(gcf,'position',[100, 60, 600, 500]);
set(gcf, 'Color', 'w'); 
plot(lonc,latc,'k');
xlabel('Longitude (^oE)');
ylabel('Latitude (^oN)');
axis([123 133 31 41]);

ut = []; vt = []; lont = []; latt = []; velt = []; Qt = [];
for i = min(line0) : max(line0)
    fi = find(line0==i);
    if length(fi)>0
        dhano = d(fi);
        lond = lon0(fi);
        latd = lat0(fi);
        stationd = station0(fi);
        depthd = depth0(fi);
        
        [l angle]= sw_dist(latd,lond,'km');
        l=l*1000;
        f=sw_f(latd);
        
        for k=1:length(lond)-1
            lonp(k,1)=mean([lond(k+1) lond(k)]);
            latp(k,1)=mean([latd(k+1) latd(k)]);
            depthp(k,1)=mean([depthd(k+1) depthd(k)]);
            vel(k,1)=10*(dhano(k+1)-dhano(k))/(f(k)*l(k)); 
            Q(k,1)=l(k,1)*vel(k,1)*depthp(k,1)*10^-6;
        end
        
        [u v]=pol2cart(deg2rad(angle-90),-Q); 
        ut = [ut;u];
        vt = [vt;v];
        lont = [lont;lonp];
        latt = [latt;latp];
        velt = [velt;vel];
        Qt = [Qt;Q];
                
        if i==203 | i==204 | i==205 | i==206 | i==207 | i==208 | i==209
        Q(isnan(Q))=0;
        sum_Q(i-202)=sum(Q);
        end
        
        clear lonp latp vel Q;
        hold on
        plot(lond, latd, 'k.');
    end
end

hold on
quiver(lont,latt,ut,vt,2,'Linewidth',1,'color','b');
title(['Geostrophic Current Volume Transport(' strmon(monthi,:) '2013)'],'fontsize',15)


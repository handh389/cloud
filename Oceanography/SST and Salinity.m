%% 동해 L102
clear

[area, line_stattion_no, latitude, longitude, date,  depth, temp, sal] =textread('동해 L102.txt', '%s%6c%f%f%16c%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s',  'headerlines', 1);
station_no=str2num(line_stattion_no(:, 5:6)); 

dep = unique(depth);
stt_no = unique(station_no);
long = unique(longitude);

table1 = NaN(length(dep), length(stt_no));
table2 = NaN(length(dep), length(stt_no));

for i=1:length(dep);
    for j=1: length(stt_no);
        f=find(station_no==stt_no(j) & depth==dep(i));
        if length(f)>0;
            table1(i,j)=temp(f);
            table2(i,j)=sal(f);
            
        else
            table1(i,j)=NaN;
            table2(i,j)=NaN;
           
        end
    end
end

[xi, yi] = meshgrid(min(long): 0.01 :max(long), 0:10:500)
table11 = interp2(long', dep', table1, xi, yi);
table22 = interp2(long', dep', table2, xi, yi);

figure(1);
[c,h]=contourf(xi, -yi, table11, [0:2:22])
colorbar;
caxis([min(temp) max(temp)]);
clabel(c,h)
set(gca,'ytick',[-500:50:0],'yticklabel',[500:-50:0]);
set(gca,'xtick', long,'xticklabel',stt_no,'xaxislocation','top');
ylabel('Depth (m)','fontname','times new roman');
xlabel('station number','fontname','times new roman');
title('Temperature(°C) of L102 line June 2016', 'fontsize', 20, 'fontname','times new roman')
colormap(cool);

figure(2)'
[c,h]=contourf(xi, -yi, table22, [32: 0.2: 35]);
colorbar;
caxis([min(sal) max(sal)]);
clabel(c,h);
set(gca, 'ytick', [-500:50:0],'yticklabel',[500:-50:0]);
set(gca,'xtick', long,'xticklabel',stt_no,'xaxislocation','top');
ylabel('Depth (m)','fontname','times new roman');
xlabel('station number','fontname','times new roman');
title('Salinity(psu) of L102 line June 2016', 'fontsize', 20, 'fontname','times new roman')
colormap(jet);

%% 동해 L103

clear

[area, line_stattion_no, latitude, longitude, date,  depth, temp, sal] =textread('동해 L103.txt', '%s%6c%f%f%16c%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s',  'headerlines', 1);
station_no=str2num(line_stattion_no(:, 5:6)); 

dep = unique(depth);
stt_no = unique(station_no);
long = unique(longitude);

table1 = NaN(length(dep), length(stt_no));
table2 = NaN(length(dep), length(stt_no));

for i=1:length(dep);
    for j=1: length(stt_no);
        f=find(station_no==stt_no(j) & depth==dep(i));
        if length(f)>0;
            table1(i,j)=temp(f);
            table2(i,j)=sal(f);
            
        else
            table1(i,j)=NaN;
            table2(i,j)=NaN;
           
        end
    end
end

[xi, yi] = meshgrid(min(long): 0.01 :max(long), 0:10:500)
table11 = interp2(long', dep', table1, xi, yi);
table22 = interp2(long', dep', table2, xi, yi);

figure(1);
[c,h]=contourf(xi, -yi, table11, [0:2:22])
colorbar;
caxis([min(temp) max(temp)]);
clabel(c,h)
set(gca,'ytick',[-500:50:0],'yticklabel',[500:-50:0]);
set(gca,'xtick', long,'xticklabel',stt_no,'xaxislocation','top');
ylabel('Depth (m)','fontname','times new roman');
xlabel('station number','fontname','times new roman');
title('Temperature(°C) of L103 line June 2016', 'fontsize', 20, 'fontname','times new roman')
colormap(cool);

figure(2);
[c,h]=contourf(xi, -yi, table22, [33: 0.2: 35]);
colorbar;
caxis([min(sal) max(sal)]);
clabel(c,h);
set(gca, 'ytick', [-500:50:0],'yticklabel',[500:-50:0]);
set(gca,'xtick', long,'xticklabel',stt_no,'xaxislocation','top');
ylabel('Depth (m)','fontname','times new roman');
xlabel('station number','fontname','times new roman');
title('Salinity(psu) of L103 line June 2016', 'fontsize', 20, 'fontname','times new roman')
colormap(jet);

%% 동해 L104
clear

[area, line_stattion_no, latitude, longitude, date,  depth, temp, sal] =textread('동해 L102.txt', '%s%6c%f%f%16c%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s',  'headerlines', 1);
station_no=str2num(line_stattion_no(:, 5:6)); 

dep = unique(depth);
stt_no = unique(station_no);
long = unique(longitude);

table1 = NaN(length(dep), length(stt_no));
table2 = NaN(length(dep), length(stt_no));

for i=1:length(dep);
    for j=1: length(stt_no);
        f=find(station_no==stt_no(j) & depth==dep(i));
        if length(f)>0;
            table1(i,j)=temp(f);
            table2(i,j)=sal(f);
            
        else
            table1(i,j)=NaN;
            table2(i,j)=NaN;
           
        end
    end
end

[xi, yi] = meshgrid(min(long): 0.01 :max(long), 0:10:500)
table11 = interp2(long', dep', table1, xi, yi);
table22 = interp2(long', dep', table2, xi, yi);

figure(1);
[c,h]=contourf(xi, -yi, table11, [0:2:22])
colorbar;
caxis([min(temp) max(temp)]);
clabel(c,h)
set(gca,'ytick',[-500:50:0],'yticklabel',[500:-50:0]);
set(gca,'xtick', long,'xticklabel',stt_no,'xaxislocation','top');
ylabel('Depth (m)','fontname','times new roman');
xlabel('station number','fontname','times new roman');
title('Temperature(°C) of L104 line June 2016', 'fontsize', 20, 'fontname','times new roman')
colormap(cool);

figure(2)'
[c,h]=contourf(xi, -yi, table22, [32: 0.2: 35]);
colorbar;
caxis([min(sal) max(sal)]);
clabel(c,h);
set(gca, 'ytick', [-500:50:0],'yticklabel',[500:-50:0]);
set(gca,'xtick', long,'xticklabel',stt_no,'xaxislocation','top');
ylabel('Depth (m)','fontname','times new roman');
xlabel('station number','fontname','times new roman');
title('Salinity(psu) of L104 line June 2016', 'fontsize', 20, 'fontname','times new roman')
colormap(jet);
clear
clc
%%
%read excel
filename_excel="D:\yellow river water comsumption\data\单产统计数据_地级市.xlsx";
data=readtable(filename_excel);
wheat_rea_2000=table2array(data(:,"wheat2000"));
maize_rea_2000=table2array(data(:,"maize2000"));
soybean_rea_2000=table2array(data(:,"soybean2000"));
wheat_rea_2005=table2array(data(:,"wheat2005"));
maize_rea_2005=table2array(data(:,"maize2005"));
soybean_rea_2005=table2array(data(:,"soybean2005"));
wheat_rea_2010=table2array(data(:,"wheat2010"));
maize_rea_2010=table2array(data(:,"maize2010"));
soybean_rea_2010=table2array(data(:,"soybean2010"));
wheat_rea_2015=table2array(data(:,"wheat2015"));
maize_rea_2015=table2array(data(:,"maize2015"));
soybean_rea_2015=table2array(data(:,"soybean2015"));
wheat_rea_2020=table2array(data(:,"wheat2020"));
maize_rea_2020=table2array(data(:,"maize2020"));
soybean_rea_2020=table2array(data(:,"soybean2020"));
filename_yellow_river_city_shp="D:\yellow river water comsumption\data\shp\cities_in_the_yellow_river_basin_geo_66.shp";
S=shaperead(filename_yellow_river_city_shp);
Sinfo=shapeinfo(filename_yellow_river_city_shp);
figure(1)
mapshow(S)
%%
str1={'whea','maiz','soyb'};
str2={'2000','2005','2010','2015','2020'};
lamda=zeros(15,67);
for strnum1=1:3
    for strnum2=1:5
        disp("strnum")
        disp(strnum1)
        disp(strnum2)
        filename_1km_yield=strcat("D:\yellow river water comsumption\data\yield catted from spam to crop distribution\3degree\",str1(strnum1),"_A_",str2(strnum2),"_3degree_0318.tif");
        [R,I]=geotiffread(filename_1km_yield);
        filename_temp=strcat("D:\yellow river water comsumption\data\crop distribution from dai 1km\crop_harvest_maps_yellow_river_dai_new\ha_",str1(strnum1),"_A_30sec_",str2(strnum2),"_CHN.tif");
        [R_dai_temp,~]=geotiffread(filename_temp);
        filename=strcat("D:\yellow river water comsumption\data\crop distribution from dai 1km\",str1(strnum1),"\ha_",str1(strnum1),"_A_30sec_",str2(strnum2),"_CHN.tif");
        [~,I_dai]=geotiffread(filename);
        R_dai=zeros(4248,7391);
        R_dai(1:4000,:)=R_dai_temp;
        info=geotiffinfo(filename);
        %%
        %check the data
        for i=1:4248
            lat(i)=53.55-(i-1)/120;
        end

        for j=1:7391
            lon(j)=73.5+(j-1)/120;
        end
        count=0;
        for i=1:4248
            for j=1:7391
                if lat(i)>30.5 && lat(i)<43.5
                    if lon(j)>89 && lon(j)<120
                        if R_dai(i,j)>0
                            count=count+1;
                        end
                    end
                end
            end
        end

        lengthR=length(find(R>-3));
        length_difference=lengthR-count;
        %         disp(count)
        %         disp(lengthR)
        %         disp(length_difference)
        %%
        for i=1:4248
            for j=1:7391
                if R(i,j)==-1
                    R_dai(i,j)=0;
                end
                if R(i,j)==-2
                    R_dai(i,j)=0;
                end
            end
        end

        for i=1:4248
            for j=1:7391
                if R(i,j)<0
                    R_dai(i,j)=nan;
                end
            end
        end

        R(R==-1)=nan;
        R(R==-2)=nan;
        %%
        %calibration
        for countcity=1:67
            disp("first")
            disp(countcity)
            yield_total_cell=[];
            area_total_cell=[];
            for i=1:4248
                for j=1:7391
                    if lat(i)>30.5 && lat(i)<43.5
                        if lon(j)>89 && lon(j)<120
                            if R(i,j)>0
                                [in on]=inpolygon(lon(j),lat(i),S(countcity).X,S(countcity).Y);
                                if in+on>0
                                    yield_total_cell=[yield_total_cell,R(i,j)*R_dai(i,j)];
                                    area_total_cell=[area_total_cell,R_dai(i,j)];
                                end
                            end
                        end
                    end
                end
            end

            if (strnum1-1)*5+strnum2==1
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(1,countcity)=mi/wheat_rea_2000(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(1,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==2
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(2,countcity)=mi/wheat_rea_2005(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(2,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==3
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(3,countcity)=mi/wheat_rea_2010(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(3,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==4
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(4,countcity)=mi/wheat_rea_2015(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(4,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==5
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(5,countcity)=mi/wheat_rea_2020(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(5,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==6
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(6,countcity)=mi/maize_rea_2000(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(6,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==7
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(7,countcity)=mi/maize_rea_2005(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(7,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==8
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(8,countcity)=mi/maize_rea_2010(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(8,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==9
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(9,countcity)=mi/maize_rea_2015(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(9,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==10
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(10,countcity)=mi/maize_rea_2020(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(10,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==11
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(11,countcity)=mi/soybean_rea_2000(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(11,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==12
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(12,countcity)=mi/soybean_rea_2005(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(12,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==13
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(13,countcity)=mi/soybean_rea_2010(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(13,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==14
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(14,countcity)=mi/soybean_rea_2015(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(14,countcity)=1;
                end
            end
            if (strnum1-1)*5+strnum2==15
                if isempty(yield_total_cell)==0
                    mi=sum(yield_total_cell)./sum(area_total_cell);
                    lamda(15,countcity)=mi/soybean_rea_2020(countcity);
                end
                if isempty(yield_total_cell)==1
                    lamda(15,countcity)=1;
                end
            end
        end
        R_final=nan*zeros(4248,7391);
        for countcity=1:67
            disp("second")
            disp(countcity)
            for i=1:4248
                for j=1:7391
                    if lat(i)>30.5 && lat(i)<43.5
                        if lon(j)>89 && lon(j)<120
                            [in on]=inpolygon(lon(j),lat(i),S(countcity).X,S(countcity).Y);
                            if in+on>0
                                R_final(i,j)=R(i,j)./lamda((strnum1-1)*5+strnum2,countcity);
                            end
                        end
                    end
                end
            end
        end
        %%
        filename_distribution_save=strcat("D:\yellow river water comsumption\data\corrected_distribution_yield\distribution_",str1(strnum1),"_A_",str2(strnum2),"_0806.tif");
        filename_yield_corrected_save=strcat("D:\yellow river water comsumption\data\corrected_distribution_yield\yield_",str1(strnum1),"_A_",str2(strnum2),"_0806.tif");
        geotiffwrite(filename_distribution_save,R_dai,I_dai,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag)
        geotiffwrite(filename_yield_corrected_save,R_final,I_dai,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag)
    end
end

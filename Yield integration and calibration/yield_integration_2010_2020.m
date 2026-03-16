clear
clc
t1=clock;
[~,I]=geotiffread("D:\yellow river water comsumption\data\crop distribution from dai 1km\whea\ha_whea_A_30sec_2000_CHN.tif");
%%
test=nan*zeros(36,3);
%read shp
filename_yellow_river_city_shp="D:\yellow river water comsumption\data\shp\cities_in_the_yellow_river_basin_geo_merge_66.shp";
S=shaperead(filename_yellow_river_city_shp);
Sinfo=shapeinfo(filename_yellow_river_city_shp);
figure(1)
mapshow(S)
%%
str1={'whea','maiz','soyb'};
str2='A';
str3={'2010','2015','2020'};
for strnum1=1:3
    for strnum2=1:1
        for strnum3=1:3

            filename=strcat("D:\yellow river water comsumption\data\crop distribution from dai 1km\crop_harvest_maps_yellow_river_dai_new\ha_",str1(strnum1),"_",str2(strnum2),"_30sec_",str3(strnum3),"_CHN.tif");
            filename_spam_2010=strcat("D:\yellow river water comsumption\data\SPAM yield\spam",str3(strnum3),"\",str3(strnum3),"_Y_T",str2(strnum2),".xlsx");
            %%
            [R_temp,~]=geotiffread(filename);
            R=zeros(4248,7391);
            R(1:4000,:)=R_temp;
            %read and test shp
            info=geotiffinfo(filename);
            data=readtable(filename_spam_2010);
            lon_spam=table2array(data(:,"X"));
            lat_spam=table2array(data(:,"Y"));
            R_wheat=table2array(data(:,"WHEA"));
            R_maize=table2array(data(:,"MAIZ"));
            R_soybean=table2array(data(:,"SOYB"));
            R_cotton=table2array(data(:,"COTT"));

            for i=1:4248
                lat(i)=53.55-(i-1)/120;
            end

            for j=1:7391
                lon(j)=73.5+(j-1)/120;
            end
            %%
            %wheat, integration data (downscale and spatially match)
            yield_final=nan*zeros(4248,7391);
            if strnum1==1
                for i=1:4248
                    for j=1:7391
                        if lat(i)>30.5 && lat(i)<43.5
                            if lon(j)>89 && lon(j)<120
                                if R(i,j)>0
                                    i
                                    j
                                    distance=[];
                                    yield_temp=[];
                                    for m=1:length(lat_spam)
                                        if lat_spam(m)>lat(i)-3 && lat_spam(m)<lat(i)+3
                                            if lon_spam(m)>lon(j)-3 && lon_spam(m)<lon(j)+3
                                                if R_wheat(m)>0
                                                    distance=[distance;sqrt((lat_spam(m)-lat(i)).^2+(lon_spam(m)-lon(j)).^2)];
                                                    yield_temp=[yield_temp;R_wheat(m)];
                                                end
                                            end
                                        end
                                    end
                                    if isempty(distance)==1
                                        dy=[];
                                        [in on]=inpolygon(lon(j),lat(i),S.X,S.Y);
                                        if in==1
                                            yield_final(i,j)=-1;
                                        end
                                        if in==0
                                            yield_final(i,j)=-2;
                                        end
                                    end
                                    if isempty(distance)==0
                                        dy=[distance,yield_temp];
                                        sortdy=sortrows(dy);
                                        yield_final(i,j)=sortdy(1,2);
                                    end
                                end
                            end
                        end
                    end
                end
            end
%%
            %maize,integration data (downscale and spatially match)
            if strnum1==2
                for i=1:4248
                    for j=1:7391
                        if lat(i)>30.5 && lat(i)<43.5
                            if lon(j)>89 && lon(j)<120
                                if R(i,j)>0
                                    i
                                    j
                                    distance=[];
                                    yield_temp=[];
                                    for m=1:length(lat_spam)
                                        if lat_spam(m)>lat(i)-3 && lat_spam(m)<lat(i)+3
                                            if lon_spam(m)>lon(j)-3 && lon_spam(m)<lon(j)+3
                                                if R_maize(m)>0
                                                    distance=[distance;sqrt((lat_spam(m)-lat(i)).^2+(lon_spam(m)-lon(j)).^2)];
                                                    yield_temp=[yield_temp;R_maize(m)];
                                                end
                                            end
                                        end
                                    end
                                    if isempty(distance)==1
                                        dy=[];
                                        [in on]=inpolygon(lon(j),lat(i),S.X,S.Y);
                                        if in==1
                                            yield_final(i,j)=-1;
                                        end
                                        if in==0
                                            yield_final(i,j)=-2;
                                        end
                                    end
                                    if isempty(distance)==0
                                        dy=[distance,yield_temp];
                                        sortdy=sortrows(dy);
                                        yield_final(i,j)=sortdy(1,2);
                                    end
                                end
                            end
                        end
                    end
                end
            end
%%
            %soybean,integration data (downscale and spatially match)
            if strnum1==3
                for i=1:4248
                    for j=1:7391
                        if lat(i)>30.5 && lat(i)<43.5
                            if lon(j)>89 && lon(j)<120
                                if R(i,j)>0
                                    i
                                    j
                                    distance=[];
                                    yield_temp=[];
                                    for m=1:length(lat_spam)
                                        if lat_spam(m)>lat(i)-3 && lat_spam(m)<lat(i)+3
                                            if lon_spam(m)>lon(j)-3 && lon_spam(m)<lon(j)+3
                                                if R_soybean(m)>0
                                                    distance=[distance;sqrt((lat_spam(m)-lat(i)).^2+(lon_spam(m)-lon(j)).^2)];
                                                    yield_temp=[yield_temp;R_soybean(m)];
                                                end
                                            end
                                        end
                                    end
                                    if isempty(distance)==1
                                        dy=[];
                                        [in on]=inpolygon(lon(j),lat(i),S.X,S.Y);
                                        if in==1
                                            yield_final(i,j)=-1;
                                        end
                                        if in==0
                                            yield_final(i,j)=-2;
                                        end
                                    end
                                    if isempty(distance)==0
                                        dy=[distance,yield_temp];
                                        sortdy=sortrows(dy);
                                        yield_final(i,j)=sortdy(1,2);
                                    end
                                end
                            end
                        end
                    end
                end
            end
%%
            filename_save=strcat("D:\yellow river water comsumption\data\yield catted from spam to crop distribution\",str1(strnum1),"_",str2(strnum2),"_",str3(strnum3),"_3degree_0318.tif");
            geotiffwrite(filename_save,yield_final,I,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag)
            test(((strnum1-1)*9+(strnum2-1)*3+strnum3),1)=length(find(yield_final>0));
            test(((strnum1-1)*9+(strnum2-1)*3+strnum3),2)=length(find(yield_final==-1))/length(find(yield_final>0));
            test(((strnum1-1)*9+(strnum2-1)*3+strnum3),3)=length(find(yield_final==-2))/length(find(yield_final>0));
        end
    end
end

t2=clock;
runtime=etime(t2,t1)



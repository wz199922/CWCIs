clear
clc
t1=clock;
[~,I]=geotiffread("D:\yellow river water comsumption\data\crop distribution from dai 1km\whea\ha_whea_A_30sec_2000_CHN.tif");
%%
filename_yellow_river_city_shp="D:\yellow river water comsumption\data\shp\cities_in_the_yellow_river_basin_geo_merge_66.shp";
%read shp
S=shaperead(filename_yellow_river_city_shp);
Sinfo=shapeinfo(filename_yellow_river_city_shp);
figure(1)
mapshow(S)
%%
str1={'WHEA','MAIZ','SOYB'};
str2='A';
str3={'whea','maiz','soyb'};
for strnum1=1:3
    for strnum2=1:1
        filename=strcat("D:\yellow river water comsumption\data\crop distribution from dai 1km\crop_harvest_maps_yellow_river_dai_new\ha_",str3(strnum1),"_",str2(strnum2),"_30sec_2005_CHN.tif");
        [R_temp,~]=geotiffread(filename);
        R=zeros(4248,7391);
        R(1:4000,:)=R_temp;
        info=geotiffinfo(filename);
        filename_spam=strcat("D:\yellow river water comsumption\data\SPAM yield\spam2005\SPAM2005V3r2_global_Y_T",str2(strnum2),"_",str1(strnum1),"_",str2(strnum2),".tif");
        [R_spam,I_spam]=geotiffread(filename_spam);

        for i=1:4248
            lat(i)=53.55-(i-1)/120;
        end

        for j=1:7391
            lon(j)=73.5+(j-1)/120;
        end

        for m=1:2160
            lat_spam(m)=90-(m-1)/12;
        end
        for n=1:4320
            lon_spam(n)=-180+(n-1)/12;
        end
        %%
        %integration data (downscale and spatially match)
        yield_final=nan*zeros(4248,7391);

        for i=1:4248
            for j=1:7391
                if lat(i)>30.5 && lat(i)<43.5
                    if lon(j)>89 && lon(j)<120
                        if R(i,j)>0
                            i
                            j
                            distance=[];
                            yield_temp=[];
                            for m=1:1:2160
                                for n=1:4320
                                    if lat_spam(m)>lat(i)-3 && lat_spam(m)<lat(i)+3
                                        if lon_spam(n)>lon(j)-3 && lon_spam(n)<lon(j)+3
                                            if R_spam(m,n)>0
                                                distance=[distance;sqrt((lon_spam(n)-lon(j)).^2+(lat_spam(m)-lat(i)).^2)];
                                                yield_temp=[yield_temp;R_spam(m,n)];
                                            end
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
        filename_save=strcat("D:\yellow river water comsumption\data\yield catted from spam to crop distribution\",str3(strnum1),"_",str2(strnum2),"_2005_3degree_0318.tif");
        geotiffwrite(filename_save,yield_final,I,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag)
    end
end

t2=clock;
runtime=etime(t2,t1);
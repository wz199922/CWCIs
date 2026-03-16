clear
clc
%%
filename_wheat="D:\yellow river water comsumption\data\shp\cities_new\cities_wheat_66_new.shp";
S_wheat=shaperead(filename_wheat);
filename_maize="D:\yellow river water comsumption\data\shp\cities_new\cities_maize_66_new.shp";
S_maize=shaperead(filename_maize);
filename_soybean="D:\yellow river water comsumption\data\shp\cities_new\cities_soybean_66_new.shp";
S_soybean=shaperead(filename_soybean);
%%
filename_pre=strcat("G:\mete_1980-2022\pre\1998\ChinaMet_001deg_prec_1998_01_01.nc");
lon_pre=ncread(filename_pre,'lon');
lat_pre=ncread(filename_pre,'lat');
%%
str1={'whea','maiz','soyb'};
str2={'A'};
str3={'2000','2005','2010','2015','2020'};

for strnum1=1:3
    for strnum2=1:1
        for strnum3=1:5
            disp(strnum1)
            disp(strnum2)
            disp(strnum3)
            filename_water=strcat("D:\yellow river water comsumption\data\water comsumption\water_",str1(strnum1),"_",str2(strnum2),"_",str3(strnum3),"_0818.tif");
            [R,I]=geotiffread(filename_water);
            filename_water_max=strcat("D:\yellow river water comsumption\data\water comsumption\water_",str1(strnum1),"_",str2(strnum2),"_",str3(strnum3),"_max_0818.tif");
            [R_max,I_max]=geotiffread(filename_water_max);
            filename_water_min=strcat("D:\yellow river water comsumption\data\water comsumption\water_",str1(strnum1),"_",str2(strnum2),"_",str3(strnum3),"_min_0818.tif");
            [R_min,I_min]=geotiffread(filename_water_min);
            filename1="D:\yellow river water comsumption\China_1km_prep_2000.nc";
            info=geotiffinfo(filename_water);
            lon_pre=ncread(filename1,"lon");
            lat_pre=ncread(filename1,"lat");
            lon_pre=lon_pre(1868:5587);
            lat_pre=lat_pre(1208:2767);
            %year
            filename_pre_spring_wheat=load(strcat("D:\yellow river water comsumption\data\pre during growing seasons\pre_wheat_spring_new_0901.mat"));
            pre_spring_wheat=filename_pre_spring_wheat.pre_wheat_spring_mean;
            filename_pre_winter_wheat=load(strcat("D:\yellow river water comsumption\data\pre during growing seasons\pre_wheat_winter_new_0901.mat"));
            pre_winter_wheat=filename_pre_winter_wheat.pre_wheat_winter_mean;
            filename_pre_spring_maize=load(strcat("D:\yellow river water comsumption\data\pre during growing seasons\pre_maize_spring_new_0901.mat"));
            pre_spring_maize=filename_pre_spring_maize.pre_maize_spring_mean;
            filename_pre_summer_maize=load(strcat("D:\yellow river water comsumption\data\pre during growing seasons\pre_maize_summer_new_0901.mat"));
            pre_summer_maize=filename_pre_summer_maize.pre_maize_summer_mean;
            filename_pre_spring_soybean=load(strcat("D:\yellow river water comsumption\data\pre during growing seasons\pre_soybean_spring_new_0901.mat"));
            pre_spring_soybean=filename_pre_spring_soybean.pre_soybean_spring_mean;
            filename_pre_summer_soybean=load(strcat("D:\yellow river water comsumption\data\pre during growing seasons\pre_soybean_summer_new_0901.mat"));
            pre_summer_soybean=filename_pre_summer_soybean.pre_soybean_summer_mean;

            if strnum3==1
                data_pre_spring_wheat=pre_spring_wheat(:,:,1);
                data_pre_winter_wheat=pre_winter_wheat(:,:,1);
                data_pre_spring_maize=pre_spring_maize(:,:,1);
                data_pre_summer_maize=pre_summer_maize(:,:,1);
                data_pre_spring_soybean=pre_spring_soybean(:,:,1);
                data_pre_summer_soybean=pre_summer_soybean(:,:,1);   
            end

            if strnum3==2
                data_pre_spring_wheat=pre_spring_wheat(:,:,2);
                data_pre_winter_wheat=pre_winter_wheat(:,:,2);
                data_pre_spring_maize=pre_spring_maize(:,:,2);
                data_pre_summer_maize=pre_summer_maize(:,:,2);
                data_pre_spring_soybean=pre_spring_soybean(:,:,2);
                data_pre_summer_soybean=pre_summer_soybean(:,:,2);  
            end

            if strnum3==3
                data_pre_spring_wheat=pre_spring_wheat(:,:,3);
                data_pre_winter_wheat=pre_winter_wheat(:,:,3);
                data_pre_spring_maize=pre_spring_maize(:,:,3);
                data_pre_summer_maize=pre_summer_maize(:,:,3);
                data_pre_spring_soybean=pre_spring_soybean(:,:,3);
                data_pre_summer_soybean=pre_summer_soybean(:,:,3);  
            end

            if strnum3==4
                data_pre_spring_wheat=pre_spring_wheat(:,:,4);
                data_pre_winter_wheat=pre_winter_wheat(:,:,4);
                data_pre_spring_maize=pre_spring_maize(:,:,4);
                data_pre_summer_maize=pre_summer_maize(:,:,4);
                data_pre_spring_soybean=pre_spring_soybean(:,:,4);
                data_pre_summer_soybean=pre_summer_soybean(:,:,4);  
            end

            if strnum3==5
                data_pre_spring_wheat=pre_spring_wheat(:,:,5);
                data_pre_winter_wheat=pre_winter_wheat(:,:,5);
                data_pre_spring_maize=pre_spring_maize(:,:,5);
                data_pre_summer_maize=pre_summer_maize(:,:,5);
                data_pre_spring_soybean=pre_spring_soybean(:,:,5);
                data_pre_summer_soybean=pre_summer_soybean(:,:,5);  
            end

            for i=1:4248
                lat(i)=53.55-(i-1)/120;
            end

            for j=1:7391
                lon(j)=73.5+(j-1)/120;
            end

            %%
            
            if strnum1==1
                irrigation_wheat=zeros(4248,7391);
                irrigation_wheat_max=zeros(4248,7391);
                irrigation_wheat_min=zeros(4248,7391);
                for i=1208:2767
                    for j=1862:5581
                        if R(i,j)>0
                            disp("whea")
                            disp(i)
                            disp(j)

                            turn_lon=round((lon(j)-67.8425)/0.01+1);
                            turn_lat=round((lat(i)-15.2963)/0.01+1);

                            [in,on]=inpolygon(lon(j),lat(i),S_wheat(1).X,S_wheat(1).Y);
                            if in+on>0
                                irrigation_wheat(i,j)=R(i,j)-data_pre_winter_wheat(turn_lon,turn_lat);
                                irrigation_wheat_max(i,j)=R_max(i,j)-data_pre_winter_wheat(turn_lon,turn_lat);
                                irrigation_wheat_min(i,j)=R_min(i,j)-data_pre_winter_wheat(turn_lon,turn_lat);
                            end
                            [in,on]=inpolygon(lon(j),lat(i),S_wheat(2).X,S_wheat(2).Y);
                            if in+on>0
                                irrigation_wheat(i,j)=R(i,j)-data_pre_spring_wheat(turn_lon,turn_lat);
                                irrigation_wheat_max(i,j)=R_max(i,j)-data_pre_spring_wheat(turn_lon,turn_lat);
                                irrigation_wheat_min(i,j)=R_min(i,j)-data_pre_spring_wheat(turn_lon,turn_lat);
                            end
                        end
                    end
                end
            end

            if strnum1==2
                irrigation_maize=zeros(4248,7391);
                irrigation_maize_max=zeros(4248,7391);
                irrigation_maize_min=zeros(4248,7391);
                for i=1208:2767
                    for j=1862:5581
                        if R(i,j)>0
                            disp("maiz")
                            disp(i)
                            disp(j)

                            turn_lon=round((lon(j)-67.8425)/0.01+1);
                            turn_lat=round((lat(i)-15.2963)/0.01+1);

                            [in,on]=inpolygon(lon(j),lat(i),S_maize(2).X,S_maize(2).Y);
                            if in+on>0
                                irrigation_maize(i,j)=R(i,j)-data_pre_spring_maize(turn_lon,turn_lat);
                                irrigation_maize_max(i,j)=R_max(i,j)-data_pre_spring_maize(turn_lon,turn_lat);
                                irrigation_maize_min(i,j)=R_min(i,j)-data_pre_spring_maize(turn_lon,turn_lat);
                            end
                            [in,on]=inpolygon(lon(j),lat(i),S_maize(1).X,S_maize(1).Y);
                            if in+on>0
                                irrigation_maize(i,j)=R(i,j)-data_pre_summer_maize(turn_lon,turn_lat);
                                irrigation_maize_max(i,j)=R_max(i,j)-data_pre_summer_maize(turn_lon,turn_lat);
                                irrigation_maize_min(i,j)=R_min(i,j)-data_pre_summer_maize(turn_lon,turn_lat);
                            end
                        end
                    end
                end
            end

            if strnum1==3
                irrigation_soybean=zeros(4248,7391);
                irrigation_soybean_max=zeros(4248,7391);
                irrigation_soybean_min=zeros(4248,7391);
                for i=1208:2767
                    for j=1862:5581
                        if R(i,j)>0
                            disp("soyb")
                            disp(i)
                            disp(j)

                            turn_lon=round((lon(j)-67.8425)/0.01+1);
                            turn_lat=round((lat(i)-15.2963)/0.01+1);

                            [in,on]=inpolygon(lon(j),lat(i),S_soybean(2).X,S_soybean(2).Y);
                            if in+on>0
                                irrigation_soybean(i,j)=R(i,j)-data_pre_spring_soybean(turn_lon,turn_lat);
                                irrigation_soybean_max(i,j)=R_max(i,j)-data_pre_spring_soybean(turn_lon,turn_lat);
                                irrigation_soybean_min(i,j)=R_min(i,j)-data_pre_spring_soybean(turn_lon,turn_lat);
                            end
                            [in,on]=inpolygon(lon(j),lat(i),S_soybean(1).X,S_soybean(1).Y);
                            if in+on>0
                                irrigation_soybean(i,j)=R(i,j)-data_pre_summer_soybean(turn_lon,turn_lat);
                                irrigation_soybean_max(i,j)=R_max(i,j)-data_pre_summer_soybean(turn_lon,turn_lat);
                                irrigation_soybean_min(i,j)=R_min(i,j)-data_pre_summer_soybean(turn_lon,turn_lat);
                            end
                        end
                    end
                end
            end

            %%
            if strnum1==1
                for i=1208:2767
                    for j=1862:5581
                        [in,on]=inpolygon(lon(j),lat(i),S_soybean(2).X,S_soybean(2).Y);
                        if in+on>0
                            i
                            j
                            disp("in wheat")
                            irrigation_wheat(i,j)=irrigation_wheat(i,j)/0.85;
                            irrigation_wheat_max(i,j)=irrigation_wheat_max(i,j)/0.85;
                            irrigation_wheat_min(i,j)=irrigation_wheat_min(i,j)/0.85;
                        end
                    end
                end
                filename_save=strcat("D:\yellow river water comsumption\data\irrigation\irrigation_wheat_",str2(strnum2),"_",str3(strnum3),"_0904.tif");
                geotiffwrite(filename_save,irrigation_wheat,I,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
                filename_save_max=strcat("D:\yellow river water comsumption\data\irrigation\irrigation_wheat_",str2(strnum2),"_",str3(strnum3),"_max_0904.tif");
                geotiffwrite(filename_save_max,irrigation_wheat_max,I_max,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
                filename_save_min=strcat("D:\yellow river water comsumption\data\irrigation\irrigation_wheat_",str2(strnum2),"_",str3(strnum3),"_min_0904.tif");
                geotiffwrite(filename_save_min,irrigation_wheat_min,I_min,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
            end
            if strnum1==2
                for i=1208:2767
                    for j=1862:5581
                        [in,on]=inpolygon(lon(j),lat(i),S_soybean(2).X,S_soybean(2).Y);
                        if in+on>0
                            i
                            j
                            disp("in maize")
                            irrigation_maize(i,j)=irrigation_maize(i,j)/0.85;
                            irrigation_maize_max(i,j)=irrigation_maize_max(i,j)/0.85;
                            irrigation_maize_min(i,j)=irrigation_maize_min(i,j)/0.85;
                        end
                    end
                end
                filename_save=strcat("D:\yellow river water comsumption\data\irrigation\irrigation_maize_",str2(strnum2),"_",str3(strnum3),"_0904.tif");
                geotiffwrite(filename_save,irrigation_maize,I,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
                filename_save_max=strcat("D:\yellow river water comsumption\data\irrigation\irrigation_maize_",str2(strnum2),"_",str3(strnum3),"_max_0904.tif");
                geotiffwrite(filename_save_max,irrigation_maize_max,I_max,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
                filename_save_min=strcat("D:\yellow river water comsumption\data\irrigation\irrigation_maize_",str2(strnum2),"_",str3(strnum3),"_min_0904.tif");
                geotiffwrite(filename_save_min,irrigation_maize_min,I_min,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
            end
            if strnum1==3
                for i=1208:2767
                    for j=1862:5581
                        [in,on]=inpolygon(lon(j),lat(i),S_soybean(2).X,S_soybean(2).Y);
                        if in+on>0
                            i
                            j
                            disp("in soybean")
                            irrigation_soybean(i,j)=irrigation_soybean(i,j)/0.85;
                            irrigation_soybean_max(i,j)=irrigation_soybean_max(i,j)/0.85;
                            irrigation_soybean_min(i,j)=irrigation_soybean_min(i,j)/0.85;
                        end
                    end
                end
                filename_save=strcat("D:\yellow river water comsumption\data\irrigation\irrigation_soybean_",str2(strnum2),"_",str3(strnum3),"_0904.tif");
                geotiffwrite(filename_save,irrigation_soybean,I,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
                filename_save_max=strcat("D:\yellow river water comsumption\data\irrigation\irrigation_soybean_",str2(strnum2),"_",str3(strnum3),"_max_0904.tif");
                geotiffwrite(filename_save_max,irrigation_soybean_max,I_max,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
                filename_save_min=strcat("D:\yellow river water comsumption\data\irrigation\irrigation_soybean_",str2(strnum2),"_",str3(strnum3),"_min_0904.tif");
                geotiffwrite(filename_save_min,irrigation_soybean_min,I_min,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
            end

        end
    end
end


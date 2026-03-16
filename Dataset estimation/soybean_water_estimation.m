clear
clc


filename="D:\yellow river water comsumption\yield_et_fit_new.xlsx";
excel_yield_et=readtable(filename);
alpha=0.1;
%%
str1={'soyb'};
strnum1=1;
str2={'2000','2005','2010','2015','2020'};
str3={'A'};
for strnum2=1:5
    for strnum3=1:1
filename_yield_1km=strcat("D:\yellow river water comsumption\data\corrected_distribution_yield\yield_",str1(strnum1),"_",str3(strnum3),"_",str2(strnum2),"_0806.tif");
[R,I]=geotiffread(filename_yield_1km);
info=geotiffinfo(filename_yield_1km);
for i=1:4248
    lat(i)=53.55-(i-1)/120;
end

for j=1:7391
    lon(j)=73.5+(j-1)/120;
end
%%
filename_yellow_river_wheat_partitions="D:\yellow river water comsumption\data\shp\soybean_cities_geo_66_0106.shp";
S=shaperead(filename_yellow_river_wheat_partitions);
Sinfo=shapeinfo(filename_yellow_river_wheat_partitions);
figure(1)
mapshow(S)
%%
%soybean region1
wheat_f3r1_x=table2array(excel_yield_et(960:967,"x1_et_max"));
wheat_f3r1_y=table2array(excel_yield_et(960:967,"yield"));
wheat_f3r1_yield=table2array(excel_yield_et(960:967,"yield"));
wheat_f3r1_et=table2array(excel_yield_et(960:967,"et"));

model_f3r1=@(b,wheat_f3r1_x) b(1)+b(2)*(1-wheat_f3r1_x.*wheat_f3r1_x);
beta0=[0,0];
[beta1_f3r1,~]=lsqcurvefit(model_f3r1,beta0,wheat_f3r1_x,wheat_f3r1_y);

wheat_f1r1_x=table2array(excel_yield_et(960:967,"x1_et_max"));
wheat_f1r1_y=table2array(excel_yield_et(960:967,"x1_yield_max"));
wheat_f1r1_yield=table2array(excel_yield_et(960:967,"yield"));
wheat_f1r1_et=table2array(excel_yield_et(960:967,"et"));

model_f1r1=@(k,wheat_f1r1_x) k*wheat_f1r1_x;
beta0=1;
[beta1_f1r1,resnorm]=lsqcurvefit(model_f1r1,beta0,wheat_f1r1_x,wheat_f1r1_y);

MSE=resnorm/length(wheat_f1r1_x);
MSE_x_wheat_f1r1=MSE/beta1_f1r1;
sqsx=[];
for i=1:length(wheat_f1r1_y)
    sqsx(i)=(wheat_f1r1_y(i)-mean(wheat_f1r1_y))^2;
end
sqsx1_wheat_f1r1=sum(sqsx);

t_val_wheat_f1r1=tinv(1-alpha/2,length(wheat_f1r1_y)-length(beta1_f1r1));

syms x_wheat_r1;
y_wheat_r1=beta1_f3r1(1)+beta1_f3r1(2)*(1-x_wheat_r1.*x_wheat_r1);
%%
%region2
wheat_f3r2_x=table2array(excel_yield_et(968:974,"x1_et_max"));
wheat_f3r2_y=table2array(excel_yield_et(968:974,"yield"));
wheat_f3r2_yield=table2array(excel_yield_et(968:974,"yield"));
wheat_f3r2_et=table2array(excel_yield_et(968:974,"et"));

model_f3r2=@(b,wheat_f3r2_x) b(1)+b(2)*(1-wheat_f3r2_x.*wheat_f3r2_x);
beta0=[0,0];
[beta1_f3r2,~]=lsqcurvefit(model_f3r2,beta0,wheat_f3r2_x,wheat_f3r2_y);

wheat_f1r2_x=table2array(excel_yield_et(968:974,"x1_et_max"));
wheat_f1r2_y=table2array(excel_yield_et(968:974,"x1_yield_max"));
wheat_f1r2_yield=table2array(excel_yield_et(968:974,"yield"));
wheat_f1r2_et=table2array(excel_yield_et(968:974,"et"));

model_f1r2=@(k,wheat_f1r2_x) k*wheat_f1r2_x;
beta0=1;
[beta1_f1r2,resnorm]=lsqcurvefit(model_f1r2,beta0,wheat_f1r2_x,wheat_f1r2_y);

MSE=resnorm/length(wheat_f1r2_x);
MSE_x_wheat_f1r2=MSE/beta1_f1r2;
sqsx=[];
for i=1:length(wheat_f1r2_y)
    sqsx(i)=(wheat_f1r2_y(i)-mean(wheat_f1r2_y))^2;
end
sqsx1_wheat_f1r2=sum(sqsx);

t_val_wheat_f1r2=tinv(1-alpha/2,length(wheat_f1r2_y)-length(beta1_f1r2));

syms x_wheat_r2;
y_wheat_r2=beta1_f3r2(1)+beta1_f3r2(2)*(1-x_wheat_r2.*x_wheat_r2);
%%
%region3
wheat_f3r3_x=table2array(excel_yield_et(975:1017,"x1_et_max"));
wheat_f3r3_y=table2array(excel_yield_et(975:1017,"yield"));
wheat_f3r3_yield=table2array(excel_yield_et(975:1017,"yield"));
wheat_f3r3_et=table2array(excel_yield_et(975:1017,"et"));

model_f3r3=@(b,wheat_f3r3_x) b(1)+b(2)*(1-wheat_f3r3_x.*wheat_f3r3_x);
beta0=[0,0];
[beta1_f3r3,~]=lsqcurvefit(model_f3r3,beta0,wheat_f3r3_x,wheat_f3r3_y);

wheat_f1r3_x=table2array(excel_yield_et(975:1017,"x1_et_max"));
wheat_f1r3_y=table2array(excel_yield_et(975:1017,"x1_yield_max"));
wheat_f1r3_yield=table2array(excel_yield_et(975:1017,"yield"));
wheat_f1r3_et=table2array(excel_yield_et(975:1017,"et"));

model_f1r3=@(k,wheat_f1r3_x) k*wheat_f1r3_x;
beta0=1;
[beta1_f1r3,resnorm]=lsqcurvefit(model_f1r3,beta0,wheat_f1r3_x,wheat_f1r3_y);

MSE=resnorm/length(wheat_f1r3_x);
MSE_x_wheat_f1r3=MSE/beta1_f1r3;
sqsx=[];
for i=1:length(wheat_f1r3_y)
    sqsx(i)=(wheat_f1r3_y(i)-mean(wheat_f1r3_y))^2;
end
sqsx1_wheat_f1r3=sum(sqsx);

t_val_wheat_f1r3=tinv(1-alpha/2,length(wheat_f1r3_y)-length(beta1_f1r3));

syms x_wheat_r3;
y_wheat_r3=beta1_f3r3(1)+beta1_f3r3(2)*(1-x_wheat_r3.*x_wheat_r3);
%%
R_mi=zeros(4248,7391);
R_max=zeros(4248,7391);
R_min=zeros(4248,7391);
for i=1:4248
    for j=1:7391
        if lat(i)>30.5 && lat(i)<43.5
            if lon(j)>89 && lon(j)<120
                if R(i,j)>0
                    i
                    j
                    for turn=1:3
                        if S(turn).Region_wz==1
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                               disp("region 1")
                                R_temp=1-R(i,j)/max(wheat_f1r1_yield);
                                if R(i,j)>sum(beta1_f3r1)
                                    xmi=-(R(i,j)-sum(beta1_f3r1))/(beta1_f1r1*max(wheat_f1r1_yield));
                                end
                                if R(i,j)<=sum(beta1_f3r1)
                                    x_wheat_r1=solve(y_wheat_r1==R(i,j));
                                    xmi=double(x_wheat_r1(2));
                                end
                                res=sqrt(MSE_x_wheat_f1r1*(1/length(wheat_f1r1_y)+(R_temp-mean(wheat_f1r1_y))^2/sqsx1_wheat_f1r1));
                                ci=t_val_wheat_f1r1*res;
                                xmax=xmi+ci;
                                xmin=xmi-ci;
                                x_mi=max(wheat_f1r1_et)*(1-xmi);
                                x_max=max(wheat_f1r1_et)*(1-xmin);
                                x_min=max(wheat_f1r1_et)*(1-xmax);
                                R_mi(i,j)=x_mi;
                                R_max(i,j)=x_max;
                                R_min(i,j)=x_min;
                            end
                        end
                    end

                    for turn=1:3
                        if S(turn).Region_wz==2
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                               disp("region 2")
                                R_temp=1-R(i,j)/max(wheat_f1r2_yield);
                                if R(i,j)>sum(beta1_f3r2)
                                    xmi=-(R(i,j)-sum(beta1_f3r2))/(beta1_f1r2*max(wheat_f1r2_yield));
                                end
                                if R(i,j)<=sum(beta1_f3r2)
                                    x_wheat_r2=solve(y_wheat_r2==R(i,j));
                                    xmi=double(x_wheat_r2(2));
                                end
                                res=sqrt(MSE_x_wheat_f1r2*(1/length(wheat_f1r2_y)+(R_temp-mean(wheat_f1r2_y))^2/sqsx1_wheat_f1r2));
                                ci=t_val_wheat_f1r2*res;
                                xmax=xmi+ci;
                                xmin=xmi-ci;
                                x_mi=max(wheat_f1r2_et)*(1-xmi);
                                x_max=max(wheat_f1r2_et)*(1-xmin);
                                x_min=max(wheat_f1r2_et)*(1-xmax);
                                R_mi(i,j)=x_mi;
                                R_max(i,j)=x_max;
                                R_min(i,j)=x_min;
                            end
                        end
                    end

                    for turn=1:3
                        if S(turn).Region_wz==3
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                               disp("region 3")
                                R_temp=1-R(i,j)/max(wheat_f1r3_yield);
                                if R(i,j)>sum(beta1_f3r3)
                                    xmi=-(R(i,j)-sum(beta1_f3r3))/(beta1_f1r3*max(wheat_f1r3_yield));
                                end
                                if R(i,j)<=sum(beta1_f3r3)
                                    x_wheat_r3=solve(y_wheat_r3==R(i,j));
                                    xmi=double(x_wheat_r3(2));
                                end
                                res=sqrt(MSE_x_wheat_f1r3*(1/length(wheat_f1r3_y)+(R_temp-mean(wheat_f1r3_y))^2/sqsx1_wheat_f1r3));
                                ci=t_val_wheat_f1r3*res;
                                xmax=xmi+ci;
                                xmin=xmi-ci;
                                x_mi=max(wheat_f1r3_et)*(1-xmi);
                                x_max=max(wheat_f1r3_et)*(1-xmin);
                                x_min=max(wheat_f1r3_et)*(1-xmax);
                                R_mi(i,j)=x_mi;
                                R_max(i,j)=x_max;
                                R_min(i,j)=x_min;
                            end
                        end
                    end
                end
            end
        end
    end
end
%%
filename_water=strcat("D:\yellow river water comsumption\data\water comsumption\water_",str1(strnum1),"_",str3(strnum3),"_",str2(strnum2),"_0818.tif");
geotiffwrite(filename_water,R_mi,I,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag)
filename_water_max=strcat("D:\yellow river water comsumption\data\water comsumption\water_",str1(strnum1),"_",str3(strnum3),"_",str2(strnum2),"_max_0818.tif");
geotiffwrite(filename_water_max,R_max,I,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag)
filename_water_min=strcat("D:\yellow river water comsumption\data\water comsumption\water_",str1(strnum1),"_",str3(strnum3),"_",str2(strnum2),"_min_0818.tif");
geotiffwrite(filename_water_min,R_min,I,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag)
end
end
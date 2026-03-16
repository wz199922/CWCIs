clear
clc


filename="D:\yellow river water comsumption\yield_et_fit_new.xlsx";
excel_yield_et=readtable(filename);
alpha=0.1;
%%
str1={'maiz'};
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
filename_yellow_river_wheat_partitions="D:\yellow river water comsumption\data\shp\maize_cities_geo_66_0106.shp";
S=shaperead(filename_yellow_river_wheat_partitions);
Sinfo=shapeinfo(filename_yellow_river_wheat_partitions);
figure(1)
mapshow(S)
%%
%maize region1
wheat_f1r1_x=table2array(excel_yield_et(423:500,"x1_et_max"));
wheat_f1r1_y=table2array(excel_yield_et(423:500,"x1_yield_max"));
wheat_f1r1_yield=table2array(excel_yield_et(423:500,"yield"));
wheat_f1r1_et=table2array(excel_yield_et(423:500,"et"));

model_f1r1=@(k,wheat_f1r1_x) k*wheat_f1r1_x;
beta0=1;
[beta1_f1r1,resnorm]=lsqcurvefit(model_f1r1,beta0,wheat_f1r1_x,wheat_f1r1_y);

MSE=resnorm/length(wheat_f1r1_y);
MSE_x_wheat_f1r1=MSE/beta1_f1r1;
sqsx=[];
for i=1:length(wheat_f1r1_y)
    sqsx(i)=(wheat_f1r1_y(i)-mean(wheat_f1r1_y))^2;
end
sqsx1_wheat_f1r1=sum(sqsx);

t_val_wheat_f1r1=tinv(1-alpha/2,length(wheat_f1r1_y)-length(beta1_f1r1));

syms x_wheat_r1;
y_wheat_r1=beta1_f1r1*x_wheat_r1;
%%
%region2
wheat_f1r2_x=table2array(excel_yield_et(501:512,"x1_et_max"));
wheat_f1r2_y=table2array(excel_yield_et(501:512,"x1_yield_max"));
wheat_f1r2_yield=table2array(excel_yield_et(501:512,"yield"));
wheat_f1r2_et=table2array(excel_yield_et(501:512,"et"));

model_f1r2=@(k,wheat_f1r2_x) k*wheat_f1r2_x;
beta0=1;
[beta1_f1r2,resnorm]=lsqcurvefit(model_f1r2,beta0,wheat_f1r2_x,wheat_f1r2_y);

MSE=resnorm/length(wheat_f1r2_y);
MSE_x_wheat_f1r2=MSE/beta1_f1r2;
sqsx=[];
for i=1:length(wheat_f1r2_y)
    sqsx(i)=(wheat_f1r2_y(i)-mean(wheat_f1r2_y))^2;
end
sqsx1_wheat_f1r2=sum(sqsx);

t_val_wheat_f1r2=tinv(1-alpha/2,length(wheat_f1r2_y)-length(beta1_f1r2));

syms x_wheat_r2;
y_wheat_r2=beta1_f1r2*x_wheat_r2;
%%
%region3
wheat_f1r3_x=table2array(excel_yield_et(513:553,"x1_et_max"));
wheat_f1r3_y=table2array(excel_yield_et(513:553,"x1_yield_max"));
wheat_f1r3_yield=table2array(excel_yield_et(513:553,"yield"));
wheat_f1r3_et=table2array(excel_yield_et(513:553,"et"));

model_f1r3=@(k,wheat_f1r3_x) k*wheat_f1r3_x;
beta0=1;
[beta1_f1r3,resnorm]=lsqcurvefit(model_f1r3,beta0,wheat_f1r3_x,wheat_f1r3_y);

MSE=resnorm/length(wheat_f1r3_y);
MSE_x_wheat_f1r3=MSE/beta1_f1r3;
sqsx=[];
for i=1:length(wheat_f1r3_y)
    sqsx(i)=(wheat_f1r3_y(i)-mean(wheat_f1r3_y))^2;
end
sqsx1_wheat_f1r3=sum(sqsx);

t_val_wheat_f1r3=tinv(1-alpha/2,length(wheat_f1r3_y)-length(beta1_f1r3));

syms x_wheat_r3;
y_wheat_r3=beta1_f1r3*x_wheat_r3;
%%
%region4
wheat_f1r4_x=table2array(excel_yield_et(554:648,"x1_et_max"));
wheat_f1r4_y=table2array(excel_yield_et(554:648,"x1_yield_max"));
wheat_f1r4_yield=table2array(excel_yield_et(554:648,"yield"));
wheat_f1r4_et=table2array(excel_yield_et(554:648,"et"));

model_f1r4=@(k,wheat_f1r4_x) k*wheat_f1r4_x;
beta0=1;
[beta1_f1r4,resnorm]=lsqcurvefit(model_f1r4,beta0,wheat_f1r4_x,wheat_f1r4_y);

MSE=resnorm/length(wheat_f1r4_y);
MSE_x_wheat_f1r4=MSE/beta1_f1r4;
sqsx=[];
for i=1:length(wheat_f1r4_y)
    sqsx(i)=(wheat_f1r4_y(i)-mean(wheat_f1r4_y))^2;
end
sqsx1_wheat_f1r4=sum(sqsx);

t_val_wheat_f1r4=tinv(1-alpha/2,length(wheat_f1r4_y)-length(beta1_f1r4));

syms x_wheat_r4;
y_wheat_r4=beta1_f1r4*x_wheat_r4;
%%
%region5
wheat_f1r5_x=table2array(excel_yield_et(649:780,"x1_et_max"));
wheat_f1r5_y=table2array(excel_yield_et(649:780,"x1_yield_max"));
wheat_f1r5_yield=table2array(excel_yield_et(649:780,"yield"));
wheat_f1r5_et=table2array(excel_yield_et(649:780,"et"));

model_f1r5=@(k,wheat_f1r5_x) k*wheat_f1r5_x;
beta0=1;
[beta1_f1r5,resnorm]=lsqcurvefit(model_f1r5,beta0,wheat_f1r5_x,wheat_f1r5_y);

MSE=resnorm/length(wheat_f1r5_y);
MSE_x_wheat_f1r5=MSE/beta1_f1r5;
sqsx=[];
for i=1:length(wheat_f1r5_y)
    sqsx(i)=(wheat_f1r5_y(i)-mean(wheat_f1r5_y))^2;
end
sqsx1_wheat_f1r5=sum(sqsx);

t_val_wheat_f1r5=tinv(1-alpha/2,length(wheat_f1r5_y)-length(beta1_f1r5));

syms x_wheat_r5;
y_wheat_r5=beta1_f1r5*x_wheat_r5;
%%
%region6
wheat_f3r6_x=table2array(excel_yield_et(781:793,"x1_et_max"));
wheat_f3r6_y=table2array(excel_yield_et(781:793,"yield"));
wheat_f3r6_yield=table2array(excel_yield_et(781:793,"yield"));
wheat_f3r6_et=table2array(excel_yield_et(781:793,"et"));

model_f3r6=@(b,wheat_f3r6_x) b(1)+b(2)*(1-wheat_f3r6_x.*wheat_f3r6_x);
beta0=[0,0];
[beta1_f3r6,~]=lsqcurvefit(model_f3r6,beta0,wheat_f3r6_x,wheat_f3r6_y);

wheat_f1r6_x=table2array(excel_yield_et(781:793,"x1_et_max"));
wheat_f1r6_y=table2array(excel_yield_et(781:793,"x1_yield_max"));
wheat_f1r6_yield=table2array(excel_yield_et(781:793,"yield"));
wheat_f1r6_et=table2array(excel_yield_et(781:793,"et"));

model_f1r6=@(k,wheat_f1r6_x) k*wheat_f1r6_x;
beta0=1;
[beta1_f1r6,resnorm]=lsqcurvefit(model_f1r6,beta0,wheat_f1r6_x,wheat_f1r6_y);

MSE=resnorm/length(wheat_f1r6_x);
MSE_x_wheat_f1r6=MSE/beta1_f1r6;
sqsx=[];
for i=1:length(wheat_f1r6_y)
    sqsx(i)=(wheat_f1r6_y(i)-mean(wheat_f1r6_y))^2;
end
sqsx1_wheat_f1r6=sum(sqsx);

t_val_wheat_f1r6=tinv(1-alpha/2,length(wheat_f1r6_y)-length(beta1_f1r6));

syms x_wheat_r6;
y_wheat_r6=beta1_f3r6(1)+beta1_f3r6(2)*(1-x_wheat_r6.*x_wheat_r6);
%%
%region7
wheat_f1r7_x=table2array(excel_yield_et(794:885,"x1_et_max"));
wheat_f1r7_y=table2array(excel_yield_et(794:885,"x1_yield_max"));
wheat_f1r7_yield=table2array(excel_yield_et(794:885,"yield"));
wheat_f1r7_et=table2array(excel_yield_et(794:885,"et"));

model_f1r7=@(k,wheat_f1r7_x) k*wheat_f1r7_x;
beta0=1;
[beta1_f1r7,resnorm]=lsqcurvefit(model_f1r7,beta0,wheat_f1r7_x,wheat_f1r7_y);

MSE=resnorm/length(wheat_f1r7_y);
MSE_x_wheat_f1r7=MSE/beta1_f1r7;
sqsx=[];
for i=1:length(wheat_f1r7_y)
    sqsx(i)=(wheat_f1r7_y(i)-mean(wheat_f1r7_y))^2;
end
sqsx1_wheat_f1r7=sum(sqsx);

t_val_wheat_f1r7=tinv(1-alpha/2,length(wheat_f1r7_y)-length(beta1_f1r7));

syms x_wheat_r7;
y_wheat_r7=beta1_f1r7*x_wheat_r7;
%%
%region8
wheat_f1r8_x=table2array(excel_yield_et(886:892,"x1_et_max"));
wheat_f1r8_y=table2array(excel_yield_et(886:892,"x1_yield_max"));
wheat_f1r8_yield=table2array(excel_yield_et(886:892,"yield"));
wheat_f1r8_et=table2array(excel_yield_et(886:892,"et"));

model_f1r8=@(k,wheat_f1r8_x) k*wheat_f1r8_x;
beta0=1;
[beta1_f1r8,resnorm]=lsqcurvefit(model_f1r8,beta0,wheat_f1r8_x,wheat_f1r8_y);

MSE=resnorm/length(wheat_f1r8_y);
MSE_x_wheat_f1r8=MSE/beta1_f1r8;
sqsx=[];
for i=1:length(wheat_f1r8_y)
    sqsx(i)=(wheat_f1r8_y(i)-mean(wheat_f1r8_y))^2;
end
sqsx1_wheat_f1r8=sum(sqsx);

t_val_wheat_f1r8=tinv(1-alpha/2,length(wheat_f1r8_y)-length(beta1_f1r8));

syms x_wheat_r8;
y_wheat_r8=beta1_f1r8*x_wheat_r8;
%%
%region9
wheat_f3r9_x=table2array(excel_yield_et(893:916,"x1_et_max"));
wheat_f3r9_y=table2array(excel_yield_et(893:916,"yield"));
wheat_f3r9_yield=table2array(excel_yield_et(893:916,"yield"));
wheat_f3r9_et=table2array(excel_yield_et(893:916,"et"));

model_f3r9=@(b,wheat_f3r9_x) b(1)+b(2)*(1-wheat_f3r9_x.*wheat_f3r9_x);
beta0=[0,0];
[beta1_f3r9,~]=lsqcurvefit(model_f3r9,beta0,wheat_f3r9_x,wheat_f3r9_y);

wheat_f1r9_x=table2array(excel_yield_et(893:916,"x1_et_max"));
wheat_f1r9_y=table2array(excel_yield_et(893:916,"x1_yield_max"));
wheat_f1r9_yield=table2array(excel_yield_et(893:916,"yield"));
wheat_f1r9_et=table2array(excel_yield_et(893:916,"et"));

model_f1r9=@(k,wheat_f1r9_x) k*wheat_f1r9_x;
beta0=1;
[beta1_f1r9,resnorm]=lsqcurvefit(model_f1r9,beta0,wheat_f1r9_x,wheat_f1r9_y);

MSE=resnorm/length(wheat_f1r9_x);
MSE_x_wheat_f1r9=MSE/beta1_f1r9;
sqsx=[];
for i=1:length(wheat_f1r9_y)
    sqsx(i)=(wheat_f1r9_y(i)-mean(wheat_f1r9_y))^2;
end
sqsx1_wheat_f1r9=sum(sqsx);

t_val_wheat_f1r9=tinv(1-alpha/2,length(wheat_f1r9_y)-length(beta1_f1r9));

syms x_wheat_r9;
y_wheat_r9=beta1_f3r9(1)+beta1_f3r9(2)*(1-x_wheat_r9.*x_wheat_r9);
%%
%region10
wheat_f1r10_x=table2array(excel_yield_et(917:926,"x1_et_max"));
wheat_f1r10_y=table2array(excel_yield_et(917:926,"x1_yield_max"));
wheat_f1r10_yield=table2array(excel_yield_et(917:926,"yield"));
wheat_f1r10_et=table2array(excel_yield_et(917:926,"et"));

model_f1r10=@(k,wheat_f1r10_x) k*wheat_f1r10_x;
beta0=1;
[beta1_f1r10,resnorm]=lsqcurvefit(model_f1r10,beta0,wheat_f1r10_x,wheat_f1r10_y);

MSE=resnorm/length(wheat_f1r10_y);
MSE_x_wheat_f1r10=MSE/beta1_f1r10;
sqsx=[];
for i=1:length(wheat_f1r10_y)
    sqsx(i)=(wheat_f1r10_y(i)-mean(wheat_f1r10_y))^2;
end
sqsx1_wheat_f1r10=sum(sqsx);

t_val_wheat_f1r10=tinv(1-alpha/2,length(wheat_f1r10_y)-length(beta1_f1r10));

%解方程
syms x_wheat_r10;
y_wheat_r10=beta1_f1r10*x_wheat_r10;
%%
%region12
wheat_f1r12_x=table2array(excel_yield_et(927:944,"x1_et_max"));
wheat_f1r12_y=table2array(excel_yield_et(927:944,"x1_yield_max"));
wheat_f1r12_yield=table2array(excel_yield_et(927:944,"yield"));
wheat_f1r12_et=table2array(excel_yield_et(927:944,"et"));
model_f1r12=@(k,wheat_f1r12_x) k*wheat_f1r12_x;
beta0=1;
[beta1_f1r12,resnorm]=lsqcurvefit(model_f1r12,beta0,wheat_f1r12_x,wheat_f1r12_y);

MSE=resnorm/length(wheat_f1r12_y);
MSE_x_wheat_f1r12=MSE/beta1_f1r12;
sqsx=[];
for i=1:length(wheat_f1r12_y)
    sqsx(i)=(wheat_f1r12_y(i)-mean(wheat_f1r12_y))^2;
end
sqsx1_wheat_f1r12=sum(sqsx);

t_val_wheat_f1r12=tinv(1-alpha/2,length(wheat_f1r12_y)-length(beta1_f1r12));

syms x_wheat_r12;
y_wheat_r12=beta1_f1r12*x_wheat_r12;
%%
%region13
wheat_f1r13_x=table2array(excel_yield_et(945:959,"x1_et_max"));
wheat_f1r13_y=table2array(excel_yield_et(945:959,"x1_yield_max"));
wheat_f1r13_yield=table2array(excel_yield_et(945:959,"yield"));
wheat_f1r13_et=table2array(excel_yield_et(945:959,"et"));
model_f1r13=@(k,wheat_f1r13_x) k*wheat_f1r13_x;
beta0=1;
[beta1_f1r13,resnorm]=lsqcurvefit(model_f1r13,beta0,wheat_f1r13_x,wheat_f1r13_y);

MSE=resnorm/length(wheat_f1r13_y);
MSE_x_wheat_f1r13=MSE/beta1_f1r13;
sqsx=[];
for i=1:length(wheat_f1r13_y)
    sqsx(i)=(wheat_f1r13_y(i)-mean(wheat_f1r13_y))^2;
end
sqsx1_wheat_f1r13=sum(sqsx);

t_val_wheat_f1r13=tinv(1-alpha/2,length(wheat_f1r13_y)-length(beta1_f1r13));

syms x_wheat_r13;
y_wheat_r13=beta1_f1r13*x_wheat_r13;
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
                    for turn=1:12
                        if S(turn).Region_wz==1
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                                disp("region 1")
                                R_temp=1-R(i,j)/max(wheat_f1r1_yield);
                                x_wheat_r1=solve(y_wheat_r1==R_temp);
                                res=sqrt(MSE_x_wheat_f1r1*(1/length(wheat_f1r1_y)+(R_temp-mean(wheat_f1r1_y))^2/sqsx1_wheat_f1r1));
                                ci=t_val_wheat_f1r1*res;
                                xmi=double(x_wheat_r1);
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

                    for turn=1:12
                        if S(turn).Region_wz==2
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                                disp("region 2")
                                R_temp=1-R(i,j)/max(wheat_f1r2_yield);
                                x_wheat_r2=solve(y_wheat_r2==R_temp);
                                res=sqrt(MSE_x_wheat_f1r2*(1/length(wheat_f1r2_y)+(R_temp-mean(wheat_f1r2_y))^2/sqsx1_wheat_f1r2));
                                ci=t_val_wheat_f1r2*res;
                                xmi=double(x_wheat_r2);
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

                    for turn=1:12
                        if S(turn).Region_wz==3
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                                disp("region 3")
                                R_temp=1-R(i,j)/max(wheat_f1r3_yield);
                                x_wheat_r3=solve(y_wheat_r3==R_temp);
                                res=sqrt(MSE_x_wheat_f1r3*(1/length(wheat_f1r3_y)+(R_temp-mean(wheat_f1r3_y))^2/sqsx1_wheat_f1r3));
                                ci=t_val_wheat_f1r3*res;
                                xmi=double(x_wheat_r3);
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

                    for turn=1:12
                        if S(turn).Region_wz==4
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                                disp("region 4")
                                R_temp=1-R(i,j)/max(wheat_f1r4_yield);
                                x_wheat_r4=solve(y_wheat_r4==R_temp);
                                res=sqrt(MSE_x_wheat_f1r4*(1/length(wheat_f1r4_y)+(R_temp-mean(wheat_f1r4_y))^2/sqsx1_wheat_f1r4));
                                ci=t_val_wheat_f1r4*res;
                                xmi=double(x_wheat_r4);
                                xmax=xmi+ci;
                                xmin=xmi-ci;
                                x_mi=max(wheat_f1r4_et)*(1-xmi);
                                x_max=max(wheat_f1r4_et)*(1-xmin);
                                x_min=max(wheat_f1r4_et)*(1-xmax);
                                R_mi(i,j)=x_mi;
                                R_max(i,j)=x_max;
                                R_min(i,j)=x_min;
                            end
                        end
                    end

                    for turn=1:12
                        if S(turn).Region_wz==5
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                                disp("region 5")
                                R_temp=1-R(i,j)/max(wheat_f1r5_yield);
                                x_wheat_r5=solve(y_wheat_r5==R_temp);
                                res=sqrt(MSE_x_wheat_f1r5*(1/length(wheat_f1r5_y)+(R_temp-mean(wheat_f1r5_y))^2/sqsx1_wheat_f1r5));
                                ci=t_val_wheat_f1r5*res;
                                xmi=double(x_wheat_r5);
                                xmax=xmi+ci;
                                xmin=xmi-ci;
                                x_mi=max(wheat_f1r5_et)*(1-xmi);
                                x_max=max(wheat_f1r5_et)*(1-xmin);
                                x_min=max(wheat_f1r5_et)*(1-xmax);
                                R_mi(i,j)=x_mi;
                                R_max(i,j)=x_max;
                                R_min(i,j)=x_min;
                            end
                        end
                    end

                    for turn=1:12
                        if S(turn).Region_wz==6
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                                disp("region 6")
                                R_temp=1-R(i,j)/max(wheat_f1r6_yield);
                                if R(i,j)>sum(beta1_f3r6)
                                    xmi=-(R(i,j)-sum(beta1_f3r6))/(beta1_f1r6*max(wheat_f1r6_yield));
                                end
                                if R(i,j)<=sum(beta1_f3r6)
                                    x_wheat_r6=solve(y_wheat_r6==R(i,j));
                                    xmi=double(x_wheat_r6(2));
                                end
                                res=sqrt(MSE_x_wheat_f1r6*(1/length(wheat_f1r6_y)+(R_temp-mean(wheat_f1r6_y))^2/sqsx1_wheat_f1r6));
                                ci=t_val_wheat_f1r6*res;
                                xmax=xmi+ci;
                                xmin=xmi-ci;
                                x_mi=max(wheat_f1r6_et)*(1-xmi);
                                x_max=max(wheat_f1r6_et)*(1-xmin);
                                x_min=max(wheat_f1r6_et)*(1-xmax);
                                R_mi(i,j)=x_mi;
                                R_max(i,j)=x_max;
                                R_min(i,j)=x_min;
                            end
                        end
                    end

                    for turn=1:12
                        if S(turn).Region_wz==7
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                                disp("region 7")
                                R_temp=1-R(i,j)/max(wheat_f1r7_yield);
                                x_wheat_r7=solve(y_wheat_r7==R_temp);
                                res=sqrt(MSE_x_wheat_f1r7*(1/length(wheat_f1r7_y)+(R_temp-mean(wheat_f1r7_y))^2/sqsx1_wheat_f1r7));
                                ci=t_val_wheat_f1r7*res;
                                xmi=double(x_wheat_r7);
                                xmax=xmi+ci;
                                xmin=xmi-ci;
                                x_mi=max(wheat_f1r7_et)*(1-xmi);
                                x_max=max(wheat_f1r7_et)*(1-xmin);
                                x_min=max(wheat_f1r7_et)*(1-xmax);
                                R_mi(i,j)=x_mi;
                                R_max(i,j)=x_max;
                                R_min(i,j)=x_min;
                            end
                        end
                    end

                    for turn=1:12
                        if S(turn).Region_wz==8
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                                disp("region 8")
                                R_temp=1-R(i,j)/max(wheat_f1r8_yield);
                                x_wheat_r8=solve(y_wheat_r8==R_temp);
                                res=sqrt(MSE_x_wheat_f1r8*(1/length(wheat_f1r8_y)+(R_temp-mean(wheat_f1r8_y))^2/sqsx1_wheat_f1r8));
                                ci=t_val_wheat_f1r8*res;
                                xmi=double(x_wheat_r8);
                                xmax=xmi+ci;
                                xmin=xmi-ci;
                                x_mi=max(wheat_f1r8_et)*(1-xmi);
                                x_max=max(wheat_f1r8_et)*(1-xmin);
                                x_min=max(wheat_f1r8_et)*(1-xmax);
                                R_mi(i,j)=x_mi;
                                R_max(i,j)=x_max;
                                R_min(i,j)=x_min;
                            end
                        end
                    end

                    for turn=1:12
                        if S(turn).Region_wz==9
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                                disp("region 9")
                                R_temp=1-R(i,j)/max(wheat_f1r9_yield);
                                if R(i,j)>sum(beta1_f3r9)
                                    xmi=-(R(i,j)-sum(beta1_f3r9))/(beta1_f1r9*max(wheat_f1r9_yield));
                                end
                                if R(i,j)<=sum(beta1_f3r9)
                                    x_wheat_r9=solve(y_wheat_r9==R(i,j));
                                    xmi=double(x_wheat_r9(2));
                                end
                                res=sqrt(MSE_x_wheat_f1r9*(1/length(wheat_f1r9_y)+(R_temp-mean(wheat_f1r9_y))^2/sqsx1_wheat_f1r9));
                                ci=t_val_wheat_f1r9*res;
                                xmax=xmi+ci;
                                xmin=xmi-ci;
                                x_mi=max(wheat_f1r9_et)*(1-xmi);
                                x_max=max(wheat_f1r9_et)*(1-xmin);
                                x_min=max(wheat_f1r9_et)*(1-xmax);
                                R_mi(i,j)=x_mi;
                                R_max(i,j)=x_max;
                                R_min(i,j)=x_min;
                            end
                        end
                    end

                    for turn=1:12
                        if S(turn).Region_wz==10
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                                disp("region 10")
                                R_temp=1-R(i,j)/max(wheat_f1r10_yield);
                                x_wheat_r10=solve(y_wheat_r10==R_temp);
                                res=sqrt(MSE_x_wheat_f1r10*(1/length(wheat_f1r10_y)+(R_temp-mean(wheat_f1r10_y))^2/sqsx1_wheat_f1r10));
                                ci=t_val_wheat_f1r10*res;
                                xmi=double(x_wheat_r10);
                                xmax=xmi+ci;
                                xmin=xmi-ci;
                                x_mi=max(wheat_f1r10_et)*(1-xmi);
                                x_max=max(wheat_f1r10_et)*(1-xmin);
                                x_min=max(wheat_f1r10_et)*(1-xmax);
                                R_mi(i,j)=x_mi;
                                R_max(i,j)=x_max;
                                R_min(i,j)=x_min;
                            end
                        end
                    end

                    for turn=1:12
                        if S(turn).Region_wz==11
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                                disp("region 11")
                                R_temp=1-R(i,j)/max(wheat_f1r12_yield);
                                x_wheat_r12=solve(y_wheat_r12==R_temp);
                                res=sqrt(MSE_x_wheat_f1r12*(1/length(wheat_f1r12_y)+(R_temp-mean(wheat_f1r12_y))^2/sqsx1_wheat_f1r12));
                                ci=t_val_wheat_f1r12*res;
                                xmi=double(x_wheat_r12);
                                xmax=xmi+ci;
                                xmin=xmi-ci;
                                x_mi=max(wheat_f1r12_et)*(1-xmi);
                                x_max=max(wheat_f1r12_et)*(1-xmin);
                                x_min=max(wheat_f1r12_et)*(1-xmax);
                                R_mi(i,j)=x_mi;
                                R_max(i,j)=x_max;
                                R_min(i,j)=x_min;
                            end
                        end
                    end

                    for turn=1:12
                        if S(turn).Region_wz==12
                            [in,on]=inpolygon(lon(j),lat(i),S(turn).X,S(turn).Y);
                            if in+on>0
                                disp("region 12")
                                R_temp=1-R(i,j)/max(wheat_f1r13_yield);
                                x_wheat_r13=solve(y_wheat_r13==R_temp);
                                res=sqrt(MSE_x_wheat_f1r13*(1/length(wheat_f1r13_y)+(R_temp-mean(wheat_f1r13_y))^2/sqsx1_wheat_f1r13));
                                ci=t_val_wheat_f1r13*res;
                                xmi=double(x_wheat_r13);
                                xmax=xmi+ci;
                                xmin=xmi-ci;
                                x_mi=max(wheat_f1r13_et)*(1-xmi);
                                x_max=max(wheat_f1r13_et)*(1-xmin);
                                x_min=max(wheat_f1r13_et)*(1-xmax);
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
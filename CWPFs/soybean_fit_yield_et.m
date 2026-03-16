clear
clc
filename="D:\yellow river water comsumption\yield_et_fit_new.xlsx";
excel_yield_et=readtable(filename);
%%
%soybean CWPF1 region1
wheat_f1r1_x=table2array(excel_yield_et(960:967,"x1_et_max"));
wheat_f1r1_y=table2array(excel_yield_et(960:967,"x1_yield_max"));
wheat_f1r1_yield=table2array(excel_yield_et(960:967,"yield"));
wheat_f1r1_et=table2array(excel_yield_et(960:967,"et"));

model_f1r1=@(k,wheat_f1r1_x) k*wheat_f1r1_x;

beta0=1;

[beta1_f1r1,resnorm]=lsqcurvefit(model_f1r1,beta0,wheat_f1r1_x,wheat_f1r1_y);

wheat_f1r1_yfit=model_f1r1(beta1_f1r1,wheat_f1r1_x);
wheat_f1r1_yfit1=max(wheat_f1r1_yield)*(1-wheat_f1r1_yfit);

%figure
figure(1)
plot(wheat_f1r1_et,wheat_f1r1_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r1_et,wheat_f1r1_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','--')

axis1=380;
axis2=480;
axis3=min(wheat_f1r1_yield)-500;
axis4=max(wheat_f1r1_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Soybean Sub-region 3",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r1_y-wheat_f1r1_yfit).^2);
SStotal=sum((wheat_f1r1_y-mean(wheat_f1r1_y)).^2);
R2_f1r1=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r1_yield-wheat_f1r1_yfit1).^2);
RMSE_f1r1=(SSresid1/size(wheat_f1r1_yield,1))^0.5;
nRMSE_f1r1=RMSE_f1r1/(mean(wheat_f1r1_yield));
%%
wheat_f2r1_x=table2array(excel_yield_et(960:967,"et_max"));
wheat_f2r1_y=table2array(excel_yield_et(960:967,"yield_max"));
wheat_f2r1_yield=table2array(excel_yield_et(960:967,"yield"));
wheat_f2r1_et=table2array(excel_yield_et(960:967,"et"));

wheat_f2r1_yfit=wheat_f2r1_x;
wheat_f2r1_yfit1=max(wheat_f2r1_yield)*wheat_f2r1_yfit;

xy=[wheat_f2r1_et,wheat_f2r1_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[226/255,83/255,61/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f2r1_y-wheat_f2r1_yfit).^2);
SStotal=sum((wheat_f2r1_y-mean(wheat_f2r1_y)).^2);
R2_f2r1=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f2r1_yield-wheat_f2r1_yfit1).^2);
RMSE_f2r1=(SSresid1/size(wheat_f2r1_yield,1))^0.5;
nRMSE_f2r1=RMSE_f2r1/(mean(wheat_f2r1_yield));
%%
wheat_f3r1_x=table2array(excel_yield_et(960:967,"x1_et_max"));
wheat_f3r1_y=table2array(excel_yield_et(960:967,"yield"));
wheat_f3r1_yield=table2array(excel_yield_et(960:967,"yield"));
wheat_f3r1_et=table2array(excel_yield_et(960:967,"et"));

model_f3r1=@(b,wheat_f3r1_x) b(1)+b(2)*(1-wheat_f3r1_x.*wheat_f3r1_x);

beta0=[0,0];

[beta1_f3r1,resnorm]=lsqcurvefit(model_f3r1,beta0,wheat_f3r1_x,wheat_f3r1_y);

wheat_f3r1_yfit=model_f3r1(beta1_f3r1,wheat_f3r1_x);
wheat_f3r1_yfit1=wheat_f3r1_yfit;

xy=[wheat_f3r1_et,wheat_f3r1_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[249/255,228/255,169/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f3r1_y-wheat_f3r1_yfit).^2);
SStotal=sum((wheat_f3r1_y-mean(wheat_f3r1_y)).^2);
R2_f3r1=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r1_yield-wheat_f3r1_yfit1).^2);
RMSE_f3r1=(SSresid1/size(wheat_f3r1_yield,1))^0.5;
nRMSE_f3r1=RMSE_f3r1/(mean(wheat_f3r1_yield));
%%
wheat_f4r1_yield=table2array(excel_yield_et(960:967,"yield"));
wheat_f4r1_et=table2array(excel_yield_et(960:967,"et"));

xx=wheat_f4r1_et;
yy=wheat_f4r1_yield;

maxyield=max(wheat_f4r1_yield);
et50_r1=(max(wheat_f4r1_et)/2);

model_f4r1=@(k,wheat_f4r1_et) maxyield*((wheat_f4r1_et.^k)./((et50_r1.^k)+(wheat_f4r1_et.^k)));

beta0=1;
[beta1_f4r1,resnorm]=lsqcurvefit(model_f4r1,beta0,wheat_f4r1_et,wheat_f4r1_yield);

wheat_f4r1_yfit=model_f4r1(beta1_f4r1,wheat_f4r1_et);

xy=[wheat_f4r1_et,wheat_f4r1_yfit];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[178/255,223/255,227/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f4r1_yield-wheat_f4r1_yfit).^2);
SStotal=sum((wheat_f4r1_yield-mean(wheat_f4r1_yield)).^2);
R2_f4r1=1-(SSresid/SStotal);


%RMSE
RMSE_f4r1=(SSresid/size(wheat_f4r1_yield,1))^0.5;
nRMSE_f4r1=RMSE_f4r1/(mean(wheat_f4r1_yield));
%%
wheat_f5r1_x=table2array(excel_yield_et(960:967,"x1_et_max"));
wheat_f5r1_y=table2array(excel_yield_et(960:967,"x1_yield_max"));
wheat_f5r1_yield=table2array(excel_yield_et(960:967,"yield"));
wheat_f5r1_et=table2array(excel_yield_et(960:967,"et"));

model_f5r1=@(k,wheat_f5r1_x) k*(wheat_f5r1_x.*wheat_f5r1_x);

beta0=1;

[beta1_f5r1,resnorm]=lsqcurvefit(model_f5r1,beta0,wheat_f5r1_x,wheat_f5r1_y);
c1=max(wheat_f5r1_et)*max(wheat_f5r1_et);
c2_r1=(beta1_f5r1*max(wheat_f5r1_yield))/c1;
wheat_f5r1_yfit=model_f5r1(beta1_f5r1,wheat_f5r1_x);
wheat_f5r1_yfit1=max(wheat_f5r1_yield)*(1-wheat_f5r1_yfit);

xy=[wheat_f5r1_et,wheat_f5r1_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[69/255,156/255,215/255],'LineWidth',1,'LineStyle','--')
hold off

%R2
SSresid=sum((wheat_f5r1_y-wheat_f5r1_yfit).^2);
SStotal=sum((wheat_f5r1_y-mean(wheat_f5r1_y)).^2);
R2_f5r1=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f5r1_yield-wheat_f5r1_yfit1).^2);
RMSE_f5r1=(SSresid1/size(wheat_f5r1_yield,1))^0.5;
nRMSE_f5r1=RMSE_f5r1/(mean(wheat_f5r1_yield));

%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\soybean_r1_0304';
print(figure(1),filepath_save,'-dpng','-r1000')
print(figure(1),filepath_save,'-djpeg','-r1000')

%%
%region2
wheat_f1r2_x=table2array(excel_yield_et(968:974,"x1_et_max"));
wheat_f1r2_y=table2array(excel_yield_et(968:974,"x1_yield_max"));
wheat_f1r2_yield=table2array(excel_yield_et(968:974,"yield"));
wheat_f1r2_et=table2array(excel_yield_et(968:974,"et"));

model_f1r2=@(k,wheat_f1r2_x) k*wheat_f1r2_x;

beta0=1;

[beta1_f1r2,resnorm]=lsqcurvefit(model_f1r2,beta0,wheat_f1r2_x,wheat_f1r2_y);

wheat_f1r2_yfit=model_f1r2(beta1_f1r2,wheat_f1r2_x);
wheat_f1r2_yfit1=max(wheat_f1r2_yield)*(1-wheat_f1r2_yfit);

%figure
figure(2)
plot(wheat_f1r2_et,wheat_f1r2_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f1r2_et,wheat_f1r2_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','--')

axis1=330;
axis2=380;
axis3=min(wheat_f1r2_yield)-500;
axis4=max(wheat_f1r2_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Soybean Sub-region 1",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r2_y-wheat_f1r2_yfit).^2);
SStotal=sum((wheat_f1r2_y-mean(wheat_f1r2_y)).^2);
R2_f1r2=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r2_yield-wheat_f1r2_yfit1).^2);
RMSE_f1r2=(SSresid1/size(wheat_f1r2_yield,1))^0.5;
nRMSE_f1r2=RMSE_f1r2/(mean(wheat_f1r2_yield));
%%
wheat_f2r2_x=table2array(excel_yield_et(968:974,"et_max"));
wheat_f2r2_y=table2array(excel_yield_et(968:974,"yield_max"));
wheat_f2r2_yield=table2array(excel_yield_et(968:974,"yield"));
wheat_f2r2_et=table2array(excel_yield_et(968:974,"et"));

wheat_f2r2_yfit=wheat_f2r2_x;
wheat_f2r2_yfit1=max(wheat_f2r2_yield)*wheat_f2r2_yfit;

xy=[wheat_f2r2_et,wheat_f2r2_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[226/255,83/255,61/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f2r2_y-wheat_f2r2_yfit).^2);
SStotal=sum((wheat_f2r2_y-mean(wheat_f2r2_y)).^2);
R2_f2r2=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f2r2_yield-wheat_f2r2_yfit1).^2);
RMSE_f2r2=(SSresid1/size(wheat_f2r2_yield,1))^0.5;
nRMSE_f2r2=RMSE_f2r2/(mean(wheat_f2r2_yield));
%%
wheat_f3r2_x=table2array(excel_yield_et(968:974,"x1_et_max"));
wheat_f3r2_y=table2array(excel_yield_et(968:974,"yield"));
wheat_f3r2_yield=table2array(excel_yield_et(968:974,"yield"));
wheat_f3r2_et=table2array(excel_yield_et(968:974,"et"));

model_f3r2=@(b,wheat_f3r2_x) b(1)+b(2)*(1-wheat_f3r2_x.*wheat_f3r2_x);

beta0=[0,0];

[beta1_f3r2,resnorm]=lsqcurvefit(model_f3r2,beta0,wheat_f3r2_x,wheat_f3r2_y);

wheat_f3r2_yfit=model_f3r2(beta1_f3r2,wheat_f3r2_x);
wheat_f3r2_yfit1=wheat_f3r2_yfit;

xy=[wheat_f3r2_et,wheat_f3r2_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[249/255,228/255,169/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f3r2_y-wheat_f3r2_yfit).^2);
SStotal=sum((wheat_f3r2_y-mean(wheat_f3r2_y)).^2);
R2_f3r2=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r2_yield-wheat_f3r2_yfit1).^2);
RMSE_f3r2=(SSresid1/size(wheat_f3r2_yield,1))^0.5;
nRMSE_f3r2=RMSE_f3r2/(mean(wheat_f3r2_yield));
%%
wheat_f4r2_yield=table2array(excel_yield_et(968:974,"yield"));
wheat_f4r2_et=table2array(excel_yield_et(968:974,"et"));

xx=wheat_f4r2_et;
yy=wheat_f4r2_yield;

maxyield=max(wheat_f4r2_yield);
et50_r2=(max(wheat_f4r2_et)/2);

model_f4r2=@(k,wheat_f4r2_et) maxyield*((wheat_f4r2_et.^k)./((et50_r2.^k)+(wheat_f4r2_et.^k)));

beta0=1;
[beta1_f4r2,resnorm]=lsqcurvefit(model_f4r2,beta0,wheat_f4r2_et,wheat_f4r2_yield);

wheat_f4r2_yfit=model_f4r2(beta1_f4r2,wheat_f4r2_et);

xy=[wheat_f4r2_et,wheat_f4r2_yfit];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[178/255,223/255,227/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f4r2_yield-wheat_f4r2_yfit).^2);
SStotal=sum((wheat_f4r2_yield-mean(wheat_f4r2_yield)).^2);
R2_f4r2=1-(SSresid/SStotal);


%RMSE
RMSE_f4r2=(SSresid/size(wheat_f4r2_yield,1))^0.5;
nRMSE_f4r2=RMSE_f4r2/(mean(wheat_f4r2_yield));
%%
wheat_f5r2_x=table2array(excel_yield_et(968:974,"x1_et_max"));
wheat_f5r2_y=table2array(excel_yield_et(968:974,"x1_yield_max"));
wheat_f5r2_yield=table2array(excel_yield_et(968:974,"yield"));
wheat_f5r2_et=table2array(excel_yield_et(968:974,"et"));

model_f5r2=@(k,wheat_f5r2_x) k*(wheat_f5r2_x.*wheat_f5r2_x);

beta0=1;

[beta1_f5r2,resnorm]=lsqcurvefit(model_f5r2,beta0,wheat_f5r2_x,wheat_f5r2_y);
c1=max(wheat_f5r2_et)*max(wheat_f5r2_et);
c2_r2=(beta1_f5r2*max(wheat_f5r2_yield))/c1;
wheat_f5r2_yfit=model_f5r2(beta1_f5r2,wheat_f5r2_x);
wheat_f5r2_yfit1=max(wheat_f5r2_yield)*(1-wheat_f5r2_yfit);

xy=[wheat_f5r2_et,wheat_f5r2_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[69/255,156/255,215/255],'LineWidth',1,'LineStyle','--')
hold off
%R2
SSresid=sum((wheat_f5r2_y-wheat_f5r2_yfit).^2);
SStotal=sum((wheat_f5r2_y-mean(wheat_f5r2_y)).^2);
R2_f5r2=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f5r2_yield-wheat_f5r2_yfit1).^2);
RMSE_f5r2=(SSresid1/size(wheat_f5r2_yield,1))^0.5;
nRMSE_f5r2=RMSE_f5r2/(mean(wheat_f5r2_yield));

%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\soybean_r2_0304';
print(figure(2),filepath_save,'-dpng','-r1000')
print(figure(2),filepath_save,'-djpeg','-r1000')

%%
wheat_f1r3_x=table2array(excel_yield_et(975:1017,"x1_et_max"));
wheat_f1r3_y=table2array(excel_yield_et(975:1017,"x1_yield_max"));
wheat_f1r3_yield=table2array(excel_yield_et(975:1017,"yield"));
wheat_f1r3_et=table2array(excel_yield_et(975:1017,"et"));

model_f1r3=@(k,wheat_f1r3_x) k*wheat_f1r3_x;

beta0=1;

[beta1_f1r3,resnorm]=lsqcurvefit(model_f1r3,beta0,wheat_f1r3_x,wheat_f1r3_y);

wheat_f1r3_yfit=model_f1r3(beta1_f1r3,wheat_f1r3_x);
wheat_f1r3_yfit1=max(wheat_f1r3_yield)*(1-wheat_f1r3_yfit);

%figure
figure(3)
plot(wheat_f1r3_et,wheat_f1r3_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f1r3_et,wheat_f1r3_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r3_et)-100;
axis2=max(wheat_f1r3_et)+100;
axis3=min(wheat_f1r3_yield)-500;
axis4=max(wheat_f1r3_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Soybean Sub-region 2",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r3_y-wheat_f1r3_yfit).^2);
SStotal=sum((wheat_f1r3_y-mean(wheat_f1r3_y)).^2);
R2_f1r3=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r3_yield-wheat_f1r3_yfit1).^2);
RMSE_f1r3=(SSresid1/size(wheat_f1r3_yield,1))^0.5;
nRMSE_f1r3=RMSE_f1r3/(mean(wheat_f1r3_yield));
%%
wheat_f2r3_x=table2array(excel_yield_et(975:1017,"et_max"));
wheat_f2r3_y=table2array(excel_yield_et(975:1017,"yield_max"));
wheat_f2r3_yield=table2array(excel_yield_et(975:1017,"yield"));
wheat_f2r3_et=table2array(excel_yield_et(975:1017,"et"));

wheat_f2r3_yfit=wheat_f2r3_x;
wheat_f2r3_yfit1=max(wheat_f2r3_yield)*wheat_f2r3_yfit;

xy=[wheat_f2r3_et,wheat_f2r3_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[226/255,83/255,61/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f2r3_y-wheat_f2r3_yfit).^2);
SStotal=sum((wheat_f2r3_y-mean(wheat_f2r3_y)).^2);
R2_f2r3=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f2r3_yield-wheat_f2r3_yfit1).^2);
RMSE_f2r3=(SSresid1/size(wheat_f2r3_yield,1))^0.5;
nRMSE_f2r3=RMSE_f2r3/(mean(wheat_f2r3_yield));
%%
wheat_f3r3_x=table2array(excel_yield_et(975:1017,"x1_et_max"));
wheat_f3r3_y=table2array(excel_yield_et(975:1017,"yield"));
wheat_f3r3_yield=table2array(excel_yield_et(975:1017,"yield"));
wheat_f3r3_et=table2array(excel_yield_et(975:1017,"et"));

model_f3r3=@(b,wheat_f3r3_x) b(1)+b(2)*(1-wheat_f3r3_x.*wheat_f3r3_x);

beta0=[0,0];

[beta1_f3r3,resnorm]=lsqcurvefit(model_f3r3,beta0,wheat_f3r3_x,wheat_f3r3_y);

wheat_f3r3_yfit=model_f3r3(beta1_f3r3,wheat_f3r3_x);
wheat_f3r3_yfit1=wheat_f3r3_yfit;

xy=[wheat_f3r3_et,wheat_f3r3_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[249/255,228/255,169/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f3r3_y-wheat_f3r3_yfit).^2);
SStotal=sum((wheat_f3r3_y-mean(wheat_f3r3_y)).^2);
R2_f3r3=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r3_yield-wheat_f3r3_yfit1).^2);
RMSE_f3r3=(SSresid1/size(wheat_f3r3_yield,1))^0.5;
nRMSE_f3r3=RMSE_f3r3/(mean(wheat_f3r3_yield));
%%
wheat_f4r3_yield=table2array(excel_yield_et(975:1017,"yield"));
wheat_f4r3_et=table2array(excel_yield_et(975:1017,"et"));

xx=wheat_f4r3_et;
yy=wheat_f4r3_yield;

maxyield=max(wheat_f4r3_yield);
et50_r3=(max(wheat_f4r3_et)/2);

model_f4r3=@(k,wheat_f4r3_et) maxyield*((wheat_f4r3_et.^k)./((et50_r3.^k)+(wheat_f4r3_et.^k)));

beta0=1;
[beta1_f4r3,resnorm]=lsqcurvefit(model_f4r3,beta0,wheat_f4r3_et,wheat_f4r3_yield);

wheat_f4r3_yfit=model_f4r3(beta1_f4r3,wheat_f4r3_et);

xy=[wheat_f4r3_et,wheat_f4r3_yfit];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[178/255,223/255,227/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f4r3_yield-wheat_f4r3_yfit).^2);
SStotal=sum((wheat_f4r3_yield-mean(wheat_f4r3_yield)).^2);
R2_f4r3=1-(SSresid/SStotal);


%RMSE
RMSE_f4r3=(SSresid/size(wheat_f4r3_yield,1))^0.5;
nRMSE_f4r3=RMSE_f4r3/(mean(wheat_f4r3_yield));
%%
wheat_f5r3_x=table2array(excel_yield_et(975:1017,"x1_et_max"));
wheat_f5r3_y=table2array(excel_yield_et(975:1017,"x1_yield_max"));
wheat_f5r3_yield=table2array(excel_yield_et(975:1017,"yield"));
wheat_f5r3_et=table2array(excel_yield_et(975:1017,"et"));

model_f5r3=@(k,wheat_f5r3_x) k*(wheat_f5r3_x.*wheat_f5r3_x);

beta0=1;

[beta1_f5r3,resnorm]=lsqcurvefit(model_f5r3,beta0,wheat_f5r3_x,wheat_f5r3_y);
c1=max(wheat_f5r3_et)*max(wheat_f5r3_et);
c2_r3=(beta1_f5r3*max(wheat_f5r3_yield))/c1;
wheat_f5r3_yfit=model_f5r3(beta1_f5r3,wheat_f5r3_x);
wheat_f5r3_yfit1=max(wheat_f5r3_yield)*(1-wheat_f5r3_yfit);

xy=[wheat_f5r3_et,wheat_f5r3_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[69/255,156/255,215/255],'LineWidth',1,'LineStyle','--')
hold off
%R2
SSresid=sum((wheat_f5r3_y-wheat_f5r3_yfit).^2);
SStotal=sum((wheat_f5r3_y-mean(wheat_f5r3_y)).^2);
R2_f5r3=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f5r3_yield-wheat_f5r3_yfit1).^2);
RMSE_f5r3=(SSresid1/size(wheat_f5r3_yield,1))^0.5;
nRMSE_f5r3=RMSE_f5r3/(mean(wheat_f5r3_yield));

%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\soybean_r3_0304';
print(figure(3),filepath_save,'-dpng','-r1000')
print(figure(3),filepath_save,'-djpeg','-r1000')
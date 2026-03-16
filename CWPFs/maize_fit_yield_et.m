clear
clc
filename="D:\yellow river water comsumption\yield_et_fit_new.xlsx";
excel_yield_et=readtable(filename);
%%
%maize CWPF1 region1
wheat_f1r1_x=table2array(excel_yield_et(423:500,"x1_et_max"));
wheat_f1r1_y=table2array(excel_yield_et(423:500,"x1_yield_max"));
wheat_f1r1_yield=table2array(excel_yield_et(423:500,"yield"));
wheat_f1r1_et=table2array(excel_yield_et(423:500,"et"));

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

axis1=min(wheat_f1r1_et)-100;
axis2=max(wheat_f1r1_et)+100;
axis3=min(wheat_f1r1_yield)-500;
axis4=max(wheat_f1r1_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Maize Sub-region 1",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r1_y-wheat_f1r1_yfit).^2);
SStotal=sum((wheat_f1r1_y-mean(wheat_f1r1_y)).^2);
R2_f1r1=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r1_yield-wheat_f1r1_yfit1).^2);
RMSE_f1r1=(SSresid1/size(wheat_f1r1_yield,1))^0.5;
nRMSE_f1r1=RMSE_f1r1/(mean(wheat_f1r1_yield));
%%
wheat_f2r1_x=table2array(excel_yield_et(423:500,"et_max"));
wheat_f2r1_y=table2array(excel_yield_et(423:500,"yield_max"));
wheat_f2r1_yield=table2array(excel_yield_et(423:500,"yield"));
wheat_f2r1_et=table2array(excel_yield_et(423:500,"et"));

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
wheat_f3r1_x=table2array(excel_yield_et(423:500,"x1_et_max"));
wheat_f3r1_y=table2array(excel_yield_et(423:500,"yield"));
wheat_f3r1_yield=table2array(excel_yield_et(423:500,"yield"));
wheat_f3r1_et=table2array(excel_yield_et(423:500,"et"));

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
wheat_f4r1_yield=table2array(excel_yield_et(423:500,"yield"));
wheat_f4r1_et=table2array(excel_yield_et(423:500,"et"));

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
wheat_f5r1_x=table2array(excel_yield_et(423:500,"x1_et_max"));
wheat_f5r1_y=table2array(excel_yield_et(423:500,"x1_yield_max"));
wheat_f5r1_yield=table2array(excel_yield_et(423:500,"yield"));
wheat_f5r1_et=table2array(excel_yield_et(423:500,"et"));

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
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r1_0304';
print(figure(1),filepath_save,'-dpng','-r1000')
print(figure(1),filepath_save,'-djpeg','-r1000')

%%
wheat_f1r2_x=table2array(excel_yield_et(501:512,"x1_et_max"));
wheat_f1r2_y=table2array(excel_yield_et(501:512,"x1_yield_max"));
wheat_f1r2_yield=table2array(excel_yield_et(501:512,"yield"));
wheat_f1r2_et=table2array(excel_yield_et(501:512,"et"));

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

axis1=min(wheat_f1r2_et)-100;
axis2=max(wheat_f1r2_et)+100;
axis3=min(wheat_f1r2_yield)-500;
axis4=max(wheat_f1r2_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Maize Sub-region 2",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r2_y-wheat_f1r2_yfit).^2);
SStotal=sum((wheat_f1r2_y-mean(wheat_f1r2_y)).^2);
R2_f1r2=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r2_yield-wheat_f1r2_yfit1).^2);
RMSE_f1r2=(SSresid1/size(wheat_f1r2_yield,1))^0.5;
nRMSE_f1r2=RMSE_f1r2/(mean(wheat_f1r2_yield));
%%
wheat_f2r2_x=table2array(excel_yield_et(501:512,"et_max"));
wheat_f2r2_y=table2array(excel_yield_et(501:512,"yield_max"));
wheat_f2r2_yield=table2array(excel_yield_et(501:512,"yield"));
wheat_f2r2_et=table2array(excel_yield_et(501:512,"et"));

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
wheat_f3r2_x=table2array(excel_yield_et(501:512,"x1_et_max"));
wheat_f3r2_y=table2array(excel_yield_et(501:512,"yield"));
wheat_f3r2_yield=table2array(excel_yield_et(501:512,"yield"));
wheat_f3r2_et=table2array(excel_yield_et(501:512,"et"));

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
wheat_f4r2_yield=table2array(excel_yield_et(501:512,"yield"));
wheat_f4r2_et=table2array(excel_yield_et(501:512,"et"));

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
wheat_f5r2_x=table2array(excel_yield_et(501:512,"x1_et_max"));
wheat_f5r2_y=table2array(excel_yield_et(501:512,"x1_yield_max"));
wheat_f5r2_yield=table2array(excel_yield_et(501:512,"yield"));
wheat_f5r2_et=table2array(excel_yield_et(501:512,"et"));

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
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r2_0304';
print(figure(2),filepath_save,'-dpng','-r1000')
print(figure(2),filepath_save,'-djpeg','-r1000')

%%
%region3
wheat_f1r3_x=table2array(excel_yield_et(513:553,"x1_et_max"));
wheat_f1r3_y=table2array(excel_yield_et(513:553,"x1_yield_max"));
wheat_f1r3_yield=table2array(excel_yield_et(513:553,"yield"));
wheat_f1r3_et=table2array(excel_yield_et(513:553,"et"));

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
title("Maize Sub-region 3",'FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

%R2
SSresid=sum((wheat_f1r3_y-wheat_f1r3_yfit).^2);
SStotal=sum((wheat_f1r3_y-mean(wheat_f1r3_y)).^2);
R2_f1r3=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r3_yield-wheat_f1r3_yfit1).^2);
RMSE_f1r3=(SSresid1/size(wheat_f1r3_yield,1))^0.5;
nRMSE_f1r3=RMSE_f1r3/(mean(wheat_f1r3_yield));
%%
wheat_f2r3_x=table2array(excel_yield_et(513:553,"et_max"));
wheat_f2r3_y=table2array(excel_yield_et(513:553,"yield_max"));
wheat_f2r3_yield=table2array(excel_yield_et(513:553,"yield"));
wheat_f2r3_et=table2array(excel_yield_et(513:553,"et"));

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
wheat_f3r3_x=table2array(excel_yield_et(513:553,"x1_et_max"));
wheat_f3r3_y=table2array(excel_yield_et(513:553,"yield"));
wheat_f3r3_yield=table2array(excel_yield_et(513:553,"yield"));
wheat_f3r3_et=table2array(excel_yield_et(513:553,"et"));

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
wheat_f4r3_yield=table2array(excel_yield_et(513:553,"yield"));
wheat_f4r3_et=table2array(excel_yield_et(513:553,"et"));

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
wheat_f5r3_x=table2array(excel_yield_et(513:553,"x1_et_max"));
wheat_f5r3_y=table2array(excel_yield_et(513:553,"x1_yield_max"));
wheat_f5r3_yield=table2array(excel_yield_et(513:553,"yield"));
wheat_f5r3_et=table2array(excel_yield_et(513:553,"et"));

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
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r3_0304';
print(figure(3),filepath_save,'-dpng','-r1000')
print(figure(3),filepath_save,'-djpeg','-r1000')

%%
%region4
wheat_f1r4_x=table2array(excel_yield_et(554:648,"x1_et_max"));
wheat_f1r4_y=table2array(excel_yield_et(554:648,"x1_yield_max"));
wheat_f1r4_yield=table2array(excel_yield_et(554:648,"yield"));
wheat_f1r4_et=table2array(excel_yield_et(554:648,"et"));

model_f1r4=@(k,wheat_f1r4_x) k*wheat_f1r4_x;

beta0=1;

[beta1_f1r4,resnorm]=lsqcurvefit(model_f1r4,beta0,wheat_f1r4_x,wheat_f1r4_y);

wheat_f1r4_yfit=model_f1r4(beta1_f1r4,wheat_f1r4_x);
wheat_f1r4_yfit1=max(wheat_f1r4_yield)*(1-wheat_f1r4_yfit);

%figure
figure(4)
plot(wheat_f1r4_et,wheat_f1r4_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f1r4_et,wheat_f1r4_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r4_et)-100;
axis2=max(wheat_f1r4_et)+100;
axis3=min(wheat_f1r4_yield)-500;
axis4=max(wheat_f1r4_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Maize Sub-region 4",'FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

%R2
SSresid=sum((wheat_f1r4_y-wheat_f1r4_yfit).^2);
SStotal=sum((wheat_f1r4_y-mean(wheat_f1r4_y)).^2);
R2_f1r4=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r4_yield-wheat_f1r4_yfit1).^2);
RMSE_f1r4=(SSresid1/size(wheat_f1r4_yield,1))^0.5;
nRMSE_f1r4=RMSE_f1r4/(mean(wheat_f1r4_yield));
%%
wheat_f2r4_x=table2array(excel_yield_et(554:648,"et_max"));
wheat_f2r4_y=table2array(excel_yield_et(554:648,"yield_max"));
wheat_f2r4_yield=table2array(excel_yield_et(554:648,"yield"));
wheat_f2r4_et=table2array(excel_yield_et(554:648,"et"));

wheat_f2r4_yfit=wheat_f2r4_x;
wheat_f2r4_yfit1=max(wheat_f2r4_yield)*wheat_f2r4_yfit;

xy=[wheat_f2r4_et,wheat_f2r4_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[226/255,83/255,61/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f2r4_y-wheat_f2r4_yfit).^2);
SStotal=sum((wheat_f2r4_y-mean(wheat_f2r4_y)).^2);
R2_f2r4=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f2r4_yield-wheat_f2r4_yfit1).^2);
RMSE_f2r4=(SSresid1/size(wheat_f2r4_yield,1))^0.5;
nRMSE_f2r4=RMSE_f2r4/(mean(wheat_f2r4_yield));
%%
wheat_f3r4_x=table2array(excel_yield_et(554:648,"x1_et_max"));
wheat_f3r4_y=table2array(excel_yield_et(554:648,"yield"));
wheat_f3r4_yield=table2array(excel_yield_et(554:648,"yield"));
wheat_f3r4_et=table2array(excel_yield_et(554:648,"et"));

model_f3r4=@(b,wheat_f3r4_x) b(1)+b(2)*(1-wheat_f3r4_x.*wheat_f3r4_x);

beta0=[0,0];

[beta1_f3r4,resnorm]=lsqcurvefit(model_f3r4,beta0,wheat_f3r4_x,wheat_f3r4_y);

wheat_f3r4_yfit=model_f3r4(beta1_f3r4,wheat_f3r4_x);
wheat_f3r4_yfit1=wheat_f3r4_yfit;

xy=[wheat_f3r4_et,wheat_f3r4_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[249/255,228/255,169/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f3r4_y-wheat_f3r4_yfit).^2);
SStotal=sum((wheat_f3r4_y-mean(wheat_f3r4_y)).^2);
R2_f3r4=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r4_yield-wheat_f3r4_yfit1).^2);
RMSE_f3r4=(SSresid1/size(wheat_f3r4_yield,1))^0.5;
nRMSE_f3r4=RMSE_f3r4/(mean(wheat_f3r4_yield));
%%
wheat_f4r4_yield=table2array(excel_yield_et(554:648,"yield"));
wheat_f4r4_et=table2array(excel_yield_et(554:648,"et"));

xx=wheat_f4r4_et;
yy=wheat_f4r4_yield;

maxyield=max(wheat_f4r4_yield);
et50_r4=(max(wheat_f4r4_et)/2);

model_f4r4=@(k,wheat_f4r4_et) maxyield*((wheat_f4r4_et.^k)./((et50_r4.^k)+(wheat_f4r4_et.^k)));

beta0=1;
[beta1_f4r4,resnorm]=lsqcurvefit(model_f4r4,beta0,wheat_f4r4_et,wheat_f4r4_yield);

wheat_f4r4_yfit=model_f4r4(beta1_f4r4,wheat_f4r4_et);

xy=[wheat_f4r4_et,wheat_f4r4_yfit];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[178/255,223/255,227/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f4r4_yield-wheat_f4r4_yfit).^2);
SStotal=sum((wheat_f4r4_yield-mean(wheat_f4r4_yield)).^2);
R2_f4r4=1-(SSresid/SStotal);

%RMSE
RMSE_f4r4=(SSresid/size(wheat_f4r4_yield,1))^0.5;
nRMSE_f4r4=RMSE_f4r4/(mean(wheat_f4r4_yield));
%%
wheat_f5r4_x=table2array(excel_yield_et(554:648,"x1_et_max"));
wheat_f5r4_y=table2array(excel_yield_et(554:648,"x1_yield_max"));
wheat_f5r4_yield=table2array(excel_yield_et(554:648,"yield"));
wheat_f5r4_et=table2array(excel_yield_et(554:648,"et"));

model_f5r4=@(k,wheat_f5r4_x) k*(wheat_f5r4_x.*wheat_f5r4_x);

beta0=1;

[beta1_f5r4,resnorm]=lsqcurvefit(model_f5r4,beta0,wheat_f5r4_x,wheat_f5r4_y);
c1=max(wheat_f5r4_et)*max(wheat_f5r4_et);
c2_r4=(beta1_f5r4*max(wheat_f5r4_yield))/c1;

wheat_f5r4_yfit=model_f5r4(beta1_f5r4,wheat_f5r4_x);
wheat_f5r4_yfit1=max(wheat_f5r4_yield)*(1-wheat_f5r4_yfit);

xy=[wheat_f5r4_et,wheat_f5r4_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[69/255,156/255,215/255],'LineWidth',1,'LineStyle','--')
hold off
%R2
SSresid=sum((wheat_f5r4_y-wheat_f5r4_yfit).^2);
SStotal=sum((wheat_f5r4_y-mean(wheat_f5r4_y)).^2);
R2_f5r4=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f5r4_yield-wheat_f5r4_yfit1).^2);
RMSE_f5r4=(SSresid1/size(wheat_f5r4_yield,1))^0.5;
nRMSE_f5r4=RMSE_f5r4/(mean(wheat_f5r4_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r4_0304';
print(figure(4),filepath_save,'-dpng','-r1000')
print(figure(4),filepath_save,'-djpeg','-r1000')

%%
wheat_f1r5_x=table2array(excel_yield_et(649:780,"x1_et_max"));
wheat_f1r5_y=table2array(excel_yield_et(649:780,"x1_yield_max"));
wheat_f1r5_yield=table2array(excel_yield_et(649:780,"yield"));
wheat_f1r5_et=table2array(excel_yield_et(649:780,"et"));

model_f1r5=@(k,wheat_f1r5_x) k*wheat_f1r5_x;

beta0=1;

[beta1_f1r5,resnorm]=lsqcurvefit(model_f1r5,beta0,wheat_f1r5_x,wheat_f1r5_y);

wheat_f1r5_yfit=model_f1r5(beta1_f1r5,wheat_f1r5_x);
wheat_f1r5_yfit1=max(wheat_f1r5_yield)*(1-wheat_f1r5_yfit);

%figure
figure(5)
plot(wheat_f1r5_et,wheat_f1r5_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f1r5_et,wheat_f1r5_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r5_et)-100;
axis2=max(wheat_f1r5_et)+100;
axis3=min(wheat_f1r5_yield)-500;
axis4=max(wheat_f1r5_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Maize Sub-region 5",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r5_y-wheat_f1r5_yfit).^2);
SStotal=sum((wheat_f1r5_y-mean(wheat_f1r5_y)).^2);
R2_f1r5=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r5_yield-wheat_f1r5_yfit1).^2);
RMSE_f1r5=(SSresid1/size(wheat_f1r5_yield,1))^0.5;
nRMSE_f1r5=RMSE_f1r5/(mean(wheat_f1r5_yield));
%%
wheat_f2r5_x=table2array(excel_yield_et(649:780,"et_max"));
wheat_f2r5_y=table2array(excel_yield_et(649:780,"yield_max"));
wheat_f2r5_yield=table2array(excel_yield_et(649:780,"yield"));
wheat_f2r5_et=table2array(excel_yield_et(649:780,"et"));

wheat_f2r5_yfit=wheat_f2r5_x;
wheat_f2r5_yfit1=max(wheat_f2r5_yield)*wheat_f2r5_yfit;

xy=[wheat_f2r5_et,wheat_f2r5_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[226/255,83/255,61/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f2r5_y-wheat_f2r5_yfit).^2);
SStotal=sum((wheat_f2r5_y-mean(wheat_f2r5_y)).^2);
R2_f2r5=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f2r5_yield-wheat_f2r5_yfit1).^2);
RMSE_f2r5=(SSresid1/size(wheat_f2r5_yield,1))^0.5;
nRMSE_f2r5=RMSE_f2r5/(mean(wheat_f2r5_yield));
%%
wheat_f3r5_x=table2array(excel_yield_et(649:780,"x1_et_max"));
wheat_f3r5_y=table2array(excel_yield_et(649:780,"yield"));
wheat_f3r5_yield=table2array(excel_yield_et(649:780,"yield"));
wheat_f3r5_et=table2array(excel_yield_et(649:780,"et"));

model_f3r5=@(b,wheat_f3r5_x) b(1)+b(2)*(1-wheat_f3r5_x.*wheat_f3r5_x);

beta0=[0,0];

[beta1_f3r5,resnorm]=lsqcurvefit(model_f3r5,beta0,wheat_f3r5_x,wheat_f3r5_y);

wheat_f3r5_yfit=model_f3r5(beta1_f3r5,wheat_f3r5_x);
wheat_f3r5_yfit1=wheat_f3r5_yfit;

xy=[wheat_f3r5_et,wheat_f3r5_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[249/255,228/255,169/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f3r5_y-wheat_f3r5_yfit).^2);
SStotal=sum((wheat_f3r5_y-mean(wheat_f3r5_y)).^2);
R2_f3r5=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r5_yield-wheat_f3r5_yfit1).^2);
RMSE_f3r5=(SSresid1/size(wheat_f3r5_yield,1))^0.5;
nRMSE_f3r5=RMSE_f3r5/(mean(wheat_f3r5_yield));
%%
wheat_f4r5_yield=table2array(excel_yield_et(649:780,"yield"));
wheat_f4r5_et=table2array(excel_yield_et(649:780,"et"));

xx=wheat_f4r5_et;
yy=wheat_f4r5_yield;

maxyield=max(wheat_f4r5_yield);
et50_r5=(max(wheat_f4r5_et)/2);

model_f4r5=@(k,wheat_f4r5_et) maxyield*((wheat_f4r5_et.^k)./((et50_r5.^k)+(wheat_f4r5_et.^k)));

beta0=1;
[beta1_f4r5,resnorm]=lsqcurvefit(model_f4r5,beta0,wheat_f4r5_et,wheat_f4r5_yield);

wheat_f4r5_yfit=model_f4r5(beta1_f4r5,wheat_f4r5_et);

xy=[wheat_f4r5_et,wheat_f4r5_yfit];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[178/255,223/255,227/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f4r5_yield-wheat_f4r5_yfit).^2);
SStotal=sum((wheat_f4r5_yield-mean(wheat_f4r5_yield)).^2);
R2_f4r5=1-(SSresid/SStotal);

%RMSE
RMSE_f4r5=(SSresid/size(wheat_f4r5_yield,1))^0.5;
nRMSE_f4r5=RMSE_f4r5/(mean(wheat_f4r5_yield));
%%
wheat_f5r5_x=table2array(excel_yield_et(649:780,"x1_et_max"));
wheat_f5r5_y=table2array(excel_yield_et(649:780,"x1_yield_max"));
wheat_f5r5_yield=table2array(excel_yield_et(649:780,"yield"));
wheat_f5r5_et=table2array(excel_yield_et(649:780,"et"));

model_f5r5=@(k,wheat_f5r5_x) k*(wheat_f5r5_x.*wheat_f5r5_x);

beta0=1;

[beta1_f5r5,resnorm]=lsqcurvefit(model_f5r5,beta0,wheat_f5r5_x,wheat_f5r5_y);
c1=max(wheat_f5r5_et)*max(wheat_f5r5_et);
c2_r5=(beta1_f5r5*max(wheat_f5r5_yield))/c1;
wheat_f5r5_yfit=model_f5r5(beta1_f5r5,wheat_f5r5_x);
wheat_f5r5_yfit1=max(wheat_f5r5_yield)*(1-wheat_f5r5_yfit);

xy=[wheat_f5r5_et,wheat_f5r5_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[69/255,156/255,215/255],'LineWidth',1,'LineStyle','--')
hold off
%R2
SSresid=sum((wheat_f5r5_y-wheat_f5r5_yfit).^2);
SStotal=sum((wheat_f5r5_y-mean(wheat_f5r5_y)).^2);
R2_f5r5=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f5r5_yield-wheat_f5r5_yfit1).^2);
RMSE_f5r5=(SSresid1/size(wheat_f5r5_yield,1))^0.5;
nRMSE_f5r5=RMSE_f5r5/(mean(wheat_f5r5_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r5_0304';
print(figure(5),filepath_save,'-dpng','-r1000')
print(figure(5),filepath_save,'-djpeg','-r1000')

%%
%region6
wheat_f1r6_x=table2array(excel_yield_et(781:793,"x1_et_max"));
wheat_f1r6_y=table2array(excel_yield_et(781:793,"x1_yield_max"));
wheat_f1r6_yield=table2array(excel_yield_et(781:793,"yield"));
wheat_f1r6_et=table2array(excel_yield_et(781:793,"et"));

model_f1r6=@(k,wheat_f1r6_x) k*wheat_f1r6_x;

beta0=1;

[beta1_f1r6,resnorm]=lsqcurvefit(model_f1r6,beta0,wheat_f1r6_x,wheat_f1r6_y);

wheat_f1r6_yfit=model_f1r6(beta1_f1r6,wheat_f1r6_x);
wheat_f1r6_yfit1=max(wheat_f1r6_yield)*(1-wheat_f1r6_yfit);

%figure
figure(6)
plot(wheat_f1r6_et,wheat_f1r6_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f1r6_et,wheat_f1r6_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r6_et)-100;
axis2=max(wheat_f1r6_et)+100;
axis3=min(wheat_f1r6_yield)-500;
axis4=max(wheat_f1r6_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Maize Sub-region 6",'FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

%R2
SSresid=sum((wheat_f1r6_y-wheat_f1r6_yfit).^2);
SStotal=sum((wheat_f1r6_y-mean(wheat_f1r6_y)).^2);
R2_f1r6=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r6_yield-wheat_f1r6_yfit1).^2);
RMSE_f1r6=(SSresid1/size(wheat_f1r6_yield,1))^0.5;
nRMSE_f1r6=RMSE_f1r6/(mean(wheat_f1r6_yield));
%%
wheat_f2r6_x=table2array(excel_yield_et(781:793,"et_max"));
wheat_f2r6_y=table2array(excel_yield_et(781:793,"yield_max"));
wheat_f2r6_yield=table2array(excel_yield_et(781:793,"yield"));
wheat_f2r6_et=table2array(excel_yield_et(781:793,"et"));

wheat_f2r6_yfit=wheat_f2r6_x;
wheat_f2r6_yfit1=max(wheat_f2r6_yield)*wheat_f2r6_yfit;

xy=[wheat_f2r6_et,wheat_f2r6_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[226/255,83/255,61/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f2r6_y-wheat_f2r6_yfit).^2);
SStotal=sum((wheat_f2r6_y-mean(wheat_f2r6_y)).^2);
R2_f2r6=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f2r6_yield-wheat_f2r6_yfit1).^2);
RMSE_f2r6=(SSresid1/size(wheat_f2r6_yield,1))^0.5;
nRMSE_f2r6=RMSE_f2r6/(mean(wheat_f2r6_yield));
%%
wheat_f3r6_x=table2array(excel_yield_et(781:793,"x1_et_max"));
wheat_f3r6_y=table2array(excel_yield_et(781:793,"yield"));
wheat_f3r6_yield=table2array(excel_yield_et(781:793,"yield"));
wheat_f3r6_et=table2array(excel_yield_et(781:793,"et"));

model_f3r6=@(b,wheat_f3r6_x) b(1)+b(2)*(1-wheat_f3r6_x.*wheat_f3r6_x);

beta0=[0,0];

[beta1_f3r6,resnorm]=lsqcurvefit(model_f3r6,beta0,wheat_f3r6_x,wheat_f3r6_y);

wheat_f3r6_yfit=model_f3r6(beta1_f3r6,wheat_f3r6_x);
wheat_f3r6_yfit1=wheat_f3r6_yfit;

xy=[wheat_f3r6_et,wheat_f3r6_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[249/255,228/255,169/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f3r6_y-wheat_f3r6_yfit).^2);
SStotal=sum((wheat_f3r6_y-mean(wheat_f3r6_y)).^2);
R2_f3r6=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r6_yield-wheat_f3r6_yfit1).^2);
RMSE_f3r6=(SSresid1/size(wheat_f3r6_yield,1))^0.5;
nRMSE_f3r6=RMSE_f3r6/(mean(wheat_f3r6_yield));
%%
wheat_f4r6_yield=table2array(excel_yield_et(781:793,"yield"));
wheat_f4r6_et=table2array(excel_yield_et(781:793,"et"));

xx=wheat_f4r6_et;
yy=wheat_f4r6_yield;

maxyield=max(wheat_f4r6_yield);
et50_r6=(max(wheat_f4r6_et)/2);

model_f4r6=@(k,wheat_f4r6_et) maxyield*((wheat_f4r6_et.^k)./((et50_r6.^k)+(wheat_f4r6_et.^k)));

beta0=1;
[beta1_f4r6,resnorm]=lsqcurvefit(model_f4r6,beta0,wheat_f4r6_et,wheat_f4r6_yield);

wheat_f4r6_yfit=model_f4r6(beta1_f4r6,wheat_f4r6_et);

xy=[wheat_f4r6_et,wheat_f4r6_yfit];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[178/255,223/255,227/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f4r6_yield-wheat_f4r6_yfit).^2);
SStotal=sum((wheat_f4r6_yield-mean(wheat_f4r6_yield)).^2);
R2_f4r6=1-(SSresid/SStotal);

%RMSE
RMSE_f4r6=(SSresid/size(wheat_f4r6_yield,1))^0.5;
nRMSE_f4r6=RMSE_f4r6/(mean(wheat_f4r6_yield));
%%
wheat_f5r6_x=table2array(excel_yield_et(781:793,"x1_et_max"));
wheat_f5r6_y=table2array(excel_yield_et(781:793,"x1_yield_max"));
wheat_f5r6_yield=table2array(excel_yield_et(781:793,"yield"));
wheat_f5r6_et=table2array(excel_yield_et(781:793,"et"));

model_f5r6=@(k,wheat_f5r6_x) k*(wheat_f5r6_x.*wheat_f5r6_x);

beta0=1;

[beta1_f5r6,resnorm]=lsqcurvefit(model_f5r6,beta0,wheat_f5r6_x,wheat_f5r6_y);

wheat_f5r6_yfit=model_f5r6(beta1_f5r6,wheat_f5r6_x);
wheat_f5r6_yfit1=max(wheat_f5r6_yield)*(1-wheat_f5r6_yfit);
c1=max(wheat_f5r6_et)*max(wheat_f5r6_et);
c2_r6=(beta1_f5r6*max(wheat_f5r6_yield))/c1;
xy=[wheat_f5r6_et,wheat_f5r6_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[69/255,156/255,215/255],'LineWidth',1,'LineStyle','--')
hold off
%R2
SSresid=sum((wheat_f5r6_y-wheat_f5r6_yfit).^2);
SStotal=sum((wheat_f5r6_y-mean(wheat_f5r6_y)).^2);
R2_f5r6=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f5r6_yield-wheat_f5r6_yfit1).^2);
RMSE_f5r6=(SSresid1/size(wheat_f5r6_yield,1))^0.5;
nRMSE_f5r6=RMSE_f5r6/(mean(wheat_f5r6_yield));

%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r6_0304';
print(figure(6),filepath_save,'-dpng','-r1000')
print(figure(6),filepath_save,'-djpeg','-r1000')

%%
wheat_f1r7_x=table2array(excel_yield_et(794:885,"x1_et_max"));
wheat_f1r7_y=table2array(excel_yield_et(794:885,"x1_yield_max"));
wheat_f1r7_yield=table2array(excel_yield_et(794:885,"yield"));
wheat_f1r7_et=table2array(excel_yield_et(794:885,"et"));

model_f1r7=@(k,wheat_f1r7_x) k*wheat_f1r7_x;

beta0=1;

[beta1_f1r7,resnorm]=lsqcurvefit(model_f1r7,beta0,wheat_f1r7_x,wheat_f1r7_y);

wheat_f1r7_yfit=model_f1r7(beta1_f1r7,wheat_f1r7_x);
wheat_f1r7_yfit1=max(wheat_f1r7_yield)*(1-wheat_f1r7_yfit);

%figure
figure(7)
plot(wheat_f1r7_et,wheat_f1r7_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f1r7_et,wheat_f1r7_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r7_et)-100;
axis2=max(wheat_f1r7_et)+100;
axis3=min(wheat_f1r7_yield)-500;
axis4=max(wheat_f1r7_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Maize Sub-region 9",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r7_y-wheat_f1r7_yfit).^2);
SStotal=sum((wheat_f1r7_y-mean(wheat_f1r7_y)).^2);
R2_f1r7=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r7_yield-wheat_f1r7_yfit1).^2);
RMSE_f1r7=(SSresid1/size(wheat_f1r7_yield,1))^0.5;
nRMSE_f1r7=RMSE_f1r7/(mean(wheat_f1r7_yield));
%%
wheat_f2r7_x=table2array(excel_yield_et(794:885,"et_max"));
wheat_f2r7_y=table2array(excel_yield_et(794:885,"yield_max"));
wheat_f2r7_yield=table2array(excel_yield_et(794:885,"yield"));
wheat_f2r7_et=table2array(excel_yield_et(794:885,"et"));

wheat_f2r7_yfit=wheat_f2r7_x;
wheat_f2r7_yfit1=max(wheat_f2r7_yield)*wheat_f2r7_yfit;

xy=[wheat_f2r7_et,wheat_f2r7_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[226/255,83/255,61/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f2r7_y-wheat_f2r7_yfit).^2);
SStotal=sum((wheat_f2r7_y-mean(wheat_f2r7_y)).^2);
R2_f2r7=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f2r7_yield-wheat_f2r7_yfit1).^2);
RMSE_f2r7=(SSresid1/size(wheat_f2r7_yield,1))^0.5;
nRMSE_f2r7=RMSE_f2r7/(mean(wheat_f2r7_yield));
%%
wheat_f3r7_x=table2array(excel_yield_et(794:885,"x1_et_max"));
wheat_f3r7_y=table2array(excel_yield_et(794:885,"yield"));
wheat_f3r7_yield=table2array(excel_yield_et(794:885,"yield"));
wheat_f3r7_et=table2array(excel_yield_et(794:885,"et"));

model_f3r7=@(b,wheat_f3r7_x) b(1)+b(2)*(1-wheat_f3r7_x.*wheat_f3r7_x);

beta0=[0,0];

[beta1_f3r7,resnorm]=lsqcurvefit(model_f3r7,beta0,wheat_f3r7_x,wheat_f3r7_y);

wheat_f3r7_yfit=model_f3r7(beta1_f3r7,wheat_f3r7_x);
wheat_f3r7_yfit1=wheat_f3r7_yfit;

xy=[wheat_f3r7_et,wheat_f3r7_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[249/255,228/255,169/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f3r7_y-wheat_f3r7_yfit).^2);
SStotal=sum((wheat_f3r7_y-mean(wheat_f3r7_y)).^2);
R2_f3r7=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r7_yield-wheat_f3r7_yfit1).^2);
RMSE_f3r7=(SSresid1/size(wheat_f3r7_yield,1))^0.5;
nRMSE_f3r7=RMSE_f3r7/(mean(wheat_f3r7_yield));
%%
wheat_f4r7_yield=table2array(excel_yield_et(794:885,"yield"));
wheat_f4r7_et=table2array(excel_yield_et(794:885,"et"));

xx=wheat_f4r7_et;
yy=wheat_f4r7_yield;

maxyield=max(wheat_f4r7_yield);
et50_r7=(max(wheat_f4r7_et)/2);

model_f4r7=@(k,wheat_f4r7_et) maxyield*((wheat_f4r7_et.^k)./((et50_r7.^k)+(wheat_f4r7_et.^k)));

beta0=1;
[beta1_f4r7,resnorm]=lsqcurvefit(model_f4r7,beta0,wheat_f4r7_et,wheat_f4r7_yield);

wheat_f4r7_yfit=model_f4r7(beta1_f4r7,wheat_f4r7_et);

xy=[wheat_f4r7_et,wheat_f4r7_yfit];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[178/255,223/255,227/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f4r7_yield-wheat_f4r7_yfit).^2);
SStotal=sum((wheat_f4r7_yield-mean(wheat_f4r7_yield)).^2);
R2_f4r7=1-(SSresid/SStotal);

%RMSE
RMSE_f4r7=(SSresid/size(wheat_f4r7_yield,1))^0.5;
nRMSE_f4r7=RMSE_f4r7/(mean(wheat_f4r7_yield));
%%
wheat_f5r7_x=table2array(excel_yield_et(794:885,"x1_et_max"));
wheat_f5r7_y=table2array(excel_yield_et(794:885,"x1_yield_max"));
wheat_f5r7_yield=table2array(excel_yield_et(794:885,"yield"));
wheat_f5r7_et=table2array(excel_yield_et(794:885,"et"));

model_f5r7=@(k,wheat_f5r7_x) k*(wheat_f5r7_x.*wheat_f5r7_x);

beta0=1;

[beta1_f5r7,resnorm]=lsqcurvefit(model_f5r7,beta0,wheat_f5r7_x,wheat_f5r7_y);

wheat_f5r7_yfit=model_f5r7(beta1_f5r7,wheat_f5r7_x);
wheat_f5r7_yfit1=max(wheat_f5r7_yield)*(1-wheat_f5r7_yfit);
c1=max(wheat_f5r7_et)*max(wheat_f5r7_et);
c2_r7=(beta1_f5r7*max(wheat_f5r7_yield))/c1;
xy=[wheat_f5r7_et,wheat_f5r7_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[69/255,156/255,215/255],'LineWidth',1,'LineStyle','--')
hold off
%R2
SSresid=sum((wheat_f5r7_y-wheat_f5r7_yfit).^2);
SStotal=sum((wheat_f5r7_y-mean(wheat_f5r7_y)).^2);
R2_f5r7=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f5r7_yield-wheat_f5r7_yfit1).^2);
RMSE_f5r7=(SSresid1/size(wheat_f5r7_yield,1))^0.5;
nRMSE_f5r7=RMSE_f5r7/(mean(wheat_f5r7_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r7_0304';
print(figure(7),filepath_save,'-dpng','-r1000')
print(figure(7),filepath_save,'-djpeg','-r1000')

%%
%小麦   拟合函数1  region8
wheat_f1r8_x=table2array(excel_yield_et(886:892,"x1_et_max"));
wheat_f1r8_y=table2array(excel_yield_et(886:892,"x1_yield_max"));
wheat_f1r8_yield=table2array(excel_yield_et(886:892,"yield"));
wheat_f1r8_et=table2array(excel_yield_et(886:892,"et"));

model_f1r8=@(k,wheat_f1r8_x) k*wheat_f1r8_x;

beta0=1;

[beta1_f1r8,resnorm]=lsqcurvefit(model_f1r8,beta0,wheat_f1r8_x,wheat_f1r8_y);

wheat_f1r8_yfit=model_f1r8(beta1_f1r8,wheat_f1r8_x);
wheat_f1r8_yfit1=max(wheat_f1r8_yield)*(1-wheat_f1r8_yfit);

%figure
figure(8)
plot(wheat_f1r8_et,wheat_f1r8_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f1r8_et,wheat_f1r8_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r8_et)-100;
axis2=max(wheat_f1r8_et)+100;
axis3=min(wheat_f1r8_yield)-500;
axis4=max(wheat_f1r8_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Maize Sub-region 10",'FontSize',32,'FontName','Times New Roman')
%R2
SSresid=sum((wheat_f1r8_y-wheat_f1r8_yfit).^2);
SStotal=sum((wheat_f1r8_y-mean(wheat_f1r8_y)).^2);
R2_f1r8=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r8_yield-wheat_f1r8_yfit1).^2);
RMSE_f1r8=(SSresid1/size(wheat_f1r8_yield,1))^0.5;
nRMSE_f1r8=RMSE_f1r8/(mean(wheat_f1r8_yield));
%%
wheat_f2r8_x=table2array(excel_yield_et(886:892,"et_max"));
wheat_f2r8_y=table2array(excel_yield_et(886:892,"yield_max"));
wheat_f2r8_yield=table2array(excel_yield_et(886:892,"yield"));
wheat_f2r8_et=table2array(excel_yield_et(886:892,"et"));

wheat_f2r8_yfit=wheat_f2r8_x;
wheat_f2r8_yfit1=max(wheat_f2r8_yield)*wheat_f2r8_yfit;

xy=[wheat_f2r8_et,wheat_f2r8_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[226/255,83/255,61/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f2r8_y-wheat_f2r8_yfit).^2);
SStotal=sum((wheat_f2r8_y-mean(wheat_f2r8_y)).^2);
R2_f2r8=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f2r8_yield-wheat_f2r8_yfit1).^2);
RMSE_f2r8=(SSresid1/size(wheat_f2r8_yield,1))^0.5;
nRMSE_f2r8=RMSE_f2r8/(mean(wheat_f2r8_yield));
%%
wheat_f3r8_x=table2array(excel_yield_et(886:892,"x1_et_max"));
wheat_f3r8_y=table2array(excel_yield_et(886:892,"yield"));
wheat_f3r8_yield=table2array(excel_yield_et(886:892,"yield"));
wheat_f3r8_et=table2array(excel_yield_et(886:892,"et"));

model_f3r8=@(b,wheat_f3r8_x) b(1)+b(2)*(1-wheat_f3r8_x.*wheat_f3r8_x);

beta0=[0,0];

[beta1_f3r8,resnorm]=lsqcurvefit(model_f3r8,beta0,wheat_f3r8_x,wheat_f3r8_y);

wheat_f3r8_yfit=model_f3r8(beta1_f3r8,wheat_f3r8_x);
wheat_f3r8_yfit1=wheat_f3r8_yfit;

xy=[wheat_f3r8_et,wheat_f3r8_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[249/255,228/255,169/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f3r8_y-wheat_f3r8_yfit).^2);
SStotal=sum((wheat_f3r8_y-mean(wheat_f3r8_y)).^2);
R2_f3r8=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r8_yield-wheat_f3r8_yfit1).^2);
RMSE_f3r8=(SSresid1/size(wheat_f3r8_yield,1))^0.5;
nRMSE_f3r8=RMSE_f3r8/(mean(wheat_f3r8_yield));
%%
wheat_f4r8_yield=table2array(excel_yield_et(886:892,"yield"));
wheat_f4r8_et=table2array(excel_yield_et(886:892,"et"));

xx=wheat_f4r8_et;
yy=wheat_f4r8_yield;

maxyield=max(wheat_f4r8_yield);
et50_r8=(max(wheat_f4r8_et)/2);

model_f4r8=@(k,wheat_f4r8_et) maxyield*((wheat_f4r8_et.^k)./((et50_r8.^k)+(wheat_f4r8_et.^k)));

beta0=1;
[beta1_f4r8,resnorm]=lsqcurvefit(model_f4r8,beta0,wheat_f4r8_et,wheat_f4r8_yield);

wheat_f4r8_yfit=model_f4r8(beta1_f4r8,wheat_f4r8_et);

xy=[wheat_f4r8_et,wheat_f4r8_yfit];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[178/255,223/255,227/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f4r8_yield-wheat_f4r8_yfit).^2);
SStotal=sum((wheat_f4r8_yield-mean(wheat_f4r8_yield)).^2);
R2_f4r8=1-(SSresid/SStotal);


%RMSE
RMSE_f4r8=(SSresid/size(wheat_f4r8_yield,1))^0.5;
nRMSE_f4r8=RMSE_f4r8/(mean(wheat_f4r8_yield));
%%
wheat_f5r8_x=table2array(excel_yield_et(886:892,"x1_et_max"));
wheat_f5r8_y=table2array(excel_yield_et(886:892,"x1_yield_max"));
wheat_f5r8_yield=table2array(excel_yield_et(886:892,"yield"));
wheat_f5r8_et=table2array(excel_yield_et(886:892,"et"));

model_f5r8=@(k,wheat_f5r8_x) k*(wheat_f5r8_x.*wheat_f5r8_x);

beta0=1;

[beta1_f5r8,resnorm]=lsqcurvefit(model_f5r8,beta0,wheat_f5r8_x,wheat_f5r8_y);

wheat_f5r8_yfit=model_f5r8(beta1_f5r8,wheat_f5r8_x);
wheat_f5r8_yfit1=max(wheat_f5r8_yield)*(1-wheat_f5r8_yfit);
c1=max(wheat_f5r8_et)*max(wheat_f5r8_et);
c2_r8=(beta1_f5r8*max(wheat_f5r8_yield))/c1;
xy=[wheat_f5r8_et,wheat_f5r8_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[69/255,156/255,215/255],'LineWidth',1,'LineStyle','--')
hold off
%R2
SSresid=sum((wheat_f5r8_y-wheat_f5r8_yfit).^2);
SStotal=sum((wheat_f5r8_y-mean(wheat_f5r8_y)).^2);
R2_f5r8=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f5r8_yield-wheat_f5r8_yfit1).^2);
RMSE_f5r8=(SSresid1/size(wheat_f5r8_yield,1))^0.5;
nRMSE_f5r8=RMSE_f5r8/(mean(wheat_f5r8_yield));

%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r8_0304';
print(figure(8),filepath_save,'-dpng','-r1000')
print(figure(8),filepath_save,'-djpeg','-r1000')

%%
%region9
wheat_f1r9_x=table2array(excel_yield_et(893:916,"x1_et_max"));
wheat_f1r9_y=table2array(excel_yield_et(893:916,"x1_yield_max"));
wheat_f1r9_yield=table2array(excel_yield_et(893:916,"yield"));
wheat_f1r9_et=table2array(excel_yield_et(893:916,"et"));

model_f1r9=@(k,wheat_f1r9_x) k*wheat_f1r9_x;

beta0=1;

[beta1_f1r9,resnorm]=lsqcurvefit(model_f1r9,beta0,wheat_f1r9_x,wheat_f1r9_y);

wheat_f1r9_yfit=model_f1r9(beta1_f1r9,wheat_f1r9_x);
wheat_f1r9_yfit1=max(wheat_f1r9_yield)*(1-wheat_f1r9_yfit);

%figure
figure(9)
plot(wheat_f1r9_et,wheat_f1r9_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f1r9_et,wheat_f1r9_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r9_et)-100;
axis2=max(wheat_f1r9_et)+100;
axis3=min(wheat_f1r9_yield)-500;
axis4=max(wheat_f1r9_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Maize Sub-region 11",'FontSize',32,'FontName','Times New Roman')
%R2
SSresid=sum((wheat_f1r9_y-wheat_f1r9_yfit).^2);
SStotal=sum((wheat_f1r9_y-mean(wheat_f1r9_y)).^2);
R2_f1r9=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r9_yield-wheat_f1r9_yfit1).^2);
RMSE_f1r9=(SSresid1/size(wheat_f1r9_yield,1))^0.5;
nRMSE_f1r9=RMSE_f1r9/(mean(wheat_f1r9_yield));
%%
wheat_f2r9_x=table2array(excel_yield_et(893:916,"et_max"));
wheat_f2r9_y=table2array(excel_yield_et(893:916,"yield_max"));
wheat_f2r9_yield=table2array(excel_yield_et(893:916,"yield"));
wheat_f2r9_et=table2array(excel_yield_et(893:916,"et"));

wheat_f2r9_yfit=wheat_f2r9_x;
wheat_f2r9_yfit1=max(wheat_f2r9_yield)*wheat_f2r9_yfit;

xy=[wheat_f2r9_et,wheat_f2r9_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[226/255,83/255,61/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f2r9_y-wheat_f2r9_yfit).^2);
SStotal=sum((wheat_f2r9_y-mean(wheat_f2r9_y)).^2);
R2_f2r9=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f2r9_yield-wheat_f2r9_yfit1).^2);
RMSE_f2r9=(SSresid1/size(wheat_f2r9_yield,1))^0.5;
nRMSE_f2r9=RMSE_f2r9/(mean(wheat_f2r9_yield));
%%
wheat_f3r9_x=table2array(excel_yield_et(893:916,"x1_et_max"));
wheat_f3r9_y=table2array(excel_yield_et(893:916,"yield"));
wheat_f3r9_yield=table2array(excel_yield_et(893:916,"yield"));
wheat_f3r9_et=table2array(excel_yield_et(893:916,"et"));

model_f3r9=@(b,wheat_f3r9_x) b(1)+b(2)*(1-wheat_f3r9_x.*wheat_f3r9_x);

beta0=[0,0];

[beta1_f3r9,resnorm]=lsqcurvefit(model_f3r9,beta0,wheat_f3r9_x,wheat_f3r9_y);

wheat_f3r9_yfit=model_f3r9(beta1_f3r9,wheat_f3r9_x);
wheat_f3r9_yfit1=wheat_f3r9_yfit;

xy=[wheat_f3r9_et,wheat_f3r9_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[249/255,228/255,169/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f3r9_y-wheat_f3r9_yfit).^2);
SStotal=sum((wheat_f3r9_y-mean(wheat_f3r9_y)).^2);
R2_f3r9=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r9_yield-wheat_f3r9_yfit1).^2);
RMSE_f3r9=(SSresid1/size(wheat_f3r9_yield,1))^0.5;
nRMSE_f3r9=RMSE_f3r9/(mean(wheat_f3r9_yield));
%%
wheat_f4r9_yield=table2array(excel_yield_et(893:916,"yield"));
wheat_f4r9_et=table2array(excel_yield_et(893:916,"et"));

xx=wheat_f4r9_et;
yy=wheat_f4r9_yield;

maxyield=max(wheat_f4r9_yield);
et50_r9=(max(wheat_f4r9_et)/2);

model_f4r9=@(k,wheat_f4r9_et) maxyield*((wheat_f4r9_et.^k)./((et50_r9.^k)+(wheat_f4r9_et.^k)));

beta0=1;
[beta1_f4r9,resnorm]=lsqcurvefit(model_f4r9,beta0,wheat_f4r9_et,wheat_f4r9_yield);

wheat_f4r9_yfit=model_f4r9(beta1_f4r9,wheat_f4r9_et);

xy=[wheat_f4r9_et,wheat_f4r9_yfit];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[178/255,223/255,227/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f4r9_yield-wheat_f4r9_yfit).^2);
SStotal=sum((wheat_f4r9_yield-mean(wheat_f4r9_yield)).^2);
R2_f4r9=1-(SSresid/SStotal);

%RMSE
RMSE_f4r9=(SSresid/size(wheat_f4r9_yield,1))^0.5;
nRMSE_f4r9=RMSE_f4r9/(mean(wheat_f4r9_yield));
%%
wheat_f5r9_x=table2array(excel_yield_et(893:916,"x1_et_max"));
wheat_f5r9_y=table2array(excel_yield_et(893:916,"x1_yield_max"));
wheat_f5r9_yield=table2array(excel_yield_et(893:916,"yield"));
wheat_f5r9_et=table2array(excel_yield_et(893:916,"et"));

model_f5r9=@(k,wheat_f5r9_x) k*(wheat_f5r9_x.*wheat_f5r9_x);

beta0=1;

[beta1_f5r9,resnorm]=lsqcurvefit(model_f5r9,beta0,wheat_f5r9_x,wheat_f5r9_y);

wheat_f5r9_yfit=model_f5r9(beta1_f5r9,wheat_f5r9_x);
wheat_f5r9_yfit1=max(wheat_f5r9_yield)*(1-wheat_f5r9_yfit);
c1=max(wheat_f5r9_et)*max(wheat_f5r9_et);
c2_r9=(beta1_f5r9*max(wheat_f5r9_yield))/c1;
xy=[wheat_f5r9_et,wheat_f5r9_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[69/255,156/255,215/255],'LineWidth',1,'LineStyle','--')
hold off
%R2
SSresid=sum((wheat_f5r9_y-wheat_f5r9_yfit).^2);
SStotal=sum((wheat_f5r9_y-mean(wheat_f5r9_y)).^2);
R2_f5r9=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f5r9_yield-wheat_f5r9_yfit1).^2);
RMSE_f5r9=(SSresid1/size(wheat_f5r9_yield,1))^0.5;
nRMSE_f5r9=RMSE_f5r9/(mean(wheat_f5r9_yield));

%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r9_0304';
print(figure(9),filepath_save,'-dpng','-r1000')
print(figure(9),filepath_save,'-djpeg','-r1000')

%%
%region10
wheat_f1r10_x=table2array(excel_yield_et(917:926,"x1_et_max"));
wheat_f1r10_y=table2array(excel_yield_et(917:926,"x1_yield_max"));
wheat_f1r10_yield=table2array(excel_yield_et(917:926,"yield"));
wheat_f1r10_et=table2array(excel_yield_et(917:926,"et"));

model_f1r10=@(k,wheat_f1r10_x) k*wheat_f1r10_x;

beta0=1;

[beta1_f1r10,resnorm]=lsqcurvefit(model_f1r10,beta0,wheat_f1r10_x,wheat_f1r10_y);

wheat_f1r10_yfit=model_f1r10(beta1_f1r10,wheat_f1r10_x);
wheat_f1r10_yfit1=max(wheat_f1r10_yield)*(1-wheat_f1r10_yfit);

%figure
figure(10)
plot(wheat_f1r10_et,wheat_f1r10_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f1r10_et,wheat_f1r10_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r10_et)-100;
axis2=max(wheat_f1r10_et)+100;
axis3=min(wheat_f1r10_yield)-500;
axis4=max(wheat_f1r10_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Maize Sub-region 12",'FontSize',32,'FontName','Times New Roman')
%R2
SSresid=sum((wheat_f1r10_y-wheat_f1r10_yfit).^2);
SStotal=sum((wheat_f1r10_y-mean(wheat_f1r10_y)).^2);
R2_f1r10=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r10_yield-wheat_f1r10_yfit1).^2);
RMSE_f1r10=(SSresid1/size(wheat_f1r10_yield,1))^0.5;
nRMSE_f1r10=RMSE_f1r10/(mean(wheat_f1r10_yield));
%%
wheat_f2r10_x=table2array(excel_yield_et(917:926,"et_max"));
wheat_f2r10_y=table2array(excel_yield_et(917:926,"yield_max"));
wheat_f2r10_yield=table2array(excel_yield_et(917:926,"yield"));
wheat_f2r10_et=table2array(excel_yield_et(917:926,"et"));

wheat_f2r10_yfit=wheat_f2r10_x;
wheat_f2r10_yfit1=max(wheat_f2r10_yield)*wheat_f2r10_yfit;

xy=[wheat_f2r10_et,wheat_f2r10_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[226/255,83/255,61/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f2r10_y-wheat_f2r10_yfit).^2);
SStotal=sum((wheat_f2r10_y-mean(wheat_f2r10_y)).^2);
R2_f2r10=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f2r10_yield-wheat_f2r10_yfit1).^2);
RMSE_f2r10=(SSresid1/size(wheat_f2r10_yield,1))^0.5;
nRMSE_f2r10=RMSE_f2r10/(mean(wheat_f2r10_yield));
%%
wheat_f3r10_x=table2array(excel_yield_et(917:926,"x1_et_max"));
wheat_f3r10_y=table2array(excel_yield_et(917:926,"yield"));
wheat_f3r10_yield=table2array(excel_yield_et(917:926,"yield"));
wheat_f3r10_et=table2array(excel_yield_et(917:926,"et"));

model_f3r10=@(b,wheat_f3r10_x) b(1)+b(2)*(1-wheat_f3r10_x.*wheat_f3r10_x);

beta0=[0,0];

[beta1_f3r10,resnorm]=lsqcurvefit(model_f3r10,beta0,wheat_f3r10_x,wheat_f3r10_y);

wheat_f3r10_yfit=model_f3r10(beta1_f3r10,wheat_f3r10_x);
wheat_f3r10_yfit1=wheat_f3r10_yfit;

xy=[wheat_f3r10_et,wheat_f3r10_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[249/255,228/255,169/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f3r10_y-wheat_f3r10_yfit).^2);
SStotal=sum((wheat_f3r10_y-mean(wheat_f3r10_y)).^2);
R2_f3r10=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r10_yield-wheat_f3r10_yfit1).^2);
RMSE_f3r10=(SSresid1/size(wheat_f3r10_yield,1))^0.5;
nRMSE_f3r10=RMSE_f3r10/(mean(wheat_f3r10_yield));
%%
%region10
wheat_f4r10_yield=table2array(excel_yield_et(917:926,"yield"));
wheat_f4r10_et=table2array(excel_yield_et(917:926,"et"));

xx=wheat_f4r10_et;
yy=wheat_f4r10_yield;

maxyield=max(wheat_f4r10_yield);
et50_r10=(max(wheat_f4r10_et)/2);

model_f4r10=@(k,wheat_f4r10_et) maxyield*((wheat_f4r10_et.^k)./((et50_r10.^k)+(wheat_f4r10_et.^k)));

beta0=1;
[beta1_f4r10,resnorm]=lsqcurvefit(model_f4r10,beta0,wheat_f4r10_et,wheat_f4r10_yield);

wheat_f4r10_yfit=model_f4r10(beta1_f4r10,wheat_f4r10_et);

xy=[wheat_f4r10_et,wheat_f4r10_yfit];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[178/255,223/255,227/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f4r10_yield-wheat_f4r10_yfit).^2);
SStotal=sum((wheat_f4r10_yield-mean(wheat_f4r10_yield)).^2);
R2_f4r10=1-(SSresid/SStotal);

%RMSE
RMSE_f4r10=(SSresid/size(wheat_f4r10_yield,1))^0.5;
nRMSE_f4r10=RMSE_f4r10/(mean(wheat_f4r10_yield));
%%
wheat_f5r10_x=table2array(excel_yield_et(917:926,"x1_et_max"));
wheat_f5r10_y=table2array(excel_yield_et(917:926,"x1_yield_max"));
wheat_f5r10_yield=table2array(excel_yield_et(917:926,"yield"));
wheat_f5r10_et=table2array(excel_yield_et(917:926,"et"));

model_f5r10=@(k,wheat_f5r10_x) k*(wheat_f5r10_x.*wheat_f5r10_x);

beta0=1;

[beta1_f5r10,resnorm]=lsqcurvefit(model_f5r10,beta0,wheat_f5r10_x,wheat_f5r10_y);

wheat_f5r10_yfit=model_f5r10(beta1_f5r10,wheat_f5r10_x);
wheat_f5r10_yfit1=max(wheat_f5r10_yield)*(1-wheat_f5r10_yfit);
c1=max(wheat_f5r10_et)*max(wheat_f5r10_et);
c2_r10=(beta1_f5r10*max(wheat_f5r10_yield))/c1;
xy=[wheat_f5r10_et,wheat_f5r10_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[69/255,156/255,215/255],'LineWidth',1,'LineStyle','--')
hold off
%R2
SSresid=sum((wheat_f5r10_y-wheat_f5r10_yfit).^2);
SStotal=sum((wheat_f5r10_y-mean(wheat_f5r10_y)).^2);
R2_f5r10=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f5r10_yield-wheat_f5r10_yfit1).^2);
RMSE_f5r10=(SSresid1/size(wheat_f5r10_yield,1))^0.5;
nRMSE_f5r10=RMSE_f5r10/(mean(wheat_f5r10_yield));

%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r10_0304';
print(figure(10),filepath_save,'-dpng','-r1000')
print(figure(10),filepath_save,'-djpeg','-r1000')
%%
%region12
wheat_f1r12_x=table2array(excel_yield_et(927:944,"x1_et_max"));
wheat_f1r12_y=table2array(excel_yield_et(927:944,"x1_yield_max"));
wheat_f1r12_yield=table2array(excel_yield_et(927:944,"yield"));
wheat_f1r12_et=table2array(excel_yield_et(927:944,"et"));

model_f1r12=@(k,wheat_f1r12_x) k*wheat_f1r12_x;

beta0=1;

[beta1_f1r12,resnorm]=lsqcurvefit(model_f1r12,beta0,wheat_f1r12_x,wheat_f1r12_y);

wheat_f1r12_yfit=model_f1r12(beta1_f1r12,wheat_f1r12_x);
wheat_f1r12_yfit1=max(wheat_f1r12_yield)*(1-wheat_f1r12_yfit);

%figure
figure(12)
plot(wheat_f1r12_et,wheat_f1r12_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f1r12_et,wheat_f1r12_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r12_et)-100;
axis2=max(wheat_f1r12_et)+100;
axis3=min(wheat_f1r12_yield)-500;
axis4=max(wheat_f1r12_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Maize Sub-region 8",'FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

%R2
SSresid=sum((wheat_f1r12_y-wheat_f1r12_yfit).^2);
SStotal=sum((wheat_f1r12_y-mean(wheat_f1r12_y)).^2);
R2_f1r12=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r12_yield-wheat_f1r12_yfit1).^2);
RMSE_f1r12=(SSresid1/size(wheat_f1r12_yield,1))^0.5;
nRMSE_f1r12=RMSE_f1r12/(mean(wheat_f1r12_yield));
%%
wheat_f2r12_x=table2array(excel_yield_et(927:944,"et_max"));
wheat_f2r12_y=table2array(excel_yield_et(927:944,"yield_max"));
wheat_f2r12_yield=table2array(excel_yield_et(927:944,"yield"));
wheat_f2r12_et=table2array(excel_yield_et(927:944,"et"));

wheat_f2r12_yfit=wheat_f2r12_x;
wheat_f2r12_yfit1=max(wheat_f2r12_yield)*wheat_f2r12_yfit;

xy=[wheat_f2r12_et,wheat_f2r12_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[226/255,83/255,61/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f2r12_y-wheat_f2r12_yfit).^2);
SStotal=sum((wheat_f2r12_y-mean(wheat_f2r12_y)).^2);
R2_f2r12=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f2r12_yield-wheat_f2r12_yfit1).^2);
RMSE_f2r12=(SSresid1/size(wheat_f2r12_yield,1))^0.5;
nRMSE_f2r12=RMSE_f2r12/(mean(wheat_f2r12_yield));
%%
wheat_f3r12_x=table2array(excel_yield_et(927:944,"x1_et_max"));
wheat_f3r12_y=table2array(excel_yield_et(927:944,"yield"));
wheat_f3r12_yield=table2array(excel_yield_et(927:944,"yield"));
wheat_f3r12_et=table2array(excel_yield_et(927:944,"et"));

model_f3r12=@(b,wheat_f3r12_x) b(1)+b(2)*(1-wheat_f3r12_x.*wheat_f3r12_x);

beta0=[0,0];

[beta1_f3r12,resnorm]=lsqcurvefit(model_f3r12,beta0,wheat_f3r12_x,wheat_f3r12_y);

wheat_f3r12_yfit=model_f3r12(beta1_f3r12,wheat_f3r12_x);
wheat_f3r12_yfit1=wheat_f3r12_yfit;

xy=[wheat_f3r12_et,wheat_f3r12_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[249/255,228/255,169/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f3r12_y-wheat_f3r12_yfit).^2);
SStotal=sum((wheat_f3r12_y-mean(wheat_f3r12_y)).^2);
R2_f3r12=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r12_yield-wheat_f3r12_yfit1).^2);
RMSE_f3r12=(SSresid1/size(wheat_f3r12_yield,1))^0.5;
nRMSE_f3r12=RMSE_f3r12/(mean(wheat_f3r12_yield));
%%
wheat_f4r12_yield=table2array(excel_yield_et(927:944,"yield"));
wheat_f4r12_et=table2array(excel_yield_et(927:944,"et"));

xx=wheat_f4r12_et;
yy=wheat_f4r12_yield;

maxyield=max(wheat_f4r12_yield);
et50_r12=(max(wheat_f4r12_et)/2);

model_f4r12=@(k,wheat_f4r12_et) maxyield*((wheat_f4r12_et.^k)./((et50_r12.^k)+(wheat_f4r12_et.^k)));

beta0=1;
[beta1_f4r12,resnorm]=lsqcurvefit(model_f4r12,beta0,wheat_f4r12_et,wheat_f4r12_yield);

wheat_f4r12_yfit=model_f4r12(beta1_f4r12,wheat_f4r12_et);

xy=[wheat_f4r12_et,wheat_f4r12_yfit];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[178/255,223/255,227/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f4r12_yield-wheat_f4r12_yfit).^2);
SStotal=sum((wheat_f4r12_yield-mean(wheat_f4r12_yield)).^2);
R2_f4r12=1-(SSresid/SStotal);

%RMSE
RMSE_f4r12=(SSresid/size(wheat_f4r12_yield,1))^0.5;
nRMSE_f4r12=RMSE_f4r12/(mean(wheat_f4r12_yield));
%%
wheat_f5r12_x=table2array(excel_yield_et(927:944,"x1_et_max"));
wheat_f5r12_y=table2array(excel_yield_et(927:944,"x1_yield_max"));
wheat_f5r12_yield=table2array(excel_yield_et(927:944,"yield"));
wheat_f5r12_et=table2array(excel_yield_et(927:944,"et"));

model_f5r12=@(k,wheat_f5r12_x) k*(wheat_f5r12_x.*wheat_f5r12_x);

beta0=1;

[beta1_f5r12,resnorm]=lsqcurvefit(model_f5r12,beta0,wheat_f5r12_x,wheat_f5r12_y);

wheat_f5r12_yfit=model_f5r12(beta1_f5r12,wheat_f5r12_x);
wheat_f5r12_yfit1=max(wheat_f5r12_yield)*(1-wheat_f5r12_yfit);
c1=max(wheat_f5r12_et)*max(wheat_f5r12_et);
c2_r12=(beta1_f5r12*max(wheat_f5r12_yield))/c1;
xy=[wheat_f5r12_et,wheat_f5r12_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[69/255,156/255,215/255],'LineWidth',1,'LineStyle','--')
hold off
%R2
SSresid=sum((wheat_f5r12_y-wheat_f5r12_yfit).^2);
SStotal=sum((wheat_f5r12_y-mean(wheat_f5r12_y)).^2);
R2_f5r12=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f5r12_yield-wheat_f5r12_yfit1).^2);
RMSE_f5r12=(SSresid1/size(wheat_f5r12_yield,1))^0.5;
nRMSE_f5r12=RMSE_f5r12/(mean(wheat_f5r12_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r11_0304';
print(figure(12),filepath_save,'-dpng','-r1000')
print(figure(12),filepath_save,'-djpeg','-r1000')

%%
%region13
wheat_f1r13_x=table2array(excel_yield_et(945:959,"x1_et_max"));
wheat_f1r13_y=table2array(excel_yield_et(945:959,"x1_yield_max"));
wheat_f1r13_yield=table2array(excel_yield_et(945:959,"yield"));
wheat_f1r13_et=table2array(excel_yield_et(945:959,"et"));

model_f1r13=@(k,wheat_f1r13_x) k*wheat_f1r13_x;

beta0=1;

[beta1_f1r13,resnorm]=lsqcurvefit(model_f1r13,beta0,wheat_f1r13_x,wheat_f1r13_y);

wheat_f1r13_yfit=model_f1r13(beta1_f1r13,wheat_f1r13_x);
wheat_f1r13_yfit1=max(wheat_f1r13_yield)*(1-wheat_f1r13_yfit);

%figure
figure(13)
plot(wheat_f1r13_et,wheat_f1r13_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f1r13_et,wheat_f1r13_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r13_et)-100;
axis2=max(wheat_f1r13_et)+100;
axis3=min(wheat_f1r13_yield)-500;
axis4=max(wheat_f1r13_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.1+axis1;
texty=(axis4-axis3)*0.9+axis3;
title("Maize Sub-region 7",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r13_y-wheat_f1r13_yfit).^2);
SStotal=sum((wheat_f1r13_y-mean(wheat_f1r13_y)).^2);
R2_f1r13=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r13_yield-wheat_f1r13_yfit1).^2);
RMSE_f1r13=(SSresid1/size(wheat_f1r13_yield,1))^0.5;
nRMSE_f1r13=RMSE_f1r13/(mean(wheat_f1r13_yield));
%%
wheat_f2r13_x=table2array(excel_yield_et(945:959,"et_max"));
wheat_f2r13_y=table2array(excel_yield_et(945:959,"yield_max"));
wheat_f2r13_yield=table2array(excel_yield_et(945:959,"yield"));
wheat_f2r13_et=table2array(excel_yield_et(945:959,"et"));

wheat_f2r13_yfit=wheat_f2r13_x;
wheat_f2r13_yfit1=max(wheat_f2r13_yield)*wheat_f2r13_yfit;

xy=[wheat_f2r13_et,wheat_f2r13_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[226/255,83/255,61/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f2r13_y-wheat_f2r13_yfit).^2);
SStotal=sum((wheat_f2r13_y-mean(wheat_f2r13_y)).^2);
R2_f2r13=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f2r13_yield-wheat_f2r13_yfit1).^2);
RMSE_f2r13=(SSresid1/size(wheat_f2r13_yield,1))^0.5;
nRMSE_f2r13=RMSE_f2r13/(mean(wheat_f2r13_yield));
%%
wheat_f3r13_x=table2array(excel_yield_et(945:959,"x1_et_max"));
wheat_f3r13_y=table2array(excel_yield_et(945:959,"yield"));
wheat_f3r13_yield=table2array(excel_yield_et(945:959,"yield"));
wheat_f3r13_et=table2array(excel_yield_et(945:959,"et"));

model_f3r13=@(b,wheat_f3r13_x) b(1)+b(2)*(1-wheat_f3r13_x.*wheat_f3r13_x);

beta0=[0,0];

[beta1_f3r13,resnorm]=lsqcurvefit(model_f3r13,beta0,wheat_f3r13_x,wheat_f3r13_y);

wheat_f3r13_yfit=model_f3r13(beta1_f3r13,wheat_f3r13_x);
wheat_f3r13_yfit1=wheat_f3r13_yfit;

xy=[wheat_f3r13_et,wheat_f3r13_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[249/255,228/255,169/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f3r13_y-wheat_f3r13_yfit).^2);
SStotal=sum((wheat_f3r13_y-mean(wheat_f3r13_y)).^2);
R2_f3r13=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r13_yield-wheat_f3r13_yfit1).^2);
RMSE_f3r13=(SSresid1/size(wheat_f3r13_yield,1))^0.5;
nRMSE_f3r13=RMSE_f3r13/(mean(wheat_f3r13_yield));
%%
wheat_f4r13_yield=table2array(excel_yield_et(945:959,"yield"));
wheat_f4r13_et=table2array(excel_yield_et(945:959,"et"));

xx=wheat_f4r13_et;
yy=wheat_f4r13_yield;

maxyield=max(wheat_f4r13_yield);
et50_r13=(max(wheat_f4r13_et)/2);

model_f4r13=@(k,wheat_f4r13_et) maxyield*((wheat_f4r13_et.^k)./((et50_r13.^k)+(wheat_f4r13_et.^k)));

beta0=1;
[beta1_f4r13,resnorm]=lsqcurvefit(model_f4r13,beta0,wheat_f4r13_et,wheat_f4r13_yield);

wheat_f4r13_yfit=model_f4r13(beta1_f4r13,wheat_f4r13_et);

xy=[wheat_f4r13_et,wheat_f4r13_yfit];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[178/255,223/255,227/255],'LineWidth',1,'LineStyle','--')

%R2
SSresid=sum((wheat_f4r13_yield-wheat_f4r13_yfit).^2);
SStotal=sum((wheat_f4r13_yield-mean(wheat_f4r13_yield)).^2);
R2_f4r13=1-(SSresid/SStotal);


%RMSE
RMSE_f4r13=(SSresid/size(wheat_f4r13_yield,1))^0.5;
nRMSE_f4r13=RMSE_f4r13/(mean(wheat_f4r13_yield));
%%
wheat_f5r13_x=table2array(excel_yield_et(945:959,"x1_et_max"));
wheat_f5r13_y=table2array(excel_yield_et(945:959,"x1_yield_max"));
wheat_f5r13_yield=table2array(excel_yield_et(945:959,"yield"));
wheat_f5r13_et=table2array(excel_yield_et(945:959,"et"));

model_f5r13=@(k,wheat_f5r13_x) k*(wheat_f5r13_x.*wheat_f5r13_x);

beta0=1;

[beta1_f5r13,resnorm]=lsqcurvefit(model_f5r13,beta0,wheat_f5r13_x,wheat_f5r13_y);

wheat_f5r13_yfit=model_f5r13(beta1_f5r13,wheat_f5r13_x);
wheat_f5r13_yfit1=max(wheat_f5r13_yield)*(1-wheat_f5r13_yfit);
c1=max(wheat_f5r13_et)*max(wheat_f5r13_et);
c2_r13=(beta1_f5r13*max(wheat_f5r13_yield))/c1;
xy=[wheat_f5r13_et,wheat_f5r13_yfit1];
sortxy=sortrows(xy);
plot(sortxy(:,1),sortxy(:,2),'Color',[69/255,156/255,215/255],'LineWidth',1,'LineStyle','--')
hold off
%R2
SSresid=sum((wheat_f5r13_y-wheat_f5r13_yfit).^2);
SStotal=sum((wheat_f5r13_y-mean(wheat_f5r13_y)).^2);
R2_f5r13=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f5r13_yield-wheat_f5r13_yfit1).^2);
RMSE_f5r13=(SSresid1/size(wheat_f5r13_yield,1))^0.5;
nRMSE_f5r13=RMSE_f5r13/(mean(wheat_f5r13_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r12_0304';
print(figure(13),filepath_save,'-dpng','-r1000')
print(figure(13),filepath_save,'-djpeg','-r1000')
clear
clc
filename="D:\yellow river water comsumption\yield_et_fit_new.xlsx";
excel_yield_et=readtable(filename);
%%
alpha=0.1;
%wheat region1
wheat_f3r1_x=table2array(excel_yield_et(1:27,"x1_et_max"));
wheat_f3r1_y=table2array(excel_yield_et(1:27,"yield"));
wheat_f3r1_yield=table2array(excel_yield_et(1:27,"yield"));
wheat_f3r1_et=table2array(excel_yield_et(1:27,"et"));

model_f3r1=@(b,wheat_f3r1_x) b(1)+b(2)*(1-wheat_f3r1_x.*wheat_f3r1_x);

beta0=[0,0];

[beta1_f3r1,resnorm]=lsqcurvefit(model_f3r1,beta0,wheat_f3r1_x,wheat_f3r1_y);

wheat_f3r1_yfit=model_f3r1(beta1_f3r1,wheat_f3r1_x);
wheat_f3r1_yfit1=wheat_f3r1_yfit;

%%%-----------------------------------------------------------------------------
%confidence intervals
MSE=resnorm/length(wheat_f3r1_x);
sqsx=[];
res=[];
for i=1:length(wheat_f3r1_x)
    sqsx(i)=(wheat_f3r1_x(i)-mean(wheat_f3r1_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f3r1_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f3r1_x)+(wheat_f3r1_x(j)-mean(wheat_f3r1_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f3r1_y)-length(beta1_f3r1));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f3r1_x)
    y_max(k,1)=wheat_f3r1_yfit(k)+ci(k);
    y_min(k,1)=wheat_f3r1_yfit(k)-ci(k);
end

%%%-----------------------------------------------------------------------------
%figure
figure(1)
plot(wheat_f3r1_et,wheat_f3r1_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f3r1_et,wheat_f3r1_yfit1];
xy_max=[wheat_f3r1_et,y_max];
xy_min=[wheat_f3r1_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f3r1_et)-100;
axis2=max(wheat_f3r1_et)+100;
axis3=min(wheat_f3r1_yield)-500;
axis4=max(wheat_f3r1_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.1652','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=539.8 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title('Wheat Sub-region 1','FontSize',32,'FontName','Times New Roman')
%R2
SSresid=sum((wheat_f3r1_y-wheat_f3r1_yfit).^2);
SStotal=sum((wheat_f3r1_y-mean(wheat_f3r1_y)).^2);
R2_f3r1=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r1_yield-wheat_f3r1_yfit1).^2);
RMSE_f3r1=(SSresid1/size(wheat_f3r1_yield,1))^0.5;
nRMSE_f3r1=RMSE_f3r1/(mean(wheat_f3r1_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\wheat_r1_uncertainty_0304';
print(figure(1),filepath_save,'-dpng','-r1000')
print(figure(1),filepath_save,'-djpeg','-r1000')

%%
%region2
wheat_f3r2_x=table2array(excel_yield_et(28:42,"x1_et_max"));
wheat_f3r2_y=table2array(excel_yield_et(28:42,"yield"));
wheat_f3r2_yield=table2array(excel_yield_et(28:42,"yield"));
wheat_f3r2_et=table2array(excel_yield_et(28:42,"et"));

model_f3r2=@(b,wheat_f3r2_x) b(1)+b(2)*(1-wheat_f3r2_x.*wheat_f3r2_x);

beta0=[0,0];

[beta1_f3r2,resnorm]=lsqcurvefit(model_f3r2,beta0,wheat_f3r2_x,wheat_f3r2_y);


wheat_f3r2_yfit=model_f3r2(beta1_f3r2,wheat_f3r2_x);
wheat_f3r2_yfit1=wheat_f3r2_yfit;

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f3r2_x);
sqsx=[];
res=[];
for i=1:length(wheat_f3r2_x)
    sqsx(i)=(wheat_f3r2_x(i)-mean(wheat_f3r2_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f3r2_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f3r2_x)+(wheat_f3r2_x(j)-mean(wheat_f3r2_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f3r2_y)-length(beta1_f3r2));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f3r2_x)
    y_max(k,1)=wheat_f3r2_yfit(k)+ci(k);
    y_min(k,1)=wheat_f3r2_yfit(k)-ci(k);
end

%%%-----------------------------------------------------------------------------
%figure
figure(2)
plot(wheat_f3r2_et,wheat_f3r2_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f3r2_et,wheat_f3r2_yfit1];
xy_max=[wheat_f3r2_et,y_max];
xy_min=[wheat_f3r2_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f3r2_et)-100;
axis2=max(wheat_f3r2_et)+100;
axis3=min(wheat_f3r2_yield)-500;
axis4=max(wheat_f3r2_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.3294','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=932.5 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title('Wheat Sub-region 2','FontSize',32,'FontName','Times New Roman')
%R2
SSresid=sum((wheat_f3r2_y-wheat_f3r2_yfit).^2);
SStotal=sum((wheat_f3r2_y-mean(wheat_f3r2_y)).^2);
R2_f3r2=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r2_yield-wheat_f3r2_yfit1).^2);
RMSE_f3r2=(SSresid1/size(wheat_f3r2_yield,1))^0.5;
nRMSE_f3r2=RMSE_f3r2/(mean(wheat_f3r2_yield));

%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\wheat_r2_uncertainty_0304';
print(figure(2),filepath_save,'-dpng','-r1000')
print(figure(2),filepath_save,'-djpeg','-r1000')

%%
%region3
wheat_f1r4_x=table2array(excel_yield_et(43:62,"x1_et_max"));
wheat_f1r4_y=table2array(excel_yield_et(43:62,"x1_yield_max"));
wheat_f1r4_yield=table2array(excel_yield_et(43:62,"yield"));
wheat_f1r4_et=table2array(excel_yield_et(43:62,"et"));

model_f1r4=@(k,wheat_f1r4_x) k*wheat_f1r4_x;

beta0=1;

[beta1_f1r4,resnorm]=lsqcurvefit(model_f1r4,beta0,wheat_f1r4_x,wheat_f1r4_y);

wheat_f1r4_yfit=model_f1r4(beta1_f1r4,wheat_f1r4_x);
wheat_f1r4_yfit1=max(wheat_f1r4_yield)*(1-wheat_f1r4_yfit);


%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f1r4_x);
sqsx=[];
res=[];
for i=1:length(wheat_f1r4_x)
    sqsx(i)=(wheat_f1r4_x(i)-mean(wheat_f1r4_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f1r4_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f1r4_x)+(wheat_f1r4_x(j)-mean(wheat_f1r4_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f1r4_x)-length(beta1_f1r4));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f1r4_x)
    ymax=wheat_f1r4_yfit(k)+ci(k);
    ymin=wheat_f1r4_yfit(k)-ci(k);
    y_max(k,1)=max(wheat_f1r4_yield)*(1-ymin);
    y_min(k,1)=max(wheat_f1r4_yield)*(1-ymax);
end

%%%-----------------------------------------------------------------------------
%figure
figure(3)
plot(wheat_f1r4_et,wheat_f1r4_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r4_et,wheat_f1r4_yfit1];
xy_max=[wheat_f1r4_et,y_max];
xy_min=[wheat_f1r4_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r4_et)-100;
axis2=max(wheat_f1r4_et)+100;
axis3=min(wheat_f1r4_yield)-500;
axis4=max(wheat_f1r4_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.6992','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=687.3 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Wheat Sub-region 4",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r4_y-wheat_f1r4_yfit).^2);
SStotal=sum((wheat_f1r4_y-mean(wheat_f1r4_y)).^2);
R2_f1r4=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r4_yield-wheat_f1r4_yfit1).^2);
RMSE_f1r4=(SSresid1/size(wheat_f1r4_yield,1))^0.5;
nRMSE_f1r4=RMSE_f1r4/(mean(wheat_f1r4_yield));

%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\wheat_r3_uncertainty_0304';
print(figure(3),filepath_save,'-dpng','-r1000')
print(figure(3),filepath_save,'-djpeg','-r1000')

%%
%region4
wheat_f3r5_x=table2array(excel_yield_et(63:145,"x1_et_max"));
wheat_f3r5_y=table2array(excel_yield_et(63:145,"yield"));
wheat_f3r5_yield=table2array(excel_yield_et(63:145,"yield"));
wheat_f3r5_et=table2array(excel_yield_et(63:145,"et"));

model_f3r5=@(b,wheat_f3r5_x) b(1)+b(2)*(1-wheat_f3r5_x.*wheat_f3r5_x);

beta0=[0,0];

[beta1_f3r5,resnorm]=lsqcurvefit(model_f3r5,beta0,wheat_f3r5_x,wheat_f3r5_y);

wheat_f3r5_yfit=model_f3r5(beta1_f3r5,wheat_f3r5_x);
wheat_f3r5_yfit1=wheat_f3r5_yfit;

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f3r5_x);
sqsx=[];
res=[];
for i=1:length(wheat_f3r5_x)
    sqsx(i)=(wheat_f3r5_x(i)-mean(wheat_f3r5_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f3r5_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f3r5_x)+(wheat_f3r5_x(j)-mean(wheat_f3r5_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f3r5_y)-length(beta1_f3r5));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f3r5_x)
    y_max(k,1)=wheat_f3r5_yfit(k)+ci(k);
    y_min(k,1)=wheat_f3r5_yfit(k)-ci(k);
end

%%%-----------------------------------------------------------------------------
%figure
figure(4)
plot(wheat_f3r5_et,wheat_f3r5_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f3r5_et,wheat_f3r5_yfit1];
xy_max=[wheat_f3r5_et,y_max];
xy_min=[wheat_f3r5_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f3r5_et)-100;
axis2=max(wheat_f3r5_et)+100;
axis3=min(wheat_f3r5_yield)-500;
axis4=max(wheat_f3r5_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.4413','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=1533.6 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Wheat Sub-region 5",'FontSize',32,'FontName','Times New Roman')
%R2
SSresid=sum((wheat_f3r5_y-wheat_f3r5_yfit).^2);
SStotal=sum((wheat_f3r5_y-mean(wheat_f3r5_y)).^2);
R2_f3r5=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r5_yield-wheat_f3r5_yfit1).^2);
RMSE_f3r5=(SSresid1/size(wheat_f3r5_yield,1))^0.5;
nRMSE_f3r5=RMSE_f3r5/(mean(wheat_f3r5_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\wheat_r4_uncertainty_0304';
print(figure(4),filepath_save,'-dpng','-r1000')
print(figure(4),filepath_save,'-djpeg','-r1000')

%%
%region5
wheat_f1r6_x=table2array(excel_yield_et(146:172,"x1_et_max"));
wheat_f1r6_y=table2array(excel_yield_et(146:172,"x1_yield_max"));
wheat_f1r6_yield=table2array(excel_yield_et(146:172,"yield"));
wheat_f1r6_et=table2array(excel_yield_et(146:172,"et"));

model_f1r6=@(k,wheat_f1r6_x) k*wheat_f1r6_x;

beta0=1;

[beta1_f1r6,resnorm]=lsqcurvefit(model_f1r6,beta0,wheat_f1r6_x,wheat_f1r6_y);

wheat_f1r6_yfit=model_f1r6(beta1_f1r6,wheat_f1r6_x);
wheat_f1r6_yfit1=max(wheat_f1r6_yield)*(1-wheat_f1r6_yfit);

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f1r6_x);
sqsx=[];
res=[];
for i=1:length(wheat_f1r6_x)
    sqsx(i)=(wheat_f1r6_x(i)-mean(wheat_f1r6_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f1r6_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f1r6_x)+(wheat_f1r6_x(j)-mean(wheat_f1r6_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f1r6_y)-length(beta1_f1r6));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f1r6_x)
    ymax=wheat_f1r6_yfit(k)+ci(k);
    ymin=wheat_f1r6_yfit(k)-ci(k);
    y_max(k,1)=max(wheat_f1r6_yield)*(1-ymin);
    y_min(k,1)=max(wheat_f1r6_yield)*(1-ymax);
end

%%%-----------------------------------------------------------------------------
%figure
figure(5)
plot(wheat_f1r6_et,wheat_f1r6_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r6_et,wheat_f1r6_yfit1];
xy_max=[wheat_f1r6_et,y_max];
xy_min=[wheat_f1r6_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')


axis1=min(wheat_f1r6_et)-100;
axis2=max(wheat_f1r6_et)+100;
axis3=min(wheat_f1r6_yield)-500;
axis4=max(wheat_f1r6_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.9186','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=447.7 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Wheat Sub-region 6",'FontSize',32,'FontName','Times New Roman')
%R2
SSresid=sum((wheat_f1r6_y-wheat_f1r6_yfit).^2);
SStotal=sum((wheat_f1r6_y-mean(wheat_f1r6_y)).^2);
R2_f1r6=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r6_yield-wheat_f1r6_yfit1).^2);
RMSE_f1r6=(SSresid1/size(wheat_f1r6_yield,1))^0.5;
nRMSE_f1r6=RMSE_f1r6/(mean(wheat_f1r6_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\wheat_r5_uncertainty_0304';
print(figure(5),filepath_save,'-dpng','-r1000')
print(figure(5),filepath_save,'-djpeg','-r1000')

%%
%region6
wheat_f1r7_x=table2array(excel_yield_et(173:210,"x1_et_max"));
wheat_f1r7_y=table2array(excel_yield_et(173:210,"x1_yield_max"));
wheat_f1r7_yield=table2array(excel_yield_et(173:210,"yield"));
wheat_f1r7_et=table2array(excel_yield_et(173:210,"et"));

model_f1r7=@(k,wheat_f1r7_x) k*wheat_f1r7_x;

beta0=1;

[beta1_f1r7,resnorm]=lsqcurvefit(model_f1r7,beta0,wheat_f1r7_x,wheat_f1r7_y);

wheat_f1r7_yfit=model_f1r7(beta1_f1r7,wheat_f1r7_x);
wheat_f1r7_yfit1=max(wheat_f1r7_yield)*(1-wheat_f1r7_yfit);

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f1r7_x);
sqsx=[];
res=[];
for i=1:length(wheat_f1r7_x)
    sqsx(i)=(wheat_f1r7_x(i)-mean(wheat_f1r7_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f1r7_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f1r7_x)+(wheat_f1r7_x(j)-mean(wheat_f1r7_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f1r7_y)-length(beta1_f1r7));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f1r7_x)
    ymax=wheat_f1r7_yfit(k)+ci(k);
    ymin=wheat_f1r7_yfit(k)-ci(k);
    y_max(k,1)=max(wheat_f1r7_yield)*(1-ymin);
    y_min(k,1)=max(wheat_f1r7_yield)*(1-ymax);
end

%%%-----------------------------------------------------------------------------
%figure
figure(6)
plot(wheat_f1r7_et,wheat_f1r7_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r7_et,wheat_f1r7_yfit1];
xy_max=[wheat_f1r7_et,y_max];
xy_min=[wheat_f1r7_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')


axis1=min(wheat_f1r7_et)-100;
axis2=max(wheat_f1r7_et)+100;
axis3=min(wheat_f1r7_yield)-500;
axis4=max(wheat_f1r7_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.2535','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=1054.7 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Wheat Sub-region 7",'FontSize',32,'FontName','Times New Roman')
%R2
SSresid=sum((wheat_f1r7_y-wheat_f1r7_yfit).^2);
SStotal=sum((wheat_f1r7_y-mean(wheat_f1r7_y)).^2);
R2_f1r6=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r7_yield-wheat_f1r7_yfit1).^2);
RMSE_f1r7=(SSresid1/size(wheat_f1r7_yield,1))^0.5;
nRMSE_f1r7=RMSE_f1r7/(mean(wheat_f1r7_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\wheat_r6_uncertainty_0304';
print(figure(6),filepath_save,'-dpng','-r1000')
print(figure(6),filepath_save,'-djpeg','-r1000')

%%
%region7
wheat_f1r8_x=table2array(excel_yield_et(211:221,"x1_et_max"));
wheat_f1r8_y=table2array(excel_yield_et(211:221,"x1_yield_max"));
wheat_f1r8_yield=table2array(excel_yield_et(211:221,"yield"));
wheat_f1r8_et=table2array(excel_yield_et(211:221,"et"));

model_f1r8=@(k,wheat_f1r8_x) k*wheat_f1r8_x;

beta0=1;

[beta1_f1r8,resnorm]=lsqcurvefit(model_f1r8,beta0,wheat_f1r8_x,wheat_f1r8_y);

wheat_f1r8_yfit=model_f1r8(beta1_f1r8,wheat_f1r8_x);
wheat_f1r8_yfit1=max(wheat_f1r8_yield)*(1-wheat_f1r8_yfit);

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f1r8_x);
sqsx=[];
res=[];
for i=1:length(wheat_f1r8_x)
    sqsx(i)=(wheat_f1r8_x(i)-mean(wheat_f1r8_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f1r8_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f1r8_x)+(wheat_f1r8_x(j)-mean(wheat_f1r8_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f1r8_y)-length(beta1_f1r8));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f1r8_x)
    ymax=wheat_f1r8_yfit(k)+ci(k);
    ymin=wheat_f1r8_yfit(k)-ci(k);
    y_max(k,1)=max(wheat_f1r8_yield)*(1-ymin);
    y_min(k,1)=max(wheat_f1r8_yield)*(1-ymax);
end

%%%-----------------------------------------------------------------------------
%figure
figure(7)
plot(wheat_f1r8_et,wheat_f1r8_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r8_et,wheat_f1r8_yfit1];
xy_max=[wheat_f1r8_et,y_max];
xy_min=[wheat_f1r8_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')


axis1=min(wheat_f1r8_et)-100;
axis2=max(wheat_f1r8_et)+100;
axis3=min(wheat_f1r8_yield)-500;
axis4=max(wheat_f1r8_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.5480','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=901.2 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Wheat Sub-region 8",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r8_y-wheat_f1r8_yfit).^2);
SStotal=sum((wheat_f1r8_y-mean(wheat_f1r8_y)).^2);
R2_f1r7=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r8_yield-wheat_f1r8_yfit1).^2);
RMSE_f1r8=(SSresid1/size(wheat_f1r8_yield,1))^0.5;
nRMSE_f1r8=RMSE_f1r8/(mean(wheat_f1r8_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\wheat_r7_uncertainty_0304';
print(figure(7),filepath_save,'-dpng','-r1000')
print(figure(7),filepath_save,'-djpeg','-r1000')

%%
%region 8
wheat_f3r9_x=table2array(excel_yield_et(222:263,"x1_et_max"));
wheat_f3r9_y=table2array(excel_yield_et(222:263,"yield"));
wheat_f3r9_yield=table2array(excel_yield_et(222:263,"yield"));
wheat_f3r9_et=table2array(excel_yield_et(222:263,"et"));

model_f3r9=@(b,wheat_f3r9_x) b(1)+b(2)*(1-wheat_f3r9_x.*wheat_f3r9_x);

beta0=[0,0];

[beta1_f3r9,resnorm]=lsqcurvefit(model_f3r9,beta0,wheat_f3r9_x,wheat_f3r9_y);

wheat_f3r9_yfit=model_f3r9(beta1_f3r9,wheat_f3r9_x);
wheat_f3r9_yfit1=wheat_f3r9_yfit;

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f3r9_x);
sqsx=[];
res=[];
for i=1:length(wheat_f3r9_x)
    sqsx(i)=(wheat_f3r9_x(i)-mean(wheat_f3r9_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f3r9_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f3r9_x)+(wheat_f3r9_x(j)-mean(wheat_f3r9_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f3r9_y)-length(beta1_f3r9));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f3r9_x)
    y_max(k,1)=wheat_f3r9_yfit(k)+ci(k);
    y_min(k,1)=wheat_f3r9_yfit(k)-ci(k);
end

%%%-----------------------------------------------------------------------------
%figure
figure(8)
plot(wheat_f3r9_et,wheat_f3r9_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f3r9_et,wheat_f3r9_yfit1];
xy_max=[wheat_f3r9_et,y_max];
xy_min=[wheat_f3r9_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f3r9_et)-100;
axis2=max(wheat_f3r9_et)+100;
axis3=min(wheat_f3r9_yield)-500;
axis4=max(wheat_f3r9_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.6025','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=1065.0 kg/hm^2','FontSize',28,'FontName','Times New Roman')


title("Wheat Sub-region 9",'FontSize',32,'FontName','Times New Roman')
%R2
SSresid=sum((wheat_f3r9_y-wheat_f3r9_yfit).^2);
SStotal=sum((wheat_f3r9_y-mean(wheat_f3r9_y)).^2);
R2_f3r9=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r9_yield-wheat_f3r9_yfit1).^2);
RMSE_f3r9=(SSresid1/size(wheat_f3r9_yield,1))^0.5;
nRMSE_f3r9=RMSE_f3r9/(mean(wheat_f3r9_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\wheat_r8_uncertainty_0304';
print(figure(8),filepath_save,'-dpng','-r1000')
print(figure(8),filepath_save,'-djpeg','-r1000')

%%
wheat_f3r10_x=table2array(excel_yield_et(264:327,"x1_et_max"));
wheat_f3r10_y=table2array(excel_yield_et(264:327,"yield"));
wheat_f3r10_yield=table2array(excel_yield_et(264:327,"yield"));
wheat_f3r10_et=table2array(excel_yield_et(264:327,"et"));

model_f3r10=@(b,wheat_f3r10_x) b(1)+b(2)*(1-wheat_f3r10_x.*wheat_f3r10_x);

beta0=[0,0];

[beta1_f3r10,resnorm]=lsqcurvefit(model_f3r10,beta0,wheat_f3r10_x,wheat_f3r10_y);

wheat_f3r10_yfit=model_f3r10(beta1_f3r10,wheat_f3r10_x);
wheat_f3r10_yfit1=wheat_f3r10_yfit;

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f3r10_x);
sqsx=[];
res=[];
for i=1:length(wheat_f3r10_x)
    sqsx(i)=(wheat_f3r10_x(i)-mean(wheat_f3r10_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f3r10_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f3r10_x)+(wheat_f3r10_x(j)-mean(wheat_f3r10_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f3r10_y)-length(beta1_f3r10));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f3r10_x)
    y_max(k,1)=wheat_f3r10_yfit(k)+ci(k);
    y_min(k,1)=wheat_f3r10_yfit(k)-ci(k);
end

%%%-----------------------------------------------------------------------------
%figure
figure(9)
plot(wheat_f3r10_et,wheat_f3r10_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f3r10_et,wheat_f3r10_yfit1];
xy_max=[wheat_f3r10_et,y_max];
xy_min=[wheat_f3r10_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f3r10_et)-100;
axis2=max(wheat_f3r10_et)+100;
axis3=min(wheat_f3r10_yield)-500;
axis4=max(wheat_f3r10_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.3180','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=888.9 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Wheat Sub-region 11",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f3r10_y-wheat_f3r10_yfit).^2);
SStotal=sum((wheat_f3r10_y-mean(wheat_f3r10_y)).^2);
R2_f3r10=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r10_yield-wheat_f3r10_yfit1).^2);
RMSE_f3r10=(SSresid1/size(wheat_f3r10_yield,1))^0.5;
nRMSE_f3r10=RMSE_f3r10/(mean(wheat_f3r10_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\wheat_r9_uncertainty_0304';
print(figure(9),filepath_save,'-dpng','-r1000')
print(figure(9),filepath_save,'-djpeg','-r1000')

%%
%region10
wheat_f1r11_x=table2array(excel_yield_et(328:335,"x1_et_max"));
wheat_f1r11_y=table2array(excel_yield_et(328:335,"x1_yield_max"));
wheat_f1r11_yield=table2array(excel_yield_et(328:335,"yield"));
wheat_f1r11_et=table2array(excel_yield_et(328:335,"et"));

model_f1r11=@(k,wheat_f1r11_x) k*wheat_f1r11_x;

beta0=1;

[beta1_f1r11,resnorm]=lsqcurvefit(model_f1r11,beta0,wheat_f1r11_x,wheat_f1r11_y);

wheat_f1r11_yfit=model_f1r11(beta1_f1r11,wheat_f1r11_x);
wheat_f1r11_yfit1=max(wheat_f1r11_yield)*(1-wheat_f1r11_yfit);

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f1r11_x);
sqsx=[];
res=[];
for i=1:length(wheat_f1r11_x)
    sqsx(i)=(wheat_f1r11_x(i)-mean(wheat_f1r11_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f1r11_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f1r11_x)+(wheat_f1r11_x(j)-mean(wheat_f1r11_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f1r11_y)-length(beta1_f1r11));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f1r11_x)
    ymax=wheat_f1r11_yfit(k)+ci(k);
    ymin=wheat_f1r11_yfit(k)-ci(k);
    y_max(k,1)=max(wheat_f1r11_yield)*(1-ymin);
    y_min(k,1)=max(wheat_f1r11_yield)*(1-ymax);
end

%%%-----------------------------------------------------------------------------
%figure
figure(10)
plot(wheat_f1r11_et,wheat_f1r11_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r11_et,wheat_f1r11_yfit1];
xy_max=[wheat_f1r11_et,y_max];
xy_min=[wheat_f1r11_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')


axis1=min(wheat_f1r11_et)-100;
axis2=max(wheat_f1r11_et)+100;
axis3=min(wheat_f1r11_yield)-500;
axis4=max(wheat_f1r11_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.8885','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=208.5 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Wheat Sub-region 12",'FontSize',32,'FontName','Times New Roman')
%R2
SSresid=sum((wheat_f1r11_y-wheat_f1r11_yfit).^2);
SStotal=sum((wheat_f1r11_y-mean(wheat_f1r11_y)).^2);
R2_f1r11=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r11_yield-wheat_f1r11_yfit1).^2);
RMSE_f1r11=(SSresid1/size(wheat_f1r11_yield,1))^0.5;
nRMSE_f1r11=RMSE_f1r11/(mean(wheat_f1r11_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\wheat_r10_uncertainty_0304';
print(figure(10),filepath_save,'-dpng','-r1000')
print(figure(10),filepath_save,'-djpeg','-r1000')

%%
%region11
wheat_f1r12_x=table2array(excel_yield_et(336:415,"x1_et_max"));
wheat_f1r12_y=table2array(excel_yield_et(336:415,"x1_yield_max"));
wheat_f1r12_yield=table2array(excel_yield_et(336:415,"yield"));
wheat_f1r12_et=table2array(excel_yield_et(336:415,"et"));

model_f1r12=@(k,wheat_f1r12_x) k*wheat_f1r12_x;

beta0=1;

[beta1_f1r12,resnorm]=lsqcurvefit(model_f1r12,beta0,wheat_f1r12_x,wheat_f1r12_y);

wheat_f1r12_yfit=model_f1r12(beta1_f1r12,wheat_f1r12_x);
wheat_f1r12_yfit1=max(wheat_f1r12_yield)*(1-wheat_f1r12_yfit);

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f1r12_x);
sqsx=[];
res=[];
for i=1:length(wheat_f1r12_x)
    sqsx(i)=(wheat_f1r12_x(i)-mean(wheat_f1r12_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f1r12_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f1r12_x)+(wheat_f1r12_x(j)-mean(wheat_f1r12_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f1r12_y)-length(beta1_f1r12));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f1r12_x)
    ymax=wheat_f1r12_yfit(k)+ci(k);
    ymin=wheat_f1r12_yfit(k)-ci(k);
    y_max(k,1)=max(wheat_f1r12_yield)*(1-ymin);
    y_min(k,1)=max(wheat_f1r12_yield)*(1-ymax);
end

%%%-----------------------------------------------------------------------------
%figure
figure(11)
plot(wheat_f1r12_et,wheat_f1r12_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r12_et,wheat_f1r12_yfit1];
xy_max=[wheat_f1r12_et,y_max];
xy_min=[wheat_f1r12_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')


axis1=min(wheat_f1r12_et)-100;
axis2=max(wheat_f1r12_et)+100;
axis3=min(wheat_f1r12_yield)-500;
axis4=max(wheat_f1r12_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.4512','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=822.7 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Wheat Sub-region 10",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r12_y-wheat_f1r12_yfit).^2);
SStotal=sum((wheat_f1r12_y-mean(wheat_f1r12_y)).^2);
R2_f1r12=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r12_yield-wheat_f1r12_yfit1).^2);
RMSE_f1r12=(SSresid1/size(wheat_f1r12_yield,1))^0.5;
nRMSE_f1r12=RMSE_f1r12/(mean(wheat_f1r12_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\wheat_r11_uncertainty_0304';
print(figure(11),filepath_save,'-dpng','-r1000')
print(figure(11),filepath_save,'-djpeg','-r1000')

%%
%region12
wheat_f1r13_x=table2array(excel_yield_et(416:422,"x1_et_max"));
wheat_f1r13_y=table2array(excel_yield_et(416:422,"x1_yield_max"));
wheat_f1r13_yield=table2array(excel_yield_et(416:422,"yield"));
wheat_f1r13_et=table2array(excel_yield_et(416:422,"et"));

model_f1r13=@(k,wheat_f1r13_x) k*wheat_f1r13_x;

beta0=1;

[beta1_f1r13,resnorm]=lsqcurvefit(model_f1r13,beta0,wheat_f1r13_x,wheat_f1r13_y);

wheat_f1r13_yfit=model_f1r13(beta1_f1r13,wheat_f1r13_x);
wheat_f1r13_yfit1=max(wheat_f1r13_yield)*(1-wheat_f1r13_yfit);

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f1r13_x);
sqsx=[];
res=[];
for i=1:length(wheat_f1r13_x)
    sqsx(i)=(wheat_f1r13_x(i)-mean(wheat_f1r13_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f1r13_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f1r13_x)+(wheat_f1r13_x(j)-mean(wheat_f1r13_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f1r13_y)-length(beta1_f1r13));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f1r13_x)
    ymax=wheat_f1r13_yfit(k)+ci(k);
    ymin=wheat_f1r13_yfit(k)-ci(k);
    y_max(k,1)=max(wheat_f1r13_yield)*(1-ymin);
    y_min(k,1)=max(wheat_f1r13_yield)*(1-ymax);
end

%%%-----------------------------------------------------------------------------
%figure
figure(12)
plot(wheat_f1r13_et,wheat_f1r13_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r13_et,wheat_f1r13_yfit1];
xy_max=[wheat_f1r13_et,y_max];
xy_min=[wheat_f1r13_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')


axis1=min(wheat_f1r13_et)-100;
axis2=max(wheat_f1r13_et)+100;
axis3=min(wheat_f1r13_yield)-500;
axis4=max(wheat_f1r13_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.6243','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=717.1 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Wheat Sub-region 3",'FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r13_y-wheat_f1r13_yfit).^2);
SStotal=sum((wheat_f1r13_y-mean(wheat_f1r13_y)).^2);
R2_f1r13=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r13_yield-wheat_f1r13_yfit1).^2);
RMSE_f1r13=(SSresid1/size(wheat_f1r13_yield,1))^0.5;
nRMSE_f1r13=RMSE_f1r13/(mean(wheat_f1r13_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\wheat_r12_uncertainty_0304';
print(figure(12),filepath_save,'-dpng','-r1000')
print(figure(12),filepath_save,'-djpeg','-r1000')
clear
clc
filename="D:\yellow river water comsumption\yield_et_fit_new.xlsx";
excel_yield_et=readtable(filename);
%%
alpha=0.1;
%%
%maize region1
wheat_f1r1_x=table2array(excel_yield_et(423:500,"x1_et_max"));
wheat_f1r1_y=table2array(excel_yield_et(423:500,"x1_yield_max"));
wheat_f1r1_yield=table2array(excel_yield_et(423:500,"yield"));
wheat_f1r1_et=table2array(excel_yield_et(423:500,"et"));

model_f1r1=@(k,wheat_f1r1_x) k*wheat_f1r1_x;

beta0=1;

[beta1_f1r1,resnorm]=lsqcurvefit(model_f1r1,beta0,wheat_f1r1_x,wheat_f1r1_y);

wheat_f1r1_yfit=model_f1r1(beta1_f1r1,wheat_f1r1_x);
wheat_f1r1_yfit1=max(wheat_f1r1_yield)*(1-wheat_f1r1_yfit);


%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f1r1_x);
sqsx=[];
res=[];
for i=1:length(wheat_f1r1_x)
    sqsx(i)=(wheat_f1r1_x(i)-mean(wheat_f1r1_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f1r1_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f1r1_x)+(wheat_f1r1_x(j)-mean(wheat_f1r1_x))^2/sqsx1));
end


t_val=tinv(1-alpha/2,length(wheat_f1r1_x)-length(beta1_f1r1));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f1r1_x)
    ymax=wheat_f1r1_yfit(k)+ci(k);
    ymin=wheat_f1r1_yfit(k)-ci(k);
    y_max(k,1)=max(wheat_f1r1_yield)*(1-ymin);
    y_min(k,1)=max(wheat_f1r1_yield)*(1-ymax);
end

%%%-----------------------------------------------------------------------------
%figure
figure(1)
plot(wheat_f1r1_et,wheat_f1r1_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r1_et,wheat_f1r1_yfit1];
xy_max=[wheat_f1r1_et,y_max];
xy_min=[wheat_f1r1_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r1_et)-100;
axis2=max(wheat_f1r1_et)+100;
axis3=min(wheat_f1r1_yield)-500;
axis4=max(wheat_f1r1_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.7397','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=1910.8 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title('Maize Sub-region 1','FontSize',32,'FontName','Times New Roman')

%R2
SSresid=sum((wheat_f1r1_y-wheat_f1r1_yfit).^2);
SStotal=sum((wheat_f1r1_y-mean(wheat_f1r1_y)).^2);
R2_f1r1=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r1_yield-wheat_f1r1_yfit1).^2);
RMSE_f1r1=(SSresid1/size(wheat_f1r1_yield,1))^0.5;
nRMSE_f1r1=RMSE_f1r1/(mean(wheat_f1r1_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r1_uncertainty_0304';
print(figure(1),filepath_save,'-dpng','-r1000')
print(figure(1),filepath_save,'-djpeg','-r1000')
%%
%region2
wheat_f1r2_x=table2array(excel_yield_et(501:512,"x1_et_max"));
wheat_f1r2_y=table2array(excel_yield_et(501:512,"x1_yield_max"));
wheat_f1r2_yield=table2array(excel_yield_et(501:512,"yield"));
wheat_f1r2_et=table2array(excel_yield_et(501:512,"et"));

model_f1r2=@(k,wheat_f1r2_x) k*wheat_f1r2_x;

beta0=1;

[beta1_f1r2,resnorm]=lsqcurvefit(model_f1r2,beta0,wheat_f1r2_x,wheat_f1r2_y);

wheat_f1r2_yfit=model_f1r2(beta1_f1r2,wheat_f1r2_x);
wheat_f1r2_yfit1=max(wheat_f1r2_yield)*(1-wheat_f1r2_yfit);

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f1r2_x);
sqsx=[];
res=[];
for i=1:length(wheat_f1r2_x)
    sqsx(i)=(wheat_f1r2_x(i)-mean(wheat_f1r2_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f1r2_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f1r2_x)+(wheat_f1r2_x(j)-mean(wheat_f1r2_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f1r2_x)-length(beta1_f1r2));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f1r2_x)
    ymax=wheat_f1r2_yfit(k)+ci(k);
    ymin=wheat_f1r2_yfit(k)-ci(k);
    y_max(k,1)=max(wheat_f1r2_yield)*(1-ymin);
    y_min(k,1)=max(wheat_f1r2_yield)*(1-ymax);
end

%%%-----------------------------------------------------------------------------
%figure
figure(2)
plot(wheat_f1r2_et,wheat_f1r2_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r2_et,wheat_f1r2_yfit1];
xy_max=[wheat_f1r2_et,y_max];
xy_min=[wheat_f1r2_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r2_et)-100;
axis2=max(wheat_f1r2_et)+100;
axis3=min(wheat_f1r2_yield)-500;
axis4=max(wheat_f1r2_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.6867','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=1423.6 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title('Maize Sub-region 2','FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

%R2
SSresid=sum((wheat_f1r2_y-wheat_f1r2_yfit).^2);
SStotal=sum((wheat_f1r2_y-mean(wheat_f1r2_y)).^2);
R2_f1r2=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r2_yield-wheat_f1r2_yfit1).^2);
RMSE_f1r2=(SSresid1/size(wheat_f1r2_yield,1))^0.5;
nRMSE_f1r2=RMSE_f1r2/(mean(wheat_f1r2_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r2_uncertainty_0304';
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

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f1r3_x);
sqsx=[];
res=[];
for i=1:length(wheat_f1r3_x)
    sqsx(i)=(wheat_f1r3_x(i)-mean(wheat_f1r3_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f1r3_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f1r3_x)+(wheat_f1r3_x(j)-mean(wheat_f1r3_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f1r3_x)-length(beta1_f1r3));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f1r3_x)
    ymax=wheat_f1r3_yfit(k)+ci(k);
    ymin=wheat_f1r3_yfit(k)-ci(k);
    y_max(k,1)=max(wheat_f1r3_yield)*(1-ymin);
    y_min(k,1)=max(wheat_f1r3_yield)*(1-ymax);
end

%%%-----------------------------------------------------------------------------
%figure
figure(3)
plot(wheat_f1r3_et,wheat_f1r3_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r3_et,wheat_f1r3_yfit1];
xy_max=[wheat_f1r3_et,y_max];
xy_min=[wheat_f1r3_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r3_et)-100;
axis2=max(wheat_f1r3_et)+100;
axis3=min(wheat_f1r3_yield)-500;
axis4=max(wheat_f1r3_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.4886','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=1617.1 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title('Maize Sub-region 3','FontSize',32,'FontName','Times New Roman')
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
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r3_uncertainty_0304';
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
figure(4)
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
text(textx,texty,'R^{2}=0.4380','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=2191.4 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title('Maize Sub-region 4','FontSize',32,'FontName','Times New Roman')
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
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r4_uncertainty_0304';
print(figure(4),filepath_save,'-dpng','-r1000')
print(figure(4),filepath_save,'-djpeg','-r1000')
%%
%region5
wheat_f1r5_x=table2array(excel_yield_et(649:780,"x1_et_max"));
wheat_f1r5_y=table2array(excel_yield_et(649:780,"x1_yield_max"));
wheat_f1r5_yield=table2array(excel_yield_et(649:780,"yield"));
wheat_f1r5_et=table2array(excel_yield_et(649:780,"et"));

model_f1r5=@(k,wheat_f1r5_x) k*wheat_f1r5_x;

beta0=1;

[beta1_f1r5,resnorm]=lsqcurvefit(model_f1r5,beta0,wheat_f1r5_x,wheat_f1r5_y);

wheat_f1r5_yfit=model_f1r5(beta1_f1r5,wheat_f1r5_x);
wheat_f1r5_yfit1=max(wheat_f1r5_yield)*(1-wheat_f1r5_yfit);

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f1r5_x);
sqsx=[];
res=[];
for i=1:length(wheat_f1r5_x)
    sqsx(i)=(wheat_f1r5_x(i)-mean(wheat_f1r5_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f1r5_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f1r5_x)+(wheat_f1r5_x(j)-mean(wheat_f1r5_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f1r5_x)-length(beta1_f1r5));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f1r5_x)
    ymax=wheat_f1r5_yfit(k)+ci(k);
    ymin=wheat_f1r5_yfit(k)-ci(k);
    y_max(k,1)=max(wheat_f1r5_yield)*(1-ymin);
    y_min(k,1)=max(wheat_f1r5_yield)*(1-ymax);
end

%%%-----------------------------------------------------------------------------
%figure
figure(5)
plot(wheat_f1r5_et,wheat_f1r5_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r5_et,wheat_f1r5_yfit1];
xy_max=[wheat_f1r5_et,y_max];
xy_min=[wheat_f1r5_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r5_et)-100;
axis2=max(wheat_f1r5_et)+100;
axis3=min(wheat_f1r5_yield)-500;
axis4=max(wheat_f1r5_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.6628','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=1683.0 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title('Maize Sub-region 5','FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

%R2
SSresid=sum((wheat_f1r5_y-wheat_f1r5_yfit).^2);
SStotal=sum((wheat_f1r5_y-mean(wheat_f1r5_y)).^2);
R2_f1r5=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r5_yield-wheat_f1r5_yfit1).^2);
RMSE_f1r5=(SSresid1/size(wheat_f1r5_yield,1))^0.5;
nRMSE_f1r5=RMSE_f1r5/(mean(wheat_f1r5_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r5_uncertainty_0304';
print(figure(5),filepath_save,'-dpng','-r1000')
print(figure(5),filepath_save,'-djpeg','-r1000')
%%
%region6
wheat_f3r6_x=table2array(excel_yield_et(781:793,"x1_et_max"));
wheat_f3r6_y=table2array(excel_yield_et(781:793,"yield"));
wheat_f3r6_yield=table2array(excel_yield_et(781:793,"yield"));
wheat_f3r6_et=table2array(excel_yield_et(781:793,"et"));

model_f3r6=@(b,wheat_f3r6_x) b(1)+b(2)*(1-wheat_f3r6_x.*wheat_f3r6_x);

beta0=[0,0];

[beta1_f3r6,resnorm]=lsqcurvefit(model_f3r6,beta0,wheat_f3r6_x,wheat_f3r6_y);

wheat_f3r6_yfit=model_f3r6(beta1_f3r6,wheat_f3r6_x);
wheat_f3r6_yfit1=wheat_f3r6_yfit;

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f3r6_x);
sqsx=[];
res=[];
for i=1:length(wheat_f3r6_x)
    sqsx(i)=(wheat_f3r6_x(i)-mean(wheat_f3r6_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f3r6_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f3r6_x)+(wheat_f3r6_x(j)-mean(wheat_f3r6_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f3r6_y)-length(beta1_f3r6));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f3r6_x)
    y_max(k,1)=wheat_f3r6_yfit(k)+ci(k);
    y_min(k,1)=wheat_f3r6_yfit(k)-ci(k);
end

%%%-----------------------------------------------------------------------------
%figure
figure(6)
plot(wheat_f3r6_et,wheat_f3r6_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f3r6_et,wheat_f3r6_yfit1];
xy_max=[wheat_f3r6_et,y_max];
xy_min=[wheat_f3r6_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f3r6_et)-100;
axis2=max(wheat_f3r6_et)+100;
axis3=min(wheat_f3r6_yield)-500;
axis4=max(wheat_f3r6_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.4633','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=880.7 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title('Maize Sub-region 6','FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

%R2
SSresid=sum((wheat_f3r6_y-wheat_f3r6_yfit).^2);
SStotal=sum((wheat_f3r6_y-mean(wheat_f3r6_y)).^2);
R2_f3r6=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r6_yield-wheat_f3r6_yfit1).^2);
RMSE_f3r6=(SSresid1/size(wheat_f3r6_yield,1))^0.5;
nRMSE_f3r6=RMSE_f3r6/(mean(wheat_f3r6_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r6_uncertainty_0304';
print(figure(6),filepath_save,'-dpng','-r1000')
print(figure(6),filepath_save,'-djpeg','-r1000')
%%
%region7
wheat_f1r7_x=table2array(excel_yield_et(794:885,"x1_et_max"));
wheat_f1r7_y=table2array(excel_yield_et(794:885,"x1_yield_max"));
wheat_f1r7_yield=table2array(excel_yield_et(794:885,"yield"));
wheat_f1r7_et=table2array(excel_yield_et(794:885,"et"));

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

t_val=tinv(1-alpha/2,length(wheat_f1r7_x)-length(beta1_f1r7));

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
figure(7)
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
text(textx,texty,'R^{2}=0.6534','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=1301.1 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Maize Sub-region 9",'FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

%R2
SSresid=sum((wheat_f1r7_y-wheat_f1r7_yfit).^2);
SStotal=sum((wheat_f1r7_y-mean(wheat_f1r7_y)).^2);
R2_f1r7=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r7_yield-wheat_f1r7_yfit1).^2);
RMSE_f1r7=(SSresid1/size(wheat_f1r7_yield,1))^0.5;
nRMSE_f1r7=RMSE_f1r7/(mean(wheat_f1r7_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r7_uncertainty_0304';
print(figure(7),filepath_save,'-dpng','-r1000')
print(figure(7),filepath_save,'-djpeg','-r1000')

%%
%region8
wheat_f1r8_x=table2array(excel_yield_et(886:892,"x1_et_max"));
wheat_f1r8_y=table2array(excel_yield_et(886:892,"x1_yield_max"));
wheat_f1r8_yield=table2array(excel_yield_et(886:892,"yield"));
wheat_f1r8_et=table2array(excel_yield_et(886:892,"et"));

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

t_val=tinv(1-alpha/2,length(wheat_f1r8_x)-length(beta1_f1r8));

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
figure(8)
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
text(textx,texty,'R^{2}=0.5049','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=681.2 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Maize Sub-region 10",'FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

%R2
SSresid=sum((wheat_f1r8_y-wheat_f1r8_yfit).^2);
SStotal=sum((wheat_f1r8_y-mean(wheat_f1r8_y)).^2);
R2_f1r8=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r8_yield-wheat_f1r8_yfit1).^2);
RMSE_f1r8=(SSresid1/size(wheat_f1r8_yield,1))^0.5;
nRMSE_f1r8=RMSE_f1r8/(mean(wheat_f1r8_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r8_uncertainty_0304';
print(figure(8),filepath_save,'-dpng','-r1000')
print(figure(8),filepath_save,'-djpeg','-r1000')

%%
%region9
wheat_f3r9_x=table2array(excel_yield_et(893:916,"x1_et_max"));
wheat_f3r9_y=table2array(excel_yield_et(893:916,"yield"));
wheat_f3r9_yield=table2array(excel_yield_et(893:916,"yield"));
wheat_f3r9_et=table2array(excel_yield_et(893:916,"et"));

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
figure(9)
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
text(textx,texty,'R^{2}=0.3851','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=1070.2 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Maize Sub-region 11",'FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

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
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r9_uncertainty_0304';
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

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f1r10_x);
sqsx=[];
res=[];
for i=1:length(wheat_f1r10_x)
    sqsx(i)=(wheat_f1r10_x(i)-mean(wheat_f1r10_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f1r10_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f1r10_x)+(wheat_f1r10_x(j)-mean(wheat_f1r10_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f1r10_x)-length(beta1_f1r10));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f1r10_x)
    ymax=wheat_f1r10_yfit(k)+ci(k);
    ymin=wheat_f1r10_yfit(k)-ci(k);
    y_max(k,1)=max(wheat_f1r10_yield)*(1-ymin);
    y_min(k,1)=max(wheat_f1r10_yield)*(1-ymax);
end

%%%-----------------------------------------------------------------------------
%figure
figure(10)
plot(wheat_f1r10_et,wheat_f1r10_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on

xy=[wheat_f1r10_et,wheat_f1r10_yfit1];
xy_max=[wheat_f1r10_et,y_max];
xy_min=[wheat_f1r10_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[150/255,150/255,150/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f1r10_et)-100;
axis2=max(wheat_f1r10_et)+100;
axis3=min(wheat_f1r10_yield)-500;
axis4=max(wheat_f1r10_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.9309','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=476.1 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Maize Sub-region 12",'FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

%R2
SSresid=sum((wheat_f1r10_y-wheat_f1r10_yfit).^2);
SStotal=sum((wheat_f1r10_y-mean(wheat_f1r10_y)).^2);
R2_f1r10=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f1r10_yield-wheat_f1r10_yfit1).^2);
RMSE_f1r10=(SSresid1/size(wheat_f1r10_yield,1))^0.5;
nRMSE_f1r10=RMSE_f1r10/(mean(wheat_f1r10_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r10_uncertainty_0304';
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

t_val=tinv(1-alpha/2,length(wheat_f1r12_x)-length(beta1_f1r12));

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
figure(12)
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
text(textx,texty,'R^{2}=0.2787','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=1699.4 kg/hm^2','FontSize',28,'FontName','Times New Roman')

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
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r11_uncertainty_0304';
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

t_val=tinv(1-alpha/2,length(wheat_f1r13_x)-length(beta1_f1r13));

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
figure(13)
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
text(textx,texty,'R^{2}=0.5181','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=997.0 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Maize Sub-region 7",'FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

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
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\maize_r12_uncertainty_0304';
print(figure(13),filepath_save,'-dpng','-r1000')
print(figure(13),filepath_save,'-djpeg','-r1000')
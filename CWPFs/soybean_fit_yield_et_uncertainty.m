clear
clc
filename="D:\yellow river water comsumption\yield_et_fit_new.xlsx";
excel_yield_et=readtable(filename);
%%
alpha=0.1;

%soybean region1
wheat_f3r1_x=table2array(excel_yield_et(960:967,"x1_et_max"));
wheat_f3r1_y=table2array(excel_yield_et(960:967,"yield"));
wheat_f3r1_yield=table2array(excel_yield_et(960:967,"yield"));
wheat_f3r1_et=table2array(excel_yield_et(960:967,"et"));

model_f3r1=@(b,wheat_f3r1_x) b(1)+b(2)*(1-wheat_f3r1_x.*wheat_f3r1_x);

beta0=[0,0];

[beta1_f3r1,resnorm]=lsqcurvefit(model_f3r1,beta0,wheat_f3r1_x,wheat_f3r1_y);

wheat_f3r1_yfit=model_f3r1(beta1_f3r1,wheat_f3r1_x);
wheat_f3r1_yfit1=wheat_f3r1_yfit;

%%%-----------------------------------------------------------------------------
%confidence interval
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

axis1=380;
axis2=480;
axis3=min(wheat_f3r1_yield)-700;
axis4=max(wheat_f3r1_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.2639','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=408.1 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Soybean Sub-region 3",'FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

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
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\soybean_r1_uncertainty_0304';
print(figure(1),filepath_save,'-dpng','-r1000')
print(figure(1),filepath_save,'-djpeg','-r1000')
%%
%soybean region2
wheat_f3r2_x=table2array(excel_yield_et(968:974,"x1_et_max"));
wheat_f3r2_y=table2array(excel_yield_et(968:974,"yield"));
wheat_f3r2_yield=table2array(excel_yield_et(968:974,"yield"));
wheat_f3r2_et=table2array(excel_yield_et(968:974,"et"));

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

axis1=330;
axis2=380;
axis3=min(wheat_f3r2_yield)-600;
axis4=max(wheat_f3r2_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.3641','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=390.7 kg/hm^2','FontSize',28,'FontName','Times New Roman')


title("Soybean Sub-region 1",'FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

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
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\soybean_r2_uncertainty_0304';
print(figure(2),filepath_save,'-dpng','-r1000')
print(figure(2),filepath_save,'-djpeg','-r1000')
%%
%region3
wheat_f3r3_x=table2array(excel_yield_et(975:1017,"x1_et_max"));
wheat_f3r3_y=table2array(excel_yield_et(975:1017,"yield"));
wheat_f3r3_yield=table2array(excel_yield_et(975:1017,"yield"));
wheat_f3r3_et=table2array(excel_yield_et(975:1017,"et"));

model_f3r3=@(b,wheat_f3r3_x) b(1)+b(2)*(1-wheat_f3r3_x.*wheat_f3r3_x);

beta0=[0,0];

[beta1_f3r3,resnorm]=lsqcurvefit(model_f3r3,beta0,wheat_f3r3_x,wheat_f3r3_y);

wheat_f3r3_yfit=model_f3r3(beta1_f3r3,wheat_f3r3_x);
wheat_f3r3_yfit1=wheat_f3r3_yfit;

%%%-----------------------------------------------------------------------------
%confidence interval
MSE=resnorm/length(wheat_f3r3_x);
sqsx=[];
res=[];
for i=1:length(wheat_f3r3_x)
    sqsx(i)=(wheat_f3r3_x(i)-mean(wheat_f3r3_x))^2;
end
sqsx1=sum(sqsx);
for j=1:length(wheat_f3r3_x)
res(j,1)=sqrt(MSE*(1/length(wheat_f3r3_x)+(wheat_f3r3_x(j)-mean(wheat_f3r3_x))^2/sqsx1));
end

t_val=tinv(1-alpha/2,length(wheat_f3r3_y)-length(beta1_f3r3));

ci=t_val*res;

y_max=[];
y_min=[];
for k=1:length(wheat_f3r3_x)
    y_max(k,1)=wheat_f3r3_yfit(k)+ci(k);
    y_min(k,1)=wheat_f3r3_yfit(k)-ci(k);
end

%%%-----------------------------------------------------------------------------
%figure
figure(3)
plot(wheat_f3r3_et,wheat_f3r3_yield,'.','MarkerSize',14,'Color',[49/255,92/255,181/255])
hold on
xy=[wheat_f3r3_et,wheat_f3r3_yfit1];
xy_max=[wheat_f3r3_et,y_max];
xy_min=[wheat_f3r3_et,y_min];
sortxy=sortrows(xy);
sortxy_max=sortrows(xy_max);
sortxy_min=sortrows(xy_min);
plot(sortxy(:,1),sortxy(:,2),'Color',[155/255,46/255,43/255],'LineWidth',1,'LineStyle','-')
plot(sortxy_max(:,1),sortxy_max(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')
plot(sortxy_min(:,1),sortxy_min(:,2),'Color',[100/255,100/255,100/255],'LineWidth',1,'LineStyle','--')

axis1=min(wheat_f3r3_et)-100;
axis2=max(wheat_f3r3_et)+100;
axis3=min(wheat_f3r3_yield)-500;
axis4=max(wheat_f3r3_yield)+500;
axis([axis1 axis2 axis3 axis4])
set(gca,'FontName','Times New Roman','FontSize',28);
textx=(axis2-axis1)*0.07+axis1;
texty=(axis4-axis3)*0.93+axis3;
texty2=(axis4-axis3)*0.80+axis3;
text(textx,texty,'R^{2}=0.3069','FontSize',28,'FontName','Times New Roman')
text(textx,texty2,'RMSE=390.7 kg/hm^2','FontSize',28,'FontName','Times New Roman')

title("Soybean Sub-region 2",'FontSize',32,'FontName','Times New Roman')
set(gca,'yticklabel',get(gca,'ytick'));

%R2
SSresid=sum((wheat_f3r3_y-wheat_f3r3_yfit).^2);
SStotal=sum((wheat_f3r3_y-mean(wheat_f3r3_y)).^2);
R2_f3r3=1-(SSresid/SStotal);

%RMSE
SSresid1=sum((wheat_f3r3_yield-wheat_f3r3_yfit1).^2);
RMSE_f3r3=(SSresid1/size(wheat_f3r3_yield,1))^0.5;
nRMSE_f3r3=RMSE_f3r3/(mean(wheat_f3r3_yield));
%%
%save figure
filepath_save='D:\yellow river water comsumption\figure\new_figures_from_0102\soybean_r3_uncertainty_0304';
print(figure(3),filepath_save,'-dpng','-r1000')
print(figure(3),filepath_save,'-djpeg','-r1000')

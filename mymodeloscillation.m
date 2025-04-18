close all;
clear all;
% experimentv=readmatrix("liuc_1.4ma.csv");
% plot(experimentv(1:100000,1), experimentv(1:100000,3));
Tc=340;
Tamb=30;
Cth=1e-10;
delta_Gth=1e-4;
RL=1500;
%% oscillation

current=0.8e-3;cap=2e-9;T=Tamb;v=0;dt=1e-9;
Ai=0.0;
Cin=20e-9;
fa=5.5e3;
tmp=0;
anst=zeros(8e6,1);ansivT=zeros(8e6,3);count=0;
i=0;
for t=dt:dt:8e-3
   Gth=erf((T-70)/8)*delta_Gth+delta_Gth+8.5e-5;
   if T>65%%65
       tmp=1;
       Gth=erf((T-72)/8)*5e-5+10e-5;
   end
   if (tmp==1)&&(T>=60)
       tmp=1;
       Gth=erf((T-72)/8)*5e-5+10e-5;
   end
   if T<60
       tmp=0;
   end
   if T<=60+2*randn()
      G=1/(1.663e4)*(1+0.0075*(T-30));
      R=(1/G);
      dT=(dt/Cth)*(v*v*G-(T-Tamb)*Gth);
   else
      R=(erfc((T-62)/10))*((1-T/100))*16e3+RL;
      G=1/R;
      dT=(dt/Cth)*(v*v*G-(T-Tamb)*Gth+0.000415);
   end
    i=v*(G);
    dv=(current+Ai*2*pi*fa*Cin*cos(2*pi*fa*t)-i)*dt/(cap+Cin);
    v=v+dv;
    T=T+dT;
    count=count+1;
    anst(count,1)=t;
    ansivT(count,1)=i;
    ansivT(count,2)=v;
    ansivT(count,3)=T;
end
figure(4)
% plot(experimentv(20000:130000,1), experimentv(20000:130000,2)./25);
hold on
plot(anst(1:count),ansivT(1:count,1)); title("Oscillation i(t)"); xlabel("t");ylabel("i");
figure(5)
yellow=mod(1:count,10000);
plot(anst(:,1),ansivT(:,2)); title("Oscillation v(t)"); xlabel("t");ylabel("V");
hold on
%plot(experimentv(20000:130000,1)+1.289e-5, experimentv(20000:130000,3));
% figure(6)
% plot(anst(:,1),ansivT(:,3)); title("Oscillation T(t)"); xlabel("t");ylabel("T");
% figure(7)
% scatter3(ansivT(:,2),ansivT(:,1),ansivT(:,3),'filled','cdata',yellow);title("Oscillation i(V)"); xlabel("V");ylabel("i");zlabel("T")
% grid on
% xlswrite('liuc_oscillation.xlsx',ansivT,'ivt');

% figure(8)
% subplot(1,2,1)
% plot(ansivT(:,2),ansivT(:,1));
% subplot(1,2,2)
% plot(ansivT(1:count-1,2),ansivT(2:count,2)-ansivT(1:count-1,2))
% figure(9)
% plot(anst(1:count),ansivT(1:count,1).*ansivT(1:count,2))
newans=[anst(1:100:8000000),ansivT(1:100:8000000,1:2)];
figure(10);
x=anst;
y=ansivT(:,2);
z=ansivT(:,1);
% 绘制散点图
% yyaxis left
plot(x, y, 'k-', 'LineWidth', 1.5);
hold on
ylabel('Voltage (V)', 'FontSize', 14);
set(gca, 'ycolor','k');
ylim([0 6]);
% yyaxis right
% plot(x,z,'r-','LineWidth',1.5);
% ylabel('Current (A)', 'FontSize', 14);
% ylim([0 1e-2]);

% 设置坐标轴
ax = gca;
ax.FontSize = 12; % 坐标轴字体大小
ax.XColor = 'k'; % X轴颜色
ax.YColor = 'k'; % Y轴颜色

% 标签
xlabel('Time (s)', 'FontSize', 14);

% 图例
% legend('', '线性拟合', 'FontSize', 12, 'Location', 'best');

% 图形标题
title('inject: 0 V', 'FontSize', 16, 'FontWeight', 'bold');

% 调整图形布局，确保图形不被遮挡
set(gca,'FontName','Arial','FontSize',28,'LineWidth',2);
% 输出为高分辨率的图像文件
print(gcf, 'inject: 0 V.png', '-dpng', '-r300');
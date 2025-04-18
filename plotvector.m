clear all;
close all;
ansT=zeros(1,1000);
ansv=zeros(1,1000);
ansv2=zeros(1,1000);

% 定义x和y的范围
x = linspace(1, 6, 50);
y = linspace(0, 1, 50);
[X, Y] = meshgrid(x, y);
% 定义矢量的分量
U = Y;
V = X;

Tc=340;
Tamb=30;
Cth=1e-11;
delta_Gth=1e-4;
RL=1500;
current=0.5e-3;cap=2e-10;T=Tamb;v=0;dt=1e-9;

for i=1:50
    for j=1:50
        T=x(i)*30;
        v=y(j)*10;
        Gth=erf((T-70)/8)*delta_Gth+delta_Gth+8.5e-5;
        if T>65
           Gth=erf((T-72)/8)*5e-5+10e-5;
        end
        if T<=58
            G=1/(1.663e4)*(1+0.0075*(T-30));
            R=(1/G);
            dT=(dt/Cth)*(v*v*G-(T-Tamb)*Gth);
        else
            R=(erfc((T-62)/10))*((1-T/100))*16e3+RL;
            G=1/R;
            dT=(dt/Cth)*(v*v*G-(T-Tamb)*Gth+0.000415);
        end
        iii=v*(G);
        dv=(current-iii)*dt/(cap);
        U(i,j)=dv/10;
        V(i,j)=dT/30;
    end
end
count=0;
for T=30:0.1:150
        count=count+1;
        Gth=erf((T-70)/8)*delta_Gth+delta_Gth+8.5e-5;
        if T>=65
           Gth=erf((T-72)/8)*5e-5+10e-5;
        end
        if T<=58
            G=1/(1.663e4)*(1+0.0075*(T-30));
            R=(1/G);
            dT=(dt/Cth)*(v*v*G-(T-Tamb)*Gth);
            v=sqrt((T-Tamb)*Gth/G);
        else
            R=(erfc((T-62)/10))*((1-T/100))*16e3+RL;
            G=1/R;
            v=sqrt(((T-Tamb)*Gth+0.000415)/G);
        end
        ansT(count)=T;ansv(count)=v;

        ansv2(count)=current/G;
end



figure(1)
plot(ansT./30,ansv./10,'LineWidth', 2);
hold on
plot(ansT./30,ansv2./10,'LineWidth', 2);
hold on
% 画矢量场
quiver(X, Y, U, V);
 
% 添加箭头
quiver(X, Y, U, V, 'filled', 'LineWidth', 0.5);
 
% 设置轴标签
xlabel('T');
ylabel('V');
 
% 设置标题
title('Vector Field');
 
% 显示网格
grid on;
 
% 保持轴比例相等

axis([1 6 0 1])

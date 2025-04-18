close all;
clear all;
train_origin=readmatrix("Xtrain.csv")./1000;
train_device=readmatrix('Xtrain_device.csv');
train_label=readmatrix('Ytrain.csv');
%%0-160, 1-122, 2-16, 3-66,4-200,5-1,6-80,7-11,8-53,9-320
ii=320;
train_label(ii)
figure(1);
%aaaa=train_origin(ii,1:4800);
aaaa=train_origin(ii,1:2400);
sampleRate=8000;
t = 0:1/sampleRate:(length(aaaa)*1/sampleRate)-1/sampleRate;
%Compute CWT
%If necessary, substitute workspace variable name for aaaaa as first input to cwt() function in code below
%Run the function call below without output arguments to plot the results
[waveletTransform,frequency] = cwt(aaaa, sampleRate);
scalogram = abs(waveletTransform);
imagesc(t,frequency,scalogram);
colormap jet
set(gca, 'YDir','normal');
set(gca, 'Yscale','log');

ylabel('Frequency (Hz)')
xlabel('Time (s)')

set(gca,'FontName','Arial','FontSize',28,'LineWidth',2);
colorbar(gca,'FontSize',22)
ylabel(colorbar,'Magniture','FontSize',22,'LineWidth',2);
filename3=strcat('before/',num2str(ii),'pinpu_label',num2str(train_label(ii)),'.png');
exportgraphics(gcf,filename3,'ContentType','vector','BackgroundColor','none')

figure(2);
aaaa=train_device(ii,1:3000);
sampleRate=10000;
t = 0:1/sampleRate:(length(aaaa)*1/sampleRate)-1/sampleRate;
Compute CWT
If necessary, substitute workspace variable name for aaaaa as first input to cwt() function in code below
Run the function call below without output arguments to plot the results
[waveletTransform,frequency] = cwt(aaaa, sampleRate);
scalogram = abs(waveletTransform);
imagesc(t,frequency,scalogram);
colormap jet
set(gca, 'YDir','normal');
set(gca, 'Yscale','log');

ylabel('Frequency (Hz)')
xlabel('Time (s)')

set(gca,'FontName','Arial','FontSize',28,'LineWidth',2);
colorbar(gca,'FontSize',22)
ylabel(colorbar,'Magniture','FontSize',22,'LineWidth',2);
filename3=strcat('after/',num2str(ii),'pinpu_label',num2str(train_label(ii)),'.png');
exportgraphics(gcf,filename3,'ContentType','vector','BackgroundColor','none')

figure(3)
subplot(4,1,1);
plot((1:4800)./10000,train_origin(ii,1:4800));
xlabel('Time (s)');
ylabel("Voltage");

subplot(4,1,2);
plot((1:5:4800)./10000,train_origin(ii,1:5:4800));
xlabel('Time (s)');
ylabel("Voltage");

subplot(4,1,3);
plot((1:5000)./10000,train_device(ii,1:5000));
xlabel('Time (s)');
ylabel("Voltage");

subplot(4,1,4);
plot((1:5:5000)./10000,train_device(ii,1:5:5000));
xlabel('Time (s)');
ylabel("Voltage");

figure(4)
subplot(2,1,1);

plot((1:2880)./10000,train_origin(ii,1:2880),'b-','LineWidth',1);
xlabel('Time (s)');
ylabel("Voltage (V)");
% legend('original signal', 'FontSize', 14);
title('four', 'FontSize', 16, 'FontWeight', 'bold');
ax = gca;
ax.FontSize = 12; % 
ax.XColor = 'k'; % X color
ax.YColor = 'k'; % Y color

% label
xlabel('Time (s)', 'FontSize', 14);


set(gca,'FontName','Arial','FontSize',28,'LineWidth',2);
subplot(2,1,2);
plot((1:3000)./10000,train_device(ii,1:3000),'r-','LineWidth',1);
xlabel('Time (s)');
ylabel("Voltage (V)");
% legend('Device filtered', 'FontSize', 14);
ylim([0 6])
ax = gca;
ax.FontSize = 12;
ax.XColor = 'k'; % X color
ax.YColor = 'k'; % Y color

% 标签
xlabel('Time (s)', 'FontSize', 14);

% 调整图形布局，确保图形不被遮挡
set(gca,'FontName','Arial','FontSize',28,'LineWidth',2);

print(gcf, '4.png', '-dpng', '-r300');
% writematrix([(1:4800)./10000,train_origin(ii,1:4800)],"label0_before.csv");
% writematrix([(1:5000)./10000,train_device(ii,1:5000)],"label0_after.csv");
% figure(5)
% plot((1:2880)./10000,train_origin(ii,1:2880),'k-','LineWidth',1);
% xlabel('Time (s)','FontSize', 14);
% ylabel("Voltage (V)",'FontSize', 14);
% set(gca,'FontName','Arial','FontSize',28,'LineWidth',2);
% print(gcf, 'before.png', '-dpng', '-r300');
% figure(6)
% plot((1:3000)./10000,train_device(ii,1:3000),'k-','LineWidth',1);
% xlabel('Time (s)','FontSize', 14);
% ylabel("Voltage (V)",'FontSize', 14);
% set(gca,'FontName','Arial','FontSize',28,'LineWidth',2);
% print(gcf, 'after.png', '-dpng', '-r300');

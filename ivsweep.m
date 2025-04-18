close all;
clear all;
a=readmatrix("30 1.5m.csv");
isweep=a(247:447,2:3);
Tc=340;
Tamb=30;
Cth=2.68e-9;
delta_Gth=1e-4;
RL=1500;
%% static sweep
ansivt=zeros(10000001,3);
ansR=zeros(10000001,1);
anstime=zeros(10000001,1);
k=0;
Tcom=30;
f=5;
tmp=0;
for t=0:1e-8:0.1
   k=k+1;
   i=1.5e-3*sin(2*pi*f*t);
   Gth=erf((Tcom-70)/8)*delta_Gth+delta_Gth+8.5e-5;
   if Tcom>65
       tmp=1;
       Gth=erf((Tcom-72)/8)*5e-5+10e-5;
   end
   if (tmp==1)&&(Tcom>=60)
       tmp=1;
       Gth=erf((Tcom-72)/8)*5e-5+10e-5;
   end
   if Tcom<60
       tmp=0;
   end
   Rth=1/(Gth);
   
   if Tcom<=58
      G=1/(1.663e4)*(1+0.0075*(Tcom-30));
      R=1/G;
      dT=(1e-8/Cth)*(i*i*R-(Tcom-Tamb)*Gth);
   else
      R=(erfc((Tcom-62)/10))*((1-Tcom/100))*16e3+RL;
      G=1/R;
      dT=(1e-8/Cth)*(i*i*R-(Tcom-Tamb)*Gth+0.000415);
   end
      v=i*(R);
  
   ansivt(k,1)=i;
   ansivt(k,2)=v;
   ansivt(k,3)=Tcom;
   anstime(k)=t;
   ansR(k,1)=R;

   Tcom=Tcom+dT;
end
 figure(1)
 plot(isweep(:,2),isweep(:,1),'^','LineWidth',1);
 hold on 
 plot(ansivt(:,2),ansivt(:,1),'r','LineWidth',2); 
 scatter(ansivt(:,2),ansivt(:,1),'filled','cdata',ansivt(:,3));
 colormap jet;
 title("static i(v)"); xlabel("V");ylabel("i");

 simulate=ansivt(1:10:10000001,:);
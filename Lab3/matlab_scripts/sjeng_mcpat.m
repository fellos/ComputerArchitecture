%sjeng graphs for lab3

%load data
data1 = importdata("sjeng_stats.txt");
n= length(data1.data);

index= data1.data(:,1);
energy= data1.data(:,2);
delay= data1.data(:,3);
areaCore= data1.data(:,4);
areaL2= data1.data(:,5);

peakDynCore= data1.data(:,7);
subLeakageCore= data1.data(:,8);
gateLeakageCore= data1.data(:,9);
peakDynL2= data1.data(:,10);
subLeakageL2= data1.data(:,11);
gateLeakageCoreL2= data1.data(:,12);

%calculate edap
area= areaCore + areaL2;
edap= (energy) .* delay .* area;
[minEdap,iEdap] = min(edap);

%edap graphs
figure(1);
b=bar(edap,0.8);
xticks([1:n]);
b.FaceColor = 'flat';
b.CData(iEdap,:) = [1 0 0];
title("EDAP of every simulation model (sjeng)");
xlabel("model");
ylabel("EDAP");

%area and power graphs

%area-associativity
areaValues= [area(7) area(9) area(12)];
figure(2)
plot(1:3,areaValues,'Marker','o');
ylim([1 100]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'(1,1,4)','(2,2,8)','(4,4,16)'});
title("sjeng: Area vs Associativity");
ylabel("Area (mm^2)");
xlabel("Associativity (L1D,L1I,L2)");
text(2.5,80,{"L1D-size=64KB","L1I-size=32KB","L2-size=2MB","CL-size=64"});

%area-l1 size
areaValues= [area(20) area(9) area(14)];
figure(3)
plot(1:3,areaValues,'Marker','o');
ylim([1 100]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'(32,16)','(64,32)','(128,64)'});
title("sjeng: Area vs L1 size");
ylabel("Area (mm^2)");
xlabel("L1 size (L1D,L1I) in KB");
text(2.5,80,{"L2-size=2MB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=64"});

%area-l2 size
areaValues= [area(21) area(9) area(11)];
figure(4)
plot(1:3,areaValues,'Marker','o');
ylim([1 100]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'1','2','4'});
title("sjeng: Area vs L2 size");
ylabel("Area (mm^2)");
xlabel("L2 size in MB");
text(2.5,70,{"L1D-size=64KB","L1I-size=32KB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=64"});

%area-CL
areaValues= [area(8) area(9) area(10) area(22)];
figure(5)
plot(1:4,areaValues,'Marker','o');
ylim([1 100]);
xlim([0.9 4.1]);
xticks([1 2 3 4]);
xticklabels({'32','64','128','256'});
title("sjeng: Area vs Cache Line size");
ylabel("Area (mm^2)");
xlabel("Cache Line size");
text(3,25,{"L1D-size=64KB","L1I-size=32KB","L2-size=2MB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8"});

%peak power calculation
power = peakDynCore + subLeakageCore + gateLeakageCore + peakDynL2 + subLeakageL2 + gateLeakageCoreL2;

%power-associativity
powerValues= [power(7) power(9) power(12)];
figure(6)
plot(1:3,powerValues,'Marker','o');
ylim([1 30]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'(1,1,4)','(2,2,8)','(4,4,16)'});
title("sjeng: Power vs Associativity");
ylabel("Power (W)");
xlabel("Associativity (L1D,L1I,L2)");
text(2.5,20,{"L1D-size=64KB","L1I-size=32KB","L2-size=2MB","CL-size=64"});

%power-l1 size
powerValues= [power(20) power(9) power(14)];
figure(7)
plot(1:3,powerValues,'Marker','o');
ylim([1 30]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'(32,16)','(64,32)','(128,64)'});
title("sjeng: Power vs L1 size");
ylabel("Power (W)");
xlabel("L1 size (L1D,L1I) in KB");
text(2.5,20,{"L2-size=2MB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=64"});

%power-l2 size
powerValues= [power(21) power(9) power(11)];
figure(8)
plot(1:3,powerValues,'Marker','o');
ylim([1 30]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'1','2','4'});
title("sjeng: Power vs L2 size");
ylabel("Power (W)");
xlabel("L2 size in MB");
text(2.5,20,{"L1D-size=64KB","L1I-size=32KB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=64"});

%power-CL
powerValues= [power(8) power(9) power(10) power(22)];
figure(9)
plot(1:4,powerValues,'Marker','o');
ylim([1 30]);
xlim([0.9 4.1]);
xticks([1 2 3 4]);
xticklabels({'32','64','128','256'});
title("sjeng: Power vs Cache Line size");
ylabel("Power (W)");
xlabel("Cache Line size");
text(3.3,8,{"L1D-size=64KB","L1I-size=32KB","L2-size=2MB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8"});

%cost function comparison
data2 = importdata("Results_sjeng.txt");
L1D_s= data2.data(:,1);
L1D_a= data2.data(:,2);
L1I_s= data2.data(:,3);
L1I_a= data2.data(:,4);
L2_s= data2.data(:,5);
L2_a= data2.data(:,6);
CLS= data2.data(:,7);
CPI= data2.data(:,8);
cost =(3/16)*(L1D_s+ L1I_s + (L2_s/10)*1024)+ 2*(L1D_a+L1I_a+L2_a)+ CLS/16;
f = cost.*CPI;

%standarize data
z_edap= (edap-mean(edap))./std(edap);
z_f= (f-mean(f))./std(f);

figure(10);
scatter(z_f,z_edap);
title("F(Standardized) vs EDAP(Standardized) - sjeng");
xlabel("F");
ylabel("EDAP");
text(1,2,sprintf("r = %f",corr2(f,edap)),'FontSize',12,'Color','blue');
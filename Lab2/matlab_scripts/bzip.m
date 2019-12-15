%CPI plots for bzip

%associativity
cpi=[1.645449 1.665609 1.598381];
figure(1)
plot(1:3,cpi,'Marker','o');
ylim([1.5 1.8]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'(1,1,4)','(2,2,8)','(4,4,16)'});
title("bzip: CPI vs Associativity");
ylabel("CPI");
xlabel("Associativity (L1D,L1I,L2)");
text(2.5,1.75,{"L1D-size=64KB","L1I-size=32KB","L2-size=2MB","CL-size=64"});

%l1 size
cpi=[1.694298 1.665609 1.635354];
figure(2)
plot(1:3,cpi,'Marker','o');
ylim([1.5 1.8]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'(32,16)','(64,32)','(128,64)'});
title("bzip: CPI vs L1 size");
ylabel("CPI");
xlabel("L1 size (L1D,L1I) in KB");
text(2.5,1.75,{"L2-size=2MB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=64"});

%l2 size
cpi=[1.630251 1.665609 1.647623];
figure(3)
plot(1:3,cpi,'Marker','o');
ylim([1.5 1.8]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'1','2','4'});
title("bzip: CPI vs L2 size");
ylabel("CPI");
xlabel("L2 size in MB");
text(2.5,1.75,{"L1D-size=64KB","L1I-size=32KB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=64"});

%CL
cpi=[1.775686 1.665609 1.657915 1.608190];
figure(4)
plot(1:4,cpi,'Marker','o');
ylim([1.5 1.8]);
xlim([0.9 4.1]);
xticks([1 2 3 4]);
xticklabels({'32','64','128','256'});
title("bzip: CPI vs Cache Line size");
ylabel("CPI");
xlabel("Cache Line size");
text(3,1.75,{"L1D-size=64KB","L1I-size=32KB","L2-size=2MB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8"});

%extra??
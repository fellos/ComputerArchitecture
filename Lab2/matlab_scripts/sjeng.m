%CPI plots for sjeng

%associativity
cpi=[7.056733 7.040968 7.044207];
figure(1)
plot(1:3,cpi,'Marker','o');
ylim([1 12]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'(1,1,4)','(2,2,8)','(4,4,16)'});
title("sjeng: CPI vs Associativity");
ylabel("CPI");
xlabel("Associativity (L1D,L1I,L2)");
text(2.5,10,{"L1D-size=64KB","L1I-size=32KB","L2-size=2MB","CL-size=64"});

%l1 size
cpi=[7.040633 7.040968 7.040555];
figure(2)
plot(1:3,cpi,'Marker','o');
ylim([1 12]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'(32,16)','(64,32)','(128,64)'});
title("sjeng: CPI vs L1 size");
ylabel("CPI");
xlabel("L1 size (L1D,L1I) in KB");
text(2.5,10,{"L2-size=2MB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=64"});

%l2 size
cpi=[7.041194 7.040968 7.039282];
figure(3)
plot(1:3,cpi,'Marker','o');
ylim([1 12]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'1','2','4'});
title("sjeng: CPI vs L2 size");
ylabel("CPI");
xlabel("L2 size in MB");
text(2.5,10,{"L1D-size=64KB","L1I-size=32KB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=64"});

%CL
cpi=[11.658780 7.040968 4.974909 3.715489];
figure(4)
plot(1:4,cpi,'Marker','o');
ylim([1 12]);
xlim([0.9 4.1]);
xticks([1 2 3 4]);
xticklabels({'32','64','128','256'});
title("sjeng: CPI vs Cache Line size");
ylabel("CPI");
xlabel("Cache Line size");
text(3,10,{"L1D-size=64KB","L1I-size=32KB","L2-size=2MB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8"});

%extra
cpi=[3.715863 3.715484 3.715624 3.715489];
figure(5)
plot(1:4,cpi,'Marker','o');
ylim([1 12]);
xlim([0.9 4.1]);
xticks([1 2 3 4]);
xticklabels({'(16,8,256)','(16,8,512)','(32,16,2048)','(64,32,2048)'});
title("sjeng: CPI vs Cache size (for CL-size=256)");
ylabel("CPI");
xlabel("Cache size (L1D,L1I,L2) in KB");
text(3,10,{"L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=256"});
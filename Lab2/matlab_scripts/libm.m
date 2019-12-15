%CPI plots for libm

%associativity
cpi=[2.638071 2.623555 2.623150];
figure(1)
plot(1:3,cpi,'Marker','o');
ylim([1 4]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'(1,1,4)','(2,2,8)','(4,4,16)'});
title("libm: CPI vs Associativity");
ylabel("CPI");
xlabel("Associativity (L1D,L1I,L2)");
text(2.5,3.5,{"L1D-size=64KB","L1I-size=32KB","L2-size=2MB","CL-size=64"});

%l1 size
cpi=[2.623140 2.623555 2.623565];
figure(2)
plot(1:3,cpi,'Marker','o');
ylim([1 4]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'(32,16)','(64,32)','(128,64)'});
title("libm: CPI vs L1 size");
ylabel("CPI");
xlabel("L1 size (L1D,L1I) in KB");
text(2.5,3.5,{"L2-size=2MB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=64"});

%l2 size
cpi=[3.495281 2.623555 2.621073];
figure(3)
plot(1:3,cpi,'Marker','o');
ylim([1 4]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'1','2','4'});
title("libm: CPI vs L2 size");
ylabel("CPI");
xlabel("L2 size in MB");
text(2.5,3.5,{"L1D-size=64KB","L1I-size=32KB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=64"});

%CL
cpi=[3.921536 2.623555 1.990434 1.990565];
figure(4)
plot(1:4,cpi,'Marker','o');
ylim([1 4]);
xlim([0.9 4.1]);
xticks([1 2 3 4]);
xticklabels({'32','64','128','256'});
title("libm: CPI vs Cache Line size");
ylabel("CPI");
xlabel("Cache Line size");
text(3,3.5,{"L1D-size=64KB","L1I-size=32KB","L2-size=2MB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8"});
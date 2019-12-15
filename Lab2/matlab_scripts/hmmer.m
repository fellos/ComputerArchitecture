%CPI plots for hmmer

%associativity
cpi=[1.209620 1.184534 1.184085];
figure(1)
plot(1:3,cpi,'Marker','o');
ylim([1.15 1.25]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'(1,1,4)','(2,2,8)','(4,4,16)'});
title("hmmer: CPI vs Associativity");
ylabel("CPI");
xlabel("Associativity (L1D,L1I,L2)");
text(2.5,1.23,{"L1D-size=64KB","L1I-size=32KB","L2-size=2MB","CL-size=64"});

%l1 size
cpi=[1.189222 1.184534 1.182631];
figure(2)
plot(1:3,cpi,'Marker','o');
ylim([1.15 1.25]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'(32,16)','(64,32)','(128,64)'});
title("hmmer: CPI vs L1 size");
ylabel("CPI");
xlabel("L1 size (L1D,L1I) in KB");
text(2.5,1.23,{"L2-size=2MB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=64"});

%l2 size
cpi=[1.187362 1.184534 1.184534];
figure(3)
plot(1:3,cpi,'Marker','o');
ylim([1.15 1.25]);
xlim([0.9 3.1]);
xticks([1 2 3]);
xticklabels({'1','2','4'});
title("hmmer: CPI vs L2 size");
ylabel("CPI");
xlabel("L2 size in MB");
text(2.5,1.23,{"L1D-size=64KB","L1I-size=32KB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8","CL-size=64"});

%CL
cpi=[1.191317 1.184534 1.181712 1.182031];
figure(4)
plot(1:4,cpi,'Marker','o');
ylim([1.15 1.25]);
xlim([0.9 4.1]);
xticks([1 2 3 4]);
xticklabels({'32','64','128','256'});
title("hmmer: CPI vs Cache Line size");
ylabel("CPI");
xlabel("Cache Line size");
text(3,1.23,{"L1D-size=64KB","L1I-size=32KB","L2-size=2MB","L1D-assoc=2","L1I-assoc=2","L2-assoc=8"});

%extra
cpi=[1.182821 1.181330 1.179532 1.179532];
figure(5)
plot(1:4,cpi,'Marker','o');
ylim([1.15 1.25]);
xlim([0.9 4.1]);
xticks([1 2 3 4]);
xticklabels({'(64,32)','(128,32)','(128,64)','(128,128)'});
title("hmmer: CPI vs L1 size (for CL-size=128)");
ylabel("CPI");
xlabel("L1 size (L1D,L1I) in KB");
text(3,1.23,{"L2-size=2MB","L1D-assoc=4","L1I-assoc=4","L2-assoc=8","CL-size=128"});
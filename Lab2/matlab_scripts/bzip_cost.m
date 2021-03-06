data = importdata("Results_bzip2.txt");

n= length(data.data);
L1D_s= data.data(:,1);
L1D_a= data.data(:,2);
L1I_s= data.data(:,3);
L1I_a= data.data(:,4);
L2_s= data.data(:,5);
L2_a= data.data(:,6);
CLS= data.data(:,7);
CPI= data.data(:,8);

cost =(3/16)*(L1D_s+ L1I_s + (L2_s/10)*1024)+ 2*(L1D_a+L1I_a+L2_a)+ CLS/16;
f = cost.*CPI;

[minCost,iC] = min(cost);
[minf,iF] = min(f);

figure(1);
b=bar(cost,0.8);
xticks([1:n]);
b.FaceColor = 'flat';
b.CData(iC,:) = [1 0 0];
title("Cost of every simulation model (bzip)");
xlabel("model");
ylabel("Cost");

figure(2);
b=bar(f,0.8);
xticks([1:n]);
b.FaceColor = 'flat';
b.CData(iF,:) = [1 0 0];
title("Value of F=(Cost x CPI) for every simulation model (bzip)");
xlabel("model");
ylabel("F");

[minCPI,iCPI]= min(CPI);
figure(3);
b=bar(CPI,0.8);
xticks([1:n]);
ylim([1 1.8]);
b.FaceColor = 'flat';
b.CData(iCPI,:) = [1 0 0];
title("CPI for every simulation model (bzip)");
xlabel("model");
ylabel("CPI");

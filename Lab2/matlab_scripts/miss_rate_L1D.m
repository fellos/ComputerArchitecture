%L1D miss rate grapgh

figure(1);
x= categorical({'401.bzip2','456.hmmer','470.lbm','429.mcf','458.sjeng'});
y=[0.014599 0.001625 0.060971 0.002168 0.121831];
bar(x,y);
title("Benchmark miss rates of L1D (Default, 2GHz)");
ylabel("L1D total miss rate");
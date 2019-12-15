%L1I miss rate grapgh

figure(1);
x= categorical({'401.bzip2','456.hmmer','470.lbm','429.mcf','458.sjeng'});
y=[0.000060 0.000128 0.000105 0.000039 0.000015];
bar(x,y);
title("Benchmark miss rates of L1I (Default, 2GHz)");
ylabel("L1I total miss rate");
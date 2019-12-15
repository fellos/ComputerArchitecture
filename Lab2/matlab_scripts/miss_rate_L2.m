%L2 miss rate grapgh

figure(1);
x= categorical({'401.bzip2','456.hmmer','470.lbm','429.mcf','458.sjeng'});
y=[0.266697 0.083085 0.999946 0.701421 0.999945];
bar(x,y);
title("Benchmark miss rates of L2 (Default, 2GHz)");
ylabel("L2 total miss rate");
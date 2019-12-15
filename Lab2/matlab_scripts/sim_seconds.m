%sim seconds grapgh

figure(1);
x= categorical({'401.bzip2','456.hmmer','470.lbm','429.mcf','458.sjeng'});
y=[0.086956 0.059431 0.174681 0.056131 0.513520];
bar(x,y);
title("Benchmark execution times (Default, 2GHz)");
ylabel("Execution time (sec)");
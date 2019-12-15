%cpi grapgh

figure(1);
x= categorical({'401.bzip2','456.hmmer','470.lbm','429.mcf','458.sjeng'});
y=[1.739123 1.188625 3.493624 1.122612 10.270404];
bar(x,y);
title("Benchmark CPI (Default, 2GHz)");
ylabel("CPI");
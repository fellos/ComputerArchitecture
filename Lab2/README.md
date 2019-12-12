# COMPUTER ARCHITECTURE
## LAB 2  Gem5

_Falis Konstantinos_  
_Valasiadou Panagiota_

### **Task 1.a** 


* **Cache Size:**   
**options.py**

  1.L1d size: 64kB 
  > parser.add_option("--l1d_size", type="string", default="64kB")[line:119]   

  2.L1i size: 32kB    
  > parser.add_option("--l1i_size", type="string", default="32kB")[line:120]

  3.L2 size: 2MB  
  >parser.add_option("--l2_size", type="string", default="2MB")[line:121]  

* **Associativity:**  
**options.py**  

  1.L1d assoc: 2    
  >parser.add_option("--l1d_assoc", type="int", default=2)[line:123]  
   
   2.L1i assoc: 2  
   >parser.add_option("--l1i_assoc", type="int", default=2)[line:124]    
   
   3.L2 assoc: 8  
   >parser.add_option("--l2_assoc", type="int", default=8) [line:125]
 

 * **Cache Line Size:**  
  **se.py**

   >system = System(cpu = [CPUClass(cpu_id=i) for i in range(np)],   
                mem_mode = test_mem_mode,  
                mem_ranges = [AddrRange(options.mem_size)],  
                cache_line_size = options.cacheline_size)   [lines:176-180]

    **options.py**  
    >parser.add_option("--cacheline_size", type="int", default=64) [line:127]
  

  ### **config.ini**  

* **L1d:**  
  
  >[system.cpu.dcache]  
  assoc=2  
  size=65536

* **L1i:**  
  
  >[system.cpu.icache]  
  assoc=2  
  size=32768

* **L2:**  

  >[system.l2]  
  assoc=8  
  size=2097152

* **Cache Line Size:**  
  >[system]  
  cache_line_size=64

### **Task 1.b** 
### **stats.txt**  

* **401.bzip2**  |  stats
    ---|---  
	 sim_seconds  |                               0.086956   
	 system.cpu.cpi                |               1.739123    
	 system.cpu.icache.overall_miss_rate::total  | 0.000060  
    system.cpu.dcache.overall_miss_rate::total |  0.014599   
    system.l2.overall_miss_rate::total    |       0.266697  

* **456.hmmer** | stats
    ---|---
	sim_seconds                 |                 0.059431   
	system.cpu.cpi               |                1.188625   
	system.cpu.icache.overall_miss_rate::total  | 0.000128  
    system.cpu.dcache.overall_miss_rate::total |  0.001625   
    system.l2.overall_miss_rate::total          | 0.083085   

 * **470.lbm**  |stats  
    ---|---
	sim_seconds    |                              0.174681   
	system.cpu.cpi       |                        3.493624  
	system.cpu.icache.overall_miss_rate::total |  0.000105  
    system.cpu.dcache.overall_miss_rate::total  | 0.060971   
    system.l2.overall_miss_rate::total         |  0.999946   
   
* **429.mcf**   |stats
    ---|---
	sim_seconds                  |                0.056131  
	system.cpu.cpi                             |  1.122612   
	system.cpu.icache.overall_miss_rate::total |  0.000039  
	system.cpu.dcache.overall_miss_rate::total |  0.002168  
    system.l2.overall_miss_rate::total         |  0.701421   
   
* **458.sjeng**   |stats
    ---|---
	sim_seconds                             |     0.513520   
	system.cpu.cpi                             |  10.270404   
	system.cpu.icache.overall_miss_rate::total  | 0.000015  
    system.cpu.dcache.overall_miss_rate::total |  0.121831  
    system.l2.overall_miss_rate::total          | 0.999945     
      
### **GRAPHS:**  

 ### **1.Execution time (sim_seconds)**

 ![](graphs/sim_seconds.jpg)

### **2.Cycles Per Instruction (CPI)**

![](graphs/cpi.jpg)

### **3.L1 Instruction Cache Miss Rate**

![](graphs/L1Imiss.jpg)

### **4.L1 Data Cache Miss Rate**

![](graphs/L1Dmiss.jpg)

### **5.L2 Cache Miss Rate**

![](graphs/L2miss.jpg)

### **Task 1.c** 

### **stats.txt** 

* **cpu-clock=1GHz**  
  >system.clk_domain.clock                          1000  
   [Clock period in ticks]  
   system.cpu_clk_domain.clock                      1000   
   [Clock period in ticks]

* **cpu-clock=2GHz**  
  >system.clk_domain.clock                          1000  
   [Clock period in ticks]  
   system.cpu_clk_domain.clock                      500   
   [Clock period in ticks]


The **system clock** is needed to synchronize all components on the motherboard.The **CPU clock** has the same purpose, but is only used on the chip itself. Because the CPU needs to perform more operations per time than the motherboard, the CPU clock is much higher. And because we don't want to have another oscillator (e.g. because they also would need to be synchronized), the CPU just takes the system clock and multiplies it by a number, which is either fixed or unlocked.

### **config.json**

* **cpu-clock=2GHz**

  >"clk_domain": {"name": "clk_domain", "clock": [1000],...}

  >"cpu_clk_domain": {"name": "cpu_clk_domain", "clock": [500],...}      
  
**Adding a second core :**  
(--num-cpus=2)  
(cpu0, cpu1)
  >system.clk_domain.clock                          1000     
[Clock period in ticks]  
system.cpu_clk_domain.clock                       500   
[Clock period in ticks]

_All cores(cpu0,cpu1) have the same clock as it is expected._   

### **Scaling**  

				                1GHz			       2GHz		          4GHz
    401.bzip2  sim_seconds    0.166561             0.086956 	    	0.047382

	456.hmmer  sim_seconds    0.118453              0.059431			0.029822

    470.lbm    sim_seconds   0.262355               0.174681			0.132673

    429.mcf    sim_seconds    0.109967              0.056131			 0.028977
	
    458.sjeng  sim_seconds    0.704097              0.513520        	0.417614 
			
	
Scaling is almost perfect for bzip2, mcf,hmmer but not for sjeng,lbm.
The reason is that bzip2, mcf,hmmer,are benchmarks that measure compute-intensive integer performance while lbm is for compute-intensive floating point performance.
Floating point data need more memory that can't fit in cache so the increase of the cpu-clock(the decrease of the sim seconds) is limited by the latency from memory acceses.
Also for sjeng there isn't a perfect scaling and one reason is that it creates a tree of possible chess moves so it needs a lot of memory.Often accesses occuring in lower memory levels makes it difficult for the cpu clock to scale.


### **Task 2.a**  
Results after running the benchmarks with different parameters:  
>_model naming_ :  **spec**[_name of benchmark_]**_L1D**([_size of L1D_],[_associativity of L1D_])**_L1I**([_size of L1I_],[_associativity of L1I_])**_L2**([_size of L2_],[_associativity of L2_])**_CL**([_cache line size_])

>**CPI**=system.cpu.cpi  
**L1D_miss_rate**=system.cpu.dcache.overall_miss_rate::total  
**L1I_miss_rate**=system.cpu.icache.overall_miss_rate::total  
**L2_miss_rate**=system.l2.overall_miss_rate::total

* **401.bzip2** [(results)](./results/Results_bzip2.txt)

Benchmarks 	                  |                         CPI	 |    L1D_miss_rate  |  L1I_miss_rate  | L2_miss_rate
---|---|---|---|---
1.specbzip_L1D(16,4)_L1I(8,4)_L2(4,16)_CL(64)  |       1.646686	|    0.020357	 |   0.000194 |       0.178179
2.specbzip_L1D(16,4)_L1I(8,4)_L2(512,8)_CL(64)	|    1.706717	|    0.020353	 |   0.000195	|    0.275318
3.specbzip_L1D(32,2)_L1I(16,2)_L2(2,8)_CL(64)	 |       1.694298	 |   0.017475	 |   0.000066	|    0.218697
4.specbzip_L1D(32,4)_L1I(16,4)_L2(4,16)_CL(64)	  |  1.612626	  |  0.016517	 |   0.000073	|    0.222360
5.specbzip_L1D(64,1)_L1I(32,1)_L2(2,4)_CL(64)	   |     1.645449	 |   0.017756	|    0.000086	|    0.230784
6.specbzip_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(32)	  |      1.775686	|    0.017700	|    0.000074	|    0.407203
7.specbzip_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(64)	   |     1.665609	|    0.014485	|    0.000060	|    0.266691
8.specbzip_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(128)	   | 1.657915	 |   0.014123	|    0.000051	    |0.163292
9.specbzip_L1D(64,2)_L1I(32,2)_L2(4,8)_CL(64)	|        1.647623	|    0.014478	|    0.000060	|    0.230578
10.specbzip_L1D(64,4)_L1I(32,4)_L2(2,16)_CL(64)	 |   1.598381	|    0.013218	 |   0.000067	|    0.316583
11.specbzip_L1D(64,4)_L1I(32,4)_L2(4,16)_CL(64)	   | 1.583257	 |   0.013213	 |   0.000067	|    0.282450
12.specbzip_L1D(128,2)_L1I(64,2)_L2(2,8)_CL(64)	   | 1.635354	|    0.011626	|    0.000055	|    0.337721
13.specbzip_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(64)	  |  1.627679	|    0.010884	 |   0.000054	 |   0.362860
14.specbzip_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(128)	|    1.615151	|    0.009882	|    0.000042	|    0.237956
15.specbzip_L1D(128,4)_L1I(128,4)_L2(2,8)_CL(128)	|    1.615126	 |   0.009882	|    0.000041	|    0.237953
16.specbzip_L1D(128,4)_L1I(128,4)_L2(4,8)_CL(64)	|    1.609739	|    0.010878	|    0.000054	|    0.313748
17.specbzip_L1D(128,8)_L1I(64,8)_L2(2,8)_CL(64)	   | 1.620015	 |   0.010263	|    0.000054	|    0.386927
18.specbzip_L1D(128,8)_L1I(128,8)_L2(4,16)_CL(64)	 |   1.601439	|    0.010255	|    0.000054	|    0.336071
19.specbzip_L1D(64,2)_L1I(32,2)_L2(1,8)_CL(64)   |    1.630251	 |   0.014684	|    0.000074	|    0.318376
20.specbzip_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(256)	   | 1.608190	|    0.015223	|    0.000054	|    0.108392
21.specbzip_L1D(64,4)_L1I(32,4)_L2(2,16)_CL(256)	|    1.592055	 |   0.013797	|    0.000041	 |   0.119960
22.specbzip_L1D(64,4)_L1I(32,4)_L2(4,16)_CL(256)	|    1.583927	|    0.013765	|    0.000041	 |   0.105156


* **456.hmmer** [(results)](./results/Results_hmmer.txt)

Benchmarks |	                                           CPI	  |   L1D_miss_rate  |  L1I_miss_rate |  L2_miss_rate
---|---|---|---|---	
1.spechmmer_L1D(32,2)_L1I(16,2)_L2(2,8)_CL(64)	    |1.189222	 |   0.002368	  |  0.000781	  |  0.051941
2.spechmmer_L1D(64,1)_L1I(32,1)_L2(2,4)_CL(64)	    |1.209620	  |  0.003468	 |   0.000624    |	0.037902
3.spechmmer_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(32)	   | 1.191317	 |   0.003141	  |  0.000218    |	0.081729
4.spechmmer_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(64)	   | 1.184534	 |   0.001638	 |   0.000205    |	0.082233
5.spechmmer_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(128)	   | 1.181712	|    0.000898	|    0.000259	 |   0.076574
6.spechmmer_L1D(64,2)_L1I(32,2)_L2(4,8)_CL(64)	    |1.184534	 |   0.001638	 |   0.000205	  |  0.082233
7.spechmmer_L1D(64,4)_L1I(32,4)_L2(2,16)_CL(64)	  |  1.184085	 |   0.001593	|    0.000102    |	0.086899
8.spechmmer_L1D(128,2)_L1I(64,2)_L2(2,8)_CL(64)	  |  1.182631	 |   0.000719	   | 0.000102    |	0.196151
9.spechmmer_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(64)	   | 1.182121	 |   0.000667	  |  0.000082    |	0.217930
10.spechmmer_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(128)	|    1.179532	|    0.000374	|    0.000059   | 	0.206267
11.spechmmer_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(256)	 |   1.178365	 |   0.000215	|   0.000044    |	0.192182
12.spechmmer_L1D(128,4)_L1I(64,4)_L2(4,16)_CL(128)|	1.179532	 |   0.000374	   | 0.000059    |	0.206267
13.spechmmer_L1D(128,4)_L1I(128,4)_L2(2,8)_CL(128)	|1.179532	  |  0.000374	  |  0.000055    |	0.207280
14.spechmmer_L1D(128,8)_L1I(64,4)_L2(2,8)_CL(64)	 |   1.181649	|    0.000548    |	0.000082    |	0.272139
15.spechmmer_L1D(64,2)_L1I(32,2)_L2(1,8)_CL(64)	   | 1.187362	  | 0.001645	   | 0.000205	   | 0.082246
16.spechmmer_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(256)	 |   1.182031	|    0.000563	  |  0.000384  |  	0.059629
17.spechmmer_L1D(64,4)_L1I(32,4)_L2(2,8)_CL(128)	  |  1.182821	 |   0.000859	  |  0.000095  |  	0.085677
18.spechmmer_L1D(64,4)_L1I(32,4)_L2(2,8)_CL(128)	 |   1.182821	|    0.000859   |	0.000095	|    0.085677
19.spechmmer_L1D(128,4)_L1I(32,4)_L2(2,8)_CL(128)	 |   1.181330	|    0.000376    |	0.000095    |	0.198898


* **470.lbm** [(results)](./results/Results_libm.txt)

Benchmarks 	  |                                         CPI	|     L1D_miss_rate  |  L1I_miss_rate |  L2_miss_rate	
---|---|---|---|---
1.speclibm_L1D(32,2)_L1I(16,2)_L2(2,8)_CL(64)	    |    2.623140	|0.060971	|0.000108	|0.999892
2.speclibm_L1D(64,1)_L1I(32,1)_L2(2,4)_CL(64)	     |   2.638071|	0.061561	|0.000113	|0.986435
3.speclibm_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(32)	     |   3.921536|	0.121940	|0.000091	|0.999977
4.speclibm_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(64)	   |     2.623555	|0.060971	|0.000099	|0.999927
5.speclibm_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(128)	   |     1.990434	|0.030487	|0.000122|	0.999835
6.speclibm_L1D(64,2)_L1I(32,2)_L2(4,8)_CL(64)	    |    2.621073	|0.060971	|0.000104	|0.999946
7.speclibm_L1D(64,4)_L1I(32,4)_L2(2,16)_CL(64)	  |      2.623150	|0.060971	|0.000094	|0.999983
8.speclibm_L1D(128,2)_L1I(64,2)_L2(2,8)_CL(64)	    |    2.623565	|0.060971	|0.000096	|0.999976
9.speclibm_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(64)	    |    2.623555	|0.060971	|0.000086	|0.999979
10.speclibm_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(128)	|    1.990373	|0.030487	|0.000097	|0.999957
11.speclibm_L1D(128,4)_L1I(128,4)_L2(2,8)_CL(128)	  |  1.990373	|0.030487	|0.000096	|0.999965
12.speclibm_L1D(128,8)_L1I(64,8)_L2(2,8)_CL(64)	    |    2.623555	|0.060971	|0.000086	|0.999982
13.speclibm_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(256)	 |       1.990539	|0.015244	|0.000083	|0.999901
14.speclibm_L1D(128,4)_L1I(64,4)_L2(4,8)_CL(128)	 |       2.576571	|0.030487	|0.000097	|0.999957
15.speclibm_L1D(64,2)_L1I(32,2)_L2(1,8)_CL(64)	    |    3.495281	|0.060971	|0.000099	|0.999927
16.speclibm_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(256)	     |   1.990565	|0.015244	|0.000118	|0.999611


* **429.mcf** [(results)](./results/Results_mcf.txt)
  
Benchmarks 	  |                                         CPI	|     L1D_miss_rate  |  L1I_miss_rate |  L2_miss_rate	
---|---|---|---|---
1.specmcf_L1D(32,2)_L1I(16,2)_L2(2,8)_CL(64)	|1.469198	|0.002390	|0.059433	|0.023445
2.specmcf_L1D(64,1)_L1I(32,1)_L2(2,4)_CL(64)	|1.118466	|0.002560	|0.004668	|0.202505
3.specmcf_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(64)	|1.099667	|0.002168	|0.000039	|0.701190
4.specmcf_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(32)	|1.117471	|0.003094	|0.000044	|0.836402
5.specmcf_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(128)	|1.072646	|0.001276	|0.000042	|0.554544
6.specmcf_L1D(64,2)_L1I(32,2)_L2(4,8)_CL(64)	|1.091092	|0.002051	|0.000037	|0.720964
7.specmcf_L1D(64,4)_L1I(32,4)_L2(2,16)_CL(64)	|1.090521	|0.001952	|0.000020	|0.764178
8.specmcf_L1D(128,2)_L1I(64,2)_L2(2,8)_CL(64)	|1.090129	|0.001913	|0.000019	|0.780518
9.specmcf_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(64)	|1.089742	|0.001866	|0.000019	|0.797806
10.specmcf_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(128)	|1.071351	|0.001085	|0.000013	|0.664389
11.specmcf_L1D(128,4)_L1I(64,4)_L2(4,8)_CL(128)	|1.071267	|0.001085	|0.000013	|0.660887
12.specmcf_L1D(128,4)_L1I(64,4)_L2(4,16)_CL(128)	|1.071267	|0.001085	|0.000013	|0.660887
13.specmcf_L1D(128,4)_L1I(128,4)_L2(2,8)_CL(128)	|1.071351	|0.001085	|0.000013	|0.664456
14.specmcf_L1D(128,8)_L1I(64,8)_L2(2,8)_CL(64)|	1.089662	|0.001857	|0.000019	|0.801627
15.specmcf_L1D(64,2)_L1I(32,2)_L2(1,8)_CL(64)	|1.093448	|0.002051	|0.000037	|0.775969
16.specmcf_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(256)	|1.118754	|0.000946	|0.008173	|0.042457



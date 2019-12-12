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

* **401.bzip2**  
	>sim_seconds                                 0.086956   
	system.cpu.cpi                               1.739123    
	system.cpu.icache.overall_miss_rate::total   0.000060  
    system.cpu.dcache.overall_miss_rate::total   0.014599   
    system.l2.overall_miss_rate::total           0.266697  

* **456.hmmer**
	>sim_seconds                                  0.059431   
	system.cpu.cpi                               1.188625   
	system.cpu.icache.overall_miss_rate::total   0.000128  
    system.cpu.dcache.overall_miss_rate::total   0.001625   
    system.l2.overall_miss_rate::total           0.083085   

 * **470.lbm**   
	>sim_seconds                                  0.174681   
	system.cpu.cpi                               3.493624  
	system.cpu.icache.overall_miss_rate::total   0.000105  
    system.cpu.dcache.overall_miss_rate::total   0.060971   
    system.l2.overall_miss_rate::total           0.999946   
   
* **429.mcf**   
	>sim_seconds                                  0.056131  
	system.cpu.cpi                               1.122612   
	system.cpu.icache.overall_miss_rate::total   0.000039  
	system.cpu.dcache.overall_miss_rate::total   0.002168  
    system.l2.overall_miss_rate::total           0.701421   
   
* **458.sjeng**   
	>sim_seconds                                  0.513520   
	system.cpu.cpi                               10.270404   
	system.cpu.icache.overall_miss_rate::total   0.000015  
    system.cpu.dcache.overall_miss_rate::total   0.121831  
    system.l2.overall_miss_rate::total           0.999945     
      
### **GRAPHS:**  
  

 ![**1.Execution time (sim_seconds)**] (graphs/sim_seconds.jpg)

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


### **Task 2**

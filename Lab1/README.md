# COMPUTER ARCHITECTURE
## LAB 1  Gem5

_Falis Konstantinos_  
_Valasiadou Panagiota_  

### **Task 1**

### **Essential system features in starter_se.py**

* **CPU type** : In starter_se.py there are 3 possible CPU types (atomic, minor, hpi). [lines:69-79]  
We execute with **--cpu-type="minor"**.

* **System Voltage** : 3.3V    
 > self.voltage_domain = VoltageDomain(voltage="3.3V") [line:99]

* **System Clock** : 1 GHz   
 >self.clk_domain = SrcClockDomain(clock="1GHz",voltage_domain=self.voltage_domain) [lines:100-101]


* #### **CPU :**
>self.cpu_cluster = devices.CpuCluster(self, args.num_cores, args.cpu_freq, "1.2V", *cpu_types[args.cpu])     
1. Number of cores: 1 (default) [line:195]
2. Frequency: 4GHz (default) [line:194] 
3. Voltage:1.2V   
4. Type: minor (set by user)


* **CACHE :** 

>if self.cpu_cluster.memoryMode() == "timing":  
            self.cpu_cluster.addL1() **_L1 cache_**       
            self.cpu_cluster.addL2(self.cpu_cluster.clk_domain)         **_L2 cache_**

We are using a **minor CPU** which uses **timing** transport interface so **L1** and **L2** are created.

>"minor" : (MinorCPU,
               devices.L1I, devices.L1D,
               devices.WalkCache,
               devices.L2),

 ### **--devices.py--**   
 (more information about caches)  
 * **class L1I(L1_ICache):**  
    tag_latency = 1  
    data_latency = 1  
    response_latency = 1  
    mshrs = 4  
    tgts_per_mshr = 8  
    size = '48kB'  
    assoc = 3

* **class L1D(L1_DCache):**  
    tag_latency = 2  
    data_latency = 2  
    response_latency = 1  
    mshrs = 16  
    tgts_per_mshr = 16  
    size = '32kB'  
    assoc = 2  
    write_buffers = 16


* **class WalkCache(PageTableWalkerCache):**  
    tag_latency = 4  
    data_latency = 4  
    response_latency = 4  
    mshrs = 6  
    tgts_per_mshr = 8  
    size = '1kB'  
    assoc = 8  
    write_buffers = 16


* **class L2(L2Cache):**  
    tag_latency = 12   
    data_latency = 12  
    response_latency = 5  
    mshrs = 32  
    tgts_per_mshr = 8  
    size = '1MB'  
    assoc = 16  
    write_buffers = 8  
    clusivity='mostly_excl'

* cache_line_size = 64  [line:196]

_More specific :_  
* **L1I :**
    * size= 48 KB  
    * associativity= 3

* **L1D :**  
    * size= 32 KB  
    * associativity= 2

* **L2 :**  
    * size= 1 MB  
    * associativity= 16

* **Walk Cache :**  
    * size= 1 KB
    * associativity= 8


* **MEMORY :**

  * Memory Ranges:  
    >system.mem_ranges = [ AddrRange(start=0, size=args.mem_size) ]     


  * Configure the off-chip Memory System:
    >MemConfig.config_mem(args, system)                                           
  
  * Memory Type:
    >parser.add_argument("--mem-type", default="DDR3_1600_8x8",
  * Memory Channels:
    >parser.add_argument("--mem-channels", type=int, default=2,
                        help = "number of memory channels")
  * Memory Size:
    >parser.add_argument("--mem-size", action="store", type=str,
                        default="2GB",
                        help="Specify the physical memory size")  
                         
As in the building process we don't change these arguments ,in the execution of Hello World the simulator uses the **default** arguments for **memory type**, **memory channels** and **memory size**. 

>Type= DDR3 1600 8x8  
Number of channels= 2    
Size= 2 GB

 ### **Task 2**

### **Essential system features in config.ini**

**[system]**   
* **In --devices.py-- :** cache_line_size=64  
* **Memory mode:** mem_mode=timing  
* **Memory size:** mem_ranges=0:2147483647   
* **Number of memory channels:** memories=system.mem_ctrls0 system.mem_ctrls1 
  
**[system.clk_domain]**  
* **System Clock in picoseconds:** clock=1000	  


**[system.cpu_cluster.cpus]**  
* **CPU Type:** type=MinorCPU   
* **Number of cores:** numThreads=1 

**[system.cpu_cluster.clk_domain]**  
* **Cpu clock in picoseconds:** clock=250 

**[system.cpu_cluster.cpus.dcache]**  
* **Size of L1D:**   size=32768  
* **Associativity of L1D:** assoc=2

**[system.cpu_cluster.cpus.dtb_walker_cache]**
* **Size of Walk_Cache_D:** size=1024
* **Associativity of Walk_Cache_D:**    assoc=8

**[system.cpu_cluster.cpus.icache]**
* **Size of L1I:**   size=49152
* **Associativity of L1I:**    assoc=3

**[system.cpu_cluster.cpus.itb_walker_cache]**
* **Size of Walk_Cache_I:**   size=1024
* **Associativity of Walk_Cache_I:**    assoc=8
    
**[system.cpu_cluster.l2]**
* **Size of L2:**   size=1048576
* **Associativity of L2:**    assoc=16

**[system.cpu_cluster.voltage_domain]**  
* **CPU Voltage(V):** voltage=1.2 

**[system.mem_ctrls0]**  
*    **DRAM Type:** type=DRAMCtrl  
*    device_size=536870912  
*    **Size of memory:** range=0:2147483647:0:1048704 
*    **Type of memory:**
    _DDR3 1600 8x8 : [file: /scr/mem/DRAMCtrl.py Micron Datasheet pg.43]_   
        		IDD0=0.055  
                IDD02=0.0  
				IDD2N=0.032     
				IDD2N2=0.0  
				IDD2P0=0.0    
				IDD2P02=0.0  
				IDD2P1=0.032  
				IDD2P12=0.0  
				IDD3N=0.038  
				IDD3N2=0.0  
				IDD3P0=0.0  
				IDD3P02=0.0  
				IDD3P1=0.038  
				IDD3P12=0.0  
				IDD4R=0.157  
				IDD4R2=0.0  
				IDD4W=0.125  
				IDD4W2=0.0  
				IDD5=0.235  
				IDD52=0.0  
				IDD6=0.02  
				IDD62=0.0  
				VDD=1.5  
				VDD2=0.0  

**[system.mem_ctrls1]**  
* device_size=536870912  
* **Size of memory:** range=0:2147483647:1:1048704 


**[system.voltage_domain]**  
* **System Voltage(V):** voltage=3.3 

 ### **Task 3**


### In-Order CPUS

### **1. SimpleCPU**

The [SimpleCPU][Simple] is a purely functional, in-order model that is suited for cases where a detailed model is not necessary. This can include warm-up periods, client systems that are driving a host, or just testing to make sure a program works.

It has recently been re-written to support the new memory system, and is now broken up into three classes. 

The **BaseSimpleCPU** serves several purposes:

* Holds architected state, stats common across the SimpleCPU models.
* Defines functions for checking for interrupts, setting up a fetch request, handling pre-execute setup, handling post-execute actions, and advancing the PC to the next instruction. These functions are also common across the SimpleCPU models.
* Implements the ExecContext interface.

The BaseSimpleCPU can not be run on its own. You must use one of the classes that inherits from BaseSimpleCPU, either AtomicSimpleCPU or TimingSimpleCPU. 

### **2. AtomicSimpleCPU**

The [AtomicSimpleCPU][Simple] is the version of SimpleCPU that uses atomic memory accesses (see Memory System for details). It uses the latency estimates from the atomic accesses to estimate overall cache access time. The AtomicSimpleCPU is derived from BaseSimpleCPU, and implements functions to read and write memory, and also to tick, which defines what happens every CPU cycle. It defines the port that is used to hook up to memory, and connects the CPU to the cache. 

### **3. TimingSimpleCPU**

The [TimingSimpleCPU][Simple] is the version of SimpleCPU that uses timing memory accesses . It stalls on cache accesses and waits for the memory system to respond prior to proceeding. Like the AtomicSimpleCPU, the TimingSimpleCPU is also derived from BaseSimpleCPU, and implements the same set of functions. It defines the port that is used to hook up to memory, and connects the CPU to the cache. It also defines the necessary functions for handling the response from memory to the accesses sent out. 

### **4. Minor CPU**

[Minor CPU](http://www.gem5.org/docs/html/minor.html?fbclid=IwAR0zAVrSlCAW6b8MJA-phUJFG5HDSK-gBbcChqL2u-lbZzdn-kLQKVCBLKc) is an in-order processor model with a fixed pipeline but configurable data structures and execute behaviour. It is intended to be used to model processors with strict in-order execution behaviour and allows visualisation of an instruction's position in the pipeline through the MinorTrace/minorview.py format/tool. The intention is to provide a framework for micro-architecturally correlating the model with a particular, chosen processor with similar capabilities.

#### **Task 3.a**

### **--Se.py--**

* **MatrixMult DIM=10**
   >**MinorCPU:**  
	host_seconds                                     0.99  
	sim_seconds                                  0.000137

   >**TimingSimpleCPU:**   
	host_seconds                                     0.46                       
	sim_seconds                                  0.000270


* **MatrixMult DIM=20**

  >**MinorCPU:**   
	host_seconds                                     4.32  
	sim_seconds                                  0.000601

  >**TimingSimpleCPU:**  
	host_seconds                                     1.91  
	sim_seconds                                  0.001379

* **MatrixMult DIM=50**
   >**MinorCPU:**  
	host_seconds                                    45.52  
	sim_seconds                                  0.006584

   >**TimingSimpleCPU:**  
	host_seconds                                    21.37  
	sim_seconds                                  0.015891

#### **Task 3.b**

We run a simple **matrix multiplication program** of 2-dimensional arrays, with dimension equal to 10,20,50. The CPU types that we are using are: **Minor** and **TimingSimple**.
Gathering the results from **stats.txt**, we came to the conclusion that the simulation time (sim_seconds) of MinorCPU is approximately half the time of TimingSimple.
However, the real time elapsed on the host(host_seconds) of MinorCPU is about two-times the host time of TimingSimple. 

This conclusion is expected, since we know that the [TimingSimple][pdfgem5](pg.94) model isn't pipelined ,opposed to the [Minor][pdfgem5](pg.95-96) model which supports parameterizable in-order pipeline.
The pipeline makes the Minor Model faster (sim_seconds), but harder to emulate on the host system(host_seconds).


[TimingSimple](https://www.cse.wustl.edu/~roger/560M.f17/p1-binkert.pdf)(pg.4)  are non-pipelined CPU models that attempt to fetch, decode,execute and commit a single instruction on every cycle.  
 TimingSimple CPU also only allows one outstanding memory request at a time,but the CPU does model the timing of memory accesses.  
The  InOrder  model  is  an  “execute-in-execute”  CPUmodel emphasizing instruction timing and simulation accuracy with an in-order pipeline.
 

#### **Task 3.c**
* **MinorCPU:**
  
	>CPU clock= **2GHz**  
    Memory Type: DDR3 1600 8x8  
	sim_seconds             	_0.000137_

	>CPU clock= **4GHz**  
    Memory Type: DDR3 1600 8x8  
	sim_seconds                     _0.000086_

	>CPU clock= **1GHz**  
    Memory Type: DDR3 1600 8x8  
	sim_seconds                     _0.000239_


	>CPU clock= 2GHz  
    Memory Type: **DDR4_2400_16x4**  
	sim_seconds             	_0.000137_

	>CPU clock= 2GHz  
    Memory Type: **LPDDR2_S4_1066_1x32**  
	sim_seconds             	_0.000148_

	>CPU clock= 2GHz   
    Memory Type: **DDR3_2133_8x8**  
	sim_seconds             	_0.000136_



* **TimingSimple:**
	
	>CPU clock= **2GHz**   
    Memory Type: DDR3 1600 8x8  
	sim_seconds             	_0.000270_

	>CPU clock= **4GHz**  
    Memory Type: DDR3 1600 8x8  
    sim_seconds                     _0.000150_

	>CPU clock= **1GHz**   
    Memory Type: DDR3 1600 8x8  
    sim_seconds                     _0.000513_
	
	>CPU clock= 2GHz   
    Memory Type: **DDR4_2400_16x4**   
	sim_seconds             	_0.000270_

	>CPU clock= 2GHz   
    Memory Type: **LPDDR2_S4_1066_1x32**  
	sim_seconds             	_0.000279_

	>CPU clock= 2GHz   
    Memory Type: **DDR3_2133_8x8**  
	sim_seconds             	_0.000269_

1. In both CPU models, **changing the CPU clock** has a similar effect on simulation time, for example doubling the frequency reduces the time in half.
2. In both CPU models, **changing the memory type** has very little or no effect.This result is expected, since our program does not need a lot of main memory accesses and uses the Cache memory most of the time.

### **Conclusion**

This lab exercise introduced us to the process of a CPU simulation with gem5 and helped us recreate it on our systems.
Therefore, we learned that using the System Call Emulation Mode we can extract useful data about the emulated system _(e.g. How the system efficiency depends on the CPU type)_
and about the program that we run _(e.g. How much RAM it uses)_.

#### **What we liked:**
	-Getting familiar with LINUX and its terminal.
	-Learning the fundamentals of git and github , although it seemed overwhelming at first.
	-Gathering and comparing the output statistics of our simulation.

#### **What gave us a hard time:**
	-Understanding which parameters affect the output data.
	-Separating out the information needed in big files of code/text.
	-Finding useful internet sources about gem5 (besides gem5.org).


### **Bibliography/Useful Links:**

http://www.m5sim.org/SimpleCPU  
http://www.gem5.org/docs/html/minor.html?fbclid=IwAR0zAVrSlCAW6b8MJA-phUJFG5HDSK-gBbcChqL2u-lbZzdn-kLQKVCBLKc  
http://gem5.org/wiki/images/0/0e/ASPLOS2017_gem5_tutorial.pdffbclid=IwAR3kHguRVrkT74t7tcch8xIu8fyCqwR_iIF9Szbs6TKdBVqX_CMAm1gpIm4 https://www.cse.wustl.edu/~roger/560M.f17/p1-binkert.pdf  
http://learning.gem5.org/book/part1/index.html  
https://github.com/CSL-KU/SpectreGuard/blob/master/gem5/src/mem/DRAMCtrl.pyfbclid=IwAR1mu00WGPjtzC3tYkpNH5FihD52JFyzwFQ8ysVGc8bvpK2_9pCfYXkEdKs  


[Simple]:http://www.m5sim.org/SimpleCPU
[pdfgem5]:http://gem5.org/wiki/images/0/0e/ASPLOS2017_gem5_tutorial.pdf?fbclid=IwAR3kHguRVrkT74t7tcch8xIu8fyCqwR_iIF9Szbs6TKdBVqX_CMAm1gpIm4
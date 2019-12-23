# COMPUTER ARCHITECTURE
## LAB 3 Energy-Delay-Area Product Optimization (gem5 + McPAT)

_Falis Konstantinos_  
_Valasiadou Panagiota_

### **Task 1.a**

There are several factors contributing to the CPU power consumption. They include dynamic power consumption, short-circuit power consumption, and power loss due to transistor leakage currents.

![](./graphs/type1.png)

* **Dynamic Power:**  
  The dynamic power consumption originates from the activity of logic gates inside a CPU. When the logic gates toggle, energy is flowing as the capacitors inside them are charged and discharged. The dynamic power consumed by a CPU is approximately proportional to the CPU frequency, and to the square of the CPU voltage.  
  
  
  ![](./graphs/type2.png)
    
    where C is capacitance, f is frequency, and V is voltage.

* **Leakage Power:**  
  Power consumption due to leakage power emanates at a micro-level in transistors. Small amounts of currents are always flowing between the differently doped parts of the transistor. The magnitude of these currents depend on the state of the transistor, its dimensions, physical properties and sometimes temperature. The total amount of leakage currents tends to inflate for increasing temperature and decreasing transistor sizes.

>Dynamic power consumption is dependent on the clock frequency, while the leakage current is dependent on the CPU supply voltage. It has been shown that the energy consumption of a program shows convex energy behavior, meaning that there exists an optimal CPU frequency at which energy consumption is minimal.

**Running different programms** to the same CPU(not in parallel) affects the instant clock rate for each programm. So, the instant clock frequency of the cpu is different for each programm. As it was mentioned dynamic power consuption is dependent on the clock frequency, so dynamic power is affected by the program that is running.The affection can be observed by the above formula( : Pdyn = C(V^2)f ).The leakage power is not dependent on the clock frequency but on the supply voltage.We can assume that leakage is static and running different programs will not affect it.


It is well known that power is not dependent on time (power=energy/time).So,the execution time of a program isn't a factor that affects the dynamic power or the leakage power.We only need the execution time for the energy calculation.

### **Task 1.b**
**Energy Efficiency:**  

In computing, performance per watt is a measure of the energy efficiency of a particular computer architecture or computer hardware. Literally, it measures the rate of computation that can be delivered by a computer for every watt of power consumed.

We can conclude that the useful information is the energy that is consumed for a particular progress (Energy=Power*Time).To measure energy efficiency we need the number performance/power. The McPAT can provide the power but not the total energy.We need a performance measure such as the time that a progress takes to end.  

So, in this case we have two processors (5 Watt, 40 Watt) and we need to choose one for a particular system with a constant battery capacity. We can not choose with confidence as there is a possibility for the 40 Watt processor to be more energy efficient than the 5 Watt processor and provide to the system more battery life. To be sure about our choice we need some  information about the performance of the processors. This way we could measure the energy efficiency for each processor. McPAT can't provide these  information as we have mentioned above. 

### **Task 1.c**

* **Xeon(Xeon.xml):**   
performance = 40,  
power= runtime dynamic + total leakage  ->   
Runtime Dynamic= 72.9199 W  
Total Leakage= 36.8319 W  
Power=109.7518 W  
energy_eff= performance/power  
energy_eff= 40/109.7518 = 0.36446

* **ARM A9(ARM_A9_2GHz.xml):**   
performance = 1,   
power= runtime dynamic + total leakage  ->   
Runtime Dynamic= 2.96053 W  
Total Leakage= 0.108687 W  
Power=3.069217 W   
energy_eff= performance/power  
energy_eff= 1/3.069217 = 0.325816  

We can observe that Xeon seems to be more energy efficient than ARM A9. However, we have to take into consideration that the total leakage power in Xeon is big enough. That means that even when the system is idle, there is power consumed due to leakage. The conclusion is that in the long term , the ARM A9 processor is the most energy efficient one(between ARM A9 and Xeon).     

### **Task 2**
The main goal here is to calculate the EDAP (Energy Delay Area product) for every CPU model that we created in the previous lab exercise **(see ./spec_results)**.
To achieve that, we created the xml file **(see ./cpus)** for every CPU model and then used them to get the McPAT results for each one **(see ./mcpat_results)**.

**EDAP**

* Energy : We used the energy value from the outpur results of the print_energy.py scripts **(see ./energy_results)**.
* Delay : We used the execution time of each program , that is the sim_seconds value from the gem5 stats.txt .
* Area: We used the sum of Core:Area and L2:Area of the McPat results.
* **EDAP = Energy(mJ) * Delay(sec) * Area(mm^2)**

- ### **bzip:**

Models |         
---|
1.specbzip_L1D(16,4)_L1I(8,4)_L2(4,16)_CL(64)  |       
2.specbzip_L1D(16,4)_L1I(8,4)_L2(512,8)_CL(64)	|    
3.specbzip_L1D(32,2)_L1I(16,2)_L2(2,8)_CL(64)	 |      
4.specbzip_L1D(32,4)_L1I(16,4)_L2(4,16)_CL(64)	  |  
5.specbzip_L1D(64,1)_L1I(32,1)_L2(2,4)_CL(64)	   |     
6.specbzip_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(32)	  |      
7.specbzip_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(64)	   |    
8.specbzip_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(128)	   | 
9.specbzip_L1D(64,2)_L1I(32,2)_L2(4,8)_CL(64)	|    
10.specbzip_L1D(64,4)_L1I(32,4)_L2(2,16)_CL(64)	 |   
11.specbzip_L1D(64,4)_L1I(32,4)_L2(4,16)_CL(64)   |
12.specbzip_L1D(128,2)_L1I(64,2)_L2(2,8)_CL(64)	   | 
13.specbzip_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(64)	  |  
14.specbzip_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(128)	|   
15.specbzip_L1D(128,4)_L1I(128,4)_L2(2,8)_CL(128)	|   
16.specbzip_L1D(128,4)_L1I(128,4)_L2(4,8)_CL(64)	|    
17.specbzip_L1D(128,8)_L1I(64,8)_L2(2,8)_CL(64)	   |
18.specbzip_L1D(128,8)_L1I(128,8)_L2(4,16)_CL(64)	 |  
19.specbzip_L1D(64,2)_L1I(32,2)_L2(1,8)_CL(64)   | 
20.specbzip_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(256)	   | 
21.specbzip_L1D(64,4)_L1I(32,4)_L2(2,16)_CL(256)	|    
22.specbzip_L1D(64,4)_L1I(32,4)_L2(4,16)_CL(256)	|    
**For the EDAP results click [here](./edap/edap_bzip.txt).**

- ### **hmmer:**
Models |
---|
1.spechmmer_L1D(32,2)_L1I(16,2)_L2(2,8)_CL(64)	    |
2.spechmmer_L1D(64,1)_L1I(32,1)_L2(2,4)_CL(64)	    |
3.spechmmer_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(32)	   | 
4.spechmmer_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(64)	   | 
5.spechmmer_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(128)	   | 
6.spechmmer_L1D(64,2)_L1I(32,2)_L2(4,8)_CL(64)	    |
7.spechmmer_L1D(64,4)_L1I(32,4)_L2(2,16)_CL(64)	  |  
8.spechmmer_L1D(128,2)_L1I(64,2)_L2(2,8)_CL(64)	  |
9.spechmmer_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(64)	   | 
10.spechmmer_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(128)	|   
11.spechmmer_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(256)	 | 
12.spechmmer_L1D(128,4)_L1I(64,4)_L2(4,16)_CL(128)|	
13.spechmmer_L1D(128,4)_L1I(128,4)_L2(2,8)_CL(128)	|
14.spechmmer_L1D(128,8)_L1I(64,4)_L2(2,8)_CL(64)	 |   
15.spechmmer_L1D(64,2)_L1I(32,2)_L2(1,8)_CL(64)	   | 
16.spechmmer_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(256)	 |   
17.spechmmer_L1D(64,4)_L1I(32,4)_L2(2,8)_CL(128)	  |  
18.spechmmer_L1D(64,4)_L1I(32,4)_L2(2,8)_CL(128)	 |   
19.spechmmer_L1D(128,4)_L1I(32,4)_L2(2,8)_CL(128)	 | 

>Note: Models 17 and 18 were the same by mistake so we overlooked model 18.

**For the EDAP results click [here](./edap/edap_hmmer.txt).**
- ### **libm:**
Models 	  |             	
---|
1.speclibm_L1D(32,2)_L1I(16,2)_L2(2,8)_CL(64)	    |    
2.speclibm_L1D(64,1)_L1I(32,1)_L2(2,4)_CL(64)	     |   
3.speclibm_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(32)	     |  
4.speclibm_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(64)	   |     
5.speclibm_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(128)	   |    
6.speclibm_L1D(64,2)_L1I(32,2)_L2(4,8)_CL(64)	    |    
7.speclibm_L1D(64,4)_L1I(32,4)_L2(2,16)_CL(64)	  |     
8.speclibm_L1D(128,2)_L1I(64,2)_L2(2,8)_CL(64)	    |    
9.speclibm_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(64)	    |    
10.speclibm_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(128)	|    
11.speclibm_L1D(128,4)_L1I(128,4)_L2(2,8)_CL(128)	  |  
12.speclibm_L1D(128,8)_L1I(64,8)_L2(2,8)_CL(64)	    |    
13.speclibm_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(256)	 |       
14.speclibm_L1D(128,4)_L1I(64,4)_L2(4,8)_CL(128)	 |      
15.speclibm_L1D(64,2)_L1I(32,2)_L2(1,8)_CL(64)	    |    
16.speclibm_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(256)	     |  

**For the EDAP results click [here](./edap/edap_libm.txt).**

- ### **mcf:**
 Models 	  |       
---|
1.specmcf_L1D(32,2)_L1I(16,2)_L2(2,8)_CL(64)	|
2.specmcf_L1D(64,1)_L1I(32,1)_L2(2,4)_CL(64)	|
3.specmcf_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(64)	|
4.specmcf_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(32)	|
5.specmcf_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(128)	|
6.specmcf_L1D(64,2)_L1I(32,2)_L2(4,8)_CL(64)	|
7.specmcf_L1D(64,4)_L1I(32,4)_L2(2,16)_CL(64)	|
8.specmcf_L1D(128,2)_L1I(64,2)_L2(2,8)_CL(64)	|
9.specmcf_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(64)	|
10.specmcf_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(128)	|
11.specmcf_L1D(128,4)_L1I(64,4)_L2(4,8)_CL(128)	|
12.specmcf_L1D(128,4)_L1I(64,4)_L2(4,16)_CL(128)	|
13.specmcf_L1D(128,4)_L1I(128,4)_L2(2,8)_CL(128)	|
14.specmcf_L1D(128,8)_L1I(64,8)_L2(2,8)_CL(64)|	
15.specmcf_L1D(64,2)_L1I(32,2)_L2(1,8)_CL(64)	|
16.specmcf_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(256)	|

**For the EDAP results click [here](./edap/edap_mcf.txt).**

- ### **sjeng:**
 Models	  |        
---|
1.specsjeng_L1D(16,2)_L1I(8,2)_L2(256,8)_CL(128)	|
2.specsjeng_L1D(16,2)_L1I(8,2)_L2(256,8)_CL(256)	|
3.specsjeng_L1D(16,2)_L1I(8,2)_L2(512,8)_CL(64)	|
4.specsjeng_L1D(16,2)_L1I(8,2)_L2(512,8)_CL(256)	|
5.specsjeng_L1D(32,2)_L1I(16,2)_L2(2,8)_CL(256)	|
6.specsjeng_L1D(32,4)_L1I(16,4)_L2(512,8)_CL(32)|	
7.specsjeng_L1D(64,1)_L1I(32,1)_L2(2,4)_CL(64)	|
8.specsjeng_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(32)|	
9.specsjeng_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(64)|	
10.specsjeng_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(128)	|
11.specsjeng_L1D(64,2)_L1I(32,2)_L2(4,8)_CL(64)|	
12.specsjeng_L1D(64,4)_L1I(32,4)_L2(2,16)_CL(64)	|
13.specsjeng_L1D(64,4)_L1I(128,4)_L2(4,8)_CL(256)|
14.specsjeng_L1D(128,2)_L1I(64,2)_L2(2,8)_CL(64)|	
15.specsjeng_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(64)	|
16.specsjeng_L1D(128,4)_L1I(64,4)_L2(2,8)_CL(128)	|
17.specsjeng_L1D(128,4)_L1I(128,4)_L2(2,8)_CL(128)|	
18.specsjeng_L1D(128,4)_L1I(128,4)_L2(4,8)_CL(128)|	
19.specsjeng_L1D(128,8)_L1I(64,8)_L2(2,8)_CL(64)|	
20.specsjeng_L1D(32,2)_L1I(16,2)_L2(2,8)_CL(64)|
21.specsjeng_L1D(64,2)_L1I(32,2)_L2(1,8)_CL(64)	|
22.specsjeng_L1D(64,2)_L1I(32,2)_L2(2,8)_CL(256)|	

**For the EDAP results click [here](./edap/edap_sjeng.txt).**

### **Task 2.c**
Here, we will compare the EDAP results from every model with values of the cost function that we defined in the 2nd Lab. The comparison is accomplished with the respective bargraphs, and a scatterplot of the F function vs EDAP for each benchmark.
The scatterplot shows the correlation (r) between the two units , which were standarized to get a more precise presentation since F and EDAP have incomparable values.
- ### **bzip:**
  ![](./graphs/f_bzip.jpg)
  ![](./graphs/bzip_edap1.jpg)
  >The 2nd model has both the lowest cost-efficiency(F) and EDAP value. Besides that, we cannot see any other pattern about the relation of cost and EDAP.

  ![](./graphs/bzip_edap2.jpg)
  >The correlation is small, so we can say that the EDAP does not depend on the cost function.

- ### **hmmer:**
  ![](./graphs/f_hmmer.jpg)
  ![](./graphs/hmmer_edap1.jpg)

  >Similarly, the same model (15) has both the lowest cost-efficiency(F) and EDAP value. Besides that, we cannot see any other pattern about the relation of cost and EDAP.

  ![](./graphs/hmmer_edap2.jpg)
  >The correlation is the biggest for this benchmark but it is still small, so the two variables have a weak relation.

- ### **libm:**
  ![](./graphs/f_libm.jpg)
  ![](./graphs/libm_edap1.jpg)

  >Here, the most cost efficient model has a relatively high EDAP and vice versa.


  ![](./graphs/libm_edap2.jpg)
  >The correlations is small and negative. So, by comparing to the other benchamrks we can only tell that there is no dependency.

- ### **mcf:**
  ![](./graphs/f_mcf.jpg)
  ![](./graphs/mcf_edap1.jpg)
  ![](./graphs/mcf_edap2.jpg)

  >Here, the correlation coefficient is so small that it is clear that the two variables are completely independent.

  - ### **sjeng:**
  ![](./graphs/f_sjeng.jpg)
  ![](./graphs/sjeng_edap1.jpg)
  ![](./graphs/sjeng_edap2.jpg)

  >The same applies here, there is no relation between EDAP and the cost function.

Although we expected to see some relation between the two measures since they both include a performance unit (CPI and Delay),
our calculations showed that there is **no clear dependency** between the cost function 
**F = cost * CPI** and the **EDAP = Energy * Delay * Area**, 
 meaning that the cost of a CPU does not depend on the area it covers or the energy it consumes,

### **Conclusion/Review**
>This lab exercise introduced us to the concepts of CPU power, Energy efficiency and EDAP optimization , with the help of McPAT.
- **Task 1:** It was easy to find information about the power consumed in a CPU and it only required some effort to understand how is energy efficiency defined. 
- **Task 2:** Gathering and presenting the results of mcpat took quite some time and repetitive work, while all benchmarks lead to the same conclusions. It would be preferable to use only one or two of them for this lab.
### **Bibliography/Useful Links:**
 


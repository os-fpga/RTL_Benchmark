
#!/bin/csh

vcom ../../Components/Utils_pkg.vhd
vcom -93 ../../Components/rom.vhd
vcom -93 ../../Components/ram.vhd

vcom ../cpuC_utils.vhd     
vcom ../cpuC_cu.vhd     
vcom ../cpuC_du.vhd     
vcom ../cpuC_iu.vhd     
vcom ../cpuC_oa.vhd  
vcom ../cpuC.vhd  

vcom ./Clock.vhd
vcom ./World.vhd
vcom ./testbench_a.vhd
   


#!/bin/csh

vcom ../../Components/Utils_pkg.vhd
vcom ../../Components/stack_if.vhd
vcom ../../Components/sram.vhd
vcom ../../Components/stack_t.vhd
vcom -93 ../../Components/ram.vhd
vcom ../../Components/timer.vhd
vcom ../../Components/h2v.vhd
vcom ../../Components/waitstategen.vhd
vcom ../../Components/ctrl16cpu.vhd

vcom ../cpu_utils.vhd     
vcom ../cpu_cu.vhd     
vcom ../cpu_du.vhd     
vcom ../cpu_iu.vhd     
vcom ../cpu_oa.vhd  
vcom ../cpu.vhd  

vcom ./Clock.vhd
vcom ./World.vhd
vcom ./cpu16bit.vhd
vcom ./testbench_a.vhd
   

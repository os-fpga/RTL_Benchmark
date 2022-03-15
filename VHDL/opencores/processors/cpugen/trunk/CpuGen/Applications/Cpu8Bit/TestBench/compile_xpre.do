
#!/bin/csh

vcom ../../Components/Utils_pkg.vhd
vcom ../../Components/interrupt.vhd
vcom ../../Components/inout4reg.vhd
vcom -93 ../../Components/ram.vhd
vcom -93 ../../Components/rom.vhd
vcom ../../Components/timer.vhd
vcom ../../Components/tx_uart.vhd
vcom ../../Components/rx_uart.vhd
vcom ../../Components/ctrl8cpu.vhd

vcom ../cpu_utils.vhd     
vcom ../cpu_cu.vhd     
vcom ../cpu_du.vhd     
vcom ../cpu_iu.vhd     
vcom ../cpu_oa.vhd  
vcom ../cpu.vhd  

vcom ./Clock.vhd
vcom ./World.vhd
vcom ./cpu8bit.vhd
vcom ./testbench_x.vhd
   

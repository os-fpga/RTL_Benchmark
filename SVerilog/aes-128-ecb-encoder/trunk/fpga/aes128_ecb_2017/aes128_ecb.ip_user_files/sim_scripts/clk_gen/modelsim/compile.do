vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm

vlog -work xil_defaultlib -64 -incr -sv -L xil_defaultlib "+incdir+../../../ipstatic" "+incdir+/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/xilinx_vip/include" \
"/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ipstatic" "+incdir+/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen_clk_wiz.v" \
"../../../../aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen.v" \

vlog -work xil_defaultlib \
"glbl.v"


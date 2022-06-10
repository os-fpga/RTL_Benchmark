vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv -L xil_defaultlib "+incdir+../../../ipstatic" "+incdir+/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/xilinx_vip/include" \
"/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic" "+incdir+/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen_clk_wiz.v" \
"../../../../aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen.v" \

vlog -work xil_defaultlib \
"glbl.v"


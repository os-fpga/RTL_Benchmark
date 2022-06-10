vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../ipstatic" "+incdir+/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/xilinx_vip/include" \
"/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" "+incdir+/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../ipstatic" "+incdir+/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen_clk_wiz.v" \
"../../../../aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen.v" \

vlog -work xil_defaultlib \
"glbl.v"


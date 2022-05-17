-makelib ies_lib/xil_defaultlib -sv \
  "/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen_clk_wiz.v" \
  "../../../../aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib


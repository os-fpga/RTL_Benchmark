-makelib ies_lib/xil_defaultlib -sv \
  "/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "/opt/cad/xilinx/Vivado2017/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/axi_lite_ipif_v3_0_4 \
  "../../../ipstatic/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/lib_pkg_v1_0_2 \
  "../../../ipstatic/hdl/lib_pkg_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/lib_srl_fifo_v1_0_2 \
  "../../../ipstatic/hdl/lib_srl_fifo_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/lib_cdc_v1_0_2 \
  "../../../ipstatic/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/axi_uartlite_v2_0_19 \
  "../../../ipstatic/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../aes128_ecb.srcs/sources_1/ip/axi_uartlite_module/sim/axi_uartlite_module.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib


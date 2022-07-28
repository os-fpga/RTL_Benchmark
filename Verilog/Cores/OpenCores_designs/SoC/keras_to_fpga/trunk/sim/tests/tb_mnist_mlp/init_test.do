# ------------------------------------
#
# ------------------------------------

global env

# setup environment
do ../../../scripts/sim_env.do
set env(SIM_TARGET) fpga
set env(ALTERA_LIBS) $env(PROJECT_DIR)/sim/libs/quartus_17_1/verilog_libs
set env(IP_DIR) $env(PROJECT_DIR)/syn/mac

radix -hexadecimal

make_lib work 1

sim_compile_lib $env(LIB_BASE_DIR) tb_packages
sim_compile_lib $env(LIB_BASE_DIR) bfm_packages
sim_compile_lib $env(LIB_BASE_DIR) qaz_lib
sim_compile_lib $env(LIB_BASE_DIR) axi4_lib
sim_compile_lib $env(LIB_BASE_DIR) sim

# vlog -f ./tb_pkg_files.f
vlog $env(LIB_BASE_DIR)/BFM/src/axis_video_frame/avf_pkg.sv
vlog $env(PROJECT_DIR)/sim/src/anf/anf_pkg.sv

vlog -f ./tb_files.f

vlog -f ../../src/ip_files.f
vlog -f ./files.f

sim_run_test



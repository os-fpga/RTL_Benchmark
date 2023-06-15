create_design 3002_oc_8051_x6

add_design_file -V_2001 \
        ${ROOT_DIR}/rtl/handsome_rd.v \
        ${ROOT_DIR}/rtl/handsome_wr.v \
        ${ROOT_DIR}/rtl/oc8051_acc.v \
        ${ROOT_DIR}/rtl/oc8051_alu.v \
        ${ROOT_DIR}/rtl/oc8051_alu_src_sel.v \
        ${ROOT_DIR}/rtl/oc8051_b_register.v \
        ${ROOT_DIR}/rtl/oc8051_cache_ram.v \
        ${ROOT_DIR}/rtl/oc8051_comp.v \
        ${ROOT_DIR}/rtl/oc8051_cy_select.v \
        ${ROOT_DIR}/rtl/oc8051_decoder.v \
        ${ROOT_DIR}/rtl/oc8051_defines.v \
        ${ROOT_DIR}/rtl/oc8051_divide.v \
        ${ROOT_DIR}/rtl/oc8051_dptr.v \
        ${ROOT_DIR}/rtl/oc8051_icache.v \
        ${ROOT_DIR}/rtl/oc8051_indi_addr.v \
        ${ROOT_DIR}/rtl/oc8051_int.v \
        ${ROOT_DIR}/rtl/oc8051_memory_interface.v \
        ${ROOT_DIR}/rtl/oc8051_multiply.v \
        ${ROOT_DIR}/rtl/oc8051_ports.v \
        ${ROOT_DIR}/rtl/oc8051_psw.v \
        ${ROOT_DIR}/rtl/oc8051_ram_64x32_dual_bist.v \
        ${ROOT_DIR}/rtl/oc8051_ram_256x8_two_bist.v \
        ${ROOT_DIR}/rtl/oc8051_ram_top.v \
        ${ROOT_DIR}/rtl/oc8051_rom.v \
        ${ROOT_DIR}/rtl/oc8051_sfr.v \
        ${ROOT_DIR}/rtl/oc8051_sp.v \
        ${ROOT_DIR}/rtl/oc8051_tc.v \
        ${ROOT_DIR}/rtl/oc8051_tc2.v \
        ${ROOT_DIR}/rtl/oc8051_timescale.v \
        ${ROOT_DIR}/rtl/oc8051_top.v \
        ${ROOT_DIR}/rtl/oc8051_uart.v \
        ${ROOT_DIR}/rtl/oc8051_wb_iinterface.v \
        ${ROOT_DIR}/rtl/oc8051_wrapper.v 
 

set_top_module oc8051_wrapper

target_device 1GE100-ES1

add_constraint_file ${ROOT_DIR}/sdc/raptor_constraints.sdc

analyze
synthesize delay
packing
place
route
sta 
bitstream


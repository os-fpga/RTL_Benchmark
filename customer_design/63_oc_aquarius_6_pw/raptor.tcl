create_design 63_oc_aquarius_6_pw

add_include_path ${ROOT_DIR}/rtl/include 

add_design_file -V_2001 \
        ${ROOT_DIR}/rtl/aquarius_wrapper.v \
        ${ROOT_DIR}/rtl/cpu.v \
        ${ROOT_DIR}/rtl/datapath.v \
        ${ROOT_DIR}/rtl/decode.v \
        ${ROOT_DIR}/rtl/handsome_rd.v \
        ${ROOT_DIR}/rtl/handsome_wr.v \
        ${ROOT_DIR}/rtl/lib_fpga.v \
        ${ROOT_DIR}/rtl/mem.v \
        ${ROOT_DIR}/rtl/memory_rtl.v \
        ${ROOT_DIR}/rtl/mult.v \
        ${ROOT_DIR}/rtl/pio.v \
        ${ROOT_DIR}/rtl/register.v \
        ${ROOT_DIR}/rtl/rom.v \
        ${ROOT_DIR}/rtl/sasc_brg.v \
        ${ROOT_DIR}/rtl/sasc_fifo4.v \
        ${ROOT_DIR}/rtl/sasc_top.v \
        ${ROOT_DIR}/rtl/sys.v \
        ${ROOT_DIR}/rtl/top.v \
        ${ROOT_DIR}/rtl/uart.v \
        ${ROOT_DIR}/rtl/src/butterfly.v \
        ${ROOT_DIR}/rtl/src/sync_fifo.v \
        ${ROOT_DIR}/rtl/src/top.v \
        ${ROOT_DIR}/rtl/src/bist_check.v \
        ${ROOT_DIR}/rtl/src/bist_generate.v 

set_top_module aquarius_wrapper_pw

target_device 1GE124-L

add_constraint_file ${ROOT_DIR}/sdc/raptor_constraint.sdc

analyze
synthesize delay
pnr_options --alpha_clustering 0.5
packing
place
route
sta 
bitstream


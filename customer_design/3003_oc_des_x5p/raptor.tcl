create_design 3003_oc_des_x5p

add_design_file -V_2001 \
        ${ROOT_DIR}/rtl/btpincrack_fifo.v \
        ${ROOT_DIR}/rtl/crp.v \
        ${ROOT_DIR}/rtl/defines.v \
        ${ROOT_DIR}/rtl/des.v \
        ${ROOT_DIR}/rtl/des_wrapper.v \
        ${ROOT_DIR}/rtl/des3.v \
        ${ROOT_DIR}/rtl/handsome_rd.v \
        ${ROOT_DIR}/rtl/handsome_wr.v \
        ${ROOT_DIR}/rtl/key_sel.v \
        ${ROOT_DIR}/rtl/RAMB18_M2000.v \
        ${ROOT_DIR}/rtl/sbox1.v \
        ${ROOT_DIR}/rtl/sbox2.v \
        ${ROOT_DIR}/rtl/sbox3.v \
        ${ROOT_DIR}/rtl/sbox4.v \
        ${ROOT_DIR}/rtl/sbox5.v \
        ${ROOT_DIR}/rtl/sbox6.v \
        ${ROOT_DIR}/rtl/sbox7.v \
        ${ROOT_DIR}/rtl/sbox8.v \
        ${ROOT_DIR}/rtl/sr16_fifo_regfile54.v \
        ${ROOT_DIR}/rtl/sr16_fifo_regfile54_reg_mem.v \
        ${ROOT_DIR}/rtl/sr32_fifo_regfile54.v \
        ${ROOT_DIR}/rtl/sr32_fifo_regfile54_reg_mem.v 
 

set_top_module des_wrapper

target_device 1GE100-ES1

add_constraint_file ${ROOT_DIR}/sdc/constraints.sdc

analyze
synthesize delay
packing
place
route
sta 
bitstream


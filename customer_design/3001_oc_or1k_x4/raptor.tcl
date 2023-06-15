create_design 3001_oc_or1k_x4 
add_design_file -V_2001 \
        ${ROOT_DIR}/rtl/handsome_rd.v \
        ${ROOT_DIR}/rtl/handsome_wr.v \
        ${ROOT_DIR}/rtl/m2000_spram_1024x32_va.v \
        ${ROOT_DIR}/rtl/m2000_spram_2048x32_va.v \
        ${ROOT_DIR}/rtl/or1k_wrapper.v \
        ${ROOT_DIR}/rtl/or1200_alu.v \
        ${ROOT_DIR}/rtl/or1200_amultp2_32x32.v \
        ${ROOT_DIR}/rtl/or1200_cfgr.v \
        ${ROOT_DIR}/rtl/or1200_cpu.v \
        ${ROOT_DIR}/rtl/or1200_ctrl.v \
        ${ROOT_DIR}/rtl/or1200_dc_fsm.v \
        ${ROOT_DIR}/rtl/or1200_dc_ram.v \
        ${ROOT_DIR}/rtl/or1200_dc_tag.v \
        ${ROOT_DIR}/rtl/or1200_dc_top.v \
        ${ROOT_DIR}/rtl/or1200_defines.v \
        ${ROOT_DIR}/rtl/or1200_dmmu_tlb.v \
        ${ROOT_DIR}/rtl/or1200_dmmu_top.v \
        ${ROOT_DIR}/rtl/or1200_dpram_32x32.v \
        ${ROOT_DIR}/rtl/or1200_dpram_256x32.v \
        ${ROOT_DIR}/rtl/or1200_du.v \
        ${ROOT_DIR}/rtl/or1200_except.v \
        ${ROOT_DIR}/rtl/or1200_freeze.v \
        ${ROOT_DIR}/rtl/or1200_genpc.v \
        ${ROOT_DIR}/rtl/or1200_gmultp2_32x32.v \
        ${ROOT_DIR}/rtl/or1200_ic_fsm.v \
        ${ROOT_DIR}/rtl/or1200_ic_ram.v \
        ${ROOT_DIR}/rtl/or1200_ic_tag.v \
        ${ROOT_DIR}/rtl/or1200_ic_top.v \
        ${ROOT_DIR}/rtl/or1200_if.v \
        ${ROOT_DIR}/rtl/or1200_immu_tlb.v \
        ${ROOT_DIR}/rtl/or1200_immu_top.v \
        ${ROOT_DIR}/rtl/or1200_iwb_biu.v \
        ${ROOT_DIR}/rtl/or1200_lsu.v \
        ${ROOT_DIR}/rtl/or1200_mem2reg.v \
        ${ROOT_DIR}/rtl/or1200_mult_mac.v \
        ${ROOT_DIR}/rtl/or1200_operandmuxes.v \
        ${ROOT_DIR}/rtl/or1200_pic.v \
        ${ROOT_DIR}/rtl/or1200_pm.v \
        ${ROOT_DIR}/rtl/or1200_qmem_top.v \
        ${ROOT_DIR}/rtl/or1200_reg2mem.v \
        ${ROOT_DIR}/rtl/or1200_rf.v \
        ${ROOT_DIR}/rtl/or1200_rfram_generic.v \
        ${ROOT_DIR}/rtl/or1200_sb.v \
        ${ROOT_DIR}/rtl/or1200_sb_fifo.v \
        ${ROOT_DIR}/rtl/or1200_spram_32x24.v \
        ${ROOT_DIR}/rtl/or1200_spram_64x14.v \
        ${ROOT_DIR}/rtl/or1200_spram_64x22.v \
        ${ROOT_DIR}/rtl/or1200_spram_64x24.v \
        ${ROOT_DIR}/rtl/or1200_spram_128x32.v \
        ${ROOT_DIR}/rtl/or1200_spram_256x21.v \
        ${ROOT_DIR}/rtl/or1200_spram_512x20.v \
        ${ROOT_DIR}/rtl/or1200_spram_1024x8.v \
        ${ROOT_DIR}/rtl/or1200_spram_1024x32.v \
        ${ROOT_DIR}/rtl/or1200_spram_1024x32_bw.v \
        ${ROOT_DIR}/rtl/or1200_spram_2048x8.v \
        ${ROOT_DIR}/rtl/or1200_spram_2048x32.v \
        ${ROOT_DIR}/rtl/or1200_spram_2048x32_bw.v \
        ${ROOT_DIR}/rtl/or1200_sprs.v \
        ${ROOT_DIR}/rtl/or1200_top.v \
        ${ROOT_DIR}/rtl/or1200_tpram_32x32.v \
        ${ROOT_DIR}/rtl/or1200_tt.v \
        ${ROOT_DIR}/rtl/or1200_wb_biu.v \
        ${ROOT_DIR}/rtl/or1200_wbmux.v \
        ${ROOT_DIR}/rtl/or1200_xcv_ram32x8d.v 


set_top_module or1k_wrapper

target_device 1GE100-ES1

add_constraint_file ${ROOT_DIR}/sdc/raptor_constraints.sdc

analyze
synthesize delay
packing
place
route
sta 
bitstream


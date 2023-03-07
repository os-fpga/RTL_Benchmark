// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_core (
    scan_enable,
    d_araddr,
    d_arburst,
    d_arcache,
    d_arid,
    d_arlen,
    d_arlock,
    d_arprot,
    d_arready,
    d_arsize,
    d_arvalid,
    d_awaddr,
    d_awburst,
    d_awcache,
    d_awid,
    d_awlen,
    d_awlock,
    d_awprot,
    d_awready,
    d_awsize,
    d_awvalid,
    d_bid,
    d_bready,
    d_bresp,
    d_bvalid,
    d_rdata,
    d_rid,
    d_rlast,
    d_rready,
    d_rresp,
    d_rvalid,
    d_wdata,
    d_wlast,
    d_wready,
    d_wstrb,
    d_wvalid,
    i_araddr,
    i_arburst,
    i_arcache,
    i_arid,
    i_arlen,
    i_arlock,
    i_arprot,
    i_arready,
    i_arsize,
    i_arvalid,
    i_awaddr,
    i_awburst,
    i_awcache,
    i_awid,
    i_awlen,
    i_awlock,
    i_awprot,
    i_awready,
    i_awsize,
    i_awvalid,
    i_bid,
    i_bready,
    i_bresp,
    i_bvalid,
    i_rdata,
    i_rid,
    i_rlast,
    i_rready,
    i_rresp,
    i_rvalid,
    i_wdata,
    i_wlast,
    i_wready,
    i_wstrb,
    i_wvalid,
    gen1_trace_cause,
    gen1_trace_enabled,
    gen1_trace_iaddr,
    gen1_trace_iexception,
    gen1_trace_instr,
    gen1_trace_interrupt,
    gen1_trace_ivalid,
    gen1_trace_priv,
    gen1_trace_tval,
    trace_cause,
    trace_enabled,
    trace_halted,
    trace_iaddr,
    trace_ilastsize,
    trace_iretire,
    trace_itype,
    trace_priv,
    trace_reset,
    trace_stall,
    trace_trigger,
    trace_tval,
    ace_acr_dirty_set,
    csr_marchid,
    csr_mimpid,
    hart_id,
    resethaltreq,
    ace_error,
    dcache_tag0_we,
    dcache_tag1_we,
    dcache_tag2_we,
    dcache_tag3_we,
    dcache_wpt_addr,
    dcache_wpt_byte_we,
    dcache_wpt_cs,
    dcache_wpt_rdata,
    dcache_wpt_wdata,
    dcache_wpt_we,
    vpu_init_rf,
    ace_cmd_beat,
    ace_cmd_hartid,
    ace_cmd_inst,
    ace_cmd_pc,
    ace_cmd_priv,
    ace_cmd_ready,
    ace_cmd_rs1,
    ace_cmd_rs2,
    ace_cmd_rs3,
    ace_cmd_rs4,
    ace_cmd_valid,
    ace_cmd_vl,
    ace_cmd_vtype,
    ace_interrupt,
    ace_standby_ready,
    ace_sync_ack,
    ace_sync_ack_status,
    ace_sync_req,
    ace_sync_type,
    ace_xrf_rd1_data,
    ace_xrf_rd1_index,
    ace_xrf_rd1_ready,
    ace_xrf_rd1_status,
    ace_xrf_rd1_valid,
    ace_xrf_rd2_data,
    ace_xrf_rd2_index,
    ace_xrf_rd2_ready,
    ace_xrf_rd2_status,
    ace_xrf_rd2_valid,
    vpu_ack_status,
    vpu_ack_valid,
    vpu_cmt_i0_op1,
    vpu_cmt_i1_op1,
    vpu_cmt_kill,
    vpu_cmt_valid,
    vpu_req_i0_ctrl,
    vpu_req_i0_instr,
    vpu_req_i0_op1,
    vpu_req_i0_op2,
    vpu_req_i1_ctrl,
    vpu_req_i1_instr,
    vpu_req_i1_op1,
    vpu_req_i1_op2,
    vpu_req_ls_privilege,
    vpu_req_valid,
    vpu_req_vl,
    vpu_req_vstart,
    vpu_req_vtype,
    vpu_srf_waddr,
    vpu_srf_wdata,
    vpu_srf_wfrf,
    vpu_srf_wready,
    vpu_srf_wvalid,
    vpu_viq_size,
    vpu_vtlb_flush,
    stlb0_addr,
    stlb0_cs,
    stlb0_rdata,
    stlb0_wdata,
    stlb0_we,
    stlb1_addr,
    stlb1_cs,
    stlb1_rdata,
    stlb1_wdata,
    stlb1_we,
    stlb2_addr,
    stlb2_cs,
    stlb2_rdata,
    stlb2_wdata,
    stlb2_we,
    stlb3_addr,
    stlb3_cs,
    stlb3_rdata,
    stlb3_wdata,
    stlb3_we,
    stlb_data0_addr,
    stlb_data0_cs,
    stlb_data0_rdata,
    stlb_data0_wdata,
    stlb_data0_we,
    stlb_data1_addr,
    stlb_data1_cs,
    stlb_data1_rdata,
    stlb_data1_wdata,
    stlb_data1_we,
    stlb_data2_addr,
    stlb_data2_cs,
    stlb_data2_rdata,
    stlb_data2_wdata,
    stlb_data2_we,
    stlb_data3_addr,
    stlb_data3_cs,
    stlb_data3_rdata,
    stlb_data3_wdata,
    stlb_data3_we,
    stlb_tag0_addr,
    stlb_tag0_cs,
    stlb_tag0_rdata,
    stlb_tag0_wdata,
    stlb_tag0_we,
    stlb_tag1_addr,
    stlb_tag1_cs,
    stlb_tag1_rdata,
    stlb_tag1_wdata,
    stlb_tag1_we,
    stlb_tag2_addr,
    stlb_tag2_cs,
    stlb_tag2_rdata,
    stlb_tag2_wdata,
    stlb_tag2_we,
    stlb_tag3_addr,
    stlb_tag3_cs,
    stlb_tag3_rdata,
    stlb_tag3_wdata,
    stlb_tag3_we,
    vpu_pma_req_pa,
    vpu_pma_resp_fault,
    vpu_pma_resp_mtype,
    vpu_pmp_req_pa,
    vpu_pmp_resp_permission,
    core_coherent_enable,
    core_coherent_state,
    l2_clk,
    l2_reset_n,
    m0_a_address,
    m0_a_corrupt,
    m0_a_data,
    m0_a_mask,
    m0_a_opcode,
    m0_a_param,
    m0_a_ready,
    m0_a_size,
    m0_a_source,
    m0_a_user,
    m0_a_valid,
    m0_b_address,
    m0_b_corrupt,
    m0_b_data,
    m0_b_mask,
    m0_b_opcode,
    m0_b_param,
    m0_b_ready,
    m0_b_size,
    m0_b_source,
    m0_b_valid,
    m0_c_address,
    m0_c_corrupt,
    m0_c_data,
    m0_c_opcode,
    m0_c_param,
    m0_c_ready,
    m0_c_size,
    m0_c_source,
    m0_c_user,
    m0_c_valid,
    m0_d_corrupt,
    m0_d_data,
    m0_d_denied,
    m0_d_opcode,
    m0_d_param,
    m0_d_ready,
    m0_d_sink,
    m0_d_size,
    m0_d_source,
    m0_d_user,
    m0_d_valid,
    m0_e_ready,
    m0_e_sink,
    m0_e_valid,
    m1_a_address,
    m1_a_corrupt,
    m1_a_data,
    m1_a_mask,
    m1_a_opcode,
    m1_a_param,
    m1_a_ready,
    m1_a_size,
    m1_a_source,
    m1_a_user,
    m1_a_valid,
    m1_d_corrupt,
    m1_d_data,
    m1_d_denied,
    m1_d_opcode,
    m1_d_param,
    m1_d_ready,
    m1_d_sink,
    m1_d_size,
    m1_d_source,
    m1_d_user,
    m1_d_valid,
    m2_a_address,
    m2_a_corrupt,
    m2_a_data,
    m2_a_mask,
    m2_a_opcode,
    m2_a_param,
    m2_a_ready,
    m2_a_size,
    m2_a_source,
    m2_a_user,
    m2_a_valid,
    m2_d_corrupt,
    m2_d_data,
    m2_d_denied,
    m2_d_opcode,
    m2_d_param,
    m2_d_ready,
    m2_d_sink,
    m2_d_size,
    m2_d_source,
    m2_d_user,
    m2_d_valid,
    dlm1_user,
    dlm2_user,
    dlm3_user,
    dlm_a_addr,
    dlm_a_data,
    dlm_a_mask,
    dlm_a_opcode,
    dlm_a_parity,
    dlm_a_ready,
    dlm_a_size,
    dlm_a_user,
    dlm_a_valid,
    dlm_d_data,
    dlm_d_denied,
    dlm_d_parity,
    dlm_d_ready,
    dlm_d_valid,
    dlm_user,
    ilm0_user,
    ilm1_user,
    ilm_a_addr,
    ilm_a_data,
    ilm_a_mask,
    ilm_a_opcode,
    ilm_a_parity0,
    ilm_a_parity1,
    ilm_a_ready,
    ilm_a_size,
    ilm_a_user,
    ilm_a_valid,
    ilm_d_data,
    ilm_d_denied,
    ilm_d_parity0,
    ilm_d_parity1,
    ilm_d_ready,
    ilm_d_valid,
    lm_local_int,
    core_current_pc,
    core_gpr_index,
    core_selected_gpr_value,
    slv1_araddr,
    slv1_arburst,
    slv1_arcache,
    slv1_arid,
    slv1_arlen,
    slv1_arlock,
    slv1_arprot,
    slv1_arready,
    slv1_arsize,
    slv1_aruser,
    slv1_arvalid,
    slv1_awaddr,
    slv1_awburst,
    slv1_awcache,
    slv1_awid,
    slv1_awlen,
    slv1_awlock,
    slv1_awprot,
    slv1_awready,
    slv1_awsize,
    slv1_awuser,
    slv1_awvalid,
    slv1_bid,
    slv1_bready,
    slv1_bresp,
    slv1_bvalid,
    slv1_rdata,
    slv1_rid,
    slv1_rlast,
    slv1_rready,
    slv1_rresp,
    slv1_rvalid,
    slv1_wdata,
    slv1_wlast,
    slv1_wready,
    slv1_wstrb,
    slv1_wvalid,
    slv_araddr,
    slv_arburst,
    slv_arcache,
    slv_arid,
    slv_arlen,
    slv_arlock,
    slv_arprot,
    slv_arready,
    slv_arsize,
    slv_aruser,
    slv_arvalid,
    slv_awaddr,
    slv_awburst,
    slv_awcache,
    slv_awid,
    slv_awlen,
    slv_awlock,
    slv_awprot,
    slv_awready,
    slv_awsize,
    slv_awuser,
    slv_awvalid,
    slv_bid,
    slv_bready,
    slv_bresp,
    slv_bvalid,
    slv_rdata,
    slv_rid,
    slv_rlast,
    slv_rready,
    slv_rresp,
    slv_rvalid,
    slv_wdata,
    slv_wlast,
    slv_wready,
    slv_wstrb,
    slv_wvalid,
    core_clk,
    dcu_clk,
    core_reset_n,
    slv_reset_n,
    slv1_reset_n,
    lm_clk,
    lm_reset_n,
    bus_clk,
    bus_clk_en,
    slv_clk,
    slv_clk_en,
    slv1_clk,
    slv1_clk_en,
    test_mode,
    reset_vector,
    hart_unavail,
    hart_halted,
    hart_under_reset,
    stoptime,
    core_wfi_mode,
    meip,
    meiack,
    meiid,
    mtip,
    msip,
    debugint,
    nmi,
    seip,
    seiack,
    seiid,
    ueip,
    ueiack,
    ueiid,
    awid,
    awaddr,
    awlen,
    awsize,
    awburst,
    awlock,
    awcache,
    awprot,
    awvalid,
    awready,
    wdata,
    wstrb,
    wlast,
    wvalid,
    wready,
    bid,
    bresp,
    bvalid,
    bready,
    arid,
    araddr,
    arlen,
    arsize,
    arburst,
    arlock,
    arcache,
    arprot,
    arvalid,
    arready,
    rid,
    rdata,
    rresp,
    rlast,
    rvalid,
    rready,
    ilm0_addr,
    ilm0_byte_we,
    ilm0_cs,
    ilm0_we,
    ilm0_rdata,
    ilm0_wdata,
    ilm1_addr,
    ilm1_byte_we,
    ilm1_cs,
    ilm1_we,
    ilm1_rdata,
    ilm1_wdata,
    dlm_addr,
    dlm_byte_we,
    dlm_cs,
    dlm_we,
    dlm_rdata,
    dlm_wdata,
    dlm1_addr,
    dlm1_byte_we,
    dlm1_cs,
    dlm1_we,
    dlm1_rdata,
    dlm1_wdata,
    dlm2_addr,
    dlm2_byte_we,
    dlm2_cs,
    dlm2_we,
    dlm2_rdata,
    dlm2_wdata,
    dlm3_addr,
    dlm3_byte_we,
    dlm3_cs,
    dlm3_we,
    dlm3_rdata,
    dlm3_wdata,
    btb0_addr,
    btb0_cs,
    btb0_rdata,
    btb0_wdata,
    btb0_we,
    btb1_addr,
    btb1_cs,
    btb1_rdata,
    btb1_wdata,
    btb1_we,
    icache_disable_init,
    icache_data0_addr,
    icache_data0_cs,
    icache_data0_rdata,
    icache_data0_wdata,
    icache_data0_we,
    icache_data1_addr,
    icache_data1_cs,
    icache_data1_rdata,
    icache_data1_wdata,
    icache_data1_we,
    icache_data2_addr,
    icache_data2_cs,
    icache_data2_rdata,
    icache_data2_wdata,
    icache_data2_we,
    icache_data3_addr,
    icache_data3_cs,
    icache_data3_rdata,
    icache_data3_wdata,
    icache_data3_we,
    icache_data4_addr,
    icache_data4_cs,
    icache_data4_rdata,
    icache_data4_wdata,
    icache_data4_we,
    icache_data5_addr,
    icache_data5_cs,
    icache_data5_rdata,
    icache_data5_wdata,
    icache_data5_we,
    icache_data6_addr,
    icache_data6_cs,
    icache_data6_rdata,
    icache_data6_wdata,
    icache_data6_we,
    icache_data7_addr,
    icache_data7_cs,
    icache_data7_rdata,
    icache_data7_wdata,
    icache_data7_we,
    icache_tag0_addr,
    icache_tag0_cs,
    icache_tag0_rdata,
    icache_tag0_wdata,
    icache_tag0_we,
    icache_tag1_addr,
    icache_tag1_cs,
    icache_tag1_rdata,
    icache_tag1_wdata,
    icache_tag1_we,
    icache_tag2_addr,
    icache_tag2_cs,
    icache_tag2_rdata,
    icache_tag2_wdata,
    icache_tag2_we,
    icache_tag3_addr,
    icache_tag3_cs,
    icache_tag3_rdata,
    icache_tag3_wdata,
    icache_tag3_we,
    dcache_disable_init,
    dcache_data0_addr,
    dcache_data0_cs,
    dcache_data0_we,
    dcache_data0_byte_we,
    dcache_data0_rdata,
    dcache_data0_wdata,
    dcache_data1_addr,
    dcache_data1_cs,
    dcache_data1_we,
    dcache_data1_byte_we,
    dcache_data1_rdata,
    dcache_data1_wdata,
    dcache_data2_addr,
    dcache_data2_cs,
    dcache_data2_we,
    dcache_data2_byte_we,
    dcache_data2_rdata,
    dcache_data2_wdata,
    dcache_data3_addr,
    dcache_data3_cs,
    dcache_data3_we,
    dcache_data3_byte_we,
    dcache_data3_rdata,
    dcache_data3_wdata,
    dcache_tag0_addr,
    dcache_tag0_cs,
    dcache_tag0_rdata,
    dcache_tag0_wdata,
    dcache_tag1_addr,
    dcache_tag1_cs,
    dcache_tag1_rdata,
    dcache_tag1_wdata,
    dcache_tag2_addr,
    dcache_tag2_cs,
    dcache_tag2_rdata,
    dcache_tag2_wdata,
    dcache_tag3_addr,
    dcache_tag3_cs,
    dcache_tag3_rdata,
    dcache_tag3_wdata
);
parameter CPUID = 16'h0000;
parameter MIMPID = 32'h00000000;
parameter ISA_BASE_INT = 1;
parameter RVC_SUPPORT_INT = 1;
parameter RVN_SUPPORT_INT = 0;
parameter RVA_SUPPORT_INT = 0;
parameter RVB_SUPPORT_INT = 0;
parameter RVV_SUPPORT_INT = 0;
parameter ACE_SUPPORT_INT = 0;
parameter DSP_SUPPORT_INT = 0;
parameter ACE_LS_SUPPORT_INT = 0;
parameter ACE_GPR_2W_SUPPORT_INT = 0;
parameter ACE_GPR_3R_SUPPORT_INT = 0;
parameter SLAVE_PORT_SUPPORT_INT = 0;
parameter PC_GPR_PROBING_SUPPORT_INT = 0;
parameter VECTOR_PLIC_SUPPORT_INT = 0;
parameter SLAVE_PORT_DATA_WIDTH = 64;
parameter SLAVE_PORT_ID_WIDTH = 8;
parameter SLAVE_PORT_SOURCE_NUM = 1;
parameter SLAVE_PORT_ASYNC_SUPPORT = 0;
parameter LOCALINT_SLPECC = 16;
parameter LOCALINT_SBE = 17;
parameter LOCALINT_HPMINT = 18;
parameter LM_INTERFACE_INT = 0;
parameter LM_ENABLE_CTRL_INT = 0;
parameter ILM_SIZE_KB = 32;
parameter ILM_ECC_TYPE_INT = 0;
parameter DLM_SIZE_KB = 32;
parameter DLM_ECC_TYPE_INT = 0;
parameter CACHE_LINE_SIZE = 32;
parameter ICACHE_SIZE_KB = 0;
parameter ICACHE_LRU_INT = 0;
parameter ICACHE_WAY = 2;
parameter ICACHE_ECC_TYPE_INT = 0;
parameter ICACHE_FIRST_WORD_FIRST_INT = 1;
parameter DCACHE_SIZE_KB = 0;
parameter DCACHE_LRU_INT = 0;
parameter DCACHE_WAY = 2;
parameter DCACHE_ECC_TYPE_INT = 0;
parameter DCACHE_PREFETCH_SUPPORT_INT = 0;
parameter WRITE_AROUND_SUPPORT_INT = 0;
parameter MSHR_DEPTH = 3;
parameter CM_SUPPORT_INT = 0;
parameter WPT_SUPPORT = 1;
parameter CLUSTER_SUPPORT_INT = 0;
parameter L2C_CACHE_SIZE_KB = 0;
parameter L2C_REG_BASE = 64'd0;
parameter IOCP_NUM = 0;
parameter NCORE_CLUSTER = 1;
parameter VLEN = 512;
parameter LSU_PREFETCH_INT = 0;
parameter FENCE_FLUSH_DCACHE_INT = 0;
parameter POWERBRAKE_SUPPORT_INT = 0;
parameter STACKSAFE_SUPPORT_INT = 0;
parameter CODENSE_SUPPORT_INT = 1;
parameter UNALIGNED_ACCESS_INT = 0;
parameter FPU_TYPE_INT = 0;
parameter FP16_SUPPORT_INT = 0;
parameter BFLOAT16_SUPPORT_INT = 0;
parameter PUSHPOP_TYPE = 0;
parameter MMU_SCHEME_INT = 0;
parameter ITLB_ENTRIES = 4;
parameter DTLB_ENTRIES = 4;
parameter STLB_ENTRIES = 32;
parameter STLB_SP_ENTRIES = 4;
parameter STLB_ECC_TYPE = 0;
parameter PALEN = 32;
parameter PMP_ENTRIES = 0;
parameter PMP_GRANULARITY = 8;
parameter PMA_ENTRIES = 0;
parameter BIU_ASYNC_SUPPORT = 0;
parameter BIU_ADDR_WIDTH = 32;
parameter BIU_DATA_WIDTH = 64;
parameter BIU_PATH_X2_INT = 0;
parameter BIU_ID_WIDTH = 4;
parameter TL_SINK_WIDTH = 2;
parameter L2_SOURCE_WIDTH = 3;
parameter L2_ADDR_WIDTH = 32;
parameter L2_DATA_WIDTH = 128;
parameter CORE_BRG_ASYNC = 0;
parameter CORE_BRG_REG = 0;
parameter L2_CLK_SYNC_STAGE = 2;
parameter CORE_CLK_SYNC_STAGE = 2;
parameter NUM_PRIVILEGE_LEVELS = 1;
parameter NUM_DLM_BANKS = 1;
parameter BRANCH_PREDICTION_INT = 4;
parameter DEBUG_SUPPORT_INT = 1;
parameter NUM_TRIGGER = 2;
parameter TRACE_INTERFACE_INT = 0;
parameter PERFORMANCE_MONITOR_INT = 0;
parameter MULTIPLIER_INT = 1;
parameter ILM_BASE = 64'h1000_0000;
parameter DLM_BASE = 64'h2000_0000;
parameter DEBUG_VEC = 64'h0000_0000;
parameter DEVICE_REGION0_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION0_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION1_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION1_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION2_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION2_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION3_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION3_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION4_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION4_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION5_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION5_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION6_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION6_MASK = 64'h00000000_00000000;
parameter DEVICE_REGION7_BASE = 64'hffffffff_ffffffff;
parameter DEVICE_REGION7_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION0_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION0_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION1_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION1_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION2_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION2_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION3_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION3_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION4_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION4_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION5_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION5_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION6_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION6_MASK = 64'h00000000_00000000;
parameter WRITETHROUGH_REGION7_BASE = 64'hffffffff_ffffffff;
parameter WRITETHROUGH_REGION7_MASK = 64'h00000000_00000000;
parameter BTB_RAM_ADDR_WIDTH = 4;
parameter BTB_RAM_DATA_WIDTH = 42;
parameter STLB_RAM_AW = 1;
parameter STLB_RAM_DW = 1;
parameter STLB_TAG_RAM_DW = 1;
parameter STLB_DATA_RAM_DW = 1;
parameter ICACHE_TAG_RAM_AW = 1;
parameter ICACHE_TAG_RAM_DW = 1;
parameter ICACHE_DATA_RAM_AW = 1;
parameter ICACHE_DATA_RAM_DW = 1;
parameter DCACHE_TAG_RAM_AW = 1;
parameter DCACHE_TAG_RAM_DW = 1;
parameter DCACHE_DATA_RAM_AW = 1;
parameter DCACHE_DATA_RAM_DW = 1;
parameter DCACHE_DATA_RAM_BWEW = 1;
parameter DCACHE_WPT_RAM_AW = 11;
parameter DCACHE_WPT_RAM_DW = 16;
parameter DCACHE_WPT_RAM_BWEW = 2;
parameter DLM_RAM_AW = 9;
parameter DLM_RAM_DW = 1;
parameter DLM_RAM_BWEW = 1;
parameter DLM_WAIT_CYCLE = 0;
parameter ILM_RAM_AW = 1;
parameter ILM_RAM_DW = 1;
parameter ILM_RAM_BWEW = 1;
parameter ILM_WAIT_CYCLE = 1;
parameter ISA_GP_INT = 1;
parameter ISA_LEA_INT = 1;
parameter ISA_BEQC_INT = 1;
parameter ISA_BBZ_INT = 1;
parameter ISA_BFO_INT = 1;
parameter ISA_STR_INT = 1;
localparam TL_SIZE_WIDTH = 3;
localparam DCU_SOURCE_WIDTH = 3;
localparam VALEN = ((MMU_SCHEME_INT == 0)) ? PALEN : ((MMU_SCHEME_INT == 1)) ? 32 : ((MMU_SCHEME_INT == 2)) ? 39 : 48;
localparam ILM_DW = 32;
localparam ILM_BWEW = ILM_DW / 8;
localparam ILM_ECCW = ((ILM_ECC_TYPE_INT == 2) ? 7 : 4);
localparam DLM_DW = 32;
localparam DLM_BWEW = DLM_DW / 8;
localparam BTB_SIZE = 256;
localparam ILM_AMSB = ILM_RAM_AW + 2;
localparam DLM_AMSB = (DLM_DW == 64) ? (NUM_DLM_BANKS == 1) ? DLM_RAM_AW + 2 : (NUM_DLM_BANKS == 2) ? DLM_RAM_AW + 2 + 1 : DLM_RAM_AW + 2 + 2 : (NUM_DLM_BANKS == 1) ? DLM_RAM_AW + 1 : (NUM_DLM_BANKS == 2) ? DLM_RAM_AW + 1 + 1 : DLM_RAM_AW + 1 + 2;
localparam EXTVALEN = (((MMU_SCHEME_INT != 0)) && (32 > VALEN)) ? VALEN + 1 : VALEN;
localparam FLEN = ((FPU_TYPE_INT == 2)) ? 64 : ((FPU_TYPE_INT == 1)) ? 32 : 1;
localparam DSP_OCTRL_WIDTH = 44;
localparam DSP_FCTRL_WIDTH = 151;
localparam DSP_RCTRL_WIDTH = 70;
localparam DSP_2W_EN_INT = ((DSP_SUPPORT_INT == 1)) ? 1 : 0;
localparam DSP_3R_EN_INT = ((DSP_SUPPORT_INT == 1)) ? 1 : 0;
localparam DSP_4R_EN_INT = ((DSP_SUPPORT_INT == 1)) ? 1 : 0;
localparam HAS_VPU_INT = (((FPU_TYPE_INT != 0))) ? 1 : 0;
localparam CACHE_OFFSET_WIDTH = (CACHE_LINE_SIZE == 32) ? 5 : 4;
localparam OFFSET_WIDTH = (DCACHE_SIZE_KB == 0) ? 1 : ((CACHE_LINE_SIZE == 32) && (BIU_DATA_WIDTH == 32)) ? 3 : 2;
localparam ICACHE_WIDTH_1WAY = (ICACHE_SIZE_KB == 8) ? 13 : (ICACHE_SIZE_KB == 16) ? 14 : (ICACHE_SIZE_KB == 32) ? 15 : 16;
localparam ICACHE_WIDTH = (ICACHE_WAY == 1) ? ICACHE_WIDTH_1WAY : (ICACHE_WAY == 2) ? (ICACHE_WIDTH_1WAY - 1) : (ICACHE_WIDTH_1WAY - 2);
localparam ICACHE_INDEX_MSB = ICACHE_WIDTH - 1;
localparam ICACHE_NO_ECC_TAG_DW = (ICACHE_WIDTH >= 12) ? (PALEN + 3 - 12) : (PALEN + 3 - ICACHE_WIDTH);
localparam ICACHE_TAG_ECC_DW = (ICACHE_SIZE_KB == 0) ? 0 : ((ICACHE_ECC_TYPE_INT == 0)) ? 0 : (ICACHE_NO_ECC_TAG_DW > 32) ? 8 : ((ICACHE_ECC_TYPE_INT == 2)) ? 7 : 4;
localparam ICACHE_NO_ECC_DATA_DW = (ICACHE_SIZE_KB == 0) ? 1 : 32;
localparam ICACHE_DATA_ECC_DW = (ICACHE_SIZE_KB == 0) ? 0 : ((ICACHE_ECC_TYPE_INT == 0)) ? 0 : ((ICACHE_ECC_TYPE_INT == 2)) ? 7 : 4;
localparam STATIC_BRANCH_PREDICTION_INT = 0;
localparam CAUSE_LEN = 6;
localparam ITLB_V_BIT = 0;
localparam ITLB_X_BIT = ITLB_V_BIT + 1;
localparam ITLB_U_BIT = ITLB_X_BIT + 1;
localparam ITLB_G_BIT = ITLB_U_BIT + 1;
localparam ITLB_A_BIT = ITLB_G_BIT + 1;
localparam ITLB_PAGE_FAULT_BIT = ITLB_A_BIT + 1;
localparam ITLB_PTW_ACCESS_FAULT_BIT = ITLB_PAGE_FAULT_BIT + 1;
localparam ITLB_MDCAUSE_LSB = ITLB_PTW_ACCESS_FAULT_BIT + 1;
localparam ITLB_MDCAUSE_MSB = ITLB_MDCAUSE_LSB + 3 - 1;
localparam ITLB_ECC_CODE_LSB = ITLB_MDCAUSE_MSB + 1;
localparam ITLB_ECC_CODE_MSB = ITLB_ECC_CODE_LSB + 8 - 1;
localparam ITLB_ECC_CORR_BIT = ITLB_ECC_CODE_MSB + 1;
localparam ITLB_ECC_RAMID_LSB = ITLB_ECC_CORR_BIT + 1;
localparam ITLB_ECC_RAMID_MSB = ITLB_ECC_RAMID_LSB + 4 - 1;
localparam ITLB_PPN_LSB = ITLB_ECC_RAMID_MSB + 1;
localparam ITLB_PPN_MSB = ITLB_PPN_LSB + PALEN - 12 - 1;
localparam ITLB_MSB = ITLB_PPN_MSB;
localparam DTLB_V_BIT = 0;
localparam DTLB_X_BIT = DTLB_V_BIT + 1;
localparam DTLB_W_BIT = DTLB_X_BIT + 1;
localparam DTLB_R_BIT = DTLB_W_BIT + 1;
localparam DTLB_U_BIT = DTLB_R_BIT + 1;
localparam DTLB_G_BIT = DTLB_U_BIT + 1;
localparam DTLB_A_BIT = DTLB_G_BIT + 1;
localparam DTLB_D_BIT = DTLB_A_BIT + 1;
localparam DTLB_PAGE_FAULT_BIT = DTLB_D_BIT + 1;
localparam DTLB_PTW_ACCESS_FAULT_BIT = DTLB_PAGE_FAULT_BIT + 1;
localparam DTLB_MDCAUSE_LSB = DTLB_PTW_ACCESS_FAULT_BIT + 1;
localparam DTLB_MDCAUSE_MSB = DTLB_MDCAUSE_LSB + 3 - 1;
localparam DTLB_ECC_CODE_LSB = DTLB_MDCAUSE_MSB + 1;
localparam DTLB_ECC_CODE_MSB = DTLB_ECC_CODE_LSB + 8 - 1;
localparam DTLB_ECC_CORR_BIT = DTLB_ECC_CODE_MSB + 1;
localparam DTLB_ECC_RAMID_LSB = DTLB_ECC_CORR_BIT + 1;
localparam DTLB_ECC_RAMID_MSB = DTLB_ECC_RAMID_LSB + 4 - 1;
localparam DTLB_PPN_LSB = DTLB_ECC_RAMID_MSB + 1;
localparam DTLB_PPN_MSB = DTLB_PPN_LSB + PALEN - 12 - 1;
localparam DTLB_MSB = DTLB_PPN_MSB;
localparam ELEN = 32;
localparam SIMD_WIDTH = 512;
localparam SLEN = 512;
localparam SELEN = 8;
localparam VL_WIDTH = $unsigned($clog2(VLEN)) + 1;
localparam ASP_DATA_WIDTH = 256;
localparam ASP_BWE_WIDTH = ASP_DATA_WIDTH / 8;
localparam ASP_ADDR_WIDTH = $clog2(ASP_BWE_WIDTH);
localparam VLS_DATA_WIDTH = ASP_DATA_WIDTH;
localparam VD_PART_BITS = (VLEN >= VLS_DATA_WIDTH) ? $clog2(VLEN / VLS_DATA_WIDTH) : 0;
localparam VD_BITS = 5 + VD_PART_BITS;
localparam LS_DEST_BITS = (VD_BITS > 5) ? VD_BITS : 5;
localparam HAS_CORE_BRG = ((CLUSTER_SUPPORT_INT == 1)) ? 1 : 0;
input scan_enable;
output [(BIU_ADDR_WIDTH - 1):0] d_araddr;
output [1:0] d_arburst;
output [3:0] d_arcache;
output [(BIU_ID_WIDTH - 1):0] d_arid;
output [7:0] d_arlen;
output d_arlock;
output [2:0] d_arprot;
input d_arready;
output [2:0] d_arsize;
output d_arvalid;
output [(BIU_ADDR_WIDTH - 1):0] d_awaddr;
output [1:0] d_awburst;
output [3:0] d_awcache;
output [(BIU_ID_WIDTH - 1):0] d_awid;
output [7:0] d_awlen;
output d_awlock;
output [2:0] d_awprot;
input d_awready;
output [2:0] d_awsize;
output d_awvalid;
input [(BIU_ID_WIDTH - 1):0] d_bid;
output d_bready;
input [1:0] d_bresp;
input d_bvalid;
input [(BIU_DATA_WIDTH - 1):0] d_rdata;
input [(BIU_ID_WIDTH - 1):0] d_rid;
input d_rlast;
output d_rready;
input [1:0] d_rresp;
input d_rvalid;
output [(BIU_DATA_WIDTH - 1):0] d_wdata;
output d_wlast;
input d_wready;
output [(BIU_DATA_WIDTH / 8) - 1:0] d_wstrb;
output d_wvalid;
output [(BIU_ADDR_WIDTH - 1):0] i_araddr;
output [1:0] i_arburst;
output [3:0] i_arcache;
output [(BIU_ID_WIDTH - 1):0] i_arid;
output [7:0] i_arlen;
output i_arlock;
output [2:0] i_arprot;
input i_arready;
output [2:0] i_arsize;
output i_arvalid;
output [(BIU_ADDR_WIDTH - 1):0] i_awaddr;
output [1:0] i_awburst;
output [3:0] i_awcache;
output [(BIU_ID_WIDTH - 1):0] i_awid;
output [7:0] i_awlen;
output i_awlock;
output [2:0] i_awprot;
input i_awready;
output [2:0] i_awsize;
output i_awvalid;
input [(BIU_ID_WIDTH - 1):0] i_bid;
output i_bready;
input [1:0] i_bresp;
input i_bvalid;
input [(BIU_DATA_WIDTH - 1):0] i_rdata;
input [(BIU_ID_WIDTH - 1):0] i_rid;
input i_rlast;
output i_rready;
input [1:0] i_rresp;
input i_rvalid;
output [(BIU_DATA_WIDTH - 1):0] i_wdata;
output i_wlast;
input i_wready;
output [(BIU_DATA_WIDTH / 8) - 1:0] i_wstrb;
output i_wvalid;
output [19:0] gen1_trace_cause;
input gen1_trace_enabled;
output [(VALEN * 2) - 1:0] gen1_trace_iaddr;
output [1:0] gen1_trace_iexception;
output [63:0] gen1_trace_instr;
output [1:0] gen1_trace_interrupt;
output [1:0] gen1_trace_ivalid;
output [3:0] gen1_trace_priv;
output [63:0] gen1_trace_tval;
output [9:0] trace_cause;
input trace_enabled;
output trace_halted;
output [(VALEN * 2) - 1:0] trace_iaddr;
output [1:0] trace_ilastsize;
output [3:0] trace_iretire;
output [7:0] trace_itype;
output [1:0] trace_priv;
output trace_reset;
input trace_stall;
output [5:0] trace_trigger;
output [31:0] trace_tval;
input ace_acr_dirty_set;
input [31:0] csr_marchid;
input [31:0] csr_mimpid;
input [63:0] hart_id;
input resethaltreq;
input ace_error;
output dcache_tag0_we;
output dcache_tag1_we;
output dcache_tag2_we;
output dcache_tag3_we;
output [(DCACHE_WPT_RAM_AW - 1):0] dcache_wpt_addr;
output [(DCACHE_WPT_RAM_BWEW - 1):0] dcache_wpt_byte_we;
output dcache_wpt_cs;
input [(DCACHE_WPT_RAM_DW - 1):0] dcache_wpt_rdata;
output [(DCACHE_WPT_RAM_DW - 1):0] dcache_wpt_wdata;
output dcache_wpt_we;
output vpu_init_rf;
output [31:0] ace_cmd_beat;
output [31:0] ace_cmd_hartid;
output [31:7] ace_cmd_inst;
output [(VALEN - 1):0] ace_cmd_pc;
output [1:0] ace_cmd_priv;
input ace_cmd_ready;
output [31:0] ace_cmd_rs1;
output [31:0] ace_cmd_rs2;
output [31:0] ace_cmd_rs3;
output [31:0] ace_cmd_rs4;
output ace_cmd_valid;
output [31:0] ace_cmd_vl;
output [31:0] ace_cmd_vtype;
output ace_interrupt;
input ace_standby_ready;
input ace_sync_ack;
input ace_sync_ack_status;
output ace_sync_req;
output [31:0] ace_sync_type;
input [31:0] ace_xrf_rd1_data;
input [4:0] ace_xrf_rd1_index;
output ace_xrf_rd1_ready;
input ace_xrf_rd1_status;
input ace_xrf_rd1_valid;
input [31:0] ace_xrf_rd2_data;
input [4:0] ace_xrf_rd2_index;
output ace_xrf_rd2_ready;
input ace_xrf_rd2_status;
input ace_xrf_rd2_valid;
input [1:0] vpu_ack_status;
input vpu_ack_valid;
output [63:0] vpu_cmt_i0_op1;
output [63:0] vpu_cmt_i1_op1;
output vpu_cmt_kill;
output vpu_cmt_valid;
output [16:0] vpu_req_i0_ctrl;
output [31:0] vpu_req_i0_instr;
output [63:0] vpu_req_i0_op1;
output [63:0] vpu_req_i0_op2;
output [16:0] vpu_req_i1_ctrl;
output [31:0] vpu_req_i1_instr;
output [63:0] vpu_req_i1_op1;
output [63:0] vpu_req_i1_op2;
output [1:0] vpu_req_ls_privilege;
output [1:0] vpu_req_valid;
output [10:0] vpu_req_vl;
output [9:0] vpu_req_vstart;
output [8:0] vpu_req_vtype;
input [4:0] vpu_srf_waddr;
input [63:0] vpu_srf_wdata;
input vpu_srf_wfrf;
output vpu_srf_wready;
input vpu_srf_wvalid;
input [3:0] vpu_viq_size;
output vpu_vtlb_flush;
output [(STLB_RAM_AW - 1):0] stlb0_addr;
output stlb0_cs;
input [(STLB_RAM_DW - 1):0] stlb0_rdata;
output [(STLB_RAM_DW - 1):0] stlb0_wdata;
output stlb0_we;
output [(STLB_RAM_AW - 1):0] stlb1_addr;
output stlb1_cs;
input [(STLB_RAM_DW - 1):0] stlb1_rdata;
output [(STLB_RAM_DW - 1):0] stlb1_wdata;
output stlb1_we;
output [(STLB_RAM_AW - 1):0] stlb2_addr;
output stlb2_cs;
input [(STLB_RAM_DW - 1):0] stlb2_rdata;
output [(STLB_RAM_DW - 1):0] stlb2_wdata;
output stlb2_we;
output [(STLB_RAM_AW - 1):0] stlb3_addr;
output stlb3_cs;
input [(STLB_RAM_DW - 1):0] stlb3_rdata;
output [(STLB_RAM_DW - 1):0] stlb3_wdata;
output stlb3_we;
output [(STLB_RAM_AW - 1):0] stlb_data0_addr;
output stlb_data0_cs;
input [(STLB_DATA_RAM_DW - 1):0] stlb_data0_rdata;
output [(STLB_DATA_RAM_DW - 1):0] stlb_data0_wdata;
output stlb_data0_we;
output [(STLB_RAM_AW - 1):0] stlb_data1_addr;
output stlb_data1_cs;
input [(STLB_DATA_RAM_DW - 1):0] stlb_data1_rdata;
output [(STLB_DATA_RAM_DW - 1):0] stlb_data1_wdata;
output stlb_data1_we;
output [(STLB_RAM_AW - 1):0] stlb_data2_addr;
output stlb_data2_cs;
input [(STLB_DATA_RAM_DW - 1):0] stlb_data2_rdata;
output [(STLB_DATA_RAM_DW - 1):0] stlb_data2_wdata;
output stlb_data2_we;
output [(STLB_RAM_AW - 1):0] stlb_data3_addr;
output stlb_data3_cs;
input [(STLB_DATA_RAM_DW - 1):0] stlb_data3_rdata;
output [(STLB_DATA_RAM_DW - 1):0] stlb_data3_wdata;
output stlb_data3_we;
output [(STLB_RAM_AW - 1):0] stlb_tag0_addr;
output stlb_tag0_cs;
input [(STLB_TAG_RAM_DW - 1):0] stlb_tag0_rdata;
output [(STLB_TAG_RAM_DW - 1):0] stlb_tag0_wdata;
output stlb_tag0_we;
output [(STLB_RAM_AW - 1):0] stlb_tag1_addr;
output stlb_tag1_cs;
input [(STLB_TAG_RAM_DW - 1):0] stlb_tag1_rdata;
output [(STLB_TAG_RAM_DW - 1):0] stlb_tag1_wdata;
output stlb_tag1_we;
output [(STLB_RAM_AW - 1):0] stlb_tag2_addr;
output stlb_tag2_cs;
input [(STLB_TAG_RAM_DW - 1):0] stlb_tag2_rdata;
output [(STLB_TAG_RAM_DW - 1):0] stlb_tag2_wdata;
output stlb_tag2_we;
output [(STLB_RAM_AW - 1):0] stlb_tag3_addr;
output stlb_tag3_cs;
input [(STLB_TAG_RAM_DW - 1):0] stlb_tag3_rdata;
output [(STLB_TAG_RAM_DW - 1):0] stlb_tag3_wdata;
output stlb_tag3_we;
input [(PALEN - 1):0] vpu_pma_req_pa;
output vpu_pma_resp_fault;
output [3:0] vpu_pma_resp_mtype;
input [(PALEN - 1):0] vpu_pmp_req_pa;
output [3:0] vpu_pmp_resp_permission;
output core_coherent_enable;
input core_coherent_state;
input l2_clk;
input l2_reset_n;
output [(L2_ADDR_WIDTH - 1):0] m0_a_address;
output m0_a_corrupt;
output [(L2_DATA_WIDTH - 1):0] m0_a_data;
output [(L2_DATA_WIDTH / 8) - 1:0] m0_a_mask;
output [2:0] m0_a_opcode;
output [2:0] m0_a_param;
input m0_a_ready;
output [(TL_SIZE_WIDTH - 1):0] m0_a_size;
output [(L2_SOURCE_WIDTH - 1):0] m0_a_source;
output [11:0] m0_a_user;
output m0_a_valid;
input [(L2_ADDR_WIDTH - 1):0] m0_b_address;
input m0_b_corrupt;
input [(L2_DATA_WIDTH - 1):0] m0_b_data;
input [(L2_DATA_WIDTH / 8) - 1:0] m0_b_mask;
input [2:0] m0_b_opcode;
input [2:0] m0_b_param;
output m0_b_ready;
input [2:0] m0_b_size;
input [(L2_SOURCE_WIDTH - 1):0] m0_b_source;
input m0_b_valid;
output [(L2_ADDR_WIDTH - 1):0] m0_c_address;
output m0_c_corrupt;
output [(L2_DATA_WIDTH - 1):0] m0_c_data;
output [2:0] m0_c_opcode;
output [2:0] m0_c_param;
input m0_c_ready;
output [2:0] m0_c_size;
output [(L2_SOURCE_WIDTH - 1):0] m0_c_source;
output [7:0] m0_c_user;
output m0_c_valid;
input m0_d_corrupt;
input [(L2_DATA_WIDTH - 1):0] m0_d_data;
input m0_d_denied;
input [2:0] m0_d_opcode;
input [1:0] m0_d_param;
output m0_d_ready;
input [(TL_SINK_WIDTH - 1):0] m0_d_sink;
input [2:0] m0_d_size;
input [(L2_SOURCE_WIDTH - 1):0] m0_d_source;
input [5:0] m0_d_user;
input m0_d_valid;
input m0_e_ready;
output [(TL_SINK_WIDTH - 1):0] m0_e_sink;
output m0_e_valid;
output [(L2_ADDR_WIDTH - 1):0] m1_a_address;
output m1_a_corrupt;
output [(L2_DATA_WIDTH - 1):0] m1_a_data;
output [(L2_DATA_WIDTH / 8) - 1:0] m1_a_mask;
output [2:0] m1_a_opcode;
output [2:0] m1_a_param;
input m1_a_ready;
output [(TL_SIZE_WIDTH - 1):0] m1_a_size;
output [(L2_SOURCE_WIDTH - 1):0] m1_a_source;
output [11:0] m1_a_user;
output m1_a_valid;
input m1_d_corrupt;
input [(L2_DATA_WIDTH - 1):0] m1_d_data;
input m1_d_denied;
input [2:0] m1_d_opcode;
input [1:0] m1_d_param;
output m1_d_ready;
input [(TL_SINK_WIDTH - 1):0] m1_d_sink;
input [(TL_SIZE_WIDTH - 1):0] m1_d_size;
input [(L2_SOURCE_WIDTH - 1):0] m1_d_source;
input [5:0] m1_d_user;
input m1_d_valid;
output [(L2_ADDR_WIDTH - 1):0] m2_a_address;
output m2_a_corrupt;
output [(L2_DATA_WIDTH - 1):0] m2_a_data;
output [(L2_DATA_WIDTH / 8) - 1:0] m2_a_mask;
output [2:0] m2_a_opcode;
output [2:0] m2_a_param;
input m2_a_ready;
output [(TL_SIZE_WIDTH - 1):0] m2_a_size;
output [(L2_SOURCE_WIDTH - 1):0] m2_a_source;
output [11:0] m2_a_user;
output m2_a_valid;
input m2_d_corrupt;
input [(L2_DATA_WIDTH - 1):0] m2_d_data;
input m2_d_denied;
input [2:0] m2_d_opcode;
input [1:0] m2_d_param;
output m2_d_ready;
input [(TL_SINK_WIDTH - 1):0] m2_d_sink;
input [(TL_SIZE_WIDTH - 1):0] m2_d_size;
input [(L2_SOURCE_WIDTH - 1):0] m2_d_source;
input [5:0] m2_d_user;
input m2_d_valid;
output [1:0] dlm1_user;
output [1:0] dlm2_user;
output [1:0] dlm3_user;
output [DLM_RAM_AW + 2:3] dlm_a_addr;
output [31:0] dlm_a_data;
output [3:0] dlm_a_mask;
output [2:0] dlm_a_opcode;
output [7:0] dlm_a_parity;
input dlm_a_ready;
output [2:0] dlm_a_size;
output [1:0] dlm_a_user;
output dlm_a_valid;
input [31:0] dlm_d_data;
input dlm_d_denied;
input [7:0] dlm_d_parity;
output dlm_d_ready;
input dlm_d_valid;
output [1:0] dlm_user;
output [1:0] ilm0_user;
output [1:0] ilm1_user;
output [(ILM_RAM_AW + 2):3] ilm_a_addr;
output [63:0] ilm_a_data;
output [7:0] ilm_a_mask;
output [2:0] ilm_a_opcode;
output [7:0] ilm_a_parity0;
output [7:0] ilm_a_parity1;
input ilm_a_ready;
output [2:0] ilm_a_size;
output [1:0] ilm_a_user;
output ilm_a_valid;
input [63:0] ilm_d_data;
input ilm_d_denied;
input [7:0] ilm_d_parity0;
input [7:0] ilm_d_parity1;
output ilm_d_ready;
input ilm_d_valid;
output lm_local_int;
output [(VALEN - 1):0] core_current_pc;
input [12:0] core_gpr_index;
output [31:0] core_selected_gpr_value;
input [(BIU_ADDR_WIDTH - 1):0] slv1_araddr;
input [1:0] slv1_arburst;
input [3:0] slv1_arcache;
input [(SLAVE_PORT_ID_WIDTH - 1):0] slv1_arid;
input [7:0] slv1_arlen;
input slv1_arlock;
input [2:0] slv1_arprot;
output slv1_arready;
input [2:0] slv1_arsize;
input slv1_aruser;
input slv1_arvalid;
input [(BIU_ADDR_WIDTH - 1):0] slv1_awaddr;
input [1:0] slv1_awburst;
input [3:0] slv1_awcache;
input [(SLAVE_PORT_ID_WIDTH - 1):0] slv1_awid;
input [7:0] slv1_awlen;
input slv1_awlock;
input [2:0] slv1_awprot;
output slv1_awready;
input [2:0] slv1_awsize;
input slv1_awuser;
input slv1_awvalid;
output [(SLAVE_PORT_ID_WIDTH - 1):0] slv1_bid;
input slv1_bready;
output [1:0] slv1_bresp;
output slv1_bvalid;
output [(SLAVE_PORT_DATA_WIDTH - 1):0] slv1_rdata;
output [(SLAVE_PORT_ID_WIDTH - 1):0] slv1_rid;
output slv1_rlast;
input slv1_rready;
output [1:0] slv1_rresp;
output slv1_rvalid;
input [(SLAVE_PORT_DATA_WIDTH - 1):0] slv1_wdata;
input slv1_wlast;
output slv1_wready;
input [((SLAVE_PORT_DATA_WIDTH / 8) - 1):0] slv1_wstrb;
input slv1_wvalid;
input [(BIU_ADDR_WIDTH - 1):0] slv_araddr;
input [1:0] slv_arburst;
input [3:0] slv_arcache;
input [(SLAVE_PORT_ID_WIDTH - 1):0] slv_arid;
input [7:0] slv_arlen;
input slv_arlock;
input [2:0] slv_arprot;
output slv_arready;
input [2:0] slv_arsize;
input slv_aruser;
input slv_arvalid;
input [(BIU_ADDR_WIDTH - 1):0] slv_awaddr;
input [1:0] slv_awburst;
input [3:0] slv_awcache;
input [(SLAVE_PORT_ID_WIDTH - 1):0] slv_awid;
input [7:0] slv_awlen;
input slv_awlock;
input [2:0] slv_awprot;
output slv_awready;
input [2:0] slv_awsize;
input slv_awuser;
input slv_awvalid;
output [(SLAVE_PORT_ID_WIDTH - 1):0] slv_bid;
input slv_bready;
output [1:0] slv_bresp;
output slv_bvalid;
output [(SLAVE_PORT_DATA_WIDTH - 1):0] slv_rdata;
output [(SLAVE_PORT_ID_WIDTH - 1):0] slv_rid;
output slv_rlast;
input slv_rready;
output [1:0] slv_rresp;
output slv_rvalid;
input [(SLAVE_PORT_DATA_WIDTH - 1):0] slv_wdata;
input slv_wlast;
output slv_wready;
input [((SLAVE_PORT_DATA_WIDTH / 8) - 1):0] slv_wstrb;
input slv_wvalid;
input core_clk;
input dcu_clk;
input core_reset_n;
input slv_reset_n;
input slv1_reset_n;
input lm_clk;
output lm_reset_n;
input bus_clk;
input bus_clk_en;
input slv_clk;
input slv_clk_en;
input slv1_clk;
input slv1_clk_en;
input test_mode;
input [(VALEN - 1):0] reset_vector;
output hart_unavail;
output hart_halted;
output hart_under_reset;
output stoptime;
output core_wfi_mode;
input meip;
output meiack;
input [9:0] meiid;
input mtip;
input msip;
input debugint;
input nmi;
input seip;
output seiack;
input [9:0] seiid;
input ueip;
output ueiack;
input [9:0] ueiid;
output [(BIU_ID_WIDTH - 1):0] awid;
output [(BIU_ADDR_WIDTH - 1):0] awaddr;
output [7:0] awlen;
output [2:0] awsize;
output [1:0] awburst;
output awlock;
output [3:0] awcache;
output [2:0] awprot;
output awvalid;
input awready;
output [(BIU_DATA_WIDTH - 1):0] wdata;
output [(BIU_DATA_WIDTH / 8) - 1:0] wstrb;
output wlast;
output wvalid;
input wready;
input [(BIU_ID_WIDTH - 1):0] bid;
input [1:0] bresp;
input bvalid;
output bready;
output [(BIU_ID_WIDTH - 1):0] arid;
output [(BIU_ADDR_WIDTH - 1):0] araddr;
output [7:0] arlen;
output [2:0] arsize;
output [1:0] arburst;
output arlock;
output [3:0] arcache;
output [2:0] arprot;
output arvalid;
input arready;
input [(BIU_ID_WIDTH - 1):0] rid;
input [(BIU_DATA_WIDTH - 1):0] rdata;
input [1:0] rresp;
input rlast;
input rvalid;
output rready;
output [(ILM_RAM_AW - 1):0] ilm0_addr;
output [(ILM_RAM_BWEW - 1):0] ilm0_byte_we;
output ilm0_cs;
output ilm0_we;
input [(ILM_RAM_DW - 1):0] ilm0_rdata;
output [(ILM_RAM_DW - 1):0] ilm0_wdata;
output [(ILM_RAM_AW - 1):0] ilm1_addr;
output [(ILM_RAM_BWEW - 1):0] ilm1_byte_we;
output ilm1_cs;
output ilm1_we;
input [(ILM_RAM_DW - 1):0] ilm1_rdata;
output [(ILM_RAM_DW - 1):0] ilm1_wdata;
output [(DLM_RAM_AW - 1):0] dlm_addr;
output [(DLM_RAM_BWEW - 1):0] dlm_byte_we;
output dlm_cs;
output dlm_we;
input [(DLM_RAM_DW - 1):0] dlm_rdata;
output [(DLM_RAM_DW - 1):0] dlm_wdata;
output [(DLM_RAM_AW - 1):0] dlm1_addr;
output [(DLM_RAM_BWEW - 1):0] dlm1_byte_we;
output dlm1_cs;
output dlm1_we;
input [(DLM_RAM_DW - 1):0] dlm1_rdata;
output [(DLM_RAM_DW - 1):0] dlm1_wdata;
output [(DLM_RAM_AW - 1):0] dlm2_addr;
output [(DLM_RAM_BWEW - 1):0] dlm2_byte_we;
output dlm2_cs;
output dlm2_we;
input [(DLM_RAM_DW - 1):0] dlm2_rdata;
output [(DLM_RAM_DW - 1):0] dlm2_wdata;
output [(DLM_RAM_AW - 1):0] dlm3_addr;
output [(DLM_RAM_BWEW - 1):0] dlm3_byte_we;
output dlm3_cs;
output dlm3_we;
input [(DLM_RAM_DW - 1):0] dlm3_rdata;
output [(DLM_RAM_DW - 1):0] dlm3_wdata;
output [(BTB_RAM_ADDR_WIDTH - 1):0] btb0_addr;
output btb0_cs;
input [(BTB_RAM_DATA_WIDTH - 1):0] btb0_rdata;
output [(BTB_RAM_DATA_WIDTH - 1):0] btb0_wdata;
output btb0_we;
output [(BTB_RAM_ADDR_WIDTH - 1):0] btb1_addr;
output btb1_cs;
input [(BTB_RAM_DATA_WIDTH - 1):0] btb1_rdata;
output [(BTB_RAM_DATA_WIDTH - 1):0] btb1_wdata;
output btb1_we;
input icache_disable_init;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data0_addr;
output icache_data0_cs;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data0_rdata;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data0_wdata;
output icache_data0_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data1_addr;
output icache_data1_cs;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data1_rdata;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data1_wdata;
output icache_data1_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data2_addr;
output icache_data2_cs;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data2_rdata;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data2_wdata;
output icache_data2_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data3_addr;
output icache_data3_cs;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data3_rdata;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data3_wdata;
output icache_data3_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data4_addr;
output icache_data4_cs;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data4_rdata;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data4_wdata;
output icache_data4_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data5_addr;
output icache_data5_cs;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data5_rdata;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data5_wdata;
output icache_data5_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data6_addr;
output icache_data6_cs;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data6_rdata;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data6_wdata;
output icache_data6_we;
output [(ICACHE_DATA_RAM_AW - 1):0] icache_data7_addr;
output icache_data7_cs;
input [(ICACHE_DATA_RAM_DW - 1):0] icache_data7_rdata;
output [(ICACHE_DATA_RAM_DW - 1):0] icache_data7_wdata;
output icache_data7_we;
output [(ICACHE_TAG_RAM_AW - 1):0] icache_tag0_addr;
output icache_tag0_cs;
input [(ICACHE_TAG_RAM_DW - 1):0] icache_tag0_rdata;
output [(ICACHE_TAG_RAM_DW - 1):0] icache_tag0_wdata;
output icache_tag0_we;
output [(ICACHE_TAG_RAM_AW - 1):0] icache_tag1_addr;
output icache_tag1_cs;
input [(ICACHE_TAG_RAM_DW - 1):0] icache_tag1_rdata;
output [(ICACHE_TAG_RAM_DW - 1):0] icache_tag1_wdata;
output icache_tag1_we;
output [(ICACHE_TAG_RAM_AW - 1):0] icache_tag2_addr;
output icache_tag2_cs;
input [(ICACHE_TAG_RAM_DW - 1):0] icache_tag2_rdata;
output [(ICACHE_TAG_RAM_DW - 1):0] icache_tag2_wdata;
output icache_tag2_we;
output [(ICACHE_TAG_RAM_AW - 1):0] icache_tag3_addr;
output icache_tag3_cs;
input [(ICACHE_TAG_RAM_DW - 1):0] icache_tag3_rdata;
output [(ICACHE_TAG_RAM_DW - 1):0] icache_tag3_wdata;
output icache_tag3_we;
input dcache_disable_init;
output [(DCACHE_DATA_RAM_AW - 1):0] dcache_data0_addr;
output dcache_data0_cs;
output dcache_data0_we;
output [(DCACHE_DATA_RAM_BWEW - 1):0] dcache_data0_byte_we;
input [(DCACHE_DATA_RAM_DW - 1):0] dcache_data0_rdata;
output [(DCACHE_DATA_RAM_DW - 1):0] dcache_data0_wdata;
output [(DCACHE_DATA_RAM_AW - 1):0] dcache_data1_addr;
output dcache_data1_cs;
output dcache_data1_we;
output [(DCACHE_DATA_RAM_BWEW - 1):0] dcache_data1_byte_we;
input [(DCACHE_DATA_RAM_DW - 1):0] dcache_data1_rdata;
output [(DCACHE_DATA_RAM_DW - 1):0] dcache_data1_wdata;
output [(DCACHE_DATA_RAM_AW - 1):0] dcache_data2_addr;
output dcache_data2_cs;
output dcache_data2_we;
output [(DCACHE_DATA_RAM_BWEW - 1):0] dcache_data2_byte_we;
input [(DCACHE_DATA_RAM_DW - 1):0] dcache_data2_rdata;
output [(DCACHE_DATA_RAM_DW - 1):0] dcache_data2_wdata;
output [(DCACHE_DATA_RAM_AW - 1):0] dcache_data3_addr;
output dcache_data3_cs;
output dcache_data3_we;
output [(DCACHE_DATA_RAM_BWEW - 1):0] dcache_data3_byte_we;
input [(DCACHE_DATA_RAM_DW - 1):0] dcache_data3_rdata;
output [(DCACHE_DATA_RAM_DW - 1):0] dcache_data3_wdata;
output [(DCACHE_TAG_RAM_AW - 1):0] dcache_tag0_addr;
output dcache_tag0_cs;
input [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag0_rdata;
output [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag0_wdata;
output [(DCACHE_TAG_RAM_AW - 1):0] dcache_tag1_addr;
output dcache_tag1_cs;
input [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag1_rdata;
output [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag1_wdata;
output [(DCACHE_TAG_RAM_AW - 1):0] dcache_tag2_addr;
output dcache_tag2_cs;
input [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag2_rdata;
output [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag2_wdata;
output [(DCACHE_TAG_RAM_AW - 1):0] dcache_tag3_addr;
output dcache_tag3_cs;
input [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag3_rdata;
output [(DCACHE_TAG_RAM_DW - 1):0] dcache_tag3_wdata;


wire biu_ipipe_standby_ready;
wire lm_clk_en;
wire lm_reset_done;
wire dcu_a_ready;
wire dcu_c_ready;
wire dcu_d_corrupt;
wire [(L2_DATA_WIDTH - 1):0] dcu_d_data;
wire dcu_d_denied;
wire [2:0] dcu_d_opcode;
wire [1:0] dcu_d_param;
wire [(TL_SINK_WIDTH - 1):0] dcu_d_sink;
wire [2:0] dcu_d_size;
wire [2:0] dcu_d_source;
wire [5:0] dcu_d_user;
wire dcu_d_valid;
wire dcu_e_ready;
wire icu_a_ready;
wire icu_d_corrupt;
wire [(L2_DATA_WIDTH - 1):0] icu_d_data;
wire icu_d_denied;
wire [2:0] icu_d_opcode;
wire [1:0] icu_d_param;
wire [(TL_SINK_WIDTH - 1):0] icu_d_sink;
wire [2:0] icu_d_size;
wire [1:0] icu_d_source;
wire [1:0] icu_d_user;
wire icu_d_valid;
wire lsu_a_ready;
wire lsu_d_corrupt;
wire [(L2_DATA_WIDTH - 1):0] lsu_d_data;
wire lsu_d_denied;
wire [2:0] lsu_d_opcode;
wire [1:0] lsu_d_param;
wire [(TL_SINK_WIDTH - 1):0] lsu_d_sink;
wire [2:0] lsu_d_size;
wire lsu_d_source;
wire [1:0] lsu_d_user;
wire lsu_d_valid;
wire [(VALEN - 1):0] bpu_info_fall_thru_pc;
wire bpu_info_hit;
wire [9:0] bpu_info_offset;
wire [3:0] bpu_info_pred_cnt;
wire bpu_info_pred_taken;
wire bpu_info_ret;
wire [(VALEN - 1):0] bpu_info_start_pc;
wire [(VALEN - 1):0] bpu_info_target;
wire bpu_info_ucond;
wire [1:0] bpu_info_way;
wire bpu_rd_ack;
wire bpu_rd_ready;
wire btb_flush_ready;
wire btb_init_done;
wire [4:0] etrigger_fire;
wire ii_i0_trace_stall;
wire [9:0] ipipe_csr_cause_code;
wire [2:0] ipipe_csr_cause_detail;
wire [1:0] ipipe_csr_cause_detail_pm;
wire ipipe_csr_cause_detail_we;
wire ipipe_csr_cause_interrupt;
wire ipipe_csr_cause_we;
wire [7:0] ipipe_csr_ecc_code;
wire ipipe_csr_ecc_code_en;
wire ipipe_csr_ecc_corr;
wire ipipe_csr_ecc_fetch;
wire ipipe_csr_ecc_insn;
wire ipipe_csr_ecc_precise;
wire [3:0] ipipe_csr_ecc_ramid;
wire ipipe_csr_ecc_trap;
wire [31:0] ipipe_csr_epc_wdata;
wire ipipe_csr_epc_we;
wire [2:0] ipipe_csr_halt_cause;
wire [15:0] ipipe_csr_halt_ddcause;
wire ipipe_csr_halt_return;
wire ipipe_csr_halt_taken;
wire [1:0] ipipe_csr_inst_retire;
wire ipipe_csr_m_trap_return;
wire ipipe_csr_nmi_taken;
wire [1:0] ipipe_csr_pfm_inst_retire;
wire ipipe_csr_s_trap_return;
wire ipipe_csr_trap_taken;
wire [31:0] ipipe_csr_tval_wdata;
wire ipipe_csr_tval_we;
wire ipipe_csr_u_trap_return;
wire [2:0] nds_unused_resume_ras_ptr;
wire [(EXTVALEN - 1):0] resume_pc;
wire resume_vectored;
wire trap_handled_by_s_mode;
wire trap_handled_by_u_mode;
wire trigm_icount_clr;
wire trigm_icount_valid;
wire [16:0] trigm_xcpt_onehot;
wire [40:0] wb_i0_instr_event;
wire [40:0] wb_i1_instr_event;
wire core_coherent_enable_int;
wire [1:0] csr_cur_privilege;
wire csr_dcsr_debugint;
wire csr_dcsr_ebreakm;
wire csr_dcsr_ebreaks;
wire csr_dcsr_ebreaku;
wire csr_dcsr_mprven;
wire csr_dcsr_step;
wire csr_dcsr_stepie;
wire csr_dexc2dbg_ace;
wire csr_dexc2dbg_hec;
wire csr_dexc2dbg_hsp;
wire csr_dexc2dbg_iaf;
wire csr_dexc2dbg_iam;
wire csr_dexc2dbg_ii;
wire csr_dexc2dbg_ipf;
wire csr_dexc2dbg_laf;
wire csr_dexc2dbg_lam;
wire csr_dexc2dbg_lpf;
wire csr_dexc2dbg_mec;
wire csr_dexc2dbg_nmi;
wire csr_dexc2dbg_pmov;
wire csr_dexc2dbg_saf;
wire csr_dexc2dbg_sam;
wire csr_dexc2dbg_sbe;
wire csr_dexc2dbg_sec;
wire csr_dexc2dbg_slpecc;
wire csr_dexc2dbg_spf;
wire csr_dexc2dbg_uec;
wire [31:0] csr_dpc;
wire [31:0] csr_frm;
wire csr_halt_mode;
wire [31:0] csr_ipipe_resp_rdata;
wire [31:0] csr_ipipe_rmw_rdata;
wire [31:0] csr_ipipe_slie;
wire [31:0] csr_ipipe_slip;
wire csr_ls_translate_en;
wire csr_mcache_ctl_cctl_suen;
wire [1:0] csr_mcache_ctl_dc_eccen;
wire csr_mcache_ctl_dc_en;
wire csr_mcache_ctl_dc_rwecc;
wire [1:0] csr_mcache_ctl_dc_waround;
wire csr_mcache_ctl_dprefetch_en;
wire [1:0] csr_mcache_ctl_ic_eccen;
wire csr_mcache_ctl_ic_en;
wire csr_mcache_ctl_ic_rwecc;
wire csr_mcache_ctl_iprefetch_en;
wire [1:0] csr_mcache_ctl_tlb_eccen;
wire csr_mcache_ctl_tlb_rwecc;
wire [31:0] csr_mcctlbeginaddr;
wire csr_mcontext_we;
wire [31:0] csr_mcounteren;
wire [31:0] csr_mcounterwen;
wire csr_mdlmb_den;
wire [1:0] csr_mdlmb_eccen;
wire csr_mdlmb_rwecc;
wire [31:0] csr_mecc_code;
wire [31:0] csr_medeleg;
wire [9:0] csr_meiid;
wire [31:0] csr_mepc;
wire [31:0] csr_mhsp_base;
wire [31:0] csr_mhsp_bound;
wire csr_mhsp_ctl_m;
wire csr_mhsp_ctl_ovf_en;
wire csr_mhsp_ctl_s;
wire csr_mhsp_ctl_schm;
wire csr_mhsp_ctl_u;
wire csr_mhsp_ctl_udf_en;
wire [31:0] csr_mideleg;
wire [31:0] csr_mie;
wire [1:0] csr_milmb_eccen;
wire csr_milmb_ien;
wire csr_milmb_rwecc;
wire [31:0] csr_mip;
wire [1:0] csr_mmisc_ctl_aces;
wire csr_mmisc_ctl_brpe;
wire csr_mmisc_ctl_nbcache_en;
wire csr_mmisc_ctl_rvcompm;
wire csr_mmisc_ctl_una;
wire csr_mmisc_ctl_vec_plic;
wire csr_mmu_satp_we;
wire [31:0] csr_mslideleg;
wire [1:0] csr_mstatus_fs;
wire csr_mstatus_mie;
wire [1:0] csr_mstatus_mpp;
wire csr_mstatus_mprv;
wire csr_mstatus_mxr;
wire csr_mstatus_sie;
wire csr_mstatus_sum;
wire csr_mstatus_tsr;
wire csr_mstatus_tvm;
wire csr_mstatus_tw;
wire csr_mstatus_uie;
wire [31:0] csr_mtvec;
wire csr_mxstatus_dme;
wire csr_mxstatus_ime;
wire csr_pft_en;
wire [11:0] csr_pma_raddr0;
wire [11:0] csr_pma_raddr1;
wire [11:0] csr_pma_waddr;
wire [31:0] csr_pma_wdata;
wire csr_pma_we;
wire [11:0] csr_pmp_raddr0;
wire [11:0] csr_pmp_raddr1;
wire [11:0] csr_pmp_waddr;
wire [31:0] csr_pmp_wdata;
wire csr_pmp_we;
wire [31:0] csr_prob_rdata;
wire csr_resethaltreq;
wire [8:0] csr_satp_asid;
wire [3:0] csr_satp_mode;
wire [(PALEN - 1):12] csr_satp_ppn;
wire csr_scontext_we;
wire [31:0] csr_scounteren;
wire [31:0] csr_sedeleg;
wire [9:0] csr_seiid;
wire [31:0] csr_sepc;
wire [31:0] csr_sideleg;
wire [31:0] csr_stvec;
wire [3:0] csr_t_level;
wire csr_tcontrol_mte;
wire csr_tdata1_we;
wire csr_tdata2_we;
wire csr_tdata3_we;
wire csr_trap_delegated;
wire csr_tselect_we;
wire [9:0] csr_ueiid;
wire [31:0] csr_uepc;
wire [31:0] csr_uitb;
wire [31:0] csr_utvec;
wire [31:0] csr_vl;
wire [31:0] csr_vstart;
wire [31:0] csr_vtype;
wire [31:0] csr_wdata;
wire cur_privilege_m;
wire cur_privilege_s;
wire cur_privilege_u;
wire [2:0] int_ecc_cause_detail;
wire int_ecc_corr;
wire int_ecc_insn;
wire [3:0] int_ecc_ramid;
wire itlb_translate_en;
wire ls_privilege_m;
wire ls_privilege_s;
wire ls_privilege_u;
wire lsu_prefetch_clr;
wire lsu_reserve_clr;
wire [(L2_ADDR_WIDTH - 1):0] dcu_a_address;
wire dcu_a_corrupt;
wire [(L2_DATA_WIDTH - 1):0] dcu_a_data;
wire [L2_DATA_WIDTH / 8 - 1:0] dcu_a_mask;
wire [2:0] dcu_a_opcode;
wire [2:0] dcu_a_param;
wire [2:0] dcu_a_size;
wire [2:0] dcu_a_source;
wire [11:0] dcu_a_user;
wire dcu_a_valid;
wire dcu_acctl_ecc_corr;
wire dcu_acctl_ecc_error;
wire [0:0] dcu_ack_id;
wire [31:0] dcu_ack_rdata;
wire [18:0] dcu_ack_status;
wire dcu_ack_valid;
wire dcu_async_ecc_corr;
wire dcu_async_ecc_error;
wire [3:0] dcu_async_ecc_ramid;
wire dcu_async_write_error;
wire dcu_b_ready;
wire [(L2_ADDR_WIDTH - 1):0] dcu_c_address;
wire dcu_c_corrupt;
wire [(L2_DATA_WIDTH - 1):0] dcu_c_data;
wire [2:0] dcu_c_opcode;
wire [2:0] dcu_c_param;
wire [2:0] dcu_c_size;
wire [2:0] dcu_c_source;
wire [7:0] dcu_c_user;
wire dcu_c_valid;
wire [0:0] dcu_cri_id;
wire [31:0] dcu_cri_nbload_result;
wire [31:0] dcu_cri_rdata;
wire [8:0] dcu_cri_status;
wire dcu_cri_valid;
wire dcu_d_ready;
wire [(TL_SINK_WIDTH - 1):0] dcu_e_sink;
wire dcu_e_valid;
wire [6:0] dcu_event;
wire dcu_ix_ack;
wire [31:0] dcu_ix_raddr;
wire [31:0] dcu_ix_rdata;
wire [11:0] dcu_ix_status;
wire dcu_req_ready;
wire dcu_standby_ready;
wire dcu_wna_pending;
wire [15:0] mshr_event;
wire dsp_stage1_ovf_set;
wire [63:0] dsp_stage1_result;
wire dsp_stage2_ovf_set;
wire [63:0] dsp_stage2_result;
wire dsp_stage3_ovf_set;
wire [63:0] dsp_stage3_result;
wire [(PALEN - 1):12] dtlb_lsu_ppn;
wire [30:0] dtlb_lsu_status;
wire dtlb_miss_req;
wire [(VALEN - 1):12] dtlb_miss_vpn;
wire mmu_lsu_resp_valid;
wire [31:0] fmul_result;
wire fdiv_req_ready;
wire [4:0] fdiv_resp_flag_set;
wire [(FLEN - 1):0] fdiv_resp_result;
wire [4:0] fdiv_resp_tag;
wire fdiv_resp_valid;
wire [4:0] fmac_flag_set;
wire [4:0] fmis_flag_set;
wire [(FLEN - 1):0] fpu_fmac32_result;
wire [(FLEN - 1):0] fpu_fmac64_result;
wire [63:0] fpu_fmis_result;
wire [63:0] fpu_fmv_result;
wire fpu_ipipe_fdiv_standby_ready;
wire fpu_ipipe_standby_ready;
wire [(FLEN - 1):0] frf_rdata1;
wire [(FLEN - 1):0] frf_rdata2;
wire [(FLEN - 1):0] frf_rdata3;
wire [(FLEN - 1):0] frf_rdata4;
wire [(L2_ADDR_WIDTH - 1):0] icu_a_address;
wire icu_a_corrupt;
wire [(L2_DATA_WIDTH - 1):0] icu_a_data;
wire [L2_DATA_WIDTH / 8 - 1:0] icu_a_mask;
wire [2:0] icu_a_opcode;
wire [2:0] icu_a_param;
wire [2:0] icu_a_size;
wire [1:0] icu_a_source;
wire [7:0] icu_a_user;
wire icu_a_valid;
wire icu_d_ready;
wire icu_ifu_bus_req_event;
wire icu_ifu_bus_req_full;
wire icu_ifu_line_aq_done;
wire icu_ifu_line_aq_error;
wire icu_ifu_line_op_req_done;
wire icu_ifu_req_ready;
wire [63:0] icu_ifu_resp_rdata;
wire [35:0] icu_ifu_resp_status;
wire icu_ifu_resp_tag;
wire [3:0] icu_ifu_resp_valid;
wire icu_standby_ready;
wire bpu_rd_valid;
wire ex9_lookup_ready;
wire [7:0] ex9_lookup_resp_ecc_code;
wire ex9_lookup_resp_ecc_corr;
wire [2:0] ex9_lookup_resp_ecc_ramid;
wire ex9_lookup_resp_fault;
wire [2:0] ex9_lookup_resp_fault_dcause;
wire [31:0] ex9_lookup_resp_instr;
wire ex9_lookup_resp_page_fault;
wire ex9_lookup_resp_valid;
wire ifu_cctl_ack;
wire [11:0] ifu_cctl_ecc_status;
wire [31:0] ifu_cctl_raddr;
wire [31:0] ifu_cctl_rdata;
wire [4:0] ifu_cctl_status;
wire [5:0] ifu_event;
wire ifu_fence_done;
wire [7:0] ifu_i0_ecc_code;
wire ifu_i0_ecc_corr;
wire [2:0] ifu_i0_ecc_ramid;
wire ifu_i0_fault;
wire [2:0] ifu_i0_fault_dcause;
wire ifu_i0_fault_upper;
wire [31:0] ifu_i0_instr;
wire ifu_i0_instr_16b;
wire ifu_i0_keep_bhr;
wire ifu_i0_page_fault;
wire [(EXTVALEN - 1):0] ifu_i0_pc;
wire ifu_i0_pred_bogus;
wire ifu_i0_pred_brk;
wire [3:0] ifu_i0_pred_cnt;
wire ifu_i0_pred_hit;
wire [(VALEN - 1):0] ifu_i0_pred_npc;
wire ifu_i0_pred_ret;
wire ifu_i0_pred_start;
wire ifu_i0_pred_taken;
wire ifu_i0_pred_valid;
wire [1:0] ifu_i0_pred_way;
wire ifu_i0_valid;
wire ifu_i0_vector_resume;
wire [7:0] ifu_i1_ecc_code;
wire ifu_i1_ecc_corr;
wire [2:0] ifu_i1_ecc_ramid;
wire ifu_i1_fault;
wire [2:0] ifu_i1_fault_dcause;
wire ifu_i1_fault_upper;
wire [31:0] ifu_i1_instr;
wire ifu_i1_instr_16b;
wire ifu_i1_keep_bhr;
wire ifu_i1_page_fault;
wire [(EXTVALEN - 1):0] ifu_i1_pc;
wire ifu_i1_pred_bogus;
wire ifu_i1_pred_brk;
wire [3:0] ifu_i1_pred_cnt;
wire ifu_i1_pred_hit;
wire [(VALEN - 1):0] ifu_i1_pred_npc;
wire ifu_i1_pred_ret;
wire ifu_i1_pred_start;
wire ifu_i1_pred_taken;
wire ifu_i1_pred_valid;
wire [1:0] ifu_i1_pred_way;
wire ifu_i1_valid;
wire ifu_i1_vector_resume;
wire [(PALEN - 1):0] ifu_icu_f1_pa;
wire ifu_icu_f2_cacheable;
wire ifu_icu_f2_cctl_pref;
wire ifu_icu_kill;
wire ifu_icu_line_aq;
wire [(PALEN - 1):0] ifu_icu_line_aq_addr;
wire [16:0] ifu_icu_line_aq_attri;
wire [ICACHE_INDEX_MSB:6] ifu_icu_line_aq_index;
wire [1:0] ifu_icu_line_op;
wire ifu_icu_line_op_req;
wire [(VALEN - 1):0] ifu_icu_req_addr;
wire ifu_icu_req_nonseq;
wire [1:0] ifu_icu_req_rd_word;
wire ifu_icu_req_tag;
wire [2:0] ifu_icu_req_type;
wire ifu_icu_req_valid;
wire [71:0] ifu_icu_req_wdata;
wire ifu_icu_req_wecc;
wire ifu_ilm_kill;
wire [(VALEN - 1):0] ifu_ilm_req_addr;
wire ifu_ilm_req_stall;
wire ifu_ilm_req_tag;
wire ifu_ilm_req_valid;
wire ifu_ipipe_init_done;
wire ifu_ipipe_standby_ready;
wire ifu_itlb_req_valid;
wire [(EXTVALEN - 1):0] ifu_itlb_va;
wire ifu_mmu_req_valid;
wire [(EXTVALEN - 1):0] ifu_mmu_va;
wire [(PALEN - 1):0] ifu_pma_req_pa;
wire [(PALEN - 1):0] ifu_pmp_req_pa;
wire async_valid;
wire debugint_valid;
wire epc_init;
wire [2:0] int_cause_detail;
wire int_cause_interrupt;
wire [9:0] int_code;
wire [15:0] int_ddcause;
wire int_detail_cause_valid;
wire int_dex2dbg;
wire int_ecc;
wire ipipe_csr_int_delegate_s;
wire ipipe_csr_int_delegate_u;
wire ipipe_csr_m_hpmint_clr;
wire ipipe_csr_m_sbe_clr;
wire ipipe_csr_m_sbe_set;
wire ipipe_csr_m_slpecc_clr;
wire ipipe_csr_nmi_pending;
wire ipipe_csr_s_hpmint_clr;
wire ipipe_csr_s_sbe_clr;
wire ipipe_csr_s_sbe_set;
wire ipipe_csr_s_slpecc_clr;
wire [4:0] itrigger_fire;
wire mei_entry_sel;
wire mint_valid;
wire [11:0] mint_vec;
wire nmi_valid;
wire rf_init;
wire sei_entry_sel;
wire sint_valid;
wire [10:0] sint_vec;
wire [4:0] trigm_int_code;
wire uei_entry_sel;
wire uint_valid;
wire [9:0] uint_vec;
wire wfi_done;
wire [35:0] alu0_func;
wire [31:0] alu0_op0;
wire [31:0] alu0_op1;
wire [31:0] alu1_bop0;
wire [31:0] alu1_bop1;
wire [35:0] alu1_func;
wire [31:0] alu1_op0;
wire [31:0] alu1_op1;
wire [35:0] alu2_func;
wire [31:0] alu2_op0;
wire [31:0] alu2_op1;
wire [31:0] alu3_bop0;
wire [31:0] alu3_bop1;
wire [35:0] alu3_func;
wire [31:0] alu3_op0;
wire [31:0] alu3_op1;
wire async_ready;
wire bhr_recover;
wire [7:0] bhr_recover_data;
wire bht_update_p0;
wire [7:0] bht_update_p0_dir_addr;
wire [1:0] bht_update_p0_dir_data;
wire [7:0] bht_update_p0_sel_addr;
wire [1:0] bht_update_p0_sel_data;
wire bht_update_p1;
wire [7:0] bht_update_p1_dir_addr;
wire [1:0] bht_update_p1_dir_data;
wire [7:0] bht_update_p1_sel_addr;
wire [1:0] bht_update_p1_sel_data;
wire [4:0] bru0_fn;
wire [20:0] bru0_offset;
wire [31:0] bru0_op0;
wire [31:0] bru0_op1;
wire [(EXTVALEN - 1):0] bru0_pc;
wire [11:0] bru0_pred_info;
wire [(EXTVALEN - 1):0] bru0_pred_npc;
wire [8:0] bru0_type;
wire [31:0] bru1_bop0;
wire [31:0] bru1_bop1;
wire [4:0] bru1_fn;
wire [20:0] bru1_offset;
wire [31:0] bru1_op0;
wire [31:0] bru1_op1;
wire [(EXTVALEN - 1):0] bru1_pc;
wire [11:0] bru1_pred_info;
wire [(EXTVALEN - 1):0] bru1_pred_npc;
wire [8:0] bru1_type;
wire [4:0] bru2_fn;
wire [20:0] bru2_offset;
wire [31:0] bru2_op0;
wire [31:0] bru2_op1;
wire [(EXTVALEN - 1):0] bru2_pc;
wire [11:0] bru2_pred_info;
wire [(EXTVALEN - 1):0] bru2_pred_npc;
wire [8:0] bru2_type;
wire [31:0] bru3_bop0;
wire [31:0] bru3_bop1;
wire [4:0] bru3_fn;
wire [20:0] bru3_offset;
wire [31:0] bru3_op0;
wire [31:0] bru3_op1;
wire [(EXTVALEN - 1):0] bru3_pc;
wire [11:0] bru3_pred_info;
wire [(EXTVALEN - 1):0] bru3_pred_npc;
wire [8:0] bru3_type;
wire btb_flush_valid;
wire btb_update_p0;
wire btb_update_p0_alloc;
wire [9:0] btb_update_p0_blk_offset;
wire btb_update_p0_call;
wire btb_update_p0_hold;
wire btb_update_p0_ret;
wire [(VALEN - 1):0] btb_update_p0_start_pc;
wire [(VALEN - 1):0] btb_update_p0_target_pc;
wire btb_update_p0_ucond;
wire [1:0] btb_update_p0_way;
wire btb_update_p1;
wire btb_update_p1_alloc;
wire [9:0] btb_update_p1_blk_offset;
wire btb_update_p1_call;
wire btb_update_p1_hold;
wire btb_update_p1_ret;
wire [(VALEN - 1):0] btb_update_p1_start_pc;
wire [(VALEN - 1):0] btb_update_p1_target_pc;
wire btb_update_p1_ucond;
wire [1:0] btb_update_p1_way;
wire [31:0] dsp_data_src1;
wire [31:0] dsp_data_src2;
wire [31:0] dsp_data_src3;
wire [31:0] dsp_data_src4;
wire [(DSP_FCTRL_WIDTH - 1):0] dsp_function_ctrl;
wire dsp_instr_valid;
wire [(DSP_OCTRL_WIDTH - 1):0] dsp_operand_ctrl;
wire dsp_overflow_ctrl;
wire [(DSP_RCTRL_WIDTH - 1):0] dsp_result_ctrl;
wire dsp_stage2_pipe_en;
wire dsp_stage3_pipe_en;
wire [(EXTVALEN - 1):0] ex9_lookup_pc;
wire ex9_lookup_resp_ready;
wire ex9_lookup_valid;
wire fdiv_kill;
wire fdiv_resp_ready;
wire [3:0] fmul_func;
wire [31:0] fmul_op0;
wire [31:0] fmul_op1;
wire fmul_req;
wire fmul_stall;
wire [21:0] fpu_i0_ctrl;
wire [63:0] fpu_i0_frs1;
wire [(FLEN - 1):0] fpu_i0_frs2;
wire [(FLEN - 1):0] fpu_i0_frs3;
wire fpu_i0_valid;
wire [21:0] fpu_i1_ctrl;
wire [63:0] fpu_i1_frs1;
wire [(FLEN - 1):0] fpu_i1_frs2;
wire [(FLEN - 1):0] fpu_i1_frs3;
wire fpu_i1_valid;
wire fpu_lx_stall;
wire [4:0] frf_raddr1;
wire [4:0] frf_raddr2;
wire [4:0] frf_raddr3;
wire [4:0] frf_raddr4;
wire [4:0] frf_waddr1;
wire [4:0] frf_waddr2;
wire [4:0] frf_waddr3;
wire [(FLEN - 1):0] frf_wdata1;
wire [(FLEN - 1):0] frf_wdata2;
wire [(FLEN - 1):0] frf_wdata3;
wire frf_we1;
wire frf_we2;
wire frf_we3;
wire [1:0] frf_wstatus1;
wire [1:0] frf_wstatus2;
wire frf_wstatus3;
wire ifu_i0_ready;
wire ifu_i1_ready;
wire [4:0] ipipe_csr_fflags_set;
wire ipipe_csr_fs_wen;
wire ipipe_csr_hsp_xcpt;
wire [31:0] ipipe_csr_mhsp_bound_wdata;
wire ipipe_csr_mhsp_bound_wen;
wire [1:0] ipipe_csr_req_func;
wire ipipe_csr_req_mrandstate;
wire [11:0] ipipe_csr_req_raddr;
wire ipipe_csr_req_rd_valid;
wire ipipe_csr_req_read_only;
wire [11:0] ipipe_csr_req_waddr;
wire [31:0] ipipe_csr_req_wdata;
wire ipipe_csr_req_wr_valid;
wire ipipe_csr_ucode_ov_set;
wire [31:0] ipipe_csr_vl_wdata;
wire ipipe_csr_vl_we;
wire [31:0] ipipe_csr_vtype_wdata;
wire ipipe_csr_vtype_we;
wire [0:0] ipipe_event;
wire ipipe_ifu_stall;
wire ls_cmt_kill;
wire ls_cmt_valid;
wire [31:0] ls_cmt_wdata_base;
wire ls_cmt_wdata_sel_vpu;
wire [63:0] ls_cmt_wdata_vpu;
wire [8:0] ls_req_asid;
wire [31:0] ls_req_base0;
wire [31:0] ls_req_base1;
wire [2:0] ls_req_base_bypass;
wire [34:0] ls_req_func;
wire [20:0] ls_req_offset;
wire [11:0] ls_req_pc;
wire [1:0] ls_req_stall;
wire ls_req_valid;
wire ls_una_wait;
wire mdu_kill;
wire [3:0] mdu_req_func;
wire [31:0] mdu_req_op0;
wire [31:0] mdu_req_op1;
wire [4:0] mdu_req_tag;
wire mdu_req_valid;
wire mdu_resp_ready;
wire redirect;
wire redirect_for_cti;
wire [(EXTVALEN - 1):0] redirect_pc;
wire redirect_pc_hit_ilm;
wire [1:0] redirect_ras_ptr;
wire resume;
wire resume_for_replay;
wire retry;
wire [(EXTVALEN - 1):0] retry_pc;
wire [4:0] rf_raddr1;
wire [4:0] rf_raddr2;
wire [4:0] rf_raddr3;
wire [4:0] rf_raddr4;
wire rf_sdw_recover;
wire [4:0] rf_waddr1;
wire [4:0] rf_waddr2;
wire [4:0] rf_waddr3;
wire [31:0] rf_wdata1;
wire [31:0] rf_wdata2;
wire [31:0] rf_wdata3;
wire rf_we1;
wire rf_we2;
wire rf_we3;
wire [1:0] rf_wstatus1;
wire [1:0] rf_wstatus2;
wire rf_wstatus3;
wire [(VALEN - 1):0] trigm_i0_pc;
wire [(VALEN - 1):0] trigm_i1_pc;
wire [31:0] vsetvl_op0;
wire [31:0] vsetvl_op1;
wire wb_i0_16b;
wire wb_i0_alive;
wire [149:0] wb_i0_ctrl;
wire [31:0] wb_i0_instr;
wire [(EXTVALEN - 1):0] wb_i0_npc;
wire [(EXTVALEN - 1):0] wb_i0_pc;
wire [12:0] wb_i0_reso_info;
wire wb_i0_resume;
wire wb_i0_retire;
wire wb_i0_seg_end;
wire [2:0] wb_i0_trace_trigger;
wire [31:0] wb_i0_tval;
wire wb_i1_16b;
wire wb_i1_alive;
wire [149:0] wb_i1_ctrl;
wire [31:0] wb_i1_instr;
wire [(EXTVALEN - 1):0] wb_i1_npc;
wire [(EXTVALEN - 1):0] wb_i1_pc;
wire [12:0] wb_i1_reso_info;
wire wb_i1_resume;
wire wb_i1_retire;
wire wb_i1_seg_end;
wire [2:0] wb_i1_trace_trigger;
wire [31:0] wb_i1_tval;
wire [7:0] wb_ls_ecc_code;
wire wb_ls_ecc_corr;
wire [3:0] wb_ls_ecc_ramid;
wire wb_postsync_resume;
wire wfi_enabled;
wire [(PALEN - 1):0] itlb_ifu_pa;
wire [18:0] itlb_ifu_status;
wire itlb_miss_req;
wire [(VALEN - 1):12] itlb_miss_vpn;
wire mmu_ifu_resp_valid;
wire [(PALEN - 1):0] dcu_cmt_addr;
wire [10:0] dcu_cmt_func;
wire dcu_cmt_valid;
wire [31:0] dcu_cmt_wdata;
wire [3:0] dcu_cmt_wmask;
wire [31:0] dcu_ix_addr;
wire [7:0] dcu_ix_command;
wire dcu_ix_req;
wire [31:0] dcu_ix_wdata;
wire [(PALEN - 1):0] dcu_req_addr;
wire [21:0] dcu_req_func;
wire [0:0] dcu_req_id;
wire dcu_req_stall;
wire dcu_req_valid;
wire dcu_wbf_flush;
wire dptw_mmu_req_ready;
wire [31:0] dptw_mmu_resp_data;
wire [16:0] dptw_mmu_resp_status;
wire dptw_mmu_resp_valid;
wire [4:0] ifu_cctl_command;
wire ifu_cctl_req;
wire [31:0] ifu_cctl_waddr;
wire [31:0] ifu_cctl_wdata;
wire ifu_fence_req;
wire iptw_mmu_req_ready;
wire [31:0] iptw_mmu_resp_data;
wire [16:0] iptw_mmu_resp_status;
wire iptw_mmu_resp_valid;
wire ls_issue_ready;
wire [31:0] ls_resp_bresult;
wire [(EXTVALEN - 1):0] ls_resp_fault_addr;
wire [31:0] ls_resp_result;
wire [63:0] ls_resp_result_64b;
wire [31:0] ls_resp_status;
wire ls_resp_valid;
wire ls_standby_ready;
wire [(L2_ADDR_WIDTH - 1):0] lsu_a_address;
wire lsu_a_corrupt;
wire [(L2_DATA_WIDTH - 1):0] lsu_a_data;
wire [L2_DATA_WIDTH / 8 - 1:0] lsu_a_mask;
wire [2:0] lsu_a_opcode;
wire [2:0] lsu_a_param;
wire [2:0] lsu_a_size;
wire lsu_a_source;
wire [7:0] lsu_a_user;
wire lsu_a_valid;
wire lsu_async_read_error;
wire lsu_async_write_error;
wire [31:0] lsu_cctl_raddr;
wire [31:0] lsu_cctl_rdata;
wire lsu_d_ready;
wire [DLM_AMSB:0] lsu_dlm0_a_addr;
wire [2:0] lsu_dlm0_a_func;
wire lsu_dlm0_a_stall;
wire [0:0] lsu_dlm0_a_user;
wire lsu_dlm0_a_valid;
wire [31:0] lsu_dlm0_w_data;
wire [3:0] lsu_dlm0_w_mask;
wire lsu_dlm0_w_valid;
wire [DLM_AMSB:0] lsu_dlm1_a_addr;
wire [2:0] lsu_dlm1_a_func;
wire lsu_dlm1_a_stall;
wire [0:0] lsu_dlm1_a_user;
wire lsu_dlm1_a_valid;
wire [31:0] lsu_dlm1_w_data;
wire [3:0] lsu_dlm1_w_mask;
wire lsu_dlm1_w_valid;
wire [DLM_AMSB:0] lsu_dlm2_a_addr;
wire [2:0] lsu_dlm2_a_func;
wire lsu_dlm2_a_stall;
wire [0:0] lsu_dlm2_a_user;
wire lsu_dlm2_a_valid;
wire [31:0] lsu_dlm2_w_data;
wire [3:0] lsu_dlm2_w_mask;
wire lsu_dlm2_w_valid;
wire [DLM_AMSB:0] lsu_dlm3_a_addr;
wire [2:0] lsu_dlm3_a_func;
wire lsu_dlm3_a_stall;
wire [0:0] lsu_dlm3_a_user;
wire lsu_dlm3_a_valid;
wire [31:0] lsu_dlm3_w_data;
wire [3:0] lsu_dlm3_w_mask;
wire lsu_dlm3_w_valid;
wire lsu_dtlb_lru_valid;
wire [7:0] lsu_dtlb_lru_wdata;
wire lsu_dtlb_privilege_u;
wire lsu_dtlb_store;
wire [(VALEN - 1):0] lsu_dtlb_va_op0;
wire [20:0] lsu_dtlb_va_op1;
wire [4:0] lsu_event;
wire [ILM_AMSB:0] lsu_ilm_a_addr;
wire [2:0] lsu_ilm_a_func;
wire lsu_ilm_a_stall;
wire [2:0] lsu_ilm_a_user;
wire lsu_ilm_a_valid;
wire [63:0] lsu_ilm_w_data;
wire [7:0] lsu_ilm_w_mask;
wire lsu_ilm_w_valid;
wire lsu_mmu_req_valid;
wire [(EXTVALEN - 1):0] lsu_mmu_va;
wire [(PALEN - 1):0] lsu_pma_req_pa;
wire [(PALEN - 1):0] lsu_pmp_req_pa;
wire lsu_pmp_req_store;
wire [8:0] mmu_fence_asid;
wire [1:0] mmu_fence_mode;
wire mmu_fence_req;
wire [(VALEN - 1):12] mmu_fence_vaddr;
wire [4:0] nbload_resp_rd;
wire [31:0] nbload_resp_result;
wire nbload_resp_status;
wire nbload_resp_valid;
wire [1:0] tlb_cctl_command;
wire tlb_cctl_req;
wire [31:0] tlb_cctl_waddr;
wire [31:0] tlb_cctl_wdata;
wire [(VALEN - 1):0] trigm_ls_addr;
wire trigm_ls_load;
wire trigm_ls_store;
wire mdu_req_ready;
wire [31:0] mdu_resp_result;
wire [4:0] mdu_resp_tag;
wire mdu_resp_valid;
wire [DTLB_PPN_MSB:0] dtlb_miss_data;
wire dtlb_miss_resp;
wire dtlb_sfence_mode_flush_all;
wire dtlb_sfence_mode_va;
wire dtlb_sfence_req;
wire [ITLB_PPN_MSB:0] itlb_miss_data;
wire itlb_miss_resp;
wire itlb_sfence_mode_flush_all;
wire itlb_sfence_mode_va;
wire itlb_sfence_req;
wire mmu_csr_mdtlb_access;
wire mmu_csr_mdtlb_miss;
wire mmu_csr_mitlb_access;
wire mmu_csr_mitlb_miss;
wire [(PALEN - 1):0] mmu_dptw_req_pa;
wire mmu_dptw_req_valid;
wire mmu_fence_done;
wire mmu_ipipe_standby_ready;
wire [(PALEN - 1):0] mmu_iptw_req_pa;
wire mmu_iptw_req_valid;
wire tlb_cctl_ack;
wire [7:0] tlb_cctl_ecc_status;
wire [31:0] tlb_cctl_raddr;
wire [31:0] tlb_cctl_rdata;
wire pma_csr_hit0;
wire pma_csr_hit1;
wire [31:0] pma_csr_rdata0;
wire [31:0] pma_csr_rdata1;
wire pma_ifu_resp_fault;
wire [3:0] pma_ifu_resp_mtype;
wire pma_lsu_resp_fault;
wire [3:0] pma_lsu_resp_mtype;
wire pma_lsu_resp_namo;
wire pmp_csr_hit0;
wire pmp_csr_hit1;
wire [31:0] pmp_csr_rdata0;
wire [31:0] pmp_csr_rdata1;
wire pmp_ifu_resp_fault;
wire pmp_lsu_resp_fault;
wire [31:0] rf_rdata1;
wire [31:0] rf_rdata2;
wire [31:0] rf_rdata3;
wire [31:0] rf_rdata4;
wire [31:0] rf_rdata5;
wire [31:0] csr_mcontext;
wire [31:0] csr_scontext;
wire [31:0] csr_tdata1;
wire [31:0] csr_tdata2;
wire [31:0] csr_tdata3;
wire [31:0] csr_tinfo;
wire [31:0] csr_tselect;
wire [4:0] trigm_i0_result;
wire [4:0] trigm_i1_result;
wire trigm_icount_enabled;
wire [4:0] trigm_icount_result;
wire [4:0] trigm_int_result;
wire [4:0] trigm_ls_result;
wire trigm_trace_enabled;
wire [4:0] trigm_xcpt_result;
wire [31:0] alu0_aresult;
wire [31:0] alu0_bresult;
wire [31:0] alu0_result;
wire [31:0] alu1_result;
wire [31:0] nds_unused_alu1_aresult;
wire [31:0] nds_unused_alu1_bresult;
wire [31:0] alu2_result;
wire [31:0] nds_unused_alu2_aresult;
wire [31:0] nds_unused_alu2_bresult;
wire [31:0] alu3_result;
wire [31:0] nds_unused_alu3_aresult;
wire [31:0] nds_unused_alu3_bresult;
wire core_coherent_state_int;
wire [(L2_ADDR_WIDTH - 1):0] dcu_b_address;
wire dcu_b_corrupt;
wire [(L2_DATA_WIDTH - 1):0] dcu_b_data;
wire [(L2_DATA_WIDTH / 8) - 1:0] dcu_b_mask;
wire [2:0] dcu_b_opcode;
wire [2:0] dcu_b_param;
wire [2:0] dcu_b_size;
wire [2:0] dcu_b_source;
wire dcu_b_valid;
wire [12:0] bru0_reso_info;
wire [(EXTVALEN - 1):0] bru0_seq_npc;
wire [(EXTVALEN - 1):0] bru0_target;
wire [12:0] bru1_reso_info;
wire [(EXTVALEN - 1):0] bru1_seq_npc;
wire [(EXTVALEN - 1):0] bru1_target;
wire [12:0] bru2_reso_info;
wire [(EXTVALEN - 1):0] bru2_seq_npc;
wire [(EXTVALEN - 1):0] bru2_target;
wire [12:0] bru3_reso_info;
wire [(EXTVALEN - 1):0] bru3_seq_npc;
wire [(EXTVALEN - 1):0] bru3_target;
wire dlm0_async_write_error;
wire dlm1_async_write_error;
wire dlm2_async_write_error;
wire dlm3_async_write_error;
wire dlm_csr_access0;
wire dlm_csr_access1;
wire dlm_csr_access2;
wire dlm_csr_access3;
wire lsu_dlm0_a_ready;
wire [31:0] lsu_dlm0_d_data;
wire [13:0] lsu_dlm0_d_status;
wire [0:0] lsu_dlm0_d_user;
wire lsu_dlm0_d_valid;
wire lsu_dlm0_w_ready;
wire lsu_dlm0_w_status;
wire lsu_dlm1_a_ready;
wire [31:0] lsu_dlm1_d_data;
wire [13:0] lsu_dlm1_d_status;
wire [0:0] lsu_dlm1_d_user;
wire lsu_dlm1_d_valid;
wire lsu_dlm1_w_ready;
wire lsu_dlm1_w_status;
wire lsu_dlm2_a_ready;
wire [31:0] lsu_dlm2_d_data;
wire [13:0] lsu_dlm2_d_status;
wire [0:0] lsu_dlm2_d_user;
wire lsu_dlm2_d_valid;
wire lsu_dlm2_w_ready;
wire lsu_dlm2_w_status;
wire lsu_dlm3_a_ready;
wire [31:0] lsu_dlm3_d_data;
wire [13:0] lsu_dlm3_d_status;
wire [0:0] lsu_dlm3_d_user;
wire lsu_dlm3_d_valid;
wire lsu_dlm3_w_ready;
wire lsu_dlm3_w_status;
wire nds_unused_dlm_ipipe_standby_ready;
wire slv_dlm0_a_ready;
wire [31:0] slv_dlm0_d_data;
wire [13:0] slv_dlm0_d_status;
wire [0:0] slv_dlm0_d_user;
wire slv_dlm0_d_valid;
wire slv_dlm0_w_ready;
wire slv_dlm1_a_ready;
wire [31:0] slv_dlm1_d_data;
wire [13:0] slv_dlm1_d_status;
wire [0:0] slv_dlm1_d_user;
wire slv_dlm1_d_valid;
wire slv_dlm1_w_ready;
wire slv_dlm2_a_ready;
wire [31:0] slv_dlm2_d_data;
wire [13:0] slv_dlm2_d_status;
wire [0:0] slv_dlm2_d_user;
wire slv_dlm2_d_valid;
wire slv_dlm2_w_ready;
wire slv_dlm3_a_ready;
wire [31:0] slv_dlm3_d_data;
wire [13:0] slv_dlm3_d_status;
wire [0:0] slv_dlm3_d_user;
wire slv_dlm3_d_valid;
wire slv_dlm3_w_ready;
wire [ILM_AMSB:0] ifu_ilm_a_addr;
wire [2:0] ifu_ilm_a_func;
wire ifu_ilm_a_stall;
wire [2:0] ifu_ilm_a_user;
wire ifu_ilm_a_valid;
wire ilm_ifu_req_ready;
wire [63:0] ilm_ifu_resp_rdata;
wire [35:0] ilm_ifu_resp_status;
wire ilm_ifu_resp_tag;
wire [3:0] ilm_ifu_resp_valid;
wire ifu_ilm_a_ready;
wire [63:0] ifu_ilm_d_data;
wire [13:0] ifu_ilm_d_status;
wire [2:0] ifu_ilm_d_user;
wire ifu_ilm_d_valid;
wire ilm_async_write_error;
wire ilm_csr_access;
wire lsu_ilm_a_ready;
wire [63:0] lsu_ilm_d_data;
wire [13:0] lsu_ilm_d_status;
wire [2:0] lsu_ilm_d_user;
wire lsu_ilm_d_valid;
wire lsu_ilm_w_ready;
wire lsu_ilm_w_status;
wire nds_unused_ilm_ipipe_standby_ready;
wire slv_ilm_a_ready;
wire [63:0] slv_ilm_d_data;
wire [13:0] slv_ilm_d_status;
wire [2:0] slv_ilm_d_user;
wire slv_ilm_d_valid;
wire slv_ilm_w_ready;
wire lm_async_write_error;
wire slvp_ipipe_ecc_corr;
wire [3:0] slvp_ipipe_ecc_ramid;
wire slvp_ipipe_local_int;
wire slv1_reset_n_int;
wire slv_reset_n_int;
wire [11:0] csr_prob_raddr;
wire [4:0] rf_raddr5;
wire [((DLM_AMSB + 1) - 1):0] slv_dlm0_a_addr;
wire [2:0] slv_dlm0_a_func;
wire slv_dlm0_a_stall;
wire [0:0] slv_dlm0_a_user;
wire slv_dlm0_a_valid;
wire [31:0] slv_dlm0_w_data;
wire [3:0] slv_dlm0_w_mask;
wire slv_dlm0_w_valid;
wire [((DLM_AMSB + 1) - 1):0] slv_dlm1_a_addr;
wire [2:0] slv_dlm1_a_func;
wire slv_dlm1_a_stall;
wire [0:0] slv_dlm1_a_user;
wire slv_dlm1_a_valid;
wire [31:0] slv_dlm1_w_data;
wire [3:0] slv_dlm1_w_mask;
wire slv_dlm1_w_valid;
wire [((DLM_AMSB + 1) - 1):0] slv_dlm2_a_addr;
wire [2:0] slv_dlm2_a_func;
wire slv_dlm2_a_stall;
wire [0:0] slv_dlm2_a_user;
wire slv_dlm2_a_valid;
wire [31:0] slv_dlm2_w_data;
wire [3:0] slv_dlm2_w_mask;
wire slv_dlm2_w_valid;
wire [((DLM_AMSB + 1) - 1):0] slv_dlm3_a_addr;
wire [2:0] slv_dlm3_a_func;
wire slv_dlm3_a_stall;
wire [0:0] slv_dlm3_a_user;
wire slv_dlm3_a_valid;
wire [31:0] slv_dlm3_w_data;
wire [3:0] slv_dlm3_w_mask;
wire slv_dlm3_w_valid;
wire [((ILM_AMSB + 1) - 1):0] slv_ilm_a_addr;
wire [2:0] slv_ilm_a_func;
wire [1:0] slv_ilm_a_mask;
wire slv_ilm_a_stall;
wire [2:0] slv_ilm_a_user;
wire slv_ilm_a_valid;
wire [63:0] slv_ilm_w_data;
wire [7:0] slv_ilm_w_mask;
wire slv_ilm_w_valid;
wire slvp_async_ecc_corr;
wire [3:0] slvp_async_ecc_ramid;
wire slvp_async_local_int;
wire [31:0] vsetvl_result;
wire [8:0] vsetvl_vtype;
assign lm_clk_en = 1'b1;
generate
    if ((ILM_SIZE_KB != 0) || (DLM_SIZE_KB != 0)) begin:gen_lm_reset_done
        reg lm_reset_done_r;
        wire lm_reset_done_reset_n = lm_reset_n;
        always @(posedge lm_clk or negedge lm_reset_done_reset_n) begin
            if (!lm_reset_done_reset_n) begin
                lm_reset_done_r <= 1'b0;
            end
            else begin
                lm_reset_done_r <= 1'b1;
            end
        end

        assign lm_reset_done = lm_reset_done_r;
    end
    else begin:gen_lm_reset_done_stub
        assign lm_reset_done = 1'b1;
    end
endgenerate
generate
    if ((SLAVE_PORT_SUPPORT_INT == 0)) begin:gen_slv_port_no
        assign slvp_async_ecc_corr = 1'b0;
        assign slvp_async_ecc_ramid = 4'b0;
        assign slvp_async_local_int = 1'b0;
        assign slv_ilm_a_addr = {(ILM_AMSB + 1){1'b0}};
        assign slv_ilm_a_func = {3{1'b0}};
        assign slv_ilm_a_stall = 1'b0;
        assign slv_ilm_a_user = 3'b0;
        assign slv_ilm_a_valid = 1'b0;
        assign slv_ilm_a_mask = {2{1'b0}};
        assign slv_ilm_w_data = {64{1'b0}};
        assign slv_ilm_w_mask = {8{1'b0}};
        assign slv_ilm_w_valid = 1'b0;
        assign slv_dlm0_a_addr = {(DLM_AMSB + 1){1'b0}};
        assign slv_dlm0_a_func = {3{1'b0}};
        assign slv_dlm0_a_stall = 1'b0;
        assign slv_dlm0_a_user = 1'b0;
        assign slv_dlm0_a_valid = 1'b0;
        assign slv_dlm0_w_data = {32{1'b0}};
        assign slv_dlm0_w_mask = {4{1'b0}};
        assign slv_dlm0_w_valid = 1'b0;
        assign slv_dlm1_a_addr = {(DLM_AMSB + 1){1'b0}};
        assign slv_dlm1_a_func = {3{1'b0}};
        assign slv_dlm1_a_stall = 1'b0;
        assign slv_dlm1_a_user = 1'b0;
        assign slv_dlm1_a_valid = 1'b0;
        assign slv_dlm1_w_data = {32{1'b0}};
        assign slv_dlm1_w_mask = {4{1'b0}};
        assign slv_dlm1_w_valid = 1'b0;
        assign slv_dlm2_a_addr = {(DLM_AMSB + 1){1'b0}};
        assign slv_dlm2_a_func = {3{1'b0}};
        assign slv_dlm2_a_stall = 1'b0;
        assign slv_dlm2_a_user = 1'b0;
        assign slv_dlm2_a_valid = 1'b0;
        assign slv_dlm2_w_data = {32{1'b0}};
        assign slv_dlm2_w_mask = {4{1'b0}};
        assign slv_dlm2_w_valid = 1'b0;
        assign slv_dlm3_a_addr = {(DLM_AMSB + 1){1'b0}};
        assign slv_dlm3_a_func = {3{1'b0}};
        assign slv_dlm3_a_stall = 1'b0;
        assign slv_dlm3_a_user = 1'b0;
        assign slv_dlm3_a_valid = 1'b0;
        assign slv_dlm3_w_data = {32{1'b0}};
        assign slv_dlm3_w_mask = {4{1'b0}};
        assign slv_dlm3_w_valid = 1'b0;
        assign slv_arready = 1'b0;
        assign slv_awready = 1'b0;
        assign slv_bid = {(SLAVE_PORT_ID_WIDTH){1'b0}};
        assign slv_bresp = {2{1'b0}};
        assign slv_bvalid = 1'b0;
        assign slv_rdata = {(SLAVE_PORT_DATA_WIDTH){1'b0}};
        assign slv_rid = {(SLAVE_PORT_ID_WIDTH){1'b0}};
        assign slv_rlast = 1'b0;
        assign slv_rresp = {2{1'b0}};
        assign slv_rvalid = 1'b0;
        assign slv_wready = 1'b0;
        assign slv1_arready = 1'b0;
        assign slv1_awready = 1'b0;
        assign slv1_bid = {(SLAVE_PORT_ID_WIDTH){1'b0}};
        assign slv1_bresp = {2{1'b0}};
        assign slv1_bvalid = 1'b0;
        assign slv1_rdata = {(SLAVE_PORT_DATA_WIDTH){1'b0}};
        assign slv1_rid = {(SLAVE_PORT_ID_WIDTH){1'b0}};
        assign slv1_rlast = 1'b0;
        assign slv1_rresp = {2{1'b0}};
        assign slv1_rvalid = 1'b0;
        assign slv1_wready = 1'b0;
    end
endgenerate
generate
    if (HAS_CORE_BRG == 0) begin:gen_cluster_stub
        assign m0_a_address = {BIU_ADDR_WIDTH{1'b0}};
        assign m0_a_corrupt = 1'b0;
        assign m0_a_data = {BIU_DATA_WIDTH{1'b0}};
        assign m0_a_mask = {(BIU_DATA_WIDTH / 8){1'b0}};
        assign m0_a_opcode = 3'b0;
        assign m0_a_param = 3'b0;
        assign m0_a_size = {TL_SIZE_WIDTH{1'b0}};
        assign m0_a_source = {L2_SOURCE_WIDTH{1'b0}};
        assign m0_a_user = {12{1'b0}};
        assign m0_a_valid = 1'b0;
        assign m0_b_ready = 1'b0;
        assign m0_c_address = {BIU_ADDR_WIDTH{1'b0}};
        assign m0_c_corrupt = 1'b0;
        assign m0_c_data = {BIU_DATA_WIDTH{1'b0}};
        assign m0_c_opcode = 3'd0;
        assign m0_c_param = 3'd0;
        assign m0_c_size = 3'd0;
        assign m0_c_source = {L2_SOURCE_WIDTH{1'b0}};
        assign m0_c_user = {8{1'b0}};
        assign m0_c_valid = 1'b0;
        assign m0_d_ready = 1'b0;
        assign m0_e_sink = {TL_SINK_WIDTH{1'b0}};
        assign m0_e_valid = 1'b0;
        assign m1_a_address = {BIU_ADDR_WIDTH{1'b0}};
        assign m1_a_corrupt = 1'b0;
        assign m1_a_data = {BIU_DATA_WIDTH{1'b0}};
        assign m1_a_mask = {(BIU_DATA_WIDTH / 8){1'b0}};
        assign m1_a_opcode = 3'b0;
        assign m1_a_param = 3'b0;
        assign m1_a_size = {TL_SIZE_WIDTH{1'b0}};
        assign m1_a_source = {L2_SOURCE_WIDTH{1'b0}};
        assign m1_a_user = {12{1'b0}};
        assign m1_a_valid = 1'b0;
        assign m1_d_ready = 1'b0;
        assign m2_a_address = {BIU_ADDR_WIDTH{1'b0}};
        assign m2_a_corrupt = 1'b0;
        assign m2_a_data = {BIU_DATA_WIDTH{1'b0}};
        assign m2_a_mask = {(BIU_DATA_WIDTH / 8){1'b0}};
        assign m2_a_opcode = 3'b0;
        assign m2_a_param = 3'b0;
        assign m2_a_size = {TL_SIZE_WIDTH{1'b0}};
        assign m2_a_source = {L2_SOURCE_WIDTH{1'b0}};
        assign m2_a_user = {12{1'b0}};
        assign m2_a_valid = 1'b0;
        assign m2_d_ready = 1'b0;
        assign dcu_b_address = {BIU_ADDR_WIDTH{1'b0}};
        assign dcu_b_corrupt = 1'b0;
        assign dcu_b_data = {BIU_DATA_WIDTH{1'b0}};
        assign dcu_b_mask = {(BIU_DATA_WIDTH / 8){1'b0}};
        assign dcu_b_opcode = 3'b0;
        assign dcu_b_param = 3'b0;
        assign dcu_b_size = {TL_SIZE_WIDTH{1'b0}};
        assign dcu_b_source = {3{1'b0}};
        assign dcu_b_valid = 1'b0;
        assign core_coherent_enable = core_coherent_enable_int;
        assign core_coherent_state_int = core_coherent_state;
    end
endgenerate
generate
    if (HAS_CORE_BRG == 1) begin:gen_biu_stub
        assign arid = {BIU_ID_WIDTH{1'b0}};
        assign araddr = {BIU_ADDR_WIDTH{1'b0}};
        assign arlen = 8'b0;
        assign arsize = 3'b0;
        assign arburst = 2'b0;
        assign arlock = 1'b0;
        assign arcache = 4'b0;
        assign arprot = 3'b0;
        assign arvalid = 1'b0;
        assign awid = {BIU_ID_WIDTH{1'b0}};
        assign awaddr = {BIU_ADDR_WIDTH{1'b0}};
        assign awlen = 8'b0;
        assign awsize = 3'b0;
        assign awburst = 2'b0;
        assign awlock = 1'b0;
        assign awcache = 4'b0;
        assign awprot = 3'b0;
        assign awvalid = 1'b0;
        assign wdata = {BIU_DATA_WIDTH{1'b0}};
        assign wstrb = {BIU_DATA_WIDTH / 8{1'b0}};
        assign wlast = 1'b0;
        assign wvalid = 1'b0;
        assign bready = 1'b0;
        assign rready = 1'b0;
        assign i_arid = {BIU_ID_WIDTH{1'b0}};
        assign i_araddr = {BIU_ADDR_WIDTH{1'b0}};
        assign i_arlen = 8'b0;
        assign i_arsize = 3'b0;
        assign i_arburst = 2'b0;
        assign i_arlock = 1'b0;
        assign i_arcache = 4'b0;
        assign i_arprot = 3'b0;
        assign i_arvalid = 1'b0;
        assign i_awid = {BIU_ID_WIDTH{1'b0}};
        assign i_awaddr = {BIU_ADDR_WIDTH{1'b0}};
        assign i_awlen = 8'b0;
        assign i_awsize = 3'b0;
        assign i_awburst = 2'b0;
        assign i_awlock = 1'b0;
        assign i_awcache = 4'b0;
        assign i_awprot = 3'b0;
        assign i_awvalid = 1'b0;
        assign i_wdata = {BIU_DATA_WIDTH{1'b0}};
        assign i_wstrb = {BIU_DATA_WIDTH / 8{1'b0}};
        assign i_wlast = 1'b0;
        assign i_wvalid = 1'b0;
        assign i_bready = 1'b0;
        assign i_rready = 1'b0;
        assign d_arid = {BIU_ID_WIDTH{1'b0}};
        assign d_araddr = {BIU_ADDR_WIDTH{1'b0}};
        assign d_arlen = 8'b0;
        assign d_arsize = 3'b0;
        assign d_arburst = 2'b0;
        assign d_arlock = 1'b0;
        assign d_arcache = 4'b0;
        assign d_arprot = 3'b0;
        assign d_arvalid = 1'b0;
        assign d_awid = {BIU_ID_WIDTH{1'b0}};
        assign d_awaddr = {BIU_ADDR_WIDTH{1'b0}};
        assign d_awlen = 8'b0;
        assign d_awsize = 3'b0;
        assign d_awburst = 2'b0;
        assign d_awlock = 1'b0;
        assign d_awcache = 4'b0;
        assign d_awprot = 3'b0;
        assign d_awvalid = 1'b0;
        assign d_wdata = {BIU_DATA_WIDTH{1'b0}};
        assign d_wstrb = {BIU_DATA_WIDTH / 8{1'b0}};
        assign d_wlast = 1'b0;
        assign d_wvalid = 1'b0;
        assign d_bready = 1'b0;
        assign d_rready = 1'b0;
    end
endgenerate
assign biu_ipipe_standby_ready = 1'b1;
generate
    if (HAS_CORE_BRG == 0) begin:gen_sp_unused
        wire nds_unused_m0_a_ready = m0_a_ready;
        wire [(BIU_ADDR_WIDTH - 1):0] nds_unused_m0_b_address = m0_b_address;
        wire nds_unused_m0_b_corrupt = m0_b_corrupt;
        wire [(BIU_DATA_WIDTH - 1):0] nds_unused_m0_b_data = m0_b_data;
        wire [(BIU_DATA_WIDTH / 8) - 1:0] nds_unused_m0_b_mask = m0_b_mask;
        wire [2:0] nds_unused_m0_b_opcode = m0_b_opcode;
        wire [2:0] nds_unused_m0_b_param = m0_b_param;
        wire [2:0] nds_unused_m0_b_size = m0_b_size;
        wire [(L2_SOURCE_WIDTH - 1):0] nds_unused_m0_b_source = m0_b_source;
        wire nds_unused_m0_b_valid = m0_b_valid;
        wire nds_unused_m0_c_ready = m0_c_ready;
        wire nds_unused_m0_d_corrupt = m0_d_corrupt;
        wire [(BIU_DATA_WIDTH - 1):0] nds_unused_m0_d_data = m0_d_data;
        wire nds_unused_m0_d_denied = m0_d_denied;
        wire [2:0] nds_unused_m0_d_opcode = m0_d_opcode;
        wire [1:0] nds_unused_m0_d_param = m0_d_param;
        wire [(TL_SINK_WIDTH - 1):0] nds_unused_m0_d_sink = m0_d_sink;
        wire [2:0] nds_unused_m0_d_size = m0_d_size;
        wire [(L2_SOURCE_WIDTH - 1):0] nds_unused_m0_d_source = m0_d_source;
        wire [5:0] nds_unused_m0_d_user = m0_d_user;
        wire nds_unused_m0_d_valid = m0_d_valid;
        wire nds_unused_m0_e_ready = m0_e_ready;
        wire nds_unused_m1_a_ready = m1_a_ready;
        wire nds_unused_m1_d_corrupt = m1_d_corrupt;
        wire [(BIU_DATA_WIDTH - 1):0] nds_unused_m1_d_data = m1_d_data;
        wire nds_unused_m1_d_denied = m1_d_denied;
        wire [2:0] nds_unused_m1_d_opcode = m1_d_opcode;
        wire [1:0] nds_unused_m1_d_param = m1_d_param;
        wire [(TL_SINK_WIDTH - 1):0] nds_unused_m1_d_sink = m1_d_sink;
        wire [(TL_SIZE_WIDTH - 1):0] nds_unused_m1_d_size = m1_d_size;
        wire [(L2_SOURCE_WIDTH - 1):0] nds_unused_m1_d_source = m1_d_source;
        wire [5:0] nds_unused_m1_d_user = m1_d_user;
        wire nds_unused_m1_d_valid = m1_d_valid;
        wire nds_unused_m2_a_ready = m2_a_ready;
        wire nds_unused_m2_d_corrupt = m2_d_corrupt;
        wire [(BIU_DATA_WIDTH - 1):0] nds_unused_m2_d_data = m2_d_data;
        wire nds_unused_m2_d_denied = m2_d_denied;
        wire [2:0] nds_unused_m2_d_opcode = m2_d_opcode;
        wire [1:0] nds_unused_m2_d_param = m2_d_param;
        wire [(TL_SINK_WIDTH - 1):0] nds_unused_m2_d_sink = m2_d_sink;
        wire [(TL_SIZE_WIDTH - 1):0] nds_unused_m2_d_size = m2_d_size;
        wire [(L2_SOURCE_WIDTH - 1):0] nds_unused_m2_d_source = m2_d_source;
        wire [5:0] nds_unused_m2_d_user = m2_d_user;
        wire nds_unused_m2_d_valid = m2_d_valid;
        wire nds_unused_dcu_b_ready = dcu_b_ready;
    end
    if ((SLAVE_PORT_SUPPORT_INT == 0)) begin:gen_no_slvp_unused
        wire [(BIU_ADDR_WIDTH - 1):0] nds_unused_slv1_araddr = slv1_araddr;
        wire [1:0] nds_unused_slv1_arburst = slv1_arburst;
        wire [3:0] nds_unused_slv1_arcache = slv1_arcache;
        wire [(SLAVE_PORT_ID_WIDTH - 1):0] nds_unused_slv1_arid = slv1_arid;
        wire [7:0] nds_unused_slv1_arlen = slv1_arlen;
        wire nds_unused_slv1_arlock = slv1_arlock;
        wire [2:0] nds_unused_slv1_arprot = slv1_arprot;
        wire [2:0] nds_unused_slv1_arsize = slv1_arsize;
        wire nds_unused_slv1_aruser = slv1_aruser;
        wire nds_unused_slv1_arvalid = slv1_arvalid;
        wire [(BIU_ADDR_WIDTH - 1):0] nds_unused_slv1_awaddr = slv1_awaddr;
        wire [1:0] nds_unused_slv1_awburst = slv1_awburst;
        wire [3:0] nds_unused_slv1_awcache = slv1_awcache;
        wire [(SLAVE_PORT_ID_WIDTH - 1):0] nds_unused_slv1_awid = slv1_awid;
        wire [7:0] nds_unused_slv1_awlen = slv1_awlen;
        wire nds_unused_slv1_awlock = slv1_awlock;
        wire [2:0] nds_unused_slv1_awprot = slv1_awprot;
        wire [2:0] nds_unused_slv1_awsize = slv1_awsize;
        wire nds_unused_slv1_awuser = slv1_awuser;
        wire nds_unused_slv1_awvalid = slv1_awvalid;
        wire nds_unused_slv1_bready = slv1_bready;
        wire nds_unused_slv1_rready = slv1_rready;
        wire [(SLAVE_PORT_DATA_WIDTH - 1):0] nds_unused_slv1_wdata = slv1_wdata;
        wire nds_unused_slv1_wlast = slv1_wlast;
        wire [((SLAVE_PORT_DATA_WIDTH / 8) - 1):0] nds_unused_slv1_wstrb = slv1_wstrb;
        wire nds_unused_slv1_wvalid = slv1_wvalid;
        wire [(BIU_ADDR_WIDTH - 1):0] nds_unused_slv_araddr = slv_araddr;
        wire [1:0] nds_unused_slv_arburst = slv_arburst;
        wire [3:0] nds_unused_slv_arcache = slv_arcache;
        wire [(SLAVE_PORT_ID_WIDTH - 1):0] nds_unused_slv_arid = slv_arid;
        wire [7:0] nds_unused_slv_arlen = slv_arlen;
        wire nds_unused_slv_arlock = slv_arlock;
        wire [2:0] nds_unused_slv_arprot = slv_arprot;
        wire [2:0] nds_unused_slv_arsize = slv_arsize;
        wire nds_unused_slv_aruser = slv_aruser;
        wire nds_unused_slv_arvalid = slv_arvalid;
        wire [(BIU_ADDR_WIDTH - 1):0] nds_unused_slv_awaddr = slv_awaddr;
        wire [1:0] nds_unused_slv_awburst = slv_awburst;
        wire [3:0] nds_unused_slv_awcache = slv_awcache;
        wire [(SLAVE_PORT_ID_WIDTH - 1):0] nds_unused_slv_awid = slv_awid;
        wire [7:0] nds_unused_slv_awlen = slv_awlen;
        wire nds_unused_slv_awlock = slv_awlock;
        wire [2:0] nds_unused_slv_awprot = slv_awprot;
        wire [2:0] nds_unused_slv_awsize = slv_awsize;
        wire nds_unused_slv_awuser = slv_awuser;
        wire nds_unused_slv_awvalid = slv_awvalid;
        wire nds_unused_slv_bready = slv_bready;
        wire nds_unused_slv_rready = slv_rready;
        wire [(SLAVE_PORT_DATA_WIDTH - 1):0] nds_unused_slv_wdata = slv_wdata;
        wire nds_unused_slv_wlast = slv_wlast;
        wire [((SLAVE_PORT_DATA_WIDTH / 8) - 1):0] nds_unused_slv_wstrb = slv_wstrb;
        wire nds_unused_slv_wvalid = slv_wvalid;
        wire nds_unused_slv1_clk_en = slv1_clk_en;
        wire nds_unused_slv_clk_en = slv_clk_en;
        wire nds_unused_slv1_reset_n_int = slv1_reset_n_int;
        wire nds_unused_slv_reset_n_int = slv_reset_n_int;
        wire nds_unused_slv_ilm_a_ready = slv_ilm_a_ready;
        wire [63:0] nds_unused_slv_ilm_d_data = slv_ilm_d_data;
        wire [13:0] nds_unused_slv_ilm_d_status = slv_ilm_d_status;
        wire [2:0] nds_unused_slv_ilm_d_user = slv_ilm_d_user;
        wire nds_unused_slv_ilm_d_valid = slv_ilm_d_valid;
        wire nds_unused_slv_ilm_w_ready = slv_ilm_w_ready;
        wire nds_unused_slv_dlm0_a_ready = slv_dlm0_a_ready;
        wire [31:0] nds_unused_slv_dlm0_d_data = slv_dlm0_d_data;
        wire [13:0] nds_unused_slv_dlm0_d_status = slv_dlm0_d_status;
        wire [0:0] nds_unused_slv_dlm0_d_user = slv_dlm0_d_user;
        wire nds_unused_slv_dlm0_d_valid = slv_dlm0_d_valid;
        wire nds_unused_slv_dlm0_w_ready = slv_dlm0_w_ready;
        wire nds_unused_slv_dlm1_a_ready = slv_dlm1_a_ready;
        wire [31:0] nds_unused_slv_dlm1_d_data = slv_dlm1_d_data;
        wire [13:0] nds_unused_slv_dlm1_d_status = slv_dlm1_d_status;
        wire [0:0] nds_unused_slv_dlm1_d_user = slv_dlm1_d_user;
        wire nds_unused_slv_dlm1_d_valid = slv_dlm1_d_valid;
        wire nds_unused_slv_dlm1_w_ready = slv_dlm1_w_ready;
        wire nds_unused_slv_dlm2_a_ready = slv_dlm2_a_ready;
        wire [31:0] nds_unused_slv_dlm2_d_data = slv_dlm2_d_data;
        wire [13:0] nds_unused_slv_dlm2_d_status = slv_dlm2_d_status;
        wire [0:0] nds_unused_slv_dlm2_d_user = slv_dlm2_d_user;
        wire nds_unused_slv_dlm2_d_valid = slv_dlm2_d_valid;
        wire nds_unused_slv_dlm2_w_ready = slv_dlm2_w_ready;
        wire nds_unused_slv_dlm3_a_ready = slv_dlm3_a_ready;
        wire [31:0] nds_unused_slv_dlm3_d_data = slv_dlm3_d_data;
        wire [13:0] nds_unused_slv_dlm3_d_status = slv_dlm3_d_status;
        wire [0:0] nds_unused_slv_dlm3_d_user = slv_dlm3_d_user;
        wire nds_unused_slv_dlm3_d_valid = slv_dlm3_d_valid;
        wire nds_unused_slv_dlm3_w_ready = slv_dlm3_w_ready;
    end
endgenerate
kv_ipipe #(
    .ACE_LS_SUPPORT_INT(ACE_LS_SUPPORT_INT),
    .ACE_SUPPORT_INT(ACE_SUPPORT_INT),
    .BFLOAT16_SUPPORT_INT(BFLOAT16_SUPPORT_INT),
    .BRANCH_PREDICTION_INT(4),
    .BTB_SIZE(BTB_SIZE),
    .CACHE_LINE_SIZE(CACHE_LINE_SIZE),
    .CAUSE_LEN(CAUSE_LEN),
    .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT),
    .DCACHE_SIZE_KB(DCACHE_SIZE_KB),
    .DEBUG_SUPPORT_INT(DEBUG_SUPPORT_INT),
    .DEBUG_VEC(DEBUG_VEC),
    .DLM_AMSB(DLM_AMSB),
    .DLM_BASE(DLM_BASE),
    .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .DSP_SUPPORT_INT(DSP_SUPPORT_INT),
    .EXTVALEN(EXTVALEN),
    .FLEN(FLEN),
    .FP16_SUPPORT_INT(FP16_SUPPORT_INT),
    .HAS_VPU_INT(HAS_VPU_INT),
    .ICACHE_ECC_TYPE_INT(ICACHE_ECC_TYPE_INT),
    .ICACHE_SIZE_KB(ICACHE_SIZE_KB),
    .ILM_AMSB(ILM_AMSB),
    .ILM_BASE(ILM_BASE),
    .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .ISA_BBZ_INT(ISA_BBZ_INT),
    .ISA_BEQC_INT(ISA_BEQC_INT),
    .ISA_BFO_INT(ISA_BFO_INT),
    .ISA_GP_INT(ISA_GP_INT),
    .ISA_LEA_INT(ISA_LEA_INT),
    .ISA_STR_INT(ISA_STR_INT),
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .MMU_SCHEME_INT(MMU_SCHEME_INT),
    .MULTIPLIER_INT(MULTIPLIER_INT),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .PALEN(PALEN),
    .PERFORMANCE_MONITOR_INT(PERFORMANCE_MONITOR_INT),
    .PMA_ENTRIES(PMA_ENTRIES),
    .POWERBRAKE_SUPPORT_INT(POWERBRAKE_SUPPORT_INT),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT),
    .RVN_SUPPORT_INT(RVN_SUPPORT_INT),
    .STACKSAFE_SUPPORT_INT(STACKSAFE_SUPPORT_INT),
    .STATIC_BRANCH_PREDICTION_INT(STATIC_BRANCH_PREDICTION_INT),
    .STLB_ECC_TYPE(STLB_ECC_TYPE),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .UNALIGNED_ACCESS_INT(UNALIGNED_ACCESS_INT),
    .VALEN(VALEN),
    .VECTOR_PLIC_SUPPORT_INT(VECTOR_PLIC_SUPPORT_INT)
) kv_ipipe (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .hart_halted(hart_halted),
    .biu_ipipe_standby_ready(biu_ipipe_standby_ready),
    .ifu_ipipe_standby_ready(ifu_ipipe_standby_ready),
    .mmu_ipipe_standby_ready(mmu_ipipe_standby_ready),
    .fpu_ipipe_standby_ready(fpu_ipipe_standby_ready),
    .fpu_ipipe_fdiv_standby_ready(fpu_ipipe_fdiv_standby_ready),
    .core_wfi_mode(core_wfi_mode),
    .wfi_enabled(wfi_enabled),
    .csr_vstart(csr_vstart),
    .csr_vtype(csr_vtype),
    .csr_vl(csr_vl),
    .ls_privilege_m(ls_privilege_m),
    .ls_privilege_s(ls_privilege_s),
    .ls_privilege_u(ls_privilege_u),
    .ipipe_ifu_stall(ipipe_ifu_stall),
    .ifu_ipipe_init_done(ifu_ipipe_init_done),
    .ifu_i0_valid(ifu_i0_valid),
    .ifu_i0_pc(ifu_i0_pc),
    .ifu_i0_instr(ifu_i0_instr),
    .ifu_i0_vector_resume(ifu_i0_vector_resume),
    .ifu_i0_instr_16b(ifu_i0_instr_16b),
    .ifu_i0_pred_valid(ifu_i0_pred_valid),
    .ifu_i0_pred_hit(ifu_i0_pred_hit),
    .ifu_i0_pred_way(ifu_i0_pred_way),
    .ifu_i0_pred_taken(ifu_i0_pred_taken),
    .ifu_i0_pred_ret(ifu_i0_pred_ret),
    .ifu_i0_pred_bogus(ifu_i0_pred_bogus),
    .ifu_i0_pred_cnt(ifu_i0_pred_cnt),
    .ifu_i0_pred_start(ifu_i0_pred_start),
    .ifu_i0_pred_brk(ifu_i0_pred_brk),
    .ifu_i0_keep_bhr(ifu_i0_keep_bhr),
    .ifu_i0_pred_npc(ifu_i0_pred_npc),
    .ifu_i0_fault(ifu_i0_fault),
    .ifu_i0_fault_dcause(ifu_i0_fault_dcause),
    .ifu_i0_page_fault(ifu_i0_page_fault),
    .ifu_i0_fault_upper(ifu_i0_fault_upper),
    .ifu_i0_ecc_corr(ifu_i0_ecc_corr),
    .ifu_i0_ecc_code(ifu_i0_ecc_code),
    .ifu_i0_ecc_ramid(ifu_i0_ecc_ramid),
    .ifu_i0_ready(ifu_i0_ready),
    .ifu_i1_valid(ifu_i1_valid),
    .ifu_i1_pc(ifu_i1_pc),
    .ifu_i1_instr(ifu_i1_instr),
    .ifu_i1_vector_resume(ifu_i1_vector_resume),
    .ifu_i1_instr_16b(ifu_i1_instr_16b),
    .ifu_i1_pred_valid(ifu_i1_pred_valid),
    .ifu_i1_pred_hit(ifu_i1_pred_hit),
    .ifu_i1_pred_way(ifu_i1_pred_way),
    .ifu_i1_pred_taken(ifu_i1_pred_taken),
    .ifu_i1_pred_ret(ifu_i1_pred_ret),
    .ifu_i1_pred_bogus(ifu_i1_pred_bogus),
    .ifu_i1_pred_cnt(ifu_i1_pred_cnt),
    .ifu_i1_keep_bhr(ifu_i1_keep_bhr),
    .ifu_i1_pred_npc(ifu_i1_pred_npc),
    .ifu_i1_pred_start(ifu_i1_pred_start),
    .ifu_i1_pred_brk(ifu_i1_pred_brk),
    .ifu_i1_fault(ifu_i1_fault),
    .ifu_i1_fault_dcause(ifu_i1_fault_dcause),
    .ifu_i1_page_fault(ifu_i1_page_fault),
    .ifu_i1_fault_upper(ifu_i1_fault_upper),
    .ifu_i1_ecc_corr(ifu_i1_ecc_corr),
    .ifu_i1_ecc_code(ifu_i1_ecc_code),
    .ifu_i1_ecc_ramid(ifu_i1_ecc_ramid),
    .ifu_i1_ready(ifu_i1_ready),
    .fpu_i0_ctrl(fpu_i0_ctrl),
    .fpu_i0_valid(fpu_i0_valid),
    .fpu_i0_frs1(fpu_i0_frs1),
    .fpu_i0_frs2(fpu_i0_frs2),
    .fpu_i0_frs3(fpu_i0_frs3),
    .fpu_i1_ctrl(fpu_i1_ctrl),
    .fpu_i1_valid(fpu_i1_valid),
    .fpu_i1_frs1(fpu_i1_frs1),
    .fpu_i1_frs2(fpu_i1_frs2),
    .fpu_i1_frs3(fpu_i1_frs3),
    .fpu_lx_stall(fpu_lx_stall),
    .fpu_fmis_result(fpu_fmis_result),
    .fmis_flag_set(fmis_flag_set),
    .fpu_fmv_result(fpu_fmv_result),
    .fpu_fmac32_result(fpu_fmac32_result),
    .fpu_fmac64_result(fpu_fmac64_result),
    .fmac_flag_set(fmac_flag_set),
    .redirect(redirect),
    .redirect_for_cti(redirect_for_cti),
    .redirect_pc(redirect_pc),
    .redirect_pc_hit_ilm(redirect_pc_hit_ilm),
    .redirect_ras_ptr(redirect_ras_ptr),
    .retry(retry),
    .retry_pc(retry_pc),
    .btb_flush_ready(btb_flush_ready),
    .btb_flush_valid(btb_flush_valid),
    .btb_update_p0(btb_update_p0),
    .btb_update_p0_way(btb_update_p0_way),
    .btb_update_p0_blk_offset(btb_update_p0_blk_offset),
    .btb_update_p0_alloc(btb_update_p0_alloc),
    .btb_update_p0_start_pc(btb_update_p0_start_pc),
    .btb_update_p0_target_pc(btb_update_p0_target_pc),
    .btb_update_p0_ucond(btb_update_p0_ucond),
    .btb_update_p0_call(btb_update_p0_call),
    .btb_update_p0_ret(btb_update_p0_ret),
    .btb_update_p0_hold(btb_update_p0_hold),
    .btb_update_p1(btb_update_p1),
    .btb_update_p1_way(btb_update_p1_way),
    .btb_update_p1_blk_offset(btb_update_p1_blk_offset),
    .btb_update_p1_alloc(btb_update_p1_alloc),
    .btb_update_p1_start_pc(btb_update_p1_start_pc),
    .btb_update_p1_target_pc(btb_update_p1_target_pc),
    .btb_update_p1_ucond(btb_update_p1_ucond),
    .btb_update_p1_call(btb_update_p1_call),
    .btb_update_p1_ret(btb_update_p1_ret),
    .btb_update_p1_hold(btb_update_p1_hold),
    .bhr_recover(bhr_recover),
    .bhr_recover_data(bhr_recover_data),
    .bht_update_p0(bht_update_p0),
    .bht_update_p0_dir_addr(bht_update_p0_dir_addr),
    .bht_update_p0_sel_addr(bht_update_p0_sel_addr),
    .bht_update_p0_sel_data(bht_update_p0_sel_data),
    .bht_update_p0_dir_data(bht_update_p0_dir_data),
    .bht_update_p1(bht_update_p1),
    .bht_update_p1_dir_addr(bht_update_p1_dir_addr),
    .bht_update_p1_sel_addr(bht_update_p1_sel_addr),
    .bht_update_p1_sel_data(bht_update_p1_sel_data),
    .bht_update_p1_dir_data(bht_update_p1_dir_data),
    .rf_sdw_recover(rf_sdw_recover),
    .rf_raddr1(rf_raddr1),
    .rf_raddr2(rf_raddr2),
    .rf_raddr3(rf_raddr3),
    .rf_raddr4(rf_raddr4),
    .rf_rdata1(rf_rdata1),
    .rf_rdata2(rf_rdata2),
    .rf_rdata3(rf_rdata3),
    .rf_rdata4(rf_rdata4),
    .rf_we1(rf_we1),
    .rf_waddr1(rf_waddr1),
    .rf_wdata1(rf_wdata1),
    .rf_wstatus1(rf_wstatus1),
    .rf_we2(rf_we2),
    .rf_waddr2(rf_waddr2),
    .rf_wdata2(rf_wdata2),
    .rf_wstatus2(rf_wstatus2),
    .rf_we3(rf_we3),
    .rf_waddr3(rf_waddr3),
    .rf_wdata3(rf_wdata3),
    .rf_wstatus3(rf_wstatus3),
    .frf_raddr1(frf_raddr1),
    .frf_raddr2(frf_raddr2),
    .frf_raddr3(frf_raddr3),
    .frf_raddr4(frf_raddr4),
    .frf_rdata1(frf_rdata1),
    .frf_rdata2(frf_rdata2),
    .frf_rdata3(frf_rdata3),
    .frf_rdata4(frf_rdata4),
    .frf_we1(frf_we1),
    .frf_waddr1(frf_waddr1),
    .frf_wdata1(frf_wdata1),
    .frf_wstatus1(frf_wstatus1),
    .frf_we2(frf_we2),
    .frf_waddr2(frf_waddr2),
    .frf_wdata2(frf_wdata2),
    .frf_wstatus2(frf_wstatus2),
    .frf_we3(frf_we3),
    .frf_waddr3(frf_waddr3),
    .frf_wdata3(frf_wdata3),
    .frf_wstatus3(frf_wstatus3),
    .alu0_func(alu0_func),
    .alu0_op0(alu0_op0),
    .alu0_op1(alu0_op1),
    .alu0_result(alu0_result),
    .alu0_aresult(alu0_aresult),
    .alu0_bresult(alu0_bresult),
    .alu1_func(alu1_func),
    .alu1_op0(alu1_op0),
    .alu1_op1(alu1_op1),
    .alu1_bop0(alu1_bop0),
    .alu1_bop1(alu1_bop1),
    .alu1_result(alu1_result),
    .alu2_func(alu2_func),
    .alu2_op0(alu2_op0),
    .alu2_op1(alu2_op1),
    .alu2_result(alu2_result),
    .alu3_func(alu3_func),
    .alu3_op0(alu3_op0),
    .alu3_op1(alu3_op1),
    .alu3_bop0(alu3_bop0),
    .alu3_bop1(alu3_bop1),
    .alu3_result(alu3_result),
    .bru0_pc(bru0_pc),
    .bru0_op0(bru0_op0),
    .bru0_op1(bru0_op1),
    .bru0_fn(bru0_fn),
    .bru0_offset(bru0_offset),
    .bru0_type(bru0_type),
    .bru0_pred_info(bru0_pred_info),
    .bru0_pred_npc(bru0_pred_npc),
    .bru0_target(bru0_target),
    .bru0_seq_npc(bru0_seq_npc),
    .bru0_reso_info(bru0_reso_info),
    .bru1_pc(bru1_pc),
    .bru1_op0(bru1_op0),
    .bru1_op1(bru1_op1),
    .bru1_bop0(bru1_bop0),
    .bru1_bop1(bru1_bop1),
    .bru1_fn(bru1_fn),
    .bru1_offset(bru1_offset),
    .bru1_type(bru1_type),
    .bru1_pred_info(bru1_pred_info),
    .bru1_pred_npc(bru1_pred_npc),
    .bru1_target(bru1_target),
    .bru1_seq_npc(bru1_seq_npc),
    .bru1_reso_info(bru1_reso_info),
    .bru2_pc(bru2_pc),
    .bru2_op0(bru2_op0),
    .bru2_op1(bru2_op1),
    .bru2_fn(bru2_fn),
    .bru2_offset(bru2_offset),
    .bru2_type(bru2_type),
    .bru2_pred_info(bru2_pred_info),
    .bru2_pred_npc(bru2_pred_npc),
    .bru2_target(bru2_target),
    .bru2_seq_npc(bru2_seq_npc),
    .bru2_reso_info(bru2_reso_info),
    .bru3_pc(bru3_pc),
    .bru3_op0(bru3_op0),
    .bru3_op1(bru3_op1),
    .bru3_bop0(bru3_bop0),
    .bru3_bop1(bru3_bop1),
    .bru3_fn(bru3_fn),
    .bru3_offset(bru3_offset),
    .bru3_type(bru3_type),
    .bru3_pred_info(bru3_pred_info),
    .bru3_pred_npc(bru3_pred_npc),
    .bru3_target(bru3_target),
    .bru3_seq_npc(bru3_seq_npc),
    .bru3_reso_info(bru3_reso_info),
    .mdu_kill(mdu_kill),
    .mdu_req_valid(mdu_req_valid),
    .mdu_req_tag(mdu_req_tag),
    .mdu_req_func(mdu_req_func),
    .mdu_req_op0(mdu_req_op0),
    .mdu_req_op1(mdu_req_op1),
    .mdu_req_ready(mdu_req_ready),
    .mdu_resp_valid(mdu_resp_valid),
    .mdu_resp_tag(mdu_resp_tag),
    .mdu_resp_result(mdu_resp_result),
    .mdu_resp_ready(mdu_resp_ready),
    .ex9_lookup_valid(ex9_lookup_valid),
    .ex9_lookup_ready(ex9_lookup_ready),
    .ex9_lookup_pc(ex9_lookup_pc),
    .ex9_lookup_resp_valid(ex9_lookup_resp_valid),
    .ex9_lookup_resp_ready(ex9_lookup_resp_ready),
    .ex9_lookup_resp_instr(ex9_lookup_resp_instr),
    .ex9_lookup_resp_fault(ex9_lookup_resp_fault),
    .ex9_lookup_resp_fault_dcause(ex9_lookup_resp_fault_dcause),
    .ex9_lookup_resp_page_fault(ex9_lookup_resp_page_fault),
    .ex9_lookup_resp_ecc_corr(ex9_lookup_resp_ecc_corr),
    .ex9_lookup_resp_ecc_code(ex9_lookup_resp_ecc_code),
    .ex9_lookup_resp_ecc_ramid(ex9_lookup_resp_ecc_ramid),
    .async_valid(async_valid),
    .async_ready(async_ready),
    .wfi_done(wfi_done),
    .itrigger_fire(itrigger_fire),
    .etrigger_fire(etrigger_fire),
    .ii_i0_trace_stall(ii_i0_trace_stall),
    .wb_i0_alive(wb_i0_alive),
    .wb_i1_alive(wb_i1_alive),
    .wb_i0_seg_end(wb_i0_seg_end),
    .wb_i1_seg_end(wb_i1_seg_end),
    .wb_i0_retire(wb_i0_retire),
    .wb_i1_retire(wb_i1_retire),
    .wb_i0_pc(wb_i0_pc),
    .wb_i1_pc(wb_i1_pc),
    .wb_i0_npc(wb_i0_npc),
    .wb_i1_npc(wb_i1_npc),
    .wb_i0_tval(wb_i0_tval),
    .wb_i1_tval(wb_i1_tval),
    .wb_i0_ctrl(wb_i0_ctrl),
    .wb_i1_ctrl(wb_i1_ctrl),
    .wb_i0_instr(wb_i0_instr),
    .wb_i1_instr(wb_i1_instr),
    .wb_i0_reso_info(wb_i0_reso_info),
    .wb_i1_reso_info(wb_i1_reso_info),
    .wb_i0_16b(wb_i0_16b),
    .wb_i1_16b(wb_i1_16b),
    .wb_i0_trace_trigger(wb_i0_trace_trigger),
    .wb_i1_trace_trigger(wb_i1_trace_trigger),
    .wb_ls_ecc_code(wb_ls_ecc_code),
    .wb_ls_ecc_corr(wb_ls_ecc_corr),
    .wb_ls_ecc_ramid(wb_ls_ecc_ramid),
    .resume(resume),
    .resume_for_replay(resume_for_replay),
    .resume_pc(resume_pc),
    .resume_vectored(resume_vectored),
    .wb_i0_resume(wb_i0_resume),
    .wb_i1_resume(wb_i1_resume),
    .wb_postsync_resume(wb_postsync_resume),
    .ls_standby_ready(ls_standby_ready),
    .ls_issue_ready(ls_issue_ready),
    .ls_req_valid(ls_req_valid),
    .ls_req_pc(ls_req_pc),
    .ls_req_stall(ls_req_stall),
    .ls_req_base0(ls_req_base0),
    .ls_req_base1(ls_req_base1),
    .ls_req_base_bypass(ls_req_base_bypass),
    .ls_req_offset(ls_req_offset),
    .ls_req_asid(ls_req_asid),
    .ls_req_func(ls_req_func),
    .ls_resp_valid(ls_resp_valid),
    .ls_resp_result(ls_resp_result),
    .ls_resp_bresult(ls_resp_bresult),
    .ls_resp_status(ls_resp_status),
    .ls_resp_fault_addr(ls_resp_fault_addr),
    .ls_resp_result_64b(ls_resp_result_64b),
    .ls_cmt_valid(ls_cmt_valid),
    .ls_cmt_kill(ls_cmt_kill),
    .ls_cmt_wdata_sel_vpu(ls_cmt_wdata_sel_vpu),
    .ls_cmt_wdata_base(ls_cmt_wdata_base),
    .ls_cmt_wdata_vpu(ls_cmt_wdata_vpu),
    .ls_una_wait(ls_una_wait),
    .nbload_resp_valid(nbload_resp_valid),
    .nbload_resp_rd(nbload_resp_rd),
    .nbload_resp_result(nbload_resp_result),
    .nbload_resp_status(nbload_resp_status),
    .vpu_srf_wvalid(vpu_srf_wvalid),
    .vpu_srf_wready(vpu_srf_wready),
    .vpu_srf_wfrf(vpu_srf_wfrf),
    .vpu_srf_waddr(vpu_srf_waddr),
    .vpu_srf_wdata(vpu_srf_wdata),
    .csr_mmisc_ctl_aces(csr_mmisc_ctl_aces),
    .ipipe_csr_req_wr_valid(ipipe_csr_req_wr_valid),
    .ipipe_csr_req_rd_valid(ipipe_csr_req_rd_valid),
    .ipipe_csr_req_read_only(ipipe_csr_req_read_only),
    .ipipe_csr_req_mrandstate(ipipe_csr_req_mrandstate),
    .ipipe_csr_req_func(ipipe_csr_req_func),
    .ipipe_csr_req_waddr(ipipe_csr_req_waddr),
    .ipipe_csr_req_raddr(ipipe_csr_req_raddr),
    .ipipe_csr_req_wdata(ipipe_csr_req_wdata),
    .csr_mhsp_bound(csr_mhsp_bound),
    .csr_mhsp_base(csr_mhsp_base),
    .csr_mhsp_ctl_ovf_en(csr_mhsp_ctl_ovf_en),
    .csr_mhsp_ctl_udf_en(csr_mhsp_ctl_udf_en),
    .csr_mhsp_ctl_schm(csr_mhsp_ctl_schm),
    .csr_mhsp_ctl_u(csr_mhsp_ctl_u),
    .csr_mhsp_ctl_s(csr_mhsp_ctl_s),
    .csr_mhsp_ctl_m(csr_mhsp_ctl_m),
    .ipipe_csr_mhsp_bound_wdata(ipipe_csr_mhsp_bound_wdata),
    .ipipe_csr_mhsp_bound_wen(ipipe_csr_mhsp_bound_wen),
    .ipipe_csr_hsp_xcpt(ipipe_csr_hsp_xcpt),
    .ipipe_csr_vtype_we(ipipe_csr_vtype_we),
    .ipipe_csr_vtype_wdata(ipipe_csr_vtype_wdata),
    .ipipe_csr_vl_we(ipipe_csr_vl_we),
    .ipipe_csr_vl_wdata(ipipe_csr_vl_wdata),
    .csr_uitb(csr_uitb),
    .csr_t_level(csr_t_level),
    .csr_pft_en(csr_pft_en),
    .csr_ipipe_resp_rdata(csr_ipipe_resp_rdata),
    .csr_ipipe_rmw_rdata(csr_ipipe_rmw_rdata),
    .csr_mcache_ctl_cctl_suen(csr_mcache_ctl_cctl_suen),
    .csr_mstatus_tw(csr_mstatus_tw),
    .csr_mstatus_tvm(csr_mstatus_tvm),
    .csr_mstatus_tsr(csr_mstatus_tsr),
    .csr_cur_privilege(csr_cur_privilege),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_halt_mode(csr_halt_mode),
    .csr_dcsr_step(csr_dcsr_step),
    .csr_dcsr_ebreakm(csr_dcsr_ebreakm),
    .csr_dcsr_ebreaks(csr_dcsr_ebreaks),
    .csr_dcsr_ebreaku(csr_dcsr_ebreaku),
    .csr_ls_translate_en(csr_ls_translate_en),
    .csr_mcounteren(csr_mcounteren),
    .csr_mcounterwen(csr_mcounterwen),
    .csr_scounteren(csr_scounteren),
    .csr_frm(csr_frm),
    .csr_mtvec(csr_mtvec),
    .csr_stvec(csr_stvec),
    .csr_utvec(csr_utvec),
    .csr_mstatus_fs(csr_mstatus_fs),
    .csr_mmisc_ctl_rvcompm(csr_mmisc_ctl_rvcompm),
    .csr_mmisc_ctl_brpe(csr_mmisc_ctl_brpe),
    .csr_mmisc_ctl_nbcache_en(csr_mmisc_ctl_nbcache_en),
    .fmul_req(fmul_req),
    .fmul_func(fmul_func),
    .fmul_op0(fmul_op0),
    .fmul_op1(fmul_op1),
    .fmul_stall(fmul_stall),
    .fmul_result(fmul_result),
    .trigm_i0_pc(trigm_i0_pc),
    .trigm_i1_pc(trigm_i1_pc),
    .trigm_i0_result(trigm_i0_result),
    .trigm_i1_result(trigm_i1_result),
    .trigm_icount_result(trigm_icount_result),
    .trigm_icount_enabled(trigm_icount_enabled),
    .ipipe_csr_fflags_set(ipipe_csr_fflags_set),
    .ipipe_csr_ucode_ov_set(ipipe_csr_ucode_ov_set),
    .ipipe_csr_fs_wen(ipipe_csr_fs_wen),
    .dsp_instr_valid(dsp_instr_valid),
    .dsp_operand_ctrl(dsp_operand_ctrl),
    .dsp_function_ctrl(dsp_function_ctrl),
    .dsp_result_ctrl(dsp_result_ctrl),
    .dsp_overflow_ctrl(dsp_overflow_ctrl),
    .dsp_data_src1(dsp_data_src1),
    .dsp_data_src2(dsp_data_src2),
    .dsp_data_src3(dsp_data_src3),
    .dsp_data_src4(dsp_data_src4),
    .dsp_stage2_pipe_en(dsp_stage2_pipe_en),
    .dsp_stage3_pipe_en(dsp_stage3_pipe_en),
    .dsp_stage1_result(dsp_stage1_result),
    .dsp_stage1_ovf_set(dsp_stage1_ovf_set),
    .dsp_stage2_result(dsp_stage2_result),
    .dsp_stage2_ovf_set(dsp_stage2_ovf_set),
    .dsp_stage3_result(dsp_stage3_result),
    .dsp_stage3_ovf_set(dsp_stage3_ovf_set),
    .vsetvl_op0(vsetvl_op0),
    .vsetvl_op1(vsetvl_op1),
    .vsetvl_result(vsetvl_result),
    .vsetvl_vtype(vsetvl_vtype),
    .ace_cmd_valid(ace_cmd_valid),
    .ace_cmd_inst(ace_cmd_inst),
    .ace_cmd_pc(ace_cmd_pc),
    .ace_cmd_rs1(ace_cmd_rs1),
    .ace_cmd_rs2(ace_cmd_rs2),
    .ace_cmd_rs3(ace_cmd_rs3),
    .ace_cmd_rs4(ace_cmd_rs4),
    .ace_cmd_ready(ace_cmd_ready),
    .ace_cmd_priv(ace_cmd_priv),
    .ace_cmd_beat(ace_cmd_beat),
    .ace_cmd_vl(ace_cmd_vl),
    .ace_cmd_vtype(ace_cmd_vtype),
    .ace_cmd_hartid(ace_cmd_hartid),
    .ace_sync_req(ace_sync_req),
    .ace_sync_type(ace_sync_type),
    .ace_interrupt(ace_interrupt),
    .ace_sync_ack(ace_sync_ack),
    .ace_sync_ack_status(ace_sync_ack_status),
    .ace_error(ace_error),
    .ace_standby_ready(ace_standby_ready),
    .ace_xrf_rd1_ready(ace_xrf_rd1_ready),
    .ace_xrf_rd1_valid(ace_xrf_rd1_valid),
    .ace_xrf_rd1_index(ace_xrf_rd1_index),
    .ace_xrf_rd1_data(ace_xrf_rd1_data),
    .ace_xrf_rd1_status(ace_xrf_rd1_status),
    .ace_xrf_rd2_ready(ace_xrf_rd2_ready),
    .ace_xrf_rd2_valid(ace_xrf_rd2_valid),
    .ace_xrf_rd2_index(ace_xrf_rd2_index),
    .ace_xrf_rd2_data(ace_xrf_rd2_data),
    .ace_xrf_rd2_status(ace_xrf_rd2_status),
    .fdiv_req_ready(fdiv_req_ready),
    .fdiv_resp_tag(fdiv_resp_tag),
    .fdiv_resp_flag_set(fdiv_resp_flag_set),
    .fdiv_resp_result(fdiv_resp_result),
    .fdiv_resp_valid(fdiv_resp_valid),
    .fdiv_resp_ready(fdiv_resp_ready),
    .fdiv_kill(fdiv_kill),
    .vpu_viq_size(vpu_viq_size),
    .vpu_req_valid(vpu_req_valid),
    .vpu_req_vtype(vpu_req_vtype),
    .vpu_req_vstart(vpu_req_vstart),
    .vpu_req_vl(vpu_req_vl),
    .vpu_req_ls_privilege(vpu_req_ls_privilege),
    .vpu_req_i0_ctrl(vpu_req_i0_ctrl),
    .vpu_req_i0_instr(vpu_req_i0_instr),
    .vpu_req_i0_op1(vpu_req_i0_op1),
    .vpu_req_i0_op2(vpu_req_i0_op2),
    .vpu_req_i1_ctrl(vpu_req_i1_ctrl),
    .vpu_req_i1_instr(vpu_req_i1_instr),
    .vpu_req_i1_op1(vpu_req_i1_op1),
    .vpu_req_i1_op2(vpu_req_i1_op2),
    .vpu_vtlb_flush(vpu_vtlb_flush),
    .vpu_cmt_valid(vpu_cmt_valid),
    .vpu_cmt_kill(vpu_cmt_kill),
    .vpu_cmt_i0_op1(vpu_cmt_i0_op1),
    .vpu_cmt_i1_op1(vpu_cmt_i1_op1),
    .vpu_ack_valid(vpu_ack_valid),
    .vpu_ack_status(vpu_ack_status),
    .ipipe_event(ipipe_event)
);
kv_lsu #(
    .CLUSTER_SUPPORT_INT(CLUSTER_SUPPORT_INT),
    .DCACHE_PREFETCH_SUPPORT_INT(DCACHE_PREFETCH_SUPPORT_INT),
    .DLM_AMSB(DLM_AMSB),
    .DLM_BASE(DLM_BASE),
    .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
    .DLM_RAM_DW(DLM_RAM_DW),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .EXTVALEN(EXTVALEN),
    .FLEN(FLEN),
    .ILM_AMSB(ILM_AMSB),
    .ILM_BASE(ILM_BASE),
    .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
    .ILM_RAM_DW(ILM_RAM_DW),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .L2_ADDR_WIDTH(L2_ADDR_WIDTH),
    .L2_DATA_WIDTH(L2_DATA_WIDTH),
    .MMU_SCHEME_INT(MMU_SCHEME_INT),
    .NUM_DLM_BANKS(NUM_DLM_BANKS),
    .PALEN(PALEN),
    .PERFORMANCE_MONITOR_INT(PERFORMANCE_MONITOR_INT),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT),
    .TL_SINK_WIDTH(TL_SINK_WIDTH),
    .UNALIGNED_ACCESS_INT(UNALIGNED_ACCESS_INT),
    .VALEN(VALEN)
) kv_lsu (
    .dptw_mmu_req_ready(dptw_mmu_req_ready),
    .dptw_mmu_resp_data(dptw_mmu_resp_data),
    .dptw_mmu_resp_status(dptw_mmu_resp_status),
    .dptw_mmu_resp_valid(dptw_mmu_resp_valid),
    .mmu_dptw_req_pa(mmu_dptw_req_pa),
    .mmu_dptw_req_valid(mmu_dptw_req_valid),
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .iptw_mmu_req_ready(iptw_mmu_req_ready),
    .iptw_mmu_resp_data(iptw_mmu_resp_data),
    .iptw_mmu_resp_status(iptw_mmu_resp_status),
    .iptw_mmu_resp_valid(iptw_mmu_resp_valid),
    .mmu_iptw_req_pa(mmu_iptw_req_pa),
    .mmu_iptw_req_valid(mmu_iptw_req_valid),
    .csr_ls_translate_en(csr_ls_translate_en),
    .csr_mdlmb_eccen(csr_mdlmb_eccen),
    .csr_mdlmb_rwecc(csr_mdlmb_rwecc),
    .csr_milmb_eccen(csr_milmb_eccen),
    .csr_milmb_rwecc(csr_milmb_rwecc),
    .csr_mmisc_ctl_una(csr_mmisc_ctl_una),
    .csr_mxstatus_dme(csr_mxstatus_dme),
    .csr_satp_mode(csr_satp_mode),
    .dcu_ack_id(dcu_ack_id),
    .dcu_ack_rdata(dcu_ack_rdata),
    .dcu_ack_status(dcu_ack_status),
    .dcu_ack_valid(dcu_ack_valid),
    .dcu_cmt_addr(dcu_cmt_addr),
    .dcu_cmt_func(dcu_cmt_func),
    .dcu_cmt_valid(dcu_cmt_valid),
    .dcu_cmt_wdata(dcu_cmt_wdata),
    .dcu_cmt_wmask(dcu_cmt_wmask),
    .dcu_cri_id(dcu_cri_id),
    .dcu_cri_nbload_result(dcu_cri_nbload_result),
    .dcu_cri_rdata(dcu_cri_rdata),
    .dcu_cri_status(dcu_cri_status),
    .dcu_cri_valid(dcu_cri_valid),
    .dcu_req_addr(dcu_req_addr),
    .dcu_req_func(dcu_req_func),
    .dcu_req_id(dcu_req_id),
    .dcu_req_ready(dcu_req_ready),
    .dcu_req_stall(dcu_req_stall),
    .dcu_req_valid(dcu_req_valid),
    .dcu_wna_pending(dcu_wna_pending),
    .dtlb_lsu_status(dtlb_lsu_status),
    .lsu_async_read_error(lsu_async_read_error),
    .lsu_async_write_error(lsu_async_write_error),
    .lsu_dlm0_a_addr(lsu_dlm0_a_addr),
    .lsu_dlm0_a_func(lsu_dlm0_a_func),
    .lsu_dlm0_a_ready(lsu_dlm0_a_ready),
    .lsu_dlm0_a_stall(lsu_dlm0_a_stall),
    .lsu_dlm0_a_user(lsu_dlm0_a_user),
    .lsu_dlm0_a_valid(lsu_dlm0_a_valid),
    .lsu_dlm0_d_data(lsu_dlm0_d_data),
    .lsu_dlm0_d_status(lsu_dlm0_d_status),
    .lsu_dlm0_d_user(lsu_dlm0_d_user),
    .lsu_dlm0_d_valid(lsu_dlm0_d_valid),
    .lsu_dlm0_w_data(lsu_dlm0_w_data),
    .lsu_dlm0_w_mask(lsu_dlm0_w_mask),
    .lsu_dlm0_w_ready(lsu_dlm0_w_ready),
    .lsu_dlm0_w_status(lsu_dlm0_w_status),
    .lsu_dlm0_w_valid(lsu_dlm0_w_valid),
    .lsu_dlm1_a_addr(lsu_dlm1_a_addr),
    .lsu_dlm1_a_func(lsu_dlm1_a_func),
    .lsu_dlm1_a_ready(lsu_dlm1_a_ready),
    .lsu_dlm1_a_stall(lsu_dlm1_a_stall),
    .lsu_dlm1_a_user(lsu_dlm1_a_user),
    .lsu_dlm1_a_valid(lsu_dlm1_a_valid),
    .lsu_dlm1_d_data(lsu_dlm1_d_data),
    .lsu_dlm1_d_status(lsu_dlm1_d_status),
    .lsu_dlm1_d_user(lsu_dlm1_d_user),
    .lsu_dlm1_d_valid(lsu_dlm1_d_valid),
    .lsu_dlm1_w_data(lsu_dlm1_w_data),
    .lsu_dlm1_w_mask(lsu_dlm1_w_mask),
    .lsu_dlm1_w_ready(lsu_dlm1_w_ready),
    .lsu_dlm1_w_status(lsu_dlm1_w_status),
    .lsu_dlm1_w_valid(lsu_dlm1_w_valid),
    .lsu_dlm2_a_addr(lsu_dlm2_a_addr),
    .lsu_dlm2_a_func(lsu_dlm2_a_func),
    .lsu_dlm2_a_ready(lsu_dlm2_a_ready),
    .lsu_dlm2_a_stall(lsu_dlm2_a_stall),
    .lsu_dlm2_a_user(lsu_dlm2_a_user),
    .lsu_dlm2_a_valid(lsu_dlm2_a_valid),
    .lsu_dlm2_d_data(lsu_dlm2_d_data),
    .lsu_dlm2_d_status(lsu_dlm2_d_status),
    .lsu_dlm2_d_user(lsu_dlm2_d_user),
    .lsu_dlm2_d_valid(lsu_dlm2_d_valid),
    .lsu_dlm2_w_data(lsu_dlm2_w_data),
    .lsu_dlm2_w_mask(lsu_dlm2_w_mask),
    .lsu_dlm2_w_ready(lsu_dlm2_w_ready),
    .lsu_dlm2_w_status(lsu_dlm2_w_status),
    .lsu_dlm2_w_valid(lsu_dlm2_w_valid),
    .lsu_dlm3_a_addr(lsu_dlm3_a_addr),
    .lsu_dlm3_a_func(lsu_dlm3_a_func),
    .lsu_dlm3_a_ready(lsu_dlm3_a_ready),
    .lsu_dlm3_a_stall(lsu_dlm3_a_stall),
    .lsu_dlm3_a_user(lsu_dlm3_a_user),
    .lsu_dlm3_a_valid(lsu_dlm3_a_valid),
    .lsu_dlm3_d_data(lsu_dlm3_d_data),
    .lsu_dlm3_d_status(lsu_dlm3_d_status),
    .lsu_dlm3_d_user(lsu_dlm3_d_user),
    .lsu_dlm3_d_valid(lsu_dlm3_d_valid),
    .lsu_dlm3_w_data(lsu_dlm3_w_data),
    .lsu_dlm3_w_mask(lsu_dlm3_w_mask),
    .lsu_dlm3_w_ready(lsu_dlm3_w_ready),
    .lsu_dlm3_w_status(lsu_dlm3_w_status),
    .lsu_dlm3_w_valid(lsu_dlm3_w_valid),
    .lsu_dtlb_lru_valid(lsu_dtlb_lru_valid),
    .lsu_dtlb_lru_wdata(lsu_dtlb_lru_wdata),
    .lsu_ilm_a_addr(lsu_ilm_a_addr),
    .lsu_ilm_a_func(lsu_ilm_a_func),
    .lsu_ilm_a_ready(lsu_ilm_a_ready),
    .lsu_ilm_a_stall(lsu_ilm_a_stall),
    .lsu_ilm_a_user(lsu_ilm_a_user),
    .lsu_ilm_a_valid(lsu_ilm_a_valid),
    .lsu_ilm_d_data(lsu_ilm_d_data),
    .lsu_ilm_d_status(lsu_ilm_d_status),
    .lsu_ilm_d_user(lsu_ilm_d_user),
    .lsu_ilm_d_valid(lsu_ilm_d_valid),
    .lsu_ilm_w_data(lsu_ilm_w_data),
    .lsu_ilm_w_mask(lsu_ilm_w_mask),
    .lsu_ilm_w_ready(lsu_ilm_w_ready),
    .lsu_ilm_w_status(lsu_ilm_w_status),
    .lsu_ilm_w_valid(lsu_ilm_w_valid),
    .lsu_pma_req_pa(lsu_pma_req_pa),
    .lsu_pmp_req_pa(lsu_pmp_req_pa),
    .lsu_pmp_req_store(lsu_pmp_req_store),
    .nbload_resp_rd(nbload_resp_rd),
    .nbload_resp_result(nbload_resp_result),
    .nbload_resp_status(nbload_resp_status),
    .nbload_resp_valid(nbload_resp_valid),
    .pma_lsu_resp_fault(pma_lsu_resp_fault),
    .pma_lsu_resp_mtype(pma_lsu_resp_mtype),
    .pma_lsu_resp_namo(pma_lsu_resp_namo),
    .pmp_lsu_resp_fault(pmp_lsu_resp_fault),
    .trigm_ls_addr(trigm_ls_addr),
    .trigm_ls_load(trigm_ls_load),
    .trigm_ls_result(trigm_ls_result),
    .trigm_ls_store(trigm_ls_store),
    .csr_halt_mode(csr_halt_mode),
    .csr_mcache_ctl_dc_en(csr_mcache_ctl_dc_en),
    .ls_una_wait(ls_una_wait),
    .csr_mdlmb_den(csr_mdlmb_den),
    .csr_milmb_ien(csr_milmb_ien),
    .dtlb_lsu_ppn(dtlb_lsu_ppn),
    .lsu_dtlb_privilege_u(lsu_dtlb_privilege_u),
    .lsu_dtlb_store(lsu_dtlb_store),
    .lsu_dtlb_va_op0(lsu_dtlb_va_op0),
    .lsu_dtlb_va_op1(lsu_dtlb_va_op1),
    .lsu_event(lsu_event),
    .lsu_mmu_req_valid(lsu_mmu_req_valid),
    .lsu_mmu_va(lsu_mmu_va),
    .mmu_lsu_resp_valid(mmu_lsu_resp_valid),
    .ls_privilege_u(ls_privilege_u),
    .lsu_a_address(lsu_a_address),
    .lsu_a_corrupt(lsu_a_corrupt),
    .lsu_a_data(lsu_a_data),
    .lsu_a_mask(lsu_a_mask),
    .lsu_a_opcode(lsu_a_opcode),
    .lsu_a_param(lsu_a_param),
    .lsu_a_ready(lsu_a_ready),
    .lsu_a_size(lsu_a_size),
    .lsu_a_source(lsu_a_source),
    .lsu_a_user(lsu_a_user),
    .lsu_a_valid(lsu_a_valid),
    .lsu_d_corrupt(lsu_d_corrupt),
    .lsu_d_data(lsu_d_data),
    .lsu_d_denied(lsu_d_denied),
    .lsu_d_opcode(lsu_d_opcode),
    .lsu_d_param(lsu_d_param),
    .lsu_d_ready(lsu_d_ready),
    .lsu_d_sink(lsu_d_sink),
    .lsu_d_size(lsu_d_size),
    .lsu_d_source(lsu_d_source),
    .lsu_d_user(lsu_d_user),
    .lsu_d_valid(lsu_d_valid),
    .csr_mcache_ctl_dprefetch_en(csr_mcache_ctl_dprefetch_en),
    .lsu_prefetch_clr(lsu_prefetch_clr),
    .csr_mcache_ctl_ic_rwecc(csr_mcache_ctl_ic_rwecc),
    .csr_mcache_ctl_tlb_rwecc(csr_mcache_ctl_tlb_rwecc),
    .csr_mcctlbeginaddr(csr_mcctlbeginaddr),
    .dcu_acctl_ecc_corr(dcu_acctl_ecc_corr),
    .dcu_acctl_ecc_error(dcu_acctl_ecc_error),
    .dcu_ix_ack(dcu_ix_ack),
    .dcu_ix_addr(dcu_ix_addr),
    .dcu_ix_command(dcu_ix_command),
    .dcu_ix_raddr(dcu_ix_raddr),
    .dcu_ix_rdata(dcu_ix_rdata),
    .dcu_ix_req(dcu_ix_req),
    .dcu_ix_status(dcu_ix_status),
    .dcu_ix_wdata(dcu_ix_wdata),
    .dcu_standby_ready(dcu_standby_ready),
    .dcu_wbf_flush(dcu_wbf_flush),
    .ifu_cctl_ack(ifu_cctl_ack),
    .ifu_cctl_command(ifu_cctl_command),
    .ifu_cctl_ecc_status(ifu_cctl_ecc_status),
    .ifu_cctl_raddr(ifu_cctl_raddr),
    .ifu_cctl_rdata(ifu_cctl_rdata),
    .ifu_cctl_req(ifu_cctl_req),
    .ifu_cctl_status(ifu_cctl_status),
    .ifu_cctl_waddr(ifu_cctl_waddr),
    .ifu_cctl_wdata(ifu_cctl_wdata),
    .ifu_fence_done(ifu_fence_done),
    .ifu_fence_req(ifu_fence_req),
    .ifu_ipipe_standby_ready(ifu_ipipe_standby_ready),
    .ls_cmt_kill(ls_cmt_kill),
    .ls_cmt_valid(ls_cmt_valid),
    .ls_cmt_wdata_base(ls_cmt_wdata_base),
    .ls_cmt_wdata_sel_vpu(ls_cmt_wdata_sel_vpu),
    .ls_cmt_wdata_vpu(ls_cmt_wdata_vpu),
    .ls_issue_ready(ls_issue_ready),
    .ls_privilege_m(ls_privilege_m),
    .ls_privilege_s(ls_privilege_s),
    .ls_req_asid(ls_req_asid),
    .ls_req_base0(ls_req_base0),
    .ls_req_base1(ls_req_base1),
    .ls_req_base_bypass(ls_req_base_bypass),
    .ls_req_func(ls_req_func),
    .ls_req_offset(ls_req_offset),
    .ls_req_pc(ls_req_pc),
    .ls_req_stall(ls_req_stall),
    .ls_req_valid(ls_req_valid),
    .ls_resp_bresult(ls_resp_bresult),
    .ls_resp_fault_addr(ls_resp_fault_addr),
    .ls_resp_result(ls_resp_result),
    .ls_resp_result_64b(ls_resp_result_64b),
    .ls_resp_status(ls_resp_status),
    .ls_resp_valid(ls_resp_valid),
    .ls_standby_ready(ls_standby_ready),
    .lsu_cctl_raddr(lsu_cctl_raddr),
    .lsu_cctl_rdata(lsu_cctl_rdata),
    .lsu_reserve_clr(lsu_reserve_clr),
    .mmu_fence_asid(mmu_fence_asid),
    .mmu_fence_done(mmu_fence_done),
    .mmu_fence_mode(mmu_fence_mode),
    .mmu_fence_req(mmu_fence_req),
    .mmu_fence_vaddr(mmu_fence_vaddr),
    .tlb_cctl_ack(tlb_cctl_ack),
    .tlb_cctl_command(tlb_cctl_command),
    .tlb_cctl_ecc_status(tlb_cctl_ecc_status),
    .tlb_cctl_raddr(tlb_cctl_raddr),
    .tlb_cctl_rdata(tlb_cctl_rdata),
    .tlb_cctl_req(tlb_cctl_req),
    .tlb_cctl_waddr(tlb_cctl_waddr),
    .tlb_cctl_wdata(tlb_cctl_wdata),
    .wfi_enabled(wfi_enabled)
);
kv_rf kv_rf(
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .rf_init(rf_init),
    .rf_sdw_recover(rf_sdw_recover),
    .rf_raddr1(rf_raddr1),
    .rf_rdata1(rf_rdata1),
    .rf_raddr2(rf_raddr2),
    .rf_rdata2(rf_rdata2),
    .rf_raddr3(rf_raddr3),
    .rf_rdata3(rf_rdata3),
    .rf_raddr4(rf_raddr4),
    .rf_rdata4(rf_rdata4),
    .rf_raddr5(rf_raddr5),
    .rf_rdata5(rf_rdata5),
    .rf_we1(rf_we1),
    .rf_waddr1(rf_waddr1),
    .rf_wdata1(rf_wdata1),
    .rf_wstatus1(rf_wstatus1),
    .rf_we2(rf_we2),
    .rf_waddr2(rf_waddr2),
    .rf_wdata2(rf_wdata2),
    .rf_wstatus2(rf_wstatus2),
    .rf_we3(rf_we3),
    .rf_waddr3(rf_waddr3),
    .rf_wdata3(rf_wdata3),
    .rf_wstatus3(rf_wstatus3)
);
kv_alu #(
    .ISA_BFO_INT(ISA_BFO_INT),
    .ISA_LEA_INT(ISA_LEA_INT),
    .ISA_STR_INT(ISA_STR_INT),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT)
) u_alu0 (
    .alu_op0(alu0_op0),
    .alu_op1(alu0_op1),
    .alu_bop0(alu0_op0),
    .alu_bop1(alu0_op1),
    .alu_func(alu0_func),
    .alu_result(alu0_result),
    .alu_aresult(alu0_aresult),
    .alu_bresult(alu0_bresult)
);
kv_alu #(
    .ISA_BFO_INT(ISA_BFO_INT),
    .ISA_LEA_INT(ISA_LEA_INT),
    .ISA_STR_INT(ISA_STR_INT),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT)
) u_alu1 (
    .alu_op0(alu1_op0),
    .alu_op1(alu1_op1),
    .alu_bop0(alu1_bop0),
    .alu_bop1(alu1_bop1),
    .alu_func(alu1_func),
    .alu_result(alu1_result),
    .alu_aresult(nds_unused_alu1_aresult),
    .alu_bresult(nds_unused_alu1_bresult)
);
kv_alu #(
    .ISA_BFO_INT(ISA_BFO_INT),
    .ISA_LEA_INT(ISA_LEA_INT),
    .ISA_STR_INT(ISA_STR_INT),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT)
) u_alu2 (
    .alu_op0(alu2_op0),
    .alu_op1(alu2_op1),
    .alu_bop0(alu2_op0),
    .alu_bop1(alu2_op1),
    .alu_func(alu2_func),
    .alu_result(alu2_result),
    .alu_aresult(nds_unused_alu2_aresult),
    .alu_bresult(nds_unused_alu2_bresult)
);
kv_alu #(
    .ISA_BFO_INT(ISA_BFO_INT),
    .ISA_LEA_INT(ISA_LEA_INT),
    .ISA_STR_INT(ISA_STR_INT),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT)
) u_alu3 (
    .alu_op0(alu3_op0),
    .alu_op1(alu3_op1),
    .alu_bop0(alu3_bop0),
    .alu_bop1(alu3_bop1),
    .alu_func(alu3_func),
    .alu_result(alu3_result),
    .alu_aresult(nds_unused_alu3_aresult),
    .alu_bresult(nds_unused_alu3_bresult)
);
kv_bru #(
    .EXTVALEN(EXTVALEN),
    .ILM_AMSB(ILM_AMSB),
    .ILM_BASE(ILM_BASE),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .ISA_BBZ_INT(ISA_BBZ_INT),
    .VALEN(VALEN)
) u_bru0 (
    .bru_pc(bru0_pc),
    .bru_op0(bru0_op0),
    .bru_op1(bru0_op1),
    .bru_bop0(bru0_op0),
    .bru_bop1(bru0_op1),
    .bru_fn(bru0_fn),
    .bru_offset(bru0_offset),
    .bru_type(bru0_type),
    .bru_pred_info(bru0_pred_info),
    .bru_pred_npc(bru0_pred_npc),
    .bru_target(bru0_target),
    .bru_seq_npc(bru0_seq_npc),
    .bru_reso_info(bru0_reso_info)
);
kv_bru #(
    .EXTVALEN(EXTVALEN),
    .ILM_AMSB(ILM_AMSB),
    .ILM_BASE(ILM_BASE),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .ISA_BBZ_INT(ISA_BBZ_INT),
    .VALEN(VALEN)
) u_bru1 (
    .bru_pc(bru1_pc),
    .bru_op0(bru1_op0),
    .bru_op1(bru1_op1),
    .bru_bop0(bru1_bop0),
    .bru_bop1(bru1_bop1),
    .bru_fn(bru1_fn),
    .bru_offset(bru1_offset),
    .bru_type(bru1_type),
    .bru_pred_info(bru1_pred_info),
    .bru_pred_npc(bru1_pred_npc),
    .bru_target(bru1_target),
    .bru_seq_npc(bru1_seq_npc),
    .bru_reso_info(bru1_reso_info)
);
kv_bru #(
    .EXTVALEN(EXTVALEN),
    .ILM_AMSB(ILM_AMSB),
    .ILM_BASE(ILM_BASE),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .ISA_BBZ_INT(ISA_BBZ_INT),
    .VALEN(VALEN)
) u_bru2 (
    .bru_pc(bru2_pc),
    .bru_op0(bru2_op0),
    .bru_op1(bru2_op1),
    .bru_bop0(bru2_op0),
    .bru_bop1(bru2_op1),
    .bru_fn(bru2_fn),
    .bru_offset(bru2_offset),
    .bru_type(bru2_type),
    .bru_pred_info(bru2_pred_info),
    .bru_pred_npc(bru2_pred_npc),
    .bru_target(bru2_target),
    .bru_seq_npc(bru2_seq_npc),
    .bru_reso_info(bru2_reso_info)
);
kv_bru #(
    .EXTVALEN(EXTVALEN),
    .ILM_AMSB(ILM_AMSB),
    .ILM_BASE(ILM_BASE),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .ISA_BBZ_INT(ISA_BBZ_INT),
    .VALEN(VALEN)
) u_bru3 (
    .bru_pc(bru3_pc),
    .bru_op0(bru3_op0),
    .bru_op1(bru3_op1),
    .bru_bop0(bru3_bop0),
    .bru_bop1(bru3_bop1),
    .bru_fn(bru3_fn),
    .bru_offset(bru3_offset),
    .bru_type(bru3_type),
    .bru_pred_info(bru3_pred_info),
    .bru_pred_npc(bru3_pred_npc),
    .bru_target(bru3_target),
    .bru_seq_npc(bru3_seq_npc),
    .bru_reso_info(bru3_reso_info)
);
kv_mdu #(
    .MULTIPLIER_INT(MULTIPLIER_INT)
) kv_mdu (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .mdu_req_valid(mdu_req_valid),
    .mdu_req_tag(mdu_req_tag),
    .mdu_req_func(mdu_req_func),
    .mdu_req_op0(mdu_req_op0),
    .mdu_req_op1(mdu_req_op1),
    .mdu_req_ready(mdu_req_ready),
    .mdu_kill(mdu_kill),
    .mdu_resp_valid(mdu_resp_valid),
    .mdu_resp_tag(mdu_resp_tag),
    .mdu_resp_result(mdu_resp_result),
    .mdu_resp_ready(mdu_resp_ready)
);
kv_fastmul #(
    .MULTIPLIER_INT(MULTIPLIER_INT)
) kv_fastmul (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .fmul_req(fmul_req),
    .fmul_func(fmul_func),
    .fmul_op0(fmul_op0),
    .fmul_op1(fmul_op1),
    .fmul_stall(fmul_stall),
    .fmul_result(fmul_result)
);
kv_intc #(
    .CAUSE_LEN(CAUSE_LEN),
    .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT),
    .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
    .ICACHE_ECC_TYPE_INT(ICACHE_ECC_TYPE_INT),
    .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .SLAVE_PORT_SUPPORT_INT(SLAVE_PORT_SUPPORT_INT),
    .VALEN(VALEN),
    .VECTOR_PLIC_SUPPORT_INT(VECTOR_PLIC_SUPPORT_INT)
) kv_intc (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .hart_under_reset(hart_under_reset),
    .hart_unavail(hart_unavail),
    .csr_halt_mode(csr_halt_mode),
    .csr_dcsr_step(csr_dcsr_step),
    .csr_dcsr_stepie(csr_dcsr_stepie),
    .csr_dcsr_debugint(csr_dcsr_debugint),
    .csr_resethaltreq(csr_resethaltreq),
    .resume(resume),
    .resume_vectored(resume_vectored),
    .ifu_ipipe_init_done(ifu_ipipe_init_done),
    .rf_init(rf_init),
    .epc_init(epc_init),
    .vpu_init_rf(vpu_init_rf),
    .csr_cur_privilege(csr_cur_privilege),
    .csr_mmisc_ctl_vec_plic(csr_mmisc_ctl_vec_plic),
    .csr_mstatus_mie(csr_mstatus_mie),
    .csr_mstatus_sie(csr_mstatus_sie),
    .csr_mstatus_uie(csr_mstatus_uie),
    .csr_mip(csr_mip),
    .csr_ipipe_slip(csr_ipipe_slip),
    .csr_mie(csr_mie),
    .csr_ipipe_slie(csr_ipipe_slie),
    .csr_mideleg(csr_mideleg),
    .csr_sideleg(csr_sideleg),
    .csr_mslideleg(csr_mslideleg),
    .csr_dexc2dbg_slpecc(csr_dexc2dbg_slpecc),
    .csr_dexc2dbg_sbe(csr_dexc2dbg_sbe),
    .csr_dexc2dbg_pmov(csr_dexc2dbg_pmov),
    .nmi(nmi),
    .meiack(meiack),
    .seiack(seiack),
    .ueiack(ueiack),
    .ipipe_csr_nmi_taken(ipipe_csr_nmi_taken),
    .csr_meiid(csr_meiid),
    .csr_seiid(csr_seiid),
    .csr_ueiid(csr_ueiid),
    .lsu_async_write_error(lsu_async_write_error),
    .lsu_async_read_error(lsu_async_read_error),
    .dcu_async_write_error(dcu_async_write_error),
    .lm_async_write_error(lm_async_write_error),
    .ipipe_csr_nmi_pending(ipipe_csr_nmi_pending),
    .ipipe_csr_m_sbe_set(ipipe_csr_m_sbe_set),
    .ipipe_csr_s_sbe_set(ipipe_csr_s_sbe_set),
    .ipipe_csr_m_slpecc_clr(ipipe_csr_m_slpecc_clr),
    .ipipe_csr_m_hpmint_clr(ipipe_csr_m_hpmint_clr),
    .ipipe_csr_m_sbe_clr(ipipe_csr_m_sbe_clr),
    .ipipe_csr_s_slpecc_clr(ipipe_csr_s_slpecc_clr),
    .ipipe_csr_s_hpmint_clr(ipipe_csr_s_hpmint_clr),
    .ipipe_csr_s_sbe_clr(ipipe_csr_s_sbe_clr),
    .ipipe_csr_int_delegate_s(ipipe_csr_int_delegate_s),
    .ipipe_csr_int_delegate_u(ipipe_csr_int_delegate_u),
    .int_code(int_code),
    .int_cause_detail(int_cause_detail),
    .int_cause_interrupt(int_cause_interrupt),
    .trigm_int_code(trigm_int_code),
    .trigm_int_result(trigm_int_result),
    .itrigger_fire(itrigger_fire),
    .int_ecc(int_ecc),
    .wfi_done(wfi_done),
    .async_valid(async_valid),
    .async_ready(async_ready),
    .debugint_valid(debugint_valid),
    .nmi_valid(nmi_valid),
    .mint_valid(mint_valid),
    .sint_valid(sint_valid),
    .uint_valid(uint_valid),
    .mei_entry_sel(mei_entry_sel),
    .sei_entry_sel(sei_entry_sel),
    .uei_entry_sel(uei_entry_sel),
    .mint_vec(mint_vec),
    .sint_vec(sint_vec),
    .uint_vec(uint_vec),
    .int_detail_cause_valid(int_detail_cause_valid),
    .int_dex2dbg(int_dex2dbg),
    .int_ddcause(int_ddcause),
    .int_ecc_cause_detail(int_ecc_cause_detail)
);
kv_cmt #(
    .CAUSE_LEN(CAUSE_LEN),
    .DEBUG_VEC(DEBUG_VEC),
    .EXTVALEN(EXTVALEN),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .RVN_SUPPORT_INT(RVN_SUPPORT_INT),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .VALEN(VALEN)
) kv_cmt (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_cur_privilege(csr_cur_privilege),
    .hart_under_reset(hart_under_reset),
    .hart_halted(hart_halted),
    .wb_i0_alive(wb_i0_alive),
    .wb_i1_alive(wb_i1_alive),
    .wb_i0_seg_end(wb_i0_seg_end),
    .wb_i1_seg_end(wb_i1_seg_end),
    .wb_i0_pc(wb_i0_pc),
    .wb_i1_pc(wb_i1_pc),
    .wb_i0_npc(wb_i0_npc),
    .wb_i1_npc(wb_i1_npc),
    .wb_i0_tval(wb_i0_tval),
    .wb_i1_tval(wb_i1_tval),
    .wb_i0_instr(wb_i0_instr),
    .wb_i1_instr(wb_i1_instr),
    .wb_i0_ctrl(wb_i0_ctrl),
    .wb_i1_ctrl(wb_i1_ctrl),
    .wb_i0_reso_info(wb_i0_reso_info),
    .wb_i1_reso_info(wb_i1_reso_info),
    .wb_i0_16b(wb_i0_16b),
    .wb_i1_16b(wb_i1_16b),
    .wb_i0_trace_trigger(wb_i0_trace_trigger),
    .wb_i1_trace_trigger(wb_i1_trace_trigger),
    .wb_ls_ecc_code(wb_ls_ecc_code),
    .wb_ls_ecc_corr(wb_ls_ecc_corr),
    .wb_ls_ecc_ramid(wb_ls_ecc_ramid),
    .async_ready(async_ready),
    .debugint_valid(debugint_valid),
    .nmi_valid(nmi_valid),
    .mint_valid(mint_valid),
    .sint_valid(sint_valid),
    .uint_valid(uint_valid),
    .mei_entry_sel(mei_entry_sel),
    .sei_entry_sel(sei_entry_sel),
    .uei_entry_sel(uei_entry_sel),
    .mint_vec(mint_vec),
    .sint_vec(sint_vec),
    .uint_vec(uint_vec),
    .int_code(int_code),
    .int_cause_detail(int_cause_detail),
    .int_ecc(int_ecc),
    .int_ecc_corr(int_ecc_corr),
    .int_ecc_ramid(int_ecc_ramid),
    .int_ecc_insn(int_ecc_insn),
    .int_cause_interrupt(int_cause_interrupt),
    .int_dex2dbg(int_dex2dbg),
    .int_ddcause(int_ddcause),
    .int_detail_cause_valid(int_detail_cause_valid),
    .reset_vector(reset_vector),
    .csr_halt_mode(csr_halt_mode),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .csr_medeleg(csr_medeleg),
    .csr_sedeleg(csr_sedeleg),
    .csr_mtvec(csr_mtvec),
    .csr_stvec(csr_stvec),
    .csr_utvec(csr_utvec),
    .csr_dpc(csr_dpc),
    .csr_mepc(csr_mepc),
    .csr_sepc(csr_sepc),
    .csr_uepc(csr_uepc),
    .csr_dexc2dbg_iam(csr_dexc2dbg_iam),
    .csr_dexc2dbg_iaf(csr_dexc2dbg_iaf),
    .csr_dexc2dbg_ii(csr_dexc2dbg_ii),
    .csr_dexc2dbg_nmi(csr_dexc2dbg_nmi),
    .csr_dexc2dbg_lam(csr_dexc2dbg_lam),
    .csr_dexc2dbg_laf(csr_dexc2dbg_laf),
    .csr_dexc2dbg_sam(csr_dexc2dbg_sam),
    .csr_dexc2dbg_saf(csr_dexc2dbg_saf),
    .csr_dexc2dbg_uec(csr_dexc2dbg_uec),
    .csr_dexc2dbg_sec(csr_dexc2dbg_sec),
    .csr_dexc2dbg_hec(csr_dexc2dbg_hec),
    .csr_dexc2dbg_mec(csr_dexc2dbg_mec),
    .csr_dexc2dbg_hsp(csr_dexc2dbg_hsp),
    .csr_dexc2dbg_ace(csr_dexc2dbg_ace),
    .csr_dexc2dbg_sbe(csr_dexc2dbg_sbe),
    .csr_dexc2dbg_ipf(csr_dexc2dbg_ipf),
    .csr_dexc2dbg_lpf(csr_dexc2dbg_lpf),
    .csr_dexc2dbg_spf(csr_dexc2dbg_spf),
    .csr_dexc2dbg_pmov(csr_dexc2dbg_pmov),
    .csr_mmisc_ctl_vec_plic(csr_mmisc_ctl_vec_plic),
    .resume(resume),
    .wb_i0_resume(wb_i0_resume),
    .wb_i0_retire(wb_i0_retire),
    .wb_i1_resume(wb_i1_resume),
    .wb_i1_retire(wb_i1_retire),
    .wb_postsync_resume(wb_postsync_resume),
    .resume_pc(resume_pc),
    .resume_ras_ptr(nds_unused_resume_ras_ptr),
    .resume_vectored(resume_vectored),
    .epc_init(epc_init),
    .trigm_xcpt_onehot(trigm_xcpt_onehot),
    .trigm_xcpt_result(trigm_xcpt_result),
    .etrigger_fire(etrigger_fire),
    .trigm_icount_valid(trigm_icount_valid),
    .trigm_icount_clr(trigm_icount_clr),
    .trigm_trace_enabled(trigm_trace_enabled),
    .ipipe_csr_cause_we(ipipe_csr_cause_we),
    .ipipe_csr_cause_detail_we(ipipe_csr_cause_detail_we),
    .ipipe_csr_cause_interrupt(ipipe_csr_cause_interrupt),
    .ipipe_csr_cause_code(ipipe_csr_cause_code),
    .ipipe_csr_cause_detail(ipipe_csr_cause_detail),
    .ipipe_csr_cause_detail_pm(ipipe_csr_cause_detail_pm),
    .ipipe_csr_ecc_trap(ipipe_csr_ecc_trap),
    .ipipe_csr_ecc_code(ipipe_csr_ecc_code),
    .ipipe_csr_ecc_code_en(ipipe_csr_ecc_code_en),
    .ipipe_csr_ecc_corr(ipipe_csr_ecc_corr),
    .ipipe_csr_ecc_precise(ipipe_csr_ecc_precise),
    .ipipe_csr_ecc_ramid(ipipe_csr_ecc_ramid),
    .ipipe_csr_ecc_insn(ipipe_csr_ecc_insn),
    .ipipe_csr_ecc_fetch(ipipe_csr_ecc_fetch),
    .ipipe_csr_epc_we(ipipe_csr_epc_we),
    .ipipe_csr_epc_wdata(ipipe_csr_epc_wdata),
    .ipipe_csr_tval_we(ipipe_csr_tval_we),
    .ipipe_csr_tval_wdata(ipipe_csr_tval_wdata),
    .ipipe_csr_halt_taken(ipipe_csr_halt_taken),
    .ipipe_csr_halt_return(ipipe_csr_halt_return),
    .ipipe_csr_halt_cause(ipipe_csr_halt_cause),
    .ipipe_csr_halt_ddcause(ipipe_csr_halt_ddcause),
    .ipipe_csr_nmi_taken(ipipe_csr_nmi_taken),
    .ipipe_csr_trap_taken(ipipe_csr_trap_taken),
    .trap_handled_by_s_mode(trap_handled_by_s_mode),
    .trap_handled_by_u_mode(trap_handled_by_u_mode),
    .ipipe_csr_m_trap_return(ipipe_csr_m_trap_return),
    .ipipe_csr_s_trap_return(ipipe_csr_s_trap_return),
    .ipipe_csr_u_trap_return(ipipe_csr_u_trap_return),
    .ipipe_csr_int_delegate_u(ipipe_csr_int_delegate_u),
    .ipipe_csr_int_delegate_s(ipipe_csr_int_delegate_s),
    .wb_i0_instr_event(wb_i0_instr_event),
    .wb_i1_instr_event(wb_i1_instr_event),
    .ipipe_csr_inst_retire(ipipe_csr_inst_retire),
    .ipipe_csr_pfm_inst_retire(ipipe_csr_pfm_inst_retire),
    .gen1_trace_enabled(gen1_trace_enabled),
    .gen1_trace_ivalid(gen1_trace_ivalid),
    .gen1_trace_iexception(gen1_trace_iexception),
    .gen1_trace_interrupt(gen1_trace_interrupt),
    .gen1_trace_iaddr(gen1_trace_iaddr),
    .gen1_trace_instr(gen1_trace_instr),
    .gen1_trace_priv(gen1_trace_priv),
    .gen1_trace_cause(gen1_trace_cause),
    .gen1_trace_tval(gen1_trace_tval),
    .trace_enabled(trace_enabled),
    .trace_stall(trace_stall),
    .trace_itype(trace_itype),
    .trace_cause(trace_cause),
    .trace_tval(trace_tval),
    .trace_priv(trace_priv),
    .trace_iaddr(trace_iaddr),
    .trace_iretire(trace_iretire),
    .trace_ilastsize(trace_ilastsize),
    .trace_halted(trace_halted),
    .trace_reset(trace_reset),
    .trace_trigger(trace_trigger),
    .ii_i0_trace_stall(ii_i0_trace_stall)
);
kv_vsetvl_stub #(
    .VLEN(VLEN)
) u_vsetvl (
    .op0(vsetvl_op0),
    .op1(vsetvl_op1),
    .vtype(vsetvl_vtype),
    .result(vsetvl_result)
);
kv_csr #(
    .ACE_SUPPORT_INT(ACE_SUPPORT_INT),
    .BFLOAT16_SUPPORT_INT(BFLOAT16_SUPPORT_INT),
    .BRANCH_PREDICTION_INT(4),
    .CACHE_LINE_SIZE(CACHE_LINE_SIZE),
    .CAUSE_LEN(CAUSE_LEN),
    .CLUSTER_SUPPORT_INT(CLUSTER_SUPPORT_INT),
    .CM_SUPPORT_INT(CM_SUPPORT_INT),
    .CPUID(CPUID),
    .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT),
    .DCACHE_LRU_INT(DCACHE_LRU_INT),
    .DCACHE_PREFETCH_SUPPORT_INT(DCACHE_PREFETCH_SUPPORT_INT),
    .DCACHE_SIZE_KB(DCACHE_SIZE_KB),
    .DCACHE_TAG_AW(DCACHE_TAG_RAM_AW),
    .DCACHE_WAY(DCACHE_WAY),
    .DEBUG_SUPPORT_INT(DEBUG_SUPPORT_INT),
    .DLM_BASE(DLM_BASE),
    .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .DSP_SUPPORT_INT(DSP_SUPPORT_INT),
    .EXTVALEN(EXTVALEN),
    .FLEN(FLEN),
    .FP16_SUPPORT_INT(FP16_SUPPORT_INT),
    .HAS_VPU_INT(HAS_VPU_INT),
    .ICACHE_ECC_TYPE_INT(ICACHE_ECC_TYPE_INT),
    .ICACHE_LRU_INT(ICACHE_LRU_INT),
    .ICACHE_SIZE_KB(ICACHE_SIZE_KB),
    .ICACHE_TAG_RAM_AW(ICACHE_TAG_RAM_AW),
    .ICACHE_WAY(ICACHE_WAY),
    .ILM_BASE(ILM_BASE),
    .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .IOCP_NUM(IOCP_NUM),
    .L2C_CACHE_SIZE_KB(L2C_CACHE_SIZE_KB),
    .L2C_REG_BASE(L2C_REG_BASE),
    .LM_ENABLE_CTRL_INT(0),
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .MIMPID(MIMPID),
    .MMU_SCHEME_INT(MMU_SCHEME_INT),
    .NCORE_CLUSTER(NCORE_CLUSTER),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .NUM_TRIGGER(NUM_TRIGGER),
    .PALEN(PALEN),
    .PERFORMANCE_MONITOR_INT(PERFORMANCE_MONITOR_INT),
    .PMA_ENTRIES(PMA_ENTRIES),
    .POWERBRAKE_SUPPORT_INT(POWERBRAKE_SUPPORT_INT),
    .RVA_SUPPORT_INT(RVA_SUPPORT_INT),
    .RVN_SUPPORT_INT(RVN_SUPPORT_INT),
    .SLAVE_PORT_SUPPORT_INT(SLAVE_PORT_SUPPORT_INT),
    .STACKSAFE_SUPPORT_INT(STACKSAFE_SUPPORT_INT),
    .STLB_ECC_TYPE(STLB_ECC_TYPE),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .UNALIGNED_ACCESS_INT(UNALIGNED_ACCESS_INT),
    .VALEN(VALEN),
    .VECTOR_PLIC_SUPPORT_INT(VECTOR_PLIC_SUPPORT_INT),
    .WRITE_AROUND_SUPPORT_INT(WRITE_AROUND_SUPPORT_INT)
) kv_csr (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .reset_vector(reset_vector),
    .hart_id(hart_id),
    .csr_marchid(csr_marchid),
    .csr_mimpid(csr_mimpid),
    .core_coherent_enable(core_coherent_enable_int),
    .core_coherent_state(core_coherent_state_int),
    .mmu_csr_mitlb_access(mmu_csr_mitlb_access),
    .mmu_csr_mitlb_miss(mmu_csr_mitlb_miss),
    .mmu_csr_mdtlb_access(mmu_csr_mdtlb_access),
    .mmu_csr_mdtlb_miss(mmu_csr_mdtlb_miss),
    .ace_acr_dirty_set(ace_acr_dirty_set),
    .ace_error(ace_error),
    .ilm_csr_access(ilm_csr_access),
    .dlm_csr_access0(dlm_csr_access0),
    .dlm_csr_access1(dlm_csr_access1),
    .dlm_csr_access2(dlm_csr_access2),
    .dlm_csr_access3(dlm_csr_access3),
    .ipipe_csr_nmi_pending(ipipe_csr_nmi_pending),
    .wb_i0_instr_event(wb_i0_instr_event),
    .wb_i1_instr_event(wb_i1_instr_event),
    .ipipe_csr_req_wr_valid(ipipe_csr_req_wr_valid),
    .ipipe_csr_req_rd_valid(ipipe_csr_req_rd_valid),
    .ipipe_csr_req_read_only(ipipe_csr_req_read_only),
    .ipipe_csr_req_mrandstate(ipipe_csr_req_mrandstate),
    .ipipe_csr_req_func(ipipe_csr_req_func),
    .ipipe_csr_req_waddr(ipipe_csr_req_waddr),
    .ipipe_csr_req_wdata(ipipe_csr_req_wdata),
    .ipipe_csr_req_raddr(ipipe_csr_req_raddr),
    .csr_ipipe_resp_rdata(csr_ipipe_resp_rdata),
    .csr_ipipe_rmw_rdata(csr_ipipe_rmw_rdata),
    .csr_trap_delegated(csr_trap_delegated),
    .ipipe_csr_halt_taken(ipipe_csr_halt_taken),
    .ipipe_csr_halt_return(ipipe_csr_halt_return),
    .ipipe_csr_halt_cause(ipipe_csr_halt_cause),
    .ipipe_csr_halt_ddcause(ipipe_csr_halt_ddcause),
    .csr_medeleg(csr_medeleg),
    .csr_sedeleg(csr_sedeleg),
    .ipipe_csr_nmi_taken(ipipe_csr_nmi_taken),
    .ipipe_csr_trap_taken(ipipe_csr_trap_taken),
    .trap_handled_by_s_mode(trap_handled_by_s_mode),
    .trap_handled_by_u_mode(trap_handled_by_u_mode),
    .ipipe_csr_m_trap_return(ipipe_csr_m_trap_return),
    .ipipe_csr_s_trap_return(ipipe_csr_s_trap_return),
    .ipipe_csr_u_trap_return(ipipe_csr_u_trap_return),
    .ipipe_csr_inst_retire(ipipe_csr_inst_retire),
    .ipipe_csr_pfm_inst_retire(ipipe_csr_pfm_inst_retire),
    .ipipe_csr_cause_we(ipipe_csr_cause_we),
    .ipipe_csr_cause_detail_we(ipipe_csr_cause_detail_we),
    .ipipe_csr_cause_interrupt(ipipe_csr_cause_interrupt),
    .ipipe_csr_cause_code(ipipe_csr_cause_code),
    .ipipe_csr_cause_detail(ipipe_csr_cause_detail),
    .ipipe_csr_cause_detail_pm(ipipe_csr_cause_detail_pm),
    .ipipe_csr_epc_we(ipipe_csr_epc_we),
    .ipipe_csr_epc_wdata(ipipe_csr_epc_wdata),
    .ipipe_csr_tval_wdata(ipipe_csr_tval_wdata),
    .ipipe_csr_tval_we(ipipe_csr_tval_we),
    .ipipe_csr_ecc_trap(ipipe_csr_ecc_trap),
    .ipipe_csr_ecc_code_en(ipipe_csr_ecc_code_en),
    .ipipe_csr_ecc_code(ipipe_csr_ecc_code),
    .ipipe_csr_ecc_corr(ipipe_csr_ecc_corr),
    .ipipe_csr_ecc_precise(ipipe_csr_ecc_precise),
    .ipipe_csr_ecc_ramid(ipipe_csr_ecc_ramid),
    .ipipe_csr_ecc_insn(ipipe_csr_ecc_insn),
    .ipipe_csr_ecc_fetch(ipipe_csr_ecc_fetch),
    .ipipe_csr_vtype_we(ipipe_csr_vtype_we),
    .ipipe_csr_vtype_wdata(ipipe_csr_vtype_wdata),
    .ipipe_csr_vl_we(ipipe_csr_vl_we),
    .ipipe_csr_vl_wdata(ipipe_csr_vl_wdata),
    .csr_mstatus_mie(csr_mstatus_mie),
    .csr_mstatus_sie(csr_mstatus_sie),
    .csr_mstatus_uie(csr_mstatus_uie),
    .csr_mepc(csr_mepc),
    .csr_sepc(csr_sepc),
    .csr_uepc(csr_uepc),
    .csr_mtvec(csr_mtvec),
    .csr_stvec(csr_stvec),
    .csr_utvec(csr_utvec),
    .csr_mip(csr_mip),
    .csr_mie(csr_mie),
    .csr_ipipe_slip(csr_ipipe_slip),
    .csr_ipipe_slie(csr_ipipe_slie),
    .ipipe_csr_int_delegate_u(ipipe_csr_int_delegate_u),
    .ipipe_csr_int_delegate_s(ipipe_csr_int_delegate_s),
    .ipipe_csr_m_sbe_set(ipipe_csr_m_sbe_set),
    .ipipe_csr_s_sbe_set(ipipe_csr_s_sbe_set),
    .ipipe_csr_m_slpecc_clr(ipipe_csr_m_slpecc_clr),
    .ipipe_csr_m_hpmint_clr(ipipe_csr_m_hpmint_clr),
    .ipipe_csr_m_sbe_clr(ipipe_csr_m_sbe_clr),
    .ipipe_csr_s_slpecc_clr(ipipe_csr_s_slpecc_clr),
    .ipipe_csr_s_hpmint_clr(ipipe_csr_s_hpmint_clr),
    .ipipe_csr_s_sbe_clr(ipipe_csr_s_sbe_clr),
    .csr_milmb_ien(csr_milmb_ien),
    .csr_milmb_eccen(csr_milmb_eccen),
    .csr_milmb_rwecc(csr_milmb_rwecc),
    .csr_mdlmb_den(csr_mdlmb_den),
    .csr_mdlmb_eccen(csr_mdlmb_eccen),
    .csr_mdlmb_rwecc(csr_mdlmb_rwecc),
    .csr_mecc_code(csr_mecc_code),
    .csr_mcache_ctl_iprefetch_en(csr_mcache_ctl_iprefetch_en),
    .csr_mcache_ctl_ic_en(csr_mcache_ctl_ic_en),
    .csr_mcache_ctl_ic_eccen(csr_mcache_ctl_ic_eccen),
    .csr_mcache_ctl_ic_rwecc(csr_mcache_ctl_ic_rwecc),
    .csr_mcache_ctl_dc_en(csr_mcache_ctl_dc_en),
    .csr_mcache_ctl_dc_eccen(csr_mcache_ctl_dc_eccen),
    .csr_mcache_ctl_dc_rwecc(csr_mcache_ctl_dc_rwecc),
    .csr_mcache_ctl_cctl_suen(csr_mcache_ctl_cctl_suen),
    .csr_mcache_ctl_dprefetch_en(csr_mcache_ctl_dprefetch_en),
    .csr_mcache_ctl_dc_waround(csr_mcache_ctl_dc_waround),
    .csr_mcache_ctl_tlb_eccen(csr_mcache_ctl_tlb_eccen),
    .csr_mcache_ctl_tlb_rwecc(csr_mcache_ctl_tlb_rwecc),
    .csr_mxstatus_dme(csr_mxstatus_dme),
    .csr_mxstatus_ime(csr_mxstatus_ime),
    .lsu_reserve_clr(lsu_reserve_clr),
    .lsu_prefetch_clr(lsu_prefetch_clr),
    .csr_cur_privilege(csr_cur_privilege),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .ls_privilege_m(ls_privilege_m),
    .ls_privilege_s(ls_privilege_s),
    .ls_privilege_u(ls_privilege_u),
    .csr_mstatus_mpp(csr_mstatus_mpp),
    .csr_mstatus_mprv(csr_mstatus_mprv),
    .csr_mstatus_mxr(csr_mstatus_mxr),
    .csr_mstatus_sum(csr_mstatus_sum),
    .csr_dcsr_debugint(csr_dcsr_debugint),
    .csr_resethaltreq(csr_resethaltreq),
    .csr_halt_mode(csr_halt_mode),
    .csr_dcsr_step(csr_dcsr_step),
    .csr_dcsr_mprven(csr_dcsr_mprven),
    .csr_dcsr_ebreakm(csr_dcsr_ebreakm),
    .csr_dcsr_ebreaks(csr_dcsr_ebreaks),
    .csr_dcsr_ebreaku(csr_dcsr_ebreaku),
    .csr_dcsr_stepie(csr_dcsr_stepie),
    .csr_dpc(csr_dpc),
    .csr_mstatus_fs(csr_mstatus_fs),
    .csr_mmisc_ctl_aces(csr_mmisc_ctl_aces),
    .csr_mmisc_ctl_vec_plic(csr_mmisc_ctl_vec_plic),
    .csr_mmisc_ctl_rvcompm(csr_mmisc_ctl_rvcompm),
    .csr_mmisc_ctl_brpe(csr_mmisc_ctl_brpe),
    .csr_mmisc_ctl_una(csr_mmisc_ctl_una),
    .csr_mmisc_ctl_nbcache_en(csr_mmisc_ctl_nbcache_en),
    .csr_tcontrol_mte(csr_tcontrol_mte),
    .csr_dexc2dbg_iam(csr_dexc2dbg_iam),
    .csr_dexc2dbg_iaf(csr_dexc2dbg_iaf),
    .csr_dexc2dbg_ii(csr_dexc2dbg_ii),
    .csr_dexc2dbg_nmi(csr_dexc2dbg_nmi),
    .csr_dexc2dbg_lam(csr_dexc2dbg_lam),
    .csr_dexc2dbg_laf(csr_dexc2dbg_laf),
    .csr_dexc2dbg_sam(csr_dexc2dbg_sam),
    .csr_dexc2dbg_saf(csr_dexc2dbg_saf),
    .csr_dexc2dbg_uec(csr_dexc2dbg_uec),
    .csr_dexc2dbg_sec(csr_dexc2dbg_sec),
    .csr_dexc2dbg_hec(csr_dexc2dbg_hec),
    .csr_dexc2dbg_mec(csr_dexc2dbg_mec),
    .csr_dexc2dbg_hsp(csr_dexc2dbg_hsp),
    .csr_dexc2dbg_slpecc(csr_dexc2dbg_slpecc),
    .csr_dexc2dbg_sbe(csr_dexc2dbg_sbe),
    .csr_dexc2dbg_ace(csr_dexc2dbg_ace),
    .csr_dexc2dbg_pmov(csr_dexc2dbg_pmov),
    .csr_dexc2dbg_spf(csr_dexc2dbg_spf),
    .csr_dexc2dbg_lpf(csr_dexc2dbg_lpf),
    .csr_dexc2dbg_ipf(csr_dexc2dbg_ipf),
    .debugint(debugint),
    .resethaltreq(resethaltreq),
    .csr_satp_ppn(csr_satp_ppn),
    .csr_satp_mode(csr_satp_mode),
    .csr_satp_asid(csr_satp_asid),
    .meip(meip),
    .mtip(mtip),
    .msip(msip),
    .seip(seip),
    .ueip(ueip),
    .meiid(meiid),
    .seiid(seiid),
    .ueiid(ueiid),
    .csr_meiid(csr_meiid),
    .csr_seiid(csr_seiid),
    .csr_ueiid(csr_ueiid),
    .csr_tselect_we(csr_tselect_we),
    .csr_tdata1_we(csr_tdata1_we),
    .csr_tdata2_we(csr_tdata2_we),
    .csr_tdata3_we(csr_tdata3_we),
    .csr_mcontext_we(csr_mcontext_we),
    .csr_scontext_we(csr_scontext_we),
    .csr_wdata(csr_wdata),
    .csr_tselect(csr_tselect),
    .csr_tdata1(csr_tdata1),
    .csr_tdata2(csr_tdata2),
    .csr_tdata3(csr_tdata3),
    .csr_tinfo(csr_tinfo),
    .csr_mcontext(csr_mcontext),
    .csr_scontext(csr_scontext),
    .lsu_cctl_rdata(lsu_cctl_rdata),
    .lsu_cctl_raddr(lsu_cctl_raddr),
    .csr_t_level(csr_t_level),
    .csr_pft_en(csr_pft_en),
    .ipipe_csr_mhsp_bound_wdata(ipipe_csr_mhsp_bound_wdata),
    .ipipe_csr_mhsp_bound_wen(ipipe_csr_mhsp_bound_wen),
    .ipipe_csr_hsp_xcpt(ipipe_csr_hsp_xcpt),
    .csr_mhsp_bound(csr_mhsp_bound),
    .csr_mhsp_base(csr_mhsp_base),
    .csr_mhsp_ctl_ovf_en(csr_mhsp_ctl_ovf_en),
    .csr_mhsp_ctl_udf_en(csr_mhsp_ctl_udf_en),
    .csr_mhsp_ctl_schm(csr_mhsp_ctl_schm),
    .csr_mhsp_ctl_u(csr_mhsp_ctl_u),
    .csr_mhsp_ctl_s(csr_mhsp_ctl_s),
    .csr_mhsp_ctl_m(csr_mhsp_ctl_m),
    .csr_uitb(csr_uitb),
    .stoptime(stoptime),
    .csr_mcounteren(csr_mcounteren),
    .csr_mcounterwen(csr_mcounterwen),
    .csr_scounteren(csr_scounteren),
    .csr_mstatus_tw(csr_mstatus_tw),
    .csr_mstatus_tvm(csr_mstatus_tvm),
    .csr_mstatus_tsr(csr_mstatus_tsr),
    .ipipe_csr_ucode_ov_set(ipipe_csr_ucode_ov_set),
    .csr_frm(csr_frm),
    .ipipe_csr_fs_wen(ipipe_csr_fs_wen),
    .ipipe_csr_fflags_set(ipipe_csr_fflags_set),
    .csr_mmu_satp_we(csr_mmu_satp_we),
    .csr_pmp_we(csr_pmp_we),
    .csr_pmp_waddr(csr_pmp_waddr),
    .csr_pmp_raddr0(csr_pmp_raddr0),
    .csr_pmp_raddr1(csr_pmp_raddr1),
    .csr_pmp_wdata(csr_pmp_wdata),
    .pmp_csr_hit0(pmp_csr_hit0),
    .pmp_csr_rdata0(pmp_csr_rdata0),
    .pmp_csr_hit1(pmp_csr_hit1),
    .pmp_csr_rdata1(pmp_csr_rdata1),
    .csr_pma_we(csr_pma_we),
    .csr_pma_waddr(csr_pma_waddr),
    .csr_pma_raddr0(csr_pma_raddr0),
    .csr_pma_raddr1(csr_pma_raddr1),
    .csr_pma_wdata(csr_pma_wdata),
    .pma_csr_hit0(pma_csr_hit0),
    .pma_csr_rdata0(pma_csr_rdata0),
    .pma_csr_hit1(pma_csr_hit1),
    .pma_csr_rdata1(pma_csr_rdata1),
    .csr_mideleg(csr_mideleg),
    .csr_sideleg(csr_sideleg),
    .csr_mslideleg(csr_mslideleg),
    .csr_mcctlbeginaddr(csr_mcctlbeginaddr),
    .itlb_translate_en(itlb_translate_en),
    .csr_ls_translate_en(csr_ls_translate_en),
    .csr_vtype(csr_vtype),
    .csr_vl(csr_vl),
    .csr_vstart(csr_vstart),
    .ipipe_event(ipipe_event),
    .dcu_event(dcu_event),
    .mshr_event(mshr_event),
    .ifu_event(ifu_event),
    .lsu_event(lsu_event),
    .csr_prob_raddr(csr_prob_raddr),
    .csr_prob_rdata(csr_prob_rdata),
    .slvp_ipipe_local_int(slvp_ipipe_local_int),
    .slvp_ipipe_ecc_corr(slvp_ipipe_ecc_corr),
    .slvp_ipipe_ecc_ramid(slvp_ipipe_ecc_ramid),
    .dcu_async_ecc_error(dcu_async_ecc_error),
    .dcu_async_ecc_corr(dcu_async_ecc_corr),
    .dcu_async_ecc_ramid(dcu_async_ecc_ramid),
    .int_ecc_corr(int_ecc_corr),
    .int_ecc_ramid(int_ecc_ramid),
    .int_ecc_insn(int_ecc_insn),
    .int_ecc_cause_detail(int_ecc_cause_detail)
);
kv_trigm #(
    .LOCALINT_HPMINT(LOCALINT_HPMINT),
    .LOCALINT_SBE(LOCALINT_SBE),
    .LOCALINT_SLPECC(LOCALINT_SLPECC),
    .NUM_PRIVILEGE_LEVELS(NUM_PRIVILEGE_LEVELS),
    .NUM_TRIGGER(NUM_TRIGGER),
    .TRACE_INTERFACE_INT(TRACE_INTERFACE_INT),
    .VALEN(VALEN)
) kv_trigm (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_halt_mode(csr_halt_mode),
    .csr_tcontrol_mte(csr_tcontrol_mte),
    .csr_satp_asid(csr_satp_asid),
    .csr_cur_privilege(csr_cur_privilege),
    .csr_tselect_we(csr_tselect_we),
    .csr_tdata1_we(csr_tdata1_we),
    .csr_tdata2_we(csr_tdata2_we),
    .csr_tdata3_we(csr_tdata3_we),
    .csr_mcontext_we(csr_mcontext_we),
    .csr_scontext_we(csr_scontext_we),
    .csr_wdata(csr_wdata),
    .csr_tselect(csr_tselect),
    .csr_tdata1(csr_tdata1),
    .csr_tdata2(csr_tdata2),
    .csr_tdata3(csr_tdata3),
    .csr_mcontext(csr_mcontext),
    .csr_scontext(csr_scontext),
    .csr_tinfo(csr_tinfo),
    .ipipe_csr_halt_taken(ipipe_csr_halt_taken),
    .trigm_i0_pc(trigm_i0_pc),
    .trigm_i1_pc(trigm_i1_pc),
    .trigm_i0_result(trigm_i0_result),
    .trigm_i1_result(trigm_i1_result),
    .trigm_ls_load(trigm_ls_load),
    .trigm_ls_store(trigm_ls_store),
    .trigm_ls_addr(trigm_ls_addr),
    .trigm_ls_result(trigm_ls_result),
    .trigm_int_code(trigm_int_code),
    .trigm_int_result(trigm_int_result),
    .trigm_xcpt_onehot(trigm_xcpt_onehot),
    .trigm_xcpt_result(trigm_xcpt_result),
    .trigm_icount_result(trigm_icount_result),
    .trigm_icount_valid(trigm_icount_valid),
    .trigm_icount_clr(trigm_icount_clr),
    .trigm_icount_enabled(trigm_icount_enabled),
    .trigm_trace_enabled(trigm_trace_enabled)
);
generate
    if (DCACHE_SIZE_KB != 0) begin:gen_dcu
        kv_dcu #(
            .CACHE_LINE_SIZE(CACHE_LINE_SIZE),
            .CM_SUPPORT_INT(CM_SUPPORT_INT),
            .DCACHE_DATA_RAM_AW(DCACHE_DATA_RAM_AW),
            .DCACHE_DATA_RAM_BWEW(DCACHE_DATA_RAM_BWEW),
            .DCACHE_DATA_RAM_DW(DCACHE_DATA_RAM_DW),
            .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT),
            .DCACHE_LRU_INT(DCACHE_LRU_INT),
            .DCACHE_SIZE_KB(DCACHE_SIZE_KB),
            .DCACHE_TAG_RAM_AW(DCACHE_TAG_RAM_AW),
            .DCACHE_TAG_RAM_DW(DCACHE_TAG_RAM_DW),
            .DCACHE_WAY(DCACHE_WAY),
            .DCACHE_WPT_RAM_AW(DCACHE_WPT_RAM_AW),
            .DCACHE_WPT_RAM_BWEW(DCACHE_WPT_RAM_BWEW),
            .DCACHE_WPT_RAM_DW(DCACHE_WPT_RAM_DW),
            .L2_ADDR_WIDTH(L2_ADDR_WIDTH),
            .L2_DATA_WIDTH(L2_DATA_WIDTH),
            .MSHR_DEPTH(MSHR_DEPTH),
            .PALEN(PALEN),
            .PERFORMANCE_MONITOR_INT(PERFORMANCE_MONITOR_INT),
            .SINK_WIDTH(TL_SINK_WIDTH),
            .WPT_SUPPORT(WPT_SUPPORT),
            .WRITE_AROUND_SUPPORT_INT(WRITE_AROUND_SUPPORT_INT)
        ) kv_dcu (
            .dcu_clk(dcu_clk),
            .dcu_reset_n(core_reset_n),
            .dcu_a_address(dcu_a_address),
            .dcu_a_corrupt(dcu_a_corrupt),
            .dcu_a_data(dcu_a_data),
            .dcu_a_mask(dcu_a_mask),
            .dcu_a_opcode(dcu_a_opcode),
            .dcu_a_param(dcu_a_param),
            .dcu_a_ready(dcu_a_ready),
            .dcu_a_size(dcu_a_size),
            .dcu_a_source(dcu_a_source),
            .dcu_a_user(dcu_a_user),
            .dcu_a_valid(dcu_a_valid),
            .dcu_b_address(dcu_b_address),
            .dcu_b_corrupt(dcu_b_corrupt),
            .dcu_b_data(dcu_b_data),
            .dcu_b_mask(dcu_b_mask),
            .dcu_b_opcode(dcu_b_opcode),
            .dcu_b_param(dcu_b_param),
            .dcu_b_ready(dcu_b_ready),
            .dcu_b_size(dcu_b_size),
            .dcu_b_source(dcu_b_source),
            .dcu_b_valid(dcu_b_valid),
            .dcu_c_address(dcu_c_address),
            .dcu_c_corrupt(dcu_c_corrupt),
            .dcu_c_data(dcu_c_data),
            .dcu_c_opcode(dcu_c_opcode),
            .dcu_c_param(dcu_c_param),
            .dcu_c_ready(dcu_c_ready),
            .dcu_c_size(dcu_c_size),
            .dcu_c_source(dcu_c_source),
            .dcu_c_user(dcu_c_user),
            .dcu_c_valid(dcu_c_valid),
            .dcu_d_corrupt(dcu_d_corrupt),
            .dcu_d_data(dcu_d_data),
            .dcu_d_denied(dcu_d_denied),
            .dcu_d_opcode(dcu_d_opcode),
            .dcu_d_param(dcu_d_param),
            .dcu_d_ready(dcu_d_ready),
            .dcu_d_sink(dcu_d_sink),
            .dcu_d_size(dcu_d_size),
            .dcu_d_source(dcu_d_source),
            .dcu_d_user(dcu_d_user),
            .dcu_d_valid(dcu_d_valid),
            .dcu_e_ready(dcu_e_ready),
            .dcu_e_sink(dcu_e_sink),
            .dcu_e_valid(dcu_e_valid),
            .csr_mcache_ctl_dc_eccen(csr_mcache_ctl_dc_eccen),
            .csr_mcache_ctl_dc_rwecc(csr_mcache_ctl_dc_rwecc),
            .csr_mecc_code(csr_mecc_code),
            .dcache_data0_addr(dcache_data0_addr),
            .dcache_data0_byte_we(dcache_data0_byte_we),
            .dcache_data0_cs(dcache_data0_cs),
            .dcache_data0_rdata(dcache_data0_rdata),
            .dcache_data0_wdata(dcache_data0_wdata),
            .dcache_data0_we(dcache_data0_we),
            .dcache_data1_addr(dcache_data1_addr),
            .dcache_data1_byte_we(dcache_data1_byte_we),
            .dcache_data1_cs(dcache_data1_cs),
            .dcache_data1_rdata(dcache_data1_rdata),
            .dcache_data1_wdata(dcache_data1_wdata),
            .dcache_data1_we(dcache_data1_we),
            .dcache_data2_addr(dcache_data2_addr),
            .dcache_data2_byte_we(dcache_data2_byte_we),
            .dcache_data2_cs(dcache_data2_cs),
            .dcache_data2_rdata(dcache_data2_rdata),
            .dcache_data2_wdata(dcache_data2_wdata),
            .dcache_data2_we(dcache_data2_we),
            .dcache_data3_addr(dcache_data3_addr),
            .dcache_data3_byte_we(dcache_data3_byte_we),
            .dcache_data3_cs(dcache_data3_cs),
            .dcache_data3_rdata(dcache_data3_rdata),
            .dcache_data3_wdata(dcache_data3_wdata),
            .dcache_data3_we(dcache_data3_we),
            .dcache_tag0_addr(dcache_tag0_addr),
            .dcache_tag0_cs(dcache_tag0_cs),
            .dcache_tag0_rdata(dcache_tag0_rdata),
            .dcache_tag0_wdata(dcache_tag0_wdata),
            .dcache_tag0_we(dcache_tag0_we),
            .dcache_tag1_addr(dcache_tag1_addr),
            .dcache_tag1_cs(dcache_tag1_cs),
            .dcache_tag1_rdata(dcache_tag1_rdata),
            .dcache_tag1_wdata(dcache_tag1_wdata),
            .dcache_tag1_we(dcache_tag1_we),
            .dcache_tag2_addr(dcache_tag2_addr),
            .dcache_tag2_cs(dcache_tag2_cs),
            .dcache_tag2_rdata(dcache_tag2_rdata),
            .dcache_tag2_wdata(dcache_tag2_wdata),
            .dcache_tag2_we(dcache_tag2_we),
            .dcache_tag3_addr(dcache_tag3_addr),
            .dcache_tag3_cs(dcache_tag3_cs),
            .dcache_tag3_rdata(dcache_tag3_rdata),
            .dcache_tag3_wdata(dcache_tag3_wdata),
            .dcache_tag3_we(dcache_tag3_we),
            .dcu_ack_id(dcu_ack_id),
            .dcu_ack_rdata(dcu_ack_rdata),
            .dcu_ack_status(dcu_ack_status),
            .dcu_ack_valid(dcu_ack_valid),
            .dcu_async_ecc_corr(dcu_async_ecc_corr),
            .dcu_async_ecc_error(dcu_async_ecc_error),
            .dcu_async_ecc_ramid(dcu_async_ecc_ramid),
            .dcu_async_write_error(dcu_async_write_error),
            .dcu_cmt_addr(dcu_cmt_addr),
            .dcu_cmt_func(dcu_cmt_func),
            .dcu_cmt_valid(dcu_cmt_valid),
            .dcu_cmt_wdata(dcu_cmt_wdata),
            .dcu_cmt_wmask(dcu_cmt_wmask),
            .dcu_event(dcu_event),
            .dcu_req_addr(dcu_req_addr),
            .dcu_req_func(dcu_req_func),
            .dcu_req_id(dcu_req_id),
            .dcu_req_ready(dcu_req_ready),
            .dcu_req_stall(dcu_req_stall),
            .dcu_req_valid(dcu_req_valid),
            .dcu_standby_ready(dcu_standby_ready),
            .dcu_wbf_flush(dcu_wbf_flush),
            .dcu_acctl_ecc_corr(dcu_acctl_ecc_corr),
            .dcu_acctl_ecc_error(dcu_acctl_ecc_error),
            .dcache_disable_init(dcache_disable_init),
            .dcu_ix_ack(dcu_ix_ack),
            .dcu_ix_addr(dcu_ix_addr),
            .dcu_ix_command(dcu_ix_command),
            .dcu_ix_raddr(dcu_ix_raddr),
            .dcu_ix_rdata(dcu_ix_rdata),
            .dcu_ix_req(dcu_ix_req),
            .dcu_ix_status(dcu_ix_status),
            .dcu_ix_wdata(dcu_ix_wdata),
            .dcu_cri_id(dcu_cri_id),
            .dcu_cri_nbload_result(dcu_cri_nbload_result),
            .dcu_cri_rdata(dcu_cri_rdata),
            .dcu_cri_status(dcu_cri_status),
            .dcu_cri_valid(dcu_cri_valid),
            .dcu_wna_pending(dcu_wna_pending),
            .mshr_event(mshr_event),
            .csr_mcache_ctl_dc_waround(csr_mcache_ctl_dc_waround),
            .dcache_wpt_addr(dcache_wpt_addr),
            .dcache_wpt_byte_we(dcache_wpt_byte_we),
            .dcache_wpt_cs(dcache_wpt_cs),
            .dcache_wpt_rdata(dcache_wpt_rdata),
            .dcache_wpt_wdata(dcache_wpt_wdata),
            .dcache_wpt_we(dcache_wpt_we)
        );
    end
endgenerate
generate
    if (DCACHE_SIZE_KB == 0) begin:gen_dcu_stub
        kv_dcu_stub #(
            .CACHE_LINE_SIZE(CACHE_LINE_SIZE),
            .CM_SUPPORT_INT(CM_SUPPORT_INT),
            .DCACHE_DATA_RAM_AW(DCACHE_DATA_RAM_AW),
            .DCACHE_DATA_RAM_BWEW(DCACHE_DATA_RAM_BWEW),
            .DCACHE_DATA_RAM_DW(DCACHE_DATA_RAM_DW),
            .DCACHE_ECC_TYPE_INT(DCACHE_ECC_TYPE_INT),
            .DCACHE_LRU_INT(DCACHE_LRU_INT),
            .DCACHE_SIZE_KB(DCACHE_SIZE_KB),
            .DCACHE_TAG_RAM_AW(DCACHE_TAG_RAM_AW),
            .DCACHE_TAG_RAM_DW(DCACHE_TAG_RAM_DW),
            .DCACHE_WAY(DCACHE_WAY),
            .DCACHE_WPT_RAM_AW(DCACHE_WPT_RAM_AW),
            .DCACHE_WPT_RAM_BWEW(DCACHE_WPT_RAM_BWEW),
            .DCACHE_WPT_RAM_DW(DCACHE_WPT_RAM_DW),
            .L2_ADDR_WIDTH(L2_ADDR_WIDTH),
            .L2_DATA_WIDTH(L2_DATA_WIDTH),
            .MSHR_DEPTH(MSHR_DEPTH),
            .PALEN(PALEN),
            .PERFORMANCE_MONITOR_INT(PERFORMANCE_MONITOR_INT),
            .SINK_WIDTH(TL_SINK_WIDTH),
            .WPT_SUPPORT(WPT_SUPPORT),
            .WRITE_AROUND_SUPPORT_INT(WRITE_AROUND_SUPPORT_INT)
        ) kv_dcu_stub (
            .dcu_clk(dcu_clk),
            .dcu_reset_n(core_reset_n),
            .dcu_a_address(dcu_a_address),
            .dcu_a_corrupt(dcu_a_corrupt),
            .dcu_a_data(dcu_a_data),
            .dcu_a_mask(dcu_a_mask),
            .dcu_a_opcode(dcu_a_opcode),
            .dcu_a_param(dcu_a_param),
            .dcu_a_ready(dcu_a_ready),
            .dcu_a_size(dcu_a_size),
            .dcu_a_source(dcu_a_source),
            .dcu_a_user(dcu_a_user),
            .dcu_a_valid(dcu_a_valid),
            .dcu_b_address(dcu_b_address),
            .dcu_b_corrupt(dcu_b_corrupt),
            .dcu_b_data(dcu_b_data),
            .dcu_b_mask(dcu_b_mask),
            .dcu_b_opcode(dcu_b_opcode),
            .dcu_b_param(dcu_b_param),
            .dcu_b_ready(dcu_b_ready),
            .dcu_b_size(dcu_b_size),
            .dcu_b_source(dcu_b_source),
            .dcu_b_valid(dcu_b_valid),
            .dcu_c_address(dcu_c_address),
            .dcu_c_corrupt(dcu_c_corrupt),
            .dcu_c_data(dcu_c_data),
            .dcu_c_opcode(dcu_c_opcode),
            .dcu_c_param(dcu_c_param),
            .dcu_c_ready(dcu_c_ready),
            .dcu_c_size(dcu_c_size),
            .dcu_c_source(dcu_c_source),
            .dcu_c_user(dcu_c_user),
            .dcu_c_valid(dcu_c_valid),
            .dcu_d_corrupt(dcu_d_corrupt),
            .dcu_d_data(dcu_d_data),
            .dcu_d_denied(dcu_d_denied),
            .dcu_d_opcode(dcu_d_opcode),
            .dcu_d_param(dcu_d_param),
            .dcu_d_ready(dcu_d_ready),
            .dcu_d_sink(dcu_d_sink),
            .dcu_d_size(dcu_d_size),
            .dcu_d_source(dcu_d_source),
            .dcu_d_user(dcu_d_user),
            .dcu_d_valid(dcu_d_valid),
            .dcu_e_ready(dcu_e_ready),
            .dcu_e_sink(dcu_e_sink),
            .dcu_e_valid(dcu_e_valid),
            .csr_mcache_ctl_dc_eccen(csr_mcache_ctl_dc_eccen),
            .csr_mcache_ctl_dc_rwecc(csr_mcache_ctl_dc_rwecc),
            .csr_mecc_code(csr_mecc_code),
            .dcache_data0_addr(dcache_data0_addr),
            .dcache_data0_byte_we(dcache_data0_byte_we),
            .dcache_data0_cs(dcache_data0_cs),
            .dcache_data0_rdata(dcache_data0_rdata),
            .dcache_data0_wdata(dcache_data0_wdata),
            .dcache_data0_we(dcache_data0_we),
            .dcache_data1_addr(dcache_data1_addr),
            .dcache_data1_byte_we(dcache_data1_byte_we),
            .dcache_data1_cs(dcache_data1_cs),
            .dcache_data1_rdata(dcache_data1_rdata),
            .dcache_data1_wdata(dcache_data1_wdata),
            .dcache_data1_we(dcache_data1_we),
            .dcache_data2_addr(dcache_data2_addr),
            .dcache_data2_byte_we(dcache_data2_byte_we),
            .dcache_data2_cs(dcache_data2_cs),
            .dcache_data2_rdata(dcache_data2_rdata),
            .dcache_data2_wdata(dcache_data2_wdata),
            .dcache_data2_we(dcache_data2_we),
            .dcache_data3_addr(dcache_data3_addr),
            .dcache_data3_byte_we(dcache_data3_byte_we),
            .dcache_data3_cs(dcache_data3_cs),
            .dcache_data3_rdata(dcache_data3_rdata),
            .dcache_data3_wdata(dcache_data3_wdata),
            .dcache_data3_we(dcache_data3_we),
            .dcache_tag0_addr(dcache_tag0_addr),
            .dcache_tag0_cs(dcache_tag0_cs),
            .dcache_tag0_rdata(dcache_tag0_rdata),
            .dcache_tag0_wdata(dcache_tag0_wdata),
            .dcache_tag0_we(dcache_tag0_we),
            .dcache_tag1_addr(dcache_tag1_addr),
            .dcache_tag1_cs(dcache_tag1_cs),
            .dcache_tag1_rdata(dcache_tag1_rdata),
            .dcache_tag1_wdata(dcache_tag1_wdata),
            .dcache_tag1_we(dcache_tag1_we),
            .dcache_tag2_addr(dcache_tag2_addr),
            .dcache_tag2_cs(dcache_tag2_cs),
            .dcache_tag2_rdata(dcache_tag2_rdata),
            .dcache_tag2_wdata(dcache_tag2_wdata),
            .dcache_tag2_we(dcache_tag2_we),
            .dcache_tag3_addr(dcache_tag3_addr),
            .dcache_tag3_cs(dcache_tag3_cs),
            .dcache_tag3_rdata(dcache_tag3_rdata),
            .dcache_tag3_wdata(dcache_tag3_wdata),
            .dcache_tag3_we(dcache_tag3_we),
            .dcu_ack_id(dcu_ack_id),
            .dcu_ack_rdata(dcu_ack_rdata),
            .dcu_ack_status(dcu_ack_status),
            .dcu_ack_valid(dcu_ack_valid),
            .dcu_async_write_error(dcu_async_write_error),
            .dcu_cmt_addr(dcu_cmt_addr),
            .dcu_cmt_func(dcu_cmt_func),
            .dcu_cmt_valid(dcu_cmt_valid),
            .dcu_cmt_wdata(dcu_cmt_wdata),
            .dcu_cmt_wmask(dcu_cmt_wmask),
            .dcu_event(dcu_event),
            .dcu_req_addr(dcu_req_addr),
            .dcu_req_func(dcu_req_func),
            .dcu_req_id(dcu_req_id),
            .dcu_req_ready(dcu_req_ready),
            .dcu_req_stall(dcu_req_stall),
            .dcu_req_valid(dcu_req_valid),
            .dcu_standby_ready(dcu_standby_ready),
            .dcu_acctl_ecc_corr(dcu_acctl_ecc_corr),
            .dcu_acctl_ecc_error(dcu_acctl_ecc_error),
            .dcu_async_ecc_corr(dcu_async_ecc_corr),
            .dcu_async_ecc_error(dcu_async_ecc_error),
            .dcu_async_ecc_ramid(dcu_async_ecc_ramid),
            .dcache_disable_init(dcache_disable_init),
            .dcu_ix_ack(dcu_ix_ack),
            .dcu_ix_addr(dcu_ix_addr),
            .dcu_ix_command(dcu_ix_command),
            .dcu_ix_raddr(dcu_ix_raddr),
            .dcu_ix_rdata(dcu_ix_rdata),
            .dcu_ix_req(dcu_ix_req),
            .dcu_ix_status(dcu_ix_status),
            .dcu_ix_wdata(dcu_ix_wdata),
            .dcu_cri_id(dcu_cri_id),
            .dcu_cri_nbload_result(dcu_cri_nbload_result),
            .dcu_cri_rdata(dcu_cri_rdata),
            .dcu_cri_status(dcu_cri_status),
            .dcu_cri_valid(dcu_cri_valid),
            .dcu_wna_pending(dcu_wna_pending),
            .mshr_event(mshr_event),
            .csr_mcache_ctl_dc_waround(csr_mcache_ctl_dc_waround),
            .dcu_wbf_flush(dcu_wbf_flush),
            .dcache_wpt_addr(dcache_wpt_addr),
            .dcache_wpt_byte_we(dcache_wpt_byte_we),
            .dcache_wpt_cs(dcache_wpt_cs),
            .dcache_wpt_rdata(dcache_wpt_rdata),
            .dcache_wpt_wdata(dcache_wpt_wdata),
            .dcache_wpt_we(dcache_wpt_we)
        );
    end
endgenerate
kv_bpu #(
    .BTB_RAM_ADDR_WIDTH(BTB_RAM_ADDR_WIDTH),
    .BTB_RAM_DATA_WIDTH(BTB_RAM_DATA_WIDTH),
    .BTB_SIZE(BTB_SIZE),
    .EXTVALEN(EXTVALEN),
    .VALEN(VALEN)
) kv_bpu (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .reset_vector(reset_vector),
    .resume(resume),
    .redirect(redirect),
    .redirect_pc(redirect_pc),
    .redirect_ras_ptr(redirect_ras_ptr),
    .btb_init_done(btb_init_done),
    .btb_flush_valid(btb_flush_valid),
    .btb_flush_ready(btb_flush_ready),
    .btb_update_p0(btb_update_p0),
    .btb_update_p0_alloc(btb_update_p0_alloc),
    .btb_update_p0_start_pc(btb_update_p0_start_pc),
    .btb_update_p0_target_pc(btb_update_p0_target_pc),
    .btb_update_p0_blk_offset(btb_update_p0_blk_offset),
    .btb_update_p0_ucond(btb_update_p0_ucond),
    .btb_update_p0_call(btb_update_p0_call),
    .btb_update_p0_ret(btb_update_p0_ret),
    .btb_update_p0_way(btb_update_p0_way),
    .btb_update_p0_hold(btb_update_p0_hold),
    .btb_update_p1(btb_update_p1),
    .btb_update_p1_alloc(btb_update_p1_alloc),
    .btb_update_p1_start_pc(btb_update_p1_start_pc),
    .btb_update_p1_target_pc(btb_update_p1_target_pc),
    .btb_update_p1_blk_offset(btb_update_p1_blk_offset),
    .btb_update_p1_ucond(btb_update_p1_ucond),
    .btb_update_p1_call(btb_update_p1_call),
    .btb_update_p1_ret(btb_update_p1_ret),
    .btb_update_p1_way(btb_update_p1_way),
    .btb_update_p1_hold(btb_update_p1_hold),
    .bhr_recover(bhr_recover),
    .bhr_recover_data(bhr_recover_data),
    .bht_update_p0(bht_update_p0),
    .bht_update_p0_dir_addr(bht_update_p0_dir_addr),
    .bht_update_p0_sel_addr(bht_update_p0_sel_addr),
    .bht_update_p0_sel_data(bht_update_p0_sel_data),
    .bht_update_p0_dir_data(bht_update_p0_dir_data),
    .bht_update_p1(bht_update_p1),
    .bht_update_p1_dir_addr(bht_update_p1_dir_addr),
    .bht_update_p1_sel_addr(bht_update_p1_sel_addr),
    .bht_update_p1_sel_data(bht_update_p1_sel_data),
    .bht_update_p1_dir_data(bht_update_p1_dir_data),
    .btb0_addr(btb0_addr),
    .btb0_cs(btb0_cs),
    .btb0_we(btb0_we),
    .btb0_rdata(btb0_rdata),
    .btb0_wdata(btb0_wdata),
    .btb1_addr(btb1_addr),
    .btb1_cs(btb1_cs),
    .btb1_we(btb1_we),
    .btb1_rdata(btb1_rdata),
    .btb1_wdata(btb1_wdata),
    .csr_mmisc_ctl_brpe(csr_mmisc_ctl_brpe),
    .csr_cur_privilege(csr_cur_privilege),
    .csr_halt_mode(csr_halt_mode),
    .bpu_rd_valid(bpu_rd_valid),
    .bpu_rd_ack(bpu_rd_ack),
    .bpu_info_hit(bpu_info_hit),
    .bpu_info_fall_thru_pc(bpu_info_fall_thru_pc),
    .bpu_info_target(bpu_info_target),
    .bpu_info_start_pc(bpu_info_start_pc),
    .bpu_info_offset(bpu_info_offset),
    .bpu_info_way(bpu_info_way),
    .bpu_info_ucond(bpu_info_ucond),
    .bpu_info_ret(bpu_info_ret),
    .bpu_info_pred_taken(bpu_info_pred_taken),
    .bpu_info_pred_cnt(bpu_info_pred_cnt),
    .bpu_rd_ready(bpu_rd_ready)
);
kv_ifu #(
    .BTB_SIZE(BTB_SIZE),
    .DEVICE_REGION0_BASE(DEVICE_REGION0_BASE),
    .DEVICE_REGION0_MASK(DEVICE_REGION0_MASK),
    .DEVICE_REGION1_BASE(DEVICE_REGION1_BASE),
    .DEVICE_REGION1_MASK(DEVICE_REGION1_MASK),
    .DEVICE_REGION2_BASE(DEVICE_REGION2_BASE),
    .DEVICE_REGION2_MASK(DEVICE_REGION2_MASK),
    .DEVICE_REGION3_BASE(DEVICE_REGION3_BASE),
    .DEVICE_REGION3_MASK(DEVICE_REGION3_MASK),
    .DEVICE_REGION4_BASE(DEVICE_REGION4_BASE),
    .DEVICE_REGION4_MASK(DEVICE_REGION4_MASK),
    .DEVICE_REGION5_BASE(DEVICE_REGION5_BASE),
    .DEVICE_REGION5_MASK(DEVICE_REGION5_MASK),
    .DEVICE_REGION6_BASE(DEVICE_REGION6_BASE),
    .DEVICE_REGION6_MASK(DEVICE_REGION6_MASK),
    .DEVICE_REGION7_BASE(DEVICE_REGION7_BASE),
    .DEVICE_REGION7_MASK(DEVICE_REGION7_MASK),
    .EXTVALEN(EXTVALEN),
    .ICACHE_INDEX_MSB(ICACHE_INDEX_MSB),
    .ICACHE_SIZE_KB(ICACHE_SIZE_KB),
    .ICACHE_TAG_ECC_DW(ICACHE_TAG_ECC_DW),
    .ICACHE_TAG_RAM_AW(ICACHE_TAG_RAM_AW),
    .ICACHE_TAG_RAM_DW(ICACHE_TAG_RAM_DW),
    .ICACHE_WAY(ICACHE_WAY),
    .ILM_AMSB(ILM_AMSB),
    .ILM_BASE(ILM_BASE),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .LM_ENABLE_CTRL_INT(0),
    .MMU_SCHEME_INT(MMU_SCHEME_INT),
    .PALEN(PALEN),
    .VALEN(VALEN)
) kv_ifu (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .lm_reset_done(lm_reset_done),
    .icache_disable_init(icache_disable_init),
    .btb_init_done(btb_init_done),
    .ifu_fence_req(ifu_fence_req),
    .ifu_fence_done(ifu_fence_done),
    .ifu_event(ifu_event),
    .resume(resume),
    .resume_for_replay(resume_for_replay),
    .resume_pc(resume_pc),
    .resume_vectored(resume_vectored),
    .retry(retry),
    .retry_pc(retry_pc),
    .redirect(redirect),
    .redirect_for_cti(redirect_for_cti),
    .redirect_pc(redirect_pc),
    .redirect_pc_hit_ilm(redirect_pc_hit_ilm),
    .redirect_ras_ptr(redirect_ras_ptr),
    .ipipe_ifu_stall(ipipe_ifu_stall),
    .ifu_ipipe_standby_ready(ifu_ipipe_standby_ready),
    .ifu_ipipe_init_done(ifu_ipipe_init_done),
    .ex9_lookup_valid(ex9_lookup_valid),
    .ex9_lookup_pc(ex9_lookup_pc),
    .ex9_lookup_ready(ex9_lookup_ready),
    .ex9_lookup_resp_valid(ex9_lookup_resp_valid),
    .ex9_lookup_resp_ready(ex9_lookup_resp_ready),
    .ex9_lookup_resp_instr(ex9_lookup_resp_instr),
    .ex9_lookup_resp_fault(ex9_lookup_resp_fault),
    .ex9_lookup_resp_fault_dcause(ex9_lookup_resp_fault_dcause),
    .ex9_lookup_resp_page_fault(ex9_lookup_resp_page_fault),
    .ex9_lookup_resp_ecc_corr(ex9_lookup_resp_ecc_corr),
    .ex9_lookup_resp_ecc_code(ex9_lookup_resp_ecc_code),
    .ex9_lookup_resp_ecc_ramid(ex9_lookup_resp_ecc_ramid),
    .ifu_ilm_kill(ifu_ilm_kill),
    .ifu_ilm_req_valid(ifu_ilm_req_valid),
    .ifu_ilm_req_stall(ifu_ilm_req_stall),
    .ifu_ilm_req_addr(ifu_ilm_req_addr),
    .ifu_ilm_req_tag(ifu_ilm_req_tag),
    .ilm_ifu_req_ready(ilm_ifu_req_ready),
    .ilm_ifu_resp_valid(ilm_ifu_resp_valid),
    .ilm_ifu_resp_rdata(ilm_ifu_resp_rdata),
    .ilm_ifu_resp_tag(ilm_ifu_resp_tag),
    .ilm_ifu_resp_status(ilm_ifu_resp_status),
    .ifu_icu_kill(ifu_icu_kill),
    .icu_ifu_bus_req_full(icu_ifu_bus_req_full),
    .icu_ifu_bus_req_event(icu_ifu_bus_req_event),
    .ifu_icu_req_valid(ifu_icu_req_valid),
    .ifu_icu_req_type(ifu_icu_req_type),
    .ifu_icu_req_addr(ifu_icu_req_addr),
    .ifu_icu_req_nonseq(ifu_icu_req_nonseq),
    .ifu_icu_req_rd_word(ifu_icu_req_rd_word),
    .ifu_icu_req_tag(ifu_icu_req_tag),
    .ifu_icu_f1_pa(ifu_icu_f1_pa),
    .ifu_icu_f2_cacheable(ifu_icu_f2_cacheable),
    .ifu_icu_f2_cctl_pref(ifu_icu_f2_cctl_pref),
    .ifu_icu_req_wdata(ifu_icu_req_wdata),
    .ifu_icu_req_wecc(ifu_icu_req_wecc),
    .icu_ifu_req_ready(icu_ifu_req_ready),
    .icu_ifu_resp_valid(icu_ifu_resp_valid),
    .icu_ifu_resp_tag(icu_ifu_resp_tag),
    .icu_ifu_resp_status(icu_ifu_resp_status),
    .icu_ifu_resp_rdata(icu_ifu_resp_rdata),
    .ifu_icu_line_aq(ifu_icu_line_aq),
    .ifu_icu_line_aq_addr(ifu_icu_line_aq_addr),
    .ifu_icu_line_aq_index(ifu_icu_line_aq_index),
    .ifu_icu_line_aq_attri(ifu_icu_line_aq_attri),
    .icu_ifu_line_aq_error(icu_ifu_line_aq_error),
    .icu_ifu_line_aq_done(icu_ifu_line_aq_done),
    .ifu_icu_line_op_req(ifu_icu_line_op_req),
    .ifu_icu_line_op(ifu_icu_line_op),
    .icu_ifu_line_op_req_done(icu_ifu_line_op_req_done),
    .icu_standby_ready(icu_standby_ready),
    .ifu_itlb_req_valid(ifu_itlb_req_valid),
    .ifu_itlb_va(ifu_itlb_va),
    .itlb_ifu_pa(itlb_ifu_pa),
    .itlb_ifu_status(itlb_ifu_status),
    .ifu_mmu_req_valid(ifu_mmu_req_valid),
    .ifu_mmu_va(ifu_mmu_va),
    .mmu_ifu_resp_valid(mmu_ifu_resp_valid),
    .ifu_pmp_req_pa(ifu_pmp_req_pa),
    .pmp_ifu_resp_fault(pmp_ifu_resp_fault),
    .ifu_pma_req_pa(ifu_pma_req_pa),
    .pma_ifu_resp_fault(pma_ifu_resp_fault),
    .pma_ifu_resp_mtype(pma_ifu_resp_mtype),
    .csr_milmb_ien(csr_milmb_ien),
    .csr_milmb_eccen(csr_milmb_eccen),
    .csr_mmisc_ctl_brpe(csr_mmisc_ctl_brpe),
    .csr_trap_delegated(csr_trap_delegated),
    .csr_halt_mode(csr_halt_mode),
    .csr_mcache_ctl_iprefetch_en(csr_mcache_ctl_iprefetch_en),
    .csr_mcache_ctl_ic_en(csr_mcache_ctl_ic_en),
    .csr_mxstatus_ime(csr_mxstatus_ime),
    .csr_mcache_ctl_ic_eccen(csr_mcache_ctl_ic_eccen),
    .csr_mcache_ctl_ic_rwecc(csr_mcache_ctl_ic_rwecc),
    .csr_mecc_code(csr_mecc_code),
    .csr_cur_privilege(csr_cur_privilege),
    .ifu_i0_valid(ifu_i0_valid),
    .ifu_i0_pc(ifu_i0_pc),
    .ifu_i0_instr(ifu_i0_instr),
    .ifu_i0_vector_resume(ifu_i0_vector_resume),
    .ifu_i0_instr_16b(ifu_i0_instr_16b),
    .ifu_i0_keep_bhr(ifu_i0_keep_bhr),
    .ifu_i0_pred_valid(ifu_i0_pred_valid),
    .ifu_i0_pred_hit(ifu_i0_pred_hit),
    .ifu_i0_pred_way(ifu_i0_pred_way),
    .ifu_i0_pred_taken(ifu_i0_pred_taken),
    .ifu_i0_pred_ret(ifu_i0_pred_ret),
    .ifu_i0_pred_cnt(ifu_i0_pred_cnt),
    .ifu_i0_pred_npc(ifu_i0_pred_npc),
    .ifu_i0_pred_start(ifu_i0_pred_start),
    .ifu_i0_pred_brk(ifu_i0_pred_brk),
    .ifu_i0_pred_bogus(ifu_i0_pred_bogus),
    .ifu_i0_fault(ifu_i0_fault),
    .ifu_i0_fault_dcause(ifu_i0_fault_dcause),
    .ifu_i0_page_fault(ifu_i0_page_fault),
    .ifu_i0_fault_upper(ifu_i0_fault_upper),
    .ifu_i0_ecc_corr(ifu_i0_ecc_corr),
    .ifu_i0_ecc_code(ifu_i0_ecc_code),
    .ifu_i0_ecc_ramid(ifu_i0_ecc_ramid),
    .ifu_i0_ready(ifu_i0_ready),
    .ifu_i1_valid(ifu_i1_valid),
    .ifu_i1_pc(ifu_i1_pc),
    .ifu_i1_instr(ifu_i1_instr),
    .ifu_i1_vector_resume(ifu_i1_vector_resume),
    .ifu_i1_instr_16b(ifu_i1_instr_16b),
    .ifu_i1_keep_bhr(ifu_i1_keep_bhr),
    .ifu_i1_pred_valid(ifu_i1_pred_valid),
    .ifu_i1_pred_hit(ifu_i1_pred_hit),
    .ifu_i1_pred_way(ifu_i1_pred_way),
    .ifu_i1_pred_taken(ifu_i1_pred_taken),
    .ifu_i1_pred_ret(ifu_i1_pred_ret),
    .ifu_i1_pred_cnt(ifu_i1_pred_cnt),
    .ifu_i1_pred_npc(ifu_i1_pred_npc),
    .ifu_i1_pred_start(ifu_i1_pred_start),
    .ifu_i1_pred_brk(ifu_i1_pred_brk),
    .ifu_i1_pred_bogus(ifu_i1_pred_bogus),
    .ifu_i1_fault(ifu_i1_fault),
    .ifu_i1_fault_dcause(ifu_i1_fault_dcause),
    .ifu_i1_page_fault(ifu_i1_page_fault),
    .ifu_i1_fault_upper(ifu_i1_fault_upper),
    .ifu_i1_ecc_corr(ifu_i1_ecc_corr),
    .ifu_i1_ecc_code(ifu_i1_ecc_code),
    .ifu_i1_ecc_ramid(ifu_i1_ecc_ramid),
    .ifu_i1_ready(ifu_i1_ready),
    .ifu_cctl_req(ifu_cctl_req),
    .ifu_cctl_command(ifu_cctl_command),
    .ifu_cctl_waddr(ifu_cctl_waddr),
    .ifu_cctl_wdata(ifu_cctl_wdata),
    .ifu_cctl_ack(ifu_cctl_ack),
    .ifu_cctl_status(ifu_cctl_status),
    .ifu_cctl_rdata(ifu_cctl_rdata),
    .ifu_cctl_raddr(ifu_cctl_raddr),
    .ifu_cctl_ecc_status(ifu_cctl_ecc_status),
    .bpu_rd_valid(bpu_rd_valid),
    .bpu_rd_ack(bpu_rd_ack),
    .bpu_info_hit(bpu_info_hit),
    .bpu_info_fall_thru_pc(bpu_info_fall_thru_pc),
    .bpu_info_target(bpu_info_target),
    .bpu_info_start_pc(bpu_info_start_pc),
    .bpu_info_offset(bpu_info_offset),
    .bpu_info_way(bpu_info_way),
    .bpu_info_ucond(bpu_info_ucond),
    .bpu_info_ret(bpu_info_ret),
    .bpu_info_pred_taken(bpu_info_pred_taken),
    .bpu_info_pred_cnt(bpu_info_pred_cnt),
    .bpu_rd_ready(bpu_rd_ready)
);
kv_icu #(
    .CACHE_LINE_SIZE(CACHE_LINE_SIZE),
    .EXTVALEN(EXTVALEN),
    .ICACHE_DATA_ECC_DW(ICACHE_DATA_ECC_DW),
    .ICACHE_DATA_RAM_AW(ICACHE_DATA_RAM_AW),
    .ICACHE_DATA_RAM_DW(ICACHE_DATA_RAM_DW),
    .ICACHE_ECC_TYPE_INT(ICACHE_ECC_TYPE_INT),
    .ICACHE_FIRST_WORD_FIRST_INT(1),
    .ICACHE_INDEX_MSB(ICACHE_INDEX_MSB),
    .ICACHE_LRU_INT(ICACHE_LRU_INT),
    .ICACHE_SIZE_KB(ICACHE_SIZE_KB),
    .ICACHE_TAG_ECC_DW(ICACHE_TAG_ECC_DW),
    .ICACHE_TAG_RAM_AW(ICACHE_TAG_RAM_AW),
    .ICACHE_TAG_RAM_DW(ICACHE_TAG_RAM_DW),
    .ICACHE_WAY(ICACHE_WAY),
    .L2_ADDR_WIDTH(L2_ADDR_WIDTH),
    .L2_DATA_WIDTH(L2_DATA_WIDTH),
    .PALEN(PALEN),
    .TL_SINK_WIDTH(TL_SINK_WIDTH),
    .TL_SIZE_WIDTH(TL_SIZE_WIDTH),
    .VALEN(VALEN)
) kv_icu (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_mcache_ctl_ic_en(csr_mcache_ctl_ic_en),
    .csr_halt_mode(csr_halt_mode),
    .cur_privilege_m(cur_privilege_m),
    .cur_privilege_s(cur_privilege_s),
    .cur_privilege_u(cur_privilege_u),
    .ifu_icu_kill(ifu_icu_kill),
    .icu_ifu_bus_req_full(icu_ifu_bus_req_full),
    .icu_ifu_bus_req_event(icu_ifu_bus_req_event),
    .ifu_icu_req_valid(ifu_icu_req_valid),
    .ifu_icu_req_type(ifu_icu_req_type),
    .ifu_icu_req_addr(ifu_icu_req_addr),
    .ifu_icu_req_nonseq(ifu_icu_req_nonseq),
    .ifu_icu_req_rd_word(ifu_icu_req_rd_word),
    .ifu_icu_req_tag(ifu_icu_req_tag),
    .ifu_icu_f1_pa(ifu_icu_f1_pa),
    .ifu_icu_f2_cacheable(ifu_icu_f2_cacheable),
    .ifu_icu_f2_cctl_pref(ifu_icu_f2_cctl_pref),
    .ifu_icu_req_wdata(ifu_icu_req_wdata),
    .ifu_icu_req_wecc(ifu_icu_req_wecc),
    .icu_ifu_req_ready(icu_ifu_req_ready),
    .icu_ifu_resp_valid(icu_ifu_resp_valid),
    .icu_ifu_resp_tag(icu_ifu_resp_tag),
    .icu_ifu_resp_rdata(icu_ifu_resp_rdata),
    .icu_ifu_resp_status(icu_ifu_resp_status),
    .ifu_icu_line_aq(ifu_icu_line_aq),
    .ifu_icu_line_aq_addr(ifu_icu_line_aq_addr),
    .ifu_icu_line_aq_index(ifu_icu_line_aq_index),
    .ifu_icu_line_aq_attri(ifu_icu_line_aq_attri),
    .icu_ifu_line_aq_error(icu_ifu_line_aq_error),
    .icu_ifu_line_aq_done(icu_ifu_line_aq_done),
    .ifu_icu_line_op_req(ifu_icu_line_op_req),
    .ifu_icu_line_op(ifu_icu_line_op),
    .icu_ifu_line_op_req_done(icu_ifu_line_op_req_done),
    .icu_standby_ready(icu_standby_ready),
    .icu_a_opcode(icu_a_opcode),
    .icu_a_param(icu_a_param),
    .icu_a_size(icu_a_size),
    .icu_a_address(icu_a_address),
    .icu_a_data(icu_a_data),
    .icu_a_mask(icu_a_mask),
    .icu_a_corrupt(icu_a_corrupt),
    .icu_a_user(icu_a_user),
    .icu_a_source(icu_a_source),
    .icu_a_valid(icu_a_valid),
    .icu_a_ready(icu_a_ready),
    .icu_d_opcode(icu_d_opcode),
    .icu_d_param(icu_d_param),
    .icu_d_size(icu_d_size),
    .icu_d_data(icu_d_data),
    .icu_d_denied(icu_d_denied),
    .icu_d_corrupt(icu_d_corrupt),
    .icu_d_user(icu_d_user),
    .icu_d_source(icu_d_source),
    .icu_d_sink(icu_d_sink),
    .icu_d_valid(icu_d_valid),
    .icu_d_ready(icu_d_ready),
    .icache_tag0_cs(icache_tag0_cs),
    .icache_tag0_wdata(icache_tag0_wdata),
    .icache_tag0_rdata(icache_tag0_rdata),
    .icache_tag0_we(icache_tag0_we),
    .icache_tag0_addr(icache_tag0_addr),
    .icache_data0_cs(icache_data0_cs),
    .icache_data0_wdata(icache_data0_wdata),
    .icache_data0_we(icache_data0_we),
    .icache_data0_addr(icache_data0_addr),
    .icache_data0_rdata(icache_data0_rdata),
    .icache_tag1_cs(icache_tag1_cs),
    .icache_tag1_wdata(icache_tag1_wdata),
    .icache_tag1_rdata(icache_tag1_rdata),
    .icache_tag1_we(icache_tag1_we),
    .icache_tag1_addr(icache_tag1_addr),
    .icache_data1_cs(icache_data1_cs),
    .icache_data1_wdata(icache_data1_wdata),
    .icache_data1_we(icache_data1_we),
    .icache_data1_addr(icache_data1_addr),
    .icache_data1_rdata(icache_data1_rdata),
    .icache_tag2_cs(icache_tag2_cs),
    .icache_tag2_wdata(icache_tag2_wdata),
    .icache_tag2_rdata(icache_tag2_rdata),
    .icache_tag2_we(icache_tag2_we),
    .icache_tag2_addr(icache_tag2_addr),
    .icache_data2_cs(icache_data2_cs),
    .icache_data2_wdata(icache_data2_wdata),
    .icache_data2_we(icache_data2_we),
    .icache_data2_addr(icache_data2_addr),
    .icache_data2_rdata(icache_data2_rdata),
    .icache_tag3_cs(icache_tag3_cs),
    .icache_tag3_wdata(icache_tag3_wdata),
    .icache_tag3_rdata(icache_tag3_rdata),
    .icache_tag3_we(icache_tag3_we),
    .icache_tag3_addr(icache_tag3_addr),
    .icache_data3_cs(icache_data3_cs),
    .icache_data3_wdata(icache_data3_wdata),
    .icache_data3_we(icache_data3_we),
    .icache_data3_addr(icache_data3_addr),
    .icache_data3_rdata(icache_data3_rdata),
    .icache_data4_cs(icache_data4_cs),
    .icache_data4_wdata(icache_data4_wdata),
    .icache_data4_we(icache_data4_we),
    .icache_data4_addr(icache_data4_addr),
    .icache_data4_rdata(icache_data4_rdata),
    .icache_data5_cs(icache_data5_cs),
    .icache_data5_wdata(icache_data5_wdata),
    .icache_data5_we(icache_data5_we),
    .icache_data5_addr(icache_data5_addr),
    .icache_data5_rdata(icache_data5_rdata),
    .icache_data6_cs(icache_data6_cs),
    .icache_data6_wdata(icache_data6_wdata),
    .icache_data6_we(icache_data6_we),
    .icache_data6_addr(icache_data6_addr),
    .icache_data6_rdata(icache_data6_rdata),
    .icache_data7_cs(icache_data7_cs),
    .icache_data7_wdata(icache_data7_wdata),
    .icache_data7_we(icache_data7_we),
    .icache_data7_addr(icache_data7_addr),
    .icache_data7_rdata(icache_data7_rdata)
);
generate
    if (1'b1 && (ILM_SIZE_KB != 0)) begin:gen_ifu_ilm_brg
        kv_ifu_ilm_brg #(
            .ILM_AMSB(ILM_AMSB),
            .VALEN(VALEN)
        ) u_ifu_ilm_brg (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .ifu_ilm_kill(ifu_ilm_kill),
            .ifu_ilm_req_valid(ifu_ilm_req_valid),
            .ifu_ilm_req_stall(ifu_ilm_req_stall),
            .ifu_ilm_req_addr(ifu_ilm_req_addr),
            .ifu_ilm_req_tag(ifu_ilm_req_tag),
            .ilm_ifu_req_ready(ilm_ifu_req_ready),
            .ilm_ifu_resp_valid(ilm_ifu_resp_valid),
            .ilm_ifu_resp_rdata(ilm_ifu_resp_rdata),
            .ilm_ifu_resp_tag(ilm_ifu_resp_tag),
            .ilm_ifu_resp_status(ilm_ifu_resp_status),
            .ifu_ilm_a_addr(ifu_ilm_a_addr),
            .ifu_ilm_a_func(ifu_ilm_a_func),
            .ifu_ilm_a_ready(ifu_ilm_a_ready),
            .ifu_ilm_a_stall(ifu_ilm_a_stall),
            .ifu_ilm_a_user(ifu_ilm_a_user),
            .ifu_ilm_a_valid(ifu_ilm_a_valid),
            .ifu_ilm_d_data(ifu_ilm_d_data),
            .ifu_ilm_d_status(ifu_ilm_d_status),
            .ifu_ilm_d_user(ifu_ilm_d_user),
            .ifu_ilm_d_valid(ifu_ilm_d_valid)
        );
    end
endgenerate
generate
    if (1'b1 && (ILM_SIZE_KB == 0)) begin:gen_ifu_ilm_brg_stub
        kv_ifu_ilm_brg_stub #(
            .ILM_AMSB(ILM_AMSB),
            .VALEN(VALEN)
        ) u_ifu_ilm_brg_stub (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .ifu_ilm_kill(ifu_ilm_kill),
            .ifu_ilm_req_valid(ifu_ilm_req_valid),
            .ifu_ilm_req_stall(ifu_ilm_req_stall),
            .ifu_ilm_req_addr(ifu_ilm_req_addr),
            .ifu_ilm_req_tag(ifu_ilm_req_tag),
            .ilm_ifu_req_ready(ilm_ifu_req_ready),
            .ilm_ifu_resp_valid(ilm_ifu_resp_valid),
            .ilm_ifu_resp_rdata(ilm_ifu_resp_rdata),
            .ilm_ifu_resp_tag(ilm_ifu_resp_tag),
            .ilm_ifu_resp_status(ilm_ifu_resp_status),
            .ifu_ilm_a_addr(ifu_ilm_a_addr),
            .ifu_ilm_a_func(ifu_ilm_a_func),
            .ifu_ilm_a_ready(ifu_ilm_a_ready),
            .ifu_ilm_a_stall(ifu_ilm_a_stall),
            .ifu_ilm_a_user(ifu_ilm_a_user),
            .ifu_ilm_a_valid(ifu_ilm_a_valid),
            .ifu_ilm_d_data(ifu_ilm_d_data),
            .ifu_ilm_d_status(ifu_ilm_d_status),
            .ifu_ilm_d_user(ifu_ilm_d_user),
            .ifu_ilm_d_valid(ifu_ilm_d_valid)
        );
    end
endgenerate
generate
    if ((ILM_SIZE_KB == 0) && (DLM_SIZE_KB == 0)) begin:gen_lm_rstgen_stub
        kv_lm_rstgen_stub u_lm_rstgen_stub(
            .core_reset_n(core_reset_n),
            .slv_reset_n(slv_reset_n),
            .slv1_reset_n(slv1_reset_n),
            .lm_clk(lm_clk),
            .slv_clk(slv_clk),
            .slv1_clk(slv1_clk),
            .test_mode(test_mode),
            .lm_reset_n(lm_reset_n),
            .slv_reset_n_int(slv_reset_n_int),
            .slv1_reset_n_int(slv1_reset_n_int)
        );
    end
endgenerate
generate
    if ((ILM_SIZE_KB != 0) || (DLM_SIZE_KB != 0)) begin:gen_lm_rstgen
        kv_lm_rstgen #(
            .SLAVE_PORT_ASYNC_SUPPORT(SLAVE_PORT_ASYNC_SUPPORT),
            .SLAVE_PORT_SUPPORT_INT(SLAVE_PORT_SUPPORT_INT)
        ) u_lm_rstgen (
            .core_reset_n(core_reset_n),
            .slv_reset_n(slv_reset_n),
            .slv1_reset_n(slv1_reset_n),
            .lm_clk(lm_clk),
            .slv_clk(slv_clk),
            .slv1_clk(slv1_clk),
            .test_mode(test_mode),
            .lm_reset_n(lm_reset_n),
            .slv_reset_n_int(slv_reset_n_int),
            .slv1_reset_n_int(slv1_reset_n_int)
        );
    end
endgenerate
generate
    if ((ILM_SIZE_KB != 0) || (DLM_SIZE_KB != 0)) begin:gen_lm_local_int
        kv_lm_local_int #(
            .SLAVE_PORT_SUPPORT(SLAVE_PORT_SUPPORT_INT)
        ) u_lm_local_int (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .ilm_async_write_error(ilm_async_write_error),
            .dlm0_async_write_error(dlm0_async_write_error),
            .dlm1_async_write_error(dlm1_async_write_error),
            .dlm2_async_write_error(dlm2_async_write_error),
            .dlm3_async_write_error(dlm3_async_write_error),
            .slvp_async_ecc_corr(slvp_async_ecc_corr),
            .slvp_async_ecc_ramid(slvp_async_ecc_ramid),
            .slvp_async_local_int(slvp_async_local_int),
            .lm_async_write_error(lm_async_write_error),
            .slvp_ipipe_ecc_corr(slvp_ipipe_ecc_corr),
            .slvp_ipipe_ecc_ramid(slvp_ipipe_ecc_ramid),
            .slvp_ipipe_local_int(slvp_ipipe_local_int),
            .lm_local_int(lm_local_int)
        );
    end
endgenerate
generate
    if ((ILM_SIZE_KB == 0) && (DLM_SIZE_KB == 0)) begin:gen_lm_local_int_stub
        kv_lm_local_int_stub #(
            .SLAVE_PORT_SUPPORT(SLAVE_PORT_SUPPORT_INT)
        ) u_lm_local_int_stub (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .ilm_async_write_error(ilm_async_write_error),
            .dlm0_async_write_error(dlm0_async_write_error),
            .dlm1_async_write_error(dlm1_async_write_error),
            .dlm2_async_write_error(dlm2_async_write_error),
            .dlm3_async_write_error(dlm3_async_write_error),
            .slvp_async_ecc_corr(slvp_async_ecc_corr),
            .slvp_async_ecc_ramid(slvp_async_ecc_ramid),
            .slvp_async_local_int(slvp_async_local_int),
            .lm_async_write_error(lm_async_write_error),
            .slvp_ipipe_ecc_corr(slvp_ipipe_ecc_corr),
            .slvp_ipipe_ecc_ramid(slvp_ipipe_ecc_ramid),
            .slvp_ipipe_local_int(slvp_ipipe_local_int),
            .lm_local_int(lm_local_int)
        );
    end
endgenerate
generate
    if (1'b1 && (ILM_SIZE_KB != 0)) begin:gen_ilm
        kv_ilm #(
            .ILM_AMSB(ILM_AMSB),
            .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
            .ILM_RAM_AW(ILM_RAM_AW),
            .ILM_RAM_BWEW(ILM_RAM_BWEW),
            .ILM_RAM_DW(ILM_RAM_DW),
            .ILM_SIZE_KB(ILM_SIZE_KB),
            .ILM_WAIT_CYCLE(ILM_WAIT_CYCLE)
        ) u_ilm (
            .csr_mecc_code(csr_mecc_code),
            .csr_milmb_eccen(csr_milmb_eccen),
            .csr_milmb_rwecc(csr_milmb_rwecc),
            .ilm0_addr(ilm0_addr),
            .ilm0_byte_we(ilm0_byte_we),
            .ilm0_cs(ilm0_cs),
            .ilm0_rdata(ilm0_rdata),
            .ilm0_user(ilm0_user),
            .ilm0_wdata(ilm0_wdata),
            .ilm0_we(ilm0_we),
            .ilm1_addr(ilm1_addr),
            .ilm1_byte_we(ilm1_byte_we),
            .ilm1_cs(ilm1_cs),
            .ilm1_rdata(ilm1_rdata),
            .ilm1_user(ilm1_user),
            .ilm1_wdata(ilm1_wdata),
            .ilm1_we(ilm1_we),
            .ilm_a_addr(ilm_a_addr),
            .ilm_a_data(ilm_a_data),
            .ilm_a_mask(ilm_a_mask),
            .ilm_a_opcode(ilm_a_opcode),
            .ilm_a_parity0(ilm_a_parity0),
            .ilm_a_parity1(ilm_a_parity1),
            .ilm_a_ready(ilm_a_ready),
            .ilm_a_size(ilm_a_size),
            .ilm_a_user(ilm_a_user),
            .ilm_a_valid(ilm_a_valid),
            .ilm_async_write_error(ilm_async_write_error),
            .ilm_csr_access(ilm_csr_access),
            .ilm_d_data(ilm_d_data),
            .ilm_d_denied(ilm_d_denied),
            .ilm_d_parity0(ilm_d_parity0),
            .ilm_d_parity1(ilm_d_parity1),
            .ilm_d_ready(ilm_d_ready),
            .ilm_d_valid(ilm_d_valid),
            .ilm_standby_ready(nds_unused_ilm_ipipe_standby_ready),
            .lm_clk_en(lm_clk_en),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .ifu_ilm_a_addr(ifu_ilm_a_addr),
            .ifu_ilm_a_func(ifu_ilm_a_func),
            .ifu_ilm_a_ready(ifu_ilm_a_ready),
            .ifu_ilm_a_stall(ifu_ilm_a_stall),
            .ifu_ilm_a_user(ifu_ilm_a_user),
            .ifu_ilm_a_valid(ifu_ilm_a_valid),
            .ifu_ilm_d_data(ifu_ilm_d_data),
            .ifu_ilm_d_status(ifu_ilm_d_status),
            .ifu_ilm_d_user(ifu_ilm_d_user),
            .ifu_ilm_d_valid(ifu_ilm_d_valid),
            .lsu_ilm_a_addr(lsu_ilm_a_addr),
            .lsu_ilm_a_func(lsu_ilm_a_func),
            .lsu_ilm_a_ready(lsu_ilm_a_ready),
            .lsu_ilm_a_stall(lsu_ilm_a_stall),
            .lsu_ilm_a_user(lsu_ilm_a_user),
            .lsu_ilm_a_valid(lsu_ilm_a_valid),
            .lsu_ilm_d_data(lsu_ilm_d_data),
            .lsu_ilm_d_status(lsu_ilm_d_status),
            .lsu_ilm_d_user(lsu_ilm_d_user),
            .lsu_ilm_d_valid(lsu_ilm_d_valid),
            .lsu_ilm_w_data(lsu_ilm_w_data),
            .lsu_ilm_w_mask(lsu_ilm_w_mask),
            .lsu_ilm_w_ready(lsu_ilm_w_ready),
            .lsu_ilm_w_status(lsu_ilm_w_status),
            .lsu_ilm_w_valid(lsu_ilm_w_valid),
            .slv_ilm_a_addr(slv_ilm_a_addr),
            .slv_ilm_a_func(slv_ilm_a_func),
            .slv_ilm_a_mask(slv_ilm_a_mask),
            .slv_ilm_a_ready(slv_ilm_a_ready),
            .slv_ilm_a_stall(slv_ilm_a_stall),
            .slv_ilm_a_user(slv_ilm_a_user),
            .slv_ilm_a_valid(slv_ilm_a_valid),
            .slv_ilm_d_data(slv_ilm_d_data),
            .slv_ilm_d_status(slv_ilm_d_status),
            .slv_ilm_d_user(slv_ilm_d_user),
            .slv_ilm_d_valid(slv_ilm_d_valid),
            .slv_ilm_w_data(slv_ilm_w_data),
            .slv_ilm_w_mask(slv_ilm_w_mask),
            .slv_ilm_w_ready(slv_ilm_w_ready),
            .slv_ilm_w_valid(slv_ilm_w_valid)
        );
    end
endgenerate
generate
    if (1'b1 && (ILM_SIZE_KB == 0)) begin:gen_ilm_stub
        kv_ilm_stub #(
            .ILM_AMSB(ILM_AMSB),
            .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
            .ILM_RAM_AW(ILM_RAM_AW),
            .ILM_RAM_BWEW(ILM_RAM_BWEW),
            .ILM_RAM_DW(ILM_RAM_DW),
            .ILM_SIZE_KB(ILM_SIZE_KB),
            .ILM_WAIT_CYCLE(ILM_WAIT_CYCLE)
        ) u_ilm_stub (
            .csr_mecc_code(csr_mecc_code),
            .csr_milmb_eccen(csr_milmb_eccen),
            .csr_milmb_rwecc(csr_milmb_rwecc),
            .ilm_async_write_error(ilm_async_write_error),
            .ilm0_addr(ilm0_addr),
            .ilm0_byte_we(ilm0_byte_we),
            .ilm0_cs(ilm0_cs),
            .ilm0_rdata(ilm0_rdata),
            .ilm0_user(ilm0_user),
            .ilm0_wdata(ilm0_wdata),
            .ilm0_we(ilm0_we),
            .ilm1_addr(ilm1_addr),
            .ilm1_byte_we(ilm1_byte_we),
            .ilm1_cs(ilm1_cs),
            .ilm1_rdata(ilm1_rdata),
            .ilm1_user(ilm1_user),
            .ilm1_wdata(ilm1_wdata),
            .ilm1_we(ilm1_we),
            .ilm_csr_access(ilm_csr_access),
            .ilm_standby_ready(nds_unused_ilm_ipipe_standby_ready),
            .lm_clk_en(lm_clk_en),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .ifu_ilm_a_addr(ifu_ilm_a_addr),
            .ifu_ilm_a_func(ifu_ilm_a_func),
            .ifu_ilm_a_ready(ifu_ilm_a_ready),
            .ifu_ilm_a_stall(ifu_ilm_a_stall),
            .ifu_ilm_a_user(ifu_ilm_a_user),
            .ifu_ilm_a_valid(ifu_ilm_a_valid),
            .ifu_ilm_d_data(ifu_ilm_d_data),
            .ifu_ilm_d_status(ifu_ilm_d_status),
            .ifu_ilm_d_user(ifu_ilm_d_user),
            .ifu_ilm_d_valid(ifu_ilm_d_valid),
            .lsu_ilm_a_addr(lsu_ilm_a_addr),
            .lsu_ilm_a_func(lsu_ilm_a_func),
            .lsu_ilm_a_ready(lsu_ilm_a_ready),
            .lsu_ilm_a_stall(lsu_ilm_a_stall),
            .lsu_ilm_a_user(lsu_ilm_a_user),
            .lsu_ilm_a_valid(lsu_ilm_a_valid),
            .lsu_ilm_d_data(lsu_ilm_d_data),
            .lsu_ilm_d_status(lsu_ilm_d_status),
            .lsu_ilm_d_user(lsu_ilm_d_user),
            .lsu_ilm_d_valid(lsu_ilm_d_valid),
            .lsu_ilm_w_data(lsu_ilm_w_data),
            .lsu_ilm_w_mask(lsu_ilm_w_mask),
            .lsu_ilm_w_ready(lsu_ilm_w_ready),
            .lsu_ilm_w_status(lsu_ilm_w_status),
            .lsu_ilm_w_valid(lsu_ilm_w_valid),
            .slv_ilm_a_addr(slv_ilm_a_addr),
            .slv_ilm_a_func(slv_ilm_a_func),
            .slv_ilm_a_mask(slv_ilm_a_mask),
            .slv_ilm_a_ready(slv_ilm_a_ready),
            .slv_ilm_a_stall(slv_ilm_a_stall),
            .slv_ilm_a_user(slv_ilm_a_user),
            .slv_ilm_a_valid(slv_ilm_a_valid),
            .slv_ilm_d_data(slv_ilm_d_data),
            .slv_ilm_d_status(slv_ilm_d_status),
            .slv_ilm_d_user(slv_ilm_d_user),
            .slv_ilm_d_valid(slv_ilm_d_valid),
            .slv_ilm_w_data(slv_ilm_w_data),
            .slv_ilm_w_mask(slv_ilm_w_mask),
            .slv_ilm_w_ready(slv_ilm_w_ready),
            .slv_ilm_w_valid(slv_ilm_w_valid),
            .ilm_a_addr(ilm_a_addr),
            .ilm_a_data(ilm_a_data),
            .ilm_a_mask(ilm_a_mask),
            .ilm_a_opcode(ilm_a_opcode),
            .ilm_a_parity0(ilm_a_parity0),
            .ilm_a_parity1(ilm_a_parity1),
            .ilm_a_ready(ilm_a_ready),
            .ilm_a_size(ilm_a_size),
            .ilm_a_user(ilm_a_user),
            .ilm_a_valid(ilm_a_valid),
            .ilm_d_denied(ilm_d_denied),
            .ilm_d_data(ilm_d_data),
            .ilm_d_parity0(ilm_d_parity0),
            .ilm_d_parity1(ilm_d_parity1),
            .ilm_d_ready(ilm_d_ready),
            .ilm_d_valid(ilm_d_valid)
        );
    end
endgenerate
generate
    if (1'b1 && (DLM_SIZE_KB != 0)) begin:gen_dlm
        kv_dlm #(
            .DLM_AMSB(DLM_AMSB),
            .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .DLM_RAM_AW(DLM_RAM_AW),
            .DLM_RAM_BWEW(DLM_RAM_BWEW),
            .DLM_RAM_DW(DLM_RAM_DW),
            .DLM_SIZE_KB(DLM_SIZE_KB),
            .DLM_WAIT_CYCLE(DLM_WAIT_CYCLE),
            .NUM_DLM_BANKS(NUM_DLM_BANKS)
        ) u_dlm (
            .dlm_standby_ready(nds_unused_dlm_ipipe_standby_ready),
            .dlm0_async_write_error(dlm0_async_write_error),
            .dlm_a_addr(dlm_a_addr),
            .dlm_a_data(dlm_a_data),
            .dlm_a_mask(dlm_a_mask),
            .dlm_a_opcode(dlm_a_opcode),
            .dlm_a_parity(dlm_a_parity),
            .dlm_a_ready(dlm_a_ready),
            .dlm_a_size(dlm_a_size),
            .dlm_a_user(dlm_a_user),
            .dlm_a_valid(dlm_a_valid),
            .dlm_addr(dlm_addr),
            .dlm_byte_we(dlm_byte_we),
            .dlm_cs(dlm_cs),
            .dlm_csr_access0(dlm_csr_access0),
            .dlm_d_data(dlm_d_data),
            .dlm_d_denied(dlm_d_denied),
            .dlm_d_parity(dlm_d_parity),
            .dlm_d_ready(dlm_d_ready),
            .dlm_d_valid(dlm_d_valid),
            .dlm_rdata(dlm_rdata),
            .dlm_user(dlm_user),
            .dlm_wdata(dlm_wdata),
            .dlm_we(dlm_we),
            .csr_mdlmb_eccen(csr_mdlmb_eccen),
            .csr_mdlmb_rwecc(csr_mdlmb_rwecc),
            .csr_mecc_code(csr_mecc_code),
            .lm_clk_en(lm_clk_en),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .dlm1_addr(dlm1_addr),
            .dlm1_async_write_error(dlm1_async_write_error),
            .dlm1_byte_we(dlm1_byte_we),
            .dlm1_cs(dlm1_cs),
            .dlm1_rdata(dlm1_rdata),
            .dlm1_user(dlm1_user),
            .dlm1_wdata(dlm1_wdata),
            .dlm1_we(dlm1_we),
            .dlm_csr_access1(dlm_csr_access1),
            .dlm2_addr(dlm2_addr),
            .dlm2_async_write_error(dlm2_async_write_error),
            .dlm2_byte_we(dlm2_byte_we),
            .dlm2_cs(dlm2_cs),
            .dlm2_rdata(dlm2_rdata),
            .dlm2_user(dlm2_user),
            .dlm2_wdata(dlm2_wdata),
            .dlm2_we(dlm2_we),
            .dlm_csr_access2(dlm_csr_access2),
            .dlm3_addr(dlm3_addr),
            .dlm3_async_write_error(dlm3_async_write_error),
            .dlm3_byte_we(dlm3_byte_we),
            .dlm3_cs(dlm3_cs),
            .dlm3_rdata(dlm3_rdata),
            .dlm3_user(dlm3_user),
            .dlm3_wdata(dlm3_wdata),
            .dlm3_we(dlm3_we),
            .dlm_csr_access3(dlm_csr_access3),
            .lsu_dlm0_a_addr(lsu_dlm0_a_addr),
            .lsu_dlm0_a_func(lsu_dlm0_a_func),
            .lsu_dlm0_a_ready(lsu_dlm0_a_ready),
            .lsu_dlm0_a_stall(lsu_dlm0_a_stall),
            .lsu_dlm0_a_user(lsu_dlm0_a_user),
            .lsu_dlm0_a_valid(lsu_dlm0_a_valid),
            .lsu_dlm0_d_data(lsu_dlm0_d_data),
            .lsu_dlm0_d_status(lsu_dlm0_d_status),
            .lsu_dlm0_d_user(lsu_dlm0_d_user),
            .lsu_dlm0_d_valid(lsu_dlm0_d_valid),
            .lsu_dlm0_w_data(lsu_dlm0_w_data),
            .lsu_dlm0_w_mask(lsu_dlm0_w_mask),
            .lsu_dlm0_w_ready(lsu_dlm0_w_ready),
            .lsu_dlm0_w_status(lsu_dlm0_w_status),
            .lsu_dlm0_w_valid(lsu_dlm0_w_valid),
            .slv_dlm0_a_addr(slv_dlm0_a_addr),
            .slv_dlm0_a_func(slv_dlm0_a_func),
            .slv_dlm0_a_ready(slv_dlm0_a_ready),
            .slv_dlm0_a_stall(slv_dlm0_a_stall),
            .slv_dlm0_a_user(slv_dlm0_a_user),
            .slv_dlm0_a_valid(slv_dlm0_a_valid),
            .slv_dlm0_d_data(slv_dlm0_d_data),
            .slv_dlm0_d_status(slv_dlm0_d_status),
            .slv_dlm0_d_user(slv_dlm0_d_user),
            .slv_dlm0_d_valid(slv_dlm0_d_valid),
            .slv_dlm0_w_data(slv_dlm0_w_data),
            .slv_dlm0_w_mask(slv_dlm0_w_mask),
            .slv_dlm0_w_ready(slv_dlm0_w_ready),
            .slv_dlm0_w_valid(slv_dlm0_w_valid),
            .lsu_dlm1_a_addr(lsu_dlm1_a_addr),
            .lsu_dlm1_a_func(lsu_dlm1_a_func),
            .lsu_dlm1_a_ready(lsu_dlm1_a_ready),
            .lsu_dlm1_a_stall(lsu_dlm1_a_stall),
            .lsu_dlm1_a_user(lsu_dlm1_a_user),
            .lsu_dlm1_a_valid(lsu_dlm1_a_valid),
            .lsu_dlm1_d_data(lsu_dlm1_d_data),
            .lsu_dlm1_d_status(lsu_dlm1_d_status),
            .lsu_dlm1_d_user(lsu_dlm1_d_user),
            .lsu_dlm1_d_valid(lsu_dlm1_d_valid),
            .lsu_dlm1_w_data(lsu_dlm1_w_data),
            .lsu_dlm1_w_mask(lsu_dlm1_w_mask),
            .lsu_dlm1_w_ready(lsu_dlm1_w_ready),
            .lsu_dlm1_w_status(lsu_dlm1_w_status),
            .lsu_dlm1_w_valid(lsu_dlm1_w_valid),
            .slv_dlm1_a_addr(slv_dlm1_a_addr),
            .slv_dlm1_a_func(slv_dlm1_a_func),
            .slv_dlm1_a_ready(slv_dlm1_a_ready),
            .slv_dlm1_a_stall(slv_dlm1_a_stall),
            .slv_dlm1_a_user(slv_dlm1_a_user),
            .slv_dlm1_a_valid(slv_dlm1_a_valid),
            .slv_dlm1_d_data(slv_dlm1_d_data),
            .slv_dlm1_d_status(slv_dlm1_d_status),
            .slv_dlm1_d_user(slv_dlm1_d_user),
            .slv_dlm1_d_valid(slv_dlm1_d_valid),
            .slv_dlm1_w_data(slv_dlm1_w_data),
            .slv_dlm1_w_mask(slv_dlm1_w_mask),
            .slv_dlm1_w_ready(slv_dlm1_w_ready),
            .slv_dlm1_w_valid(slv_dlm1_w_valid),
            .lsu_dlm2_a_addr(lsu_dlm2_a_addr),
            .lsu_dlm2_a_func(lsu_dlm2_a_func),
            .lsu_dlm2_a_ready(lsu_dlm2_a_ready),
            .lsu_dlm2_a_stall(lsu_dlm2_a_stall),
            .lsu_dlm2_a_user(lsu_dlm2_a_user),
            .lsu_dlm2_a_valid(lsu_dlm2_a_valid),
            .lsu_dlm2_d_data(lsu_dlm2_d_data),
            .lsu_dlm2_d_status(lsu_dlm2_d_status),
            .lsu_dlm2_d_user(lsu_dlm2_d_user),
            .lsu_dlm2_d_valid(lsu_dlm2_d_valid),
            .lsu_dlm2_w_data(lsu_dlm2_w_data),
            .lsu_dlm2_w_mask(lsu_dlm2_w_mask),
            .lsu_dlm2_w_ready(lsu_dlm2_w_ready),
            .lsu_dlm2_w_status(lsu_dlm2_w_status),
            .lsu_dlm2_w_valid(lsu_dlm2_w_valid),
            .slv_dlm2_a_addr(slv_dlm2_a_addr),
            .slv_dlm2_a_func(slv_dlm2_a_func),
            .slv_dlm2_a_ready(slv_dlm2_a_ready),
            .slv_dlm2_a_stall(slv_dlm2_a_stall),
            .slv_dlm2_a_user(slv_dlm2_a_user),
            .slv_dlm2_a_valid(slv_dlm2_a_valid),
            .slv_dlm2_d_data(slv_dlm2_d_data),
            .slv_dlm2_d_status(slv_dlm2_d_status),
            .slv_dlm2_d_user(slv_dlm2_d_user),
            .slv_dlm2_d_valid(slv_dlm2_d_valid),
            .slv_dlm2_w_data(slv_dlm2_w_data),
            .slv_dlm2_w_mask(slv_dlm2_w_mask),
            .slv_dlm2_w_ready(slv_dlm2_w_ready),
            .slv_dlm2_w_valid(slv_dlm2_w_valid),
            .lsu_dlm3_a_addr(lsu_dlm3_a_addr),
            .lsu_dlm3_a_func(lsu_dlm3_a_func),
            .lsu_dlm3_a_ready(lsu_dlm3_a_ready),
            .lsu_dlm3_a_stall(lsu_dlm3_a_stall),
            .lsu_dlm3_a_user(lsu_dlm3_a_user),
            .lsu_dlm3_a_valid(lsu_dlm3_a_valid),
            .lsu_dlm3_d_data(lsu_dlm3_d_data),
            .lsu_dlm3_d_status(lsu_dlm3_d_status),
            .lsu_dlm3_d_user(lsu_dlm3_d_user),
            .lsu_dlm3_d_valid(lsu_dlm3_d_valid),
            .lsu_dlm3_w_data(lsu_dlm3_w_data),
            .lsu_dlm3_w_mask(lsu_dlm3_w_mask),
            .lsu_dlm3_w_ready(lsu_dlm3_w_ready),
            .lsu_dlm3_w_status(lsu_dlm3_w_status),
            .lsu_dlm3_w_valid(lsu_dlm3_w_valid),
            .slv_dlm3_a_addr(slv_dlm3_a_addr),
            .slv_dlm3_a_func(slv_dlm3_a_func),
            .slv_dlm3_a_ready(slv_dlm3_a_ready),
            .slv_dlm3_a_stall(slv_dlm3_a_stall),
            .slv_dlm3_a_user(slv_dlm3_a_user),
            .slv_dlm3_a_valid(slv_dlm3_a_valid),
            .slv_dlm3_d_data(slv_dlm3_d_data),
            .slv_dlm3_d_status(slv_dlm3_d_status),
            .slv_dlm3_d_user(slv_dlm3_d_user),
            .slv_dlm3_d_valid(slv_dlm3_d_valid),
            .slv_dlm3_w_data(slv_dlm3_w_data),
            .slv_dlm3_w_mask(slv_dlm3_w_mask),
            .slv_dlm3_w_ready(slv_dlm3_w_ready),
            .slv_dlm3_w_valid(slv_dlm3_w_valid)
        );
    end
endgenerate
generate
    if (1'b1 && (DLM_SIZE_KB == 0)) begin:gen_dlm_stub
        kv_dlm_stub #(
            .DLM_AMSB(DLM_AMSB),
            .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .DLM_RAM_AW(DLM_RAM_AW),
            .DLM_RAM_BWEW(DLM_RAM_BWEW),
            .DLM_RAM_DW(DLM_RAM_DW),
            .DLM_SIZE_KB(DLM_SIZE_KB),
            .DLM_WAIT_CYCLE(DLM_WAIT_CYCLE)
        ) u_dlm_stub (
            .dlm_standby_ready(nds_unused_dlm_ipipe_standby_ready),
            .dlm0_async_write_error(dlm0_async_write_error),
            .dlm_a_addr(dlm_a_addr),
            .dlm_a_data(dlm_a_data),
            .dlm_a_mask(dlm_a_mask),
            .dlm_a_opcode(dlm_a_opcode),
            .dlm_a_parity(dlm_a_parity),
            .dlm_a_ready(dlm_a_ready),
            .dlm_a_size(dlm_a_size),
            .dlm_a_user(dlm_a_user),
            .dlm_a_valid(dlm_a_valid),
            .dlm_addr(dlm_addr),
            .dlm_byte_we(dlm_byte_we),
            .dlm_cs(dlm_cs),
            .dlm_csr_access0(dlm_csr_access0),
            .dlm_d_data(dlm_d_data),
            .dlm_d_denied(dlm_d_denied),
            .dlm_d_parity(dlm_d_parity),
            .dlm_d_ready(dlm_d_ready),
            .dlm_d_valid(dlm_d_valid),
            .dlm_rdata(dlm_rdata),
            .dlm_user(dlm_user),
            .dlm_wdata(dlm_wdata),
            .dlm_we(dlm_we),
            .csr_mdlmb_eccen(csr_mdlmb_eccen),
            .csr_mdlmb_rwecc(csr_mdlmb_rwecc),
            .csr_mecc_code(csr_mecc_code),
            .lm_clk_en(lm_clk_en),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .dlm1_addr(dlm1_addr),
            .dlm1_async_write_error(dlm1_async_write_error),
            .dlm1_byte_we(dlm1_byte_we),
            .dlm1_cs(dlm1_cs),
            .dlm1_rdata(dlm1_rdata),
            .dlm1_user(dlm1_user),
            .dlm1_wdata(dlm1_wdata),
            .dlm1_we(dlm1_we),
            .dlm_csr_access1(dlm_csr_access1),
            .dlm2_addr(dlm2_addr),
            .dlm2_async_write_error(dlm2_async_write_error),
            .dlm2_byte_we(dlm2_byte_we),
            .dlm2_cs(dlm2_cs),
            .dlm2_rdata(dlm2_rdata),
            .dlm2_user(dlm2_user),
            .dlm2_wdata(dlm2_wdata),
            .dlm2_we(dlm2_we),
            .dlm_csr_access2(dlm_csr_access2),
            .dlm3_addr(dlm3_addr),
            .dlm3_async_write_error(dlm3_async_write_error),
            .dlm3_byte_we(dlm3_byte_we),
            .dlm3_cs(dlm3_cs),
            .dlm3_rdata(dlm3_rdata),
            .dlm3_user(dlm3_user),
            .dlm3_wdata(dlm3_wdata),
            .dlm3_we(dlm3_we),
            .dlm_csr_access3(dlm_csr_access3),
            .lsu_dlm0_a_addr(lsu_dlm0_a_addr),
            .lsu_dlm0_a_func(lsu_dlm0_a_func),
            .lsu_dlm0_a_ready(lsu_dlm0_a_ready),
            .lsu_dlm0_a_stall(lsu_dlm0_a_stall),
            .lsu_dlm0_a_user(lsu_dlm0_a_user),
            .lsu_dlm0_a_valid(lsu_dlm0_a_valid),
            .lsu_dlm0_d_data(lsu_dlm0_d_data),
            .lsu_dlm0_d_status(lsu_dlm0_d_status),
            .lsu_dlm0_d_user(lsu_dlm0_d_user),
            .lsu_dlm0_d_valid(lsu_dlm0_d_valid),
            .lsu_dlm0_w_data(lsu_dlm0_w_data),
            .lsu_dlm0_w_mask(lsu_dlm0_w_mask),
            .lsu_dlm0_w_ready(lsu_dlm0_w_ready),
            .lsu_dlm0_w_status(lsu_dlm0_w_status),
            .lsu_dlm0_w_valid(lsu_dlm0_w_valid),
            .slv_dlm0_a_addr(slv_dlm0_a_addr),
            .slv_dlm0_a_func(slv_dlm0_a_func),
            .slv_dlm0_a_ready(slv_dlm0_a_ready),
            .slv_dlm0_a_stall(slv_dlm0_a_stall),
            .slv_dlm0_a_user(slv_dlm0_a_user),
            .slv_dlm0_a_valid(slv_dlm0_a_valid),
            .slv_dlm0_d_data(slv_dlm0_d_data),
            .slv_dlm0_d_status(slv_dlm0_d_status),
            .slv_dlm0_d_user(slv_dlm0_d_user),
            .slv_dlm0_d_valid(slv_dlm0_d_valid),
            .slv_dlm0_w_data(slv_dlm0_w_data),
            .slv_dlm0_w_mask(slv_dlm0_w_mask),
            .slv_dlm0_w_ready(slv_dlm0_w_ready),
            .slv_dlm0_w_valid(slv_dlm0_w_valid),
            .lsu_dlm1_a_addr(lsu_dlm1_a_addr),
            .lsu_dlm1_a_func(lsu_dlm1_a_func),
            .lsu_dlm1_a_ready(lsu_dlm1_a_ready),
            .lsu_dlm1_a_stall(lsu_dlm1_a_stall),
            .lsu_dlm1_a_user(lsu_dlm1_a_user),
            .lsu_dlm1_a_valid(lsu_dlm1_a_valid),
            .lsu_dlm1_d_data(lsu_dlm1_d_data),
            .lsu_dlm1_d_status(lsu_dlm1_d_status),
            .lsu_dlm1_d_user(lsu_dlm1_d_user),
            .lsu_dlm1_d_valid(lsu_dlm1_d_valid),
            .lsu_dlm1_w_data(lsu_dlm1_w_data),
            .lsu_dlm1_w_mask(lsu_dlm1_w_mask),
            .lsu_dlm1_w_ready(lsu_dlm1_w_ready),
            .lsu_dlm1_w_status(lsu_dlm1_w_status),
            .lsu_dlm1_w_valid(lsu_dlm1_w_valid),
            .slv_dlm1_a_addr(slv_dlm1_a_addr),
            .slv_dlm1_a_func(slv_dlm1_a_func),
            .slv_dlm1_a_ready(slv_dlm1_a_ready),
            .slv_dlm1_a_stall(slv_dlm1_a_stall),
            .slv_dlm1_a_user(slv_dlm1_a_user),
            .slv_dlm1_a_valid(slv_dlm1_a_valid),
            .slv_dlm1_d_data(slv_dlm1_d_data),
            .slv_dlm1_d_status(slv_dlm1_d_status),
            .slv_dlm1_d_user(slv_dlm1_d_user),
            .slv_dlm1_d_valid(slv_dlm1_d_valid),
            .slv_dlm1_w_data(slv_dlm1_w_data),
            .slv_dlm1_w_mask(slv_dlm1_w_mask),
            .slv_dlm1_w_ready(slv_dlm1_w_ready),
            .slv_dlm1_w_valid(slv_dlm1_w_valid),
            .lsu_dlm2_a_addr(lsu_dlm2_a_addr),
            .lsu_dlm2_a_func(lsu_dlm2_a_func),
            .lsu_dlm2_a_ready(lsu_dlm2_a_ready),
            .lsu_dlm2_a_stall(lsu_dlm2_a_stall),
            .lsu_dlm2_a_user(lsu_dlm2_a_user),
            .lsu_dlm2_a_valid(lsu_dlm2_a_valid),
            .lsu_dlm2_d_data(lsu_dlm2_d_data),
            .lsu_dlm2_d_status(lsu_dlm2_d_status),
            .lsu_dlm2_d_user(lsu_dlm2_d_user),
            .lsu_dlm2_d_valid(lsu_dlm2_d_valid),
            .lsu_dlm2_w_data(lsu_dlm2_w_data),
            .lsu_dlm2_w_mask(lsu_dlm2_w_mask),
            .lsu_dlm2_w_ready(lsu_dlm2_w_ready),
            .lsu_dlm2_w_status(lsu_dlm2_w_status),
            .lsu_dlm2_w_valid(lsu_dlm2_w_valid),
            .slv_dlm2_a_addr(slv_dlm2_a_addr),
            .slv_dlm2_a_func(slv_dlm2_a_func),
            .slv_dlm2_a_ready(slv_dlm2_a_ready),
            .slv_dlm2_a_stall(slv_dlm2_a_stall),
            .slv_dlm2_a_user(slv_dlm2_a_user),
            .slv_dlm2_a_valid(slv_dlm2_a_valid),
            .slv_dlm2_d_data(slv_dlm2_d_data),
            .slv_dlm2_d_status(slv_dlm2_d_status),
            .slv_dlm2_d_user(slv_dlm2_d_user),
            .slv_dlm2_d_valid(slv_dlm2_d_valid),
            .slv_dlm2_w_data(slv_dlm2_w_data),
            .slv_dlm2_w_mask(slv_dlm2_w_mask),
            .slv_dlm2_w_ready(slv_dlm2_w_ready),
            .slv_dlm2_w_valid(slv_dlm2_w_valid),
            .lsu_dlm3_a_addr(lsu_dlm3_a_addr),
            .lsu_dlm3_a_func(lsu_dlm3_a_func),
            .lsu_dlm3_a_ready(lsu_dlm3_a_ready),
            .lsu_dlm3_a_stall(lsu_dlm3_a_stall),
            .lsu_dlm3_a_user(lsu_dlm3_a_user),
            .lsu_dlm3_a_valid(lsu_dlm3_a_valid),
            .lsu_dlm3_d_data(lsu_dlm3_d_data),
            .lsu_dlm3_d_status(lsu_dlm3_d_status),
            .lsu_dlm3_d_user(lsu_dlm3_d_user),
            .lsu_dlm3_d_valid(lsu_dlm3_d_valid),
            .lsu_dlm3_w_data(lsu_dlm3_w_data),
            .lsu_dlm3_w_mask(lsu_dlm3_w_mask),
            .lsu_dlm3_w_ready(lsu_dlm3_w_ready),
            .lsu_dlm3_w_status(lsu_dlm3_w_status),
            .lsu_dlm3_w_valid(lsu_dlm3_w_valid),
            .slv_dlm3_a_addr(slv_dlm3_a_addr),
            .slv_dlm3_a_func(slv_dlm3_a_func),
            .slv_dlm3_a_ready(slv_dlm3_a_ready),
            .slv_dlm3_a_stall(slv_dlm3_a_stall),
            .slv_dlm3_a_user(slv_dlm3_a_user),
            .slv_dlm3_a_valid(slv_dlm3_a_valid),
            .slv_dlm3_d_data(slv_dlm3_d_data),
            .slv_dlm3_d_status(slv_dlm3_d_status),
            .slv_dlm3_d_user(slv_dlm3_d_user),
            .slv_dlm3_d_valid(slv_dlm3_d_valid),
            .slv_dlm3_w_data(slv_dlm3_w_data),
            .slv_dlm3_w_mask(slv_dlm3_w_mask),
            .slv_dlm3_w_ready(slv_dlm3_w_ready),
            .slv_dlm3_w_valid(slv_dlm3_w_valid)
        );
    end
endgenerate
generate
    if (HAS_CORE_BRG == 1) begin:gen_core_brg
        kv_core_brg #(
            .CORE_BRG_ASYNC(CORE_BRG_ASYNC),
            .CORE_BRG_REG(CORE_BRG_REG),
            .CORE_CLK_SYNC_STAGE(CORE_CLK_SYNC_STAGE),
            .L2_ADDR_WIDTH(L2_ADDR_WIDTH),
            .L2_CLK_SYNC_STAGE(L2_CLK_SYNC_STAGE),
            .L2_DATA_WIDTH(L2_DATA_WIDTH),
            .L2_SOURCE_WIDTH(L2_SOURCE_WIDTH),
            .TL_SINK_WIDTH(TL_SINK_WIDTH),
            .TL_SIZE_WIDTH(TL_SIZE_WIDTH)
        ) u_brg (
            .core_clk(core_clk),
            .dcu_clk(dcu_clk),
            .core_reset_n(core_reset_n),
            .l2_clk(l2_clk),
            .l2_reset_n(l2_reset_n),
            .dcu_a_opcode(dcu_a_opcode),
            .dcu_a_param(dcu_a_param),
            .dcu_a_user(dcu_a_user),
            .dcu_a_size(dcu_a_size),
            .dcu_a_source(dcu_a_source),
            .dcu_a_address(dcu_a_address),
            .dcu_a_data(dcu_a_data),
            .dcu_a_mask(dcu_a_mask),
            .dcu_a_corrupt(dcu_a_corrupt),
            .dcu_a_valid(dcu_a_valid),
            .dcu_a_ready(dcu_a_ready),
            .dcu_b_opcode(dcu_b_opcode),
            .dcu_b_param(dcu_b_param),
            .dcu_b_size(dcu_b_size),
            .dcu_b_source(dcu_b_source),
            .dcu_b_address(dcu_b_address),
            .dcu_b_data(dcu_b_data),
            .dcu_b_mask(dcu_b_mask),
            .dcu_b_corrupt(dcu_b_corrupt),
            .dcu_b_valid(dcu_b_valid),
            .dcu_b_ready(dcu_b_ready),
            .dcu_c_opcode(dcu_c_opcode),
            .dcu_c_param(dcu_c_param),
            .dcu_c_size(dcu_c_size),
            .dcu_c_user(dcu_c_user),
            .dcu_c_source(dcu_c_source),
            .dcu_c_address(dcu_c_address),
            .dcu_c_data(dcu_c_data),
            .dcu_c_corrupt(dcu_c_corrupt),
            .dcu_c_valid(dcu_c_valid),
            .dcu_c_ready(dcu_c_ready),
            .dcu_d_opcode(dcu_d_opcode),
            .dcu_d_param(dcu_d_param),
            .dcu_d_user(dcu_d_user),
            .dcu_d_size(dcu_d_size),
            .dcu_d_source(dcu_d_source),
            .dcu_d_data(dcu_d_data),
            .dcu_d_denied(dcu_d_denied),
            .dcu_d_corrupt(dcu_d_corrupt),
            .dcu_d_sink(dcu_d_sink),
            .dcu_d_valid(dcu_d_valid),
            .dcu_d_ready(dcu_d_ready),
            .dcu_e_valid(dcu_e_valid),
            .dcu_e_sink(dcu_e_sink),
            .dcu_e_ready(dcu_e_ready),
            .lsu_a_opcode(lsu_a_opcode),
            .lsu_a_param(lsu_a_param),
            .lsu_a_user(lsu_a_user),
            .lsu_a_size(lsu_a_size),
            .lsu_a_source(lsu_a_source),
            .lsu_a_address(lsu_a_address),
            .lsu_a_data(lsu_a_data),
            .lsu_a_mask(lsu_a_mask),
            .lsu_a_corrupt(lsu_a_corrupt),
            .lsu_a_valid(lsu_a_valid),
            .lsu_a_ready(lsu_a_ready),
            .lsu_d_opcode(lsu_d_opcode),
            .lsu_d_param(lsu_d_param),
            .lsu_d_user(lsu_d_user),
            .lsu_d_size(lsu_d_size),
            .lsu_d_source(lsu_d_source),
            .lsu_d_sink(lsu_d_sink),
            .lsu_d_data(lsu_d_data),
            .lsu_d_denied(lsu_d_denied),
            .lsu_d_corrupt(lsu_d_corrupt),
            .lsu_d_valid(lsu_d_valid),
            .lsu_d_ready(lsu_d_ready),
            .icu_a_opcode(icu_a_opcode),
            .icu_a_param(icu_a_param),
            .icu_a_user(icu_a_user),
            .icu_a_size(icu_a_size),
            .icu_a_source(icu_a_source),
            .icu_a_address(icu_a_address),
            .icu_a_data(icu_a_data),
            .icu_a_mask(icu_a_mask),
            .icu_a_corrupt(icu_a_corrupt),
            .icu_a_valid(icu_a_valid),
            .icu_a_ready(icu_a_ready),
            .icu_d_opcode(icu_d_opcode),
            .icu_d_param(icu_d_param),
            .icu_d_user(icu_d_user),
            .icu_d_size(icu_d_size),
            .icu_d_source(icu_d_source),
            .icu_d_sink(icu_d_sink),
            .icu_d_data(icu_d_data),
            .icu_d_denied(icu_d_denied),
            .icu_d_corrupt(icu_d_corrupt),
            .icu_d_valid(icu_d_valid),
            .icu_d_ready(icu_d_ready),
            .m0_a_opcode(m0_a_opcode),
            .m0_a_param(m0_a_param),
            .m0_a_user(m0_a_user),
            .m0_a_size(m0_a_size),
            .m0_a_source(m0_a_source),
            .m0_a_address(m0_a_address),
            .m0_a_data(m0_a_data),
            .m0_a_mask(m0_a_mask),
            .m0_a_corrupt(m0_a_corrupt),
            .m0_a_valid(m0_a_valid),
            .m0_a_ready(m0_a_ready),
            .m0_b_opcode(m0_b_opcode),
            .m0_b_param(m0_b_param),
            .m0_b_size(m0_b_size),
            .m0_b_source(m0_b_source),
            .m0_b_address(m0_b_address),
            .m0_b_data(m0_b_data),
            .m0_b_mask(m0_b_mask),
            .m0_b_corrupt(m0_b_corrupt),
            .m0_b_valid(m0_b_valid),
            .m0_b_ready(m0_b_ready),
            .m0_c_opcode(m0_c_opcode),
            .m0_c_param(m0_c_param),
            .m0_c_size(m0_c_size),
            .m0_c_user(m0_c_user),
            .m0_c_source(m0_c_source),
            .m0_c_address(m0_c_address),
            .m0_c_data(m0_c_data),
            .m0_c_corrupt(m0_c_corrupt),
            .m0_c_valid(m0_c_valid),
            .m0_c_ready(m0_c_ready),
            .m0_d_opcode(m0_d_opcode),
            .m0_d_param(m0_d_param),
            .m0_d_user(m0_d_user),
            .m0_d_size(m0_d_size),
            .m0_d_source(m0_d_source),
            .m0_d_data(m0_d_data),
            .m0_d_denied(m0_d_denied),
            .m0_d_corrupt(m0_d_corrupt),
            .m0_d_sink(m0_d_sink),
            .m0_d_valid(m0_d_valid),
            .m0_d_ready(m0_d_ready),
            .m0_e_valid(m0_e_valid),
            .m0_e_sink(m0_e_sink),
            .m0_e_ready(m0_e_ready),
            .m1_a_opcode(m1_a_opcode),
            .m1_a_param(m1_a_param),
            .m1_a_user(m1_a_user),
            .m1_a_size(m1_a_size),
            .m1_a_source(m1_a_source),
            .m1_a_address(m1_a_address),
            .m1_a_data(m1_a_data),
            .m1_a_mask(m1_a_mask),
            .m1_a_corrupt(m1_a_corrupt),
            .m1_a_valid(m1_a_valid),
            .m1_a_ready(m1_a_ready),
            .m1_d_opcode(m1_d_opcode),
            .m1_d_param(m1_d_param),
            .m1_d_user(m1_d_user),
            .m1_d_size(m1_d_size),
            .m1_d_source(m1_d_source),
            .m1_d_sink(m1_d_sink),
            .m1_d_data(m1_d_data),
            .m1_d_denied(m1_d_denied),
            .m1_d_corrupt(m1_d_corrupt),
            .m1_d_valid(m1_d_valid),
            .m1_d_ready(m1_d_ready),
            .m2_a_opcode(m2_a_opcode),
            .m2_a_param(m2_a_param),
            .m2_a_user(m2_a_user),
            .m2_a_size(m2_a_size),
            .m2_a_source(m2_a_source),
            .m2_a_address(m2_a_address),
            .m2_a_data(m2_a_data),
            .m2_a_mask(m2_a_mask),
            .m2_a_corrupt(m2_a_corrupt),
            .m2_a_valid(m2_a_valid),
            .m2_a_ready(m2_a_ready),
            .m2_d_opcode(m2_d_opcode),
            .m2_d_param(m2_d_param),
            .m2_d_user(m2_d_user),
            .m2_d_size(m2_d_size),
            .m2_d_source(m2_d_source),
            .m2_d_sink(m2_d_sink),
            .m2_d_data(m2_d_data),
            .m2_d_denied(m2_d_denied),
            .m2_d_corrupt(m2_d_corrupt),
            .m2_d_valid(m2_d_valid),
            .m2_d_ready(m2_d_ready),
            .core_coherent_enable_int(core_coherent_enable_int),
            .core_coherent_state_int(core_coherent_state_int),
            .core_coherent_enable(core_coherent_enable),
            .core_coherent_state(core_coherent_state)
        );
    end
endgenerate
generate
    if (HAS_CORE_BRG == 0) begin:gen_axi_biu
        kv_biu #(
            .BIU_ADDR_WIDTH(BIU_ADDR_WIDTH),
            .BIU_ASYNC_SUPPORT(BIU_ASYNC_SUPPORT),
            .BIU_DATA_WIDTH(BIU_DATA_WIDTH),
            .BIU_ID_WIDTH(BIU_ID_WIDTH),
            .BIU_PATH_X2_INT(BIU_PATH_X2_INT),
            .L2_ADDR_WIDTH(L2_ADDR_WIDTH),
            .L2_DATA_WIDTH(L2_DATA_WIDTH),
            .TL_SINK_WIDTH(TL_SINK_WIDTH),
            .TL_SIZE_WIDTH(TL_SIZE_WIDTH)
        ) kv_biu (
            .dcu_a_address(dcu_a_address),
            .dcu_a_corrupt(dcu_a_corrupt),
            .dcu_a_data(dcu_a_data),
            .dcu_a_mask(dcu_a_mask),
            .dcu_a_opcode(dcu_a_opcode),
            .dcu_a_param(dcu_a_param),
            .dcu_a_ready(dcu_a_ready),
            .dcu_a_size(dcu_a_size),
            .dcu_a_source(dcu_a_source),
            .dcu_a_user(dcu_a_user),
            .dcu_a_valid(dcu_a_valid),
            .dcu_c_address(dcu_c_address),
            .dcu_c_corrupt(dcu_c_corrupt),
            .dcu_c_data(dcu_c_data),
            .dcu_c_opcode(dcu_c_opcode),
            .dcu_c_param(dcu_c_param),
            .dcu_c_ready(dcu_c_ready),
            .dcu_c_size(dcu_c_size),
            .dcu_c_source(dcu_c_source),
            .dcu_c_user(dcu_c_user),
            .dcu_c_valid(dcu_c_valid),
            .dcu_d_corrupt(dcu_d_corrupt),
            .dcu_d_data(dcu_d_data),
            .dcu_d_denied(dcu_d_denied),
            .dcu_d_opcode(dcu_d_opcode),
            .dcu_d_param(dcu_d_param),
            .dcu_d_ready(dcu_d_ready),
            .dcu_d_sink(dcu_d_sink),
            .dcu_d_size(dcu_d_size),
            .dcu_d_source(dcu_d_source),
            .dcu_d_user(dcu_d_user),
            .dcu_d_valid(dcu_d_valid),
            .dcu_e_ready(dcu_e_ready),
            .dcu_e_sink(dcu_e_sink),
            .dcu_e_valid(dcu_e_valid),
            .icu_a_source(icu_a_source),
            .icu_a_user(icu_a_user),
            .icu_d_source(icu_d_source),
            .icu_d_user(icu_d_user),
            .lsu_a_address(lsu_a_address),
            .lsu_a_corrupt(lsu_a_corrupt),
            .lsu_a_data(lsu_a_data),
            .lsu_a_mask(lsu_a_mask),
            .lsu_a_opcode(lsu_a_opcode),
            .lsu_a_param(lsu_a_param),
            .lsu_a_ready(lsu_a_ready),
            .lsu_a_size(lsu_a_size),
            .lsu_a_source(lsu_a_source),
            .lsu_a_user(lsu_a_user),
            .lsu_a_valid(lsu_a_valid),
            .lsu_d_corrupt(lsu_d_corrupt),
            .lsu_d_data(lsu_d_data),
            .lsu_d_denied(lsu_d_denied),
            .lsu_d_opcode(lsu_d_opcode),
            .lsu_d_param(lsu_d_param),
            .lsu_d_ready(lsu_d_ready),
            .lsu_d_sink(lsu_d_sink),
            .lsu_d_size(lsu_d_size),
            .lsu_d_source(lsu_d_source),
            .lsu_d_user(lsu_d_user),
            .lsu_d_valid(lsu_d_valid),
            .test_mode(test_mode),
            .bus_clk(bus_clk),
            .core_reset_n(core_reset_n),
            .araddr(araddr),
            .arburst(arburst),
            .arcache(arcache),
            .arid(arid),
            .arlen(arlen),
            .arlock(arlock),
            .arprot(arprot),
            .arready(arready),
            .arsize(arsize),
            .arvalid(arvalid),
            .awaddr(awaddr),
            .awburst(awburst),
            .awcache(awcache),
            .awid(awid),
            .awlen(awlen),
            .awlock(awlock),
            .awprot(awprot),
            .awready(awready),
            .awsize(awsize),
            .awvalid(awvalid),
            .bid(bid),
            .bready(bready),
            .bresp(bresp),
            .bvalid(bvalid),
            .rdata(rdata),
            .rid(rid),
            .rlast(rlast),
            .rready(rready),
            .rresp(rresp),
            .rvalid(rvalid),
            .wdata(wdata),
            .wlast(wlast),
            .wready(wready),
            .wstrb(wstrb),
            .wvalid(wvalid),
            .bus_clk_en(bus_clk_en),
            .core_clk(core_clk),
            .d_araddr(d_araddr),
            .d_arburst(d_arburst),
            .d_arcache(d_arcache),
            .d_arid(d_arid),
            .d_arlen(d_arlen),
            .d_arlock(d_arlock),
            .d_arprot(d_arprot),
            .d_arready(d_arready),
            .d_arsize(d_arsize),
            .d_arvalid(d_arvalid),
            .d_awaddr(d_awaddr),
            .d_awburst(d_awburst),
            .d_awcache(d_awcache),
            .d_awid(d_awid),
            .d_awlen(d_awlen),
            .d_awlock(d_awlock),
            .d_awprot(d_awprot),
            .d_awready(d_awready),
            .d_awsize(d_awsize),
            .d_awvalid(d_awvalid),
            .d_bid(d_bid),
            .d_bready(d_bready),
            .d_bresp(d_bresp),
            .d_bvalid(d_bvalid),
            .d_rdata(d_rdata),
            .d_rid(d_rid),
            .d_rlast(d_rlast),
            .d_rready(d_rready),
            .d_rresp(d_rresp),
            .d_rvalid(d_rvalid),
            .d_wdata(d_wdata),
            .d_wlast(d_wlast),
            .d_wready(d_wready),
            .d_wstrb(d_wstrb),
            .d_wvalid(d_wvalid),
            .i_araddr(i_araddr),
            .i_arburst(i_arburst),
            .i_arcache(i_arcache),
            .i_arid(i_arid),
            .i_arlen(i_arlen),
            .i_arlock(i_arlock),
            .i_arprot(i_arprot),
            .i_arready(i_arready),
            .i_arsize(i_arsize),
            .i_arvalid(i_arvalid),
            .i_awaddr(i_awaddr),
            .i_awburst(i_awburst),
            .i_awcache(i_awcache),
            .i_awid(i_awid),
            .i_awlen(i_awlen),
            .i_awlock(i_awlock),
            .i_awprot(i_awprot),
            .i_awready(i_awready),
            .i_awsize(i_awsize),
            .i_awvalid(i_awvalid),
            .i_bid(i_bid),
            .i_bready(i_bready),
            .i_bresp(i_bresp),
            .i_bvalid(i_bvalid),
            .i_rdata(i_rdata),
            .i_rid(i_rid),
            .i_rlast(i_rlast),
            .i_rready(i_rready),
            .i_rresp(i_rresp),
            .i_rvalid(i_rvalid),
            .i_wdata(i_wdata),
            .i_wlast(i_wlast),
            .i_wready(i_wready),
            .i_wstrb(i_wstrb),
            .i_wvalid(i_wvalid),
            .icu_a_address(icu_a_address),
            .icu_a_corrupt(icu_a_corrupt),
            .icu_a_data(icu_a_data),
            .icu_a_mask(icu_a_mask),
            .icu_a_opcode(icu_a_opcode),
            .icu_a_param(icu_a_param),
            .icu_a_ready(icu_a_ready),
            .icu_a_size(icu_a_size),
            .icu_a_valid(icu_a_valid),
            .icu_d_corrupt(icu_d_corrupt),
            .icu_d_data(icu_d_data),
            .icu_d_denied(icu_d_denied),
            .icu_d_opcode(icu_d_opcode),
            .icu_d_param(icu_d_param),
            .icu_d_ready(icu_d_ready),
            .icu_d_sink(icu_d_sink),
            .icu_d_size(icu_d_size),
            .icu_d_valid(icu_d_valid)
        );
    end
endgenerate
generate
    if ((PC_GPR_PROBING_SUPPORT_INT == 1)) begin:gen_pc_gpr_prob
        kv_pc_gpr_prob #(
            .EXTVALEN(EXTVALEN),
            .VALEN(VALEN)
        ) u_pc_gpr_prob (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .rf_raddr5(rf_raddr5),
            .rf_rdata5(rf_rdata5),
            .csr_prob_raddr(csr_prob_raddr),
            .csr_prob_rdata(csr_prob_rdata),
            .wb_i0_retire(wb_i0_retire),
            .wb_i1_retire(wb_i1_retire),
            .wb_i0_pc(wb_i0_pc),
            .wb_i1_pc(wb_i1_pc),
            .core_current_pc(core_current_pc),
            .core_gpr_index(core_gpr_index),
            .core_selected_gpr_value(core_selected_gpr_value)
        );
    end
endgenerate
generate
    if ((PC_GPR_PROBING_SUPPORT_INT == 0)) begin:gen_pc_gpr_prob_stub
        kv_pc_gpr_prob_stub #(
            .EXTVALEN(EXTVALEN),
            .VALEN(VALEN)
        ) u_pc_gpr_prob_stub (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .rf_raddr5(rf_raddr5),
            .rf_rdata5(rf_rdata5),
            .csr_prob_raddr(csr_prob_raddr),
            .csr_prob_rdata(csr_prob_rdata),
            .wb_i0_retire(wb_i0_retire),
            .wb_i1_retire(wb_i1_retire),
            .wb_i0_pc(wb_i0_pc),
            .wb_i1_pc(wb_i1_pc),
            .core_current_pc(core_current_pc),
            .core_gpr_index(core_gpr_index),
            .core_selected_gpr_value(core_selected_gpr_value)
        );
    end
endgenerate
generate
    if ((SLAVE_PORT_SUPPORT_INT == 1)) begin:gen_slvp
        kv_slvp #(
            .DLM_AMSB(DLM_AMSB),
            .DLM_BANK(NUM_DLM_BANKS),
            .DLM_ECC_TYPE_INT(DLM_ECC_TYPE_INT),
            .DLM_SIZE_KB(DLM_SIZE_KB),
            .DLM_UW(1),
            .ILM_AMSB(ILM_AMSB),
            .ILM_ECC_TYPE_INT(ILM_ECC_TYPE_INT),
            .ILM_SIZE_KB(ILM_SIZE_KB),
            .ILM_UW(3),
            .SLAVE_PORT_ADDR_WIDTH(BIU_ADDR_WIDTH),
            .SLAVE_PORT_ASYNC(SLAVE_PORT_ASYNC_SUPPORT),
            .SLAVE_PORT_DATA_WIDTH(SLAVE_PORT_DATA_WIDTH),
            .SLAVE_PORT_ID_WIDTH(SLAVE_PORT_ID_WIDTH)
        ) u_slvp (
            .slv_clk(slv_clk),
            .slv_reset_n(slv_reset_n_int),
            .slv_clk_en(slv_clk_en),
            .slv1_clk(slv1_clk),
            .slv1_reset_n(slv1_reset_n_int),
            .slv1_clk_en(slv1_clk_en),
            .lm_clk(lm_clk),
            .lm_reset_n(lm_reset_n),
            .lm_reset_done(lm_reset_done),
            .csr_mdlmb_eccen(csr_mdlmb_eccen),
            .csr_milmb_eccen(csr_milmb_eccen),
            .slvp_ipipe_ecc_corr(slvp_async_ecc_corr),
            .slvp_ipipe_ecc_ramid(slvp_async_ecc_ramid),
            .slvp_ipipe_local_int(slvp_async_local_int),
            .slv0_awid(slv_awid),
            .slv0_awaddr(slv_awaddr),
            .slv0_awlen(slv_awlen),
            .slv0_awsize(slv_awsize),
            .slv0_awburst(slv_awburst),
            .slv0_awlock(slv_awlock),
            .slv0_awcache(slv_awcache),
            .slv0_awprot(slv_awprot),
            .slv0_awuser(slv_awuser),
            .slv0_awready(slv_awready),
            .slv0_awvalid(slv_awvalid),
            .slv0_wdata(slv_wdata),
            .slv0_wstrb(slv_wstrb),
            .slv0_wlast(slv_wlast),
            .slv0_wvalid(slv_wvalid),
            .slv0_wready(slv_wready),
            .slv0_bid(slv_bid),
            .slv0_bresp(slv_bresp),
            .slv0_bvalid(slv_bvalid),
            .slv0_bready(slv_bready),
            .slv0_arid(slv_arid),
            .slv0_araddr(slv_araddr),
            .slv0_arlen(slv_arlen),
            .slv0_arsize(slv_arsize),
            .slv0_arburst(slv_arburst),
            .slv0_arlock(slv_arlock),
            .slv0_arcache(slv_arcache),
            .slv0_arprot(slv_arprot),
            .slv0_aruser(slv_aruser),
            .slv0_arvalid(slv_arvalid),
            .slv0_arready(slv_arready),
            .slv0_rid(slv_rid),
            .slv0_rdata(slv_rdata),
            .slv0_rresp(slv_rresp),
            .slv0_rlast(slv_rlast),
            .slv0_rvalid(slv_rvalid),
            .slv0_rready(slv_rready),
            .slv1_awid(slv1_awid),
            .slv1_awaddr(slv1_awaddr),
            .slv1_awlen(slv1_awlen),
            .slv1_awsize(slv1_awsize),
            .slv1_awburst(slv1_awburst),
            .slv1_awlock(slv1_awlock),
            .slv1_awcache(slv1_awcache),
            .slv1_awprot(slv1_awprot),
            .slv1_awuser(slv1_awuser),
            .slv1_awready(slv1_awready),
            .slv1_awvalid(slv1_awvalid),
            .slv1_wdata(slv1_wdata),
            .slv1_wstrb(slv1_wstrb),
            .slv1_wlast(slv1_wlast),
            .slv1_wvalid(slv1_wvalid),
            .slv1_wready(slv1_wready),
            .slv1_bid(slv1_bid),
            .slv1_bresp(slv1_bresp),
            .slv1_bvalid(slv1_bvalid),
            .slv1_bready(slv1_bready),
            .slv1_arid(slv1_arid),
            .slv1_araddr(slv1_araddr),
            .slv1_arlen(slv1_arlen),
            .slv1_arsize(slv1_arsize),
            .slv1_arburst(slv1_arburst),
            .slv1_arlock(slv1_arlock),
            .slv1_arcache(slv1_arcache),
            .slv1_arprot(slv1_arprot),
            .slv1_aruser(slv1_aruser),
            .slv1_arvalid(slv1_arvalid),
            .slv1_arready(slv1_arready),
            .slv1_rid(slv1_rid),
            .slv1_rdata(slv1_rdata),
            .slv1_rresp(slv1_rresp),
            .slv1_rlast(slv1_rlast),
            .slv1_rvalid(slv1_rvalid),
            .slv1_rready(slv1_rready),
            .slv_ilm_a_addr(slv_ilm_a_addr),
            .slv_ilm_a_mask(slv_ilm_a_mask),
            .slv_ilm_a_func(slv_ilm_a_func),
            .slv_ilm_a_stall(slv_ilm_a_stall),
            .slv_ilm_a_user(slv_ilm_a_user),
            .slv_ilm_a_valid(slv_ilm_a_valid),
            .slv_ilm_a_ready(slv_ilm_a_ready),
            .slv_ilm_d_data(slv_ilm_d_data),
            .slv_ilm_d_status(slv_ilm_d_status),
            .slv_ilm_d_user(slv_ilm_d_user),
            .slv_ilm_d_valid(slv_ilm_d_valid),
            .slv_ilm_w_data(slv_ilm_w_data),
            .slv_ilm_w_mask(slv_ilm_w_mask),
            .slv_ilm_w_valid(slv_ilm_w_valid),
            .slv_ilm_w_ready(slv_ilm_w_ready),
            .slv_dlm0_a_addr(slv_dlm0_a_addr),
            .slv_dlm0_a_func(slv_dlm0_a_func),
            .slv_dlm0_a_stall(slv_dlm0_a_stall),
            .slv_dlm0_a_user(slv_dlm0_a_user),
            .slv_dlm0_a_valid(slv_dlm0_a_valid),
            .slv_dlm0_a_ready(slv_dlm0_a_ready),
            .slv_dlm0_d_data(slv_dlm0_d_data),
            .slv_dlm0_d_status(slv_dlm0_d_status),
            .slv_dlm0_d_user(slv_dlm0_d_user),
            .slv_dlm0_d_valid(slv_dlm0_d_valid),
            .slv_dlm0_w_data(slv_dlm0_w_data),
            .slv_dlm0_w_mask(slv_dlm0_w_mask),
            .slv_dlm0_w_valid(slv_dlm0_w_valid),
            .slv_dlm0_w_ready(slv_dlm0_w_ready),
            .slv_dlm1_a_addr(slv_dlm1_a_addr),
            .slv_dlm1_a_func(slv_dlm1_a_func),
            .slv_dlm1_a_stall(slv_dlm1_a_stall),
            .slv_dlm1_a_user(slv_dlm1_a_user),
            .slv_dlm1_a_valid(slv_dlm1_a_valid),
            .slv_dlm1_a_ready(slv_dlm1_a_ready),
            .slv_dlm1_d_data(slv_dlm1_d_data),
            .slv_dlm1_d_status(slv_dlm1_d_status),
            .slv_dlm1_d_user(slv_dlm1_d_user),
            .slv_dlm1_d_valid(slv_dlm1_d_valid),
            .slv_dlm1_w_data(slv_dlm1_w_data),
            .slv_dlm1_w_mask(slv_dlm1_w_mask),
            .slv_dlm1_w_valid(slv_dlm1_w_valid),
            .slv_dlm1_w_ready(slv_dlm1_w_ready),
            .slv_dlm2_a_addr(slv_dlm2_a_addr),
            .slv_dlm2_a_func(slv_dlm2_a_func),
            .slv_dlm2_a_stall(slv_dlm2_a_stall),
            .slv_dlm2_a_user(slv_dlm2_a_user),
            .slv_dlm2_a_valid(slv_dlm2_a_valid),
            .slv_dlm2_a_ready(slv_dlm2_a_ready),
            .slv_dlm2_d_data(slv_dlm2_d_data),
            .slv_dlm2_d_status(slv_dlm2_d_status),
            .slv_dlm2_d_user(slv_dlm2_d_user),
            .slv_dlm2_d_valid(slv_dlm2_d_valid),
            .slv_dlm2_w_data(slv_dlm2_w_data),
            .slv_dlm2_w_mask(slv_dlm2_w_mask),
            .slv_dlm2_w_valid(slv_dlm2_w_valid),
            .slv_dlm2_w_ready(slv_dlm2_w_ready),
            .slv_dlm3_a_addr(slv_dlm3_a_addr),
            .slv_dlm3_a_func(slv_dlm3_a_func),
            .slv_dlm3_a_stall(slv_dlm3_a_stall),
            .slv_dlm3_a_user(slv_dlm3_a_user),
            .slv_dlm3_a_valid(slv_dlm3_a_valid),
            .slv_dlm3_a_ready(slv_dlm3_a_ready),
            .slv_dlm3_d_data(slv_dlm3_d_data),
            .slv_dlm3_d_status(slv_dlm3_d_status),
            .slv_dlm3_d_user(slv_dlm3_d_user),
            .slv_dlm3_d_valid(slv_dlm3_d_valid),
            .slv_dlm3_w_data(slv_dlm3_w_data),
            .slv_dlm3_w_mask(slv_dlm3_w_mask),
            .slv_dlm3_w_valid(slv_dlm3_w_valid),
            .slv_dlm3_w_ready(slv_dlm3_w_ready)
        );
    end
endgenerate
kv_itlb #(
    .EXTVALEN(EXTVALEN),
    .ITLB_ENTRIES(ITLB_ENTRIES),
    .MMU_SCHEME_INT(MMU_SCHEME_INT),
    .PALEN(PALEN),
    .STLB_ECC_TYPE(STLB_ECC_TYPE),
    .VALEN(VALEN)
) kv_itlb (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .itlb_translate_en(itlb_translate_en),
    .csr_cur_privilege(csr_cur_privilege),
    .csr_satp_mode(csr_satp_mode),
    .csr_mmu_satp_we(csr_mmu_satp_we),
    .ifu_itlb_req_valid(ifu_itlb_req_valid),
    .ifu_itlb_va(ifu_itlb_va),
    .itlb_ifu_pa(itlb_ifu_pa),
    .itlb_ifu_status(itlb_ifu_status),
    .ifu_mmu_req_valid(ifu_mmu_req_valid),
    .ifu_mmu_va(ifu_mmu_va),
    .mmu_ifu_resp_valid(mmu_ifu_resp_valid),
    .itlb_miss_req(itlb_miss_req),
    .itlb_miss_vpn(itlb_miss_vpn),
    .itlb_miss_resp(itlb_miss_resp),
    .itlb_miss_data(itlb_miss_data),
    .itlb_sfence_req(itlb_sfence_req),
    .itlb_sfence_mode_flush_all(itlb_sfence_mode_flush_all),
    .itlb_sfence_mode_va(itlb_sfence_mode_va)
);
kv_dtlb #(
    .DTLB_ENTRIES(DTLB_ENTRIES),
    .EXTVALEN(EXTVALEN),
    .MMU_SCHEME_INT(MMU_SCHEME_INT),
    .PALEN(PALEN),
    .STLB_ECC_TYPE(STLB_ECC_TYPE),
    .VALEN(VALEN)
) kv_dtlb (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_mstatus_mxr(csr_mstatus_mxr),
    .csr_mstatus_sum(csr_mstatus_sum),
    .csr_mmu_satp_we(csr_mmu_satp_we),
    .lsu_dtlb_privilege_u(lsu_dtlb_privilege_u),
    .lsu_dtlb_va_op0(lsu_dtlb_va_op0),
    .lsu_dtlb_va_op1(lsu_dtlb_va_op1),
    .lsu_dtlb_store(lsu_dtlb_store),
    .dtlb_lsu_ppn(dtlb_lsu_ppn),
    .dtlb_lsu_status(dtlb_lsu_status),
    .lsu_dtlb_lru_valid(lsu_dtlb_lru_valid),
    .lsu_dtlb_lru_wdata(lsu_dtlb_lru_wdata),
    .lsu_mmu_req_valid(lsu_mmu_req_valid),
    .lsu_mmu_va(lsu_mmu_va),
    .mmu_lsu_resp_valid(mmu_lsu_resp_valid),
    .dtlb_miss_req(dtlb_miss_req),
    .dtlb_miss_vpn(dtlb_miss_vpn),
    .dtlb_miss_resp(dtlb_miss_resp),
    .dtlb_miss_data(dtlb_miss_data),
    .dtlb_sfence_req(dtlb_sfence_req),
    .dtlb_sfence_mode_flush_all(dtlb_sfence_mode_flush_all),
    .dtlb_sfence_mode_va(dtlb_sfence_mode_va)
);
kv_mmu #(
    .DTLB_ENTRIES(DTLB_ENTRIES),
    .EXTVALEN(EXTVALEN),
    .ITLB_ENTRIES(ITLB_ENTRIES),
    .MMU_SCHEME_INT(MMU_SCHEME_INT),
    .PALEN(PALEN),
    .STLB_ECC_TYPE(STLB_ECC_TYPE),
    .STLB_ENTRIES(STLB_ENTRIES),
    .STLB_SP_ENTRIES(STLB_SP_ENTRIES),
    .VALEN(VALEN)
) kv_mmu (
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_satp_ppn(csr_satp_ppn),
    .csr_satp_mode(csr_satp_mode),
    .csr_satp_asid(csr_satp_asid),
    .csr_mmu_satp_we(csr_mmu_satp_we),
    .csr_mcache_ctl_tlb_eccen(csr_mcache_ctl_tlb_eccen),
    .csr_mcache_ctl_tlb_rwecc(csr_mcache_ctl_tlb_rwecc),
    .csr_mecc_code(csr_mecc_code),
    .tlb_cctl_req(tlb_cctl_req),
    .tlb_cctl_command(tlb_cctl_command),
    .tlb_cctl_waddr(tlb_cctl_waddr),
    .tlb_cctl_wdata(tlb_cctl_wdata),
    .tlb_cctl_ack(tlb_cctl_ack),
    .tlb_cctl_raddr(tlb_cctl_raddr),
    .tlb_cctl_rdata(tlb_cctl_rdata),
    .tlb_cctl_ecc_status(tlb_cctl_ecc_status),
    .mmu_csr_mitlb_access(mmu_csr_mitlb_access),
    .mmu_csr_mitlb_miss(mmu_csr_mitlb_miss),
    .mmu_csr_mdtlb_access(mmu_csr_mdtlb_access),
    .mmu_csr_mdtlb_miss(mmu_csr_mdtlb_miss),
    .mmu_fence_req(mmu_fence_req),
    .mmu_fence_mode(mmu_fence_mode),
    .mmu_fence_vaddr(mmu_fence_vaddr),
    .mmu_fence_asid(mmu_fence_asid),
    .mmu_fence_done(mmu_fence_done),
    .mmu_ipipe_standby_ready(mmu_ipipe_standby_ready),
    .dtlb_miss_req(dtlb_miss_req),
    .dtlb_miss_vpn(dtlb_miss_vpn),
    .dtlb_miss_resp(dtlb_miss_resp),
    .dtlb_miss_data(dtlb_miss_data),
    .dtlb_sfence_req(dtlb_sfence_req),
    .dtlb_sfence_mode_flush_all(dtlb_sfence_mode_flush_all),
    .dtlb_sfence_mode_va(dtlb_sfence_mode_va),
    .itlb_miss_req(itlb_miss_req),
    .itlb_miss_vpn(itlb_miss_vpn),
    .itlb_miss_resp(itlb_miss_resp),
    .itlb_miss_data(itlb_miss_data),
    .itlb_sfence_req(itlb_sfence_req),
    .itlb_sfence_mode_flush_all(itlb_sfence_mode_flush_all),
    .itlb_sfence_mode_va(itlb_sfence_mode_va),
    .mmu_iptw_req_valid(mmu_iptw_req_valid),
    .mmu_iptw_req_pa(mmu_iptw_req_pa),
    .iptw_mmu_req_ready(iptw_mmu_req_ready),
    .iptw_mmu_resp_valid(iptw_mmu_resp_valid),
    .iptw_mmu_resp_status(iptw_mmu_resp_status),
    .iptw_mmu_resp_data(iptw_mmu_resp_data),
    .mmu_dptw_req_valid(mmu_dptw_req_valid),
    .mmu_dptw_req_pa(mmu_dptw_req_pa),
    .dptw_mmu_req_ready(dptw_mmu_req_ready),
    .dptw_mmu_resp_valid(dptw_mmu_resp_valid),
    .dptw_mmu_resp_status(dptw_mmu_resp_status),
    .dptw_mmu_resp_data(dptw_mmu_resp_data),
    .stlb0_cs(stlb0_cs),
    .stlb1_cs(stlb1_cs),
    .stlb2_cs(stlb2_cs),
    .stlb3_cs(stlb3_cs),
    .stlb0_we(stlb0_we),
    .stlb1_we(stlb1_we),
    .stlb2_we(stlb2_we),
    .stlb3_we(stlb3_we),
    .stlb0_addr(stlb0_addr),
    .stlb1_addr(stlb1_addr),
    .stlb2_addr(stlb2_addr),
    .stlb3_addr(stlb3_addr),
    .stlb0_wdata(stlb0_wdata),
    .stlb1_wdata(stlb1_wdata),
    .stlb2_wdata(stlb2_wdata),
    .stlb3_wdata(stlb3_wdata),
    .stlb0_rdata(stlb0_rdata),
    .stlb1_rdata(stlb1_rdata),
    .stlb2_rdata(stlb2_rdata),
    .stlb3_rdata(stlb3_rdata),
    .stlb_tag0_cs(stlb_tag0_cs),
    .stlb_tag1_cs(stlb_tag1_cs),
    .stlb_tag2_cs(stlb_tag2_cs),
    .stlb_tag3_cs(stlb_tag3_cs),
    .stlb_tag0_we(stlb_tag0_we),
    .stlb_tag1_we(stlb_tag1_we),
    .stlb_tag2_we(stlb_tag2_we),
    .stlb_tag3_we(stlb_tag3_we),
    .stlb_tag0_addr(stlb_tag0_addr),
    .stlb_tag1_addr(stlb_tag1_addr),
    .stlb_tag2_addr(stlb_tag2_addr),
    .stlb_tag3_addr(stlb_tag3_addr),
    .stlb_tag0_wdata(stlb_tag0_wdata),
    .stlb_tag1_wdata(stlb_tag1_wdata),
    .stlb_tag2_wdata(stlb_tag2_wdata),
    .stlb_tag3_wdata(stlb_tag3_wdata),
    .stlb_tag0_rdata(stlb_tag0_rdata),
    .stlb_tag1_rdata(stlb_tag1_rdata),
    .stlb_tag2_rdata(stlb_tag2_rdata),
    .stlb_tag3_rdata(stlb_tag3_rdata),
    .stlb_data0_cs(stlb_data0_cs),
    .stlb_data1_cs(stlb_data1_cs),
    .stlb_data2_cs(stlb_data2_cs),
    .stlb_data3_cs(stlb_data3_cs),
    .stlb_data0_we(stlb_data0_we),
    .stlb_data1_we(stlb_data1_we),
    .stlb_data2_we(stlb_data2_we),
    .stlb_data3_we(stlb_data3_we),
    .stlb_data0_addr(stlb_data0_addr),
    .stlb_data1_addr(stlb_data1_addr),
    .stlb_data2_addr(stlb_data2_addr),
    .stlb_data3_addr(stlb_data3_addr),
    .stlb_data0_wdata(stlb_data0_wdata),
    .stlb_data1_wdata(stlb_data1_wdata),
    .stlb_data2_wdata(stlb_data2_wdata),
    .stlb_data3_wdata(stlb_data3_wdata),
    .stlb_data0_rdata(stlb_data0_rdata),
    .stlb_data1_rdata(stlb_data1_rdata),
    .stlb_data2_rdata(stlb_data2_rdata),
    .stlb_data3_rdata(stlb_data3_rdata)
);
kv_pmp #(
    .DEBUG_VEC(DEBUG_VEC),
    .PALEN(PALEN),
    .PMP_ENTRIES(PMP_ENTRIES),
    .PMP_GRANULARITY(PMP_GRANULARITY)
) kv_pmp (
    .ifu_pmp_req_pa(ifu_pmp_req_pa),
    .pmp_ifu_resp_fault(pmp_ifu_resp_fault),
    .csr_dcsr_mprven(csr_dcsr_mprven),
    .csr_halt_mode(csr_halt_mode),
    .csr_mstatus_mprv(csr_mstatus_mprv),
    .csr_mstatus_mpp(csr_mstatus_mpp),
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .csr_cur_privilege(csr_cur_privilege),
    .lsu_pmp_req_pa(lsu_pmp_req_pa),
    .lsu_pmp_req_store(lsu_pmp_req_store),
    .pmp_lsu_resp_fault(pmp_lsu_resp_fault),
    .vpu_pmp_req_pa(vpu_pmp_req_pa),
    .vpu_pmp_resp_permission(vpu_pmp_resp_permission),
    .csr_pmp_raddr0(csr_pmp_raddr0),
    .csr_pmp_raddr1(csr_pmp_raddr1),
    .csr_pmp_waddr(csr_pmp_waddr),
    .csr_pmp_wdata(csr_pmp_wdata),
    .csr_pmp_we(csr_pmp_we),
    .pmp_csr_hit0(pmp_csr_hit0),
    .pmp_csr_hit1(pmp_csr_hit1),
    .pmp_csr_rdata0(pmp_csr_rdata0),
    .pmp_csr_rdata1(pmp_csr_rdata1)
);
kv_pma #(
    .CLUSTER_SUPPORT_INT(CLUSTER_SUPPORT_INT),
    .DEVICE_REGION0_BASE(DEVICE_REGION0_BASE),
    .DEVICE_REGION0_MASK(DEVICE_REGION0_MASK),
    .DEVICE_REGION1_BASE(DEVICE_REGION1_BASE),
    .DEVICE_REGION1_MASK(DEVICE_REGION1_MASK),
    .DEVICE_REGION2_BASE(DEVICE_REGION2_BASE),
    .DEVICE_REGION2_MASK(DEVICE_REGION2_MASK),
    .DEVICE_REGION3_BASE(DEVICE_REGION3_BASE),
    .DEVICE_REGION3_MASK(DEVICE_REGION3_MASK),
    .DEVICE_REGION4_BASE(DEVICE_REGION4_BASE),
    .DEVICE_REGION4_MASK(DEVICE_REGION4_MASK),
    .DEVICE_REGION5_BASE(DEVICE_REGION5_BASE),
    .DEVICE_REGION5_MASK(DEVICE_REGION5_MASK),
    .DEVICE_REGION6_BASE(DEVICE_REGION6_BASE),
    .DEVICE_REGION6_MASK(DEVICE_REGION6_MASK),
    .DEVICE_REGION7_BASE(DEVICE_REGION7_BASE),
    .DEVICE_REGION7_MASK(DEVICE_REGION7_MASK),
    .PALEN(PALEN),
    .PMA_ENTRIES(PMA_ENTRIES),
    .WRITETHROUGH_REGION0_BASE(WRITETHROUGH_REGION0_BASE),
    .WRITETHROUGH_REGION0_MASK(WRITETHROUGH_REGION0_MASK),
    .WRITETHROUGH_REGION1_BASE(WRITETHROUGH_REGION1_BASE),
    .WRITETHROUGH_REGION1_MASK(WRITETHROUGH_REGION1_MASK),
    .WRITETHROUGH_REGION2_BASE(WRITETHROUGH_REGION2_BASE),
    .WRITETHROUGH_REGION2_MASK(WRITETHROUGH_REGION2_MASK),
    .WRITETHROUGH_REGION3_BASE(WRITETHROUGH_REGION3_BASE),
    .WRITETHROUGH_REGION3_MASK(WRITETHROUGH_REGION3_MASK),
    .WRITETHROUGH_REGION4_BASE(WRITETHROUGH_REGION4_BASE),
    .WRITETHROUGH_REGION4_MASK(WRITETHROUGH_REGION4_MASK),
    .WRITETHROUGH_REGION5_BASE(WRITETHROUGH_REGION5_BASE),
    .WRITETHROUGH_REGION5_MASK(WRITETHROUGH_REGION5_MASK),
    .WRITETHROUGH_REGION6_BASE(WRITETHROUGH_REGION6_BASE),
    .WRITETHROUGH_REGION6_MASK(WRITETHROUGH_REGION6_MASK),
    .WRITETHROUGH_REGION7_BASE(WRITETHROUGH_REGION7_BASE),
    .WRITETHROUGH_REGION7_MASK(WRITETHROUGH_REGION7_MASK)
) kv_pma (
    .ifu_pma_req_pa(ifu_pma_req_pa),
    .pma_ifu_resp_fault(pma_ifu_resp_fault),
    .pma_ifu_resp_mtype(pma_ifu_resp_mtype),
    .core_clk(core_clk),
    .core_reset_n(core_reset_n),
    .lsu_pma_req_pa(lsu_pma_req_pa),
    .pma_lsu_resp_fault(pma_lsu_resp_fault),
    .pma_lsu_resp_mtype(pma_lsu_resp_mtype),
    .pma_lsu_resp_namo(pma_lsu_resp_namo),
    .vpu_pma_req_pa(vpu_pma_req_pa),
    .vpu_pma_resp_fault(vpu_pma_resp_fault),
    .vpu_pma_resp_mtype(vpu_pma_resp_mtype),
    .csr_cur_privilege(csr_cur_privilege),
    .csr_pma_raddr0(csr_pma_raddr0),
    .csr_pma_raddr1(csr_pma_raddr1),
    .csr_pma_waddr(csr_pma_waddr),
    .csr_pma_wdata(csr_pma_wdata),
    .csr_pma_we(csr_pma_we),
    .pma_csr_hit0(pma_csr_hit0),
    .pma_csr_hit1(pma_csr_hit1),
    .pma_csr_rdata0(pma_csr_rdata0),
    .pma_csr_rdata1(pma_csr_rdata1)
);
generate
    if ((DSP_SUPPORT_INT == 1)) begin:gen_dsp
        kv_dsp kv_dsp(
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .dsp_instr_valid(dsp_instr_valid),
            .dsp_operand_ctrl(dsp_operand_ctrl),
            .dsp_function_ctrl(dsp_function_ctrl),
            .dsp_result_ctrl(dsp_result_ctrl),
            .dsp_overflow_ctrl(dsp_overflow_ctrl),
            .dsp_data_src1(dsp_data_src1),
            .dsp_data_src2(dsp_data_src2),
            .dsp_data_src3(dsp_data_src3),
            .dsp_data_src4(dsp_data_src4),
            .dsp_stage2_pipe_en(dsp_stage2_pipe_en),
            .dsp_stage3_pipe_en(dsp_stage3_pipe_en),
            .dsp_stage1_result(dsp_stage1_result),
            .dsp_stage1_ovf_set(dsp_stage1_ovf_set),
            .dsp_stage2_result(dsp_stage2_result),
            .dsp_stage2_ovf_set(dsp_stage2_ovf_set),
            .dsp_stage3_result(dsp_stage3_result),
            .dsp_stage3_ovf_set(dsp_stage3_ovf_set)
        );
    end
endgenerate
generate
    if ((DSP_SUPPORT_INT != 1)) begin:gen_dsp_stub
        kv_dsp_stub kv_dsp_stub(
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .dsp_instr_valid(dsp_instr_valid),
            .dsp_operand_ctrl(dsp_operand_ctrl),
            .dsp_function_ctrl(dsp_function_ctrl),
            .dsp_result_ctrl(dsp_result_ctrl),
            .dsp_overflow_ctrl(dsp_overflow_ctrl),
            .dsp_data_src1(dsp_data_src1),
            .dsp_data_src2(dsp_data_src2),
            .dsp_data_src3(dsp_data_src3),
            .dsp_data_src4(dsp_data_src4),
            .dsp_stage2_pipe_en(dsp_stage2_pipe_en),
            .dsp_stage3_pipe_en(dsp_stage3_pipe_en),
            .dsp_stage1_result(dsp_stage1_result),
            .dsp_stage1_ovf_set(dsp_stage1_ovf_set),
            .dsp_stage2_result(dsp_stage2_result),
            .dsp_stage2_ovf_set(dsp_stage2_ovf_set),
            .dsp_stage3_result(dsp_stage3_result),
            .dsp_stage3_ovf_set(dsp_stage3_ovf_set)
        );
    end
endgenerate
generate
    if (FLEN != 1) begin:gen_frf
        kv_frf #(
            .FLEN(FLEN)
        ) kv_frf (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .rf_init(rf_init),
            .frf_raddr1(frf_raddr1),
            .frf_rdata1(frf_rdata1),
            .frf_raddr2(frf_raddr2),
            .frf_rdata2(frf_rdata2),
            .frf_raddr3(frf_raddr3),
            .frf_rdata3(frf_rdata3),
            .frf_raddr4(frf_raddr4),
            .frf_rdata4(frf_rdata4),
            .frf_we1(frf_we1),
            .frf_waddr1(frf_waddr1),
            .frf_wdata1(frf_wdata1),
            .frf_wstatus1(frf_wstatus1),
            .frf_we2(frf_we2),
            .frf_waddr2(frf_waddr2),
            .frf_wdata2(frf_wdata2),
            .frf_wstatus2(frf_wstatus2),
            .frf_we3(frf_we3),
            .frf_waddr3(frf_waddr3),
            .frf_wdata3(frf_wdata3),
            .frf_wstatus3(frf_wstatus3)
        );
    end
endgenerate
generate
    if (FLEN == 1) begin:gen_frf_stub
        kv_frf_stub #(
            .FLEN(FLEN)
        ) kv_frf (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .hart_under_reset(hart_under_reset),
            .frf_raddr1(frf_raddr1),
            .frf_rdata1(frf_rdata1),
            .frf_raddr2(frf_raddr2),
            .frf_rdata2(frf_rdata2),
            .frf_raddr3(frf_raddr3),
            .frf_rdata3(frf_rdata3),
            .frf_raddr4(frf_raddr4),
            .frf_rdata4(frf_rdata4),
            .frf_we1(frf_we1),
            .frf_waddr1(frf_waddr1),
            .frf_wdata1(frf_wdata1),
            .frf_wstatus1(frf_wstatus1),
            .frf_we2(frf_we2),
            .frf_waddr2(frf_waddr2),
            .frf_wdata2(frf_wdata2),
            .frf_wstatus2(frf_wstatus2),
            .frf_we3(frf_we3),
            .frf_waddr3(frf_waddr3),
            .frf_wdata3(frf_wdata3),
            .frf_wstatus3(frf_wstatus3)
        );
    end
endgenerate
generate
    if (FLEN != 1) begin:gen_fpu
        kv_fpu #(
            .FLEN(FLEN)
        ) kv_fpu (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .fpu_i0_ctrl(fpu_i0_ctrl),
            .fpu_i0_valid(fpu_i0_valid),
            .fpu_i0_frs1(fpu_i0_frs1),
            .fpu_i0_frs2(fpu_i0_frs2),
            .fpu_i0_frs3(fpu_i0_frs3),
            .fpu_i1_ctrl(fpu_i1_ctrl),
            .fpu_i1_valid(fpu_i1_valid),
            .fpu_i1_frs1(fpu_i1_frs1),
            .fpu_i1_frs2(fpu_i1_frs2),
            .fpu_i1_frs3(fpu_i1_frs3),
            .fpu_lx_stall(fpu_lx_stall),
            .fpu_ipipe_standby_ready(fpu_ipipe_standby_ready),
            .fpu_ipipe_fdiv_standby_ready(fpu_ipipe_fdiv_standby_ready),
            .fpu_fmis_result(fpu_fmis_result),
            .fmis_flag_set(fmis_flag_set),
            .fpu_fmv_result(fpu_fmv_result),
            .fpu_fmac32_result(fpu_fmac32_result),
            .fpu_fmac64_result(fpu_fmac64_result),
            .fmac_flag_set(fmac_flag_set),
            .fdiv_req_ready(fdiv_req_ready),
            .fdiv_resp_result(fdiv_resp_result),
            .fdiv_resp_tag(fdiv_resp_tag),
            .fdiv_resp_valid(fdiv_resp_valid),
            .fdiv_resp_ready(fdiv_resp_ready),
            .fdiv_resp_flag_set(fdiv_resp_flag_set),
            .fdiv_kill(fdiv_kill)
        );
    end
endgenerate
generate
    if (FLEN == 1) begin:gen_fpu_stub
        kv_fpu_stub #(
            .FLEN(FLEN)
        ) kv_fpu (
            .core_clk(core_clk),
            .core_reset_n(core_reset_n),
            .fpu_i0_ctrl(fpu_i0_ctrl),
            .fpu_i0_valid(fpu_i0_valid),
            .fpu_i0_frs1(fpu_i0_frs1),
            .fpu_i0_frs2(fpu_i0_frs2),
            .fpu_i0_frs3(fpu_i0_frs3),
            .fpu_i1_ctrl(fpu_i1_ctrl),
            .fpu_i1_valid(fpu_i1_valid),
            .fpu_i1_frs1(fpu_i1_frs1),
            .fpu_i1_frs2(fpu_i1_frs2),
            .fpu_i1_frs3(fpu_i1_frs3),
            .fpu_lx_stall(fpu_lx_stall),
            .fdiv_kill(fdiv_kill),
            .fpu_ipipe_standby_ready(fpu_ipipe_standby_ready),
            .fpu_ipipe_fdiv_standby_ready(fpu_ipipe_fdiv_standby_ready),
            .fpu_fmis_result(fpu_fmis_result),
            .fpu_fmv_result(fpu_fmv_result),
            .fpu_fmac32_result(fpu_fmac32_result),
            .fpu_fmac64_result(fpu_fmac64_result),
            .fmis_flag_set(fmis_flag_set),
            .fmac_flag_set(fmac_flag_set),
            .fdiv_resp_result(fdiv_resp_result),
            .fdiv_resp_valid(fdiv_resp_valid),
            .fdiv_resp_ready(fdiv_resp_ready),
            .fdiv_resp_tag(fdiv_resp_tag),
            .fdiv_resp_flag_set(fdiv_resp_flag_set),
            .fdiv_req_ready(fdiv_req_ready)
        );
    end
endgenerate
endmodule


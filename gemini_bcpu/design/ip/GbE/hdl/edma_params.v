  parameter [31:0] p_edma_queues              = `edma_queues;
  parameter [31:0] p_edma_tx_pbuf_data        = `edma_tx_pbuf_data;
  parameter [31:0] p_edma_rx_pbuf_data        = `edma_rx_pbuf_data;
  parameter [31:0] p_edma_tx_pbuf_addr        = `edma_tx_pbuf_addr;
  parameter [31:0] p_edma_rx_pbuf_addr        = `edma_rx_pbuf_addr;
  `ifdef edma_has_802p3_br
    parameter [31:0] p_edma_emac_tx_pbuf_addr = `edma_emac_tx_pbuf_addr;
    parameter [31:0] p_edma_emac_rx_pbuf_addr = `edma_emac_rx_pbuf_addr;
  `else
    parameter [31:0] p_edma_emac_tx_pbuf_addr = 32'd10;
    parameter [31:0] p_edma_emac_rx_pbuf_addr = 32'd10;
  `endif
  parameter p_edma_tx_pbuf_queue_segment_size = `edma_tx_pbuf_queue_segment_size;
  parameter [31:0] p_emac_bus_width           = `emac_bus_width;
  parameter [31:0] p_edma_bus_width           = `edma_bus_width;
  parameter p_edma_addr_width                 = `edma_addr_width;
  parameter p_edma_rx_fifo_size               = `gem_rx_fifo_size;
  parameter p_edma_tx_fifo_size               = `gem_tx_fifo_size;
  parameter p_edma_rx_base2_fifo_size         = `gem_rx_base2_fifo_size;
  parameter p_edma_tx_base2_fifo_size         = `gem_tx_base2_fifo_size;
  parameter p_edma_rx_fifo_cnt_width          = `gem_rx_fifo_cnt_width ;
  parameter p_edma_tx_fifo_cnt_width          = `gem_tx_fifo_cnt_width ;
  parameter p_edma_axi_access_pipeline_bits   = `edma_axi_access_pipeline_bits;
  parameter p_edma_axi_tx_descr_rd_buff_bits  = `edma_axi_tx_descr_rd_buff_bits;
  parameter p_edma_axi_rx_descr_rd_buff_bits  = `edma_axi_rx_descr_rd_buff_bits;
  parameter p_edma_axi_tx_descr_wr_buff_bits  = `edma_axi_tx_descr_wr_buff_bits;
  parameter p_edma_axi_rx_descr_wr_buff_bits  = `edma_axi_rx_descr_wr_buff_bits;
  parameter p_edma_hprot_value                = `edma_hprot_value;
  parameter p_edma_axi_prot_value             = `edma_axi_prot_value;
  parameter p_edma_axi_arcache_value          = `edma_axi_arcache_value;
  parameter p_edma_axi_awcache_value          = `edma_axi_awcache_value;
  parameter p_edma_dma_bus_width_def          = `edma_dma_bus_width_def;
  parameter p_edma_mdc_clock_div              = `edma_mdc_clock_div;
  parameter p_edma_endian_swap_def            = `edma_endian_swap_def;
  parameter p_edma_rx_pbuf_size_def           = `edma_rx_pbuf_size_def;
  parameter p_edma_tx_pbuf_size_def           = `edma_tx_pbuf_size_def;
  parameter p_edma_rx_buffer_length_def       = `edma_rx_buffer_length_def;
  parameter p_edma_jumbo_max_length           = `edma_jumbo_max_length;
  parameter p_gem_rx_pipeline_delay           = `gem_rx_pipeline_delay;
  parameter p_edma_srd_width                  = `gem_pcs_if_width;

`ifdef gem_no_pcs
parameter p_edma_has_pcs = 1'b0;
`else
parameter p_edma_has_pcs = 1'b1;
`endif

`ifdef gem_pcs_legacy_if
parameter p_edma_pcs_legacy_if = 1'b1;
`else
parameter p_edma_pcs_legacy_if = 1'b0;
`endif

`ifdef gem_pcs_legacy_if
parameter p_edma_pcs_code_align = 1'b0;
`else
parameter p_edma_pcs_code_align = 1'b1;
`endif

`ifdef xgm
  parameter p_xgm                  = 1'b1;
`else
  parameter p_xgm                  = 1'b0;
`endif

`ifdef edma_phy_ident
  parameter p_edma_phy_ident       = 1'b1;
`else
  parameter p_edma_phy_ident       = 1'b0;
`endif

`ifdef num_spec_add_filters
  parameter p_num_spec_add_filters = `num_spec_add_filters;
`else
  parameter p_num_spec_add_filters = 32'd1;
`endif

`ifdef num_type1_screeners
  parameter p_num_type1_screeners = `num_type1_screeners;
`else
  parameter p_num_type1_screeners = 8'd0;
`endif
`ifdef num_type2_screeners
  parameter p_num_type2_screeners = `num_type2_screeners;
`else
  parameter p_num_type2_screeners = 8'd0;
`endif
`ifdef num_scr2_compare_regs
  parameter p_num_scr2_compare_regs = `num_scr2_compare_regs;
`else
  parameter p_num_scr2_compare_regs = 8'd0;
`endif
`ifdef num_scr2_ethtype_regs
  parameter p_num_scr2_ethtype_regs = `num_scr2_ethtype_regs;
`else
  parameter p_num_scr2_ethtype_regs = 8'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q0
  parameter p_edma_tx_pbuf_num_segments_q0 = `edma_tx_pbuf_num_segments_q0;
`else
  parameter p_edma_tx_pbuf_num_segments_q0 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q1
  parameter p_edma_tx_pbuf_num_segments_q1 = `edma_tx_pbuf_num_segments_q1;
`else
  parameter p_edma_tx_pbuf_num_segments_q1 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q2
  parameter p_edma_tx_pbuf_num_segments_q2 = `edma_tx_pbuf_num_segments_q2;
`else
  parameter p_edma_tx_pbuf_num_segments_q2 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q3
  parameter p_edma_tx_pbuf_num_segments_q3 = `edma_tx_pbuf_num_segments_q3;
`else
  parameter p_edma_tx_pbuf_num_segments_q3 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q4
  parameter p_edma_tx_pbuf_num_segments_q4 = `edma_tx_pbuf_num_segments_q4;
`else
  parameter p_edma_tx_pbuf_num_segments_q4 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q5
  parameter p_edma_tx_pbuf_num_segments_q5 = `edma_tx_pbuf_num_segments_q5;
`else
  parameter p_edma_tx_pbuf_num_segments_q5 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q6
  parameter p_edma_tx_pbuf_num_segments_q6 = `edma_tx_pbuf_num_segments_q6;
`else
  parameter p_edma_tx_pbuf_num_segments_q6 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q7
  parameter p_edma_tx_pbuf_num_segments_q7 = `edma_tx_pbuf_num_segments_q7;
`else
  parameter p_edma_tx_pbuf_num_segments_q7 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q8
  parameter p_edma_tx_pbuf_num_segments_q8 = `edma_tx_pbuf_num_segments_q8;
`else
  parameter p_edma_tx_pbuf_num_segments_q8 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q9
  parameter p_edma_tx_pbuf_num_segments_q9 = `edma_tx_pbuf_num_segments_q9;
`else
  parameter p_edma_tx_pbuf_num_segments_q9 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q10
  parameter p_edma_tx_pbuf_num_segments_q10 = `edma_tx_pbuf_num_segments_q10;
`else
  parameter p_edma_tx_pbuf_num_segments_q10 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q11
  parameter p_edma_tx_pbuf_num_segments_q11 = `edma_tx_pbuf_num_segments_q11;
`else
  parameter p_edma_tx_pbuf_num_segments_q11 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q12
  parameter p_edma_tx_pbuf_num_segments_q12 = `edma_tx_pbuf_num_segments_q12;
`else
  parameter p_edma_tx_pbuf_num_segments_q12 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q13
  parameter p_edma_tx_pbuf_num_segments_q13 = `edma_tx_pbuf_num_segments_q13;
`else
  parameter p_edma_tx_pbuf_num_segments_q13 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q14
  parameter p_edma_tx_pbuf_num_segments_q14 = `edma_tx_pbuf_num_segments_q14;
`else
  parameter p_edma_tx_pbuf_num_segments_q14 = 32'd0;
`endif
`ifdef edma_tx_pbuf_num_segments_q15
  parameter p_edma_tx_pbuf_num_segments_q15 = `edma_tx_pbuf_num_segments_q15;
`else
  parameter p_edma_tx_pbuf_num_segments_q15 = 32'd0;
`endif

`ifdef edma_exclude_cbs
  parameter p_edma_exclude_cbs = 1'b1;
`else
  parameter p_edma_exclude_cbs = 1'b0;
`endif

`ifdef edma_exclude_qbv
  parameter p_edma_exclude_qbv = 1'd1;
`else
  parameter p_edma_exclude_qbv = 1'd0;
`endif

`ifdef edma_pbuf_cutthru
  parameter p_edma_pbuf_cutthru = 1'b1;
`else
  parameter p_edma_pbuf_cutthru = 1'b0;
`endif

`ifdef edma_tsu
  parameter p_edma_tsu = 1'b1;
`else
  parameter p_edma_tsu = 1'b0;
`endif

`ifdef edma_asf_prot_tsu
  parameter p_edma_asf_prot_tsu = 1'd1;
`else
  parameter p_edma_asf_prot_tsu = 1'd0;
`endif

`ifdef edma_tsu_clk
  parameter p_edma_tsu_clk = 1'b1;
`else
  parameter p_edma_tsu_clk = 1'b0;
`endif

`ifdef edma_ext_tsu_timer
  parameter p_edma_ext_tsu_timer = 1'b1;
`else
  parameter p_edma_ext_tsu_timer = 1'b0;
`endif

`ifdef edma_axi
  parameter p_edma_axi = 1'b1;
`else
  parameter p_edma_axi = 1'b0;
`endif

`ifdef edma_pbuf_lso
  parameter p_edma_lso = p_edma_axi;  // LSO is only supported for AXI
`else
  parameter p_edma_lso = 1'b0;
`endif

`ifdef edma_pbuf_rsc
  parameter p_edma_rsc = p_edma_axi;  // RSC is only supported for AXI
`else
  parameter p_edma_rsc = 1'b0;
`endif

`ifdef edma_spram
  parameter p_edma_spram = 1'b1;
`else
  parameter p_edma_spram = 1'b0;
`endif

`ifdef edma_ext_fifo_interface
  parameter p_edma_ext_fifo_interface  = 1'b1;
`else
  parameter p_edma_ext_fifo_interface  = 1'b0;
`endif

`ifdef gem_add_rx_external_fifo_if
  parameter p_edma_add_rx_external_fifo_if  = 1'b1;
`else
  parameter p_edma_add_rx_external_fifo_if  = 1'b0;
`endif

`ifdef gem_add_tx_external_fifo_if
  parameter p_edma_add_tx_external_fifo_if  = 1'b1;
`else
  parameter p_edma_add_tx_external_fifo_if  = 1'b0;
`endif

`ifdef edma_host_if_soft_select
  parameter p_edma_host_if_soft_select = 1'b1;
`else
  parameter p_edma_host_if_soft_select = 1'b0;
`endif

`ifdef edma_pfc_multi_quantum
  parameter p_edma_pfc_multi_quantum   = 1'b1;
`else
  parameter p_edma_pfc_multi_quantum   = 1'b0;
`endif

`ifdef edma_rx_pkt_buffer
  parameter p_edma_rx_pkt_buffer   = 1'b1;
`else
  parameter p_edma_rx_pkt_buffer   = 1'b0;
`endif

`ifdef edma_tx_pkt_buffer
  parameter p_edma_tx_pkt_buffer   = 1'b1;
`else
  parameter p_edma_tx_pkt_buffer   = 1'b0;
`endif

`ifdef gem_user_io
  parameter p_gem_user_io = 1'b1;
  parameter p_gem_user_in_width = `gem_user_in_width;
  parameter p_gem_user_out_width = `gem_user_out_width;
`else
  parameter p_gem_user_io = 1'b0;
  parameter p_gem_user_in_width = 32'd1;
  parameter p_gem_user_out_width = 32'd1;
`endif

`ifdef gem_irq_read_clear
  parameter p_edma_irq_read_clear = 1'b1;
`else
  parameter p_edma_irq_read_clear = 1'b0;
`endif

`ifdef gem_no_snapshot
  parameter p_edma_no_snapshot = 1'b1;
`else
  parameter p_edma_no_snapshot = 1'b0;
`endif

`ifdef gem_no_stats
  parameter p_edma_no_stats = 1'b1;
`else
  parameter p_edma_no_stats = 1'b0;
`endif

`ifdef gem_no_pcs
  parameter p_edma_no_pcs = 1'b1;
`else
  parameter p_edma_no_pcs = 1'b0;
`endif

`ifdef gem_int_loopback
  parameter p_edma_int_loopback = 1'b1;
`else
  parameter p_edma_int_loopback = 1'b0;
`endif

`ifdef edma_tx_add_fifo_if
  parameter p_edma_tx_add_fifo_if = 1'b1;
`else
  parameter p_edma_tx_add_fifo_if = 1'b0;
`endif

`ifdef edma_asf_dap_prot
  parameter p_edma_asf_dap_prot  = 1'd1;
  parameter p_emac_parity_width  = p_emac_bus_width    == 32'd128 ? 8'd16
                                                                  : p_emac_bus_width == 32'd64  ? 8'd8  : 8'd4;
  parameter p_edma_parity_width  = p_edma_bus_width    == 32'd128 ? 8'd16
                                                                  : p_edma_bus_width == 32'd64  ? 8'd8  : 8'd4;
  parameter p_edma_rx_pbuf_prty  = p_edma_rx_pbuf_data == 32'd128 ? 8'd16
                                                                  : p_edma_rx_pbuf_data == 32'd64  ? 8'd8  : 8'd4;
  parameter p_edma_tx_pbuf_prty  = p_edma_tx_pbuf_data == 32'd128 ? 8'd16
                                                                  : p_edma_tx_pbuf_data == 32'd64  ? 8'd8  : 8'd4;
`else
  parameter p_edma_asf_dap_prot  = 1'd0;
  parameter p_emac_parity_width  = 8'd0;
  parameter p_edma_parity_width  = 8'd0;
  parameter p_edma_rx_pbuf_prty  = 8'd0;
  parameter p_edma_tx_pbuf_prty  = 8'd0;
`endif

  parameter p_edma_rx_pbuf_addr_par = (p_edma_rx_pbuf_addr+7)/8;
  parameter p_edma_tx_pbuf_addr_par = (p_edma_tx_pbuf_addr+7)/8;
  parameter p_edma_emac_rx_pbuf_addr_par = (p_edma_emac_rx_pbuf_addr+7)/8;
  parameter p_edma_emac_tx_pbuf_addr_par = (p_edma_emac_tx_pbuf_addr+7)/8;

`ifdef edma_asf_ecc_sram
  parameter p_edma_asf_ecc_sram = 1'd1;
  parameter p_edma_rx_pbuf_temp     = p_edma_rx_pbuf_data == 32'd128  ? 8'd16
                                                                      : p_edma_rx_pbuf_data == 32'd64 ? 8'd8  : 8'd7;
  parameter p_edma_tx_pbuf_temp     = p_edma_tx_pbuf_data == 32'd128  ? 8'd16
                                                                      : p_edma_tx_pbuf_data == 32'd64 ? 8'd8  : 8'd7;
`else
  parameter p_edma_asf_ecc_sram = 1'd0;
  parameter p_edma_rx_pbuf_temp     = p_edma_rx_pbuf_data == 32'd128  ? 8'd16
                                                                      : p_edma_rx_pbuf_data == 32'd64 ? 8'd8  : 8'd4;
  parameter p_edma_tx_pbuf_temp     = p_edma_tx_pbuf_data == 32'd128  ? 8'd16
                                                                      : p_edma_tx_pbuf_data == 32'd64 ? 8'd8  : 8'd4;
`endif

  parameter p_edma_tx_pbuf_reduncy  = ((p_edma_asf_dap_prot > 0) || (p_edma_asf_ecc_sram > 0)) ? p_edma_tx_pbuf_addr_par[7:0] + p_edma_tx_pbuf_temp[7:0]
                                                                                              : 8'd0;
  parameter p_edma_rx_pbuf_reduncy  = ((p_edma_asf_dap_prot > 0) || (p_edma_asf_ecc_sram > 0)) ? p_edma_rx_pbuf_addr_par[7:0] + p_edma_rx_pbuf_temp[7:0]
                                                                                              : 8'd0;
  parameter p_edma_emac_tx_pbuf_reduncy  = ((p_edma_asf_dap_prot > 0) || (p_edma_asf_ecc_sram > 0)) ? p_edma_emac_tx_pbuf_addr_par[7:0] + p_edma_tx_pbuf_temp[7:0]
                                                                                              : 8'd0;
  parameter p_edma_emac_rx_pbuf_reduncy  = ((p_edma_asf_dap_prot > 0) || (p_edma_asf_ecc_sram > 0)) ? p_edma_emac_rx_pbuf_addr_par[7:0] + p_edma_rx_pbuf_temp[7:0]
                                                                                              : 8'd0;


`ifdef edma_asf_csr_prot
  parameter p_edma_asf_csr_prot = 1'd1;
`else
  parameter p_edma_asf_csr_prot = 1'd0;
`endif

`ifdef gem_asf_trans_to_prot
  parameter p_edma_asf_trans_to_prot  = 1'd1;
`else
  parameter p_edma_asf_trans_to_prot  = 1'd0;
`endif

  parameter p_edma_asf_integrity_prot = 1'd0;

  parameter p_edma_asf_prot_tx_sched  = 1'd0;

  parameter p_edma_asf_host_par = 1'd0;

`ifdef gem_no_of_cb_streams
  parameter p_gem_num_cb_streams  = (`gem_no_of_cb_streams > 8'd0) ? `gem_no_of_cb_streams : 8'd1;
  parameter p_gem_has_cb          = (`gem_no_of_cb_streams > 8'd0) ? 1'b1  : 1'b0;
`else
  parameter p_gem_num_cb_streams  = 8'd1;
  parameter p_gem_has_cb          = 1'b0;
`endif

`ifdef edma_has_802p3_br
  parameter p_edma_has_br          = 1'b1;
`else
  parameter p_edma_has_br          = 1'b0;
`endif

`ifdef gem_seq_history_len
  parameter p_gem_cb_history_len  = `gem_seq_history_len;
`else
  parameter p_gem_cb_history_len  = 8'd1;
`endif

`ifdef gem_use_rgmii
  parameter p_edma_using_rgmii = 1'b1;
`else
  parameter p_edma_using_rgmii = 1'b0;
`endif

`ifdef gem_include_rmii
  parameter p_edma_include_rmii = 1'b1;
`else
  parameter p_edma_include_rmii = 1'b0;
`endif

parameter grouped_params = {
p_edma_rx_pbuf_reduncy,
p_edma_tx_pbuf_reduncy,
p_edma_tx_pbuf_prty,
p_edma_rx_pbuf_prty,
p_edma_parity_width,
p_emac_parity_width,
p_edma_asf_trans_to_prot,
p_edma_asf_integrity_prot,
p_edma_asf_prot_tx_sched,
p_edma_asf_host_par,
p_edma_asf_ecc_sram,
p_edma_asf_csr_prot,
p_edma_asf_dap_prot,
p_edma_asf_prot_tsu,
p_edma_has_br,
p_edma_emac_tx_pbuf_addr,
p_edma_emac_rx_pbuf_addr,
p_edma_pcs_code_align,
p_edma_using_rgmii,
p_edma_include_rmii,
p_gem_rx_pipeline_delay,
p_edma_srd_width,
p_edma_has_pcs,
p_edma_pcs_legacy_if,
p_gem_num_cb_streams,
p_gem_cb_history_len,
p_gem_has_cb,
p_edma_exclude_qbv,
p_edma_queues,
p_edma_tx_pbuf_data,
p_edma_rx_pbuf_data,
p_edma_tx_pbuf_addr,
p_edma_rx_pbuf_addr,
p_edma_tx_pbuf_queue_segment_size,
p_emac_bus_width,
p_edma_bus_width,
p_edma_addr_width,
p_edma_rx_fifo_size,
p_edma_tx_fifo_size,
p_edma_rx_fifo_cnt_width,
p_edma_tx_fifo_cnt_width,
p_xgm,
p_edma_phy_ident,
p_num_spec_add_filters,
p_edma_tx_pbuf_num_segments_q0,
p_edma_tx_pbuf_num_segments_q1,
p_edma_tx_pbuf_num_segments_q2,
p_edma_tx_pbuf_num_segments_q3,
p_edma_tx_pbuf_num_segments_q4,
p_edma_tx_pbuf_num_segments_q5,
p_edma_tx_pbuf_num_segments_q6,
p_edma_tx_pbuf_num_segments_q7,
p_edma_tx_pbuf_num_segments_q8,
p_edma_tx_pbuf_num_segments_q9,
p_edma_tx_pbuf_num_segments_q10,
p_edma_tx_pbuf_num_segments_q11,
p_edma_tx_pbuf_num_segments_q12,
p_edma_tx_pbuf_num_segments_q13,
p_edma_tx_pbuf_num_segments_q14,
p_edma_tx_pbuf_num_segments_q15,
p_edma_exclude_cbs,
p_edma_pbuf_cutthru,
p_edma_tsu,
p_edma_tsu_clk,
p_edma_ext_tsu_timer,
p_edma_axi,
p_edma_lso,
p_edma_rsc,
p_edma_spram,
p_edma_ext_fifo_interface,
p_edma_add_rx_external_fifo_if,
p_edma_add_tx_external_fifo_if,
p_edma_host_if_soft_select,
p_edma_pfc_multi_quantum,
p_edma_rx_pkt_buffer,
p_edma_tx_pkt_buffer,
p_gem_user_io,
p_gem_user_in_width,
p_gem_user_out_width,
p_edma_irq_read_clear,
p_edma_no_snapshot,
p_edma_no_stats,
p_edma_no_pcs,
p_edma_int_loopback,
p_edma_tx_add_fifo_if,
p_edma_rx_base2_fifo_size,
p_edma_tx_base2_fifo_size,
p_edma_axi_access_pipeline_bits,
p_edma_axi_tx_descr_rd_buff_bits,
p_edma_axi_rx_descr_rd_buff_bits,
p_edma_axi_tx_descr_wr_buff_bits,
p_edma_axi_rx_descr_wr_buff_bits,
p_edma_hprot_value,
p_edma_axi_prot_value,
p_edma_axi_arcache_value,
p_edma_axi_awcache_value,
p_edma_dma_bus_width_def,
p_edma_mdc_clock_div,
p_edma_endian_swap_def,
p_edma_rx_pbuf_size_def,
p_edma_tx_pbuf_size_def,
p_edma_rx_buffer_length_def,
p_edma_jumbo_max_length,
p_num_type1_screeners,
p_num_type2_screeners,
p_num_scr2_compare_regs,
p_num_scr2_ethtype_regs
};


// Parity widths for ASF
parameter p_emac_bus_pwid     = p_emac_bus_width/8;
parameter p_edma_bus_pwid     = p_edma_bus_width/8;
parameter p_edma_addr_pwid    = p_edma_addr_width/8;
parameter p_edma_rx_pbuf_pwid = p_edma_rx_pbuf_data/8;
parameter p_edma_tx_pbuf_pwid = p_edma_tx_pbuf_data/8;

//------------------------------------------------------------------------------
// Copyright (c) 2017 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           gem_reg_designcfg_dbg.v
//   Module Name:        gem_reg_designcfg_dbg
//
//   Release Revision:   r1p12
//   Release SVN Tag:    gem_gxl_det0102_r1p12
//
//   IP Name:            GEM Gigabit Ethernet MAC
//   IP Part Number:     IP7014
//
//   Product Type:       Off-the-shelf
//   IP Type:            Soft
//   IP Family:          Ethernet Controller
//   Technology:         N/A
//   Protocol:           Ethernet
//   Architecture:       N/A
//   Licensable IP:      SIP-Ethernet-MAC+DMA+1588+TSN+PCS-10M/100M/1G-IP7014
//
//------------------------------------------------------------------------------
//   Description    : Contains GEM design configuration data. Static
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_designcfg_dbg (
  output  [31:0]  gem_designcfg_debug1,   // Configuration data
  output  [31:0]  gem_designcfg_debug2,
  output  [31:0]  gem_designcfg_debug3,
  output  [31:0]  gem_designcfg_debug4,
  output  [31:0]  gem_designcfg_debug5,
  output  [31:0]  gem_designcfg_debug6,
  output  [31:0]  gem_designcfg_debug7,
  output  [31:0]  gem_designcfg_debug8,
  output  [31:0]  gem_designcfg_debug9,
  output  [31:0]  gem_designcfg_debug10,
  output  [31:0]  gem_designcfg_debug11,
  output  [31:0]  gem_designcfg_debug12
);

  // Parameters passed down from top level
   parameter [1363:0] grouped_params = {1364{1'b0}};
  `include "ungroup_params.v"

  // Internal wires to interface to configuration parameters
  wire  [31:0]  gem_user_out_wid;
  wire  [31:0]  gem_user_in_wid;
  wire  [5:0]   num_spec_add_filters_w;
  wire  [31:0]  gem_dma_bus_width;
  wire  [31:0]  gem_tx_pbuf_data;
  wire  [31:0]  gem_rx_pbuf_data;
  wire  [31:0]  gem_emac_bus_width;
  wire  [31:0]  gem_rx_pbuf_add;
  wire  [31:0]  gem_tx_pbuf_add;
  wire  [31:0]  gem_emac_tx_pbuf_add;
  wire  [31:0]  gem_emac_rx_pbuf_add;
  wire  [31:0]  gem_rx_fifo_size;
  wire  [4:0]   gem_rx_base2_fifo_size;
  wire  [31:0]  gem_tx_fifo_size;
  wire  [3:0]   gem_tx_base2_fifo_size;
  wire  [31:0]  gem_rx_fifo_cnt_width;
  wire  [31:0]  gem_tx_fifo_cnt_width;
  wire          dma_priority_queue1;
  wire          dma_priority_queue2;
  wire          dma_priority_queue3;
  wire          dma_priority_queue4;
  wire          dma_priority_queue5;
  wire          dma_priority_queue6;
  wire          dma_priority_queue7;
  wire          dma_priority_queue8;
  wire          dma_priority_queue9;
  wire          dma_priority_queue10;
  wire          dma_priority_queue11;
  wire          dma_priority_queue12;
  wire          dma_priority_queue13;
  wire          dma_priority_queue14;
  wire          dma_priority_queue15;
  wire  [31:0]  gem_tx_pbuf_queue_segment_size;
  wire          gem_dma_addr_width_is_64b;

  // Assign wires to configuration parameters
  assign gem_user_out_wid             = p_gem_user_out_width;
  assign gem_user_in_wid              = p_gem_user_in_width;
  assign num_spec_add_filters_w       = p_num_spec_add_filters[5:0];
  assign gem_dma_bus_width            = p_edma_bus_width;
  assign gem_tx_pbuf_data             = p_edma_tx_pbuf_data;
  assign gem_rx_pbuf_data             = p_edma_rx_pbuf_data;
  assign gem_emac_bus_width           = p_emac_bus_width;
  assign gem_rx_pbuf_add              = p_edma_rx_pbuf_addr;
  assign gem_tx_pbuf_add              = p_edma_tx_pbuf_addr;
  assign gem_emac_rx_pbuf_add         = p_edma_emac_rx_pbuf_addr;
  assign gem_emac_tx_pbuf_add         = p_edma_emac_tx_pbuf_addr;
  assign gem_rx_fifo_size             = p_edma_rx_pkt_buffer == 0 ? p_edma_rx_fifo_size       : 32'd0;
  assign gem_rx_base2_fifo_size       = p_edma_rx_pkt_buffer == 0 ? p_edma_rx_base2_fifo_size : 5'd0;
  assign gem_tx_fifo_size             = p_edma_rx_pkt_buffer == 0 ? p_edma_tx_fifo_size       : 32'd0;
  assign gem_tx_base2_fifo_size       = p_edma_rx_pkt_buffer == 0 ? p_edma_tx_base2_fifo_size : 4'h0;
  assign gem_rx_fifo_cnt_width        = p_edma_rx_fifo_cnt_width;
  assign gem_tx_fifo_cnt_width        = p_edma_tx_fifo_cnt_width;
  assign dma_priority_queue1          = p_edma_queues > 32'd1;
  assign dma_priority_queue2          = p_edma_queues > 32'd2;
  assign dma_priority_queue3          = p_edma_queues > 32'd3;
  assign dma_priority_queue4          = p_edma_queues > 32'd4;
  assign dma_priority_queue5          = p_edma_queues > 32'd5;
  assign dma_priority_queue6          = p_edma_queues > 32'd6;
  assign dma_priority_queue7          = p_edma_queues > 32'd7;
  assign dma_priority_queue8          = p_edma_queues > 32'd8;
  assign dma_priority_queue9          = p_edma_queues > 32'd9;
  assign dma_priority_queue10         = p_edma_queues > 32'd10;
  assign dma_priority_queue11         = p_edma_queues > 32'd11;
  assign dma_priority_queue12         = p_edma_queues > 32'd12;
  assign dma_priority_queue13         = p_edma_queues > 32'd13;
  assign dma_priority_queue14         = p_edma_queues > 32'd14;
  assign dma_priority_queue15         = p_edma_queues > 32'd15;
  assign gem_dma_addr_width_is_64b    = (p_edma_addr_width == 32'd64);
  assign gem_tx_pbuf_queue_segment_size = p_edma_tx_pbuf_queue_segment_size;

  // Assign configuration bus for software read
  assign gem_designcfg_debug1 = {p_edma_axi_awcache_value,// 31:28
                                  gem_dma_bus_width[7:5], // 27:25
                                  p_edma_exclude_cbs,     // 24
                                  p_edma_irq_read_clear,  // 23
                                  p_edma_no_snapshot,     // 22
                                  p_edma_no_stats,        // 21
                                  1'b1,                   // 20
                                  gem_user_in_wid[4:0],   // 19:15
                                  gem_user_out_wid[4:0],  // 14:10
                                  p_gem_user_io,          // 9
                                  1'b1,                   // 8
                                  1'b0,                   // 7
                                  p_edma_ext_fifo_interface, // 6
                                  1'b0,                   // 5
                                  p_edma_int_loopback,    // 4
                                  1'b0,                   // 3
                                  1'b0,                   // 2
                                  p_edma_exclude_qbv,     // 1
                                  p_edma_no_pcs};         // 0

  assign gem_designcfg_debug2 = {p_edma_spram,            // 31
                                  p_edma_axi,             // 30
                                  gem_tx_pbuf_add[3:0],   // 29:26
                                  gem_rx_pbuf_add[3:0],   // 25:22
                                  p_edma_tx_pkt_buffer,   // 21
                                  p_edma_rx_pkt_buffer,   // 20
                                  p_edma_hprot_value,     // 19:16
                                  2'b00,                  // 15:14
                                  p_edma_jumbo_max_length}; // 13:0

  assign gem_designcfg_debug3 = {2'b00,                   // 31:30
                                  num_spec_add_filters_w, // 29:24
                                  3'b000,                 // 23:21
                                  gem_rx_base2_fifo_size, // 20:16
                                  gem_rx_fifo_size[15:0]};// 15:0

  assign gem_designcfg_debug4 = {12'd0,                   // 31:20
                                  gem_tx_base2_fifo_size, // 19:16
                                  gem_tx_fifo_size[15:0]};// 15:0


  assign gem_designcfg_debug5 = {p_edma_axi_prot_value,   // 31:29
                                  p_edma_tsu_clk,         // 28
                                  p_edma_rx_buffer_length_def, // 27:20
                                  p_edma_tx_pbuf_size_def,// 19
                                  p_edma_rx_pbuf_size_def,// 18:17
                                  p_edma_endian_swap_def, // 16:15
                                  p_edma_mdc_clock_div,   // 14:12
                                  p_edma_dma_bus_width_def,  // 11:10
                                  p_edma_phy_ident,       // 9
                                  p_edma_tsu,             // 8
                                  gem_tx_fifo_cnt_width[3:0], // 7:4
                                  gem_rx_fifo_cnt_width[3:0]};// 3:0

  assign gem_designcfg_debug6 = {4'd0,                    // 31:28
                                  p_edma_lso,             // 27
                                  p_edma_rsc,             // 26
                                  p_edma_pbuf_cutthru,    // 25
                                  p_edma_pfc_multi_quantum,  // 24
                                  gem_dma_addr_width_is_64b, // 23
                                  p_edma_host_if_soft_select,// 22
                                  p_edma_tx_add_fifo_if,  // 21
                                  p_edma_ext_tsu_timer,   // 20
                                  gem_tx_pbuf_queue_segment_size[3:0],  // 19:16
                                  dma_priority_queue15,   // 15
                                  dma_priority_queue14,   // 14
                                  dma_priority_queue13,   // 13
                                  dma_priority_queue12,   // 12
                                  dma_priority_queue11,   // 11
                                  dma_priority_queue10,   // 10
                                  dma_priority_queue9,    // 9
                                  dma_priority_queue8,    // 8
                                  dma_priority_queue7,    // 7
                                  dma_priority_queue6,    // 6
                                  dma_priority_queue5,    // 5
                                  dma_priority_queue4,    // 4
                                  dma_priority_queue3,    // 3
                                  dma_priority_queue2,    // 2
                                  dma_priority_queue1,    // 1
                                  1'b0};                  // 0

  assign gem_designcfg_debug7 = {1'b0,p_edma_tx_pbuf_num_segments_q7[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q6[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q5[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q4[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q3[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q2[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q1[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q0[2:0]};

  assign gem_designcfg_debug8[31:24]  = p_num_type1_screeners;
  assign gem_designcfg_debug8[23:16]  = p_num_type2_screeners;
  assign gem_designcfg_debug8[15:8]   = p_num_scr2_ethtype_regs;
  assign gem_designcfg_debug8[7:0]    = p_num_scr2_compare_regs;

  assign gem_designcfg_debug9 = {1'b0,
                                  p_edma_tx_pbuf_num_segments_q15[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q14[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q13[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q12[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q11[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q10[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q9[2:0],
                                  1'b0,p_edma_tx_pbuf_num_segments_q8[2:0]};

  assign gem_designcfg_debug10[31:28] = gem_emac_bus_width[8:5];
  assign gem_designcfg_debug10[27:24] = gem_tx_pbuf_data[8:5];
  assign gem_designcfg_debug10[23:20] = gem_rx_pbuf_data[8:5];
  assign gem_designcfg_debug10[19:16] = p_edma_axi_access_pipeline_bits;
  assign gem_designcfg_debug10[15:12] = p_edma_axi_tx_descr_rd_buff_bits;
  assign gem_designcfg_debug10[11:8]  = p_edma_axi_rx_descr_rd_buff_bits;
  assign gem_designcfg_debug10[7:4]   = p_edma_axi_tx_descr_wr_buff_bits;
  assign gem_designcfg_debug10[3:0]   = p_edma_axi_rx_descr_wr_buff_bits;

  assign gem_designcfg_debug11 = {24'd0,
                                  p_edma_asf_prot_tx_sched,
                                  p_edma_asf_host_par,
                                  p_edma_asf_trans_to_prot,
                                  p_edma_asf_integrity_prot,
                                  p_edma_asf_prot_tsu,
                                  p_edma_asf_csr_prot,
                                  p_edma_asf_dap_prot,
                                  p_edma_asf_ecc_sram};

  assign gem_designcfg_debug12 = {6'd0,
                                  p_edma_has_br,
                                  gem_emac_tx_pbuf_add[3:0],  //  24:21
                                  gem_emac_rx_pbuf_add[3:0],  //  20:17
                                  p_gem_has_cb,
                                  p_gem_cb_history_len,
                                  p_gem_num_cb_streams};

endmodule

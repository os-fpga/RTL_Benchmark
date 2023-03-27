

// -------------------------------
// DO NOT EDIT THE FOLLOWING ...
//--------------------------------


// -------------------------- GEM -----------------------------

`ifndef xgm

  // Automatically set ASF internally

  `ifdef gem_ext_fifo_interface
    `define gem_add_rx_external_fifo_if
    `define gem_add_tx_external_fifo_if
    `define edma_ext_fifo_interface
  `else
    `ifdef gem_host_if_soft_select
      `define gem_add_rx_external_fifo_if
      `define gem_add_tx_external_fifo_if
      `define edma_host_if_soft_select
    `else
      `ifdef gem_tx_add_fifo_if
        `define gem_add_tx_external_fifo_if
        `define edma_tx_add_fifo_if
      `endif
    `endif
  `endif

  `ifdef gem_add_tx_external_fifo_if
    `ifdef gem_add_rx_external_fifo_if
      `ifdef gem_fifo_8b_if
        `define use_gem_fifo_8b_if
      `endif
    `endif
  `endif

  `define edma_bus_width `gem_dma_bus_width
  `define edma_addr_width `gem_dma_addr_width
  `define emac_bus_width `gem_emac_bus_width
  `define edma_rx_fifo_size `gem_rx_fifo_size
  `define edma_rx_base2_fifo_size `gem_rx_base2_fifo_size
  `define edma_rx_fifo_cnt_width  `gem_rx_fifo_cnt_width
  `define edma_tx_fifo_size `gem_tx_fifo_size
  `define edma_tx_base2_fifo_size `gem_tx_base2_fifo_size
  `define edma_tx_fifo_cnt_width `gem_tx_fifo_cnt_width
  `define edma_hprot_value `gem_hprot_value

  `ifndef gem_ext_fifo_interface
    `ifdef gem_rx_pkt_buffer
      `define edma_rx_pkt_buffer
    `endif
    `ifdef gem_pbuf_rsc
      `define edma_pbuf_rsc
    `endif
    `ifdef gem_pbuf_lso
      `define edma_pbuf_lso
    `endif
    `ifdef gem_tx_pkt_buffer
      `define edma_tx_pkt_buffer
    `endif
    `ifdef gem_spram
      `define edma_spram
    `endif
    `ifdef gem_axi
      `define edma_axi
    `endif
  `endif

  `ifdef edma_tx_pkt_buffer
    `define edma_axi_access_pipeline_bits `gem_axi_access_pipeline_bits
    `define edma_axi_tx_descr_rd_buff_bits `gem_axi_tx_descr_rd_buff_bits
    `define edma_axi_rx_descr_rd_buff_bits `gem_axi_rx_descr_rd_buff_bits
    `define edma_axi_tx_descr_wr_buff_bits `gem_axi_tx_descr_wr_buff_bits
    `define edma_axi_rx_descr_wr_buff_bits `gem_axi_rx_descr_wr_buff_bits
    `define edma_axi_awcache_value `gem_axi_awcache_value
    `define edma_axi_arcache_value `gem_axi_arcache_value
    `define edma_axi_prot_value `gem_axi_prot_value
    `define edma_rx_pbuf_size_def `gem_rx_pbuf_size_def
    `define edma_tx_pbuf_size_def `gem_tx_pbuf_size_def
  `else
    `define edma_axi_access_pipeline_bits 4'h0
    `define edma_axi_tx_descr_rd_buff_bits 4'h0
    `define edma_axi_rx_descr_rd_buff_bits 4'h0
    `define edma_axi_tx_descr_wr_buff_bits 4'h0
    `define edma_axi_rx_descr_wr_buff_bits 4'h0
    `define edma_axi_awcache_value 4'h0
    `define edma_axi_arcache_value 4'h0
    `define edma_axi_prot_value 3'h0
    `define edma_rx_pbuf_size_def 2'b00
    `define edma_tx_pbuf_size_def 1'b0
  `endif

  `ifdef gem_phy_id_top
    `define edma_phy_ident
  `endif
  `define edma_rx_buffer_length_def `gem_rx_buffer_length_def
  `define edma_dma_bus_width_def     `gem_dma_bus_width_def
  `define edma_mdc_clock_div         `gem_mdc_clock_div
  `define edma_endian_swap_def       `gem_endian_swap_def
  `define edma_rx_buffer_length_def  `gem_rx_buffer_length_def
  `define edma_jumbo_max_length      `gem_jumbo_max_length
  `define edma_rx_pbuf_addr `gem_rx_pbuf_addr
  `define edma_tx_pbuf_addr `gem_tx_pbuf_addr
  `define edma_emac_rx_pbuf_addr `gem_emac_rx_pbuf_addr
  `define edma_emac_tx_pbuf_addr `gem_emac_tx_pbuf_addr
  `define edma_rx_pbuf_data `gem_rx_pbuf_data
  `define edma_tx_pbuf_data `gem_tx_pbuf_data

    `define emac_parity_width 32'd0
    `define edma_parity_width 32'd0
    `define edma_rx_pbuf_prty 32'd0
    `define edma_tx_pbuf_prty 32'd0

      `define edma_rx_pbuf_reduncy 0
      `define edma_tx_pbuf_reduncy 0
      `define edma_emac_rx_pbuf_reduncy 0
      `define edma_emac_tx_pbuf_reduncy 0


  `ifdef gem_asf_trans_to_prot
    `ifndef edma_any_asf
      `define edma_any_asf
    `endif
    `define edma_asf_trans_to_prot
  `endif




  `ifdef dma_priority_queue1
    `define edma_priority_queue1
    `ifdef gem_tx_pbuf_num_segments_q0
      `define edma_tx_pbuf_num_segments_q0 `gem_tx_pbuf_num_segments_q0
    `endif
    `ifdef gem_tx_pbuf_num_segments_q1
      `define edma_tx_pbuf_num_segments_q1 `gem_tx_pbuf_num_segments_q1
    `endif
  `endif
  `ifdef dma_priority_queue2
    `define edma_priority_queue2
    `ifdef gem_tx_pbuf_num_segments_q2
      `define edma_tx_pbuf_num_segments_q2 `gem_tx_pbuf_num_segments_q2
    `endif
  `endif
  `ifdef dma_priority_queue3
    `define edma_priority_queue3
    `ifdef gem_tx_pbuf_num_segments_q3
      `define edma_tx_pbuf_num_segments_q3 `gem_tx_pbuf_num_segments_q3
    `endif
  `endif
  `ifdef dma_priority_queue4
    `define edma_priority_queue4
    `ifdef gem_tx_pbuf_num_segments_q4
      `define edma_tx_pbuf_num_segments_q4 `gem_tx_pbuf_num_segments_q4
    `endif
  `endif
  `ifdef dma_priority_queue5
    `define edma_priority_queue5
    `ifdef gem_tx_pbuf_num_segments_q5
      `define edma_tx_pbuf_num_segments_q5 `gem_tx_pbuf_num_segments_q5
    `endif
  `endif
  `ifdef dma_priority_queue6
    `define edma_priority_queue6
    `ifdef gem_tx_pbuf_num_segments_q6
      `define edma_tx_pbuf_num_segments_q6 `gem_tx_pbuf_num_segments_q6
    `endif
  `endif
  `ifdef dma_priority_queue7
    `define edma_priority_queue7
    `ifdef gem_tx_pbuf_num_segments_q7
      `define edma_tx_pbuf_num_segments_q7 `gem_tx_pbuf_num_segments_q7
    `endif
  `endif
  `ifdef dma_priority_queue8
    `define edma_priority_queue8
    `ifdef gem_tx_pbuf_num_segments_q8
      `define edma_tx_pbuf_num_segments_q8 `gem_tx_pbuf_num_segments_q8
    `endif
  `endif
  `ifdef dma_priority_queue9
    `define edma_priority_queue9
    `ifdef gem_tx_pbuf_num_segments_q9
      `define edma_tx_pbuf_num_segments_q9 `gem_tx_pbuf_num_segments_q9
    `endif
  `endif
  `ifdef dma_priority_queue10
    `define edma_priority_queue10
    `ifdef gem_tx_pbuf_num_segments_q10
      `define edma_tx_pbuf_num_segments_q10 `gem_tx_pbuf_num_segments_q10
    `endif
  `endif
  `ifdef dma_priority_queue11
    `define edma_priority_queue11
    `ifdef gem_tx_pbuf_num_segments_q11
      `define edma_tx_pbuf_num_segments_q11 `gem_tx_pbuf_num_segments_q11
    `endif
  `endif
  `ifdef dma_priority_queue12
    `define edma_priority_queue12
    `ifdef gem_tx_pbuf_num_segments_q12
      `define edma_tx_pbuf_num_segments_q12 `gem_tx_pbuf_num_segments_q12
    `endif
  `endif
  `ifdef dma_priority_queue13
    `define edma_priority_queue13
    `ifdef gem_tx_pbuf_num_segments_q13
      `define edma_tx_pbuf_num_segments_q13 `gem_tx_pbuf_num_segments_q13
    `endif
  `endif
  `ifdef dma_priority_queue14
    `define edma_priority_queue14
    `ifdef gem_tx_pbuf_num_segments_q14
      `define edma_tx_pbuf_num_segments_q14 `gem_tx_pbuf_num_segments_q14
    `endif
  `endif
  `ifdef dma_priority_queue15
    `define edma_priority_queue15
    `ifdef gem_tx_pbuf_num_segments_q15
      `define edma_tx_pbuf_num_segments_q15 `gem_tx_pbuf_num_segments_q15
    `endif
  `endif
  `ifdef gem_tx_pbuf_queue_segment_size
    `define edma_tx_pbuf_queue_segment_size `gem_tx_pbuf_queue_segment_size
  `else
    `define edma_tx_pbuf_queue_segment_size 1
  `endif
  `ifdef gem_pbuf_cutthru
    `define edma_pbuf_cutthru
  `endif
  `ifdef gem_tsu
    `define edma_tsu
  `endif
  `ifdef gem_tsu_clk
    `define edma_tsu_clk
  `endif
  `ifdef gem_ext_tsu_timer
    `define edma_ext_tsu_timer
  `endif
  `ifdef gem_exclude_cbs
    `define edma_exclude_cbs
  `endif
    `ifdef gem_exclude_qbv
    `define edma_exclude_qbv
  `endif
  `ifdef gem_pfc_multi_quantum
    `define edma_pfc_multi_quantum
  `endif

  `ifdef gem_has_802p3_br
    `define edma_has_802p3_br
  `endif
// -------------------------- XGM -----------------------------

`else

  // XGM Specific that can't be changed when in DMA mode
  `ifndef xgm_ext_fifo_interface
    `define FIFO_INERTIA    2
    `define MFIFO_PNTR_WIDTH  3
    `define xgm_axi
    `define edma_axi
    `define xgm_rx_pkt_buffer
    `define xgm_tx_pkt_buffer
    `define xgm_tx_pbuf_data 128
    `define xgm_rx_pbuf_data 128
    `define xgm_hprot_value 0
    `define edma_rx_pkt_buffer
    `define edma_tx_pkt_buffer
    `ifdef xgm_spram
      `define edma_spram
    `endif
  `else
    `define edma_ext_fifo_interface
  `endif

  // XGM Configurable
  `define edma_bus_width `xgm_dma_bus_width
  `define edma_addr_width `xgm_dma_addr_width
  `define emac_bus_width 64
  `define edma_hprot_value `xgm_hprot_value
  `define edma_axi_access_pipeline_bits  `xgm_axi_access_pipeline_bits
  `define edma_axi_tx_descr_rd_buff_bits `xgm_axi_tx_descr_rd_buff_bits
  `define edma_axi_rx_descr_rd_buff_bits `xgm_axi_rx_descr_rd_buff_bits
  `define edma_axi_tx_descr_wr_buff_bits `xgm_axi_tx_descr_wr_buff_bits
  `define edma_axi_rx_descr_wr_buff_bits `xgm_axi_rx_descr_wr_buff_bits
  `define edma_axi_awcache_value `xgm_axi_awcache_value
  `define edma_axi_arcache_value `xgm_axi_arcache_value
  `define edma_axi_prot_value `xgm_axi_prot_value
  `define edma_endian_swap_def `xgm_endian_swap_def
  `define edma_rx_pbuf_size_def `xgm_rx_pbuf_size_def
  `define edma_tx_pbuf_size_def `xgm_tx_pbuf_size_def
  `define edma_rx_buffer_length_def `xgm_rx_buffer_length_def
  `define edma_jumbo_max_length `xgm_jumbo_max_length
  `define edma_rx_pbuf_addr `xgm_rx_pbuf_addr
  `define edma_rx_pbuf_data `xgm_rx_pbuf_data
  `define edma_tx_pbuf_addr `xgm_tx_pbuf_addr
  `define edma_tx_pbuf_data `xgm_tx_pbuf_data
  `ifdef xgm_phy_ident
    `define edma_phy_ident
  `endif
  `define edma_dma_bus_width_def     `xgm_dma_bus_width_def
  `define edma_mdc_clock_div         `xgm_mdc_clock_div
  `define edma_endian_swap_def       `xgm_endian_swap_def
  `define edma_rx_pbuf_size_def      `xgm_rx_pbuf_size_def
  `define edma_tx_pbuf_size_def      `xgm_tx_pbuf_size_def
  `define edma_rx_buffer_length_def  `xgm_rx_buffer_length_def
  `ifdef xgm_pbuf_rsc
    `define edma_pbuf_rsc
  `endif
  `ifdef dma_priority_queue1
    `define edma_priority_queue1
    `define edma_tx_pbuf_queue_segment_size `xgm_tx_pbuf_queue_segment_size
    `ifdef xgm_tx_pbuf_num_segments_q0
      `define edma_tx_pbuf_num_segments_q0 `xgm_tx_pbuf_num_segments_q0
    `endif
    `ifdef xgm_tx_pbuf_num_segments_q1
      `define edma_tx_pbuf_num_segments_q1 `xgm_tx_pbuf_num_segments_q1
    `endif
  `endif
  `ifdef dma_priority_queue2
    `define edma_priority_queue2
    `ifdef xgm_tx_pbuf_num_segments_q2
      `define edma_tx_pbuf_num_segments_q2 `xgm_tx_pbuf_num_segments_q2
    `endif
  `endif
  `ifdef dma_priority_queue3
    `define edma_priority_queue3
    `ifdef xgm_tx_pbuf_num_segments_q3
      `define edma_tx_pbuf_num_segments_q3 `xgm_tx_pbuf_num_segments_q3
    `endif
  `endif
  `ifdef dma_priority_queue4
    `define edma_priority_queue4
    `ifdef xgm_tx_pbuf_num_segments_q4
      `define edma_tx_pbuf_num_segments_q4 `xgm_tx_pbuf_num_segments_q4
    `endif
  `endif
  `ifdef dma_priority_queue5
    `define edma_priority_queue5
    `ifdef xgm_tx_pbuf_num_segments_q5
      `define edma_tx_pbuf_num_segments_q5 `xgm_tx_pbuf_num_segments_q5
    `endif
  `endif
  `ifdef dma_priority_queue6
    `define edma_priority_queue6
    `ifdef xgm_tx_pbuf_num_segments_q6
      `define edma_tx_pbuf_num_segments_q6 `xgm_tx_pbuf_num_segments_q6
    `endif
  `endif
  `ifdef dma_priority_queue7
    `define edma_priority_queue7
    `ifdef xgm_tx_pbuf_num_segments_q7
      `define edma_tx_pbuf_num_segments_q7 `xgm_tx_pbuf_num_segments_q7
    `endif
  `endif
  `ifdef dma_priority_queue8
    `define edma_priority_queue8
    `ifdef xgm_tx_pbuf_num_segments_q8
      `define edma_tx_pbuf_num_segments_q8 `xgm_tx_pbuf_num_segments_q8
    `endif
  `endif
  `ifdef dma_priority_queue9
    `define edma_priority_queue9
    `ifdef xgm_tx_pbuf_num_segments_q9
      `define edma_tx_pbuf_num_segments_q9 `xgm_tx_pbuf_num_segments_q9
    `endif
  `endif
  `ifdef dma_priority_queue10
    `define edma_priority_queue10
    `ifdef xgm_tx_pbuf_num_segments_q10
      `define edma_tx_pbuf_num_segments_q10 `xgm_tx_pbuf_num_segments_q10
    `endif
  `endif
  `ifdef dma_priority_queue11
    `define edma_priority_queue11
    `ifdef xgm_tx_pbuf_num_segments_q11
      `define edma_tx_pbuf_num_segments_q11 `xgm_tx_pbuf_num_segments_q11
    `endif
  `endif
  `ifdef dma_priority_queue12
    `define edma_priority_queue12
    `ifdef xgm_tx_pbuf_num_segments_q12
      `define edma_tx_pbuf_num_segments_q12 `xgm_tx_pbuf_num_segments_q12
    `endif
  `endif
  `ifdef dma_priority_queue13
    `define edma_priority_queue13
    `ifdef xgm_tx_pbuf_num_segments_q13
      `define edma_tx_pbuf_num_segments_q13 `xgm_tx_pbuf_num_segments_q13
    `endif
  `endif
  `ifdef dma_priority_queue14
    `define edma_priority_queue14
    `ifdef xgm_tx_pbuf_num_segments_q14
      `define edma_tx_pbuf_num_segments_q14 `xgm_tx_pbuf_num_segments_q14
    `endif
  `endif
  `ifdef dma_priority_queue15
    `define edma_priority_queue15
    `ifdef xgm_tx_pbuf_num_segments_q15
      `define edma_tx_pbuf_num_segments_q15 `xgm_tx_pbuf_num_segments_q15
    `endif
  `endif
  `ifdef xgm_tx_pbuf_queue_segment_size
    `define edma_tx_pbuf_queue_segment_size `xgm_tx_pbuf_queue_segment_size
  `else
    `define edma_tx_pbuf_queue_segment_size 0
  `endif
  `ifdef xgm_pbuf_cutthru
    `define edma_pbuf_cutthru
  `endif
  `ifdef xgm_tsu
    `define edma_tsu
  `endif
  `ifdef xgm_tsu_clk
    `define edma_tsu_clk
  `endif
  `ifdef xgm_ext_tsu_timer
    `define edma_ext_tsu_timer
  `endif
  `ifdef xgm_exclude_cbs
    `define edma_exclude_cbs
  `endif
  `ifdef xgm_pfc_multi_quantum
    `define edma_pfc_multi_quantum
  `endif

`endif



// -------------------------- Common -----------------------------

`ifdef dma_priority_queue15
  `define edma_queues 32'd16
`else
  `ifdef dma_priority_queue14
    `define edma_queues 32'd15
  `else
    `ifdef dma_priority_queue13
      `define edma_queues 32'd14
    `else
      `ifdef dma_priority_queue12
        `define edma_queues 32'd13
      `else
        `ifdef dma_priority_queue11
          `define edma_queues 32'd12
        `else
          `ifdef dma_priority_queue10
            `define edma_queues 32'd11
          `else
            `ifdef dma_priority_queue9
              `define edma_queues 32'd10
            `else
              `ifdef dma_priority_queue8
                `define edma_queues 32'd9
              `else
                `ifdef dma_priority_queue7
                  `define edma_queues 32'd8
                `else
                  `ifdef dma_priority_queue6
                    `define edma_queues 32'd7
                  `else
                    `ifdef dma_priority_queue5
                      `define edma_queues 32'd6
                    `else
                      `ifdef dma_priority_queue4
                        `define edma_queues 32'd5
                      `else
                        `ifdef dma_priority_queue3
                          `define edma_queues 32'd4
                        `else
                          `ifdef dma_priority_queue2
                            `define edma_queues 32'd3
                          `else
                            `ifdef dma_priority_queue1
                              `define edma_queues 32'd2
                            `else
                                `define edma_queues 32'd1
                            `endif
                          `endif
                        `endif
                      `endif
                    `endif
                  `endif
                `endif
              `endif
            `endif
          `endif
        `endif
      `endif
    `endif
  `endif
`endif

`ifdef num_type1_screeners
  `define edma_num_type1_screeners `num_type1_screeners
`endif
`ifdef num_type2_screeners
  `define edma_num_type2_screeners `num_type2_screeners
`endif
`ifdef num_scr2_compare_regs
  `define edma_num_scr2_compare_regs `num_scr2_compare_regs
`endif
`ifdef num_scr2_ethtype_regs
  `define edma_num_scr2_ethtype_regs `num_scr2_ethtype_regs
`endif


//------------------------------------------------------------------------------
// GEM Register address map
//------------------------------------------------------------------------------

    // Control and Configuration register addresses
   `define gem_network_control      12'h000   // Network Control Register
   `define gem_network_config       12'h004   // Network Configuration  Register
   `define gem_network_status       12'h008   // Network Status Register
   `define gem_user_io_register     12'h00c   // User Input/Output Register
   `define gem_dma_config           12'h010   // DMA configuration register
   `define gem_transmit_status      12'h014   // Transmit Status Register
   `define gem_receive_q_ptr        12'h018   // RX Buffer Queue Base Address
   `define gem_transmit_q_ptr       12'h01c   // TX Buffer Queue Base Address
   `define gem_receive_status       12'h020   // Receive Status Register
   `define gem_int_status           12'h024   // Interrupt Status Register
   `define gem_int_enable           12'h028   // Interrupt Enable Register
   `define gem_int_disable          12'h02c   // Interrupt Disable Register
   `define gem_int_mask             12'h030   // Interrupt Mask Register
   `define gem_phy_management       12'h034   // PHY maintenance Register
   `define gem_pause_time           12'h038   // Received Pause Quantum Register
   `define gem_tx_pause_quantum     12'h03c   // Transmit Pause Quantum Register
   `define gem_pbuf_txcutthru       12'h040   // Cut-thru enable and threshold
   `define gem_pbuf_rxcutthru       12'h044   // Cut-thru enable and threshold
   `define gem_jumbo_max_length_ad  12'h048   // Jumbo Packet Max Length
   `define gem_soft_conf_ctrl       12'h04c   // Soft configuration control reg
   `define gem_axi_max_pipeline     12'h054   // AXI Max Pipeline register
   `define gem_rsc_control          12'h058   // RSC Control register
   `define gem_int_moderation       12'h05c   // Interrupt moderation register
   `define gem_sys_wake_time        12'h060   // Tw_sys_tx time register
   `define gem_fatal_or_non_fatal_int_sel 12'h064   // Fatal or non Fatal Interrupt Indication Register
   `define gem_lockup_config        12'h068   // Lockup Detection and Recovery Configuration Register
   `define gem_lockup_config2       12'h06c   // Lockup Detection and Recovery Configuration Register
   `define gem_lockup_config3       12'h070   // Lockup Detection and Recovery Configuration Register
   `define gem_rx_water_mark        12'h07c   // Receive water mark register for triggering pause frame transmission
   `define gem_hash_bottom          12'h080   // Hash Register Bottom
   `define gem_hash_top             12'h084   // Hash Register Top
   `define gem_spec_add1_bottom     12'h088   // Specific Address 1 Bottom
   `define gem_spec_add1_top        12'h08c   // Specific Address 1 Top
   `define gem_spec_add2_bottom     12'h090   // Specific Address 2 Bottom
   `define gem_spec_add2_top        12'h094   // Specific Address 2 Top
   `define gem_spec_add3_bottom     12'h098   // Specific Address 3 Bottom
   `define gem_spec_add3_top        12'h09c   // Specific Address 3 Top
   `define gem_spec_add4_bottom     12'h0a0   // Specific Address 4 Bottom
   `define gem_spec_add4_top        12'h0a4   // Specific Address 4 Top
   `define gem_spec_type1           12'h0a8   // TypeID match 1 Register
   `define gem_spec_type2           12'h0ac   // TypeID match 2 Register
   `define gem_spec_type3           12'h0b0   // TypeID match 3 Register
   `define gem_spec_type4           12'h0b4   // TypeID match 4 Register
   `define gem_wol_register         12'h0b8   // Wakeup-on-LAN Register
   `define gem_stretch_ratio        12'h0bc   // Stretch Ratio Register
   `define gem_stacked_vlan         12'h0c0   // Stretched VLAN Register
   `define gem_tx_pfc_pause         12'h0c4   // Transmit PFC Pause Register
   `define gem_mask_add1_bottom     12'h0c8   // Specific Address 1 Mask Bottom
   `define gem_mask_add1_top        12'h0cc   // Specific Address 1 Mask Top
   `define gem_dma_addr_or_mask     12'h0d0   // Mask for data buffer accesses
   `define gem_rx_ptp_unicast       12'h0d4   // Unicast IP DA for receive PTP
   `define gem_tx_ptp_unicast       12'h0d8   // Unicast IP DA for transmit PTP
   `define gem_tsu_nsec_cmp         12'h0dc   // TSU timer comparison nanosecond
   `define gem_tsu_sec_cmp          12'h0e0   // TSU timer comparison second [31:0]
   `define gem_tsu_msb_sec_cmp      12'h0e4   // TSU timer comparison second [47:32]
   `define gem_tsu_ptp_tx_msb_sec   12'h0e8   // PTP frame event trans sec[47:32]
   `define gem_tsu_ptp_rx_msb_sec   12'h0ec   // PTP frame event receive sec[47:32]
   `define gem_tsu_peer_tx_msb_sec  12'h0f0   // peer frame event trans sec[47:32]
   `define gem_tsu_peer_rx_msb_sec  12'h0f4   // peer frame event receive sec[47:32]
   `define gem_dpram_fill_dbg       12'h0f8   // DPRAM Debug register
   `define gem_revision_reg         12'h0fc   // Module ID Register

    // Statistic register addresses
   `define gem_octets_txed_bottom       12'h100   // Octets Transmitted Bottom
   `define gem_octets_txed_top          12'h104   // Octets Transmitted Top
   `define gem_frames_txed_ok           12'h108   // Frames Transmitted
   `define gem_broadcast_txed           12'h10c   // Broadcast Frames Transmitted
   `define gem_multicast_txed           12'h110   // Multicast Frames Transmitted
   `define gem_pause_frames_txed        12'h114   // Transmitted Pause Frames
   `define gem_frames_txed_64           12'h118   // 64 Byte Frames Transmitted
   `define gem_frames_txed_65           12'h11c   // 65 to 127 Byte Frames Txed
   `define gem_frames_txed_128          12'h120   // 128 to 255 Byte Frames Txed
   `define gem_frames_txed_256          12'h124   // 256 to 511 Byte Frames Txed
   `define gem_frames_txed_512          12'h128   // 512 to 1023 Byte Frames Txed
   `define gem_frames_txed_1024         12'h12c   // 1024 to 1518 Byte Frames Txed
   `define gem_frames_txed_1519         12'h130   // > 1518 Byte Frames Txed
   `define gem_tx_underruns             12'h134   // Transmit Under Run Errors
   `define gem_single_collisions        12'h138   // Single Collision Frames
   `define gem_multiple_collisions      12'h13c   // Multiple Collision Frames
   `define gem_excessive_collisions     12'h140   // Excessive Collisions
   `define gem_late_collisions          12'h144   // Late Collisions
   `define gem_deferred_frames          12'h148   // Deferred Transmission Frames
   `define gem_crs_errors               12'h14c   // Carrier Sense Errors
   `define gem_octets_rxed_bottom       12'h150   // Octets Received Bottom
   `define gem_octets_rxed_top          12'h154   // Octets Received Top
   `define gem_frames_rxed_ok           12'h158   // Frames Received
   `define gem_broadcast_rxed           12'h15c   // Broadcast Frames Received
   `define gem_multicast_rxed           12'h160   // Multicast Frames Received
   `define gem_pause_frames_rxed        12'h164   // Pause Frames Received
   `define gem_frames_rxed_64           12'h168   // 64 Byte Frames Received
   `define gem_frames_rxed_65           12'h16c   // 65 to 127 Byte Frames Rxed
   `define gem_frames_rxed_128          12'h170   // 128 to 255 Byte Frames Rxed
   `define gem_frames_rxed_256          12'h174   // 256 to 511 Byte Frames Rxed
   `define gem_frames_rxed_512          12'h178   // 512 to 1023 Byte Frames Rxed
   `define gem_frames_rxed_1024         12'h17c   // 1024 to 1518 Byte Frames Rxed
   `define gem_frames_rxed_1519         12'h180   // > 1518 Byte Frames Rxed
   `define gem_undersize_frames         12'h184   // Undersize Frames Received
   `define gem_excessive_rx_length      12'h188   // Oversize Frames Received
   `define gem_rx_jabbers               12'h18c   // Jabber Frames Received
   `define gem_fcs_errors               12'h190   // Frame Check Sequence Errors
   `define gem_rx_length_errors         12'h194   // Length Field Frame Errors
   `define gem_rx_symbol_errors         12'h198   // Receive Symbol Errors
   `define gem_alignment_errors         12'h19c   // Alignment Errors
   `define gem_rx_resource_errors       12'h1a0   // Receive Resource Errors
   `define gem_rx_overruns              12'h1a4   // Receive Overrun Errors
   `define gem_rx_ip_ck_errors          12'h1a8   // IP header checksum Errors
   `define gem_rx_tcp_ck_errors         12'h1ac   // TCP checksum Errors
   `define gem_rx_udp_ck_errors         12'h1b0   // UDP checksum Errors
   `define gem_auto_flushed_pkts        12'h1b4   // GEM RX DMA flushed packets
   `define gem_tsu_timer_incr_sub_nsec  12'h1bc   // 1588 timer increment (sub ns 16-bits)
   `define gem_tsu_timer_msb_sec        12'h1c0   // 1588 timer seconds [47:32]
   `define gem_tsu_strobe_msb_sec       12'h1c4   // timer sync strobe seconds [47:32]
   `define gem_tsu_strobe_sec           12'h1c8   // timer sync strobe seconds [31:0]
   `define gem_tsu_strobe_nsec          12'h1cc   // timer sync strobe nanoseconds
   `define gem_tsu_timer_sec            12'h1d0   // 1588 timer seconds
   `define gem_tsu_timer_nsec           12'h1d4   // 1588 timer nanoseconds
   `define gem_tsu_timer_adjust         12'h1d8   // 1588 timer adjust
   `define gem_tsu_timer_incr           12'h1dc   // 1588 timer increment
   `define gem_tsu_ptp_tx_sec           12'h1e0   // PTP frame event trans sec[31:0]
   `define gem_tsu_ptp_tx_nsec          12'h1e4   // PTP frame event trans nanosec
   `define gem_tsu_ptp_rx_sec           12'h1e8   // PTP frame event receive sec[31:0]
   `define gem_tsu_ptp_rx_nsec          12'h1ec   // PTP frame event receive nanosec
   `define gem_tsu_peer_tx_sec          12'h1f0   // peer frame event trans sec[31:0]
   `define gem_tsu_peer_tx_nsec         12'h1f4   // peer frame event trans nanosec
   `define gem_tsu_peer_rx_sec          12'h1f8   // peer frame event receive sec[31:0]
   `define gem_tsu_peer_rx_nsec         12'h1fc   // peer frame event receive nanosec

    // PCS Register addresses
   `define gem_pcs_control          12'h200   // PCS Control Register
   `define gem_pcs_status           12'h204   // PCS Status Register
   `define gem_pcs_phy_top_id       12'h208   // PCS PHY Upper Identifier
   `define gem_pcs_phy_bot_id       12'h20C   // PCS PHY Lower Identifier
   `define gem_pcs_an_adv           12'h210   // PCS AN Advertisment Register
   `define gem_pcs_an_lp_base       12'h214   // PCS AN Link Partner Ability Reg
   `define gem_pcs_an_exp           12'h218   // PCS AN Expansion Register
   `define gem_pcs_an_np_tx         12'h21C   // PCS AN Next Page Register
   `define gem_pcs_an_lp_np         12'h220   // PCS AN Link Partner Next Page
   `define gem_pcs_reserved_reg1    12'h224   // RESERVED ADDRESS
   `define gem_pcs_reserved_reg2    12'h228   // RESERVED ADDRESS
   `define gem_pcs_reserved_reg3    12'h22c   // RESERVED ADDRESS
   `define gem_pcs_reserved_reg4    12'h230   // RESERVED ADDRESS
   `define gem_pcs_reserved_reg5    12'h234   // RESERVED ADDRESS
   `define gem_pcs_reserved_reg6    12'h238   // RESERVED ADDRESS
   `define gem_pcs_an_ext_status    12'h23C   // PCS AN Extended Status Register

    //additional PFC priority registers
   `define gem_tx_pause_quantum1    12'h260   // Transmit Pause Quantum Register 1 for priority 2 & 3
   `define gem_tx_pause_quantum2    12'h264   // Transmit Pause Quantum Register 2 for priority 4 & 5
   `define gem_tx_pause_quantum3    12'h268   // Transmit Pause Quantum Register 3 for priority 6 & 7
   `define gem_pfc_status           12'h26C   // Priority flow control status register

    // Energy efficient Ethernet registers
   `define gem_rx_lpi               12'h270   // count of rx lpi transitions
   `define gem_rx_lpi_time          12'h274   // time rx lpi is asserted
   `define gem_tx_lpi               12'h278   // count of tx lpi transitions
   `define gem_tx_lpi_time          12'h27C   // time tx lpi is asserted

    // Design Configuration Info (For Debug)
   `define gem_designcfg_debug1     12'h280   // Design Configuration Readable through APB
   `define gem_designcfg_debug2     12'h284   // Design Configuration Readable through APB
   `define gem_designcfg_debug3     12'h288   // Design Configuration Readable through APB
   `define gem_designcfg_debug4     12'h28c   // Design Configuration Readable through APB
   `define gem_designcfg_debug5     12'h290   // Design Configuration Readable through APB
   `define gem_designcfg_debug6     12'h294   // Design Configuration Readable through APB
   `define gem_designcfg_debug7     12'h298   // Design Configuration Readable through APB
   `define gem_designcfg_debug8     12'h29c   // Design Configuration Readable through APB
   `define gem_designcfg_debug9     12'h2a0   // Design Configuration Readable through APB
   `define gem_designcfg_debug10    12'h2a4   // Design Configuration Readable through APB
   `define gem_designcfg_debug11    12'h2a8   // Design Configuration Readable through APB
   `define gem_designcfg_debug12    12'h2ac   // Design Configuration Readable through APB

    // AXI QoS registers.
   `define gem_axi_qos_cfg0         12'h2e0   // AXI QoS configuration for queues 0-3
   `define gem_axi_qos_cfg1         12'h2e4   // AXI QoS configuration for queues 4-7
   `define gem_axi_qos_cfg2         12'h2e8   // AXI QoS configuration for queues 8-11
   `define gem_axi_qos_cfg3         12'h2ec   // AXI QoS configuration for queues 12-15

    // Extra specific registers
   `define gem_spec_add5_bottom     12'h300   // Specific Address 5 Bottom
   `define gem_spec_add5_top        12'h304   // Specific Address 5 Top
   `define gem_spec_add6_bottom     12'h308   // Specific Address 6 Bottom
   `define gem_spec_add6_top        12'h30c   // Specific Address 6 Top
   `define gem_spec_add7_bottom     12'h310   // Specific Address 7 Bottom
   `define gem_spec_add7_top        12'h314   // Specific Address 7 Top
   `define gem_spec_add8_bottom     12'h318   // Specific Address 8 Bottom
   `define gem_spec_add8_top        12'h31c   // Specific Address 8 Top
   `define gem_spec_add9_bottom     12'h320   // Specific Address 9 Bottom
   `define gem_spec_add9_top        12'h324   // Specific Address 9 Top
   `define gem_spec_add10_bottom    12'h328   // Specific Address 10 Bottom
   `define gem_spec_add10_top       12'h32c   // Specific Address 10 Top
   `define gem_spec_add11_bottom    12'h330   // Specific Address 11 Bottom
   `define gem_spec_add11_top       12'h334   // Specific Address 11 Top
   `define gem_spec_add12_bottom    12'h338   // Specific Address 12 Bottom
   `define gem_spec_add12_top       12'h33c   // Specific Address 12 Top
   `define gem_spec_add13_bottom    12'h340   // Specific Address 13 Bottom
   `define gem_spec_add13_top       12'h344   // Specific Address 13 Top
   `define gem_spec_add14_bottom    12'h348   // Specific Address 14 Bottom
   `define gem_spec_add14_top       12'h34c   // Specific Address 14 Top
   `define gem_spec_add15_bottom    12'h350   // Specific Address 15 Bottom
   `define gem_spec_add15_top       12'h354   // Specific Address 15 Top
   `define gem_spec_add16_bottom    12'h358   // Specific Address 16 Bottom
   `define gem_spec_add16_top       12'h35c   // Specific Address 16 Top
   `define gem_spec_add17_bottom    12'h360   // Specific Address 17 Bottom
   `define gem_spec_add17_top       12'h364   // Specific Address 17 Top
   `define gem_spec_add18_bottom    12'h368   // Specific Address 18 Bottom
   `define gem_spec_add18_top       12'h36c   // Specific Address 18 Top
   `define gem_spec_add19_bottom    12'h370   // Specific Address 19 Bottom
   `define gem_spec_add19_top       12'h374   // Specific Address 19 Top
   `define gem_spec_add20_bottom    12'h378   // Specific Address 20 Bottom
   `define gem_spec_add20_top       12'h37c   // Specific Address 20 Top
   `define gem_spec_add21_bottom    12'h380   // Specific Address 21 Bottom
   `define gem_spec_add21_top       12'h384   // Specific Address 21 Top
   `define gem_spec_add22_bottom    12'h388   // Specific Address 22 Bottom
   `define gem_spec_add22_top       12'h38c   // Specific Address 22 Top
   `define gem_spec_add23_bottom    12'h390   // Specific Address 23 Bottom
   `define gem_spec_add23_top       12'h394   // Specific Address 23 Top
   `define gem_spec_add24_bottom    12'h398   // Specific Address 24 Bottom
   `define gem_spec_add24_top       12'h39c   // Specific Address 24 Top
   `define gem_spec_add25_bottom    12'h3a0   // Specific Address 25 Bottom
   `define gem_spec_add25_top       12'h3a4   // Specific Address 25 Top
   `define gem_spec_add26_bottom    12'h3a8   // Specific Address 26 Bottom
   `define gem_spec_add26_top       12'h3ac   // Specific Address 26 Top
   `define gem_spec_add27_bottom    12'h3b0   // Specific Address 27 Bottom
   `define gem_spec_add27_top       12'h3b4   // Specific Address 27 Top
   `define gem_spec_add28_bottom    12'h3b8   // Specific Address 28 Bottom
   `define gem_spec_add28_top       12'h3bc   // Specific Address 28 Top
   `define gem_spec_add29_bottom    12'h3c0   // Specific Address 29 Bottom
   `define gem_spec_add29_top       12'h3c4   // Specific Address 29 Top
   `define gem_spec_add30_bottom    12'h3c8   // Specific Address 30 Bottom
   `define gem_spec_add30_top       12'h3cc   // Specific Address 30 Top
   `define gem_spec_add31_bottom    12'h3d0   // Specific Address 31 Bottom
   `define gem_spec_add31_top       12'h3d4   // Specific Address 31 Top
   `define gem_spec_add32_bottom    12'h3d8   // Specific Address 32 Bottom
   `define gem_spec_add32_top       12'h3dc   // Specific Address 32 Top
   `define gem_spec_add33_bottom    12'h3e0   // Specific Address 33 Bottom
   `define gem_spec_add33_top       12'h3e4   // Specific Address 33 Top
   `define gem_spec_add34_bottom    12'h3e8   // Specific Address 34 Bottom
   `define gem_spec_add34_top       12'h3ec   // Specific Address 34 Top
   `define gem_spec_add35_bottom    12'h3f0   // Specific Address 35 Bottom
   `define gem_spec_add35_top       12'h3f4   // Specific Address 35 Top
   `define gem_spec_add36_bottom    12'h3f8   // Specific Address 36 Bottom
   `define gem_spec_add36_top       12'h3fc   // Specific Address 36 Top

   // The following defines are required if the priority queuing feature in the DMA
   // is enabled
   //
   // Extra Interrupt Status Registers ...
   `define gem_int_q1_status        12'h400   // Interrupt Status Register Q1
   `define gem_int_q2_status        12'h404   // Interrupt Status Register Q2
   `define gem_int_q3_status        12'h408   // Interrupt Status Register Q3
   `define gem_int_q4_status        12'h40c   // Interrupt Status Register Q4
   `define gem_int_q5_status        12'h410   // Interrupt Status Register Q5
   `define gem_int_q6_status        12'h414   // Interrupt Status Register Q6
   `define gem_int_q7_status        12'h418   // Interrupt Status Register Q7
   `define gem_int_q8_status        12'h41c   // Interrupt Status Register Q8
   `define gem_int_q9_status        12'h420   // Interrupt Status Register Q9
   `define gem_int_q10_status       12'h424   // Interrupt Status Register Q10
   `define gem_int_q11_status       12'h428   // Interrupt Status Register Q11
   `define gem_int_q12_status       12'h42c   // Interrupt Status Register Q12
   `define gem_int_q13_status       12'h430   // Interrupt Status Register Q13
   `define gem_int_q14_status       12'h434   // Interrupt Status Register Q14
   `define gem_int_q15_status       12'h438   // Interrupt Status Register Q15

    // Extra Transmit Buffer Queue Base Address Registers ...
   `define gem_transmit_q1_ptr      12'h440   // TX Buffer Queue 1 Base Add
   `define gem_transmit_q2_ptr      12'h444   // TX Buffer Queue 2 Base Add
   `define gem_transmit_q3_ptr      12'h448   // TX Buffer Queue 3 Base Add
   `define gem_transmit_q4_ptr      12'h44c   // TX Buffer Queue 4 Base Add
   `define gem_transmit_q5_ptr      12'h450   // TX Buffer Queue 5 Base Add
   `define gem_transmit_q6_ptr      12'h454   // TX Buffer Queue 6 Base Add
   `define gem_transmit_q7_ptr      12'h458   // TX Buffer Queue 7 Base Add
   `define gem_transmit_q8_ptr      12'h45c   // TX Buffer Queue 8 Base Add
   `define gem_transmit_q9_ptr      12'h460   // TX Buffer Queue 9 Base Add
   `define gem_transmit_q10_ptr     12'h464   // TX Buffer Queue 10 Base Add
   `define gem_transmit_q11_ptr     12'h468   // TX Buffer Queue 11 Base Add
   `define gem_transmit_q12_ptr     12'h46c   // TX Buffer Queue 12 Base Add
   `define gem_transmit_q13_ptr     12'h470   // TX Buffer Queue 13 Base Add
   `define gem_transmit_q14_ptr     12'h474   // TX Buffer Queue 14 Base Add
   `define gem_transmit_q15_ptr     12'h478   // TX Buffer Queue 15 Base Add

    // Extra Receive Buffer Queue Base Address Registers ...
   `define gem_receive_q1_ptr       12'h480   // RX Buffer Queue 1 Base Add
   `define gem_receive_q2_ptr       12'h484   // RX Buffer Queue 2 Base Add
   `define gem_receive_q3_ptr       12'h488   // RX Buffer Queue 3 Base Add
   `define gem_receive_q4_ptr       12'h48c   // RX Buffer Queue 4 Base Add
   `define gem_receive_q5_ptr       12'h490   // RX Buffer Queue 5 Base Add
   `define gem_receive_q6_ptr       12'h494   // RX Buffer Queue 6 Base Add
   `define gem_receive_q7_ptr       12'h498   // RX Buffer Queue 7 Base Add
   `define gem_dma_rxbuf_size_q1    12'h4a0   // RX Buffer Size for Queue 1
   `define gem_dma_rxbuf_size_q2    12'h4a4   // RX Buffer Size for Queue 2
   `define gem_dma_rxbuf_size_q3    12'h4a8   // RX Buffer Size for Queue 3
   `define gem_dma_rxbuf_size_q4    12'h4ac   // RX Buffer Size for Queue 4
   `define gem_dma_rxbuf_size_q5    12'h4b0   // RX Buffer Size for Queue 5
   `define gem_dma_rxbuf_size_q6    12'h4b4   // RX Buffer Size for Queue 6
   `define gem_dma_rxbuf_size_q7    12'h4b8   // RX Buffer Size for Queue 7

    // Transmit Queue Scheduling Options
   `define gem_cbs_control          12'h4bc   // Credit Based Shaping ctrl
   `define gem_cbs_idleslope_q_a    12'h4c0   // CBS IdleSlope parameter
   `define gem_cbs_idleslope_q_b    12'h4c4   // CBS IdleSlope parameter

   `define gem_upper_tx_q_base_addr 12'h4c8   // Upper 32b Buffer Queue Base Address
   `define gem_tx_bd_control        12'h4cc   // TX BD control register
   `define gem_rx_bd_control        12'h4d0   // RX BD control register
   `define gem_upper_rx_q_base_addr 12'h4d4   // Upper 32b Buffer rx Queue Base Address


   `define gem_cbs_port_tx_rate_10m   12'h4e0   // 10M Port TX Rate *** HIDDEN Register ***
   `define gem_cbs_port_tx_rate_100m  12'h4e4   // 100M Port TX Rate *** HIDDEN Register ***
   `define gem_cbs_port_tx_rate_1g    12'h4e8   // 1G Port TX Rate *** HIDDEN Register ***
   `define gem_wd_counter             12'h4ec   // *** HIDDEN Register ***
   `define gem_axi_tx_full_threshold0 12'h4f8   // AXI full threshold setting *** HIDDEN Register ***
   `define gem_axi_tx_full_threshold1 12'h4fc   // AXI full threshold setting *** HIDDEN Register ***

    // Type 1 Screener APB Addresses.
    //  screener 0 will be located at address 0x500
    //  screener 1 will be located at address 0x504
    //  screener 2 will be located at address 0x508
    //  and so on ...
   `define type1_screener_base_addr 12'h500
   `define type1_screener_0         12'h500
   `define type1_screener_1         12'h504
   `define type1_screener_2         12'h508
   `define type1_screener_3         12'h50c
   `define type1_screener_4         12'h510
   `define type1_screener_5         12'h514
   `define type1_screener_6         12'h518
   `define type1_screener_7         12'h51c
   `define type1_screener_8         12'h520
   `define type1_screener_9         12'h524
   `define type1_screener_10        12'h528
   `define type1_screener_11        12'h52c
   `define type1_screener_12        12'h530
   `define type1_screener_13        12'h534
   `define type1_screener_14        12'h538
   `define type1_screener_15        12'h53c

    // Type 2 Screener APB Addresses.
    //  screener 0 will be located at address 0x540
    //  screener 1 will be located at address 0x544
    //  screener 2 will be located at address 0x548
    //  and so on ...
   `define type2_screener_base_addr 12'h540
   `define type2_screener_0         12'h540
   `define type2_screener_1         12'h544
   `define type2_screener_2         12'h548
   `define type2_screener_3         12'h54c
   `define type2_screener_4         12'h550
   `define type2_screener_5         12'h554
   `define type2_screener_6         12'h558
   `define type2_screener_7         12'h55c
   `define type2_screener_8         12'h560
   `define type2_screener_9         12'h564
   `define type2_screener_10        12'h568
   `define type2_screener_11        12'h56c
   `define type2_screener_12        12'h570
   `define type2_screener_13        12'h574
   `define type2_screener_14        12'h578
   `define type2_screener_15        12'h57c

   `define gem_dwrr_ets_control     12'h580   // DWRR and ETS queue enable
   `define gem_bw_rate_limit_q03    12'h590   // Bandwidth allocation for Q0-3
   `define gem_bw_rate_limit_q47    12'h594   // Bandwidth allocation for Q4-7
   `define gem_bw_rate_limit_q8b    12'h598   // Bandwidth allocation for Q8-11
   `define gem_bw_rate_limit_qcf    12'h59c   // Bandwidth allocation for Q12-15

   `define gem_tx_q_seg_alloc_q07   12'h5a0   // Number of segments for TX Q 0-7
   `define gem_tx_q_seg_alloc_q8f   12'h5a4   // Number of segments for TX Q 8-15

    // RX Quue registers continued
   `define gem_receive_q8_ptr       12'h5c0   // RX Buffer Queue 8 Base Add
   `define gem_receive_q9_ptr       12'h5c4   // RX Buffer Queue 9 Base Add
   `define gem_receive_q10_ptr      12'h5c8   // RX Buffer Queue 10 Base Add
   `define gem_receive_q11_ptr      12'h5cc   // RX Buffer Queue 11 Base Add
   `define gem_receive_q12_ptr      12'h5d0   // RX Buffer Queue 12 Base Add
   `define gem_receive_q13_ptr      12'h5d4   // RX Buffer Queue 13 Base Add
   `define gem_receive_q14_ptr      12'h5d8   // RX Buffer Queue 14 Base Add
   `define gem_receive_q15_ptr      12'h5dc   // RX Buffer Queue 15 Base Add
   `define gem_dma_rxbuf_size_q8    12'h5e0   // RX Buffer Size for Queue 8
   `define gem_dma_rxbuf_size_q9    12'h5e4   // RX Buffer Size for Queue 9
   `define gem_dma_rxbuf_size_q10   12'h5e8   // RX Buffer Size for Queue 10
   `define gem_dma_rxbuf_size_q11   12'h5ec   // RX Buffer Size for Queue 11
   `define gem_dma_rxbuf_size_q12   12'h5f0   // RX Buffer Size for Queue 12
   `define gem_dma_rxbuf_size_q13   12'h5f4   // RX Buffer Size for Queue 13
   `define gem_dma_rxbuf_size_q14   12'h5f8   // RX Buffer Size for Queue 14
   `define gem_dma_rxbuf_size_q15   12'h5fc   // RX Buffer Size for Queue 15

    // Extra Interrupt Enable/Disable and Mask Registers ...
   `define gem_int_q1_enable        12'h600   // Interrupt Enable Register q1
   `define gem_int_q2_enable        12'h604   // Interrupt Enable Register q2
   `define gem_int_q3_enable        12'h608   // Interrupt Enable Register q3
   `define gem_int_q4_enable        12'h60c   // Interrupt Enable Register q4
   `define gem_int_q5_enable        12'h610   // Interrupt Enable Register q5
   `define gem_int_q6_enable        12'h614   // Interrupt Enable Register q6
   `define gem_int_q7_enable        12'h618   // Interrupt Enable Register q7
   `define gem_int_q1_disable       12'h620   // Interrupt Disable Register q1
   `define gem_int_q2_disable       12'h624   // Interrupt Disable Register q2
   `define gem_int_q3_disable       12'h628   // Interrupt Disable Register q3
   `define gem_int_q4_disable       12'h62c   // Interrupt Disable Register q4
   `define gem_int_q5_disable       12'h630   // Interrupt Disable Register q5
   `define gem_int_q6_disable       12'h634   // Interrupt Disable Register q6
   `define gem_int_q7_disable       12'h638   // Interrupt Disable Register q7
   `define gem_int_q1_mask          12'h640   // Interrupt Mask    Register q1
   `define gem_int_q2_mask          12'h644   // Interrupt Mask    Register q2
   `define gem_int_q3_mask          12'h648   // Interrupt Mask    Register q3
   `define gem_int_q4_mask          12'h64c   // Interrupt Mask    Register q4
   `define gem_int_q5_mask          12'h650   // Interrupt Mask    Register q5
   `define gem_int_q6_mask          12'h654   // Interrupt Mask    Register q6
   `define gem_int_q7_mask          12'h658   // Interrupt Mask    Register q7
   `define gem_int_q8_enable        12'h660   // Interrupt Enable Register q8
   `define gem_int_q9_enable        12'h664   // Interrupt Enable Register q9
   `define gem_int_q10_enable       12'h668   // Interrupt Enable Register q10
   `define gem_int_q11_enable       12'h66c   // Interrupt Enable Register q11
   `define gem_int_q12_enable       12'h670   // Interrupt Enable Register q12
   `define gem_int_q13_enable       12'h674   // Interrupt Enable Register q13
   `define gem_int_q14_enable       12'h678   // Interrupt Enable Register q14
   `define gem_int_q15_enable       12'h67c   // Interrupt Enable Register q15
   `define gem_int_q8_disable       12'h680   // Interrupt Disable Register q8
   `define gem_int_q9_disable       12'h684   // Interrupt Disable Register q9
   `define gem_int_q10_disable      12'h688   // Interrupt Disable Register q10
   `define gem_int_q11_disable      12'h68c   // Interrupt Disable Register q11
   `define gem_int_q12_disable      12'h690   // Interrupt Disable Register q12
   `define gem_int_q13_disable      12'h694   // Interrupt Disable Register q13
   `define gem_int_q14_disable      12'h698   // Interrupt Disable Register q14
   `define gem_int_q15_disable      12'h69c   // Interrupt Disable Register q15
   `define gem_int_q8_mask          12'h6a0   // Interrupt Mask    Register q8
   `define gem_int_q9_mask          12'h6a4   // Interrupt Mask    Register q9
   `define gem_int_q10_mask         12'h6a8   // Interrupt Mask    Register q10
   `define gem_int_q11_mask         12'h6ac   // Interrupt Mask    Register q11
   `define gem_int_q12_mask         12'h6b0   // Interrupt Mask    Register q12
   `define gem_int_q13_mask         12'h6b4   // Interrupt Mask    Register q13
   `define gem_int_q14_mask         12'h6b8   // Interrupt Mask    Register q14
   `define gem_int_q15_mask         12'h6bc   // Interrupt Mask    Register q15

    // Screener Type 2 Ethertype Registers
    // reserve the space following 6e0 for more type 2 ethertype registers ...
    //  ethertype match register 0 will be located at address 0x6e0
    //  ethertype match register 1 will be located at address 0x6e4
    //  ethertype match register 2 will be located at address 0x6e8
    //  and so on ...
   `define scr2_ethtype_reg_0       12'h6e0
   `define scr2_ethtype_reg_1       12'h6e4
   `define scr2_ethtype_reg_2       12'h6e8
   `define scr2_ethtype_reg_3       12'h6ec
   `define scr2_ethtype_reg_4       12'h6f0
   `define scr2_ethtype_reg_5       12'h6f4
   `define scr2_ethtype_reg_6       12'h6f8
   `define scr2_ethtype_reg_7       12'h6fc

    // Screener Type 2 Compare Registers
    // reserve the space following 700 for more type 2 compare registers ...
    //  compare match register 0a will be located at address 0x700
    //  compare match register 0b will be located at address 0x704
    //  compare match register 1a will be located at address 0x708
    //  compare match register 1b will be located at address 0x70c
    //  compare match register 2a will be located at address 0x710
    //  compare match register 2b will be located at address 0x714
    //  and so on ...
   `define scr2_compare_reg_0       12'h700
   `define scr2_compare_reg_0a      12'h700
   `define scr2_compare_reg_0b      12'h704
   `define scr2_compare_reg_1a      12'h708
   `define scr2_compare_reg_1b      12'h70c
   `define scr2_compare_reg_2a      12'h710
   `define scr2_compare_reg_2b      12'h714
   `define scr2_compare_reg_3a      12'h718
   `define scr2_compare_reg_3b      12'h71c
   `define scr2_compare_reg_4a      12'h720
   `define scr2_compare_reg_4b      12'h724
   `define scr2_compare_reg_5a      12'h728
   `define scr2_compare_reg_5b      12'h72c
   `define scr2_compare_reg_6a      12'h730
   `define scr2_compare_reg_6b      12'h734
   `define scr2_compare_reg_7a      12'h738
   `define scr2_compare_reg_7b      12'h73c
   `define scr2_compare_reg_8a      12'h740
   `define scr2_compare_reg_8b      12'h744
   `define scr2_compare_reg_9a      12'h748
   `define scr2_compare_reg_9b      12'h74c
   `define scr2_compare_reg_10a     12'h750
   `define scr2_compare_reg_10b     12'h754
   `define scr2_compare_reg_11a     12'h758
   `define scr2_compare_reg_11b     12'h75c
   `define scr2_compare_reg_12a     12'h760
   `define scr2_compare_reg_12b     12'h764
   `define scr2_compare_reg_13a     12'h768
   `define scr2_compare_reg_13b     12'h76c
   `define scr2_compare_reg_14a     12'h770
   `define scr2_compare_reg_14b     12'h774
   `define scr2_compare_reg_15a     12'h778
   `define scr2_compare_reg_15b     12'h77c
   `define scr2_compare_reg_16a     12'h780
   `define scr2_compare_reg_16b     12'h784
   `define scr2_compare_reg_17a     12'h788
   `define scr2_compare_reg_17b     12'h78c
   `define scr2_compare_reg_18a     12'h790
   `define scr2_compare_reg_18b     12'h794
   `define scr2_compare_reg_19a     12'h798
   `define scr2_compare_reg_19b     12'h79c
   `define scr2_compare_reg_20a     12'h7a0
   `define scr2_compare_reg_20b     12'h7a4
   `define scr2_compare_reg_21a     12'h7a8
   `define scr2_compare_reg_21b     12'h7ac
   `define scr2_compare_reg_22a     12'h7b0
   `define scr2_compare_reg_22b     12'h7b4
   `define scr2_compare_reg_23a     12'h7b8
   `define scr2_compare_reg_23b     12'h7bc
   `define scr2_compare_reg_24a     12'h7c0
   `define scr2_compare_reg_24b     12'h7c4
   `define scr2_compare_reg_25a     12'h7c8
   `define scr2_compare_reg_25b     12'h7cc
   `define scr2_compare_reg_26a     12'h7d0
   `define scr2_compare_reg_26b     12'h7d4
   `define scr2_compare_reg_27a     12'h7d8
   `define scr2_compare_reg_27b     12'h7dc
   `define scr2_compare_reg_28a     12'h7e0
   `define scr2_compare_reg_28b     12'h7e4
   `define scr2_compare_reg_29a     12'h7e8
   `define scr2_compare_reg_29b     12'h7ec
   `define scr2_compare_reg_30a     12'h7f0
   `define scr2_compare_reg_30b     12'h7f4
   `define scr2_compare_reg_31a     12'h7f8
   `define scr2_compare_reg_31b     12'h7fc

    // EnST Registers
   `define gem_start_time_reg_0           12'h800
   `define gem_start_time_reg_1           12'h804
   `define gem_start_time_reg_2           12'h808
   `define gem_start_time_reg_3           12'h80c
   `define gem_start_time_reg_4           12'h810
   `define gem_start_time_reg_5           12'h814
   `define gem_start_time_reg_6           12'h818
   `define gem_start_time_reg_7           12'h81c
   `define gem_on_time_reg_0              12'h820
   `define gem_on_time_reg_1              12'h824
   `define gem_on_time_reg_2              12'h828
   `define gem_on_time_reg_3              12'h82c
   `define gem_on_time_reg_4              12'h830
   `define gem_on_time_reg_5              12'h834
   `define gem_on_time_reg_6              12'h838
   `define gem_on_time_reg_7              12'h83c
   `define gem_off_time_reg_0             12'h840
   `define gem_off_time_reg_1             12'h844
   `define gem_off_time_reg_2             12'h848
   `define gem_off_time_reg_3             12'h84c
   `define gem_off_time_reg_4             12'h850
   `define gem_off_time_reg_5             12'h854
   `define gem_off_time_reg_6             12'h858
   `define gem_off_time_reg_7             12'h85c
   `define gem_enst_control_reg           12'h880

    // 802.1CB Registers
   `define gem_frer_timeout               12'h8a0
   `define gem_frer_red_tag               12'h8a4
   `define gem_frer_control_1_a           12'h8c0
   `define gem_frer_control_1_b           12'h8c4
   `define gem_frer_statistics_1_a        12'h8c8
   `define gem_frer_statistics_1_b        12'h8cc
   `define gem_frer_control_2_a           12'h8d0
   `define gem_frer_control_2_b           12'h8d4
   `define gem_frer_statistics_2_a        12'h8d8
   `define gem_frer_statistics_2_b        12'h8dc
   `define gem_frer_control_3_a           12'h8e0
   `define gem_frer_control_3_b           12'h8e4
   `define gem_frer_statistics_3_a        12'h8e8
   `define gem_frer_statistics_3_b        12'h8ec
   `define gem_frer_control_4_a           12'h8f0
   `define gem_frer_control_4_b           12'h8f4
   `define gem_frer_statistics_4_a        12'h8f8
   `define gem_frer_statistics_4_b        12'h8fc
   `define gem_frer_control_5_a           12'h900
   `define gem_frer_control_5_b           12'h904
   `define gem_frer_statistics_5_a        12'h908
   `define gem_frer_statistics_5_b        12'h90c
   `define gem_frer_control_6_a           12'h910
   `define gem_frer_control_6_b           12'h914
   `define gem_frer_statistics_6_a        12'h918
   `define gem_frer_statistics_6_b        12'h91c
   `define gem_frer_control_7_a           12'h920
   `define gem_frer_control_7_b           12'h924
   `define gem_frer_statistics_7_a        12'h928
   `define gem_frer_statistics_7_b        12'h92c
   `define gem_frer_control_8_a           12'h930
   `define gem_frer_control_8_b           12'h934
   `define gem_frer_statistics_8_a        12'h938
   `define gem_frer_statistics_8_b        12'h93c
   `define gem_frer_control_9_a           12'h940
   `define gem_frer_control_9_b           12'h944
   `define gem_frer_statistics_9_a        12'h948
   `define gem_frer_statistics_9_b        12'h94c
   `define gem_frer_control_10_a          12'h950
   `define gem_frer_control_10_b          12'h954
   `define gem_frer_statistics_10_a       12'h958
   `define gem_frer_statistics_10_b       12'h95c
   `define gem_frer_control_11_a          12'h960
   `define gem_frer_control_11_b          12'h964
   `define gem_frer_statistics_11_a       12'h968
   `define gem_frer_statistics_11_b       12'h96c
   `define gem_frer_control_12_a          12'h970
   `define gem_frer_control_12_b          12'h974
   `define gem_frer_statistics_12_a       12'h978
   `define gem_frer_statistics_12_b       12'h97c
   `define gem_frer_control_13_a          12'h980
   `define gem_frer_control_13_b          12'h984
   `define gem_frer_statistics_13_a       12'h988
   `define gem_frer_statistics_13_b       12'h98c
   `define gem_frer_control_14_a          12'h990
   `define gem_frer_control_14_b          12'h994
   `define gem_frer_statistics_14_a       12'h998
   `define gem_frer_statistics_14_b       12'h99c
   `define gem_frer_control_15_a          12'h9a0
   `define gem_frer_control_15_b          12'h9a4
   `define gem_frer_statistics_15_a       12'h9a8
   `define gem_frer_statistics_15_b       12'h9ac
   `define gem_frer_control_16_a          12'h9b0
   `define gem_frer_control_16_b          12'h9b4
   `define gem_frer_statistics_16_a       12'h9b8
   `define gem_frer_statistics_16_b       12'h9bc

    // The following should not be modified:
   `ifdef gem_pcs_20b_if
     `define gem_pcs_if_width  20
   `else
     `define gem_pcs_if_width  10
   `endif

    // Rx per queue traffic policing addresses
   `define gem_rx_q0_flush                    12'hb00
   `define gem_rx_q1_flush                    12'hb04
   `define gem_rx_q2_flush                    12'hb08
   `define gem_rx_q3_flush                    12'hb0c
   `define gem_rx_q4_flush                    12'hb10
   `define gem_rx_q5_flush                    12'hb14
   `define gem_rx_q6_flush                    12'hb18
   `define gem_rx_q7_flush                    12'hb1c
   `define gem_rx_q8_flush                    12'hb20
   `define gem_rx_q9_flush                    12'hb24
   `define gem_rx_q10_flush                   12'hb28
   `define gem_rx_q11_flush                   12'hb2c
   `define gem_rx_q12_flush                   12'hb30
   `define gem_rx_q13_flush                   12'hb34
   `define gem_rx_q14_flush                   12'hb38
   `define gem_rx_q15_flush                   12'hb3c

    // Per type 2 screener rate limiting registers addresses
   `define gem_scr2_0_rate_limit              12'hb40
   `define gem_scr2_1_rate_limit              12'hb44
   `define gem_scr2_2_rate_limit              12'hb48
   `define gem_scr2_3_rate_limit              12'hb4c
   `define gem_scr2_4_rate_limit              12'hb50
   `define gem_scr2_5_rate_limit              12'hb54
   `define gem_scr2_6_rate_limit              12'hb58
   `define gem_scr2_7_rate_limit              12'hb5c
   `define gem_scr2_8_rate_limit              12'hb60
   `define gem_scr2_9_rate_limit              12'hb64
   `define gem_scr2_10_rate_limit             12'hb68
   `define gem_scr2_11_rate_limit             12'hb6c
   `define gem_scr2_12_rate_limit             12'hb70
   `define gem_scr2_13_rate_limit             12'hb74
   `define gem_scr2_14_rate_limit             12'hb78
   `define gem_scr2_15_rate_limit             12'hb7c

    // Per type 2 screener rate limiting registers status addresses
   `define gem_scr_excess_rate                12'hb80

    // ASF feature registers addresses
   `define gem_asf_base_addr                  12'he00
   `define gem_asf_int_status                 `gem_asf_base_addr + 12'h000
   `define gem_asf_int_raw_status             `gem_asf_base_addr + 12'h004
   `define gem_asf_int_mask                   `gem_asf_base_addr + 12'h008
   `define gem_asf_int_test                   `gem_asf_base_addr + 12'h00C
   `define gem_asf_fatal_nonfatal_select      `gem_asf_base_addr + 12'h010
   `define gem_asf_sram_corr_fault_status     `gem_asf_base_addr + 12'h020
   `define gem_asf_sram_uncorr_fault_status   `gem_asf_base_addr + 12'h024
   `define gem_asf_sram_fault_stats           `gem_asf_base_addr + 12'h028
   `define gem_asf_trans_to_ctrl              `gem_asf_base_addr + 12'h030
   `define gem_asf_trans_to_fault_mask        `gem_asf_base_addr + 12'h034
   `define gem_asf_trans_to_fault_status      `gem_asf_base_addr + 12'h038
   `define gem_asf_protocol_fault_mask        `gem_asf_base_addr + 12'h040
   `define gem_asf_protocol_fault_status      `gem_asf_base_addr + 12'h044

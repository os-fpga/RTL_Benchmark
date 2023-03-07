//------------------------------------------------------------------------------
// Copyright (c) 2001-2022 Cadence Design Systems, Inc.
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
//   Filename:           gem_registers.v
//   Module Name:        gem_registers
//
//   Release Revision:   r1p12f7
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
//   Description :      Contains all the register inferences for the
//                      Gigabit Ethernet MAC. Also includes the logic for
//                      driving the MDIO interface and the ethernet_int pin.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_registers(

  // system inputs.
  n_preset,
  pclk,

  // apb interface signals.
  paddr,
  prdata,
  prdata_par,
  pwdata,
  pwdata_par,
  pwrite,
  penable,
  psel,
  perr,

  // other top level signals.
  mdio_in,
  mdio_en,
  mdio_out,
  mdc,
  ethernet_int,
  loopback,
  half_duplex,
  speed_mode,
  user_out,
  user_in,

  // signals from gem_pclk_syncs for tx status & statistics.
  tx_ok_pclk,
  tx_ok_mod_pclk,
  tx_underrun_pclk,
  tx_buffers_ex_pclk,
  tx_buff_ex_mid_pclk,
  tx_hresp_notok_pclk,
  tx_coll_occ_pclk,
  tx_toomanyretry_pclk,
  tx_mac_ok_pclk,
  tx_bytes_pclk,
  tx_broadcast_pclk,
  tx_multicast_pclk,
  tx_single_col_pclk,
  tx_multi_col_pclk,
  tx_late_col_pclk,
  tx_deferred_pclk,
  tx_crs_err_pclk,
  tx_pause_zero_pclk,
  tx_pause_ok_pclk,
  tx_pfc_pause_ok_pclk,
  tx_pause_time_pclk,
  tx_dma_descr_ptr,
  tx_go_pclk,
  tx_late_col_mac_pclk,

  // signals from gem_pclk_syncs for rx status & statistics.
  ok_to_update_rx_stats,
  rx_ok_pclk,
  rx_ok_mod_pclk,
  rx_mac_ok_pclk,
  rx_bytes_pclk,
  rx_broadcast_pclk,
  rx_multicast_pclk,
  rx_align_err_pclk,
  rx_crc_err_pclk,
  rx_short_err_pclk,
  rx_long_err_pclk,
  rx_jabber_err_pclk,
  rx_symbol_err_pclk,
  rx_pause_ok_pclk,
  rx_pause_nz_pclk,
  rx_length_err_pclk,
  rx_ip_ck_err_pclk,
  rx_tcp_ck_err_pclk,
  rx_udp_ck_err_pclk,
  rx_dma_pkt_flushed_pclk,
  rx_overflow_pclk,
  rx_dma_overrun_pclk,
  rx_buff_not_rdy_pclk,
  rx_resource_err_pclk,
  rx_hresp_notok_pclk,
  rx_dma_descr_ptr,
  tx_dma_int_queue,
  rx_dma_int_queue,
  pfc_negotiate_pclk,
  rx_pfc_paused_pclk,
  lpi_indicate_pclk,
  lpi_indicate_del,
  wol_pulse,
  axi_xaction_out_pclk,
  tx_frame_too_large_pclk,
  disable_tx_pclk,
  disable_rx_pclk,

  ptp_sync_tx_int,
  ptp_del_tx_int,
  ptp_pdel_req_tx_int,
  ptp_pdel_resp_tx_int,
  ptp_sync_rx_int,
  ptp_del_rx_int,
  ptp_pdel_req_rx_int,
  ptp_pdel_resp_rx_int,

  // signals from gem_pclk_syncs
  ptp_tx_time_load,
  ptp_rx_time_load,
  ptp_tx_ptime_load,
  ptp_rx_ptime_load,
  // signals from/to gem_tsu
  tsu_timer_sec,
  tsu_timer_nsec,
  tsu_timer_sec_wr,
  tsu_timer_nsec_wr,
  tsu_timer_adj_ctrl,
  tsu_timer_adj,
  tsu_timer_adj_wr,
  tsu_timer_incr,
  tsu_timer_incr_wr,
  tsu_timer_alt_incr,
  tsu_timer_num_incr,
  tsu_timer_nsec_cmp,
  tsu_timer_nsec_cmp_wr,
  tsu_timer_sec_cmp,
  tsu_incr_sec_int,
  timer_cmp_val_int,
  timer_strobe,
  tsu_ptp_tx_timer_in,
  tsu_ptp_rx_timer_in,
  tsu_ptp_tx_timer_par_in,
  tsu_ptp_rx_timer_par_in,
  one_step_sync_mode,
  oss_correction_field,
  ext_tsu_timer_en,

  // signals from gem_pclk_syncs for other status
  ext_interrupt_pclk,

  // signals coming from gem_pcs_register.
  pcs_link_state,
  pcs_an_complete,
  np_data_int,
  mac_pause_tx_en,
  mac_pause_rx_en,
  mac_full_duplex,

  // signals going to gem_dma_top.
  tx_dma_descr_base_addr,
  tx_dma_descr_base_par,
  rx_dma_buffer_offset,
  rx_dma_descr_base_addr,
  rx_dma_descr_base_par,
  rx_dma_buffer_size,

  new_receive_q_ptr,
  new_transmit_q_ptr,
  tx_start_pclk,
  tx_halt_pclk,
  flush_rx_pkt_pclk,
  hdr_data_splitting_en,
  inf_last_dbuf_size_en,
  crc_error_report,
  ahb_burst_length,
  endian_swap,

  // signals going to gem_dma_top and gem_mac.
  enable_transmit,
  enable_receive,
  dma_bus_width,

  // signals going to packet buffers
  rx_pbuf_size,
  rx_cutthru_threshold,
  rx_cutthru,
  rx_fill_level_low,
  rx_fill_level_high,
  tx_pbuf_size,
  tx_pbuf_tcp_en,
  tx_cutthru_threshold,
  tx_cutthru,

  // signals going to gem_pcs
  alt_sgmii_mode,
  sgmii_mode,
  uni_direct_en,

  // signals going to gem_mac.
  ign_ipg_rx_er,
  rx_bad_preamble,
  stretch_enable,
  stretch_ratio,
  min_ifg,
  rx_no_crc_check,
  tx_byte_mode,
  retry_test,
  tx_pause_quantum,
  tx_pause_quantum_par,
  tx_pause_quantum_p1,
  tx_pause_quantum_p1_par,
  tx_pause_quantum_p2,
  tx_pause_quantum_p2_par,
  tx_pause_quantum_p3,
  tx_pause_quantum_p3_par,
  tx_pause_quantum_p4,
  tx_pause_quantum_p4_par,
  tx_pause_quantum_p5,
  tx_pause_quantum_p5_par,
  tx_pause_quantum_p6,
  tx_pause_quantum_p6_par,
  tx_pause_quantum_p7,
  tx_pause_quantum_p7_par,
  tx_pause_frame_req,
  tx_pause_frame_zero,
  tx_pfc_frame_req,
  tx_pfc_frame_pri,
  tx_pfc_frame_pri_par,
  tx_pfc_frame_zero,
  tx_lpi_en,
  ifg_eats_qav_credit,
  pause_enable,
  rx_1536_en,
  jumbo_enable,
  force_discard_on_err,
  force_max_ahb_burst_rx,
  force_max_ahb_burst_tx,
  check_rx_length,
  store_udp_offset,
  strip_rx_fcs,
  store_rx_ts,
  tsu_timer_cnt_pclk,
  tsu_timer_cnt_par_pclk,
  tsu_timer_cnt_pclk_vld,
  ptp_unicast_ena,
  rx_ptp_unicast,
  tx_ptp_unicast,
  pfc_enable,

  // signals going to gem_mac (gem_filter).
  back_pressure,
  full_duplex,
  loopback_local,
  en_half_duplex_rx,
  rx_no_pause_frames,
  rx_toe_enable,
  ext_match_en,
  uni_hash_en,
  multi_hash_en,
  no_broadcast,
  copy_all_frames,
  rm_non_vlan,
  hash,
  spec_add_filter_regs,
  spec_add_filter_active,
  spec_add1_tx,
  spec_add1_tx_par,
  mask_add1,
  spec_type1,
  spec_type2,
  spec_type3,
  spec_type4,
  spec_type1_active,
  spec_type2_active,
  spec_type3_active,
  spec_type4_active,
  stacked_vlantype,
  dma_addr_or_mask,

  // match registers for priortiy queues
  screener_type1_regs,
  screener_type2_regs,
  scr2_compare_regs,
  scr2_ethtype_regs,

  wol_ip_addr,
  wol_mask,

  tx_pbuf_segments,
  tx_disable_queue,
  rx_disable_queue,
  // Credit Based Shaping
  cbs_q_a_id,
  cbs_q_b_id,
  cbs_enable,
  idleslope_q_a,
  idleslope_q_b,
  port_tx_rate,
  bw_rate_limit,
  dwrr_ets_control,

  // when software configuration of fifo / dma is available
  // enable ext fifo port
  soft_config_fifo_en,

  //jumbo packet max length
  jumbo_max_length,

  ext_rxq_sel_en,

  // interrupt moderation
  int_moderation,

  tw_sys_tx_time,
  use_aw2b_fill,
  max_num_axi_aw2w,
  max_num_axi_ar2r,

  rsc_en,
  rsc_clr,

  sel_dpram_fill_lvl_dbg,
  dpram_fill_lvl_pclk,
  rx_dpram_fill_lvl_pad_pclk,

  // AXI configuration, soft config to determine the AXI thresholds
  // when the underlying tx dma is full
  axi_tx_full_adj_0,
  axi_tx_full_adj_1,
  axi_tx_full_adj_2,
  axi_tx_full_adj_3,

  restart_counter_top,

  // 64b addressing and extended BD control
  upper_tx_q_base_addr,
  upper_tx_q_base_par,
  upper_rx_q_base_addr,
  upper_rx_q_base_par,
  dma_addr_bus_width,

  tx_bd_extended_mode_en,
  tx_bd_ts_mode,

  rx_bd_extended_mode_en,
  rx_bd_ts_mode,

  sel_mii_on_rgmii,

  // EnST signals
  enst_en,
  start_time,
  on_time,
  off_time,

  // ASF - signals going to fault rpt and log
  asf_dap_paddr_err,
  asf_dap_prdata_err,
  asf_csr_pcs_err,
  asf_csr_mmsl_err,
  asf_dap_pcs_tx_err,
  asf_dap_pcs_rx_err,

  asf_sram_corr_fault,
  asf_sram_corr_fault_stats_upd,
  asf_sram_corr_fault_status,
  asf_sram_uncorr_fault,
  asf_sram_uncorr_fault_status,

  asf_dap_txclk_err_pclk,
  asf_dap_rxclk_err_pclk,
  asf_dap_dma_err_pclk,
  asf_integrity_dma_err_pclk,
  asf_integrity_tsu_err_pclk,
  asf_integrity_tx_sched_err_pclk,
  asf_host_trans_to_err_pclk,
  asf_dap_rdata_err_pclk,

  // ASF - signals from lockup detection
  tx_lockup_detected,
  rx_lockup_detected,
  dma_tx_lockup_detected,
  dma_rx_lockup_detected,

  // ASF - signals going to lockup detection
  tx_lockup_mon_en,
  rx_lockup_mon_en,
  dma_tx_lockup_mon_en,
  dma_rx_lockup_mon_en,
  dma_tx_lockup_q_en,
  lockup_prescale_val,
  dma_lockup_time,
  tx_mac_lockup_time,
  rx_mac_lockup_time,

  // 802.1CB Control and Status
  frer_to_cnt,
  frer_rtag_ethertype,
  frer_strip_rtag,
  frer_6b_tag,
  frer_en_vec_alg,
  frer_use_rtag,
  frer_seqnum_oset,
  frer_seqnum_len,
  frer_scr_sel_1,
  frer_scr_sel_2,
  frer_vec_win_sz,
  frer_en_elim,
  frer_en_to,
  frer_to_pulse,
  frer_rogue_pulse,
  frer_ooo_pulse,
  frer_err_upd_pulse,
  frer_err_upd_val,

  // Rx traffic policing registers
  rx_q_flush,

  // pulse signaling a frame being discarded because
  // of Mode2, 3 or 4 of rx traffic policing
  frame_flushed_pclk,

  // rate limiting registers
  scr2_rate_lim,
  scr_excess_rate_pclk,

  // AXI QoS signalling configuration
  axi_qos_q_mapping,

  // Link Fault Signalling
  link_fault_signal_en,
  link_fault_status_pclk,

  // ASF transaction timeout control
  asf_trans_to_en,
  asf_trans_to_time,

  // ASF comman output error indications
  asf_sram_corr_err,
  asf_sram_uncorr_err,
  asf_dap_err,
  asf_csr_err,
  asf_trans_to_err,
  asf_protocol_err,
  asf_integrity_err,
  // ASF and fatal and non-fatal interrupts
  asf_int_nonfatal,
  asf_int_fatal

);

   parameter [1363:0] grouped_params = {1364{1'b0}};
  `include "ungroup_params.v"

  // system signals.
  input               n_preset;             // amba apb reset.
  input               pclk;                 // amba apb clock.

  // apb interface signals.
  input       [11:2]  paddr;                // address bus of selected master.
  output      [31:0]  prdata;               // apb read data.
  output      [3:0]   prdata_par;           // Parity for prdata
  input       [31:0]  pwdata;               // apb write data.
  input       [3:0]   pwdata_par;           // Parity associated with pwdata
  input               pwrite;               // peripheral write strobe.
  input               penable;              // peripheral enable.
  input               psel;                 // peripheral select for GPIO.
  output              perr;                 // not a standard APB signal, driven
                                            // high when psel is asserted if
                                            // address is not recognized.

  // other top level signals.
  input               mdio_in;              // status of MDIO pin.
  output              mdio_en;              // enable signal for MDIO pin.
  output              mdio_out;             // MDIO pin output.
  output              mdc;                  // management data clock.
  output      [15:0]  ethernet_int;         // ethernet MAC interrupt signal, 1 per queue
  output              loopback;             // external loopback signal to the PHY
  output              half_duplex;          // duplex signal from the network
                                            // configuration register.
  output      [3:0]   speed_mode;           // Indicate speed and interface.

  output      [(p_gem_user_out_width - 1):0]// programmable user outputs
                      user_out;             // to top level
  input       [(p_gem_user_in_width - 1):0] // programmable user inputs
                      user_in;              // from top level

  input               ptp_sync_tx_int;      // PTP sync frame transmit interrupt
  input               ptp_del_tx_int;       // PTP delay_req frame transmit
                                            // interrupt
  input               ptp_pdel_req_tx_int;  // PTP pdelay_req transmit interrupt
  input               ptp_pdel_resp_tx_int; // PTP pdelay_resp frame transmit
                                            // interrupt
  input               ptp_sync_rx_int;      // PTP sync frame receive interrupt
  input               ptp_del_rx_int;       // PTP delay_req frame receive
                                            // interrupt
  input               ptp_pdel_req_rx_int;  // PTP pdelay_req receive interrupt
  input               ptp_pdel_resp_rx_int; // PTP pdelay_resp frame receive
                                            // interrupt
  // signals from gem_pclk_syncs
  input               ptp_tx_time_load;     // load timer value to PTP event
                                            // transmitted register
  input               ptp_rx_time_load;     // load timer value to PTP event
                                            // received register
  input               ptp_tx_ptime_load;    // load timer value to peer event
                                            // transmitted register
  input               ptp_rx_ptime_load;    // load timer value to peer event
                                            // received register
  // signals from/to gem_tsu
  output      [47:0]  tsu_timer_sec;        // TSU registered timer value
                                            // seconds
  output      [29:0]  tsu_timer_nsec;       // TSU registered timer value
                                            // nanoseconds
  output              tsu_timer_sec_wr;     // TSU timer seconds written
  output              tsu_timer_nsec_wr;    // TSU timer nanoseconds written
  output              tsu_timer_adj_wr;     // TSU timer adjust written
  output              tsu_timer_adj_ctrl;   // TSU timer add/subtract adjust
  output      [29:0]  tsu_timer_adj;        // TSU timer adjust
  output      [31:0]  tsu_timer_incr;       // TSU timer increment
  output              tsu_timer_incr_wr;    // TSU timer incr written
  output      [7:0]   tsu_timer_alt_incr;   // TSU timer alternative increment
  output      [7:0]   tsu_timer_num_incr;   // TSU timer number of increments
                                            // alternative increment value used
  output      [21:0]  tsu_timer_nsec_cmp;   // TSU timer comparison nanosecond
                                            // upper 22 bits
  output              tsu_timer_nsec_cmp_wr; // indicates a comparison ns write
  output      [47:0]  tsu_timer_sec_cmp;    // TSU timer comparison second
  input               timer_strobe;         // write timer sync strobe registers
  input       [77:0]  tsu_ptp_tx_timer_in;  // Timestamp sampled on ptp_tx_time_load/ptp_tx_ptime_load
  input       [77:0]  tsu_ptp_rx_timer_in;  // Timestamp sampled on ptp_rx_time_load/ptp_rx_ptime_load
  input       [9:0]   tsu_ptp_tx_timer_par_in;  // parity protection for Timestamp
  input       [9:0]   tsu_ptp_rx_timer_par_in;  // parity protection for Timestamp

  // pclk domain
  output              one_step_sync_mode;   // enable ts insertion into sync frames
  output              oss_correction_field; // enable update of correction field in sync frames
  output              ext_tsu_timer_en;     // select external tsu timer port
  output              store_rx_ts;          // store receive time stamp to memory

  input               tsu_incr_sec_int;     // Timer seconds increment
  input               timer_cmp_val_int;    // TSU timer comparison valid interrut

  // signals from gem_pclk_syncs for tx status & statistics.
  input               tx_ok_pclk;           // pclk pulse for frame txed OK
  input               tx_ok_mod_pclk;       // moderated pclk pulse for frame txed OK
  input               tx_mac_ok_pclk;       // == tx_ok_pclk when not using
                                            // pktbuff. Done this way so that LEC
                                            // proves the old non PBUF versions
                                            // are still equivalent tx_mac_ok_pclk
                                            // is simply a delayed MAC version of
                                            // tx_ok_pclk whilst in pktbuff mode
  input       [13:0]  tx_bytes_pclk;        // Number of bytes in frame txed OK
  input               tx_broadcast_pclk;    // pclk pulse for broadcast txed OK
  input               tx_multicast_pclk;    // pclk pulse for multicast txed OK
  input               tx_single_col_pclk;   // pclk pulse when frame eventually
                                            // txed OK but had a single collision.
  input               tx_multi_col_pclk;    // pclk pulse when frame eventually
                                            // txed OK but had multiple collisions
  input               tx_late_col_pclk;     // pclk pulse on late collision frame.
  input               tx_late_col_mac_pclk; // pclk pulse on late collision frame.
                                            // set to tx_late_col_pclk when not
                                            // using pktbuf
  input               tx_deferred_pclk;     // pclk pulse if frame was deferred.
  input               tx_crs_err_pclk;      // pclk pulse if frame had crs error.
  input               tx_coll_occ_pclk;     // pclk pulse if frame had a collision
  input               tx_toomanyretry_pclk; // pclk pulse if frame had too many
                                            // retries.
  input               tx_pause_zero_pclk;   // pclk pulse when pause timer reaches
                                            // zero or zero pause frame rxed.
  input               tx_pause_ok_pclk;     // pclk pulse for 802.3 pause frame
                                            // txed OK
  input               tx_pfc_pause_ok_pclk; // pclk pulse for PFC pause frame
                                            // txed OK
  input       [15:0]  tx_pause_time_pclk;   // Pause timer value synced to pclk.
  input               tx_underrun_pclk;     // pclk pulse when tx underrun occured
  input               tx_buffers_ex_pclk;   // pclk pulse when tx buffers are
                                            // exhausted.
  input               tx_buff_ex_mid_pclk;  // pclk pulse when tx buffers are
                                            // exhausted mid frame.
  input               tx_hresp_notok_pclk;  // pclk pulse when hresp not OK
                                            // happened during TX DMA.
  input       [(p_edma_queues*32)-1:0]
                      tx_dma_descr_ptr;     // Descriptor queue pointer for debug
  input               tx_go_pclk;           // tx_go from DMA resynced to pclk.

  // signals from gem_pclk_syncs for rx status & statistics.
  input               ok_to_update_rx_stats;// OK to update the stats
  input               rx_ok_pclk;           // pclk pulse for frame rxed OK
  input               rx_ok_mod_pclk;       // moderated pclk pulse for frame rxed OK
  input               rx_mac_ok_pclk;       // == rx_ok_pclk when not using
                                            // pktbuff. Done this way so that LEC
                                            // proves the old non PBUF versions
                                            // are still equivalent tx_mac_ok_pclk
                                            // is simply a delayed MAC version of
                                            // rx_ok_pclk whilst in pktbuff mode
  input       [13:0]  rx_bytes_pclk;        // Number of bytes in frame rxed OK
  input               rx_broadcast_pclk;    // pclk pulse for broadcast rxed OK
  input               rx_multicast_pclk;    // pclk pulse for multicast rxed OK
  input               rx_align_err_pclk;    // pclk pulse when rx frame discarded
                                            // because of an alignment error.
  input               rx_crc_err_pclk;      // pclk pulse when rx frame discarded
                                            // because of a CRC/FCS error.
  input               rx_short_err_pclk;    // pclk pulse when rx frame discarded
                                            // because of a too short error.
  input               rx_long_err_pclk;     // pclk pulse when rx frame discarded
                                            // because of a too long error.
  input               rx_jabber_err_pclk;   // pclk pulse when rx frame discarded
                                            // because of a jabber error.
  input               rx_symbol_err_pclk;   // pclk pulse when rx frame discarded
                                            // because of a symbol error.
  input               rx_pause_ok_pclk;     // pclk pulse for 802.3 or PFC
                                            // pause frame rxed OK.
  input               rx_pause_nz_pclk;     // pclk pulse for 802.3
                                            // pause frame with non-zero quantum
                                            // or any type of PFC pause frame
                                            // rxed OK.
  input               rx_length_err_pclk;   // pclk pulse when rx frame discarded
                                            // because of a length field error.
  input               rx_ip_ck_err_pclk;    // pclk pulse when rx frame discarded
                                            // because of a IP checksum error.
  input               rx_tcp_ck_err_pclk;   // pclk pulse when rx frame discarded
                                            // because of a TCP checksum error.
  input               rx_udp_ck_err_pclk;   // pclk pulse when rx frame discarded
                                            // because of a UDP checksum error.
  input               rx_dma_pkt_flushed_pclk; // pclk pulse when rx frame discarded
                                            // because of a AHB resource error
  input               rx_overflow_pclk;     // pclk pulse when the RX pipeline or
                                            // FIFO overflowed due to bandwidth.
  input               rx_buff_not_rdy_pclk; // pclk pulse when used bit was read
                                            // during RX DMA operation.
  input               rx_resource_err_pclk; // pclk pulse when rx frame discarded
                                            // because a buffer was unavailable.
  input               rx_hresp_notok_pclk;  // pclk pulse when the RX pipeline or
                                            // FIFO overflowed due to bandwidth.
  input       [(p_edma_queues*32)-1:0]
                      rx_dma_descr_ptr;     // Descriptor queue pointer for debug
  input       [3:0]   tx_dma_int_queue;     // Identifies which queue the
  input       [3:0]   rx_dma_int_queue;     // interrupt is destined for
  input               rx_dma_overrun_pclk;  // DMA RX overflow
  input               tx_frame_too_large_pclk; // TX AXI frame too large for SRAM
  input               axi_xaction_out_pclk; // At least one outstanding transaction ...
  input               disable_tx_pclk;      // disable TX due to major error
  input               disable_rx_pclk;      // disable RX due to major error
  input               pfc_negotiate_pclk;   // indicates a negotiated PFC pause frame
  input       [7:0]   rx_pfc_paused_pclk;   // PFC pause indication
  input               lpi_indicate_pclk;    // rx LPI indication has been detected
  input               lpi_indicate_del;     // lpi_indicate_pclk delayed by one pclk
  input               wol_pulse;            // wake on LAN indication pclk synced

  // signals from gem_pclk_syncs for other status
  input               ext_interrupt_pclk;   // pclk pulse indicating a
                                            // rising edge on ext interrupt pin.

  // signals coming from gem_pcs_register.
  input               pcs_link_state;       // current link state of PCS
  input               pcs_an_complete;      // PCS autonegotiation complete
  input               np_data_int;          // Next page data required
  input               mac_pause_tx_en;      // negotiated pause tx
  input               mac_pause_rx_en;      // negotiated pause rx
  input               mac_full_duplex;      // negotiated duplex mode

  // signals going to gem_dma_top.
  output      [(p_edma_queues*32)-1:0]
                      tx_dma_descr_base_addr; // A concatenated list of all q pointers
                                            // In basic verilog it's not possibleto use
                                            // a two dimensional array at an IO so we
                                            // concatenate the internal array.
                                            // queue pointer list.
  output      [(p_edma_queues*4)-1:0]
                      tx_dma_descr_base_par;  // Parity
  output      [(p_edma_queues*32)-1:0]
                      rx_dma_descr_base_addr; // base position of the receive buffer queue pointer list.
  output      [(p_edma_queues*4)-1:0]
                      rx_dma_descr_base_par;  // Parity
  output      [(p_edma_queues*8)-1:0]
                      rx_dma_buffer_size;   // RX DMA buffer sizes
  output      [1:0]   rx_dma_buffer_offset; // byte offset of receive buffer from
                                            // buffer descriptor pointer.
  output              new_receive_q_ptr;    // asserted when receive queue pointer
                                            // is written.
  output              new_transmit_q_ptr;   // asserted when tx queue pointer
                                            // is written.
  output              tx_start_pclk;        // asserted when bit 9 of network
                                            // control register is written.
  output              tx_halt_pclk;         // asserted when bit 10 of network
                                            // control register is written.
  output              flush_rx_pkt_pclk;    // asserted when bit 18 of network
                                            // control register is written.
  output              hdr_data_splitting_en;// Header Data Splitting enable
  output              inf_last_dbuf_size_en;// data buffer pointed to by last descriptor is infinite size
  output              crc_error_report;     // Jumbo Length Reporting
  output      [4:0]   ahb_burst_length;     // AHB burst length control
  output      [1:0]   endian_swap;          // Endian swap enable

  //signals going to gem_dma_top and gem_mac.
  output              enable_transmit;      // transmit enable signal from network
                                            // control register.
  output              enable_receive;       // receive enable signal from network
                                            // control register.
  output      [1:0]   dma_bus_width;        // encoding for DMA bus width.

  // signals going to packet buffers
  output      [1:0]   rx_pbuf_size;         // Programmed size of RX DPRAM
  output      [p_edma_rx_pbuf_addr-1:0]
                      rx_cutthru_threshold; // Threshold value
  output              rx_cutthru;           // Enable for cut-thru operation
  output              rx_fill_level_low;    // watermark for transmitting zero pause frame
  output              rx_fill_level_high;   // watermark for transmitting non-zero pause frame
  output              tx_pbuf_size;         // Programmed size of TX DPRAM
  output              tx_pbuf_tcp_en;       // TCP TX checksum offload enable
  output      [p_edma_tx_pbuf_addr-1:0]
                      tx_cutthru_threshold; // Threshold value
  output              tx_cutthru;           // Enable for cut-thru operation

  //signals going to gem_pcs
  output              alt_sgmii_mode;       // alternative tx config for SGMII
  output              sgmii_mode;           // PCS is configured for SGMII
  output              uni_direct_en;        // when set PCS transmits data rather
                                            // than idle when rx link is down

  //signals going to gem_mac
  output              back_pressure;        // goes to tx block to force
                                            // collisions on all incoming frames
  output              ign_ipg_rx_er;        // ignore rx_er when rx_dv is low
  output              rx_bad_preamble;      // enables reception of frames with
                                            // bad preamble
  output              stretch_enable;       // enables IPG stretching
  output  reg [15:0]  stretch_ratio;        // determines how to stretch the IPG
  output       [3:0]  min_ifg;              // minimum transmit IFG divided by four
  output              rx_no_crc_check;      // disables crc checking on receive
  output              tx_byte_mode;         // gem_tx transmits bytes not nibbles
  output              retry_test;           // goes to tx block must be set to
                                            // zero for normal operation.
  output  reg [15:0]  tx_pause_quantum;     // tx_pause_quantum for pause tx for priority 0.
  output      [1:0]   tx_pause_quantum_par; // Optional parity
  output      [15:0]  tx_pause_quantum_p1;  // tx_pause_quantum for pause tx for priority 1.
  output      [1:0]   tx_pause_quantum_p1_par;
  output      [15:0]  tx_pause_quantum_p2;  // tx_pause_quantum for pause tx for priority 2.
  output      [1:0]   tx_pause_quantum_p2_par;
  output      [15:0]  tx_pause_quantum_p3;  // tx_pause_quantum for pause tx for priority 3.
  output      [1:0]   tx_pause_quantum_p3_par;
  output      [15:0]  tx_pause_quantum_p4;  // tx_pause_quantum for pause tx for priority 4.
  output      [1:0]   tx_pause_quantum_p4_par;
  output      [15:0]  tx_pause_quantum_p5;  // tx_pause_quantum for pause tx for priority 5.
  output      [1:0]   tx_pause_quantum_p5_par;
  output      [15:0]  tx_pause_quantum_p6;  // tx_pause_quantum for pause tx for priority 6.
  output      [1:0]   tx_pause_quantum_p6_par;
  output      [15:0]  tx_pause_quantum_p7;  // tx_pause_quantum for pause tx for priority 7.
  output      [1:0]   tx_pause_quantum_p7_par;
  output              tx_pause_frame_req;   // toggles for transmission of a
                                            // non-zero 802.3 pause frame
  output              tx_pause_frame_zero;  // toggles for transmission of a
                                            // zero 802.3 pause frame
  output              tx_pfc_frame_req;     // toggles for transmission of PFC
                                            // pause frame
  output      [7:0]   tx_pfc_frame_pri;     // PFC pause frame priority enable
                                            // vector.
  output              tx_pfc_frame_pri_par; // Optional parity
  output      [7:0]   tx_pfc_frame_zero;    // use zero quantum in tx
                                            // PFC pause frame.
  output              tx_lpi_en;            // enables transmission of LPI
  output              ifg_eats_qav_credit;  // modifies CBS algorithm so IFG/IPG uses Qav credit
  output              pause_enable;         // stops tx when pause time non-zero.
  output              rx_1536_en;           // goes to rx block to enable
                                            // reception of 1536 byte frames.
  output              jumbo_enable;         // enable jumbo frames.
  output              check_rx_length;      // enables rx length field checking.
  output              strip_rx_fcs;         // stops rx fcs/crc being copied.
  output              store_udp_offset;     // store tcp/udp offset to memory
  input       [77:0]  tsu_timer_cnt_pclk;   // TSU timer count value, pclk timed
  input       [9:0]   tsu_timer_cnt_par_pclk; // Parity
  input               tsu_timer_cnt_pclk_vld; // TSU timer count value, valid
  output              pfc_enable;           // PFC pause frame receive enable
  output              ptp_unicast_ena;      // enable PTPv2 IPv4 unicast IP DA
                                            // detection
  output  reg [31:0]  rx_ptp_unicast;       // rx PTPv2 IPv4 unicast IP DA
  output  reg [31:0]  tx_ptp_unicast;       // tx PTPv2 IPv4 unicast IP DA

  // signals going to gem_dma_top (gem_filter).
  output              full_duplex;          // duplex signal from the network
                                            // configuration register.
  output              loopback_local;       // internal loopback signal.
  output              en_half_duplex_rx;    // enable receiving of frames whilst
                                            // transmiting in half duplex.
  output              rx_no_pause_frames;   // don't copy any pause frames.
  output              rx_toe_enable;        // Enable RX TCP Offload Engine.
  output              ext_match_en;         // external address match enable from
                                            // the network config register.
  output              uni_hash_en;          // unicast hash enable from the
                                            // network configuration register.
  output              multi_hash_en;        // multicast hash enable signal from
                                            // the network configuration register.
  output              no_broadcast;         // signal to disable recption of
                                            // broadcast frames from the network
                                            // configuration register.
  output              copy_all_frames;      // copy all frames signal from the
                                            // network configuration register.
  output              rm_non_vlan;          // Discard non-VLAN frames
  output      [63:0]  hash;                 // hash register for destination
                                            // address filtering.
  output      [55*(p_num_spec_add_filters+1)-1:0]
                      spec_add_filter_regs; // specific address filters
  output      [p_num_spec_add_filters:0]
                      spec_add_filter_active; // specific address filter active
  output      [47:0]  spec_add1_tx;         // Source address for TX Pause transmit
  output      [5:0]   spec_add1_tx_par;     // Parity
  output      [47:0]  mask_add1;            // specific address 1 mask for
                                            // destination address comparison.

  output      [15:0]  spec_type1;           // specific type 1 for type comparison
  output      [15:0]  spec_type2;           // specific type 2 for type comparison
  output      [15:0]  spec_type3;           // specific type 3 for type comparison
  output      [15:0]  spec_type4;           // specific type 4 for type comparison
  output              spec_type1_active;    // spec_type1 can be used for type
                                            // comparison.
  output              spec_type2_active;    // spec_type2 can be used for type
                                            // comparison.
  output              spec_type3_active;    // spec_type3 can be used for type
                                            // comparison.
  output              spec_type4_active;    // spec_type4 can be used for type
                                            // comparison.
  output  reg [16:0]  stacked_vlantype;     // VLAN tag TPID (bit 16 enables
                                            // stacked VLAN tag support)
  output      [15:0]  wol_ip_addr;          // lower bits of IP address for WoL
  output      [3:0]   wol_mask;             // Wake-onLAN enable mask
  output      [47:0]  tx_pbuf_segments;     // Segment allocations for TX
  output      [p_edma_queues-1:0]
                      tx_disable_queue;
  output      [p_edma_queues-1:0]
                      rx_disable_queue;
  output      [8:0]   dma_addr_or_mask;     // OR mask used for data-buffers

  output      [(32*p_num_type1_screeners):0]
                      screener_type1_regs;
  output      [(32*p_num_type2_screeners):0]
                      screener_type2_regs;
  output      [(43*p_num_scr2_compare_regs):0]
                      scr2_compare_regs;
  output      [(16*p_num_scr2_ethtype_regs):0]
                      scr2_ethtype_regs;

  output              force_discard_on_err; // Force packets to be discarded from
                                            // PBUF after AHB error
  output              force_max_ahb_burst_rx; // Force AHB  to always burst at max
  output              force_max_ahb_burst_tx; // Force AHB  to always burst at max

  // Credit Based Shaping support
  output      [3:0]   cbs_q_a_id;           // Dynamic indication of top enabled queue
  output      [3:0]   cbs_q_b_id;           // Dynamic indication of top enabled queue
  output      [1:0]   cbs_enable;           // Enable for CBS queues
  output      [31:0]  idleslope_q_a;        // Rate of Change of credit for Queue A
  output      [31:0]  idleslope_q_b;        // Rate of Change of credit for Queue B
  output      [31:0]  port_tx_rate;         // TX rate for CBS
  output      [31:0]  dwrr_ets_control;
  output      [127:0] bw_rate_limit;

  //jumbo packet max length
  output  reg [13:0]  jumbo_max_length;     // programmable max length

  output              ext_rxq_sel_en;       // enable external receive queue selection

  // interrupt moderation
  output      [31:0]  int_moderation;       // interrupt moderation register value

  output  reg [15:0]  tw_sys_tx_time;       // system wake time after tx LPI stops

  // when software configuration of fifo / dma is available enable ext fifo port
  output  reg         soft_config_fifo_en;  // use ext fifo port

  output      [7:0]   max_num_axi_aw2w;
  output      [7:0]   max_num_axi_ar2r;
  output              use_aw2b_fill;

  output      [14:0]  rsc_en;
  input       [p_edma_queues-1:0]
                      rsc_clr;              // Receive Side Coalescing clear


  // 64b addressing support and extended BD from reg_top
  output      [31:0]  upper_tx_q_base_addr; // upper 32b base address for tx buffer descriptors
  output      [3:0]   upper_tx_q_base_par;
  output      [31:0]  upper_rx_q_base_addr; // upper 32b base address for rx buffer descriptors
  output      [3:0]   upper_rx_q_base_par;
  output              dma_addr_bus_width;

  output              tx_bd_extended_mode_en;
  output      [1:0]   tx_bd_ts_mode;

  output              rx_bd_extended_mode_en;
  output      [1:0]   rx_bd_ts_mode;

  output              sel_mii_on_rgmii;     // reconfigures RGMII interface for MII operation

  output      [4:0]   sel_dpram_fill_lvl_dbg;
  input       [15:0]  dpram_fill_lvl_pclk;
  input       [15:0]  rx_dpram_fill_lvl_pad_pclk; // receive fill level

  output      [p_edma_tx_pbuf_addr-1:0]
                      axi_tx_full_adj_0;
  output      [p_edma_tx_pbuf_addr-1:0]
                      axi_tx_full_adj_1;
  output      [p_edma_tx_pbuf_addr-1:0]
                      axi_tx_full_adj_2;
  output      [p_edma_tx_pbuf_addr-1:0]
                      axi_tx_full_adj_3;

  output      [3:0]   restart_counter_top;

  // EnST signals
  output      [7:0]   enst_en;              // Disable/Enable vector
  output      [255:0] start_time;           // start_time of the transmission
  output      [135:0] on_time;              // on_time of the transmission expressed in bytes
  output      [135:0] off_time;             // off_time of the transmission expressed in bytes


  // Link Fault Signalling
  input               link_fault_signal_en; // 802.3cb link fault signalling enabled
  input        [1:0]  link_fault_status_pclk;  // 00 - OK; 01 - local fault; 10 - remote fault; 11 - link interruption

  // ASF external status inputs
  input               asf_dap_paddr_err;    // Parity check error on paddr
  input               asf_dap_prdata_err;   // Parity check error on prdata
  input               asf_csr_pcs_err;      // There was a parity error in PCS reg
  input               asf_csr_mmsl_err;     // There was a parity error in MMSL reg
  input               asf_dap_pcs_tx_err;   // Fault in PCS TX datapath
  input               asf_dap_pcs_rx_err;   // Fault in PCS RX datapath

  // ASF -  SRAM protection
  input               asf_sram_corr_fault;
  input       [7:0]   asf_sram_corr_fault_stats_upd;
  input       [31:0]  asf_sram_corr_fault_status;
  input               asf_sram_uncorr_fault;
  input       [31:0]  asf_sram_uncorr_fault_status;

  input               asf_dap_txclk_err_pclk;     // Parity error in TX domain
  input               asf_dap_rxclk_err_pclk;     // Parity error in RX domain
  input               asf_dap_dma_err_pclk;       // Parity error in DMA domain
  input               asf_integrity_dma_err_pclk; // DMA integrity error
  input               asf_integrity_tsu_err_pclk; // Time Stamp Unit error
  input               asf_integrity_tx_sched_err_pclk; // Transmit Scheduling error
  input               asf_host_trans_to_err_pclk; // Host transaction timeout (AXI/AHB)
  input               asf_dap_rdata_err_pclk;     // AXI rdata parity error

  // ASF - signals from lockup detection
  input               tx_lockup_detected;       // TX lockup detection
  input               rx_lockup_detected;       // RX lockup detection
  input               dma_tx_lockup_detected;   // TX lockup detection
  input               dma_rx_lockup_detected;   // RX lockup detection

  // signals going to lockup detection
  output  reg         tx_lockup_mon_en;         // Enable the TX lockup detector
  output  reg         rx_lockup_mon_en;         // Enable the RX lockup detector
  output              dma_tx_lockup_mon_en;     // Enable the TX lockup detector
  output              dma_rx_lockup_mon_en;     // Enable the RX lockup detector
  output      [p_edma_queues-1:0]
                      dma_tx_lockup_q_en;       // Queue specific enable of timer
  output  reg [15:0]  lockup_prescale_val;      // Prescaler reset value
  output      [10:0]  dma_lockup_time;          // DMA lockup time
  output  reg [10:0]  tx_mac_lockup_time;       // MAC TX lockup time
  output  reg [15:0]  rx_mac_lockup_time;       // MAC RX lockup time

  // 802.1CB control and status
  output      [15:0]  frer_to_cnt;              // Count of number of frer_to_cnt_tog
                                                // without passing frames before timeout
  output      [15:0]  frer_rtag_ethertype;      // Ethertype for redundancy tag detect
  output              frer_strip_rtag;          // Strip redundancy tags
  output              frer_6b_tag;              // R-Tag is 6 bytes
  output      [p_gem_num_cb_streams-1:0]
                      frer_en_vec_alg;          // Select which algorithm to use.
  output      [p_gem_num_cb_streams-1:0]
                      frer_use_rtag;            // Set to use RTag or offset for seqnum
  output      [(p_gem_num_cb_streams*9)-1:0]
                      frer_seqnum_oset;         // Offset into frame for seqnum
  output      [(p_gem_num_cb_streams*5)-1:0]
                      frer_seqnum_len;          // Number of bits of seqnum to use
  output      [(p_gem_num_cb_streams*4)-1:0]
                      frer_scr_sel_1;           // Screener match for stream 1
  output      [(p_gem_num_cb_streams*4)-1:0]
                      frer_scr_sel_2;           // Screener match for stream 2
  output      [(p_gem_num_cb_streams*6)-1:0]
                      frer_vec_win_sz;          // History depth to use for vec rcv alg
  output      [p_gem_num_cb_streams-1:0]
                      frer_en_elim;             // Enable 802.1CB elimination function
  output      [p_gem_num_cb_streams-1:0]
                      frer_en_to;               // Enable 802.1CB timeout function
  input       [p_gem_num_cb_streams-1:0]
                      frer_to_pulse;            // indicate timeout occurred
  input       [p_gem_num_cb_streams-1:0]
                      frer_rogue_pulse;         // indicate rogue frame rcvd
  input       [p_gem_num_cb_streams-1:0]
                      frer_ooo_pulse;           // indicate out of order frame
  input       [p_gem_num_cb_streams-1:0]
                      frer_err_upd_pulse;       // enable update of latent errors
  input       [(p_gem_num_cb_streams*7)-1:0]
                      frer_err_upd_val;         // Incrememt value, use with above

  output      [(32*p_edma_queues)-1:0]
                      rx_q_flush;               // RX traffic policing registers

  input               frame_flushed_pclk;       // pulse signalling a frame being dropped
                                                // due to a limit breach in rx traffic policing
                                                // in Mode2, 3 or 4
  output      [(32*p_num_type2_screeners):0]    // rate limiting algorithm registers
                      scr2_rate_lim;

  input       [p_num_type2_screeners:0]         // per scr2 rate limiting stats
                      scr_excess_rate_pclk;

  // AXI QoS signalling configuration
  output      [(8*p_edma_queues)-1:0]
                      axi_qos_q_mapping;        // QoS config for each queue.

  // ASF configuration
  output              asf_trans_to_en;
  output      [15:0]  asf_trans_to_time;

  // ASF comman output error indications
  output              asf_sram_corr_err;        // SRAM correctable error indication
  output              asf_sram_uncorr_err;      // SRAM uncorrectable error indication
  output              asf_dap_err;              // Data and Address Paths error indication
  output              asf_csr_err;              // Configuration and Status Registers error indication
  output              asf_trans_to_err;         // Transaction Timeouts indication
  output              asf_protocol_err;         // Protocol error indication
  output              asf_integrity_err;        // Integrity error indication

  // ASF and fatal and non-fatal interrupts
  output              asf_int_nonfatal;         // ASF non-fatal interrupt
  output              asf_int_fatal;            // ASF fatal interrupt

// -----------------------------------------------------------------------------
//  wire and reg declarations
// -----------------------------------------------------------------------------

  parameter p_network_config_rst_val  = {9'h000,p_edma_dma_bus_width_def,
                                          p_edma_mdc_clock_div,18'h00000};

  // APB interface timing and decoding
  wire  [11:0]  i_paddr;                // internal APB address bus, with
                                        // bottom two bits zeroed to ease
                                        // comparison logic.
  wire          write_registers;        // write to apb registers.
  wire          read_registers;         // read from apb registers.

  wire  [31:0]  prdata_int;             // OR of all prdata
  reg   [31:0]  prdata_i;               // Registered apb read data.
  reg   [31:0]  prdata_i_nq;            // apb read data with queue priority
  reg           perr_nq;                // perr for non-queue priority access
  wire  [31:0]  prdata_stats;           // APB read data from statistics
  wire          perr_stats;
  wire  [31:0]  prdata_cb;              // Combined read data from 802.1CB
  wire          perr_cb;                // Perr status from 802.1CB
  wire  [31:0]  prdata_scrn;            // Combined read data from screeners
  wire          perr_scrn;              // Perr status from screeners
  wire  [31:0]  prdata_enst;            // QBV
  wire          perr_enst;
  wire  [31:0]  prdata_tsu;             // TSU
  wire          perr_tsu;
  wire  [31:0]  prdata_phy_man;         // PHY management
  wire          perr_phy_man;
  wire  [31:0]  prdata_filters;         // Address filtering
  wire          perr_filters;
  wire  [31:0]  prdata_sched;           // Scheduling related
  wire          perr_sched;
  wire  [31:0]  prdata_ints;            // Interrupts and status
  wire          perr_ints;
  wire  [31:0]  prdata_dma;             // DMA specific registers
  wire          perr_dma;
  wire  [31:0]  prdata_asf;             // ASF fault reporting and logging moudle specific
  wire          perr_asf;
  wire  [31:0]  prdata_rx_q_flush;      // per-queue rx flush specific registers
  wire          perr_rx_q_flush;


  // ASF interface timing and decoding
  wire          asf_err;                // error from ASF fault reporting and logging
  wire  [6:0]   i_paddr_asf;            // ASF address bus, with bottom two bits zeroed
  wire          i_sel_asf;              // Select (read/write) ASF fault logging and reporting module
  reg           i_sel_not_asf;          // ASF fault logging and reporting not selected
  wire  [11:0]  asf_base_addr;          // The base address of the ASF registers
  wire          asf_dap_fault;          // OR all data and address path fault singal indications
  wire          asf_integrity_fault;    // OR all integrity fault sources
  wire  [4:0]   asf_trans_to_fault;     // Collection of transaction timeout fault sources
  wire  [21:0]  asf_protocol_fault;     // Collection of internal existing faults.

  // Network control register
  wire  [31:0]  network_control;        // Network control register
  wire          man_port_en;            // management port enable
  wire          stats_write_en;         // allow writing to stats registers
  wire          stats_read_snap;        // read snapshot image instead of
                                        // statistic register.
  wire          stats_take_snap;        // take snapshot of registers
  wire          clear_all_stats_regs;   // reset all statistic registers.
  wire          inc_all_stats_regs;     // increment all statistic register.

  // Network configuration register
  reg   [31:0]  network_config;         // Network Configuration register
  wire          speed;                  // Indicate 10M or 100M.
  wire          gigabit;                // high for gigabit operation.
  wire          tbi;                    // high when Ten Bit Interface is
                                        // selected.
  wire  [2:0]   mdc_clock_div;          // clock division for MDC from PCLK

  wire  [31:0]  network_status;         // Network status register

  wire          man_done;               // PhY management transfer complete, a
                                        // bit in the network status register.
  reg   [19:0]  wol_reg;                // Wake on Lan register

  // Additional pause quantum registers for one quantum per priority pause
  wire          pfc_ctrl;               // enable pfc multiple pause quantums
  wire  [15:0]  tx_pause_quantum_p1_rd; // tx_pause_quantum for pause tx for priority 1
  wire  [15:0]  tx_pause_quantum_p2_rd; // tx_pause_quantum for pause tx for priority 2
  wire  [15:0]  tx_pause_quantum_p3_rd; // tx_pause_quantum for pause tx for priority 3
  wire  [15:0]  tx_pause_quantum_p4_rd; // tx_pause_quantum for pause tx for priority 4
  wire  [15:0]  tx_pause_quantum_p5_rd; // tx_pause_quantum for pause tx for priority 5
  wire  [15:0]  tx_pause_quantum_p6_rd; // tx_pause_quantum for pause tx for priority 6
  wire  [15:0]  tx_pause_quantum_p7_rd; // tx_pause_quantum for pause tx for priority 7

  // Design configuration debug data for software to read
  wire  [31:0]  gem_designcfg_debug1;
  wire  [31:0]  gem_designcfg_debug2;
  wire  [31:0]  gem_designcfg_debug3;
  wire  [31:0]  gem_designcfg_debug4;
  wire  [31:0]  gem_designcfg_debug5;
  wire  [31:0]  gem_designcfg_debug6;
  wire  [31:0]  gem_designcfg_debug7;
  wire  [31:0]  gem_designcfg_debug8;
  wire  [31:0]  gem_designcfg_debug9;
  wire  [31:0]  gem_designcfg_debug10;
  wire  [31:0]  gem_designcfg_debug11;
  wire  [31:0]  gem_designcfg_debug12;
  wire          gem_dma_addr_width_is_64b;

  // TX PFC pause register
  reg   [15:0]  tx_pfc_pause_reg;   // Transmit PFC pause register
  wire  [7:0]   tx_pfc_frame_zero;  // zero or non-zero PFC pause frame
  wire          two_pt_five_gig;    // indicates 2.5G operation

  wire  [15:0]  tx_disable_q_pad;   // Pad for up to 16 queues
  wire  [15:0]  rx_disable_q_pad;

  wire  [15:0]  user_in_rd;         // Padded GPIO register read
  wire  [15:0]  user_out_rd;        // Padded GPIO register out

  // Lockup detect configuration
  reg           lockup_recovery_en; // Enable the Lockup Recovery

  wire          asf_dap_pwdata_err; // Error on pwdata input
  wire          asf_dap_prdata_err; // Error on prdata output
  wire          tsu_par_err;        // Parity protection fault detection
  wire          asf_dap_tsu_err;    // TSU datapath parity fault detection
  wire          scrn_par_err;       // Parity protection fault detection
  wire          sched_par_err;      // Parity protection fault detection
  wire          filt_par_err;       // Parity protection fault detection
  wire          enst_par_err;       // Parity protection fault detection
  wire          rx_q_flush_par_err; // Parity protection fault detection
  wire          dma_par_err;        // Parity protection fault detection
  wire          cb_par_err;         // Parity protection fault detection
  wire          int_sts_dplc_err;   // Compare error of interrupt status module
  wire          nwc_dplc_err;       // Compare error of network control register
  wire          phy_man_dplc_err;   // Compare error of PHY management module
  wire          pause_par_err;      // Parity error in pause registers
  wire          csr_parity_fault;   // Combined error in config/control or status regs

  wire    [3:0] min_ifg;            // minimum transmit IFG divided by four
  reg     [3:0] min_ipg;            // introduced in r1p12f7 to allow min ipg of 12 to 60 bytes
  reg           ifg_32;             // introduced in r1p12f6 to set min ipg of 32 bytes
  reg           ifg_24;             // introduced in r1p12f6 to set min ipg of 24 bytes

  // -----------------------------------------------------------------------------
  //  Beginning of main code.
  // -----------------------------------------------------------------------------

  // Derive min_ifg to send to gem_tx module, if min_ipg is non-zero it takes precedence over ifg_24 and ifg_32
  assign min_ifg = (ifg_32 && (min_ipg == 4'h0)) ? 4'd8 :    // multiply min_ifg by 4 to get min IPG in bytes
                   (ifg_24 && (min_ipg == 4'h0)) ? 4'd6 :
                   (min_ipg > 4'h3)              ? min_ipg : // range 3 to 15 (equivalent to 16 to 60 bytes in increments of 4)
                                                   4'd3;     // default to 12 bytes

  // Internal APB address bus, with bottom two bits zeroed to ease
  // comparison logic.
  assign i_paddr[11:0] = {paddr[11:2], 2'b00};

  // AMBA 1.0 is no longer supported.

  // For AMBA 2.0 write_registers will be active in the middle of a cycle
  assign write_registers      =  pwrite & ~penable & psel;

  // read_registers indicates register read. Used to clear some regs
  // For AMBA 2.0 read_registers will be active at the end of a cycle
  assign read_registers       = ~pwrite & ~penable & psel;


  // Instantiate design configuration debug module.
  gem_reg_designcfg_dbg #(
    .grouped_params(grouped_params)
  ) i_designcfg_dbg (
    .gem_designcfg_debug1 (gem_designcfg_debug1),
    .gem_designcfg_debug2 (gem_designcfg_debug2),
    .gem_designcfg_debug3 (gem_designcfg_debug3),
    .gem_designcfg_debug4 (gem_designcfg_debug4),
    .gem_designcfg_debug5 (gem_designcfg_debug5),
    .gem_designcfg_debug6 (gem_designcfg_debug6),
    .gem_designcfg_debug7 (gem_designcfg_debug7),
    .gem_designcfg_debug8 (gem_designcfg_debug8),
    .gem_designcfg_debug9 (gem_designcfg_debug9),
    .gem_designcfg_debug10(gem_designcfg_debug10),
    .gem_designcfg_debug11(gem_designcfg_debug11),
    .gem_designcfg_debug12(gem_designcfg_debug12)
  );
  assign gem_dma_addr_width_is_64b  = gem_designcfg_debug6[23] && p_edma_ext_fifo_interface == 1'b0;


// -----------------------------------------------------------------------------
//  APB register writes:
// -----------------------------------------------------------------------------
//  Write logic for following registers:
//     -network control & configuration
//         (plus decodes for tx_go, tx_halt, clear_all_stats_regs and
//          inc_all_stats_regs)
//     -user I/O register
//     -receive & transmit queue pointers registers (plus new pntr indication)
//     -interrupt enable, disable and mask registers
//     -transmit pause quantum register
//     -hash registers (top & bottom)
//     -specific address and type registers
//     -AHB burst length register
//     -Packet buffer registers
// -----------------------------------------------------------------------------
  always @(posedge pclk or negedge n_preset)
  begin : p_write_register //begin p_write_register
    if (~n_preset)
    begin
      network_config        <= p_network_config_rst_val;
      rx_ptp_unicast        <= 32'h00000000;
      tx_ptp_unicast        <= 32'h00000000;
      tx_pause_quantum      <= 16'hffff;
      stacked_vlantype      <= 17'h00000;
      wol_reg               <= 20'h00000;
      stretch_ratio         <= 16'h0000;
      min_ipg               <= 4'h0;
      ifg_24                <= 1'b0;
      ifg_32                <= 1'b0;
      tx_pfc_pause_reg      <= 16'h0000;
      jumbo_max_length      <= p_edma_jumbo_max_length;
      tw_sys_tx_time        <= 16'h0000;
      soft_config_fifo_en   <= 1'b0;
      tx_lockup_mon_en      <= 1'b0;
      rx_lockup_mon_en      <= 1'b0;
      lockup_recovery_en    <= 1'b0;
      lockup_prescale_val   <= {16{1'b1}};
      tx_mac_lockup_time    <= {11{1'b1}};
      rx_mac_lockup_time    <= {16{1'b1}};
    end
    else
    begin
      if (write_registers) // begin if (write_registers)
      begin
        case (i_paddr)
          `gem_network_config       : network_config      <= pwdata;
          `gem_tx_pause_quantum     : tx_pause_quantum    <= pwdata[15:0];
          `gem_wol_register         : wol_reg             <= pwdata[19:0];
          `gem_stretch_ratio        :
            begin
              ifg_24              <= pwdata[31];
              ifg_32              <= pwdata[30];
              min_ipg             <= pwdata[19:16];
              stretch_ratio       <= pwdata[15:0];
            end
          `gem_stacked_vlan         : stacked_vlantype    <= {pwdata[31],pwdata[15:0]};
          `gem_tx_pfc_pause         : tx_pfc_pause_reg    <= pwdata[15:0];
          `gem_rx_ptp_unicast       : rx_ptp_unicast      <= pwdata;
          `gem_tx_ptp_unicast       : tx_ptp_unicast      <= pwdata;
          `gem_soft_conf_ctrl       : soft_config_fifo_en <= pwdata[0] & (p_edma_host_if_soft_select == 1);
          `gem_jumbo_max_length_ad  : jumbo_max_length    <= pwdata[13:0];
          `gem_sys_wake_time        : tw_sys_tx_time      <= pwdata[15:0];
          `gem_lockup_config        :
            begin
              tx_lockup_mon_en    <= pwdata[30];
              rx_lockup_mon_en    <= pwdata[28];
              lockup_recovery_en  <= pwdata[27];
              lockup_prescale_val <= pwdata[15:0];
            end
          `gem_lockup_config2       :
            begin
              tx_mac_lockup_time  <= pwdata[26:16];
              rx_mac_lockup_time  <= pwdata[15:0];
            end
          default : ;
        endcase // case(i_paddr).
      end // end - if(write_registers)
    end //end - if not reset
  end // end - p_write_register.

  assign wol_ip_addr          = wol_reg[15:0];
  assign wol_mask             = wol_reg[19:16];

  wire  [31:0]  dma_tx_lockup_q_en_int; // Internal padded value written by APB
  wire  [31:0]  dma_tx_lockup_q_en_rd;  // Gated based on number of queues

  // Registers for packet buffer DMA specific lockup detect configuration
  generate if (p_edma_tx_pkt_buffer == 1) begin : gen_lockup_cfg_pbuf
    reg         dma_tx_lockup_mon_en_r;
    reg         dma_rx_lockup_mon_en_r;
    reg [10:0]  dma_lockup_time_r;

    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
      begin
        dma_tx_lockup_mon_en_r  <= 1'b0;
        dma_rx_lockup_mon_en_r  <= 1'b0;
        dma_lockup_time_r       <= {11{1'b1}};
      end
      else
        if (write_registers & (i_paddr == `gem_lockup_config))
        begin
          dma_tx_lockup_mon_en_r  <= pwdata[31];
          dma_rx_lockup_mon_en_r  <= pwdata[29];
          dma_lockup_time_r       <= pwdata[26:16];
        end
    end

    if (p_edma_asf_csr_prot == 1'b1) begin : gen_tx_q_en_full
      reg [15:0]  dma_tx_lockup_q_en_r;
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          dma_tx_lockup_q_en_r  <= 16'h0000;
        else
          if (write_registers & (i_paddr == `gem_lockup_config3))
            dma_tx_lockup_q_en_r  <= pwdata[15:0];
      end
      assign dma_tx_lockup_q_en_int = {16'd0,dma_tx_lockup_q_en_r};
    end else begin : gen_tx_q_en_min
      reg [p_edma_queues-1:0] dma_tx_lockup_q_en_r;
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          dma_tx_lockup_q_en_r  <= {p_edma_queues{1'b0}};
        else
          if (write_registers & (i_paddr == `gem_lockup_config3))
            dma_tx_lockup_q_en_r  <= pwdata[p_edma_queues-1:0];
      end
      assign dma_tx_lockup_q_en_int = {{(32-p_edma_queues){1'b0}},dma_tx_lockup_q_en_r};
    end

    assign dma_tx_lockup_mon_en   = dma_tx_lockup_mon_en_r;
    assign dma_rx_lockup_mon_en   = dma_rx_lockup_mon_en_r;
    assign dma_lockup_time        = dma_lockup_time_r;
  end else begin : gen_no_lockup_cfg_pbuf
    assign dma_tx_lockup_mon_en   = 1'b0;
    assign dma_rx_lockup_mon_en   = 1'b0;
    assign dma_lockup_time        = {11{1'b0}};
    assign dma_tx_lockup_q_en_int = 32'd0;
  end
  endgenerate

  genvar loop_q;
  generate for (loop_q = 0; loop_q < 32; loop_q = loop_q + 1) begin : gen_lockup_q_gate
    if (loop_q < p_edma_queues) begin : gen_q_exists
      assign dma_tx_lockup_q_en_rd[loop_q]  = dma_tx_lockup_q_en_int[loop_q];
    end else begin : gen_no_q_exists
      assign dma_tx_lockup_q_en_rd[loop_q]  = 1'b0;
    end
  end
  endgenerate
  assign dma_tx_lockup_q_en = dma_tx_lockup_q_en_rd[p_edma_queues-1:0];

  // GPIO only if defined
  // Note that this is not protected.
  generate if (p_gem_user_io == 1) begin : gen_user_io
    genvar  loop_io;

    // The IN and OUT can be up to 16-bits wide each. Loop through and pad
    // appropriately.
    for (loop_io = 0; loop_io<16; loop_io = loop_io + 1) begin : gen_loop_io
      if (loop_io < p_gem_user_in_width) begin : gen_in_exist
        assign user_in_rd[loop_io]  = user_in[loop_io];
      end else begin : gen_in_no_exist
        assign user_in_rd[loop_io]  = 1'b0;
      end
      if (loop_io < p_gem_user_out_width) begin : gen_out_exist
        reg user_out_r;
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
            user_out_r  <= 1'b0;
          else
            if (write_registers & (i_paddr == `gem_user_io_register))
              user_out_r  <= pwdata[loop_io];
        end
        assign user_out_rd[loop_io] = user_out_r;
      end else begin : gen_out_no_exist
        assign user_out_rd[loop_io] = 1'b0;
      end
    end

  end else begin : gen_no_user_io
    assign user_in_rd   = 16'h0000;
    assign user_out_rd  = 16'h0000;
  end
  endgenerate

  // The output always exists, if no GPIO is defined, this output will be 1-bit wide.
  assign user_out = user_out_rd[p_gem_user_out_width-1:0];

  // -----------------------------------------------------------------------------
  //  APB register writes for Multi-PFC quantum regs
  // -----------------------------------------------------------------------------
  generate if (p_edma_pfc_multi_quantum == 1) begin : gen_pfc_multi_regs
    reg   [15:0]  tx_pause_quantum_p1_r;  // tx_pause_quantum for pause tx for priority 1
    reg   [15:0]  tx_pause_quantum_p2_r;  // tx_pause_quantum for pause tx for priority 2
    reg   [15:0]  tx_pause_quantum_p3_r;  // tx_pause_quantum for pause tx for priority 3
    reg   [15:0]  tx_pause_quantum_p4_r;  // tx_pause_quantum for pause tx for priority 4
    reg   [15:0]  tx_pause_quantum_p5_r;  // tx_pause_quantum for pause tx for priority 5
    reg   [15:0]  tx_pause_quantum_p6_r;  // tx_pause_quantum for pause tx for priority 6
    reg   [15:0]  tx_pause_quantum_p7_r;  // tx_pause_quantum for pause tx for priority 7

    always@(posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
      begin
        tx_pause_quantum_p1_r <= 16'hffff;
        tx_pause_quantum_p2_r <= 16'hffff;
        tx_pause_quantum_p3_r <= 16'hffff;
        tx_pause_quantum_p4_r <= 16'hffff;
        tx_pause_quantum_p5_r <= 16'hffff;
        tx_pause_quantum_p6_r <= 16'hffff;
        tx_pause_quantum_p7_r <= 16'hffff;
      end
      else
      begin
        if (write_registers)
        begin
          case (i_paddr)
            `gem_tx_pause_quantum   : tx_pause_quantum_p1_r <= pwdata[31:16];
            `gem_tx_pause_quantum1  :
            begin
              tx_pause_quantum_p2_r <= pwdata[15:0];
              tx_pause_quantum_p3_r <= pwdata[31:16];
            end
            `gem_tx_pause_quantum2  :
            begin
              tx_pause_quantum_p4_r <= pwdata[15:0];
              tx_pause_quantum_p5_r <= pwdata[31:16];
            end
            `gem_tx_pause_quantum3  :
            begin
              tx_pause_quantum_p6_r <= pwdata[15:0];
              tx_pause_quantum_p7_r <= pwdata[31:16];
            end
            default : ;
          endcase
        end
      end
    end

    // Assign register read values
    assign tx_pause_quantum_p1_rd = tx_pause_quantum_p1_r;
    assign tx_pause_quantum_p2_rd = tx_pause_quantum_p2_r;
    assign tx_pause_quantum_p3_rd = tx_pause_quantum_p3_r;
    assign tx_pause_quantum_p4_rd = tx_pause_quantum_p4_r;
    assign tx_pause_quantum_p5_rd = tx_pause_quantum_p5_r;
    assign tx_pause_quantum_p6_rd = tx_pause_quantum_p6_r;
    assign tx_pause_quantum_p7_rd = tx_pause_quantum_p7_r;

    // Control output values are controlled by a mux.
    assign tx_pause_quantum_p1  = pfc_ctrl  ? tx_pause_quantum_p1_r : tx_pause_quantum;
    assign tx_pause_quantum_p2  = pfc_ctrl  ? tx_pause_quantum_p2_r : tx_pause_quantum;
    assign tx_pause_quantum_p3  = pfc_ctrl  ? tx_pause_quantum_p3_r : tx_pause_quantum;
    assign tx_pause_quantum_p4  = pfc_ctrl  ? tx_pause_quantum_p4_r : tx_pause_quantum;
    assign tx_pause_quantum_p5  = pfc_ctrl  ? tx_pause_quantum_p5_r : tx_pause_quantum;
    assign tx_pause_quantum_p6  = pfc_ctrl  ? tx_pause_quantum_p6_r : tx_pause_quantum;
    assign tx_pause_quantum_p7  = pfc_ctrl  ? tx_pause_quantum_p7_r : tx_pause_quantum;

    // Optional parity protection
    if ((p_edma_asf_csr_prot == 1'b1) ||
        (p_edma_asf_dap_prot == 1'b1)) begin : gen_par
      reg   [3:0] quant_0_par;
      reg   [3:0] quant_1_par;
      reg   [3:0] quant_2_par;
      reg   [3:0] quant_3_par;

      // Store associated parity
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          quant_0_par <= 4'h0;
          quant_1_par <= 4'h0;
          quant_2_par <= 4'h0;
          quant_3_par <= 4'h0;
        end
        else if (write_registers)
        begin
          if (i_paddr == `gem_tx_pause_quantum)
            quant_0_par <= pwdata_par;
          if (i_paddr == `gem_tx_pause_quantum1)
            quant_1_par <= pwdata_par;
          if (i_paddr == `gem_tx_pause_quantum2)
            quant_2_par <= pwdata_par;
          if (i_paddr == `gem_tx_pause_quantum3)
            quant_3_par <= pwdata_par;
        end
      end

      // Check the parity constantly
      cdnsdru_asf_parity_check_v1 #(.p_data_width(128)) i_par_chk (
        .odd_par    (1'b0),
        .data_in    ({tx_pause_quantum_p7_r,
                      tx_pause_quantum_p6_r,
                      tx_pause_quantum_p5_r,
                      tx_pause_quantum_p4_r,
                      tx_pause_quantum_p3_r,
                      tx_pause_quantum_p2_r,
                      tx_pause_quantum_p1_r,
                      tx_pause_quantum}),
        .parity_in  ({quant_3_par,
                      quant_2_par,
                      quant_1_par,
                      quant_0_par}),
        .parity_err (pause_par_err)
      );
      assign tx_pause_quantum_par     = quant_0_par[1:0];
      assign tx_pause_quantum_p1_par  = pfc_ctrl  ? quant_0_par[3:2]  : tx_pause_quantum_par;
      assign tx_pause_quantum_p2_par  = pfc_ctrl  ? quant_1_par[1:0]  : tx_pause_quantum_par;
      assign tx_pause_quantum_p3_par  = pfc_ctrl  ? quant_1_par[3:2]  : tx_pause_quantum_par;
      assign tx_pause_quantum_p4_par  = pfc_ctrl  ? quant_2_par[1:0]  : tx_pause_quantum_par;
      assign tx_pause_quantum_p5_par  = pfc_ctrl  ? quant_2_par[3:2]  : tx_pause_quantum_par;
      assign tx_pause_quantum_p6_par  = pfc_ctrl  ? quant_3_par[1:0]  : tx_pause_quantum_par;
      assign tx_pause_quantum_p7_par  = pfc_ctrl  ? quant_3_par[3:2]  : tx_pause_quantum_par;

    end else begin : gen_no_par
      assign pause_par_err            = 1'b0;
      assign tx_pause_quantum_par     = 2'b00;
      assign tx_pause_quantum_p1_par  = 2'b00;
      assign tx_pause_quantum_p2_par  = 2'b00;
      assign tx_pause_quantum_p3_par  = 2'b00;
      assign tx_pause_quantum_p4_par  = 2'b00;
      assign tx_pause_quantum_p5_par  = 2'b00;
      assign tx_pause_quantum_p6_par  = 2'b00;
      assign tx_pause_quantum_p7_par  = 2'b00;
    end

  end
  else
  begin : gen_no_pfc_multi_regs

    // Optional parity protection
    if ((p_edma_asf_csr_prot == 1'b1) ||
        (p_edma_asf_dap_prot == 1'b1)) begin : gen_par
      reg   [1:0] quant_0_par;

      // Store associated parity
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          quant_0_par <= 2'h0;
        else if (write_registers & (i_paddr == `gem_tx_pause_quantum))
          quant_0_par <= pwdata_par[1:0];
      end

      // Check the parity constantly
      cdnsdru_asf_parity_check_v1 #(.p_data_width(16)) i_par_chk (
        .odd_par    (1'b0),
        .data_in    (tx_pause_quantum),
        .parity_in  (quant_0_par),
        .parity_err (pause_par_err)
      );
      assign tx_pause_quantum_par     = quant_0_par[1:0];
    end else begin : gen_no_par
      assign pause_par_err            = 1'b0;
      assign tx_pause_quantum_par     = 2'b00;
    end

    assign tx_pause_quantum_p1_rd = 16'h0000;
    assign tx_pause_quantum_p2_rd = 16'h0000;
    assign tx_pause_quantum_p3_rd = 16'h0000;
    assign tx_pause_quantum_p4_rd = 16'h0000;
    assign tx_pause_quantum_p5_rd = 16'h0000;
    assign tx_pause_quantum_p6_rd = 16'h0000;
    assign tx_pause_quantum_p7_rd = 16'h0000;

    assign tx_pause_quantum_p1      = tx_pause_quantum;
    assign tx_pause_quantum_p2      = tx_pause_quantum;
    assign tx_pause_quantum_p3      = tx_pause_quantum;
    assign tx_pause_quantum_p4      = tx_pause_quantum;
    assign tx_pause_quantum_p5      = tx_pause_quantum;
    assign tx_pause_quantum_p6      = tx_pause_quantum;
    assign tx_pause_quantum_p7      = tx_pause_quantum;
    assign tx_pause_quantum_p1_par  = tx_pause_quantum_par;
    assign tx_pause_quantum_p2_par  = tx_pause_quantum_par;
    assign tx_pause_quantum_p3_par  = tx_pause_quantum_par;
    assign tx_pause_quantum_p4_par  = tx_pause_quantum_par;
    assign tx_pause_quantum_p5_par  = tx_pause_quantum_par;
    assign tx_pause_quantum_p6_par  = tx_pause_quantum_par;
    assign tx_pause_quantum_p7_par  = tx_pause_quantum_par;
  end
  endgenerate


  //------------------------------------------------------------------------------
  // APB register read (main common registers)
  //------------------------------------------------------------------------------
  always @(*)
  begin : p_read_register
    if (read_registers)
    begin
      case (i_paddr)
        //Read Mode
        `gem_network_control      : prdata_i_nq = network_control & 32'hfff9c19f; // mask out WO regs
        `gem_network_config       : prdata_i_nq = network_config;
        `gem_network_status       : prdata_i_nq = network_status;
        `gem_user_io_register     : prdata_i_nq = {user_in_rd,user_out_rd};

        `gem_pause_time           : prdata_i_nq = {16'h0000,tx_pause_time_pclk};
        `gem_tx_pause_quantum     : prdata_i_nq = {tx_pause_quantum_p1_rd & {16{p_edma_pfc_multi_quantum == 1}},tx_pause_quantum};
        `gem_tx_pause_quantum1    : prdata_i_nq = {tx_pause_quantum_p3_rd & {16{p_edma_pfc_multi_quantum == 1}},tx_pause_quantum_p2_rd & {16{p_edma_pfc_multi_quantum == 1}}};
        `gem_tx_pause_quantum2    : prdata_i_nq = {tx_pause_quantum_p5_rd & {16{p_edma_pfc_multi_quantum == 1}},tx_pause_quantum_p4_rd & {16{p_edma_pfc_multi_quantum == 1}}};
        `gem_tx_pause_quantum3    : prdata_i_nq = {tx_pause_quantum_p7_rd & {16{p_edma_pfc_multi_quantum == 1}},tx_pause_quantum_p6_rd & {16{p_edma_pfc_multi_quantum == 1}}};
        `gem_pfc_status           : prdata_i_nq = {23'd0, pfc_negotiate_pclk, rx_pfc_paused_pclk};
        `gem_wol_register         : prdata_i_nq = {12'h000,wol_mask[3:0], wol_ip_addr[15:0]};
        `gem_stretch_ratio        : prdata_i_nq = {ifg_24,ifg_32,10'd0,min_ipg,stretch_ratio};
        `gem_stacked_vlan         : prdata_i_nq = {stacked_vlantype[16], 15'h0000, stacked_vlantype[15:0]};
        `gem_revision_reg         : prdata_i_nq = `gem_revision_reg_value;

        `gem_rx_ptp_unicast       : prdata_i_nq = rx_ptp_unicast[31:0];
        `gem_tx_ptp_unicast       : prdata_i_nq = tx_ptp_unicast[31:0];

        // Debug Information, Read-only
        `gem_designcfg_debug1     : prdata_i_nq = gem_designcfg_debug1;
        `gem_designcfg_debug2     : prdata_i_nq = gem_designcfg_debug2;
        `gem_designcfg_debug3     : prdata_i_nq = gem_designcfg_debug3;
        `gem_designcfg_debug4     : prdata_i_nq = gem_designcfg_debug4;
        `gem_designcfg_debug5     : prdata_i_nq = gem_designcfg_debug5;
        `gem_designcfg_debug6     : prdata_i_nq = gem_designcfg_debug6;
        `gem_designcfg_debug7     : prdata_i_nq = gem_designcfg_debug7;
        `gem_designcfg_debug8     : prdata_i_nq = gem_designcfg_debug8;
        `gem_designcfg_debug9     : prdata_i_nq = gem_designcfg_debug9;
        `gem_designcfg_debug10    : prdata_i_nq = gem_designcfg_debug10;
        `gem_designcfg_debug11    : prdata_i_nq = gem_designcfg_debug11;
        `gem_designcfg_debug12    : prdata_i_nq = gem_designcfg_debug12;

        `gem_tx_pfc_pause         : prdata_i_nq = {16'h0000,tx_pfc_pause_reg};
        `gem_soft_conf_ctrl       : prdata_i_nq = {31'd0,soft_config_fifo_en};

        `gem_jumbo_max_length_ad  : prdata_i_nq = {18'h00000,jumbo_max_length};

        `gem_sys_wake_time        : prdata_i_nq = {16'h0000,tw_sys_tx_time};

        `gem_lockup_config        : prdata_i_nq = {dma_tx_lockup_mon_en,tx_lockup_mon_en,
                                                          dma_rx_lockup_mon_en,rx_lockup_mon_en,
                                                          lockup_recovery_en,dma_lockup_time,
                                                          lockup_prescale_val};
        `gem_lockup_config2       : prdata_i_nq = {5'h00,tx_mac_lockup_time,rx_mac_lockup_time};
        `gem_lockup_config3       : prdata_i_nq = dma_tx_lockup_q_en_rd;

        default : prdata_i_nq = 32'h00000000;
      endcase
    end
    else
      prdata_i_nq = 32'h00000000;
  end // end block: p_read_register.



  //------------------------------------------------------------------------------
  // Drive perr when address not recognised.
  //------------------------------------------------------------------------------

  // perr output is driven when paddr does not match any know address
  // This is a non-standard APB signal.
  always @(posedge pclk or negedge n_preset)
  begin : p_perr
    if (~n_preset)
      perr_nq <= 1'b0;
    else if (psel)
      case (i_paddr)
        `gem_network_control      : perr_nq <= 1'b0;
        `gem_network_config       : perr_nq <= 1'b0;
        `gem_network_status       : perr_nq <= 1'b0;
        `gem_user_io_register     : perr_nq <= p_gem_user_io == 0;
        `gem_pause_time           : perr_nq <= 1'b0;
        `gem_tx_pause_quantum     : perr_nq <= 1'b0;
        `gem_tx_pause_quantum1    : perr_nq <= p_edma_pfc_multi_quantum == 0;
        `gem_tx_pause_quantum2    : perr_nq <= p_edma_pfc_multi_quantum == 0;
        `gem_tx_pause_quantum3    : perr_nq <= p_edma_pfc_multi_quantum == 0;
        `gem_pfc_status           : perr_nq <= 1'b0;
        `gem_wol_register         : perr_nq <= 1'b0;
        `gem_stretch_ratio        : perr_nq <= 1'b0;
        `gem_stacked_vlan         : perr_nq <= 1'b0;
        `gem_tx_pfc_pause         : perr_nq <= 1'b0;
        `gem_rx_ptp_unicast       : perr_nq <= 1'b0;
        `gem_tx_ptp_unicast       : perr_nq <= 1'b0;
        `gem_revision_reg         : perr_nq <= 1'b0;
        `gem_designcfg_debug1     : perr_nq <= 1'b0;
        `gem_designcfg_debug2     : perr_nq <= 1'b0;
        `gem_designcfg_debug3     : perr_nq <= 1'b0;
        `gem_designcfg_debug4     : perr_nq <= 1'b0;
        `gem_designcfg_debug5     : perr_nq <= 1'b0;
        `gem_designcfg_debug6     : perr_nq <= 1'b0;
        `gem_designcfg_debug7     : perr_nq <= 1'b0;
        `gem_designcfg_debug8     : perr_nq <= 1'b0;
        `gem_designcfg_debug9     : perr_nq <= 1'b0;
        `gem_designcfg_debug10    : perr_nq <= 1'b0;
        `gem_designcfg_debug11    : perr_nq <= 1'b0;
        `gem_designcfg_debug12    : perr_nq <= 1'b0;
        `gem_soft_conf_ctrl       : perr_nq <= p_edma_host_if_soft_select == 0;
        `gem_jumbo_max_length_ad  : perr_nq <= 1'b0;
        `gem_sys_wake_time        : perr_nq <= 1'b0;
        `gem_lockup_config        : perr_nq <= 1'b0;
        `gem_lockup_config2       : perr_nq <= 1'b0;
        `gem_lockup_config3       : perr_nq <= p_edma_tx_pkt_buffer == 0;
        default : perr_nq <= 1'b1;
      endcase // case(i_paddr)
    else
      perr_nq <= 1'b0;
  end // block: p_perr_nq.


  // -----------------------------------------------------------------------------
  //  Instantiate and decode network control register bits.
  // -----------------------------------------------------------------------------
  gem_reg_nwc #(
    .p_edma_pfc_multi_quantum (p_edma_pfc_multi_quantum),
    .p_edma_axi               (p_edma_axi),
    .p_edma_tsu               (p_edma_tsu),
    .p_edma_ext_tsu_timer     (p_edma_ext_tsu_timer),
    .p_edma_rx_pkt_buffer     (p_edma_rx_pkt_buffer),
    .p_edma_no_stats          (p_edma_no_stats),
    .p_edma_no_snapshot       (p_edma_no_snapshot)
  ) i_network_control_reg (
    .pclk                   (pclk),
    .n_preset               (n_preset),
    .i_paddr                (i_paddr),
    .write_registers        (write_registers),
    .pwdata                 (pwdata),
    .disable_rx_pclk        (disable_rx_pclk),
    .disable_tx_pclk        (disable_tx_pclk),
    .tx_lockup_detected     (tx_lockup_detected),
    .rx_lockup_detected     (rx_lockup_detected),
    .dma_tx_lockup_detected (dma_tx_lockup_detected),
    .dma_rx_lockup_detected (dma_rx_lockup_detected),
    .lockup_recovery_en     (lockup_recovery_en),
    .tx_buff_ex_mid_pclk    (tx_buff_ex_mid_pclk),
    .network_control        (network_control)
  );

  // Decode bits
  assign ifg_eats_qav_credit  = network_control[30];
  assign two_pt_five_gig      = network_control[29];
  assign sel_mii_on_rgmii     = network_control[28];
  assign oss_correction_field = network_control[27];
  assign ext_rxq_sel_en       = network_control[26];
  assign pfc_ctrl             = network_control[25];
  assign one_step_sync_mode   = network_control[24];
  assign ext_tsu_timer_en     = network_control[23];
  assign store_udp_offset     = network_control[22];
  assign alt_sgmii_mode       = network_control[21];
  assign ptp_unicast_ena      = network_control[20];
  assign tx_lpi_en            = network_control[19];
  assign flush_rx_pkt_pclk    = network_control[18];
  assign tx_pfc_frame_req     = network_control[17];
  assign pfc_enable           = network_control[16];
  assign store_rx_ts          = network_control[15];
  assign stats_read_snap      = network_control[14] & (p_edma_no_stats == 0);
  assign stats_take_snap      = network_control[13] & (p_edma_no_stats == 0);
  assign tx_pause_frame_zero  = network_control[12];
  assign tx_pause_frame_req   = network_control[11];
  assign tx_halt_pclk         = network_control[10] & (p_edma_ext_fifo_interface == 0);
  assign tx_start_pclk        = network_control[9] & (p_edma_ext_fifo_interface == 0);
  assign back_pressure        = network_control[8];
  assign stats_write_en       = network_control[7] & (p_edma_no_stats == 0);
  assign inc_all_stats_regs   = network_control[6] & (p_edma_no_stats == 0);
  assign clear_all_stats_regs = network_control[5] & (p_edma_no_stats == 0);
  assign man_port_en          = network_control[4];
  assign enable_transmit      = network_control[3];
  assign enable_receive       = network_control[2];
  assign loopback_local       = network_control[1];
  assign loopback             = network_control[0];


  // Optionally duplicate and compare
  generate if (p_edma_asf_csr_prot == 1'b1) begin : gen_duplc_nwc
    wire  [31:0]  network_control_d;

    gem_reg_nwc #(
      .p_edma_pfc_multi_quantum (p_edma_pfc_multi_quantum),
      .p_edma_axi               (p_edma_axi),
      .p_edma_tsu               (p_edma_tsu),
      .p_edma_ext_tsu_timer     (p_edma_ext_tsu_timer),
      .p_edma_rx_pkt_buffer     (p_edma_rx_pkt_buffer),
      .p_edma_no_stats          (p_edma_no_stats),
      .p_edma_no_snapshot       (p_edma_no_snapshot)
    ) i_nwc_asf_duplc (
      .pclk                   (pclk),
      .n_preset               (n_preset),
      .i_paddr                (i_paddr),
      .write_registers        (write_registers),
      .pwdata                 (pwdata),
      .disable_rx_pclk        (disable_rx_pclk),
      .disable_tx_pclk        (disable_tx_pclk),
      .tx_lockup_detected     (tx_lockup_detected),
      .rx_lockup_detected     (rx_lockup_detected),
      .dma_tx_lockup_detected (dma_tx_lockup_detected),
      .dma_rx_lockup_detected (dma_rx_lockup_detected),
      .lockup_recovery_en     (lockup_recovery_en),
      .tx_buff_ex_mid_pclk    (tx_buff_ex_mid_pclk),
      .network_control        (network_control_d)
    );
    assign nwc_dplc_err = (network_control != network_control_d);
  end else begin : gen_no_duplc_nwc
    assign nwc_dplc_err = 1'b0;
  end
  endgenerate

  // -----------------------------------------------------------------------------
  //  Decode network configuration register bits.
  // -----------------------------------------------------------------------------
  assign uni_direct_en      = network_config[31];
  assign ign_ipg_rx_er      = network_config[30];
  assign rx_bad_preamble    = network_config[29];
  assign stretch_enable     = network_config[28];
  assign sgmii_mode         = network_config[27];
  assign rx_no_crc_check    = network_config[26];
  assign en_half_duplex_rx  = network_config[25];
  assign rx_toe_enable      = network_config[24];
  assign rx_no_pause_frames = network_config[23];
  // want to to be able to use this to indicate 128bit FIFO to top-level in FIFO only configs
  assign dma_bus_width      = ((p_edma_bus_width == 32'd128) || (p_edma_ext_fifo_interface == 1))  ? network_config[22:21] :
                              (p_edma_bus_width == 32'd64)  ? {1'b0, network_config[21]}
                                                            : 2'b00;
  assign mdc_clock_div      = {network_config[20],
                               network_config[19],
                               network_config[18]};
  assign strip_rx_fcs       = network_config[17];
  assign check_rx_length    = network_config[16];
  assign pause_enable       = network_config[13];
  assign retry_test         = network_config[12];
  assign tbi                = network_config[11] && p_edma_no_pcs == 0;
  assign gigabit            = network_config[10];
  assign ext_match_en       = network_config[9];
  assign rx_1536_en         = network_config[8];
  assign uni_hash_en        = network_config[7];
  assign multi_hash_en      = network_config[6];
  assign no_broadcast       = network_config[5];
  assign copy_all_frames    = network_config[4];
  assign jumbo_enable       = network_config[3];
  assign rm_non_vlan        = network_config[2];
  assign full_duplex        = network_config[1];
  assign half_duplex        = ~full_duplex;
  assign speed              = network_config[0];


  //------ assign tx_pfc_frame_pri output  -----------
  assign tx_pfc_frame_pri  = tx_pfc_pause_reg[7:0];
  assign tx_pfc_frame_zero = tx_pfc_pause_reg[15:8];


  // -----------------------------------------------------------------------------
  //  Decode network status register bits.
  // -----------------------------------------------------------------------------
  assign network_status = {21'd0,
                            // force link_fault indication low when the LFSM is disabled
                            link_fault_status_pclk & {link_fault_signal_en,link_fault_signal_en},
                            axi_xaction_out_pclk,
                            lpi_indicate_pclk,
                            pfc_negotiate_pclk,
                            mac_pause_tx_en,
                            mac_pause_rx_en,
                            mac_full_duplex,
                            man_done,
                            mdio_in,
                            pcs_link_state};


  // -----------------------------------------------------------------------------
  //  Instantiate statistics module
  // -----------------------------------------------------------------------------
  generate if (p_edma_no_stats == 0) begin : gen_stats_reg
    // Instantiate the statistics registers
    gem_reg_stats #(
        .p_edma_no_snapshot   (p_edma_no_snapshot),
        .p_edma_rx_pkt_buffer (p_edma_rx_pkt_buffer)
    ) i_gem_reg_stats (
      .pclk                   (pclk),
      .n_preset               (n_preset),
      .i_paddr                (i_paddr),
      .psel                   (psel),
      .write_registers        (write_registers),
      .read_registers         (read_registers),
      .pwdata                 (pwdata),
      .stats_write_en         (stats_write_en),
      .inc_all_stats_regs     (inc_all_stats_regs),
      .clear_all_stats_regs   (clear_all_stats_regs),
      .stats_take_snap        (stats_take_snap),
      .stats_read_snap        (stats_read_snap),
      .tx_lpi_en              (tx_lpi_en),
      .tx_mac_ok_pclk         (tx_mac_ok_pclk),
      .tx_bytes_pclk          (tx_bytes_pclk),
      .tx_broadcast_pclk      (tx_broadcast_pclk),
      .tx_multicast_pclk      (tx_multicast_pclk),
      .tx_single_col_pclk     (tx_single_col_pclk),
      .tx_multi_col_pclk      (tx_multi_col_pclk),
      .tx_late_col_pclk       (tx_late_col_pclk),
      .tx_late_col_mac_pclk   (tx_late_col_mac_pclk),
      .tx_deferred_pclk       (tx_deferred_pclk),
      .tx_crs_err_pclk        (tx_crs_err_pclk),
      .tx_toomanyretry_pclk   (tx_toomanyretry_pclk),
      .tx_pause_ok_pclk       (tx_pause_ok_pclk),
      .tx_pfc_pause_ok_pclk   (tx_pfc_pause_ok_pclk),
      .tx_underrun_pclk       (tx_underrun_pclk),
      .ok_to_update_rx_stats  (ok_to_update_rx_stats),
      .rx_mac_ok_pclk         (rx_mac_ok_pclk),
      .rx_bytes_pclk          (rx_bytes_pclk),
      .rx_broadcast_pclk      (rx_broadcast_pclk),
      .rx_multicast_pclk      (rx_multicast_pclk),
      .rx_align_err_pclk      (rx_align_err_pclk),
      .rx_crc_err_pclk        (rx_crc_err_pclk),
      .rx_short_err_pclk      (rx_short_err_pclk),
      .rx_long_err_pclk       (rx_long_err_pclk),
      .rx_jabber_err_pclk     (rx_jabber_err_pclk),
      .rx_symbol_err_pclk     (rx_symbol_err_pclk),
      .rx_pause_ok_pclk       (rx_pause_ok_pclk),
      .rx_length_err_pclk     (rx_length_err_pclk),
      .rx_ip_ck_err_pclk      (rx_ip_ck_err_pclk),
      .rx_tcp_ck_err_pclk     (rx_tcp_ck_err_pclk),
      .rx_udp_ck_err_pclk     (rx_udp_ck_err_pclk),
      .rx_dma_pkt_flushed_pclk(rx_dma_pkt_flushed_pclk),
      .rx_overflow_pclk       (rx_overflow_pclk),
      .rx_resource_err_pclk   (rx_resource_err_pclk),
      .lpi_indicate_pclk      (lpi_indicate_pclk),
      .lpi_indicate_del       (lpi_indicate_del),
      .frame_flushed_pclk     (frame_flushed_pclk),
      .prdata_stats           (prdata_stats),
      .perr_stats             (perr_stats)
    );

  end
  else
  begin : gen_no_stats_reg
    assign prdata_stats         = 32'h00000000;
    assign perr_stats           = 1'b1;
  end
  endgenerate


  //------------------------------------------------------------------------------
  // Instantiate registers address filtering
  //------------------------------------------------------------------------------
  gem_reg_filters #(
    .p_num_spec_add_filters (p_num_spec_add_filters),
    .p_parity_prot          (p_edma_asf_csr_prot),
    .p_edma_asf_dap_prot    (p_edma_asf_dap_prot)
  ) i_filters (
    .pclk                   (pclk),
    .n_preset               (n_preset),
    .i_paddr                (i_paddr),
    .psel                   (psel),
    .write_registers        (write_registers),
    .read_registers         (read_registers),
    .pwdata                 (pwdata),
    .pwdata_par             (pwdata_par),
    .hash                   (hash),
    .mask_add1              (mask_add1),
    .spec_type1             (spec_type1),
    .spec_type2             (spec_type2),
    .spec_type3             (spec_type3),
    .spec_type4             (spec_type4),
    .spec_type1_active      (spec_type1_active),
    .spec_type2_active      (spec_type2_active),
    .spec_type3_active      (spec_type3_active),
    .spec_type4_active      (spec_type4_active),
    .spec_add_filter_regs   (spec_add_filter_regs),
    .spec_add_filter_active (spec_add_filter_active),
    .spec_add1_tx           (spec_add1_tx),
    .spec_add1_tx_par       (spec_add1_tx_par),
    .prdata_filters         (prdata_filters),
    .perr_filters           (perr_filters),
    .filt_par_err           (filt_par_err)
  );


  //------------------------------------------------------------------------------
  // Instantiate registers for screener functionality
  //------------------------------------------------------------------------------
  generate if ((p_num_type1_screeners > 8'd0) || (p_num_type2_screeners > 8'd0))
  begin : gen_scrn
    gem_reg_scrn #(
      .p_num_type1_screeners  (p_num_type1_screeners),
      .p_num_type2_screeners  (p_num_type2_screeners),
      .p_num_scr2_compare_regs(p_num_scr2_compare_regs),
      .p_num_scr2_ethtype_regs(p_num_scr2_ethtype_regs),
      .p_parity_prot          (p_edma_asf_csr_prot)
    ) i_reg_scrn (
      .pclk                (pclk),
      .n_preset            (n_preset),
      .psel                (psel),
      .i_paddr             (i_paddr),
      .write_registers     (write_registers),
      .read_registers      (read_registers),
      .pwdata              (pwdata),
      .pwdata_par          (pwdata_par),
      .screener_type1_regs (screener_type1_regs),
      .screener_type2_regs (screener_type2_regs),
      .scr2_compare_regs   (scr2_compare_regs),
      .scr2_ethtype_regs   (scr2_ethtype_regs),
      .scr2_rate_lim       (scr2_rate_lim),
      .scr_excess_rate_pclk(scr_excess_rate_pclk),
      .prdata_scrn         (prdata_scrn),
      .perr_scrn           (perr_scrn),
      .scrn_par_err        (scrn_par_err)
    );
  end
  else
  begin : gen_no_scrn
    assign screener_type1_regs  = 1'b0;
    assign screener_type2_regs  = 1'b0;
    assign scr2_compare_regs    = 1'b0;
    assign scr2_ethtype_regs    = 1'b0;
    assign prdata_scrn          = 32'h00000000;
    assign perr_scrn            = 1'b1;
    assign scrn_par_err         = 1'b0;
    assign scr2_rate_lim        = 1'b0;
  end
  endgenerate


  //------------------------------------------------------------------------------
  // Instantiate registers for supporting 802.1CB FRER
  //------------------------------------------------------------------------------
  generate if ((p_gem_has_cb == 1'b1) && (p_num_type2_screeners > 8'd0))
  begin : gen_cb
    gem_reg_cb #(
      .p_gem_num_cb_streams (p_gem_num_cb_streams),
      .p_parity_prot        (p_edma_asf_csr_prot)
    ) i_reg_cb (
      .pclk               (pclk),
      .n_preset           (n_preset),
      .i_paddr            (i_paddr),
      .psel               (psel),
      .write_registers    (write_registers),
      .read_registers     (read_registers),
      .pwdata             (pwdata),
      .pwdata_par         (pwdata_par),
      .frer_to_pulse      (frer_to_pulse),
      .frer_rogue_pulse   (frer_rogue_pulse),
      .frer_ooo_pulse     (frer_ooo_pulse),
      .frer_err_upd_pulse (frer_err_upd_pulse),
      .frer_err_upd_val   (frer_err_upd_val),
      .frer_to_cnt        (frer_to_cnt),
      .frer_rtag_ethertype(frer_rtag_ethertype),
      .frer_strip_rtag    (frer_strip_rtag),
      .frer_6b_tag        (frer_6b_tag),
      .frer_en_vec_alg    (frer_en_vec_alg),
      .frer_use_rtag      (frer_use_rtag),
      .frer_seqnum_oset   (frer_seqnum_oset),
      .frer_seqnum_len    (frer_seqnum_len),
      .frer_scr_sel_1     (frer_scr_sel_1),
      .frer_scr_sel_2     (frer_scr_sel_2),
      .frer_vec_win_sz    (frer_vec_win_sz),
      .frer_en_elim       (frer_en_elim),
      .frer_en_to         (frer_en_to),
      .prdata_cb          (prdata_cb),
      .perr_cb            (perr_cb),
      .cb_par_err         (cb_par_err)
    );
  end
  else
  begin : gen_no_cb
    assign prdata_cb            = 32'h00000000;
    assign perr_cb              = 1'b1;
    assign frer_to_cnt          = 16'h0000;
    assign frer_rtag_ethertype  = 16'h0000;
    assign frer_strip_rtag      = 1'b0;
    assign frer_6b_tag          = 1'b0;
    assign frer_en_vec_alg      = {p_gem_num_cb_streams{1'b0}};
    assign frer_use_rtag        = {p_gem_num_cb_streams{1'b0}};
    assign frer_seqnum_oset     = {p_gem_num_cb_streams{9'd0}};
    assign frer_seqnum_len      = {p_gem_num_cb_streams{5'd0}};
    assign frer_scr_sel_1       = {p_gem_num_cb_streams{4'd0}};
    assign frer_scr_sel_2       = {p_gem_num_cb_streams{4'd0}};
    assign frer_vec_win_sz      = {p_gem_num_cb_streams{6'd0}};
    assign frer_en_elim         = {p_gem_num_cb_streams{1'b0}};
    assign frer_en_to           = {p_gem_num_cb_streams{1'b0}};
    assign cb_par_err           = 1'b0;
  end
  endgenerate

  //------------------------------------------------------------------------------
  // Instantiate per-queue rx flush mechanism registers
  //------------------------------------------------------------------------------
  gem_reg_rx_q_flush # (
    .p_edma_queues  (p_edma_queues),
    .p_parity_prot  (p_edma_asf_csr_prot)
  ) i_reg_rx_q_flush (
    .pclk               (pclk),
    .n_preset           (n_preset),
    .i_paddr            (i_paddr),
    .psel               (psel),
    .write_registers    (write_registers),
    .read_registers     (read_registers),
    .pwdata             (pwdata),
    .pwdata_par         (pwdata_par),
    .rx_q_flush         (rx_q_flush),
    .prdata_rx_q_flush  (prdata_rx_q_flush),
    .perr_rx_q_flush    (perr_rx_q_flush),
    .rx_q_flush_par_err (rx_q_flush_par_err)
  );

  //------------------------------------------------------------------------------
  // Instantiate DMA registers
  //------------------------------------------------------------------------------
  generate if (p_edma_ext_fifo_interface == 0) begin  : gen_dma
    gem_reg_dma #(.grouped_params(grouped_params)) i_reg_dma (
      .pclk                     (pclk),
      .n_preset                 (n_preset),
      .i_paddr                  (i_paddr),
      .psel                     (psel),
      .write_registers          (write_registers),
      .read_registers           (read_registers),
      .pwdata                   (pwdata),
      .pwdata_par               (pwdata_par),
      .enable_receive           (enable_receive),
      .tx_go_pclk               (tx_go_pclk),
      .network_config           (network_config),
      .gem_dma_addr_width_is_64b(gem_dma_addr_width_is_64b),
      .tx_dma_descr_ptr         (tx_dma_descr_ptr),
      .rx_dma_descr_ptr         (rx_dma_descr_ptr),
      .rsc_en                   (rsc_en),
      .rsc_clr                  (rsc_clr),
      .tx_disable_q             (tx_disable_q_pad),
      .rx_disable_q             (rx_disable_q_pad),
      .new_receive_q_ptr        (new_receive_q_ptr),
      .new_transmit_q_ptr       (new_transmit_q_ptr),
      .tx_dma_descr_base_addr   (tx_dma_descr_base_addr),
      .tx_dma_descr_base_par    (tx_dma_descr_base_par),
      .rx_dma_descr_base_addr   (rx_dma_descr_base_addr),
      .rx_dma_descr_base_par    (rx_dma_descr_base_par),
      .rx_dma_buffer_size       (rx_dma_buffer_size),
      .rx_dma_buffer_offset     (rx_dma_buffer_offset),
      .ahb_burst_length         (ahb_burst_length),
      .dma_addr_bus_width       (dma_addr_bus_width),
      .endian_swap              (endian_swap),
      .restart_counter_top      (restart_counter_top),
      .max_num_axi_aw2w         (max_num_axi_aw2w),
      .max_num_axi_ar2r         (max_num_axi_ar2r),
      .use_aw2b_fill            (use_aw2b_fill),
      .axi_tx_full_adj_0        (axi_tx_full_adj_0),
      .axi_tx_full_adj_1        (axi_tx_full_adj_1),
      .axi_tx_full_adj_2        (axi_tx_full_adj_2),
      .axi_tx_full_adj_3        (axi_tx_full_adj_3),
      .dma_addr_or_mask         (dma_addr_or_mask),
      .rx_pbuf_size             (rx_pbuf_size),
      .rx_cutthru_threshold     (rx_cutthru_threshold),
      .rx_cutthru               (rx_cutthru),
      .rx_fill_level_low        (rx_fill_level_low),
      .rx_fill_level_high       (rx_fill_level_high),
      .hdr_data_splitting_en    (hdr_data_splitting_en),
      .inf_last_dbuf_size_en    (inf_last_dbuf_size_en),
      .crc_error_report         (crc_error_report),
      .force_discard_on_err     (force_discard_on_err),
      .force_max_ahb_burst_rx   (force_max_ahb_burst_rx),
      .rx_bd_extended_mode_en   (rx_bd_extended_mode_en),
      .rx_bd_ts_mode            (rx_bd_ts_mode),
      .upper_rx_q_base_addr     (upper_rx_q_base_addr),
      .upper_rx_q_base_par      (upper_rx_q_base_par),
      .tx_cutthru_threshold     (tx_cutthru_threshold),
      .tx_cutthru               (tx_cutthru),
      .sel_dpram_fill_lvl_dbg   (sel_dpram_fill_lvl_dbg),
      .dpram_fill_lvl_pclk      (dpram_fill_lvl_pclk),
      .rx_dpram_fill_lvl_pad_pclk (rx_dpram_fill_lvl_pad_pclk),
      .tx_pbuf_size             (tx_pbuf_size),
      .tx_pbuf_tcp_en           (tx_pbuf_tcp_en),
      .force_max_ahb_burst_tx   (force_max_ahb_burst_tx),
      .tx_bd_extended_mode_en   (tx_bd_extended_mode_en),
      .tx_bd_ts_mode            (tx_bd_ts_mode),
      .upper_tx_q_base_addr     (upper_tx_q_base_addr),
      .upper_tx_q_base_par      (upper_tx_q_base_par),
      .tx_pbuf_segments         (tx_pbuf_segments),
      .axi_qos_q_mapping        (axi_qos_q_mapping),
      .prdata_dma               (prdata_dma),
      .perr_dma                 (perr_dma),
      .dma_par_err              (dma_par_err)
    );
  end
  else
  begin : gen_no_dma
    assign rsc_en                 = 14'd0;
    assign tx_disable_q_pad       = 16'd0;
    assign rx_disable_q_pad       = 16'd0;
    assign new_receive_q_ptr      = 1'b0;
    assign new_transmit_q_ptr     = 1'b0;
    assign tx_dma_descr_base_addr = 32'd0;
    assign tx_dma_descr_base_par  = 4'h0;
    assign rx_dma_descr_base_addr = 32'd0;
    assign rx_dma_descr_base_par  = 4'h0;
    assign rx_dma_buffer_size     = 8'd0;
    assign rx_dma_buffer_offset   = 2'b00;
    assign ahb_burst_length       = 5'd0;
    assign dma_addr_bus_width     = 1'b0;
    assign endian_swap            = 2'b00;
    assign restart_counter_top    = 4'd0;
    assign max_num_axi_aw2w       = 8'd0;
    assign max_num_axi_ar2r       = 8'd0;
    assign use_aw2b_fill          = 1'b0;
    assign axi_tx_full_adj_0      = {p_edma_tx_pbuf_addr{1'b0}};
    assign axi_tx_full_adj_1      = {p_edma_tx_pbuf_addr{1'b0}};
    assign axi_tx_full_adj_2      = {p_edma_tx_pbuf_addr{1'b0}};
    assign axi_tx_full_adj_3      = {p_edma_tx_pbuf_addr{1'b0}};
    assign dma_addr_or_mask       = 9'd0;
    assign rx_pbuf_size           = 2'b00;
    assign rx_cutthru_threshold   = {p_edma_rx_pbuf_addr{1'b0}};
    assign rx_cutthru             = 1'b0;
    assign rx_fill_level_low      = 1'b0;
    assign rx_fill_level_high     = 1'b0;
    assign hdr_data_splitting_en  = 1'b0;
    assign inf_last_dbuf_size_en  = 1'b0;
    assign crc_error_report       = 1'b0;
    assign force_discard_on_err   = 1'b0;
    assign force_max_ahb_burst_rx = 1'b0;
    assign rx_bd_extended_mode_en = 1'b0;
    assign rx_bd_ts_mode          = 2'b00;
    assign upper_rx_q_base_addr   = 32'd0;
    assign upper_rx_q_base_par    = 4'h0;
    assign tx_cutthru_threshold   = {p_edma_tx_pbuf_addr{1'b0}};
    assign tx_cutthru             = 1'b0;
    assign sel_dpram_fill_lvl_dbg = 4'd0;
    assign tx_pbuf_size           = 1'b0;
    assign tx_pbuf_tcp_en         = 1'b0;
    assign force_max_ahb_burst_tx = 1'b0;
    assign tx_bd_extended_mode_en = 1'b0;
    assign tx_bd_ts_mode          = 2'b00;
    assign upper_tx_q_base_addr   = 32'd0;
    assign upper_tx_q_base_par    = 4'h0;
    assign tx_pbuf_segments       = {48{1'b0}};
    assign axi_qos_q_mapping      = {(8*p_edma_queues){1'b0}};
    assign prdata_dma             = 32'd0;
    assign perr_dma               = 1'b1;
    assign dma_par_err            = 1'b0;
  end
  endgenerate
  assign tx_disable_queue = tx_disable_q_pad[p_edma_queues-1:0];
  assign rx_disable_queue = rx_disable_q_pad[p_edma_queues-1:0];

  //------------------------------------------------------------------------------
  // Instantiate registers for supporting 802.1Qbv EnST
  //------------------------------------------------------------------------------
  generate if ((p_edma_exclude_qbv == 0) && ((p_edma_tx_pkt_buffer == 1 || p_edma_ext_fifo_interface == 1)))
  begin : gen_enst
    gem_reg_enst #(
      .p_edma_queues(p_edma_queues),
      .p_parity_prot(p_edma_asf_csr_prot)
    ) i_reg_enst (
      .pclk               (pclk),
      .n_preset           (n_preset),
      .i_paddr            (i_paddr),
      .psel               (psel),
      .write_registers    (write_registers),
      .read_registers     (read_registers),
      .pwdata             (pwdata),
      .pwdata_par         (pwdata_par),
      .enst_en            (enst_en),
      .start_time         (start_time),
      .on_time            (on_time),
      .off_time           (off_time),
      .prdata_enst        (prdata_enst),
      .perr_enst          (perr_enst),
      .enst_par_err       (enst_par_err)
    );
  end
  else
  begin : gen_no_enst
    assign enst_en      = 8'h00;
    assign start_time   = {256{1'b0}};
    assign on_time      = {136{1'b0}};
    assign off_time     = {136{1'b0}};
    assign prdata_enst  = 32'h00000000;
    assign perr_enst    = 1'b1;
    assign enst_par_err = 1'b0;
  end
  endgenerate


  //------------------------------------------------------------------------------
  // Instantiate registers for TSU support
  //------------------------------------------------------------------------------
  generate if (p_edma_tsu == 1)
  begin : gen_tsu
    gem_reg_tsu #(
      .p_edma_tsu_clk       (p_edma_tsu_clk),
      .p_edma_ext_tsu_timer (p_edma_ext_tsu_timer),
      .p_parity_prot        (p_edma_asf_csr_prot),
      .p_dap_prot           (p_edma_asf_dap_prot)
    ) i_reg_tsu (
      .pclk                   (pclk),
      .n_preset               (n_preset),
      .i_paddr                (i_paddr),
      .psel                   (psel),
      .write_registers        (write_registers),
      .read_registers         (read_registers),
      .pwdata                 (pwdata),
      .pwdata_par             (pwdata_par),
      .timer_strobe           (timer_strobe),
      .tsu_timer_cnt_pclk     (tsu_timer_cnt_pclk),
      .tsu_timer_cnt_par_pclk (tsu_timer_cnt_par_pclk),
      .tsu_timer_cnt_pclk_vld (tsu_timer_cnt_pclk_vld),
      .tsu_ptp_tx_timer_in    (tsu_ptp_tx_timer_in),
      .tsu_ptp_tx_timer_par_in(tsu_ptp_tx_timer_par_in),
      .tsu_ptp_rx_timer_in    (tsu_ptp_rx_timer_in),
      .tsu_ptp_rx_timer_par_in(tsu_ptp_rx_timer_par_in),
      .ptp_tx_time_load       (ptp_tx_time_load),
      .ptp_rx_time_load       (ptp_rx_time_load),
      .ptp_tx_ptime_load      (ptp_tx_ptime_load),
      .ptp_rx_ptime_load      (ptp_rx_ptime_load),
      .tsu_timer_sec          (tsu_timer_sec),
      .tsu_timer_nsec         (tsu_timer_nsec),
      .tsu_timer_sec_wr       (tsu_timer_sec_wr),
      .tsu_timer_nsec_wr      (tsu_timer_nsec_wr),
      .tsu_timer_adj_wr       (tsu_timer_adj_wr),
      .tsu_timer_adj_ctrl     (tsu_timer_adj_ctrl),
      .tsu_timer_adj          (tsu_timer_adj),
      .tsu_timer_incr         (tsu_timer_incr),
      .tsu_timer_incr_wr      (tsu_timer_incr_wr),
      .tsu_timer_alt_incr     (tsu_timer_alt_incr),
      .tsu_timer_num_incr     (tsu_timer_num_incr),
      .tsu_timer_nsec_cmp     (tsu_timer_nsec_cmp),
      .tsu_timer_nsec_cmp_wr  (tsu_timer_nsec_cmp_wr),
      .tsu_timer_sec_cmp      (tsu_timer_sec_cmp),
      .prdata_tsu             (prdata_tsu),
      .perr_tsu               (perr_tsu),
      .tsu_par_err            (tsu_par_err),
      .tsu_dap_err            (asf_dap_tsu_err)
    );
  end
  else
  begin : gen_no_tsu
    assign tsu_timer_sec        = {48{1'b0}};
    assign tsu_timer_nsec       = {30{1'b0}};
    assign tsu_timer_sec_wr     = 1'b0;
    assign tsu_timer_nsec_wr    = 1'b0;
    assign tsu_timer_adj_wr     = 1'b0;
    assign tsu_timer_adj_ctrl   = 1'b0;
    assign tsu_timer_adj        = {30{1'b0}};
    assign tsu_timer_incr       = {32{1'b0}};
    assign tsu_timer_incr_wr    = 1'b0;
    assign tsu_timer_alt_incr   = {8{1'b0}};
    assign tsu_timer_num_incr   = {8{1'b0}};
    assign tsu_timer_nsec_cmp   = {22{1'b0}};
    assign tsu_timer_nsec_cmp_wr = 1'b0;
    assign tsu_timer_sec_cmp    = {48{1'b0}};
    assign prdata_tsu           = 32'h00000000;
    assign perr_tsu             = 1'b1;
    assign tsu_par_err          = 1'b0;
    assign asf_dap_tsu_err      = 1'b0;
  end
  endgenerate


  //------------------------------------------------------------------------------
  // Instantiate PHY management module
  //------------------------------------------------------------------------------
  gem_reg_phy_man i_phy_man (
    .pclk           (pclk),
    .n_preset       (n_preset),
    .i_paddr        (i_paddr),
    .psel           (psel),
    .write_registers(write_registers),
    .read_registers (read_registers),
    .pwdata         (pwdata),
    .man_port_en    (man_port_en),
    .mdc_clock_div  (mdc_clock_div),
    .mdio_in        (mdio_in),
    .mdio_en        (mdio_en),
    .mdio_out       (mdio_out),
    .mdc            (mdc),
    .man_done       (man_done),
    .prdata_phy_man (prdata_phy_man),
    .perr_phy_man   (perr_phy_man)
  );

  // Optionally duplicate and compare
  generate if (p_edma_asf_csr_prot == 1'b1) begin : gen_duplc_phyman
    wire          mdio_en_d;
    wire          mdio_out_d;
    wire          man_done_d;
    wire          mdc_d;
    wire  [31:0]  prdata_phy_man_d;
    wire          perr_phy_man_d;

    gem_reg_phy_man i_phy_man_asf_duplc (
      .pclk           (pclk),
      .n_preset       (n_preset),
      .i_paddr        (i_paddr),
      .psel           (psel),
      .write_registers(write_registers),
      .read_registers (read_registers),
      .pwdata         (pwdata),
      .man_port_en    (man_port_en),
      .mdc_clock_div  (mdc_clock_div),
      .mdio_in        (mdio_in),
      .mdio_en        (mdio_en_d),
      .mdio_out       (mdio_out_d),
      .mdc            (mdc_d),
      .man_done       (man_done_d),
      .prdata_phy_man (prdata_phy_man_d),
      .perr_phy_man   (perr_phy_man_d)
    );

    assign phy_man_dplc_err = ({mdio_en,mdio_out,mdc,man_done,prdata_phy_man,perr_phy_man} !=
                                {mdio_en_d,mdio_out_d,mdc_d,man_done_d,prdata_phy_man_d,perr_phy_man_d});
  end else begin : gen_no_duplc_phyman
    assign phy_man_dplc_err = 1'b0;
  end
  endgenerate


  //------------------------------------------------------------------------------
  // Instantiate scheduler registers
  //------------------------------------------------------------------------------
  gem_reg_sched #(
    .p_edma_queues      (p_edma_queues),
    .p_edma_exclude_cbs (p_edma_exclude_cbs),
    .p_edma_spram       (p_edma_spram),
    .p_parity_prot      (p_edma_asf_csr_prot)
  ) i_reg_sched (
    .pclk             (pclk),
    .n_preset         (n_preset),
    .i_paddr          (i_paddr),
    .psel             (psel),
    .write_registers  (write_registers),
    .read_registers   (read_registers),
    .pwdata           (pwdata),
    .pwdata_par       (pwdata_par),
    .speed_mode       (speed_mode),
    .tx_disable_q_pad (tx_disable_q_pad),
    .cbs_q_a_id       (cbs_q_a_id),
    .cbs_q_b_id       (cbs_q_b_id),
    .cbs_enable       (cbs_enable),
    .idleslope_q_a    (idleslope_q_a),
    .idleslope_q_b    (idleslope_q_b),
    .port_tx_rate     (port_tx_rate),
    .dwrr_ets_control (dwrr_ets_control),
    .bw_rate_limit    (bw_rate_limit),
    .prdata_sched     (prdata_sched),
    .perr_sched       (perr_sched),
    .sched_par_err    (sched_par_err)
  );


  //------------------------------------------------------------------------------
  // Instantiate interrupts and status registers
  //------------------------------------------------------------------------------
  gem_reg_int_sts #(
    .p_edma_irq_read_clear(p_edma_irq_read_clear),
    .p_edma_tx_pkt_buffer (p_edma_tx_pkt_buffer),
    .p_edma_rx_pkt_buffer (p_edma_rx_pkt_buffer),
    .p_edma_queues        (p_edma_queues),
    .p_edma_tsu           (p_edma_tsu),
    .p_edma_axi           (p_edma_axi),
    .p_edma_has_pcs       (p_edma_has_pcs),
    .p_edma_ext_fifo_interface  (p_edma_ext_fifo_interface)
  ) i_reg_int_sts (
    .pclk                   (pclk),
    .n_preset               (n_preset),
    .i_paddr                (i_paddr),
    .psel                   (psel),
    .write_registers        (write_registers),
    .read_registers         (read_registers),
    .pwdata                 (pwdata),
    .gigabit                (gigabit),
    .disable_tx_pclk        (disable_tx_pclk),
    .disable_rx_pclk        (disable_rx_pclk),
    .ext_interrupt_pclk     (ext_interrupt_pclk),
    .tx_frame_too_large_pclk(tx_frame_too_large_pclk),
    .link_fault_signal_en   (link_fault_signal_en),
    .link_fault_status_pclk (link_fault_status_pclk),
    .pcs_link_state         (pcs_link_state),
    .pcs_an_complete        (pcs_an_complete),
    .np_data_int            (np_data_int),
    .tx_late_col_pclk       (tx_late_col_pclk),
    .tx_go_pclk             (tx_go_pclk),
    .tx_ok_pclk             (tx_ok_pclk),
    .tx_ok_mod_pclk         (tx_ok_mod_pclk),
    .rx_ok_pclk             (rx_ok_pclk),
    .rx_ok_mod_pclk         (rx_ok_mod_pclk),
    .tx_coll_occ_pclk       (tx_coll_occ_pclk),
    .tx_toomanyretry_pclk   (tx_toomanyretry_pclk),
    .tx_pause_zero_pclk     (tx_pause_zero_pclk),
    .tx_pause_ok_pclk       (tx_pause_ok_pclk),
    .tx_pfc_pause_ok_pclk   (tx_pfc_pause_ok_pclk),
    .tx_underrun_pclk       (tx_underrun_pclk),
    .tx_buffers_ex_pclk     (tx_buffers_ex_pclk),
    .tx_buff_ex_mid_pclk    (tx_buff_ex_mid_pclk),
    .tx_hresp_notok_pclk    (tx_hresp_notok_pclk),
    .rx_hresp_notok_pclk    (rx_hresp_notok_pclk),
    .rx_buff_not_rdy_pclk   (rx_buff_not_rdy_pclk),
    .rx_dma_overrun_pclk    (rx_dma_overrun_pclk),
    .tx_dma_int_queue       (tx_dma_int_queue),
    .rx_dma_int_queue       (rx_dma_int_queue),
    .man_done               (man_done),
    .dma_tx_lockup_detected (dma_tx_lockup_detected),
    .dma_rx_lockup_detected (dma_rx_lockup_detected),
    .tx_lockup_detected     (tx_lockup_detected),
    .rx_lockup_detected     (rx_lockup_detected),
    .timer_cmp_val_int      (timer_cmp_val_int),
    .tsu_incr_sec_int       (tsu_incr_sec_int),
    .ptp_sync_tx_int        (ptp_sync_tx_int),
    .ptp_del_tx_int         (ptp_del_tx_int),
    .ptp_pdel_req_tx_int    (ptp_pdel_req_tx_int),
    .ptp_pdel_resp_tx_int   (ptp_pdel_resp_tx_int),
    .ptp_sync_rx_int        (ptp_sync_rx_int),
    .ptp_del_rx_int         (ptp_del_rx_int),
    .ptp_pdel_req_rx_int    (ptp_pdel_req_rx_int),
    .ptp_pdel_resp_rx_int   (ptp_pdel_resp_rx_int),
    .wol_pulse              (wol_pulse),
    .lpi_indicate_pclk      (lpi_indicate_pclk),
    .lpi_indicate_del       (lpi_indicate_del),
    .rx_pause_nz_pclk       (rx_pause_nz_pclk),
    .int_moderation         (int_moderation),
    .prdata_ints            (prdata_ints),
    .perr_ints              (perr_ints),
    .ethernet_int           (ethernet_int)
  );

  // Optionally duplicate and compare
  generate if (p_edma_asf_csr_prot == 1'b1) begin : gen_duplc_int_sts
    wire  [31:0]  int_moderation_d;
    wire  [31:0]  prdata_ints_d;
    wire          perr_ints_d;
    wire  [15:0]  ethernet_int_d;

    gem_reg_int_sts #(
      .p_edma_irq_read_clear(p_edma_irq_read_clear),
      .p_edma_tx_pkt_buffer (p_edma_tx_pkt_buffer),
      .p_edma_rx_pkt_buffer (p_edma_rx_pkt_buffer),
      .p_edma_queues        (p_edma_queues),
      .p_edma_tsu           (p_edma_tsu),
      .p_edma_axi           (p_edma_axi),
      .p_edma_has_pcs       (p_edma_has_pcs),
      .p_edma_ext_fifo_interface  (p_edma_ext_fifo_interface)
    ) i_reg_int_sts_asf_duplc (
      .pclk                   (pclk),
      .n_preset               (n_preset),
      .i_paddr                (i_paddr),
      .psel                   (psel),
      .write_registers        (write_registers),
      .read_registers         (read_registers),
      .pwdata                 (pwdata),
      .gigabit                (gigabit),
      .disable_tx_pclk        (disable_tx_pclk),
      .disable_rx_pclk        (disable_rx_pclk),
      .ext_interrupt_pclk     (ext_interrupt_pclk),
      .tx_frame_too_large_pclk(tx_frame_too_large_pclk),
      .link_fault_signal_en   (link_fault_signal_en),
      .link_fault_status_pclk (link_fault_status_pclk),
      .pcs_link_state         (pcs_link_state),
      .pcs_an_complete        (pcs_an_complete),
      .np_data_int            (np_data_int),
      .tx_late_col_pclk       (tx_late_col_pclk),
      .tx_go_pclk             (tx_go_pclk),
      .tx_ok_pclk             (tx_ok_pclk),
      .tx_ok_mod_pclk         (tx_ok_mod_pclk),
      .rx_ok_pclk             (rx_ok_pclk),
      .rx_ok_mod_pclk         (rx_ok_mod_pclk),
      .tx_coll_occ_pclk       (tx_coll_occ_pclk),
      .tx_toomanyretry_pclk   (tx_toomanyretry_pclk),
      .tx_pause_zero_pclk     (tx_pause_zero_pclk),
      .tx_pause_ok_pclk       (tx_pause_ok_pclk),
      .tx_pfc_pause_ok_pclk   (tx_pfc_pause_ok_pclk),
      .tx_underrun_pclk       (tx_underrun_pclk),
      .tx_buffers_ex_pclk     (tx_buffers_ex_pclk),
      .tx_buff_ex_mid_pclk    (tx_buff_ex_mid_pclk),
      .tx_hresp_notok_pclk    (tx_hresp_notok_pclk),
      .rx_hresp_notok_pclk    (rx_hresp_notok_pclk),
      .rx_buff_not_rdy_pclk   (rx_buff_not_rdy_pclk),
      .rx_dma_overrun_pclk    (rx_dma_overrun_pclk),
      .tx_dma_int_queue       (tx_dma_int_queue),
      .rx_dma_int_queue       (rx_dma_int_queue),
      .man_done               (man_done),
      .dma_tx_lockup_detected (dma_tx_lockup_detected),
      .dma_rx_lockup_detected (dma_rx_lockup_detected),
      .tx_lockup_detected     (tx_lockup_detected),
      .rx_lockup_detected     (rx_lockup_detected),
      .timer_cmp_val_int      (timer_cmp_val_int),
      .tsu_incr_sec_int       (tsu_incr_sec_int),
      .ptp_sync_tx_int        (ptp_sync_tx_int),
      .ptp_del_tx_int         (ptp_del_tx_int),
      .ptp_pdel_req_tx_int    (ptp_pdel_req_tx_int),
      .ptp_pdel_resp_tx_int   (ptp_pdel_resp_tx_int),
      .ptp_sync_rx_int        (ptp_sync_rx_int),
      .ptp_del_rx_int         (ptp_del_rx_int),
      .ptp_pdel_req_rx_int    (ptp_pdel_req_rx_int),
      .ptp_pdel_resp_rx_int   (ptp_pdel_resp_rx_int),
      .wol_pulse              (wol_pulse),
      .lpi_indicate_pclk      (lpi_indicate_pclk),
      .lpi_indicate_del       (lpi_indicate_del),
      .rx_pause_nz_pclk       (rx_pause_nz_pclk),
      .int_moderation         (int_moderation_d),
      .prdata_ints            (prdata_ints_d),
      .perr_ints              (perr_ints_d),
      .ethernet_int           (ethernet_int_d)
    );
    assign int_sts_dplc_err = (int_moderation     != int_moderation_d)    |
                              (prdata_ints        != prdata_ints_d)       |
                              (perr_ints          != perr_ints_d)         |
                              (ethernet_int       != ethernet_int_d);

  end else begin : gen_no_duplc_int_sts
    assign int_sts_dplc_err = 1'b0;
  end
  endgenerate


  //------------------------------------------------------------------------------
  // Instantiate ASF fault logging and reporting module
  //------------------------------------------------------------------------------
  // ASF address bus, with bottom two bits zeroed
  assign i_paddr_asf[6:0] = i_paddr[6:0];

  // Select (read/write) ASF fault logging and reporting module
  assign asf_base_addr        = `gem_asf_base_addr;
  assign i_sel_asf            = (write_registers | read_registers) & (i_paddr[11:7] == asf_base_addr[11:7]);
  assign asf_dap_fault        = asf_dap_paddr_err       |     // Checking signals already in pclk
                                asf_dap_pwdata_err      |     // Checking signals already in pclk
                                asf_dap_prdata_err      |     // Checking signals already in pclk
                                asf_dap_rdata_err_pclk  |     // Synchronised to pclk
                                asf_dap_tsu_err         |     // Checking signals already in pclk
                                asf_dap_txclk_err_pclk  |     // Synchronised to pclk
                                asf_dap_rxclk_err_pclk  |     // Synchronised to pclk
                                asf_dap_dma_err_pclk    |     // Synchronised to pclk
                                asf_dap_pcs_rx_err      |     // Special case already synchronised in PCS
                                asf_dap_pcs_tx_err;           // Special case already synchronised in PCS

  assign asf_integrity_fault  = asf_integrity_dma_err_pclk |
                                asf_integrity_tsu_err_pclk |
                                asf_integrity_tx_sched_err_pclk;

  // Assignment of multi-bit sources.
  assign asf_trans_to_fault[0]    = tx_lockup_detected;
  assign asf_trans_to_fault[1]    = rx_lockup_detected;
  assign asf_trans_to_fault[2]    = dma_tx_lockup_detected;
  assign asf_trans_to_fault[3]    = dma_rx_lockup_detected;
  assign asf_trans_to_fault[4]    = asf_host_trans_to_err_pclk;

  assign asf_protocol_fault[0]    = rx_crc_err_pclk;
  assign asf_protocol_fault[1]    = rx_short_err_pclk;
  assign asf_protocol_fault[2]    = rx_long_err_pclk;
  assign asf_protocol_fault[3]    = rx_symbol_err_pclk;
  assign asf_protocol_fault[4]    = rx_length_err_pclk;
  assign asf_protocol_fault[5]    = rx_ip_ck_err_pclk;
  assign asf_protocol_fault[6]    = rx_tcp_ck_err_pclk;
  assign asf_protocol_fault[7]    = rx_udp_ck_err_pclk;
  assign asf_protocol_fault[8]    = tx_toomanyretry_pclk;
  assign asf_protocol_fault[15:9] = 7'h00;
  assign asf_protocol_fault[16]   = tx_underrun_pclk;
  assign asf_protocol_fault[17]   = tx_buff_ex_mid_pclk;
  assign asf_protocol_fault[18]   = tx_hresp_notok_pclk;
  assign asf_protocol_fault[19]   = rx_hresp_notok_pclk;
  assign asf_protocol_fault[20]   = rx_overflow_pclk;
  assign asf_protocol_fault[21]   = rx_dma_pkt_flushed_pclk;

  // The fault logging module exists for all configurations and will always have protocol
  // check reporting and lockup detect reporting (through trans_to).
  // When ASF is enabled, then a host transaction timeout functionality is added.
  parameter p_trans_to_status_width = (p_edma_tx_pkt_buffer == 1) ? (p_edma_asf_trans_to_prot == 1'b1)  ? 32'd5
                                                                                                        : 32'd4
                                                                  : 32'd2;
  cdnsdru_asf_fault_log_rpt_v2 #(
    .p_add_sram_protect       ((p_edma_asf_dap_prot || p_edma_asf_ecc_sram) && p_edma_tx_pkt_buffer),
    .p_add_sram_corr_count    (p_edma_asf_ecc_sram && p_edma_tx_pkt_buffer),
    .p_add_sram_uncorr_count  (1'b0),
    .p_add_dap_parity         (p_edma_asf_dap_prot),
    .p_add_csr_parity         (p_edma_asf_csr_prot),
    .p_add_trans_to           (1'b1),
    .p_add_trans_to_ctrl      (p_edma_asf_trans_to_prot && p_edma_tx_pkt_buffer),
    .p_trans_to_status_width  (p_trans_to_status_width),
    .p_add_protocol_check     (1'b1),
    .p_protocol_status_width  (32'd22),
    .p_protocol_status_exists (22'h3f01ff),
    .p_add_integrity_check    (p_edma_asf_integrity_prot)
  ) i_reg_asf_fault_log_rpt (
    // system inputs.
    .asf_clk                          (pclk),
    .asf_reset_n                      (n_preset),
    .asf_addr                         (i_paddr_asf),
    .asf_wdata                        (pwdata),
    .asf_wdata_par                    (pwdata_par),
    .asf_write                        (pwrite),
    .asf_sel                          (i_sel_asf),
    .asf_rdata                        (prdata_asf),
    .asf_rdata_par                    (),
    .asf_err                          (asf_err),
    .asf_sram_corr_fault              (asf_sram_corr_fault),
    .asf_sram_corr_fault_status       (asf_sram_corr_fault_status),
    .asf_sram_corr_fault_stats_upd    (asf_sram_corr_fault_stats_upd),
    .asf_sram_uncorr_fault            (asf_sram_uncorr_fault),
    .asf_sram_uncorr_fault_status     (asf_sram_uncorr_fault_status),
    .asf_sram_uncorr_fault_stats_upd  (8'h00),
    .asf_dap_fault                    (asf_dap_fault),
    .asf_csr_fault                    (csr_parity_fault),
    .asf_trans_to_fault               (asf_trans_to_fault[p_trans_to_status_width-1:0]),
    .asf_protocol_fault               (asf_protocol_fault),
    .asf_integrity_fault              (asf_integrity_fault),
    .asf_trans_to_en                  (asf_trans_to_en),
    .asf_trans_to_time                (asf_trans_to_time),
    .asf_sram_corr_err                (asf_sram_corr_err),
    .asf_sram_uncorr_err              (asf_sram_uncorr_err),
    .asf_dap_err                      (asf_dap_err),
    .asf_csr_err                      (asf_csr_err),
    .asf_trans_to_err                 (asf_trans_to_err),
    .asf_protocol_err                 (asf_protocol_err),
    .asf_integrity_err                (asf_integrity_err),
    .asf_int_nonfatal                 (asf_int_nonfatal),
    .asf_int_fatal                    (asf_int_fatal)
  );

  // ASF fault logging and reporting not selected
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      i_sel_not_asf <= 1'b0;
    else
      if(((write_registers | read_registers) & (i_paddr[11:7]!=5'h1c)))
        i_sel_not_asf <= 1'b1;
      else
        i_sel_not_asf <= 1'b0;
  end
  assign perr_asf = (i_sel_not_asf)? 1'b1:asf_err;

  // Combine all prdata sources
  assign prdata_int = prdata_i_nq |
                      prdata_stats |
                      prdata_scrn |
                      prdata_enst |
                      prdata_tsu  |
                      prdata_phy_man |
                      prdata_filters |
                      prdata_sched |
                      prdata_ints |
                      prdata_rx_q_flush |
                      prdata_dma |
                      prdata_cb |
                      prdata_asf;

  // Register prdata
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      prdata_i <= 32'h00000000;
    else
      prdata_i <= prdata_int;
  end

  assign prdata = prdata_i;  // AMBA 2.0 drives prdata continuously

  // Mux in p_err from each match register access
  assign perr = perr_nq &
                perr_stats &
                perr_scrn &
                perr_enst &
                perr_tsu  &
                perr_phy_man &
                perr_filters &
                perr_sched &
                perr_ints &
                perr_rx_q_flush &
                perr_dma &
                perr_cb &
                perr_asf;


  // Decodes for operating speed

  // gigabit | tbi
  //   0     |   0   | MII operation
  //   0     |   1   | SGMII 10/100 operation
  //   1     |   0   | GMII operation
  //   1     |   1   | Gigabit SGMII operation

  // assign speed_mode signal output. Indicates speed and interface selected.
  // Can be decoded as follows:
  //  bits- 2 1 0              function
  //  ------------------------------------------------
  //        1 1 x      1000 Mbits/s using TBI interface    125MHz clk
  //        0 1 x      1000 Mbits/s using GMII interface   125MHz clk
  //        0 0 1       100 Mbits/s using MII interface     25MHz clk
  //        0 0 0        10 Mbits/s using MII interface    2.5MHz clk
  //        1 0 1       100 Mbits/s using SGMII interface 12.5MHz clk
  //        1 0 0        10 Mbits/s using SGMII interface 1.25MHz clk
  assign speed_mode = {two_pt_five_gig, // 2.5G operation
                        tbi,            // TBI when high, GMII when low
                        gigabit,        // 1G when high,  10/100 when low
                        speed};         // 100M when high, 10M when low

  assign tx_byte_mode = tbi | gigabit;  // indicates whether gem_tx will output
                                        // bytes or nibbles. In SGMII mode may
                                        // bytes will be transmitted even when
                                        // not in gigabit mode.

  // Optional parity for tx_pfc_frame_pri
  wire  [1:0] pfc_pause_par;
  generate if ((p_edma_asf_csr_prot == 1'b1) ||
                (p_edma_asf_dap_prot == 1'b1)) begin : gen_tx_pfc_frame_pri_par
    reg [1:0] pfc_pause_par_r;
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        pfc_pause_par_r <= 2'b00;
      else if (write_registers & (i_paddr == `gem_tx_pfc_pause))
        pfc_pause_par_r <= pwdata_par[1:0];
    end
    assign pfc_pause_par  = pfc_pause_par_r;
  end else begin : gen_no_tx_pfc_frame_pri_par
    assign pfc_pause_par  = 2'b00;
  end
  endgenerate
  assign tx_pfc_frame_pri_par = pfc_pause_par[0];

  // Optional parity protection
  generate if (p_edma_asf_csr_prot == 1'b1) begin : gen_par
    reg   [3:0] nwc_par;            // Store parity for common registers
    reg   [2:0] wol_par;
    reg   [1:0] stretch_par;
    reg   [2:0] vlan_par;
    reg   [3:0] rx_ptp_uni_par;
    reg   [3:0] tx_ptp_uni_par;
    reg         soft_conf_par;
    reg   [1:0] jumbo_par;
    reg   [1:0] wake_time_par;
    wire  [1:0] lockup_cfg_par_3_2;
    reg   [1:0] lockup_cfg_par_1_0;
    reg   [3:0] lockup_cfg2_par;
    wire  [1:0] lockup_cfg3_par;
    wire        cmn_par_err;        // Parity error in common registers
    reg         csr_parity_fault_r;

    // Store associated parity
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
      begin
        nwc_par             <= {^p_network_config_rst_val[31:24],
                                ^p_network_config_rst_val[23:16],
                                ^p_network_config_rst_val[15:8],
                                ^p_network_config_rst_val[7:0]};
        wol_par             <= 3'h0;
        stretch_par         <= 2'h0;
        vlan_par            <= 3'h0;
        rx_ptp_uni_par      <= 4'h0;
        tx_ptp_uni_par      <= 4'h0;
        soft_conf_par       <= 1'b0;
        jumbo_par           <= {^p_edma_jumbo_max_length[13:8],
                                ^p_edma_jumbo_max_length[7:0]};
        wake_time_par       <= 2'h0;
        lockup_cfg_par_1_0  <= 2'b00;
        lockup_cfg2_par     <= 4'b1000;
      end
      else if (write_registers)
      begin
        case (i_paddr)
          `gem_network_config       : nwc_par             <= pwdata_par;
          `gem_wol_register         : wol_par             <= {^pwdata[19:16],pwdata_par[1:0]};
          `gem_stretch_ratio        : stretch_par         <= pwdata_par[1:0];
          `gem_stacked_vlan         : vlan_par            <= {pwdata[31],pwdata_par[1:0]};
          `gem_rx_ptp_unicast       : rx_ptp_uni_par      <= pwdata_par;
          `gem_tx_ptp_unicast       : tx_ptp_uni_par      <= pwdata_par;
          `gem_soft_conf_ctrl       : soft_conf_par       <= pwdata[0] & (p_edma_host_if_soft_select == 1);
          `gem_jumbo_max_length_ad  : jumbo_par           <= {^pwdata[13:8],pwdata_par[0]};
          `gem_sys_wake_time        : wake_time_par       <= pwdata_par[1:0];
          `gem_lockup_config        : lockup_cfg_par_1_0  <= pwdata_par[1:0];
          `gem_lockup_config2       : lockup_cfg2_par     <= {^pwdata[26:24],pwdata_par[2:0]};
          default : ;
        endcase // case(i_paddr).
      end
    end

    // DMA lockup specific parity
    if (p_edma_tx_pkt_buffer == 1) begin : gen_pbuf_lockup_par
      reg [1:0] lockup_cfg_par_3_2_r;
      reg [1:0] lockup_cfg3_par_r;
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          lockup_cfg_par_3_2_r  <= 2'b10;
          lockup_cfg3_par_r     <= 2'b00;
        end
        else
        begin
          if (write_registers & (i_paddr == `gem_lockup_config))
            lockup_cfg_par_3_2_r  <= pwdata_par[3:2];
          if (write_registers & (i_paddr == `gem_lockup_config3))
            lockup_cfg3_par_r     <= pwdata_par[1:0];
        end
      end
      assign lockup_cfg_par_3_2 = lockup_cfg_par_3_2_r;
      assign lockup_cfg3_par    = lockup_cfg3_par_r;
    end else begin : gen_no_pbuf_lockup_par
      reg lockup_cfg_par_3_r;
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          lockup_cfg_par_3_r  <= 1'b0;
        else
          if (write_registers & (i_paddr == `gem_lockup_config))
            lockup_cfg_par_3_r  <= pwdata[30]^pwdata[28]^pwdata[27];
      end
      assign lockup_cfg_par_3_2 = {lockup_cfg_par_3_r,1'b0};
      assign lockup_cfg3_par    = 2'b00;
    end

    // Check the parity constantly
    cdnsdru_asf_parity_check_v1 #(.p_data_width(296)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    ({network_config,
                    4'h0,wol_reg,
                    stretch_ratio,
                    7'h00,stacked_vlantype,
                    tx_pfc_pause_reg,
                    rx_ptp_unicast,
                    tx_ptp_unicast,
                    7'h00,soft_config_fifo_en,
                    2'h0,jumbo_max_length,
                    tw_sys_tx_time,
                    dma_tx_lockup_q_en_int[15:0],
                    dma_tx_lockup_mon_en,
                    tx_lockup_mon_en,
                    dma_rx_lockup_mon_en,
                    rx_lockup_mon_en,
                    lockup_recovery_en,
                    dma_lockup_time,
                    lockup_prescale_val,
                    5'h00,
                    tx_mac_lockup_time,
                    rx_mac_lockup_time}),
      .parity_in  ({nwc_par,
                    wol_par,
                    stretch_par,
                    vlan_par,
                    pfc_pause_par,
                    rx_ptp_uni_par,
                    tx_ptp_uni_par,
                    soft_conf_par,
                    jumbo_par,
                    wake_time_par,
                    lockup_cfg3_par,
                    lockup_cfg_par_3_2,
                    lockup_cfg_par_1_0,
                    lockup_cfg2_par}),
      .parity_err (cmn_par_err)
    );

    // Register parity error
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        csr_parity_fault_r  <= 1'b0;
      else
        csr_parity_fault_r  <=  asf_csr_pcs_err   |
                                asf_csr_mmsl_err  |
                                cmn_par_err       |
                                tsu_par_err       |
                                scrn_par_err      |
                                sched_par_err     |
                                filt_par_err      |
                                enst_par_err      |
                                rx_q_flush_par_err|
                                dma_par_err       |
                                cb_par_err        |
                                pause_par_err     |
                                int_sts_dplc_err  |
                                nwc_dplc_err      |
                                phy_man_dplc_err;
    end
    assign csr_parity_fault = csr_parity_fault_r;

  end else begin : gen_no_par
    assign csr_parity_fault = 1'b0;
  end
  endgenerate


  // Generate prdata_par and check pwdata_par
  generate if (p_edma_asf_host_par == 1'b1) begin : gen_host_par
    wire  [3:0] prdata_par_int;
    reg   [3:0] prdata_par_r;

    // Check pwdata_par
    cdnsdru_asf_parity_check_v1 #(.p_data_width(32)) i_gen_chk_pwdata_par (
      .odd_par    (1'b0),
      .data_in    (pwdata),
      .parity_in  (pwdata_par),
      .parity_err (asf_dap_pwdata_err)
    );

    // Generate parity for prdata
    cdnsdru_asf_parity_gen_v1 #(.p_data_width(32)) i_gen_prdata_par (
      .odd_par    (1'b0),
      .data_in    (prdata_int),
      .data_out   (),
      .parity_out (prdata_par_int)
    );

    // Register prdata_par
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        prdata_par_r  <= 4'h0;
      else
        prdata_par_r  <= prdata_par_int;
    end
    assign prdata_par = prdata_par_r;

  end
  else begin : gen_no_host_par
    assign prdata_par         = 4'h0;
    assign asf_dap_pwdata_err = 1'b0;
  end
  endgenerate

endmodule

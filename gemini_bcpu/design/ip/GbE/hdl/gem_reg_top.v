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
//   Filename:           gem_reg_top.v
//   Module Name:        gem_reg_top
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
//   Description :      Module integrating the gem_registers and
//                      gem_pclk_syncs module.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_top (

   // system signals.
   n_preset,
   pclk,
   n_tsureset,
   tsu_clk,
   n_txreset,
   tx_clk,
   n_hreset,
   hclk,
   n_rxreset,
   rx_clk,

   // APB interface signals.
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
   ext_interrupt_in,
   mdio_in,
   mdio_en,
   mdio_out,
   mdc,
   ethernet_int,
   loopback,
   half_duplex,
   speed_mode,
   tx_byte_mode,
   rx_no_crc_check,
   user_out,
   user_in,

   // handshaking between gem_mac and gem_reg_top.
   tx_end_tog,
   tx_status_wr_tog,
   rx_end_tog,
   rx_status_wr_tog,
   tx_pause_tog_ack,

   // signals coming from gem_tx.
   tx_frame_txed_ok,
   tx_bytes_in_frame,
   tx_broadcast_frame,
   tx_multicast_frame,
   tx_single_coll_frame,
   tx_multi_coll_frame,
   tx_late_coll_frame,
   tx_deferred_tx_frame,
   tx_crs_error_frame,
   tx_coll_occured,
   tx_pause_time,
   tx_pause_time_tog,
   tx_pause_frame_txed,
   tx_pfc_pause_frame_txed,

   // signals coming from gem_rx.
   rx_frame_rxed_ok,
   rx_bytes_in_frame,
   rx_broadcast_frame,
   rx_multicast_frame,
   rx_align_error,
   rx_crc_error,
   rx_short_error,
   rx_long_error,
   rx_jabber_error,
   rx_symbol_error,
   rx_pause_frame,
   rx_pause_nonzero,
   rx_length_error,
   rx_ip_ck_error,
   rx_tcp_ck_error,
   rx_udp_ck_error,
   rx_dma_pkt_flushed,
   rx_pkt_dbuff_overflow,
   rx_overflow,
   pfc_negotiate,
   rx_pfc_paused,
   lpi_indicate,
   wol,

   // handshaking between gem_dma_top and gem_reg_top.
   tx_dma_stable_tog,
   tx_dma_stat_capt_tog,
   rx_dma_stable_tog,
   rx_dma_stat_capt_tog,

   // signals coming from gem_dma_tx.
   tx_dma_complete_ok,
   tx_dma_buffers_ex,
   tx_dma_buff_ex_mid,
   tx_dma_go,
   tx_dma_hresp_notok,
   tx_dma_late_col,
   tx_dma_toomanyretry,
   tx_dma_underflow,
   tx_too_many_retries,
   tx_underflow_frame,
   tx_dma_descr_ptr,
   tx_dma_descr_ptr_tog,

   // signals coming from gem_dma_rx.
   rx_dma_complete_ok,
   rx_dma_buff_not_rdy,
   rx_dma_resource_err,
   rx_dma_hresp_notok,
   tx_dma_int_queue,
   rx_dma_int_queue,
   rx_dma_descr_ptr,
   rx_dma_descr_ptr_tog,

   axi_tx_frame_too_large,
   axi_xaction_out,
   disable_tx,
   disable_rx,

   // signals coming from gem_pcs_register.
   pcs_link_state,
   pcs_an_complete,
   np_data_int,
   mac_pause_tx_en,
   mac_pause_rx_en,
   mac_full_duplex,

   // signals going to gem_dma_top.
   rx_dma_descr_base_addr,
   rx_dma_descr_base_par,
   tx_dma_descr_base_addr,
   tx_dma_descr_base_par,
   rx_dma_buffer_size,
   rx_dma_buffer_offset,
   rx_buff_not_rdy_pclk,
   new_receive_q_ptr,
   new_transmit_q_ptr,
   tx_start_pclk,
   tx_halt_pclk,
   flush_rx_pkt_pclk,
   hdr_data_splitting_en,
   infinite_last_dbuf_size_en,
   ahb_burst_length,
   endian_swap,

   // signals going to gem_dma_top (gem_hclk_syncs) and gem_mac.
   enable_transmit,
   enable_receive,
   dma_bus_width,

   // signals going to packet buffers
   rx_pbuf_size,
   rx_cutthru_threshold,
   rx_cutthru,
   rx_fill_level_low,
   rx_fill_level_high,
   crc_error_report,
   tx_pbuf_size,
   tx_pbuf_tcp_en,
   tx_cutthru_threshold,
   tx_cutthru,

   //signals going to gem_pcs
   alt_sgmii_mode,
   sgmii_mode,
   uni_direct_en,

   // signals going to gem_mac.
   ign_ipg_rx_er,
   rx_bad_preamble,
   stretch_enable,
   stretch_ratio,
   min_ifg,
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
   tw_sys_tx_time,
   pause_enable,
   rx_1536_en,
   jumbo_enable,
   force_discard_on_err,
   force_max_ahb_burst_tx,
   force_max_ahb_burst_rx,
   check_rx_length,
   strip_rx_fcs,
   store_udp_offset,
   pfc_enable,
   ptp_unicast_ena,
   rx_ptp_unicast,
   tx_ptp_unicast,

   // precision time protocol signals for IEEE 1588 support
   sync_frame_rx,
   delay_req_rx,
   pdelay_req_rx,
   pdelay_resp_rx,
   sync_frame_tx,
   delay_req_tx,
   pdelay_req_tx,
   pdelay_resp_tx,
   store_rx_ts,
   tsu_timer_cnt,
   tsu_timer_cnt_par,
   tsu_sec_incr,
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
   timer_strobe,
   tsu_timer_nsec_cmp,
   tsu_timer_nsec_cmp_wr,
   tsu_timer_sec_cmp,
   tsu_timer_cmp_val,
   tsu_ptp_tx_timer_in,
   tsu_ptp_rx_timer_in,
   tsu_ptp_tx_timer_prty_in,
   tsu_ptp_rx_timer_prty_in,
   one_step_sync_mode,
   oss_correction_field,
   ext_tsu_timer_en,

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
   mask_add1,
   spec_add1_tx,
   spec_add1_tx_par,
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
   cbs_enable,
   cbs_q_a_id,
   cbs_q_b_id,
   idleslope_q_a,
   idleslope_q_b,
   port_tx_rate,

   dwrr_ets_control,
   bw_rate_limit,

   soft_config_fifo_en,

   jumbo_max_length,
   ext_rxq_sel_en,

   // AXI specific
   use_aw2b_fill,
   max_num_axi_ar2r,
   max_num_axi_aw2w,

   // 64b addressing and extended BD control
   upper_tx_q_base_addr,
   upper_tx_q_base_par,
   upper_rx_q_base_addr,
   upper_rx_q_base_par,
   dma_addr_bus_width,

   // Debug port
   tx_dpram_fill_lvl_dbg,
   rx_dpram_fill_lvl_dbg,

   // AXI configuration, soft config to determine the AXI thresholds
   // when the underlying tx dma is full
   axi_tx_full_adj_0,
   axi_tx_full_adj_1,
   axi_tx_full_adj_2,
   axi_tx_full_adj_3,

   // RSC specific
   rsc_clr_tog,
   rsc_en,

   restart_counter_top,

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

   // ASF external status inputs
   asf_dap_paddr_err,
   asf_dap_prdata_err,
   asf_dap_rdata_err,
   asf_csr_pcs_err,
   asf_csr_mmsl_err,
   asf_dap_pcs_tx_err,
   asf_dap_pcs_rx_err,
   asf_dap_mmsl_tx_err,
   asf_dap_mmsl_rx_err,

   // Link fault Status
   link_fault_signal_en,
   link_fault_status,

   // ASF - from SRAM protection
   tx_corr_err,
   tx_uncorr_err,
   tx_err_addr,
   rx_corr_err,
   rx_uncorr_err,
   rx_err_addr,

   asf_dap_txclk_err,
   asf_dap_rxclk_err,
   asf_dap_dma_err,
   asf_integrity_dma_err,
   asf_integrity_tsu_err,
   asf_integrity_tx_sched_err,
   asf_host_trans_to_err,

   // RAS - signals from lockup detection
   dma_tx_lockup_detected,
   dma_rx_lockup_detected,
   tx_lockup_detected,
   rx_lockup_detected,

   // RAS - signals going to lockup detection
   dma_tx_lockup_mon_en,
   dma_rx_lockup_mon_en,
   dma_tx_lockup_q_en,
   tx_lockup_mon_en,
   rx_lockup_mon_en,
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
   frer_to_tog,
   frer_rogue_tog,
   frer_ooo_tog,
   frer_err_upd_tog,
   frer_err_upd_val,

   // Rx traffic policing registers
   rx_q_flush,

   // per type 2 screener rate limiting registers
   scr2_rate_lim,
   scr_excess_rate,

   // toggle to stats, indicating a frame flushed by mode2, 3, or 4
   frame_flushed_tog,

   // AXI QoS configuration
   axi_qos_q_mapping,

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
   input         n_preset;                // amba apb reset.
   input         pclk;                    // amba apb clock.
   input         n_tsureset;              // TSU clock
   input         tsu_clk;                 // TSU reset
   input         n_txreset;               // transmit clock reset
   input         tx_clk;                  // transmit clock
   input         n_hreset;
   input         hclk;
   input         n_rxreset;
   input         rx_clk;

   // APB interface signals.
   input  [11:2] paddr;                   // address bus of selected master.
   output [31:0] prdata;                  // read data.
   output [3:0]  prdata_par;              // Parity for prdata
   input  [31:0] pwdata;                  // write data.
   input  [3:0]  pwdata_par;              // Parity for pwdata
   input         pwrite;                  // peripheral write strobe.
   input         penable;                 // peripheral enable.
   input         psel;                    // peripheral select for GPIO.
   output        perr;                    // not a standard APB signal, driven.
                                          // high when psel is asserted if
                                          // address is not recognized.

   // other top level signals.
   input         ext_interrupt_in;        // External interrupt input
   input         mdio_in;                 // status of MDIO pin.
   output        mdio_en;                 // enable signal for MDIO pin.
   output        mdio_out;                // MDIO pin output.
   output        mdc;                     // management data clock.
   output [15:0] ethernet_int;            // ethernet MAC interrupt signal.
   output        loopback;                // ext loopback signal to the PHY.
   output        half_duplex;             // duplex signal from the network configuration register.
   output  [3:0] speed_mode;              // Indicate speed and interface.
   output        tx_byte_mode;            // gem_tx transmits bytes not nibbles
   output        rx_no_crc_check;         // disables crc checking on receive

   output  [(p_gem_user_out_width - 1):0] // programmable user outputs
                 user_out;                // to top level
   input   [(p_gem_user_in_width - 1):0]  // programmable user inputs
                 user_in;                 // from top level

   // handshaking between gem_mac and gem_reg_top.
   input         tx_end_tog;              // toggled at the end of frame
                                          // transmission (used for handshake
                                          // of statistics).
   output        tx_status_wr_tog;        // signal for tx handshake of status.
   input         rx_end_tog;              // toggled at end of frame
                                          // reception.
   output        rx_status_wr_tog;        // signal for rx handshake of status.
   output        tx_pause_tog_ack;        // handshake of tx_pause_time_tog.

   // signals coming from gem_tx.
   input         tx_frame_txed_ok;        // asserted at end of transmitted
                                          // frame, if no underrun and not too
                                          // many retries. Cleared when
                                          // tx_status_wr_tog is returned.
   input  [13:0] tx_bytes_in_frame;       // number of bytes in tx frame
   input         tx_broadcast_frame;      // broadcast tx frame
   input         tx_multicast_frame;      // multicast tx frame
   input         tx_single_coll_frame;    // asserted high at the end of frame
                                          // if a single collision and no
                                          // underrun, cleared when
                                          // tx_status_wr_tog is returned.
   input         tx_multi_coll_frame;     // asserted high at the end of frame
                                          // if a multicollision, no underrun
                                          // and not too many retries, cleared
                                          // when tx_status_wr_tog is returned.
   input         tx_late_coll_frame;      // asserted high at the end of frame
                                          // if late collision, no underrun and
                                          // not too many retries, cleared
                                          // when tx_status_wr_tog is returned.
   input         tx_deferred_tx_frame;    // asserted high at the end of frame
                                          // if deferred, no collision and no
                                          // underrun, cleared when
                                          // when tx_status_wr_tog is returned.
   input         tx_crs_error_frame;      // asserted high at the end of frame
                                          // if crs error and no underrun,
                                          // cleared when tx_status_wr_tog is
                                          // returned.
   input         tx_coll_occured;         // collision occured during transmit,
                                          // cleared when tx_status_wr_tog is
                                          // returned.
   input  [15:0] tx_pause_time;           // value of pause time register.
   input         tx_pause_time_tog;       // indicates that the pause time
                                          // register has decremented.
   input         tx_pause_frame_txed;     // indicates that the pause frame was
                                          // transmitted, cleared when
                                          // tx_status_wr_tog is returned.
   input         tx_pfc_pause_frame_txed; // indicates that the PFC pause
                                          // frame was transmitted,
                                          // cleared when
                                          // tx_status_wr_tog is returned.

   // signals coming from gem_rx.
   input         rx_frame_rxed_ok;        // frame recieved OK by MAC
   input  [13:0] rx_bytes_in_frame;       // number of bytes in rx frame
   input         rx_broadcast_frame;      // broadcast rx frame
   input         rx_multicast_frame;      // multicast rx frame
   input         rx_align_error;          // misaligned frame (non-integral
                                          // number of bytes and bad crc),
                                          // cleared when rx_status_wr_tog is
                                          // returned.
   input         rx_crc_error;            // crc errored frame (integral number
                                          // of bytes and bad crc), cleared when
                                          // rx_status_wr_tog is returned.
   input         rx_short_error;          // short frame (less than 64 bytes and
                                          // good crc), cleared when
                                          // rx_status_wr_tog is returned.
   input         rx_long_error;           // long frame (greater than 1518 bytes
                                          // and good crc), cleared when
                                          // rx_status_wr_tog is returned.
   input         rx_jabber_error;         // long frame with bad crc (greater
                                          // than 1518 bytes), cleared when
                                          // rx_status_wr_tog is returned.
   input         rx_symbol_error;         // signal indicating a rx_er frame,
                                          // cleared when rx_status_wr_tog is
                                          // returned.
   input         rx_pause_frame;          // indicates a 8023.or PFC
                                          // pause frame has been received,
                                          // cleared when
                                          // rx_status_wr_tog is returned.
   input         rx_pause_nonzero;        // indicates a 802.3 or PFC
                                          // pause frame has been received
                                          // with non-zero quantum.
                                          // cleared on rx_status_wr_tog.
   input         rx_length_error;         // indicates a frame has been received
                                          // where the length field is incorrect
                                          // cleared when rx_status_wr_tog is
                                          // returned.
   input         rx_ip_ck_error;          // frame had IP header checksum error
                                          // cleared when rx_status_wr_tog
                                          // is returned.
   input         rx_tcp_ck_error;         // frame had TCP checksum error
                                          // cleared when rx_status_wr_tog
                                          // is returned.
   input         rx_udp_ck_error;         // frame had UDP checksum error
                                          // cleared when rx_status_wr_tog
                                          // is returned.
   input         rx_dma_pkt_flushed;      // frame was dropped due to AHB
                                          // resource error
   input         rx_pkt_dbuff_overflow;   // Overflow from Packet Buffer
   input         rx_overflow;             // asserted when overflow in RX path
   input         pfc_negotiate;           // indicates a received PFC
                                          // pause frame
   input   [7:0] rx_pfc_paused;           // each bit is set when PFC frame has
                                          // been received and the associated
                                          // PFC counter != 0
   input         lpi_indicate;            // rx LPI indication has been detected
   input         wol;                     // wake on LAN indication

   // handshaking between gem_dma_top and gem_reg_top.
   input         rx_dma_stable_tog;       // toggles to indicate that rx_dma
                                          // status can be sampled in pclk
                                          // domain
   output        rx_dma_stat_capt_tog;    // toggle whenever rx_dma status is
                                          // captured in pclk registers
   input         tx_dma_stable_tog;       // toggles to indicate that tx_dma
                                          // status can be sampled in pclk
                                          // domain
   output        tx_dma_stat_capt_tog;    // toggle whenever tx_dma status is
                                          // captured in pclk registers

   // signals coming from gem_dma_tx.
   input         tx_dma_complete_ok;      // tx_frame_end indication.
   input         tx_dma_buffers_ex;       // sets bit in transmit status reg.
   input         tx_dma_buff_ex_mid;      // sets bit in transmit status reg.
   input         tx_dma_go;               // sets bit in transmit status reg.
   input         tx_dma_hresp_notok;      // asserted when hresp is not OK.
   input [(p_edma_queues*32)-1:0] tx_dma_descr_ptr;        // Descriptor queue pointer for debug
   input         tx_dma_descr_ptr_tog;    // handshaking for tx_dma_descr_ptr.
   input         tx_dma_late_col;         // late collision indicator
   input         tx_dma_toomanyretry;     // too many retires indicator
   input         tx_dma_underflow;        // Underflow indicator
   input         tx_too_many_retries;     // set if collision retry limit has
                                          // been reached, cleared when
                                          // tx_status_wr_tog is returned.
   input         tx_underflow_frame;      // asserted high at the end of frame
                                          // to indicate a fifo underrun or
                                          // status writeback problem, cleared
                                          // when tx_status_wr_tog is returned.

   // signals coming from gem_dma_rx.
   input         rx_dma_complete_ok;      // asserted when a received frame
                                          // has been transferred to memory.
   input         rx_dma_buff_not_rdy;     // signal from the dma block to set
                                          // bit in receive status register.
   input         rx_dma_resource_err;     // indicates discard of a rx frame
                                          // due to no rx buffer available.
   input         rx_dma_hresp_notok;      // asserted when hresp is not OK.
   input  [(p_edma_queues*32)-1:0] rx_dma_descr_ptr;        // Descriptor queue pointer for debug
   input         rx_dma_descr_ptr_tog;    // handshaking for rx_dma_descr_ptr.
   input  [3:0]  tx_dma_int_queue;        // Identifies which queue the
   input  [3:0]  rx_dma_int_queue;        // interrupt is destined for

   input         axi_tx_frame_too_large;  // AXI incoming frame on TX was too large for SRAM
   input         axi_xaction_out;         // At least one outstanding transaction
   input         disable_tx;              // Major errors from AXI module require disabing TX
   input         disable_rx;              // Major errors from AXI module require disabing RX


   // signals coming from gem_pcs_register.
   input         pcs_link_state;          // current link state of PCS
   input         pcs_an_complete;         // PCS autonegotiation complete
   input         np_data_int;             // More np data required
   input         mac_pause_tx_en;         // negotiated pause tx
   input         mac_pause_rx_en;         // negotiated pause rx
   input         mac_full_duplex;         // negotiated duplex mode

   input  [(p_edma_tx_pbuf_addr*p_edma_queues)-1:0] tx_dpram_fill_lvl_dbg;
   input  [p_edma_rx_pbuf_addr-1:0] rx_dpram_fill_lvl_dbg;

   output [p_edma_tx_pbuf_addr-1:0] axi_tx_full_adj_0;
   output [p_edma_tx_pbuf_addr-1:0] axi_tx_full_adj_1;
   output [p_edma_tx_pbuf_addr-1:0] axi_tx_full_adj_2;
   output [p_edma_tx_pbuf_addr-1:0] axi_tx_full_adj_3;

   // RSC specific
   input [p_edma_queues-1:0] rsc_clr_tog;    // Receive Side Coalescing clear

   output [3:0]  restart_counter_top;     //

   // signals going to gem_dma_top.
   output [(p_edma_queues*32)-1:0] rx_dma_descr_base_addr;  // base position of the rx buffer
                                          // queue pointer list.
   output [(p_edma_queues*4)-1:0]  rx_dma_descr_base_par;   // Parity
   output [(p_edma_queues*32)-1:0] tx_dma_descr_base_addr;
                                          // A serialised list of all q pointers
                                          // In basic verilog it's not possible to use
                                          // a two dimensional array at an IO so we
                                          // serialize the internal array.
                                          // queue pointer list.
   output  [(p_edma_queues*4)-1:0] tx_dma_descr_base_par;   // Parity
   output  [(p_edma_queues*8)-1:0] rx_dma_buffer_size;      // rx buffer depth (in x64 bytes)
   output  [1:0] rx_dma_buffer_offset;    // byte offset of receive buffer from
                                          // buffer descriptor pointer.
   output        rx_buff_not_rdy_pclk;    // pclk pulse for corresp flag
   output        new_receive_q_ptr;       // asserted when receive queue pointer
                                          // is written.
   output        new_transmit_q_ptr;      // asserted when tx queue pointer
                                          // is written.
   output        tx_start_pclk;           // asserted when bit 9 of network
                                          // control register is written.
   output        tx_halt_pclk;            // asserted when bit 10 of network
                                          // control register is written.
   output        flush_rx_pkt_pclk;       // asserted when bit 18 of network
                                          // control register is written.
   output        hdr_data_splitting_en;   // Header Data Splitting enbable
   output        infinite_last_dbuf_size_en;// data buffer pointed to by last descriptor is infinite size
   output  [4:0] ahb_burst_length;        // AHB burst length control
   output  [1:0] endian_swap;             // Endian swap enable

   // signals going to gem_dma_top (gem_hclk_syncs) and gem_mac.
   output        enable_transmit;         // transmit enable signal from network
                                          // control register.
   output        enable_receive;          // receive enable signal from network
                                          // control register.
   output  [1:0] dma_bus_width;           // encoding for DMA bus width.

   // signals going to packet buffers
   output  [1:0] rx_pbuf_size;            // Programmed size of RX DPRAM
   output[p_edma_rx_pbuf_addr-1:0] rx_cutthru_threshold; // Threshold value
   output        rx_cutthru;              // Enable for cut-thru operation
   output        rx_fill_level_low;       // watermark for transmitting zero pause frame
   output        rx_fill_level_high;      // watermark for transmitting non-zero pause frame
   output        crc_error_report;        // jumbo length reporting
   output        tx_pbuf_size;            // Programmed size of TX DPRAM
   output        tx_pbuf_tcp_en;          // TCP TX checksum offload enable
   output [p_edma_tx_pbuf_addr-1:0] tx_cutthru_threshold; // Threshold value
   output        tx_cutthru;              // Enable for cut-thru operation

   //signals going to gem_pcs
   output        alt_sgmii_mode;          // alternative tx config for SGMII
   output        sgmii_mode;              // PCS is configured for SGMII
   output        uni_direct_en;           // when set PCS transmits data rather
                                          // than idle when rx link is down

   // signals going to gem_mac.
   output        ign_ipg_rx_er;           // ignore rx_er when rx_dv is low
   output        rx_bad_preamble;         // enables reception of frames with
                                          // bad preamble
   output        stretch_enable;          // enables IPG stretching
   output [15:0] stretch_ratio;           // determines how to stretch the IPG
   output  [3:0] min_ifg;                 // minimum transmit IFG divided by four
   output        retry_test;              // goes to gem_mac, must be set to
                                          // zero for normal operation.
   output [15:0] tx_pause_quantum;        // tx_pause_quantum for pause tx.
   output [1:0]  tx_pause_quantum_par;    // Optional parity
   output [15:0] tx_pause_quantum_p1;     // tx_pause_quantum for pause tx.
   output [1:0]  tx_pause_quantum_p1_par; // Optional parity
   output [15:0] tx_pause_quantum_p2;     // tx_pause_quantum for pause tx.
   output [1:0]  tx_pause_quantum_p2_par; // Optional parity
   output [15:0] tx_pause_quantum_p3;     // tx_pause_quantum for pause tx.
   output [1:0]  tx_pause_quantum_p3_par; // Optional parity
   output [15:0] tx_pause_quantum_p4;     // tx_pause_quantum for pause tx.
   output [1:0]  tx_pause_quantum_p4_par; // Optional parity
   output [15:0] tx_pause_quantum_p5;     // tx_pause_quantum for pause tx.
   output [1:0]  tx_pause_quantum_p5_par; // Optional parity
   output [15:0] tx_pause_quantum_p6;     // tx_pause_quantum for pause tx.
   output [1:0]  tx_pause_quantum_p6_par; // Optional parity
   output [15:0] tx_pause_quantum_p7;     // tx_pause_quantum for pause tx.
   output [1:0]  tx_pause_quantum_p7_par; // Optional parity
   output        tx_pause_frame_req;      // transmit pause frame (prog quantum)
   output        tx_pause_frame_zero;     // use zero quantum in tx pause frame.
   output        tx_pfc_frame_req;        // transmit PFC pause frame
   output  [7:0] tx_pfc_frame_pri;        // PFC pause frame priority enable
                                          // vector.
   output        tx_pfc_frame_pri_par;    // Optional parity
   output  [7:0] tx_pfc_frame_zero;       // use zero quantum in tx
                                          // PFC pause frame.
   output        tx_lpi_en;               // enables transmission of LPI
   output        ifg_eats_qav_credit;     // modifies CBS algorithm so IFG/IPG uses Qav credit
   output [15:0] tw_sys_tx_time;          // system wake time after tx LPI stops
   output        pause_enable;            // stops tx when pause time is
                                          // non-zero.
   output        rx_1536_en;              // goes to rx block to enable
                                          // reception of 1536 byte frames.
   output        jumbo_enable;            // enable jumbo frames.
   output        force_discard_on_err;    //
   output        force_max_ahb_burst_tx;  //
   output        force_max_ahb_burst_rx;  //
   output        check_rx_length;         // enables rx length field checking.
   output        strip_rx_fcs;            // stops rx fcs/crc being copied.
   output        store_udp_offset;        // store udp/tcp offset to memory
   output        store_rx_ts;             // store receive time stamp to memory
   input  [93:16] tsu_timer_cnt;          // TSU timer count value
   input  [11:2]  tsu_timer_cnt_par;      // Parity for tsu_timer_cnt
   output        pfc_enable;              // PFC pause frame receive enable
   output        ptp_unicast_ena;         // enable PTPv2 IPv4 unicast IP DA
                                          // detection
   output [31:0] rx_ptp_unicast;          // rx PTPv2 IPv4 unicast IP DA
   output [31:0] tx_ptp_unicast;          // tx PTPv2 IPv4 unicast IP DA

   // signals going to gem_mac (gem_filter).
   output        back_pressure;           // goes to tx block to force
   output        full_duplex;             // duplex signal from the network
                                          // configuration register.
   output        loopback_local;          // internal loopback signal.
   output        en_half_duplex_rx;       // enable receiving of frames whilst
                                          // transmiting in half duplex.
   output        rx_no_pause_frames;      // don't copy any pause frames.
   output        rx_toe_enable;           // Enable RX TCP Offload Engine.
   output        ext_match_en;            // external address match enable from
                                          // the network configuration register.
   output        uni_hash_en;             // unicast hash enable from the
                                          // network configuration register.
   output        multi_hash_en;           // multicast hash enable signal from
                                          // the network configuration register.
   output        no_broadcast;            // signal to disable recption of
                                          // broadcast frames from the network
                                          // configuration register.
   output        copy_all_frames;         // copy all frames signal from the
                                          // network configuration register.
   output        rm_non_vlan;             // Discard non-VLAN frames
   output [63:0] hash;                    // hash register for destination
                                          // address filtering.
   output [55*(p_num_spec_add_filters+1)-1:0]  spec_add_filter_regs;   // specific address filters
   output [p_num_spec_add_filters:0]           spec_add_filter_active;  // specific address filter active
   output [47:0] mask_add1;               // specific address 1 mask for
                                          // destination address comparison.
   output [47:0] spec_add1_tx;            // Source address for pause tx
   output [5:0]  spec_add1_tx_par;        // Optional parity
   output [15:0] spec_type1;              // specific type 1 for type comparison
   output [15:0] spec_type2;              // specific type 2 for type comparison
   output [15:0] spec_type3;              // specific type 3 for type comparison
   output [15:0] spec_type4;              // specific type 4 for type comparison
   output        spec_type1_active;       // spec_type1 can be used for type
                                          // comparison.
   output        spec_type2_active;       // spec_type2 can be used for type
                                          // comparison.
   output        spec_type3_active;       // spec_type3 can be used for type
                                          // comparison.
   output        spec_type4_active;       // spec_type4 can be used for type
                                          // comparison.
   output [16:0] stacked_vlantype;        // VLAN tag TPID (bit 16 enables
                                          // stacked VLAN tag support)
   output [15:0] wol_ip_addr;             // lower bits of IP address for WoL
   output  [3:0] wol_mask;                // Wake-onLAN enable mask
   output  [8:0] dma_addr_or_mask;        // OR mask used for data-buffers

   input         sync_frame_tx;           // PTP sync frame transmitted
   input         delay_req_tx;            // PTP delay_req transmitted
   input         pdelay_req_tx;           // PTP pdelay_req transmitted
   input         pdelay_resp_tx;          // PTP pdelay_rsp transmitted
   input         sync_frame_rx;           // PTP sync frame received
   input         delay_req_rx;            // PTP delay_req received
   input         pdelay_req_rx;           // PTP pdelay_req received
   input         pdelay_resp_rx;          // PTP pdelay_rsp received

   // precision time protocol signals for IEEE 1588 support
   input         tsu_sec_incr;            // TSU timer seconds incremented
   output [47:0] tsu_timer_sec;           // TSU registered timer value seconds
   output [29:0] tsu_timer_nsec;          // TSU registered timer value
                                          // nanoseconds
   output        tsu_timer_sec_wr;        // TSU timer seconds written
   output        tsu_timer_nsec_wr;       // TSU timer nanoseconds written
   output        tsu_timer_adj_ctrl;      // TSU timer add/subtract adjust
   output [29:0] tsu_timer_adj;           // TSU timer adjust
   output        tsu_timer_adj_wr;        // TSU timer adjust written
   output [31:0] tsu_timer_incr;          // TSU timer increment
   output        tsu_timer_incr_wr;       // TSU timer incr written
   output  [7:0] tsu_timer_alt_incr;      // TSU timer alternative increment
   output  [7:0] tsu_timer_num_incr;      // TSU timer number of increments
                                          // alternative increment value used
   output [21:0] tsu_timer_nsec_cmp;      // TSU timer comparison nanosecond
   output        tsu_timer_nsec_cmp_wr;   // indicates a comparison ns write
   output [47:0] tsu_timer_sec_cmp;       // TSU timer comparison second
   input         timer_strobe;            // write timer sync strobe registers
   input         tsu_timer_cmp_val;       // TSU timer comparison valid
   // tx_clk domain outputs
   input  [77:0] tsu_ptp_tx_timer_in;     // TX Timstamp value synchonized to PCLK
   input  [77:0] tsu_ptp_rx_timer_in;     // RX Timstamp value synchonized to PCLK
   // RAS - Timestamp parity protection
   input  [9:0] tsu_ptp_tx_timer_prty_in; // parity protection for tsu_ptp_tx_timer_in
   input  [9:0] tsu_ptp_rx_timer_prty_in; // parity protection for tsu_ptp_rx_timer_in

   // pclk domain
   output        one_step_sync_mode;      // enable ts insertion into sync frames
   output        oss_correction_field;    // enable update of correction field in sync frames
   output        ext_tsu_timer_en;        // select external tsu timer port

   output [(32*p_num_type1_screeners):0]   screener_type1_regs; //
   output [(32*p_num_type2_screeners):0]   screener_type2_regs; //
   output [(43*p_num_scr2_compare_regs):0] scr2_compare_regs;   //
   output [(16*p_num_scr2_ethtype_regs):0] scr2_ethtype_regs;   //

   output [47:0] tx_pbuf_segments;
   output [p_edma_queues-1:0] tx_disable_queue;
   output [p_edma_queues-1:0] rx_disable_queue;
   // Credit Based Shaping support
   output    [1:0] cbs_enable;            // Enable for CBS queues
   output    [3:0] cbs_q_a_id;
   output    [3:0] cbs_q_b_id;
   output   [31:0] idleslope_q_a;         // Rate of Change of credit for Queue A
   output   [31:0] idleslope_q_b;         // Rate of Change of credit for Queue B
   output   [31:0] port_tx_rate;          // Transmit Rate
   output   [31:0] dwrr_ets_control;
   output   [127:0] bw_rate_limit;

   //jumbo packet max length
   output   [13:0] jumbo_max_length;      // progammable max length
   output          ext_rxq_sel_en;        // enable external receive queue selection

   // when software configuration of fifo / dma is available
   // enable ext fif port
   output          soft_config_fifo_en;   // use ext fifo port

  // AXI specific
   output          use_aw2b_fill;         //
   output   [7:0]  max_num_axi_ar2r;      //
   output   [7:0]  max_num_axi_aw2w;      //

   output   [14:0] rsc_en;                //

    // 64b addressing support and extended BD from reg_top
   output  [31:0] upper_tx_q_base_addr;   // upper 32b base address for tx buffer descriptors
   output   [3:0] upper_tx_q_base_par;
   output  [31:0] upper_rx_q_base_addr;   // upper 32b base address for rx buffer descriptors
   output   [3:0] upper_rx_q_base_par;
   output         dma_addr_bus_width;

   output         tx_bd_extended_mode_en;
   output   [1:0] tx_bd_ts_mode;

   output         rx_bd_extended_mode_en;
   output   [1:0] rx_bd_ts_mode;

   output         sel_mii_on_rgmii;       // reconfigures RGMII interface for MII operation

   // EnST signals
   output [7:0]   enst_en;                // Disable/Enable vector for the EnST module
   output [255:0] start_time;             // start_time of the transmission
   output [135:0] on_time;                // on time of the transmission expressed in bytes
   output [135:0] off_time;               // off time of the transmission expressed in bytes

   // ASF external status inputs
   input         asf_dap_paddr_err;       // Parity check error on paddr
   input         asf_dap_prdata_err;      // Parity check error on prdata
   input         asf_dap_rdata_err;       // Parity check error on rdata
   input         asf_csr_pcs_err;         // There was a parity error in PCS registers
   input         asf_csr_mmsl_err;        // There was a parity error in MMSL registers
   input         asf_dap_pcs_tx_err;      // Fault in PCS TX datapath
   input         asf_dap_pcs_rx_err;      // Fault in PCS RX datapath
   input         asf_dap_mmsl_tx_err;     // Fault in MMSL TX datapath
   input         asf_dap_mmsl_rx_err;     // Fault in MMSL RX datapath

   // Link Fault Signalling
   input         link_fault_signal_en;    // 802.3cb link fault signalling enabled
   input   [1:0] link_fault_status;       // 00 - OK; 01 - local fault; 10 - remote fault; 11 - link interruption

   // ASF - from SRAM protection
   input                   tx_corr_err;   // Correctable error for TX SRAM
   input                   tx_uncorr_err; // Uncorrectable error for TX SRAM
   input   [p_edma_tx_pbuf_addr-1:0]
                           tx_err_addr;   // Address of TX SRAM error
   input                   rx_corr_err;   // Correctable error for RX SRAM
   input                   rx_uncorr_err; // Uncorrectable error for RX SRAM
   input   [p_edma_rx_pbuf_addr-1:0]
                          rx_err_addr;    // Address of RX SRAM error

   input  asf_dap_dma_err;                // Parity error in DMA domain
   input  asf_dap_txclk_err;              // Parity error in tx clock domain
   input  asf_dap_rxclk_err;              // Parity error in rx clock domain
   input  asf_integrity_dma_err;          // Integrity fault detected in DMA
   input  asf_integrity_tsu_err;          // Fault detected in TSU protection
   input  asf_integrity_tx_sched_err;     // Fault detected in Transmit Scheduling
   input  asf_host_trans_to_err;          // Host transaction timeout

   // RAS - signals from lockup detection
   input tx_lockup_detected;              // TX lockup detection
   input rx_lockup_detected;              // RX lockup detection
   input dma_tx_lockup_detected;          // TX lockup detection
   input dma_rx_lockup_detected;          // RX lockup detection

   // RAS - signals going to lockup detection
   output        tx_lockup_mon_en;        // Enable the TX lockup detector
   output        rx_lockup_mon_en;        // Enable the RX lockup detector
   output        dma_tx_lockup_mon_en;    // Enable the TX lockup detector
   output        dma_rx_lockup_mon_en;    // Enable the RX lockup detector
   output [p_edma_queues-1:0]
                 dma_tx_lockup_q_en;      // Per queue enable
   output [15:0] lockup_prescale_val;     // Prescale timer
   output [10:0] dma_lockup_time;         // lockup time for DMA
   output [10:0] tx_mac_lockup_time;      // lockup time for MAC TX
   output [15:0] rx_mac_lockup_time;      // lockup time for MAC RX

   // 802.1CB control and status
   output [15:0]  frer_to_cnt;            // Count of number of frer_to_cnt_tog
                                          // without passing frames before timeout
   output [15:0]  frer_rtag_ethertype;    // Ethertype for redundancy tag detect
   output         frer_strip_rtag;        // Strip redundancy tags
   output         frer_6b_tag;            // R-Tag is 6-bytes not 4 bytes
   output [p_gem_num_cb_streams-1:0]
                  frer_en_vec_alg;        // Select which algorithm to use.
   output [p_gem_num_cb_streams-1:0]
                  frer_use_rtag;          // Set to use RTag or offset for seqnum

   output [(p_gem_num_cb_streams*9)-1:0]
                  frer_seqnum_oset;       // Offset into frame for seqnum
   output [(p_gem_num_cb_streams*5)-1:0]
                  frer_seqnum_len;        // Number of bits of seqnum to use
   output [(p_gem_num_cb_streams*4)-1:0]
                  frer_scr_sel_1;         // Screener match for stream 1
   output [(p_gem_num_cb_streams*4)-1:0]
                  frer_scr_sel_2;         // Screener match for stream 2
   output [(p_gem_num_cb_streams*6)-1:0]
                  frer_vec_win_sz;        // History depth to use for vec rcv alg

   output [p_gem_num_cb_streams-1:0]
                  frer_en_elim;           // Enable 802.1CB elimination function
   output [p_gem_num_cb_streams-1:0]
                  frer_en_to;             // Enable 802.1CB timeout function

   input  [p_gem_num_cb_streams-1:0]
                  frer_to_tog;            // Toggle to indicate timeout occurred
   input  [p_gem_num_cb_streams-1:0]
                  frer_rogue_tog;         // Toggle to indicate rogue frame rcvd
   input  [p_gem_num_cb_streams-1:0]
                  frer_ooo_tog;           // Toggle to indicate out of order frame
   input  [p_gem_num_cb_streams-1:0]
                  frer_err_upd_tog;       // Toggle to enable update latent errors
   input  [(p_gem_num_cb_streams*7)-1:0]
                  frer_err_upd_val;       // Incrememt value, use with above

   output [(32*p_edma_queues)-1:0]
                  rx_q_flush;             // Rx traffic policing

   output [(32*p_num_type2_screeners):0]  // rate limiting algorithm
                  scr2_rate_lim;

   input  [p_num_type2_screeners:0]       // statistic registers for per-type2 screeners rate limiting functionality
                  scr_excess_rate;

   input          frame_flushed_tog;      // toggle to stats, indicating a frame flushed by mode2, 3, or 4

   // AXI QoS configuration
   output [(8*p_edma_queues)-1:0]
                  axi_qos_q_mapping;

   // ASF configuration
   output         asf_trans_to_en;
   output [15:0]  asf_trans_to_time;

   // ASF comman output error indications
   output         asf_sram_corr_err;      // SRAM correctable error indication
   output         asf_sram_uncorr_err;    // SRAM uncorrectable error indication
   output         asf_dap_err;            // Data and Address Paths error indication
   output         asf_csr_err;            // Configuration and Status Registers error indication
   output         asf_trans_to_err;       // Transaction Timeouts indication
   output         asf_protocol_err;       // Protocol error indication
   output         asf_integrity_err;      // Integrity error indication
   // ASF and fatal and non-fatal interrupts
   output         asf_int_nonfatal;       // ASF non-fatal interrupt
   output         asf_int_fatal;          // ASF fatal interrupt

   // internal wire and reg declarations.

   // signals going from pclk_syncs to gem_registers for tx status & statistics.
   wire          tx_mac_ok_pclk;          // pclk pulse for frame txed OK
   wire          tx_late_col_mac_pclk;    // pclk pulse on late collision frame.
   wire          tx_ok_pclk;              // pclk pulse for frame txed OK
   wire          tx_ok_mod_pclk;          // moderated pclk pulse for frame txed OK
   wire   [13:0] tx_bytes_pclk;           // Number of bytes in frame txed OK
   wire          tx_broadcast_pclk;       // pclk pulse for broadcast txed OK
   wire          tx_multicast_pclk;       // pclk pulse for multicast txed OK
   wire          tx_single_col_pclk;      // pclk pulse when frame eventually
                                          // txed OK but had a single collision.
   wire          tx_multi_col_pclk;       // pclk pulse when frame eventually
                                          // txed OK but had multiple collisions
   wire          tx_late_col_pclk;        // pclk pulse on late collision frame.
   wire          tx_deferred_pclk;        // pclk pulse if frame was deferred.
   wire          tx_crs_err_pclk;         // pclk pulse if frame had crs error.
   wire          tx_coll_occ_pclk;        // pclk pulse if frame had a collision
   wire          tx_toomanyretry_pclk;    // pclk pulse if frame had too many
                                          // retries.
   wire          tx_pause_zero_pclk;      // pclk pulse when pause timer reaches
                                          // zero or zero pause frame rxed.
   wire          tx_pause_ok_pclk;        // pclk pulse for 802.3 pause frame
                                          // txed OK
   wire          tx_pfc_pause_ok_pclk;    // pclk pulse for PFC pause frame
                                          // txed OK
   wire   [15:0] tx_pause_time_pclk;      // Pause timer value synced to pclk.
   wire          tx_underrun_pclk;        // pclk pulse when tx underrun occured
   wire          tx_buffers_ex_pclk;      // pclk pulse when tx buffers are
                                          // exhausted.
   wire          tx_buff_ex_mid_pclk;     // pclk pulse when tx buffers are
                                          // exhausted mid frame.
   wire          tx_hresp_notok_pclk;     // pclk pulse when hresp not OK
                                          // happened during TX DMA.
   wire   [3:0]  tx_dma_int_queue_pclk;   // pclk pulse
   wire   [3:0]  rx_dma_int_queue_pclk;   // pclk pulse
   wire   [31:0] tx_dma_descr_ptr_pclk;   // Descriptor queue pointer for debug
   wire          tx_go_pclk;              // tx_go from DMA resynced to pclk.
   wire [(p_edma_queues*32)-1:0] tx_dma_descr_ptr_local; // A local verison with the pclk
                                          // synced version for queue 0.

   // signals going from pclk_syncs to gem_registers for rx status & statistics.
   wire          ok_to_update_rx_stats;   // OK to update the stats
   wire          rx_mac_ok_pclk;          // pclk pulse for frame rxed OK
   wire          rx_ok_pclk;              // pclk pulse for frame rxed OK
   wire          rx_ok_mod_pclk;          // moderated pclk pulse for frame rxed OK
   wire   [13:0] rx_bytes_pclk;           // Number of bytes in frame rxed OK
   wire          rx_broadcast_pclk;       // pclk pulse for broadcast rxed OK
   wire          rx_multicast_pclk;       // pclk pulse for multicast rxed OK
   wire          rx_align_err_pclk;       // pclk pulse when rx frame discarded
                                          // because of an alignment error.
   wire          rx_crc_err_pclk;         // pclk pulse when rx frame discarded
                                          // because of a CRC/FCS error.
   wire          rx_short_err_pclk;       // pclk pulse when rx frame discarded
                                          // because of a too short error.
   wire          rx_long_err_pclk;        // pclk pulse when rx frame discarded
                                          // because of a too long error.
   wire          rx_jabber_err_pclk;      // pclk pulse when rx frame discarded
                                          // because of a jabber error.
   wire          rx_symbol_err_pclk;      // pclk pulse when rx frame discarded
                                          // because of a symbol error.
   wire          rx_pause_ok_pclk;        // pclk pulse for 802.3 or PFC
                                          // pause frame rxed OK.
   wire          rx_pause_nz_pclk;        // pclk pulse for 802.3 or PFC pause
                                          // frame with non-zero quantum rxed OK
   wire          rx_length_err_pclk;      // pclk pulse when rx frame discarded
                                          // because of a length field error.
   wire          rx_ip_ck_err_pclk;       // pclk pulse when rx frame discarded
                                          // because of a IP checksum error.
   wire          rx_tcp_ck_err_pclk;      // pclk pulse when rx frame discarded
                                          // because of a TCP checksum error.
   wire          rx_udp_ck_err_pclk;      // pclk pulse when rx frame discarded
                                          // because of a UDP checksum error.
   wire          rx_overflow_pclk;        // pclk pulse when the RX pipeline or
                                          // FIFO overflowed due to bandwidth.
   wire          pfc_negotiate_pclk;      // synchronise pfc_negotiate
   wire   [7:0]  rx_pfc_paused_pclk;      // synchronise rx_pfc_paused
   wire          rx_buff_not_rdy_pclk;    // pclk pulse when used bit was read
                                          // during RX DMA operation.
   wire          rx_resource_err_pclk;    // pclk pulse when rx frame discarded
                                          // because a buffer was unavailable.
   wire          rx_hresp_notok_pclk;     // pclk pulse when the RX pipeline or
                                          // FIFO overflowed due to bandwidth.
   wire          rx_dma_pkt_flushed_pclk;


   wire   [31:0] rx_dma_descr_ptr_pclk;   // Descriptor queue pointer for debug
   wire [(p_edma_queues*32)-1:0] rx_dma_descr_ptr_local; // A local verison with the pclk
   wire          lpi_indicate_pclk;       // rx LPI indication has been detected
   wire          lpi_indicate_del;        // lpi_indicate_pclk delayed by one pclk
   wire          wol_pulse;               // wake on LAN indication pclk synced
   wire  [p_gem_num_cb_streams-1:0]
                 frer_to_pulse;           // indicate timeout occurred
   wire  [p_gem_num_cb_streams-1:0]
                 frer_rogue_pulse;        // indicate rogue frame rcvd
   wire  [p_gem_num_cb_streams-1:0]
                 frer_ooo_pulse;          // indicate out of order frame
   wire  [p_gem_num_cb_streams-1:0]
                 frer_err_upd_pulse;      // enable update of latent errors

   // signals going from pclk_syncs to gem_registers for other status
   wire          ext_interrupt_pclk;      // pclk pulse when an external
                                          // interrupt was detected.
   wire          ptp_sync_tx_int;         // PTP sync frame transmit interrupt
   wire          ptp_del_tx_int;          // PTP delay_req frame transmit
                                          // interrupt
   wire          ptp_pdel_req_tx_int;     // PTP pdelay_req transmit interrupt
   wire          ptp_pdel_resp_tx_int;    // PTP pdelay_resp transmit
                                          // interrupt
   wire          ptp_sync_rx_int;         // PTP sync frame receive interrupt
   wire          ptp_del_rx_int;          // PTP delay_req frame receive
                                          // interrupt
   wire          ptp_pdel_req_rx_int;     // PTP pdelay_req receive interrupt
   wire          ptp_pdel_resp_rx_int;    // PTP pdelay_resp receive
                                          // interrupt
   wire          tsu_incr_sec_int;        // Timer seconds increment interrupt
   wire          ptp_tx_time_load;        // load timer value to PTP event
                                          // transmitted register
   wire          ptp_rx_time_load;        // load timer value to PTP event
                                          // received register
   wire          ptp_tx_ptime_load;       // load timer value to peer event
                                          // transmitted register
   wire          ptp_rx_ptime_load;       // load timer value to peer event
                                          // received register
   wire          timer_cmp_val_int;       // TSU timer comparison valid interrupt

   wire  [77:0]  tsu_timer_cnt_pclk;      // TSU timer count value, pclk timed
   wire  [9:0]   tsu_timer_cnt_par_pclk;  // Parity matching tsu_timer_cnt_pclk
   wire          tsu_timer_cnt_pclk_vld;  // TSU timer count value, validates above
   wire          timer_str_sync;          // write timer sync strobe registers

   wire          tx_frame_too_large_pclk;
   wire          axi_xaction_out_pclk;
   wire          disable_tx_pclk;
   wire          disable_rx_pclk;

   wire  [(p_edma_tx_pbuf_addr*p_edma_queues)-1:0] tx_dpram_fill_lvl_dbg;
   wire  [p_edma_rx_pbuf_addr-1:0] rx_dpram_fill_lvl_dbg;
   wire  [4:0]   sel_dpram_fill_lvl_dbg;
   wire [15:0]   dpram_fill_lvl_pclk;
   wire [15:0]   rx_dpram_fill_lvl_pad_pclk;

   wire          frame_flushed_pclk;
   wire [p_num_type2_screeners:0] scr_excess_rate_pclk;

   // RSC specific
   wire [p_edma_queues-1:0] rsc_clr_tog;  // Receive Side Coalescing clear
   wire [p_edma_queues-1:0] rsc_clr_sync; // Receive Side Coalescing clear Sync

   wire   [31:0] int_moderation;          // interrupt moderation register value

   // ASF - signals going to gem_registers for statistics and status
   wire          asf_sram_corr_fault;
   wire  [7:0]   asf_sram_corr_fault_stats_upd;
   wire  [31:0]  asf_sram_corr_fault_status;
   wire          asf_sram_uncorr_fault;
   wire  [31:0]  asf_sram_uncorr_fault_status;

   wire asf_dap_txclk_err_pclk;           // synchronised to pclk
   wire asf_dap_rxclk_err_pclk;           // synchronised to pclk
   wire asf_dap_dma_err_pclk;             // synchronised to pclk
   wire asf_integrity_dma_err_pclk;       // Synchronised to pclk
   wire asf_integrity_tsu_err_pclk;       // Synchronised to pclk
   wire asf_integrity_tx_sched_err_pclk;  // Synchronised to pclk
   wire asf_host_trans_to_err_pclk;       // Synchronised to pclk
   wire asf_dap_rdata_err_pclk;

   wire [1:0] link_fault_status_pclk;
   wire       mdio_in_pclk;

   // Only queue 0's pointer passes through a re-synchronisation stage, so we have to
   // mux that version in.

generate if (p_edma_queues > 32'd1) begin : gen_set_descr_ptr
      assign tx_dma_descr_ptr_local = {tx_dma_descr_ptr[(p_edma_queues*32)-1:32], tx_dma_descr_ptr_pclk};
      assign rx_dma_descr_ptr_local = {rx_dma_descr_ptr[(p_edma_queues*32)-1:32], rx_dma_descr_ptr_pclk};
end else begin : gen_1_q
      assign tx_dma_descr_ptr_local = tx_dma_descr_ptr_pclk;
      assign rx_dma_descr_ptr_local = rx_dma_descr_ptr_pclk;
end
endgenerate


gem_registers  #(
    .grouped_params(grouped_params)
   ) i_gem_registers (

   // system inputs.
   .n_preset             (n_preset),
   .pclk                 (pclk),

   // APB interface signals.
   .paddr                (paddr),
   .prdata               (prdata),
   .prdata_par           (prdata_par),
   .pwdata               (pwdata),
   .pwdata_par           (pwdata_par),
   .pwrite               (pwrite),
   .penable              (penable),
   .psel                 (psel),
   .perr                 (perr),

   // other top level signals.
   .mdio_in              (mdio_in_pclk),
   .mdio_en              (mdio_en),
   .mdio_out             (mdio_out),
   .mdc                  (mdc),
   .ethernet_int         (ethernet_int),
   .loopback             (loopback),
   .half_duplex          (half_duplex),
   .speed_mode           (speed_mode),
   .tx_byte_mode         (tx_byte_mode),
   .rx_no_crc_check      (rx_no_crc_check),
   .user_out             (user_out),
   .user_in              (user_in),

   .ptp_pdel_req_tx_int   (ptp_pdel_req_tx_int),
   .ptp_pdel_resp_tx_int  (ptp_pdel_resp_tx_int),
   .ptp_sync_rx_int       (ptp_sync_rx_int),
   .ptp_del_rx_int        (ptp_del_rx_int),
   .ptp_pdel_req_rx_int   (ptp_pdel_req_rx_int),
   .ptp_pdel_resp_rx_int  (ptp_pdel_resp_rx_int),
   .ptp_sync_tx_int       (ptp_sync_tx_int),
   .ptp_del_tx_int        (ptp_del_tx_int),

   .tsu_timer_sec         (tsu_timer_sec),
   .tsu_timer_nsec        (tsu_timer_nsec),
   .tsu_timer_sec_wr      (tsu_timer_sec_wr),
   .tsu_timer_nsec_wr     (tsu_timer_nsec_wr),
   .tsu_timer_adj_ctrl    (tsu_timer_adj_ctrl),
   .tsu_timer_adj         (tsu_timer_adj),
   .tsu_timer_adj_wr      (tsu_timer_adj_wr),
   .tsu_timer_incr        (tsu_timer_incr),
   .tsu_timer_incr_wr     (tsu_timer_incr_wr),
   .tsu_timer_alt_incr    (tsu_timer_alt_incr),
   .tsu_timer_num_incr    (tsu_timer_num_incr),
   .tsu_incr_sec_int      (tsu_incr_sec_int),
   .ptp_tx_time_load      (ptp_tx_time_load),
   .ptp_rx_time_load      (ptp_rx_time_load),
   .ptp_tx_ptime_load     (ptp_tx_ptime_load),
   .ptp_rx_ptime_load     (ptp_rx_ptime_load),
   .tsu_timer_nsec_cmp    (tsu_timer_nsec_cmp),
   .tsu_timer_nsec_cmp_wr (tsu_timer_nsec_cmp_wr),
   .tsu_timer_sec_cmp     (tsu_timer_sec_cmp),
   .timer_cmp_val_int     (timer_cmp_val_int),
   .tsu_ptp_tx_timer_in   (tsu_ptp_tx_timer_in),
   .tsu_ptp_rx_timer_in   (tsu_ptp_rx_timer_in),
   .tsu_ptp_tx_timer_par_in (tsu_ptp_tx_timer_prty_in),
   .tsu_ptp_rx_timer_par_in (tsu_ptp_rx_timer_prty_in),
   // pclk domain
   .one_step_sync_mode    (one_step_sync_mode),
   .oss_correction_field  (oss_correction_field),
   .tsu_timer_cnt_pclk_vld(tsu_timer_cnt_pclk_vld),
   .tsu_timer_cnt_par_pclk(tsu_timer_cnt_par_pclk),
   .tsu_timer_cnt_pclk    (tsu_timer_cnt_pclk),
   .timer_strobe          (timer_str_sync),
   .ext_tsu_timer_en      (ext_tsu_timer_en),

   // signals going to gem_registers for tx status & statistics.
   .tx_mac_ok_pclk       (tx_mac_ok_pclk),
   .tx_late_col_mac_pclk (tx_late_col_mac_pclk),
   .tx_ok_pclk           (tx_ok_pclk),
   .tx_ok_mod_pclk       (tx_ok_mod_pclk),
   .tx_bytes_pclk        (tx_bytes_pclk),
   .tx_broadcast_pclk    (tx_broadcast_pclk),
   .tx_multicast_pclk    (tx_multicast_pclk),
   .tx_single_col_pclk   (tx_single_col_pclk),
   .tx_multi_col_pclk    (tx_multi_col_pclk),
   .tx_late_col_pclk     (tx_late_col_pclk),
   .tx_deferred_pclk     (tx_deferred_pclk),
   .tx_crs_err_pclk      (tx_crs_err_pclk),
   .tx_coll_occ_pclk     (tx_coll_occ_pclk),
   .tx_toomanyretry_pclk (tx_toomanyretry_pclk),
   .tx_pause_zero_pclk   (tx_pause_zero_pclk),
   .tx_pause_ok_pclk     (tx_pause_ok_pclk),
   .tx_pfc_pause_ok_pclk (tx_pfc_pause_ok_pclk),
   .tx_pause_time_pclk   (tx_pause_time_pclk),
   .tx_underrun_pclk     (tx_underrun_pclk),
   .tx_buffers_ex_pclk   (tx_buffers_ex_pclk),
   .tx_buff_ex_mid_pclk  (tx_buff_ex_mid_pclk),
   .tx_hresp_notok_pclk  (tx_hresp_notok_pclk),
   .tx_dma_descr_ptr     (tx_dma_descr_ptr_local),
   .tx_go_pclk           (tx_go_pclk),

   // signals going to gem_registers for rx status & statistics.
   .ok_to_update_rx_stats   (ok_to_update_rx_stats),
   .rx_mac_ok_pclk          (rx_mac_ok_pclk),
   .rx_ok_pclk              (rx_ok_pclk),
   .rx_ok_mod_pclk          (rx_ok_mod_pclk),
   .rx_bytes_pclk           (rx_bytes_pclk),
   .rx_broadcast_pclk       (rx_broadcast_pclk),
   .rx_multicast_pclk       (rx_multicast_pclk),
   .rx_align_err_pclk       (rx_align_err_pclk),
   .rx_crc_err_pclk         (rx_crc_err_pclk),
   .rx_short_err_pclk       (rx_short_err_pclk),
   .rx_long_err_pclk        (rx_long_err_pclk),
   .rx_jabber_err_pclk      (rx_jabber_err_pclk),
   .rx_symbol_err_pclk      (rx_symbol_err_pclk),
   .rx_pause_ok_pclk        (rx_pause_ok_pclk),
   .rx_dma_pkt_flushed_pclk (rx_dma_pkt_flushed_pclk),
   .rx_pause_nz_pclk        (rx_pause_nz_pclk),
   .rx_dma_overrun_pclk     (rx_overflow_pclk),
   .rx_length_err_pclk      (rx_length_err_pclk),
   .rx_ip_ck_err_pclk       (rx_ip_ck_err_pclk),
   .rx_tcp_ck_err_pclk      (rx_tcp_ck_err_pclk),
   .rx_udp_ck_err_pclk      (rx_udp_ck_err_pclk),
   .rx_overflow_pclk        (rx_overflow_pclk),
   .rx_buff_not_rdy_pclk    (rx_buff_not_rdy_pclk),
   .rx_resource_err_pclk    (rx_resource_err_pclk),
   .rx_hresp_notok_pclk     (rx_hresp_notok_pclk),
   .rx_dma_descr_ptr        (rx_dma_descr_ptr_local),
   .tx_dma_int_queue        (tx_dma_int_queue_pclk),
   .rx_dma_int_queue        (rx_dma_int_queue_pclk),
   .pfc_negotiate_pclk      (pfc_negotiate_pclk),
   .rx_pfc_paused_pclk      (rx_pfc_paused_pclk),
   .lpi_indicate_pclk       (lpi_indicate_pclk),
   .lpi_indicate_del        (lpi_indicate_del),
   .wol_pulse               (wol_pulse),

   .tx_frame_too_large_pclk(tx_frame_too_large_pclk),
   .axi_xaction_out_pclk (axi_xaction_out_pclk),
   .disable_tx_pclk      (disable_tx_pclk),
   .disable_rx_pclk      (disable_rx_pclk),

   // signals going to gem_registers for other status
   .ext_interrupt_pclk   (ext_interrupt_pclk),

   // signals coming from gem_pcs_register.
   .pcs_link_state       (pcs_link_state),
   .pcs_an_complete      (pcs_an_complete),
   .np_data_int          (np_data_int),
   .mac_pause_tx_en      (mac_pause_tx_en),
   .mac_pause_rx_en      (mac_pause_rx_en),
   .mac_full_duplex      (mac_full_duplex),

   // signals going to gem_dma_top.
   .rx_dma_descr_base_addr(rx_dma_descr_base_addr),
   .rx_dma_descr_base_par (rx_dma_descr_base_par),
   .tx_dma_descr_base_addr(tx_dma_descr_base_addr),
   .tx_dma_descr_base_par (tx_dma_descr_base_par),
   .rx_dma_buffer_size   (rx_dma_buffer_size),
   .rx_dma_buffer_offset (rx_dma_buffer_offset),
   .new_receive_q_ptr    (new_receive_q_ptr),
   .new_transmit_q_ptr   (new_transmit_q_ptr),
   .tx_start_pclk        (tx_start_pclk),
   .tx_halt_pclk         (tx_halt_pclk),
   .flush_rx_pkt_pclk    (flush_rx_pkt_pclk),
   .hdr_data_splitting_en(hdr_data_splitting_en),
   .inf_last_dbuf_size_en(infinite_last_dbuf_size_en),
   .ahb_burst_length     (ahb_burst_length),
   .endian_swap          (endian_swap),


   //signals going to gem_dma_top and gem_mac.
   .enable_transmit      (enable_transmit),
   .enable_receive       (enable_receive),
   .dma_bus_width        (dma_bus_width),

   // signals going to packet buffers
   .rx_pbuf_size         (rx_pbuf_size),
   .rx_cutthru_threshold (rx_cutthru_threshold),
   .rx_cutthru           (rx_cutthru),
   .rx_fill_level_low    (rx_fill_level_low),
   .rx_fill_level_high   (rx_fill_level_high),
   .crc_error_report     (crc_error_report),
   .tx_pbuf_size         (tx_pbuf_size),
   .tx_pbuf_tcp_en       (tx_pbuf_tcp_en),
   .tx_cutthru_threshold (tx_cutthru_threshold),
   .tx_cutthru           (tx_cutthru),

   //signals going to gem_pcs
   .alt_sgmii_mode       (alt_sgmii_mode),
   .sgmii_mode           (sgmii_mode),
   .uni_direct_en        (uni_direct_en),

   // signals going to gem_mac
   .ign_ipg_rx_er        (ign_ipg_rx_er),
   .rx_bad_preamble      (rx_bad_preamble),
   .stretch_enable       (stretch_enable),
   .stretch_ratio        (stretch_ratio),
   .min_ifg              (min_ifg),
   .retry_test           (retry_test),
   .tx_pause_quantum        (tx_pause_quantum),
   .tx_pause_quantum_par    (tx_pause_quantum_par),
   .tx_pause_quantum_p1     (tx_pause_quantum_p1),
   .tx_pause_quantum_p1_par (tx_pause_quantum_p1_par),
   .tx_pause_quantum_p2     (tx_pause_quantum_p2),
   .tx_pause_quantum_p2_par (tx_pause_quantum_p2_par),
   .tx_pause_quantum_p3     (tx_pause_quantum_p3),
   .tx_pause_quantum_p3_par (tx_pause_quantum_p3_par),
   .tx_pause_quantum_p4     (tx_pause_quantum_p4),
   .tx_pause_quantum_p4_par (tx_pause_quantum_p4_par),
   .tx_pause_quantum_p5     (tx_pause_quantum_p5),
   .tx_pause_quantum_p5_par (tx_pause_quantum_p5_par),
   .tx_pause_quantum_p6     (tx_pause_quantum_p6),
   .tx_pause_quantum_p6_par (tx_pause_quantum_p6_par),
   .tx_pause_quantum_p7     (tx_pause_quantum_p7),
   .tx_pause_quantum_p7_par (tx_pause_quantum_p7_par),
   .tx_pause_frame_req   (tx_pause_frame_req),
   .tx_pause_frame_zero  (tx_pause_frame_zero),
   .tx_pfc_frame_req     (tx_pfc_frame_req),
   .tx_pfc_frame_pri     (tx_pfc_frame_pri),
   .tx_pfc_frame_pri_par (tx_pfc_frame_pri_par),
   .tx_pfc_frame_zero    (tx_pfc_frame_zero),
   .tx_lpi_en            (tx_lpi_en),
   .ifg_eats_qav_credit  (ifg_eats_qav_credit),
   .pause_enable         (pause_enable),
   .rx_1536_en           (rx_1536_en),
   .jumbo_enable         (jumbo_enable),
   .force_discard_on_err (force_discard_on_err),
   .force_max_ahb_burst_rx (force_max_ahb_burst_rx),
   .force_max_ahb_burst_tx (force_max_ahb_burst_tx),

   .check_rx_length      (check_rx_length),
   .strip_rx_fcs         (strip_rx_fcs),
   .store_udp_offset     (store_udp_offset),
   .store_rx_ts          (store_rx_ts),

   .pfc_enable           (pfc_enable),
   .ptp_unicast_ena      (ptp_unicast_ena),
   .rx_ptp_unicast       (rx_ptp_unicast),
   .tx_ptp_unicast       (tx_ptp_unicast),

   // signals going to gem_mac (gem_filter).
   .back_pressure        (back_pressure),
   .full_duplex          (full_duplex),
   .loopback_local       (loopback_local),
   .en_half_duplex_rx    (en_half_duplex_rx),
   .rx_no_pause_frames   (rx_no_pause_frames),
   .rx_toe_enable        (rx_toe_enable),
   .ext_match_en         (ext_match_en),
   .uni_hash_en          (uni_hash_en),
   .multi_hash_en        (multi_hash_en),
   .no_broadcast         (no_broadcast),
   .copy_all_frames      (copy_all_frames),
   .rm_non_vlan          (rm_non_vlan),
   .hash                 (hash),
   .spec_add_filter_regs  (spec_add_filter_regs),
   .spec_add_filter_active(spec_add_filter_active),
   .mask_add1            (mask_add1),
   .spec_add1_tx         (spec_add1_tx),
   .spec_add1_tx_par     (spec_add1_tx_par),
   .spec_type1           (spec_type1),
   .spec_type2           (spec_type2),
   .spec_type3           (spec_type3),
   .spec_type4           (spec_type4),
   .spec_type1_active    (spec_type1_active),
   .spec_type2_active    (spec_type2_active),
   .spec_type3_active    (spec_type3_active),
   .spec_type4_active    (spec_type4_active),
   .stacked_vlantype     (stacked_vlantype),
   .dma_addr_or_mask     (dma_addr_or_mask),
   .wol_ip_addr          (wol_ip_addr),

   .screener_type1_regs  (screener_type1_regs),
   .screener_type2_regs  (screener_type2_regs),
   .scr2_compare_regs    (scr2_compare_regs),
   .scr2_ethtype_regs    (scr2_ethtype_regs),

   .wol_mask             (wol_mask),
   .tx_pbuf_segments     (tx_pbuf_segments),
   .tx_disable_queue     (tx_disable_queue),
   .rx_disable_queue     (rx_disable_queue),

   .cbs_enable           (cbs_enable),
   .cbs_q_a_id           (cbs_q_a_id),
   .cbs_q_b_id           (cbs_q_b_id),
   .idleslope_q_a        (idleslope_q_a),
   .idleslope_q_b        (idleslope_q_b),
   .port_tx_rate         (port_tx_rate),

   .dwrr_ets_control     (dwrr_ets_control),
   .bw_rate_limit        (bw_rate_limit),
   .soft_config_fifo_en  (soft_config_fifo_en),

   .jumbo_max_length     (jumbo_max_length),

   .ext_rxq_sel_en       (ext_rxq_sel_en),
   .int_moderation       (int_moderation),

   .tw_sys_tx_time       (tw_sys_tx_time),

   // AXI specific
   .use_aw2b_fill        (use_aw2b_fill),
   .max_num_axi_ar2r     (max_num_axi_ar2r),
   .max_num_axi_aw2w     (max_num_axi_aw2w),

   .rsc_en                      (rsc_en),
   .rsc_clr                     (rsc_clr_sync),

   .upper_tx_q_base_addr        (upper_tx_q_base_addr),
   .upper_tx_q_base_par         (upper_tx_q_base_par),
   .upper_rx_q_base_addr        (upper_rx_q_base_addr),
   .upper_rx_q_base_par         (upper_rx_q_base_par),
   .dma_addr_bus_width          (dma_addr_bus_width),

   // Debug ports
   .sel_dpram_fill_lvl_dbg      (sel_dpram_fill_lvl_dbg),
   .dpram_fill_lvl_pclk         (dpram_fill_lvl_pclk),
   .rx_dpram_fill_lvl_pad_pclk  (rx_dpram_fill_lvl_pad_pclk),

   .axi_tx_full_adj_0           (axi_tx_full_adj_0),
   .axi_tx_full_adj_1           (axi_tx_full_adj_1),
   .axi_tx_full_adj_2           (axi_tx_full_adj_2),
   .axi_tx_full_adj_3           (axi_tx_full_adj_3),
   .restart_counter_top         (restart_counter_top),

   .tx_bd_extended_mode_en      (tx_bd_extended_mode_en),
   .tx_bd_ts_mode               (tx_bd_ts_mode),

   .rx_bd_extended_mode_en      (rx_bd_extended_mode_en),
   .rx_bd_ts_mode               (rx_bd_ts_mode),

   .sel_mii_on_rgmii            (sel_mii_on_rgmii),

   // EnST signals
   .enst_en                     (enst_en),
   .start_time                  (start_time),
   .on_time                     (on_time),
   .off_time                    (off_time),

   // Link Fault Signalling ...
   .link_fault_signal_en        (link_fault_signal_en),
   .link_fault_status_pclk      (link_fault_status_pclk),

   // ASF - signals going to fault rpt and log
   .asf_dap_paddr_err           (asf_dap_paddr_err),
   .asf_dap_prdata_err          (asf_dap_prdata_err),
   .asf_dap_rdata_err_pclk      (asf_dap_rdata_err_pclk),
   .asf_csr_pcs_err             (asf_csr_pcs_err),
   .asf_csr_mmsl_err            (asf_csr_mmsl_err),
   .asf_dap_pcs_tx_err          (asf_dap_pcs_tx_err),
   .asf_dap_pcs_rx_err          (asf_dap_pcs_rx_err),

   .asf_sram_corr_fault             (asf_sram_corr_fault),
   .asf_sram_corr_fault_stats_upd   (asf_sram_corr_fault_stats_upd),
   .asf_sram_corr_fault_status      (asf_sram_corr_fault_status),
   .asf_sram_uncorr_fault           (asf_sram_uncorr_fault),
   .asf_sram_uncorr_fault_status    (asf_sram_uncorr_fault_status),

   .asf_dap_txclk_err_pclk          (asf_dap_txclk_err_pclk),
   .asf_dap_rxclk_err_pclk          (asf_dap_rxclk_err_pclk),
   .asf_dap_dma_err_pclk            (asf_dap_dma_err_pclk),
   .asf_integrity_dma_err_pclk      (asf_integrity_dma_err_pclk),
   .asf_integrity_tsu_err_pclk      (asf_integrity_tsu_err_pclk),
   .asf_integrity_tx_sched_err_pclk (asf_integrity_tx_sched_err_pclk),
   .asf_host_trans_to_err_pclk      (asf_host_trans_to_err_pclk),

   // signals from lockup detection
   .tx_lockup_detected          (tx_lockup_detected),
   .rx_lockup_detected          (rx_lockup_detected),
   .dma_tx_lockup_detected      (dma_tx_lockup_detected),
   .dma_rx_lockup_detected      (dma_rx_lockup_detected),

   // signals going to lockup detection
   .tx_lockup_mon_en            (tx_lockup_mon_en),
   .rx_lockup_mon_en            (rx_lockup_mon_en),
   .dma_tx_lockup_mon_en        (dma_tx_lockup_mon_en),
   .dma_rx_lockup_mon_en        (dma_rx_lockup_mon_en),
   .dma_tx_lockup_q_en          (dma_tx_lockup_q_en),
   .lockup_prescale_val         (lockup_prescale_val),
   .dma_lockup_time             (dma_lockup_time),
   .tx_mac_lockup_time          (tx_mac_lockup_time),
   .rx_mac_lockup_time          (rx_mac_lockup_time),

   // 802.1CB Control and Status
   .frer_to_cnt                 (frer_to_cnt),
   .frer_rtag_ethertype         (frer_rtag_ethertype),
   .frer_strip_rtag             (frer_strip_rtag),
   .frer_6b_tag                 (frer_6b_tag),
   .frer_en_vec_alg             (frer_en_vec_alg),
   .frer_use_rtag               (frer_use_rtag),
   .frer_seqnum_oset            (frer_seqnum_oset),
   .frer_seqnum_len             (frer_seqnum_len),
   .frer_scr_sel_1              (frer_scr_sel_1),
   .frer_scr_sel_2              (frer_scr_sel_2),
   .frer_vec_win_sz             (frer_vec_win_sz),
   .frer_en_elim                (frer_en_elim),
   .frer_en_to                  (frer_en_to),
   .frer_to_pulse               (frer_to_pulse),
   .frer_rogue_pulse            (frer_rogue_pulse),
   .frer_ooo_pulse              (frer_ooo_pulse),
   .frer_err_upd_pulse          (frer_err_upd_pulse),
   .frer_err_upd_val            (frer_err_upd_val),

   // Rx traffic policing
   .rx_q_flush                  (rx_q_flush),

   // pulse signaling a frame being discarded because
   // of Mode2, 3 or 4 of rx traffic policing
   .frame_flushed_pclk          (frame_flushed_pclk),

   // rate limiting algorithm
   .scr2_rate_lim               (scr2_rate_lim),
   .scr_excess_rate_pclk        (scr_excess_rate_pclk),

   // AXI QoS configuration
   .axi_qos_q_mapping           (axi_qos_q_mapping),

   // ASF Configuration
   .asf_trans_to_en             (asf_trans_to_en),
   .asf_trans_to_time           (asf_trans_to_time),

   // ASF signalling
   .asf_sram_corr_err           (asf_sram_corr_err),
   .asf_sram_uncorr_err         (asf_sram_uncorr_err),
   .asf_dap_err                 (asf_dap_err),
   .asf_csr_err                 (asf_csr_err),
   .asf_trans_to_err            (asf_trans_to_err),
   .asf_protocol_err            (asf_protocol_err),
   .asf_integrity_err           (asf_integrity_err),
   .asf_int_nonfatal            (asf_int_nonfatal),
   .asf_int_fatal               (asf_int_fatal)

   );


gem_pclk_syncs #(
    .grouped_params(grouped_params)
  ) i_gem_pclk_syncs (

   // system inputs.
   .n_preset             (n_preset),
   .pclk                 (pclk),
   .tsu_clk              (tsu_clk),
   .n_tsureset           (n_tsureset),
   .n_txreset            (n_txreset),
   .tx_clk               (tx_clk),
   .n_hreset             (n_hreset),
   .hclk                 (hclk),
   .n_rxreset            (n_rxreset),
   .rx_clk               (rx_clk),

   // other top level signals.
   .ext_interrupt_in     (ext_interrupt_in),
   .mdio_in              (mdio_in),
   .mdio_in_pclk         (mdio_in_pclk),

   // handshaking between gem_mac and gem_reg_top.
   .tx_end_tog           (tx_end_tog),
   .tx_status_wr_tog     (tx_status_wr_tog),
   .rx_end_tog           (rx_end_tog),
   .rx_status_wr_tog     (rx_status_wr_tog),
   .tx_pause_tog_ack     (tx_pause_tog_ack),

   // signals coming from gem_tx.
   .tx_frame_txed_ok     (tx_frame_txed_ok),
   .tx_bytes_in_frame    (tx_bytes_in_frame),
   .tx_broadcast_frame   (tx_broadcast_frame),
   .tx_multicast_frame   (tx_multicast_frame),
   .tx_single_coll_frame (tx_single_coll_frame),
   .tx_multi_coll_frame  (tx_multi_coll_frame),
   .tx_late_coll_frame   (tx_late_coll_frame),
   .tx_deferred_tx_frame (tx_deferred_tx_frame),
   .tx_crs_error_frame   (tx_crs_error_frame),
   .tx_coll_occured      (tx_coll_occured),
   .tx_pause_time        (tx_pause_time),
   .tx_pause_time_tog    (tx_pause_time_tog),
   .tx_pause_frame_txed  (tx_pause_frame_txed),
   .tx_pfc_pause_frame_txed (tx_pfc_pause_frame_txed),

   // signals coming from gem_rx.
   .rx_frame_rxed_ok     (rx_frame_rxed_ok),
   .rx_bytes_in_frame    (rx_bytes_in_frame),
   .rx_broadcast_frame   (rx_broadcast_frame),
   .rx_multicast_frame   (rx_multicast_frame),
   .rx_align_error       (rx_align_error),
   .rx_crc_error         (rx_crc_error),
   .rx_short_error       (rx_short_error),
   .rx_long_error        (rx_long_error),
   .rx_jabber_error      (rx_jabber_error),
   .rx_symbol_error      (rx_symbol_error),
   .rx_pause_frame       (rx_pause_frame),
   .rx_pause_nonzero     (rx_pause_nonzero),
   .rx_length_error      (rx_length_error),
   .rx_ip_ck_error       (rx_ip_ck_error),
   .rx_tcp_ck_error      (rx_tcp_ck_error),
   .rx_udp_ck_error      (rx_udp_ck_error),
   .rx_dma_pkt_flushed   (rx_dma_pkt_flushed),
   .rx_pkt_dbuff_overflow(rx_pkt_dbuff_overflow),
   .rx_overflow          (rx_overflow),
   .pfc_negotiate        (pfc_negotiate),
   .rx_pfc_paused        (rx_pfc_paused),
   .lpi_indicate         (lpi_indicate),
   .wol                  (wol),
   .frer_to_tog          (frer_to_tog),
   .frer_rogue_tog       (frer_rogue_tog),
   .frer_ooo_tog         (frer_ooo_tog),
   .frer_err_upd_tog     (frer_err_upd_tog),

   // handshaking between gem_dma_top and gem_reg_top.
   .tx_dma_stable_tog    (tx_dma_stable_tog),
   .tx_dma_stat_capt_tog (tx_dma_stat_capt_tog),
   .rx_dma_stable_tog    (rx_dma_stable_tog),
   .rx_dma_stat_capt_tog (rx_dma_stat_capt_tog),

   // signals coming from gem_dma_tx.
   .tx_dma_complete_ok   (tx_dma_complete_ok),
   .tx_dma_buffers_ex    (tx_dma_buffers_ex),
   .tx_dma_buff_ex_mid   (tx_dma_buff_ex_mid),
   .tx_dma_go            (tx_dma_go),
   .tx_dma_hresp_notok   (tx_dma_hresp_notok),
   .tx_dma_late_col      (tx_dma_late_col),
   .tx_dma_toomanyretry  (tx_dma_toomanyretry),
   .tx_dma_underflow     (tx_dma_underflow),
   .tx_dma_int_queue     (tx_dma_int_queue),
   .tx_too_many_retries  (tx_too_many_retries),
   .tx_underflow_frame   (tx_underflow_frame),

   // signals coming from gem_dma_rx.
   .rx_dma_complete_ok   (rx_dma_complete_ok),
   .rx_dma_buff_not_rdy  (rx_dma_buff_not_rdy),
   .rx_dma_resource_err  (rx_dma_resource_err),
   .rx_dma_hresp_notok   (rx_dma_hresp_notok),
   .rx_dma_int_queue     (rx_dma_int_queue),

   .axi_tx_frame_too_large(axi_tx_frame_too_large),
   .axi_xaction_out      (axi_xaction_out),
   .disable_tx           (disable_tx),
   .disable_rx           (disable_rx),
   .tx_frame_too_large_pclk(tx_frame_too_large_pclk),
   .axi_xaction_out_pclk (axi_xaction_out_pclk),
   .disable_tx_pclk      (disable_tx_pclk),
   .disable_rx_pclk      (disable_rx_pclk),

   // signals going to gem_registers for tx status & statistics.
   .tx_ok_pclk           (tx_ok_pclk),
   .tx_ok_mod_pclk       (tx_ok_mod_pclk),
   .tx_mac_ok_pclk       (tx_mac_ok_pclk),
   .tx_late_col_mac_pclk (tx_late_col_mac_pclk),
   .tx_bytes_pclk        (tx_bytes_pclk),
   .tx_broadcast_pclk    (tx_broadcast_pclk),
   .tx_multicast_pclk    (tx_multicast_pclk),
   .tx_single_col_pclk   (tx_single_col_pclk),
   .tx_multi_col_pclk    (tx_multi_col_pclk),
   .tx_late_col_pclk     (tx_late_col_pclk),
   .tx_deferred_pclk     (tx_deferred_pclk),
   .tx_crs_err_pclk      (tx_crs_err_pclk),
   .tx_coll_occ_pclk     (tx_coll_occ_pclk),
   .tx_toomanyretry_pclk (tx_toomanyretry_pclk),
   .tx_pause_zero_pclk   (tx_pause_zero_pclk),
   .tx_pause_ok_pclk     (tx_pause_ok_pclk),
   .tx_pfc_pause_ok_pclk (tx_pfc_pause_ok_pclk),
   .tx_pause_time_pclk   (tx_pause_time_pclk),
   .tx_underrun_pclk     (tx_underrun_pclk),
   .tx_buffers_ex_pclk   (tx_buffers_ex_pclk),
   .tx_buff_ex_mid_pclk  (tx_buff_ex_mid_pclk),
   .tx_hresp_notok_pclk  (tx_hresp_notok_pclk),
   .tx_dma_int_queue_pclk(tx_dma_int_queue_pclk),
   .tx_go_pclk           (tx_go_pclk),

   // signals going to gem_registers for rx status & statistics.
   .ok_to_update_rx_stats   (ok_to_update_rx_stats),
   .rx_mac_ok_pclk          (rx_mac_ok_pclk),
   .rx_ok_pclk              (rx_ok_pclk),
   .rx_ok_mod_pclk          (rx_ok_mod_pclk),
   .rx_bytes_pclk           (rx_bytes_pclk),
   .rx_broadcast_pclk       (rx_broadcast_pclk),
   .rx_multicast_pclk       (rx_multicast_pclk),
   .rx_align_err_pclk       (rx_align_err_pclk),
   .rx_crc_err_pclk         (rx_crc_err_pclk),
   .rx_short_err_pclk       (rx_short_err_pclk),
   .rx_long_err_pclk        (rx_long_err_pclk),
   .rx_jabber_err_pclk      (rx_jabber_err_pclk),
   .rx_symbol_err_pclk      (rx_symbol_err_pclk),
   .rx_pause_ok_pclk        (rx_pause_ok_pclk),
   .rx_pause_nz_pclk        (rx_pause_nz_pclk),
   .rx_length_err_pclk      (rx_length_err_pclk),
   .rx_ip_ck_err_pclk       (rx_ip_ck_err_pclk),
   .rx_tcp_ck_err_pclk      (rx_tcp_ck_err_pclk),
   .rx_udp_ck_err_pclk      (rx_udp_ck_err_pclk),
   .rx_dma_pkt_flushed_pclk (rx_dma_pkt_flushed_pclk),
   .rx_overflow_pclk        (rx_overflow_pclk),
   .rx_dma_int_queue_pclk   (rx_dma_int_queue_pclk),
   .pfc_negotiate_pclk      (pfc_negotiate_pclk),
   .rx_pfc_paused_pclk      (rx_pfc_paused_pclk),
   .rx_buff_not_rdy_pclk    (rx_buff_not_rdy_pclk),
   .rx_resource_err_pclk    (rx_resource_err_pclk),
   .rx_hresp_notok_pclk     (rx_hresp_notok_pclk),
   .lpi_indicate_pclk       (lpi_indicate_pclk),
   .lpi_indicate_del        (lpi_indicate_del),
   .wol_pulse               (wol_pulse),
   .frer_to_pulse           (frer_to_pulse),
   .frer_rogue_pulse        (frer_rogue_pulse),
   .frer_ooo_pulse          (frer_ooo_pulse),
   .frer_err_upd_pulse      (frer_err_upd_pulse),

   // signals coming from gem_registers
   .speed_mode           (speed_mode),
   .int_moderation       (int_moderation),

   // signals used for queue pointer reading during debug
   .rx_dma_descr_base_addr(rx_dma_descr_base_addr[31:0]),
   .new_receive_q_ptr    (new_receive_q_ptr),
   .rx_dma_descr_ptr_tog (rx_dma_descr_ptr_tog),
   .rx_dma_descr_ptr     (rx_dma_descr_ptr[31:0]),
   .rx_dma_descr_ptr_pclk(rx_dma_descr_ptr_pclk),
   .tx_dma_descr_base_addr(tx_dma_descr_base_addr[31:0]),
   .new_transmit_q_ptr   (new_transmit_q_ptr),
   .tx_dma_descr_ptr_tog (tx_dma_descr_ptr_tog),
   .tx_dma_descr_ptr     (tx_dma_descr_ptr[31:0]),
   .tx_dma_descr_ptr_pclk(tx_dma_descr_ptr_pclk),

   // precision time protocol signals for IEEE 1588 support
   .sync_frame_tx        (sync_frame_tx),
   .delay_req_tx         (delay_req_tx),
   .pdelay_req_tx        (pdelay_req_tx),
   .pdelay_resp_tx       (pdelay_resp_tx),
   .sync_frame_rx        (sync_frame_rx),
   .delay_req_rx         (delay_req_rx),
   .pdelay_req_rx        (pdelay_req_rx),
   .pdelay_resp_rx       (pdelay_resp_rx),
   .ptp_sync_tx_int      (ptp_sync_tx_int),
   .ptp_del_tx_int       (ptp_del_tx_int),
   .ptp_pdel_req_tx_int  (ptp_pdel_req_tx_int),
   .ptp_pdel_resp_tx_int (ptp_pdel_resp_tx_int),
   .ptp_sync_rx_int      (ptp_sync_rx_int),
   .ptp_del_rx_int       (ptp_del_rx_int),
   .ptp_pdel_req_rx_int  (ptp_pdel_req_rx_int),
   .ptp_pdel_resp_rx_int (ptp_pdel_resp_rx_int),

   .tsu_sec_incr         (tsu_sec_incr),
   .tsu_incr_sec_int     (tsu_incr_sec_int),
   .ptp_tx_time_load     (ptp_tx_time_load),
   .ptp_rx_time_load     (ptp_rx_time_load),
   .ptp_tx_ptime_load    (ptp_tx_ptime_load),
   .ptp_rx_ptime_load    (ptp_rx_ptime_load),
   .tsu_timer_cmp_val    (tsu_timer_cmp_val),
   .timer_cmp_val_int    (timer_cmp_val_int),
   .timer_strobe         (timer_strobe),
   .timer_str_sync       (timer_str_sync),
   .tsu_timer_cnt_pclk_vld(tsu_timer_cnt_pclk_vld),
   .tsu_timer_cnt_par_pclk(tsu_timer_cnt_par_pclk),
   .tsu_timer_cnt_pclk   (tsu_timer_cnt_pclk),
   .tsu_timer_cnt        (tsu_timer_cnt[93:16]),
   .tsu_timer_cnt_par    (tsu_timer_cnt_par[11:2]),
   .soft_config_fifo_en  (soft_config_fifo_en),

   // RSC specific
   .rsc_clr_tog             (rsc_clr_tog),
   .rsc_clr_sync            (rsc_clr_sync),

   .tx_dpram_fill_lvl_dbg   (tx_dpram_fill_lvl_dbg),
   .rx_dpram_fill_lvl_dbg   (rx_dpram_fill_lvl_dbg),
   .sel_dpram_fill_lvl_dbg  (sel_dpram_fill_lvl_dbg),
   .dpram_fill_lvl_pclk     (dpram_fill_lvl_pclk),
   .rx_dpram_fill_lvl_pad_pclk (rx_dpram_fill_lvl_pad_pclk),

   // signals going to gem_registers for other status
   .ext_interrupt_pclk      (ext_interrupt_pclk),

   // Per queue receive flushing toggle signals for stats
   .frame_flushed_tog            (frame_flushed_tog),
   .frame_flushed_pclk           (frame_flushed_pclk),

   // Per scr2 rate limiting signals for stats
   .scr_excess_rate              (scr_excess_rate),
   .scr_excess_rate_pclk         (scr_excess_rate_pclk),

   // ASF - from SRAM protection
   .tx_corr_err                   (tx_corr_err),
   .tx_uncorr_err                 (tx_uncorr_err),
   .tx_err_addr                   (tx_err_addr),
   .rx_corr_err                   (rx_corr_err),
   .rx_uncorr_err                 (rx_uncorr_err),
   .rx_err_addr                   (rx_err_addr),
   // ASF - signals going to fault rpt and log
   .asf_sram_corr_fault           (asf_sram_corr_fault),
   .asf_sram_corr_fault_stats_upd (asf_sram_corr_fault_stats_upd),
   .asf_sram_corr_fault_status    (asf_sram_corr_fault_status),
   .asf_sram_uncorr_fault         (asf_sram_uncorr_fault),
   .asf_sram_uncorr_fault_status  (asf_sram_uncorr_fault_status),

   .asf_dap_txclk_err             (asf_dap_txclk_err | asf_dap_mmsl_tx_err),
   .asf_dap_txclk_err_pclk        (asf_dap_txclk_err_pclk),
   .asf_dap_rxclk_err             (asf_dap_rxclk_err | asf_dap_mmsl_rx_err),
   .asf_dap_rxclk_err_pclk        (asf_dap_rxclk_err_pclk),
   .asf_dap_dma_err               (asf_dap_dma_err),
   .asf_dap_dma_err_pclk          (asf_dap_dma_err_pclk),
   .asf_integrity_dma_err         (asf_integrity_dma_err),
   .asf_integrity_dma_err_pclk    (asf_integrity_dma_err_pclk),
   .asf_integrity_tsu_err         (asf_integrity_tsu_err),
   .asf_integrity_tsu_err_pclk    (asf_integrity_tsu_err_pclk),
   .asf_integrity_tx_sched_err    (asf_integrity_tx_sched_err),
   .asf_integrity_tx_sched_err_pclk (asf_integrity_tx_sched_err_pclk),
   .asf_host_trans_to_err         (asf_host_trans_to_err),
   .asf_host_trans_to_err_pclk    (asf_host_trans_to_err_pclk),
   .asf_dap_rdata_err             (asf_dap_rdata_err),
   .asf_dap_rdata_err_pclk        (asf_dap_rdata_err_pclk),

   // Link Fault Signalling ..
   .link_fault_status           (link_fault_status),
   .link_fault_status_pclk      (link_fault_status_pclk)

   );

endmodule

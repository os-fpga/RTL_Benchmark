//------------------------------------------------------------------------------
// Copyright (c) 2002-2020 Cadence Design Systems, Inc.
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
//   Filename:           gem_pclk_syncs.v
//   Module Name:        gem_pclk_syncs
//
//   Release Revision:   r1p12f4
//   Release SVN Tag:    gem_gxl_det0102_r1p12f1
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
//   Description :      Synchronises signals to pclk
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_pclk_syncs(

   //System Inputs
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

   // other top level signals
   ext_interrupt_in,
   mdio_in,
   mdio_in_pclk,

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
   frer_to_tog,
   frer_rogue_tog,
   frer_ooo_tog,
   frer_err_upd_tog,

   // handshaking between gem_dma_top and gem_reg_top.
   rx_dma_stable_tog,
   rx_dma_stat_capt_tog,
   tx_dma_stable_tog,
   tx_dma_stat_capt_tog,

   // signals coming from gem_dma_tx.
   tx_dma_complete_ok,
   tx_dma_buffers_ex,
   tx_dma_buff_ex_mid,
   tx_dma_go,
   tx_dma_hresp_notok,
   tx_dma_int_queue,
   tx_dma_late_col,
   tx_dma_toomanyretry,
   tx_dma_underflow,
   tx_too_many_retries,
   tx_underflow_frame,

   // signals coming from gem_dma_rx.
   rx_dma_complete_ok,
   rx_dma_buff_not_rdy,
   rx_dma_resource_err,
   rx_dma_hresp_notok,
   rx_dma_int_queue,

   axi_tx_frame_too_large,
   axi_xaction_out,
   disable_tx,
   disable_rx,
   tx_frame_too_large_pclk,
   axi_xaction_out_pclk,
   disable_tx_pclk,
   disable_rx_pclk,


   // signals going to gem_registers for tx status & statistics.
   tx_ok_pclk,
   tx_ok_mod_pclk,
   tx_bytes_pclk,
   tx_broadcast_pclk,
   tx_multicast_pclk,
   tx_single_col_pclk,
   tx_multi_col_pclk,
   tx_late_col_pclk,
   tx_deferred_pclk,
   tx_crs_err_pclk,
   tx_coll_occ_pclk,
   tx_toomanyretry_pclk,
   tx_pause_zero_pclk,
   tx_pause_ok_pclk,
   tx_pfc_pause_ok_pclk,
   tx_pause_time_pclk,
   tx_underrun_pclk,
   tx_buffers_ex_pclk,
   tx_buff_ex_mid_pclk,
   tx_hresp_notok_pclk,
   tx_dma_int_queue_pclk,
   tx_go_pclk,
   tx_mac_ok_pclk,
   tx_late_col_mac_pclk,

   // signals going to gem_registers for rx status & statistics.
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
   rx_overflow_pclk,
   pfc_negotiate_pclk,
   rx_pfc_paused_pclk,
   rx_buff_not_rdy_pclk,
   rx_resource_err_pclk,
   rx_hresp_notok_pclk,
   rx_dma_int_queue_pclk,
   rx_dma_pkt_flushed_pclk,
   lpi_indicate_pclk,
   lpi_indicate_del,
   wol_pulse,
   frer_to_pulse,
   frer_rogue_pulse,
   frer_ooo_pulse,
   frer_err_upd_pulse,

   // signals coming from gem_registers
   speed_mode,
   int_moderation,

   // signals used for queue pointer reading during debug
   rx_dma_descr_base_addr,
   new_receive_q_ptr,
   rx_dma_descr_ptr,
   rx_dma_descr_ptr_tog,
   rx_dma_descr_ptr_pclk,
   tx_dma_descr_base_addr,
   new_transmit_q_ptr,
   tx_dma_descr_ptr,
   tx_dma_descr_ptr_tog,
   tx_dma_descr_ptr_pclk,

   // precision time protocol signals for IEEE 1588 support
   sync_frame_rx,
   delay_req_rx,
   pdelay_req_rx,
   pdelay_resp_rx,
   sync_frame_tx,
   delay_req_tx,
   pdelay_req_tx,
   pdelay_resp_tx,
   ptp_sync_tx_int,
   ptp_del_tx_int,
   ptp_pdel_req_tx_int,
   ptp_pdel_resp_tx_int,
   ptp_sync_rx_int,
   ptp_del_rx_int,
   ptp_pdel_req_rx_int,
   ptp_pdel_resp_rx_int,
   tsu_sec_incr,
   ptp_tx_time_load,
   ptp_rx_time_load,
   ptp_tx_ptime_load,
   ptp_rx_ptime_load,
   tsu_incr_sec_int,
   tsu_timer_cmp_val,
   timer_cmp_val_int,
   tsu_timer_cnt_pclk,
   tsu_timer_cnt_par_pclk,
   tsu_timer_cnt_pclk_vld,
   tsu_timer_cnt,
   tsu_timer_cnt_par,
   timer_strobe,
   timer_str_sync,

   soft_config_fifo_en,

   // RSC specific
   rsc_clr_tog,
   rsc_clr_sync,

   // Debug
   tx_dpram_fill_lvl_dbg,
   rx_dpram_fill_lvl_dbg,
   sel_dpram_fill_lvl_dbg,
   dpram_fill_lvl_pclk,
   rx_dpram_fill_lvl_pad_pclk,

   // signals going to gem_registers for other status
   ext_interrupt_pclk,

   // Per queue receive flushing toggle signals for stats
   frame_flushed_tog,
   frame_flushed_pclk,

   // Per scr2 rate limiting signals for stats
   scr_excess_rate,
   scr_excess_rate_pclk,

   // ASF - from SRAM protection
   tx_corr_err,
   tx_uncorr_err,
   tx_err_addr,
   rx_corr_err,
   rx_uncorr_err,
   rx_err_addr,
   // ASF - signals going to fault rpt and log
   asf_sram_corr_fault,
   asf_sram_corr_fault_stats_upd,
   asf_sram_corr_fault_status,
   asf_sram_uncorr_fault,
   asf_sram_uncorr_fault_status,

   asf_dap_txclk_err,
   asf_dap_txclk_err_pclk,
   asf_dap_rxclk_err,
   asf_dap_rxclk_err_pclk,
   asf_dap_dma_err,
   asf_dap_dma_err_pclk,

   asf_integrity_dma_err,
   asf_integrity_dma_err_pclk,
   asf_integrity_tsu_err,
   asf_integrity_tsu_err_pclk,
   asf_integrity_tx_sched_err,
   asf_integrity_tx_sched_err_pclk,

   asf_host_trans_to_err,
   asf_host_trans_to_err_pclk,

   asf_dap_rdata_err,
   asf_dap_rdata_err_pclk,

   // Link Fault Signalling
   link_fault_status,
   link_fault_status_pclk
);

   parameter [1363:0] grouped_params = {1364{1'b0}};
   `include "ungroup_params.v"

   // system signals
   input         n_preset;                // Amba reset
   input         pclk;                    // peripherical clock bus
   input         n_tsureset;              // TSU clock
   input         tsu_clk;                 // TSU reset
   input         n_txreset;               // transmit clock reset
   input         tx_clk;                  // transmit clock
   input         n_hreset;                // ahb clock
   input         hclk;                    // hclk reset
   input         n_rxreset;               // receive clock reset
   input         rx_clk;                  // receive clock

   // other top level signals
   input         ext_interrupt_in;        // external interrupt input

   input         mdio_in;                 // MDIO from PHY
   output        mdio_in_pclk;            // Synchronised to pclk

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
   input         tx_pause_frame_txed;     // indicates that the 802.3 pause
                                          // frame was transmitted,
                                          // cleared when
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
   input         rx_pause_frame;          // indicates a 802.3 or PFC pause
                                          // frame has been received,
                                          // cleared when
                                          // rx_status_wr_tog is returned.
   input         rx_pause_nonzero;        // indicates a 802.3 or PFC pause
                                          // frame has been
                                          // received with non-zero quantum.
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
   input         rx_pkt_dbuff_overflow;   // asserted when overflow in pbuf
   input         rx_overflow;             // asserted when overflow in RX path
   input         pfc_negotiate;           // indicates a received PFC
                                          // pause frame
   input   [7:0] rx_pfc_paused;           // each bit is set when PFC frame has
                                          // been received and the associated
                                          // PFC counter != 0
   input         lpi_indicate;            // rx LPI indication has been detected
   input         wol;                     // wake on LAN indication
   input  [p_gem_num_cb_streams-1:0]
                 frer_to_tog;             // indicate timeout occurred
   input  [p_gem_num_cb_streams-1:0]
                 frer_rogue_tog;          // indicate rogue frame rcvd
   input  [p_gem_num_cb_streams-1:0]
                 frer_ooo_tog;            // indicate out of order frame
   input  [p_gem_num_cb_streams-1:0]
                 frer_err_upd_tog;        // enable update of latent errors

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
   input [3:0]   tx_dma_int_queue;        // queue

   // the MAC errors are stored in the DMA packet buffer so that we can
   // free up the MAC as soon as the MAC tx path is completed.  Therefore,
   // the following inputs are required in this mode
   input         tx_dma_late_col;         // late collision indicator from DMA
   input         tx_dma_toomanyretry;     // too many retries indicator from DMA
   input         tx_dma_underflow;        // Underflow from DMA
   input         tx_too_many_retries;     // set if collision retry limit has
                                          // been reached, cleared when
                                          // tx_status_wr_tog is returned.
   input         tx_underflow_frame;      // asserted high at the end of frame
                                          // to indicate a fifo underrun or
                                          // tx_r_err condition, cleared when
                                          // tx_status_wr_tog is returned.

   // signals coming from gem_dma_rx.
   input         rx_dma_complete_ok;      // asserted when a received frame
                                          // has been transferred to memory.
   input         rx_dma_buff_not_rdy;     // signal from the dma block to set
                                          // bit in receive status register.
   input         rx_dma_resource_err;     // indicates discard of a rx frame
                                          // due to no rx buffer available.
   input         rx_dma_hresp_notok;      // asserted when hresp is not OK.
   input [3:0]   rx_dma_int_queue;        // asserted when hresp is not OK.

   input         axi_tx_frame_too_large;  // major error, so disable tx
   input         axi_xaction_out;         // AXI transaction out
   input         disable_tx;              // major error, so disable tx
   input         disable_rx;              // major error, so disable rx
   output        tx_frame_too_large_pclk;
   output        axi_xaction_out_pclk;    // AXI transaction out, pclk timed
   output        disable_tx_pclk;
   output        disable_rx_pclk;

   // Debug
   input  [(p_edma_tx_pbuf_addr*p_edma_queues)-1:0] tx_dpram_fill_lvl_dbg;
   input  [p_edma_rx_pbuf_addr-1:0]                 rx_dpram_fill_lvl_dbg;
   input  [4:0]  sel_dpram_fill_lvl_dbg;
   output [15:0] dpram_fill_lvl_pclk;
   output [15:0] rx_dpram_fill_lvl_pad_pclk;

   // signals going from pclk_syncs to gem_registers for tx status & statistics.
   output        tx_ok_pclk;              // pclk pulse for frame txed OK
   output        tx_ok_mod_pclk;          // moderated pclk pulse for frame txed OK
   output [13:0] tx_bytes_pclk;           // Number of bytes in frame txed OK
   output        tx_broadcast_pclk;       // pclk pulse for broadcast txed OK
   output        tx_multicast_pclk;       // pclk pulse for multicast txed OK
   output        tx_single_col_pclk;      // pclk pulse when frame eventually
                                          // txed OK but had a single collision.
   output        tx_multi_col_pclk;       // pclk pulse when frame eventually
                                          // txed OK but had multiple collisions
   output        tx_late_col_pclk;        // pclk pulse on late collision frame.
   output        tx_deferred_pclk;        // pclk pulse if frame was deferred.
   output        tx_crs_err_pclk;         // pclk pulse if frame had crs error.
   output        tx_coll_occ_pclk;        // pclk pulse if frame had a collision
   output        tx_toomanyretry_pclk;    // pclk pulse if frame had too many
                                          // retries.
   output        tx_pause_zero_pclk;      // pclk pulse when pause timer reaches
                                          // zero or zero pause frame rxed.
   output        tx_pause_ok_pclk;        // pclk pulse for 802.3 pause frame
                                          // txed OK
   output        tx_pfc_pause_ok_pclk;    // pclk pulse for PFC pause frame
                                          // txed OK
   output [15:0] tx_pause_time_pclk;      // Pause timer value synced to pclk.
   output        tx_underrun_pclk;        // pclk pulse when tx underrun occured
   output        tx_buffers_ex_pclk;      // pclk pulse when tx buffers are
                                          // exhausted.
   output        tx_buff_ex_mid_pclk;     // pclk pulse when tx buffers are
                                          // exhausted mid frame.
   output        tx_hresp_notok_pclk;     // pclk pulse when hresp not OK
                                          // happened during TX DMA.
   output [3:0]  tx_dma_int_queue_pclk;   // pclk pulse
   output        tx_go_pclk;              // tx_go from DMA resynced to pclk.
   // When using packet buffer, we need to identify the end of both MAC and DMA
   // The DMA version is tx_ok_pclk, the MAC version is tx_mac_ok_pclk
   // Also, the MAC version of tx_late_col_mac_pclk is required for the
   // stats updates (the DMA one can sometimes be blocked by the MAC i/f
   // to the DMA)
   output        tx_mac_ok_pclk;          // pclk pulse for frame txed OK
   output        tx_late_col_mac_pclk;    // pclk pulse on late collision frame.

   // signals going from pclk_syncs to gem_registers for rx status & statistics.
   output        ok_to_update_rx_stats;   // OK to update the stats
   output        rx_ok_pclk;              // pclk pulse for frame rxed OK
   output        rx_ok_mod_pclk;          // moderated pclk pulse for frame rxed OK
   output        rx_mac_ok_pclk;          // == rx_ok_pclk when not using pktbuff
                                          // Done this way so that LEC proves the old
                                          // non PBUF versions are still equivalent
                                          // rx_mac_ok_pclk is simply a earlier MAC version
                                          // of rx_ok_pclk whilst in pktbuff mode
   output [13:0] rx_bytes_pclk;           // Number of bytes in frame rxed OK
   output        rx_broadcast_pclk;       // pclk pulse for broadcast rxed OK
   output        rx_multicast_pclk;       // pclk pulse for multicast rxed OK
   output        rx_align_err_pclk;       // pclk pulse when rx frame discarded
                                          // because of an alignment error.
   output        rx_crc_err_pclk;         // pclk pulse when rx frame discarded
                                          // because of a CRC/FCS error.
   output        rx_short_err_pclk;       // pclk pulse when rx frame discarded
                                          // because of a too short error.
   output        rx_long_err_pclk;        // pclk pulse when rx frame discarded
                                          // because of a too long error.
   output        rx_jabber_err_pclk;      // pclk pulse when rx frame discarded
                                          // because of a jabber error.
   output        rx_symbol_err_pclk;      // pclk pulse when rx frame discarded
                                          // because of a symbol error.
   output        rx_pause_ok_pclk;        // pclk pulse for 802.3pause frame
                                          // rxed OK.
   output        rx_pause_nz_pclk;        // pclk pulse for 802.3 pause frame
                                          // with non-zero quantum rxed OK.
   output        rx_length_err_pclk;      // pclk pulse when rx frame discarded
                                          // because of a length field error.
   output        rx_ip_ck_err_pclk;       // pclk pulse when rx frame discarded
                                          // because of a IP checksum error.
   output        rx_tcp_ck_err_pclk;      // pclk pulse when rx frame discarded
                                          // because of a TCP checksum error.
   output        rx_udp_ck_err_pclk;      // pclk pulse when rx frame discarded
                                          // because of a UDP checksum error.
   output        rx_overflow_pclk;        // pclk pulse when the RX pipeline or
                                          // FIFO overflowed due to bandwidth.
   output        pfc_negotiate_pclk;      // synchronise pfc_negotiate
   output  [7:0] rx_pfc_paused_pclk;      // PFC pause indication
   output        rx_buff_not_rdy_pclk;    // pclk pulse when used bit was read
                                          // during RX DMA operation.
   output        rx_resource_err_pclk;    // pclk pulse when rx frame discarded
                                          // because a buffer was unavailable.
   output        rx_hresp_notok_pclk;     // pclk pulse when the RX pipeline or
                                          // FIFO overflowed due to bandwidth.
   output  [3:0] rx_dma_int_queue_pclk;   // pclk pulse
   output        rx_dma_pkt_flushed_pclk; // pclk pulse when rx frame discarded
                                          // because of a AHB resource error
   output        lpi_indicate_pclk;       // rx LPI indication has been detected
   output        lpi_indicate_del;        // lpi_indicate_pclk delayed by one pclk
   output        wol_pulse;               // wake on LAN indication pclk synced
   output  [p_gem_num_cb_streams-1:0]
                 frer_to_pulse;           // indicate timeout occurred
   output  [p_gem_num_cb_streams-1:0]
                 frer_rogue_pulse;        // indicate rogue frame rcvd
   output  [p_gem_num_cb_streams-1:0]
                 frer_ooo_pulse;          // indicate out of order frame
   output  [p_gem_num_cb_streams-1:0]
                 frer_err_upd_pulse;      // enable update of latent errors

   // signals coming from gem_registers
   input   [3:0] speed_mode;              // Indicates {tbi, gigabit, 100M}
   input  [31:0] int_moderation;          // interrupt moderation register value

   // signals used for queue pointer reading during debug
   input  [31:0] rx_dma_descr_base_addr;  // base position of the rx buffer
                                          // queue pointer list.
   input         new_receive_q_ptr;       // asserted when receive queue pointer
                                          // is written.
   input  [31:0] rx_dma_descr_ptr;        // Descriptor queue pointer for debug
   input         rx_dma_descr_ptr_tog;    // toggle handshaking for update
   output [31:0] rx_dma_descr_ptr_pclk;   // Descriptor queue pointer for debug
   input  [31:0] tx_dma_descr_base_addr;  // base position of the tx buffer
                                          // queue pointer list.
   input         new_transmit_q_ptr;      // asserted when tx queue pointer
                                          // is written.
   input  [31:0] tx_dma_descr_ptr;        // Descriptor queue pointer for debug
   input         tx_dma_descr_ptr_tog;    // toggle handshaking for update
   output [31:0] tx_dma_descr_ptr_pclk;   // Descriptor queue pointer for debug

   // signals going from pclk_syncs to gem_registers for other status
   output        ext_interrupt_pclk;      // pclk pulse when an external
                                          // interrupt was detected.

   input         sync_frame_tx;           // PTP sync frame transmitted
   input         delay_req_tx;            // PTP delay_req transmitted
   input         pdelay_req_tx;           // PTP pdelay_req transmitted
   input         pdelay_resp_tx;          // PTP pdelay_resp transmitted
   input         sync_frame_rx;           // PTP sync frame received
   input         delay_req_rx;            // PTP delay_req received
   input         pdelay_req_rx;           // PTP pdelay_req received
   input         pdelay_resp_rx;          // PTP pdelay_resp received
   output        ptp_sync_tx_int;         // PTP sync frame transmit interrupt
   output        ptp_del_tx_int;          // PTP delay_req frame transmit
                                          // interrupt
   output        ptp_pdel_req_tx_int;     // PTP pdelay_req transmit interrupt
   output        ptp_pdel_resp_tx_int;    // PTP pdelay_resp frame transmit
                                          // interrupt
   output        ptp_sync_rx_int;         // PTP sync frame receive interrupt
   output        ptp_del_rx_int;          // PTP delay_req frame receive
                                          // interrupt
   output        ptp_pdel_req_rx_int;     // PTP pdelay_req receive interrupt
   output        ptp_pdel_resp_rx_int;    // PTP pdelay_resp frame receive
                                          // interrupt
   // precision time protocol signals for IEEE 1588 support
   input         tsu_sec_incr;            // TSU seconds incremented
   input         tsu_timer_cmp_val;       // TSU timer comparison valid
   output        tsu_incr_sec_int;        // TSU second increment interrupt
   output        ptp_rx_time_load;        // load captured timer value to PTP
                                          // event frame received registers
   output        ptp_tx_time_load;        // load captured timer value to PTP
                                          // event frame transmitted registers
   output        ptp_tx_ptime_load;       // load captured timer value to peer
                                          // event frame transmitted registers
   output        ptp_rx_ptime_load;       // load captured timer value to peer
                                          // event frame received registers
   output        timer_cmp_val_int;       // synced TSU timer comparison valid
                                          // pulse, for interrupt
   input [93:16] tsu_timer_cnt;           // TSU timer count value
   input [11:2]  tsu_timer_cnt_par;       // Parity
   output [77:0] tsu_timer_cnt_pclk;      // TSU timer count value, pclk timed
   output [9:0]  tsu_timer_cnt_par_pclk;  // Parity
   output        tsu_timer_cnt_pclk_vld;  // TSU timer count value, valid

   input         timer_strobe;            // write timer sync strobe registers
   output        timer_str_sync;          // timer_strobe synced to pclk

   input         soft_config_fifo_en;     // select ext fifo interface

   // RSC specific
   input  [p_edma_queues-1:0]  rsc_clr_tog;  // Receive Side Coalescing clear
   output [p_edma_queues-1:0]  rsc_clr_sync; // Receive Side Coalescing clear Sync

   // ASF - from SRAM protection
   input                   tx_corr_err;   // Correctable error for TX SRAM
   input                   tx_uncorr_err; // Uncorrectable error for TX SRAM
   input   [p_edma_tx_pbuf_addr-1:0]
                           tx_err_addr;   // Address of TX SRAM error
   input                   rx_corr_err;   // Correctable error for RX SRAM
   input                   rx_uncorr_err; // Uncorrectable error for RX SRAM
   input   [p_edma_rx_pbuf_addr-1:0]
                           rx_err_addr;   // Address of RX SRAM error
   // ASF -  SRAM protection
   output                  asf_sram_corr_fault;
   output  [7:0]           asf_sram_corr_fault_stats_upd;
   output  [31:0]          asf_sram_corr_fault_status;
   output                  asf_sram_uncorr_fault;
   output  [31:0]          asf_sram_uncorr_fault_status;

   input  asf_dap_txclk_err;             // Parity error in tx domain
   output asf_dap_txclk_err_pclk;        // Synchronised to pclk domain
   input  asf_dap_rxclk_err;             // Parity error in rx domain
   output asf_dap_rxclk_err_pclk;        // Synchronised to pclk domain
   input  asf_dap_dma_err;               // Parity error in DMA domain
   output asf_dap_dma_err_pclk;          // Synchronised to pclk domain

   input  asf_integrity_dma_err;         // DMA integrity error
   output asf_integrity_dma_err_pclk;    // Synchronised to pclk
   input  asf_integrity_tsu_err;         // tsu protection error
   output asf_integrity_tsu_err_pclk;    // tsu protection error in pclk domain
   input  asf_integrity_tx_sched_err;    // Transmit Scheduling protection error
   output asf_integrity_tx_sched_err_pclk; // Transmit Scheduling protection error in pclk domain

   input  asf_host_trans_to_err;         // Transaction timeout error
   output asf_host_trans_to_err_pclk;    // Synchronised to pclk

   input  asf_dap_rdata_err;             // AXI rdata parity error
   output asf_dap_rdata_err_pclk;        // Synchronised to pclk

   // per queue receive flushing toggle signal for stats
   // and related output pclk pulse
   input  frame_flushed_tog;
   output frame_flushed_pclk;

   // per scr2 rate limiting signals for stats
   input      [p_num_type2_screeners:0] scr_excess_rate;
   output     [p_num_type2_screeners:0] scr_excess_rate_pclk;

   // Link Fault Status ..
   input     [1:0] link_fault_status;    // 00 - OK; 01 - local fault; 10 - remote fault; 11 - link interruption
   output    [1:0] link_fault_status_pclk;

   // internal wire and reg declarations.

   // signals used for external interrupt detection
   wire          ext_interrupt_pclk;      // pclk pulse when an external
                                          // interrupt was detected.

   // signals used for detecting other tx status
   wire          tx_pause_tog_sync;       // sync tx_pause_time_tog to pclk.
   reg           tx_pause_tog_del;        // sync tx_pause_time_tog to pclk.
   wire          tx_pause_tog_edge;       // detected edge on tx_pause_time_tog
   wire          tx_go_pclk;              // tx_go from DMA resynced to pclk.
   reg    [31:0] tx_dma_descr_ptr_pclk;   // Descriptor queue pointer for debug
   wire          tx_dma_descr_ptr_tog_edge; // detect either edge of toggle

   // signals used for detecting other rx status
   wire          rx_buff_not_rdy_pclk_int; // pclk pulse when used bit was read
                                          // during RX DMA operation.
   reg    [31:0] rx_dma_descr_ptr_pclk;   // Descriptor queue pointer for debug
   wire          rx_dma_descr_ptr_tog_edge;  // detect either edge of toggle
   reg           new_transmit_q_ptr_d1;   // delay toggle signal for edge detect
   reg           new_receive_q_ptr_d1;    // delay toggle signal for edge detect

   // signals for handshaking between DMA and registers
   wire          update_rx_dma_status;    // edge detect rx_dma_stable_tog.
   reg           rx_dma_stat_capt_tog;    // toggle back to hclk status seen.
   wire          update_tx_dma_status;    // edge detect tx_dma_stable_tog.
   reg           tx_dma_stat_capt_tog;    // toggle back to hclk status seen.

   // signals for handshaking between TX/RX MAC and registers
   wire          rx_end_frame_pulse;      // edge detect rx_end_tog.
   reg           rx_status_wr_tog;        // toggle back to rx_clk status seen.
   wire          tx_end_frame_pulse;      // edge detect tx_end_tog.
   reg           tx_status_wr_tog;        // toggle back to tx_clk status seen.

   // precision time protocol signals for IEEE 1588 support
   wire          sync_frame_rx_pulse;     // edge detect sync_frame_rx
   wire          delay_req_rx_pulse;      // edge detect delay_req_rx
   wire          sync_frame_tx_pulse;     // edge detect sync_frame_tx
   wire          delay_req_tx_pulse;      // edge detect delay_req_tx
   wire          ptp_tx_time_load;        // store timer on PTP event transmit
   wire          pdelay_req_tx_pulse;     // edge detect pdelay_req_tx
   wire          pdelay_req_rx_pulse;     // edge detect pdelay_req_rx
   wire          pdelay_resp_rx_pulse;    // edge detect pdelay_resp_rx
   reg           ptp_sync_rx_int;         // PTP sync frame receive interrupt
   reg           ptp_del_rx_int;          // PTP delay request receive interrupt
   reg           ptp_pdel_req_rx_int;     // PTP pdelay_req receive interrupt
   reg           ptp_pdel_resp_rx_int;    // PTP pdelay_resp receive interrupt
   reg           ptp_sync_tx_int;         // PTP sync frame transmit interrupt
   reg           ptp_del_tx_int;          // PTP delay request transmit
                                          // interrupt
   reg           ptp_pdel_req_tx_int;     // PTP pdelay_req transmit interrupt
   reg           ptp_pdel_resp_tx_int;    // PTP pdelay_resp tranmit interrupt

   wire          ptp_rx_time_load;        // store timer on PTP event received
   wire          ptp_rx_ptime_load;       // store timer on peer event received
   wire          pdelay_resp_tx_pulse;    // edge detect pdelay_resp_tx
   wire          ptp_tx_ptime_load;       // store timer on peer event transmit

   wire          timer_cmp_val_int;       // sync tsu_timer_cmp_val to pclk
   wire          timer_cmp_val_pulse;     // sync tsu_timer_cmp_val to pclk
   wire          tsu_incr_sec_int;        // pclk pulse when TSU seconds
                                          // increment interrupt detected
   // signals for TX/RX MAC complete OK
   wire          ok_to_update_tx_stats;   // Both DMA TX & MAC TX completed
   wire          ok_to_update_rx_stats;   // Its time to update the stats

   // PFC signals
   wire          pfc_negotiate_pclk;      //synchronise pfc_negotaite
   wire   [7:0]  rx_pfc_paused_pclk;      // PFC pause indication

   // lpi indicate
   wire          lpi_indicate_pclk;       // rx LPI indication has been detected
   reg           lpi_indicate_del;        // lpi_indicate_pclk delayed by one pclk

   // wol
   wire          wol_pulse;               // wake on LAN rising edge pulse

   // interrupt moderation wires and regs
   wire          tx_ok_txclk;             // tx_clk timed transmit event pulse
   reg     [7:0] tx_cnt_800;              // count 800 nanoseconds
   reg     [7:0] tx_int_mod;              // count down interrupt moderation value every 800 nanoseconds
   reg           tx_ok_mod_tog;           // toggle after interrupt moderation time out
   wire          tx_ok_mod_pulse;         // pclk timed pulse after interrupt moderation time out
   wire    [7:0] clks_in_800;             // number of clock cycles in 800ns
   wire          rx_ok_txclk;             // rx_clk timed receive event pulse
   reg     [7:0] rx_cnt_800;              // count 800 nanoseconds
   reg     [7:0] rx_int_mod;              // count down interrupt moderation value every 800 nanoseconds
   reg           rx_ok_mod_tog;           // toggle after interrupt moderation time out
   wire          rx_ok_mod_pulse;         // pclk timed pulse after interrupt moderation time out
   wire    [7:0] tx_int_mod_thresh;       // count of transmitted frames before tx int is set
   wire    [7:0] tx_int_moderation;       // count of 800ns periods before tx int is set
   wire    [7:0] rx_int_mod_thresh;       // count of received frames before rx int is set
   wire    [7:0] rx_int_moderation;       // count of 800ns periods before rx int is set
   reg     [7:0] tx_int_mod_th;           // counts down transmit interrupts received for thresh-hold moderation
   wire          tx_tb_mod_complete;      // signals completion of time-based moderation
   wire          tx_th_mod_complete;      // signals completion of thresh-hold based moderation
   reg     [7:0] rx_int_mod_th;           // counts down receive interrupts received for thresh-hold moderation
   wire          rx_tb_mod_complete;      // signals completion of time-based moderation
   wire          rx_th_mod_complete;      // signals completion of thresh-hold based moderation

   reg           tsu_timer_cmp_tog;       // used for converting tsu_timer_cmp_val from tsu_clk timed pulse to a toggle
   wire          tsu_timer_cmp_tog_cmb;   // used for converting tsu_timer_cmp_val from tsu_clk timed pulse to a toggle

   // assign values from the appropriate slices of the vector from the interrupt moderation register
   assign tx_int_mod_thresh = int_moderation[31:24];
   assign tx_int_moderation = int_moderation[23:16];
   assign rx_int_mod_thresh = int_moderation[15:8];
   assign rx_int_moderation = int_moderation[7:0];



//------------------------------------------------------------------------------
// External interrupt synchronisation
//------------------------------------------------------------------------------

   // synchronise external interrupt signal to pclk and detect rising edge
   edma_sync_toggle_detect i_edma_sync_toggle_detect_ext_interrupt_in (
      .clk(pclk),
      .reset_n(n_preset),
      .din(ext_interrupt_in),
      .rise_edge(ext_interrupt_pclk),
      .fall_edge(),
      .any_edge());


//------------------------------------------------------------------------------
// External MDIO synchronisation
//------------------------------------------------------------------------------

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_mdio_in (
      .clk(pclk),
      .reset_n(n_preset),
      .din(mdio_in),
      .dout(mdio_in_pclk));


//------------------------------------------------------------------------------
// RX MAC to Register end of frame synchronisation
//------------------------------------------------------------------------------

   // detect both edges of rx_end_tog and use for sampling status. Once
   // both DMA and register update complete, provide toggle status back
   // to RX to indicate status seen.

   edma_sync_toggle_detect i_edma_sync_toggle_detect_rx_end_tog (
     .clk      (pclk),
     .reset_n  (n_preset),
     .din      (rx_end_tog),
     .rise_edge(),
     .fall_edge(),
     .any_edge (rx_end_frame_pulse)
   );

   always@(posedge pclk or negedge n_preset)
   begin
     if (~n_preset)
       rx_status_wr_tog   <= 1'b0;
     else
       begin
         // send toggle back to RX block
         if (ok_to_update_rx_stats)
           rx_status_wr_tog <= ~rx_status_wr_tog;
         else
           rx_status_wr_tog <= rx_status_wr_tog;
       end
   end



   // drive pclk pulses to the registers block to set or increment status/stats
   // when both the DMA and MAC have completed
   // Handshaking delay ensures that sync1 signals are stable by the time
   // they are enabled by the all_done signal
   assign rx_bytes_pclk      = rx_bytes_in_frame   & {14{ok_to_update_rx_stats}};
   assign rx_broadcast_pclk  = rx_broadcast_frame  & ok_to_update_rx_stats;
   assign rx_multicast_pclk  = rx_multicast_frame  & ok_to_update_rx_stats;
   assign rx_align_err_pclk  = rx_align_error      & ok_to_update_rx_stats;
   assign rx_crc_err_pclk    = rx_crc_error        & ok_to_update_rx_stats;
   assign rx_short_err_pclk  = rx_short_error      & ok_to_update_rx_stats;
   assign rx_long_err_pclk   = rx_long_error       & ok_to_update_rx_stats;
   assign rx_jabber_err_pclk = rx_jabber_error     & ok_to_update_rx_stats;
   assign rx_symbol_err_pclk = rx_symbol_error     & ok_to_update_rx_stats;
   assign rx_pause_ok_pclk   = rx_pause_frame      & ok_to_update_rx_stats;
   assign rx_pause_nz_pclk   = rx_pause_nonzero    & ok_to_update_rx_stats;
   assign rx_length_err_pclk = rx_length_error     & ok_to_update_rx_stats;
   assign rx_ip_ck_err_pclk  = rx_ip_ck_error      & ok_to_update_rx_stats;
   assign rx_tcp_ck_err_pclk = rx_tcp_ck_error     & ok_to_update_rx_stats;
   assign rx_udp_ck_err_pclk = rx_udp_ck_error     & ok_to_update_rx_stats;

   generate if (p_edma_rx_pkt_buffer == 1'b1) begin : gen_rx_pkt_buffer
     wire          rx_pkt_dbuff_overflow_tog;
     wire          rx_pkt_dbuff_overflow_pclk;
     edma_sync_toggle_detect i_edma_sync_toggle_detect_rx_dma_pkt_flushed (
        .clk      (pclk),
        .reset_n  (n_preset),
        .din      (rx_dma_pkt_flushed),
        .rise_edge(),
        .fall_edge(),
        .any_edge (rx_dma_pkt_flushed_pclk));

     edma_sync_toggle_detect i_edma_sync_toggle_detect_frame_flushed (
        .clk      (pclk),
        .reset_n  (n_preset),
        .din      (frame_flushed_tog),
        .rise_edge(),
        .fall_edge(),
        .any_edge (frame_flushed_pclk));

     edma_toggle_generate #(.DIN_W(1)) i_edma_toggle_gen_rx_pbuf_overflow (
      .clk    (rx_clk),
      .reset_n(n_rxreset),
      .din    (rx_pkt_dbuff_overflow),
      .dout   (rx_pkt_dbuff_overflow_tog));

     edma_sync_toggle_detect i_edma_sync_toggle_detect_rx_pbuf_overflow (
        .clk      (pclk),
        .reset_n  (n_preset),
        .din      (rx_pkt_dbuff_overflow_tog),
        .rise_edge(),
        .fall_edge(),
        .any_edge (rx_pkt_dbuff_overflow_pclk));

     assign rx_overflow_pclk    = (rx_overflow & ok_to_update_rx_stats) | rx_pkt_dbuff_overflow_pclk;
  end else begin : gen_no_rx_pkt_buffer
     assign rx_dma_pkt_flushed_pclk       = 1'b0;
     assign frame_flushed_pclk            = 1'b0;
     assign rx_overflow_pclk              = (rx_overflow & ok_to_update_rx_stats);
  end
  endgenerate

//------------------------------------------------------------------------------
// TX MAC to Register end of frame synchronisation
//------------------------------------------------------------------------------

   // detect both edges of tx_end_tog and use for sampling status.
   // Once the MAC has finished with a frame and the registers
   // block has sampled it, then toggle tx_status_wr_tog.
   // Also toggled when a collision occurs.

   edma_sync_toggle_detect i_edma_sync_toggle_detect_tx_end_tog (
     .clk      (pclk),
     .reset_n  (n_preset),
     .din      (tx_end_tog),
     .rise_edge(),
     .fall_edge(),
     .any_edge (tx_end_frame_pulse)
   );

   always@(posedge pclk or negedge n_preset)
   begin
     if (~n_preset)
       tx_status_wr_tog <= 1'b0;
     else
       begin
         // send toggle back to TX block
         if ((p_edma_tx_pkt_buffer == 1'b1 && tx_end_frame_pulse)     |
             (p_edma_tx_pkt_buffer == 1'b0 && ok_to_update_tx_stats)  |
              tx_coll_occ_pclk)
           tx_status_wr_tog <= ~tx_status_wr_tog;
         else
           tx_status_wr_tog <= tx_status_wr_tog;
       end
   end

   // drive pclk pulses to the registers block to set or increment status/stats
   // when both the DMA and MAC have completed
   // Handshaking delay ensures that sync1 signals are stable by the time
   // they are enabled by the all_done signal
   // Note that when the pbuf is enabled, then we want to just create
   // the MAC versions here for all except underrun, late col and toomanyretries
   // When gem_host_if_soft_select is defined the soft_config_fifo_en signal selects
   // the correct signal for the selected dma or ext_fifo_interface port
   // otherwise fix the connections.

  reg    [13:0] tx_bytes_pclk;           // Number of bytes in frame txed OK
  reg           tx_broadcast_pclk;       // pclk pulse for broadcast txed OK
  reg           tx_multicast_pclk;       // pclk pulse for multicast txed OK
  reg           tx_late_col_mac_pclk;    // pclk pulse on late collision
  reg           tx_single_col_pclk;      // pclk pulse when frame eventually
                                         // txed OK but had a single collision.
  reg           tx_multi_col_pclk;       // pclk pulse when frame eventually
                                         // txed OK but had multiple collisions
  reg           tx_late_col_pclk;        // pclk pulse on late collision frame.
  reg           tx_deferred_pclk;        // pclk pulse if frame was deferred.
  reg           tx_crs_err_pclk;         // pclk pulse if frame had crs error.
  wire          tx_coll_occ_pclk;        // pclk pulse if frame had a collision
  reg           tx_toomanyretry_pclk;    // pclk pulse if frame had too many
                                         // retries.
  wire          tx_pause_zero_pclk;      // pclk pulse when pause timer reaches
                                         // zero or zero pause frame rxed.
  reg           tx_pause_ok_pclk;        // pclk pulse for 802.3 pause frame
                                         // txed OK
  reg           tx_pfc_pause_ok_pclk;    // pclk pulse for PFC pause frame
                                         // txed OK
  reg    [15:0] tx_pause_time_pclk;      // Pause timer value synced to pclk.
  reg           tx_underrun_pclk;        // pclk pulse when tx underrun occured
  always @(*)
  begin
    if (p_edma_tx_pkt_buffer == 1'b1)
    begin
      tx_bytes_pclk        = tx_bytes_in_frame & {14{ok_to_update_tx_stats}};
      tx_broadcast_pclk    = soft_config_fifo_en ? (tx_broadcast_frame    & ok_to_update_tx_stats)  :(tx_broadcast_frame   & tx_end_frame_pulse);
      tx_multicast_pclk    = soft_config_fifo_en ? (tx_multicast_frame    & ok_to_update_tx_stats)  :(tx_multicast_frame   & tx_end_frame_pulse);
      tx_single_col_pclk   = soft_config_fifo_en ? (tx_single_coll_frame  & ok_to_update_tx_stats)  :(tx_single_coll_frame  & tx_end_frame_pulse);
      tx_multi_col_pclk    = soft_config_fifo_en ? (tx_multi_coll_frame   & ok_to_update_tx_stats)  :(tx_multi_coll_frame   & tx_end_frame_pulse);
      tx_deferred_pclk     = soft_config_fifo_en ? (tx_deferred_tx_frame  & ok_to_update_tx_stats)  :(tx_deferred_tx_frame    & tx_end_frame_pulse);
      tx_crs_err_pclk      = soft_config_fifo_en ? (tx_crs_error_frame    & ok_to_update_tx_stats)  :(tx_crs_error_frame     & tx_end_frame_pulse);
      tx_pause_ok_pclk     = soft_config_fifo_en ? (tx_pause_frame_txed   & ok_to_update_tx_stats)  :(tx_pause_frame_txed    & tx_end_frame_pulse);
      tx_pfc_pause_ok_pclk = soft_config_fifo_en ? (tx_pfc_pause_frame_txed & ok_to_update_tx_stats):(tx_pfc_pause_frame_txed & tx_end_frame_pulse);
      tx_late_col_mac_pclk = soft_config_fifo_en ? (tx_late_coll_frame   & ok_to_update_tx_stats)   :(tx_late_coll_frame  & tx_end_frame_pulse);
      tx_late_col_pclk     = soft_config_fifo_en ? (tx_late_coll_frame   & ok_to_update_tx_stats)   :(tx_dma_late_col & update_tx_dma_status);
      tx_toomanyretry_pclk = soft_config_fifo_en ? (tx_too_many_retries  & ok_to_update_tx_stats)   :(tx_dma_toomanyretry  & update_tx_dma_status);
      tx_underrun_pclk     = soft_config_fifo_en ? (tx_underflow_frame   & ok_to_update_tx_stats)   :(tx_dma_underflow  & update_tx_dma_status);
    end
    else
    begin
      tx_bytes_pclk        = tx_bytes_in_frame;
      tx_broadcast_pclk    = tx_broadcast_frame      & ok_to_update_tx_stats;
      tx_multicast_pclk    = tx_multicast_frame      & ok_to_update_tx_stats;
      tx_single_col_pclk   = tx_single_coll_frame    & ok_to_update_tx_stats;
      tx_multi_col_pclk    = tx_multi_coll_frame     & ok_to_update_tx_stats;
      tx_deferred_pclk     = tx_deferred_tx_frame    & ok_to_update_tx_stats;
      tx_crs_err_pclk      = tx_crs_error_frame      & ok_to_update_tx_stats;
      tx_pause_ok_pclk     = tx_pause_frame_txed     & ok_to_update_tx_stats;
      tx_pfc_pause_ok_pclk = tx_pfc_pause_frame_txed & ok_to_update_tx_stats;
      tx_late_col_mac_pclk = tx_late_coll_frame      & ok_to_update_tx_stats;
      tx_late_col_pclk     = tx_late_coll_frame      & ok_to_update_tx_stats;
      tx_toomanyretry_pclk = tx_too_many_retries     & ok_to_update_tx_stats;
      tx_underrun_pclk     = tx_underflow_frame      & ok_to_update_tx_stats;
    end
  end


//------------------------------------------------------------------------------
// Other TX/RX MAC to Register synchronisation
//------------------------------------------------------------------------------

   // synchronise pause_time_tog signal from the TX block to pclk
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tx_pause_time_tog (
      .clk(pclk),
      .reset_n(n_preset),
      .din(tx_pause_time_tog),
      .dout(tx_pause_tog_sync));

   always@(posedge pclk or negedge n_preset)
   begin
      if (~n_preset)
         begin
            tx_pause_tog_del   <= 1'b0;
         end
      else
         begin
            tx_pause_tog_del   <= tx_pause_tog_sync;
         end
   end

   // detect edge on pause_time_tog signal from the TX block to pclk
   assign tx_pause_tog_edge = tx_pause_tog_sync ^ tx_pause_tog_del;


   // assign detected tx_pause_time_tog to acknowledge signal. This is used by
   // the TX block to know when it is safe to send a new tx_pause_time_tog.
   assign tx_pause_tog_ack = tx_pause_tog_del;


   // synchronise pause_time signal from the rx block to pclk
   always@(posedge pclk or negedge n_preset)
   begin
      if (~n_preset)
         begin
            tx_pause_time_pclk  <= 16'h0000;
         end
      else
         begin
            // sample synchronising flop when edge detected on handshake
            if (tx_pause_tog_edge)
               tx_pause_time_pclk  <= tx_pause_time;
            else
               tx_pause_time_pclk  <= tx_pause_time_pclk;
         end
   end

   // detect when tx_pause time has just decremented to zero
   assign tx_pause_zero_pclk = tx_pause_tog_edge &
                               (tx_pause_time == 16'h0000);




   // synchronise tx_coll_occured signal from the tx block to pclk and detect
   // the leading edge
   edma_sync_toggle_detect i_edma_sync_toggle_detect_tx_coll_occured (
      .clk(pclk),
      .reset_n(n_preset),
      .din(tx_coll_occured),
      .rise_edge(tx_coll_occ_pclk),
      .fall_edge(),
      .any_edge());



//------------------------------------------------------------------------------
// DMA RX to register block end of frame synchronisation
//------------------------------------------------------------------------------

   // synchronise rx_dma_stable_tog and generate pulse for registers
   // update and toggle back to hclk domain
   edma_sync_toggle_detect i_edma_sync_toggle_detect_rx_dma_stable_tog (
      .clk(pclk),
      .reset_n(n_preset),
      .din(rx_dma_stable_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge(update_rx_dma_status));

   always@(posedge pclk or negedge n_preset)
   begin
      if (~n_preset)
         begin
            rx_dma_stat_capt_tog <= 1'b0;
         end
      else
         begin

            // send toggle back to DMA RX block
            if ((p_edma_rx_pkt_buffer == 1'b1 && update_rx_dma_status) ||
                (p_edma_rx_pkt_buffer == 1'b0 && ok_to_update_rx_stats))
               rx_dma_stat_capt_tog <= ~rx_dma_stat_capt_tog;
            else
               rx_dma_stat_capt_tog <= rx_dma_stat_capt_tog;
         end
   end

   // drive pclk pulses to the registers block to set or increment status/stats
   // when both the DMA and MAC have completed
   // Handshaking delay ensures that sync1 signals are stable by the time
   // they are enabled by the all_done signal
   assign rx_resource_err_pclk = rx_dma_resource_err & update_rx_dma_status;
   assign rx_hresp_notok_pclk  = rx_dma_hresp_notok & update_rx_dma_status;
   assign rx_dma_int_queue_pclk  = rx_dma_int_queue & {4{update_rx_dma_status}};

   // synchronise rx_dma_buff_not_rdy signal from the dma block to pclk and
   // detect the leading edge
   edma_sync_toggle_detect i_edma_sync_toggle_detect_rx_dma_buff_not_rdy (
      .clk(pclk),
      .reset_n(n_preset),
      .din(rx_dma_buff_not_rdy),
      .rise_edge(rx_buff_not_rdy_pclk_int),
      .fall_edge(),
      .any_edge());

  // the following is required to remove a CDC issue
  generate if (p_edma_rx_pkt_buffer == 0) begin : gen_rx_buff_not_rdy_leg
    reg rx_buff_not_rdy_pclk_r;
    always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
         rx_buff_not_rdy_pclk_r <= 1'b0;
      else
         rx_buff_not_rdy_pclk_r <= rx_buff_not_rdy_pclk_int;
    end
    assign rx_buff_not_rdy_pclk = rx_buff_not_rdy_pclk_r;
  end else begin : gen_rx_buff_not_rdy_pbuf
    assign rx_buff_not_rdy_pclk = rx_buff_not_rdy_pclk_int;
  end
  endgenerate

generate if (p_edma_axi == 1'b1) begin : gen_axi
   // Sync Major error
   edma_sync_toggle_detect #(
      .DIN_W(3)
   ) i_edma_sync_toggle_detect_disable (
      .clk(pclk),
      .reset_n(n_preset),
      .din({disable_tx,disable_rx,axi_tx_frame_too_large}),
      .rise_edge({disable_tx_pclk,disable_rx_pclk,tx_frame_too_large_pclk}),
      .fall_edge(),
      .any_edge());

  cdnsdru_datasync_v1 i_edma_sync_axi_xaction_out (.clk(pclk),.reset_n(n_preset),.din(axi_xaction_out),.dout(axi_xaction_out_pclk));

end else begin : gen_no_axi
  assign disable_tx_pclk         = 1'b0;
  assign disable_rx_pclk         = 1'b0;
  assign tx_frame_too_large_pclk = 1'b0;
  assign axi_xaction_out_pclk    = 1'b0;
end
endgenerate

//------------------------------------------------------------------------------
// DMA TX to register block end of frame synchronisation
//------------------------------------------------------------------------------

   // synchronise tx_dma_stable_tog and generate pulse for registers
   // update and toggle back to hclk domain
   edma_sync_toggle_detect i_edma_sync_toggle_detect_tx_dma_stable_tog (
      .clk(pclk),
      .reset_n(n_preset),
      .din(tx_dma_stable_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge(update_tx_dma_status));

   always@(posedge pclk or negedge n_preset)
   begin
       if (~n_preset)
         begin
            tx_dma_stat_capt_tog <= 1'b0;
         end
      else
         begin
            // send toggle back to DMA RX block
            if ((p_edma_tx_pkt_buffer == 1'b1 && update_tx_dma_status) ||
                (p_edma_tx_pkt_buffer == 1'b0 && ok_to_update_tx_stats))
               tx_dma_stat_capt_tog <= ~tx_dma_stat_capt_tog;
            else
               tx_dma_stat_capt_tog <= tx_dma_stat_capt_tog;
         end
   end



   // drive pclk pulses to the registers block to set or increment status/stats
   // when both the DMA and MAC have completed.
   // Handshaking delay ensures that sync1 signals are stable by the time
   // they are enabled by the all_done signal
   assign tx_buffers_ex_pclk    = tx_dma_buffers_ex  & update_tx_dma_status;
   assign tx_buff_ex_mid_pclk   = tx_dma_buff_ex_mid & update_tx_dma_status;
   assign tx_hresp_notok_pclk   = tx_dma_hresp_notok & update_tx_dma_status;
   assign tx_dma_int_queue_pclk = tx_dma_int_queue   & {4{update_tx_dma_status}};


   // synchronise tx_go signal from the dma block to pclk
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tx_dma_go (
      .clk(pclk),
      .reset_n(n_preset),
      .din(tx_dma_go),
      .dout(tx_go_pclk));


//------------------------------------------------------------------------------
// Descriptor queue pointer synchonisation for reading during debug
//------------------------------------------------------------------------------

   // Descriptor queue pointer synchonisation for reading during debug.
   // These buses are generated in HCLK and synchronised into PCLK
   // using handshaking.
   // These registers are only for test purposes, and hence will only be read
   // at the end of a test when the source is stable.
   // If new queue value is written, the pclk value is updated immediately
   // so that it may be read back in next APB read.

   edma_sync_toggle_detect #(
      .DIN_W(2)
   ) i_edma_sync_toggle_detect_dma_descr_ptr_tog (
      .clk(pclk),
      .reset_n(n_preset),
      .din({tx_dma_descr_ptr_tog,rx_dma_descr_ptr_tog}),
      .rise_edge(),
      .fall_edge(),
      .any_edge({tx_dma_descr_ptr_tog_edge,rx_dma_descr_ptr_tog_edge}));

   always@(posedge pclk or negedge n_preset)
   begin
      if (~n_preset)
         begin
            tx_dma_descr_ptr_pclk      <= 32'd0;
            rx_dma_descr_ptr_pclk      <= 32'd0;
            new_transmit_q_ptr_d1      <= 1'b0;
            new_receive_q_ptr_d1       <= 1'b0;
         end
      else
         begin

            // detect toggle signals to update counts from hclk

            new_receive_q_ptr_d1       <= new_receive_q_ptr;
            new_transmit_q_ptr_d1      <= new_transmit_q_ptr;


            // If new transmit queue pointer written, update with new value
            if (new_transmit_q_ptr ^ new_transmit_q_ptr_d1)
               tx_dma_descr_ptr_pclk  <= tx_dma_descr_base_addr;

            // If new update seen then load new value
            else if (tx_dma_descr_ptr_tog_edge)
               tx_dma_descr_ptr_pclk  <= tx_dma_descr_ptr;


            // If new receive queue pointer written, update with new value
            if (new_receive_q_ptr ^ new_receive_q_ptr_d1)
               rx_dma_descr_ptr_pclk  <= rx_dma_descr_base_addr;

            // If new update seen then load new value
            else if (rx_dma_descr_ptr_tog_edge)
               rx_dma_descr_ptr_pclk  <= rx_dma_descr_ptr;

         end
   end



//------------------------------------------------------------------------------
// TX complete OK logic
//------------------------------------------------------------------------------

  generate if (p_edma_ext_fifo_interface == 1'b1 || p_edma_tx_pkt_buffer == 1'b1) begin : gen_trigger_update_tx
    assign ok_to_update_tx_stats = tx_end_frame_pulse;
  end else begin : gen_trigger_update_legacy
     // Detect when TX MAC finishes and store until TX DMA finishes. Only expect
     // TX DMA to finish if not a pause frame.
     reg  tx_done_pclk;            // MAC TX completed
     always@(posedge pclk or negedge n_preset)
     begin
        if (~n_preset)
           begin
              tx_done_pclk <= 1'b0;
           end
        else
           begin
              // Store that MAC has completed, when still waiting for
              // DMA to complete. Only set if expecting DMA to complete.
              if (tx_end_frame_pulse & ~tx_pause_frame_txed &
                  ~tx_pfc_pause_frame_txed &
                  ~update_tx_dma_status)
                 tx_done_pclk <= 1'b1;

              // Reset MAC done stored once DMA is complete.
              else if (update_tx_dma_status)
                 tx_done_pclk <= 1'b0;

              // Else maintain value
              else
                 tx_done_pclk <= tx_done_pclk;
           end
     end

     // detect when both the MAC and DMA have finished
     // Force completion if not expecting DMA to finish.
     // Not expecting to see a MAC finish if buffers exhausted is seen since
     // no data is sent to the MAC.

     assign ok_to_update_tx_stats =   ((update_tx_dma_status |
                                       ((tx_pause_frame_txed|tx_pfc_pause_frame_txed)& tx_end_frame_pulse)) &
                                        (tx_end_frame_pulse | tx_done_pclk | (tx_dma_buffers_ex & update_tx_dma_status)));
  end
  endgenerate

   // Identify when just MAC is done.
   // In legacy DMA modes, we use the legacy DMA here ...
   assign tx_mac_ok_pclk =(p_edma_tx_pkt_buffer == 1 || p_edma_ext_fifo_interface == 1)
                                    ? tx_frame_txed_ok & tx_end_frame_pulse       // tx_end_frame_pulse is pclk qualifier
                                    : (tx_dma_complete_ok & update_tx_dma_status);

   // signal TX OK when both MAC and DMA are both done and OK.
   assign tx_ok_pclk     = ((p_edma_ext_fifo_interface == 1) | soft_config_fifo_en)
                                          ? tx_mac_ok_pclk
                                          : (tx_dma_complete_ok & update_tx_dma_status);


//------------------------------------------------------------------------------
// RX complete OK logic
//------------------------------------------------------------------------------
  generate if (p_edma_ext_fifo_interface == 1'b1) begin : gen_rx_fifo_trig
    assign ok_to_update_rx_stats = rx_end_frame_pulse;
    assign rx_ok_pclk  = rx_frame_rxed_ok & rx_end_frame_pulse;
    assign rx_mac_ok_pclk = rx_ok_pclk;
  end else if (p_edma_rx_pkt_buffer == 1) begin : gen_rx_pbuf_trig
      assign ok_to_update_rx_stats = rx_end_frame_pulse;

      // signal RX OK when both MAC and DMA are both done and OK
      assign rx_ok_pclk     = soft_config_fifo_en ? (rx_frame_rxed_ok & rx_end_frame_pulse) : (rx_dma_complete_ok & update_rx_dma_status);
      assign rx_mac_ok_pclk = soft_config_fifo_en ?  rx_ok_pclk : (rx_frame_rxed_ok & rx_end_frame_pulse);
  end else begin : gen_rx_legacy_trig
    reg           rx_done_pclk;            // MAC TX completed
    assign rx_mac_ok_pclk = rx_ok_pclk;
    // Detect when RX MAC finishes and store until RX DMA finishes. Only expect
    // RX DMA to finish if frame is OK'ed by RX MAC.
    always@(posedge pclk or negedge n_preset)
    begin
       if (~n_preset)
          begin
             rx_done_pclk <= 1'b0;
          end
       else
          begin
             // Store that MAC has completed, when still waiting for
             // DMA to complete. Only set if expecting DMA to complete.
             if (rx_end_frame_pulse & rx_frame_rxed_ok & ~update_rx_dma_status)
                rx_done_pclk <= 1'b1;

             // Reset MAC done stored once DMA is complete.
             else if (update_rx_dma_status)
                rx_done_pclk <= 1'b0;

             // Else maintain value
             else
                rx_done_pclk <= rx_done_pclk;
          end
    end

    // Detect when both the MAC and DMA have finished
    // Force completion if not expecting DMA to finish.
    assign ok_to_update_rx_stats = ((update_rx_dma_status |
                                     (~rx_frame_rxed_ok & rx_end_frame_pulse)) &
                                     (rx_end_frame_pulse | rx_done_pclk));

    // signal RX OK when both MAC and DMA are both done and OK
    assign rx_ok_pclk = (rx_frame_rxed_ok & rx_dma_complete_ok & ok_to_update_rx_stats);

  end
  endgenerate

//------------------------------------------------------------------------------
// Interrupt moderation stuff
//------------------------------------------------------------------------------
  // With interrupt moderation receive and transmit interrupts are not generated
  // immediately a frame is transmitted or received. Instead when a receive or
  // transmit event occurs a timer is started and the interrupt is asserted
  // after it times out. This limits the frequency with which the CPU receives
  // interrupts. This means the CPU only has to process transmit and receive
  // traffic periodically. This is useful in high traffic environments. It is
  // less useful in low traffic environments where a single packet will incur
  // the full timer latency.
  //
  // The timer counts an integer number of 800ns periods. 800 nanoseconds is
  // the clock period for 10M SGMII mode operation.
  //
  // For both receive and transmit events these 800 nanoseconds will be counted
  // in the tx_clk domain.


  // Transmit interrupt moderation
  // first generate tx_clk timed transmit event pulse tx_ok_txclk

  // Use same end of frame event for both FIFO and DMA configs. It is OK to generate this immediately
  // at end of frame because the interrupt moderation functionality will have already delayed
  // CPU activity so there is no need to wait for DMA complete indication
  reg  tx_frame_txed_ok_del;
  always@(posedge tx_clk or negedge n_txreset)
    begin
      if(~n_txreset)
         tx_frame_txed_ok_del <= 1'b0;
      else
         tx_frame_txed_ok_del <= tx_frame_txed_ok;
    end

  assign tx_ok_txclk = (tx_frame_txed_ok & ~tx_frame_txed_ok_del);


   // speed_mode[3:0] indicates {two_pt_five_gig, tbi, gigabit, 100M}
   // ie speed and interface selected.
   // Can be decoded as follows:
   //  bits- 2 1 0              function
   //  ------------------------------------------------
   //        1 1 x      1000 Mbits/s using TBI interface    125Mhz tx_clk
   //        0 1 x      1000 Mbits/s using GMII interface   125Mhz tx_clk
   //        0 0 1       100 Mbits/s using MII interface     25Mhz tx_clk
   //        1 0 1       100 Mbits/s using SGMII interface 12.5Mhz tx_clk
   //        0 0 0        10 Mbits/s using MII interface    2.5Mhz tx_clk
   //        1 0 0        10 Mbits/s using SGMII interface 1.25Mhz tx_clk

  // clks_in_800 is assigned with one less than the total number of clock periods in 800 ns
  // speed_mode is assumed static so does not need synchronization to tx_clk
  assign clks_in_800 = (speed_mode[3])         ? 8'd249:  // 312.5MHz tx_clk (3.2ns period)
                       (speed_mode[1])         ? 8'd99:   // 125MHz tx_clk (8ns period)
                       (speed_mode == 4'b0001) ? 8'd19:   // 25Mhz tx_clk (40ns period)
                       (speed_mode == 4'b0101) ? 8'd09:   // 12.5Mhz tx_clk (80ns period)
                       (speed_mode == 4'b0000) ? 8'd01:   // 2.5Mhz tx_clk (400ns period)
                                                 8'd00;   // 1.25MHz tx_clk (800ns period)

    // perform the time-based moderation
    always@(posedge tx_clk or negedge n_txreset)
    begin
       if (~n_txreset)
          begin
             tx_cnt_800 <= 8'h00;
             tx_int_mod <= 8'h00;
          end
       else if ((tx_int_moderation == 8'h00) || tx_th_mod_complete)
          // no interrupt moderation when tx_int_moderation is zero and reset if thresh-hold based moderation completes
          begin
             tx_cnt_800 <= 8'h00;
             tx_int_mod <= 8'h00;
          end
       else if ((tx_cnt_800 == clks_in_800) && (tx_int_mod != 8'h00))
          // count down tx_int_mod every 800 nanoseconds and assert tx_tb_mod_complete when it reaches zero
          begin
             tx_cnt_800 <= 8'h00;
             tx_int_mod <= tx_int_mod - 1'b1;
          end
       else if ((tx_ok_txclk) && (tx_int_mod == 8'h00))
          // set tx_int_mod to value in tx_int_moderation on transmit event
          begin
             tx_cnt_800 <= 8'h00;
             tx_int_mod <= tx_int_moderation;
          end
       else if (tx_int_mod != 8'h00)
          begin
             tx_cnt_800 <= tx_cnt_800 + 1'b1;
             tx_int_mod <= tx_int_mod;
          end
    end
    // signal completion on condition that decrements tx_int_mod to zero
    assign tx_tb_mod_complete = (tx_cnt_800 == clks_in_800) && (tx_int_mod == 8'h01);


    // perform the thresh-hold based moderation
    always@(posedge tx_clk or negedge n_txreset)
    begin
       if (~n_txreset)
          begin
             tx_int_mod_th <= 8'h00;
          end
       else if ((tx_int_mod_thresh == 8'h00) || tx_tb_mod_complete)
          // no interrupt moderation when tx_int_mod_thresh is zero and reset if time-based moderation completes
          begin
             tx_int_mod_th <= 8'h00;
          end
       else if ((tx_ok_txclk) && (tx_int_mod_th != 8'h00))
          // count down tx_int_mod_th with every transmit interrupt and assert tx_th_mod_complete when it reaches zero
          begin
             tx_int_mod_th <= tx_int_mod_th - 1'b1;
          end
       else if ((tx_ok_txclk) && (tx_int_mod_th == 8'h00))
          // set tx_int_mod_th to value in tx_int_mod_thresh on transmit event
          begin
             tx_int_mod_th <= tx_int_mod_thresh - 1'b1;  // needs to be one less because we have already transmitted a frame
          end
    end
    // signal completion on condition that decrements tx_int_mod_th to zero
    assign tx_th_mod_complete = (tx_ok_txclk) && (tx_int_mod_th == 8'h01);


    // generate the toggle signal if either time-based or thresh-hold based moderation completes
    // note tx_tb_mod_complete and tx_th_mod_complete reset each other's moderation so although it is possible for them to
    // occur simulataneously they cannot occur close together
    always@(posedge tx_clk or negedge n_txreset)
    begin
       if (~n_txreset)
          begin
             tx_ok_mod_tog <= 1'b0;
          end
       else if (tx_tb_mod_complete || tx_th_mod_complete)
          // generate toggle
          begin
             tx_ok_mod_tog <= ~tx_ok_mod_tog;
          end
       else
          begin
             tx_ok_mod_tog <= tx_ok_mod_tog;
          end
    end

    // generate pclk timed pulse when tx_ok_mod_tog toggles
    edma_sync_toggle_detect i_edma_sync_toggle_detect_tx_ok_mod_pulse (
      .clk(pclk),
      .reset_n(n_preset),
      .din(tx_ok_mod_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge(tx_ok_mod_pulse));

    // generate tx_ok_mod_pclk which goes to gem_registers to assert the transmit interrupt
    // note thresh-hold of one means you need an interrupt with every transmitted frame - this is not detected by the code above because one less is loaded
    // also when threshold is set to one time based moderation is blocked
    assign tx_ok_mod_pclk = ((int_moderation[31:16] == 16'h0000)  | (tx_int_mod_thresh == 8'h01)) ? tx_ok_pclk : tx_ok_mod_pulse;


    // Receive interrupt moderation
    // first generate tx_clk timed receive event pulse rx_ok_txclk
    generate if ((p_edma_ext_fifo_interface == 1'b1)||(p_edma_rx_pkt_buffer == 1'b0)) begin: gen_rx_ok_legacydma_or_fifo
      // synchronise rx complete to tx_clk - rx_frame_rxed_ok is assumed to be static
      wire rx_end_frame_pulse_txclk;
      edma_sync_toggle_detect i_edma_sync_toggle_detect_rx_end_tog_tx (
        .clk      (tx_clk),
        .reset_n  (n_txreset),
        .din      (rx_end_tog),
        .rise_edge(),
        .fall_edge(),
        .any_edge (rx_end_frame_pulse_txclk)
      );

      assign rx_ok_txclk = rx_frame_rxed_ok & rx_end_frame_pulse_txclk;

    end else begin: gen_rx_ok_pbuf_dma

      // synchronise dma complete to tx_clk
      wire rx_dma_stable_pulse;
      edma_sync_toggle_detect i_edma_sync_toggle_rx_dma_stable_pulse (
        .clk      (tx_clk),
        .reset_n  (n_txreset),
        .din      (rx_dma_stable_tog),
        .rise_edge(),
        .fall_edge(),
        .any_edge (rx_dma_stable_pulse)
      );

      if (p_edma_host_if_soft_select == 1'b1) begin: gen_rx_end_frame_pulse_txclk
        // synchronise rx complete to tx_clk - rx_frame_rxed_ok is assumed to be static
        // Note: if p_edma_host_if_soft_select is zero, soft_config_fifo_en is forced to zero too
        // so if we hadn't created another if..else.. the signal rx_end_frame_pulse_txclk would be unused
        // in all the configs with no soft if selection, resulting in a Black Box in syn2pnr LEC reports.
        wire rx_end_frame_pulse_txclk;
        edma_sync_toggle_detect i_edma_sync_toggle_detect_rx_end_tog_tx (
          .clk      (tx_clk),
          .reset_n  (n_txreset),
          .din      (rx_end_tog),
          .rise_edge(),
          .fall_edge(),
          .any_edge (rx_end_frame_pulse_txclk)
        );

        assign rx_ok_txclk = soft_config_fifo_en ? (rx_frame_rxed_ok & rx_end_frame_pulse_txclk)
                                                 : (rx_dma_stable_pulse);
      end else begin: no_gen_rx_end_frame_pulse_txclk
        assign rx_ok_txclk = rx_dma_stable_pulse;
      end

    end
    endgenerate

    // perform the time-based moderation
    always@(posedge tx_clk or negedge n_txreset)
    begin
       if (~n_txreset)
          begin
             rx_cnt_800 <= 8'h00;
             rx_int_mod <= 8'h00;
          end
       else if ((rx_int_moderation == 8'h00) || rx_th_mod_complete)
          // no interrupt moderation when rx_int_moderation is zero and reset if thresh-hold based moderation completes
          begin
             rx_cnt_800 <= 8'h00;
             rx_int_mod <= 8'h00;
          end
       else if ((rx_cnt_800 == clks_in_800) && (rx_int_mod != 8'h00))
          // count down rx_int_mod every 800 nanoseconds and toggle rx_tb_mod_complete when it reaches zero
          begin
             rx_cnt_800 <= 8'h00;
             rx_int_mod <= rx_int_mod - 1'b1;
          end
       else if ((rx_ok_txclk) && (rx_int_mod == 8'h00))
          // set rx_int_mod to value in rx_int_moderation on receive event
          begin
             rx_cnt_800 <= 8'h00;
             rx_int_mod <= rx_int_moderation;
          end
       else if (rx_int_mod != 8'h00)
          begin
             rx_cnt_800 <= rx_cnt_800 + 1'b1;
             rx_int_mod <= rx_int_mod;
          end
    end
    // signal completion on condition that decrements rx_int_mod to zero
    assign rx_tb_mod_complete = (rx_cnt_800 == clks_in_800) && (rx_int_mod == 8'h01);


    // perform the thresh-hold based moderation
    always@(posedge tx_clk or negedge n_txreset)
    begin
       if (~n_txreset)
          begin
             rx_int_mod_th <= 8'h00;
          end
       else if ((rx_int_mod_thresh == 8'h00) || rx_tb_mod_complete)
          // no interrupt moderation when rx_int_mod_thresh is zero and reset if time-based moderation completes
          begin
             rx_int_mod_th <= 8'h00;
          end
       else if ((rx_ok_txclk) && (rx_int_mod_th != 8'h00))
          // count down rx_int_mod_th with every receive interrupt and assert rx_th_mod_complete when it reaches zero
          begin
             rx_int_mod_th <= rx_int_mod_th - 1'b1;
          end
       else if ((rx_ok_txclk) && (rx_int_mod_th == 8'h00))
          // set rx_int_mod_th to value in rx_int_mod_thresh on receive event
          begin
             rx_int_mod_th <= rx_int_mod_thresh - 1'b1;  // needs to be one less because we have already received a frame
          end
    end
    // signal completion on condition that decrements rx_int_mod_th to zero
    assign rx_th_mod_complete = (rx_ok_txclk) && (rx_int_mod_th == 8'h01);


    // generate the toggle signal if either time-based or thresh-hold based moderation completes
    // note rx_tb_mod_complete and rx_th_mod_complete reset each other's moderation so although it is possible for them to
    // occur simulataneously they cannot occur close together
    always@(posedge tx_clk or negedge n_txreset)
    begin
       if (~n_txreset)
          begin
             rx_ok_mod_tog <= 1'b0;
          end
       else if (rx_tb_mod_complete || rx_th_mod_complete)
          // generate toggle
          begin
             rx_ok_mod_tog <= ~rx_ok_mod_tog;
          end
       else
          begin
             rx_ok_mod_tog <= rx_ok_mod_tog;
          end
    end

    // generate pclk timed pulse when rx_ok_mod_tog toggles
    edma_sync_toggle_detect i_edma_sync_toggle_detect_rx_ok_mod_pulse (
      .clk      (pclk),
      .reset_n  (n_preset),
      .din      (rx_ok_mod_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge (rx_ok_mod_pulse)
    );

    // generate rx_ok_mod_pclk which goes to gem_registers to assert the receive interrupt
    // note thresh-hold of one means you need an interrupt with every receive frame  this is not detected by the code above because one less is loaded
    // also when threshold is set to one time based moderation is blocked
    assign rx_ok_mod_pclk = ((int_moderation[15:0] == 16'h0000) | (rx_int_mod_thresh == 8'h01)) ? rx_ok_pclk : rx_ok_mod_pulse;



//------------------------------------------------------------------------------
// Precision time protocol signals for IEEE 1588 support
//------------------------------------------------------------------------------

   // RX sof sync_frame delay_req pdelay_req ad pdelay_resp synchronisation
   edma_sync_toggle_detect # (
      .DIN_W(4)
   ) i_edma_sync_toggle_detect_rx_ptp (
      .clk(pclk),
      .reset_n(n_preset),
      .din(      {sync_frame_rx,      delay_req_rx,      pdelay_req_rx,      pdelay_resp_rx}),
      .rise_edge({sync_frame_rx_pulse,delay_req_rx_pulse,pdelay_req_rx_pulse,pdelay_resp_rx_pulse}),
      .fall_edge(),
      .any_edge());


   // TX sof sync_frame delay_req pdelay_req ad pdelay_resp synchronisation
   edma_sync_toggle_detect # (
      .DIN_W(4)
   ) i_edma_sync_toggle_detect_tx_ptp (
      .clk(pclk),
      .reset_n(n_preset),
      .din(      {sync_frame_tx,      delay_req_tx,      pdelay_req_tx,      pdelay_resp_tx}),
      .rise_edge({sync_frame_tx_pulse,delay_req_tx_pulse,pdelay_req_tx_pulse,pdelay_resp_tx_pulse}),
      .fall_edge(),
      .any_edge());


   // PTP event frame rx and tx interrupts
   always@(posedge pclk or negedge n_preset)
   begin
      if (~n_preset)
         begin
            ptp_sync_tx_int      <= 1'b0;
            ptp_del_tx_int       <= 1'b0;
            ptp_pdel_req_tx_int  <= 1'b0;
            ptp_pdel_resp_tx_int <= 1'b0;
            ptp_sync_rx_int      <= 1'b0;
            ptp_del_rx_int       <= 1'b0;
            ptp_pdel_req_rx_int  <= 1'b0;
            ptp_pdel_resp_rx_int <= 1'b0;
         end
      else
         begin
            // interrupt signals are set with rising edge of sync_frame_tx,
            // sync_frame_rx, delay_req_tx or delay_req_rx, reset after ahp read
            // interrupt status register
            if (sync_frame_tx_pulse)
               ptp_sync_tx_int <= 1'b1;
            else if (ptp_sync_tx_int)
               ptp_sync_tx_int <= 1'b0;

            if (delay_req_tx_pulse)
               ptp_del_tx_int <= 1'b1;
            else if (ptp_del_tx_int)
               ptp_del_tx_int <= 1'b0;
            if (sync_frame_rx_pulse)
               ptp_sync_rx_int <= 1'b1;
            else if (ptp_sync_rx_int)
               ptp_sync_rx_int <= 1'b0;

            if (delay_req_rx_pulse)
               ptp_del_rx_int <= 1'b1;
            else if (ptp_del_rx_int)
               ptp_del_rx_int <= 1'b0;

            // interrupt signals are set with rising edge of pdelay_req_tx,
            // pdelay_req_rx, pdelay_resp_tx or pdelay_resp_rx, reset after
            // ahp read interrupt status register
            if (pdelay_req_tx_pulse)
               ptp_pdel_req_tx_int <= 1'b1;
            else if (ptp_pdel_req_tx_int)
               ptp_pdel_req_tx_int <= 1'b0;

            if (pdelay_resp_tx_pulse)
               ptp_pdel_resp_tx_int <= 1'b1;
            else if (ptp_pdel_resp_tx_int)
               ptp_pdel_resp_tx_int <= 1'b0;

            if (pdelay_req_rx_pulse)
               ptp_pdel_req_rx_int <= 1'b1;
            else if (ptp_pdel_req_rx_int)
               ptp_pdel_req_rx_int <= 1'b0;

            if (pdelay_resp_rx_pulse)
               ptp_pdel_resp_rx_int <= 1'b1;
            else if (ptp_pdel_resp_rx_int)
               ptp_pdel_resp_rx_int <= 1'b0;
         end
   end

  generate if (p_edma_tsu == 1'b1) begin : gen_tsu_specific
   assign ptp_rx_time_load    = delay_req_rx_pulse | sync_frame_rx_pulse;

   // used to set peer received interrupts and to load timer value to peer
   // event frame received register, assert on rising edge

   assign ptp_rx_ptime_load = pdelay_req_rx_pulse | pdelay_resp_rx_pulse;

   // used to set PTP transmitted interrupts and to cature timer and to
   // load value to PTP event frame transmitted register, assert on rising edge
   assign ptp_tx_time_load    = delay_req_tx_pulse | sync_frame_tx_pulse;


   // used to set peer transmitted interrupts and to load timer value to peer
   // event frame transmitted register, assert on rising edge
   assign ptp_tx_ptime_load = pdelay_req_tx_pulse | pdelay_resp_tx_pulse;



    // synchronization of TSU timer comparison valid
    // used to set TSU timer comparison valid interrupt
    // eth_1696 fix
    // First stage changes tsu_timer_cmp_val from tsu_clk timed pulse to a toggle by inverting tsu_timer_cmp_tog when tsu_timer_cmp_val is pulsed high
    // In second stage, move timer_cmp_val_pulse from rise_edge to any_edge
    assign tsu_timer_cmp_tog_cmb = tsu_timer_cmp_val ? (~tsu_timer_cmp_tog) : tsu_timer_cmp_tog;
    always@(posedge tsu_clk or negedge n_tsureset)
    begin
       if (~n_tsureset)
          begin
             tsu_timer_cmp_tog <= 1'b0;
          end
       else
          begin
             tsu_timer_cmp_tog <= tsu_timer_cmp_tog_cmb;
          end
    end

    edma_sync_toggle_detect i_edma_sync_toggle_detect_tsu_timer_cmp_val (
       .clk(pclk),
       .reset_n(n_preset),
       .din(tsu_timer_cmp_tog),
       .rise_edge(),
       .fall_edge(),
       .any_edge(timer_cmp_val_pulse));


    reg timer_cmp_val_int_r;
    // TSU timer comparison valid interrupt
    always@(posedge pclk or negedge n_preset)
    begin
       if (~n_preset)
          begin
             timer_cmp_val_int_r   <= 1'b0;
          end
       else
          begin
             // interrupt signal is set with rising edge of tsu_timer_cmp_val,
             if (timer_cmp_val_pulse)
                timer_cmp_val_int_r <= 1'b1;
             else if (timer_cmp_val_int)
                timer_cmp_val_int_r <= 1'b0;
          end
    end
    assign timer_cmp_val_int = timer_cmp_val_int_r;


    if (p_edma_tsu_clk == 1'b1) begin : gen_tsu_clk_specific
      // Timer seconds increment synchronisation
      edma_sync_toggle_detect # (
         .DIN_W(1)
      ) i_edma_sync_toggle_detect_timer_tsu (
         .clk(pclk),
         .reset_n(n_preset),
         .din({timer_strobe}),
         .rise_edge({timer_str_sync}),
         .fall_edge(),
         .any_edge());

      edma_sync_toggle_detect # (
         .DIN_W(1)
      ) i_edma_sync_toggle_detect_sec_int_tsu (
         .clk(pclk),
         .reset_n(n_preset),
         .din(tsu_sec_incr),
         .rise_edge(),
         .fall_edge(),
         .any_edge(tsu_incr_sec_int));

/*
      // time at sof which will be sampled using sync_frame_tx to gem_registers
      localparam p_tsu_has_par = ((p_edma_asf_dap_prot == 1) || (p_edma_asf_csr_prot == 1));
      localparam p_tsu_xfer_w  = (p_tsu_has_par > 0) ? 88  : 78;

      wire  [p_tsu_xfer_w-1:0]  tsu_bus_src,  tsu_bus_pclk;

      if (p_tsu_has_par > 0) begin : gen_tsu_has_par
        assign tsu_bus_src              = {tsu_timer_cnt_par[11:2],tsu_timer_cnt[93:16]};
        assign {tsu_timer_cnt_par_pclk,
                tsu_timer_cnt_pclk}     = tsu_bus_pclk;
      end else begin : gen_tsu_has_no_par
        assign tsu_bus_src              = tsu_timer_cnt[93:16];
        assign tsu_timer_cnt_par_pclk   = 10'h000;
        assign tsu_timer_cnt_pclk       = tsu_bus_pclk;
      end

      // Synchronise to pclk and generate valid pulse.
      // The output is not registered as gem_reg_tsu will sample the result
      // on tsu_timer_cnt_pclk_valid.
      gem_bus_sync #(
        .p_dwidth (p_tsu_xfer_w),
        .p_reg_out(0)
      ) i_sync_tsu_bus_pclk (
        .src_clk      (tsu_clk),
        .src_rst_n    (n_tsureset),
        .dest_clk     (pclk),
        .dest_rst_n   (n_preset),
        .src_data     (tsu_bus_src),
        .src_xfer_en  (1'b1),
        .src_data_last(),
        .src_rdy      (),
        .dest_data    (tsu_bus_pclk),
        .dest_val     (tsu_timer_cnt_pclk_vld)
      );
*/
      //
      // time at sof which will be sampled using sync_frame_tx to gem_registers
      wire tsu_timer_fifo_full,tsu_timer_fifo_empty;
      edma_gen_async_fifo #(.DATA_W (88),
                           .ADDR_W (0),
                           .DEPTH  (1)
                          )
                          i_tsu_cnt2pclk_bndry (
       .clk_push   (tsu_clk),
       .clk_pop    (pclk),
       .rst_push_n (n_tsureset),
       .rst_pop_n  (n_preset),

       // Push Interface
       .push           (~tsu_timer_fifo_full),             // Push Data to the FIFO
       .pushd          ({tsu_timer_cnt_par[11:2],          // TODO replace with above
                        tsu_timer_cnt[93:16]}),            // Push Data
       .push_full      (tsu_timer_fifo_full),              // Full (push side)
       .push_overflow  (),                                 // Overflow
       .push_size      (),                                 // Number of entries (push side) in FIFO

       // Pop Interface
       .pop            (~tsu_timer_fifo_empty),            // Pop Data from the FIFO
       .popd           ({tsu_timer_cnt_par_pclk,
                        tsu_timer_cnt_pclk}),              // Pop Data
       .pop_empty      (tsu_timer_fifo_empty),             // Empty (pop side)
       .pop_underflow  (),
       .pop_size       ()                                  // Number of entries (push side) in FIFO
      );
      assign tsu_timer_cnt_pclk_vld = ~tsu_timer_fifo_empty;
    end else begin : gen_no_tsu_clk
       reg tsu_sec_incr_reg;        // sync tsu_sec_incr to pclk
       // used to set PTP received interrupts and to capture timer and load
       // value to PTP event frame received register, assert on rising edge

      assign tsu_timer_cnt_pclk_vld = 1'b1;
      assign tsu_timer_cnt_pclk     = tsu_timer_cnt[93:16];
      assign tsu_timer_cnt_par_pclk = tsu_timer_cnt_par[11:2];

       // Timer seconds increment synchronisation
       always@(posedge pclk or negedge n_preset)
       begin
          if (~n_preset)
             begin
                tsu_sec_incr_reg   <= 1'b0;
             end
          else
             begin
                tsu_sec_incr_reg   <= tsu_sec_incr;
             end
       end

       // used to set Timer seconds increment interrupt assert, on rising edge
       assign tsu_incr_sec_int = tsu_sec_incr ^ tsu_sec_incr_reg;
       assign timer_str_sync   = timer_strobe;
    end // gen_no_tsu_clk_specific
  end else begin : gen_no_tsu_specific
    assign tsu_incr_sec_int       = 1'b0;
    assign ptp_rx_time_load       = 1'b0;
    assign ptp_tx_time_load       = 1'b0;
    assign ptp_tx_ptime_load      = 1'b0;
    assign ptp_rx_ptime_load      = 1'b0;
    assign timer_cmp_val_int      = 1'b0;
    assign tsu_timer_cnt_pclk_vld = 1'b0;
    assign tsu_timer_cnt_pclk     = {78{1'b0}};
    assign tsu_timer_cnt_par_pclk = 10'h000;
    assign timer_str_sync         = 1'b0;
  end
  endgenerate

   //-----------------------------------------
   //----- synchronise pfc_negotiate    ------
   //-----------------------------------------
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_pfc_negotiate (
      .clk(pclk),
      .reset_n(n_preset),
      .din(pfc_negotiate),
      .dout(pfc_negotiate_pclk));

   //-----------------------------------------
   //----- synchronise rx_pfc_paused    ------
   //-----------------------------------------
   cdnsdru_datasync_v1 #(
      .CDNSDRU_DATASYNC_DIN_W(8)
   ) i_cdnsdru_datasync_v1_rx_pfc_paused (
      .clk(pclk),
      .reset_n(n_preset),
      .din(rx_pfc_paused),
      .dout(rx_pfc_paused_pclk));

   //-----------------------------------------
   //----- synchronise lpi_indicate    ------
   //-----------------------------------------
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_lpi_indicate (
      .clk(pclk),
      .reset_n(n_preset),
      .din(lpi_indicate),
      .dout(lpi_indicate_pclk));
   always@(posedge pclk or negedge n_preset)
   begin
      if (~n_preset)
         begin
            lpi_indicate_del   <= 1'b0;
         end
      else
         begin
            lpi_indicate_del   <= lpi_indicate_pclk;
         end
   end

   //-----------------------------------------
   // synchronise wol and detect rising edge
   //-----------------------------------------
   edma_sync_toggle_detect i_edma_sync_toggle_detect_wol (
      .clk(pclk),
      .reset_n(n_preset),
      .din(wol),
      .rise_edge(wol_pulse),
      .fall_edge(),
      .any_edge());

  // Synchronise and toggle detect the toggles from the MAC RX for
  // updating 802.1CB statistics
  generate if ((p_gem_has_cb == 1'b1) && (p_num_type2_screeners > 8'd0))
  begin : gen_cb
    edma_sync_toggle_detect i_sync_tog_frer_to[p_gem_num_cb_streams-1:0] (
      .clk      (pclk),
      .reset_n  (n_preset),
      .din      (frer_to_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge (frer_to_pulse)
    );
    edma_sync_toggle_detect i_sync_tog_frer_rogue[p_gem_num_cb_streams-1:0] (
      .clk      (pclk),
      .reset_n  (n_preset),
      .din      (frer_rogue_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge (frer_rogue_pulse)
    );
    edma_sync_toggle_detect i_sync_tog_frer_ooo[p_gem_num_cb_streams-1:0] (
      .clk      (pclk),
      .reset_n  (n_preset),
      .din      (frer_ooo_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge (frer_ooo_pulse)
    );
    edma_sync_toggle_detect i_sync_tog_frer_err[p_gem_num_cb_streams-1:0] (
      .clk      (pclk),
      .reset_n  (n_preset),
      .din      (frer_err_upd_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge (frer_err_upd_pulse)
    );
  end
  else
  begin : gen_no_cb
    assign frer_to_pulse      = {p_gem_num_cb_streams{1'b0}};
    assign frer_rogue_pulse   = {p_gem_num_cb_streams{1'b0}};
    assign frer_ooo_pulse     = {p_gem_num_cb_streams{1'b0}};
    assign frer_err_upd_pulse = {p_gem_num_cb_streams{1'b0}};
  end
  endgenerate

// Link Fault Signalling ..
  generate if (p_edma_has_pcs == 1) begin : gen_pcs
    gem_bus_sync #(
      .p_dwidth (32'd2),
      .p_reg_out(32'd2)
    ) i_bus_sync_link_fault (
      .src_clk      (rx_clk),
      .src_rst_n    (n_rxreset),
      .dest_clk     (pclk),
      .dest_rst_n   (n_preset),
      .src_data     (link_fault_status),
      .src_xfer_en  (1'b1),
      .src_data_last(),
      .src_rdy      (),
      .dest_data    (link_fault_status_pclk),
      .dest_val     ()
    );
  end else begin : gen_no_pcs
    assign link_fault_status_pclk = 2'b00;
  end
  endgenerate

  // Handle Packet Buffer specific synchronisation
  generate if (p_edma_tx_pkt_buffer == 1'b1) begin : gen_tx_pkt_buffer
    genvar g2;
    genvar g3;
    wire  [p_edma_tx_pbuf_addr-1:0] tx_dpram_fill_lvl_array[15:0];  // Array of TX debug entries
    wire  [3:0]                     tx_dpram_dbg_sel;               // Select array entry
    wire  [p_edma_tx_pbuf_addr-1:0] tx_dpram_fill_lvl;              // Selected fill level
    wire  [p_edma_tx_pbuf_addr-1:0] tx_dpram_fill_lvl_pclk;         // Selected fill level in pclk
    wire  [15:0]                    tx_dpram_fill_lvl_pad_pclk;     // Padded to 16-bits.
    wire  [p_edma_rx_pbuf_addr-1:0] rx_dpram_fill_lvl_pclk;         // RX fill level in pclk

    // Fill up array of TX fill level debug entries
    // For non-existent entries, just fill with Q0 value (pre-existing behavior).
    for (g2=0; g2<16; g2=g2+1) begin : loop_tx_dbg_arr
      if (g2 < p_edma_queues[31:0]) begin : gen_exists
        assign tx_dpram_fill_lvl_array[g2]  = tx_dpram_fill_lvl_dbg[((g2[31:0]+32'd1)*p_edma_tx_pbuf_addr)-32'd1:g2[31:0]*p_edma_tx_pbuf_addr];
      end else begin : gen_no_exists
        assign tx_dpram_fill_lvl_array[g2]  = tx_dpram_fill_lvl_dbg[p_edma_tx_pbuf_addr-1:0];
      end
    end
    assign tx_dpram_dbg_sel   = sel_dpram_fill_lvl_dbg[4:1];
    assign tx_dpram_fill_lvl  = ~tx_dpram_fill_lvl_array[tx_dpram_dbg_sel];

    // Synchronise to pclk
    gem_bus_sync #(
      .p_dwidth (p_edma_tx_pbuf_addr),
      .p_reg_out(1)
    ) i_sync_tx_dpram_fill_lvl_pclk (
      .src_clk      (hclk),
      .src_rst_n    (n_hreset),
      .dest_clk     (pclk),
      .dest_rst_n   (n_preset),
      .src_data     (tx_dpram_fill_lvl),
      .src_xfer_en  (1'b1),
      .src_data_last(),
      .src_rdy      (),
      .dest_data    (tx_dpram_fill_lvl_pclk),
      .dest_val     ()
    );

    // Now pad to 16-bits if necessary
    if (p_edma_tx_pbuf_addr < 32'd16) begin : gen_pad_tx_fill
      assign tx_dpram_fill_lvl_pad_pclk = {{(16-p_edma_tx_pbuf_addr){1'b0}},tx_dpram_fill_lvl_pclk};
    end else begin : gen_no_pad_tx_fill
      assign tx_dpram_fill_lvl_pad_pclk = tx_dpram_fill_lvl_pclk[15:0];
    end

    // Similarly synchronise the RX fill level. There is only single fill level which is common to
    // all queues.
    gem_bus_sync #(
      .p_dwidth (p_edma_rx_pbuf_addr),
      .p_reg_out(1)
    ) i_sync_rx_dpram_fill_lvl_pclk (
      .src_clk      (rx_clk),
      .src_rst_n    (n_rxreset),
      .dest_clk     (pclk),
      .dest_rst_n   (n_preset),
      .src_data     (rx_dpram_fill_lvl_dbg),
      .src_xfer_en  (1'b1),
      .src_data_last(),
      .src_rdy      (),
      .dest_data    (rx_dpram_fill_lvl_pclk),
      .dest_val     ()
    );

    // Now pad to 16-bits if necessary
    if (p_edma_rx_pbuf_addr < 32'd16) begin : gen_pad_rx_fill
      assign rx_dpram_fill_lvl_pad_pclk = {{(16-p_edma_rx_pbuf_addr){1'b0}},rx_dpram_fill_lvl_pclk};
    end else begin : gen_no_pad_rx_fill
      assign rx_dpram_fill_lvl_pad_pclk = rx_dpram_fill_lvl_pclk[15:0];
    end

    // Select whether to show TX or RX fill level
    assign dpram_fill_lvl_pclk  = sel_dpram_fill_lvl_dbg[0] ? tx_dpram_fill_lvl_pad_pclk
                                                            : rx_dpram_fill_lvl_pad_pclk;


    //------------------------------------------------------------------------------
    // ASF - handle SRAM statistics and status clock synchronisation
    //------------------------------------------------------------------------------
    if (((p_edma_asf_dap_prot == 1'b1) || (p_edma_asf_ecc_sram == 1'b1)) &&
          (p_edma_tx_pkt_buffer == 1'b1)) begin : gen_pclk_syncs_sram_stats
      wire tx_rd_clk;
      wire tx_rd_rst_n;

      // Select clock to use for DMA TX read side stats.
      if (p_edma_spram == 1'b1) begin : gen_hclk_syncs_txspram_stats
        assign tx_rd_clk   = hclk;
        assign tx_rd_rst_n  = n_hreset;
      end else begin : gen_txclk_syncs_txspram_stats
        assign tx_rd_clk   = tx_clk;
        assign tx_rd_rst_n  = n_txreset;
      end

      // Gather statistics and transfer to pclk domain
      gem_pclk_syncs_sram_stats #(
        .p_tx_addr_width  (p_edma_tx_pbuf_addr),
        .p_rx_addr_width  (p_edma_rx_pbuf_addr),
        .p_corr_stats     (p_edma_asf_ecc_sram)
      ) i_gem_pclk_syncs_sram_stats (
        .pclk                         (pclk),
        .n_preset                     (n_preset),
        .tx_rd_clk                    (tx_rd_clk),
        .tx_rd_rst_n                  (tx_rd_rst_n),
        .rx_rd_clk                    (hclk),
        .rx_rd_rst_n                  (n_hreset),
        .tx_corr_err                  (tx_corr_err),
        .tx_uncorr_err                (tx_uncorr_err),
        .tx_err_addr                  (tx_err_addr),
        .rx_corr_err                  (rx_corr_err),
        .rx_uncorr_err                (rx_uncorr_err),
        .rx_err_addr                  (rx_err_addr),
        .asf_sram_corr_fault          (asf_sram_corr_fault),
        .asf_sram_corr_fault_stats_upd(asf_sram_corr_fault_stats_upd),
        .asf_sram_corr_fault_status   (asf_sram_corr_fault_status),
        .asf_sram_uncorr_fault        (asf_sram_uncorr_fault),
        .asf_sram_uncorr_fault_status (asf_sram_uncorr_fault_status)
      );
    end else begin : gen_no_pclk_syncs_sram_stats
      assign asf_sram_corr_fault           = 1'b0;
      assign asf_sram_corr_fault_stats_upd = 8'h00;
      assign asf_sram_corr_fault_status    = 32'h00000000;
      assign asf_sram_uncorr_fault         = 1'b0;
      assign asf_sram_uncorr_fault_status  = 32'h00000000;
    end // gen_no_pclk_syncs_sram_stats

    //------------------------------------------------------------------------------
    // ASF - End to end data path parity protection
    //------------------------------------------------------------------------------
    if (p_edma_asf_dap_prot == 1'b1) begin : gen_tx_dp_parity
      // Synchronise DMA datapath parity errors to pclk domain
      gem_pulse_tsync i_psync_asf_dap_dma_err (
        .src_clk    (hclk),
        .src_rst_n  (n_hreset),
        .dest_clk   (pclk),
        .dest_rst_n (n_preset),
        .src_in     (asf_dap_dma_err),
        .dest_pulse (asf_dap_dma_err_pclk)
      );
    end else begin : gen_no_tx_dp_parity
      assign asf_dap_dma_err_pclk = 1'b0;
    end
  end else begin : no_gen_tx_pkt_buffer
    assign dpram_fill_lvl_pclk            = 16'h0000;
    assign rx_dpram_fill_lvl_pad_pclk     = 16'h0000;
    assign asf_dap_dma_err_pclk           = 1'b0;
    assign asf_sram_corr_fault            = 1'b0;
    assign asf_sram_corr_fault_stats_upd  = 8'h00;
    assign asf_sram_corr_fault_status     = 32'h00000000;
    assign asf_sram_uncorr_fault          = 1'b0;
    assign asf_sram_uncorr_fault_status   = 32'h00000000;
  end
  endgenerate

   //-----------------------------------------
   //----- synchronise rsc_clr_tog    ------
   //-----------------------------------------
  genvar g;
  generate if (p_edma_rsc == 1'b1) begin: gen_rsc_clr_sync
    for (g=0; g<p_edma_queues[31:0]; g=g+1) begin : gen_rsc_clr_for
      edma_sync_toggle_detect i_edma_sync_toggle_detect_rsc_clr_tog (
        .clk      (pclk),
        .reset_n  (n_preset),
        .din      (rsc_clr_tog[g]),
        .rise_edge(),
        .fall_edge(),
        .any_edge (rsc_clr_sync[g])
      );
    end
  end else begin : gen_no_edma_rsc
    for (g=0; g<p_edma_queues[31:0]; g=g+1) begin : gen_rsc_clr_for
      assign rsc_clr_sync[g] = 1'b0;
    end
  end
  endgenerate


  //------------------------------------------------------------------------------
  // ASF - End to end data path parity protection
  //------------------------------------------------------------------------------
  generate if (p_edma_asf_dap_prot == 1'b1) begin : gen_dp_parity

      gem_pulse_tsync i_psync_asf_dap_rxclk_err (
        .src_clk    (rx_clk),
        .src_rst_n  (n_rxreset),
        .dest_clk   (pclk),
        .dest_rst_n (n_preset),
        .src_in     (asf_dap_rxclk_err),
        .dest_pulse (asf_dap_rxclk_err_pclk)
      );
      gem_pulse_tsync i_psync_asf_dap_txclk_err (
        .src_clk    (tx_clk),
        .src_rst_n  (n_txreset),
        .dest_clk   (pclk),
        .dest_rst_n (n_preset),
        .src_in     (asf_dap_txclk_err),
        .dest_pulse (asf_dap_txclk_err_pclk)
      );
    end else begin : gen_no_dp_parity
       assign asf_dap_rxclk_err_pclk  = 1'b0;
       assign asf_dap_txclk_err_pclk  = 1'b0;
     end
  endgenerate

  //------------------------------------------------------------------------------
  // ASF TSU protection error synchronisation
  //------------------------------------------------------------------------------
  generate if (p_edma_asf_prot_tsu == 1'b1 && p_edma_tsu == 1'b1) begin : gen_asf_protect_tsu
    if (p_edma_tsu_clk == 1) begin : gen_tsu_clk
      gem_pulse_tsync i_psync_asf_integrity_tsu_err (
        .src_clk    (tsu_clk),
        .src_rst_n  (n_tsureset),
        .dest_clk   (pclk),
        .dest_rst_n (n_preset),
        .src_in     (asf_integrity_tsu_err),
        .dest_pulse (asf_integrity_tsu_err_pclk)
      );
    end else begin : gen_pclk
      assign asf_integrity_tsu_err_pclk = asf_integrity_tsu_err;
    end
  end else begin : gen_no_asf_protect_tsu
    assign asf_integrity_tsu_err_pclk  = 1'b0;
  end
  endgenerate

  // ASF host parity protection for AXI
  generate if ((p_edma_asf_host_par == 1) && (p_edma_axi==1)) begin : gen_asf_rdata_err
    gem_pulse_tsync i_psync_asf_dap_rdata_err (
      .src_clk    (hclk),
      .src_rst_n  (n_hreset),
      .dest_clk   (pclk),
      .dest_rst_n (n_preset),
      .src_in     (asf_dap_rdata_err),
      .dest_pulse (asf_dap_rdata_err_pclk)
    );
  end else begin : gen_no_asf_rdata_err
    assign asf_dap_rdata_err_pclk = 1'b0;
  end
  endgenerate

  //------------------------------------------------------------------------------
  // ASF transaction timeout error synchronisation
  //------------------------------------------------------------------------------
  generate if (p_edma_asf_trans_to_prot == 1'b1 && p_edma_ext_fifo_interface == 1'b0) begin : gen_asf_trans_to
    gem_pulse_tsync i_psync_asf_host_trans_to_err (
      .src_clk    (hclk),
      .src_rst_n  (n_hreset),
      .dest_clk   (pclk),
      .dest_rst_n (n_preset),
      .src_in     (asf_host_trans_to_err),
      .dest_pulse (asf_host_trans_to_err_pclk)
    );
    end else begin : gen_no_asf_trans_to
       assign asf_host_trans_to_err_pclk  = 1'b0;
    end
  endgenerate

  //------------------------------------------------------------------------------
  // ASF Integrity Protection Synchronisation
  //------------------------------------------------------------------------------
  generate if ((p_edma_asf_integrity_prot == 1'b1) && (p_edma_tx_pkt_buffer == 1'b1)) begin : gen_asf_integrity
     gem_pulse_tsync i_psync_asf_integrity_dma_err (
      .src_clk    (hclk),
      .src_rst_n  (n_hreset),
      .dest_clk   (pclk),
      .dest_rst_n (n_preset),
      .src_in     (asf_integrity_dma_err),
      .dest_pulse (asf_integrity_dma_err_pclk)
    );
  end else begin : gen_no_asf_integrity
    assign asf_integrity_dma_err_pclk = 1'b0;
  end
  endgenerate

  //------------------------------------------------------------------------------
  // ASF Transmit Scheduling protection Synchronisation
  //------------------------------------------------------------------------------
  generate if (p_edma_asf_prot_tx_sched == 1'b1) begin : gen_asf_protect_tx_sched
     wire sched_clk;
     wire sched_rst_n;
     if (p_edma_spram == 1) begin : gen_hclk_syncs_tx_sched
       assign sched_clk   = hclk;
       assign sched_rst_n = n_hreset;
     end else begin : gen_txclk_syncs_tx_sched
       assign sched_clk   = tx_clk;
       assign sched_rst_n = n_txreset;
     end

     gem_pulse_tsync i_psync_asf_integrity_tx_sched_err (
      .src_clk    (sched_clk),
      .src_rst_n  (sched_rst_n),
      .dest_clk   (pclk),
      .dest_rst_n (n_preset),
      .src_in     (asf_integrity_tx_sched_err),
      .dest_pulse (asf_integrity_tx_sched_err_pclk)
    );
  end else begin : gen_no_asf_protect_tx_sched
    assign asf_integrity_tx_sched_err_pclk = 1'b0;
  end
  endgenerate

  //------------------------------------------------------------------------------
  // Per scr2 rate limiting signals synchronisation
  //------------------------------------------------------------------------------
  // We will generate a pulse everytime the excess rate limiting will toggle
  // This will be then registered in the registers
  generate if(p_num_type2_screeners>8'd0) begin: gen_excess_rate_pclk_sync
    genvar i;
    wire [p_num_type2_screeners-1:0] excess_rate_pclk;
    for(i=0; i<p_num_type2_screeners; i=i+1) begin: gen_loop
      edma_sync_toggle_detect i_gen_excess_rate_toggle_detect (
        .clk      (pclk),
        .reset_n  (n_preset),
        .din      (scr_excess_rate[i]),
        .rise_edge(),
        .fall_edge(),
        .any_edge (excess_rate_pclk[i])
      );
    end
    assign scr_excess_rate_pclk = {1'b0,excess_rate_pclk}; // the MSB is just always zero
  end
  else begin: no_gen_excess_rate_pclk_sync
    assign scr_excess_rate_pclk = 1'b0;
  end
  endgenerate

endmodule

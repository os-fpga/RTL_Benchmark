//------------------------------------------------------------------------------
// Copyright (c) 2002-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_hclk_syncs.v
//   Module Name:        edma_hclk_syncs
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
//   Description  :      Synchronises signals to hclk
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

// This blocks synchronises signals to hclk
module edma_hclk_syncs (
   // system signals
   hclk,
   n_hreset,

   // inputs from the tx clock domain
   dma_tx_end_tog,
   late_coll_occured,
   too_many_retries,
   underflow_frame,
   collision_occured,

   // inputs from the rx clock domain
   dma_rx_end_tog,
   rx_w_bad_frame,
   rx_w_frame_length,
   rx_w_vlan_tagged,
   rx_w_prty_tagged,
   rx_w_tci,
   rx_w_broadcast_frame,
   rx_w_mult_hash_match,
   rx_w_uni_hash_match,
   rx_w_ext_match1,
   rx_w_ext_match2,
   rx_w_ext_match3,
   rx_w_ext_match4,
   rx_w_add_match1,
   rx_w_add_match2,
   rx_w_add_match3,
   rx_w_add_match4,
   rx_w_type_match1,
   rx_w_type_match2,
   rx_w_type_match3,
   rx_w_type_match4,
   rx_w_checksumi_ok,
   rx_w_checksumt_ok,
   rx_w_checksumu_ok,
   rx_w_snap_frame,
   rx_w_crc_error,

   // Inputs from the pclk domain
   rx_dma_stat_capt_tog,
   tx_dma_stat_capt_tog,
   flush_rx_pkt_pclk,
   rx_buff_not_rdy_pclk,
   enable_receive,
   enable_transmit,
   new_receive_q_ptr,
   new_transmit_q_ptr,
   tx_start_pclk,
   tx_halt_pclk,

   // synchronised outputs to the hclk domain edma_dma_tx
   enable_tx_hclk,
   tx_stat_capt_pulse,
   new_tx_q_ptr_pulse,
   tx_start_hclk_pulse,
   tx_halt_hclk,
   tx_frame_end_pulse,
   too_many_retry_hclk,
   underflow_frame_hclk,
   late_coll_occ_hclk,
   coll_occurred_hclk,

   // synchronised outputs to the hclk domain edma_dma_rx
   flush_rx_pkt_hclk,
   rx_frame_end_pulse,
   rx_buff_not_rdy_clr,
   rx_w_bad_frame_hclk,
   rx_w_frm_lngth_hclk,
   rx_w_vlan_tag_hclk,
   rx_w_prty_tag_hclk,
   rx_w_tci_hclk,
   rx_w_broadcast_hclk,
   rx_w_mult_hash_hclk,
   rx_w_uni_hash_hclk,
   rx_w_ext_match1_hclk,
   rx_w_ext_match2_hclk,
   rx_w_ext_match3_hclk,
   rx_w_ext_match4_hclk,
   rx_w_add_match1_hclk,
   rx_w_add_match2_hclk,
   rx_w_add_match3_hclk,
   rx_w_add_match4_hclk,
   rx_w_type_mtch1_hclk,
   rx_w_type_mtch2_hclk,
   rx_w_type_mtch3_hclk,
   rx_w_type_mtch4_hclk,
   rx_w_cksumi_ok_hclk,
   rx_w_cksumt_ok_hclk,
   rx_w_cksumu_ok_hclk,
   rx_w_snap_frame_hclk,
   rx_w_crc_error_hclk,
   new_rx_q_ptr_pulse,
   enable_rx_hclk,
   rx_stat_capt_pulse
   );

  parameter p_edma_rx_pkt_buffer = 1'b0;
  parameter p_edma_tx_pkt_buffer = 1'b0;

   // system signals
   input         n_hreset;             // Amba reset
   input         hclk;                 // AHB clock

   // Inputs from the pclk domain
   input         rx_dma_stat_capt_tog; // toggle when pclk domain registerred
                                       // rx_dma status signals
   input         tx_dma_stat_capt_tog; // toggle when pclk domain registerred
                                       // tx_dma status signals
   input         rx_buff_not_rdy_pclk; // pclk pulse corresp to posedge of
                                       // rx_buff_not_rdy_dma flag
   input         enable_receive;       // enable receive signal from network
                                       // control register
   input         enable_transmit;      // transmit enable signal from network
                                       // control register
   input         new_receive_q_ptr;    // asserted when receive queue pointer
                                       // is written to
   input         new_transmit_q_ptr;   // asserted when tx queue pointer
                                       // is written to
   input         tx_start_pclk;        // asserted when bit 9 of network
                                       // control register is written
   input         tx_halt_pclk;         // asserted when bit 10 of network
                                       // control register is written

   // Inputs from the tx_clk domain
   input          flush_rx_pkt_pclk;
   input         dma_tx_end_tog;       // Edge detected tx end of frame
                                       // signal, used to register tx status
   input         late_coll_occured;    // set if late collision occurs in
                                       // gigabit mode (flushes tx fifo),
                                       // cleared when dma_tx_status_tog
                                       // is returned.
   input         too_many_retries;     // signals too many retries error
                                       // condition (flushes tx fifo),
                                       // cleared when dma_tx_status_tog
                                       // is returned.
   input         underflow_frame;      // asserted high at the end of frame
                                       // to indicate a fifo underrun or
                                       // tx_r_err condition, cleared when
                                       // dma_tx_status_tog is returned.
   input         collision_occured;    // collision detected in tx_clk domain

   // Inputs from the rx_clk domain
   input         dma_rx_end_tog;       // Edge detected rx end of frame
                                       // signal, used to register rx status
   input         rx_w_bad_frame;       // end of bad receive frame.
   input  [13:0] rx_w_frame_length;    // records frame length for status
                                       // reporting.
   input         rx_w_vlan_tagged;     // used for reporting vlan tag.
   input         rx_w_prty_tagged;     // used for reporting priority tag.
   input   [3:0] rx_w_tci;             // used for reporting vlan priority.
   input         rx_w_broadcast_frame; // broadcast frame signal from the
                                       // address checker - rx status
                                       // reporting.
   input         rx_w_mult_hash_match; // multicast hash matched frame signal
                                       // for rx status reporting.
   input         rx_w_uni_hash_match;  // unicast hash matched frame signal
                                       // for rx status reporting.
   input         rx_w_ext_match1;      // external matched frame signal
                                       // for rx status reporting.
   input         rx_w_ext_match2;      // external matched frame signal
                                       // for rx status reporting.
   input         rx_w_ext_match3;      // external matched frame signal
                                       // for rx status reporting.
   input         rx_w_ext_match4;      // external matched frame signal
                                       // for rx status reporting.
   input         rx_w_add_match1;      // specific address register 1 matched
                                       // destination address.
   input         rx_w_add_match2;      // specific address register 2 matched
                                       // destination address.
   input         rx_w_add_match3;      // specific address register 3 matched
                                       // destination address.
   input         rx_w_add_match4;      // specific address register 4 matched
                                       // destination address.
   input         rx_w_type_match1;     // specific type register 1 matched
                                       // type field.
   input         rx_w_type_match2;     // specific type register 2 matched
                                       // type field.
   input         rx_w_type_match3;     // specific type register 3 matched
                                       // type field.
   input         rx_w_type_match4;     // specific type register 4 matched
                                       // type field.
   input         rx_w_checksumi_ok;    // IP checksum checked and was OK.
   input         rx_w_checksumt_ok;    // TCP checksum checked and was OK.
   input         rx_w_checksumu_ok;    // UDP checksum checked and was OK.
   input         rx_w_snap_frame;      // Frame was SNAP encapsulated and
                                       // had no VLAN or VLAN with no CFI.
   input         rx_w_crc_error;       // Frame had bad FCS

   // synchronised outputs to the hclk domain for edma_dma_tx
   output        enable_tx_hclk;       // transmit enable from control
                                       // register synced to hclk
   output        new_tx_q_ptr_pulse;   // asserted when tx queue pointer
                                       // register is written to
   output        tx_start_hclk_pulse;  // asserted when bit 9 of network
                                       // control register is written
   output        tx_halt_hclk;         // asserted when bit 10 of network
                                       // control register is written
   output        tx_stat_capt_pulse;   // hclk pulse indicating tx dma
                                       // status is captured
   output        tx_frame_end_pulse;   // signal end of frame to edma_dma_tx
   output        too_many_retry_hclk;  // too_many_retries from edma_tx.
   output        underflow_frame_hclk; // underflow_frame from edma_tx.
   output        late_coll_occ_hclk;   // late_coll_occured from edma_tx.
   output        coll_occurred_hclk;   // collision detected in hclk domain

   // synchronised outputs to the hclk domain for edma_dma_rx
   output        enable_rx_hclk;       // receive enable from control
                                       // register synced to hclk
   output        rx_stat_capt_pulse;   // hclk pulse indicating rx dma
                                       // status is captured
   output        new_rx_q_ptr_pulse;   // asserted when receive queue pointer
                                       // register is written to
   output        flush_rx_pkt_hclk;

   output        rx_buff_not_rdy_clr;  // pulse to clear corresp flag
   output        rx_frame_end_pulse;   // signal end of frame to edma_dma_rx
   output        rx_w_bad_frame_hclk;  // hclk version of rx_w_bad_frame
   output [13:0] rx_w_frm_lngth_hclk;  // hclk version of rx_w_frame_length
   output        rx_w_vlan_tag_hclk;   // hclk version of rx_w_vlan_tagged
   output        rx_w_prty_tag_hclk;   // hclk version of rx_w_prty_tagged
   output  [3:0] rx_w_tci_hclk;        // hclk version of rx_w_tci
   output        rx_w_broadcast_hclk;  // hclk version of rx_w_broadcast_frame
   output        rx_w_mult_hash_hclk;  // hclk version of rx_w_mult_hash_match
   output        rx_w_uni_hash_hclk;   // hclk version of rx_w_uni_hash_match
   output        rx_w_ext_match1_hclk; // hclk version of rx_w_ext_match1
   output        rx_w_ext_match2_hclk; // hclk version of rx_w_ext_match2
   output        rx_w_ext_match3_hclk; // hclk version of rx_w_ext_match3
   output        rx_w_ext_match4_hclk; // hclk version of rx_w_ext_match4
   output        rx_w_add_match1_hclk; // hclk version of rx_w_add_match1
   output        rx_w_add_match2_hclk; // hclk version of rx_w_add_match2
   output        rx_w_add_match3_hclk; // hclk version of rx_w_add_match3
   output        rx_w_add_match4_hclk; // hclk version of rx_w_add_match4
   output        rx_w_type_mtch1_hclk; // hclk version of rx_w_type_match1
   output        rx_w_type_mtch2_hclk; // hclk version of rx_w_type_match2
   output        rx_w_type_mtch3_hclk; // hclk version of rx_w_type_match3
   output        rx_w_type_mtch4_hclk; // hclk version of rx_w_type_match4
   output        rx_w_cksumi_ok_hclk;  // hclk version of rx_w_checksumi_ok
   output        rx_w_cksumt_ok_hclk;  // hclk version of rx_w_checksumt_ok
   output        rx_w_cksumu_ok_hclk;  // hclk version of rx_w_checksumu_ok
   output        rx_w_snap_frame_hclk; // hclk version of rx_w_snap_frame
   output        rx_w_crc_error_hclk;  // hclk version of rx_w_crc_error


   // Internal signals
   wire          enable_rx_hclk;       // Second stage of metastab. protect
   wire          enable_tx_hclk;       // Second stage of metastab. protect
   wire          new_rx_q_ptr_pulse;   // Edge detection output
   wire          new_tx_q_ptr_pulse;   // Edge detection output
   wire          tx_start_hclk_pulse;  // Edge detection output
   wire          tx_halt_hclk;         // Second stage of metastab. protect

//------------------------------------------------------------------------------
// REGISTERS (PCLK) to HCLK synchronisation
//------------------------------------------------------------------------------

  generate if (p_edma_rx_pkt_buffer == 0) begin : gen_pkt_buff_resync_rx
    reg           rx_bad_frame_sync1;   // hclk version of rx_w_bad_frame
    reg    [13:0] rx_frm_lngth_sync1;   // hclk version of rx_w_frame_length
    reg           rx_vlan_tag_sync1;    // hclk version of rx_w_vlan_tagged
    reg           rx_prty_tag_sync1;    // hclk version of rx_w_prty_tagged
    reg     [3:0] rx_tci_sync1;         // hclk version of rx_w_tci
    reg           rx_broadcast_sync1;   // hclk version of rx_w_broadcast_frame
    reg           rx_mult_hash_sync1;   // hclk version of rx_w_mult_hash_match
    reg           rx_uni_hash_sync1;    // hclk version of rx_w_uni_hash_match
    reg           rx_ext_match1_sync1;  // hclk version of rx_w_ext_match1
    reg           rx_ext_match2_sync1;  // hclk version of rx_w_ext_match2
    reg           rx_ext_match3_sync1;  // hclk version of rx_w_ext_match3
    reg           rx_ext_match4_sync1;  // hclk version of rx_w_ext_match4
    reg           rx_add_match1_sync1;  // hclk version of rx_w_add_match1
    reg           rx_add_match2_sync1;  // hclk version of rx_w_add_match2
    reg           rx_add_match3_sync1;  // hclk version of rx_w_add_match3
    reg           rx_add_match4_sync1;  // hclk version of rx_w_add_match4
    reg           rx_type_mtch1_sync1;  // hclk version of rx_w_type_match1
    reg           rx_type_mtch2_sync1;  // hclk version of rx_w_type_match2
    reg           rx_type_mtch3_sync1;  // hclk version of rx_w_type_match3
    reg           rx_type_mtch4_sync1;  // hclk version of rx_w_type_match4
    reg           rx_w_cksumi_ok_sync1; // hclk version of rx_w_checksumi_ok
    reg           rx_w_cksumt_ok_sync1; // hclk version of rx_w_checksumt_ok
    reg           rx_w_cksumu_ok_sync1; // hclk version of rx_w_checksumu_ok
    reg           rx_w_snap_frm_sync1;  // hclk version of rx_w_snap_frame
    reg           rx_w_crc_error_sync1; // hclk version of rx_w_crc_error

    // synchronize rx_buff_not_rdy_pclk pulse in hclk domain and
    // generate an hclk pulse corresp to the posedge of the pclk pulse
    edma_sync_toggle_detect i_edma_sync_toggle_detect_rx_buff_not_rdy_pclk (
      .clk      (hclk),
      .reset_n  (n_hreset),
      .din      (rx_buff_not_rdy_pclk),
      .rise_edge(rx_buff_not_rdy_clr),
      .fall_edge(),
      .any_edge ());

    // synchronise dma_rx_end_tog from rx block to hclk
    // used to signal dma that it should cause the appropriate write back
    // of descriptor
    edma_sync_toggle_detect i_edma_sync_toggle_detect_dma_rx_end_tog (
      .clk      (hclk),
      .reset_n  (n_hreset),
      .din      (dma_rx_end_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge (rx_frame_end_pulse));

   // Sync rx_clk domain signals to hclk
   // These signals will be stable long before they are used.
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
      begin
         rx_bad_frame_sync1   <= 1'b0;
         rx_frm_lngth_sync1   <= 14'd0;
         rx_vlan_tag_sync1    <= 1'b0;
         rx_prty_tag_sync1    <= 1'b0;
         rx_tci_sync1         <= 4'h0;
         rx_broadcast_sync1   <= 1'b0;
         rx_mult_hash_sync1   <= 1'b0;
         rx_uni_hash_sync1    <= 1'b0;
         rx_ext_match1_sync1  <= 1'b0;
         rx_ext_match2_sync1  <= 1'b0;
         rx_ext_match3_sync1  <= 1'b0;
         rx_ext_match4_sync1  <= 1'b0;
         rx_add_match1_sync1  <= 1'b0;
         rx_add_match2_sync1  <= 1'b0;
         rx_add_match3_sync1  <= 1'b0;
         rx_add_match4_sync1  <= 1'b0;
         rx_type_mtch1_sync1  <= 1'b0;
         rx_type_mtch2_sync1  <= 1'b0;
         rx_type_mtch3_sync1  <= 1'b0;
         rx_type_mtch4_sync1  <= 1'b0;
         rx_w_cksumi_ok_sync1 <= 1'b0;
         rx_w_cksumt_ok_sync1 <= 1'b0;
         rx_w_cksumu_ok_sync1 <= 1'b0;
         rx_w_snap_frm_sync1  <= 1'b0;
         rx_w_crc_error_sync1 <= 1'b0;
      end
      else
      begin
         rx_bad_frame_sync1   <= rx_w_bad_frame;
         rx_frm_lngth_sync1   <= rx_w_frame_length;
         rx_vlan_tag_sync1    <= rx_w_vlan_tagged;
         rx_prty_tag_sync1    <= rx_w_prty_tagged;
         rx_tci_sync1         <= rx_w_tci;
         rx_broadcast_sync1   <= rx_w_broadcast_frame;
         rx_mult_hash_sync1   <= rx_w_mult_hash_match;
         rx_uni_hash_sync1    <= rx_w_uni_hash_match;
         rx_ext_match1_sync1  <= rx_w_ext_match1;
         rx_ext_match2_sync1  <= rx_w_ext_match2;
         rx_ext_match3_sync1  <= rx_w_ext_match3;
         rx_ext_match4_sync1  <= rx_w_ext_match4;
         rx_add_match1_sync1  <= rx_w_add_match1;
         rx_add_match2_sync1  <= rx_w_add_match2;
         rx_add_match3_sync1  <= rx_w_add_match3;
         rx_add_match4_sync1  <= rx_w_add_match4;
         rx_type_mtch1_sync1  <= rx_w_type_match1;
         rx_type_mtch2_sync1  <= rx_w_type_match2;
         rx_type_mtch3_sync1  <= rx_w_type_match3;
         rx_type_mtch4_sync1  <= rx_w_type_match4;
         rx_w_cksumi_ok_sync1 <= rx_w_checksumi_ok;
         rx_w_cksumt_ok_sync1 <= rx_w_checksumt_ok;
         rx_w_cksumu_ok_sync1 <= rx_w_checksumu_ok;
         rx_w_snap_frm_sync1  <= rx_w_snap_frame;
         rx_w_crc_error_sync1 <= rx_w_crc_error;
      end

    // From outputs to edma_dma_rx
    assign rx_w_bad_frame_hclk  = rx_bad_frame_sync1;
    assign rx_w_frm_lngth_hclk  = rx_frm_lngth_sync1;
    assign rx_w_vlan_tag_hclk   = rx_vlan_tag_sync1;
    assign rx_w_prty_tag_hclk   = rx_prty_tag_sync1;
    assign rx_w_tci_hclk        = rx_tci_sync1;
    assign rx_w_broadcast_hclk  = rx_broadcast_sync1;
    assign rx_w_mult_hash_hclk  = rx_mult_hash_sync1;
    assign rx_w_uni_hash_hclk   = rx_uni_hash_sync1;
    assign rx_w_ext_match1_hclk = rx_ext_match1_sync1;
    assign rx_w_ext_match2_hclk = rx_ext_match2_sync1;
    assign rx_w_ext_match3_hclk = rx_ext_match3_sync1;
    assign rx_w_ext_match4_hclk = rx_ext_match4_sync1;
    assign rx_w_add_match1_hclk = rx_add_match1_sync1;
    assign rx_w_add_match2_hclk = rx_add_match2_sync1;
    assign rx_w_add_match3_hclk = rx_add_match3_sync1;
    assign rx_w_add_match4_hclk = rx_add_match4_sync1;
    assign rx_w_type_mtch1_hclk = rx_type_mtch1_sync1;
    assign rx_w_type_mtch2_hclk = rx_type_mtch2_sync1;
    assign rx_w_type_mtch3_hclk = rx_type_mtch3_sync1;
    assign rx_w_type_mtch4_hclk = rx_type_mtch4_sync1;
    assign rx_w_cksumi_ok_hclk  = rx_w_cksumi_ok_sync1;
    assign rx_w_cksumt_ok_hclk  = rx_w_cksumt_ok_sync1;
    assign rx_w_cksumu_ok_hclk  = rx_w_cksumu_ok_sync1;
    assign rx_w_snap_frame_hclk = rx_w_snap_frm_sync1;
    assign rx_w_crc_error_hclk  = rx_w_crc_error_sync1;
    assign flush_rx_pkt_hclk    = 1'b0;

  end else begin : gen_no_resync_rx

    edma_sync_toggle_detect i_edma_sync_toggle_detect_flush_rx_pkt_pclk (
      .clk(hclk),
      .reset_n(n_hreset),
      .din(flush_rx_pkt_pclk),
      .rise_edge(),
      .fall_edge(),
      .any_edge(flush_rx_pkt_hclk));

    assign rx_frame_end_pulse   = 1'b0;
    assign rx_buff_not_rdy_clr  = 1'b0;
    assign rx_w_bad_frame_hclk  = 1'b0;
    assign rx_w_frm_lngth_hclk  = 14'd0;
    assign rx_w_vlan_tag_hclk   = 1'b0;
    assign rx_w_prty_tag_hclk   = 1'b0;
    assign rx_w_tci_hclk        = 4'h0;
    assign rx_w_broadcast_hclk  = 1'b0;
    assign rx_w_mult_hash_hclk  = 1'b0;
    assign rx_w_uni_hash_hclk   = 1'b0;
    assign rx_w_ext_match1_hclk = 1'b0;
    assign rx_w_ext_match2_hclk = 1'b0;
    assign rx_w_ext_match3_hclk = 1'b0;
    assign rx_w_ext_match4_hclk = 1'b0;
    assign rx_w_add_match1_hclk = 1'b0;
    assign rx_w_add_match2_hclk = 1'b0;
    assign rx_w_add_match3_hclk = 1'b0;
    assign rx_w_add_match4_hclk = 1'b0;
    assign rx_w_type_mtch1_hclk = 1'b0;
    assign rx_w_type_mtch2_hclk = 1'b0;
    assign rx_w_type_mtch3_hclk = 1'b0;
    assign rx_w_type_mtch4_hclk = 1'b0;
    assign rx_w_cksumi_ok_hclk  = 1'b0;
    assign rx_w_cksumt_ok_hclk  = 1'b0;
    assign rx_w_cksumu_ok_hclk  = 1'b0;
    assign rx_w_snap_frame_hclk = 1'b0;
    assign rx_w_crc_error_hclk  = 1'b0;
  end
  endgenerate

  generate if (p_edma_tx_pkt_buffer == 0) begin : gen_pkt_buff_resync_tx
    reg           too_many_retry_sync1; // too_many_retries from edma_tx.
    reg           underflow_frm_sync1;  // underflow_frame from edma_tx.
    reg           late_coll_occ_sync1;  // late_coll_occured from edma_tx.
    reg           too_many_retry_int;   // too_many_retries from edma_tx.
    reg           underflow_frm_int;    // underflow_frame from edma_tx.
    reg           late_coll_occ_int;    // late_coll_occured from edma_tx.
    // synchronise dma_tx_end_tog from tx block to hclk
    // used to signal dma that it should cause the appropriate write back
    // of descriptor
    edma_sync_toggle_detect i_edma_sync_toggle_detect_dma_tx_end_tog (
       .clk(hclk),
       .reset_n(n_hreset),
       .din(dma_tx_end_tog),
       .rise_edge(),
       .fall_edge(),
       .any_edge(tx_frame_end_pulse));

    // too_many_retries_sync1, underflow_frame_sync1 & late_coll_occ_sync1
    // Initial sync to remove any chance of glitches on sample logic
    always@(posedge hclk or negedge n_hreset)
       if (~n_hreset)
          begin
             too_many_retry_sync1 <= 1'b0;
             underflow_frm_sync1  <= 1'b0;
             late_coll_occ_sync1  <= 1'b0;
          end
       else
          begin
             too_many_retry_sync1 <= too_many_retries;
             underflow_frm_sync1  <= underflow_frame;
             late_coll_occ_sync1  <= late_coll_occured;
          end

    // too_many_retries_int, underflow_frame_int & late_coll_occ_int
    // This group of signals are used to sample and hold the status from
    // the edma_tx that is passed across with the tx_frame_end_pulse handshaking
    // mechanism.
    always@(posedge hclk or negedge n_hreset)
       if (~n_hreset)
          begin
             too_many_retry_int <= 1'b0;
             underflow_frm_int  <= 1'b0;
             late_coll_occ_int  <= 1'b0;
          end

       // take new value when indicated stable
       else if (tx_frame_end_pulse)
          begin
             too_many_retry_int <= too_many_retry_sync1;
             underflow_frm_int  <= underflow_frm_sync1;
             late_coll_occ_int  <= late_coll_occ_sync1;
          end

       // zero values once pclk update has completed
       else if (tx_stat_capt_pulse)
          begin
             too_many_retry_int <=  1'b0;
             underflow_frm_int  <=  1'b0;
             late_coll_occ_int  <=  1'b0;
          end

       // Else maintain value
       else
          begin
             too_many_retry_int <= too_many_retry_int;
             underflow_frm_int  <= underflow_frm_int;
             late_coll_occ_int  <= late_coll_occ_int;
          end

    // assign outputs to edma_dma_tx
    assign too_many_retry_hclk  = too_many_retry_int;
    assign underflow_frame_hclk = underflow_frm_int;
    assign late_coll_occ_hclk   = late_coll_occ_int;

    // synchronise collision_occured from tx block to hclk
    // used to signal dma that it should cause the appropriate write back
    // of descriptor
    cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_collision_occured (
       .clk(hclk),
       .reset_n(n_hreset),
       .din(collision_occured),
       .dout(coll_occurred_hclk));

  end else begin : gen_no_resync_tx
    assign tx_frame_end_pulse     = 1'b0;
    assign too_many_retry_hclk    = 1'b0;
    assign underflow_frame_hclk   = 1'b0;
    assign late_coll_occ_hclk     = 1'b0;
    assign coll_occurred_hclk     = 1'b0;
  end
  endgenerate

   // synchronise enable_receive from register block to hclk
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_enable_receive (
      .clk(hclk),
      .reset_n(n_hreset),
      .din(enable_receive),
      .dout(enable_rx_hclk));

   // synchronise enable_transmit from registers block to hclk
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_enable_transmit (
      .clk(hclk),
      .reset_n(n_hreset),
      .din(enable_transmit),
      .dout(enable_tx_hclk));

   // synchronise new_rx_q_ptr from registers block to hclk
   edma_sync_toggle_detect i_edma_sync_toggle_detect_new_receive_q_ptr (
      .clk(hclk),
      .reset_n(n_hreset),
      .din(new_receive_q_ptr),
      .rise_edge(),
      .fall_edge(),
      .any_edge(new_rx_q_ptr_pulse));

   // synchronise rx_dma_stat_capt_tog input from pclk into hclk
   edma_sync_toggle_detect i_edma_sync_toggle_detect_rx_dma_stat_capt_tog (
      .clk(hclk),
      .reset_n(n_hreset),
      .din(rx_dma_stat_capt_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge(rx_stat_capt_pulse));

   // synchronise tx_dma_stat_capt_tog input from pclk into hclk
   edma_sync_toggle_detect i_edma_sync_toggle_detect_tx_dma_stat_capt_tog (
      .clk(hclk),
      .reset_n(n_hreset),
      .din(tx_dma_stat_capt_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge(tx_stat_capt_pulse));

   // synchronise new_transmit_q_ptr from registers block to hclk
   edma_sync_toggle_detect i_edma_sync_toggle_detect_new_transmit_q_ptr (
      .clk(hclk),
      .reset_n(n_hreset),
      .din(new_transmit_q_ptr),
      .rise_edge(),
      .fall_edge(),
      .any_edge(new_tx_q_ptr_pulse));


   // synchronise tx_start from registers block to hclk
   // Note that if enable and start are both set at the same time then
   // it is possible that the start will not be seen after the enable
   // which would result in start having no effect until it is triggered
   // again. This is not considered a real issue as usage guideline
   // should state that enable is set followed by start after a frame
   // has been queued.
   edma_sync_toggle_detect #(
      .NUM_FLOPS(2)
   ) i_edma_sync_toggle_detect_tx_start_pclk (
      .clk(hclk),
      .reset_n(n_hreset),
      .din(tx_start_pclk),
      .rise_edge(),
      .fall_edge(),
      .any_edge(tx_start_hclk_pulse));

   // synchronise tx_halt from registers block to hclk
   // used to signal dma that it should reset the tx_go variable
   edma_sync_toggle_detect i_edma_sync_toggle_detect_tx_halt_pclk (
      .clk(hclk),
      .reset_n(n_hreset),
      .din(tx_halt_pclk),
      .rise_edge(),
      .fall_edge(),
      .any_edge(tx_halt_hclk));

endmodule

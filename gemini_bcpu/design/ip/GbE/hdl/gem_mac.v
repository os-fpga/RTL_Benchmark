//------------------------------------------------------------------------------
// Copyright (c) 2002-2022 Cadence Design Systems, Inc.
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
//   Filename:           gem_mac.v
//   Module Name:        gem_mac
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
//   Description        :      Ethernet MAC block that combines both the
//                             transmit (gem_tx) and receive (gem_rx +
//                             gem_filter) datapaths.
//                             Also incorporated, is the loopback module,
//                             providing loopback at the gmii/mii interface.
//
//                             A raw fifo interface is provided for connection
//                             into the soc, which can be attached either
//                             to the AMBA AHB DMA module or to an interface
//                             as defined by the IP user.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_mac (

   // system signals.
   n_txreset,
   n_rxreset,

   // Loopback clock.
   n_ntxreset,
   n_tx_clk,
   tsu_clk,
   n_tsureset,
   pclk,
   n_preset,
   hclk,
   n_hreset,

   // match registers for priortiy queues
   screener_type1_regs,
   screener_type2_regs,
   scr2_ethtype_regs,
   scr2_compare_regs,

   // From 802.3br MMSL
   rx_br_halt,

   // gmii/mii signals.
   tx_clk,
   rx_clk,
   txd_gmii,
   txd_par_gmii,
   tx_en_gmii,
   tx_er_gmii,
   rxd_gmii,
   rxd_par_gmii,
   rx_er_gmii,
   rx_dv_gmii,
   col,
   crs,

   // dedicated PCS Interface.
   tx_er_pcs,
   txd_pcs,
   txd_par_pcs,
   tx_en_pcs,
   rxd_pcs,
   rxd_par_pcs,
   rx_er_pcs,
   rx_dv_pcs,
   col_pcs,
   crs_pcs,

   // top level ethernet signals.
   txd_frame_size,
   txd_rdy,
   tx_pause,
   tx_pause_zero,
   tx_pfc_sel,
   tx_pfc_pause,
   tx_pfc_pause_zero,
   wol,

   // external filter interface
   ext_match1,
   ext_match2,
   ext_match3,
   ext_match4,
   ext_da,
   ext_da_stb,
   ext_sa,
   ext_sa_stb,
   ext_type,
   ext_type_stb,
   ext_ip_sa,
   ext_ip_sa_stb,
   ext_ip_da,
   ext_ip_da_stb,
   ext_source_port,
   ext_sp_stb,
   ext_dest_port,
   ext_dp_stb,
   ext_ipv6,

   // Stacked VLAN tag support
   stacked_vlantype,
   ext_vlan_tag1,
   ext_vlan_tag1_stb,
   ext_vlan_tag2,
   ext_vlan_tag2_stb,

   // precision time protocol signals for IEEE 1588 support
   sof_tx,
   sync_frame_tx,
   delay_req_tx,
   pdelay_req_tx,
   pdelay_resp_tx,
   general_frame_tx,
   event_frame_tx,
   sof_rx,
   sync_frame_rx,
   delay_req_rx,
   pdelay_req_rx,
   pdelay_resp_rx,
   general_frame_rx,

   // signals coming from gem_reg_top (gem_registers).
   full_duplex,
   bit_rate,
   gigabit,
   tbi,
   two_pt_five_gig,
   tx_byte_mode,
   dma_bus_width,
   enable_transmit,
   enable_receive,
   jumbo_enable,
   pause_enable,
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
   tx_status_wr_tog,
   rx_status_wr_tog,
   rx_no_crc_check,
   tx_pause_tog_ack,
   rx_1536_en,
   strip_rx_fcs,
   rx_no_pause_frames,
   rx_toe_enable,
   pfc_enable,
   ptp_unicast_ena,
   rx_ptp_unicast,
   tx_ptp_unicast,
   rx_fill_level_low,
   rx_fill_level_high,
   check_rx_length,
   halfduplex_fc_en,
   back_pressure,
   loopback_local,
   en_half_duplex_rx,
   ext_match_en,
   uni_hash_en,
   multi_hash_en,
   no_broadcast,
   copy_all_frames,
   rm_non_vlan,
   hash,
   mask_add1,
   spec_add_filter_regs,
   spec_add_filter_active,
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
   wol_ip_addr,
   wol_mask,
   stretch_enable,
   stretch_ratio,
   min_ifg,
   rx_bad_preamble,
   ign_ipg_rx_er,
   store_udp_offset,
   store_rx_ts,
   tsu_ptp_tx_timer_out,
   tsu_ptp_rx_timer_out,
   tsu_ptp_tx_timer_par_out,
   tsu_ptp_rx_timer_par_out,
   one_step_sync_mode,
   oss_correction_field,
   tsu_timer_cnt,
   tsu_timer_cnt_par,
   idleslope_q_a,
   cbs_enable,
   cbs_q_a_id,
   cbs_q_b_id,
   idleslope_q_b,
   port_tx_rate,
   dwrr_ets_control,
   bw_rate_limit,

   // fifo signals coming from gem_dma_top (or external tx fifo interface).
   tx_r_data,
   tx_r_data_par,
   tx_r_mod,
   tx_r_sop,
   tx_r_eop,
   tx_r_err,
   tx_r_valid,
   tx_r_data_rdy,
   dma_is_busy,
   tx_r_flushed,
   tx_r_underflow,
   tx_r_control,
   tx_r_frame_size,
   tx_r_frame_size_vld,
   tx_r_launch_time,
   tx_r_launch_time_vld,

   // signals going to gem_dma_top (or external tx fifo interface).
   tx_r_rd,
   tx_r_rd_int,
   tx_r_queue,
   tx_r_queue_int,

   // fifo signals going to gem_dma_top (or external rx fifo interface).
   rx_w_wr,
   rx_w_data,
   rx_w_data_par,
   rx_w_mod,
   rx_w_sop,
   rx_w_eop,
   rx_w_err,
   rx_w_flush,
   rx_w_overflow,

   // status signals going to gem_dma_top (or external rx fifo interface).
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
   rx_w_add_match,
   rx_w_type_match1,
   rx_w_type_match2,
   rx_w_type_match3,
   rx_w_type_match4,
   rx_w_checksumi_ok,
   rx_w_checksumt_ok,
   rx_w_checksumu_ok,
   rx_w_snap_frame,
   rx_w_length_error,
   rx_w_crc_error,
   rx_w_too_short,
   rx_w_too_long,
   rx_w_code_error,
   rx_w_l4_offset,
   rx_w_pld_offset,
   rx_w_pld_offset_vld,

   // status signals going to gem_dma_top (or external tx fifo interface).
   late_coll_occured,
   too_many_retries,
   underflow_frame,
   collision_occured,

   tx_r_timestamp,
   rx_w_timestamp,
   tx_r_timestamp_par,
   rx_w_timestamp_par,

   // signals coming from gem_dma_top (or external tx fifo interface).
   dma_tx_status_tog,
   dma_rx_status_tog,

   // signals going to gem_dma_top (or ext tx fifo i/f)(via gem_hclk_syncs)
   dma_tx_end_tog,
   dma_rx_end_tog,

   // signals going to the gem_reg_top (gem_pclk_syncs) for
   // statistics register recording.
   tx_end_tog,
   rx_end_tog,
   tx_coll_occured,
   tx_frame_txed_ok,
   tx_broadcast_frame,
   tx_multicast_frame,
   tx_single_coll_frame,
   tx_multi_coll_frame,
   tx_deferred_tx_frame,
   tx_late_coll_frame,
   tx_crs_error_frame,
   tx_too_many_retries,
   tx_bytes_in_frame,
   tx_pause_frame_txed,
   tx_pfc_pause_frame_txed,
   tx_underflow_frame,
   tx_pause_time,
   tx_pause_time_tog,
   rx_broadcast_frame,
   rx_multicast_frame,
   rx_bytes_in_frame,
   lpi_indicate,

   rx_frame_rxed_ok,
   rx_align_error,
   rx_crc_error,
   rx_short_error,
   rx_long_error,
   rx_jabber_error,
   rx_symbol_error,
   rx_pause_frame,
   rx_pause_nonzero,
   rx_pfc_pause_frame,
   rx_pfc_pause_nonzero,
   rx_length_error,
   rx_ip_ck_error,
   rx_tcp_ck_error,
   rx_udp_ck_error,
   rx_overflow,

   queue_ptr_rx,
   pfc_negotiate,
   rx_pfc_paused,

   soft_config_fifo_en,

   // RSC Specific
   rsc_stop,
   rsc_push,
   tcp_seqnum,
   tcp_syn,
   tcp_payload_len,

   jumbo_max_length,
   ext_rxq_sel_en,

   // EnST signals
   enst_en,
   start_time,
   on_time,
   off_time,
   add_frag_size,
   hold,

  // ASF - signals going to gem_reg_top
   asf_dap_mac_rx_err,
   asf_dap_mac_tx_err,
   asf_integrity_tx_sched_err,

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

   tx_r_sop_lockup,
   tx_r_eop_lockup,
   tx_r_valid_lockup,

   // per type 2 screener rate limiting algorithm registers
   scr2_rate_lim,
   scr_excess_rate,

   // toggle to stats, indicating a frame flushed by mode2, 3, or 4
   frame_flushed_tog,

   // rx_q_flush signals ready to use by gem_rx_per_queue_flush module
   max_val_pclk,
   drop_all_frames_rx_clk,
   limit_frames_size_rx_clk,
   fill_lvl_breached,
   block_sram_ecc_check

);

   parameter [1363:0] grouped_params = {1364{1'b0}};
  `include "ungroup_params.v"

   // system signals.
   input         n_txreset;               // reset synchronized to tx_clk.
   input         n_rxreset;               // reset synchronized to rx_clk.

   // Loopback clock
   input         n_ntxreset;              // reset synchronized to n_tx_clk.
   input         n_tx_clk;                // inverted tx_clk for loopback
   input         tsu_clk;                 // TSU clock
   input         n_tsureset;              // TSU reset
   input         pclk;                    // APB clock
   input         n_preset;                // APB reset
   input         hclk;                    // AHB clock.
   input         n_hreset;                // AHB reset.

   input [(32*p_num_type1_screeners):0]   screener_type1_regs; //
   input [(32*p_num_type2_screeners):0]   screener_type2_regs; //
   input [(43*p_num_scr2_compare_regs):0] scr2_compare_regs;
   input [(16*p_num_scr2_ethtype_regs):0] scr2_ethtype_regs;

   // From 802.3br MMSL
   input         rx_br_halt;              // Halt mid-packet

   // gmii/mii signals.
   input         tx_clk;                  // 2.5MHz, 25MHz or 125MHz transmit
                                          // clock.
   input         rx_clk;                  // 2.5MHz, 25MHz or 125MHz receive
                                          // clock.
   output  [7:0] txd_gmii;                // transmit data to the PHY.
   output        txd_par_gmii;            // optional parity
   output        tx_en_gmii;              // transmit enable signal to the PHY.
   output        tx_er_gmii;              // transmit error signal to the PHY.
   input   [7:0] rxd_gmii;                // receive data from the PHY.
   input         rxd_par_gmii;            // Optional parity
   input         rx_er_gmii;              // receive error signal from the PHY.
   input         rx_dv_gmii;              // receive data valid signal from PHY.
   input         col;                     // collision detect signal from the
                                          // PHY.
   input         crs;                     // carrier sense signal from the PHY.

   // dedicated pcs interface.
   output        tx_er_pcs;               // transmit error signal to the PCS.
   output  [7:0] txd_pcs;                 // transmit data to the PCS.
   output        txd_par_pcs;
   output        tx_en_pcs;               // transmit enable signal to the PCS.
   input  [15:0] rxd_pcs;                 // receive data from the PCS.
   input   [1:0] rxd_par_pcs;             // Optional parity
   input   [1:0] rx_er_pcs;               // receive error signal from the PCS.
   input   [1:0] rx_dv_pcs;               // receive data valid signal from PCS.
   input         col_pcs;                 // collision detect signal from the
                                          // PCS.
   input         crs_pcs;                 // carrier sense signal from the PCS.

   // top level ethernet signals.
   output [13:0] txd_frame_size;          // Frame Length in Bytes
   input         txd_rdy;                 // TXD ready ..
   input         tx_pause;                // toggling this input causes a
                                          // pause frame to be transmitted with
                                          // the pause quantum value taken from
                                          // the transmit pause quantum
                                          // register.
   input         tx_pause_zero;           // toggling this input causes a pause
                                          // frame to be transmitted with zero
                                          // pause quantum.
   input         tx_pfc_sel;              // When set to 0, transmit 802.3
                                          // pause frame
                                          // When set to 1, transmit PFC
                                          // pause frame

   input   [7:0] tx_pfc_pause;            // priority enable vector of the
                                          // PFC pause frame
   input   [7:0] tx_pfc_pause_zero;       // When set to 1, PFC pause frame
                                          // has zero pause quantum
                                          // When set to 0, PFC pause frame
                                          // has the value of transmit pause
                                          // quantum register

   output        wol;                     // Wake-on-LAN output

   // external filter interface
   input         ext_match1;              // external match (frame to be copied)
   input         ext_match2;              // external match (frame to be copied)
   input         ext_match3;              // external match (frame to be copied)
   input         ext_match4;              // external match (frame to be copied)
   output [47:0] ext_da;                  // destination address from rx frame
   output        ext_da_stb;              // pulsed when dest. address valid
   output [47:0] ext_sa;                  // source address from the rx data
   output        ext_sa_stb;              // pulsed when source address valid
   output [15:0] ext_type;                // length/TypeID field from rx frame
   output        ext_type_stb;            // pulsed when length/TypeID valid
   output [127:0] ext_ip_sa;              // IP source address
   output        ext_ip_sa_stb;           // IP source address valid strobe
   output [127:0] ext_ip_da;              // IP destination address
   output        ext_ip_da_stb;           // IP destination address valid strobe
   output [15:0] ext_source_port;         // source port number
   output        ext_sp_stb;              // validates source port number
   output [15:0] ext_dest_port;           // destination port number
   output        ext_dp_stb;              // validates destination port number
   output        ext_ipv6;                // high for ipv6

   // Stacked VLAN tag support
   input  [16:0] stacked_vlantype;        // VLAN tag TPID (bit 16 enables
                                          // stacked VLAN tag support)
   output [31:0] ext_vlan_tag1;           // VLAN tag 1
   output        ext_vlan_tag1_stb;       // VLAN tag 1 strobe
   output [31:0] ext_vlan_tag2;           // VLAN tag 2
   output        ext_vlan_tag2_stb;       // VLAN tag 2 strobe

   // precision time protocol signals for IEEE 1588 support
   output        sof_tx;                  // asserted on SFD deasserted at EOF
   output        sync_frame_tx;           // asserted if PTP sync frame
   output        delay_req_tx;            // asserted if PTP delay_req
   output        pdelay_req_tx;           // asserted if PTP pdelay_req
   output        pdelay_resp_tx;          // asserted if PTP pdelay_resp
   output        general_frame_tx;        // asserted if PTP general frame
   output        event_frame_tx;          // asserted if PTP event frame

   output        sof_rx;                  // asserted on SFD deasserted at EOF
   output        sync_frame_rx;           // asserted if PTP sync frame
   output        delay_req_rx;            // asserted if PTP delay_req
   output        pdelay_req_rx;           // asserted if PTP pdelay_req
   output        pdelay_resp_rx;          // asserted if PTP pdelay_resp
   output        general_frame_rx;        // asserted if PTP general frame

   // signals coming from gem_reg_top (gem_registers).
   input         ptp_unicast_ena;         // enable PTPv2 IPv4 unicast IP DA
                                          // detection
   input  [31:0] rx_ptp_unicast;          // rx PTPv2 IPv4 unicast IP DA
   input  [31:0] tx_ptp_unicast;          // tx PTPv2 IPv4 unicast IP DA
   input         rx_fill_level_low;       // watermark for transmitting zero pause frame
   input         rx_fill_level_high;      // watermark for transmitting non-zero pause frame
   input         full_duplex;             // duplex signal from the network
                                          // configuration register.
   input         bit_rate;                // 10/100 operation
   input         gigabit;                 // high for gigabit operation.
   input         tbi;                     // high for PCS i/f, low for GMII.
   input         two_pt_five_gig;         // high for 2.5Gbps operation
   input         tx_byte_mode;            // gem_tx transmits bytes not nibbles
   input   [1:0] dma_bus_width;           // DMA bus width...
                                          //   00 : 32-bit
                                          //   01 : 64-bit
                                          //   10 : 128-bit
                                          //   11 : 128-bit.
   input         enable_transmit;         // transmit enable signal from network
                                          // control register (soft reset of tx
                                          // block).
   input         enable_receive;          // receive enable signal from network
                                          // control register (soft reset of rx
                                          // block).
   input         jumbo_enable;            // enable reception of jumbo frames.
   input         pause_enable;            // set to enable receipton of pause
                                          // frames, which causes tx to halt
                                          // transmission when a pause frame
                                          // is indicated by the rx block.
   input         retry_test;              // reduces back off time - must be set
                                          // to zero for normal operation.
   input  [15:0] tx_pause_quantum;        // tx_pause_quantum for pause tx.
   input  [1:0]  tx_pause_quantum_par;    // Optional parity
   input  [15:0] tx_pause_quantum_p1;     // tx_pause_quantum for pause tx.
   input  [1:0]  tx_pause_quantum_p1_par; // Optional parity
   input  [15:0] tx_pause_quantum_p2;     // tx_pause_quantum for pause tx.
   input  [1:0]  tx_pause_quantum_p2_par; // Optional parity
   input  [15:0] tx_pause_quantum_p3;     // tx_pause_quantum for pause tx.
   input  [1:0]  tx_pause_quantum_p3_par; // Optional parity
   input  [15:0] tx_pause_quantum_p4;     // tx_pause_quantum for pause tx.
   input  [1:0]  tx_pause_quantum_p4_par; // Optional parity
   input  [15:0] tx_pause_quantum_p5;     // tx_pause_quantum for pause tx.
   input  [1:0]  tx_pause_quantum_p5_par; // Optional parity
   input  [15:0] tx_pause_quantum_p6;     // tx_pause_quantum for pause tx.
   input  [1:0]  tx_pause_quantum_p6_par; // Optional parity
   input  [15:0] tx_pause_quantum_p7;     // tx_pause_quantum for pause tx.
   input  [1:0]  tx_pause_quantum_p7_par; // Optional parity
   input         tx_pause_frame_req;      // software controlled trigger for
                                          // transmission of pause frame.
   input         tx_pause_frame_zero;     // software controlled trigger for
                                          // transmission of pause frame with
                                          // zero quantum.
   input         tx_pfc_frame_req;        // request to transmit PFC pause frame
   input  [7:0]  tx_pfc_frame_pri;        // software controlled for priority
                                          // enable vector of PFC pause frame.
   input         tx_pfc_frame_pri_par;    // Optional parity
   input  [7:0]  tx_pfc_frame_zero;       // software controlled for pause
                                          // quantum field of PFC pause frame.
                                          // When each entry equal to 0,
                                          // the pause quantum field of the
                                          // associated priority is from the
                                          // TX pause quantum register
                                          // When each entry equal to 1,
                                          // the pause quantum field of the
                                          // associated priority is zero
   input         tx_lpi_en;               // enables transmission of LPI
   input         ifg_eats_qav_credit;     // modifies CBS algorithm so IFG/IPG uses Qav credit
   input  [15:0] tw_sys_tx_time;          // system wake time after tx LPI stops
   input         tx_status_wr_tog;        // toggle handshake for status write
                                          // back to register block.
   input         rx_status_wr_tog;        // toggle handshake for status write
                                          // back to register block.
   input         rx_no_crc_check;         // disables crc checking on receive
   input         tx_pause_tog_ack;        // handshake of tx_pause_time_tog
                                          // back to register block.
   input         rx_1536_en;              // enable reception of 1536 byte
                                          // frame.
   input         strip_rx_fcs;            // stops rx fcs/crc being copied.
   input         rx_no_pause_frames;      // Don't copy any pause frames.
   input         rx_toe_enable;           // Enable RX TCP Offload Engine.
   input         pfc_enable;              // bit 16 of network control register
                                          // enable PFC pause frame reception
   input         check_rx_length;         // enables rx length field checking.
   input         loopback_local;          // internal loopback mode.
   input         back_pressure;           // goes to tx block to force
                                          // collisions on all incoming frames
   input         halfduplex_fc_en;        // Enables above back_pressure mech
   input         en_half_duplex_rx;       // enable receiving of frames whilst
                                          // transmiting in half duplex.
   input         ext_match_en;            // external match enable from
                                          // the network configuration register.
   input         uni_hash_en;             // unicast hash enable from the
                                          // network configuration register.
   input         multi_hash_en;           // multicast hash enable signal from
                                          // the network configuration register.
   input         no_broadcast;            // signal to disable recption of
                                          // broadcast frames from the network
                                          // configuration register.
   input         copy_all_frames;         // copy all frames signal from the
                                          // network configuration register.
   input         rm_non_vlan;             // Discard non-VLAN frames
   input  [63:0] hash;                    // hash register for destination
                                          // address filtering.


   // Scheduler Signals
   input  [31:0] idleslope_q_a;       // Rate of Change of credit for Queue A
   input  [1:0]  cbs_enable;          // Enable for CBS queues
   input  [3:0]  cbs_q_a_id;
   input  [3:0]  cbs_q_b_id;
   input  [31:0] idleslope_q_b;       // Rate of Change of credit for Queue B
   input  [31:0] port_tx_rate;        // TX Rate
   input  [31:0] dwrr_ets_control;
   input  [127:0]bw_rate_limit;

   input [55*(p_num_spec_add_filters+1)-1:0] spec_add_filter_regs;   // specific address filters
   input [p_num_spec_add_filters:0] spec_add_filter_active;  // specific address filter active
   input  [47:0] spec_add1_tx;            // Source address for pause tx
   input  [5:0]  spec_add1_tx_par;        // Optional parity
   input  [47:0] mask_add1;               // specific address 1 mask for
                                          // destination address comparison.

   input  [15:0] spec_type1;              // specific type 1 for type comparison
   input  [15:0] spec_type2;              // specific type 2 for type comparison
   input  [15:0] spec_type3;              // specific type 3 for type comparison
   input  [15:0] spec_type4;              // specific type 4 for type comparison
   input         spec_type1_active;       // spec_type1 can be used for type
                                          // comparison.
   input         spec_type2_active;       // spec_type2 can be used for type
                                          // comparison.
   input         spec_type3_active;       // spec_type3 can be used for type
                                          // comparison.
   input         spec_type4_active;       // spec_type4 can be used for type
                                          // comparison.
   input  [15:0] wol_ip_addr;             // lower bits of IP address for WoL
   input   [3:0] wol_mask;                // Wake-onLAN enable mask
   input         stretch_enable;          // enables IPG stretching
   input  [15:0] stretch_ratio;           // determines how to stretch the IPG
   input   [3:0] min_ifg;                 // minimum transmit IFG divided by four
   input         rx_bad_preamble;         // enables reception of frames with
                                          // bad preamble
   input         ign_ipg_rx_er;           // ignore rx_er when rx_dv is low
   input         store_udp_offset;        // store tcp/udp offset to memory
   input         store_rx_ts;             // store receive time stamp to memory

   // pclk timed output to gem_registers ...
   output [77:0] tsu_ptp_tx_timer_out;    // Sampled timestamp to gem-registers
   output [77:0] tsu_ptp_rx_timer_out;    // Sampled timestamp to gem-registers
   // RAS - Timestamp parity protection
   output [9:0] tsu_ptp_tx_timer_par_out;    // parity protection for tsu_ptp_tx_timer_out
   output [9:0] tsu_ptp_rx_timer_par_out;    // parity protection for tsu_ptp_rx_timer_out

   // tsu_clk domain inputs
   input [93:16] tsu_timer_cnt;           // TSU timer count value
   input [11:2]  tsu_timer_cnt_par;

   // pclk domain
   input         one_step_sync_mode;      // enable ts insertion into sync frames
   input         oss_correction_field;    // enable update of correction field in sync frames


   // signals coming from gem_dma_top (or external tx fifo interface).
   input [127:0] tx_r_data;               // output data from the transmit fifo
                                          // to the tx module.
   input [15:0]  tx_r_data_par;
   input   [3:0] tx_r_mod;                // tx number of valid bytes in last
                                          // transfer of the frame.
                                          // 0000 - tx_r_data[7:0] valid,
                                          // 0001 - tx_r_data[15:0] valid, until
                                          // 1111 - tx_r_data[127:0] valid.
   input         tx_r_sop;                // tx start of packet indicator.
   input         tx_r_eop;                // tx end of packet indicator.
   input         tx_r_err;                // tx packet in error indicator.
   input         tx_r_valid;              // new tx data available from fifo.
   input [p_edma_queues-1:0] tx_r_data_rdy; // indicates either a complete packet
                                          // is present in the fifo or a certain
                                          // threshold of data has been crossed,
                                          // the mac uses this input to trigger
                                          // a frame transfer.
   input         dma_is_busy; // packets are availbale
   input         tx_r_underflow;          // signals tx fifo underrun condition.
   input         tx_r_flushed;            // tx fifo flushed status, not used.
   input         tx_r_control;            // packet control information
   input   [p_edma_queues-1:0]        tx_r_frame_size_vld; // We have the frame size.
   input   [(p_edma_queues*14)-1:0]   tx_r_frame_size;     // Frame Length, 1 per queue
   input   [p_edma_queues-1:0]        tx_r_launch_time_vld;
   input   [(p_edma_queues*32)-1:0]   tx_r_launch_time;

   // signals going to gem_dma_top (or external tx fifo interface).
   output  [p_edma_queues-1:0]  tx_r_rd;          // request new data from fifo.
   output  [p_edma_queues-1:0]  tx_r_rd_int;      // early version of tx_r_rd
   output  [3:0]                tx_r_queue;       // Queue ID, timed with tx_r_rd
   output  [3:0]                tx_r_queue_int;   // early version, timed with tx_r_rd_int

   // signals going to gem_dma_top (or external rx fifo interface).
   output        rx_w_wr;                 // rx write output to the receive
                                          // fifo.
   output[127:0] rx_w_data;               // output data to the receive fifo.
   output [15:0] rx_w_data_par;
   output  [3:0] rx_w_mod;                // rx number of valid bytes in last
                                          // transfer of the frame.
                                          // 0000 - tx_r_data[7:0] valid,
                                          // 0001 - tx_r_data[15:0] valid, until
                                          // 1111 - tx_r_data[127:0] valid.
   output        rx_w_sop;                // rx start of packet indicator.
   output        rx_w_eop;                // rx end of packet indicator.
   output        rx_w_err;                // rx packet in error indicator.
   output        rx_w_flush;              // rx fifo flush from the mac
   input         rx_w_overflow;           // Overflow in RX FIFO indication

   // signals going to gem_dma_top (or external rx fifo interface).
   output        rx_w_bad_frame;          // end of bad receive frame, rx frame
                                          // bad (rx_er or too long) held until
                                          // end of frame.
   output [13:0] rx_w_frame_length;       // records frame length for status
                                          // reporting.
   output        rx_w_vlan_tagged;        // used for reporting vlan tag.
   output        rx_w_prty_tagged;        // used for reporting priority tag.
   output  [3:0] rx_w_tci;                // used for reporting vlan priority.
   output        rx_w_broadcast_frame;    // broadcast frame signal from the
                                          // address checker - rx status
                                          // reporting.
   output        rx_w_mult_hash_match;    // multicast hash matched frame signal
                                          // for rx status reporting.
   output        rx_w_uni_hash_match;     // unicast hash matched frame signal
                                          // for rx status reporting.
   output        rx_w_ext_match1;         // external matched frame signal
                                          // for rx status reporting.
   output        rx_w_ext_match2;         // external matched frame signal
                                          // for rx status reporting.
   output        rx_w_ext_match3;         // external matched frame signal
                                          // for rx status reporting.
   output        rx_w_ext_match4;         // external matched frame signal
                                          // for rx status reporting.
   output [p_num_spec_add_filters:0] rx_w_add_match; // specific address register matched
   output        rx_w_type_match1;        // specific type register 1 matched
                                          // type field.
   output        rx_w_type_match2;        // specific type register 2 matched
                                          // type field.
   output        rx_w_type_match3;        // specific type register 3 matched
                                          // type field.
   output        rx_w_type_match4;        // specific type register 4 matched
                                          // type field.
   output        rx_w_checksumi_ok;       // IP checksum checked and was OK.
   output        rx_w_checksumt_ok;       // TCP checksum checked and was OK.
   output        rx_w_checksumu_ok;       // UDP checksum checked and was OK.
   output        rx_w_snap_frame;         // Frame was SNAP encapsulated and
                                          // had no VLAN or VLAN with no CFI.
   output        rx_w_length_error;       // rx_w_status length field error
   output        rx_w_crc_error;          // rx_w_status crc error
   output        rx_w_too_short;          // rx_w_status rx length short error
   output        rx_w_too_long;           // rx_w_status rx length long error
   output        rx_w_code_error;         // rx_w_status code error
   output [11:0] rx_w_l4_offset;          // TCP/UDP offset in bytes
   output [11:0] rx_w_pld_offset;         // PLD offset in bytes
   output        rx_w_pld_offset_vld;     // PLD offset valid

   // status signals going to gem_dma_top (or external tx fifo interface)
   output        late_coll_occured;       // set if late collision occurs in
                                          // gigabit mode (flushes tx fifo),
                                          // cleared when dma_tx_status_wr_tog
                                          // is returned.
   output        too_many_retries;        // signals too many retries error
                                          // condition (flushes tx fifo),
                                          // cleared when dma_tx_status_wr_tog
                                          // is returned.
   output        underflow_frame;         // asserted high at the end of frame
                                          // to indicate a fifo underrun or
                                          // tx_r_err condition, cleared when
                                          // dma_tx_status_tog is returned.
   output        collision_occured;       // set if collision happens during
                                          // frame transmission, cleared when
                                          // dma_tx_status_wr_tog is returned.
   output [77:0] tx_r_timestamp;          // asserted at the end of frame
   output [77:0] rx_w_timestamp;          // valid on rx_w_eop
   // RAS - Timestamp parity protection
   output [9:0]  tx_r_timestamp_par;     // parity protection for tx_r_timestamp
   output [9:0]  rx_w_timestamp_par;     // parity protection for rx_w_timestamp

   // signals coming from gem_dma_top (or external tx fifo interface)
   input         dma_tx_status_tog;       // when toggled, indicates transmit
                                          // status written by dma.
   input         dma_rx_status_tog;       // when toggled, indicates receive
                                          // status written by dma.

   // signals going to gem_dma_top (or ext tx fifo i/f)(via gem_hclk_syncs)
   output        dma_tx_end_tog;          // toggled at the end of frame
                                          // transmission, cleared when
                                          // dma_tx_status_tog is returned.
   output        dma_rx_end_tog;          // toggled at the end of frame
                                          // reception, cleared when
                                          // dma_rx_status_tog is returned.

   // signals going to the gem_reg_top (gem_pclk_syncs).
   // for statistics register recording.
   output        tx_end_tog;              // toggled at the end of frame
                                          // transmission (used for handshake
                                          // of statistics), cleared when
                                          // tx_status_wr_tog is returned.
   output        rx_end_tog;              // toggled at the end of frame
                                          // reception (used for handshake of
                                          // of statistics), cleared when
                                          // rx_status_wr_tog is returned.
   output        tx_coll_occured;         // set if collision happens during
                                          // frame transmission, cleared when
                                          // tx_status_wr_tog is returned.
   output        tx_frame_txed_ok;        // asserted on end_frame if no
                                          // underrun and not too many retries.
                                          // retries. cleared when
                                          // tx_status_wr_tog is returned.
   output        tx_broadcast_frame;      // asserted on end_frame if the frame
                                          // transmitted was broadcast.
   output        tx_multicast_frame;      // asserted on end_frame if the frame
                                          // transmitted was multicast.
   output        tx_single_coll_frame;    // asserted on end_frame if a single
                                          // collision occured prior to the
                                          // frame being successfully
                                          // transmitted with no fifo underrun
                                          // condition, cleared when
                                          // tx_status_wr_tog is returned.
   output        tx_multi_coll_frame;     // asserted on end_frame if a multi
                                          // collision occured prior to the
                                          // frame being successfully
                                          // transmitted with no fifo underrun
                                          // condition, cleared when
                                          // tx_status_wr_tog is returned.
   output        tx_deferred_tx_frame;    // asserted on end_frame if deferred,
                                          // no collision and no
                                          // underrun. cleared when
                                          // tx_status_wr_tog is returned.
   output        tx_late_coll_frame;      // asserted on end_frame if late
                                          // collision, no underrun and
                                          // not too many retries. cleared when
                                          // tx_status_wr_tog is returned.
   output        tx_crs_error_frame;      // asserted on end_frame, if crs error
                                          // and no underrun. cleared when
                                          // tx_status_wr_tog is returned.
   output        tx_too_many_retries;     // signals too many retries error
                                          // condition, cleared when
                                          // tx_status_wr_tog is returned.
   output        tx_underflow_frame;      // asserted high at the end of frame
                                          // to indicate a fifo underrun,
                                          // cleared when tx_status_wr_tog
                                          // is returned.
   output [13:0] tx_bytes_in_frame;       // number of bytes in tx frame.
   output        tx_pause_frame_txed;     // asserted when pause frame is txed,
                                          // cleared when tx_status_wr_tog is
                                          // returned.
   output        tx_pfc_pause_frame_txed; // asserted when PFC pause frame is
                                          // txed,
                                          // cleared when tx_status_wr_tog is
                                          // returned.
   output [15:0] tx_pause_time;           // current value of pause time
                                          // counter.
   output        tx_pause_time_tog;       // pause time counter changed.
   output [13:0] rx_bytes_in_frame;       // number of bytes in rx frame.
   output        rx_broadcast_frame;      // asserted on end_frame if the frame
                                          // received was broadcast.
   output        rx_multicast_frame;      // asserted on end_frame if the frame
                                          // received was multicast.
   output        lpi_indicate;            // rx LPI indication has been detected
   output        rx_frame_rxed_ok;        // frame recieved OK by MAC
   output        rx_align_error;          // misaligned frame (non-integral
                                          // number of bytes and bad crc).
                                          // cleared when rx_status_wr_tog
                                          // is returned.
   output        rx_crc_error;            // crc errored frame (integral number
                                          // of bytes and bad crc). cleared
                                          // when rx_status_wr_tog is returned.
   output        rx_short_error;          // short frame (less than 64 bytes and
                                          // good crc). cleared when
                                          // rx_status_wr_tog is returned.
   output        rx_long_error;           // long frame (greater than 1518 bytes
                                          // and good crc). cleared when
                                          // rx_status_wr_tog is returned.
   output        rx_jabber_error;         // long frame with bad crc (greater
                                          // than 1518 bytes). cleared when
                                          // rx_status_wr_tog is returned.
   output        rx_symbol_error;         // signal indicating a rx_er frame.
                                          // cleared when rx_status_wr_tog is
                                          // returned.
   output        rx_pause_frame;          // indicates a 802.3 pause frame
                                          // has been received. cleared when
                                          // rx_status_wr_tog is returned.
   output        rx_pause_nonzero;        // indicates a 802.3 pause frame
                                          // has been received with non-zero
                                          // quantum.
                                          // cleared on rx_status_wr_tog.
   output        rx_pfc_pause_frame;      // indicates a PFC pause frame
                                          // has been received
   output        rx_pfc_pause_nonzero;    // indicates a PFC pause frame
                                          // has been received (pause_enable=1)
                                          // equivalent to rx_pause_nonzero for
                                          // classic pause frame
   output        rx_length_error;         // indicates a frame has been received
                                          // where the length field is
                                          // incorrect. cleared when
                                          // rx_status_wr_tog is returned.
   output        rx_ip_ck_error;          // frame had IP header checksum error
                                          // cleared when rx_status_wr_tog
                                          // is returned.
   output        rx_tcp_ck_error;         // frame had TCP checksum error
                                          // cleared when rx_status_wr_tog
                                          // is returned.
   output        rx_udp_ck_error;         // frame had UDP checksum error
                                          // cleared when rx_status_wr_tog
                                          // is returned.
   output        rx_overflow;             // Indicates an overrun in the RX path
                                          // cleared when rx_status_wr_tog is
                                          // returned.
   output  [3:0] queue_ptr_rx;            // RX priority queue number

   // EnST signals
   input  [7:0]    enst_en;               // Disable/Enable Vector
   input  [255:0]  start_time;            // start_time of the transmission
   input  [135:0]  on_time;               // Number of bytes to transmit during on_time
   input  [135:0]  off_time;              // off time of the transmission expressed in bytes
   input  [1:0]    add_frag_size;         // Encoded value of the number of bytes that pMAC
                                          // can xmit before giving priority to the eMAC
   output [p_edma_queues-1:0] hold;       // 802.3br support signal

   // RAS - signals to gem_reg_top
   output asf_dap_mac_rx_err;           // data path error indications in rxclk
   output asf_dap_mac_tx_err;           // data path error indications in txclk
   output asf_integrity_tx_sched_err;   // Integrity check error in Transmit Scheduling
   wire   uncorr_err_dp_txd_gmii;       // data path error indications on txd_gmii
   wire   uncorr_err_dp_txd_to_loop;    // data path error indications on txd_to_loop

   // 802.1CB control and status
   input  [15:0]  frer_to_cnt;          // Count of number of frer_to_cnt_tog
                                            // without passing frames before timeout
   input  [15:0]  frer_rtag_ethertype;  // Ethertype for redundancy tag detect
   input          frer_strip_rtag;      // Strip redundancy tags
   input          frer_6b_tag;          // R-Tag is 6 bytes not 4 bytes
   input  [p_gem_num_cb_streams-1:0]
                  frer_en_vec_alg;      // Select which algorithm to use.
   input  [p_gem_num_cb_streams-1:0]
                  frer_use_rtag;        // Set to use RTag or offset for seqnum

   input  [(p_gem_num_cb_streams*9)-1:0]
                  frer_seqnum_oset;     // Offset into frame for seqnum
   input  [(p_gem_num_cb_streams*5)-1:0]
                  frer_seqnum_len;      // Number of bits of seqnum to use
   input  [(p_gem_num_cb_streams*4)-1:0]
                  frer_scr_sel_1;       // Screener match for stream 1
   input  [(p_gem_num_cb_streams*4)-1:0]
                  frer_scr_sel_2;       // Screener match for stream 2
   input  [(p_gem_num_cb_streams*6)-1:0]
                  frer_vec_win_sz;      // History depth to use for vec rcv alg

   input  [p_gem_num_cb_streams-1:0]
                  frer_en_elim;         // Enable 802.1CB elimination function
   input  [p_gem_num_cb_streams-1:0]
                  frer_en_to;           // Enable 802.1CB timeout function

   output [p_gem_num_cb_streams-1:0]
                  frer_to_tog;          // Toggle to indicate timeout occurred

   output [p_gem_num_cb_streams-1:0]
                  frer_rogue_tog;       // Toggle to indicate rogue frame rcvd
   output [p_gem_num_cb_streams-1:0]
                  frer_ooo_tog;         // Toggle to indicate out of order frame
   output [p_gem_num_cb_streams-1:0]
                  frer_err_upd_tog;     // Toggle to enable update latent errors
   output [(p_gem_num_cb_streams*7)-1:0]
                  frer_err_upd_val;     // Incrememt value, use with above

   output         tx_r_sop_lockup;      // SOP from FIFO i/f for lockup detection
   output         tx_r_eop_lockup;      // EOP from FIFO i/f for lockup detection
   output         tx_r_valid_lockup;

   // rx_q_flush registers signals ready to use by gem_rx_per_queue_flush module
   input     [(16*p_edma_queues)-1:0] max_val_pclk;
   input          [p_edma_queues-1:0] limit_frames_size_rx_clk;
   input          [p_edma_queues-1:0] drop_all_frames_rx_clk;
   input          [p_edma_queues-1:0] fill_lvl_breached;

   // per type 2 screener rate limiting algorithm registers
   input [32*p_num_type2_screeners:0] scr2_rate_lim;
   output   [p_num_type2_screeners:0] scr_excess_rate;

   // toggle to stats, indicating a frame flushed by mode1, mode2, or 3
   output        frame_flushed_tog;

   // PFC pause frame signals
   output        pfc_negotiate;         // indicates a received PFC pause frame

   output [7:0]  rx_pfc_paused;         // each bit is set when PFC frame has
                                        // been received and the associated
                                        // PFC counter != 0
   output        rsc_stop;              // Set if any of the SYN/FIN/RST/URG
                                        // flags are set in the TCP header
   output        rsc_push;              // Set if the PSH flas is set
   output [31:0] tcp_seqnum;            // Identifies the TCP seqnum of the frame
   output        tcp_syn;               // Set if the SYN flas is set
   output [15:0] tcp_payload_len;       // Payload Length

   input [13:0]  jumbo_max_length;      // Jumbo max frame length
   input         ext_rxq_sel_en;        // enable external receive queue selection

   input         soft_config_fifo_en;   // use ext fifo port

   output        block_sram_ecc_check;  // For SPRAN configs edma_spram_tx_mac_buffer may generate a redundant
                                        // read from an unitialised memory location. This signal prevents an
                                        // error being reported if SRAM parity protection is enabled


   // extra signals for internal loopback.
   wire          col_from_loop;           // collision detect signal from PHY
   wire          crs_from_loop;           // carrier sense signal from the PHY.
   wire          tx_er_from_loop;         // transmit error signal to the PHY.
   wire    [8:0] txd_from_loop;           // 0-7 bits transmit data to the PHY.
                                          // 8 bit parity
   wire          tx_en_from_loop;         // transmit enable signal to the PHY.
   wire    [8:0] rxd_from_loop;           // 0-7 bits receive data from the PHY.
                                          // 8 bit parity
   wire          rx_er_from_loop;         // receive error signal from the PHY.
   wire          rx_dv_from_loop;         // receive data valid signal from PHY
   wire          ext_match1_from_loop;    // external match (frame to be copied)
   wire          ext_match2_from_loop;    // external match (frame to be copied)
   wire          ext_match3_from_loop;    // external match (frame to be copied)
   wire          ext_match4_from_loop;    // external match (frame to be copied)
   wire          col_to_loop;             // collision detect signal from PHY
   wire          crs_to_loop;             // carrier sense signal from the PHY.
   wire          tx_er_to_loop;           // transmit error signal to the PHY.
   wire    [8:0] txd_to_loop;             // transmit data to the PHY.
   wire          tx_en_to_loop;           // transmit enable signal to the PHY.
   wire          rx_dv_bp;                // Data detection for backpressure

   wire [(32*p_num_type1_screeners):0] screener_type1_regs; //
   wire [(32*p_num_type2_screeners):0] screener_type2_regs; //

   wire [7:0]     rx_pfc_paused;          // each bit is set when PFC frame has
                                          // been received and the associated
                                          // PFC counter != 0

   wire [3:0]     tx_r_queue;             // Queue ID,
   wire [3:0]     tx_r_queue_int;         // Queue ID,

   wire   [13:0]  jumbo_max_length;

   wire           soft_config_fifo_en;
   wire [8:0]     rxd_gmii_wp;            // 0-7 bits  receive data from the PHY - bit 8 parity

   // EnST signals
   wire [7:0]    enst_en;                 // Enhancement for Scheduled Traffic enable
   wire [255:0]  start_time;              // start_time of the transmission
   wire [135:0]  on_time;                 // Number of bytes to transmit during on_time
   wire [135:0]  off_time;                // off time of the transmission

   // signals from gem_rx to gem_tx.
   wire   [15:0] new_pause_time;          // value of decoded new pause time.
   wire          new_pause_tog;           // indicates a new pause time rxed.

   // -----------------------------------------------------------------------
   //                      TX MAX
   // -----------------------------------------------------------------------
   gem_tx_wrap #(
     .grouped_params(grouped_params)
   ) i_gem_tx_wrap (

      // system signals.
      .n_txreset               (n_txreset),
      .tx_clk                  (tx_clk),

      // loopback clock
      .tsu_clk                 (tsu_clk),
      .n_tsureset              (n_tsureset),
      .pclk                    (pclk),
      .n_preset                (n_preset),
      .n_hreset                (n_hreset),
      .hclk                    (hclk),

      // gmii/mii signals.
      .txd                     (txd_to_loop[7:0]),
      .txd_par                 (txd_to_loop[8]),
      .tx_en                   (tx_en_to_loop),
      .tx_er                   (tx_er_to_loop),
      .col                     (col_from_loop),
      .crs                     (crs_from_loop),
      .rx_dv                   (rx_dv_bp),

      // top level ethernet signals.
      .txd_frame_size          (txd_frame_size),
      .txd_rdy                 (txd_rdy),
      .tx_pause                (tx_pause),
      .tx_pause_zero           (tx_pause_zero),
      .tx_pfc_sel              (tx_pfc_sel),
      .tx_pfc_pause            (tx_pfc_pause),
      .tx_pfc_pause_zero       (tx_pfc_pause_zero),

      // precision time protocol signals for IEEE 1588 support
      .sof_tx                  (sof_tx),
      .sync_frame_tx           (sync_frame_tx),
      .delay_req_tx            (delay_req_tx),
      .pdelay_req_tx           (pdelay_req_tx),
      .pdelay_resp_tx          (pdelay_resp_tx),
      .general_frame_tx        (general_frame_tx),
      .event_frame_tx          (event_frame_tx),

      // signals coming from gem_reg_top (gem_registers).
      .full_duplex             (full_duplex),
      .bit_rate                (bit_rate),
      .gigabit                 (gigabit),
      .two_pt_five_gig         (two_pt_five_gig),
      .tx_byte_mode            (tx_byte_mode),
      .dma_bus_width           (dma_bus_width),
      .enable_transmit         (enable_transmit),
      .pause_enable            (pause_enable),
      .retry_test              (retry_test),
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
      .tx_pause_frame_req      (tx_pause_frame_req),
      .tx_pause_frame_zero     (tx_pause_frame_zero),
      .tx_pfc_frame_req        (tx_pfc_frame_req),
      .tx_pfc_frame_pri        (tx_pfc_frame_pri),
      .tx_pfc_frame_pri_par    (tx_pfc_frame_pri_par),
      .tx_pfc_frame_zero       (tx_pfc_frame_zero),
      .tx_lpi_en               (tx_lpi_en),
      .ifg_eats_qav_credit     (ifg_eats_qav_credit),
      .tw_sys_tx_time          (tw_sys_tx_time),
      .spec_add1               (spec_add1_tx),
      .spec_add1_par           (spec_add1_tx_par),
      .spec_add1_active        (spec_add_filter_active[0]),
      .tx_status_wr_tog        (tx_status_wr_tog),
      .tx_pause_tog_ack        (tx_pause_tog_ack),
      .ptp_unicast_ena         (ptp_unicast_ena),
      .tx_ptp_unicast          (tx_ptp_unicast),
      .rx_fill_level_low       (rx_fill_level_low),
      .rx_fill_level_high      (rx_fill_level_high),
      .halfduplex_fc_en        (halfduplex_fc_en),
      .back_pressure           (back_pressure),
       // Credit Based Shaping and scheduler
      .cbs_enable              (cbs_enable),
      .cbs_q_a_id              (cbs_q_a_id),
      .cbs_q_b_id              (cbs_q_b_id),
      .idleslope_q_a           (idleslope_q_a),
      .idleslope_q_b           (idleslope_q_b),
      .port_tx_rate            (port_tx_rate),
      .dwrr_ets_control        (dwrr_ets_control),
      .bw_rate_limit           (bw_rate_limit),
      .stretch_enable          (stretch_enable),
      .stretch_ratio           (stretch_ratio),
      .min_ifg                 (min_ifg),

      .tsu_ptp_tx_timer_out    (tsu_ptp_tx_timer_out),
      .tsu_ptp_tx_timer_par_out(tsu_ptp_tx_timer_par_out),  // RAS - Timestamp parity protection
      .one_step_sync_mode      (one_step_sync_mode),
      .oss_correction_field    (oss_correction_field),
      .tsu_timer_cnt           (tsu_timer_cnt[93:16]),
      .tsu_timer_cnt_par       (tsu_timer_cnt_par[11:2]),

      // signals coming from edma_top.
      // (or external tx fifo interface).
      .tx_r_data               (tx_r_data),
      .tx_r_par                (tx_r_data_par),
      .tx_r_mod                (tx_r_mod),
      .tx_r_sop                (tx_r_sop),
      .tx_r_eop                (tx_r_eop),
      .tx_r_err                (tx_r_err),
      .tx_r_valid              (tx_r_valid),
      .tx_r_data_rdy           (tx_r_data_rdy),
      .dma_is_busy             (dma_is_busy),
      .tx_r_flushed            (tx_r_flushed),
      .tx_r_underflow          (tx_r_underflow),
      .tx_r_control            (tx_r_control),
      .tx_r_frame_size_vld     (tx_r_frame_size_vld),
      .tx_r_frame_size         (tx_r_frame_size),
      .tx_r_launch_time_vld    (tx_r_launch_time_vld),
      .tx_r_launch_time        (tx_r_launch_time),

      // signals going to edma_top.
      // (or external tx fifo interface).
      .tx_r_rd                 (tx_r_rd),
      .tx_r_rd_int             (tx_r_rd_int),
      .tx_r_queue              (tx_r_queue),
      .tx_r_queue_int          (tx_r_queue_int),

      .tx_r_timestamp          (tx_r_timestamp),
      // RAS - Timestamp parity protection
      .tx_r_timestamp_par      (tx_r_timestamp_par),

      // status signals going to edma_top (or external tx fifo interface).
      .late_coll_occured       (late_coll_occured),
      .too_many_retries        (too_many_retries),
      .underflow_frame         (underflow_frame),
      .collision_occured       (collision_occured),

      // signals coming from edma_top (or external tx fifo interface).
      .dma_tx_status_tog       (dma_tx_status_tog),

      // signals going to edma_top (gem_hclk_syncs).
      .dma_tx_end_tog          (dma_tx_end_tog),

      // signals going to the gem_reg_top (gem_pclk_syncs)
      // for statistics register recording.
      .tx_end_tog              (tx_end_tog),
      .tx_bytes_in_frame       (tx_bytes_in_frame),
      .tx_broadcast_frame      (tx_broadcast_frame),
      .tx_multicast_frame      (tx_multicast_frame),
      .tx_coll_occured         (tx_coll_occured),
      .tx_frame_txed_ok        (tx_frame_txed_ok),
      .tx_single_coll_frame    (tx_single_coll_frame),
      .tx_multi_coll_frame     (tx_multi_coll_frame),
      .tx_deferred_tx_frame    (tx_deferred_tx_frame),
      .tx_late_coll_frame      (tx_late_coll_frame),
      .tx_crs_error_frame      (tx_crs_error_frame),
      .tx_too_many_retries     (tx_too_many_retries),
      .tx_underflow_frame      (tx_underflow_frame),
      .tx_pause_frame_txed     (tx_pause_frame_txed),
      .tx_pfc_pause_frame_txed (tx_pfc_pause_frame_txed),
      .tx_pause_time           (tx_pause_time),
      .tx_pause_time_tog       (tx_pause_time_tog),

      .soft_config_fifo_en     (soft_config_fifo_en),

      // signals coming from gem_mac (gem_rx).
      .new_pause_time          (new_pause_time),
      .new_pause_tog           (new_pause_tog),

      // EnST signals
      .enst_en                 (enst_en),
      .start_time              (start_time),
      .on_time                 (on_time),
      .off_time                (off_time),
      .add_frag_size           (add_frag_size),
      .hold                    (hold),

      // Feedback for lockup detection
      .tx_r_sop_lockup         (tx_r_sop_lockup),
      .tx_r_eop_lockup         (tx_r_eop_lockup),
      .tx_r_valid_lockup       (tx_r_valid_lockup),

      .asf_integrity_tx_sched_err(asf_integrity_tx_sched_err),

      .block_sram_ecc_check    (block_sram_ecc_check)

   );

   // -----------------------------------------------------------------------
   //                      RX MAX
   // -----------------------------------------------------------------------
   gem_rx #(
      .grouped_params(grouped_params),
      .p_gem_rx_pipeline_delay(p_gem_rx_pipeline_delay)
    ) i_gem_rx (

      // system signals.
      .n_rxreset            (n_rxreset),
      .rx_clk               (rx_clk),
      .tsu_clk              (tsu_clk),
      .n_tsureset           (n_tsureset),
      .pclk                 (pclk),
      .n_preset             (n_preset),

      .screener_type1_regs  (screener_type1_regs),
      .screener_type2_regs  (screener_type2_regs),
      .scr2_compare_regs    (scr2_compare_regs),
      .scr2_ethtype_regs    (scr2_ethtype_regs),

      // Halt signal from 802.3br MMSL
      .rx_br_halt           (rx_br_halt),

      // gmii/mii interface.
      .rxd_gmii             (rxd_gmii_wp),
      .rx_er_gmii           (rx_er_from_loop),
      .rx_dv_gmii           (rx_dv_from_loop),

      // dedicated pcs interface.
      .rxd_pcs              (rxd_pcs),
      .rxd_pcs_par          (rxd_par_pcs),
      .rx_er_pcs            (rx_er_pcs),
      .rx_dv_pcs            (rx_dv_pcs),

      // control & config signals coming from the gem_reg_top (gem_registers).
      .enable_receive       (enable_receive),
      .retry_test           (retry_test),
      .gigabit              (gigabit),
      .tbi                  (tbi),
      .tx_byte_mode         (tx_byte_mode),
      .full_duplex          (full_duplex),
      .dma_bus_width        (dma_bus_width),
      .jumbo_enable         (jumbo_enable),
      .rx_1536_en           (rx_1536_en),
      .pause_enable         (pause_enable),
      .pfc_enable           (pfc_enable),
      .strip_rx_fcs         (strip_rx_fcs),
      .rx_no_pause_frames   (rx_no_pause_frames),
      .rx_toe_enable        (rx_toe_enable),
      .check_rx_length      (check_rx_length),
      .rx_status_wr_tog     (rx_status_wr_tog),
      .rx_no_crc_check      (rx_no_crc_check),
      .rx_bad_preamble      (rx_bad_preamble),
      .ign_ipg_rx_er        (ign_ipg_rx_er),
      .ptp_unicast_ena      (ptp_unicast_ena),
      .rx_ptp_unicast       (rx_ptp_unicast),
      .store_udp_offset     (store_udp_offset),
      .store_rx_ts          (store_rx_ts),

      // filter control signals coming from the gem_reg_top (gem_registers).
      .ext_match_en            (ext_match_en),
      .uni_hash_en             (uni_hash_en),
      .multi_hash_en           (multi_hash_en),
      .no_broadcast            (no_broadcast),
      .copy_all_frames         (copy_all_frames),
      .rm_non_vlan             (rm_non_vlan),
      .hash                    (hash),
      .mask_add1               (mask_add1),
      .spec_add_filter_regs    (spec_add_filter_regs),
      .spec_add_filter_active  (spec_add_filter_active),
      .spec_type1              (spec_type1),
      .spec_type2              (spec_type2),
      .spec_type3              (spec_type3),
      .spec_type4              (spec_type4),
      .spec_type1_active       (spec_type1_active),
      .spec_type2_active       (spec_type2_active),
      .spec_type3_active       (spec_type3_active),
      .spec_type4_active       (spec_type4_active),
      .wol_ip_addr             (wol_ip_addr),
      .wol_mask                (wol_mask),
      .loopback_local          (loopback_local),
      .en_half_duplex_rx       (en_half_duplex_rx),

      // signals going to/from the external filter interface.
      .ext_match1_from_loop (ext_match1_from_loop),
      .ext_match2_from_loop (ext_match2_from_loop),
      .ext_match3_from_loop (ext_match3_from_loop),
      .ext_match4_from_loop (ext_match4_from_loop),
      .ext_da               (ext_da),
      .ext_da_stb           (ext_da_stb),
      .ext_sa               (ext_sa),
      .ext_sa_stb           (ext_sa_stb),
      .ext_type             (ext_type),
      .ext_type_stb         (ext_type_stb),
      .ext_ip_sa            (ext_ip_sa),
      .ext_ip_sa_stb        (ext_ip_sa_stb),
      .ext_ip_da            (ext_ip_da),
      .ext_ip_da_stb        (ext_ip_da_stb),
      .ext_source_port      (ext_source_port),
      .ext_sp_stb           (ext_sp_stb),
      .ext_dest_port        (ext_dest_port),
      .ext_dp_stb           (ext_dp_stb),
      .ext_ipv6             (ext_ipv6),

      .stacked_vlantype     (stacked_vlantype),
      .ext_vlan_tag1        (ext_vlan_tag1),
      .ext_vlan_tag1_stb    (ext_vlan_tag1_stb),
      .ext_vlan_tag2        (ext_vlan_tag2),
      .ext_vlan_tag2_stb    (ext_vlan_tag2_stb),

      // precision time protocol signals for IEEE 1588 support
      .sof_rx               (sof_rx),
      .sync_frame_rx        (sync_frame_rx),
      .delay_req_rx         (delay_req_rx),
      .pdelay_req_rx        (pdelay_req_rx),
      .pdelay_resp_rx       (pdelay_resp_rx),
      .general_frame_rx     (general_frame_rx),

      // signals coming from gem_dma_top.
      .dma_rx_status_tog    (dma_rx_status_tog),

      // signals going to gem_dma_top (gem_hclk_syncs).
      .dma_rx_end_tog       (dma_rx_end_tog),

      // signals going to gem_dma_top (or external rx fifo interface).
      .rx_w_bad_frame       (rx_w_bad_frame),
      .rx_w_frame_length    (rx_w_frame_length),
      .rx_w_vlan_tagged     (rx_w_vlan_tagged),
      .rx_w_prty_tagged     (rx_w_prty_tagged),
      .rx_w_tci             (rx_w_tci),

      // FIFO signals going to gem_dma_top (or external rx fifo interface).
      .rx_w_wr              (rx_w_wr),
      .rx_w_data            (rx_w_data),
      .rx_w_data_par        (rx_w_data_par),
      .rx_w_mod             (rx_w_mod),
      .rx_w_sop             (rx_w_sop),
      .rx_w_eop             (rx_w_eop),
      .rx_w_err             (rx_w_err),
      .rx_w_flush           (rx_w_flush),
      .rx_w_overflow        (rx_w_overflow),
      .rx_w_timestamp       (rx_w_timestamp),
      .rx_w_timestamp_prty  (rx_w_timestamp_par),

      // filter signals going to gem_dma_top (or external rx fifo interface).
      .rx_w_broadcast_frame (rx_w_broadcast_frame),
      .rx_w_mult_hash_match (rx_w_mult_hash_match),
      .rx_w_uni_hash_match  (rx_w_uni_hash_match),
      .rx_w_ext_match1      (rx_w_ext_match1),
      .rx_w_ext_match2      (rx_w_ext_match2),
      .rx_w_ext_match3      (rx_w_ext_match3),
      .rx_w_ext_match4      (rx_w_ext_match4),
      .rx_w_add_match       (rx_w_add_match),
      .rx_w_type_match1     (rx_w_type_match1),
      .rx_w_type_match2     (rx_w_type_match2),
      .rx_w_type_match3     (rx_w_type_match3),
      .rx_w_type_match4     (rx_w_type_match4),
      .rx_w_checksumi_ok    (rx_w_checksumi_ok),
      .rx_w_checksumt_ok    (rx_w_checksumt_ok),
      .rx_w_checksumu_ok    (rx_w_checksumu_ok),
      .rx_w_snap_frame      (rx_w_snap_frame),
      .rx_w_length_error    (rx_w_length_error),
      .rx_w_crc_error       (rx_w_crc_error),
      .rx_w_too_short       (rx_w_too_short),
      .rx_w_too_long        (rx_w_too_long),
      .rx_w_code_error      (rx_w_code_error),
      .rx_w_l4_offset       (rx_w_l4_offset),
      .rx_w_pld_offset      (rx_w_pld_offset),
      .rx_w_pld_offset_vld  (rx_w_pld_offset_vld),

      // signals going to gem_reg_top (gem_pclk_syncs).
      .rx_end_tog           (rx_end_tog),
      .rx_frame_rxed_ok     (rx_frame_rxed_ok),
      .rx_align_error       (rx_align_error),
      .rx_crc_error         (rx_crc_error),
      .rx_short_error       (rx_short_error),
      .rx_long_error        (rx_long_error),
      .rx_jabber_error      (rx_jabber_error),
      .rx_symbol_error      (rx_symbol_error),
      .rx_pause_frame       (rx_pause_frame),
      .rx_pause_nonzero     (rx_pause_nonzero),
      .rx_pfc_pause_frame   (rx_pfc_pause_frame),
      .rx_pfc_pause_nonzero (rx_pfc_pause_nonzero),
      .rx_length_error      (rx_length_error),
      .rx_ip_ck_error       (rx_ip_ck_error),
      .rx_tcp_ck_error      (rx_tcp_ck_error),
      .rx_udp_ck_error      (rx_udp_ck_error),
      .rx_overflow          (rx_overflow),
      .rx_bytes_in_frame    (rx_bytes_in_frame),
      .rx_broadcast_frame   (rx_broadcast_frame),
      .rx_multicast_frame   (rx_multicast_frame),
      .lpi_indicate         (lpi_indicate),

      // signals coming from the tx block
      .tx_en                (tx_en_to_loop),

      // signals going to gem_tx (internal).
      .new_pause_time       (new_pause_time),
      .new_pause_tog        (new_pause_tog),

      // Time from TSU
      .tsu_timer_cnt        (tsu_timer_cnt[93:16]),
      .tsu_timer_cnt_par    (tsu_timer_cnt_par[11:2]),
      .tsu_ptp_rx_timer_out (tsu_ptp_rx_timer_out),
      // RAS - Timestamp parity protection
      .tsu_ptp_rx_timer_prty_out (tsu_ptp_rx_timer_par_out),

      // signals going to top level outputs
      .wol                  (wol),
      .rx_dv_bp             (rx_dv_bp),
      .queue_ptr_rx         (queue_ptr_rx),

      // ASF - signals going to gem_reg_top
      .asf_dap_mac_rx_err   (asf_dap_mac_rx_err),

      // PFC signals
      .pfc_negotiate        (pfc_negotiate),
      .rx_pfc_paused        (rx_pfc_paused),

      .rsc_stop             (rsc_stop),
      .rsc_push             (rsc_push),
      .tcp_seqnum           (tcp_seqnum),
      .tcp_syn              (tcp_syn),
      .tcp_payload_len      (tcp_payload_len),

      .jumbo_max_length     (jumbo_max_length),

      .ext_rxq_sel_en       (ext_rxq_sel_en),

      // rx_q_flush signals ready to use by gem_rx_per_queue_flush module
      .max_val_pclk             (max_val_pclk),
      .drop_all_frames_rx_clk   (drop_all_frames_rx_clk),
      .limit_frames_size_rx_clk (limit_frames_size_rx_clk),
      .fill_lvl_breached        (fill_lvl_breached),

      // per type 2 screener rate limiting registers
      .scr2_rate_lim        (scr2_rate_lim),
      .scr_excess_rate      (scr_excess_rate),

      // toggle to stats, indicating a frame flushed by mode2, 3, or 4
      .frame_flushed_tog    (frame_flushed_tog),

      // 802.1CB Control and Status
      .frer_to_cnt          (frer_to_cnt),
      .frer_rtag_ethertype  (frer_rtag_ethertype),
      .frer_strip_rtag      (frer_strip_rtag),
      .frer_6b_tag          (frer_6b_tag),
      .frer_en_vec_alg      (frer_en_vec_alg),
      .frer_use_rtag        (frer_use_rtag),
      .frer_seqnum_oset     (frer_seqnum_oset),
      .frer_seqnum_len      (frer_seqnum_len),
      .frer_scr_sel_1       (frer_scr_sel_1),
      .frer_scr_sel_2       (frer_scr_sel_2),
      .frer_vec_win_sz      (frer_vec_win_sz),
      .frer_en_elim         (frer_en_elim),
      .frer_en_to           (frer_en_to),
      .frer_to_tog          (frer_to_tog),
      .frer_rogue_tog       (frer_rogue_tog),
      .frer_ooo_tog         (frer_ooo_tog),
      .frer_err_upd_tog     (frer_err_upd_tog),
      .frer_err_upd_val     (frer_err_upd_val)

      );


  generate if (p_edma_int_loopback) begin : gen_int_loopback
   gem_loop i_gem_loop (
      // control signals
      .n_ntxreset           (n_ntxreset),
      .n_tx_clk             (n_tx_clk),
      .loopback_local       (loopback_local),

      // external ethernet signals.
      .col_to_loop          (col_to_loop),
      .crs_to_loop          (crs_to_loop),
      .tx_er_from_loop      (tx_er_from_loop),
      .txd_from_loop        (txd_from_loop),
      .tx_en_from_loop      (tx_en_from_loop),
      .rxd_to_loop          ({rxd_par_gmii,rxd_gmii}),
      .rx_er_to_loop        (rx_er_gmii),
      .rx_dv_to_loop        (rx_dv_gmii),
      .ext_match1_to_loop   (ext_match1),
      .ext_match2_to_loop   (ext_match2),
      .ext_match3_to_loop   (ext_match3),
      .ext_match4_to_loop   (ext_match4),

      // internal ethernet signals.
      .col_from_loop        (col_from_loop),
      .crs_from_loop        (crs_from_loop),
      .tx_er_to_loop        (tx_er_to_loop),
      .txd_to_loop          (txd_to_loop),
      .tx_en_to_loop        (tx_en_to_loop),
      .rxd_from_loop        (rxd_from_loop),
      .rx_er_from_loop      (rx_er_from_loop),
      .rx_dv_from_loop      (rx_dv_from_loop),
      .ext_match1_from_loop (ext_match1_from_loop),
      .ext_match2_from_loop (ext_match2_from_loop),
      .ext_match3_from_loop (ext_match3_from_loop),
      .ext_match4_from_loop (ext_match4_from_loop)
   );
  end else begin  : gen_no_int_loopback
      assign col_from_loop        = col_to_loop;
      assign crs_from_loop        = crs_to_loop;
      assign tx_er_from_loop      = tx_er_to_loop;
      assign txd_from_loop        = txd_to_loop;
      assign tx_en_from_loop      = tx_en_to_loop;
      assign rxd_from_loop        = {rxd_par_gmii,rxd_gmii};
      assign rx_er_from_loop      = rx_er_gmii;
      assign rx_dv_from_loop      = rx_dv_gmii;
      assign ext_match1_from_loop = ext_match1;
      assign ext_match2_from_loop = ext_match2;
      assign ext_match3_from_loop = ext_match3;
      assign ext_match4_from_loop = ext_match4;
  end
  endgenerate

   // transmit signals for gmii interface.
   // tie tx gmii outputs to logic '0' when tbi is selected.
   // mac internal loopback mode has priority over tbi.
   assign tx_en_gmii             = tbi  ? 1'b0  : tx_en_from_loop;
   assign tx_er_gmii             = tbi  ? 1'b0  : tx_er_from_loop;
   assign txd_gmii               = tbi  ? 8'h00 : txd_from_loop[7:0];
   assign txd_par_gmii           = tbi  ? 1'b0  : txd_from_loop[8];

   // transmit signals for pcs interface.
   // tie pcs outputs to logic '0' when gmii is selected.
   assign tx_er_pcs   = ~tbi  ? 1'b0  : tx_er_from_loop;
   assign txd_pcs     = ~tbi  ? 8'h00 : txd_from_loop[7:0];
   assign txd_par_pcs = ~tbi  ? 1'b0  : txd_from_loop[8];
   assign tx_en_pcs   = ~tbi  ? 1'b0  : tx_en_from_loop;

   // collision and carrier sense signals for loopback module
   assign col_to_loop = tbi ? col_pcs : col;
   assign crs_to_loop = tbi ? crs_pcs : crs;


// -----------------------------------------------------------------------------
// Link Fault signalling
// -----------------------------------------------------------------------------
//  generate if (p_link_fault) begin : gen_link_fault



// -----------------------------------------------------------------------------
// ASF - End to end data path parity protection
// -----------------------------------------------------------------------------

  /////////////////////////////////////////////////
  // ASF - end to end parity check
  generate if (p_edma_asf_dap_prot == 1) begin : gen_dp_parity
    reg rxd_par_prev;
    always @ (posedge rx_clk or negedge n_rxreset)
    begin
      if (~n_rxreset)
        rxd_par_prev  <= 1'b0;
      else
        rxd_par_prev  <= rxd_from_loop[8];
    end

    // When in nibble mode, the parity is always set to parity of current and last nibble.
    // i.e. just exclusive or with previous nibble parity.
    // This assumes that in nibble mode, the parity is always on lower 4-bits.
    assign rxd_gmii_wp  = gigabit ? rxd_from_loop
                                  : rxd_from_loop ^ {rxd_par_prev, 8'h00};

    //  parity check from the loop
    cdnsdru_asf_parity_check_v1 #(.p_data_width(8)) i_gem_par_chk_dp_txd_to_loop (
      .odd_par(1'b0),
      .data_in(txd_to_loop[7:0]),
      .parity_in(txd_to_loop[8]),
      .parity_err(uncorr_err_dp_txd_to_loop)
        );

    // First parity check at the MAC TX output
    cdnsdru_asf_parity_check_v1 #(.p_data_width(8)) i_gem_par_chk_dp_txd_gmii (
      .odd_par(1'b0),
      .data_in(txd_gmii[7:0]),
      .parity_in(txd_par_gmii),
      .parity_err(uncorr_err_dp_txd_gmii)
    );

  end else begin : gen_no_dp_parity
    assign rxd_gmii_wp  = rxd_from_loop;
    assign uncorr_err_dp_txd_gmii     = 1'b0;
    assign uncorr_err_dp_txd_to_loop  = 1'b0;
  end
  endgenerate

  assign asf_dap_mac_tx_err = uncorr_err_dp_txd_gmii | uncorr_err_dp_txd_to_loop;

endmodule

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
//   Filename:           gem_tx_wrap.v
//   Module Name:        gem_tx_wrap
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
//   Description    : This module instantiate all MAC TX related modules:
//                    -   gem_tx
//                    -   edma_spram_tx_mac_buffer
//                    -   edma_gen_async_fifo
//                    -   gem_tx_fifo_if
//                    -   various miscellaneous modules
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_tx_wrap (

   // system signals.
   n_txreset,
   tx_clk,

   // Loopback clock.
   tsu_clk,
   n_tsureset,
   pclk,
   n_preset,
   hclk,
   n_hreset,

   // gmii/mii interface.
   txd,
   txd_par,
   tx_en,
   tx_er,
   rx_dv,
   col,
   crs,

   // top level ethernet signals.
   txd_frame_size,
   txd_rdy,
   tx_pause,
   tx_pause_zero,
   tx_pfc_sel,
   tx_pfc_pause,
   tx_pfc_pause_zero,

   // precision time protocol signals for IEEE 1588 support
   sof_tx,
   sync_frame_tx,
   delay_req_tx,
   pdelay_req_tx,
   pdelay_resp_tx,
   general_frame_tx,
   event_frame_tx,

   // signals coming from gem_reg_top (gem_registers).
   full_duplex,
   bit_rate,
   gigabit,
   two_pt_five_gig,
   tx_byte_mode,
   dma_bus_width,
   enable_transmit,
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
   spec_add1,
   spec_add1_par,
   spec_add1_active,
   tx_status_wr_tog,
   tx_pause_tog_ack,
   ptp_unicast_ena,
   tx_ptp_unicast,
   rx_fill_level_low,
   rx_fill_level_high,
   halfduplex_fc_en,
   back_pressure,
   stretch_enable,
   stretch_ratio,
   min_ifg,
   tsu_ptp_tx_timer_out,
   tsu_ptp_tx_timer_par_out,
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
   tx_r_par,
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

   // status signals going to gem_dma_top (or external tx fifo interface).
   late_coll_occured,
   too_many_retries,
   underflow_frame,
   collision_occured,

   tx_r_timestamp,
   tx_r_timestamp_par,

   // signals coming from gem_dma_top (or external tx fifo interface).
   dma_tx_status_tog,

   // signals going to gem_dma_top (or ext tx fifo i/f)(via gem_hclk_syncs)
   dma_tx_end_tog,

   // signals going to the gem_reg_top (gem_pclk_syncs) for
   // statistics register recording.
   tx_end_tog,
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

   soft_config_fifo_en,

   // signals coming from the rx block.
   new_pause_time,
   new_pause_tog,

   // EnST signals
   enst_en,
   start_time,
   on_time,
   off_time,
   add_frag_size,
   hold,

   tx_r_sop_lockup,
   tx_r_eop_lockup,
   tx_r_valid_lockup,

   asf_integrity_tx_sched_err,

   block_sram_ecc_check

);

   parameter [1363:0] grouped_params = {1364{1'b0}};
  `include "ungroup_params.v"

   // system signals.
   input         n_txreset;               // reset synchronized to tx_clk.
   input         tx_clk;                  // 2.5MHz, 25MHz or 125MHz transmit
                                          // clock.

   // Loopback clock
   input         tsu_clk;                 // TSU clock
   input         n_tsureset;              // TSU reset
   input         pclk;                    // APB clock
   input         n_preset;                // APB reset
   input         hclk;                    // AHB clock.
   input         n_hreset;                // AHB reset.

   // ethernet signals.
   output  [7:0] txd;                     // 0-7 bits transmit data to the PHY.
   output        txd_par;                 // parity for txd_gmii
   output        tx_en;                   // transmit enable signal to the PHY.
   output        tx_er;                   // transmit error signal to the PHY.
   input         rx_dv;                   // Data Valid for 10/100 mode
   input         col;                     // collision detect signal from the
                                          // PHY.
   input         crs;                     // carrier sense signal from the PHY.

   // top level ethernet signals.
   output [13:0] txd_frame_size;          // Frame Size in Bytes ..
   input         txd_rdy;                 // TXD ready ..
   input         tx_pause;                // toggling this input causes a
                                          // 802.3 or PFC
                                          // pause frame to be transmitted with
                                          // the pause quantum value taken from
                                          // the transmit pause quantum
                                          // register.
   input         tx_pause_zero;           // state of this signal is captured
                                          // on each toggle of tx_pause and
                                          // used to determine if a zero length
                                          // pause frame is to be transmitted.
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


   // precision time protocol signals for IEEE 1588 support
   output        sof_tx;                  // asserted on SFD deasserted at EOF
   output        sync_frame_tx;           // asserted if PTP sync frame
   output        delay_req_tx;            // asserted if PTP delay_req
   output        pdelay_req_tx;           // asserted if PTP pdelay_req
   output        pdelay_resp_tx;          // asserted if PTP pdelay_resp
   output        general_frame_tx;        // asserted if PTP general frame
   output        event_frame_tx;          // asserted if PTP event frame

   // signals coming from gem_reg_top (gem_registers).
   input         ptp_unicast_ena;         // enable PTPv2 IPv4 unicast IP DA
                                          // detection
   input  [31:0] tx_ptp_unicast;          // tx PTPv2 IPv4 unicast IP DA
   input         rx_fill_level_low;       // watermark for transmitting zero pause frame
   input         rx_fill_level_high;      // watermark for transmitting non-zero pause frame
   input         full_duplex;             // duplex signal from the network
                                          // configuration register.
   input         bit_rate;                // 10/100 operation
   input         gigabit;                 // high for gigabit operation.
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
   input  [47:0] spec_add1;               // specific address 1 used for
                                          // transmission of pause frames.
   input  [5:0]  spec_add1_par;           // Optional parity
   input         spec_add1_active;        // spec_add1 can be used for
                                          // destination address comparison.
   input         tx_status_wr_tog;        // toggle handshake for status write
                                          // back to register block.
   input         tx_pause_tog_ack;        // handshake of tx_pause_time_tog
                                          // back to register block.
   input         back_pressure;           // goes to tx block to force
                                          // collisions on all incoming frames
   input         halfduplex_fc_en;        // Enables above back_pressure mech


   // Scheduler Signals
   input  [31:0] idleslope_q_a;           // Rate of Change of credit for Queue A
   input  [1:0]  cbs_enable;              // Enable for CBS queues
   input  [3:0]  cbs_q_a_id;
   input  [3:0]  cbs_q_b_id;
   input  [31:0] idleslope_q_b;           // Rate of Change of credit for Queue B
   input  [31:0] port_tx_rate;            // TX Rate
   input  [31:0] dwrr_ets_control;
   input  [127:0]bw_rate_limit;

   input         stretch_enable;          // enables IPG stretching
   input  [15:0] stretch_ratio;           // determines how to stretch the IPG
   input   [3:0] min_ifg;                 // minimum transmit IFG divided by four

   // pclk timed output to gem_registers ...
   output [77:0] tsu_ptp_tx_timer_out;    // Sampled timestamp to gem-registers
   // RAS - Timestamp parity protection
   output [9:0] tsu_ptp_tx_timer_par_out; // parity protection for tsu_ptp_tx_timer_out

   // tsu_clk domain inputs
   input [93:16] tsu_timer_cnt;           // TSU timer count value
   input [11:2]  tsu_timer_cnt_par;

   // pclk domain
   input         one_step_sync_mode;      // enable ts insertion into sync frames
   input         oss_correction_field;    // enable update of correction field in sync frames


   // signals coming from gem_dma_top (or external tx fifo interface).
   input [127:0] tx_r_data;               // output data from the transmit fifo
                                          // to the tx module.
   input  [15:0] tx_r_par;                // 16 bits parity for tx_r_data
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
   // RAS - Timestamp parity protection
   output [9:0]  tx_r_timestamp_par;      // parity protection for tx_r_timestamp

   // signals coming from gem_dma_top (or external tx fifo interface)
   input         dma_tx_status_tog;       // when toggled, indicates transmit
                                          // status written by dma.

   // signals going to gem_dma_top (or ext tx fifo i/f)(via gem_hclk_syncs)
   output        dma_tx_end_tog;          // toggled at the end of frame
                                          // transmission, cleared when
                                          // dma_tx_status_tog is returned.

   // signals going to the gem_reg_top (gem_pclk_syncs).
   // for statistics register recording.
   output        tx_end_tog;              // toggled at the end of frame
                                          // transmission (used for handshake
                                          // of statistics), cleared when
                                          // tx_status_wr_tog is returned.
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

   input         soft_config_fifo_en;     // use ext fifo port

   // signals coming from the rx block.
   input [15:0]  new_pause_time;          // value of decoded new pause time.
   input         new_pause_tog;           // indicates that tx should pause.

   // EnST signals
   input  [7:0]    enst_en;               // Disable/Enable Vector
   input  [255:0]  start_time;            // start_time of the transmission
   input  [135:0]  on_time;               // Number of bytes to transmit during on_time
   input  [135:0]  off_time;              // off time of the transmission expressed in bytes
   input  [1:0]    add_frag_size;         // Encoded value of the number of bytes that pMAC
                                          // can xmit before giving priority to the eMAC
   output [p_edma_queues-1:0] hold;       // 802.3br support signal

   output         tx_r_sop_lockup;        // SOP from FIFO i/f for lockup detection
   output         tx_r_eop_lockup;        // EOP
   output         tx_r_valid_lockup;

   output asf_integrity_tx_sched_err;     // ASF Integrity check error in Transmit Scheduling

   output         block_sram_ecc_check;   // For SPRAN configs edma_spram_tx_mac_buffer may generate a redundant
                                          // read from an unitialised memory location. This signal prevents an
                                          // error being reported if SRAM parity protection is enabled

   // reg and wire declarations.
   wire          mac_txing_dma_frame;
   wire          underflow_frame_mac;
   wire          too_many_retries_mac;
   wire          late_coll_occured_mac;
   wire          collision_occured_mac;
                                          // with last 16 bits parity tx_r_data_mac
                                          // to the tx module.
   wire    [3:0] tx_r_mod_mac;            // tx number of valid bytes in last
                                          // transfer of the frame.
                                          // 0000 - tx_r_data[7:0] valid,
                                          // 0001 - tx_r_data[15:0] valid, until
                                          // 1111 - tx_r_data[127:0] valid.
   wire          tx_r_sop_mac;            // tx start of packet indicator.
   wire          tx_r_eop_mac;            // tx end of packet indicator.
   wire          tx_r_err_mac;            // tx packet in error indicator.
   wire          tx_r_valid_mac;          // new tx data available from fifo.
   wire          tx_r_data_rdy_mac;       // indicates either a complete packet
                                          // is present in the fifo or a certain
                                          // threshold of data has been crossed,
                                          // the mac uses this wire  to trigger
                                          // a frame transfer.
   wire          tx_r_underflow_mac;      // signals tx fifo underrun condition.
   wire          tx_r_flushed_mac;        // tx fifo flushed status, not used.
   wire          tx_r_control_mac;        // packet control information

   wire          dma_tx_end_tog_mac;
   wire          dma_tx_status_tog_mac;

   // signals from gem_rx to gem_tx.
   wire   [15:0] new_pause_time;          // value of decoded new pause time.
   wire          new_pause_tog;           // indicates a new pause time rxed.

   wire  [127:0] tx_r_data_mac;           // output data from the transmit fifo
                                          // with last 16 bits parity tx_r_data_mac
                                          // to the tx module.
   wire  [15:0]  tx_r_par_mac;            // 16 bits parity for tx_r_data_mac

   wire          tx_r_rd_mac;             // request new data from fifo.
   wire          tx_r_rd_int_mac;         // early version of tx_r_rd
   wire          tx_r_rd_spram;           // request new data from fifo.
   wire          tx_r_rd_int_spram;       // early version of tx_r_rd
   wire          tx_r_data_rdy_sched;     // thee rdy signal from the scheduler back to the MAC

   wire [(p_edma_queues*14)-1:0] tx_r_frame_size_sched;     // Frame Length
   wire [13:0]   tx_r_frame_size_mac;     // Frame Length


   wire           general_frame_tx_int;   // asserted if PTP general frame
   wire [p_edma_queues-1:0] tsu_hold;     // hold signal coming from the EnST module, tsu_clk sync-ed

   wire           en_transmit_sync;

// -----------------------------------------------------------------------------
//  Beginning of main code.
// -----------------------------------------------------------------------------

  // Mux the frame length into a single bus based on current scheduled queue ..
  wire  [13:0] tx_r_frame_size_arr [15:0]; // Handy array to de-serialise the incoming signal
  genvar g;
  generate for (g=0; g<16; g=g+1) begin : gen_frame_size_array
    if (g < p_edma_queues[4:0]) begin : gen_active_queue
      assign tx_r_frame_size_arr[g] = tx_r_frame_size_sched[14*g+13:14*g];
    end else begin : gen_inactive_queue
      assign tx_r_frame_size_arr[g] = 14'd0;
    end
  end
  endgenerate

  wire [13:0] tx_r_frame_size_edma;
  assign tx_r_frame_size_edma = tx_r_frame_size_arr[tx_r_queue];

   // synchronise enable_transmit and ptp unicast from the network
   // control register to tx_clk.
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_enable_transmit (
      .clk(tx_clk),
      .reset_n(n_txreset),
      .din(enable_transmit),
      .dout(en_transmit_sync));


   gem_tx #(
     .grouped_params(grouped_params)
   ) i_gem_tx (

      // system signals.
      .n_txreset            (n_txreset),
      .tx_clk               (tx_clk),
      .tsu_clk              (tsu_clk),
      .n_tsureset           (n_tsureset),
      .pclk                 (pclk),
      .n_preset             (n_preset),

      // gmii/mii interface.
      .txd                  (txd),
      .txd_par              (txd_par),
      .tx_en                (tx_en),
      .tx_er                (tx_er),
      .col                  (col),
      .crs                  (crs),
      .rx_dv                (rx_dv),

      // top level ethernet signals.
      .txd_frame_size       (txd_frame_size),
      .txd_rdy              (txd_rdy),
      .tx_pause             (tx_pause),
      .tx_pause_zero        (tx_pause_zero),
      .tx_pfc_sel           (tx_pfc_sel),
      .tx_pfc_pause         (tx_pfc_pause),
      .tx_pfc_pause_zero    (tx_pfc_pause_zero),

      // precision time protocol signals for IEEE 1588 support
      .sof_tx               (sof_tx),
      .sync_frame_tx        (sync_frame_tx),
      .delay_req_tx         (delay_req_tx),
      .pdelay_req_tx        (pdelay_req_tx),
      .pdelay_resp_tx       (pdelay_resp_tx),
      .general_frame_tx     (general_frame_tx_int),

      // signals coming from gem_reg_top (gem_registers).
      .halfduplex_fc_en     (halfduplex_fc_en),
      .back_pressure        (back_pressure),
      .bit_rate             (bit_rate),
      .full_duplex          (full_duplex),
      .gigabit              (gigabit),
      .tx_byte_mode         (tx_byte_mode),
      .dma_bus_width        (dma_bus_width),
      .en_transmit_sync     (en_transmit_sync),
      .pause_enable         (pause_enable),
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
      .tw_sys_tx_time       (tw_sys_tx_time),
      .spec_add1            (spec_add1),
      .spec_add1_par        (spec_add1_par),
      .spec_add1_active     (spec_add1_active),
      .tx_status_wr_tog     (tx_status_wr_tog),
      .tx_pause_tog_ack     (tx_pause_tog_ack),
      .stretch_enable       (stretch_enable),
      .stretch_ratio        (stretch_ratio),
      .min_ifg              (min_ifg),

      .ptp_unicast_ena      (ptp_unicast_ena),
      .tx_ptp_unicast       (tx_ptp_unicast),
      .rx_fill_level_low    (rx_fill_level_low),
      .rx_fill_level_high   (rx_fill_level_high),

      // signals coming from gem_dma_top (or external tx fifo interface).
      .tx_r_data            (tx_r_data_mac),
      .tx_r_par             (tx_r_par_mac),
      .tx_r_mod             (tx_r_mod_mac),
      .tx_r_sop             (tx_r_sop_mac),
      .tx_r_eop             (tx_r_eop_mac),
      .tx_r_err             (tx_r_err_mac),
      .tx_r_valid           (tx_r_valid_mac),
      .tx_r_data_rdy        (tx_r_data_rdy_mac),
      .tx_r_underflow       (tx_r_underflow_mac),
      .tx_r_flushed         (tx_r_flushed_mac),
      .tx_r_control         (tx_r_control_mac),
      .tx_r_frame_size      (tx_r_frame_size_mac),

      // signals going to gem_dma_top (or external tx fifo interface).
      .tx_r_rd              (tx_r_rd_mac),
      .tx_r_rd_int          (tx_r_rd_int_mac),

      // signals coming from gem_dma_top.
      .dma_tx_status_tog    (dma_tx_status_tog_mac),

      // signals going to gem_dma_top (gem_hclk_syncs).
      .dma_tx_end_tog       (dma_tx_end_tog_mac),
      .collision_occured    (collision_occured_mac),

      // signals going to gem_dma_top.
      .late_coll_occured    (late_coll_occured_mac),
      .too_many_retries     (too_many_retries_mac),
      .underflow_frame      (underflow_frame_mac),
      .tx_r_timestamp       (tx_r_timestamp),
      .tx_r_timestamp_par  (tx_r_timestamp_par),

      // signals going to gem_reg_top (gem_pclk_syncs).
      .tx_end_tog           (tx_end_tog),
      .tx_coll_occured      (tx_coll_occured),
      .tx_frame_txed_ok     (tx_frame_txed_ok),
      .tx_broadcast_frame   (tx_broadcast_frame),
      .tx_multicast_frame   (tx_multicast_frame),
      .tx_single_coll_frame (tx_single_coll_frame),
      .tx_multi_coll_frame  (tx_multi_coll_frame),
      .tx_deferred_tx_frame (tx_deferred_tx_frame),
      .tx_late_coll_frame   (tx_late_coll_frame),
      .tx_crs_error_frame   (tx_crs_error_frame),
      .tx_bytes_in_frame    (tx_bytes_in_frame),
      .tx_too_many_retries  (tx_too_many_retries),
      .tx_underflow_frame   (tx_underflow_frame),
      .tx_pause_frame_txed  (tx_pause_frame_txed),
      .tx_pfc_pause_frame_txed (tx_pfc_pause_frame_txed),
      .tx_pause_time        (tx_pause_time),
      .tx_pause_time_tog    (tx_pause_time_tog),

      .tsu_ptp_tx_timer_out (tsu_ptp_tx_timer_out),
      // RAS - Timestamp parity protection
      .tsu_ptp_tx_timer_par_out (tsu_ptp_tx_timer_par_out),
      .tsu_timer_cnt        (tsu_timer_cnt[93:16]),
      .tsu_timer_cnt_par    (tsu_timer_cnt_par[11:2]),
      .one_step_sync_mode   (one_step_sync_mode),
      .oss_correction_field (oss_correction_field),

      .soft_config_fifo_en  (soft_config_fifo_en),

      // Signal used to decrement CBS
      .mac_txing_dma_frame  (mac_txing_dma_frame),

      // signals coming from gem_mac (gem_rx).
      .new_pause_time       (new_pause_time),
      .new_pause_tog        (new_pause_tog)

   );



   // -----------------------------------------------------------------------
   //
   //                      SPRAM Specific
   //
   // -----------------------------------------------------------------------



  generate if (p_edma_spram == 1'b1) begin :gen_spram_mac_buff
    wire   [p_emac_parity_width+p_emac_bus_width-1:0] tx_r_data_edma,tx_r_data_sp_mac;
    wire                                              tx_r_flush_mac_request;
    wire                                              collision_occured_rise_edge;
    if(p_edma_asf_dap_prot == 1'b0) begin : gen_no_parity
      assign tx_r_data_edma                       = tx_r_data[p_emac_bus_width-1:0];
      assign tx_r_data_mac[p_emac_bus_width-1:0]  = tx_r_data_sp_mac[p_emac_bus_width-1:0];
      assign tx_r_par_mac[p_emac_bus_pwid-1:0]    = {p_emac_bus_pwid{1'b0}};
    end else begin : gen_parity
      assign tx_r_data_edma                       = {tx_r_par[p_emac_bus_pwid-1:0], tx_r_data[p_emac_bus_width-1:0]};
      assign tx_r_data_mac[p_emac_bus_width-1:0]  = tx_r_data_sp_mac[p_emac_bus_width-1:0];
      assign tx_r_par_mac[p_emac_bus_pwid-1:0]    = tx_r_data_sp_mac[p_emac_bus_pwid+p_emac_bus_width-1:p_emac_bus_width];
    end
    if (p_emac_bus_width < 32'd128) begin : gen_pad_tx_r_data
      assign tx_r_data_mac[127:p_emac_bus_width]  = {(128-p_emac_bus_width){1'b0}};
      assign tx_r_par_mac[15:p_emac_bus_pwid]     = {(16-p_emac_bus_pwid){1'b0}};
    end

  edma_spram_tx_mac_buffer # (

      .p_emac_bus_width   (p_emac_bus_width),
      .p_emac_parity_width(p_emac_parity_width),
      .DATA_W             (p_emac_bus_width),
      .DATA_W_PAR         (p_emac_parity_width),
      `ifdef xgm
      .FIFO_ADDR_W(32'd4),
      `else
      .FIFO_ADDR_W(32'd2),
      `endif
      .p_edma_asf_dap_prot(p_edma_asf_dap_prot)

   ) i_edma_spram_tx_mac_buffer (

      // eDMA TX WR Interface
      .clk_edma            (hclk),
      .rst_edma_n          (n_hreset),
      .tx_r_rd_edma        (tx_r_rd_spram),
      .tx_r_rd_int_edma    (tx_r_rd_int_spram),
      .tx_r_valid_edma     (tx_r_valid),
      .tx_r_data_edma      (tx_r_data_edma),
      .tx_r_eop_edma       (tx_r_eop),
      .tx_r_sop_edma       (tx_r_sop),
      .tx_r_mod_edma       (tx_r_mod),
      .tx_r_err_edma       (tx_r_err),
      .tx_r_flushed_edma   (tx_r_flushed),
      .tx_r_underflow_edma (tx_r_underflow),
      .tx_r_data_rdy_edma  (tx_r_data_rdy_sched),
      .tx_r_control_edma   (tx_r_control),
      .tx_r_frame_size_edma(tx_r_frame_size_edma),

      // TX MAC Interface
      .clk_mac               (tx_clk),
      .rst_mac_n             (n_txreset),
      .tx_r_rd_mac           (tx_r_rd_mac),
      .tx_r_valid_mac        (tx_r_valid_mac),
      .tx_r_data_mac         (tx_r_data_sp_mac),
      .tx_r_eop_mac          (tx_r_eop_mac),
      .tx_r_sop_mac          (tx_r_sop_mac),
      .tx_r_mod_mac          (tx_r_mod_mac),
      .tx_r_err_mac          (tx_r_err_mac),
      .tx_r_flushed_mac      (tx_r_flushed_mac),
      .tx_r_underflow_mac    (tx_r_underflow_mac),
      .tx_r_data_rdy_mac     (tx_r_data_rdy_mac),
      .tx_r_control_mac      (tx_r_control_mac),
      .tx_r_frame_size_mac   (tx_r_frame_size_mac),
      .tx_r_flush_mac_request(tx_r_flush_mac_request),

      .block_sram_ecc_check  (block_sram_ecc_check)
    );


   // Re-sync the one-shot collision occurred pulse accross to the hclk domain
   edma_toggle_detect i_edma_toggle_detect_collision_occurred(
     .clk      (tx_clk),
     .reset_n  (n_txreset),
     .din      (collision_occured_mac),
     .rise_edge(collision_occured_rise_edge),
     .fall_edge(),
     .any_edge ()
   );
   edma_gear_change_async i_edma_gear_change_async_collision_occurred (
     .clk_src   (tx_clk),
     .rst_src_n (n_txreset),
     .src       (collision_occured_rise_edge),
     .clk_dest  (hclk),
     .rst_dest_n(n_hreset),
     .dest      (collision_occured)
    );


   // Wait until the tx_rd side has seen the flush request before starting to
   // flush the mac buffer.
   edma_gear_change_async #(
    .OVERFLOW_PROTECTION(1'b1)
   ) i_edma_gear_change_async_tx_r_mac_flush_request (
     .clk_src   (hclk),
     .rst_src_n (n_hreset),
     .src       (tx_r_flushed),
     .clk_dest  (tx_clk),
     .rst_dest_n(n_txreset),
     .dest      (tx_r_flush_mac_request)
   );


   // Synchronising the dma_tx_end_tog signal from the mac clock to the hclk domain is
   // quite uniquie in that we have to guarantee the synchronised version aligns with
   // any too_many_retries/late_coll_occured/underflow_frame signal. The signals are
   // generated together at source so we have to ensure they arrive together at
   // destination. We cannot pass the signals directly through a synchroniser to do this,
   // so we put them through an asynchronous FIFO to ensure they come out aligned.

   // Generate a one-shot pulse when any of the dma_tx_end_tog signals toggle. These signals
   // are then used to push the data (too_many_retries/late_coll_occured/underflow_frame)
   // into the FIFO.
   wire       dma_tx_end_pulse;
   wire [3:0] dma_tx_end_stat;
   wire       dma_tx_end_tog_edge;

   edma_toggle_detect i_edma_toggle_detect_dma_tx_end_tog (
     .clk      (tx_clk),
     .reset_n  (n_txreset),
     .din      (dma_tx_end_tog_mac),
     .rise_edge(),
     .fall_edge(),
     .any_edge (dma_tx_end_tog_edge)
   );
   `ifdef xgm
   wire dma_tx_small_end_tog_mac; // XGM specific assign required.
   edma_toggle_detect i_edma_toggle_detect_dma_tx_small_end_tog (
     .clk      (tx_clk),
     .reset_n  (n_txreset),
     .din      (dma_tx_small_end_tog_mac),
     .rise_edge(),
     .fall_edge(),
     .any_edge (dma_tx_small_end_tog_edge)
   );

   // The underflow mechanism works slightly different in xgm, so we do a
   // toggle detect on the underflow frame pulse - in xgm it toggles at an
   // underflow.
   edma_toggle_detect i_edma_toggle_detect_underflow_frame (
     .clk(tx_clk),
     .reset_n(n_txreset),
     .din(underflow_frame_mac),
     .rise_edge(),
     .fall_edge(),
     .any_edge(underflow_frame_edge)
   );
   assign dma_tx_end_pulse  = dma_tx_end_tog_edge|dma_tx_small_end_tog_edge|underflow_frame_edge;
   assign dma_tx_end_stat   = {dma_tx_end_tog_edge,late_coll_occured_mac,too_many_retries_mac,underflow_frame_edge};
   `else
   assign dma_tx_end_pulse  = dma_tx_end_tog_edge;
   assign dma_tx_end_stat   = {dma_tx_end_tog_edge,late_coll_occured_mac,too_many_retries_mac,underflow_frame_mac};
   `endif

   wire [3:0] popd;
   wire       popd_val;
   gem_bus_sync #(.p_dwidth(4), .p_reg_out(0)) i_bus_sync_dma_tx_end_stat (
    .src_clk      (tx_clk),
    .src_rst_n    (n_txreset),
    .dest_clk     (hclk),
    .dest_rst_n   (n_hreset),
    .src_data     (dma_tx_end_stat),
    .src_xfer_en  (dma_tx_end_pulse),
    .src_data_last(),
    .src_rdy      (),
    .dest_data    (popd),
    .dest_val     (popd_val)
   );

   // We want to hold the too_many_retries/late_coll_occured/underflow_frame signals stead for the duration
   // of the frame so we register them coming out the fifo when the fifo has data, and hold them steady
   // until the flush. They have to be held steady for the stats update.
   reg late_coll_occured_sync_r,too_many_retries_sync_r,underflow_frame_sync_r;

   always @(posedge hclk or negedge n_hreset)
      if (!n_hreset)
         {late_coll_occured_sync_r,too_many_retries_sync_r,underflow_frame_sync_r} <= 3'd0;
      else if (popd_val)
         {late_coll_occured_sync_r,too_many_retries_sync_r,underflow_frame_sync_r} <= popd[2:0];
      else if (tx_r_flushed)
         {late_coll_occured_sync_r,too_many_retries_sync_r,underflow_frame_sync_r} <= 3'd0;

   assign {late_coll_occured,too_many_retries,underflow_frame} = {late_coll_occured_sync_r,too_many_retries_sync_r,underflow_frame_sync_r};

   // What comes out of the aysnc FIFO will be a one shot pulse for the end tog signals, so we
   // need to "re-toggle" them
   // Note that the output of this toggle generator is registered to ensure that the DMA is signalled after the above is presented.
   edma_toggle_generate # (
      .DIN_W(1), .MODE_EARLY(1'b0)
   ) i_edma_toggle_generate (
     .clk(hclk),
     .reset_n(n_hreset),
     .din(popd_val & popd[3]),
     .dout(dma_tx_end_tog)
   );

   // sync dma_tx_status_tog into the mac clock domain
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_dma_tx_status_tog (
      .clk(tx_clk),.reset_n(n_txreset),.din(dma_tx_status_tog),.dout(dma_tx_status_tog_mac));


   // pass event_frame and general_frame fro tx_clk to hclk domain
   wire   event_frame_tx_int;
   assign event_frame_tx_int   = sync_frame_tx | delay_req_tx | pdelay_req_tx | pdelay_resp_tx;
   gem_bus_sync #(.p_dwidth(2), .p_reg_out(1)) i_bus_sync_frame_tx (
    .src_clk      (tx_clk),
    .src_rst_n    (n_txreset),
    .dest_clk     (hclk),
    .dest_rst_n   (n_hreset),
    .src_data     ({event_frame_tx_int,
                    general_frame_tx_int}),
    .src_xfer_en  (1'b1),
    .src_data_last(),
    .src_rdy      (),
    .dest_data    ({event_frame_tx,
                    general_frame_tx}),
    .dest_val     ()
   );

  end
  else
  begin :gen_no_spram
    assign event_frame_tx         = sync_frame_tx | delay_req_tx | pdelay_req_tx | pdelay_resp_tx;
    assign general_frame_tx       = general_frame_tx_int;
    assign tx_r_rd_int_spram      = tx_r_rd_int_mac;
    assign tx_r_rd_spram          = tx_r_rd_mac && (p_edma_tx_pkt_buffer == 0 && p_edma_ext_fifo_interface == 0); // Only used in DMA legacy mode
    assign dma_tx_end_tog         = dma_tx_end_tog_mac;
    assign dma_tx_status_tog_mac  = dma_tx_status_tog;
    assign collision_occured      = collision_occured_mac;
    assign late_coll_occured      = late_coll_occured_mac;
    assign too_many_retries       = too_many_retries_mac;
    assign underflow_frame        = underflow_frame_mac;
    assign tx_r_valid_mac         = tx_r_valid;
    assign tx_r_data_mac          = tx_r_data;
    assign tx_r_par_mac           = tx_r_par;
    assign tx_r_eop_mac           = tx_r_eop;
    assign tx_r_sop_mac           = tx_r_sop;
    assign tx_r_mod_mac           = tx_r_mod;
    assign tx_r_err_mac           = tx_r_err;
    assign tx_r_flushed_mac       = tx_r_flushed;
    assign tx_r_underflow_mac     = tx_r_underflow;
    assign tx_r_data_rdy_mac      = tx_r_data_rdy_sched;
    assign tx_r_control_mac       = tx_r_control;
    assign tx_r_frame_size_mac    = tx_r_frame_size_edma;
    assign block_sram_ecc_check   = 1'b0;
  end
  endgenerate

  // Lockup detection feedback
  assign tx_r_sop_lockup    = tx_r_sop_mac;
  assign tx_r_eop_lockup    = tx_r_eop_mac;
  assign tx_r_valid_lockup  = tx_r_valid_mac;

   // instance the TX FIFO interface if packet buffer or fifo interface. This will do
   // the scheduling
   generate if (p_edma_tx_pkt_buffer == 1 || p_edma_ext_fifo_interface == 1) begin : gen_tx_fifo_interface
     wire sched_clk;
     wire sched_rst_n;
     wire mac_txing_dma_frame_s;   // Optionally sync'd version for spram operation
     wire any_ets_en;
     wire ets_upd_tog;
     wire en_transmit_sync_sched;  // sync'd version for spram operation

     // We need to synchronize the tsu_hold signal to tx_clk now
     cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tsu_hold [p_edma_queues-1:0] (
       .clk    (tx_clk),
       .reset_n(n_txreset),
       .din    (tsu_hold),
       .dout   (hold)
     );

     if (p_edma_spram == 1) begin :gen_set_sched_clk_hclk
       assign sched_clk   = hclk;
       assign sched_rst_n = n_hreset;
       cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_txing_dma (
        .clk    (sched_clk),
        .reset_n(sched_rst_n),
        .din    (mac_txing_dma_frame),
        .dout   (mac_txing_dma_frame_s));

       cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_enable_transmit (
        .clk    (sched_clk),
        .reset_n(sched_rst_n),
        .din    (enable_transmit),
        .dout   (en_transmit_sync_sched));

     end else begin : gen_set_sched_clk_tx_clk
       assign sched_clk              = tx_clk;
       assign sched_rst_n            = n_txreset;
       assign mac_txing_dma_frame_s  = mac_txing_dma_frame;
       assign en_transmit_sync_sched = en_transmit_sync;
     end

      edma_tx_sched_ets_count i_ets_count (
        .tx_clk      (tx_clk),
        .tx_rst_n    (n_txreset),
        .any_ets_en  (any_ets_en),
        .tx_enable   (en_transmit_sync),
        .gigabit     (gigabit),
        .ets_upd_tog (ets_upd_tog)
      );

      gem_tx_fifo_if #(.p_edma_exclude_cbs      (p_edma_exclude_cbs),
                       .p_edma_exclude_qbv      (p_edma_exclude_qbv),
                       .p_edma_spram            (p_edma_spram),
                       .p_edma_queues           (p_edma_queues),
                       .p_edma_tsu              (p_edma_tsu),
                       .p_edma_asf_prot_tx_sched(p_edma_asf_prot_tx_sched)
                      ) i_gem_tx_fifo_if (

         .tx_r_clk             (sched_clk),
         .tx_r_rst_n           (sched_rst_n),

         .tx_clk               (tx_clk),
         .n_txreset            (n_txreset),

         .tx_r_rd_int          (tx_r_rd_int_spram),
         .tx_r_data_rdy_dma    (tx_r_data_rdy),
         .tx_r_frame_size_vld  (tx_r_frame_size_vld),
         .tx_r_frame_size      (tx_r_frame_size),
         .tx_r_launch_time_vld (tx_r_launch_time_vld),
         .tx_r_launch_time     (tx_r_launch_time),
         .tx_r_err             ((tx_r_valid & tx_r_err) | tx_r_underflow | tx_r_flushed),
         .tx_r_eop             (tx_r_eop),
         .tx_r_valid           (tx_r_valid),
         .dma_is_busy          (dma_is_busy),

         .tx_r_data_rdy_mac    (tx_r_data_rdy_sched),
         .tx_r_frame_size_mac  (tx_r_frame_size_sched),
         .tx_r_rd_int_dma      (tx_r_rd_int),
         .tx_r_rd_dma          (tx_r_rd),
         .tx_r_queue_int       (tx_r_queue_int),
         .tx_r_queue           (tx_r_queue),

         .tx_enable            (en_transmit_sync_sched),
         .cbs_enable           (cbs_enable),
         .cbs_q_a_id           (cbs_q_a_id),
         .cbs_q_b_id           (cbs_q_b_id),
         .gigabit              (gigabit),
         .bit_rate             (bit_rate),
         .two_pt_five_gig      (two_pt_five_gig),
         .idleslope_q_a        (idleslope_q_a),
         .idleslope_q_b        (idleslope_q_b),
         .port_tx_rate         (port_tx_rate),
         .mac_txing_dma_frame  (mac_txing_dma_frame_s),
         .dwrr_ets_control     (dwrr_ets_control),
         .bw_rate_limit        (bw_rate_limit),
         .tsu_clk              (tsu_clk),
         .n_tsureset           (n_tsureset),
         .enst_en              (enst_en),
         .tsu_timer_cnt        (tsu_timer_cnt[93:16]),
         .start_time           (start_time),
         .on_time              (on_time),
         .off_time             (off_time),
         .add_frag_size        (add_frag_size),
         .ets_upd_tog          (ets_upd_tog),
         .any_ets_en           (any_ets_en),
         .tsu_hold             (tsu_hold),
         .asf_integrity_tx_sched_err
                               (asf_integrity_tx_sched_err)
    );
   end else begin : gen_no_tx_fifo_interface

     assign tx_r_data_rdy_sched        = tx_r_data_rdy[0];
     assign tx_r_rd_int[0]             = tx_r_rd_int_spram;
     assign tx_r_rd[0]                 = tx_r_rd_spram;
     assign tx_r_queue                 = 4'h0;
     assign tx_r_queue_int             = 4'h0;
     assign tsu_hold                   = {p_edma_queues{1'b0}};
     assign hold                       = {p_edma_queues{1'b0}};
     assign tx_r_frame_size_sched      = {p_edma_queues*14{1'b0}};
     assign asf_integrity_tx_sched_err = 1'b0;
   end
   endgenerate

endmodule

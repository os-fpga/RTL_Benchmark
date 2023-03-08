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
//   Filename:           gem_tx.v
//   Module Name:        gem_tx
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
//   Description :             This module implements ethernet medium access
//                             control protocol for transmission in either full
//                             or half duplex.
//
//                             Transmit data (tx_r_data) is supplied from the
//                             fifo interface. tx_frame_ready is asserted to
//                             indicate the fifo has sufficient data for the
//                             transmission to commence.
//
//                             gem_tx signals to the transmit fifo when it needs
//                             a new word (tx_r_rd) and the tx_fifo returns the
//                             tx data with a valid qualifier (tx_r_valid).
//                             upon completion of the frame the mac generates
//                             status information and asserts tx_end_frame.
//                             this causes the dma to write back status
//                             information to the tx buffer descriptor.
//
//                             The tx fifo may contain up to two frames, thus
//                             allowing gigabit bursting in half duplex mode.
//
//                             In full duplex mode, both the collision and crs
//                             inputs are ignored.
//                             When operating in half duplex mode, collisions
//                             detected by the gem_tx block trigger a jam
//                             sequence followed by backoff.
//
//                             Depending on the data rate, late collisions
//                             either force a transmit retry (10/100) or cause
//                             the transmission to halt (gigabit) with status
//                             being written back to the tx descriptor.
//
//                             Collision retries are counted by the gem_tx, and
//                             when the retry limit of sixteen is reached,
//                             transmission is ended.
//
//
//------------------------------------------------------------------------------


module gem_tx (

   // system signals.
   n_txreset,
   tx_clk,
   n_tsureset,
   tsu_clk,
   n_preset,
   pclk,

   // gmii/mii interface.
   txd,
   txd_par,
   tx_en,
   tx_er,
   col,
   crs,
   rx_dv,

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

   // signals coming from the register block.
   halfduplex_fc_en,
   back_pressure,
   bit_rate,
   full_duplex,
   gigabit,
   tx_byte_mode,
   dma_bus_width,
   en_transmit_sync,
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
   tw_sys_tx_time,
   spec_add1,
   spec_add1_par,
   spec_add1_active,
   tx_status_wr_tog,
   tx_pause_tog_ack,
   stretch_enable,
   stretch_ratio,
   min_ifg,
   ptp_unicast_ena,
   tx_ptp_unicast,
   rx_fill_level_low,
   rx_fill_level_high,
   ifg_eats_qav_credit,

   // signals coming from the transmit fifo interface.
   tx_r_data,
   tx_r_par,
   tx_r_mod,
   tx_r_sop,
   tx_r_eop,
   tx_r_err,
   tx_r_valid,
   tx_r_data_rdy,
   tx_r_underflow,
   tx_r_flushed,
   tx_r_control,
   tx_r_frame_size,

   // signals going to transmit fifo interface.
   tx_r_rd,
   tx_r_rd_int,

   // signals coming from the dma block.
   dma_tx_status_tog,

   // signals going to the hclk_syncs block.
   dma_tx_end_tog,
   collision_occured,

   // signals going to the dma block.
   late_coll_occured,
   too_many_retries,
   underflow_frame,

   // signals going to the pclk_syncs block.
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
   tx_bytes_in_frame,
   tx_too_many_retries,
   tx_underflow_frame,
   tx_pause_frame_txed,
   tx_pfc_pause_frame_txed,
   tx_pause_time,
   tx_pause_time_tog,

   // time value to register block ...
   tsu_ptp_tx_timer_out,
   // RAS - Timestamp parity protection
   tsu_ptp_tx_timer_par_out,

   // Time value from TSU
   tsu_timer_cnt,
   tsu_timer_cnt_par,

   // From APB registers
   one_step_sync_mode,
   oss_correction_field,

    // extra status
   tx_r_timestamp,
   // RAS - Timestamp parity protection
   tx_r_timestamp_par,

   soft_config_fifo_en,

   // MAC is transmitting a DMA frame (for decrementing CBS credit)
   mac_txing_dma_frame,

   // signals coming from the rx block.
   new_pause_time,
   new_pause_tog

  );

   parameter [1363:0] grouped_params = {1364{1'b0}};
   `include "ungroup_params.v"
   parameter p_tx_buf_width = p_edma_tsu*56 + 160;

// buffer control state decode paramater declarations.
   localparam
      R_BUF_INIT             = 4'b0000, // idle state.
      R_RD_PEND_INIT         = 4'b0001, // initial read in progress.
      R_FRAME_RDY            = 4'b0010, // frame detected (sop set).
      R_FRAME_RDY_EOP        = 4'b0011, // frame ready and only one word.
      R_READ                 = 4'b0100, // read state whilst data taken.
      R_RD_PEND              = 4'b0101, // waiting for data valid response.
      R_IDLE1                = 4'b0110, // frame complete.
      R_IDLE2                = 4'b0111, // frame complete.
      R_BUF_RST1             = 4'b1000, // wait for fifo to flush.
      R_BUF_RST2             = 4'b1001; // wait for fifo to flush.

// data type paramater declarations.
   localparam
      TYPE_DATA              = 4'b0000, // data state decode.
      TYPE_CRC               = 4'b0001, // crc state decode.
      TYPE_PREAMBLE          = 4'b0010, // preamble state decode.
      TYPE_SFD               = 4'b0011, // sfd state decode.
      TYPE_JAM               = 4'b0100, // jam state decode.
      TYPE_CARRIER           = 4'b0101, // ce state decode.
      TYPE_FILL              = 4'b0110, // pad state decode.
      TYPE_BURST_IFG         = 4'b0111, // ce (ifg) state decode.
      TYPE_IDLE              = 4'b1000, // idle state decode.
      TYPE_JAM_CE            = 4'b1001, // jam (during ce) state decode.
      TYPE_HOLD              = 4'b1010; // Hold due to txd_rdy being low

// Define whether the random backoff PRBS counter is free running or only
// increments when a collision occurs.
   localparam RANDOM_FREE_RUNNING = 1'b1;


   // system signals.
   input         tx_clk;                  // 2.5MHz, 25MHz or 125MHz transmit
                                          // clock.
   input         n_txreset;               // reset synchronized to tx_clk.
   input         tsu_clk;                 // TSU clock
   input         n_tsureset;              // TSU reset
   input         pclk;                    // APB clock
   input         n_preset;                // APB reset

   // ethernet signals.
   output  [7:0] txd;                     // 0-7 bits transmit data to the PHY.
   output        txd_par;                 // parity for txd
   output        tx_en;                   // transmit enable signal to the PHY.
   output        tx_er;                   // transmit error signal to the PHY.
   input         col;                     // collision detect signal from the
                                          // PHY.
   input         crs;                     // carrier sense signal from the PHY.
   input         rx_dv;                   // Data Valid for 10/100 mode

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
   output        sync_frame_tx;           // asserted on PTP sync frame
   output        delay_req_tx;            // asserted on PTP delay_req
   output        pdelay_req_tx;           // asserted on PTP pdelay_req
   output        pdelay_resp_tx;          // asserted on PTP pdelay_resp
   output        general_frame_tx;        // asserted on PTP general frame

   // signals coming from the register block.
   input         bit_rate;                // For setting counter - back pressure
   input         back_pressure;           // goes to tx block to force
                                          // collisions on all incoming frames
   input         halfduplex_fc_en;        // Enables above back_pressure mech
   input         full_duplex;             // duplex signal from the network
                                          // configuration register.
   input         gigabit;                 // high for gigabit operation.
   input         tx_byte_mode;            // gem_tx transmits bytes not nibbles
                                          // active in gigabit or tbi modes
   input   [1:0] dma_bus_width;           // DMA bus width...
                                          //   00 : 32-bit
                                          //   01 : 64-bit
                                          //   10 : 128-bit
                                          //   11 : 128-bit.
   input         en_transmit_sync;        // transmit enable signal from network
                                          // control register (soft reset of tx
                                          // block).
   input         pause_enable;            // set to enable reception of pause
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
                                          // transmission of pause frame.
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
   input  [15:0] tw_sys_tx_time;          // system wake time after tx LPI stops

   input  [47:0] spec_add1;               // specific address 1 used for
                                          // transmission of pause frames.
   input  [5:0]  spec_add1_par;           // Optional parity
   input         spec_add1_active;        // spec_add1 can be used for
                                          // destination address comparison.
   input         tx_status_wr_tog;        // toggle handshake for status write
                                          // back to register block.
   input         tx_pause_tog_ack;        // handshake of tx_pause_time_tog
                                          // back from register block.
   input         stretch_enable;          // enables IPG stretching
   input  [15:0] stretch_ratio;           // determines how to stretch the IPG
   input   [3:0] min_ifg;                 // minimum transmit IFG divided by four
   input         ptp_unicast_ena;         // enable PTPv2 IPv4 unicast IP DA
                                          // detection
   input  [31:0] tx_ptp_unicast;          // tx PTPv2 IPv4 unicast IP DA
   input         rx_fill_level_low;       // watermark for transmitting zero pause frame
   input         rx_fill_level_high;      // watermark for transmitting non-zero pause frame
   input         ifg_eats_qav_credit;     // modifies CBS algorithm so IFG/IPG uses Qav credit

   // signals coming from the transmit fifo interface.
   input [127:0] tx_r_data;               // output data from the transmit fifo
                                          // to the tx module.
   input  [15:0] tx_r_par;                // ASF - 16 bits parity for tx_r_data
   input   [3:0] tx_r_mod;                // tx number of valid bytes in last
                                          // transfer of the frame.
                                          // 0000 - tx_r_data[127:0] valid,
                                          // 0001 - tx_r_data[7:0] valid,
                                          // 0010 - tx_r_data[15:0] valid, until
                                          // 1111 - tx_r_data[119:0] valid.
   input         tx_r_sop;                // start of packet indicator.
   input         tx_r_eop;                // end of packet indicator.
   input         tx_r_err;                // packet in error indicator.
   input         tx_r_valid;              // new tx data available from fifo.
   input         tx_r_data_rdy;           // indicates either a complete packet
                                          // is present in the fifo or a certain
                                          // threshold of data has been crossed,
                                          // the mac uses this input to trigger
                                          // a frame transfer.
   input         tx_r_underflow;          // signals tx fifo underrun condition.
   input         tx_r_flushed;            // indicates fifo has flushed.
   input         tx_r_control;            // packet control information
   input [13:0]  tx_r_frame_size;         // Frame Length, 1 per queue

   // signals going to the transmit fifo interface.
   output        tx_r_rd;                 // request new data from fifo.
   output        tx_r_rd_int;             // early version of tx_r_rd

   // signals coming from the dma block.
   input         dma_tx_status_tog;       // when toggled, indicates transmit
                                          // status written by dma.

   // signals going to the hclk_syncs block.
   output        dma_tx_end_tog;          // toggled at the end of frame
                                          // transmission, acknowledged
                                          // by dma_tx_status_tog.
   output        collision_occured;       // set if collision happens during
                                          // frame transmission, cleared when
                                          // dma_tx_status_tog is returned.

   // signals going to the dma block.
   output        late_coll_occured;       // set if late collision occurs in
                                          // gigabit mode (flushes tx fifo),
                                          // cleared when dma_tx_status_tog
                                          // is returned.
   output        too_many_retries;        // signals too many retries error
                                          // condition (flushes tx fifo),
                                          // cleared when dma_tx_status_tog
                                          // is returned.
   output        underflow_frame;         // asserted high at the end of frame
                                          // to indicate a fifo underrun or
                                          // tx_r_err condition, cleared when
                                          // dma_tx_status_tog is returned.
   output [77:0] tx_r_timestamp;          // asserted high at the end of frame
                                          // to indicate a fifo underrun or
                                          // tx_r_err condition, cleared when
                                          // dma_tx_status_tog is returned.
   output  [9:0] tx_r_timestamp_par;     // parity protection for tx_r_timestamp

   // signals going to the pclk_syncs block for statistics register recording.
   output        tx_end_tog;              // toggled at the end of frame
                                          // transmission, cleared when
                                          // tx_status_wr_tog is returned.
   output        tx_coll_occured;         // set if collision happens during
                                          // frame transmission, cleared when
                                          // tx_status_wr_tog is returned.
   output        tx_frame_txed_ok;        // asserted on end_frame if no
                                          // underrun and not too many retries.
                                          // retries. Cleared when
                                          // tx_status_wr_tog is returned.
   output        tx_broadcast_frame;      // asserted on end_frame if the frame
                                          // transmitted was broadcast.
   output        tx_multicast_frame;      // asserted on end_frame if the frame
                                          // transmitted was multicast.
   output        tx_single_coll_frame;    // asserted on end_frame if a single
                                          // collision occurred prior to the
                                          // frame being successfully
                                          // transmitted with no fifo underrun
                                          // condition, cleared when
                                          // tx_status_wr_tog is returned.
   output        tx_multi_coll_frame;     // asserted on end_frame if a multi
                                          // collision occurred prior to the
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
   output [13:0] tx_bytes_in_frame;       // number of bytes in frame.
   output        tx_pause_frame_txed;     // asserted when 802.3 pause frame
                                          // is txed,
                                          // cleared when tx_status_wr_tog is
                                          // returned.
   output        tx_pfc_pause_frame_txed; // asserted when PFC pause frame is
                                          // txed,
                                          // cleared when tx_status_wr_tog is
                                          // returned.
   output [15:0] tx_pause_time;           // current value of pause time
                                          // counter.
   output        tx_pause_time_tog;       // pause time counter value changed


   // signals coming from the rx block.
   input [15:0]  new_pause_time;          // value of decoded new pause time.
   input         new_pause_tog;           // indicates that tx should pause.

   output [77:0] tsu_ptp_tx_timer_out;     // value inserted into PTP sync frame
   // RAS - Timestamp parity protection
   output  [9:0] tsu_ptp_tx_timer_par_out; // parity protection for tsu_ptp_tx_timer_out

   input         one_step_sync_mode;      // enable ts insertion into sync frames
   input         oss_correction_field;    // enable update of correction field in sync frames
   input [93:16] tsu_timer_cnt;           // TSU timer count value
   input [11:2]  tsu_timer_cnt_par;


   input         soft_config_fifo_en;     // use ext fifo port

   output        mac_txing_dma_frame;     //  used to decrement CBS


   // reg and wire declarations.

   // ethernet interface signals.
   reg           tx_er;                   // transmit error signal to the PHY.
   reg           tx_er_next;              // next tx error signal to the PHY.
   reg     [7:0] txd;                     // 0-7 transmit data to the PHY.
   reg     [8:0] txd_next;                // 0-7 bits next txd to be transmitted.
                                          // 8 bit parity
   reg           tx_en;                   // transmit enable signal to the PHY.
   wire          tx_en_next;              // next tx enable signal to the PHY.
   reg    [13:0] frame_size_buf;          // Frame Length - timed with transmit_data_buf
   reg    [13:0] txd_frame_size;          // transmit error signal to the PHY.

   // fifo interface signals.
   reg           tx_r_rd;                 // request new data from fifo.

   // dma interface signals.
   reg           dma_tx_end_tog;          // toggled at the end of frame
                                          // transmission, acknowledged
                                          // by dma_tx_status_tog.
   reg           dma_tx_end_frame;        // asserted high at the end of frame
                                          // transmission, cleared when
                                          // dma_tx_status_tog is returned.
   reg           collision_occured;       // set if collision happens during
                                          // frame transmission, cleared when
                                          // dma_tx_status_tog is returned.
   reg           late_coll_occured;       // set if late collision occurs in
                                          // gigabit mode (flushes tx fifo),
                                          // cleared when dma_tx_status_tog
                                          // is returned.
   reg           too_many_retries;        // signals too many retries error
                                          // condition (flushes tx fifo),
                                          // cleared when dma_tx_status_tog
                                          // is returned.
   reg           underflow_frame;         // asserted high at the end of frame
                                          // to indicate a fifo underrun or
                                          // tx_r_err condition, cleared when
                                          // dma_tx_status_tog is returned.
   wire  [77:0]  tx_r_timestamp;          // asserted high at the end of frame
                                          // to indicate a fifo underrun or
                                          // tx_r_err condition, cleared when
                                          // dma_tx_status_tog is returned.
   wire   [9:0]  tx_r_timestamp_par;     // parity protection for tx_r_timestamp

   // signals used for synchronisation.
   wire          coll_sync;               // used for syncing col from the
                                          // external PHY to tx_clk.
   wire          crs_sync;                // used for syncing crs from the
                                          // external PHY to tx_clk.
   reg           retry_test_sync1;        // used for syncing retry_test from
                                          // pclk domain to tx_clk.
   reg           frame_ready;             // used for syncing frame_ready
                                          // signal to tx_clk.
   reg           pause_frame_transmitting;// asserted when ready to transmit
                                          // 802.3 pause frame.
   reg           pfc_frame_transmitting;  // asserted when ready to transmit
                                          // pfc pause frame
   wire          tx_lpi_en_sync;          // 2nd metastability stage.
   wire          dma_status_edge;         // one clk wide dma_tx_status_tog.
   wire          tx_status_edge;          // one clock wide tx status written.
   wire          pause_enable_sync;       // 2nd metastability stage.
   reg           tx_r_rd_int;             // registered read o/p for fifo i/f.
   wire          ptp_unicast_ena_sync;    // used for syncing enable_transmit
                                          // from the network control register.

   // signals coming from the macb_tx_state module.
   wire          load_backoff;            // loads backoff_cnt and increments
                                          // random, asserted at end of jam with
                                          // end_frame.
   wire          start_ifg;               // starts interframe_cnt counting
                                          // asserted at end_frame or when crs
                                          // detected in idle or backoff.
   wire          start_jam;               // starts jam_cnt,  asserted as jam
                                          // state is entered.
   wire          coll_occured;            // asserted if coll occurs during
                                          // frame transmission.
   wire          first_ifg;               // set during first ifg (not after a
                                          // collision) used in setting deferred
   wire    [3:0] data_type;               // indicates data_type for
                                          // transmission:
                                          // 0000 data, 0001 crc,
                                          // 0010 preamble,
                                          // 0011 sfd, 0100 jam,
                                          // 0101 carrier_ext,
                                          // 0110 fill, 0111 burst_ifg,
                                          // 1000 idle, 1001 jam_ce.
   wire          start_frame;             // single cycle pulse at the start of
                                          // frame loads first bytes of
                                          // transmit_data_buf from
                                          // transmit_data.
   wire          end_frame;               // single cycle pulse at the end of
                                          // frame (not asserted after a col).
   wire          end_data_frame;          // used to register enable byte count
                                          // of the transmitted frame.
   wire          excess_coll;             // signals too many retries error
                                          // condition, asserted with jam state.
   wire          first_frame;             // indicates first frame, i.e. not in
                                          // a burst (gigabit, half duplex
                                          // only).

   // signals used for storage, counting and signalling.
   reg           tx_frame_ready;          // asserted when a valid frame is
                                          // available to transmit.

   reg   [127:0] transmit_data;           // output data from the transmit fifo
                                          // to the tx module.
   reg    [15:0] transmit_par;            // with last 16 parity bits

   reg  [p_tx_buf_width-1:0]    transmit_data_buf_nxt;      // store of data to be transmitted. Combinatorial
   reg  [p_tx_buf_width/8-1:0]  transmit_par_buf_nxt;       // parity of transmit_data_buf

   reg  [p_tx_buf_width-1:0]    transmit_data_buf;          // store of data to be transmitted. Registered
   wire [p_tx_buf_width/8-1:0]  transmit_par_buf;           // parity of transmit_data_buf

   reg  [383:0]                 transmit_data_buf_new;      // new vector to be loaded into transmit_data_buf including transmit_data
   reg  [384/8-1:0]             transmit_par_buf_new;       // parity of transmit_data_buf_new
   reg  [383:0]                 transmit_data_buf_new_shift;// new vector to be loaded into transmit_data_buf with byte shift
   reg  [384/8-1:0]             transmit_par_buf_new_shift; // parity of transmit_data_buf_new_shift

   reg     [8:0] transmit_data_mux;       // multiplex between pause data and
                                          // frame data.
   reg     [7:0] interframe_cnt;          // counts out the 96 bits of interframe gap (or 192 or 256 bits)
   reg           ifg_cnt_active;          // set while interframe_cnt is counting.
   wire          interframe_gap;          // set while "ifg_cnt_active | ipg_stretch" is true
   reg    [23:0] stretch_size;            // indicates how much to stretch the
                                          // IPG.
   reg     [7:0] stretch_count;           // used to slow down the incrementing
                                          // stretch_size
   reg           ipg_stretch;             // asserted to stretch the IPG
   wire          spec_add1_act_le;        // leading edge of spec_add1_active
   wire          random_update;           // define when to update random PRBS.
   wire          random2_update;          // define when to update random PRBS.
   reg     [9:0] random1cnt;              //
   reg     [3:0] shiftrnd1;               //
   wire    [9:0] random1_sft;             //
   reg    [15:0] random1;                 // random number combined with crc to
                                          // generate backoff start.
   reg    [15:0] random2;                 // random number combined with crc to
                                          // generate backoff start.
   wire    [9:0] random;                  // random number combined with crc to
   reg     [3:0] attempts;                // count of number of attempts to tx
   wire          last_attempt;            // set when attempts equals 15.
   wire    [9:0] backoff_start;           // combination of random and crc.
   reg    [18:0] backoff_cnt;             // back off count in bytes.
   wire          backoff;                 // set while doing backoff (ie while
                                          // backoff_cnt counts down to zero).
   reg     [2:0] jam_cnt;                 // counts out the 32 bits of jam.
   wire          jam;                     // set when jam_cnt is not equal to 0
   reg     [2:0] crc_cnt;                 // counts out the 32 bits of crc.
   reg     [3:0] preamble_cnt;            // counts out the 64 bits of preamble.
   wire          last_preamble;           // set to signal end of preamble.
   wire          within_60bytes;          // set while frame is less than 60
                                          // bytes.
   wire          within_512bytes;         // set while frame is less than 512
                                          // bytes.
   wire          late_col_threshold;      // late collision threshold indication
   reg    [13:0] tx_frame_length;         // counts the number of bytes
                                          // transmitted in the frame,
                                          // (including carrier extension).
   wire   [13:0] tx_frame_length_nxt;     // addition for number of bytes
                                          // that have been transmitted (inc.
                                          // carrier extension).
   reg     [5:0] tx_pause_length;         // byte count for pause frames txed.
   reg    [13:0] burst_length;            // number of bytes in burst.
   reg     [4:0] no_of_valid_bytes;       // number of valid bytes in
                                          // transmit_data.
   reg     [4:0] new_frame_bytes;         // number of bytes in first word of
                                          // frame.
   reg     [4:0] no_of_stored_bytes;      // number of stored bytes in
                                          // transmit_data_buf.
   wire    [5:0] no_of_str_bytes_nxt;     // next number of stored bytes in
                                          // transmit_data_buf.
   reg    [31:0] crc;                     // used for crc generation.
   wire   [31:0] tx_stripe_out0;          // used for crc generation.
   wire   [31:0] tx_stripe_out1;          // used for crc generation.
   wire   [31:0] tx_stripe_out2;          // used for crc generation.
   wire   [31:0] tx_stripe_out3;          // used for crc generation.
   wire   [31:0] tx_stripe_out4;          // used for crc generation.
   wire   [31:0] tx_stripe_out5;          // used for crc generation.
   wire   [31:0] tx_stripe_out6;          // used for crc generation.
   wire   [31:0] tx_stripe_out7;          // used for crc generation.
   wire          last_crc;                // used for crc generation.
   wire          last_data;               // last data to be transmitted.
   reg           last_read;               // last word of frame extracted from
                                          // transmit fifo.
   reg           one_read;                // one word access from fifo interface
                                          // and used to hold last_data.
   reg           tx_paused;               // indicates that tx has paused.
   wire          pause_tx;                // indicates that tx should be paused.
   wire          load_new_pause_time;     // one clock wide pause counter load.
   wire          preset_count_512;        // counter load for 512-bit times
                                          // pause quanta count.
   reg     [6:0] count_512;               // counts to 512, used for
                                          // decrementing pause time.
   wire          decrement_pause_time;    // indicates when the pause timer may
                                          // decrement.
   reg           int_end_frame;           // used to ensure the tx doesn't defer
                                          // to it's own transmissions.
   reg     [1:0] int_end_frame_cnt;       // counter to ensure the tx doesn't
                                          // defer to it's own transmissions.
   reg     [3:0] buffer_state;            // state of gem input buffer state
                                          // machine.
   reg     [3:0] buffer_state_next;       // next state of gem input buffer
                                          // state machine.
   wire          buffer_state_bufinit;    // state machine is in R_BUF_INIT.
   reg           nibble_sel;              // used to select upper or lower
                                          // nibble in 10/100 mode.
   wire          frame_tx;                // transmit trigger signal.
   wire          within_burst_limit;      // signal indicating burst limit has
                                          // been exceeded.
   reg           fifo_underrun;           // underflow held until end of
                                          // frame.
   reg           fifo_err_underrun;       // underflow caused by tx_r_err read
                                          // held until end of frame.
   reg           underflow;               // underrun detected within fifo and
                                          // held until start of frame.
   reg           err_underflow;           // ERR detected within fifo and
                                          // held until start of frame.
   reg           tx_no_crc_sop;           // signal used to register tx_no_crc
                                          // at start of packet from fifo i/f.
   reg           tx_no_crc_held;          // signal used to register tx_no_crc
                                          // at start of frame.
   wire          tx_no_crc_valid;         // tx_no_crc only set if the frame to
                                          // be transmitted is not a pause
                                          // frame.
   reg           tx_pause_0_sync1;        // synchronise tx_pause_zero to tx_clk
   reg           tx_pause_zero_held;      // register enabled version of
                                          // tx_pause_zero input held until
                                          // 802.3 pause frame transmitted.
   reg           tx_r_flush_held;         // signal used to hold tx_r_flushed
                                          // until buffer state machine has
                                          // detected it.
   reg           collision_int;           // internal collision signal, set
                                          // upon collision and held until dma
                                          // has acknowledged previous frame.
   reg           stat_underflow_pend;     // asserted when status written to
                                          // either the registers block or dma
                                          // block has not been acknowledged
                                          // when a new frame completes (short
                                          // frame error condition where status/
                                          // statistics cannot be reported
                                          // which is indicated as underflow).
                                          // this signal is held until the
                                          // underflow error can be output.
   reg           stat_underflow_ack;      // acknowledge signal to clear
                                          // stat_underflow_pend once the
                                          // underflow error has been output.
   reg           pclksync_eof_noack;      // asserted at end of frame until
                                          // gem_pclk_sync acknowledges.
   reg           dma_eof_noack;           // asserted at end of frame until
                                          // dma acknowledges.
   reg           late_col_pending;        // late collision pending (gigabit
                                          // mode), to be updated once status
                                          // status writeback completes.

   // statistics stuff follows
   reg           tx_end_frame;            // asserted high at the end of frame
                                          // transmission (loads new tx
                                          // address and length), cleared by
                                          // tx_status_wr_tog is returned.
   reg           tx_end_tog;              // toggled at the end of frame
                                          // transmission, cleared when
                                          // tx_status_wr_tog is returned.
   reg           tx_coll_occured;         // set if collision happens during
                                          // frame transmission, cleared when
                                          // tx_status_wr_tog is returned.
   reg           tx_frame_txed_ok;        // asserted on end_frame if no
                                          // underrun and not too many retries.
                                          // retries. Cleared when
                                          // tx_status_wr_tog is returned.
   reg           broadcast_match;         // signal detecting when a broadcast
                                          // destinition address is present.
   reg           tx_broadcast_frame;      // asserted on end_frame if the frame
                                          // transmitted was broadcast.
   reg           multicast_match;         // signal detecting when a multicast
                                          // destinition address is present.
   reg           tx_multicast_frame;      // asserted on end_frame if the frame
                                          // transmitted was multicast.
   reg           single_collision;        // set after single collision
                                          // detected.
   reg           tx_single_coll_frame;    // asserted on end_frame if a single
                                          // collision occurred prior to the
                                          // frame being successfully
                                          // transmitted with no fifo underrun
                                          // condition, cleared when
                                          // tx_status_wr_tog is returned.
   reg           multi_collision;         // set after multiple collisions
                                          // detected.
   reg           tx_multi_coll_frame;     // asserted on end_frame if a multi
                                          // collision occurred prior to the
                                          // frame being successfully
                                          // transmitted with no fifo underrun
                                          // condition, cleared when
                                          // tx_status_wr_tog is returned.
   reg           deferred;                // set if frame transmission has been
                                          // deferred.
   reg           tx_deferred_tx_frame;    // asserted on end_frame if deferred,
                                          // no collision and no
                                          // underrun. cleared when
                                          // tx_status_wr_tog is returned.
   reg           late_collision;          // set if late collision is detected.
   wire          late_collision_gig;      // set if late collision is detected in gigabit mode.
   reg           tx_late_coll_frame;      // asserted on end_frame if late
                                          // collision, no underrun and
                                          // not too many retries. cleared when
                                          // tx_status_wr_tog is returned.
   reg           crs_seen;                // assert crs_seen if crs is seen
                                          // during frame transmission.
   reg           crs_deasserted;          // assert crs_deasserted if crs is
                                          // deasserted after crs_seen during
                                          // frame transmission.
   wire          crs_failure;             // assert crs_failure if crs not seen
                                          // during transmission or if crs
                                          // deasserted.
   reg           tx_crs_error_frame;      // asserted on end_frame, if crs error
                                          // and no underrun. cleared when
                                          // tx_status_wr_tog is returned.
   reg           tx_too_many_retries;     // signals too many retries error
                                          // condition, cleared when
                                          // tx_status_wr_tog is returned.
   reg           tx_underflow_frame;      // asserted high at the end of frame
                                          // to indicate a fifo underrun,
                                          // cleared when tx_status_wr_tog
                                          // is returned.
   reg    [13:0] tx_bytes_in_frame;       // number of bytes in frame.
   reg           tx_pause_frame_txed;     // asserted when 802.3 pause frame
                                          // is txed,
                                          // cleared when tx_status_wr_tog is
                                          // returned.
   reg           tx_pfc_pause_frame_txed; // asserted when PFC pause frame is
                                          // txed,
                                          // cleared when tx_status_wr_tog is
                                          // returned.
   reg    [15:0] tx_pause_tim_cnt_nxt;    // next value of pause time counter.
   reg    [15:0] tx_pause_time_cnt;       // current value of pause time
                                          // counter.
   reg    [15:0] tx_pause_time;           // held value of pause time
                                          // counter for transfering to pclk.
   wire          pause_time_zero_dec;     // Decode of when pause_time is zero.
   reg           tx_pause_time_change;    // Detect changes in pause time count
   reg           tx_pause_time_tog;       // pause time counter value changed.
   reg           tx_pause_tog_in_prog;    // update in progress to pause_time
   reg           tx_pause_tog_pending;    // new update pending to pause_time
   wire          pause_tog_ack_edge;      // edge detected on tx_pause_tog_ack
   reg    [18:0] sys_waking;              // pauses transmission when non zero - used in EEE operation


   // precision time protocol signals for IEEE 1588 support
   reg     [4:0] tx_dec_state;            // Current decoder state
   reg     [4:0] tx_dec_state_nxt;        // Next decoder state
   reg           en_tx_ptp_count;         // used to enable tx_ptp_count
   reg           en_tx_ptp_count_nxt;     // next value of tx_ptp_count
   reg     [6:0] tx_ptp_count;            // used for counting through PTP frame
   reg     [6:0] ptp_timestamp_position;  // used for calculating timestamp postion
                                          // in through PTP frame

   reg           ptp_timestamp_position_cap;    // control to capture timestamp position for 1588 version 2
   reg           ptp_timestamp_position_cap_v1; // control to capture timestamp position for 1588 version 1

   reg           sof_tx;                  // asserted on SFD deasserted at EOF
   reg           sync_frame_tx;           // asserted on PTP sync frame
   reg           sync_frame_tx_nxt;       // Next PTP sync frame
   reg           delay_req_tx;            // asserted on PTP delay_req
   reg           delay_req_tx_nxt;        // Next PTP delay_req
   reg           pdelay_req_tx;           // asserted on PTP pdelay_req
   reg           pdelay_req_tx_nxt;       // Next PTP pdelay_req
   reg           pdelay_resp_tx;          // asserted on PTP pdelay_resp
   reg           pdelay_resp_tx_nxt;      // Next PTP pdelay_resp
   reg           general_frame_tx;        // asssert on PTP general frame decode
   reg           general_frame_tx_nxt;    // asssert on PTP general frame decode
   reg           ptp_ver_1;               // used to identify PTP version 1
   reg           ptp_ver_1_nxt;           // next value of ptp_ver_1
   reg           ptp_ver_2;               // used to identify PTP version 2
   reg           ptp_ver_2_nxt;           // next value of ptp_ver_2
   reg           ptp_unicast;             // used to identify PTP unicast IP DA
   reg           ptp_unicast_nxt;         // next value of ptp_unicast

   reg           back_pressure_sync1;     // used for syncing back_pressure
                                          // signal to tx_clk
   reg           back_pressure_sync2;     // used for syncing back_pressure
                                          // signal to tx_clk
   reg           back_pressure_sync3;     // used for syncing back_pressure
                                          // signal to tx_clk
   reg           back_pressure_sync4;     // used for syncing back_pressure
                                          // signal to tx_clk
   reg     [6:0] bp_cnt;                  // counts out the 64 bits of back
                                          // pressure frame
   wire          bp_active;               // set when bp_cnt is not equal to
                                          // zero

   wire          rx_dv_sync;              // Sync into tx for BP application

   // PFC pause frame signals
   // synchronised signals
   reg           tx_pfc_sel_sync1;        // synchronise tx_pfc_sel
   reg    [7:0]  tx_pfc_pause_sync1;      // synchronise tx_pfc_pause
   reg    [7:0]  tx_pfc_pause_0_sync1;    // synchronise tx_pfc_pause_zero
   reg    [7:0]  tx_pfc_pri_held;         // priority enable for the current PFC frame

   reg    [7:0]  tx_pfc_zero_held;        // held for priority 1

   wire          pause_request_pins;      // edge detect for tx pause req - pins
   wire          pause_is_pfc_pins;       // select pfc from pins
   wire          pause_802p3_type_pins;   // select non-pfc from pins
   wire    [7:0] pause_pfc_pri_vector_pins;  //
   wire    [7:0] pause_pfc_zero_vector_pins; //
   wire          pause_request_reg;       //
   wire          pause_is_pfc_reg;        //
   wire          pause_802p3_type_reg;    //
   wire    [7:0] pause_pfc_pri_vector_reg;  //
   wire          pause_pfc_pri_vector_reg_par;
   wire    [7:0] pause_pfc_zero_vector_reg; //
   wire          pause_request;           //
   reg           pause_is_pfc;            //
   reg           pause_802p3_type;        //
   reg     [7:0] pause_pfc_pri_vector;    //
   reg           pause_pfc_pri_vector_par;
   reg     [7:0] pause_pfc_zero_vector;   //

   reg           pause_request_sched;     //
   reg           pause_is_pfc_sched;      //
   reg           pause_802p3_type_sched;  //
   reg     [7:0] pause_pfc_pri_vector_sched;   //
   reg     [7:0] pause_pfc_zero_vector_sched;  //

   wire   [79:0] tsu_ptp_tx_ts_latched;      // 80bit PTP TS format
   wire   [77:0] tsu_timer_sampled_on_sof_safe; // TSU timer count value
   wire    [9:0] tsu_timer_par_sampled_on_sof_safe;  // parity protection for the TSU timer count value
   wire          tsu_timer_safe_to_sample;   // Qualifer
   wire          tx_pause_frame_req_edge,tx_pause_frame_zero_edge,tx_pfc_frame_req_edge;
   wire          rx_fill_level_low_rise;     // synchronized rising edge indication that rx FIFO has fallen below its low watermark
   wire          rx_fill_level_high_rise;    // synchronized rising edge indication that rx FIFO has risen above its high watermark
   reg           rx_fill_pause_sent;         // registered rx_fill_level_high_rise to enable subsequent rx_fill_level_low_rise action
   wire   [77:0] tsu_ptp_tx_timer_out;       // Timestamp in PCLK domain
   // ASF - Timestamp parity protection
   wire    [9:0] tsu_ptp_tx_timer_par_out;  // parity protection for tsu_ptp_tx_timer_out

   wire   [63:0] correction_field_new;       // updated correction field
   wire          oss_correction_field_sync;  // oss_correction_field synchronised to tx_clk

   reg           mac_txing_dma_frame;        //  used to decrement CBS

   wire          apply_bp_comb;              // Combinatorial OR
   wire          apply_bp;

   // PFC quantum signals
   wire   [15:0] tx_pause_quant;
   wire   [15:0] tx_pause_quant_p1;
   wire   [15:0] tx_pause_quant_p2;
   wire   [15:0] tx_pause_quant_p3;
   wire   [15:0] tx_pause_quant_p4;
   wire   [15:0] tx_pause_quant_p5;
   wire   [15:0] tx_pause_quant_p6;
   wire   [15:0] tx_pause_quant_p7;
   wire   [1:0]  tx_pause_quant_par;
   wire   [1:0]  tx_pause_quant_par_p1;
   wire   [1:0]  tx_pause_quant_par_p2;
   wire   [1:0]  tx_pause_quant_par_p3;
   wire   [1:0]  tx_pause_quant_par_p4;
   wire   [1:0]  tx_pause_quant_par_p5;
   wire   [1:0]  tx_pause_quant_par_p6;
   wire   [1:0]  tx_pause_quant_par_p7;

   wire          tx_ts_insert_ptp_v1;     // indicates PTP version 1 TS will be inserted
   wire          tx_ts_insert_ptp_v2;     // indicates PTP version 2 TS will be inserted
   wire          tx_ts_update_cor_fld;    // indicates PTP version 2 correction field will be updated
   wire    [3:0] tx_ts_insert_count_ptp;
   wire          allow_pause;

   reg    [13:0] tx_r_frame_size_mux;     // Frame Length,

   // ASF - signals to pass parity from the generator to the data path
   wire         tx_pfc_pri_held_par;
   wire   [9:0] tsu_ptp_tx_ts_latched_par;
   wire   [7:0] correction_field_new_par;
   wire         crc_24_31_par;
   wire         crc_28_31_par;
   wire         transmit_par_mux_3_0;
   wire         transmit_par_mux_7_4;


   // TCP Offload Engine state machine labels
   localparam TX_DEC_IDLE    = 5'b00000;    // TX DEC IDLE state
   localparam TX_DEC_START   = 5'b00001;    // TX DEC_START state
   localparam TX_DEC_PTP_1   = 5'b00010;    // TX DEC_PTP_1 state
   localparam TX_DEC_PTP_2   = 5'b00011;    // TX DEC_PTP_2 state
   localparam TX_DEC_IPV4_1  = 5'b00100;    // TX DEC_IPV4_1 state
   localparam TX_DEC_IPV4_2  = 5'b00101;    // TX DEC_IPV4_2 state
   localparam TX_DEC_IPV4_3  = 5'b00110;    // TX DEC_IPV4_3 state
   localparam TX_DEC_IPV6_1  = 5'b00111;    // TX DEC_IPV6_1 state
   localparam TX_DEC_IPV6_2  = 5'b01000;    // TX DEC_IPV6_2 state
   localparam TX_DEC_IPV6_3  = 5'b01001;    // TX DEC_IPV6_3 state
   localparam TX_DEC_VIPV4_1 = 5'b01010;    // TX DEC_VIPV4_1 state
   localparam TX_DEC_VIPV4_2 = 5'b01011;    // TX DEC_VIPV4_2 state
   localparam TX_DEC_VIPV4_3 = 5'b01100;    // TX DEC_VIPV4_3 state
   localparam TX_DEC_VIPV6_1 = 5'b01101;    // TX DEC_VIPV6_1 state
   localparam TX_DEC_VIPV6_2 = 5'b01110;    // TX DEC_VIPV6_2 state
   localparam TX_DEC_VIPV6_3 = 5'b01111;    // TX DEC_VIPV6_3 state
   localparam TX_DEC_VPTP_1  = 5'b10000;    // TX DEC_PTP_1 state
   localparam TX_DEC_VPTP_2  = 5'b10001;    // TX DEC_PTP_2 state



   // instatiation of main control state machine for transmit.
   gem_tx_state i_tx_state (
   .tx_clk            (tx_clk),
   .n_txreset         (n_txreset),
   .backoff           (backoff),
   .last_attempt      (last_attempt),
   .interframe_gap    (interframe_gap),
   .coll_sync         (coll_sync),
   .late_collision    (late_collision),
   .crs_sync          (crs_sync),
   .fifo_underrun     (fifo_underrun),
   .jam               (jam),
   .last_data         (last_data),
   .frame_ready       (frame_tx),
   .last_crc          (last_crc),
   .last_preamble     (last_preamble),
   .within_60bytes    (within_60bytes),
   .within_512bytes   (within_512bytes),
   .en_transmit_sync  (en_transmit_sync),
   .tx_no_crc         (tx_no_crc_valid),
   .gigabit           (gigabit),
   .within_burst_limit(within_burst_limit),
   .full_duplex       (full_duplex),
   .txd_rdy           (txd_rdy),

   .load_backoff      (load_backoff),
   .start_ifg         (start_ifg),
   .start_jam         (start_jam),
   .coll_occured      (coll_occured),
   .first_ifg         (first_ifg),
   .tx_en_next        (tx_en_next),
   .data_type         (data_type),
   .start_frame       (start_frame),
   .end_frame         (end_frame),
   .end_data_frame    (end_data_frame),
   .first_frame       (first_frame),
   .excess_coll       (excess_coll)
   );

   wire   pfc_or_pause_frame_transmitting;
   assign pfc_or_pause_frame_transmitting = (pause_frame_transmitting|pfc_frame_transmitting);

   // signal for triggering frame transmission, either
   // frame from external fifo interface or pause frame.
   assign frame_tx = frame_ready |
                     pfc_or_pause_frame_transmitting;

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_ptp_unicast_ena (
      .clk    (tx_clk),
      .reset_n(n_txreset),
      .din    (ptp_unicast_ena),
      .dout   (ptp_unicast_ena_sync));


   // synchronise collision signal from PHY to tx_clk domain.
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_col (
      .clk    (tx_clk),
      .reset_n(n_txreset),
      .din    (col & ~full_duplex),
      .dout   (coll_sync));


   // synchronise crs signal from PHY to tx_clk domain.
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_crs (
      .clk    (tx_clk),
      .reset_n(n_txreset),
      .din    (crs & ~full_duplex),
      .dout   (crs_sync));


   // synchronise retry_test signal from pclk domain to tx_clk domain.
   // only used for test so single sync register is adequate
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         begin
            retry_test_sync1 <= 1'b0;
         end
      else
         begin
            retry_test_sync1 <= retry_test;
         end
   end


   // synchronise tx_frame_ready from the dma block. frame_ready is disabled
   // when a received pause frame is active. frame_ready is used by the
   // tx state machine to trigger frame transmission.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         begin
            frame_ready       <= 1'b0;
            tx_paused         <= 1'b0;
         end
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         begin
            frame_ready       <= 1'b0;
            tx_paused         <= 1'b0;
         end
      else
         begin
            // ensure that tx is only paused when idle. if a pause frame is
            // transmitted, then pause counter for received frames must
            // still count down to zero.
            frame_ready       <= tx_frame_ready & ~(pause_tx &
                                 (data_type == TYPE_IDLE));
            tx_paused         <= (~frame_ready & (data_type == TYPE_IDLE)) |
                             (pause_frame_transmitting |pfc_frame_transmitting);
         end
   end

// Transmission of pause frames
//-----------------------------

  // First we need to synchronize the incoming pins ...
  //   tx_pause_zero,
  //   tx_pfc_sel,
  //   tx_pfc_pause,
  //   tx_pfc_pause_zero,
  // These are effectively static signals and are sampled based on tx_pause
  // input which is toggle detected below and will have at least 2 cycle
  // delay hence these signals will be stable by the time they are read.
  always@(posedge tx_clk or negedge n_txreset)
  begin
    if (~n_txreset)
    begin
      tx_pause_0_sync1        <= 1'b0;
      tx_pfc_sel_sync1        <= 1'b0;
      tx_pfc_pause_sync1      <= 8'h00;
      tx_pfc_pause_0_sync1    <= 8'h00;
    end
    else
    begin
      tx_pause_0_sync1        <= tx_pause_zero;
      tx_pfc_sel_sync1        <= tx_pfc_sel;
      tx_pfc_pause_sync1      <= tx_pfc_pause;
      tx_pfc_pause_0_sync1    <= tx_pfc_pause_zero;
    end
  end

  // Synchonize the pause request from pins, which is a toggle
  // and create a pulse request
  edma_sync_toggle_detect i_edma_sync_toggle_detect_tx_pause (
    .clk      (tx_clk),
    .reset_n  (n_txreset),
    .din      (tx_pause),
    .rise_edge(),
    .fall_edge(),
    .any_edge (pause_request_pins)
  );

  assign pause_is_pfc_pins          = tx_pfc_sel_sync1;
  assign pause_802p3_type_pins      = tx_pause_0_sync1;
  assign pause_pfc_pri_vector_pins  = tx_pfc_pause_sync1;
  assign pause_pfc_zero_vector_pins = tx_pfc_pause_0_sync1;

  // Now create the same signals from the registers ...
  // First synchronize the signals from the register block (in pclk domain)
  // tx_pause_frame_req     - classic 802.3 pause request nzero
  // tx_pfc_frame_req       - pfc pause request
  // tx_pause_frame_zero    - classic 802.3 pause request zero
  // tx_pfc_frame_pri       - can assume these are static at the point they are read
  // tx_pfc_frame_zero      - can assume these are static at the point they are read
   edma_sync_toggle_detect # (
      .DIN_W(3)
   ) i_edma_sync_toggle_detect_tx_pause_pfc (
      .clk      (tx_clk),
      .reset_n  (n_txreset),
      .din      ({tx_pause_frame_req,tx_pause_frame_zero,tx_pfc_frame_req}),
      .rise_edge(),
      .fall_edge(),
      .any_edge ({tx_pause_frame_req_edge,tx_pause_frame_zero_edge,tx_pfc_frame_req_edge}));

   edma_sync_toggle_detect # (
      .DIN_W(2)
   ) i_edma_sync_toggle_detect_rx_fill_level (
      .clk      (tx_clk),
      .reset_n  (n_txreset),
      .din      ({rx_fill_level_low,rx_fill_level_high}),
      .rise_edge({rx_fill_level_low_rise,rx_fill_level_high_rise}),
      .fall_edge(),
      .any_edge ());

  // register rx_fill_level_high_rise to enable subsequent rx_fill_level_low_rise action
  // we should only send a zero quantum pause frame if rx_fill_level_high_rise has previously
  // initiated a pause frame request. Clear this signal when the zero quantum pause frame is
  // requested by rx_fill_level_low_rise or when transmit is disabled
  always@(posedge tx_clk or negedge n_txreset)
  begin
    if (~n_txreset)
    begin
      rx_fill_pause_sent <= 1'b0;
    end
    else if (rx_fill_level_high_rise)
    begin
      rx_fill_pause_sent <= 1'b1;
    end
    else if (rx_fill_level_low_rise | ~en_transmit_sync)
    begin
      rx_fill_pause_sent <= 1'b0;
    end
  end

  assign pause_request_reg            = tx_pause_frame_req_edge | rx_fill_level_high_rise |
                                        (pause_802p3_type_reg) |
                                        (pause_is_pfc_reg);
  assign pause_is_pfc_reg             = tx_pfc_frame_req_edge;
  assign pause_802p3_type_reg         = tx_pause_frame_zero_edge | (rx_fill_level_low_rise & rx_fill_pause_sent);  // rx_fill_level_low_rise can only initiate zero pause frame transmission if non-zero pause frame previously sent
  assign pause_pfc_pri_vector_reg     = tx_pfc_frame_pri;   // Assume static
  assign pause_pfc_pri_vector_reg_par = tx_pfc_frame_pri_par;
  assign pause_pfc_zero_vector_reg    = tx_pfc_frame_zero;  // Assume static


  // Now multiplex these onto a single set of signals ...
  // Make the pins have higher priority ...
  assign pause_request              = (pause_request_pins | pause_request_reg) &
                                      en_transmit_sync & full_duplex;
  always @(*)
  begin
    if (pause_request_pins)
    begin
      pause_is_pfc             = pause_is_pfc_pins;
      pause_802p3_type         = pause_802p3_type_pins;
      pause_pfc_pri_vector     = pause_pfc_pri_vector_pins;
      pause_pfc_pri_vector_par = ^pause_pfc_pri_vector_pins;
      pause_pfc_zero_vector    = pause_pfc_zero_vector_pins;
    end
    else
    begin
      pause_is_pfc             = pause_is_pfc_reg;
      pause_802p3_type         = pause_802p3_type_reg;
      pause_pfc_pri_vector     = pause_pfc_pri_vector_reg;
      pause_pfc_pri_vector_par = pause_pfc_pri_vector_reg_par;
      pause_pfc_zero_vector    = pause_pfc_zero_vector_reg;
    end
  end



   // The tx_pause_quantum registers are considered to be static
   // and therefore no need to control when these are sampled and used in the pause frame.
   // This is a slight change of functioanlity and required that the tx_pause_quantum* registers
   // are updated when no pause frames are being sent.
   // This was implemented to save registers but not expected to affect real operating conditions.
   // Previouse *quant_held* registers have been removed.
   //
   // When pfc priority pause uses single quantum set all priority quantums to be the same, this
   // is already done in gem_registers
   assign tx_pause_quant        = tx_pause_quantum;
   assign tx_pause_quant_par    = tx_pause_quantum_par;
   assign tx_pause_quant_p1     = tx_pause_quantum_p1;
   assign tx_pause_quant_par_p1 = tx_pause_quantum_p1_par;
   assign tx_pause_quant_p2     = tx_pause_quantum_p2;
   assign tx_pause_quant_par_p2 = tx_pause_quantum_p2_par;
   assign tx_pause_quant_p3     = tx_pause_quantum_p3;
   assign tx_pause_quant_par_p3 = tx_pause_quantum_p3_par;
   assign tx_pause_quant_p4     = tx_pause_quantum_p4;
   assign tx_pause_quant_par_p4 = tx_pause_quantum_p4_par;
   assign tx_pause_quant_p5     = tx_pause_quantum_p5;
   assign tx_pause_quant_par_p5 = tx_pause_quantum_p5_par;
   assign tx_pause_quant_p6     = tx_pause_quantum_p6;
   assign tx_pause_quant_par_p6 = tx_pause_quantum_p6_par;
   assign tx_pause_quant_p7     = tx_pause_quantum_p7;
   assign tx_pause_quant_par_p7 = tx_pause_quantum_p7_par;

  // When a pause frame request is detected, then we will schedule it for transmission
  // Only when the data pipeline is empty can we accept the pause frame information
  // until then, we just store the information in holding, or scheduling registers ...
  //
  assign allow_pause = (end_frame |
                       (data_type == TYPE_IDLE & ~pfc_or_pause_frame_transmitting));
  always@(posedge tx_clk or negedge n_txreset)
  begin
    if (~n_txreset)
    begin
      pause_request_sched             <= 1'b0;
      pause_is_pfc_sched              <= 1'b0;
      pause_802p3_type_sched          <= 1'b0;
      pause_pfc_pri_vector_sched      <= 8'h00;
      pause_pfc_zero_vector_sched     <= 8'h00;
      pause_frame_transmitting        <= 1'b0;
      pfc_frame_transmitting          <= 1'b0;
      tx_pause_zero_held              <= 1'b0;
      tx_pfc_pri_held                 <= 8'h00;
      tx_pfc_zero_held                <= 8'h00;
    end
    else
    begin
      if (~en_transmit_sync)
      begin
        pause_request_sched             <= 1'b0;
        pause_is_pfc_sched              <= 1'b0;
        pause_802p3_type_sched          <= 1'b0;
        pause_pfc_pri_vector_sched      <= 8'h00;
        pause_pfc_zero_vector_sched     <= 8'h00;
        pause_frame_transmitting        <= 1'b0;
        pfc_frame_transmitting          <= 1'b0;
        tx_pause_zero_held              <= 1'b0;
        tx_pfc_pri_held                 <= 8'h00;
        tx_pfc_zero_held                <= 8'h00;
      end

      else if (pause_request)
      begin
        if (allow_pause)
        begin
          // Take direct from pins/registers
          pause_request_sched           <= 1'b0;
          pause_frame_transmitting      <= ~pause_is_pfc;
          pfc_frame_transmitting        <= pause_is_pfc;

          tx_pause_zero_held            <= pause_802p3_type;
          tx_pfc_pri_held               <= pause_pfc_pri_vector;
          tx_pfc_zero_held              <= pause_pfc_zero_vector;
        end
        else
        begin
          pause_request_sched           <= 1'b1;
          pause_frame_transmitting      <= pause_frame_transmitting;
          pfc_frame_transmitting        <= pfc_frame_transmitting;
          pause_is_pfc_sched            <= pause_is_pfc;
          pause_802p3_type_sched        <= pause_802p3_type;
          pause_pfc_pri_vector_sched    <= pause_pfc_pri_vector;
          pause_pfc_zero_vector_sched   <= pause_pfc_zero_vector;
        end
      end

      // execute any previously scheduled pause frames when pipeline becomes
      // idle
      else if (pause_request_sched & allow_pause)
      begin
        // Take from Holding registers ...
        pause_request_sched       <= 1'b0;
        pause_frame_transmitting  <= ~pause_is_pfc_sched;
        pfc_frame_transmitting    <= pause_is_pfc_sched;
        tx_pause_zero_held        <= pause_802p3_type_sched;
        tx_pfc_pri_held           <= pause_pfc_pri_vector_sched;
        tx_pfc_zero_held          <= pause_pfc_zero_vector_sched;
      end

      else
      begin
        if (end_frame)
        begin
          pause_frame_transmitting   <= 1'b0;
          pfc_frame_transmitting     <= 1'b0;
        end
        else
        begin
          pause_frame_transmitting   <= pause_frame_transmitting;
          pfc_frame_transmitting     <= pfc_frame_transmitting;
        end
        tx_pause_zero_held        <= tx_pause_zero_held;
        tx_pfc_pri_held           <= tx_pfc_pri_held;
        tx_pfc_zero_held          <= tx_pfc_zero_held;
      end
    end
  end

  // Optional parity
  generate if (p_edma_asf_dap_prot == 1) begin : gen_pfc_par
    reg tx_pfc_pri_held_par_r;
    reg pause_pfc_pri_vector_sched_par_r;
    always@(posedge tx_clk or negedge n_txreset)
    begin
      if (~n_txreset)
      begin
        pause_pfc_pri_vector_sched_par_r  <= 1'b0;
        tx_pfc_pri_held_par_r             <= 1'b0;
      end
      else if (~en_transmit_sync)
      begin
        pause_pfc_pri_vector_sched_par_r  <= 1'b0;
        tx_pfc_pri_held_par_r             <= 1'b0;
      end
      else if (pause_request)
      begin
        if (allow_pause)
          tx_pfc_pri_held_par_r             <= pause_pfc_pri_vector_par;
        else
          pause_pfc_pri_vector_sched_par_r  <= pause_pfc_pri_vector_par;
      end
      else if (pause_request_sched & allow_pause)
        tx_pfc_pri_held_par_r <= pause_pfc_pri_vector_sched_par_r;
    end
    assign tx_pfc_pri_held_par  = tx_pfc_pri_held_par_r;
  end else begin : gen_no_pfc_par
    assign tx_pfc_pri_held_par  = 1'b0;
  end
  endgenerate



// Pausing of transmission
//------------------------

   // synchronise pause_enable from the network configuration register
   // to tx_clk.
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_pause_enable (
      .clk(tx_clk),
      .reset_n(n_txreset),
      .din(pause_enable),
      .dout(pause_enable_sync));

   // synchronise new_pause_tog from gem_rx to tx_clk.
   edma_sync_toggle_detect i_edma_sync_toggle_detect_new_pause_tog (
      .clk(tx_clk),
      .reset_n(n_txreset),
      .din(new_pause_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge(load_new_pause_time));


   // decrement the pause time counter whenever it is non-zero
   // providing gem_tx has indicated that transmission has paused.
   assign decrement_pause_time = ~pause_time_zero_dec & tx_paused;


   // preset pause quantum counter whenever a new pause time value
   // is loaded or when the pause time counter is decremented.
   assign preset_count_512 = load_new_pause_time |
                             (decrement_pause_time & (count_512 == 7'h00));


   // counter for pause quantum.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if(~n_txreset)
         // asynchronous reset.
         count_512 <= 7'h00;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         count_512 <= 7'h00;
      else if (~pause_enable_sync)
         // disable pause for reception.
         count_512 <= 7'h00;
      else if (preset_count_512 & tx_byte_mode)
         // load bit time count in tx_byte_mode.
         count_512 <= 7'h3f;  // 64 tx_clks in byte mode.
      else if (preset_count_512)
         // load bit time count in 10/100 mode.
         count_512 <= 7'h7f;  // 128 tx_clks in nibble mode.
      else if (decrement_pause_time)
         // count down if pause_time is non-zero.
         count_512 <= count_512 - 7'h01;
      else
         // hold count once zero.
         count_512 <= count_512;
   end


   // Update and decrement pause time register (next value).
   // Also indicate when pause timer is changing value so pclk can be updated.
   always@(en_transmit_sync or pause_enable_sync or load_new_pause_time or
           new_pause_time or decrement_pause_time or retry_test_sync1 or
           count_512 or tx_pause_time_cnt)
   begin
      if (~en_transmit_sync)
         begin
            // synchronous reset (from software).
            tx_pause_tim_cnt_nxt = 16'h0000;
            tx_pause_time_change = 1'b0;
         end
      else if (~pause_enable_sync)
         begin
            // disable pause for reception.
            tx_pause_tim_cnt_nxt = 16'h0000;
            tx_pause_time_change = 1'b0;
         end
      else if (load_new_pause_time)
         begin
            // new pause quantum received from rx.
            tx_pause_tim_cnt_nxt = new_pause_time;
            tx_pause_time_change = 1'b1;
         end
      else if (decrement_pause_time & retry_test_sync1)
         begin
            // test mode, decrement every clock until zero.
            tx_pause_tim_cnt_nxt = tx_pause_time_cnt - 16'h0001;
            tx_pause_time_change = 1'b1;
         end
      else if (decrement_pause_time & (count_512 == 7'h00))
         begin
            // decrement every 512 bit times
            tx_pause_tim_cnt_nxt = tx_pause_time_cnt - 16'h0001;
            tx_pause_time_change = 1'b1;
         end
      else
         begin
            // hold pause count at zero.
            tx_pause_tim_cnt_nxt = tx_pause_time_cnt;
            tx_pause_time_change = 1'b0;
         end
   end

   // update and decrement pause time register (current value).
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if(~n_txreset)
         tx_pause_time_cnt <= 16'h0000;
      else
         tx_pause_time_cnt <= tx_pause_tim_cnt_nxt;
   end


   // decode when pause timer reaches zero
   assign pause_time_zero_dec = (tx_pause_time_cnt == 16'h0000);


   // EEE stuff
   // Need to pause transmission after deassertion of tx_lpi_en.
   // Load system wake time from tw_sys_tx_time register into sys_waking
   // counter on assertion of tx_lpi_en and then count down after deassertion.
   // The value loaded is multiplied by 8 and decremented every tx_clk cycle.
   // This means tw_sys_tx_time counts 64ns periods (8 * 8ns) in gigabit mode,
   // 320ns periods (8 * 40ns) in 100M mode and 3200ns periods at 10M.
   // Transmission will be paused until sys_waking counter reaches zero.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if(~n_txreset)
         // asynchronous reset.
         sys_waking <= 19'h00000;
         // do not reset on ~en_transmit_sync - user might want to disable transmit along with asserting and deasserting tx_lpi_en
      else if (tx_lpi_en_sync)
         // load wake time.
         sys_waking <= {tw_sys_tx_time,3'h0};
      else if (sys_waking != 19'h00000)
         sys_waking <= sys_waking - 19'h00001;
      else
         // hold count once zero.
         sys_waking <= sys_waking;
   end

   // pause_tx set when pause is enabled and the pause time counter
   // is non-zero. this signal stops gem_tx commencing a new frame
   // transmission whilst the counter is set, although any currently
   // executing frames will be completed.
   // Also pause transmission when sys_waking is non zero or tx_lpi_en is active
   assign pause_tx = (pause_enable_sync & ~pause_time_zero_dec) || (sys_waking != 19'h00000) || tx_lpi_en_sync;



   // tx_pause_time_tog indication to register block.
   // Indication is sent whenever a new pause frame is received or when the
   // pause timer decrements.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if(~n_txreset)
         begin
            // asynchronous reset.
            tx_pause_time_tog    <= 1'b0;
            tx_pause_time        <= 16'h0000;
            tx_pause_tog_in_prog <= 1'b0;
            tx_pause_tog_pending <= 1'b0;
         end
      else if (~en_transmit_sync | ~pause_enable_sync)
         begin
            // synchronous reset or pause disabled for reception.
            tx_pause_time_tog    <= tx_pause_time_tog;
            tx_pause_time        <= 16'h0000;
            tx_pause_tog_in_prog <= 1'b0;
            tx_pause_tog_pending <= 1'b0;
         end
      else if (pause_tog_ack_edge & (tx_pause_tog_pending |
                                     tx_pause_time_change))
         begin
            // acknowledge seen and have new change pending
            tx_pause_time_tog    <= ~tx_pause_time_tog;
            tx_pause_time        <= tx_pause_tim_cnt_nxt;
            tx_pause_tog_in_prog <= 1'b1;
            tx_pause_tog_pending <= 1'b0;
         end
      else if (pause_tog_ack_edge)
         begin
            // acknowledge seen and no new change pending
            tx_pause_time_tog    <= tx_pause_time_tog;
            tx_pause_time        <= tx_pause_time;
            tx_pause_tog_in_prog <= 1'b0;
            tx_pause_tog_pending <= 1'b0;
         end
      else if (tx_pause_time_change & ~tx_pause_tog_in_prog)
         begin
            // signal new pause time value to pclk
            tx_pause_time_tog    <= ~tx_pause_time_tog;
            tx_pause_time        <= tx_pause_tim_cnt_nxt;
            tx_pause_tog_in_prog <= 1'b1;
            tx_pause_tog_pending <= 1'b0;
         end
      else if (tx_pause_time_change)
         begin
            // new pause time but busy, store as pending
            tx_pause_time_tog    <= tx_pause_time_tog;
            tx_pause_time        <= tx_pause_time;
            tx_pause_tog_in_prog <= 1'b1;
            tx_pause_tog_pending <= 1'b1;
         end
      else
         begin
            // maintain values
            tx_pause_time_tog    <= tx_pause_time_tog;
            tx_pause_time        <= tx_pause_time;
            tx_pause_tog_in_prog <= tx_pause_tog_in_prog;
            tx_pause_tog_pending <= tx_pause_tog_pending;
         end
   end


   // synchronise tx_pause_time_tog acknowledge from registers.
   edma_sync_toggle_detect i_edma_sync_toggle_detect_ (
      .clk(tx_clk),
      .reset_n(n_txreset),
      .din(tx_pause_tog_ack),
      .rise_edge(),
      .fall_edge(),
      .any_edge(pause_tog_ack_edge));



   // generate fifo_underrun until end of frame.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         fifo_underrun     <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         fifo_underrun     <= 1'b0;
      else if (underflow)
         // fifo_underrun condition is not detected
         // during pause frame transmission.
         fifo_underrun     <= 1'b1;
      else if (end_frame)
         // clear flag at end of frame.
         fifo_underrun     <= 1'b0;
      else
         // hold flag state until end of frame.
         fifo_underrun     <= fifo_underrun;
   end


   // generate fifo_err_underrun until end of frame.
   // Used to force correct status report depending if underflow was caused
   // by tx_r_err asserted or tx_r_underflow.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         fifo_err_underrun     <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         fifo_err_underrun     <= 1'b0;
      else if (err_underflow)
         // fifo_err_underrun condition is not detected
         // during pause frame transmission.
         fifo_err_underrun     <= 1'b1;
      else if (end_frame)
         // clear flag at end of frame.
         fifo_err_underrun     <= 1'b0;
      else
         // hold flag state until end of frame.
         fifo_err_underrun     <= fifo_err_underrun;
   end


   // synchronize tx_lpi_en for metastability.
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tx_lpi_en (
      .clk(tx_clk),
      .reset_n(n_txreset),
      .din(tx_lpi_en),
      .dout(tx_lpi_en_sync));


   // assert txd output. txd contains either nibble or
   // byte data depending on the mode. assert tx_en output
   // derived from mac_tx_state block. assert tx_er with
   // tx_en during tx fifo underrun.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         begin
            txd     <= 8'h00;
            tx_en   <= 1'b0;
            tx_er   <= 1'b0;
         end
      else if (tx_lpi_en_sync)
         begin
            txd     <= 8'h01;
            tx_en   <= 1'b0;
            tx_er   <= 1'b1;
         end
      else
         // mii/gmii registered outputs from module.
         begin
            txd     <= txd_next[7:0];
            tx_en   <= tx_en_next | bp_active;
            tx_er   <= tx_er_next;
         end
   end

   generate if (p_edma_asf_dap_prot == 1) begin : gen_txd_par
     reg  txd_par_r;
     always@(posedge tx_clk or negedge n_txreset)
     begin
      if (~n_txreset)
        txd_par_r <= 1'b0;
      else if (tx_lpi_en_sync)
        txd_par_r <= 1'b1;
      else
        txd_par_r <= txd_next[8];
     end
     assign txd_par = txd_par_r;
   end else begin : gen_no_txd_par
     assign txd_par = 1'b0;
   end
   endgenerate

   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
      begin
         frame_size_buf <= 14'h0000;
         txd_frame_size <= 14'h0000;
      end
      else
      begin
        if (tx_r_sop)
          frame_size_buf <= tx_r_frame_size_mux;
        txd_frame_size <= frame_size_buf;
      end
   end

   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         mac_txing_dma_frame <= 1'b0;
      else if (tx_lpi_en_sync)
         mac_txing_dma_frame <= 1'b0;
      else if (bp_active)
         mac_txing_dma_frame <= 1'b0;
      else
         mac_txing_dma_frame <= (tx_en_next & txd_rdy & ~pfc_or_pause_frame_transmitting) | (interframe_gap & ifg_eats_qav_credit);
   end


   // synchronize dma_tx_status_tog for metastability. This signal
   // toggles each time the dma block has taken frame status
   // information and is used by the tx module to reset the status
   // outputs following resynchronization.
   edma_sync_toggle_detect i_edma_sync_toggle_detect_dma_tx_status_tog (
      .clk(tx_clk),
      .reset_n(n_txreset),
      .din(dma_tx_status_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge(dma_status_edge));


   // synchronise tx_status_wr_tog for metastability. This signal
   // toggles each time the registers block has taken frame status
   // information and is used by the tx module to reset the status
   // outputs following resynchronization.
   edma_sync_toggle_detect i_edma_sync_toggle_detect_tx_status_wr_tog (
      .clk(tx_clk),
      .reset_n(n_txreset),
      .din(tx_status_wr_tog),
      .rise_edge(),
      .fall_edge(),
      .any_edge(tx_status_edge));


   // work out how many bytes are valid in new transmit data.
   // tx_r_mod only valid when set with tx_r_eop and tx_r_mod.
   // otherwise data size determined by dma_bus_width.
   always@(tx_r_valid or tx_r_eop or tx_r_mod or dma_bus_width)
   begin
      if (tx_r_valid & tx_r_eop)
         case (dma_bus_width[1:0])
            // 32-bit transmit data bus.
            2'b00: begin
                      if ((tx_r_mod[1:0] == 2'b00)) // 4 bytes valid.
                         no_of_valid_bytes = 5'b00100;
                      else // 1-3 bytes valid.
                         no_of_valid_bytes = {3'b000,tx_r_mod[1:0]};
                   end
            // 64-bit transmit data bus.
            2'b01: begin
                      if (tx_r_mod[2:0] == 3'b000) // 8 bytes valid.
                         no_of_valid_bytes = 5'b01000;
                      else // 1-7 bytes valid.
                         no_of_valid_bytes = {2'b00,tx_r_mod[2:0]};
                   end
            // 128-bit transmit data bus.
            default: begin
                        if (tx_r_mod == 4'h0) // 16 bytes valid.
                           no_of_valid_bytes = 5'b10000;
                        else // 1-15 bytes valid.
                           no_of_valid_bytes = {1'b0,tx_r_mod[3:0]};
                     end
         endcase
      else if (tx_r_valid & ~tx_r_eop)
         case (dma_bus_width[1:0])
            2'b00: no_of_valid_bytes   = 5'b00100;   // 32-bit data bus.
            2'b01: no_of_valid_bytes   = 5'b01000;   // 64-bit data bus.
            default: no_of_valid_bytes = 5'b10000;   // 128-bit data bus.
         endcase
      else
         no_of_valid_bytes = 5'b00000;
   end




generate if (p_edma_tsu == 1) begin : gen_tsu

   reg           ptp_cap_v1_long;         // indicates PTP version 1 TS may be inserted
   reg           ptp_cap_v2_long;         // indicates PTP version 2 TS may be inserted
   reg     [3:0] tx_ts_insert_count_ptp_r;
   wire          tsu_timer_safe_to_sample_c; // Qualifer
   reg           sof_tx_tog;                 // Toggle version of sof_tx
   wire          sof_tx_sync;                // 2nd Sync flop for sof_tx (into tsu_clk)
   reg           sof_tx_sync_d1;             // delayed flop for rising edge detect
   wire          tx_sof_pclk;
   reg           tx_ts_insert_ptp_v1_c;     // indicates PTP version 1 TS will be inserted
   reg           tx_ts_insert_ptp_v2_c;     // indicates PTP version 2 TS will be inserted
   reg           tx_ts_update_cor_fld_c;    // indicates PTP version 2 correction field will be updated

   // tx_clk domain outputs
   wire          one_step_sync_mode_sync,oss_correction_field_sync_r,tx_sof_tsu;
   reg    [77:0] tsu_ptp_tx_timer_out_r;
   reg     [6:0] ptp_timestamp_position_latch; // latched timestamp position value
   reg    [77:0] tx_r_timestamp_r;
   reg    [55:0] correction_field;
   reg    [48:0] correction_field_int;
   wire   [47:0] cf_ns_reordered;
   wire   [48:0] cf_ns_add_eg_ts;
   reg    [49:0] eg_ts_sub_cf_ns;


   always@(posedge tx_clk or negedge n_txreset)
   begin
    if (~n_txreset)
       begin
          ptp_cap_v1_long <= 1'b0;
          ptp_cap_v2_long <= 1'b0;
          tx_ts_insert_count_ptp_r <= 4'b0000;
       end
    else if (~tx_en | ~en_transmit_sync)
       begin
          tx_ts_insert_count_ptp_r <= 4'b0000;
          ptp_cap_v1_long <= 1'b0;
          ptp_cap_v2_long <= 1'b0;
       end
    else
      begin
          if (en_tx_ptp_count & ~nibble_sel & (data_type == TYPE_DATA))
            begin
              if (((tx_ts_insert_ptp_v1) || (tx_ts_insert_ptp_v2) || (tx_ts_update_cor_fld)))
                begin
                  // this will only increment to a maximum of 4'b1001 at which point tx_ts_insert_ptp_v2 will go low
                  tx_ts_insert_count_ptp_r <= tx_ts_insert_count_ptp_r + 4'b0001;
                end
            end
        if (ptp_timestamp_position_cap == 1'b1)
           ptp_cap_v2_long <= 1'b1;

        if (ptp_timestamp_position_cap_v1 == 1'b1)
           ptp_cap_v1_long <= 1'b1;
       end
   end
   assign tx_ts_insert_count_ptp  = tx_ts_insert_count_ptp_r;

  // capture timestamp bytes for ease of use later
  // for PTP version 1 there is an 8B TS
  // for PTP version 2 there is an 10B TS
  // format in PTP TS format 48b sec, 32b nsec (ie top 2b of nsec = 2'b00)
  assign tsu_ptp_tx_ts_latched = {tsu_timer_sampled_on_sof_safe[77:30], 2'b00, tsu_timer_sampled_on_sof_safe[29:0]};

  // reorder correction field bytes before doing addition because most significant byte of correction is transmitted first
  assign cf_ns_reordered = {correction_field[7:0],correction_field[15:8],correction_field[23:16],correction_field[31:24],correction_field[39:32],correction_field[47:40]};

  // add egress time stamp nanoseconds to the correction field
  assign cf_ns_add_eg_ts = cf_ns_reordered + {18'h00000,tsu_timer_sampled_on_sof_safe[29:0]};

  // subtract correction field from egress time stamp nanoseconds and add one billion if the seconds value has rolled over
  // (correction_field[48] ^ tsu_timer_sampled_on_sof_safe[30]) indicates seconds bit roll-over
  always @(*)
  begin
    if (correction_field[48] ^ tsu_timer_sampled_on_sof_safe[30])
      eg_ts_sub_cf_ns = {18'h00000,tsu_timer_sampled_on_sof_safe[29:0]} - cf_ns_reordered + 48'd1000000000;
    else
      eg_ts_sub_cf_ns = {2'd0,{{18'h00000,tsu_timer_sampled_on_sof_safe[29:0]} - cf_ns_reordered}};
  end


   always@(*)
   begin
      if (correction_field[54])
         // negative number indicated so subtract correction field from the egress timestamp
         correction_field_int = {1'b0,eg_ts_sub_cf_ns[47:0]};
      else if (correction_field[48] ^ tsu_timer_sampled_on_sof_safe[30])
         // add an extra billion because the seconds value has rolled over
         correction_field_int = cf_ns_add_eg_ts[47:0] + 48'd1000000000;
      else
         // just do a simple addition
         correction_field_int = {1'b0,cf_ns_add_eg_ts[47:0]};
   end

   assign correction_field_new  = (correction_field[55] | correction_field_int[47]) ? 64'h7FFFFFFFFFFFFFFF
                                                                                    : {correction_field_int[47:0],16'h0000};

  // In order to support single step timestamp insertion with maximum accuracy, the timstamp
  // must be captured based on the tx_sof event, passed into the TSU clock. that way the timestamp
  // can be accurately captured asap.  the captured TS must then be passed back to the TX clock for
  // insertion into the timestamp.
  // Timestamp location for PTPoE is offset 48 (34 of PTP frame + 14 ethernet header)
  // It is > than this for PTPoIP, so use PTPoE as worst case
  // Minimum sized ethernet frame is 64bytes
  // By enforcing the rule that TSU clock is > 1/8th the frequency of TX_CLK, this allows for 6 TSU clocks
  // to create a toggle signal on tx_sof, pass into TSU domain and sample the TS into a stable bank of registers.
  // This final register bank will be stable for an entire frame, i.e. >= 64 tx_clks. It will also be stable at
  // the point this module needs to sample it for insertion into the frame, and it will be stable at the point
  // gem_dma_pbuf_tx_rd.v needs to sample it on tx_r_eop.

  // first synchronize the SOF event to the TSU clock domain
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_sof_tx_tog (
     .clk    (tsu_clk),
     .reset_n(n_tsureset),
     .din    (sof_tx_tog),
     .dout   (sof_tx_sync)
   );

  // register sof_tx_sync for edge detection
  always@(posedge tsu_clk or negedge n_tsureset)
    if (~n_tsureset)
      sof_tx_sync_d1  <= 1'b0;
    else
      sof_tx_sync_d1  <= sof_tx_sync;

  // detect the SOF event in TSU clock domain
  assign tx_sof_tsu = sof_tx_sync_d1 ^ sof_tx_sync;

  // sample the time in TSU clock domain.  This will remain valid for an entire frame
  // from sof_tx to next sof_tx
  reg [77:0]  tsu_timer_sampled_on_sof_r;
  always@(posedge tsu_clk or negedge n_tsureset)
  begin
    if (~n_tsureset)
      tsu_timer_sampled_on_sof_r  <= {78{1'b0}};
    else if (tx_sof_tsu)
      tsu_timer_sampled_on_sof_r  <= tsu_timer_cnt[93:16];
  end

  if (p_edma_asf_dap_prot == 1) begin : gen_tsu_par
    reg [9:0] tsu_timer_par_sampled_on_sof_r;
    reg [9:0] tsu_ptp_tx_timer_par_out_r;
    reg [9:0] tx_r_timestamp_par_r;

    always@(posedge tsu_clk or negedge n_tsureset)
    begin
      if (~n_tsureset)
        tsu_timer_par_sampled_on_sof_r  <= {10{1'b0}};
      else if (tx_sof_tsu)
        tsu_timer_par_sampled_on_sof_r  <= tsu_timer_cnt_par[11:2];
    end

    always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        tsu_ptp_tx_timer_par_out_r  <= {10{1'b0}};
      else if (tx_sof_pclk)
        tsu_ptp_tx_timer_par_out_r  <= tsu_timer_par_sampled_on_sof_r;
    end

    always@(posedge tx_clk or negedge n_txreset)
    begin
      if (~n_txreset)
        tx_r_timestamp_par_r  <= {10{1'b0}};
      else if (~en_transmit_sync)
        tx_r_timestamp_par_r  <= {10{1'b0}};
      else if (end_frame)
        tx_r_timestamp_par_r  <= tsu_timer_par_sampled_on_sof_safe;
    end
    assign tsu_timer_par_sampled_on_sof_safe = tsu_timer_par_sampled_on_sof_r & {10{tsu_timer_safe_to_sample}};
    assign tsu_ptp_tx_timer_par_out     = tsu_ptp_tx_timer_par_out_r;
    assign tx_r_timestamp_par           = tx_r_timestamp_par_r;
  end else begin : gen_no_tsu_par
    assign tsu_timer_par_sampled_on_sof_safe = {10{1'b0}};
    assign tsu_ptp_tx_timer_par_out     = {10{1'b0}};
    assign tx_r_timestamp_par           = {10{1'b0}};
  end

  edma_sync_toggle_detect i_edma_sync_toggle_detect_safe_to_sample (
    .clk(tx_clk),
    .reset_n(n_txreset),
    .din(sof_tx_sync_d1),
    .rise_edge(),
    .fall_edge(),
    .any_edge(tsu_timer_safe_to_sample_c));

   reg tsu_timer_safe_to_sample_r;
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
        tsu_timer_safe_to_sample_r <= 1'b0;
      else if (tsu_timer_safe_to_sample_c)
        tsu_timer_safe_to_sample_r <= 1'b1;
      else if (data_type == TYPE_SFD)
        tsu_timer_safe_to_sample_r <= 1'b0;
   end
   assign tsu_timer_safe_to_sample = tsu_timer_safe_to_sample_r;
   assign tsu_timer_sampled_on_sof_safe = tsu_timer_sampled_on_sof_r & {78{tsu_timer_safe_to_sample_r}};

  // Now synchonize to pclk
  edma_sync_toggle_detect i_edma_sync_toggle_detect_sof_tx_sync_d1 (
    .clk(pclk),
    .reset_n(n_preset),
    .din(sof_tx_sync_d1),
    .rise_edge(),
    .fall_edge(),
    .any_edge(tx_sof_pclk));

  always@(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      tsu_ptp_tx_timer_out_r  <= {78{1'b0}};
    else if (tx_sof_pclk)
      tsu_ptp_tx_timer_out_r  <= tsu_timer_sampled_on_sof_r;
  end

  // generate delayed signals
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_one_step_sync_mode (
      .clk(tx_clk),
      .reset_n(n_txreset),
      .din(one_step_sync_mode),
      .dout(one_step_sync_mode_sync));

   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_oss_correction_field (
      .clk(tx_clk),
      .reset_n(n_txreset),
      .din(oss_correction_field),
      .dout(oss_correction_field_sync_r));

   // mark position for TS insertion for 10 bytes which is maximum no of TS bytes
   // (where TS is 10 bytes for ptp version 2, and 8 bytes for ptp version 1)
   // the _early signal compares one count less (ie no_of_valid_bytes less)
   // and is then registered to improve timing
   wire [7:0] ptp_ts_position_latch_p10;
   wire [7:0] ptp_ts_position_latch_p8;

   assign ptp_ts_position_latch_p10 = ptp_timestamp_position_latch + 7'd10;
   assign ptp_ts_position_latch_p8  = ptp_timestamp_position_latch + 7'd8;

   always@(*)
   begin
      // identify bytes to be replaced

      if ((tx_ptp_count >= ptp_timestamp_position_latch) &
          (tx_ptp_count < ptp_ts_position_latch_p8[6:0]))

         tx_ts_insert_ptp_v1_c = (ptp_cap_v1_long & one_step_sync_mode_sync);
      else
         tx_ts_insert_ptp_v1_c = 1'b0;

      if ((tx_ptp_count >= ptp_timestamp_position_latch) &
          (tx_ptp_count < ptp_ts_position_latch_p10[6:0]))

         tx_ts_insert_ptp_v2_c = (ptp_cap_v2_long & one_step_sync_mode_sync);
      else
         tx_ts_insert_ptp_v2_c = 1'b0;

      if ((tx_ptp_count >= (ptp_timestamp_position_latch - 7'd26)) &
          (tx_ptp_count < (ptp_timestamp_position_latch - 7'd18)))

         tx_ts_update_cor_fld_c = (ptp_cap_v2_long & oss_correction_field_sync_r);
      else
         tx_ts_update_cor_fld_c = 1'b0;
   end
   assign tx_ts_insert_ptp_v1 = tx_ts_insert_ptp_v1_c;
   assign tx_ts_insert_ptp_v2 = tx_ts_insert_ptp_v2_c;
   assign tx_ts_update_cor_fld= tx_ts_update_cor_fld_c;

   always@(posedge tx_clk or negedge n_txreset)
     begin
      if (~n_txreset)
         begin
            sof_tx_tog <= 1'b0;
         end
      else if (~tx_en | ~en_transmit_sync)
         begin
            sof_tx_tog <= sof_tx_tog;
         end
      else if (data_type == TYPE_SFD)
         begin
            sof_tx_tog <= ~sof_tx_tog;
         end
     end

   // Determine location of timestamp in PTP sync frame in units of tx_ptp_count
   // set value to maximum at sof to avoid early tx_ts_insert being active early
   wire [7:0] ptp_timestamp_position_latch_p34;
   wire [7:0] ptp_timestamp_position_latch_p8;
   assign ptp_timestamp_position_latch_p34 = ptp_timestamp_position + 7'd34;
   assign ptp_timestamp_position_latch_p8  = ptp_timestamp_position + 7'd8;

   always@(posedge tx_clk or negedge n_txreset)
     begin
      if (~n_txreset)
         begin
           ptp_timestamp_position_latch  <= 7'h7f;
         end

      else
        if (ptp_timestamp_position_cap) // sync frame is recognized at the messageType field for version 2
           begin
             // ptp version 2 insertion point is 34 bytes after messageType field
             ptp_timestamp_position_latch  <= ptp_timestamp_position_latch_p34[6:0];
           end

        else if (ptp_timestamp_position_cap_v1) // sync frame is recognized at the control field for version 1
           begin
             // ptp version 1 insertion point is 8 bytes after control field
             ptp_timestamp_position_latch  <= ptp_timestamp_position_latch_p8[6:0];
           end

        else if (start_frame)
           begin
             ptp_timestamp_position_latch  <= 7'h7f;
           end
        else
           begin
             ptp_timestamp_position_latch  <= ptp_timestamp_position_latch;
           end
     end

   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
        // asynchronous reset.
        tx_r_timestamp_r         <= {78{1'b0}};
      else if (~en_transmit_sync)
        // synchronous reset (from software).
        tx_r_timestamp_r         <= {78{1'b0}};
      else if (end_frame)
        // this is actually a clock boundary, but is safe as tsu_timer_cnt will always be stable at this point
        tx_r_timestamp_r         <= tsu_timer_sampled_on_sof_safe;
   end

   // Seven bytes of the correction field need to be captured from transmit_data_buf. Six bytes represent the nanosecond value
   // and the least significant byte contains the least significant second bit from the ingress time stamp of the sync frame.
   // The correction field is captured 27 bytes before where the egress timestamp is situated as indicated by ptp_timestamp_position_latch
   always@(posedge tx_clk or negedge n_txreset)
     begin
      if (~n_txreset)
         begin
            correction_field <= {56{1'b0}};
         end
      else if ((tx_ptp_count == (ptp_timestamp_position_latch - 7'd27)) & sync_frame_tx)
         begin
            correction_field <= transmit_data_buf[63:8];
         end
     end

   assign oss_correction_field_sync = oss_correction_field_sync_r;
   assign tsu_ptp_tx_timer_out      = tsu_ptp_tx_timer_out_r;
   assign tx_r_timestamp            = tx_r_timestamp_r;

  ////////////////////////////////////////////////

end else begin : gen_no_tsu
   assign oss_correction_field_sync = 1'b0;
   assign tsu_ptp_tx_timer_out      = {78{1'b0}};
   assign tsu_ptp_tx_timer_par_out  = {10{1'b0}};
   assign tx_r_timestamp            = {78{1'b0}};
   assign tx_r_timestamp_par        = {10{1'b0}};
   assign tsu_timer_sampled_on_sof_safe  = {78{1'b0}};
   assign tsu_timer_par_sampled_on_sof_safe = {10{1'b0}};
   assign tsu_ptp_tx_ts_latched     = {80{1'b0}};
   assign tsu_timer_safe_to_sample  = 1'b0;
   assign correction_field_new      = {64{1'b0}};
   assign tx_ts_insert_ptp_v1       = 1'b0;
   assign tx_ts_insert_ptp_v2       = 1'b0;
   assign tx_ts_update_cor_fld      = 1'b0;
   assign tx_ts_insert_count_ptp    = 4'h0;
end
endgenerate


   // unused parts of transmit data bus tied to logic 0.
   always@(dma_bus_width or tx_r_data or tx_r_par)
   begin
      case (dma_bus_width)
         // 32-bit dma bus
         2'b00: begin
                  transmit_par  = { 12'd0, tx_r_par[3:0]};        // drop and pass some of the parity
                  transmit_data = { 96'd0, tx_r_data[31:0]};
                end
         // 64-bit dma bus
         2'b01: begin
                  transmit_par  = { 8'd0, tx_r_par[7:0]};         // drop and pass some of the parity
                  transmit_data = { 64'd0, tx_r_data[63:0]};
                end
         // 128-bit dma bus
         default: begin
                    transmit_par  = tx_r_par[15:0];
                    transmit_data = tx_r_data[127:0];
                  end
      endcase
   end


   // store number of bytes for first transfer of frame. This
   // is required as the previous frame is still propagating
   // through the tx and a new frame must be queued prior to
   // the end of frame trigger.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         new_frame_bytes <= 5'h00;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         new_frame_bytes <= 5'h00;
      else if (tx_r_valid & tx_r_sop)
         // first valid word of frame following tx_r_data_rdy.
         new_frame_bytes <= no_of_valid_bytes;
      else
         // hold the value from one frame to the next.
         new_frame_bytes <= new_frame_bytes;
   end


   // register tx_no_crc at start of packet.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         tx_no_crc_sop <= 1'b0;
      else if (~en_transmit_sync | collision_int | late_coll_occured |
               too_many_retries | fifo_underrun | stat_underflow_pend)
         // synchronous reset (from software).
         tx_no_crc_sop <= 1'b0;
      else if (tx_r_valid & tx_r_sop)
         // tx_no_crc is registered with sop for use with the
         // exposed fifo interface. It is assigned to bit[0] of tx_r_control
         tx_no_crc_sop <= tx_r_control;
      else
         // hold value from one frame to the next.
         tx_no_crc_sop <= tx_no_crc_sop;
   end

   // register tx_no_crc at start of frame.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         tx_no_crc_held <= 1'b0;
      else if (~en_transmit_sync | collision_int | late_coll_occured |
               too_many_retries | fifo_underrun | stat_underflow_pend)
         // synchronous reset (from software).
         tx_no_crc_held <= 1'b0;
      else if (start_frame)
         // tx_no_crc_held is registered with start_frame. this is required
         // as new frame is read from fifo interface prior to decision
         // in main tx state machine on whether the frame currently being
         // transmitted should include crc. hence tx_no_crc_held will
         // not be updated until new frame commences transmission.
         tx_no_crc_held <= tx_no_crc_sop;
      else
         // hold value from one frame to the next.
         tx_no_crc_held <= tx_no_crc_held;
   end


   // only assign tx_no_crc for data frames, not pause frames.
   assign tx_no_crc_valid = tx_no_crc_held & ~pfc_or_pause_frame_transmitting;


   // calculate number of stored bytes in transmit_data_buf.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         begin
           no_of_stored_bytes <= 5'h00;
         end
      else if (~en_transmit_sync | collision_int | late_coll_occured |
               too_many_retries | fifo_underrun | stat_underflow_pend)
         // synchronous reset (from software) or exception.
         begin
           no_of_stored_bytes <= 5'h00;
         end
      else if (pfc_or_pause_frame_transmitting)
         // store not used for tx of pause frames.
         begin
           no_of_stored_bytes <= no_of_stored_bytes;
         end
      else if (start_frame)
         // load new value at start of frame.
         begin
           no_of_stored_bytes <= new_frame_bytes;
         end
      else if (tx_r_valid & last_read & ~nibble_sel & (data_type == TYPE_DATA))
         // byte shift and load active at once, but last_read is blocking
         // new data being loaded until next start_of_frame, so just shift.
         begin
           no_of_stored_bytes <= no_of_stored_bytes - 5'h01;
         end
      else if (tx_r_valid & ~last_read & ~nibble_sel & (data_type == TYPE_DATA))
         // byte shift and load active at once, and last_read is not blocking
         // new data being loaded, so shift & load.
         begin
           no_of_stored_bytes <= no_of_str_bytes_nxt[4:0] - 5'h01;
         end
      else if (tx_r_valid & ~last_read & ((nibble_sel & (data_type == TYPE_DATA)) | (data_type == TYPE_PREAMBLE) | (data_type == TYPE_HOLD)))
         // no byte shift, but load active from tx fifo, and last_read is not
         // blocking new data being loaded, so just load (10/100 mode only)
         // also accommodate extra reads during pre-amble when doing single step update of the correction field
         begin
           no_of_stored_bytes <= no_of_str_bytes_nxt[4:0];
         end
      else if (~tx_r_valid & ~nibble_sel & (data_type == TYPE_DATA) & (no_of_stored_bytes != 5'h00))
         // byte shift active, but no load from tx fifo, so just shift.
         begin
           no_of_stored_bytes    <= no_of_stored_bytes - 5'h01;
         end
      else
         // no byte shift or load from tx fifo.
         begin
           no_of_stored_bytes    <= no_of_stored_bytes;
         end
   end


   // calculate last data byte in transmit_data_buf
   wire last_data_state_vld;
   assign last_data_state_vld = (data_type == TYPE_DATA | data_type == TYPE_HOLD);
   assign last_data =
             (last_data_state_vld &
                (((no_of_stored_bytes <= 5'h01) & last_read & ~nibble_sel &
                      ~pause_frame_transmitting & ~pfc_frame_transmitting) |
                 ((tx_pause_length == 6'h14) & (pause_frame_transmitting)) |
                 ((tx_pause_length == 6'h23) & (pfc_frame_transmitting))));


   // calculate next value for number of bytes stored in transmit_data_buf.
   assign no_of_str_bytes_nxt = no_of_stored_bytes + no_of_valid_bytes;


   // generate tx_r_flush_held and hold until buffer state machine has
   // detected it.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         tx_r_flush_held <= 1'b0;
      else if (~en_transmit_sync | buffer_state_bufinit)
         // synchronous reset (from software).
         tx_r_flush_held <= 1'b0;
      else if (tx_r_flushed)
         // flushed signal returned from fifo interface.
         tx_r_flush_held <= 1'b1;
      else if (buffer_state == R_BUF_RST2)
         // clear flag once buffer state machine has detected the flush.
         tx_r_flush_held <= 1'b0;
      else
         // else hold flag in its current state.
         tx_r_flush_held <= tx_r_flush_held;
   end

   // control logic for fetching data from transmit fifo and placing in the
   // input buffer stage of the gem_tx module.

   // synchronize tx_r_rd for output.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         tx_r_rd <= 1'b0;
      else
         // registered output.
         tx_r_rd <= tx_r_rd_int;
   end

   // synchronous part of buffer state machine.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset for buffer state machine.
         buffer_state <= R_BUF_INIT;
      else
         // state machine flip-flops.
         buffer_state <= buffer_state_next;
   end

   // asynchronous next state decode for buffer state machine.
   always@(*)
   begin
      // default values.
      tx_frame_ready  = 1'b0;
      tx_r_rd_int     = 1'b0;
      underflow       = 1'b0;
      err_underflow   = 1'b0;

      if (~en_transmit_sync)
         // synchronous reset for buffer state machine.
         buffer_state_next = R_BUF_INIT;
      else if (coll_occured | stat_underflow_pend)
         // state where the buffer control logic waits for the tx fifo to flush.
         buffer_state_next = R_BUF_RST1;
      else
         // decodes for next state of buffer state machine.
         case (buffer_state)

            R_RD_PEND_INIT:
               // state used to wait for valid response from fifo
               // interface, indicating word is available.
               begin
                  if (tx_r_underflow)
                     // underflow condition occurs which shouldn't
                     // happen in a properly configured system. SOP has not
                     // yet been read so goto flush state. This is impossible
                     // when using the DMA.
                     buffer_state_next = R_BUF_RST1;
                  else if (tx_r_valid & tx_r_err)
                     begin
                        // errored read, return to initialisation state.
                        buffer_state_next = R_IDLE1;
                     end
                  else if (tx_r_valid & tx_r_sop & tx_r_eop)
                     begin
                        // first word in frame with sop and eop.
                        tx_frame_ready = 1'b1;
                        buffer_state_next = R_FRAME_RDY_EOP;
                     end
                  else if (tx_r_valid & tx_r_sop & ~tx_r_eop)
                     begin
                        // first word in frame with sop.
                        tx_frame_ready = 1'b1;
                        buffer_state_next = R_FRAME_RDY;
                     end
                  else if (tx_r_valid & ~tx_r_sop)
                     // no sop, so keep reading the fifo.
                     buffer_state_next = R_BUF_INIT;
                  else
                     // wait for tx_r_valid response.
                     buffer_state_next = R_RD_PEND_INIT;
               end

            R_FRAME_RDY_EOP:
               // state used to wait for start_frame from
               // main tx state machine (fifo transfer with
               // sop and eop in same word).
               begin
                  tx_frame_ready = 1'b1;
                  if (start_frame & ~pfc_or_pause_frame_transmitting)
                     // start frame detected, and only one
                     // word transfered from fifo interface.
                     buffer_state_next = R_BUF_INIT;
                  else
                     // wait in current state for start frame.
                     buffer_state_next = R_FRAME_RDY_EOP;
               end

            R_FRAME_RDY:
               // state used to wait for start frame from main tx
               // state machine.
               begin
                  tx_frame_ready = 1'b1;
                  if (start_frame & ~pfc_or_pause_frame_transmitting)
                     // start frame detected, perform reads.
                     buffer_state_next = R_READ;
                  else
                     buffer_state_next = R_FRAME_RDY;
               end

            R_READ:
               // state whilst frame in progress, read the transmit fifo whilst 4 or fewer bytes available
               // or 11 if PTP sync correction field needs modification.
               // also do extra reads during pre-amble when 32 bit data and single step update of the correction field
               begin
                  if (((no_of_stored_bytes <= 5'b00100) | ((no_of_stored_bytes <= 5'b01011) & oss_correction_field_sync))
                                        & ((data_type == TYPE_DATA) | ((data_type == TYPE_PREAMBLE) & oss_correction_field_sync)))
                     begin
                        tx_r_rd_int = 1'b1;
                        buffer_state_next = R_RD_PEND;
                     end
                  else
                     // wait for less than 4 bytes available in
                     // the input buffer.
                     buffer_state_next = R_READ;
               end

            R_RD_PEND:
               // state waiting for r_valid response from fifo
               // interface.
               begin
                  if (tx_r_underflow)
                     begin
                        underflow = 1'b1;
                        buffer_state_next = R_BUF_RST1;
                     end
                  else if (tx_r_valid & tx_r_err)
                     begin
                        underflow = 1'b1;
                        err_underflow = 1'b1;
                        buffer_state_next = R_IDLE1;
                     end
                  else if (tx_r_valid & tx_r_eop)
                     // last byte of frame being read.
                     buffer_state_next = R_BUF_INIT;
                  // if you get two SOP's with no intervening EOP then force
                  // under-run to error the frame and stop the state machine
                  // locking up
                  else if (tx_r_valid & tx_r_sop)
                     begin
                        underflow = 1'b1;
                        err_underflow = 1'b1;
                        buffer_state_next = R_IDLE1;
                     end
                  else if (tx_r_valid & ~tx_r_eop)
                     // more bytes to read as not tx_r_eop.
                     buffer_state_next = R_READ;
                  else
                     // wait for tx_r_valid.
                     buffer_state_next = R_RD_PEND;
               end

            R_IDLE1:
               // state at end frame.
               begin
                  buffer_state_next = R_IDLE2;
               end

            R_IDLE2:
               // state at end frame.
               begin
                  buffer_state_next = R_BUF_INIT;
               end

            R_BUF_RST1:
               // state used to wait for fifo flush to start.
               begin
                  if (tx_r_flush_held & ~fifo_underrun)
                     // hold until fifo is cleared.
                     buffer_state_next = R_BUF_RST2;
                  else
                     // wait in current state.
                     buffer_state_next = R_BUF_RST1;
               end

            R_BUF_RST2:
               // state used to wait while fifo flush takes place.
               begin
                  if (~tx_r_flush_held)
                     // wait for tx_r_flushed to go inactive.
                     buffer_state_next = R_BUF_INIT;
                  else
                     // wait in current state.
                     buffer_state_next = R_BUF_RST2;
               end

            default: // R_BUF_INIT:
               // state from reset, wait for frame on fifo interface, indicated
               // by tx_r_data_rdy going high.
               begin
                  if (tx_r_data_rdy & ~tx_byte_mode &
                                           (no_of_stored_bytes <= 5'h04))
                     // wait for tx_r_data_rdy and input buffer
                     // has less than four bytes stored.
                     begin
                        buffer_state_next = R_RD_PEND_INIT;
                        tx_r_rd_int = 1'b1;
                     end
                  else if (tx_r_data_rdy & tx_byte_mode &
                           (no_of_stored_bytes <= 5'h05))
                     // wait for tx_r_data_rdy and input buffer
                     // has less than five bytes stored.
                     begin
                        buffer_state_next = R_RD_PEND_INIT;
                        tx_r_rd_int = 1'b1;
                     end
                  else
                     // hold in current state.
                     buffer_state_next = R_BUF_INIT;
               end
         endcase
   end


   // decode when state is R_BUF_INIT. This is when the state machine does not
   // indicate any other valid state.
   assign buffer_state_bufinit = (buffer_state != R_RD_PEND_INIT) &
                                 (buffer_state != R_FRAME_RDY) &
                                 (buffer_state != R_FRAME_RDY_EOP) &
                                 (buffer_state != R_READ) &
                                 (buffer_state != R_RD_PEND) &
                                 (buffer_state != R_IDLE1) &
                                 (buffer_state != R_IDLE2) &
                                 (buffer_state != R_BUF_RST1) &
                                 (buffer_state != R_BUF_RST2);


   // use last_read to empty input buffer once last word
   // of frame has been read from transmit fifo.
   // last_read is set either when EOP or SOP is read and held until
   // start_frame is signalled. This prevents new data from a second frame
   // being recognised in transmit_data_buf until ready to deal with second
   // frame.
   // one_read is used to signal an SOP and EOP read in same data word,
   // and is used to prevent last_read being reset at start_frame.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         begin
            last_read <= 1'b1;
            one_read  <= 1'b0;
         end
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         begin
            last_read <= 1'b1;
            one_read  <= 1'b0;
         end
      else if (tx_r_valid & tx_r_sop & tx_r_eop & ~tx_r_err)
         // only one word to be read from fifo for frame.
         begin
            last_read <= 1'b1;
            one_read  <= 1'b1;
         end
      else if (tx_r_valid & tx_r_sop & ~tx_r_eop & ~tx_r_err)
         // more than one word to be read from fifo for frame.
         begin
            last_read <= 1'b1;
            one_read  <= 1'b0;
         end
      else if (tx_r_valid & ~tx_r_sop & tx_r_eop & ~tx_r_err)
         // last read from fifo indicated.
         begin
            last_read <= 1'b1;
            one_read  <= 1'b0;
         end
      else if (start_frame & ~one_read)
         // hold until start of next frame.
         begin
            last_read <= 1'b0;
            one_read  <= 1'b0;
         end
      else
         // else maintain value.
         begin
            last_read <= last_read;
            one_read  <= one_read;
         end
   end


   // multiplex between pause data and frame data from external
   // fifo interface.
   always@( * )
   begin
      if (pause_frame_transmitting)
         // 802.3 pause frame data.
         begin
            tx_r_frame_size_mux = 14'd0;  // Pause is not used with pre-emption. These will never be pre-empted
            case (tx_pause_length)
               6'h01 : transmit_data_mux = {1'b1,8'h01};
               6'h02 : transmit_data_mux = {1'b1,8'h80};
               6'h03 : transmit_data_mux = {1'b1,8'hc2};
               6'h04 : transmit_data_mux = {1'b0,8'h00};
               6'h05 : transmit_data_mux = {1'b0,8'h00};
               6'h06 : transmit_data_mux = {1'b1,8'h01};
               6'h07 : transmit_data_mux = {spec_add1_par[0],spec_add1[7:0]};
               6'h08 : transmit_data_mux = {spec_add1_par[1],spec_add1[15:8]};
               6'h09 : transmit_data_mux = {spec_add1_par[2],spec_add1[23:16]};
               6'h0a : transmit_data_mux = {spec_add1_par[3],spec_add1[31:24]};
               6'h0b : transmit_data_mux = {spec_add1_par[4],spec_add1[39:32]};
               6'h0c : transmit_data_mux = {spec_add1_par[5],spec_add1[47:40]};
               6'h0d : transmit_data_mux = {1'b0,8'h88};
               6'h0e : transmit_data_mux = {1'b1,8'h08};
               6'h0f : transmit_data_mux = {1'b0,8'h00};
               6'h10 : transmit_data_mux = {1'b1,8'h01};
               6'h11 : transmit_data_mux =
                          (tx_pause_zero_held) ? {1'b0,8'h00} : {tx_pause_quant_par[1],tx_pause_quant[15:8]};
               6'h12 : transmit_data_mux =
                          (tx_pause_zero_held) ? {1'b0,8'h00} : {tx_pause_quant_par[0],tx_pause_quant[7:0]};
               default : transmit_data_mux = {1'b0,8'h00};
            endcase
         end
      else if (pfc_frame_transmitting)
         // PFC pause frame data.
         begin
            tx_r_frame_size_mux = 14'd0;  // Pause is not used with pre-emption. These will never be pre-empted
            case (tx_pause_length)
               6'h01 : transmit_data_mux = {1'b1,8'h01};
               6'h02 : transmit_data_mux = {1'b1,8'h80};
               6'h03 : transmit_data_mux = {1'b1,8'hc2};
               6'h04 : transmit_data_mux = {1'b0,8'h00};
               6'h05 : transmit_data_mux = {1'b0,8'h00};
               6'h06 : transmit_data_mux = {1'b1,8'h01};
               6'h07 : transmit_data_mux = {spec_add1_par[0],spec_add1[7:0]};
               6'h08 : transmit_data_mux = {spec_add1_par[1],spec_add1[15:8]};
               6'h09 : transmit_data_mux = {spec_add1_par[2],spec_add1[23:16]};
               6'h0a : transmit_data_mux = {spec_add1_par[3],spec_add1[31:24]};
               6'h0b : transmit_data_mux = {spec_add1_par[4],spec_add1[39:32]};
               6'h0c : transmit_data_mux = {spec_add1_par[5],spec_add1[47:40]};
               6'h0d : transmit_data_mux = {1'b0,8'h88};
               6'h0e : transmit_data_mux = {1'b1,8'h08};
               6'h0f : transmit_data_mux = {1'b1,8'h01};
               6'h10 : transmit_data_mux = {1'b1,8'h01};
               6'h11 : // priority enable upper byte
                       transmit_data_mux  = {1'b0,8'h00};
               6'h12 : // priority enable lower byte
                        transmit_data_mux = {tx_pfc_pri_held_par,tx_pfc_pri_held};

               6'h13 : //--- priority 0: timer0 upper byte ---
                       if (tx_pfc_zero_held[0]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par[1],tx_pause_quant[15:8]};

               6'h14 : //--- priority 0: timer0 lower byte ---
                    // puase quantum controlled from register
                       if (tx_pfc_zero_held[0]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par[0],tx_pause_quant[7:0]};


               6'h15 : //--- priority 1: timer1 upper byte ---
                       if (tx_pfc_zero_held[1]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p1[1],tx_pause_quant_p1[15:8]};

               6'h16 : //---- priority 1: timer1 lower byte  ---
                       if (tx_pfc_zero_held[1]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p1[0],tx_pause_quant_p1[7:0]};


               6'h17 : //--- priority 2: timer2 upper byte ---
                       if (tx_pfc_zero_held[2]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p2[1],tx_pause_quant_p2[15:8]};

               6'h18 : //--- priority 2: timer2 lower byte ----
                       if (tx_pfc_zero_held[2]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p2[0],tx_pause_quant_p2[7:0]};

               6'h19 : //--- priority 3: timer3 upper byte ---
                       if (tx_pfc_zero_held[3]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p3[1],tx_pause_quant_p3[15:8]};

               6'h1a : //--- priority 3: timer3 lower byte ---
                       if (tx_pfc_zero_held[3]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p3[0],tx_pause_quant_p3[7:0]};

               6'h1b : //--- priority 4: timer4 upper byte ---
                       if (tx_pfc_zero_held[4]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p4[1],tx_pause_quant_p4[15:8]};

               6'h1c : //--- priority 4: timer5 lower byte ---
                       if (tx_pfc_zero_held[4]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p4[0],tx_pause_quant_p4[7:0]};

               6'h1d : //--- priority 5: timer5 upper byte ---
                       if (tx_pfc_zero_held[5]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p5[1],tx_pause_quant_p5[15:8]};

               6'h1e : //--- priority 5: timer5 lower byte ---
                       if (tx_pfc_zero_held[5]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p5[0],tx_pause_quant_p5[7:0]};

               6'h1f : //--- priority 6: timer6 upper byte ---
                       if (tx_pfc_zero_held[6]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p6[1],tx_pause_quant_p6[15:8]};

               6'h20 : //--- priority 6: timer6 lower byte ---
                       if (tx_pfc_zero_held[6]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p6[0],tx_pause_quant_p6[7:0]};

               6'h21 : //--- priority 7: timer7 upper byte ---
                       if (tx_pfc_zero_held[7]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p7[1],tx_pause_quant_p7[15:8]};

               6'h22 : //--- priority 7: timer7 lower byte ---
                       if (tx_pfc_zero_held[7]) transmit_data_mux = {1'b0,8'h00};
                       else                     transmit_data_mux = {tx_pause_quant_par_p7[0],tx_pause_quant_p7[7:0]};

               default : transmit_data_mux = {1'b0,8'h00};
            endcase
         end
       else
       begin
         // normal frame data.
         tx_r_frame_size_mux = tx_r_frame_size;

         if (p_edma_tsu == 1)
         // or insert Timestamp for one step sync mode
         begin
            if (tx_ts_insert_ptp_v1 & tsu_timer_safe_to_sample)  // version 1 has 8B TS
              case (tx_ts_insert_count_ptp)
                4'd0 : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[7],tsu_ptp_tx_ts_latched[63:56]};
                4'd1 : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[6],tsu_ptp_tx_ts_latched[55:48]};
                4'd2 : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[5],tsu_ptp_tx_ts_latched[47:40]};
                4'd3 : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[4],tsu_ptp_tx_ts_latched[39:32]};
                4'd4 : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[3],tsu_ptp_tx_ts_latched[31:24]};
                4'd5 : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[2],tsu_ptp_tx_ts_latched[23:16]};
                4'd6 : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[1],tsu_ptp_tx_ts_latched[15: 8]};
                default : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[0],tsu_ptp_tx_ts_latched[ 7: 0]};

              endcase

            else if (tx_ts_insert_ptp_v2 & tsu_timer_safe_to_sample)  // version 2 has 10B TS
              case (tx_ts_insert_count_ptp)
                4'd0  : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[9],tsu_ptp_tx_ts_latched[79:72]};
                4'd1  : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[8],tsu_ptp_tx_ts_latched[71:64]};
                4'd2  : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[7],tsu_ptp_tx_ts_latched[63:56]};
                4'd3  : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[6],tsu_ptp_tx_ts_latched[55:48]};
                4'd4  : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[5],tsu_ptp_tx_ts_latched[47:40]};
                4'd5  : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[4],tsu_ptp_tx_ts_latched[39:32]};
                4'd6  : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[3],tsu_ptp_tx_ts_latched[31:24]};
                4'd7  : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[2],tsu_ptp_tx_ts_latched[23:16]};
                4'd8  : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[1],tsu_ptp_tx_ts_latched[15: 8]};
                default  : transmit_data_mux = {tsu_ptp_tx_ts_latched_par[0],tsu_ptp_tx_ts_latched[ 7: 0]};
              endcase

            else if (tx_ts_update_cor_fld)
              case (tx_ts_insert_count_ptp)
                4'd0 : transmit_data_mux = {correction_field_new_par[7],correction_field_new[63:56]};
                4'd1 : transmit_data_mux = {correction_field_new_par[6],correction_field_new[55:48]};
                4'd2 : transmit_data_mux = {correction_field_new_par[5],correction_field_new[47:40]};
                4'd3 : transmit_data_mux = {correction_field_new_par[4],correction_field_new[39:32]};
                4'd4 : transmit_data_mux = {correction_field_new_par[3],correction_field_new[31:24]};
                4'd5 : transmit_data_mux = {correction_field_new_par[2],correction_field_new[23:16]};
                4'd6 : transmit_data_mux = {correction_field_new_par[1],correction_field_new[15: 8]};
                default : transmit_data_mux = {correction_field_new_par[0],correction_field_new[ 7: 0]};
              endcase

            else
              transmit_data_mux = {transmit_par_buf[0],transmit_data_buf[7:0]};
         end
         else
            transmit_data_mux = {transmit_par_buf[0],transmit_data_buf[7:0]};
      end
   end


   // Load up transmit data buffer with 128 bits of new word transmit_data from the fifo interface.
   // The location loaded depends on the number of bytes remaining in the buffer "no_of_stored_bytes"

   // declare a helper signal
   wire [7:0] stored_bit_locn;
   assign stored_bit_locn = (no_of_stored_bytes*8);
   wire [7:0] stored_bit_locn_m1;
   assign stored_bit_locn_m1 = ((no_of_stored_bytes-1)*8);
   wire [4:0] no_of_stored_bytes_m1;
   assign no_of_stored_bytes_m1 = (no_of_stored_bytes-5'd1);
   always @*
   begin : transmit_data_buf_new_block  // need to name block if local variables are declared
   integer k1;
   integer k1p;
      if (no_of_stored_bytes == 5'b00000)
         begin
            transmit_data_buf_new = {{(384-128){1'b0}},transmit_data[127:0]};
         end
      else
         begin
            // load up 128 new bits from transmit_data preserving location of unchanged bits
/*
            for (k1=0; k1<p_tx_buf_width; k1 = k1+1)
               if ((k1 >= stored_bit_locn) & (k1 < stored_bit_locn + 128))) begin
                  transmit_data_buf_new[k1] = transmit_data[k1-stored_bit_locn];
               end else begin
                  transmit_data_buf_new[k1] = transmit_data_buf[k1];
               end
*/
            // load the new 128bits of transmit_data to the top of transmit_data_buf_new
            // Note that no_of_stored_bytes is a 5 bit vector, which theoretically implies
            // 31 bytes could be buffered. 31 bytes = 248 bits, but is stored in a 256bit vector called
            // stored_bit_locn. Since 128bits are loaded,
            // we need transmit_data_buf_new to be 384 bits wide ..
            // Note that since the databuffer itself is p_tx_buf_width
            // bits wide, which is 160 or 216 if TSU is defined, then we need to drop
            // the upper bits of transmit_data_buf_new
            transmit_data_buf_new = {{(384-p_tx_buf_width){1'b0}},transmit_data_buf};
            for (k1=0; k1<128; k1=k1+1)
              transmit_data_buf_new[k1[6:0]+stored_bit_locn] = transmit_data[k1[6:0]];
         end

      // shift the parity
      if (no_of_stored_bytes == 5'b00000)
         begin
            transmit_par_buf_new = {{((384/8)-16){1'b0}},transmit_par[15:0]};
         end
      else
         begin
            // load up 128 new bits from transmit_data preserving location of unchanged bits
/*
            for (k1p=0; k1p<(p_tx_buf_width/8); k1p = k1p+1)
               if ((k1p >= (no_of_stored_bytes)) & (k1p < (no_of_stored_bytes + 16))) begin
                  transmit_par_buf_new[k1p] = transmit_par[k1p-(no_of_stored_bytes)];
               end else begin
                  transmit_par_buf_new[k1p] = transmit_par_buf[k1p];
               end
*/
            transmit_par_buf_new = {{(384/8-p_tx_buf_width/8){1'b0}},transmit_par_buf};
            for (k1p=0; k1p<16; k1p=k1p+1)
              transmit_par_buf_new[k1p[3:0]+no_of_stored_bytes] = transmit_par[k1p[3:0]];
         end
   end

   // Load up transmit data buffer with 128 bits of new word transmit_data from the fifo interface, with a shift operation
   // The location loaded depends on the number of bytes remaining in the buffer "no_of_stored_bytes"
   always @*
   begin : transmit_data_buf_new_sh_block  // need to name block if local cariables are declared
   integer k2;
   integer k2p;
      if (no_of_stored_bytes == 5'b00000)
         begin
            transmit_data_buf_new_shift = {{(384-128){1'b0}},transmit_data[127:0]};
         end
      else
         begin
            // load up 128 new bits from transmit_data byte shifting location of unchanged bits
/*
            transmit_data_buf_new_shift[p_tx_buf_width-1:p_tx_buf_width-8] = 8'h00;
            for (k2=0; k2<p_tx_buf_width-8; k2 = k2+1)
               if ((k2 >= stored_bit_locn_m1) & (k2 < (stored_bit_locn_m1 + 128))) begin
                  transmit_data_buf_new_shift[k2] = transmit_data[k2-stored_bit_locn_m1];
               end else begin
                  transmit_data_buf_new_shift[k2] = transmit_data_buf[k2+8];
               end
*/
            transmit_data_buf_new_shift = {{(384+8-p_tx_buf_width){1'b0}},transmit_data_buf[p_tx_buf_width-1:8]};
            for (k2=0; k2<128; k2=k2+1)
              transmit_data_buf_new_shift[k2[6:0]+stored_bit_locn_m1] = transmit_data[k2[6:0]];
         end

      // shift the parity
      if (no_of_stored_bytes == 5'b00000)
         begin
            transmit_par_buf_new_shift = {{(384/8-16){1'b0}},transmit_par[15:0]};
         end
      else
         begin
            // load up 128 new bits from transmit_data byte shifting location of unchanged bits
/*
            transmit_par_buf_new_shift[p_tx_buf_width/8-1] = 1'b0;
            for (k2p=0; k2p<p_tx_buf_width/8-1; k2p = k2p+1)
               if ((k2p >= ((no_of_stored_bytes-1))) & (k2p < ((no_of_stored_bytes-1) + 16))) begin
                  transmit_par_buf_new_shift[k2p] = transmit_par[k2p-((no_of_stored_bytes-1))];
               end else begin
                  transmit_par_buf_new_shift[k2p] = transmit_par_buf[k2p+1];
               end
*/
            transmit_par_buf_new_shift = {{((384+8)/8-p_tx_buf_width/8){1'b0}},transmit_par_buf[p_tx_buf_width/8-1:1]};
            for (k2p=0; k2p<16; k2p=k2p+1)
              transmit_par_buf_new_shift[k2p[3:0]+no_of_stored_bytes_m1] = transmit_par[k2p[3:0]];
         end
   end

   always@(*)
   begin
      if (tx_r_sop & tx_r_valid & ~nibble_sel & (data_type == TYPE_DATA) &
               ~pfc_or_pause_frame_transmitting) begin
         // load up buffer with new word from fifo interface and perform
         // byte shift at the same time. previous frame active and first
         // word of next frame being loaded.
         transmit_data_buf_nxt  = transmit_data_buf_new_shift[p_tx_buf_width-1:0];
         transmit_par_buf_nxt   = transmit_par_buf_new_shift[p_tx_buf_width/8-1:0];
      end else if ((tx_r_sop | (data_type == TYPE_PREAMBLE | data_type == TYPE_HOLD)) & tx_r_valid) begin
         // load up buffer with new word from fifo interface. previous frame
         // completed or previous frame active and no shift taking place or
         // pause frame active during load.
         // also accommodate extra reads during pre-amble when doing single step update of the correction field
         transmit_data_buf_nxt  = transmit_data_buf_new[p_tx_buf_width-1:0];
         transmit_par_buf_nxt   = transmit_par_buf_new[p_tx_buf_width/8-1:0];
      end else if (pfc_or_pause_frame_transmitting) begin
         // pause frame being transmitted, hold values.
         transmit_data_buf_nxt  = transmit_data_buf;
         transmit_par_buf_nxt   = transmit_par_buf;
      end else if (start_frame) begin
         // propagate any error that occurred with sop.
         transmit_data_buf_nxt  = transmit_data_buf;
         transmit_par_buf_nxt   = transmit_par_buf;
      end else if ((data_type == TYPE_DATA) & ~nibble_sel & ~tx_r_valid) begin
         // shift buffer one byte location.
         transmit_data_buf_nxt  = {8'h00,transmit_data_buf[p_tx_buf_width-1:8]};
         transmit_par_buf_nxt   = {1'b0,transmit_par_buf[p_tx_buf_width/8-1:1]};
      end else if ((data_type == TYPE_DATA) & ~nibble_sel & tx_r_valid) begin
         // load up buffer with new word from fifo interface and perform
         // byte shift at the same time.
         transmit_data_buf_nxt  = transmit_data_buf_new_shift[p_tx_buf_width-1:0];
         transmit_par_buf_nxt   = transmit_par_buf_new_shift[p_tx_buf_width/8-1:0];
      end else if ((data_type == TYPE_DATA) & nibble_sel & tx_r_valid) begin
         // load up buffer with new word from fifo interface, frame active.
         transmit_data_buf_nxt  = transmit_data_buf_new[p_tx_buf_width-1:0];
         transmit_par_buf_nxt   = transmit_par_buf_new[p_tx_buf_width/8-1:0];
      end else begin
         // else hold current values.
         transmit_data_buf_nxt  = transmit_data_buf;
         transmit_par_buf_nxt   = transmit_par_buf;
      end
   end

   // load tx_fifo data into transmit_data_buf when buffer contains
   // contains four or less bytes or at the start of a new frame.
   // also generate pause frame data, if pause frame transmission
   // is in progress.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         transmit_data_buf <= {p_tx_buf_width{1'b0}};
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         transmit_data_buf <= {p_tx_buf_width{1'b0}};
      else
         // load up buffer with new word from fifo interface and perform
         // byte shift at the same time. previous frame active and first
         // word of next frame being loaded.
         transmit_data_buf <= transmit_data_buf_nxt;
   end

   generate if (p_edma_asf_dap_prot == 1) begin : gen_transmit_par_buf
     reg  [p_tx_buf_width/8-1:0]  transmit_par_buf_r;
     always@(posedge tx_clk or negedge n_txreset)
     begin
        if (~n_txreset)
           transmit_par_buf_r  <= {p_tx_buf_width/8{1'b0}};
        else if (~en_transmit_sync)
           transmit_par_buf_r  <= {p_tx_buf_width/8{1'b0}};
        else
           transmit_par_buf_r  <= transmit_par_buf_nxt;
     end
     assign transmit_par_buf = transmit_par_buf_r;
   end else begin : gen_no_transmit_par_buf
     assign transmit_par_buf = {p_tx_buf_width/8{1'b0}};
   end
   endgenerate

   // counts out nibbles to be transmitted from transmit_data.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         nibble_sel <= 1'b0;
      else if (((data_type == TYPE_SFD) | (data_type == TYPE_DATA) |
               (data_type == TYPE_JAM) | (data_type == TYPE_CRC) |
               (data_type == TYPE_FILL))
                & ~tx_byte_mode)
         // nibble mode, nibble select inverted every clock cycle.
         nibble_sel <= ~nibble_sel;
      else
         // tx not transmitting data or tx_byte_mode
         nibble_sel <= 1'b0;
   end


   // load txd_next depending on data_type and mode (10/100 or tx_byte_mode).
   always@(*)
   begin
      if (bp_active)
        begin
          txd_next[7:0] = 8'b11011101;
          txd_next[8]   = 1'b0;
          tx_er_next    = 1'b0;
        end
      else
      if (tx_byte_mode) // tx_byte_mode.
          case (data_type)
             TYPE_DATA:                // 0000.
                begin
                   txd_next[7:0]  = transmit_data_mux[7:0];
                   txd_next[8]    = transmit_data_mux[8];
                   tx_er_next     = fifo_underrun;
                end
             TYPE_CRC:                 // 0001.
                begin
                   txd_next[7:0]  = {~crc[24],~crc[25],~crc[26],~crc[27],
                                    ~crc[28],~crc[29],~crc[30],~crc[31]};
                   txd_next[8]    = crc_24_31_par;
                   tx_er_next     = 1'b0;
                end
             TYPE_PREAMBLE:            // 0010.
                begin
                   txd_next[7:0]  = 8'h55;
                   txd_next[8]    = 1'b0;
                   tx_er_next     = fifo_underrun;
                end
             TYPE_SFD:                 // 0011.
                begin
                   txd_next[7:0]  = 8'hd5;
                   txd_next[8]    = 1'b1;
                   tx_er_next     = fifo_underrun;
                end
             TYPE_JAM:                 // 0100.
                begin
                   txd_next[7:0]  = transmit_data_mux[7:0];
                   txd_next[8]    = transmit_data_mux[8];
                   tx_er_next     = fifo_underrun;
                end
             TYPE_CARRIER:             // 0101.
                begin
                   txd_next[7:0]  = 8'h0f;
                   txd_next[8]    = 1'b0;
                   tx_er_next     = 1'b1;
                end
             TYPE_FILL:                // 0110.
                begin
                   txd_next[7:0]  = 8'h00;
                   txd_next[8]    = 1'b0;
                   tx_er_next     = 1'b0;
                end
             TYPE_BURST_IFG:           // 0111.
                begin
                   txd_next[7:0]  = 8'h0f;
                   txd_next[8]    = 1'b0;
                   tx_er_next     = 1'b1;
                end
             TYPE_JAM_CE:              // 1001.
                begin
                   txd_next[7:0]  = 8'h1f;
                   txd_next[8]    = 1'b1;
                   tx_er_next     = 1'b1;
                end
             TYPE_HOLD:
                begin
                   txd_next[7:0]  = txd;
                   txd_next[8]    = txd_par;
                   tx_er_next     = tx_er;
                end
             default: // TYPE_IDLE (1000)
                begin
                   txd_next[7:0]  = 8'h00;
                   txd_next[8]    = 1'b0;
                   tx_er_next     = 1'b0;
                end
          endcase
      else // 10/100 mode.
          case (data_type)
             TYPE_DATA:                // 0000.
                begin
                   tx_er_next     = fifo_underrun;
                   if (nibble_sel) begin
                      txd_next[7:0]  = {4'h0,transmit_data_mux[3:0]};
                      txd_next[8]    = transmit_par_mux_3_0;
                   end else begin
                      txd_next[7:0]  = {4'h0,transmit_data_mux[7:4]};
                      txd_next[8]    = transmit_par_mux_7_4;
                   end
                end
             TYPE_CRC:                 // 0001.
                begin
                   txd_next[7:0]  = {4'h0,~crc[28],~crc[29],~crc[30],~crc[31]};
                   txd_next[8]    = crc_28_31_par;
                   tx_er_next     = 1'b0;
                end
             TYPE_PREAMBLE:            // 0010.
                begin
                   txd_next[7:0]  = 8'h05;
                   txd_next[8]    = 1'b0;
                   tx_er_next     = fifo_underrun;
                end
             TYPE_SFD:                 // 0011.
                begin
                   txd_next[7:0]  = 8'h0d;
                   txd_next[8]    = 1'b1;
                   tx_er_next     = fifo_underrun;
                end
             TYPE_JAM:                 // 0100.
                begin
                   txd_next[7:0]  = {4'h0,transmit_data_mux[3:0]};
                   txd_next[8]    = transmit_par_mux_3_0;
                   tx_er_next     = fifo_underrun;
                end
             TYPE_FILL:                // 0110.
                begin
                   txd_next[7:0]  = 8'h00;
                   txd_next[8]    = 1'b0;
                   tx_er_next     = 1'b0;
                end
             TYPE_HOLD:
                begin
                   txd_next[7:0]  = txd;
                   txd_next[8]    = txd_par;
                   tx_er_next     = tx_er;
                end
             default:
                begin
                   // Default is used to catch TYPE_IDLE (1000) and types
                   // which are not valid in 10/100 mode (TYPE_CARRIER,
                   // TYPE_BURST_IFG and TYPE_JAM_CE)
                   txd_next[7:0]  = 8'h00;
                   txd_next[8]    = 1'b0;
                   tx_er_next     = 1'b0;
                end
          endcase
   end


   // count down for preamble (7 bytes or 15 nibbles).
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         preamble_cnt <= 4'he;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         preamble_cnt <= 4'he;
      else if (~txd_rdy)
         preamble_cnt <= preamble_cnt;
      else if (tx_en_next & (preamble_cnt != 4'h0))
         // decrement preamble counter.
         preamble_cnt <= preamble_cnt - 4'h1;
      else if (tx_en_next & (preamble_cnt == 4'h0))
         // once zero, hold value.
         preamble_cnt <= preamble_cnt;
      else if (tx_byte_mode)
         // tx_byte_mode, count for 7 bytes
         preamble_cnt <= 4'h6;
      else
         // 10/100 mode, count for 15 nibbles.
         preamble_cnt <= 4'he;
   end


   // last_preamble goes to the transmit state machine to signal
   // end of the 7 bytes of preamble.
   assign last_preamble = (preamble_cnt == 4'h0);

   // count interframe gap. Interframe gap lasts 96 bit times.
   // This counter will count in nibbles (4-bits). If crs becomes
   // active in first 32 (was 64) bit times then reset interframe_cnt
   // and defer. If crs goes active in last 64 (was 32) bit time then don't defer.
   // gate crs_sync with ~int_end_frame (last 4 tx_clks) to stop deference
   // to crs produced by own transmitted frames.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         interframe_cnt <= 8'd0;
      else if (~en_transmit_sync)
         // synchronous reset.
         interframe_cnt <= 8'd0;
      else if ((~interframe_cnt[4] & ~interframe_cnt[3] & crs_sync & ~int_end_frame & first_frame)
                                 | start_ifg)
         // reset counter at start of ifg or when crs is detected during
         // first 32-bit (was 64) times of ifg. crs does not reset count when bursting
         // or during last four clock cycles after tx_en goes low (as you
         // don't want to defer to your own transmission).
         interframe_cnt <= 8'd0;
      else if (ifg_cnt_active | (interframe_cnt == 8'd0))
         // interframe gap count active.
         interframe_cnt <= interframe_cnt[6:0] + {6'd0,tx_byte_mode,~tx_byte_mode};
      else
         // interframe gap counter reached 96-bit times. (or 192 or 256 bit times)
         interframe_cnt <= interframe_cnt;
   end

   // check for completion of interframe_cnt
   // assign ifg_cnt_active = interframe_cnt < (min_ifg * 8);
   // and do look ahead to be sure timing is not compromised
   // note interframe_cnt counts nibbles rather than bytes
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         ifg_cnt_active <= 1'b1;
      else
         ifg_cnt_active <= (interframe_cnt < ((min_ifg * 8) - {6'd0,tx_byte_mode,~tx_byte_mode}));
   end

   assign interframe_gap = ifg_cnt_active | ipg_stretch | (interframe_cnt == 8'd0);


   // calculate stretch size. Although stretch_size counts nibbles in 10/100
   // mode and octets in gigabit mode we still end up with the IPG being
   // a multiple of the previous frames length including preamble. The
   // multiple will be (stretch_ratio[7:0])/(stretch_ratio[15:8]+1)
   // we need the "+1" to prevent divide by zero
   wire [24:0] stretch_size_p;
   assign stretch_size_p = stretch_size + {16'h0000,stretch_ratio[7:0]};
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         begin
            // asynchronous reset.
            stretch_size  <= 24'h000000;
            stretch_count <= 8'h00;
            ipg_stretch <= 1'b0;
         end
      else if (full_duplex & stretch_enable & (data_type != TYPE_IDLE) &
                                       (stretch_count == 8'h00))
         begin
            // only increment stretch size when stretch_count is zero
            // and transmitting
            stretch_size <= stretch_size_p[23:0];
            stretch_count <= stretch_ratio[15:8];
         end
      else if (full_duplex & stretch_enable & (data_type != TYPE_IDLE))
         begin
            stretch_count <= stretch_count - 8'h01;
         end
      else if (stretch_size != 24'h000000)
         begin
            stretch_size <= stretch_size - 24'h000001;
            if (stretch_size == 24'h000001)
               ipg_stretch <= 1'b0;
            else
               ipg_stretch <= 1'b1;
         end
      else
         begin
            ipg_stretch <= 1'b0;
            // don't reset stretch_count so mod can be carried over to
            // next frame
         end
   end


   // count tx_frame_length and use it to generate within_60bytes and
   // within_512bytes indications for transmit state machine.
   // also used for statistics generation - tx bytes transmitted.
   // frame length including padding and carrier extension.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         tx_frame_length <= 14'h0000;
      else if (data_type == TYPE_HOLD)
         tx_frame_length <= tx_frame_length;
      else if (tx_byte_mode & ((tx_en_next & ((data_type == TYPE_SFD) |
              (data_type == TYPE_DATA) | (data_type == TYPE_FILL) |
              (data_type == TYPE_CRC))) | (tx_er_next &
              (data_type == TYPE_CARRIER))))
         // increment count when in sfd, data, fill, crc and carrier data types.
         // the count is generated in terms of bytes, and in tx_byte_mode this
         // increments every clock cycle during frame transmission.
         begin
            if (tx_frame_length == 14'h3fff)
               // stop count rolling over.
               tx_frame_length <= tx_frame_length;
            else
               tx_frame_length <= tx_frame_length_nxt;
         end
      else if (tx_en_next & ((data_type == TYPE_SFD) | (data_type == TYPE_DATA)
               | (data_type == TYPE_FILL) | (data_type == TYPE_CRC)))
         // increment count when in sfd, data, fill and crc data types.
         // the count is generated in terms of bytes, and in 10/100 mode this
         // increments every other clock cycle during frame transmission.
         if (nibble_sel & ~(tx_frame_length == 14'h3fff))
            tx_frame_length <= tx_frame_length_nxt;
         else
            tx_frame_length <= tx_frame_length;
      else if (tx_en_next)
         // reset counters at start of frame.
         tx_frame_length <= 14'h0000;
      else
         // hold count values until start of frame.
         tx_frame_length <= tx_frame_length;
   end

   // tx_frame_length for pause frame
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         tx_pause_length <= 6'h00;
      else
         tx_pause_length <= tx_frame_length_nxt[5:0];
   end

   // frame length count adder.
   assign tx_frame_length_nxt = tx_frame_length + 14'h0001;

   // used for inserting pad (fill) into tx frames when the frame is less
   // than 64 bytes (60 bytes + 4 bytes crc).
   assign within_60bytes = tx_frame_length < 14'h003c;


   // used for carrier extension when the frame size is less than 512 bytes.
   assign within_512bytes = tx_frame_length < 14'h0200;


   // count for burst limit when operating in gigabit, half duplex mode. count
   // is in terms of transmitted bytes from the start of preamble for the
   // first frame of the burst.
   // it is also used for late collision threshold in both 10/100 and gigabit
   // modes.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset, count starts at 12 bytes, as burst limit is
         // calculated such that byte count should not exceed 8192 bytes at
         // start of frame, but bursting decision must be made at end of
         // frame.
         burst_length <= 14'h000C;
      else if ((data_type == TYPE_PREAMBLE) | (data_type == TYPE_SFD) |
               (data_type == TYPE_DATA) | (data_type == TYPE_FILL) |
               (data_type == TYPE_CRC) | (data_type == TYPE_CARRIER) |
               (data_type == TYPE_JAM) | (data_type == TYPE_JAM_CE) |
               ((data_type == TYPE_BURST_IFG) & gigabit & ~full_duplex))
         // increment count when in preamble, sfd, data, fill, crc,
         // carrier extension, burst_ifg, jam and jam_ce data types
         // count is in terms of bytes.
         begin
            if (burst_length == 14'h3fff)
               // stop count rolling over.
               burst_length <= burst_length;
            else
               burst_length <= burst_length + 14'h0001;
         end
      else
         // count reset to 12 bytes.
         burst_length <= 14'h000C;
   end

   // used for burst limit (8192 bytes) in gigabit mode, half duplex.
   assign within_burst_limit = burst_length < 14'h2000;

   // late collision threshold is slot time (either 512 bit times [10/100] or
   // 4096 bit times [gigabit mode]) and is measured from the start of preamble.
   // the col input is double synchronised so logic needs to allow three
   // clocks to account for this.
   // burst_length  count starts at 0x000C so add this on.
   // Final decode for gigabit mode is (512 + 12 + 3 = 527 byte clocks).
   // Final decode for 10/100 mode is  (128 + 12 + 3 = 143 nibble clocks)
   assign late_col_threshold = (gigabit) ?
                                burst_length < 14'h020f : // 512 + 12 + 3 = 527.
                                burst_length < 14'h008f;  // 128 + 12 + 3 = 143.


   // Synchronise and then detect a rising edge on spec_add1_active.
   // This is used for initialising the random counter.
   edma_sync_toggle_detect i_edma_sync_toggle_detect_spec_add1_active (
      .clk(tx_clk),
      .reset_n(n_txreset),
      .din(spec_add1_active),
      .rise_edge(spec_add1_act_le),
      .fall_edge(),
      .any_edge());


   // Define when random PRBS is to update. This is controlled by a parameter
   // to be either free running or to update only when a backoff occurs.
   // In the later case retry_test is used for test purposes to ensure
   // all PRBS values are exercised for code-coverage.
   assign random_update = (load_backoff && !last_attempt) || retry_test_sync1;


   // Collision handling stuff follows
   // Generate random number for use in generating backoff after a collision.
   // Counter is initialised with the specific address 1 value to make
   // it unique for each MAC, and hence reduce the chance of two MAC getting
   // locked together.
   // Cycle through all 1024 combinations in a pseudo-random sequence.
   // Only increment when random_update is active. Also make sure zero
   // combination is reached by forcing this between the 55 and ab conditions.
   // random is exclusive OR'ed with transmit data to make it more likely that
   // different MAC's on the same network will cycle through different
   // sequences.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         random1 <= 16'hffff;
      else if (spec_add1_act_le)
         random1 <= spec_add1[47:32];
      else if (random_update & random1 == 16'had62)
         random1 <= 16'h0000;
      else if (random_update & random1 == 16'h0000)
         random1 <= 16'h78b5;
      else if (random_update)
      begin
        random1[0]  <= random1[8];
        random1[1]  <= random1[9];
        random1[2]  <= random1[10];
        random1[3]  <= random1[11] ^ random1[8];
        random1[4]  <= random1[12] ^ random1[9] ^ random1[8];
        random1[5]  <= random1[13] ^ random1[10]
                      ^ random1[9]  ^ random1[8];
        random1[6]  <= random1[14] ^ random1[11]
                      ^ random1[10] ^ random1[9];
        random1[7]  <= random1[15] ^ random1[12]
                      ^ random1[11] ^ random1[10];
        random1[8]  <= random1[0] ^ random1[13] ^ random1[12]
                      ^ random1[11];
        random1[9]  <= random1[1] ^ random1[14] ^ random1[13]
                      ^ random1[12];
        random1[10] <= random1[2] ^ random1[15]
                      ^ random1[14] ^ random1[13];
        random1[11] <= random1[3] ^ random1[15]
                      ^ random1[14];
        random1[12] <= random1[4] ^ random1[15];
        random1[13] <= random1[5];
        random1[14] <= random1[6];
        random1[15] <= random1[7];
      end
      else
         random1 <= random1;
   end

   // track 1st LFSR
   wire [10:0] random1cnt_c;
   assign random1cnt_c = random1cnt[9:0] + random_update;
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
      begin
        random1cnt <= 10'd0;
        shiftrnd1 <= 4'h0;
      end
      else
      begin
        random1cnt <= random1cnt_c[9:0];
        if (&random1cnt[9:0])
        begin
          if (shiftrnd1 == 4'd6)
            shiftrnd1 <= 4'h0;
          else
            shiftrnd1 <= shiftrnd1 + 4'h1;
        end
      end
   end

   // increment 2nd LFSR on 1st LFSR rollover
   assign random2_update = random_update & (&random1cnt);

   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         random2 <= 16'hffff;
      else if (spec_add1_act_le)
         random2 <= {6'h00,spec_add1[19:10]};
//      else if (random2_update & random2 == 16'had62)
//         random2 <= 16'h0000;
//      else if (random2_update & random2 == 16'h0000)
//         random2 <= 16'h78b5;
      else if (random2_update)
         begin
                                   random2[0]  <= random2[8];
                                   random2[1]  <= random2[9];
                                   random2[2]  <= random2[10];
                                   random2[3]  <= random2[11] ^ random2[8];
                                   random2[4]  <= random2[12] ^ random2[9] ^ random2[8];
                                   random2[5]  <= random2[13] ^ random2[10]
                                                 ^ random2[9]  ^ random2[8];
                                   random2[6]  <= random2[14] ^ random2[11]
                                                 ^ random2[10] ^ random2[9];
                                   random2[7]  <= random2[15] ^ random2[12]
                                                 ^ random2[11] ^ random2[10];
                                   random2[8]  <= random2[0] ^ random2[13] ^ random2[12]
                                                 ^ random2[11];
                                   random2[9]  <= random2[1] ^ random2[14] ^ random2[13]
                                                 ^ random2[12];
                                   random2[10] <= random2[2] ^ random2[15]
                                                 ^ random2[14] ^ random2[13];
                                   random2[11] <= random2[3] ^ random2[15]
                                                 ^ random2[14];
                                   random2[12] <= random2[4] ^ random2[15];
                                   random2[13] <= random2[5];
                                   random2[14] <= random2[6];
                                   random2[15] <= random2[7];
         end
      else
         random2 <= random2;
   end

  assign random1_sft =  shiftrnd1 == 4'd0 ? random1[9:0] :
                        shiftrnd1 == 4'd1 ? random1[10:1] :
                        shiftrnd1 == 4'd2 ? random1[11:2] :
                        shiftrnd1 == 4'd3 ? random1[12:3] :
                        shiftrnd1 == 4'd4 ? random1[13:4] :
                        shiftrnd1 == 4'd5 ? random1[14:5] :
                                            random1[15:6];

  assign random = random1_sft[9:0] ^ random2[9:0];

   // count number of attempts to transmit
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         attempts <= 4'h0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         attempts <= 4'h0;
      else if (load_backoff)
         // increment attempts counter.
         attempts <= attempts + 4'h1;
      else if (end_frame)
         // clear attempts counter at end of frame.
         attempts <= 4'h0;
      else
         // else maintain count value.
         attempts <= attempts;
   end


   // the last attempt is the 16th attempt
   assign last_attempt = (attempts == 4'hf);


   assign backoff_start = ((retry_test_sync1) ? 10'h001 : random );


   // load backoff_cnt and count down to zero. backoff_cnt is initially
   // an integer number of slot times (64 bytes in 10/100 or 512 bytes in
   // gigabit mode).
   // The number of slot times is a random number whose range increases
   // depending on the number of collisions that have occurred.
   // backoff_cnt counts in terms of nibbles.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         backoff_cnt <= 19'h00000;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         backoff_cnt <= 19'h00000;
      else if (load_backoff)
         // collision occurred and backoff counter is loaded. backoff is
         // calculated with random number and time exponentially increases
         // (base 2) with each backoff attempt as per ieee802.3.
         // Note that if attemps is already 15, backoff_cnt will not be loaded.
         case ({tx_byte_mode,attempts})
            // 10/100 mode, slot time = 64 bytes, count in nibbles.
            5'b0_0000: backoff_cnt <= {11'h000, backoff_start[0],   7'h00};
            5'b0_0001: backoff_cnt <= {10'h000, backoff_start[1:0], 7'h00};
            5'b0_0010: backoff_cnt <= { 9'h000, backoff_start[2:0], 7'h00};
            5'b0_0011: backoff_cnt <= { 8'h00,  backoff_start[3:0], 7'h00};
            5'b0_0100: backoff_cnt <= { 7'h00,  backoff_start[4:0], 7'h00};
            5'b0_0101: backoff_cnt <= { 6'h00,  backoff_start[5:0], 7'h00};
            5'b0_0110: backoff_cnt <= { 5'h00,  backoff_start[6:0], 7'h00};
            5'b0_0111: backoff_cnt <= { 4'h0,   backoff_start[7:0], 7'h00};
            5'b0_1000: backoff_cnt <= { 3'b000, backoff_start[8:0], 7'h00};
            5'b0_1001: backoff_cnt <= { 2'b00,  backoff_start,      7'h00};
            5'b0_1010: backoff_cnt <= { 2'b00,  backoff_start,      7'h00};
            5'b0_1011: backoff_cnt <= { 2'b00,  backoff_start,      7'h00};
            5'b0_1100: backoff_cnt <= { 2'b00,  backoff_start,      7'h00};
            5'b0_1101: backoff_cnt <= { 2'b00,  backoff_start,      7'h00};
            5'b0_1110: backoff_cnt <= { 2'b00,  backoff_start,      7'h00};
            // tx_byte_mode, slot time = 64 bytes, count in bytes.
            5'b1_0000: backoff_cnt <= {12'h000, backoff_start[0],   6'h00};
            5'b1_0001: backoff_cnt <= {11'h000, backoff_start[1:0], 6'h00};
            5'b1_0010: backoff_cnt <= {10'h000, backoff_start[2:0], 6'h00};
            5'b1_0011: backoff_cnt <= { 9'h000, backoff_start[3:0], 6'h00};
            5'b1_0100: backoff_cnt <= { 8'h00,  backoff_start[4:0], 6'h00};
            5'b1_0101: backoff_cnt <= { 7'h00,  backoff_start[5:0], 6'h00};
            5'b1_0110: backoff_cnt <= { 6'h00,  backoff_start[6:0], 6'h00};
            5'b1_0111: backoff_cnt <= { 5'h00,  backoff_start[7:0], 6'h00};
            5'b1_1000: backoff_cnt <= { 4'h0,   backoff_start[8:0], 6'h00};
            5'b1_1001: backoff_cnt <= { 3'b000, backoff_start,      6'h00};
            5'b1_1010: backoff_cnt <= { 3'b000, backoff_start,      6'h00};
            5'b1_1011: backoff_cnt <= { 3'b000, backoff_start,      6'h00};
            5'b1_1100: backoff_cnt <= { 3'b000, backoff_start,      6'h00};
            5'b1_1101: backoff_cnt <= { 3'b000, backoff_start,      6'h00};
            default: //5'b1_1110
                       backoff_cnt <= { 3'b000, backoff_start,      6'h00};
            // tx_byte_mode, slot time = 512 bytes, count in bytes.
            // 5'b1_0000: backoff_cnt <= {9'h000,  backoff_start[0],   9'h000};
            // 5'b1_0001: backoff_cnt <= {8'h00,   backoff_start[1:0], 9'h000};
            // 5'b1_0010: backoff_cnt <= {7'h00,   backoff_start[2:0], 9'h000};
            // 5'b1_0011: backoff_cnt <= {6'h00,   backoff_start[3:0], 9'h000};
            // 5'b1_0100: backoff_cnt <= {5'h00,   backoff_start[4:0], 9'h000};
            // 5'b1_0101: backoff_cnt <= {4'h0,    backoff_start[5:0], 9'h000};
            // 5'b1_0110: backoff_cnt <= {3'b000,  backoff_start[6:0], 9'h000};
            // 5'b1_0111: backoff_cnt <= {2'b00,   backoff_start[7:0], 9'h000};
            // 5'b1_1000: backoff_cnt <= {1'b0,    backoff_start[8:0], 9'h000};
            // 5'b1_1001: backoff_cnt <= {         backoff_start,      9'h000};
            // 5'b1_1010: backoff_cnt <= {         backoff_start,      9'h000};
            // 5'b1_1011: backoff_cnt <= {         backoff_start,      9'h000};
            // 5'b1_1100: backoff_cnt <= {         backoff_start,      9'h000};
            // 5'b1_1101: backoff_cnt <= {         backoff_start,      9'h000};
            // default: //5'b1_1110
            //            backoff_cnt <= {         backoff_start,      9'h000};
         endcase
      else if (backoff)
         // decrement backoff counter until zero.
         backoff_cnt <= backoff_cnt - 19'h00001;
      else
         // hold backoff counter at zero.
         backoff_cnt <= backoff_cnt;
   end


   // set while doing backoff (ie while backoff_cnt counts down to zero)
   assign backoff = (backoff_cnt != 19'h00000);


   // count jam down to zero. start_jam comes from the transmit state
   // machine. jam is an input to it.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         jam_cnt <= 3'b000;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         jam_cnt <= 3'b000;
      else if ((start_jam) & tx_byte_mode)
         // load jam count in gigabit mode.
         jam_cnt <= 3'h3;
      else if ((start_jam) & ~tx_byte_mode)
         // load jam count in 10/100 mode.
         jam_cnt <= 3'h7;
      else if (jam)
         // decrement jam count until zero.
         jam_cnt <= jam_cnt - 3'h1;
      else
         // hold jam count at zero.
         jam_cnt <= jam_cnt;
   end


   // jam goes to the transmit state machine
   assign jam = (jam_cnt != 3'b000);


   // crc generation logic follows.
   // count down crc_cnt.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         crc_cnt <= 3'b111;
      else if (data_type == TYPE_CRC)
         // crc active, count out period.
         crc_cnt <= crc_cnt - 3'h1;
      else if (tx_byte_mode)
         // tx_byte_mode, count in bytes.
         crc_cnt <= 3'b011;
      else
         // 10/100 mode, count in nibbles.
         crc_cnt <= 3'b111;
   end


   // high for a single cycle at the end of CRC generation.
   // needs to be low when mac_tx_state enters CRC state.
   assign last_crc = (crc_cnt == 3'b000);


   // generate crc
   gem_stripe i_str_tx_0(.din(txd_next[0]),
                                  .stripe_in(crc),
                                  .stripe_out(tx_stripe_out0));
   gem_stripe i_str_tx_1(.din(txd_next[1]),
                                  .stripe_in(tx_stripe_out0),
                                  .stripe_out(tx_stripe_out1));
   gem_stripe i_str_tx_2(.din(txd_next[2]),
                                  .stripe_in(tx_stripe_out1),
                                  .stripe_out(tx_stripe_out2));
   gem_stripe i_str_tx_3(.din(txd_next[3]),
                                  .stripe_in(tx_stripe_out2),
                                  .stripe_out(tx_stripe_out3));
   gem_stripe i_str_tx_4(.din(txd_next[4]),
                                  .stripe_in(tx_stripe_out3),
                                  .stripe_out(tx_stripe_out4));
   gem_stripe i_str_tx_5(.din(txd_next[5]),
                                  .stripe_in(tx_stripe_out4),
                                  .stripe_out(tx_stripe_out5));
   gem_stripe i_str_tx_6(.din(txd_next[6]),
                                  .stripe_in(tx_stripe_out5),
                                  .stripe_out(tx_stripe_out6));
   gem_stripe i_str_tx_7(.din(txd_next[7]),
                                  .stripe_in(tx_stripe_out6),
                                  .stripe_out(tx_stripe_out7));

   // crc register and control.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         crc <= 32'hffffffff;
      else if (tx_en_next & ((data_type == TYPE_DATA) | (data_type == TYPE_FILL)))
          // data type is data or fill.
         begin
         if (tx_byte_mode)
            // tx_byte_mode.
            crc <= tx_stripe_out7;
         else
            // 10/100 mode.
            crc <= tx_stripe_out3;
         end
      else if (tx_en_next & (data_type == TYPE_CRC))
         // data type is crc.
         begin
         if (tx_byte_mode)
            // tx_byte_mode.
            crc <= {crc[23:0],8'h00};
         else
            // 10/100 mode.
            crc <= {crc[27:0],4'h0};
         end
      else if (data_type != TYPE_HOLD)
         // reset crc generator.
         crc <= 32'hffffffff;
   end


   // Signal generation for statistics reporting follows

   // generate multicast match for statistics recording.
   // lsb of destination address indicates multicast.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         multicast_match <= 1'b0;
      else if (start_frame)
         // clear statistic at start of frame.
         multicast_match <= 1'b0;
      else if ((tx_frame_length[13:0] == 14'h0001) & (transmit_data_buf[0])
                & ~nibble_sel)
         // set statistic for lowest bit of destination address.
         multicast_match <= 1'b1;
      else
         // else hold value of statistic.
         multicast_match <= multicast_match;
   end


   // generate broadcast match for statistics recording.
   // destination address of all 1's indicates broadcast.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         broadcast_match <= 1'b0;
      else if (start_frame)
         // clear statistic at start of frame.
         broadcast_match <= 1'b0;
      else if ((tx_frame_length[13:0] == 14'h0001) &
          (transmit_data_buf[7:0] == 8'hff) & ~nibble_sel)
         // check for destination address all 1's.
         broadcast_match <= 1'b1;
      else if ((tx_frame_length[13:0] < 14'h0007) &
              (tx_frame_length[13:0] != 14'h0000) &
               (broadcast_match) & ~nibble_sel)
         begin
         // check for destination address all 1's.
            if (transmit_data_buf[7:0] == 8'hff)
               broadcast_match <= broadcast_match;
            else
               broadcast_match <= 1'b0;
         end
      else
         // else hold value of statistic.
         broadcast_match <= broadcast_match;
   end


   // generate single collision tx frame statistics
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         single_collision <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         single_collision <= 1'b0;
      else if (end_frame)
         // clear statistic at end of frame.
         single_collision <= 1'b0;
      else if (coll_occured & ~multi_collision)
         // toggle single collision, unless multi collision set.
         single_collision <= ~single_collision;
      else
         // else hold value of statistic.
         single_collision <= single_collision;
   end


   // generate multiple collision tx frame statistics
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         multi_collision <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         multi_collision <= 1'b0;
      else if (end_frame)
         // clear statistic at end of frame.
         multi_collision <= 1'b0;
      else if (coll_occured & single_collision)
         // set multi collision on second collision.
         multi_collision <= 1'b1;
      else
         // else hold value of statistic.
         multi_collision <= multi_collision;
   end


   // generate late collision tx frame statistics
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         late_collision <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         late_collision <= 1'b0;
      else if (end_frame)
         // clear statistic at end of frame.
         late_collision <= 1'b0;
      else if (coll_occured & ~late_col_threshold)
         // set statistic for late collision, regardless
         // of whether 10/100 mode or gigabit mode.
         late_collision <= 1'b1;
      else
         // else hold value of statistic.
         late_collision <= late_collision;
   end

   assign late_collision_gig = late_collision && gigabit;


   // set deferred when frame transmission has been deferred.
   // this signal is used for tx frame statistics, and is only
   // recorded when the frame doesn't experience a collision.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         deferred <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         deferred <= 1'b0;
      else if (end_frame | coll_occured)
         // clear statistic at end of frame.
         deferred <= 1'b0;
      else if (~interframe_cnt[4] & crs_sync & ~int_end_frame & first_ifg &
               frame_ready)
         // set statistic if defferal occurs prior to frame transmission.
         deferred <= 1'b1;
      else
         // else hold value of statistic.
         deferred <= deferred;
   end


   // generate crs failure statistics
   // assert crs_seen if crs is seen during frame transmission
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         crs_seen <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         crs_seen <= 1'b0;
      else if (~tx_en_next & ~(gigabit & ~full_duplex))
         // clear outside frame transmission in 10/100 mode.
         crs_seen <= 1'b0;
      else if (~tx_er_next & ~tx_en_next & gigabit & ~full_duplex)
         // clear outside frame transmission in gigabit mode.
         crs_seen <= 1'b0;
      else if (crs_sync)
         // frame active and crs detected.
         crs_seen <= 1'b1;
      else
         // else hold value.
         crs_seen <= crs_seen;
   end

   // assert crs_deasserted if crs is deasserted after it has been seen
   // during frame transmission
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         crs_deasserted <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         crs_deasserted <= 1'b0;
      else if (end_frame | coll_occured)
         // clear statistic at end of frame.
         crs_deasserted <= 1'b0;
      else if (crs_seen & (data_type != TYPE_IDLE) & ~crs_sync)
         // crs was asserted and the deasserted within frame tx.
         crs_deasserted <= 1'b1;
      else
         // else hold value.
         crs_deasserted <= crs_deasserted;
   end


   // assert crs_failure if crs not seen during transmission or if crs
   // deasserted in a tranmsit frame without collision.
   assign crs_failure = ~crs_seen | crs_deasserted;


   // need to extend int_end_frame to mask deference statistics signal
   // so that the defer statistics won't increment for back to back frames
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         begin
            int_end_frame           <= 1'b0;
            int_end_frame_cnt[1:0]  <= 2'b00;
         end
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         begin
            int_end_frame           <= 1'b0;
            int_end_frame_cnt[1:0]  <= 2'b00;
         end
      else if (end_frame)
         // trigger four clock count at end of frame.
         begin
            int_end_frame           <= 1'b1;
            int_end_frame_cnt[1:0]  <= 2'b11;
         end
      else if (int_end_frame_cnt != 2'b00)
         // count until zero.
         begin
            int_end_frame           <= 1'b1;
            int_end_frame_cnt[1:0]  <= int_end_frame_cnt - 2'b01;
         end
      else
         // hold count at zero.
         begin
            int_end_frame           <= 1'b0;
            int_end_frame_cnt[1:0]  <= 2'b00;
         end
   end


   // status signals passed to dma for status write back at end of frame.
   // handshaking is used to transfer the status signals from the tx_clk
   // domain to the hclk domain. dma_status_edge is a one clock wide edge
   // detect of dma_status_taken, and is used to clear the status outputs
   // once recorded in the hclk domain.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         begin
            dma_tx_end_frame       <= 1'b0;
            dma_tx_end_tog         <= 1'b0;
            too_many_retries       <= 1'b0;
            underflow_frame        <= 1'b0;
            late_coll_occured      <= 1'b0;
         end
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         begin
            dma_tx_end_frame       <= 1'b0;
            dma_tx_end_tog         <= dma_tx_end_tog;
            too_many_retries       <= 1'b0;
            underflow_frame        <= 1'b0;
            late_coll_occured      <= 1'b0;
         end
      else if (late_col_pending & ~dma_eof_noack & ~pclksync_eof_noack)
         // late collision pending, reported once status writeback has
         // completed.
         begin
            dma_tx_end_frame       <= 1'b1;
            dma_tx_end_tog         <= ~dma_tx_end_tog;
            too_many_retries       <= 1'b0;
            underflow_frame        <= 1'b0;
            late_coll_occured      <= 1'b1;
         end
      else if (end_frame & ~pfc_or_pause_frame_transmitting & ~dma_eof_noack
               & ~pclksync_eof_noack)
         // set status signals for the dma at end of frame, no
         // previous status writeback in progress (and not a pause
         // frame).
         begin
            dma_tx_end_frame       <= 1'b1;
            dma_tx_end_tog         <= ~dma_tx_end_tog;
            too_many_retries       <= excess_coll;
            underflow_frame        <= fifo_underrun;
            late_coll_occured      <= ~fifo_underrun & ~excess_coll & late_collision_gig;
         end
      else if (stat_underflow_pend & ~dma_eof_noack & ~pclksync_eof_noack &
               ~stat_underflow_ack)
         // status writeback error pending and previous acknowledge
         // completed. generate underflow condition, and output with
         // a toggle of dma_tx_end_tog.
         begin
            dma_tx_end_frame       <= 1'b1;
            dma_tx_end_tog         <= ~dma_tx_end_tog;
            too_many_retries       <= 1'b0;
            underflow_frame        <= 1'b1;
            late_coll_occured      <= 1'b0;
         end
      else if (~dma_status_edge & dma_tx_end_frame)
         // wait for status to be taken by dma.
         begin
            dma_tx_end_frame       <= 1'b1;
            dma_tx_end_tog         <= dma_tx_end_tog;
            too_many_retries       <= too_many_retries;
            underflow_frame        <= underflow_frame;
            late_coll_occured      <= late_coll_occured;
         end
      else
         // clear status once status taken by dma.
         begin
            dma_tx_end_frame       <= 1'b0;
            dma_tx_end_tog         <= dma_tx_end_tog;
            too_many_retries       <= 1'b0;
            underflow_frame        <= 1'b0;
            late_coll_occured      <= 1'b0;
         end
   end


   // detect when end_frame has occurred, but
   // gem_pclk_sync block has not acknowledged.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         pclksync_eof_noack     <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         pclksync_eof_noack     <= 1'b0;
      else if (end_frame & ~pclksync_eof_noack & ~dma_eof_noack &
               ~late_collision_gig)
         // set flag once end of frame has occurred.
         pclksync_eof_noack     <= 1'b1;
      else if (tx_status_edge)
         // clear flag once acknowledged by gem_pclk_sync.
         pclksync_eof_noack     <= 1'b0;
      else
         // maintain value
         pclksync_eof_noack     <= pclksync_eof_noack;
   end


   // detect when end_frame has occurred, but
   // dma block has not acknowledged.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         dma_eof_noack          <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         dma_eof_noack          <= 1'b0;
      else if (end_frame & ~pclksync_eof_noack & ~dma_eof_noack &
               ~pfc_or_pause_frame_transmitting & ~late_collision_gig)
         // set flag once end of frame has occurred.
         dma_eof_noack          <= 1'b1;
      else if (dma_status_edge)
         // clear flag once acknowledged by dma.
         dma_eof_noack          <= 1'b0;
      else
         // maintain value
         dma_eof_noack          <= dma_eof_noack;
   end


   // generate underflow pending both dma & reg interface
   // have not acknowledged the previous frame's status
   // when a second frame completes (for short frames
   // where a system error condition has occurred).
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         stat_underflow_pend   <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         stat_underflow_pend   <= 1'b0;
      else if (end_frame & ~late_collision_gig &
              ((~pfc_or_pause_frame_transmitting & dma_eof_noack) |
               pclksync_eof_noack))
         // set flag if end of frame and previous not
         // acknowledged by the dma or gem_pclk_sync blocks.
         stat_underflow_pend   <= 1'b1;
      else if (stat_underflow_ack)
         // clear flag once output to dma.
         stat_underflow_pend   <= 1'b0;
      else
         // maintain value
         stat_underflow_pend   <= stat_underflow_pend;
   end


   // assert collision_int when coll_occurred and
   // hold until it is output to the dma.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         collision_int <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         collision_int <= 1'b0;
      else if (coll_occured & gigabit & late_col_threshold & ~last_attempt)
         // do not set collision_int in gigabit mode if
         // it is a late collision.
         collision_int <= 1'b1;
      else if (coll_occured & ~gigabit & ~last_attempt)
         // both collisions and late collision set this signal
         // in 10/100 mode.
         collision_int <= 1'b1;
      else if (collision_occured)
         // clear status once status is passed to dma.
         collision_int <= 1'b0;
      else
         // else hold value.
         collision_int <= collision_int;
   end


   // assert collision_occured when collision_int and
   // hold until acknowledged by dma block.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         collision_occured <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         collision_occured <= 1'b0;
      else if (collision_int & ~dma_eof_noack & ~pclksync_eof_noack)
         // only set this output once previous frame has been acknowledged.
         collision_occured <= 1'b1;
      else if (dma_status_edge)
         // clear status once it has been taken by dma.
         collision_occured <= 1'b0;
      else
         // else hold value.
         collision_occured <= collision_occured;
   end


   // status signal for bytes transmitted in frame, passed to gem_reg_top
   // block and used to generate transmitted octets count.
   // handshaking is used to transfer the status signal from the tx_clk
   // domain to the pclk domain. tx_status_edge is a one clock wide edge
   // detect of tx_status_taken, and is used to clear the statistic once
   // recorded in the pclk domain.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         tx_bytes_in_frame <= 14'h0000;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         tx_bytes_in_frame <= 14'h0000;
      else if (end_data_frame & ~dma_eof_noack & ~pclksync_eof_noack)
         // gem_tx_psync module determines where byte count is for
         // a successfully transmitted frame using tx_frame_txed_ok.
         tx_bytes_in_frame  <= tx_frame_length;
      else if (~tx_status_edge)
         // wait for statistics to be taken.
         tx_bytes_in_frame  <= tx_bytes_in_frame;
      else
         // else clear counter.
         tx_bytes_in_frame <= 14'h0000;
   end


   // logic to hold a late collision, if it occurs during the
   // status writeback period.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         late_col_pending <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         late_col_pending <= 1'b0;
      else if (late_collision_gig & end_frame & (dma_eof_noack |
               pclksync_eof_noack))
         // writeback in progress and late collision has occurred.
         late_col_pending <= 1'b1;
      else if (late_col_pending & ~dma_eof_noack & ~pclksync_eof_noack)
         // writeback complete, so late collision may be reported.
         late_col_pending <= 1'b0;
      else
         // hold current state.
         late_col_pending <= late_col_pending;
   end


   // status signals passed to gem_reg_top block for statistics recording at
   // the end of frame.
   // handshaking is used to transfer the status signals from the tx_clk
   // domain to the pclk domain. tx_status_edge is a one clock wide edge
   // detect of tx_status_taken, and is used to clear the statistics once
   // recorded in the pclk domain.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         begin
            tx_end_frame           <= 1'b0;
            tx_end_tog             <= 1'b0;
            stat_underflow_ack     <= 1'b0;
            tx_pause_frame_txed    <= 1'b0;
            tx_pfc_pause_frame_txed<= 1'b0;
            tx_broadcast_frame     <= 1'b0;
            tx_multicast_frame     <= 1'b0;
            tx_frame_txed_ok       <= 1'b0;
            tx_single_coll_frame   <= 1'b0;
            tx_multi_coll_frame    <= 1'b0;
            tx_deferred_tx_frame   <= 1'b0;
            tx_late_coll_frame     <= 1'b0;
            tx_crs_error_frame     <= 1'b0;
            tx_too_many_retries    <= 1'b0;
            tx_underflow_frame     <= 1'b0;
         end
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         begin
            tx_end_frame           <= 1'b0;
            tx_end_tog             <= tx_end_tog;
            stat_underflow_ack     <= 1'b0;
            tx_pause_frame_txed    <= 1'b0;
            tx_pfc_pause_frame_txed<= 1'b0;
            tx_broadcast_frame     <= 1'b0;
            tx_multicast_frame     <= 1'b0;
            tx_frame_txed_ok       <= 1'b0;
            tx_single_coll_frame   <= 1'b0;
            tx_multi_coll_frame    <= 1'b0;
            tx_deferred_tx_frame   <= 1'b0;
            tx_late_coll_frame     <= 1'b0;
            tx_crs_error_frame     <= 1'b0;
            tx_too_many_retries    <= 1'b0;
            tx_underflow_frame     <= 1'b0;
         end
      else if (late_col_pending & ~dma_eof_noack & ~pclksync_eof_noack)
         // late collision pending, reported once status writeback has
         // completed.
         begin
            tx_end_frame           <= 1'b1;
            tx_end_tog             <= ~tx_end_tog;
            stat_underflow_ack     <= 1'b1;
            tx_pause_frame_txed    <= 1'b0;
            tx_pfc_pause_frame_txed<= 1'b0;
            tx_broadcast_frame     <= 1'b0;
            tx_multicast_frame     <= 1'b0;
            tx_frame_txed_ok       <= 1'b0;
            tx_single_coll_frame   <= 1'b0;
            tx_multi_coll_frame    <= 1'b0;
            tx_deferred_tx_frame   <= 1'b0;
            tx_late_coll_frame     <= 1'b1;
            tx_crs_error_frame     <= 1'b0;
            tx_too_many_retries    <= 1'b0;
            tx_underflow_frame     <= 1'b0;
         end
      else if (end_frame & ~pfc_or_pause_frame_transmitting &
               ~dma_eof_noack & ~pclksync_eof_noack)
         // set statistics outputs for non pause frame.
         begin
            tx_end_frame           <= 1'b1;
            tx_end_tog             <= ~tx_end_tog;
            stat_underflow_ack     <= 1'b0;
            tx_pause_frame_txed    <= 1'b0;
            tx_pfc_pause_frame_txed<= 1'b0;
            tx_broadcast_frame     <= ~fifo_underrun & ~excess_coll &
                                      broadcast_match &
                                       ~late_collision_gig;
            tx_multicast_frame     <= ~fifo_underrun & ~excess_coll &
                                      multicast_match & ~broadcast_match &
                                       ~late_collision_gig;
            tx_frame_txed_ok       <= ~fifo_underrun & ~excess_coll &
                                       ~late_collision_gig;
            tx_single_coll_frame   <= ~fifo_underrun & ~excess_coll &
                                       single_collision &
                                       ~late_collision_gig;
            tx_multi_coll_frame    <= ~fifo_underrun & ~excess_coll &
                                       multi_collision &
                                       ~late_collision_gig;
            tx_deferred_tx_frame   <= ~fifo_underrun & deferred;
            tx_late_coll_frame     <= ~fifo_underrun & ~excess_coll &
                                       late_collision;
            tx_crs_error_frame     <= ~fifo_underrun & crs_failure &
                                       ~full_duplex;
            tx_too_many_retries    <= excess_coll;

            // Underflow caused by reading tx_r_err from FIFO should not raise
            // an exception when in exposed FIFO interface configuration.
            if (p_edma_ext_fifo_interface == 1)
              tx_underflow_frame   <= fifo_underrun & ~fifo_err_underrun;
            else if (p_edma_host_if_soft_select == 1 && soft_config_fifo_en)
              tx_underflow_frame  <= fifo_underrun & ~fifo_err_underrun;
            else
              tx_underflow_frame    <= fifo_underrun | fifo_err_underrun;
         end
      else if (end_frame & pause_frame_transmitting & ~dma_eof_noack
               & ~pclksync_eof_noack)
         // set statistics outputs for 802.3 pause frame.
         begin
            tx_end_frame           <= 1'b1;
            tx_end_tog             <= ~tx_end_tog;
            stat_underflow_ack     <= 1'b0;
            tx_pause_frame_txed    <= 1'b1;
            tx_pfc_pause_frame_txed<= 1'b0;
            tx_broadcast_frame     <= 1'b0;
            tx_multicast_frame     <= 1'b0;
            tx_frame_txed_ok       <= 1'b0;
            tx_single_coll_frame   <= 1'b0;
            tx_multi_coll_frame    <= 1'b0;
            tx_deferred_tx_frame   <= 1'b0;
            tx_late_coll_frame     <= 1'b0;
            tx_crs_error_frame     <= 1'b0;
            tx_too_many_retries    <= 1'b0;
            tx_underflow_frame     <= 1'b0;
         end
      else if (end_frame & pfc_frame_transmitting & ~dma_eof_noack
               & ~pclksync_eof_noack)
         // set statistics outputs for PFC pause frame.
         begin
            tx_end_frame           <= 1'b1;
            tx_end_tog             <= ~tx_end_tog;
            stat_underflow_ack     <= 1'b0;
            tx_pause_frame_txed    <= 1'b0;
            tx_pfc_pause_frame_txed<= 1'b1;
            tx_broadcast_frame     <= 1'b0;
            tx_multicast_frame     <= 1'b0;
            tx_frame_txed_ok       <= 1'b0;
            tx_single_coll_frame   <= 1'b0;
            tx_multi_coll_frame    <= 1'b0;
            tx_deferred_tx_frame   <= 1'b0;
            tx_late_coll_frame     <= 1'b0;
            tx_crs_error_frame     <= 1'b0;
            tx_too_many_retries    <= 1'b0;
            tx_underflow_frame     <= 1'b0;
         end
      else if (stat_underflow_pend & ~dma_eof_noack & ~pclksync_eof_noack &
               ~stat_underflow_ack)
         // report underrun due to status writeback not completing prior to
         // a second end of frame. this condition should only occur when a short
         // frame is pushed through the mac (with tx_no_crc set, hence no pad).
         begin
            tx_end_frame           <= 1'b1;
            tx_end_tog             <= ~tx_end_tog;
            stat_underflow_ack     <= 1'b1;
            tx_pause_frame_txed    <= 1'b0;
            tx_pfc_pause_frame_txed<= 1'b0;
            tx_broadcast_frame     <= 1'b0;
            tx_multicast_frame     <= 1'b0;
            tx_frame_txed_ok       <= 1'b0;
            tx_single_coll_frame   <= 1'b0;
            tx_multi_coll_frame    <= 1'b0;
            tx_deferred_tx_frame   <= 1'b0;
            tx_late_coll_frame     <= 1'b0;
            tx_crs_error_frame     <= 1'b0;
            tx_too_many_retries    <= 1'b0;
            tx_underflow_frame     <= 1'b1;
         end
      else if (~tx_status_edge & tx_end_frame)
         // hold statistics outputs until taken by
         // registers block.
         begin
            tx_end_frame           <= 1'b1;
            tx_end_tog             <= tx_end_tog;
            stat_underflow_ack     <= stat_underflow_ack;
            tx_pause_frame_txed    <= tx_pause_frame_txed;
            tx_pfc_pause_frame_txed<= tx_pfc_pause_frame_txed;
            tx_broadcast_frame     <= tx_broadcast_frame;
            tx_multicast_frame     <= tx_multicast_frame;
            tx_frame_txed_ok       <= tx_frame_txed_ok;
            tx_single_coll_frame   <= tx_single_coll_frame;
            tx_multi_coll_frame    <= tx_multi_coll_frame;
            tx_deferred_tx_frame   <= tx_deferred_tx_frame;
            tx_late_coll_frame     <= tx_late_coll_frame;
            tx_crs_error_frame     <= tx_crs_error_frame;
            tx_too_many_retries    <= tx_too_many_retries;
            tx_underflow_frame     <= tx_underflow_frame;
         end
      else
         // clear statistics outputs once taken by
         // registers block.
         begin
            tx_end_frame           <= 1'b0;
            tx_end_tog             <= tx_end_tog;
            stat_underflow_ack     <= 1'b0;
            tx_pause_frame_txed    <= 1'b0;
            tx_pfc_pause_frame_txed<= 1'b0;
            tx_broadcast_frame     <= 1'b0;
            tx_multicast_frame     <= 1'b0;
            tx_frame_txed_ok       <= 1'b0;
            tx_single_coll_frame   <= 1'b0;
            tx_multi_coll_frame    <= 1'b0;
            tx_deferred_tx_frame   <= 1'b0;
            tx_late_coll_frame     <= 1'b0;
            tx_crs_error_frame     <= 1'b0;
            tx_too_many_retries    <= 1'b0;
            tx_underflow_frame     <= 1'b0;
         end
   end


   // assert tx_coll_occured when coll_occured and
   // hold until acknowledged by register block.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset.
         tx_coll_occured <= 1'b0;
      else if (~en_transmit_sync)
         // synchronous reset (from software).
         tx_coll_occured <= 1'b0;
      else if (collision_int & ~dma_eof_noack & ~pclksync_eof_noack)
         // collision occurred and status/statistics update from
         // previous frame complete.
         tx_coll_occured <= 1'b1;
      else if (tx_status_edge)
         // clear status once it has been taken by registers block.
         tx_coll_occured <= 1'b0;
      else
         // else hold value.
         tx_coll_occured <= tx_coll_occured;
   end


   // IEEE 1588
   // drive sof_tx
   // assert at start of frame, de-assert at end of frame
   always@(posedge tx_clk or negedge n_txreset)
     begin
      if (~n_txreset)
         begin
            sof_tx <= 1'b0;
         end
      else if (~tx_en | ~en_transmit_sync)
         begin
            sof_tx <= 1'b0;
         end
      else if (data_type == TYPE_SFD)
         begin
            sof_tx <= 1'b1;
         end
     end


   // Transmit Decode State Machine (synchronous part)
   always@(posedge tx_clk or negedge n_txreset)
     begin
      if (~n_txreset)
         begin
            tx_dec_state    <= TX_DEC_IDLE;
            en_tx_ptp_count <= 1'b0;
         end
      // stop at end of frame or if not PTP event frame
      else if (~tx_en | ~en_transmit_sync)
         begin
            tx_dec_state    <= TX_DEC_IDLE;
            en_tx_ptp_count <= 1'b0;
         end
      else
         begin
            tx_dec_state    <= tx_dec_state_nxt;
            en_tx_ptp_count <= en_tx_ptp_count_nxt;
         end
     end

  wire tx_buf_89bcd;  // Create a useful signal for use later on - used for detecting PTP general messages
  wire tx_buf_234;    // Create a useful signal for use later on - used for detecting PTP general messages
  wire general_frame_tx_dec;  // Create a useful signal for use later on - used for detecting PTP general messages
  wire ptp_primary_nunicast;    // Create a useful signal for use later on - PTP primary version 1, not unicast on last byte of dest add
  wire ptp_pri_final_general_chk;    // Create a useful signal for use later on - detect General 1588 Messages
  wire ptp_peer_final_general_chk;    // Create a useful signal for use later on - detect General 1588 Messages
  assign tx_buf_89bcd =  (transmit_data_buf[3:0] == 4'h8)
                        |(transmit_data_buf[3:0] == 4'h9)
                        |(transmit_data_buf[3:0] == 4'hb)
                        |(transmit_data_buf[3:0] == 4'hc)
                        |(transmit_data_buf[3:0] == 4'hd);

  assign  tx_buf_234 =  ((transmit_data_buf[3:0] == 4'h2)   // ptp_delay_req for ptp version 1
                        |(transmit_data_buf[3:0] == 4'h3)   // ptp_followup for ptp version 1
                        |(transmit_data_buf[3:0] == 4'h4)); // ptp_management for ptp version 1

  assign general_frame_tx_dec =  general_frame_tx & tx_buf_89bcd;
   // PTP primary version 1, not unicast on last byte of dest add
  assign ptp_primary_nunicast =  ~ptp_unicast &
                                ((transmit_data_buf[7:0] == 8'h82) |
                                 (transmit_data_buf[7:0] == 8'h83) |
                                 (transmit_data_buf[7:0] == 8'h84));

  assign ptp_pri_final_general_chk = general_frame_tx & (tx_buf_89bcd |(ptp_unicast & (transmit_data_buf[3:0] == 4'ha)));
  assign ptp_peer_final_general_chk = general_frame_tx & transmit_data_buf[3:0] == 4'ha;// Pdelay_Resp_Follow_Up

   // Transmit Decode State Machine (asynchronous part)
   always@(*)
   begin

      // defaults for next value is current value
      en_tx_ptp_count_nxt            = en_tx_ptp_count;
      sync_frame_tx_nxt              = sync_frame_tx;
      delay_req_tx_nxt               = delay_req_tx;
      pdelay_req_tx_nxt              = pdelay_req_tx;
      pdelay_resp_tx_nxt             = pdelay_resp_tx;
      general_frame_tx_nxt           = general_frame_tx;
      ptp_ver_1_nxt                  = ptp_ver_1;
      ptp_ver_2_nxt                  = ptp_ver_2;
      ptp_unicast_nxt                = ptp_unicast;
      ptp_timestamp_position         = 7'h7f;
      ptp_timestamp_position_cap     = 1'b0;
      ptp_timestamp_position_cap_v1  = 1'b0;

      // decode current state
      case (tx_dec_state)

         TX_DEC_START : // decode PTP Multicast MAC addresses or IPv4/IPV6 Ethertype
            begin
               // Multicast MAC addresses part1
               if (tx_ptp_count == 7'b0000000)
                  begin
                     // address part1 01
                     if (transmit_data_buf[7:0] == 8'h01 & (data_type == TYPE_DATA))
                        begin
                           tx_dec_state_nxt = TX_DEC_PTP_1;
                        end
                     else
                        begin
                           tx_dec_state_nxt = TX_DEC_START;
                        end
                  end
               // Ethertype needs IPv4, IPv6 or VLAN type ID
               else if (tx_ptp_count == 7'b0001100)
                  begin
                     // IPv6
                     if (transmit_data_buf[7:0] == 8'h86)
                        begin
                           tx_dec_state_nxt = TX_DEC_IPV6_1;
                        end
                     // IPv4
                     else if (transmit_data_buf[7:0] == 8'h08)
                        begin
                           tx_dec_state_nxt = TX_DEC_IPV4_1;
                        end
                     // VLAN
                     else if (transmit_data_buf[7:0] == 8'h81)
                        begin
                           tx_dec_state_nxt = TX_DEC_START;
                        end
                     else
                        begin
                           tx_dec_state_nxt = TX_DEC_IDLE;
                        end
                  end
               // VLAN
               else if (tx_ptp_count == 7'b0001101)
                  begin
                     // VLAN
                     if (transmit_data_buf[7:0] == 8'h00)
                        begin
                           tx_dec_state_nxt = TX_DEC_START;
                        end
                     else
                        begin
                           tx_dec_state_nxt = TX_DEC_IDLE;
                        end
                  end
               // VLAN, Ethertype needs IPv4 or IPv6 type ID
               else if (tx_ptp_count == 7'b0010000)
                  begin
                     // IPv6
                     if (transmit_data_buf[7:0] == 8'h86)
                        begin
                           tx_dec_state_nxt = TX_DEC_VIPV6_1;
                        end
                     // IPv4
                     else if (transmit_data_buf[7:0] == 8'h08)
                        begin
                           tx_dec_state_nxt = TX_DEC_VIPV4_1;
                        end
                     else
                        begin
                           tx_dec_state_nxt = TX_DEC_IDLE;
                        end
                  end
               else
                  begin
                     tx_dec_state_nxt     = TX_DEC_START;
                  end
            end

         TX_DEC_PTP_1 : // decode Ethernet PTP
            begin
               case (tx_ptp_count)

               7'b0000001 : // Multicast MAC addresses part2
                  begin
                     // address part2 1b
                     if (transmit_data_buf[7:0] == 8'h1b)
                        tx_dec_state_nxt = TX_DEC_PTP_1;
                     // address part2 80
                     else if (transmit_data_buf[7:0] == 8'h80)
                        tx_dec_state_nxt = TX_DEC_PTP_2;
                     else
                        tx_dec_state_nxt = TX_DEC_START;
                  end

               7'b0000010 : // Multicast MAC addresses part3
                  begin
                     // address part3 19
                     if (transmit_data_buf[7:0] == 8'h19)
                        tx_dec_state_nxt = TX_DEC_PTP_1;
                     else
                        tx_dec_state_nxt = TX_DEC_START;
                  end

               7'b0000011 : // Multicast MAC addresses part4
                  begin
                     // address part3 00
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt = TX_DEC_PTP_1;
                     else
                        tx_dec_state_nxt = TX_DEC_START;
                  end

               7'b0000100 : // Multicast  MAC addresses part5
                  begin
                     // address part5 00
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt = TX_DEC_PTP_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0000101 : // Multicast  MAC addresses part6
                  begin
                     // address part6 00
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt = TX_DEC_PTP_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0001100 : // Ethertype1 PTP
                  begin
                     if (transmit_data_buf[7:0] == 8'h88)
                        tx_dec_state_nxt  = TX_DEC_PTP_1;
                     else if (transmit_data_buf[7:0] == 8'h81)
                        tx_dec_state_nxt  = TX_DEC_VPTP_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0001101 : // Ethertype2 PTP
                  begin
                     if (transmit_data_buf[7:0] == 8'hf7)
                       tx_dec_state_nxt  = TX_DEC_PTP_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0001110 : // messageType
                  begin
                     // sync frame
                     if (transmit_data_buf[3:0] == 4'h0)
                        begin
                           tx_dec_state_nxt  = TX_DEC_PTP_1;
                           sync_frame_tx_nxt = 1'b1;
                           ptp_timestamp_position = tx_ptp_count;
                           ptp_timestamp_position_cap   = 1'b1;
                        end
                     // delay_req frame
                     else if (transmit_data_buf[3:0] == 4'h1)
                       begin
                         tx_dec_state_nxt  = TX_DEC_PTP_1;
                         delay_req_tx_nxt  = 1'b1;
                       end
                     // detect General 1588 Messages then wait for next frame and also if
                     // invalid - wait for next frame
                     else
                     begin
                       general_frame_tx_nxt =  tx_buf_89bcd;
                       tx_dec_state_nxt  = TX_DEC_IDLE;
                     end
                  end


               7'b0110000 : // timestamp start position is 34B after messageType
                  begin
                     tx_dec_state_nxt  = TX_DEC_PTP_1;
                  end

               7'b0111001 : // timestamp end position is 9B after timestamp start
                  begin
                     // this will stop tx_ptp_count after TS finished
                     tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_PTP_1;
                  end

               endcase
            end

         TX_DEC_PTP_2 : // decode Ethertype PTP
            begin
               case (tx_ptp_count)

               7'b0000001 : // Multicast MAC addresses part2
                  begin
                     // address part2 80 - must be 80 as this can only
                     // happen in 10/100 mode where data is transferred
                     // in nibbles - this is just the 2nd half of the data
                     // that we already decoded in TX_DEC_PTP_1
                     //if (transmit_data_buf[7:0] == 8'h80)
                        tx_dec_state_nxt = TX_DEC_PTP_2;
                     //else
                     //   tx_dec_state_nxt = TX_DEC_START;
                  end

               7'b0000010 : // Multicast MAC addresses part3
                  begin
                     // address part3 c2
                     if (transmit_data_buf[7:0] == 8'hc2)
                        tx_dec_state_nxt = TX_DEC_PTP_2;
                     else
                        tx_dec_state_nxt = TX_DEC_START;
                  end

               7'b0000011 : // Multicast MAC addresses part4
                  begin
                     // address part3 00
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt = TX_DEC_PTP_2;
                     else
                        tx_dec_state_nxt = TX_DEC_START;
                  end

               7'b0000100 : // Multicast  MAC addresses part5
                  begin
                     // address part5 00
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt = TX_DEC_PTP_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0000101 : // Multicast  MAC addresses part6
                  begin
                     // address part6 0e
                     if (transmit_data_buf[7:0] == 8'h0e)
                        tx_dec_state_nxt = TX_DEC_PTP_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0001100 : // Ethertype1 PTP
                  begin
                     if (transmit_data_buf[7:0] == 8'h88)
                        tx_dec_state_nxt  = TX_DEC_PTP_2;
                     else if (transmit_data_buf[7:0] == 8'h81)
                        tx_dec_state_nxt  = TX_DEC_VPTP_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0001101 : // Ethertype2 PTP
                  begin
                     if (transmit_data_buf[7:0] == 8'hf7)
                       tx_dec_state_nxt  = TX_DEC_PTP_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0001110 : // messageType
                  begin
                     // sync frame detection for 801.AS
                     if (transmit_data_buf[3:0] == 4'h0)
                        begin
                           tx_dec_state_nxt  = TX_DEC_PTP_2;
                           sync_frame_tx_nxt = 1'b1;
                           ptp_timestamp_position = tx_ptp_count;
                           ptp_timestamp_position_cap   = 1'b1;
                        end
                     // pdelay_req frame
                     else if (transmit_data_buf[3:0] == 4'h2)
                        begin
                           tx_dec_state_nxt  = TX_DEC_PTP_2;
                           pdelay_req_tx_nxt = 1'b1;
                        end
                     // pdelay_resp
                     else if (transmit_data_buf[3:0] == 4'h3)
                        begin
                           tx_dec_state_nxt   = TX_DEC_PTP_2;
                           pdelay_resp_tx_nxt = 1'b1;
                        end
                     // detect General 1588 Messages then wait for next frame and also if
                     // invalid - wait for next frame
                     // only detect Pdelay general message for 1588 but add Follow_Up for 802.1AS
                     else
                     begin
                       general_frame_tx_nxt =  ((transmit_data_buf[3:0] == 4'h8)   // Follow_Up (for 802.1AS)
                                               |(transmit_data_buf[3:0] == 4'ha)   // Pdelay_Resp_Follow_Up
                                               |(transmit_data_buf[3:0] == 4'hb)   // Announce (for 802.1AS)
                                               |(transmit_data_buf[3:0] == 4'hc)); // Signalling (for 802.1AS)
                       tx_dec_state_nxt  = TX_DEC_IDLE;
                     end
                  end

               7'b0110000 : // timestamp start position is 34B after messageType
                  begin
                     tx_dec_state_nxt  = TX_DEC_PTP_2;
                  end

               7'b0111001 : // timestamp end position is 9B after timestamp start
                  begin
                     // this will stop tx_ptp_count after TS finished
                     tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_PTP_2;
                  end

               endcase
            end

         TX_DEC_VPTP_1 : // decode Ethernet PTP
            begin
               case (tx_ptp_count)

               7'b0001101 : // VLAN
                  begin
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt  = TX_DEC_VPTP_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0010000 : // Ethertype1 PTP
                  begin
                     if (transmit_data_buf[7:0] == 8'h88)
                        tx_dec_state_nxt  = TX_DEC_VPTP_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0010001 : // Ethertype2 PTP
                  begin
                     if (transmit_data_buf[7:0] == 8'hf7)
                       tx_dec_state_nxt  = TX_DEC_VPTP_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0010010 : // messageType
                  begin
                     // sync frame
                     if (transmit_data_buf[3:0] == 4'h0)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VPTP_1;
                           sync_frame_tx_nxt = 1'b1;
                           ptp_timestamp_position = tx_ptp_count;
                           ptp_timestamp_position_cap   = 1'b1;
                        end
                     // delay_req frame
                     else if (transmit_data_buf[3:0] == 4'h1)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VPTP_1;
                           delay_req_tx_nxt  = 1'b1;
                        end
                     // detect General 1588 Messages then wait for next frame and also if
                     // invalid - wait for next frame
                     else
                     begin
                       general_frame_tx_nxt =  tx_buf_89bcd;
                       tx_dec_state_nxt  = TX_DEC_IDLE;
                     end
                  end

               7'b0110100 : // timestamp start position is 34B after messageType
                  begin
                     tx_dec_state_nxt  = TX_DEC_VPTP_1;
                  end

               7'b0111101 : // timestamp end position is 9B after timestamp start
                  begin
                     // this will stop tx_ptp_count after TS finished
                     tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_VPTP_1;
                  end

               endcase
            end

         TX_DEC_VPTP_2 : // decode Ethertype PTP
            begin
               case (tx_ptp_count)

               7'b0001101 : // VLAN
                  begin
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt  = TX_DEC_VPTP_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0010000 : // Ethertype1 PTP
                  begin
                     if (transmit_data_buf[7:0] == 8'h88)
                        tx_dec_state_nxt  = TX_DEC_VPTP_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0010001 : // Ethertype2 PTP
                  begin
                     if (transmit_data_buf[7:0] == 8'hf7)
                       tx_dec_state_nxt  = TX_DEC_VPTP_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0010010 : // messageType
                  begin  // Sync frame for 802.1AS is not supported with VLAN tag
                         // so sync frame decode has been removed from this state
                     // pdelay_req frame
                     if (transmit_data_buf[3:0] == 4'h2)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VPTP_2;
                           pdelay_req_tx_nxt = 1'b1;
                        end
                     // pdelay_resp
                     else if (transmit_data_buf[3:0] == 4'h3)
                        begin
                           tx_dec_state_nxt   = TX_DEC_VPTP_2;
                           pdelay_resp_tx_nxt = 1'b1;
                        end
                     // detect General 1588 Messages then wait for next frame and also if
                     // invalid - wait for next frame
                     else
                     begin
                       general_frame_tx_nxt =  (transmit_data_buf[3:0] == 4'ha);   // Pdelay_Resp_Follow_Up
                       tx_dec_state_nxt  = TX_DEC_IDLE;
                     end
                  end

               7'b0110100 : // timestamp start position is 34B after messageType
                  begin
                     tx_dec_state_nxt  = TX_DEC_VPTP_2;
                  end

               7'b0111101 : // timestamp end position is 9B after timestamp start
                  begin
                     // this will stop tx_ptp_count after TS finished
                     tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_VPTP_2;
                  end

               endcase
            end

         TX_DEC_IPV4_1 : // decode IPv4
            begin
               case (tx_ptp_count)
               7'b0001101 : // Ethertype IPv4
                  begin
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt  = TX_DEC_IPV4_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0010111 : // UDP protocol
                  begin
                     if (transmit_data_buf[7:0] == 8'h11)
                        tx_dec_state_nxt  = TX_DEC_IPV4_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0011110 : // IP multicast address 1
                  begin
                     // PTP primary and peer
                     if (transmit_data_buf[7:0] == 8'he0)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV4_1;
                           if (ptp_unicast_ena_sync &
                               (transmit_data_buf[7:0] == tx_ptp_unicast[31:24]))
                              ptp_unicast_nxt   = 1'b1;
                        end
                     // PTP unicast
                     else if (ptp_unicast_ena_sync &
                              (transmit_data_buf[7:0] == tx_ptp_unicast[31:24]))
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV4_1;
                           ptp_unicast_nxt   = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0011111 : // IP multicast address 2
                  begin
                     // PTP primary and peer, not unicast
                     if (~ptp_unicast & (transmit_data_buf[7:0] == 8'h00))
                        tx_dec_state_nxt  = TX_DEC_IPV4_1;
                     // PTP unicast
                     else if (ptp_unicast &
                              (transmit_data_buf[7:0] == tx_ptp_unicast[23:16]))
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV4_1;
                           ptp_unicast_nxt   = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0100000 : // IP multicast address 3
                  begin
                     // PTP primary, not unicast
                     if (~ptp_unicast & (transmit_data_buf[7:0] == 8'h01))
                        tx_dec_state_nxt  = TX_DEC_IPV4_2;
                     // peer delay, not unicast
                     else if (~ptp_unicast & (transmit_data_buf[7:0] == 8'h00))
                        tx_dec_state_nxt  = TX_DEC_IPV4_3;
                     // PTP unicast
                     else if (ptp_unicast &
                              (transmit_data_buf[7:0] == tx_ptp_unicast[15:8]))
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV4_2;
                           ptp_unicast_nxt   = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_IPV4_1;
                  end

               endcase
            end

         TX_DEC_IPV4_2 : // decode IPv4 PTP primary version 1 and 2
            begin
               case (tx_ptp_count)

               7'b0100001 : // IP multicast address 4
                  begin
                     // PTP primary version 1 and 2 possible, not unicast
                     if (~ptp_unicast & (transmit_data_buf[7:0] == 8'h81))
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV4_2;
                           ptp_ver_1_nxt     = 1'b1;
                           ptp_ver_2_nxt     = 1'b1;
                        end
                     // PTP primary version 1, not unicast
                     else if (ptp_primary_nunicast)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV4_2;
                           ptp_ver_1_nxt     = 1'b1;
                        end
                     // PTP unicast
                     else if (ptp_unicast &
                              (transmit_data_buf[7:0] == tx_ptp_unicast[7:0]))
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV4_2;
                           ptp_unicast_nxt   = 1'b1;
                           ptp_ver_2_nxt     = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0100100 : // UDP destination port 1
                  begin
                     if (transmit_data_buf[7:0] == 8'h01)
                        tx_dec_state_nxt  = TX_DEC_IPV4_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0100101 : // UDP destination port 2
                  begin
                     if (transmit_data_buf[7:0] == 8'h3f)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV4_2;
                           general_frame_tx_nxt = 1'b0;
                        end
                     else if (transmit_data_buf[7:0] == 8'h40)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV4_2;
                           general_frame_tx_nxt = 1'b1;
                        end

                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0101010 : // versionPTP and messageType in PTP version 2
                  begin
                     // correct address and versionPTP for version 2
           //          if (ptp_ver_2 & transmit_data_buf [15:8] == 8'h02)
                     if (ptp_ver_2 & transmit_data_buf [11:8] == 4'h2)
                        begin
                           ptp_ver_1_nxt  = 1'b0;
                           // sync frame
                           if (~general_frame_tx & transmit_data_buf[3:0] == 4'h0)
                              begin
                                 tx_dec_state_nxt  = TX_DEC_IPV4_2;
                                 sync_frame_tx_nxt = 1'b1;
                                 ptp_timestamp_position = tx_ptp_count;
                                 ptp_timestamp_position_cap   = 1'b1;
                              end
                           // delay_req frame
                           else if (~general_frame_tx & transmit_data_buf[3:0] == 4'h1)
                              begin
                                 tx_dec_state_nxt  = TX_DEC_IPV4_2;
                                 delay_req_tx_nxt  = 1'b1;
                              end
                           // unicast pdelay req frame
                           else if (ptp_unicast & ~general_frame_tx & transmit_data_buf[3:0] == 4'h2)
                              begin
                                 tx_dec_state_nxt  = TX_DEC_IPV4_2;
                                 pdelay_req_tx_nxt = 1'b1;
                              end
                           // unicast pdelay_req frame
                           else if (ptp_unicast & ~general_frame_tx & transmit_data_buf[3:0] == 4'h3)
                              begin
                                 tx_dec_state_nxt   = TX_DEC_IPV4_2;
                                 pdelay_resp_tx_nxt = 1'b1;
                              end
                           // detect General 1588 Messages then wait for next frame and also if
                           // invalid - wait for next frame
                           else
                           begin
                             general_frame_tx_nxt =  ptp_pri_final_general_chk;
                             tx_dec_state_nxt  = TX_DEC_IDLE;
                           end
                         end
                     // correct address and versionPTP for version 1
          //           else if (transmit_data_buf [15:8] == 8'h01) // ptp_ver_1 has to be 1 here ..
                     else if (transmit_data_buf [11:8] == 4'h1) // ptp_ver_1 has to be 1 here ..
                        begin
                           ptp_ver_2_nxt  = 1'b0;
                           tx_dec_state_nxt  = TX_DEC_IPV4_2;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b1001010 : // control in PTP version 1
                  begin
                     // correct address and versionPTP for version 1
                     if (ptp_ver_1)
                        begin
                           // sync frame
                           if (~general_frame_tx & transmit_data_buf[3:0] == 4'h0)
                              begin
                                 tx_dec_state_nxt  = TX_DEC_IPV4_2;
                                 sync_frame_tx_nxt = 1'b1;
                                 ptp_timestamp_position = tx_ptp_count;
                                 ptp_timestamp_position_cap_v1   = 1'b1;
                              end
                           // delay_req frame
                           else if (~general_frame_tx & transmit_data_buf[3:0] == 4'h1)
                              begin
                                 tx_dec_state_nxt  = TX_DEC_IPV4_2;
                                 delay_req_tx_nxt   = 1'b1;
                              end
                           // detect General 1588 Messages then wait for next frame and also if
                           // invalid - wait for next frame
                          else
                           begin
                             general_frame_tx_nxt =  general_frame_tx & tx_buf_234;
                              tx_dec_state_nxt  = TX_DEC_IDLE;
                           end
                         end
                     // invalid - wait for next frame
                     else
                       if (sync_frame_tx_nxt) // ptp_ver_2 must be set here ...
                         tx_dec_state_nxt  = TX_DEC_IPV4_2;
                       else
                         tx_dec_state_nxt  = TX_DEC_IDLE;

                  end


               7'b1001100 : // timestamp start position is 34B after messageType for ptp verson 2
                  begin
                     tx_dec_state_nxt  = TX_DEC_IPV4_2;
                  end

               7'b1010010 : // timestamp start position is 8B after control for ptp verson 1
                  begin
                     tx_dec_state_nxt  = TX_DEC_IPV4_2;
                  end

               7'b1010101 : // timestamp end position is 9B after timestamp start
                  begin
                     // this will stop tx_ptp_count after TS finished for ptp verson 2
                     // but need to wait longer for ptp v1
                     if (ptp_ver_1 == 1'b1)
                       tx_dec_state_nxt  = TX_DEC_IPV4_2;
                     else
                      tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b1011001 : // timestamp end position is 7B after timestamp start for ptp verson 1
                  begin
                    tx_dec_state_nxt  = TX_DEC_IDLE;
                  end


               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_IPV4_2;
                  end

               endcase
            end

         TX_DEC_IPV4_3 : // decode IPv4 PTP pdelay
            begin
               case (tx_ptp_count)

               7'b0100001 : // IP multicast address 4
                  begin
                     // PTP peer
                     if (transmit_data_buf[7:0] == 8'h6b)
                        tx_dec_state_nxt  = TX_DEC_IPV4_3;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0100100 : // UDP destination port 1
                  begin
                     if (transmit_data_buf[7:0] == 8'h01)
                        tx_dec_state_nxt  = TX_DEC_IPV4_3;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0100101 : // UDP destination port 2
                  begin
                     if (transmit_data_buf[7:0] == 8'h3f)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV4_3;
                           general_frame_tx_nxt = 1'b0;
                        end
                     else if (transmit_data_buf[7:0] == 8'h40)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV4_3;
                           general_frame_tx_nxt = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0101010 : // messageType
                  begin
                     // pdelay_req frame
                     if (~general_frame_tx & transmit_data_buf[3:0] == 4'h2)
                        begin
                           tx_dec_state_nxt   = TX_DEC_IPV4_3;
                           pdelay_req_tx_nxt  = 1'b1;
                        end
                     // pdelay_resp frame
                     else if (~general_frame_tx & transmit_data_buf[3:0] == 4'h3)
                        begin
                           tx_dec_state_nxt   = TX_DEC_IPV4_3;
                           pdelay_resp_tx_nxt = 1'b1;
                        end
                     // detect General 1588 Messages then wait for next frame and also if
                     // invalid - wait for next frame
                     else
                     begin
                       general_frame_tx_nxt =  ptp_peer_final_general_chk; // Pdelay_Resp_Follow_Up
                       tx_dec_state_nxt  = TX_DEC_IDLE;
                     end
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_IPV4_3;
                  end

               endcase
            end

         TX_DEC_IPV6_1 : // decode IPv6
            begin
               case (tx_ptp_count)
               7'b0001101 : // Ethertype IPv6
                  begin
                     if (transmit_data_buf[7:0] == 8'hdd)
                        tx_dec_state_nxt  = TX_DEC_IPV6_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0010100 : // UDP protocol 1
                  begin
                     if (transmit_data_buf[7:0] == 8'h11)
                        tx_dec_state_nxt  = TX_DEC_IPV6_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0100110 : // IP multicast address part 1
                  begin
                     // PTP primary and peer delay
                     if (transmit_data_buf[7:0] == 8'hff)
                        tx_dec_state_nxt  = TX_DEC_IPV6_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_IPV6_1;
                  end

               endcase
            end

         TX_DEC_IPV6_2 : // decode IPv6 PTP primary
            begin
               case (tx_ptp_count)

               7'b0100111 : // IP multicast address part 2
                  begin
                     // PTP primary or peer delay
                     if (transmit_data_buf[7:0] == 8'h02)
                        tx_dec_state_nxt  = TX_DEC_IPV6_3;
                     // PTP primary
                     else
                        tx_dec_state_nxt  = TX_DEC_IPV6_2;
                  end

               7'b0101000, 7'b0101001, 7'b0101010, 7'b0101011, 7'b0101100,
               7'b0101101, 7'b0101110, 7'b0101111, 7'b0110000, 7'b0110001,
               7'b0110010, 7'b0110011 : // IP multicast address part
                  begin
                     // PTP primary
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt  = TX_DEC_IPV6_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0110100 : // IP multicast address
                  begin
                     // PTP primary
                     if (transmit_data_buf[7:0] == 8'h01)
                        tx_dec_state_nxt  = TX_DEC_IPV6_2;
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0110101 : // IP multicast address
                  begin
                     // PTP primary
                     if (transmit_data_buf[7:0] == 8'h81)
                        tx_dec_state_nxt  = TX_DEC_IPV6_2;
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0111000 : // UDP destination port 1
                  begin
                     if (transmit_data_buf[7:0] == 8'h01)
                        tx_dec_state_nxt  = TX_DEC_IPV6_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0111001 : // UDP destination port 2
                  begin
                     if (transmit_data_buf[7:0] == 8'h3f)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV6_2;
                           general_frame_tx_nxt = 1'b0;
                        end
                     else if (transmit_data_buf[7:0] == 8'h40)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV6_2;
                           general_frame_tx_nxt = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0111110 : // messageType
                  begin
                     // Sync frame
                     if (~general_frame_tx & transmit_data_buf[3:0] == 4'h0)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV6_2;
                           sync_frame_tx_nxt = 1'b1;
                           ptp_timestamp_position = tx_ptp_count;
                           ptp_timestamp_position_cap   = 1'b1;
                        end
                     // delay_req frame
                     else if (~general_frame_tx & transmit_data_buf[3:0] == 4'h1)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV6_2;
                           delay_req_tx_nxt  = 1'b1;
                        end
                     // detect General 1588 Messages then wait for next frame and also if
                     // invalid - wait for next frame
                     else
                     begin
                       general_frame_tx_nxt =  general_frame_tx_dec;
                       tx_dec_state_nxt  = TX_DEC_IDLE;
                     end
                  end

               7'b1100000 : // timestamp start position is 34B after messageType
                  begin
                     tx_dec_state_nxt  = TX_DEC_IPV6_2;
                  end

               7'b1101001 : // timestamp end position is 9B after timestamp start
                  begin
                     // this will stop tx_ptp_count after TS finished
                     tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

                default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_IPV6_2;
                  end

               endcase
            end

         TX_DEC_IPV6_3 : // decode IPv6 PTP pdelay
            begin
               case (tx_ptp_count)

               7'b0101000, 7'b0101001, 7'b0101010, 7'b0101011, 7'b0101100,
               7'b0101101, 7'b0101110, 7'b0101111, 7'b0110000, 7'b0110001,
               7'b0110010, 7'b0110011 : // IP multicast address part
                  begin
                     // PTP primary
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt  = TX_DEC_IPV6_3;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0110100 : // IP multicast address
                  begin
                     // PTP pdelay
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt  = TX_DEC_IPV6_3;
                     // PTP primary
                     else if (transmit_data_buf[7:0] == 8'h01)
                        tx_dec_state_nxt  = TX_DEC_IPV6_2;
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0110101 : // IP multicast address
                  begin
                     // PTP primary
                     if (transmit_data_buf[7:0] == 8'h6b)
                        tx_dec_state_nxt  = TX_DEC_IPV6_3;
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0111000 : // UDP destination port 1
                  begin
                     if (transmit_data_buf[7:0] == 8'h01)
                        tx_dec_state_nxt  = TX_DEC_IPV6_3;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0111001 : // UDP destination port 2
                  begin
                     if (transmit_data_buf[7:0] == 8'h3f)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV6_3;
                           general_frame_tx_nxt = 1'b0;
                        end
                     else if (transmit_data_buf[7:0] == 8'h40)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV6_3;
                           general_frame_tx_nxt = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0111110 : // messageType
                  begin
                     // pdelay_req frame
                     if (~general_frame_tx & transmit_data_buf[3:0] == 4'h2)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV6_3;
                           pdelay_req_tx_nxt = 1'b1;
                        end
                     // pdelay_resp frame
                     else if (~general_frame_tx & transmit_data_buf[3:0] == 4'h3)
                        begin
                           tx_dec_state_nxt  = TX_DEC_IPV6_3;
                           pdelay_resp_tx_nxt   = 1'b1;
                        end
                     // detect General 1588 Messages then wait for next frame and also if
                     // invalid - wait for next frame
                     else
                     begin
                       general_frame_tx_nxt =  ptp_peer_final_general_chk; // Pdelay_Resp_Follow_Up
                       tx_dec_state_nxt  = TX_DEC_IDLE;
                     end
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_IPV6_3;
                  end

               endcase
            end

         TX_DEC_VIPV4_1 : // decode IPv4
            begin
               case (tx_ptp_count)
               7'b0010001 : // Ethertype IPv4
                  begin
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt  = TX_DEC_VIPV4_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0011011 : // UDP protocol
                  begin
                     if (transmit_data_buf[7:0] == 8'h11)
                        tx_dec_state_nxt  = TX_DEC_VIPV4_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0100010 : // IP multicast address 1
                  begin
                     // PTP primary and peer
                     if (transmit_data_buf[7:0] == 8'he0)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV4_1;
                           if (ptp_unicast_ena_sync &
                               (transmit_data_buf[7:0] == tx_ptp_unicast[31:24]))
                              ptp_unicast_nxt   = 1'b1;
                        end
                     // PTP unicast
                     else if (ptp_unicast_ena_sync &
                              (transmit_data_buf[7:0] == tx_ptp_unicast[31:24]))
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV4_1;
                           ptp_unicast_nxt   = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0100011 : // IP multicast address 2
                  begin
                     // PTP primary and peer, not unicast
                     if (~ptp_unicast & (transmit_data_buf[7:0] == 8'h00))
                        tx_dec_state_nxt  = TX_DEC_VIPV4_1;
                     // PTP unicast
                     else if (ptp_unicast &
                              (transmit_data_buf[7:0] == tx_ptp_unicast[23:16]))
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV4_1;
                           ptp_unicast_nxt   = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0100100 : // IP multicast address 3
                  begin
                     // PTP primary, not unicast
                     if (~ptp_unicast & (transmit_data_buf[7:0] == 8'h01))
                        tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                     // peer delay, not unicast
                     else if (~ptp_unicast & (transmit_data_buf[7:0] == 8'h00))
                        tx_dec_state_nxt  = TX_DEC_VIPV4_3;
                     // PTP unicast
                     else if (ptp_unicast &
                              (transmit_data_buf[7:0] == tx_ptp_unicast[15:8]))
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                           ptp_unicast_nxt   = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_VIPV4_1;
                  end

               endcase
            end

         TX_DEC_VIPV4_2 : // decode IPv4 PTP primary version 1 and 2
            begin
               case (tx_ptp_count)

               7'b0100101 : // IP multicast address 4
                  begin
                     // PTP primary version 1 and 2 possible, not unicast
                     if (~ptp_unicast & (transmit_data_buf[7:0] == 8'h81))
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                           ptp_ver_1_nxt     = 1'b1;
                           ptp_ver_2_nxt     = 1'b1;
                        end
                     // PTP primary version 1, not unicast
                     else if (ptp_primary_nunicast)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                           ptp_ver_1_nxt     = 1'b1;
                        end
                     // PTP unicast
                     else if (ptp_unicast &
                              (transmit_data_buf[7:0] == tx_ptp_unicast[7:0]))
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                           ptp_unicast_nxt   = 1'b1;
                           ptp_ver_2_nxt     = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0101000 : // UDP destination port 1
                  begin
                     if (transmit_data_buf[7:0] == 8'h01)
                        tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0101001 : // UDP destination port 2
                  begin
                     if (transmit_data_buf[7:0] == 8'h3f)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                           general_frame_tx_nxt = 1'b0;
                        end
                     else if (transmit_data_buf[7:0] == 8'h40)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                           general_frame_tx_nxt = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0101110 : // versionPTP and messageType in PTP version 2
                  begin
                     // correct address and versionPTP for version 2
           //          if (ptp_ver_2 & transmit_data_buf [15:8] == 8'h02)
                     if (ptp_ver_2 & transmit_data_buf [11:8] == 4'h2)
                        begin
                           ptp_ver_1_nxt  = 1'b0;
                           // sync frame
                           if (~general_frame_tx & transmit_data_buf[3:0] == 4'h0)
                              begin
                                 tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                                 sync_frame_tx_nxt = 1'b1;
                                 ptp_timestamp_position = tx_ptp_count;
                                 ptp_timestamp_position_cap   = 1'b1;
                              end
                           // delay_req frame
                           else if (~general_frame_tx & transmit_data_buf[3:0] == 4'h1)
                              begin
                                 tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                                 delay_req_tx_nxt  = 1'b1;
                              end
                           // unicast pdelay req frame
                           else if (~general_frame_tx & ptp_unicast & transmit_data_buf[3:0] == 4'h2)
                              begin
                                 tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                                 pdelay_req_tx_nxt = 1'b1;
                              end
                           // unicast pdelay_req frame
                           else if (~general_frame_tx & ptp_unicast & transmit_data_buf[3:0] == 4'h3)
                              begin
                                 tx_dec_state_nxt   = TX_DEC_VIPV4_2;
                                 pdelay_resp_tx_nxt = 1'b1;
                              end
                           // detect General 1588 Messages then wait for next frame and also if
                           // invalid - wait for next frame
                           else
                           begin
                             general_frame_tx_nxt = ptp_pri_final_general_chk;
                             tx_dec_state_nxt  = TX_DEC_IDLE;
                           end
                         end
                     // correct address and versionPTP for version 1
             //        else if (transmit_data_buf [15:8] == 8'h01) // ptp_ver_1 must be set in here ...
                     else if (transmit_data_buf [11:8] == 4'h1) // ptp_ver_1 must be set in here ...
                        begin
                           ptp_ver_2_nxt  = 1'b0;
                           tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b1001110 : // control in PTP version 1
                  begin
                     // correct address and versionPTP for version 1
                     if (ptp_ver_1)
                        begin
                           // sync frame
                           if (~general_frame_tx & transmit_data_buf[3:0] == 4'h0)
                              begin
                                 tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                                 sync_frame_tx_nxt = 1'b1;
                                 ptp_timestamp_position = tx_ptp_count;
                                 ptp_timestamp_position_cap_v1   = 1'b1;
                              end
                           // delay_req frame
                           else if (~general_frame_tx & transmit_data_buf[3:0] == 4'h1)
                              begin
                                 tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                                 delay_req_tx_nxt   = 1'b1;
                              end
                           // detect General 1588 Messages then wait for next frame and also if
                           // invalid - wait for next frame
                           else
                           begin
                             general_frame_tx_nxt =  general_frame_tx & tx_buf_234;
                             tx_dec_state_nxt  = TX_DEC_IDLE;
                           end
                         end
                     // invalid - wait for next frame
                     else
                       if (sync_frame_tx_nxt) // ptp_ver_2 must be set here ..
                         tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                       else
                         tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b1010000 : // timestamp start position is 34B after messageType
                  begin
                     tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                  end

               7'b1010110 : // // timestamp start position is 8B after control for ptp verson 1
                  begin
                     tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                  end

               7'b1011001 : // timestamp end position is 9B after timestamp start
                  begin
                     // this will stop tx_ptp_count after TS finished for ptp verson 2
                     // but need to wait longer for ptp v1
                     if (ptp_ver_1 == 1'b1)
                       tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                     else
                      tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b1011101 : // timestamp end position is 7B after timestamp start for ptp verson 1
                  begin
                    tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_VIPV4_2;
                  end

               endcase
            end

         TX_DEC_VIPV4_3 : // decode IPv4 PTP pdelay
            begin
               case (tx_ptp_count)

               7'b0100101 : // IP multicast address 4
                  begin
                     // PTP peer
                     if (transmit_data_buf[7:0] == 8'h6b)
                        tx_dec_state_nxt  = TX_DEC_VIPV4_3;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0101000 : // UDP destination port 1
                  begin
                     if (transmit_data_buf[7:0] == 8'h01)
                        tx_dec_state_nxt  = TX_DEC_VIPV4_3;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0101001 : // UDP destination port 2
                  begin
                     if (transmit_data_buf[7:0] == 8'h3f)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV4_3;
                           general_frame_tx_nxt = 1'b0;
                        end
                     else if (transmit_data_buf[7:0] == 8'h40)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV4_3;
                           general_frame_tx_nxt = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0101110 : // messageType
                  begin
                     // pdelay_req frame
                     if (~general_frame_tx & transmit_data_buf[3:0] == 4'h2)
                        begin
                           tx_dec_state_nxt   = TX_DEC_VIPV4_3;
                           pdelay_req_tx_nxt  = 1'b1;
                        end
                     // pdelay_resp frame
                     else if (~general_frame_tx & transmit_data_buf[3:0] == 4'h3)
                        begin
                           tx_dec_state_nxt   = TX_DEC_VIPV4_3;
                           pdelay_resp_tx_nxt = 1'b1;
                        end
                     // detect General 1588 Messages then wait for next frame and also if
                     // invalid - wait for next frame
                     else
                     begin
                       general_frame_tx_nxt =  ptp_peer_final_general_chk; // Pdelay_Resp_Follow_Up
                       tx_dec_state_nxt  = TX_DEC_IDLE;
                     end
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_VIPV4_3;
                  end

               endcase
            end

         TX_DEC_VIPV6_1 : // decode IPv6
            begin
               case (tx_ptp_count)
               7'b0010001 : // Ethertype IPv6
                  begin
                     if (transmit_data_buf[7:0] == 8'hdd)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0011000 : // UDP protocol 1
                  begin
                     if (transmit_data_buf[7:0] == 8'h11)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_1;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0101010 : // IP multicast address part 1
                  begin
                     // PTP primary and peer delay
                     if (transmit_data_buf[7:0] == 8'hff)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_VIPV6_1;
                  end

               endcase
            end

         TX_DEC_VIPV6_2 : // decode IPv6 PTP primary
            begin
               case (tx_ptp_count)

               7'b0101011 : // IP multicast address part 2
                  begin
                     // PTP primary or peer delay
                     if (transmit_data_buf[7:0] == 8'h02)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_3;
                     // PTP primary
                     else
                        tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                  end

               7'b0101100, 7'b0101101, 7'b0101110, 7'b0101111, 7'b0110000,
               7'b0110001, 7'b0110010, 7'b0110011, 7'b0110100, 7'b0110101,
               7'b0110110, 7'b0110111 : // IP multicast address part
                  begin
                     // PTP primary
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0111000 : // IP multicast address
                  begin
                     // PTP primary
                     if (transmit_data_buf[7:0] == 8'h01)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0111001 : // IP multicast address
                  begin
                     // PTP primary
                     if (transmit_data_buf[7:0] == 8'h81)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0111100 : // UDP destination port 1
                  begin
                     if (transmit_data_buf[7:0] == 8'h01)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0111101 : // UDP destination port 2
                  begin
                     if (transmit_data_buf[7:0] == 8'h3f)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                           general_frame_tx_nxt = 1'b0;
                        end
                     else if (transmit_data_buf[7:0] == 8'h40)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                           general_frame_tx_nxt = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b1000010 : // messageType
                  begin
                     // PTP primary
                     if (~general_frame_tx & transmit_data_buf[3:0] == 4'h0)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                           sync_frame_tx_nxt = 1'b1;
                           ptp_timestamp_position = tx_ptp_count;
                           ptp_timestamp_position_cap   = 1'b1;
                        end
                     // peer delay
                     else if (~general_frame_tx & transmit_data_buf[3:0] == 4'h1)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                           delay_req_tx_nxt  = 1'b1;
                        end
                     // detect General 1588 Messages then wait for next frame and also if
                     // invalid - wait for next frame
                     else
                     begin
                       general_frame_tx_nxt =  general_frame_tx_dec;
                       tx_dec_state_nxt  = TX_DEC_IDLE;
                     end
                  end

               7'b1100100 : // timestamp start position is 34B after messageType
                  begin
                     tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                  end

               7'b1101101 : // timestamp end position is 9B after timestamp start
                  begin
                     // this will stop tx_ptp_count after TS finished
                     tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                  end

               endcase
            end

         TX_DEC_VIPV6_3 : // decode IPv6 PTP pdelay
            begin
               case (tx_ptp_count)

               7'b0101100, 7'b0101101, 7'b0101110, 7'b0101111, 7'b0110000,
               7'b0110001, 7'b0110010, 7'b0110011, 7'b0110100, 7'b0110101,
               7'b0110110, 7'b0110111 : // IP multicast address part
                  begin
                     // PTP primary
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_3;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0111000 : // IP multicast address
                  begin
                     // PTP pdelay
                     if (transmit_data_buf[7:0] == 8'h00)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_3;
                     // PTP primary
                     else if (transmit_data_buf[7:0] == 8'h01)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_2;
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0111001 : // IP multicast address
                  begin
                     // PTP primary
                     if (transmit_data_buf[7:0] == 8'h6b)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_3;
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                  end

               7'b0111100 : // UDP destination port 1
                  begin
                     if (transmit_data_buf[7:0] == 8'h01)
                        tx_dec_state_nxt  = TX_DEC_VIPV6_3;
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b0111101 : // UDP destination port 2
                  begin
                     if (transmit_data_buf[7:0] == 8'h3f)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV6_3;
                           general_frame_tx_nxt = 1'b0;
                        end
                     else if (transmit_data_buf[7:0] == 8'h40)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV6_3;
                           general_frame_tx_nxt = 1'b1;
                        end
                     // invalid - wait for next frame
                     else
                        tx_dec_state_nxt  = TX_DEC_IDLE;
                   end

               7'b1000010 : // messageType
                  begin
                     // pdelay_req frame
                     if (~general_frame_tx & transmit_data_buf[3:0] == 4'h2)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV6_3;
                           pdelay_req_tx_nxt = 1'b1;
                        end
                     // pdelay_resp frame
                     else if (~general_frame_tx & transmit_data_buf[3:0] == 4'h3)
                        begin
                           tx_dec_state_nxt  = TX_DEC_VIPV6_3;
                           pdelay_resp_tx_nxt   = 1'b1;
                        end
                     // detect General 1588 Messages then wait for next frame and also if
                     // invalid - wait for next frame
                     else
                     begin
                       general_frame_tx_nxt =  ptp_peer_final_general_chk; // Pdelay_Resp_Follow_Up
                       tx_dec_state_nxt  = TX_DEC_IDLE;
                     end
                  end

               default :
                  begin
                     tx_dec_state_nxt  = TX_DEC_VIPV6_3;
                  end

               endcase
            end


         default      : // TX_DEC_IDLE
            begin
               // If new frame coming in goto RX_DEC_DA1, only if enabled
               // by synchronous process of state machine.
               ptp_ver_1_nxt        = 1'b0;
               ptp_ver_2_nxt        = 1'b0;
               ptp_unicast_nxt      = 1'b0;
               if (data_type == TYPE_PREAMBLE)
                  begin
                     tx_dec_state_nxt     = TX_DEC_START;
                     en_tx_ptp_count_nxt  = 1'b1;
                  end
               else
                  begin
                     tx_dec_state_nxt     = TX_DEC_IDLE;
                     en_tx_ptp_count_nxt  = 1'b0;
                  end
            end

      endcase
   end


   // count through PTP frame when en_tx_ptp_count is high
   // in 10/100 mode only update every other cycle
   // tx_ptp_count is a counter up to 127.  It can rollover
   // but only in cases that we dont use it, so safe
   // It is used for PTP single step timestamping and for that
   // the max size of the headers before the timestamp field
   // is <128bytes (we dont allow Ipv6 extension headers or Ipv4
   // options for PTP frames
   always@(posedge tx_clk or negedge n_txreset)
     begin
      if (~n_txreset)
         begin
            tx_ptp_count <= 7'b0000000;
         end
      else if (~tx_en | ~en_transmit_sync)
         begin
            tx_ptp_count <= 7'b0000000;
         end
      else
        begin
          if (en_tx_ptp_count & ~nibble_sel & (data_type == TYPE_DATA))
            begin
              tx_ptp_count <= tx_ptp_count + 7'b0000001;
            end
         end
     end


   // drive PTP and peer delay signals
   // de-assert at end of frame
   // assert by TX Decode State Machine
   always@(posedge tx_clk or negedge n_txreset)
     begin
      if (~n_txreset)
         begin
            sync_frame_tx    <= 1'b0;
            delay_req_tx     <= 1'b0;
            pdelay_req_tx    <= 1'b0;
            pdelay_resp_tx   <= 1'b0;
            general_frame_tx <= 1'b0;
            ptp_ver_1        <= 1'b0;
            ptp_ver_2        <= 1'b0;
            ptp_unicast      <= 1'b0;
         end
      else if (~tx_en | ~en_transmit_sync)
         begin
            sync_frame_tx    <= 1'b0;
            delay_req_tx     <= 1'b0;
            pdelay_req_tx    <= 1'b0;
            pdelay_resp_tx   <= 1'b0;
            general_frame_tx <= 1'b0;
            ptp_ver_1        <= 1'b0;
            ptp_ver_2        <= 1'b0;
            ptp_unicast      <= 1'b0;
          end
      else
         begin
            sync_frame_tx    <= sync_frame_tx_nxt;
            delay_req_tx     <= delay_req_tx_nxt;
            pdelay_req_tx    <= pdelay_req_tx_nxt;
            pdelay_resp_tx   <= pdelay_resp_tx_nxt;
            general_frame_tx <= general_frame_tx_nxt;
            ptp_ver_1        <= ptp_ver_1_nxt;
            ptp_ver_2        <= ptp_ver_2_nxt;
            ptp_unicast      <= ptp_unicast_nxt;
         end
     end

   // Synchronise into TX for BP application
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_rx_dv (
     .clk    (tx_clk),
     .reset_n(n_txreset),
     .din    (rx_dv),
     .dout   (rx_dv_sync)
   );

  assign apply_bp_comb =  back_pressure | halfduplex_fc_en;
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_apply_bp (
    .clk    (tx_clk),
    .reset_n(n_txreset),
    .din    (apply_bp_comb),
    .dout   (apply_bp)
  );


   // synchronise back_pressure to tx_clk. Generate back pressure signal
   // when receive detected in half duplex and not transmitting.
   always@(posedge tx_clk or negedge n_txreset)
     begin
      if (~n_txreset)
         begin
            back_pressure_sync1 <= 1'b0;
            back_pressure_sync2 <= 1'b0;
            back_pressure_sync3 <= 1'b0;
            back_pressure_sync4 <= 1'b0;
         end
      else
         begin
            // only set back_pressure_sync1 when rx_dv invalid
            back_pressure_sync1 <= apply_bp &
                                (back_pressure_sync1 | ~rx_dv_sync);
            back_pressure_sync2 <= back_pressure_sync1 & rx_dv_sync &
                               (data_type == 4'b1000) & ~full_duplex & ~gigabit;
            back_pressure_sync3 <= back_pressure_sync2;
            back_pressure_sync4 <= back_pressure_sync3;
         end
     end

   // count back pressure down to zero
   always@(posedge tx_clk or negedge n_txreset)
     begin
      if (~n_txreset)
         bp_cnt <= 7'h00;
      else if (back_pressure_sync3 & ~back_pressure_sync4 & bit_rate)
         bp_cnt <= 7'h40;
      else if (back_pressure_sync3 & ~back_pressure_sync4)
         bp_cnt <= 7'h10;
      else if (bp_active)
         bp_cnt <= bp_cnt - 7'h01;
      else
         bp_cnt <= bp_cnt;
     end

   assign bp_active = (bp_cnt != 7'h00);


// -----------------------------------------------------------------------------
// RAS - End to end data path parity protection
// -----------------------------------------------------------------------------


  /////////////////////////////////////////////////
  // RAS - end to end parity check
  generate if (p_edma_asf_dap_prot == 1) begin : gen_dp_parity
    // Parity generators for transmit_data_mux
    // transmit_data_mux is the output of a huge multiplexor
    // which has the following sources
    // transmit_data_buf
    // crc
    // specific address (for pause)
    // Correction_field_new
    // tsu_ptp_tx_ts_latched
    // PFC and 802.3 Pause
    // Need to generate parity for items that don't already have it.
    cdnsdru_asf_parity_gen_v1 #(.p_data_width(16)) i_gem_par_gen_crc (
      .odd_par    (1'b0),
      .data_in    ({crc[31:24],
                    4'h0,crc[31:28]}),
      .data_out   (),
      .parity_out ({crc_24_31_par,
                    crc_28_31_par})
    );
    cdnsdru_asf_parity_gen_v1 #(.p_data_width(64)) i_gem_par_gen_cor (
      .odd_par    (1'b0),
      .data_in    (correction_field_new),
      .data_out   (),
      .parity_out (correction_field_new_par)
    );

    // The following parity is generated based on checking and regeneration of source data.
    gem_par_chk_regen #(.p_chk_dwid (80)) i_regen_tsu_ptp_tx_ts_latched_par (
      .odd_par  (1'b0),
      .chk_dat  ({2'b00,tsu_timer_sampled_on_sof_safe}),
      .chk_par  (tsu_timer_par_sampled_on_sof_safe),
      .new_dat  (tsu_ptp_tx_ts_latched),
      .dat_out  (),
      .par_out  (tsu_ptp_tx_ts_latched_par),
      .chk_err  ()
    );

    gem_par_chk_regen #(.p_chk_dwid (8), .p_new_dwid(16)) i_regen_tx_data_mux_par (
      .odd_par  (1'b0),
      .chk_dat  (transmit_data_mux[7:0]),
      .chk_par  (transmit_data_mux[8]),
      .new_dat  ({4'h0,transmit_data_mux[7:4],
                  4'h0,transmit_data_mux[3:0]}),
      .dat_out  (),
      .par_out  ({transmit_par_mux_7_4,
                  transmit_par_mux_3_0}),
      .chk_err  ()
    );

  end else begin : gen_no_dp_parity
    assign tsu_ptp_tx_ts_latched_par = 10'h000;
    assign correction_field_new_par  = 8'h00;
    assign crc_24_31_par    = 1'b0;
    assign crc_28_31_par    = 1'b0;
    assign transmit_par_mux_3_0 = 1'b0;
    assign transmit_par_mux_7_4 = 1'b0;
  end
  endgenerate
////////////////////////////////////////////////////////////


`ifdef ABV_ON

// tx_ts_update_cor_fld muxes the updated correction field into the data stream going to the transmit MAC.
// It goes high for the time it takes to transmit eight bytes. Check that it goes high for exactly the
// time it takes to transmit 8 bytes.


// if tx_ts_update_cor_fld goes high check it is low 8 cycles later
  property tx_ts_update_cor_fld_chk1;
    @(negedge tx_clk)
      $rose(tx_ts_update_cor_fld & tx_byte_mode) |-> ##8 tx_ts_update_cor_fld == 1'b0;
  endproperty
  AP_tx_ts_update_cor_fld_chk1 : assert property (tx_ts_update_cor_fld_chk1);

  property tx_ts_update_cor_fld_chk2;
    @(negedge tx_clk)
      $rose(tx_ts_update_cor_fld & ~tx_byte_mode) |-> ##16 tx_ts_update_cor_fld == 1'b0;
  endproperty
  AP_tx_ts_update_cor_fld_chk2 : assert property (tx_ts_update_cor_fld_chk2);


// if tx_ts_update_cor_fld goes high check it is still high 7 cycles later
  property tx_ts_update_cor_fld_chk3;
    @(negedge tx_clk)
      $rose(tx_ts_update_cor_fld & tx_byte_mode) |-> ##7 tx_ts_update_cor_fld;
  endproperty
  AP_tx_ts_update_cor_fld_chk3 : assert property (tx_ts_update_cor_fld_chk3);

  property tx_ts_update_cor_fld_chk4;
    @(negedge tx_clk)
      $rose(tx_ts_update_cor_fld & ~tx_byte_mode) |-> ##15 tx_ts_update_cor_fld;
  endproperty
  AP_tx_ts_update_cor_fld_chk4 : assert property (tx_ts_update_cor_fld_chk4);


// check tsu_timer_safe_to_sample when tx_ts_update_cor_fld is high
  property tx_ts_update_cor_fld_chk5;
    @(negedge tx_clk)
     $rose(tx_ts_update_cor_fld) |-> ##[0:8] tsu_timer_safe_to_sample;
  endproperty
  AP_tx_ts_update_cor_fld_chk5 : assert property (tx_ts_update_cor_fld_chk5);

 `endif

endmodule

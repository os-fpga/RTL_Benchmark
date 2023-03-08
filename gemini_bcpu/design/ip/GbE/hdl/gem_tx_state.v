//------------------------------------------------------------------------------
// Copyright (c) 2001-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_tx_state.v
//   Module Name:        gem_tx_state
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
//   Description :             This state machine forms part of the transmit
//                             path and controls the transmission of ethernet
//                             frames in accordance with the IEEE 802.3
//                             standard. It uses various timers and other
//                             control signals that are passed from gem_tx.v
//                             to determine the state.
//                             10/100 or 1000 Mbits/second data rates are
//                             provided and both half duplex and full duplex
//                             modes of operation are supported. When
//                             opperating in half duplex, the CSMA/CD protocol
//                             is followed. During transmission, the state
//                             machine progresses through the states preamble,
//                             sfd, data and crc. If the frame is less than 60
//                             bytes then the fill state is used to ensure the
//                             frame is at least 64 bytes including the crc.
//                             If gigabit, half duplex is selected, then a
//                             carrier extend state is used to ensure the frame
//                             is at least 512 bytes, unless its part of a
//                             burst. A second state for inserting carrier
//                             extension during the interframe gap
//                             (interframe_gap_burst) is provided when burst
//                             mode is operational. Burst mode is only used at
//                             the gigabit data rate when the half duplex mode
//                             is selected.
//                             Further control logic is provided to determine
//                             whether a frame is part of a burst. The first
//                             frame signal indicates this.
//                             The state machine operates in the tx_clk clock
//                             domain.
//
//      Original Author :      P.O.Hawkins
//
//------------------------------------------------------------------------------


// This is the state machine that controls the transmission of ethernet frames.
// It uses various timers and other conditions that are passed to it from
// gem_tx.v to determine its state. This module operates in the tx_clk domain.

module gem_tx_state (

   // inputs.
   tx_clk,
   n_txreset,
   backoff,
   last_attempt,
   interframe_gap,
   coll_sync,
   late_collision,
   crs_sync,
   fifo_underrun,
   jam,
   last_data,
   frame_ready,
   last_crc,
   last_preamble,
   within_60bytes,
   within_512bytes,
   en_transmit_sync,
   tx_no_crc,
   gigabit,
   within_burst_limit,
   full_duplex,
   txd_rdy,

   // outputs.
   load_backoff,
   start_ifg,
   start_jam,
   coll_occured,
   first_ifg,
   tx_en_next,
   data_type,
   start_frame,
   end_frame,
   end_data_frame,
   first_frame,
   excess_coll

   );


// state decode paramater declarations.
   parameter
      INTERFRAME_GAP_INIT    = 4'b0000, // interframe gap after tx_enable.
      IDLE                   = 4'b0001, // interframe gap completed.
      PREAMBLE               = 4'b0010, // preamble state during frame tx.
      PREAMBLE_COLL          = 4'b0011, // collision occured during preamble.
      SFD_COLL               = 4'b0100, // collision occured during sfd.
      JAM_ST                 = 4'b0101, // jam state, 16-bit times.
      SFD                    = 4'b0110, // sfd state during frame tx.
      DATA                   = 4'b0111, // data state during frame tx.
      CRC                    = 4'b1000, // crc state during frame tx.
      BACKOFF_ST             = 4'b1001, // backoff state, following jam.
      INTERFRAME_GAP_BOFF    = 4'b1010, // counts interframe gap (during BOFF).
      INTERFRAME_GAP_BURST   = 4'b1011, // carrier extension within ifg.
      INTERFRAME_GAP_ST      = 4'b1100, // normal ifg.
      FILL                   = 4'b1101, // pad state during frame tx.
      CARRIER_EXTEND         = 4'b1110, // carrier extension during frame tx.
      JAM_CE                 = 4'b1111; // jam during carrier extension.


// data type paramater declarations.
   parameter
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
      TYPE_HOLD              = 4'b1010; // Holding pattern while rdy is low


   // port declarations
   input         tx_clk;            // transmit clock.
   input         n_txreset;         // reset for tx_clk domain.
   input         backoff;           // signals backoff (ie while backoff_cnt
                                    // counts down to zero).

   input         last_attempt;      // indicates next collision will cause
                                    // the tx frame to be aborted.

   input         interframe_gap;    // set while interframe_cnt is counting.
   input         coll_sync;         // collision indication, synchronized
                                    // to tx_clk.

   input         late_collision;    // set when a late collision has
                                    // occured and used in gigabit mode
                                    // to prevent a transmit retry.

   input         crs_sync;          // carrier sense indication, synchronized
                                    // to tx_clk.

   input         fifo_underrun;     // indicates a fifo underrun condition
                                    // which forces the state machine into
                                    // the jam state.

   input         jam;               // asserted whilst jam is active.
   input         last_data;         // signals end of frame data.
   input         frame_ready;       // set when there is data available to
                                    // transmit.

   input         last_crc;          // indicates transmit window for crc.
   input         last_preamble;     // set to signal end of preamble.
   input         within_60bytes;    // used for inserting pad.
   input         within_512bytes;   // used for inserting carrier extension.

   input         en_transmit_sync;  // enable transmit, synchronized to tx_clk.
   input         tx_no_crc;         // crc can be enabled/disabled on a
                                    // per frame basis (part of descriptor).

   input         gigabit;           // indicates gigabit mode selected.
   input         within_burst_limit; // asserted when burst limit exceeded.

   input         full_duplex;       // indicates full duplex mode.
   input         txd_rdy;           // indicates we are back pressuring TX path

   output        load_backoff;      // asserted at end of jam with end_frame
   output        start_ifg;         // asserted at end_frame or when crs is
                                    // detected in IDLE or BACKOFF_ST states.

   output        start_jam;         // asserted as jam state is entered.
   output        coll_occured;      // asserted if coll occurs during frame
                                    // transmission.

   output        first_ifg;         // asserted on first ifg (not after a
                                    // collision or during bursting).

   output        tx_en_next;        // asserted during frame transmission.
   output  [3:0] data_type;         // indicates data_type for transmission:
                                    // 0000 data, 0001 crc, 0010 preamble,
                                    // 0011 sfd, 0100 jam, 0101 carrier_ext,
                                    // 0110 fill, 0111 burst_ifg, 1000 idle,
                                    // 1001 jam_ce.

   output        start_frame;       // single cycle pulse at the start of the
                                    // frame.

   output        end_frame;         // single cycle pulse at the end of the
                                    // frame.
   output        end_data_frame;    // single cycle pulse at the end of the
                                    // data phase of a frame (used for tx
                                    // bytes transmitted).

   output        first_frame;       // indicates first frame of a burst.
                                    // (active in gigabit mode, half duplex).

   output        excess_coll;       // asserted with jam state when collsion
                                    // attempts have reached 16.


   // reg declarations
   reg           load_backoff;      // asserted at end of jam with end_frame.
   reg           start_ifg;         // asserted at end_frame or when crs is
                                    // detected in IDLE or BACKOFF_ST states.

   reg           start_jam;         // asserted as jam state is entered.
   reg           coll_occured;      // asserted if coll occurs during frame
                                    // transmission.

   reg           first_ifg;         // asserted on first ifg (not after a
                                    // collision).

   reg           tx_en_next;        // asserted during frame transmission.
   reg     [3:0] data_type;         // indicates data_type for transmission:
                                    // 0000 data, 0001 crc, 0010 preamble,
                                    // 0011 sfd, 0100 jam, 0101 carrier_ext,
                                    // 0110 fill, 0111 burst_ifg, 1000 idle,
                                    // 1001 jam_ce.

   reg           start_frame;       // single cycle pulse at the start of the
                                    // frame.

   reg           end_frame;         // single cycle pulse at the end of the
                                    // frame.

   reg           end_data_frame;    // single cycle pulse at the end of the
                                    // data phase of a frame (used for tx
                                    // bytes transmitted).

   reg           first_frame;       // indicates first frame of a burst.
                                    // (active in gigabit mode, half duplex).

   reg           excess_coll;       // asserted with jam state when collsion
                                    // attempts have reached 16.

   reg     [3:0] mac_state_tx;      // state of gem tx state machine.
   reg     [3:0] mac_state_tx_next; // next state of gem tx state machine.


   // synchronous part of tx state machine.
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         // asynchronous reset for state machine.
         mac_state_tx <= INTERFRAME_GAP_INIT;
      else
         // state machine flip-flops.
         mac_state_tx <= mac_state_tx_next;
   end


   // helper signal - Collision or exception occurred ..
   wire   col_ex_occ;
   assign col_ex_occ = (coll_sync | fifo_underrun);

   // asynchronous next state decode for tx state machine.
   always@(*)
   begin
      // default values.
      load_backoff   = 1'b0;
      start_ifg      = 1'b0;
      start_jam      = 1'b0;
      coll_occured   = 1'b0;
      first_ifg      = 1'b0;
      start_frame    = 1'b0;
      end_frame      = 1'b0;
      end_data_frame = 1'b0;
      excess_coll    = 1'b0;

      if (~en_transmit_sync)
         // synchronous reset for state machine.
         begin
            tx_en_next        = 1'b0;
            data_type         = TYPE_IDLE;
            mac_state_tx_next = INTERFRAME_GAP_INIT;
         end
      else if (!txd_rdy)
         // synchronous reset for state machine.
         begin
            tx_en_next        = 1'b1;
            data_type         = TYPE_HOLD;
            mac_state_tx_next = mac_state_tx;
         end
      else
         // decodes for next state.
         case (mac_state_tx)
            INTERFRAME_GAP_INIT:
               // this state is entered following reset, and counts out
               // an interframe gap period prior to allowing
               // transmission to commence.
               begin
                  first_ifg  = 1'b1;
                  tx_en_next = 1'b0;
                  data_type  = TYPE_IDLE;
                  if (interframe_gap)
                     // interframe gap period still active (96-bit times).
                     mac_state_tx_next = INTERFRAME_GAP_INIT;
                  else
                     // interframe gap period complete.
                     mac_state_tx_next = IDLE;
               end
            IDLE:
               begin
                  if (frame_ready)
                     // frame has been queued for transmission.
                     begin
                        tx_en_next        = 1'b1;
                        data_type         = TYPE_PREAMBLE;
                        mac_state_tx_next = PREAMBLE;
                        start_frame       = 1'b1;
                     end
                  else
                     begin
                        tx_en_next = 1'b0;
                        data_type  = TYPE_IDLE;
                        if (crs_sync)
                           // deferral triggered by crs.
                           begin
                              start_ifg         = 1'b1;
                              mac_state_tx_next = INTERFRAME_GAP_ST;
                           end
                        else
                           // remain in idle state for frame to tx.
                           mac_state_tx_next = IDLE;
                     end
               end
            PREAMBLE:
               begin
                  tx_en_next = 1'b1;
                  data_type  = TYPE_PREAMBLE;
                  if (col_ex_occ & last_preamble)
                     // collision or exception occured, but sfd
                     // must still be transmitted.
                     begin
                        coll_occured      = coll_sync;
                        mac_state_tx_next = SFD_COLL;
                     end
                  else if (col_ex_occ)
                     // collision or exception occured, but preamble
                     // and sfd must still be transmitted.
                     begin
                        coll_occured      = coll_sync;
                        mac_state_tx_next = PREAMBLE_COLL;
                     end
                  else if (last_preamble)
                     // preamble comleted, sfd next.
                     mac_state_tx_next = SFD;
                  else
                     // preamble still being transmitted (7 bytes or
                     // 15 nibbles in total).
                     mac_state_tx_next = PREAMBLE;
               end
            SFD:
               begin
                  tx_en_next = 1'b1;
                  data_type  = TYPE_SFD;
                  if (col_ex_occ)
                     // collision or exception occured, enter jam
                     // state.
                     begin
                        start_jam         = 1'b1;
                        coll_occured      = coll_sync;
                        mac_state_tx_next = JAM_ST;
                     end
                  else
                     // single nibble or byte of sfd, move to data state.
                     mac_state_tx_next = DATA;
               end
            PREAMBLE_COLL:
               begin
                  tx_en_next = 1'b1;
                  data_type  = TYPE_PREAMBLE;
                  if (last_preamble)
                     // preamble comleted, sfd next and collision or exception
                     // pending.
                     mac_state_tx_next = SFD_COLL;
                  else
                     // preamble still being transmitted (7 bytes or
                     // 15 nibbles in total), collision or exception
                     // pending.
                     mac_state_tx_next = PREAMBLE_COLL;
               end
            SFD_COLL:
               // single nibble or byte of sfd, move to jam state.
               begin
                  tx_en_next        = 1'b1;
                  data_type         = TYPE_SFD;
                  start_jam         = 1'b1;
                  mac_state_tx_next = JAM_ST;
               end
            JAM_ST:
               begin
                  // only set excess collision when last
                  // attempt set and not a late collision
                  // in gigabit mode.
                  excess_coll = last_attempt & ~(gigabit &
                                late_collision);
                  tx_en_next  = 1'b1;
                  data_type   = TYPE_JAM;
                  if (jam)
                     // transmit jam sequence.
                     mac_state_tx_next = JAM_ST;
                  else
                     // jam completed.
                     begin
                        start_ifg = 1'b1;
                        if (last_attempt | fifo_underrun
                            | (gigabit & late_collision))
                           begin
                              // no transmit retry, if either
                              // last attempt or a late collision
                              // in gigabit mode.
                              end_frame         = 1'b1;
                              mac_state_tx_next = INTERFRAME_GAP_ST;
                              load_backoff      = 1'b0;
                           end
                        else
                           begin
                              // perform backoff, prior to re-transmit.
                              mac_state_tx_next = INTERFRAME_GAP_BOFF;
                              load_backoff      = 1'b1;
                           end
                     end
               end
            JAM_CE:
               begin
                  // only set excess collision when last
                  // attempt set and not a late collision
                  // in gigabit mode.
                  excess_coll = last_attempt & ~late_collision;
                  tx_en_next  = 1'b0;
                  data_type   = TYPE_JAM_CE;
                  if (jam)
                     mac_state_tx_next = JAM_CE;
                  else
                     begin
                        start_ifg = 1'b1;
                        if (last_attempt | fifo_underrun | late_collision)
                           begin
                              // no transmit retry, if either
                              // last attempt or a late collision
                              // in gigabit mode.
                              end_frame         = 1'b1;
                              mac_state_tx_next = INTERFRAME_GAP_ST;
                              load_backoff      = 1'b0;
                           end
                        else
                           begin
                              // perform backoff, prior to re-transmit.
                              mac_state_tx_next = INTERFRAME_GAP_BOFF;
                              load_backoff      = 1'b1;
                           end
                     end
               end
            DATA:
               begin
                  tx_en_next = 1'b1;
                  data_type  = TYPE_DATA;
                  if (col_ex_occ)
                     // collision or exception condition, enter jam state.
                     begin
                        start_jam         = 1'b1;
                        coll_occured      = coll_sync;
                        mac_state_tx_next = JAM_ST;
                     end
                  else if (~last_data)
                     // still frame data to be transmitted.
                     mac_state_tx_next = DATA;
                  else if (gigabit & tx_no_crc & ~full_duplex &
                           first_frame & within_512bytes)
                     // carrier extension necessary, tx_no_crc means
                     // padding not applied.
                     begin
                        end_data_frame    = 1'b1;
                        mac_state_tx_next = CARRIER_EXTEND;
                     end
                  else if (gigabit & tx_no_crc & ~full_duplex &
                           frame_ready & within_burst_limit)
                     // burst mode, carrier extension through ifg (gigabit
                     // mode, half duplex).
                     begin
                        end_frame         = 1'b1;
                        end_data_frame    = 1'b1;
                        start_ifg         = 1'b1;
                        mac_state_tx_next = INTERFRAME_GAP_BURST;
                     end
                  else if (tx_no_crc)
                     // either 10/100 mode and no crc append necessary or
                     // burst limit exceeded (gigabit, half duplex),
                     // tx_no_crc means padding not applied.
                     begin
                        end_frame         = 1'b1;
                        end_data_frame    = 1'b1;
                        start_ifg         = 1'b1;
                        mac_state_tx_next = INTERFRAME_GAP_ST;
                     end
                  else if (within_60bytes)
                     // padding neceesary.
                     mac_state_tx_next = FILL;
                  else
                     // crc to be appended to frame.
                     mac_state_tx_next = CRC;
               end
            FILL:
               begin
                  tx_en_next = 1'b1;
                  data_type  = TYPE_FILL;
                  if (coll_sync)
                     // collision condition, enter jam state.
                     begin
                        start_jam         = 1'b1;
                        coll_occured      = 1'b1;
                        mac_state_tx_next = JAM_ST;
                     end
                  else if (within_60bytes)
                     // count of frame length, until 60 bytes.
                     mac_state_tx_next = FILL;
                  else
                     // append crc.
                     mac_state_tx_next = CRC;
               end
            CRC:
               begin
                  tx_en_next = 1'b1;
                  data_type  = TYPE_CRC;
                  if (coll_sync)
                     // collision condition, enter jam state.
                     begin
                        start_jam         = 1'b1;
                        coll_occured      = 1'b1;
                        mac_state_tx_next = JAM_ST;
                     end
                  else if (~last_crc)
                     // crc still being transmitted.
                     mac_state_tx_next = CRC;
                  else if (gigabit & ~full_duplex & first_frame &
                            within_512bytes)
                     // carrier extension necessary.
                     begin
                        end_data_frame    = 1'b1;
                        mac_state_tx_next = CARRIER_EXTEND;
                     end
                  else if (gigabit & ~full_duplex & frame_ready &
                            within_burst_limit)
                     // burst mode, carrier extension through ifg (gigabit
                     // mode, half duplex).
                     begin
                        end_frame         = 1'b1;
                        end_data_frame    = 1'b1;
                        start_ifg         = 1'b1;
                        mac_state_tx_next = INTERFRAME_GAP_BURST;
                     end
                  else
                     // no frame ready or burst limit exceeded.
                     begin
                        end_frame         = 1'b1;
                        end_data_frame    = 1'b1;
                        start_ifg         = 1'b1;
                        mac_state_tx_next = INTERFRAME_GAP_ST;
                     end
               end
            BACKOFF_ST:
               begin
                  if (crs_sync)
                     // crs active whilst in backoff, perform deferral with
                     // backoff timer still active.
                     begin
                        tx_en_next        = 1'b0;
                        data_type         = TYPE_IDLE;
                        start_ifg         = 1'b1;
                        mac_state_tx_next = INTERFRAME_GAP_BOFF;
                     end
                  else if (backoff | ~frame_ready)
                     // backoff timer still active, or frame not ready.
                     begin
                        tx_en_next        = 1'b0;
                        data_type         = TYPE_IDLE;
                        mac_state_tx_next = BACKOFF_ST;
                     end
                  else
                     // commence transmission retry.
                     begin
                        tx_en_next        = 1'b1;
                        data_type         = TYPE_PREAMBLE;
                        mac_state_tx_next = PREAMBLE;
                        start_frame       = 1'b1;
                     end
               end
            INTERFRAME_GAP_BOFF:
               begin
                  if (interframe_gap)
                     // deferral still active, remain in this state.
                     begin
                        tx_en_next        = 1'b0;
                        data_type         = TYPE_IDLE;
                        mac_state_tx_next = INTERFRAME_GAP_BOFF;
                     end
                  else if (backoff | ~frame_ready)
                     // backoff timer still active, or frame not ready.
                     begin
                        tx_en_next        = 1'b0;
                        data_type         = TYPE_IDLE;
                        mac_state_tx_next = BACKOFF_ST;
                     end
                  else
                     // commence transmission retry.
                     begin
                        tx_en_next        = 1'b1;
                        data_type         = TYPE_PREAMBLE;
                        mac_state_tx_next = PREAMBLE;
                        start_frame       = 1'b1;
                     end
               end
            INTERFRAME_GAP_ST:
               begin
                  first_ifg = 1'b1;
                  if (interframe_gap)
                     // deferral still active, remain in this state.
                     begin
                        tx_en_next        = 1'b0;
                        data_type         = TYPE_IDLE;
                        mac_state_tx_next = INTERFRAME_GAP_ST;
                     end
                  else if (frame_ready)
                     // frame queued for transmission.
                     begin
                        tx_en_next        = 1'b1;
                        data_type         = TYPE_PREAMBLE;
                        mac_state_tx_next = PREAMBLE;
                        start_frame       = 1'b1;
                     end
                  else
                     // no frame queued, returned to idle.
                     begin
                        tx_en_next        = 1'b0;
                        data_type         = TYPE_IDLE;
                        mac_state_tx_next = IDLE;
                     end
               end
            CARRIER_EXTEND:
               begin
                  tx_en_next = 1'b0;
                  data_type  = TYPE_CARRIER;
                  if (coll_sync)
                     // collision condition, enter jam state.
                     begin
                        start_jam         = 1'b1;
                        coll_occured      = 1'b1;
                        mac_state_tx_next = JAM_CE;
                     end
                  else if (~within_512bytes & frame_ready)
                     // slot time completed and frame queued.
                     begin
                        end_frame         = 1'b1;
                        start_ifg         = 1'b1;
                        mac_state_tx_next = INTERFRAME_GAP_BURST;
                     end
                  else if (~within_512bytes & ~frame_ready)
                     // slot time completed and no frame queued.
                     begin
                        end_frame         = 1'b1;
                        start_ifg         = 1'b1;
                        mac_state_tx_next = INTERFRAME_GAP_ST;
                     end
                  else
                     // count out slot time (512 bytes).
                     mac_state_tx_next = CARRIER_EXTEND;
               end
            INTERFRAME_GAP_BURST:
               begin
                  if (coll_sync)
                     // collision condition, enter jam state.
                     begin
                        tx_en_next        = 1'b0;
                        data_type         = TYPE_CARRIER;
                        start_jam         = 1'b1;
                        coll_occured      = 1'b1;
                        mac_state_tx_next = JAM_CE;
                     end
                  else if (interframe_gap)
                     // deferral still active, remain in this state.
                     begin
                        tx_en_next        = 1'b0;
                        data_type         = TYPE_BURST_IFG;
                        mac_state_tx_next = INTERFRAME_GAP_BURST;
                     end
                  else
                     // frame must be queued ready for transmission.
                     begin
                        tx_en_next        = 1'b1;
                        data_type         = TYPE_PREAMBLE;
                        start_frame       = 1'b1;
                        mac_state_tx_next = PREAMBLE;
                     end
               end
         endcase
   end


   // register indicating first frame of burst (gigabit mode, half duplex).
   always@(posedge tx_clk or negedge n_txreset)
   begin
      if (~n_txreset)
         first_frame <= 1'b1;
      else if (~en_transmit_sync | (mac_state_tx[3:0] == INTERFRAME_GAP_ST) |
              (mac_state_tx[3:0] == INTERFRAME_GAP_BOFF) |
              (mac_state_tx[3:0] == IDLE))
         // first frame flag set when in either idle or ifg states and
         // after a collision.
         first_frame <= 1'b1;
      else if (mac_state_tx[3:0] == INTERFRAME_GAP_BURST)
         // first frame flag cleared when ifg (with carrier extension) state
         // is entered.
         first_frame <= 1'b0;
      else
         // else hold state of first frame flag.
         first_frame <= first_frame;
   end


endmodule

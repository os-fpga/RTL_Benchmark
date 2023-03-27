//------------------------------------------------------------------------------
// Copyright (c) 2015-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_pbuf_tx_enst.v
//   Module Name:        edma_pbuf_tx_enst
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
//   Description :  The EnST (Enhancement for Scheduled Traffic) requires
//            to define when a queue is available for transmitting
//            data and needs to make the scheduler aware of
//            how much time is available for transmission
//            in order that only frames that are smaller than the
//            available time are allowed to be transferred.
//            The outputs of the module are gatestate (signaling
//            that the queue is opened or closed) and byte_count
//            (that is signaling the left number of bytes that can
//            be sent to edma_pbuf_tx_rd side)
//            This module is divided into 2 sub-modules:
//
//            1) A FSM, that is managing some signals that are
//            controlling the system that is managing the opening and the closing
//            of the gates according to the start_time, the on_time and the off_time.
//            This module actually includes also a little comparator system.
//
//            2) A Frame Counter, which is counting the number of bytes that can be transferred
//            during the on_time, while the queue is enabled.
//
//------------------------------------------------------------------------------


// The edma_pbuf_tx_enst code module definition
module edma_pbuf_tx_enst #(

   parameter p_edma_asf_prot_tx_sched = 1'b0

    ) (
   input         tx_clk,
   input         n_txreset,
   input         tsu_clk,
   input         n_tsureset,
   input         enst_en,           // Enable signal for the queue
   input [93:16] tsu_timer_cnt,     // input from tsu
   input  [31:0] start_time,        // start_time of the transmission
   input  [16:0] on_time,           // Number of bytes that are desidered to be transferred in the on_time. Given:
                                    // on_time(bytes) = on_time(nsec) * rate /8, we can revert and obtain => on_time(nsec) = 8 *(on_time(bytes) / rate).
                                    //  @ 2.5 Gbps the user will have to insert on_time(bytes)/2.5 !
                                    //  @ 1   Gbps the user will have to insert on_time(bytes)
                                    //  @ 100 Mbps the user will have to insert on_time(bytes)
                                    //  @ 10  Mbps the user will have to insert on_time(bytes)
   input [16:0]  off_time,          // off time expressed in bytes. As for the on_time input, the equation is the same:
                                    // off_time(bytes) = off_time(nsec) * rate /8, we can revert and obtain => off_time(nsec) = 8 *(off_time(bytes) / rate).
                                    //  @ 2.5 Gbps the user will have to insert off_time(bytes)/2.5 !
                                    //  @ 1   Gbps the user will have to insert off_time(bytes)
                                    //  @ 100 Mbps the user will have to insert off_time(bytes)
                                    //  @ 10  Mbps the user will have to insert off_time(bytes)
   input  [1:0]  add_frag_size,     // This input encodes the number of bytes
                                    // that can be transferred before the pMAC
                                    // will have a chance to stop xmitting
                                    // to give the priority to the eMAC
                                    //  00 : 64  bytes
                                    //  01 : 128 bytes
                                    //  10:  192 bytes
                                    //  11:  256 bytes
   input  [1:0]  speed,             // This can encode 2.5 Gbps, 1Gbps, 100Mbps, 10Mbps:
                                    //  speed = 00 for 2.5 Gbps
                                    //  speed = 01 for 1   Gbps
                                    //  speed = 10 for 100 Mbps
                                    //  speed = 11 for 10  Mbps
   output [18:0] byte_count,        // how many bytes we can still transfer so far
   output        gatestate,         // Is the queue opened or closed?
   output        tsu_hold,          // 802.3br support signal, tsu_clk sync-ed

   output        asf_integrity_tx_enst_fsm_err,
   output        asf_integrity_tx_enst_fc_err
   );

   // reg and wire declarations.
   wire fsm_active;
   wire tsu_gatestate;
   wire gatestate_tx;
   wire fsm_active_tx;
   wire enst_en_tsu;

// -----------------------------------------------------------------------------
// Beginning of Hardware description
// -----------------------------------------------------------------------------

//Finite State Machine (FSM)
edma_pbuf_tx_enst_fsm i_enst_fsm (
   .tsu_clk      (tsu_clk),
   .n_tsureset   (n_tsureset),
   .enst_en_tsu  (enst_en_tsu),
   .tsu_timer_cnt(tsu_timer_cnt),
   .start_time   (start_time),
   .on_time      (on_time),
   .off_time     (off_time),
   .speed        (speed),
   .add_frag_size(add_frag_size),
   .fsm_active   (fsm_active),
   .tsu_gatestate(tsu_gatestate),
   .tsu_hold     (tsu_hold)
);

//Frame Counter module (FC)
edma_pbuf_tx_enst_fc i_enst_fc (
   .tx_clk       (tx_clk),
   .n_txreset    (n_txreset),
   .on_time      (on_time),
   .fsm_active   (fsm_active_tx),
   .gatestate    (gatestate_tx),
   .speed        (speed),
   .byte_count   (byte_count),
   .gatestate_out(gatestate)
);

cdnsdru_datasync_v1 i_sync_enst_enq (
   .clk    (tsu_clk),
   .reset_n(n_tsureset),
   .din    (enst_en),
   .dout   (enst_en_tsu)
);

//Sync for gatestate
cdnsdru_datasync_v1 i_sync_gatestate_tx (
   .clk    (tx_clk),
   .reset_n(n_txreset),
   .din    (tsu_gatestate),
   .dout   (gatestate_tx)
);

//Sync for fsm_active
cdnsdru_datasync_v1 i_sync_fsm_active (
   .clk    (tx_clk),
   .reset_n(n_txreset),
   .din    (fsm_active),
   .dout   (fsm_active_tx)
);

//------------------------------------------------------------------------------
// ASF - instantiate edma_pbuf_tx_enst_fsm and edma_pbuf_tx_enst_fc
// Duplication Protection of Transmit EnST
//------------------------------------------------------------------------------
generate if (p_edma_asf_prot_tx_sched == 1'b1) begin : gen_edma_pbuf_tx_enst_protect
  // reg and wire duplication declarations.
  wire        fsm_active_dplc;
  wire        tsu_hold_dplc;
  wire        tsu_gatestate_dplc;
  wire [18:0] byte_count_dplc;
  wire        gatestate_dplc;

  //Finite State Machine (FSM)
  edma_pbuf_tx_enst_fsm i_enst_fsm_asf_duplc (
     .tsu_clk      (tsu_clk),
     .n_tsureset   (n_tsureset),
     .enst_en_tsu  (enst_en_tsu),
     .tsu_timer_cnt(tsu_timer_cnt),
     .start_time   (start_time),
     .on_time      (on_time),
     .off_time     (off_time),
     .speed        (speed),
     .add_frag_size(add_frag_size),
     .fsm_active   (fsm_active_dplc),
     .tsu_gatestate(tsu_gatestate_dplc),
     .tsu_hold     (tsu_hold_dplc)
  );
  assign asf_integrity_tx_enst_fsm_err  = {fsm_active,tsu_gatestate,tsu_hold} != {fsm_active_dplc,tsu_gatestate_dplc,tsu_hold_dplc};

  //Frame Counter module (FC)
  edma_pbuf_tx_enst_fc i_enst_fc_asf_duplc (
     .tx_clk       (tx_clk),
     .n_txreset    (n_txreset),
     .on_time      (on_time),
     .fsm_active   (fsm_active_tx),
     .gatestate    (gatestate_tx),
     .speed        (speed),
     .byte_count   (byte_count_dplc),
     .gatestate_out(gatestate_dplc)
  );
  assign asf_integrity_tx_enst_fc_err = {byte_count,gatestate} != {byte_count_dplc,gatestate_dplc};

end else begin : gen_no_edma_pbuf_tx_enst_protect
  assign asf_integrity_tx_enst_fsm_err  = 1'b0;
  assign asf_integrity_tx_enst_fc_err   = 1'b0;
end
endgenerate

endmodule

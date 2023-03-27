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
//   Filename:           edma_fifo_ahb_tx.v
//   Module Name:        edma_fifo_ahb_tx
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
//   Description :
//
//       The function on the edma_tx is to provide management of how
//       the frame data flows from the ahb interface into the fifo,
//       onto the gem_tx and to have capability for dealing with two
//       frames at once whilst updating the descriptors.
//
//       The edma_tx block has three major constituent
//       parts.
//
//       1. To sequence transmit buffer management read and
//          writes to generate requests for these and monitor
//          the service received in a state machine.
//
//       2. To provide an interface to the gem_fifo, to automate
//          the pushing of data into the fifo, whilst realigning the
//          data to account for an offset. Then generate
//          requests for more data using tx_dma_bus_req and monitor
//          fifo status. There will be a minimum amount of
//          locations filled to keep the gem_tx constantly
//          supplied with data.
//
//       3. To interface to the gem_tx block, indicate that there
//          is valid data to pop from the fifo using
//          tx_frame_ready and wait until the gem_tx pops using
//          r_rd. To deal with collisions generated
//          in the gem_tx and writeback status appropriatly.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

// transmit dma module
module edma_fifo_ahb_tx (

   // system signals
   hclk,
   n_hreset,
   tx_r_clk,
   tx_r_rst_n,

   // fifo input signals from gem_tx
   tx_r_rd,

   // signals coming from gem_hclk_syncs
   tx_frame_end_pulse,
   too_many_retry_hclk,
   underflow_frame_hclk,
   late_coll_occ_hclk,
   new_tx_q_ptr_pulse,
   coll_occurred_hclk,
   tx_stat_capt_pulse,
   tx_halt_hclk,
   tx_start_hclk_pulse,
   enable_tx_hclk,
   tx_buff_q_base_addr,

   // signals coming from gem_registers
   dma_bus_width,
   ahb_burst_length,

   // inputs from edma_ahb
   tx_last_data_ph,
   tx_addr_inc_strobe,
   tx_addr_strobe,
   tx_data_strobe,
   tx_dma_data_in,
   tx_burst_error,
   tx_addr_bus_owned,

   // outputs signals to gem_tx
   dma_tx_status_tog,

   // fifo output signals to gem_tx
   tx_r_valid,
   tx_r_data,
   tx_r_eop,
   tx_r_sop,
   tx_r_mod,
   tx_r_err,
   tx_r_flushed,
   tx_r_underflow,
   tx_r_data_rdy,
   tx_r_control,

   // edma_tx state signals going to edma_ahb
   tx_dma_next_data,
   tx_dma_state_data,
   tx_dma_next_man_wr,
   tx_dma_state_man_wr,
   tx_dma_next_man_rd,
   tx_dma_state_man_rd,
   tx_dma_bus_req,
   tx_dma_flow_error,
   tx_dma_data_out,
   tx_dma_burst_addr,
   tx_data_burst_break,
   tx_dma_eop_burst,

   // outputs to pclk_syncs
   tx_dma_stable_tog,
   tx_dma_complete_ok,
   tx_dma_hresp_notok,
   tx_dma_buffers_ex,
   tx_dma_buff_ex_mid,
   tx_dma_go,
   tx_dma_descr_ptr,
   tx_dma_ptr_up_tog
   );


//***************************************************************************
// port declarations
//***************************************************************************

   // system signals
   input          hclk;                // AHB clock.
   input          n_hreset;            // AHB reset.
   input          tx_r_clk;            // tx_clk for fifo read clock.
   input          tx_r_rst_n;          // n_txreset for fifo read reset.

   // fifo input signals from gem_tx
   input          tx_r_rd;             // gem tx requires a pop from the fifo.

   // signals coming from gem_hclk_syncs
   input          tx_frame_end_pulse;  // Hclk pulse indicating the end of
                                       // transmission of the oldest frame.
   input          too_many_retry_hclk; // Sampled too_many_retries from gem_tx.
   input          underflow_frame_hclk;// Sampled underflow_frame from gem_tx.
   input          late_coll_occ_hclk;  // Sampled late_coll_occured from gem_tx.
   input          new_tx_q_ptr_pulse;  // New queue pointer written (NOT USED)
   input          coll_occurred_hclk;  // collision occurred on current frame,
                                       // cause a restart sequence.
   input          tx_stat_capt_pulse;  // Hclk pulse indicating tx dma status
                                       // has been captured within pclk domain.
   input          tx_halt_hclk;        // Hclk pulse indicating that
                                       // transmission should halt after all
                                       // ongoing activity has completed.
   input          tx_start_hclk_pulse; // Hclk pulse indicating that
                                       // transmission should begin.
   input          enable_tx_hclk;      // Enable transmission path (soft reset)
   input   [31:2] tx_buff_q_base_addr; // Base address for the buffer
                                       // descriptor queue.

   // signals coming from gem_registers
   input    [1:0] dma_bus_width;       // Current programmed width of data bus:
                                       // 00 = 32  bit bus (default)
                                       // 01 = 64  bit bus
                                       // 1x = 128 bit bus
   input    [4:0] ahb_burst_length;    // AHB burst length control

   // inputs from edma_ahb
   input          tx_burst_error;      // ahb hresp for last transfer was not
                                       // OKAY
   input          tx_addr_bus_owned;   // TX owns AHB address bus
   input          tx_last_data_ph;     // signals final ahb data phase.
   input          tx_addr_inc_strobe;  // Advanced warning that TX is about to
                                       // own the next address phase on the AHB.
                                       // Used to increment registered address
                                       // counters to cope with 0 wait states.
   input          tx_addr_strobe;      // signals individual ahb address phase.
   input          tx_data_strobe;      // signals individual ahb data phase.
   input  [127:0] tx_dma_data_in;      // Read data from the AHB (used for
                                       // management and data reads).

   // outputs signals to gem_tx
   output         dma_tx_status_tog;   // Signal to gem_tx that both writeback
                                       // and pclk status update have completed.

   // fifo output signals to gem_tx
   output         tx_r_valid;          // Validates data, eop, sop after a r_rd.
   output [`edma_bus_width-1:0]     //
                  tx_r_data;           // Read data from FIFO (128/64/32 bits)
   output         tx_r_eop;            // End of packet present on r_rd.
   output         tx_r_sop;            // Start of packet present on r_rd.
   output   [3:0] tx_r_mod;            // Number of valid bytes in final access.
                                       // Only valid when tx_r_eop also set.
   output         tx_r_err;            // There is a error with the current
                                       // frame being read from the FIFO. TX
                                       // MAC should terminate transmission.
   output         tx_r_flushed;        // Flush has been asserted.
   output         tx_r_underflow;      // r_rd asserted and fifo empty.
   output         tx_r_data_rdy;       // Enough data in FIFO to begin TX.
   output         tx_r_control;        // Packet control information.

   // edma_tx state signals going to edma_ahb
   output         tx_dma_next_data;    // next hclk cycle the edma_tx will
                                       // be in data read state
   output         tx_dma_state_data;   // data flow sm in data transfer state
   output         tx_dma_next_man_wr;  // next hclk cycle the edma_tx will
                                       // be in data write management state
   output         tx_dma_state_man_wr; // data flow sm in dma management write
                                       // state
   output         tx_dma_next_man_rd;  // next hclk cycle the edma_tx will
                                       // be in data read management state
   output         tx_dma_state_man_rd; // data flow sm in dma management read
                                       // state
   output         tx_dma_bus_req;      // TX DMA is requires the AHB.
   output         tx_dma_flow_error;   // data flow sm requires any ongoing bus
                                       // transactions to be aborted.
   output  [31:0] tx_dma_data_out;     // Write data for the AHB.
   output  [31:2] tx_dma_burst_addr;   // Address for AHB.
   output         tx_data_burst_break; // used to terminate a burst that does
                                       // not require the maximum burst length.
   output         tx_dma_eop_burst;    // indicates current burst is last in
                                       // packet and is less than whole burst.

   // outputs to pclk_syncs
   output         tx_dma_stable_tog;   // Toggles to indicate to PCLK domain
                                       // that the tx dma status outputs are
                                       // stable and ready to be sampled.
   output         tx_dma_complete_ok;  // Frame completed successfully in DMA.
   output         tx_dma_hresp_notok;  // DMA indicates HRESP not OK on frame.
   output         tx_dma_buffers_ex;   // DMA indicates buffers were exhausted
                                       // before SOP for frame written to FIFO.
   output         tx_dma_buff_ex_mid;  // DMA indicates buffers were exhausted
                                       // after SOP for frame written to FIFO.
   output         tx_dma_go;           // DMA indicates on-going activity.
   output  [31:2] tx_dma_descr_ptr;    // Descriptor queue pointer for debug
   output         tx_dma_ptr_up_tog;   // handshake for tx_dma_descr_ptr



//***************************************************************************
// wire and reg declarations
//***************************************************************************

   //***************************************************************************
   // TX DMA Data Flow Main State Machine
   //***************************************************************************
   reg      [2:0] edma_tx_state;       // state of dma tx state machine
   reg      [2:0] edma_tx_state_nxt;   // next state of dma tx state machine
   wire           s_tx_idle;           // current state is TX_MAN_IDLE
   wire           s_tx_frm1_rd;        // current state is TX_MAN_FRM1_RD
   wire           s_tx_frm1_buf_vld;   // current state is TX_MAN_FRM1_BUFF_VLD
   wire           s_tx_frm1_wr;        // current state is TX_MAN_FRM1_WR
   wire           s_tx_frm2_rd;        // current state is TX_MAN_FRM2_RD
   wire           s_tx_frm2_buf_vld;   // current state is TX_MAN_FRM2_BUFF_VLD
   wire           s_tx_frm2_wr;        // current state is TX_MAN_FRM2_WR
   wire           ns_tx_idle;          // next state is TX_MAN_IDLE
   wire           ns_tx_frm1_rd;       // next state is TX_MAN_FRM1_RD
   wire           ns_tx_frm1_buf_vld;  // next state is TX_MAN_FRM1_BUFF_VLD
   wire           ns_tx_frm1_wr;       // next state is TX_MAN_FRM1_WR
   wire           ns_tx_frm2_rd;       // next state is TX_MAN_FRM2_RD
   wire           ns_tx_frm2_buf_vld;  // next state is TX_MAN_FRM2_BUFF_VLD
   wire           ns_tx_frm2_wr;       // next state is TX_MAN_FRM2_WR

   //***************************************************************************
   // Track oldest and current frame
   //***************************************************************************
   reg            frame_1_older;       // if set frame one is the oldest frame.
   wire           frame_2_older;       // if set frame two is the oldest frame.
   reg            current_is_frm1;     // if set currently working with buffers
                                       // of frame one.
   wire           current_is_frm2;     // if set currently working with buffers
                                       // of frame two.
   wire           current_is_oldest;   // Indicates whether the frame whose
                                       // buffers are currrently being worked
                                       // with is the oldest in the system.

   //***************************************************************************
   // TX go and halt
   //***************************************************************************
   reg            current_sop_written; // Tracks whether the SOP for the current
                                       // frame has had it's SOP already written
                                       // into the FIFO.
   reg            sop_written_to_fifo; // Used to determine whether next write
                                       // to the FIFO will be the SOP.
   reg            zero_writeback_halt; // No writebacks required before halting
   reg            one_writeback_halt;  // One writeback required before halting
   reg            two_writeback_halt;  // Two writebacks required before halting
   reg      [2:0] tx_go_state_nxt;     // Next state of TX_GO state machine
   reg      [2:0] tx_go_state;         // Current state of TX_GO state machine
                                       // Used for tracking enabling of DMA
                                       // operation through tx_dma_go variable,
                                       // and for sequencing halt mechanism.
   wire           s_tx_go_idle;        // Current state is TX_GO_IDLE
   wire           s_tx_go_active;      // Current state is TX_GO_ACTIVE
   wire           s_tx_go_halt1;       // Current state is TX_GO_HALT1
   wire           s_tx_go_halt2;       // Current state is TX_GO_HALT2
   wire           s_tx_go_col;         // Current state is TX_GO_COL
   wire           ns_tx_go_idle;       // Next state is TX_GO_IDLE
   wire           ns_tx_go_active;     // Next state is TX_GO_ACTIVE
   wire           ns_tx_go_halt1;      // Next state is TX_GO_HALT1
   wire           ns_tx_go_halt2;      // Next state is TX_GO_HALT2
   wire           ns_tx_go_col;        // Next state is TX_GO_COL
   reg            tx_halt_all_reads;   // stop any new buffer/data reads
   wire           tx_halt_new_frames;  // stop any new frames being read
   wire           tx_halt_dma;         // halt the DMA now
   reg            tx_dma_go;           // sets bit in transmit status register
   reg            force_fifo_eop_err;  // force an ERROR/EOP into the FIFO

   //***************************************************************************
   // Management read descriptor saving
   //***************************************************************************
   reg            tx_first_buffer;     // set if first buffer in current frame.
   reg            tx_wrap_save_frm1;   // frame one wrap bit saved
   reg            tx_wrap_save_frm2;   // frame two wrap bit saved
   reg            tx_no_crc_save_frm1; // frame one crc bit saved
   reg            tx_no_crc_save_frm2; // frame two crc bit saved
   reg            tx_eof_save_frm1;    // frame one eof bit saved
   reg            tx_eof_save_frm2;    // frame two eof bit saved
   reg     [13:0] tx_length_save_frm1; // frame one length saved
   reg     [13:0] tx_length_save_frm2; // frame two length saved
   reg     [31:2] tx_q_ptr_save_frm1;  // Stored descriptor queue pointer for
                                       // frame 1
   reg     [31:2] tx_q_ptr_save_frm2;  // Stored descriptor queue pointer for
                                       // frame 2
   reg     [31:0] tx_dma_save_add_frm1;// saved address for frame one, used if
                                       // a retry occurs
   reg     [31:0] tx_dma_save_add_frm2;// saved address for frame two, used if
                                       // a retry occurs

   //***************************************************************************
   // Buffer length monitoring & control
   //***************************************************************************
   reg      [4:0] tx_length_decrement; // sets amount tx_dma_length is to be
                                       // decremented by on next clock
                                       // set by dma_bus_width
   reg      [1:0] tx_buffer_offset;    // saved buffer descriptor offset, used
                                       // for calculating the number of accesses
   reg     [13:0] tx_length_save;      // saved buffer descriptor length, used
                                       // for calculating the number of accesses
   reg            tx_eof;              // current buffer has eof bit set.
   reg     [11:0] buf_access_cnt;      // counts down the number of accesses
                                       // still to do in the current buffer
   reg     [11:0] buf_access_cnt_next; // next value of buf_access_cnt
   wire    [13:0] buf_access_cnt_start;// Value to be loaded into buf_access_cnt
   wire    [14:0] buf_access_cnt_start_pad;
   reg            buf_access_cnt_load; // forces a load of the access counter
   reg            last_access_full;    // final DMA access is a complete word
   reg      [4:0] last_access_bytes;   // number of bytes in final DMA access
   wire           next_buffer_done;    // indicates when buffers is about to
                                       // be filled
   reg            buffer_done_decode;  // Register to hold buffer completed
   wire           buffer_done;         // indicates when a buffers has completed
                                       // and the DMA has finished.
   wire           last_buf_done_decode;// Detect when the buffer just done is
                                       // the last in a frame.
   wire           last_buffer_done;    // Detect when the buffer just done is
                                       // the last in a frame and the DMA has
                                       // finished.
   wire           zero_length_decode;  // current buffer decoded is zero length
                                       // Set on 2nd descr read
   reg            zero_length_decode_0;// current buffer decoded is zero length
                                       // Set on 1st descr read
   reg            tx_wrap_0;           // wrap bit set (valid on 2nd descr)
   reg            tx_eof_0;            // eof bit set (valid on 2nd descr)
                                       // Set on 1st descr read
                                       // Set on 1st descr read
   reg            zero_length_buffer;  // delayed zero_length_decode
   wire           new_buffer_required; // signals the state machine to start
                                       // a management read request to get
                                       // a new buffer.

   //***************************************************************************
   // TX DMA address generation
   //***************************************************************************
   reg     [31:2] tx_dma_add;          // Address for the data within the
                                       // current buffer.
   reg     [31:2] nxt_tx_dma_add;      // Next address for the data within the
                                       // current buffer.

   //***************************************************************************
   // TX management address generation
   //***************************************************************************
   reg     [31:2] nxt_tx_q_ptr_cnt;    // Next descriptor queue pointer
   reg            tx_dma_ptr_up_tog;   // handshake for pclk synchronisation

   //***************************************************************************
   // Interface to AHB module
   //***************************************************************************
   reg     [31:0] man_rd_hrdata;       // AHB read data for management read.
   reg     [31:2] haddr;               // Address for current cycle.
   reg     [31:0] hwdata;              // Write data for ahb access.
   wire           hresp_notok;         // hresp not OK detected in the ahb.
   reg            hresp_notok_del;     // delayed hresp_notok for synthesis.
   reg            block_data_bus_req;  // Prevent DMA requesting for data.
   reg            data_bus_req;        // DMA request for data.
   reg            tx_bus_required;     // Access to ahb bus required.
   reg            tx_bus_required_hold;// Hold tx_dma_bus_req until owned.
   reg            dma_data_done;       // Set when current dma data burst ends.
   reg            first_descr_d_en;    // First Descriptor Read Enable
   reg            first_descr_a_en;    // First Descriptor Read Enable
   reg            frm1_rd_data_phase_0;// Indicate when first management read
                                       // data phase for frame 1.
   reg            frm1_rd_data_phase_1;// Indicate when second management read
                                       // data phase for frame 1.
   reg            frm2_rd_data_phase_0;// Indicate when first management read
                                       // data phase for frame 2.
   reg            frm2_rd_data_phase_1;// Indicate when second management read
                                       // data phase for frame 2.
   wire           man_rd_data_phase_0; // Indicate when first management read
                                       // data phase for either frame 1 or 2.
   wire           man_rd_data_phase_1; // Indicate when second management read
                                       // data phase for either frame 1 or 2.
   reg            man_rd_done;         // Set when management descriptors
                                       // have been sucessfully read.
   reg            frm_val_data_phase;  // Indicate when a data read data
                                       // phase for either frame 1 or 2.
   reg            man_wr_done;         // Set when management write descriptor
                                       // has been written back.

   //***************************************************************************
   // FIFO signals
   //***************************************************************************
   wire           w_flush_int;         // internal flush calculation
   reg            w_flush_del;         // delayed version of internal flush
                                       // used to edge detect flush
   wire           tx_no_crc;           // asserted if frame is to be
                                       // transmitted without CRC & PAD appended
   wire           dma_w_wr;            // Push dma_w_data into the FIFO.
   wire   [127:0] dma_w_data;          // Data word to be written into FIFO.
   wire           dma_w_eop;           // Indicates the final push in a packet.
   wire           dma_w_sop;           // Indicates the first push in a packet.
   wire     [3:0] dma_w_mod;           // Indicates the number of bytes that
                                       // are valid in dma_w_data, for the final
                                       // push in a packet (dma_w_eop set).
   wire           dma_w_err;           // Indicates an error with the current
                                       // packet.
   wire           dma_w_flush;         // Flushes FIFO and resets pointers
   wire           dma_w_flushing;      // FIFO is in the process of flushing.
   reg            dma_w_control;       // Packet control information.
   wire [(`edma_tx_fifo_cnt_width - 1):0]
                  dma_w_fifo_count;    // number of valid words in hclk domain
   wire           dma_w_overflow;      // overflow in write domain of FIFO.
   wire [(`edma_tx_fifo_cnt_width - 1):0]
                  tx_r_fifo_count;     // number of valid words in tx_clk
                                       // domain used to generate tx_r_data_rdy
   wire           tx_r_pkt_comp;       // at least one packet is in the fifo in
                                       // the tx_clk domain. Used to
                                       // generate tx_r_data_rdy
   wire           fifo_free_slots;     // set when there are free slots
                                       // available in the fifo.
   wire [`edma_tx_fifo_cnt_width+4:0]   //
                  burst_length;        // Programmed burst length expanded
   wire [`edma_tx_fifo_cnt_width-1:0]   //
                  max_burst_length;    // Maximum possible AHB burst to FIFO

   //***************************************************************************
   // synchronisation of status from gem_tx
   //***************************************************************************
   reg            dma_tx_status_tog;   // Signal to gem_tx that both writeback
                                       // and pclk status update have completed.

   //***************************************************************************
   // TX MAC end of frame detection
   //***************************************************************************
   reg            frm1_man_wr_req_hold;// Sampled & held tx_frame_end_pulse
                                       // when frame one is the eldest.
   reg            frm2_man_wr_req_hold;// Sampled & held tx_frame_end_pulse
                                       // when frame two is the eldest.
   wire           man_wr_required_frm1;// Perform writeback for frame 1. Delays
                                       // frm1_man_wr_req_hold until DMA done.
   wire           man_wr_required_frm2;// Perform writeback for frame 2. Delays
                                       // frm1_man_wr_req_hold until DMA done.

   //***************************************************************************
   // collision error handling
   //***************************************************************************
   reg            coll_occurred_del;   // Delayed version of coll_occurred_hclk
   reg            coll_occurred_hold;  // Hold a collision event until DMA done.
   wire           coll_occ_pos_edge;   // Leading edge of coll_occurred_hclk,
                                       // used to force a frame_restart_edge.
   wire           coll_occ_neg_edge;   // Trailing edge of coll_occurred_hclk,
                                       // used to start DMA again after restart.
   reg            frame_restart_edge;  // Force a restart once DMA complete.
   wire           tx_frm1_restart;     // frame_restart_edge for frame 1 eldest.
   wire           tx_frm2_restart;     // frame_restart_edge for frame 2 eldest.

   //***************************************************************************
   // Error conditions
   //***************************************************************************
   reg            tx_used_bit_read_0;  // descriptor read has used bit set
   wire           tx_used_bit_read;    // set on 2nd descriptor
   reg            tx_exh_start_hold;   // Hold tx_used_bit_read if SOP has not
                                       // yet been written into the FIFO.
   reg            tx_exh_mid_frm1_hold;// Hold tx_used_bit_read if SOP has been
                                       // written into the FIFO, and current is
                                       // frame one.
   reg            tx_exh_mid_frm2_hold;// Hold tx_used_bit_read if SOP has been
                                       // written into the FIFO, and current is
                                       // frame two.
   reg            hresp_notok_hold;    // hold the hresp error until the write
                                       // back occurs to update the status reg
   wire           tx_dma_bad_frame;    // Status update for a bad frame

   //***************************************************************************
   // Transmit DMA status update to pclk domain
   //***************************************************************************
   wire           update_status;       // updates the pclk syncs stable signal
                                       // when a writeback has completed or
                                       // zero_writeback_halt is active.
   reg            tx_dma_stable_tog;   // Toggles to indicate that updates to
                                       // the registers are stable to be passed
                                       // to the reg block
   reg            tx_dma_status_stable;// Signals that the update to the
                                       // registers block are on-going.
   reg            tx_dma_complete_ok;  // Frame completed successfully in DMA.
   reg            tx_dma_hresp_notok;  // DMA indicates HRESP not OK on frame.
   reg            tx_dma_buffers_ex;   // DMA indicates buffers were exhausted
                                       // before SOP for frame written to FIFO.
   reg            tx_dma_buff_ex_mid;  // DMA indicates buffers were exhausted
                                       // after SOP for frame written to FIFO.

   //***************************************************************************
   // Parameters
   //***************************************************************************

   // parameters for main state machine
   parameter
      TX_MAN_IDLE           = 3'b000, // idle state, reset and flush fifo
      TX_MAN_FRM1_RD        = 3'b001, // read descriptor for frame one
      TX_MAN_FRM1_BUFF_VLD  = 3'b010, // request data bursts for current frm 1
      TX_MAN_FRM1_WR        = 3'b011, // write back descriptor for frame one
      TX_MAN_FRM2_RD        = 3'b100, // read descriptor for frame two
      TX_MAN_FRM2_BUFF_VLD  = 3'b101, // request data bursts for current frm 2
      TX_MAN_FRM2_WR        = 3'b110; // write back descriptor for frame two

   // parameters for TX_GO state machine
   parameter
      TX_GO_IDLE            = 3'b000, // TX_GO DMA inactive (halted)
      TX_GO_ACTIVE          = 3'b001, // TX_GO DMA active
      TX_GO_HALT1           = 3'b010, // TX_GO 1 writeback then halt
      TX_GO_HALT2           = 3'b011, // TX_GO 2 writebacks then halt
      TX_GO_COL             = 3'b111; // TX_GO writeback then halt after coll



//******************************************************************************
// Main body of code
//******************************************************************************



//******************************************************************************
// TX DMA Flow State Machine
//******************************************************************************

   // edma_tx_state_nxt
   // Next state logic for TX DMA Flow State Machine. Used to sequence the
   // buffer management and data read activities.
   //---------------------------------------------------------------------------
   always@(enable_tx_hclk or tx_halt_dma or tx_halt_new_frames or
           tx_halt_all_reads or man_wr_done or dma_data_done or
           edma_tx_state or man_rd_done or coll_occurred_hclk or
           frame_1_older or frame_2_older or current_is_frm1 or
           current_is_frm2 or man_wr_required_frm1 or man_wr_required_frm2 or
           last_buffer_done or new_buffer_required or current_is_oldest)

      // Overiding conditions that return the state machine to idle.
      if(~enable_tx_hclk | tx_halt_dma)
       begin
         edma_tx_state_nxt = TX_MAN_IDLE;
       end

      else
       begin
         case (edma_tx_state)

            //------------------------------------------------------------------
            // TX_MAN_FRM1_RD
            // Request a management read for frame one to get buffer descriptor
            // information. This performed as 2 accesses to read both descriptor
            // words, with the final access signalled by man_rd_done.
            //------------------------------------------------------------------
            TX_MAN_FRM1_RD:
               begin
                  if(man_rd_done)
                     edma_tx_state_nxt = TX_MAN_FRM1_BUFF_VLD;
                  else
                     edma_tx_state_nxt = TX_MAN_FRM1_RD;
               end


            //------------------------------------------------------------------
            // TX_MAN_FRM1_BUFF_VLD
            // Request data for frame one if there is more to fetch from the
            // current buffer and there is space to write the data into the FIFO
            // and there has been no error conditions.
            // Data is always requested in bursts of max_burst_length.
            //------------------------------------------------------------------
            TX_MAN_FRM1_BUFF_VLD:
               begin
                  // If there is a collision, but frame 2 is the eldest,
                  // then go straight to TX_MAN_FRM2_BUFF_VLD state, as we
                  // will already have descriptor information saved for frame 2.
                  if (coll_occurred_hclk & dma_data_done & frame_2_older)
                     edma_tx_state_nxt = TX_MAN_FRM2_BUFF_VLD;

                  // Else if there is a collision, and frame 1 is the eldest,
                  // then stay where we are as we will already have descriptor
                  // information for saved frame 1.
                  else if (coll_occurred_hclk & dma_data_done & frame_1_older)
                     edma_tx_state_nxt = TX_MAN_FRM1_BUFF_VLD;

                  // Else if frame 1 is the eldest in the system and the MAC TX
                  // indicates that the frame being transmitted has ended,
                  // then we are required to do a descriptor writeback.
                  else if(man_wr_required_frm1)
                     edma_tx_state_nxt = TX_MAN_FRM1_WR;

                  // Else if frame 2 is the eldest in the system and the MAC TX
                  // indicates that the frame being transmitted has ended,
                  // then we are required to do a descriptor writeback.
                  else if(man_wr_required_frm2)
                     edma_tx_state_nxt = TX_MAN_FRM2_WR;

                  // Else if the current frame is frame one and the last buffer
                  // in the frame has been emptied, and frame 1 is only frame in
                  // the system, and we are not blocked by a halt condition,
                  // then move to frame 2 and get the descriptor information.
                  else if(last_buffer_done & current_is_frm1 &
                          current_is_oldest & ~tx_halt_new_frames)
                     edma_tx_state_nxt = TX_MAN_FRM2_RD;

                  // Else if the current buffer is full and it is not the last
                  // in the frame, get the descriptor information for the next
                  // buffer in the frame.
                  else if (new_buffer_required & ~tx_halt_all_reads)
                     edma_tx_state_nxt = TX_MAN_FRM1_RD;

                  // Else stay in same state
                  else
                     edma_tx_state_nxt = TX_MAN_FRM1_BUFF_VLD;
               end


            //------------------------------------------------------------------
            // TX_MAN_FRM1_WR
            // Performs a writeback for frame 1, which must therefore be the
            // eldest frame in the system. This is a single write to the
            // first descriptor in the frame is updated by setting the ownership
            // (or used) bit, and any status bits. The access is complete when
            // man_wr_done is signalled.
            //------------------------------------------------------------------
            TX_MAN_FRM1_WR:
               begin
                  // If writeback is complete and the current buffer being
                  // worked on is the last in the frame and is now complete,
                  // then there is either zero or one frame in the system.
                  // Since we have just finished frame one, it is safe to get
                  // a new frame one so move to TX_MAN_FRM1_RD.
                  if(man_wr_done & last_buffer_done & ~tx_halt_new_frames &
                     (current_is_frm2 | (current_is_frm1 & current_is_oldest)))
                     edma_tx_state_nxt = TX_MAN_FRM1_RD;

                  // Else if writeback is complete and the current buffer being
                  // worked on is in frame 2 and it is now complete,
                  // then we have to get a new buffer for frame two, so move
                  // to TX_MAN_FRM2_RD.
                  else if(man_wr_done & current_is_frm2 & new_buffer_required &
                          ~tx_halt_all_reads)
                     edma_tx_state_nxt = TX_MAN_FRM2_RD;

                  // Else if writeback is complete and the current buffer being
                  // worked on is in frame 2 and it is not yet complete,
                  // then return to TX_MAN_FRM2_BUFF_VLD.
                  else if(man_wr_done & current_is_frm2)
                     edma_tx_state_nxt = TX_MAN_FRM2_BUFF_VLD;

                  // Else stay in same state
                  else
                     edma_tx_state_nxt = TX_MAN_FRM1_WR;
               end


            //------------------------------------------------------------------
            // TX_MAN_FRM2_RD
            // Request a management read for frame two to get buffer descriptor
            // information. This performed as 2 accesses to read both descriptor
            // words, with the final access signalled by man_rd_done.
            //------------------------------------------------------------------
            TX_MAN_FRM2_RD:
               begin
                  if(man_rd_done)
                     edma_tx_state_nxt =TX_MAN_FRM2_BUFF_VLD;
                  else
                     edma_tx_state_nxt =TX_MAN_FRM2_RD;
               end


            //------------------------------------------------------------------
            // TX_MAN_FRM2_BUFF_VLD
            // Request data for frame two if there is more to fetch from the
            // current buffer and there is space to write the data into the FIFO
            // and there has been no error conditions.
            // Data is always requested in bursts of max_burst_length.
            //------------------------------------------------------------------
            TX_MAN_FRM2_BUFF_VLD:
               begin
                  // If there is a collision, but frame 1 is the eldest,
                  // then go straight to TX_MAN_FRM1_BUFF_VLD state, as we
                  // will already have descriptor information saved for frame 1.
                  if (coll_occurred_hclk & dma_data_done & frame_1_older)
                     edma_tx_state_nxt = TX_MAN_FRM1_BUFF_VLD;

                  // Else if there is a collision, and frame 2 is the eldest,
                  // then stay where we are as we will already have descriptor
                  // information for saved frame 2.
                  else if (coll_occurred_hclk & dma_data_done & frame_2_older)
                     edma_tx_state_nxt = TX_MAN_FRM2_BUFF_VLD;

                  // Else if frame 2 is the eldest in the system and the MAC TX
                  // indicates that the frame being transmitted has ended,
                  // then we are required to do a descriptor writeback.
                  else if(man_wr_required_frm2)
                     edma_tx_state_nxt = TX_MAN_FRM2_WR;

                  // Else if frame 1 is the eldest in the system and the MAC TX
                  // indicates that the frame being transmitted has ended,
                  // then we are required to do a descriptor writeback.
                  else if(man_wr_required_frm1)
                     edma_tx_state_nxt = TX_MAN_FRM1_WR;

                  // Else if the current frame is frame two and the last buffer
                  // in the frame has been emptied, and frame 2 is only frame in
                  // the system, and we are not blocked by a halt condition,
                  // then move to frame 1 and get the descriptor information.
                  else if(last_buffer_done & current_is_frm2 &
                          current_is_oldest & ~tx_halt_new_frames)
                     edma_tx_state_nxt = TX_MAN_FRM1_RD;

                  // Else if the current buffer is full and it is not the last
                  // in the frame, get the descriptor information for the next
                  // buffer in the frame.
                  else if (new_buffer_required & ~tx_halt_all_reads)
                     edma_tx_state_nxt = TX_MAN_FRM2_RD;

                  // Else stay in same state
                  else
                     edma_tx_state_nxt = TX_MAN_FRM2_BUFF_VLD;
               end


            //------------------------------------------------------------------
            // TX_MAN_FRM2_WR
            // Performs a writeback for frame 2, which must therefore be the
            // eldest frame in the system. This is a single write to the
            // first descriptor in the frame is updated by setting the ownership
            // (or used) bit, and any status bits. The access is complete when
            // man_wr_done is signalled.
            //------------------------------------------------------------------
            TX_MAN_FRM2_WR:
               begin
                  // If writeback is complete and the current buffer being
                  // worked on is the last in the frame and is now complete,
                  // then there is either zero or one frame in the system.
                  // Since we have just finished frame two, it is safe to get
                  // a new frame two so move to TX_MAN_FRM2_RD.
                  if(man_wr_done & last_buffer_done & ~tx_halt_new_frames &
                     (current_is_frm1 | (current_is_frm2 & current_is_oldest)))
                     edma_tx_state_nxt = TX_MAN_FRM2_RD;

                  // Else if writeback is complete and the current buffer being
                  // worked on is in frame 1 and it is now complete,
                  // then we have to get a new buffer for frame one, so move
                  // to TX_MAN_FRM1_RD.
                  else if(man_wr_done & current_is_frm1 & new_buffer_required &
                          ~tx_halt_all_reads)
                     edma_tx_state_nxt = TX_MAN_FRM1_RD;

                  // Else if writeback is complete and the current buffer being
                  // worked on is in frame 1 and it is not yet complete,
                  // then return to TX_MAN_FRM1_BUFF_VLD.
                  else if(man_wr_done & current_is_frm1)
                     edma_tx_state_nxt = TX_MAN_FRM1_BUFF_VLD;

                  // Else stay in same state
                  else
                     edma_tx_state_nxt = TX_MAN_FRM2_WR;
               end


            //------------------------------------------------------------------
            // TX_MAN_IDLE
            // Idle state, waiting for a new start pulse and the enabling of TX.
            // State machine returns to idle when tx is disabled or is halted.
            // These conditions are taken care in the above overiding IF
            // statement.
            //------------------------------------------------------------------
            default : //TX_MAN_IDLE:
               begin
                  edma_tx_state_nxt = TX_MAN_FRM1_RD;
               end
         endcase
       end


   // edma_tx_state
   // update current state variable with the next state.
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
          edma_tx_state <= TX_MAN_IDLE;
      else
          edma_tx_state <= edma_tx_state_nxt;


   //decoding of the current state
   //------------------------------------------------
   assign s_tx_frm1_rd      = edma_tx_state == TX_MAN_FRM1_RD;
   assign s_tx_frm1_buf_vld = edma_tx_state == TX_MAN_FRM1_BUFF_VLD;
   assign s_tx_frm1_wr      = edma_tx_state == TX_MAN_FRM1_WR;
   assign s_tx_frm2_rd      = edma_tx_state == TX_MAN_FRM2_RD;
   assign s_tx_frm2_buf_vld = edma_tx_state == TX_MAN_FRM2_BUFF_VLD;
   assign s_tx_frm2_wr      = edma_tx_state == TX_MAN_FRM2_WR;
   assign s_tx_idle         = ~s_tx_frm1_rd & ~s_tx_frm1_buf_vld &
                              ~s_tx_frm1_wr & ~s_tx_frm2_rd &
                              ~s_tx_frm2_buf_vld & ~s_tx_frm2_wr;

   //decoding of the next state
   //------------------------------------------------
   assign ns_tx_frm1_rd      = edma_tx_state_nxt == TX_MAN_FRM1_RD;
   assign ns_tx_frm1_buf_vld = edma_tx_state_nxt == TX_MAN_FRM1_BUFF_VLD;
   assign ns_tx_frm1_wr      = edma_tx_state_nxt == TX_MAN_FRM1_WR;
   assign ns_tx_frm2_rd      = edma_tx_state_nxt == TX_MAN_FRM2_RD;
   assign ns_tx_frm2_buf_vld = edma_tx_state_nxt == TX_MAN_FRM2_BUFF_VLD;
   assign ns_tx_frm2_wr      = edma_tx_state_nxt == TX_MAN_FRM2_WR;
   assign ns_tx_idle         = ~ns_tx_frm1_rd & ~ns_tx_frm1_buf_vld &
                               ~ns_tx_frm1_wr & ~ns_tx_frm2_rd &
                               ~ns_tx_frm2_buf_vld & ~ns_tx_frm2_wr;



//******************************************************************************
// state machine control
//******************************************************************************

   // frame_1_older
   // Indicates when frame one is the oldest frame in the system. By default
   // frame one is the eldest. Toggles state on a writeback and there is more
   // than one frame in the system.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         frame_1_older <= 1'b1;
      else if(s_tx_idle)
         frame_1_older <= 1'b1;
      else if(man_wr_done & ~current_is_oldest)
         frame_1_older <= ~frame_1_older;
      else
         frame_1_older <= frame_1_older;


   // frame_2_older
   // Indicates when frame two is the oldest frame in the system.
   //------------------------------------------------
   assign frame_2_older = ~frame_1_older;


   // current_is_frm1
   // Indicates when the buffers of frame one are currently being worked on.
   // Changes to appropraite state when entering a management read state
   // after just completing a frame.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         current_is_frm1 <= 1'b1;
      else if(s_tx_idle)
         current_is_frm1 <= 1'b1;
      else if(tx_frm1_restart)
         current_is_frm1 <= 1'b1;
      else if(tx_frm2_restart)
         current_is_frm1 <= 1'b0;
      else if(ns_tx_frm1_rd & last_buffer_done)
         current_is_frm1 <= 1'b1;
      else if(ns_tx_frm2_rd & last_buffer_done)
         current_is_frm1 <= 1'b0;
      else
         current_is_frm1 <= current_is_frm1;


   // current_is_frm2
   // Indicates when the buffers of frame two are currently being worked on.
   //------------------------------------------------
   assign current_is_frm2 = ~current_is_frm1;


   // current_is_oldest
   // Indicates when the current frame being worked on is the oldest
   // in the system.
   //------------------------------------------------
   assign current_is_oldest = (current_is_frm1 & frame_1_older) |
                              (current_is_frm2 & frame_2_older);



//******************************************************************************
// TX go and halt
//******************************************************************************

   // sop_written_to_fifo :
   // Tracks whether the next write to the FIFO will be the SOP write.
   // current_sop_written :
   // Indicates when the current frame being worked on has had it's
   // Start of Packet written into the FIFO.
   // Set on detection of dma_w_wr & dma_w_sop, reset on idle, restart or
   // when current frame has been handled by the DMA (i.e. last_buffer_done).
   // For frames contained in one word (SOP and EOP both set), this will
   // remain low.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            current_sop_written <= 1'b0;
            sop_written_to_fifo <= 1'b0;
         end

      // reset both when IDLE (next will be SOP)
      else if (s_tx_idle)
         begin
            current_sop_written <= 1'b0;
            sop_written_to_fifo <= 1'b0;
         end

      // reset both signals when restarting (next will be SOP)
      else if (tx_frm1_restart | tx_frm2_restart)
         begin
            current_sop_written <= 1'b0;
            sop_written_to_fifo <= 1'b0;
         end

      // If we are writing an EOP then next must be an SOP
      else if (dma_w_wr & dma_w_eop)
         begin
            current_sop_written <= 1'b0;
            sop_written_to_fifo <= 1'b0;
         end

      // If current frame has been completely handled then reset
      // current_sop_written. sop_written_to_fifo maintained as the
      // alignment buffer maybe waiting for free slots to do final eop
      // write.
      else if ((ns_tx_frm1_rd | ns_tx_frm2_rd) & last_buffer_done)
         begin
            current_sop_written <= 1'b0;
            sop_written_to_fifo <= sop_written_to_fifo;
         end

      // If SOP is written into FIFO then set both
      else if (dma_w_wr & dma_w_sop)
         begin
            current_sop_written <= 1'b1;
            sop_written_to_fifo <= 1'b1;
         end

      // Otherwise maintain value
      else
         begin
            current_sop_written <= current_sop_written;
            sop_written_to_fifo <= sop_written_to_fifo;
         end


   // zero_writeback_halt, one_writeback_halt & two_writeback_halt
   // Decide if any halt condition will require, zero, one or two writebacks.
   //------------------------------------------------
   always @(current_sop_written or current_is_oldest or
            tx_used_bit_read or tx_halt_hclk or hresp_notok_del or
            underflow_frame_hclk or zero_length_buffer or tx_eof or
            too_many_retry_hclk or late_coll_occ_hclk or dma_w_overflow)

      // If we are not currently dealing with the oldest frame, and
      // a halt condition is received after the current frame has had it's
      // SOP written to the FIFO, then we must wait for two frames to complete.
      if (~current_is_oldest &
             (tx_halt_hclk |
              (tx_used_bit_read & current_sop_written) |
              (hresp_notok_del & current_sop_written) |
              (zero_length_buffer & tx_eof & current_sop_written)))
         begin
            zero_writeback_halt = 1'b0;
            one_writeback_halt  = 1'b0;
            two_writeback_halt  = 1'b1;
         end

      // If we are not currently dealing with the oldest frame, and
      // a halt condition is received but the current frame has not had it's
      // SOP written to the FIFO, then we must wait for one frame to complete.
      // For underflow frames only expect a writeback for the older frame.
      else if (~current_is_oldest &
                  (underflow_frame_hclk |
                   too_many_retry_hclk |
                   late_coll_occ_hclk |
                   (tx_used_bit_read & ~current_sop_written) |
                   (hresp_notok_del & ~current_sop_written)))
         begin
            zero_writeback_halt = 1'b0;
            one_writeback_halt  = 1'b1;
            two_writeback_halt  = 1'b0;
         end

      // If we are currently dealing with the oldest frame, and
      // a halt condition is received and the current frame has had it's
      // SOP written to the FIFO, then we must wait for one frame to complete.
      else if (current_is_oldest &
                  (tx_halt_hclk |
                   (underflow_frame_hclk & current_sop_written) |
                   (too_many_retry_hclk & current_sop_written) |
                   (late_coll_occ_hclk & current_sop_written) |
                   (tx_used_bit_read & current_sop_written) |
                   (hresp_notok_del & current_sop_written) |
                   (zero_length_buffer & tx_eof & current_sop_written)))
         begin
            zero_writeback_halt = 1'b0;
            one_writeback_halt  = 1'b1;
            two_writeback_halt  = 1'b0;
         end

      // Else if there is any other halt condition must need to halt immediately
      else if (tx_used_bit_read | hresp_notok_del | underflow_frame_hclk |
               too_many_retry_hclk | late_coll_occ_hclk | dma_w_overflow)
         begin
            zero_writeback_halt = 1'b1;
            one_writeback_halt  = 1'b0;
            two_writeback_halt  = 1'b0;
         end

      // Otherwise do not halt
      else
         begin
            zero_writeback_halt = 1'b0;
            one_writeback_halt  = 1'b0;
            two_writeback_halt  = 1'b0;
         end


   // tx_go_state_nxt
   // Next state decoding of TX_GO state machine
   //------------------------------------------------
   always @(tx_go_state or tx_start_hclk_pulse or zero_writeback_halt or
            one_writeback_halt or two_writeback_halt or man_wr_done or
            tx_frm1_restart or tx_frm2_restart)
      case (tx_go_state)

         //------------------------------------------------------------------
         // TX_GO_ACTIVE
         // tx_go active state (normal operation once enabled)
         //------------------------------------------------------------------
         TX_GO_ACTIVE :
            begin
               // Event requires two writebacks before halting
               if (two_writeback_halt)
                  tx_go_state_nxt = TX_GO_HALT2;

               // Event requires one writeback before halting
               else if (one_writeback_halt)
                  tx_go_state_nxt = TX_GO_HALT1;

               // Event requires no writebacks before halting
               else if (zero_writeback_halt)
                  tx_go_state_nxt = TX_GO_IDLE;

               // otherwise stay in same state
               else
                  tx_go_state_nxt = tx_go_state;
            end

         //------------------------------------------------------------------
         // TX_GO_HALT1
         // halt tx_go after one writeback
         //------------------------------------------------------------------
         TX_GO_HALT1 :
            begin
               // on writeback complete go to idle state
               if (man_wr_done)
                  tx_go_state_nxt = TX_GO_IDLE;

               // If we get a collision and we are already waiting for
               // frames to complete before halting, we need to save this halt
               // condition but allow more buffer descriptor reads. Therefore
               // go to TX_GO_COL on a collision restart
               else if (tx_frm1_restart | tx_frm2_restart)
                  tx_go_state_nxt = TX_GO_COL;

               // otherwise stay in same state
               else
                  tx_go_state_nxt = tx_go_state;
            end

         //------------------------------------------------------------------
         // TX_GO_HALT2
         // halt tx_go after two writebacks
         //------------------------------------------------------------------
         TX_GO_HALT2 :
            begin
               // on writeback complete, go to TX_GO_HALT1 to wait
               // for another writeback
               if (man_wr_done)
                  tx_go_state_nxt = TX_GO_HALT1;

               // If we get a collision and we are already waiting for
               // frames to complete before halting, we need to save this halt
               // condition but allow more buffer descriptor reads. Therefore
               // go to TX_GO_COL on a collision restart
               else if (tx_frm1_restart | tx_frm2_restart)
                  tx_go_state_nxt = TX_GO_COL;

               // otherwise stay in same state
               else
                  tx_go_state_nxt = tx_go_state;
            end

         //------------------------------------------------------------------
         // TX_GO_COL
         // halt tx_go after one writebacks, when a collision has occurred
         //------------------------------------------------------------------
         TX_GO_COL :
            begin
               // on writeback complete, go to TX_GO_IDLE
               // Even though two frames may have been originally queued
               // (i.e. entered this state from TX_GO_HALT2), we have since
               // flushed, so only wait for a single writeback.
               if (man_wr_done)
                  tx_go_state_nxt = TX_GO_IDLE;

               // otherwise stay in same state
               else
                  tx_go_state_nxt = tx_go_state;
            end

         //------------------------------------------------------------------
         // TX_GO_IDLE
         // tx_go inactive (i.e. halted)
         //------------------------------------------------------------------
         default : //TX_GO_IDLE :
            begin
               // stay in idle if halting active
               if (zero_writeback_halt | one_writeback_halt |
                   two_writeback_halt)
                  tx_go_state_nxt = tx_go_state;

               // detect start and go to active state if no halting active.
               else if (tx_start_hclk_pulse)
                  tx_go_state_nxt = TX_GO_ACTIVE;

               // otherwise stay in same state
               else
                  tx_go_state_nxt = tx_go_state;
            end
      endcase


   // tx_go_state
   // Current state for TX_GO state machine
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         tx_go_state <= TX_GO_IDLE;
      else
         tx_go_state <= tx_go_state_nxt;


   // Assign TX_GO state machine decodes for ease of referencing
   //------------------------------------------------
   assign s_tx_go_active  = (tx_go_state == TX_GO_ACTIVE);
   assign s_tx_go_halt1   = (tx_go_state == TX_GO_HALT1);
   assign s_tx_go_halt2   = (tx_go_state == TX_GO_HALT2);
   assign s_tx_go_col     = (tx_go_state == TX_GO_COL);
   assign s_tx_go_idle    = ~s_tx_go_active & ~s_tx_go_halt1 &
                            ~s_tx_go_halt2 & ~s_tx_go_col;
   assign ns_tx_go_active = (tx_go_state_nxt == TX_GO_ACTIVE);
   assign ns_tx_go_halt1  = (tx_go_state_nxt == TX_GO_HALT1);
   assign ns_tx_go_halt2  = (tx_go_state_nxt == TX_GO_HALT2);
   assign ns_tx_go_col    = (tx_go_state_nxt == TX_GO_COL);
   assign ns_tx_go_idle   = ~ns_tx_go_active & ~ns_tx_go_halt1 &
                            ~ns_tx_go_halt2 & ~ns_tx_go_col;


   // tx_dma_go
   // Set to indicate that the TX DMA is active
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         tx_dma_go <= 1'b0;
      else if (ns_tx_go_idle | ~enable_tx_hclk)
         tx_dma_go <= 1'b0;
      else
         tx_dma_go <= 1'b1;


   // tx_halt_all_reads
   // The halt mechanism has been triggered so that we shouldn't do any more
   // buffer management or data reads.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         tx_halt_all_reads <= 1'b0;
      else if (tx_halt_dma)
         tx_halt_all_reads <= 1'b0;
      else if (ns_tx_go_col)
         tx_halt_all_reads <= 1'b0;
      else if (underflow_frame_hclk | too_many_retry_hclk |
               late_coll_occ_hclk | tx_used_bit_read |
               hresp_notok_del | dma_w_overflow |
               (zero_length_decode & tx_eof_0 & current_sop_written))
         tx_halt_all_reads <= 1'b1;
      else
         tx_halt_all_reads <= tx_halt_all_reads;


   // tx_halt_new_frames
   // The halt mechanism has been triggered, so prevent any new frames
   // from starting.
   //------------------------------------------------
   assign tx_halt_new_frames = ~ns_tx_go_active;


   // tx_halt_dma
   // Signal to halt main state machine at correct time
   //------------------------------------------------
   assign tx_halt_dma = ns_tx_go_idle;


   // force_fifo_eop_err
   // If we get an error halt condition and the SOP has already been written
   // into the fifo, then force an ERR/EOP into the FIFO to force
   // the TX to underrun.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         force_fifo_eop_err <= 1'b1;
      else if(current_sop_written & (tx_used_bit_read |
                                     hresp_notok_del |
                                     (zero_length_buffer & tx_eof)))
         force_fifo_eop_err <= 1'b1;
      else
         force_fifo_eop_err <= 1'b0;




//******************************************************************************
// Management read descriptor saving
//******************************************************************************

   // tx_first_buffer
   // Indicates when the next buffer descriptor read will be the
   // first in a frame.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         tx_first_buffer <= 1'b1;

      // set when main state machine returns to idle
      else if (s_tx_idle)
         tx_first_buffer <= 1'b1;

      // on a frame 1 restart use saved EOF to decide if next read will be the
      // first in the frame
      else if (tx_frm1_restart)
         tx_first_buffer <= tx_eof_save_frm1;

      // on a frame 2 restart use saved EOF to decide if next read will be the
      // first in the frame
      else if (tx_frm2_restart)
         tx_first_buffer <= tx_eof_save_frm2;

      // on a management read word 1 sample EOF bit. If set then next buffer
      // read after this one will be the first in the frame.
      else if (man_rd_data_phase_1)
         tx_first_buffer <= tx_eof_0;

      // else maintain value
      else
         tx_first_buffer <= tx_first_buffer;



   // save information on management read for frame 1
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            tx_wrap_save_frm1    <= 1'b0;
            tx_no_crc_save_frm1  <= 1'b0;
            tx_eof_save_frm1     <= 1'b0;
            tx_length_save_frm1  <= 14'h0000;
            tx_q_ptr_save_frm1   <= 30'd0;
            tx_dma_save_add_frm1 <= 32'd0;
         end

      // reset when state machine returns to idle
      else if (s_tx_idle)
         begin
            tx_wrap_save_frm1    <= 1'b0;
            tx_no_crc_save_frm1  <= 1'b0;
            tx_eof_save_frm1     <= 1'b0;
            tx_length_save_frm1  <= 14'h0000;
            tx_q_ptr_save_frm1   <= nxt_tx_q_ptr_cnt[31:2];
            tx_dma_save_add_frm1 <= 32'd0;
         end

      // save descriptor values for management read word 0 for frame 1
      else if (frm1_rd_data_phase_0 & tx_first_buffer)
         begin
            tx_wrap_save_frm1    <= man_rd_hrdata[30];
            tx_no_crc_save_frm1  <= man_rd_hrdata[16];
            tx_eof_save_frm1     <= man_rd_hrdata[15];
            tx_length_save_frm1  <= man_rd_hrdata[13:0];

            // word 0 saved versions stay the same
            tx_dma_save_add_frm1 <= tx_dma_save_add_frm1;
            tx_q_ptr_save_frm1   <= tx_q_ptr_save_frm1;
         end

      // save descriptor values for management read word 1 for frame 1
      else if (frm1_rd_data_phase_1 & tx_first_buffer)
         begin
            tx_dma_save_add_frm1 <= man_rd_hrdata[31:0];
            tx_q_ptr_save_frm1   <= nxt_tx_q_ptr_cnt[31:2];

            // word 0 saved versions stay the same
            tx_wrap_save_frm1    <= tx_wrap_save_frm1;
            tx_no_crc_save_frm1  <= tx_no_crc_save_frm1;
            tx_eof_save_frm1     <= tx_eof_save_frm1;
            tx_length_save_frm1  <= tx_length_save_frm1;
         end

      // Else maintain value
      else
         begin
            tx_dma_save_add_frm1 <= tx_dma_save_add_frm1;
            tx_wrap_save_frm1    <= tx_wrap_save_frm1;
            tx_no_crc_save_frm1  <= tx_no_crc_save_frm1;
            tx_eof_save_frm1     <= tx_eof_save_frm1;
            tx_length_save_frm1  <= tx_length_save_frm1;
            tx_q_ptr_save_frm1   <= tx_q_ptr_save_frm1;
         end


   // save information on management read for frame 2
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            tx_wrap_save_frm2    <= 1'b0;
            tx_no_crc_save_frm2  <= 1'b0;
            tx_eof_save_frm2     <= 1'b0;
            tx_length_save_frm2  <= 14'h0000;
            tx_q_ptr_save_frm2   <= 30'd0;
            tx_dma_save_add_frm2 <= 32'd0;
         end

      // reset when state machine returns to idle
      else if (s_tx_idle)
         begin
            tx_wrap_save_frm2    <= 1'b0;
            tx_no_crc_save_frm2  <= 1'b0;
            tx_eof_save_frm2     <= 1'b0;
            tx_length_save_frm2  <= 14'h0000;
            tx_q_ptr_save_frm2   <= nxt_tx_q_ptr_cnt[31:2];
            tx_dma_save_add_frm2 <= 32'd0;
         end

      // save descriptor values for management read word 0 for frame 2
      else if (tx_first_buffer & frm2_rd_data_phase_0)
         begin
            tx_wrap_save_frm2    <= man_rd_hrdata[30];
            tx_no_crc_save_frm2  <= man_rd_hrdata[16];
            tx_eof_save_frm2     <= man_rd_hrdata[15];
            tx_length_save_frm2  <= man_rd_hrdata[13:0];

            // word 0 saved versions stay the same
            tx_dma_save_add_frm2 <= tx_dma_save_add_frm2;
            tx_q_ptr_save_frm2   <= tx_q_ptr_save_frm2;
         end

      // save descriptor values for management read word 1 for frame 2
      else if (frm2_rd_data_phase_1 & tx_first_buffer)
         begin
            tx_dma_save_add_frm2 <= man_rd_hrdata[31:0];
            tx_q_ptr_save_frm2   <= nxt_tx_q_ptr_cnt[31:2];

            // word 0 saved versions stay the same
            tx_wrap_save_frm2    <= tx_wrap_save_frm2;
            tx_no_crc_save_frm2  <= tx_no_crc_save_frm2;
            tx_eof_save_frm2     <= tx_eof_save_frm2;
            tx_length_save_frm2  <= tx_length_save_frm2;
         end

      // Else maintain value
      else
         begin
            tx_dma_save_add_frm2 <= tx_dma_save_add_frm2;
            tx_wrap_save_frm2    <= tx_wrap_save_frm2;
            tx_no_crc_save_frm2  <= tx_no_crc_save_frm2;
            tx_eof_save_frm2     <= tx_eof_save_frm2;
            tx_length_save_frm2  <= tx_length_save_frm2;
            tx_q_ptr_save_frm2   <= tx_q_ptr_save_frm2;
         end



//******************************************************************************
// Buffer length monitoring & control
//******************************************************************************

   // decode how many bytes will be transfered on the selected data bus
   // width in a single access.
   //------------------------------------------------
   always @(dma_bus_width)
      case(dma_bus_width)
         2'b00   : tx_length_decrement =  5'b00100;  // 32 bit
         2'b01   : tx_length_decrement =  5'b01000;  // 64 bit
         default : tx_length_decrement =  5'b10000;  // 128 bit
      endcase


   // tx_length_save, tx_buffer_offset & tx_eof
   // Save length and offset provided by descriptors, and use to work
   // out number of accesses required to read complete buffer.
   // Also detect when this buffer is the last in a frame (tx_eof).
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            tx_buffer_offset <= 2'b00;
            tx_length_save   <= 14'h0000;
            tx_eof           <= 1'b0;
         end

      // reset when main state machine returns to idle
      else if (s_tx_idle)
         begin
            tx_buffer_offset <= 2'b00;
            tx_length_save   <= 14'h0000;
            tx_eof           <= 1'b0;
         end

      // on a frame 1 restart restore saved versions
      else if (tx_frm1_restart)
         begin
            tx_buffer_offset <= tx_dma_save_add_frm1[1:0];
            tx_length_save   <= tx_length_save_frm1;
            tx_eof           <= tx_eof_save_frm1;
         end

      // on a frame 2 restart restore saved versions
      else if (tx_frm2_restart)
         begin
            tx_buffer_offset <= tx_dma_save_add_frm2[1:0];
            tx_length_save   <= tx_length_save_frm2;
            tx_eof           <= tx_eof_save_frm2;
         end

      // on a management read of word 1 hold new value of offset
      else if (man_rd_data_phase_1)
         begin
            tx_buffer_offset <= man_rd_hrdata[1:0];
            tx_length_save   <= tx_length_save;
            tx_eof           <= tx_eof;
         end

      // on a management read of word 0 hold new value of length and EOF
      else if (man_rd_data_phase_0 & ~man_rd_hrdata[31])
         begin
            tx_buffer_offset <= tx_buffer_offset;
            tx_length_save   <= man_rd_hrdata[13:0];
            tx_eof           <= man_rd_hrdata[15];
         end

      // else maintain value
      else
         begin
            tx_buffer_offset <= tx_buffer_offset;
            tx_length_save   <= tx_length_save;
            tx_eof           <= tx_eof;
         end


   // Value to be loaded into buf_access_cnt when buf_access_cnt_load
   // is active. Bits[13:2] will be selected to be loaded based on bus width.
   //------------------------------------------------
   assign buf_access_cnt_start_pad = tx_length_save[13:0] + {12'h000, tx_buffer_offset[1:0]};
   assign buf_access_cnt_start     = buf_access_cnt_start_pad[13:0];


   // last_access_full
   // Detect when the final access will have a complete set of bytes.
   //------------------------------------------------
   always @(dma_bus_width or buf_access_cnt_start)
      case(dma_bus_width)
         2'b00  : last_access_full = (buf_access_cnt_start[1:0] == 2'b00);
         2'b01  : last_access_full = (buf_access_cnt_start[2:0] == 3'b000);
         default: last_access_full = (buf_access_cnt_start[3:0] == 4'b0000);
      endcase


   // last_access_bytes[4:0]
   // Indicates the number of bytes that will be present in the final DMA
   // access of the buffer.
   //------------------------------------------------
   always @(tx_length_save or buf_access_cnt_start or dma_bus_width or
            tx_length_decrement or last_access_full)

      // if number of accesses will be only one then all bytes are
      // transfered in the one and only access.
      if (buf_access_cnt_start <= {9'h000,tx_length_decrement[4:0]})
         last_access_bytes[4:0] = tx_length_save[4:0];

      // if the final access is to have a complete set of bytes
      // then assign last_access_bytes to be the full decrement
      else if (last_access_full)
         last_access_bytes[4:0] = tx_length_decrement[4:0];

      // otherwise the number of bytes in the last access will depend on
      // the offset, the length of the buffer, and the width of the bus
      else
         case(dma_bus_width)
            2'b00   : last_access_bytes = {3'b000,buf_access_cnt_start[1:0]};
            2'b01   : last_access_bytes = {2'b00,buf_access_cnt_start[2:0]};
            default : last_access_bytes = {1'b0,buf_access_cnt_start[3:0]};
         endcase


   // buf_access_cnt_load
   // indicate when to load buf_access_cnt with new descriptor value.
   // always loaded after successful completion of management read word 1,
   // or when restarting after a collision.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         buf_access_cnt_load <= 1'b0;
      else
         buf_access_cnt_load <= (man_rd_data_phase_1 & ~tx_used_bit_read) |
                                coll_occ_neg_edge;


   // Next value of buf_access_cnt.
   //------------------------------------------------

   // This is done for LINT purposes
   wire [12:0] buf_access_cnt_next_1;
   assign      buf_access_cnt_next_1 = buf_access_cnt_start[13:2] + {11'h000, ~last_access_full};

   always @ *

      // zero if main state machine in idle
      if (s_tx_idle)
         buf_access_cnt_next = 12'h000;

      // load counter form start value after management read or restart.
      // If final access is not complete then add one to the intitial value
      else if (buf_access_cnt_load)
         case (dma_bus_width[1:0])

            2'b00   : buf_access_cnt_next = buf_access_cnt_next_1[11:0];
            2'b01   : buf_access_cnt_next = {1'b0, buf_access_cnt_start[13:3]}
                                          + {11'h000, ~last_access_full};

            default : buf_access_cnt_next = {2'b00, buf_access_cnt_start[13:4]}
                                          + {11'h000, ~last_access_full};
         endcase

      // at every valid data state address strobe decrement the counter
      else if (tx_addr_strobe & tx_dma_state_data & (buf_access_cnt != 12'h000))
         buf_access_cnt_next = buf_access_cnt[11:0] - 12'h001;

      // Else maintain value of counter
      else
         buf_access_cnt_next = buf_access_cnt;


   // Counter to keep track of the number of DMA accesses still required
   // to complete buffer data reads.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         buf_access_cnt <= 12'h000;
      else
         buf_access_cnt <= buf_access_cnt_next;


   // next_buffer_done
   // detect when a buffer is about to be finished.
   //------------------------------------------------
   assign next_buffer_done = (buf_access_cnt_next == 12'h001);


   // buffer_done_decode
   // Register to hold when a buffer has been completed
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         buffer_done_decode <= 1'b1;

      // set when in idle, to indicate a new buffer is required
      else if (s_tx_idle)
         buffer_done_decode <= 1'b1;

      // set when buf_access_cnt is about to go to zero
      else if ((buf_access_cnt <= 12'h001) &
               tx_addr_strobe & tx_dma_state_data)
         buffer_done_decode <= 1'b1;

      // reset on successful completion of manangement read, with valid length
      // or when a restart occurs
      else if (tx_frm1_restart | tx_frm2_restart |
               (man_rd_data_phase_1 & ~tx_used_bit_read & ~zero_length_decode))

         buffer_done_decode <= 1'b0;

      // Else maintain value
      else
         buffer_done_decode <= buffer_done_decode;


   // buffer_done
   // Allow buffer_done_decode to be passed onto state machine once DMA
   // bursts have completed
   //------------------------------------------------
   assign buffer_done = buffer_done_decode & dma_data_done;


   // last_buf_done_decode
   // Detect when the buffer just done is the last in a frame
   //------------------------------------------------
   assign last_buf_done_decode = buffer_done_decode & tx_eof;


   // last_buffer_done
   // Allow last_buf_done_decode to be passed onto state machine once DMA
   // bursts have completed. This is blocked if the last buffer in a frame
   // is a zero length buffer.
   //------------------------------------------------
   assign last_buffer_done = last_buf_done_decode & dma_data_done &
                             ~zero_length_buffer;



   // zero_length_buffer
   // detect a zero length buffer and use to signal new buffer required.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         zero_length_buffer <= 1'b1;
      else
         zero_length_buffer <= zero_length_decode;


   // new buffer required
   // signals the state machine to start a management read request to get
   // a new buffer. This is when a buffer has just been completed and
   // it is not the last buffer in a frame, or when a zero length buffer
   // has been read (regardless of whether it's the last or not).
   //------------------------------------------------
   assign new_buffer_required = (buffer_done & ~last_buffer_done) |
                                zero_length_decode;



//******************************************************************************
// TX DMA address generation
//******************************************************************************

   // Next value of tx_dma_add[31:2]
   //------------------------------------------------

   // This is added for LINT purposes
   wire [30:0] nxt_tx_dma_add_31_2_p_2;
   wire [30:0] nxt_tx_dma_add_31_2_p_4;
   assign      nxt_tx_dma_add_31_2_p_2 = tx_dma_add[31:2] + 30'h00000002;
   assign      nxt_tx_dma_add_31_2_p_4 = tx_dma_add[31:2] + 30'h00000004;

   always@ *

      // on a collision restore saved address for first buffer in frame
      if (tx_frm1_restart)
         nxt_tx_dma_add[31:2] = tx_dma_save_add_frm1[31:2];

      // on a collision restore saved address for first buffer in frame
      else if (tx_frm2_restart)
         nxt_tx_dma_add[31:2] = tx_dma_save_add_frm2[31:2];

      // load counter with address from word 1 of descriptor read.
      else if (man_rd_data_phase_1)
         nxt_tx_dma_add[31:2] = man_rd_hrdata[31:2];

      // increment address on each address strobe using next count
      else if (tx_dma_state_data & tx_addr_inc_strobe)
         case(dma_bus_width)
            2'b00   : nxt_tx_dma_add[31:2] = tx_dma_add[31:2] + 30'h00000001;
            2'b01   : nxt_tx_dma_add[31:2] = nxt_tx_dma_add_31_2_p_2[29:0];
            default : nxt_tx_dma_add[31:2] = nxt_tx_dma_add_31_2_p_4[29:0];
         endcase

      // Else maintain value
      else
         nxt_tx_dma_add[31:2] = tx_dma_add[31:2];


   // tx_dma_add
   // tx_dma_add is the address of the data word being read from the current
   // transmit buffer.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         tx_dma_add[31:2] <= 30'd0;
      else
         tx_dma_add[31:2] <= nxt_tx_dma_add[31:2];



//******************************************************************************
// TX management address generation
//******************************************************************************

   // nxt_tx_q_ptr_cnt
   // Keep track of the queue pointer for descriptor reads and writes.
   // Queue can wrap at any point. Currently implemented such that there
   // is no upper limit on the number of descriptor pairs, other than the
   // 32-bit address space.
   // If a frame is errored and causes a halt, the pointer always returns to
   // pointing towards the next buffer descriptor, after the last successfully
   // transmitted frame.
   //------------------------------------------------

   // This is added for LINT purposes
   wire [30:0] tx_q_ptr_save_frm1_31_2_p2;
   wire [30:0] tx_q_ptr_save_frm2_31_2_p2;
   wire [30:0] nxt_tx_q_ptr_cnt_p2;
   assign      tx_q_ptr_save_frm1_31_2_p2 = tx_q_ptr_save_frm1[31:2] + 30'h00000002;
   assign      tx_q_ptr_save_frm2_31_2_p2 = tx_q_ptr_save_frm2[31:2] + 30'h00000002;
   assign      nxt_tx_q_ptr_cnt_p2        = nxt_tx_q_ptr_cnt[31:2]   + 30'h00000002;

   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            nxt_tx_q_ptr_cnt <= 30'd0;
            tx_dma_ptr_up_tog <= 1'b0;
         end

      // Queue pointer will use base address when tx is disabled, or a
      // new queue pointer is written and we are halted.
      else if (~enable_tx_hclk | (new_tx_q_ptr_pulse & s_tx_idle))
         begin
            nxt_tx_q_ptr_cnt <= tx_buff_q_base_addr[31:2];
            tx_dma_ptr_up_tog <= tx_dma_ptr_up_tog;
         end

      // If halting and frame has been errored then point to saved version
      // of the errored frame
      else if (tx_halt_dma & ~s_tx_go_idle & tx_dma_bad_frame & frame_1_older)
         begin
            nxt_tx_q_ptr_cnt <= tx_q_ptr_save_frm1[31:2];
            tx_dma_ptr_up_tog <= ~tx_dma_ptr_up_tog;
         end

      // If halting and frame has been errored then point to saved version
      // of the errored frame
      else if (tx_halt_dma & ~s_tx_go_idle & tx_dma_bad_frame & frame_2_older)
         begin
            nxt_tx_q_ptr_cnt <= tx_q_ptr_save_frm2[31:2];
            tx_dma_ptr_up_tog <= ~tx_dma_ptr_up_tog;
         end

      // on a frame 1 restart restore saved version. Queue pointer will
      // use the save version plus two, since we already have stored the
      // descriptor information for the first buffer in a frame.
      else if (tx_frm1_restart)
         begin
            tx_dma_ptr_up_tog <= ~tx_dma_ptr_up_tog;
            // if this buffer indicates a wrap (tx_wrap_save_frm1 set), then
            // setup the next queue pointer from the base address. Else if
            // not wrapping then add two to the current value to get the next.
            if (tx_wrap_save_frm1)
               nxt_tx_q_ptr_cnt <= tx_buff_q_base_addr[31:2];
            else
               nxt_tx_q_ptr_cnt <= tx_q_ptr_save_frm1_31_2_p2[29:0];
         end

      // on a frame 2 restart restore saved version. Queue pointer will
      // use the save version plus two, since we already have stored the
      // descriptor information for the first buffer in a frame.
      else if (tx_frm2_restart)
         begin
            tx_dma_ptr_up_tog <= ~tx_dma_ptr_up_tog;
            // if this buffer indicates a wrap (tx_wrap_save_frm1 set), then
            // setup the next queue pointer from the base address. Else if
            // not wrapping then add two to the current value to get the next.
            if (tx_wrap_save_frm2)
               nxt_tx_q_ptr_cnt <= tx_buff_q_base_addr[31:2];
            else
               nxt_tx_q_ptr_cnt <= tx_q_ptr_save_frm2_31_2_p2[29:0];
         end

      // on a management read of word 1, get new values.
      else if (man_rd_data_phase_1 & ~tx_used_bit_read)
         begin
            tx_dma_ptr_up_tog <= ~tx_dma_ptr_up_tog;
            // if this buffer indicates a wrap (man_rd_hrdata[30] set), then
            // setup the next queue pointer from the base address. Else if
            // not wrapping then add two to the current value to get the next.
            if (tx_wrap_0)
               nxt_tx_q_ptr_cnt <= tx_buff_q_base_addr[31:2];
            else
               nxt_tx_q_ptr_cnt <= nxt_tx_q_ptr_cnt_p2[29:0];
         end

      // else maintain value
      else
         begin
            nxt_tx_q_ptr_cnt <= nxt_tx_q_ptr_cnt;
            tx_dma_ptr_up_tog <= tx_dma_ptr_up_tog;
         end



   // assign value to be passed back into registers for reading during debug
   assign tx_dma_descr_ptr = nxt_tx_q_ptr_cnt;



//******************************************************************************
// AHB interface
//******************************************************************************

   // assignments for ahb interface inputs.
   //------------------------------------------------

   // AHB read data 32-bits for management reads
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         man_rd_hrdata <= 32'd0;
      else
         man_rd_hrdata <= tx_dma_data_in[31:0];

   // AHB hresp not OK indication.
   assign hresp_notok = tx_burst_error;

   // delayed version used to reduce loading on hready & hrdata
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         hresp_notok_del <= 1'b0;
      else
         hresp_notok_del <= hresp_notok;


   // assignments for ahb interface outputs.
   //------------------------------------------------

   // write data to AHB
   assign tx_dma_data_out = hwdata;

   // Address to AHB
   assign tx_dma_burst_addr = haddr[31:2];

   // advanced warning that the next state will be a data phase, and to
   // expect to burst a max_burst_length amount upon tx_dma_bus_req
   assign tx_dma_next_data = ns_tx_frm1_buf_vld | ns_tx_frm2_buf_vld;

   // set when in the data read from ahb bus in states s_tx_frm1/2_buf_vld
   // inherantly indicates the number of burst required dependant on the state
   assign tx_dma_state_data = s_tx_frm1_buf_vld | s_tx_frm2_buf_vld;

   // advanced warning to the ahb that the next state will involve a management
   // read access
   assign tx_dma_next_man_rd  = ns_tx_frm1_rd | ns_tx_frm2_rd;

   // signal used for the ahb block to indicate the state is dma read
   // inherantly indicates the number of burst required dependant on the state
   assign tx_dma_state_man_rd = s_tx_frm1_rd | s_tx_frm2_rd;

   // advanced warning to the ahb that the next state will involve a management
   // write access
   assign tx_dma_next_man_wr  = ns_tx_frm1_wr | ns_tx_frm2_wr;

   // signal used for the ahb block to indicate the state is dma write
   // inherantly indicates the number of burst required dependant on the state
   assign tx_dma_state_man_wr = s_tx_frm1_wr | s_tx_frm2_wr;

   // advanced warning to edma_ahb that an idle state will be entered on the
   // next clock
   assign tx_dma_flow_error = s_tx_idle;

   // detect when to break a burst at the end of a data buffer
   assign tx_data_burst_break = next_buffer_done & tx_addr_inc_strobe &
                                tx_dma_state_data;

   // Detect when final burst in buffer will be less than a full burst
   assign tx_dma_eop_burst = tx_dma_state_data &
             (buf_access_cnt <= {{12-`edma_tx_fifo_cnt_width{1'b0}}, max_burst_length});




   // block_data_bus_req
   // Used to block requests for data reads, if an event occurred that
   // requires a change in the main SM state.
   //------------------------------------------------
   always@(frm1_man_wr_req_hold or frm2_man_wr_req_hold or
           coll_occurred_hclk or hresp_notok_del or hresp_notok_hold or
           zero_length_decode or tx_used_bit_read)

      // if a writeback is required then block any further bus requests
      if (frm1_man_wr_req_hold | frm2_man_wr_req_hold)
         block_data_bus_req = 1'b1;

      // if a collision has occurred then block any further bus requests
      else if (coll_occurred_hclk)
         block_data_bus_req = 1'b1;

      // if an hresp error has occurred then block any further bus requests
      else if (hresp_notok_del | hresp_notok_hold)
         block_data_bus_req = 1'b1;

      // if a zero length buffer was read then block any further bus requests
      else if (zero_length_decode)
         block_data_bus_req = 1'b1;

      // if a used buffer was read then block any further bus requests
      else if (tx_used_bit_read)
         block_data_bus_req = 1'b1;

      // Else keep block signal low
      else
         block_data_bus_req = 1'b0;


   // data_bus_req
   // Request for a data read from the AHB.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         data_bus_req <= 1'b0;

      // reset when state machine is in idle or flushing
      else if (s_tx_idle | dma_w_flush)
         data_bus_req <= 1'b0;

      // If the block is active and we have not yet sent request to AHB, then
      // reset data request
      else if (block_data_bus_req & ~tx_dma_bus_req)
         data_bus_req <= 1'b0;

      // If restarting after a collision then request the bus
      else if (coll_occ_neg_edge)
         data_bus_req <= ~block_data_bus_req;

      // If entering the data state by a management read, we can assume that
      // the buffer will not be done, as long as block_data_bus_req is not high.
      else if (tx_dma_next_data & tx_dma_state_man_rd)
         data_bus_req <= ~block_data_bus_req;

      // If entering the data state from another state (i.e. a writeback of
      // an older frame or a restart), then we need to do an initial
      // request if we are not being blocked. This time need to check that
      // there is more data in the buffer.
      else if (tx_dma_next_data & ~tx_dma_state_data)
         data_bus_req <= ~block_data_bus_req & ~buffer_done_decode;

      // This next statement will maintain the data requests once started as
      // long as we stay in the data state. It will continue until the whole
      // buffer is exhausted, or we move out of the data state.
      // Reassess request on every tx_addr_inc_strobe while in the data state.
      // If the buffer is about to be emptied or if the block is active
      // then do not do any further bus requests.
      else if (tx_dma_state_data & tx_addr_inc_strobe)
         data_bus_req <= ~block_data_bus_req & ~next_buffer_done;

      // else maintain value
      else
         data_bus_req <= data_bus_req;


   // tx_bus_required
   // Request AHB, when either a management writeback is required, a
   // management read is required or a data read is required. Management
   // requests are just a single pulse that will be held by tx_bus_required_hold
   // but data requests remain as long as there is enough free slots in
   // the FIFO.
   //------------------------------------------------
   always@(ns_tx_idle or tx_dma_next_man_wr or
           man_wr_required_frm1 or man_wr_required_frm2 or
           tx_dma_state_man_rd or tx_dma_next_man_rd or data_bus_req or
           fifo_free_slots)
      if (ns_tx_idle)
         tx_bus_required = 1'b0;

      // management write request
      else if (tx_dma_next_man_wr & (man_wr_required_frm1 |
                                     man_wr_required_frm2))
         tx_bus_required = 1'b1;

      // management read request
      else if (tx_dma_next_man_rd & ~tx_dma_state_man_rd)
         tx_bus_required = 1'b1;

      // data read request. if there is not enough space in the fifo
      // for another DMA burst, then block any further bus requests.
      // also block during buffer manager activity
      else if (data_bus_req & fifo_free_slots & ~tx_dma_next_man_wr &
               ~tx_dma_next_man_rd)
         tx_bus_required = 1'b1;
      else
         tx_bus_required = 1'b0;


   // tx_bus_required_hold
   // hold tx_dma_bus_req until tx_addr_bus_owned is indicated.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         tx_bus_required_hold <= 1'b0;

      // set when tx_bus_required is active
      else if (tx_bus_required)
         tx_bus_required_hold <= 1'b1;

      // reset when address bus is owned.
      else if(tx_addr_bus_owned)
         tx_bus_required_hold <= 1'b0;

      // Else maintain value.
      else
         tx_bus_required_hold <= tx_bus_required_hold;


   // tx_dma_bus_req to AHB state machine
   // Set and held on tx_bus_required, until the bus is acquired.
   // Blocked whilst the FIFO is still flushing.
   //------------------------------------------------
   assign tx_dma_bus_req = ~dma_w_flushing &
                           (tx_bus_required | (tx_bus_required_hold
                                               & ~tx_addr_bus_owned));



   // dma_data_done
   // Indicates when a data read burst is inactive on the AHB.
   // Reset (active) when the bus is required in the data state, set (inactive)
   // on the last data phase of the burst.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         dma_data_done <= 1'b1;
      else if(ns_tx_idle)
         dma_data_done <= 1'b1;

      // if the AHB is required during a data state then reset
      // dma_data_done to indicate a request/data phase is active
      else if (tx_bus_required & tx_dma_next_data)
         dma_data_done <= 1'b0;

      // If an on-going data request has reached the end and
      // there are no more data requests then indicate done
      else if (tx_last_data_ph & tx_dma_state_data & ~tx_bus_required_hold)
         dma_data_done <= 1'b1;

      else
         dma_data_done <= dma_data_done;


   // Detect first descriptor read (data phase)
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         first_descr_d_en <= 1'b0;
      else if ((ns_tx_frm1_rd & ~s_tx_frm1_rd) |
               (ns_tx_frm2_rd & ~s_tx_frm2_rd))
         first_descr_d_en <= 1'b1;
      else if (tx_data_strobe)
         first_descr_d_en <= 1'b0;

   // Detect first descriptor read (add phase)
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         first_descr_a_en <= 1'b1;
      else if (tx_last_data_ph | hresp_notok)
         first_descr_a_en <= 1'b1;
      else if (tx_addr_inc_strobe & tx_dma_state_man_rd)
         first_descr_a_en <= 1'b0;


   // frm1_rd_data_phase_0, frm1_rd_data_phase_1
   // indicate when a management read data phase on the AHB and in frame 1.
   // Indicate the two phases separately.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            frm1_rd_data_phase_0 <= 1'b0;
            frm1_rd_data_phase_1 <= 1'b0;
         end
      else
         begin
            frm1_rd_data_phase_0 <= (s_tx_frm1_rd & tx_data_strobe &
                                     first_descr_d_en);
            frm1_rd_data_phase_1 <= (s_tx_frm1_rd & tx_data_strobe &
                                     ~first_descr_d_en);
         end


   // frm2_rd_data_phase_0, frm2_rd_data_phase_1
   // indicate when a management read data phase on the AHB and in frame 2.
   // Indicate the two phases separately.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            frm2_rd_data_phase_0 <= 1'b0;
            frm2_rd_data_phase_1 <= 1'b0;
         end
      else
         begin
            frm2_rd_data_phase_0 <= (s_tx_frm2_rd & tx_data_strobe &
                                     first_descr_d_en);
            frm2_rd_data_phase_1 <= (s_tx_frm2_rd & tx_data_strobe &
                                     ~first_descr_d_en);
         end


   // man_rd_data_phase_0, man_rd_data_phase_1
   // Combine frame 1 & 2 data phases for easy referencing
   //------------------------------------------------
   assign man_rd_data_phase_0 = frm1_rd_data_phase_0 | frm2_rd_data_phase_0;
   assign man_rd_data_phase_1 = frm1_rd_data_phase_1 | frm2_rd_data_phase_1;


   // man_rd_done
   // set high when the current read management cycle is complete and the
   // two descriptor words have been read in
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         man_rd_done <= 1'b0;
      else
         man_rd_done <= tx_dma_state_man_rd &
                        (~first_descr_d_en | hresp_notok)& tx_data_strobe;


   // frm_val_data_phase
   // indicate when in a data phase on the AHB and in frm2
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         frm_val_data_phase <= 1'b0;
      else if (tx_dma_state_data & tx_addr_strobe)
         frm_val_data_phase <= 1'b1;
      else if (tx_last_data_ph)
         frm_val_data_phase <= 1'b0;
      else
         frm_val_data_phase <= frm_val_data_phase;


   // man_wr_done
   // set high when the current write management cycle is complete
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         man_wr_done <= 1'b0;
      else
         man_wr_done <= (tx_dma_state_man_wr & tx_last_data_ph);


//******************************************************************************
// AHB haddr control
//******************************************************************************

   // haddr[31:2]
   // This is the address sent to the AHB module. It is either the address
   // of the descriptor to be read, the address of the descriptor to be
   // written to, or the address of the next data read from within the
   // current buffer. Always 32-bit word aligned so haddr[1:0] not required.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         haddr <= 30'h00000000;

      // Descriptor read (for 2nd word).
      else if (tx_dma_next_man_rd & (tx_addr_inc_strobe | ~first_descr_a_en))
         haddr <= (nxt_tx_q_ptr_cnt[31:2]);

      // Descriptor read (1st word).
      else if (tx_dma_next_man_rd)
         haddr <= nxt_tx_q_ptr_cnt[31:2] + 30'h00000001;

      // descriptor write frame 1 (add four to saved value to write to word 1).
      else if (ns_tx_frm1_wr)
         haddr <= (tx_q_ptr_save_frm1[31:2] + 30'h00000001);

      // descriptor write frame 2 (add four to saved value to write to word 1).
      else if (ns_tx_frm2_wr)
         haddr <= (tx_q_ptr_save_frm2[31:2] + 30'h00000001);

      // data read (use next address version)
      else if (tx_dma_next_data)
         haddr <= nxt_tx_dma_add[31:2];

      else
         haddr <= haddr;



//******************************************************************************
// AHB hwdata control
//******************************************************************************

   // hwdata[31:0]
   // Write data to the AHB module. Only the lowest 32 bits will be used
   // since the only write to the AHB we do is a descriptor writeback.
   // The oldest frame in the system is always written back first.
   //------------------------------------------------
   always@ (too_many_retry_hclk or tx_wrap_save_frm1 or
           tx_exh_mid_frm1_hold or late_coll_occ_hclk or tx_no_crc_save_frm1 or
           tx_eof_save_frm1 or tx_length_save_frm1 or tx_wrap_save_frm2 or
           tx_exh_mid_frm2_hold or tx_no_crc_save_frm2 or frame_1_older or
           tx_eof_save_frm2 or tx_length_save_frm2 or underflow_frame_hclk)

      if (frame_1_older)
         hwdata = {1'b1,
                   tx_wrap_save_frm1,
                   too_many_retry_hclk,
                   underflow_frame_hclk,
                   tx_exh_mid_frm1_hold,
                   late_coll_occ_hclk,
                   9'h000,
                   tx_no_crc_save_frm1,
                   tx_eof_save_frm1,
                   1'b0,
                   tx_length_save_frm1[13:0]};
      else
         hwdata = {1'b1,
                   tx_wrap_save_frm2,
                   too_many_retry_hclk,
                   underflow_frame_hclk,
                   tx_exh_mid_frm2_hold,
                   late_coll_occ_hclk,
                   9'h000,
                   tx_no_crc_save_frm2,
                   tx_eof_save_frm2,
                   1'b0,
                   tx_length_save_frm2[13:0]};



//******************************************************************************
// data offset alignment buffer
//******************************************************************************
// This module buffers the incoming data and realigns it to a 32/64/128-bit
// boundary if an offset is being used on the current buffer.

edma_tx_align i_edma_tx_align (

   // system signals
   .hclk                 (hclk),
   .n_hreset             (n_hreset),

   // signals coming from gem_registers
   .dma_bus_width        (dma_bus_width),
   .max_burst_length     (max_burst_length),

   // inputs from edma_tx
   .tx_dma_state_data    (tx_dma_state_data),
   .tx_data_strobe       (tx_data_strobe),
   .frm_val_data_phase   (frm_val_data_phase),
   .hrdata               (tx_dma_data_in),
   .buffer_done_decode   (buffer_done_decode),
   .last_buf_done_decode (last_buf_done_decode),
   .last_access_bytes    (last_access_bytes),
   .tx_length_decrement  (tx_length_decrement),
   .tx_buffer_offset     (tx_buffer_offset),
   .sop_written_to_fifo  (sop_written_to_fifo),
   .dma_w_fifo_count     (dma_w_fifo_count),
   .dma_w_flush          (dma_w_flush),
   .force_fifo_eop_err   (force_fifo_eop_err),

   // outputs to edma_tx
   .fifo_free_slots      (fifo_free_slots),
   .dma_w_data           (dma_w_data),
   .dma_w_wr             (dma_w_wr),
   .dma_w_sop            (dma_w_sop),
   .dma_w_eop            (dma_w_eop),
   .dma_w_err            (dma_w_err),
   .dma_w_mod            (dma_w_mod)
   );



//******************************************************************************
// FIFO Control signals
//******************************************************************************

   // w_flush_int
   // Combine all events that will require a flush of the TX FIFO.
   //------------------------------------------------
   assign w_flush_int = (frame_restart_edge | late_coll_occ_hclk |
                         underflow_frame_hclk | too_many_retry_hclk |
                         dma_w_overflow);


   // w_flush_del
   // Delay w_flush_int so that it can be leading edge detected
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
        w_flush_del <= 1'b0;
      else
        w_flush_del <= w_flush_int;


   // dma_w_flush
   // Edge detect w_flush_int to form a pulse ot flush the fifo.
   // Also flush contiuously if in IDLE state.
   //------------------------------------------------
   assign dma_w_flush = (w_flush_int & ~w_flush_del) | s_tx_idle;


   // tx_no_crc
   // decide which NO CRC to send to FIFO
   //------------------------------------------------
   assign tx_no_crc = (current_is_frm1 & tx_no_crc_save_frm1) |
                      (current_is_frm2 & tx_no_crc_save_frm2);


   // dma_w_control
   // Packet control information to be store in FIFO
   // Setup at the end of a management read or on a restart of oldest frame
   // (buf_access_cnt_load provides both these).
   // This ensures that the SOP write to the FIFO has the corrrect control
   // information associated with it.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
        dma_w_control <= 1'b0;
      else if (buf_access_cnt_load)
        dma_w_control <= tx_no_crc;
      else
        dma_w_control <= dma_w_control;



//******************************************************************************
// fifo instantiation
//******************************************************************************

   // DMA TX FIFO :
   //   width = 128 bits
   //   depth = `edma_tx_fifo_size
   //------------------------------------------------
gem_fifo #(.DEPTH(`edma_tx_fifo_size),             // depth(decimal)
           .WIDTH(`edma_bus_width),                // width(decimal)
           .CNT_WIDTH(`edma_tx_fifo_cnt_width),    // pointer counters width(decimal)
           .BASE2_DEPTH(`edma_tx_base2_fifo_size)) // depth(base2)
   i_gem_ftx (

   // write signals to fifo
   .w_clk        (hclk),
   .w_rst_n      (n_hreset),
   .w_wr         (dma_w_wr),
   .w_data       (dma_w_data[`edma_bus_width-1:0]),
   .w_eop        (dma_w_eop),
   .w_sop        (dma_w_sop),
   .w_mod        (dma_w_mod),
   .w_err        (dma_w_err),
   .w_flush      (dma_w_flush),
   .w_control    (dma_w_control),

   // write signals from fifo
   .w_overflow   (dma_w_overflow),
   .w_fifo_count (dma_w_fifo_count),
   .w_flushing   (dma_w_flushing),

   // read signals to fifo
   .r_clk        (tx_r_clk),
   .r_rst_n      (tx_r_rst_n),
   .r_rd         (tx_r_rd),
   .r_valid      (tx_r_valid),
   .r_data       (tx_r_data),
   .r_eop        (tx_r_eop),
   .r_sop        (tx_r_sop),
   .r_mod        (tx_r_mod),
   .r_err        (tx_r_err),
   .r_flushed    (tx_r_flushed),

   // read signals from fifo
   .r_underflow  (tx_r_underflow),
   .r_fifo_count (tx_r_fifo_count),
   .r_pkt_comp   (tx_r_pkt_comp),
   .r_control    (tx_r_control)
   );



//******************************************************************************
// FIFO level monitor
//******************************************************************************

   // burst_length  - Expand programmed ahb_burst_length to make compare easy
   //                 and to prevent out of range compile error for
   //                 `edma_rx_fifo_cnt_width > 4.
   //------------------------------------------------
   assign burst_length = {{`edma_tx_fifo_cnt_width{1'b0}},ahb_burst_length[4:0]};
   //------------------------------------------------

   // max_burst_length - Pick off required bits from burst_length
   //                    NOTE: programmed burst length must be less than the
   //                          depth of the FIFO.
   //------------------------------------------------
   assign max_burst_length = burst_length[`edma_tx_fifo_cnt_width-1:0];
   //------------------------------------------------

   // tx_r_data_rdy
   // signal frame ready for MAC TX to process, either when a complete
   // packet is available in the FIFO, or when a threshold is reached on
   // the fill level.
   // This threshold is used to ensure enough of a buffer before the MAC TX
   // begins transmission, and is triggered when there is not enough room
   // for another AHB burst to be put into the FIFO.
   //------------------------------------------------
   assign tx_r_data_rdy =
      tx_r_pkt_comp |
      (tx_r_fifo_count > (`edma_tx_base2_fifo_size - max_burst_length));



//******************************************************************************
// synchronisation of status from gem_tx
//******************************************************************************

   // dma_tx_status_tog
   // Signal completion back to the gem_tx module. This toggle
   // handshaking signal is set once both management writeback has
   // completed and the pclk update has completed.
   // Additionally if a collision has occured, this same handshaking
   // mechanism is used by gem_tx to indicate that the collision has
   // been seen and serviced by the DMA. The inclusion of the s_tx_idle
   // signal is used so that if any spurious frame end signals come back
   // from the mac then it will toggle to keep the mac from locking
   // waiting for an status tog
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         dma_tx_status_tog <= 1'b0;
      else if(tx_stat_capt_pulse | frame_restart_edge |
             (tx_frame_end_pulse & s_tx_idle))
         dma_tx_status_tog <= ~dma_tx_status_tog;
      else
         dma_tx_status_tog <= dma_tx_status_tog;



//******************************************************************************
// TX MAC end of frame detection
//******************************************************************************

   // frm1_man_wr_req_hold
   // Detect and hold when a management writeback is required for frame 1
   // because of an tx_frame_end_pulse from the gem_tx block.
   // Hold until writeback commences
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         frm1_man_wr_req_hold <= 1'b0;
      else if (ns_tx_frm1_wr | s_tx_idle)
         frm1_man_wr_req_hold <= 1'b0;
      else if (frame_1_older & tx_frame_end_pulse)
         frm1_man_wr_req_hold <= 1'b1;
      else
         frm1_man_wr_req_hold <= frm1_man_wr_req_hold;

   // frm2_man_wr_req_hold
   // Detect and hold when a management writeback is required for frame 2
   // because of an tx_frame_end_pulse from the gem_tx block.
   // Hold until writeback commences
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         frm2_man_wr_req_hold <= 1'b0;
      else if (ns_tx_frm2_wr | s_tx_idle)
         frm2_man_wr_req_hold <= 1'b0;
      else if (frame_2_older & tx_frame_end_pulse)
         frm2_man_wr_req_hold <= 1'b1;
      else
         frm2_man_wr_req_hold <= frm2_man_wr_req_hold;


   // Once on-going DMA operation has been stopped, it is
   // safe to commence the appropriate writeback.
   //------------------------------------------------
   assign man_wr_required_frm1 = frm1_man_wr_req_hold & dma_data_done;
   assign man_wr_required_frm2 = frm2_man_wr_req_hold & dma_data_done;



//******************************************************************************
// collision error handling
//******************************************************************************

   // coll_occurred_del
   // delay coll_occurred_hclk for edge detection
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         coll_occurred_del <= 1'b0;
      else
         coll_occurred_del <= coll_occurred_hclk;


   // leading ad trailing edge detection for coll_occurred_hclk
   //------------------------------------------------
   assign coll_occ_pos_edge = coll_occurred_hclk & ~coll_occurred_del;
   assign coll_occ_neg_edge = ~coll_occurred_hclk & coll_occurred_del;


   // coll_occurred_hold
   // hold coll_occ_pos_edge until all on-going DMA or management activity
   // has finished
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
     if (~n_hreset)
        coll_occurred_hold <= 1'b0;
     else if (ns_tx_idle)
        coll_occurred_hold <= 1'b0;
     else if (dma_data_done & ((ns_tx_frm1_buf_vld & frame_1_older) |
                               (ns_tx_frm2_buf_vld & frame_2_older)))
        coll_occurred_hold <= 1'b0;
     else if (coll_occ_pos_edge)
        coll_occurred_hold <= 1'b1;
     else
        coll_occurred_hold <= coll_occurred_hold;


   // frame_restart_edge
   // force restart once we know DMA has finished
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
     if (~n_hreset)
        frame_restart_edge <= 1'b0;
     else
        frame_restart_edge <= (coll_occ_pos_edge | coll_occurred_hold) &
                              dma_data_done &
                              ((ns_tx_frm1_buf_vld & frame_1_older) |
                               (ns_tx_frm2_buf_vld & frame_2_older));


   // Direct frame_restart_edge to the eldest frame in the system.
   //------------------------------------------------
   assign tx_frm1_restart = frame_restart_edge & frame_1_older;
   assign tx_frm2_restart = frame_restart_edge & frame_2_older;



//******************************************************************************
// Error conditions
//******************************************************************************

   // tx_used_bit_read
   // Set if the ownership (or used) bit is set in word 1 of a descriptor read
   //------------------------------------------------
   // swapped order of descriptor reads, September 2007
   // To keep risk low, we have ensured  'tx_used_bit_read' is set on the
   // second descriptor read, as per the original descriptor read ordering
   always @ (posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            tx_used_bit_read_0    <= 1'b0;
            zero_length_decode_0  <= 1'b0;
            tx_eof_0        <= 1'b0;
            tx_wrap_0       <= 1'b0;
         end
      else
         begin
            if (man_rd_data_phase_0 & man_rd_hrdata[31])
               tx_used_bit_read_0 <= 1'b1;
            else if (man_rd_data_phase_1)
               tx_used_bit_read_0 <= 1'b0;

            if (man_rd_data_phase_0 & man_rd_hrdata[15])
               tx_eof_0 <= 1'b1;
            else if (man_rd_data_phase_1)
               tx_eof_0 <= 1'b0;

            if (man_rd_data_phase_0 & man_rd_hrdata[30])
               tx_wrap_0 <= 1'b1;
            else if (man_rd_data_phase_1)
               tx_wrap_0 <= 1'b0;

            if (man_rd_data_phase_0 & (man_rd_hrdata[13:0] == 14'h0000))
               zero_length_decode_0 <= 1'b1;
            else if (man_rd_data_phase_1)
               zero_length_decode_0 <= 1'b0;
         end

   assign tx_used_bit_read =(man_rd_data_phase_1 & tx_used_bit_read_0);

   // zero_length_decode
   // detect a zero length buffer and use to signal new buffer required.
   //------------------------------------------------
   assign zero_length_decode = man_rd_data_phase_1 & zero_length_decode_0;


   // tx_exh_start_hold
   // Holds an occurance of tx_used_bit_read or hresp_notok, when
   // SOP has not yet been written into the FIFO.
   // Because SOP has not yet been written, there will be no MAC TX activity
   // so the PCLK domain handshaking logic must complete on DMA alone.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         tx_exh_start_hold <= 1'b0;
      else if (s_tx_idle | update_status)
         tx_exh_start_hold <= 1'b0;
      else if ((tx_used_bit_read | hresp_notok_del) & ~current_sop_written)
         tx_exh_start_hold <= 1'b1;
      else
         tx_exh_start_hold <= tx_exh_start_hold;


   // tx_exh_mid_frm1_hold & tx_exh_mid_frm2_hold
   // detect a used bit set in the middle of the frame, this needs to be
   // held until writeback of the current frame.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            tx_exh_mid_frm1_hold <= 1'b0;
            tx_exh_mid_frm2_hold <= 1'b0;
         end

      // reset when in IDLE
      else if(s_tx_idle)
         begin
            tx_exh_mid_frm1_hold <= 1'b0;
            tx_exh_mid_frm2_hold <= 1'b0;
         end

      // Current is frame one and a used bit is read after SOP written
      else if(tx_used_bit_read & current_sop_written & current_is_frm1)
         begin
            tx_exh_mid_frm1_hold <= 1'b1;
            tx_exh_mid_frm2_hold <= tx_exh_mid_frm2_hold;
         end

      // Current is frame two and a used bit is read after SOP written
      else if(tx_used_bit_read & current_sop_written & current_is_frm2)
         begin
            tx_exh_mid_frm1_hold <= tx_exh_mid_frm1_hold;
            tx_exh_mid_frm2_hold <= 1'b1;
         end

      // Clear holding signal if just finished a writeback
      else if(man_wr_done & s_tx_frm1_wr)
         begin
            tx_exh_mid_frm1_hold <= 1'b0;
            tx_exh_mid_frm2_hold <= tx_exh_mid_frm2_hold;
         end

      // Clear holding signal if just finished a writeback
      else if(man_wr_done & s_tx_frm2_wr)
         begin
            tx_exh_mid_frm1_hold <= tx_exh_mid_frm1_hold;
            tx_exh_mid_frm2_hold <= 1'b0;
         end

      // Else maintain value
      else
         begin
            tx_exh_mid_frm1_hold <= tx_exh_mid_frm1_hold;
            tx_exh_mid_frm2_hold <= tx_exh_mid_frm2_hold;
         end


   // hresp_notok_hold
   // Detect and hold an hresp not OK error for status reporting
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         hresp_notok_hold <= 1'b0;
      else if (s_tx_idle | update_status)
         hresp_notok_hold <= 1'b0;
      else if (hresp_notok_del)
         hresp_notok_hold <= 1'b1;
      else
         hresp_notok_hold <= hresp_notok_hold;


   // tx_dma_bad_frame
   // indicates a status update of a bad frame
   //------------------------------------------------
   assign tx_dma_bad_frame = (zero_writeback_halt & s_tx_go_active) |
                             tx_used_bit_read |
                             tx_exh_mid_frm1_hold |
                             tx_exh_mid_frm2_hold |
                             hresp_notok_del |
                             hresp_notok_hold |
                             too_many_retry_hclk |
                             underflow_frame_hclk |
                             late_coll_occ_hclk;



//******************************************************************************
// Transmit DMA status update to pclk domain
//******************************************************************************

   // update_status
   // Pulse used to update the status flags output from dma_rx block;
   // Pulse when management write has completed or when a zero halt occurred.
   //------------------------------------------------
   assign update_status = ~s_tx_idle &
                         (man_wr_done | (zero_writeback_halt & s_tx_go_active));


   // tx_dma_stable_tog & tx_dma_status_stable
   // These signals indicate the the status outputs from the DMA TX to PCLK
   // domain are now stable and ready for sampling.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            tx_dma_stable_tog    <= 1'b0;
            tx_dma_status_stable <= 1'b0;
         end
      else if (update_status & ~tx_dma_status_stable)
         begin
            tx_dma_stable_tog    <= ~tx_dma_stable_tog;
            tx_dma_status_stable <= 1'b1;
         end
      else if (tx_stat_capt_pulse)
         begin
            tx_dma_stable_tog    <= tx_dma_stable_tog;
            tx_dma_status_stable <= 1'b0;
         end
      else
         begin
            tx_dma_stable_tog    <= tx_dma_stable_tog;
            tx_dma_status_stable <= tx_dma_status_stable;
         end


   // tx_dma_complete_ok, tx_dma_buffers_ex, tx_dma_buff_ex_mid
   // & tx_dma_hresp_notok
   // Status outputs to PCLK domain. Setup on update status, provided
   // an update is not already in progress.
   // tx_dma_complete_ok indicates a good frame processed by DMA
   // tx_dma_buffers_ex indicates buffers exhausted before SOP written to FIFO.
   // tx_dma_buff_ex_mid indicates buffers exhausted after SOP written to FIFO.
   // tx_dma_hresp_notok indicates an hresp error during buffer reads.
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         begin
            tx_dma_complete_ok <= 1'b0;
            tx_dma_buffers_ex  <= 1'b0;
            tx_dma_buff_ex_mid <= 1'b0;
            tx_dma_hresp_notok <= 1'b0;
         end
      else if (update_status & ~tx_dma_status_stable)
         begin
            tx_dma_complete_ok <= ~tx_dma_bad_frame;
            tx_dma_buffers_ex  <= tx_used_bit_read | tx_exh_start_hold |
                                  (hresp_notok_del & ~current_sop_written);
            tx_dma_buff_ex_mid <= tx_exh_mid_frm1_hold | tx_exh_mid_frm2_hold;
            tx_dma_hresp_notok <= hresp_notok_del | hresp_notok_hold;
         end
      else if(tx_stat_capt_pulse)
         begin
            tx_dma_complete_ok <= 1'b0;
            tx_dma_buffers_ex  <= 1'b0;
            tx_dma_buff_ex_mid <= 1'b0;
            tx_dma_hresp_notok <= 1'b0;
         end
      else
         begin
            tx_dma_complete_ok <= tx_dma_complete_ok;
            tx_dma_buffers_ex  <= tx_dma_buffers_ex;
            tx_dma_buff_ex_mid <= tx_dma_buff_ex_mid;
            tx_dma_hresp_notok <= tx_dma_hresp_notok;
         end


endmodule

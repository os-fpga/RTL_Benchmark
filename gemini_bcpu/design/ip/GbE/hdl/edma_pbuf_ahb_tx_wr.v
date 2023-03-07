//------------------------------------------------------------------------------
// Copyright (c) 2006-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_pbuf_ahb_tx_wr.v
//   Module Name:        edma_pbuf_ahb_tx_wr
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
//   Description  : This is the write interface for the DMA Packet buffer.
//                  While there is still room in the external DPRAM, we
//                  can continually fill it to a maximum of 2 full pkts
//                  It must have at least 1 full packet before the MAC
//                  is started
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_pbuf_ahb_tx_wr (

    // Queue upper and lower bound constants
    TX_PBUF_SEGMENTS_LOWER_ADDR,
    TX_PBUF_SEGMENTS_UPPER_ADDR,
    TX_PBUF_NUM_SEGMENTS,

    // Fill level constants
    TX_PBUF_MAX_FILL_LVL,

    // system signals
    hclk,
    n_hreset,

    // async input used to trigger tx_start
    trigger_dma_tx_start,

    // Static configuration
    tx_top_q_id,

    // signals coming from gem_hclk_syncs
    new_tx_q_ptr_pulse,
    tx_stat_capt_pulse,
    tx_halt_hclk,
    tx_start_hclk_pulse,
    enable_tx_hclk,
    tx_dma_descr_base_addr,

    // signals coming from gem_registers
    dma_bus_width,
    tx_pbuf_tcp_en,
    ahb_burst_length,
    endian_swap,
    tx_cutthru_threshold,
    tx_cutthru,
    full_duplex,
    force_max_ahb_burst_tx,

    // AHB Inputs
    hgrant_descr,
    hgrant_data,
    hready,
    hresp,
    hrdata,

    // TX Descriptor AHB Outputs
    hbusreq_descr,
    hlock_descr,
    hburst_descr,
    htrans_descr,
    hsize_descr,
    hwrite_descr,
    hprot_descr,
    haddr_descr,
    hwdata_descr,

    // TX Data AHB Outputs
    hbusreq_data,
    hlock_data,
    hburst_data,
    htrans_data,
    hsize_data,
    hwrite_data,
    hprot_data,
    haddr_data,
    hwdata_data,

    // outputs to pclk_syncs
    tx_dma_stable_tog,
    tx_dma_complete_ok,
    tx_dma_hresp_notok,
    tx_dma_late_col,
    tx_dma_toomanyretry,
    tx_dma_underflow,
    tx_dma_buffers_ex,
    tx_dma_buff_ex_mid,
    tx_dma_go,
    tx_dma_descr_ptr,
    tx_dma_descr_ptr_tog,
    tx_dma_int_queue,

    // DPRAM interface
    tx_ena,
    tx_wea,
    tx_addra,
    tx_dia,

    // AHB side of PBUF indicates to the MAC side that new packets
    // (or parts of packets if tx_cutthru is active) are available to be
    // read
    end_of_packet_tog,
    cutthru_buffer_pending,
    part_of_packet_tog,
    pkt_end_new,
    pkt_end_flush,
    pkt_captured,
    dpram_almost_empty,
    num_pkts_xfer,
    underflow_tog,

    // MAC side of PBUF indicates pbuf resources can be freed up
    full_pkt_read,
    part_pkt_read,
    part_pkt_queue,
    xfer_status_bus,
    xfer_status_bus_ts,
    xfer_status_captured,
    dpram_fill_lvl,

    // 64b addressing support
    upper_tx_q_base_addr,
    dma_addr_bus_width,

    // Write to the cutthru FIFO when the write pointer is getting
    // close to status words.
    cutthru_status_word,
    cutthru_status_word_push,

    tx_bd_extended_mode_en,

   // ASF - signals going to gem_reg_top
   asf_dap_tx_wr_err,

   // Lockup Detection Signals
   full_pkt_inc,
   used_bit_vec,
   lockup_flush

   );

   parameter p_edma_axi                         = 1'b1;
   parameter p_edma_spram                       = 1'b0;
   parameter p_edma_pbuf_cutthru                = 1'b0;
   parameter p_edma_hprot_value                 = 4'd0;
   parameter p_edma_queues                      = 32'd1;
   parameter p_edma_addr_width                  = 32'd32;
   parameter p_edma_tx_pbuf_data                = 32'd64;
   parameter p_edma_tx_pbuf_addr                = 32'd10;
   parameter p_edma_tx_pbuf_queue_segment_size  = 32'd2;
   parameter p_edma_asf_dap_prot                = 1'b0;
   parameter p_edma_tx_pbuf_prty                = 8'd8;

   // Depending on the size of the RAM, adjust the partpkt_threshold
   // accordingly.
   wire [p_edma_tx_pbuf_addr-1:0] partpkt_threshold;
   generate if (p_edma_tx_pbuf_data == 32'd128) begin : gen_partpkt_threhold_8
      assign partpkt_threshold = {{p_edma_tx_pbuf_addr{1'b0}},4'd8};
   end
   else begin : gen_partpkt_threhold_16
      assign partpkt_threshold = {{p_edma_tx_pbuf_addr-1{1'b0}},5'd16};
   end
   endgenerate

   // parameters for main state machine
   parameter
      DMA_IDLE     = 3'b000, // idle state, reset and flush fifo
      DMA_MANRD    = 3'b001, // read descriptor for frame one
      DMA_PKTDATA  = 3'b010, // Pkt data read from AHB
      DMA_PKTINFO  = 3'b100, // Pkt status and TCP offload checksum updates
      DMA_MANWR    = 3'b011; // writeback descriptor for frame one

   //***************************************************************************
   // port declarations
   //***************************************************************************

   // Constants to define the upper and lower bounds of the queue addresses. These would
   // normally be passsed in as parameters, but owing to how these bounds are calculated
   // (in a for loop) it's not possible to use a paramater and a wire is instead used.
   input [(p_edma_tx_pbuf_queue_segment_size*p_edma_queues)-1:0] TX_PBUF_SEGMENTS_LOWER_ADDR;
   input [(p_edma_tx_pbuf_queue_segment_size*p_edma_queues)-1:0] TX_PBUF_SEGMENTS_UPPER_ADDR;
   input [(16*5)-1:0] TX_PBUF_NUM_SEGMENTS;

   input [(p_edma_tx_pbuf_addr*p_edma_queues)-1:0] TX_PBUF_MAX_FILL_LVL;


   // System signals
   input          hclk;                // AHB clock.
   input          n_hreset;            // AHB reset.


   input          trigger_dma_tx_start;  // Async input used to trigger TX_START

   input  [3:0]   tx_top_q_id;         // ID for top queue.

   // Signals coming from gem_hclk_syncs
   input          new_tx_q_ptr_pulse;  // New queue pointer written (NOT USED)
   input          tx_stat_capt_pulse;  // Hclk pulse indicating tx dma status
                                       // has been captured within pclk domain.
   input          tx_halt_hclk;        // Hclk pulse indicating that
                                       // transmission should halt after all
                                       // ongoing activity has completed.
   input          tx_start_hclk_pulse; // Hclk pulse indicating that
                                       // transmission should begin.
   input          enable_tx_hclk;      // Enable transmission path (soft reset)
   input [(p_edma_queues*32)-1:0] tx_dma_descr_base_addr; // Base address for the buffer
                                       // descriptor queue.

   // Signals coming from gem_registers
   input    [1:0] dma_bus_width;       // Current programmed width of data bus:
                                       // 00 = 32  bit bus (default)
                                       // 01 = 64  bit bus
                                       // 1x = 128 bit bus
   input          tx_pbuf_tcp_en;      // TCP offload enable
   input    [4:0] ahb_burst_length;    // AHB burst length control
   input    [1:0] endian_swap;         // Endian swap control
   input          full_duplex;         // full duplex signal from the network.
                                       // configuration register.
   input  [p_edma_tx_pbuf_addr-1:0] tx_cutthru_threshold; // Threshold value for
                                                        // cut-thru
   input          tx_cutthru;          // Enable for cut-thru operation
   input          force_max_ahb_burst_tx; // Force AHB to issue max len bursts

   // inputs from AHB
   input           hgrant_descr;
   input           hgrant_data;
   input           hready;
   input   [1:0]   hresp;
   input  [127:0]  hrdata;

   // Outputs to AHB - TX Descriptor AHB Master
   output          hbusreq_descr;
   output          hlock_descr;
   output  [2:0]   hburst_descr;
   output  [1:0]   htrans_descr;
   output  [2:0]   hsize_descr;
   output          hwrite_descr;
   output  [3:0]   hprot_descr;
   output  [p_edma_addr_width-1:0]  haddr_descr;
   output  [127:0] hwdata_descr;

   // Outputs to AHB - TX Data AHB Master
   output          hbusreq_data;
   output          hlock_data;
   output  [2:0]   hburst_data;
   output  [1:0]   htrans_data;
   output  [2:0]   hsize_data;
   output          hwrite_data;
   output  [3:0]   hprot_data;
   output  [p_edma_addr_width-1:0]  haddr_data;
   output  [127:0]  hwdata_data;


   // Outputs to pclk_syncs
   output         tx_dma_stable_tog;   // Toggles to indicate to PCLK domain
                                       // that the tx dma status outputs are
                                       // stable and ready to be sampled.
   output         tx_dma_complete_ok;  // Frame completed successfully in DMA.
   output         tx_dma_hresp_notok;  // DMA indicates HRESP not OK on frame.
   output         tx_dma_late_col;     // late collision indicator
   output         tx_dma_toomanyretry; // too many retires indicator
   output         tx_dma_underflow;    // Underflow indicator
   output         tx_dma_buffers_ex;   // DMA indicates buffers were exhausted
                                       // before SOP for frame written to FIFO.
   output         tx_dma_buff_ex_mid;  // DMA indicates buffers were exhausted
                                       // after SOP for frame written to FIFO.
   output   [3:0] tx_dma_int_queue;    // Identifies which queue the interrupt
                                       // is destined
   output         tx_dma_go;           // DMA indicates on-going activity.
   output [(p_edma_queues*32)-1:0] tx_dma_descr_ptr;    // Descriptor queue pointer for debug
   output         tx_dma_descr_ptr_tog;   // handshake for tx_dma_descr_ptr

   output         tx_ena;                     // DPRAM Interface
   output         tx_wea;                     // DPRAM Interface
   output  [p_edma_tx_pbuf_addr-1:0]  tx_addra; // DPRAM Interface
   output  [p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:0]
                                      tx_dia;   // DPRAM Interface
                                                // the last p_edma_tx_pbuf_prty bits are parity

   // AHB side of PKT BUFFER identifies that one or more
   // full (or partial if cutthru is enabled)packets are available
   // to be read ...
   output [p_edma_queues-1:0] end_of_packet_tog;   // Packet completely written into DPRAM
   output [(p_edma_queues*4)-1:0]  num_pkts_xfer;
   input [p_edma_queues-1:0] pkt_captured;

   output [p_edma_queues-1:0] part_of_packet_tog;  // Part of Packet  written into DPRAM
   output [p_edma_queues-1:0] cutthru_buffer_pending; // A packet part is in the FIFO and the buffer is full
   output [p_edma_queues-1:0] pkt_end_new;         // Good Packet written into DPRAM
   output                    pkt_end_flush;       // Packet flushed in DPRAM
   output [p_edma_queues-1:0] dpram_almost_empty;
   input          underflow_tog;       // MAC indicates an underflow event

    // MAC side of PBUF indicates pbuf resources can be freed up
   input          full_pkt_read;       // Status available from RD side of DPRAM
   input          part_pkt_read;       // Status available from RD side of DPRAM
   input   [3:0]  part_pkt_queue;      // Queue to which part_pkt_read refers to
   input  [77:0]  xfer_status_bus;     // Status to use for writeback
   input  [48:0]  xfer_status_bus_ts;   // Status to use for writeback of timestamp
                                        // msb indicates ts_to_be_written to BD
                                        // last 6 bits are parity bits of timestamp[41:0]
   output         xfer_status_captured;       // Status from RD side has been captured

   output  [(p_edma_queues*p_edma_tx_pbuf_addr)-1:0] dpram_fill_lvl; // Fill level for all queues

     // 64b addressing support and extended BD from reg_top
   input  [31:0] upper_tx_q_base_addr; // upper 32b base address for all buffer descriptors
   input         dma_addr_bus_width;

   input         tx_bd_extended_mode_en;  // enable extended BD mode, which is used to Descriptor TS insertion

   output [p_edma_tx_pbuf_addr+95:0] cutthru_status_word;
   output reg                       cutthru_status_word_push;

   // ASF - signals going to gem_reg_top
   output        asf_dap_tx_wr_err;     // Parity error

   // lockup detection
   output [p_edma_queues-1:0]
                    full_pkt_inc;     // Complete packet written to SRAM
   output [p_edma_queues-1:0]
                    used_bit_vec;     // Used bit read for each queue
   output           lockup_flush;     // Major error, abort lockup detection

  reg   [2:0]   dma_state_nxt;     // Main State machine next state
  reg   [2:0]   dma_state;         // Main State machine curr state
  reg   [2:0]   last_dma_state;    // Main State machine last state
  reg           manrd_done;        // Descriptor Read engine finished
  reg   [29:0]  nxt_descr_ptr[p_edma_queues-1:0];    // AHB address of next descriptor
  wire  [29:0]  nxt_descr_ptr_pad         [15:0];    // Padded version of the above
  wire  [29:0]  muxed_descr_ptr;                     // AHB address of next descriptor
  wire [31:0] tx_dma_descr_base_addr_array[15:0]; // Handy array to de-serialise the incoming signal
                                                            // Makes coding slightly neater.
  wire [(p_edma_tx_pbuf_addr)-1:0] TX_PBUF_MAX_FILL_LVL_ARRAY [15:0]; // Handy array to de-serialise the incoming signal

  reg    [3:0]  tx_dma_int_queue;    // Identifies which queue the interrupt
  reg   [3:0]   str_int_queue;
  wire          buffullstr_sel;
  wire  [3:0]   queue_ptr_rph;     // Current Queue Pointer
  wire  [3:0]   queue_ptr_dph;     // Current Queue Pointer
  wire  [3:0]   queue_being_read;
  wire          queue_being_read_vld;
  wire          used_bit_read_all;
  wire                                     [4:0] TX_PBUF_NUM_SEGMENTS_ARRAY        [15:0]; // Handy array to de-serialise the incoming signal
  wire [(p_edma_tx_pbuf_queue_segment_size)-1:0] TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY [15:0]; // Handy array to de-serialise the incoming signal
  wire [(p_edma_tx_pbuf_queue_segment_size)-1:0] TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY [15:0]; // Handy array to de-serialise the incoming signal
  wire  [3:0]   set_queue_int;
  wire  [3:0]   part_pkt_queue;


  wire   [3:0]  queue_being_read_manwr;
  wire   [3:0]  queue_being_written;

  reg   [29:0]  ahb_data_addr;          // AHB address of current packet data
  reg           first_buffer_of_pkt;    // Flag identifying the current buffer
                                        // is first within a packet
  reg   [11:0]  buf_length;             // The Buffer Length
  reg   [11:0]  num_requests;           // same as buf_length but driven on
                                        // address phase of AHB
  reg           buf_has_eop;            // Current buffer is last of packet
  reg   [3:0]   pkt_end_mod_c;          // Num vld bytes on last word of pkt 1
  reg   [3:0]   pkt_end_mod;            // Num vld bytes on last word of pkt 1
  reg           tx_ena_int;             // DRAM inerface
  reg           tx_wea_int;                 // write enable for DPRAM
  reg   [p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:0]
                tx_dia;                      // DRAM inerface
                                             // the last p_edma_tx_pbuf_prty bits are parity

  wire  [p_edma_tx_pbuf_addr:0] dpram_addr_p1; // tx_addra + 1
  wire  [p_edma_tx_pbuf_addr:0] dpram_addr_p2; // tx_addra + 2
  wire  [p_edma_tx_pbuf_addr:0] dpram_addr_p3; // tx_addra + 3
  wire  [p_edma_tx_pbuf_addr:0] dpram_addr_p4; // tx_addra + 4
  reg   [7:0]   num_pkts_in_buf;        // Number of pkts currently in progress
  reg           halt_pkt_buf_wr;        // Stop processing any new pkts
  reg [p_edma_queues-1:0] end_of_packet_tog; // Per queue flag identifying pkt now in DPRAM
  reg [p_edma_queues-1:0] part_of_packet_tog; // flag identifying part of pkt now in DPRAM
  reg [p_edma_queues-1:0] cutthru_buffer_pending;       // flag identifying part of pkt now in DPRAM
  reg   [(p_edma_queues*4)-1:0]   num_pkts_xfer;          // Number of packets to be declared
                                        // as ready to be read by RD side
  reg [p_edma_queues-1:0] waiting_for_pkt_capt;   // RD side is busy processing the
                                        // last handshake
  reg [p_edma_queues-1:0] new_pkt_capt_req;     // More packets are ready to be
                                      // read by RD side of PBUF, but
                                      // waiting for current handshake to
                                      // be captured
  reg [p_edma_queues-1:0] new_part_pkt_capt_req;//
  wire  [p_edma_queues-1:0] pkt_captured_sync; // Re-synchronisation output
  wire  [p_edma_queues-1:0] pkt_captured_edge; // Packet has been capture
  reg   [p_edma_queues-1:0] pkt_end_new;       // flag identifying pkt now in DPRAM
  reg                       pkt_end_flush;     // flag identifying major flush
  reg           pkt_end_flush_capt;      // flag identifying major flush
  reg   [3:0]   buf_has_mod;            // Num bytes valid on last AHB read
                                        // of current buffer
  reg           tx_dma_buff_ex_mid;     // Held until captured by int logic
  reg           tx_dma_stable_tog;      // Interrupt info valid
  reg           tx_dma_complete_ok;     // Held until captured by int logic

  reg           tx_dma_descr_ptr_tog;      // Descr pointer valid
  reg           tx_dma_buffers_ex;      // Buffers exhanusted
  reg           hresp_notok_hold;      // AHB error held until captured
  reg   [31:0]  str_descriptor_wr_1;    // Descriptor Stored until we write into buffer
  reg   [29:0]  str_descr_ptr_wr;       // Descr Pointer stored until pkt done
  wire  [p_edma_tx_pbuf_addr-1:0]   tx_addra;     // DRAM inerface
  reg   [p_edma_tx_pbuf_addr-1:0]   dpram_addr_c; // DRAM inerface
  reg   [p_edma_tx_pbuf_addr-1:0]   dpram_addr;   // DRAM inerface
  wire  [(p_edma_queues*p_edma_tx_pbuf_addr)-1:0]   dpram_fill_lvl; // DPRAM Fill level
  reg   [p_edma_tx_pbuf_addr-1:0] dpram_fill_lvl_array[p_edma_queues-1:0]; // Same signal as the above,
                                        // but different structure to make coding slightl easier
  wire  [p_edma_tx_pbuf_addr-1:0] fill_lvl_inc[p_edma_queues-1:0]; // Amount to increment
  wire  [p_edma_tx_pbuf_addr-1:0] fill_lvl_dec[p_edma_queues-1:0]; // Amount to decrement

  wire  [p_edma_tx_pbuf_addr-1:0] q_empty_lvl[15:0]; // When does the q hit empty
  reg [p_edma_queues-1:0] dpram_almost_empty;

  reg   [11:0]  pkt_length_wr;          // Num of DPRAM accesses for pkt
  reg   [p_edma_tx_pbuf_addr-1:0]   pkt_end_addr_c;// EOP address
  reg   [p_edma_tx_pbuf_addr-1:0]   pkt_end_addr;// EOP address
  reg   [11:0]  pkt_length_rd;          // Num of DPRAM accesses for pkt
  wire  [7:0]   pkt_end_addr_offset;    // status_word_wr_0[10:0] + pkt_end_addr_offset = pkt_end_addr
  reg   [3:0]   alignment_addr;         // Determines how many vld bytes on 1st
                                        // AHB access of buffer
  reg           first_word_of_buffer;   // Identifies if this is the first word
                                        // of buffer
  reg   [12:0]  num_words_al_32;        // Number of words in buffer
  reg   [12:0]  num_words_al_64;        // Number of words in buffer
  wire  [12:0]  num_words_al_128;       // Number of words in buffer
  wire  [4:0]   num_words_plus1_sum;    // Do we add 1 to th enumber of words
  wire  [12:0]  num_words_al;           // Number of words in buffer
  reg           tx_dma_hresp_notok;     // Held until captured by int logic
  reg           tx_dma_late_col;        // late collision indicator
  reg           tx_dma_toomanyretry;    // too many retires indicator
  reg           tx_dma_underflow;       // underflow indicator
  reg           int_issued_wait_for_capt;          // Set until status has been captured
  reg   [7:0]   str_int_vector;          //
  reg           zero_len_buf_reg;        // Burrent buffer is zero-length
  reg           zero_len_buf;           // In line with man_rd_done
  wire  [2:0]   tcp_status;             // Store TCP error status for writeback
  reg           tx_dma_go;              // DMA indicates on-going activity.
  reg   [4:0]   num_bytes_ahb_end;      // Number of bytes of last word
                                        // of buffer after alignment
  reg   [3:0]   final_mod;              // Latch mod from alignment buffer
  reg   [4:0]   tx_length_decrement;    // sets amount tx_dma_length is to be
                                        // decremented by on next clock
                                        // set by dma_bus_width

  reg           stored_buf_inc;         // Increment num pkts in progress
  wire          pkt_needs_writeback;    // Current buffer needs a writeback
  reg   [1:0]   man_wr_cnt;             // Number of packets that need writebacks
  wire          buffer_written;         // All AHB reads of curr pkt done
  wire          buffer_written_pluspad; // All AHB reads of curr pkt done + PAD
  reg           new_write_allowed;      // Another pkt may start to be fetched
  wire          one_packet_in_buf;      // Only one packet in buffer
  reg           used_bit_read_reg;      // Used bit of descriptor detected (held until end of manrd)
  reg           wrap_bit_read_reg;      // Used bit of descriptor detected (held until end of manrd)
  wire          buffer_full;            // DPRAM currently full - stop writing
  wire          buffer_full_err;        // DPRAM currently full - stop writing
  wire   [15:0] buffer_full_q;          // DPRAM currently full - stop writing
  wire          pkt_flush_norep;        // Error condition requiring pt flush from DPRAM
  wire          pkt_flush_report;       // Error condition requiring pt flush from DPRAM and writeback
  wire          pkt_flush;              // pkt_flush_report | pkt_flush_norep
  wire          dpram_wr_en;            // Write to DPRAM active on next cycle
  wire          dpram_wr_data_en;       // Write to DPRAM active on next cycle (data)
  wire          dpram_wr_stat_en;       // Write to DPRAM active on next cycle (status)
  reg           dpram_wr_data_en_d1;    // Write to DPRAM active on current cycle
  wire          align_buf_end;          // End of packet post align buffer
  wire          manwr_done;             // AHB Writeback complete
  wire          all_manwr_done;         // Last AHB Writeback (when >1 manwrs req) done
  wire          ip_hdr_cs_we;           // IP checksum has been generated
  wire  [143:0] ip_hdr_cs;              // IP checksum value + unchanged value
                                        // last 16 bits are parity of IP checksum
  wire  [p_edma_tx_pbuf_addr-1:0]  ip_hdr_cs_addr;  // DPRAM address of IP cs
  wire          tcp_hdr_cs_we;          // TCP/UDP checksum has been generated
  wire  [143:0] tcp_hdr_cs;             // TCP checksum value + unchanged value
                                        // last 16 bits are parity of TCP checksum
  wire  [p_edma_tx_pbuf_addr-1:0]  tcp_hdr_cs_addr;  // DPRAM address of  cs
                                        // appropriate value (2k or 4k)
  wire          complete_flush_hclk;    // major error condition
  wire          status_captured;        // Status has been captured
  wire  [4:0]   mod_plus_ali;           // buf_has_mod + alignment_addr
  wire  [143:0] al_w_data;              // Data Output of Alignment Module
                                        // extended by 16 bits for parity
  wire  [3:0]   al_w_mod;               // Mod Output of Alignment Module
  reg   [13:0]  descr_len_field;        // Descriptor Length Field
  wire  [13:0]  descr_len_field_minus1; // Descriptor Length Field Minus 1
  wire          generate_ip_csum;       // Generate L3 checksum
  wire          generate_tcp_csum;      // Generate L4 checksum
  reg           ahbdataph_strobe_d1;    // ahbdataph_strobe delayed
  reg   [2:0]   state_cnt;              // Counts num cycles in each state
  wire  [2:0]   state_cnt_nxt;          // Next value of State Counter
  reg   [3:0]   err_status;             // AHB error reporting
  wire  [17:0]  status_word_rd_0;       // Sample status read from DPRAM during
                                        // writeback (lower 32 bits)
  wire  [29:0]  status_word_rd_1;       // Sample status read from DPRAM during
                                        // writeback (upper 32 bits)
  wire  [25:0]  status_word_rd_2;       // Descriptor Stored until we write into buffer
  reg           writing_status_dpram;   // Identifies when status is written to
                                        // DPRAM
  wire          full_pkt_read_edge;     // Edge detected do_writeback_tog
  wire          part_pkt_read_edge;     // Edge detected do_writeback_tog
  wire  [31:0]  status_word_wr_0;     // Status word 0 to write to DPRAM
  wire  [31:0]  status_word_wr_1;     // Status word 1 to write to DPRAM
  wire  [31:0]  status_word_wr_2;     // Status word 2 to write to DPRAM
  reg  [p_edma_tx_pbuf_addr-1:0]  status_add_0_c; // Address for pkt status 0
  reg  [p_edma_tx_pbuf_addr-1:0]  status_add_0; // Address for pkt status 0

  reg  [77:0]   nxt_xfer_status_bus;
  reg  [77:0]   nxt_xfer_status_bus2;
  reg  [48:0]   nxt_xfer_status_bus_ts;
                                         // last 6 bits are parity bits of timestamp[41:0]
  reg  [48:0]   nxt_xfer_status_bus_ts2;
                                         // last 6 bits are parity bits of timestamp[41:0]
  reg           xfer_status_captured;   // Status from RD side has been captured
  reg           revert_to_data;       // Identifies if next state should be DATA
  reg           break_data_wback;     // writeback should follow this burst
  reg           brkdatabuf_full_add;  // hold off AHB while buffer is full
  reg           brkdatabuf_full_data; // hold off AHB while buffer is full
  wire          dma_pktstatus_done;   // Last Cycle of DMA_PKTINFO state

  wire          dma_state_man_rd;
  wire          dma_next_man_rd;
  wire          dma_state_man_wr;
  reg           dma_state_data;

  wire          hw_dma_tx_start;      // Syncronized pulse to start TX DMA (HW)
  wire          tx_dma_start;         // HW and SW combined version of tx_start
  reg           tx_dma_start_pending; // A start transmission is pending



  wire          ahbreqph_strobe_descr;
  wire          ahbreqph_strobe_descr_wr;
  wire          ahbreqph_strobe_data;
  wire          ahbaddph_strobe_descr;
  wire          ahbaddph_strobe_data;
  wire          ahbdataph_strobe_descr;
  wire          ahbdataph_strobe_descr_wr;
  wire          ahbdataph_strobe_data;
  wire          data_or_descr_aph;
  wire          data_or_descr_dph;
  reg           ahbaddph_strobe_en_descr;
  reg           ahbaddph_strobe_en_descr_wr;
  reg           ahbdataph_strobe_en_descr;
  reg           ahbdataph_strobe_en_descr_wr;
  reg           ahbaddph_strobe_en_data;
  reg           ahbdataph_strobe_en_data;
  wire          tx_last_data_ph;     // Signals final ahb data phase.
  wire          hresp_not_ok;
  reg           hresp_notok_eob;

  reg   [127:0] dma_data_out;
  reg   [15:0]  dma_prty_out; // parity protection for dma_data_out

  reg           hbusreq;
  reg   [2:0]   hburst;
  reg   [1:0]   htrans;
  reg   [2:0]   hsize;
  reg           hwrite;
  reg   [31:0]  haddr_lo;

  reg   [127:0] hwdata;
  reg   [15:0]  hwprty; // parity protection for hwdata
  wire  [1:0]   hresp;

  wire          endian_swap_now;       // indicates endian swap required
  reg           rd_endian_swap_now;    // endian_swap_now saved for read data
  reg   [1:0]   sel_word_lane;         // detect which word lane is to be used
  reg   [1:0]   rd_enable_word;        // delayed sel_word_lane for data phase
  reg   [127:0] dma_data_out_endian;   // write data after endian swap
  reg   [15:0]  dma_prty_out_endian;   // parity protection for write data after endian swap
  reg   [127:0] dma_data_in_endian;    // read data before endian swap
  reg   [15:0]  dma_prty_in_endian;   // parity of dma_data_in_endian
  wire  [15:0]  hrdata_prty;           // parity generated from input hrdata
  reg   [127:0] tx_dma_data_in;        // read data output
  reg   [15:0]  tx_dma_prty_in;        // parity of tx_dma_data_in - read data output
  reg   [7:0]   ahb_burst_maskh;       // address comparison mask upper bits
  wire          breaks_1k_boundary;    // next burst will break 1K AHB boundary
  wire          brk1kbndry_burst;
  wire  [3:0]   bndry1k_acc_size;
  reg   [3:0]   bndry1k_acc_size_128;
  reg   [3:0]   bndry1k_acc_size_64;
  reg   [3:0]   bndry1k_acc_size_32;
  wire  [29:0]  tx_dma_burst_addr;
  wire          eop_burst;
  wire  [4:0]   eop_burst_size;
  reg   [3:0]   ahb_access_cnt;

  wire  [p_edma_tx_pbuf_addr-1:0] fill_lvl_up_1;
  wire  [p_edma_tx_pbuf_addr-1:0] fill_lvl_up_2;
  wire  [p_edma_tx_pbuf_addr-1:0] fill_lvl_up_3;
  reg   [p_edma_tx_pbuf_addr-1:0] fill_lvl_down_1;

  wire          pkt_tx_xfer_req;
  wire          last_access_burst_req;  // Last access of a burst - req phase timed
  reg           last_access_burst_dph;  // Last access of a burst - data phase timed
  reg           reading_pad_rph;
  reg           reading_pad_aph;
  reg           reading_pad_dph;
  wire          underflow_reqph;
  reg           underflow_addph;
  reg           underflow_frame_hclk;
  reg           zero_len_buf_en;        // high when length field = 0
  wire          used_bit_read;
  reg           zero_len_buf_eop;
  wire          dpram_pktinfo_wr;
  wire          part_pkt_xfer_req;
  wire          wrap_bit_read;
  reg           block_descr_rd;
  wire          all_queues_checked;
  wire          used_bit_read_regc;
  wire          wrap_bit_read_regc;
  reg           descr_rd_done_rph;
  reg           descr_rd_done_dph;
  wire          pad_remaining_burst;
  reg           err_d1;
  reg           full_pkt_read_edge_d1;
  wire          set_dpram_region_full;

  wire [3:0] wmod_upsized;

  wire [p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:0]
               wdata_upsized;
  wire [145:0] wdata_upsized_pad;  // last 17 bits of parity


  reg   [3:0]   descr_rd_done_rph_cnt;
  reg   [3:0]   descr_rd_done_dph_cnt;
  wire  [61:0]  str_descr_ptr_wr_p1;     // Descr Pointer stored until pkt done for 64b addressing
  wire  [31:0]  status_word_wr_3;        // Status word 3 to write to DPRAM ( = upper 32b address bits of BD location in 64b address mode)


  wire  [42:0]  status_word_rd_3;       // TS

  reg   [3:0]   descr_wr_reqph_cnt;
  reg   [3:0]   descr_wr_addph_cnt;
  reg           manwr_astrobe_end;
  wire          ahbdataph_strobe_descr_wr_done;


  wire          dma_late_col_int;
  wire          dma_toomanyretry_int;
  wire          dma_hresp_notok_int;
  wire          dma_buff_ex_mid_int;
  wire          dma_buff_ex_int;
  wire          dma_tx_ok_int;
  wire          int_already_requested;
  wire          manwr_complete;
  wire  [31:0]  descriptor_wb_word1;
  wire  [31:0]  descriptor_wb_word1_prty;  // parity protection for descriptor_wb_word1
  wire          descriptor_rd_1_access;
  wire          descriptor_rd_2_access;
  wire          edma_tx_pbuf_data_w_is_128;
  wire          underflow_tog_edge;
  wire          set_late_col_int;
  wire          set_toomanyretry_int;
  wire          set_hresp_notok_int;
  wire          set_buff_ex_mid_int;
  wire          set_buff_ex_int;
  wire          set_tx_ok_int;
  wire          gen_int;
  wire          gen_int_last;
  wire          al_w_wr;
  wire          pkt_end_addr_p2_eq_status_add_0;
  wire          pkt_end_addr_p3_eq_status_add_0;
  wire          tx_ena_abort;
  wire          xfer_flush_event;

  integer       i;
  integer       int_q0;


  wire [3:0]    NO_OF_MAN_WR_ACCESS;       // = no minus 1, only one word write when no extended BD's
                                           // for non extended BD's there is always 1 access to write back word 1
                                           // for extended BD mode this will be more than 1 access
  assign NO_OF_MAN_WR_ACCESS = ~tx_bd_extended_mode_en ? 4'h0 : 4'h2;  // = no minus 1, 3 write for extended_bd mode

  assign edma_tx_pbuf_data_w_is_128 = (p_edma_tx_pbuf_data == 32'd128);

  parameter [31:0] p_gem_dma_addr_w_is_64 = p_edma_addr_width;
  wire             gem_dma_addr_w_is_64;
  assign           gem_dma_addr_w_is_64 = ((p_gem_dma_addr_w_is_64 == 32'd64) & dma_addr_bus_width);

  wire [29:0]   NEXT_DESCR_PTR_INC;


  // default BD size is 2 words in legacy mode
  // 6 words for ext_bd AND addr64
  // 4 otherwise
  assign NEXT_DESCR_PTR_INC  = (~gem_dma_addr_w_is_64 & ~tx_bd_extended_mode_en) ? 30'h00000002 :
                               ( gem_dma_addr_w_is_64 &  tx_bd_extended_mode_en) ? 30'h00000006 : 30'h00000004 ;

  genvar g;
  genvar g1;
  genvar g2;

  wire [41:0]   tx_timestamp;
  wire  [5:0]   tx_timestamp_prty;
  wire          ts_to_be_written;

  assign        tx_timestamp      = nxt_xfer_status_bus_ts[41:0];
  assign        tx_timestamp_prty = nxt_xfer_status_bus_ts[48:43];
  assign        ts_to_be_written  = nxt_xfer_status_bus_ts[42] & tx_bd_extended_mode_en;


  // Based on the incoming AHB signals, we can create some strobes that relate to the
  // request phase, address phase and data phases for the specific MASTER's.  Note that
  // internally, there is only 1 MASTER that drives 2 MASTER ports based on the state
  // of the main state machine in this module - this is done so that
  // the AHB system arbiter can prioritise TX descriptors over RX data, etc
  //
  // Firstly create the request phase strobes for the management descriptors ...
  // the Descriptor RD state stays active until the data associated with the
  // descriptor has been returned + 1 cycle
  // When we are in 32 bit mode, the man_rd state
  assign        ahbreqph_strobe_descr  = (hready & hgrant_descr & hbusreq &  // this will extend as long as we stay in MANRD state
                               ((dma_state == DMA_MANRD & ~block_descr_rd) | // so will read extra words
                                (dma_state == DMA_MANWR)));
  assign        ahbreqph_strobe_descr_wr  = (hready & hgrant_descr & hbusreq &
                                             dma_state == DMA_MANWR);
  //
  // Firstly create the request phase strobes for the pkt data ...
  assign        ahbreqph_strobe_data  = (hready &
                                        (|num_requests | reading_pad_rph) &
                                        hbusreq &
                                        hgrant_data &
                                        dma_state == DMA_PKTDATA);

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      ahbaddph_strobe_en_descr <= 1'b0;
      ahbdataph_strobe_en_descr <= 1'b0;
      ahbaddph_strobe_en_descr_wr <= 1'b0;
      ahbdataph_strobe_en_descr_wr <= 1'b0;
      ahbaddph_strobe_en_data  <= 1'b0;
      ahbdataph_strobe_en_data  <= 1'b0;
    end
    else
    begin
      if (hready)
      begin
        ahbaddph_strobe_en_descr <= ahbreqph_strobe_descr;
        ahbaddph_strobe_en_descr_wr <= ahbreqph_strobe_descr_wr;
        ahbdataph_strobe_en_descr <= ahbaddph_strobe_en_descr;
        ahbdataph_strobe_en_descr_wr <= ahbaddph_strobe_en_descr_wr;
        ahbaddph_strobe_en_data  <= ahbreqph_strobe_data;
        ahbdataph_strobe_en_data  <= ahbaddph_strobe_en_data;
      end
    end
  end
  assign ahbaddph_strobe_descr   = ahbaddph_strobe_en_descr & hready;
  assign ahbdataph_strobe_descr   = ahbdataph_strobe_en_descr & hready;
  assign ahbdataph_strobe_descr_wr   = ahbdataph_strobe_en_descr_wr & hready;
  assign ahbaddph_strobe_data    = ahbaddph_strobe_en_data & hready;
  assign ahbdataph_strobe_data    = ahbdataph_strobe_en_data & hready;

  assign data_or_descr_aph = (ahbaddph_strobe_data | ahbaddph_strobe_descr);
  assign data_or_descr_dph = (ahbdataph_strobe_data | ahbdataph_strobe_descr);

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      last_access_burst_dph <= 1'b0;
    else if (last_access_burst_dph & data_or_descr_dph)
      last_access_burst_dph <= 1'b0;
    else if (ahb_access_cnt == 4'h0  & data_or_descr_aph)
      last_access_burst_dph <= 1'b1;
  end

  assign tx_last_data_ph        = ahbdataph_strobe_data & ~ahbaddph_strobe_data;
  assign hresp_not_ok           = (hresp != 2'b00) & data_or_descr_dph;

  // FOR Manrds, only want to react to HRESP on the 2nd MANRD access - this is required
  // to ensure all the information relating to status field updates of DPRAM is setup
  // For all other states, HRESP is only taken into account at the end of the current burst ...
  always @(*)
  begin
    if (hresp_not_ok | hresp_notok_hold)
    begin
      if (dma_state_man_rd)
        hresp_notok_eob  = descr_rd_done_dph & ahbdataph_strobe_descr;
      else if (|hburst[2:1])
        hresp_notok_eob  = (ahb_access_cnt == 4'h0 &
                                ahbdataph_strobe_data);
      else
        hresp_notok_eob  = ahbdataph_strobe_data | ahbdataph_strobe_descr;
    end
    else
      hresp_notok_eob  = 1'b0;
  end


// -----------------------------------------------------------------------------
// AHB read and write databus handling
// -----------------------------------------------------------------------------

   // Work out whether to endian swap on this access depending on the programmed
   // mode. endian_swap[0] indicates the desired endianism for management
   // operations and endian_swap[1] indicates the endianism for data operations.
   assign endian_swap_now = ((endian_swap[0] & ~dma_state_data) |
                             (endian_swap[1] & dma_state_data));


   // dma_data_out_endian - Byte endian swapped version of write data.
   //                       Bytes only swapped within each 32-bit word
   //                       and then each word is later aligned to correct
   //                       word within the wider bus.
   //                         byte 0  => byte 3
   //                         byte 1  => byte 2
   //                         byte 2  => byte 1
   //                         byte 3  => byte 0
   //                         byte 4  => byte 7
   //                         byte 5  => byte 6
   //                         byte 6  => byte 5
   //                         byte 7  => byte 4
   //------------------------------------------------
   always @(*)
    begin
      // Default
      dma_data_out_endian = dma_data_out;
      dma_prty_out_endian = dma_prty_out;
      if (endian_swap_now) begin
         // Only need to swap the bottom wors as the rest is redundant.
         dma_data_out_endian = {dma_data_out[127:64], // Upper 8 bytes are not used
                                dma_data_out[39:32],
                                dma_data_out[47:40],
                                dma_data_out[55:48],
                                dma_data_out[63:56],
                                dma_data_out[7:0],
                                dma_data_out[15:8],
                                dma_data_out[23:16],
                                dma_data_out[31:24]};
         dma_prty_out_endian = {dma_prty_out[15:8], // parity swap
                                dma_prty_out[4],
                                dma_prty_out[5],
                                dma_prty_out[6],
                                dma_prty_out[7],
                                dma_prty_out[0],
                                dma_prty_out[1],
                                dma_prty_out[2],
                                dma_prty_out[3]};
      end
    end
   //------------------------------------------------


   // sel_word_lane - bus lane corresponding to the accessed words
   //------------------------------------------------
   always@(*)
      // Big endian order: least significant word @ highest address
      if (endian_swap_now)
         casex({dma_bus_width, haddr_lo[3:2]})
            4'b10_xx : sel_word_lane = ~haddr_lo[3:2];  // Only needed for AHB 128bit mode (endian_swap is tied low for AXI configs)
            4'b01_x0 : sel_word_lane = 2'b01;
            default : sel_word_lane  = 2'b00;
         endcase
      // Little endian order: least significant word @ lowest address
      else
         casex({dma_bus_width, haddr_lo[3:2]})
            4'b10_xx : sel_word_lane = haddr_lo[3:2];
            4'b01_x1 : sel_word_lane = 2'b01;
            default : sel_word_lane  = 2'b00;
         endcase

   //------------------------------------------------


   // rd_enable_word - registered version of sel_word_lane.
   //                  required because data phase is one cycle after the
   //                  address phase, therefore we must register the
   //                  word address offset information
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
       begin
         rd_enable_word <= 2'd0;
         rd_endian_swap_now <= 1'b0;
       end

      // hold version of sel_word_lane at end of address phase
      else if (ahbaddph_strobe_descr | ahbaddph_strobe_data)
       begin
         rd_enable_word <= sel_word_lane;
         rd_endian_swap_now <= endian_swap_now;
       end

      // Else default is lane 0 (bits[31:0])
      else if (hready)
       begin
         rd_enable_word <= 2'd0;
         rd_endian_swap_now <= 1'b0;
       end
    end
   //------------------------------------------------


   // hwdata - ahb data output register
   //------------------------------------------------
   always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset) begin
         hwdata <= {128{1'b0}};

      // If we don't own the next data phase zero write data to allow
      // for wired or on system level
      end else if (hready & ~(ahbaddph_strobe_en_descr | ahbaddph_strobe_en_data)) begin
         hwdata <= {128{1'b0}};
      // select correct word lane on the 128 bit bus
      end else if (ahbaddph_strobe_descr | ahbaddph_strobe_data) begin
         case ({dma_bus_width, sel_word_lane})
// Note next 3 case entries are only needed for 128bit AHB mode because endian_swap is tied low for AXI configs

            4'b10_01 :
            begin
              hwdata[127:64] <= dma_data_out_endian[127:64]; // default
              hwdata[31:0]   <= dma_data_out_endian[31:0];   // default
              hwdata[63:32]  <= dma_data_out_endian[31:0];
            end
            4'b10_10 :
            begin
              hwdata[127:96] <= dma_data_out_endian[127:96]; // default
              hwdata[63:0]   <= dma_data_out_endian[63:0];   // default
              hwdata[95:64]  <= dma_data_out_endian[31:0];
            end
            4'b10_11 :
            begin
              hwdata[95:0]   <= dma_data_out_endian[95:0];   // default
              hwdata[127:96] <= dma_data_out_endian[31:0];
            end

            4'b01_01 :
            begin
              hwdata[127:64] <= dma_data_out_endian[127:64]; // default
              hwdata[63:32]  <= dma_data_out_endian[31:0];
              hwdata[31:0]   <= dma_data_out_endian[63:32];
            end
            default : begin
              hwdata  <= dma_data_out_endian;
            end
         endcase
      end

      // Else maintain value
      else begin
         hwdata <= hwdata;
      end
    end
  generate if (p_edma_asf_dap_prot == 1) begin : gen_hwdata_par
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset) begin
         hwprty <= {16{1'b0}};
      end else if (hready & ~(ahbaddph_strobe_en_descr | ahbaddph_strobe_en_data)) begin
         hwprty <= {16{1'b0}};
      end else if (ahbaddph_strobe_descr | ahbaddph_strobe_data) begin
         case ({dma_bus_width, sel_word_lane})
// Note next 3 case entries are only needed for 128bit AHB mode because endian_swap is tied low for AXI configs

            4'b10_01 :
            begin
              hwprty[15:8]   <= dma_prty_out_endian[15:8];   // parity default
              hwprty[3:0]    <= dma_prty_out_endian[3:0];    // parity default
              hwprty[7:4]    <= dma_prty_out_endian[3:0];
            end
            4'b10_10 :
            begin
              hwprty[15:12]  <= dma_prty_out_endian[15:12];  // parity default
              hwprty[7:0]    <= dma_prty_out_endian[7:0];    // parity default
              hwprty[11:8]   <= dma_prty_out_endian[3:0];
            end
            4'b10_11 :
            begin
              hwprty[11:0]   <= dma_prty_out_endian[11:0];  // parity default
              hwprty[15:12]  <= dma_prty_out_endian[3:0];
            end

            4'b01_01 :
            begin
              hwprty[15:8]   <= dma_prty_out_endian[15:8];   // parity default
              hwprty[7:4]    <= dma_prty_out_endian[3:0];
              hwprty[3:0]    <= dma_prty_out_endian[7:4];
            end
            default : begin
              hwprty  <= dma_prty_out_endian;
            end
         endcase
      end

      // Else maintain value
      else begin
         hwprty <= hwprty;
      end
    end
  end else begin : gen_no_hwdata_par
    wire zero;
    assign zero = 1'b0;
    always @(*) hwprty = {16{zero}};
  end
  endgenerate


   //------------------------------------------------


   // tx_dma_data_in_endian - selected input data from AHB. This is transferred
   //                      to both dma_rx and dma_tx blocks via an endian swap
   //------------------------------------------------
   always@(*)
      begin
         dma_data_in_endian  = hrdata; // default
         casex ({dma_bus_width,rd_enable_word,rd_endian_swap_now})

// Note next 7 case entries are only needed for 128bit AHB mode because endian_swap is tied low for AXI configs

            5'b10_01_0 : dma_data_in_endian  = {hrdata[31:0],  hrdata[127:96], hrdata[95:64],  hrdata[63:32]};
            5'b10_10_0 : dma_data_in_endian  = {hrdata[63:32], hrdata[31:0],   hrdata[127:96], hrdata[95:64]};
            5'b10_11_0 : dma_data_in_endian  = {hrdata[95:64], hrdata[63:32],  hrdata[31:0],   hrdata[127:96]};

            5'b10_00_1 : dma_data_in_endian  = {hrdata[63:32],  hrdata[95:64],  hrdata[127:96], hrdata[31:0]}; // Addr 11
            5'b10_01_1 : dma_data_in_endian  = {hrdata[95:64],  hrdata[127:96], hrdata[31:0],   hrdata[63:32]}; // Addr 10
            5'b10_10_1 : dma_data_in_endian  = {hrdata[127:96], hrdata[31:0],   hrdata[63:32],  hrdata[95:64]}; // Addr 01
            5'b10_11_1 : dma_data_in_endian  = {hrdata[31:0],   hrdata[63:32],  hrdata[95:64],  hrdata[127:96]}; // Addr 00


            5'b01_01_x : begin
               dma_data_in_endian[63:32]  = hrdata[31:0];
               dma_data_in_endian[31:0]   = hrdata[63:32];
            end

            default : dma_data_in_endian  = hrdata;
         endcase
      end
   // parity for the dma_data_in_endian
   always@(*)
      begin
         dma_prty_in_endian  = hrdata_prty; // default
         casex ({dma_bus_width,rd_enable_word,rd_endian_swap_now})
            5'b10_01_0 : dma_prty_in_endian  = {hrdata_prty[3:0],  hrdata_prty[15:12],  hrdata_prty[11:8],  hrdata_prty[7:4]};
            5'b10_10_0 : dma_prty_in_endian  = {hrdata_prty[7:4],  hrdata_prty[3:0],    hrdata_prty[15:12], hrdata_prty[11:8]};
            5'b10_11_0 : dma_prty_in_endian  = {hrdata_prty[11:8],  hrdata_prty[7:4],    hrdata_prty[3:0],   hrdata_prty[15:12]};

            5'b10_00_1 : dma_prty_in_endian  = {hrdata_prty[7:4],   hrdata_prty[11:8],  hrdata_prty[15:12], hrdata_prty[3:0]};   // Addr 11
            5'b10_01_1 : dma_prty_in_endian  = {hrdata_prty[11:8],  hrdata_prty[15:12], hrdata_prty[3:0],   hrdata_prty[7:4]}; // Addr 10
            5'b10_10_1 : dma_prty_in_endian  = {hrdata_prty[15:12], hrdata_prty[3:0],   hrdata_prty[7:4],   hrdata_prty[11:8]}; // Addr 01
            5'b10_11_1 : dma_prty_in_endian  = {hrdata_prty[3:0],   hrdata_prty[7:4],   hrdata_prty[11:8],  hrdata_prty[15:12]}; // Addr 00


            5'b01_01_x : begin
               dma_prty_in_endian[7:4]  = hrdata_prty[3:0];
               dma_prty_in_endian[3:0]  = hrdata_prty[7:4];
            end

            default : dma_prty_in_endian  = hrdata_prty;
         endcase
      end
   //------------------------------------------------


   // tx_dma_data_in - byte endian swapped version of read data.
   //               Words are already aligned, so just need to
   //               swap bytes within each 32-bit word.
   //                 byte 0  => byte 3
   //                 byte 1  => byte 2
   //                 byte 2  => byte 1
   //                 byte 3  => byte 0
   //                 byte 4  => byte 7
   //                 byte 5  => byte 6
   //                 byte 6  => byte 5
   //                 byte 7  => byte 4
   //------------------------------------------------
   always @( * )
    begin
      if (rd_endian_swap_now)
       begin

         tx_dma_data_in = {dma_data_in_endian[103:96],
                           dma_data_in_endian[111:104],
                           dma_data_in_endian[119:112],
                           dma_data_in_endian[127:120],
                           dma_data_in_endian[71:64],
                           dma_data_in_endian[79:72],
                           dma_data_in_endian[87:80],
                           dma_data_in_endian[95:88],
                           dma_data_in_endian[39:32],
                           dma_data_in_endian[47:40],
                           dma_data_in_endian[55:48],
                           dma_data_in_endian[63:56],
                           dma_data_in_endian[7:0],
                           dma_data_in_endian[15:8],
                           dma_data_in_endian[23:16],
                           dma_data_in_endian[31:24]};
       end
      else
       begin
         tx_dma_data_in = dma_data_in_endian;
       end
    end
   // the function here is simple databyte reordering
   // and the parity bits should therefore be reordered consistently
   always @( * )
    begin
      if (rd_endian_swap_now)
       begin

         tx_dma_prty_in = {dma_prty_in_endian[12],
                           dma_prty_in_endian[13],
                           dma_prty_in_endian[14],
                           dma_prty_in_endian[15],
                           dma_prty_in_endian[8],
                           dma_prty_in_endian[9],
                           dma_prty_in_endian[10],
                           dma_prty_in_endian[11],
                           dma_prty_in_endian[4],
                           dma_prty_in_endian[5],
                           dma_prty_in_endian[6],
                           dma_prty_in_endian[7],
                           dma_prty_in_endian[0],
                           dma_prty_in_endian[1],
                           dma_prty_in_endian[2],
                           dma_prty_in_endian[3]};
       end
      else
       begin
         tx_dma_prty_in = dma_prty_in_endian;
       end
    end

   //------------------------------------------------

   // htrans encoding
   parameter
      p_htrans_idle   = 2'b00,         // AHB IDLE access
      p_htrans_nseq   = 2'b10,         // AHB NONSEQ access
      p_htrans_seq    = 2'b11;         // AHB SEQ access

   // hsize encoding
   parameter
      p_hsize_32b    = 3'b010,         // AHB 32-bit access
      p_hsize_64b    = 3'b011,         // AHB 64-bit access
      p_hsize_128b   = 3'b100;         // AHB 128-bit access

   // hburst encoding
   parameter
      p_hburst_single  = 3'b000,       // AHB single access
      p_hburst_incr    = 3'b001,       // AHB INCR access
      p_hburst_incr_4  = 3'b011,       // AHB INCR4 access
      p_hburst_incr_8  = 3'b101,       // AHB INCR8 access
      p_hburst_incr_16 = 3'b111;       // AHB INCR16 access


   always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
         hsize <= 3'd0;
      else
         // If we are doing a descriptor writeback or we are in 32 bit mode then
         // do a 32 bit access
         if (dma_state_nxt == DMA_MANWR || dma_bus_width == 2'b00)
            hsize <= p_hsize_32b;
         // 128 bit mode
         else if (dma_state_nxt == DMA_MANRD | dma_bus_width == 2'b01)
            hsize <= p_hsize_64b;
         else
            hsize <= p_hsize_128b;

wire priq_descr_rd_notusedfull;
generate if (p_edma_queues > 32'd1) begin : gen_priq_descr_rd_notusedfull
  assign priq_descr_rd_notusedfull = (~used_bit_read & ~pkt_flush_norep & ~buffullstr_sel);
end else begin : gen_npriq_descr_rd_notusedfull
  assign priq_descr_rd_notusedfull = 1'b1;
end
endgenerate


// In 64b addr mode haddr_descr [63:32] comes from a fixed apb register descr_ptr_msb
generate if (p_gem_dma_addr_w_is_64 == 32'd64) begin : gen_upper_32_addr_bits
  reg [31:0]  haddr_hi;
  reg [31:0]  ahb_data_addr2;
  wire [31:0] tx_dma_burst_addr2;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      haddr_hi <= 32'h00000000;
    else if (hready)
      haddr_hi <= ~gem_dma_addr_w_is_64 ? 32'd0 : tx_dma_burst_addr2;
  end
  assign haddr_descr[63:32]   = ~gem_dma_addr_w_is_64 ? 32'd0 : upper_tx_q_base_addr;
  assign haddr_data[63:32]    = dma_state_data ? haddr_hi : 32'd0;


  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      ahb_data_addr2      <= 32'h00000000;
    else if (~enable_tx_hclk | complete_flush_hclk)
      ahb_data_addr2      <= 32'h00000000;
    else if (dma_state == DMA_MANRD)
    begin
       if ((ahbdataph_strobe_descr & (priq_descr_rd_notusedfull | all_queues_checked) & (|descr_rd_done_dph_cnt)))
         ahb_data_addr2      <= tx_dma_data_in[31:0];
    end
  end
  assign tx_dma_burst_addr2 = (dma_state == DMA_PKTDATA)  ? ahb_data_addr2 :
                                                            status_word_rd_3[31:0]; // upper address bits of BD
end
endgenerate


  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      haddr_lo        <= 32'h00000000;
      htrans          <= p_htrans_idle;
      hburst          <= p_hburst_incr;
      hwrite          <= 1'b0;
      ahb_access_cnt  <= 4'h0;
    end
    else
    begin
      if (hready)
        haddr_lo[31:0]  <= {tx_dma_burst_addr[29:0],2'b00};

      if ((~hbusreq & hready) | ~enable_tx_hclk | complete_flush_hclk)
      begin
        hwrite  <= 1'b0;
        htrans  <= p_htrans_idle;
        hburst  <= p_hburst_incr;
        ahb_access_cnt <= 4'h0;
      end
      else

      case (dma_state)

        DMA_MANRD :
        begin
          ahb_access_cnt <= 4'h0;
          // RULE : Always 2 accesses in 32 bit mode, 2nd is not sequential
          //        even though the 2 accesses are situated next to each other
          //        The first access is the 2nd descriptor
          // RULE : Always 1 access in 64 bit mode
          // RULE : Never breaks 1k boundary, always aligned to 8 byte boundary
          if (hready & hgrant_descr)
          begin
            hwrite  <= 1'b0;
            hburst  <= p_hburst_incr;
            htrans  <= p_htrans_nseq;
          end
          else
          begin // No grant so drive htrans = IDLE
            if (hready)
              htrans  <= p_htrans_idle;
          end
        end

        DMA_MANWR :
        begin
          // RULE : 1 access when not in ext bd mode. 2 or 3 acceses for ext bd mode
          // RULE : Never breaks 1k boundary, always aligned to 8 byte boundary
          //
          if (hready & hgrant_descr)
          begin
            hburst  <= p_hburst_incr;
            hwrite  <= 1'b1;
            htrans  <= p_htrans_nseq;
          end
          else
          begin // No grant so drive htrans = IDLE
            if (hready)
              htrans          <= p_htrans_idle;
          end
        end

        DMA_PKTDATA :
        begin
          if (hready & hgrant_data)
          begin
            if (hresp_notok_eob)
              hburst <= p_hburst_incr;
            else if (brk1kbndry_burst & ahb_access_cnt == 4'h0)
            begin
              casex (bndry1k_acc_size[3:0])
                 4'b00xx : hburst <= p_hburst_incr;   // 0-3 accesses left to 1k boundary
                 4'b01xx : hburst <= p_hburst_incr_4; // 4-7 accesses left to 1k boundary
                 default : hburst <= p_hburst_incr_8; // >= 8 accesses left to 1k boundary
              endcase
            end
            else if (eop_burst & ahb_access_cnt == 4'h0)
            begin
              casex (eop_burst_size[4:0])
                 5'b000xx : hburst <= p_hburst_incr;
                 5'b001xx : hburst <= p_hburst_incr_4;
                 default  : hburst <= p_hburst_incr_8;
              endcase
            end
            else if (ahb_access_cnt == 4'h0)
            begin
              casex (ahb_burst_length[4:0])
                 5'b000xx : hburst <= p_hburst_incr;
                 5'b001xx : hburst <= p_hburst_incr_4;
                 5'b01xxx : hburst <= p_hburst_incr_8;
                 default  : hburst <= p_hburst_incr_16;
              endcase
            end

            hwrite  <= 1'b0;
            if (hresp_notok_eob)
            begin
              htrans <= p_htrans_idle;
              ahb_access_cnt  <= 4'h0;
            end
            else if (ahb_access_cnt == 4'h0)
            begin
              htrans          <= p_htrans_nseq;
              if ((eop_burst_size > 5'h01 | ~eop_burst) & ~breaks_1k_boundary)
                ahb_access_cnt  <= ahb_access_cnt + 4'h1;
            end
            else if (last_access_burst_req)
            begin
              htrans          <= p_htrans_seq;
              ahb_access_cnt  <= 4'h0;
            end
            else
            begin
              htrans          <= p_htrans_seq;
              ahb_access_cnt  <= ahb_access_cnt + 4'h1;
            end
          end
          else
          begin // No grant so drive htrans = IDLE and restart ahb_access_cnt
            if (hready)
            begin
              ahb_access_cnt  <= 4'h0;
              htrans          <= p_htrans_idle;
            end
          end
        end

      default :
        begin
          hwrite  <= 1'b0;
          htrans  <= p_htrans_idle;
          hburst  <= p_hburst_incr;
          ahb_access_cnt <= 4'h0;
        end

      endcase
    end
  end
  assign last_access_burst_req =
                    ((eop_burst & eop_burst_size == 5'h01) |
                      breaks_1k_boundary |
                     ({1'b0,ahb_access_cnt} == ahb_burst_length-5'd1) |
                     (hburst == p_hburst_incr_16 & ahb_access_cnt == 4'hf) |
                     (hburst == p_hburst_incr_8 & ahb_access_cnt == 4'h7)  |
                     (hburst == p_hburst_incr_4 & ahb_access_cnt == 4'h3)  |
                    ((~(|ahb_burst_length[4:2])) & (buffer_full | pkt_needs_writeback)));

  // brk1kbndry_burst will be set if the upcoming burst will break the
  //                      1K AHB address boundary.

  // Convert ahb_burst_length to a mask to make it easier to select
  // correct bits for 1K boundary address comparison
  // Note that by this stage ahb_burst_length is one-hot.
  always @ ( * )
  begin
    case (dma_bus_width)
       2'b00  : begin // 32-bit wide access
                 ahb_burst_maskh = {3'b111,
                                    |(ahb_burst_length[4:0]),
                                    |(ahb_burst_length[3:0]),
                                    |(ahb_burst_length[2:0]),
                                    |(ahb_burst_length[1:0]),
                                    ahb_burst_length[0]};
                 end

       2'b01     : begin // 64-bit wide access
                 ahb_burst_maskh = {2'b11,
                                    |(ahb_burst_length[4:0]),
                                    |(ahb_burst_length[3:0]),
                                    |(ahb_burst_length[2:0]),
                                    |(ahb_burst_length[1:0]),
                                    ahb_burst_length[0],
                                    1'b0};
                 end
       default   : begin // 128-bit wide access
                 ahb_burst_maskh = {1'b1,
                                    |(ahb_burst_length[4:0]),
                                    |(ahb_burst_length[3:0]),
                                    |(ahb_burst_length[2:0]),
                                    |(ahb_burst_length[1:0]),
                                    ahb_burst_length[0],
                                    2'b00};
                 end

    endcase
  end

   assign brk1kbndry_burst =
                // Full 16beat burst will cross the 1k boundary
                 ((((tx_dma_burst_addr[7:0] &  ahb_burst_maskh) == ahb_burst_maskh) &
                   ((tx_dma_burst_addr[7:0] & ~ahb_burst_maskh) != 8'h00))

                // If PKT will end before reaching the 1k boundary ...
                 & ~(eop_burst & (eop_burst_size < {1'b0,bndry1k_acc_size})));

  // Calculate the number of accesses before 1k boundary
  always @(*)
  begin
    casex (tx_dma_burst_addr[3:0])
      4'b0xxx,4'b1000         : bndry1k_acc_size_32 = 4'd8;
      4'b1101,4'b1110         : bndry1k_acc_size_32 = 4'd2;
      4'b1111                 : bndry1k_acc_size_32 = 4'd1;
      default                : bndry1k_acc_size_32 = 4'd4;
    endcase
  end

  always @(*)
  begin
    casex (tx_dma_burst_addr[4:1])
      4'b0xxx,4'b1000         : bndry1k_acc_size_64 = 4'd8;
      4'b1101,4'b1110         : bndry1k_acc_size_64 = 4'd2;
      4'b1111                 : bndry1k_acc_size_64 = 4'd1;
      default                : bndry1k_acc_size_64 = 4'd4;
    endcase
  end

  always @(*)
  begin
    casex (tx_dma_burst_addr[5:2])
      4'b0xxx,4'b1000         : bndry1k_acc_size_128 = 4'd8;
      4'b1101,4'b1110         : bndry1k_acc_size_128 = 4'd2;
      4'b1111                 : bndry1k_acc_size_128 = 4'd1;
      default                : bndry1k_acc_size_128 = 4'd4;
    endcase
  end

  assign bndry1k_acc_size = dma_bus_width[1] == 1'b1 ? bndry1k_acc_size_128 :
                            dma_bus_width == 2'b01 ? bndry1k_acc_size_64
                                                   : bndry1k_acc_size_32;

   // breaks_1k_boundary should be set only on the
   assign breaks_1k_boundary = dma_bus_width[1] == 1'b1
                               ? (tx_dma_burst_addr[7:1] == 7'b1111110)
                               : (tx_dma_burst_addr[7:0] == {7'b1111111,~dma_bus_width[0]});



  assign hbusreq_descr    = ~dma_state_data ? hbusreq : 1'b0;
  assign hlock_descr      = 1'b0;
  assign hburst_descr     = ~dma_state_data ? hburst  : 3'b001;
  assign htrans_descr     = ~dma_state_data ? htrans  : 2'b00;
  assign hsize_descr      = ~dma_state_data ? hsize   : 3'b010;
  assign haddr_descr[31:0]= ~dma_state_data ? haddr_lo : 32'h00000000;
  assign hwrite_descr     = ~dma_state_data ? hwrite  : 1'b0;
  assign hprot_descr      = p_edma_hprot_value;
  assign hwdata_descr     = ~dma_state_data ? hwdata  : 128'd0;

  assign hbusreq_data     = dma_state_data ? hbusreq  : 1'b0;
  assign hlock_data       = 1'b0;
  assign hburst_data      = dma_state_data ? hburst   : 3'b001;
  assign htrans_data      = dma_state_data ? htrans   : 2'b00;
  assign hsize_data       = dma_state_data ? hsize    : 3'b010;
  assign haddr_data[31:0] = dma_state_data ? haddr_lo : 32'h00000000;
  assign hwrite_data      = 1'b0;
  assign hprot_data       = p_edma_hprot_value;
  assign hwdata_data      = dma_state_data ? hwdata   : 128'd0;


  // ----------------------------------------------------------------------------
  // End of AHB Interface Logic

  // Signal used to trigger the start of TX DMA process is callued
  // tx_dma_start pulse.  This can be set by writing a '1' to the tx_start
  // bit in the APB addressable register (tx_start_hclk_pulse) or
  // when the async input trigger_dma_tx_start is toggled.
  // First sync trigger_dma_tx_start to AHB clock

  edma_sync_toggle_detect i_edma_sync_toggle_detect_trigger_dma_tx_start (
    .clk(hclk),
    .reset_n(n_hreset),
    .din(trigger_dma_tx_start),
    .rise_edge(),
    .fall_edge(),
    .any_edge(hw_dma_tx_start));

  // Then simply OR the software and the hardware versions together to
  // allow the user to use either method to initiate TX DMA traffic ...
  assign tx_dma_start = hw_dma_tx_start | tx_start_hclk_pulse;




  // Halt DMA operation after all frames in system have completed.
  // Once halted, the DMA operation can only restart when the start
  // bit is written to
  // Conditions that can cause the DMA to halt are ...
  //  1) when the software writes to the HALT bit
  //  2) When a serious error condition occurs (like hresp,
  //     or used bit read, or dpram overflow)
  //  3) When a MAC underflow occurs
  //
  // If the DMA has been halted due to a major error, then
  // only allow a restart once the full DMA and MAC pipeline has
  // been cleared.  Otherwise, allow a restart as soon as the start bit
  // is written to
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      halt_pkt_buf_wr <= 1'b1;
    end
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
        halt_pkt_buf_wr <= 1'b1;
      else if (   (tx_halt_hclk)    |
                  (pkt_flush_report & ~tx_dma_start & ~tx_dma_start_pending)  | // ETH-198 Fix
                  (underflow_frame_hclk)
              )
        halt_pkt_buf_wr <= 1'b1;
      else if (tx_dma_start) // ETH-198 Fix
        halt_pkt_buf_wr <= 1'b0;
    end
  end

  // ETH-198 Fix
  // The purpose of the tx_dma_start_pending register is to store any new
  // start transmission requests that are rececieved while descriptors
  // are currently being read. This new register has been added to address
  // Jira issue ETH-198, where deterministic latency was needed between
  // raising a start transmission request and the frame transmission. Without
  // the fix the design would ignore a start transmission request when descriptors
  // were currently being read. With this fix descriptors are re-read if a start
  // transmission is requested while descriptors are currently being read. See
  // ETH-198 for further details.

  always@(posedge hclk or negedge n_hreset)
    if (~n_hreset)
      tx_dma_start_pending <= 1'b0;
    else
      if (~enable_tx_hclk | complete_flush_hclk)
        tx_dma_start_pending <= 1'b0;
      else if (tx_dma_start && dma_state == DMA_MANRD)
        tx_dma_start_pending <= 1'b1;
      else if (dma_state != DMA_MANRD)
        tx_dma_start_pending <= 1'b0;

  // new_write_allowed is used to identify when it is safe to read a
  // new packet descriptor
  //
  // It can only be set if there is halt_pkt_buf_wr is LOW and if we not in
  // the middle of a multi-buffer frame.  It is also gated out if the
  // packet buffer itself is full or if the main state machine is busy
  // processing a different packet and cant look at it yet

  always @( * )
  begin
    if (halt_pkt_buf_wr & buf_has_eop)
      new_write_allowed  = 1'b0;

    // The maximum number of pkts (8'hff) are in the packet buffer
    else if (&num_pkts_in_buf)
      new_write_allowed  = 1'b0;

    // The DPRAM is full
    else if (set_dpram_region_full)
      new_write_allowed  = 1'b0;

    // Cannot start reading a new packet descriptor if in DMA_PKTINFO state
    // (Although we can do this if we are in the last cycle of DMA_PKTINFO
    //  and there is no writeback request)
    else if ((dma_state == DMA_PKTINFO) & (~dma_pktstatus_done |
                                           pkt_needs_writeback))
      new_write_allowed  = 1'b0;

    // Cannot start reading a new packet descriptor if in DMA_MANWR state
    // (Although we can do this if we are in the last cycle of DMA_MANWR
    //  and there is no further writeback request pending)
    else if (dma_state == DMA_MANWR & ~all_manwr_done)
      new_write_allowed  = 1'b0;

    // Cannot start reading a new packet descriptor if IDLE and about to do
    // a writeback
    else if ((dma_state == DMA_IDLE) & pkt_needs_writeback)
      new_write_allowed  = 1'b0;

    else
      new_write_allowed  = 1'b1;

  end


  // Combine all error events that will require a complete flush of the TX FIFO.
  // Do flush once PCLK update complete (also means writeback has completed).
  // OLD CODE =
  //assign complete_flush_hclk = (late_coll_occ_hclk | underflow_frame_hclk |
  //                             too_many_retry_hclk) & status_captured;
  // NEW CODE =
  assign complete_flush_hclk = underflow_frame_hclk & status_captured;


  // Create some state identifier signals ...
  assign dma_state_man_rd = (dma_state      == DMA_MANRD);
  assign dma_next_man_rd  = (dma_state_nxt  == DMA_MANRD);
  assign dma_state_man_wr = (dma_state      == DMA_MANWR);




  // dma_state_data was combinatorial before but was registered to
  // resolve timing issues going to the external AXI data bus - i.e.
  // the state machine state has a combinatorial path directly toA
  // awaddr, etc
  always@(posedge hclk or negedge n_hreset)
    if (~n_hreset)
      dma_state_data <= 1'b0;
    else
      if (~enable_tx_hclk | complete_flush_hclk)
        dma_state_data <= 1'b0;
      else
        dma_state_data <= dma_state_nxt == DMA_PKTDATA;

  // In 32 bit mode, 2 AHB reads are required to obtain the buffer descriptors
  // Just 1 access is required when in 64 bit mode
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      descr_rd_done_rph     <= 1'b0;
      descr_rd_done_dph     <= 1'b0;
      descr_rd_done_rph_cnt <= 4'h0;
      descr_rd_done_dph_cnt <= 4'h0;
    end
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
      begin
        descr_rd_done_rph   <= 1'b0;
        descr_rd_done_dph   <= 1'b0;
        descr_rd_done_rph_cnt <= 4'h0;
        descr_rd_done_dph_cnt <= 4'h0;
      end

      // For 32bit, there are a minimum of 4 AHB cycles
      // while in the DMA_MANRD state
      // This is the only state where accesses do NOT cross
      // into other states
      //   1) 1st AHB reqphase
      //   2) 2nd reqphase, 1st addphase
      //   3) No reqphase, 2nd addphase, 1st dataphase
      //   4) No reqphase, no addphase, 2nd dataphase
      else if (~dma_state_man_rd & dma_next_man_rd)
      begin
        descr_rd_done_rph <= (descriptor_rd_1_access);
        descr_rd_done_dph <= 1'b0;
        descr_rd_done_rph_cnt <= 4'h0;
        descr_rd_done_dph_cnt <= 4'h0;
      end
      else
      begin
        if (~dma_state_man_rd)
        begin
          descr_rd_done_rph <= 1'b0;
          descr_rd_done_rph_cnt <= 4'h0;
        end

        // descr_rd_done_rph is always set if the descriptor read can 128 done in 1 access
        else if (descriptor_rd_1_access)
          descr_rd_done_rph <= 1'b1;

        else if (ahbreqph_strobe_descr)
        begin
          if (descr_rd_done_rph)  // for priority queues we need to reset cnt at end of each access
                                  // otherwise it inc thro all read accesses
            descr_rd_done_rph_cnt <= 4'h0;
          else
            descr_rd_done_rph_cnt <= descr_rd_done_rph_cnt + 4'h1;

          // 2 man rd accesses
          if (descriptor_rd_2_access)
            descr_rd_done_rph <= ~descr_rd_done_rph;
          else   // 3 man rd accesses
            descr_rd_done_rph <= descr_rd_done_rph_cnt == 4'h1;    // set done after the 2nd access (so it is high on the 3rd)
        end


        if (~dma_state_man_rd)
        begin
          descr_rd_done_dph <= 1'b0;
          descr_rd_done_dph_cnt <= 4'h0;
        end

        // descr_rd_done_dph is always set if the descriptor read can 128 done in 1 access
        else if (descriptor_rd_1_access)
          descr_rd_done_dph <= 1'b1;

        else if (ahbdataph_strobe_descr)
        begin
          if (descr_rd_done_dph)  // for priority queues we need to reset cnt at end of each access
                                  // otherwise it inc thro all read accesses
            descr_rd_done_dph_cnt <= 4'h0;
          else
            descr_rd_done_dph_cnt <= descr_rd_done_dph_cnt + 4'h1;

          // 2 man rd accesses
          if (descriptor_rd_2_access)
            descr_rd_done_dph <= ~descr_rd_done_dph;

          else  // 3 man rd accesses
            descr_rd_done_dph <= descr_rd_done_dph_cnt == 4'h1; // set done after the 2nd access (so it is high on the 3rd)
        end
      end
    end
  end

//Set queue pointers ...
parameter p_edma_queue_idx = p_edma_queues-1;
generate if (p_edma_queues > 32'd1) begin : gen_set_queue_ptrs

  reg   [3:0] queue_ptr_rph_r;
  reg   [3:0] queue_ptr_dph_r;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      queue_ptr_rph_r         <= p_edma_queue_idx[3:0];
      queue_ptr_dph_r         <= p_edma_queue_idx[3:0];
      block_descr_rd        <= 1'b0;
    end
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
      begin
        queue_ptr_rph_r   <= p_edma_queue_idx[3:0];
        queue_ptr_dph_r   <= p_edma_queue_idx[3:0];
        block_descr_rd  <= 1'b0;
      end

      // For 32bit, there are a minimum of 4 AHB cycles
      // while in the DMA_MANRD state
      // This is the only state where accesses do NOT cross
      // into other states
      //   1) 1st AHB reqphase
      //   2) 2nd reqphase, 1st addphase
      //   3) No reqphase, 2nd addphase, 1st dataphase
      //   4) No reqphase, no addphase, 2nd dataphase
      else if (~dma_state_man_rd & dma_next_man_rd)
      begin
        block_descr_rd  <= 1'b0;
        queue_ptr_dph_r   <= queue_ptr_dph;
        if (buf_has_eop)
          // If this is the first buffer of the frame, then the man rd's will always start at
          // the highest queue
          queue_ptr_rph_r   <= tx_top_q_id;
        else
          // Reload the queue information back into queue_ptr_rph for wrapping frames
          queue_ptr_rph_r   <= queue_ptr_dph;
      end
      else
      begin
        if (dma_state_man_rd & ahbreqph_strobe_descr & descr_rd_done_rph )
        begin
          if (first_buffer_of_pkt)
          begin
            if (queue_ptr_rph == 4'h0)
              block_descr_rd  <= 1'b1;
            else
              queue_ptr_rph_r <= queue_ptr_rph_r - 4'h1;
          end
          else
            block_descr_rd  <= 1'b1;
        end

        if (dma_state_man_rd & ~manrd_done & ahbdataph_strobe_descr &
            descr_rd_done_dph &
            (used_bit_read | pkt_flush_norep | buffullstr_sel))
        begin
          if (first_buffer_of_pkt & queue_ptr_dph != 4'h0)
            queue_ptr_dph_r <= queue_ptr_dph_r - 4'h1;
        end
        // Reset queue_ptr_dph to the highest queue if we are not wrapping, and the queue_ptr_rph
        // has already been reset to the top
        else if (dma_state_man_rd & ahbreqph_strobe_descr & first_buffer_of_pkt & queue_ptr_rph == tx_top_q_id)
          queue_ptr_dph_r <= tx_top_q_id;
      end

    end
  end
  assign queue_ptr_dph = queue_ptr_dph_r;
  assign queue_ptr_rph = queue_ptr_rph_r;

  reg   [3:0] queue_being_read_r;
  reg         queue_being_read_vld_r;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      queue_being_read_r      <= 4'h0;
      queue_being_read_vld_r  <= 1'b0;
    end
    else if (~dma_state_man_rd) // ETH-202 Fix
    begin
      if (part_pkt_read_edge)
      begin
        queue_being_read_r      <= part_pkt_queue;
        queue_being_read_vld_r  <= 1'b1;
      end
      else if (full_pkt_read_edge)
        queue_being_read_vld_r  <= 1'b0;
    end
  end
  assign queue_being_read         = queue_being_read_r[3:0];
  assign queue_being_read_vld     = queue_being_read_vld_r;

  assign queue_being_read_manwr   = nxt_xfer_status_bus[77:74];
  assign queue_being_written      = queue_ptr_dph;

end else begin : gen_notspecific_ahb
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      block_descr_rd <= 1'b0;
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
        block_descr_rd <= 1'b0;
      else if (~dma_state_man_rd & dma_next_man_rd)
        block_descr_rd  <= 1'b0;
      else if (dma_state_man_rd & ahbreqph_strobe_descr & descr_rd_done_rph )
        block_descr_rd  <= 1'b1;
    end
  end
  assign queue_ptr_rph          = 4'h0;
  assign queue_ptr_dph          = 4'h0;
  assign queue_being_read       = 4'h0;
  assign queue_being_read_vld   = 1'b0;
  assign queue_being_read_manwr = 4'd0;
  assign queue_being_written    = 4'd0;
end
endgenerate


    // for MANWR
    // Detect the address strobe on the final man write
    // Count ahbaddph_strobe_descr and ahbaddph_strobe_descr
    //
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      manwr_astrobe_end   <= 1'b0;
      descr_wr_reqph_cnt     <= 4'h0;
      descr_wr_addph_cnt     <= 4'h0;
    end
    else if (~dma_state_man_wr | manwr_done)
    begin
      manwr_astrobe_end   <= 1'b0;
      descr_wr_reqph_cnt     <= 4'h0;
      descr_wr_addph_cnt     <= 4'h0;
    end
    else
    begin
      if (ahbaddph_strobe_descr)
      begin
        descr_wr_addph_cnt <= descr_wr_addph_cnt + 4'h1;
        if (descr_wr_addph_cnt == NO_OF_MAN_WR_ACCESS)
          manwr_astrobe_end <= 1'b1;
      end
      if (ahbreqph_strobe_descr)
      begin
        descr_wr_reqph_cnt <= descr_wr_reqph_cnt + 4'h1;
      end
    end
  end


  // Identify when the Status and the TCP/IP checksums have been fully
  // updated in the DPRAM
  // If we dont need to insert the TCP or IP checksums, then
  // this state can end earlier than it would otherwise have to
  // This event occurs when state_cnt == 3 for 32 bit mode or 2
  // when operating in 64 bit mode
  // otherwise, it ends when state_cnt == 5
  assign dma_pktstatus_done =
                              (state_cnt == 3'b101 |
                              (state_cnt == 3'b011 & err_status[0]) |
                              ~((tcp_hdr_cs_we & generate_tcp_csum) |
                                 (ip_hdr_cs_we & generate_ip_csum)) &
                                  (state_cnt == 3'b011 |
                                  (state_cnt == 3'b010 & dma_bus_width[0])));


  // The Main DMA State Machine ...
  // This implements the flow required to perform DMA scatter
  // gather algorithms.  For each buffer read, there is a descriptor
  // read state which holds information relating to the location and
  // length of the buffer to be read from external memory into DPRAM. This
  // buffer may be a full packet or just a fragment of one. Once
  // the buffer has been fetched and written into DPRAM, the desctipor
  // is written back with a status so that the external software
  // driver has visibility
  // To optimize performance, this states in this state machine are
  // active in-line with the request phase of the AHB access.
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      dma_state  <= DMA_IDLE;
      last_dma_state <= DMA_IDLE;
    end
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
      begin
        dma_state  <= DMA_IDLE;
        last_dma_state <= DMA_IDLE;
      end
      else
      begin
        dma_state  <= dma_state_nxt;
        last_dma_state <= dma_state;
      end
    end
  end

wire priq_dma_state_usedfull;
generate if (p_edma_queues > 32'd1) begin : gen_priq_dma_state_usedfull
  assign priq_dma_state_usedfull = ((used_bit_read | pkt_flush_norep | buffullstr_sel) & ahbdataph_strobe_descr);
end else begin : gen_npriq_dma_state_usedfull
  assign priq_dma_state_usedfull = 1'b0;
end
endgenerate


  always @( * )
  begin
    cutthru_status_word_push = 1'b0;
    case (dma_state)

      DMA_MANRD:  // Descriptor read
      begin
        // if there is a problem with the AHB descriptor read, move
        // to write any status we know about this packet to the DPRAM
        // so that an interrupt can be generated in the future (in
        // the correct pkt order)
        if (pkt_flush_report)
          dma_state_nxt = DMA_PKTINFO;

        // valid read detected
        else if (manrd_done & (~ahbaddph_strobe_en_descr | all_queues_checked | ahbaddph_strobe_descr))
        begin
          if (zero_len_buf)
            dma_state_nxt = DMA_IDLE;
          else if (pkt_needs_writeback & all_queues_checked)
            dma_state_nxt = DMA_MANWR;
          else
            dma_state_nxt = DMA_PKTDATA;
        end

        // If a used bit was read, or the dpram region for this particular queue
        // is full, then move onto the next queue
        else if (priq_dma_state_usedfull & ~all_queues_checked)
            dma_state_nxt = DMA_MANRD;  // repeat the state until all queues have been checked
        else if (priq_dma_state_usedfull)
            dma_state_nxt = DMA_IDLE;

        else
          dma_state_nxt = DMA_MANRD;
      end

      DMA_PKTDATA :    // Write to DPRAM with Buffer contents
      begin
        if (pkt_flush_report)
          dma_state_nxt = DMA_PKTINFO;
        else if (pkt_flush_norep)
          dma_state_nxt = DMA_IDLE;
        else if (buffer_written_pluspad & ahbdataph_strobe_data)
        begin
          if (buf_has_eop)
            dma_state_nxt = DMA_PKTINFO;
          else // This is a multi-buffer frame, so go get next descriptor
            dma_state_nxt = DMA_MANRD;
        end
        // Break Data state at the end of current burst if we need to do
        // a writeback.
        // To simplify the storing of dpram addresses and number of dpram
        // accesses remaining when we jump to DMA_MANWR, always
        // ensure at least 1 burst gets through - since hbusreq
        // is a register, this means we cant jump immediately in cycle 0
        // of this state to DMA_MANWR
        // Note we must gate in  tx_last_data_ph here, to ensure the state
        // change only happens once all the data from this burst has been captured
        // brkdatabuf_full_data already takes this into account
        else if ((break_data_wback & tx_last_data_ph) |
                 (pkt_needs_writeback &
                   (brkdatabuf_full_data |
                   (~hbusreq & ~ahbaddph_strobe_en_data & ~ahbdataph_strobe_en_data))))
          dma_state_nxt = DMA_MANWR;
        else
          dma_state_nxt = DMA_PKTDATA;
      end

      DMA_PKTINFO :    // Perform TCP Offload checksum writeback and write PKT status
      begin
        if (dma_pktstatus_done)
        begin
          if (pkt_needs_writeback)
            dma_state_nxt = DMA_MANWR;
          else if (new_write_allowed)
            dma_state_nxt = DMA_MANRD;
          else
            dma_state_nxt = DMA_IDLE;
          // If we are in cut-thru mode and the current frame size is greater
          // than half of the buffer size then push the status words to the
          // cutthru status_word FIFO.
          if ({5'h00,status_word_wr_0[11:0]} > {{(17-p_edma_tx_pbuf_addr){1'b0}},
                                                (TX_PBUF_MAX_FILL_LVL_ARRAY[queue_ptr_dph]>>1)})
             cutthru_status_word_push = tx_cutthru;
        end
        else
          dma_state_nxt = DMA_PKTINFO;
      end

      DMA_MANWR:  // Perform writeback
      begin
        if (manwr_done)
        begin
          if (~all_manwr_done)
            dma_state_nxt = DMA_MANWR;
          else if (revert_to_data)
            dma_state_nxt = DMA_PKTDATA;
          else if (new_write_allowed)
            dma_state_nxt = DMA_MANRD;
          else
            dma_state_nxt = DMA_IDLE;
        end
        else
          dma_state_nxt = DMA_MANWR;
      end

      default :
      begin
        if (pkt_needs_writeback)
          dma_state_nxt  = DMA_MANWR;
        else
        if (new_write_allowed)
          dma_state_nxt  = DMA_MANRD;
        else
          dma_state_nxt  = DMA_IDLE;
      end
    endcase
  end


  // The following calculates the number of AHB accesses required for the
  // current buffer being read.  This must take into
  // account the initial alignment and the number of bytes required to xfer
  always @(*)
  begin
    case (tx_dma_data_in[1:0])  // alignment address (combinatorial)
    2'b00     : // 4 bytes of data avaliable at address
    begin
      num_words_al_32   = {1'h0,descr_len_field[13:2]} +
                          {12'h000,|descr_len_field[1:0]};
    end
    2'b01     : // 3 bytes of data avaliable at initial address
    begin
      num_words_al_32   = {1'h0,descr_len_field[13:2]} + 13'h0001;
    end
    2'b10     : // 2 bytes of data avaliable at initial address
    begin
      if (descr_len_field[1:0] == 2'b11)
        num_words_al_32 = {1'h0,descr_len_field[13:2]} + 13'h0002;
      else
        num_words_al_32 = {1'h0,descr_len_field[13:2]} + 13'h0001;
    end
    default   : // Only 1 byte of data avaliable at initial address
    begin
      if (descr_len_field[1])
        num_words_al_32 = {1'h0,descr_len_field[13:2]} + 13'h0002;
      else
        num_words_al_32 = {1'h0,descr_len_field[13:2]} + 13'h0001;
    end
    endcase
  end

  always @(*)
  begin
    case (alignment_addr[2:0])  // alignment address (combinatorial)
    3'b000     : // 8 bytes of data avaliable
    begin
      num_words_al_64 = {2'h0,descr_len_field[13:3]} +
                        {12'h000,|descr_len_field[2:0]};
    end
    3'b001     : // 7 bytes of data avaliable
    begin
      num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0001;
    end
    3'b010     : // 6 bytes of data avaliable
    begin
      if (descr_len_field[2:0] == 3'b111)
        num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0002;
      else
        num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0001;
    end
    3'b011   : // 5 bytes of data avaliable
    begin
      if (descr_len_field[2:1] == 2'b11)
        num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0002;
      else
        num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0001;
    end
    3'b100   : // 4 bytes of data avaliable
    begin
      if ((descr_len_field[2:1] == 2'b11) |(descr_len_field[2:0] == 3'b101))
        num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0002;
      else
        num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0001;
    end
    3'b101   : // 3 bytes of data avaliable
    begin
      if (descr_len_field[2] == 1'b1)
        num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0002;
      else
        num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0001;
    end
    3'b110   : // 2 bytes of data avaliable
    begin
      if (descr_len_field[2] | (descr_len_field[1:0] == 2'b11))
        num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0002;
      else
        num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0001;
    end
    default   : // 1 byte of data avaliable
    begin
      if (descr_len_field[2] | descr_len_field[1])
        num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0002;
      else
        num_words_al_64 = {2'h0,descr_len_field[13:3]} + 13'h0001;
    end
    endcase
  end

  // Calculate the number of words needed for 128 bit mode.

  assign descr_len_field_minus1 = descr_len_field - 14'd1;

  // Calucate if the lower bits of the descriptor lenght field, plus
  // the address alignments passes into the next 128 bit word. If this
  // is the case we add 1 to the total number of words needing read.
  assign num_words_plus1_sum = {1'b0,alignment_addr} + ((descr_len_field[4:0]-5'd1) & 5'b01111);
  assign num_words_al_128 = descr_len_field_minus1[13:4] + 14'd1 + num_words_plus1_sum[4];

  assign num_words_al = dma_bus_width[1] == 1'b1 ? num_words_al_128 :
                        dma_bus_width == 2'b01 ? num_words_al_64  :
                                                 num_words_al_32  ;


  // Detect an error occuring in the descr rd state that must result in us
  // doing a writeback sometime later.
  // This will be used to write to the error bit in the status field
  // Valid errors are :
  //    used bit read on first buffer (no writeback needed for these)
  //    used bit read or zero length buffer with the END set - exh mid_frame
  //    AHB errors
  //
  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      err_status <= 4'b0000;
      err_d1 <= 1'b1;
    end

    else
    begin
      err_d1 <= err_status[3];
      if (~enable_tx_hclk | complete_flush_hclk)
        err_status <= 4'b0000;

      else if (dma_state == DMA_MANRD & ahbdataph_strobe_descr)
      begin
        if (hresp_notok_eob)
        begin
          err_status[2:0] <= 3'b010;   //
          err_status[3]   <= ~tx_cutthru | first_buffer_of_pkt;
        end
        else if (~first_buffer_of_pkt &
                ((used_bit_read) |
                 (zero_len_buf_en & ~used_bit_read & descr_rd_done_dph)))
        begin
          err_status[2:0] <= 3'b100;   // Exhausted mid frame
          err_status[3]   <= ~tx_cutthru;
        end
        else if (used_bit_read & all_queues_checked & used_bit_read_all)
        begin
          err_status[2:0] <= 3'b001;   // resource error
          err_status[3]   <= ~tx_cutthru | first_buffer_of_pkt;
        end
        else if (~descr_rd_done_dph)
        begin
          err_status[3:0] <= 4'b0000;
        end
      end

      else if (dma_state == DMA_PKTDATA & ahbdataph_strobe_data)
      begin
        if (hresp_notok_eob)
        begin
          err_status[2:0] <= 3'b010;
          err_status[3]   <= ~tx_cutthru;
        end
        else if (buffer_full_err & ~ahbaddph_strobe_data)
        begin
          err_status[2:0] <= 3'b100;
          err_status[3]   <= 1'b1;
        end
        else
          err_status <= 4'b0000;
      end

      else if (writing_status_dpram)
        err_status <= 4'b0000;
    end
  end


  // In the descriptor writeback state, there are 2 actions.
  //  1) Generate an interrupt using the interrupt interface protocol
  //  2) If an actual AHB writeback is required, then perform an AHB write
  //     to the original descriptor location
  // This signal is set immediately if no actual AHB writeback is required
  // or when the AHB access is complete. A writeback is not required in this
  // state if there has been a used bit read on the first buffer of a packet
  assign manwr_done = (status_word_rd_0[14] | ahbdataph_strobe_descr_wr_done);
  assign ahbdataph_strobe_descr_wr_done = (~gem_dma_addr_w_is_64 & ~tx_bd_extended_mode_en) ? ahbdataph_strobe_descr_wr : ahbdataph_strobe_descr_wr & manwr_astrobe_end;


  // Generate AHB request
  // To maximize efficiency, we must drive the bus requests as early
  // as we possibly can

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      hbusreq <= 1'b0;
      full_pkt_read_edge_d1 <= 1'b0;
    end
    else
    begin
      full_pkt_read_edge_d1 <= full_pkt_read_edge & manwr_done;

      if (~enable_tx_hclk  | complete_flush_hclk |
           underflow_reqph | underflow_addph)
      begin
        hbusreq <= 1'b0;
      end
      else
      begin
        case (dma_state_nxt)

        DMA_MANRD :
        begin
          if (dma_state != DMA_MANRD)
            hbusreq <= 1'b1;
          // for 32 bit mode, cancel hbusreq as soon as we find a valid queue -
          // this will ensure
          // only 1 dummy read access is performed after a valid queue
          else if (first_buffer_of_pkt & p_edma_queues > 32'd1)
          begin
            // Found a valid queue
            if  (~used_bit_read_regc & descr_rd_done_dph_cnt == 4'h0 &
                 (~buffer_full |
                  ((queue_ptr_dph == queue_being_read) & queue_being_read_vld)) &

                  ahbdataph_strobe_descr & ~buffullstr_sel)
              hbusreq <= 1'b0;
            // Still looking for a valid queue
            else if (queue_ptr_rph != 4'h0 & hbusreq)
              hbusreq <= 1'b1;
            // Checked all queues ...
            else if (descr_rd_done_rph & ahbreqph_strobe_descr)
              hbusreq <= 1'b0;
          end
          // descr_rd_done_rph is used to indicate last word read and de-asset hbusreq
          else if (descr_rd_done_rph & ahbreqph_strobe_descr)
            hbusreq <= 1'b0;
        end

        DMA_PKTDATA :
        begin
          // If we have all the pkt data we need, then hbusreq can always go low
          if (reading_pad_rph & ahbreqph_strobe_data & last_access_burst_req)
            hbusreq <= 1'b0;

          else if (num_requests[11:1] == 11'h000 & ahbreqph_strobe_data &
                   ~pad_remaining_burst & ~reading_pad_rph)
            hbusreq <= 1'b0;

          else if (num_requests[11:0] == 12'h000)
            hbusreq <= hbusreq;

          // hbusreq must be broken if we want to break data accesses
          // in order to complete a writeback.  This wont break the burst -
          // it will complete the burst first
          else if (((pkt_needs_writeback | buffer_full) &
                    (~hbusreq |
                    (last_access_burst_req & hgrant_data & ahbreqph_strobe_data))) |
                     break_data_wback | brkdatabuf_full_add)

            hbusreq <= 1'b0;

          else
            hbusreq <= 1'b1;
        end

        DMA_MANWR:
        begin
          // Entry into MANWR state- drive hbusreq only if we need to do an AHB write
          if (dma_state != DMA_MANWR)
            hbusreq <= ~status_word_rd_0[14];

          // End of a single manwr.  If there is another manwr pending
          // then drive hbusreq only if we need to do an AHB write
          // Note that if there is more manwr's to perform, then
          // we need to look at nxt_xfer_status_bus2, not nxt_xfer_status_bus
          // (which gets mapped into status_word_rd_0
          else if (manwr_done & ~all_manwr_done & ~full_pkt_read_edge & ~nxt_xfer_status_bus2[14])
            hbusreq <= 1'b1;

          // After full_pkt_read_edge_d1 the status words have always been
          // updated when the original manwr_done occured. As such our next
          // writeback status is always in status_word_rd_0 already regardless
          // of how many writebacks are pending.
          else if (full_pkt_read_edge_d1)
            hbusreq <= ~status_word_rd_0[14];

          else
           if (~gem_dma_addr_w_is_64 & ~tx_bd_extended_mode_en)
             begin
               if (hgrant_descr & hready)
                hbusreq <= 1'b0;
             end
           else
             if (descr_wr_reqph_cnt == NO_OF_MAN_WR_ACCESS )  // 1 less than no of accesses needed
               begin
                 if (ahbreqph_strobe_descr)
                   hbusreq <= 1'b0;
               end
        end

        default : hbusreq             <= 1'b0;

        endcase
      end
    end
  end


  // determine how many requests there will be in the descriptor read
  //
  //   DP     64b Addressing           Num Accesses in Descriptor
  //  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //   32         0                              2 (two 32b)
  //   64         0                              1 (single 64b)
  //   128        0                              1 (single 64b)
  //   32         1                              3 (three 32b)
  //   64         1                              2 (two 64b)
  //   128        1                              2 (two 64b)

  assign descriptor_rd_1_access = (|dma_bus_width & ~gem_dma_addr_w_is_64);
  assign descriptor_rd_2_access = (|dma_bus_width[1:0] & gem_dma_addr_w_is_64) |
                                  (dma_bus_width[1:0] == 2'b00 & ~gem_dma_addr_w_is_64);

  // General Control process
  //     Calculates from the descriptor reads the required information for the
  //     buffer fetch.  This includes the buffer length, the buffer start
  //     AHB location, whether the buffer is the last of a multi-buffer frame,
  //      etc
  always @(*)
  begin
    // For descriptor reads that can be completed with a single access, then we need
    // to identify zero length buffers combinatorially on the returned data. Otherwise
    // we can take the value from zero_len_buf_reg
    if (descriptor_rd_1_access)
    begin
      zero_len_buf_en   = (tx_dma_data_in[45:32] == 14'h0000 & ~tx_dma_data_in[63]);
      zero_len_buf_eop  = (tx_dma_data_in[45:32] == 14'h0000 & ~tx_dma_data_in[63] & tx_dma_data_in[47]);
    end
    else
    begin
      zero_len_buf_en   = zero_len_buf_reg;
      zero_len_buf_eop  = zero_len_buf_reg & buf_has_eop;
    end
  end


  // Create a handy array to keep the base addresses(and a few other signals) in - makes coding slightly
  // neater. This is done because you cannot pass arrays as I/O.
  // Also pass the current descriptor pointer back to the register block
  // Similar handy uncrompressing of the array for the fill level
  generate for (g=0; g<p_edma_queues; g=g+1) begin : gen_tx_dma_descr_base_addr
    assign tx_dma_descr_base_addr_array[g]      = tx_dma_descr_base_addr[((g+1)*32)-1:g*32];
    assign tx_dma_descr_ptr[((g+1)*32)-1:g*32]  = {nxt_descr_ptr[g], 2'b00};
    assign TX_PBUF_MAX_FILL_LVL_ARRAY[g]        = TX_PBUF_MAX_FILL_LVL[((g+1)*p_edma_tx_pbuf_addr)-1:g*p_edma_tx_pbuf_addr];
    assign TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[g] = TX_PBUF_SEGMENTS_LOWER_ADDR[((g+1)*p_edma_tx_pbuf_queue_segment_size)-1:g*p_edma_tx_pbuf_queue_segment_size];
    assign TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[g] = TX_PBUF_SEGMENTS_UPPER_ADDR[((g+1)*p_edma_tx_pbuf_queue_segment_size)-1:g*p_edma_tx_pbuf_queue_segment_size];
    assign TX_PBUF_NUM_SEGMENTS_ARRAY[g]        = TX_PBUF_NUM_SEGMENTS[((g+1)*5)-1:g*5];
    assign dpram_fill_lvl[((g+1)*p_edma_tx_pbuf_addr)-1:g*p_edma_tx_pbuf_addr] = dpram_fill_lvl_array[g] | ~TX_PBUF_MAX_FILL_LVL_ARRAY[g];
  end

  if(p_edma_queues< 32'd16) begin: gen_others
    for(g1=p_edma_queues; g1<16; g1=g1+1) begin: gen_loop
      assign tx_dma_descr_base_addr_array[g1]      = 32'd0;
      assign TX_PBUF_MAX_FILL_LVL_ARRAY[g1]        = {p_edma_tx_pbuf_addr{1'b0}};
      assign TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[g1] = {p_edma_tx_pbuf_queue_segment_size{1'b0}};
      assign TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[g1] = {p_edma_tx_pbuf_queue_segment_size{1'b0}};
      assign TX_PBUF_NUM_SEGMENTS_ARRAY[g1]        = 5'd0;
    end
  end
  endgenerate


  wire priq_extra_wrap_cond;
  generate if (p_edma_queues > 32'd1) begin : gen_priq_extra_wrap_cond
    assign priq_extra_wrap_cond = ((~pkt_flush_norep | ~first_buffer_of_pkt) & ~buffullstr_sel);
  end else begin :gen_npriq_extra_wrap_cond
    assign priq_extra_wrap_cond = 1'b1;
  end
  endgenerate
  
  wire [30:0] nxt_descr_ptr_p_incr [p_edma_queues-1:0];
  wire [30:0] ahb_data_addr_p4;
  wire [30:0] ahb_data_addr_p2;
  wire [30:0] ahb_data_addr_p1;
  
  genvar gen_i;
  generate for (gen_i = 0; gen_i < p_edma_queues[31:0]; gen_i = gen_i+1) begin: gen_nxt_descr_ptr_incr
    assign nxt_descr_ptr_p_incr[gen_i] = nxt_descr_ptr[gen_i] + NEXT_DESCR_PTR_INC;
  end
  endgenerate  
  
  assign ahb_data_addr_p4 = ahb_data_addr + 30'd4;
  assign ahb_data_addr_p2 = ahb_data_addr + 30'd2;
  assign ahb_data_addr_p1 = ahb_data_addr + 30'd1;
  
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      manrd_done          <= 1'b0;
      zero_len_buf        <= 1'b0;
      for (i=0; i<p_edma_queues; i=i+1)
         nxt_descr_ptr[i] <= 30'h00000000;
      ahb_data_addr       <= 30'h00000000;
      num_requests        <= 12'h000;
      buf_length          <= 12'h000;
      buf_has_eop         <= 1'b1;
      str_descr_ptr_wr    <= 30'h00000000;
      str_descriptor_wr_1 <= 32'h00000000;
      buf_has_mod         <= 4'd0;
      tx_dma_descr_ptr_tog   <= 1'b0;
      alignment_addr      <= 4'b0000;
      descr_len_field     <= 14'h0000;
      first_word_of_buffer<= 1'b0;
      zero_len_buf_reg    <= 1'b0;
      break_data_wback    <= 1'b0;
      brkdatabuf_full_add <= 1'b0;
      brkdatabuf_full_data<= 1'b0;
   end
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
      begin
        manrd_done          <= 1'b0;
        zero_len_buf        <= 1'b0;
        for (i=0; i<p_edma_queues; i=i+1)
          nxt_descr_ptr[i] <= tx_dma_descr_base_addr_array[i][31:2];
        ahb_data_addr       <= 30'h00000000;
        num_requests        <= 12'h000;
        buf_length          <= 12'h000;
        buf_has_eop         <= 1'b1;
        str_descr_ptr_wr    <= 30'h00000000;
        str_descriptor_wr_1 <= 32'h00000000;
        buf_has_mod         <= 4'd0;
        tx_dma_descr_ptr_tog   <= 1'b0;
        alignment_addr      <= 4'b0000;
        descr_len_field     <= 14'h0000;
        first_word_of_buffer<= 1'b0;
        zero_len_buf_reg     <= 1'b0;
        break_data_wback    <= 1'b0;
        brkdatabuf_full_add <= 1'b0;
        brkdatabuf_full_data<= 1'b0;
      end
      else
      begin
        // If we are in the middle of a burst and the packet needs a writeback,
        // we will do this at the end of the burst. break_data_wback identifies
        // that we are in the final burst before the writeback
        if (last_access_burst_req & pkt_needs_writeback & ahbreqph_strobe_data)
          break_data_wback <= 1'b1;
        else if (dma_state != DMA_PKTDATA)
          break_data_wback <= 1'b0;

        // When the buffer is full, we will wait until the end of the burst
        // before setting this register - this is then used to halt the AHB
        if (last_access_burst_req & buffer_full & ahbreqph_strobe_data)
          brkdatabuf_full_add <= 1'b1;
        else if (~buffer_full)
          brkdatabuf_full_add <= 1'b0;

        // Now generate a datphase timed equivalent
        if (brkdatabuf_full_add & tx_last_data_ph)
          brkdatabuf_full_data <= 1'b1;
        else if (~buffer_full)
          brkdatabuf_full_data <= 1'b0;

        if (hready)
          zero_len_buf       <= zero_len_buf_en;


        // Read Descriptor
        case (dma_state)

        DMA_MANRD :
        begin
          first_word_of_buffer  <= 1'b1;

          if (first_buffer_of_pkt & ahbdataph_strobe_descr & descr_rd_done_dph_cnt == 4'h0 & ~manrd_done)
            str_descr_ptr_wr <= nxt_descr_ptr_pad[queue_ptr_dph];

          // Once the descriptor address has been sampled, increment nxt_descr_ptr
          // If there is an AHB error, reset the next descriptor
          // AHB address to the start of the current packet - this includes used bits read
          if (~first_buffer_of_pkt & ~manrd_done & pkt_flush)
          begin
            for (int_q0 = 0;int_q0<p_edma_queues[31:0];int_q0=int_q0+1)
              if (queue_ptr_dph == int_q0[3:0])
                nxt_descr_ptr[int_q0] <= str_descr_ptr_wr;
          end
          // Update the nxt_descr_ptr once a full descriptor has been read
          // This is 2 AHB accesses in 32bit. descr_rd_done_dph high indicates
          // when the dataphase of the 2nd access is completed
          else if (ahbdataph_strobe_descr & descr_rd_done_dph & ~pkt_flush & ~manrd_done)
          begin
            // Check wrap bit
            if  (wrap_bit_read & ~used_bit_read)
            begin
              if (priq_extra_wrap_cond)
                for (int_q0 = 0;int_q0<p_edma_queues[31:0];int_q0=int_q0+1)
                  if (queue_ptr_dph == int_q0[3:0])
                    nxt_descr_ptr[int_q0]  <= tx_dma_descr_base_addr_array[int_q0][31:2];
            end
            else if (~used_bit_read)
            begin
              if (priq_extra_wrap_cond)
              begin
                for (int_q0 = 0;int_q0<p_edma_queues[31:0];int_q0=int_q0+1)
                  if (queue_ptr_dph == int_q0[3:0])
                    nxt_descr_ptr[int_q0] <= nxt_descr_ptr_p_incr[int_q0][29:0]; // Setup for next pkt's manrd
              end
            end
          end


          // num_words_al requires some fairly complex combinatorial logic to
          // generate it
          // The source is the AHB read data, so I prefer to use a registered
          // version here. It does mean that there is an extra cycle of
          // latency on the descriptor read for 64 bit, but I think it is
          // required
          // For 32 bit, we should be looking at ahbdataph_strobe_descr at all
          // when manrd_done is set
          if (manrd_done)
          begin
            if (hready)
              manrd_done  <= 1'b0;

            if (|dma_bus_width)
            begin
              num_requests        <= num_words_al[11:0];
              buf_length          <= num_words_al[11:0];
            end
          end

          // Update all the control signals when we are sure the descriptor read is completed
          // this is either when a valid descriptor has been read, or when all the queues have
          // been checked.  Note that when the DPRAM is full, there is different behavour in
          // the DMA when configured for priority queueing versus single queue operation. In single
          // queue operation, the DMA will not start a new descriptor read for a new packet if
          // the DPRAM is full(it will complete a descriptor read if doing a descriptor read for
          // a multi-buffer frame). If the DPRAM becomes full while in the data state,further AHB
          // data fetches are simply stalled.  For multiple priority queues, we need to initiate
          // descriptor reads for each queue even if some of the queues have their associated
          // DPRAM regions full.  If when the descriptor is read the region is full, the same
          // behavour as when the used bit read is set is observed. If the buffer_full is set in the
          // datastate of all priorities other than highest, the data state is aborted
          else if (ahbdataph_strobe_descr & (priq_descr_rd_notusedfull | all_queues_checked))
          begin

            case (descr_rd_done_dph_cnt)
              4'h0 :
              begin
                if (dma_bus_width == 2'b00) // 32 bit, word 1
                begin
                  manrd_done      <= 1'b0;
                  buf_has_mod     <= {2'b00,tx_dma_data_in[1:0]};
                  buf_has_eop     <= tx_dma_data_in[15] | used_bit_read_regc | buffullstr_sel;
                  descr_len_field <= tx_dma_data_in[13:0];
                  zero_len_buf_reg <= (tx_dma_data_in[13:0] == 14'h0000 &
                                     ~tx_dma_data_in[31]);
                  if (first_buffer_of_pkt)
                  begin
                    // Store the current buffer contents to determine amount of
                    // data
                    // in AHB, make 25:24, 19:17 and 14 reserved
                    // thats the easiest way to ensure the bytes dont get copied in descr wr,
                    // whcih is what is expected in several tests. These tests randomize the input
                      str_descriptor_wr_1  <= {tx_dma_data_in[31:26],2'b00,tx_dma_data_in[23:20],3'b000,tx_dma_data_in[16:15],1'b0,tx_dma_data_in[13:0]};
                  end
                end
                else // 64bit, word 0/1 AND 128bit word 0/1/2/3
                begin
                  ahb_data_addr       <= dma_bus_width[1]
                                         ? {tx_dma_data_in[31:4],2'd0}:  // 128 bit
                                           {tx_dma_data_in[31:3],1'b0};  // 64 bit
                  alignment_addr      <= dma_bus_width[0]  ? {1'b0,tx_dma_data_in[2:0]} // 64 bit
                                      :                      tx_dma_data_in[3:0]; // 128 bit
                  buf_has_eop         <= tx_dma_data_in[47] | pkt_flush | used_bit_read | buffullstr_sel;
                  descr_len_field     <= tx_dma_data_in[45:32];
                  if (first_buffer_of_pkt)
                  begin
                    // in AHB, make 25:24, 19:17 and 14 reserved
                    // thats the easiest way to ensure the bytes dont get copied in descr wr,
                    // whcih is what is expected in several tests. These tests randomize the input
                    str_descriptor_wr_1  <= {tx_dma_data_in[63:58],2'b00,tx_dma_data_in[55:52],3'b000,tx_dma_data_in[48:47],1'b0,tx_dma_data_in[45:32]};
                  end
                  if (~gem_dma_addr_w_is_64)
                  begin
                    zero_len_buf_reg  <= 1'b0;
                    manrd_done        <= 1'b1;
                    tx_dma_descr_ptr_tog <= ~tx_dma_descr_ptr_tog;
                  end
                  else
                    zero_len_buf_reg <= (tx_dma_data_in[45:32] == 14'h0000 & ~tx_dma_data_in[63]);

                  buf_has_mod       <= {tx_dma_data_in[35] & dma_bus_width[1], tx_dma_data_in[34:32]};
                end
              end

              4'h1 :
              begin
                 if (pkt_flush | used_bit_read | buffullstr_sel)
                   buf_has_eop <= 1'b1;
                if (dma_bus_width == 2'b00) // 32 bit, word 0
                begin
                  if (~gem_dma_addr_w_is_64)
                  begin
                    manrd_done        <= 1'b1;
                    tx_dma_descr_ptr_tog <= ~tx_dma_descr_ptr_tog;
                  end
                  num_requests        <= num_words_al[11:0];
                  buf_length          <= num_words_al[11:0];
                  ahb_data_addr       <= tx_dma_data_in[31:2];
                  alignment_addr      <= {2'b00,tx_dma_data_in[1:0]};
                end

                else // if (dma_bus_width == 2'b01) // 64 bit, word 2/3
                begin
                  manrd_done          <= 1'b1;
                  tx_dma_descr_ptr_tog   <= ~tx_dma_descr_ptr_tog;
                end
              end


              default : // 32 bit only word 2
              begin
                manrd_done            <= 1'b1;
                tx_dma_descr_ptr_tog     <= ~tx_dma_descr_ptr_tog;
                 if (pkt_flush | used_bit_read)
                   buf_has_eop <= 1'b1;
              end
            endcase
          end
        end

        DMA_PKTDATA :
        begin
          manrd_done    <= 1'b0;

          // Set buf_has_eop to ensure the state machine acknowledges the
          // end of the current packet on an AHB error or data buffer overflow
          if (pkt_flush)
            buf_has_eop <= 1'b1;
          else
            buf_has_eop <= buf_has_eop;

          // If there is a flush in the data state, reset the next descriptor
          // AHB address to the start of the current packet.
          if (pkt_flush)
          begin
            for (int_q0 = 0;int_q0<p_edma_queues[31:0];int_q0=int_q0+1)
              if (queue_ptr_dph == int_q0[3:0])
                nxt_descr_ptr[int_q0]  <= str_descr_ptr_wr;
          end

          if (ahbreqph_strobe_data)
          begin
            if (dma_bus_width[1])
              ahb_data_addr  <= ahb_data_addr_p4[29:0];
            else if (dma_bus_width[0])
              ahb_data_addr  <= ahb_data_addr_p2[29:0];
            else
              ahb_data_addr  <= ahb_data_addr_p1[29:0];
            if (~reading_pad_rph)
              num_requests <= num_requests - 12'h001;
          end

          // If this is the first AHB read of the current buffer,  the num of
          // bytes read will depend on the alignment
          if (ahbdataph_strobe_data & ~reading_pad_dph)
          begin
            buf_length            <= buf_length - 12'h001;
            first_word_of_buffer  <= 1'b0;
          end

          if (dma_next_man_rd)
            zero_len_buf_reg  <= 1'b0;
        end

        DMA_PKTINFO :
        begin
          manrd_done         <= 1'b0;
          ahb_data_addr       <= 30'h00000000;
          num_requests        <= 12'h000;
          buf_length          <= 12'h000;
          buf_has_eop         <= buf_has_eop;
          if (dma_next_man_rd)
            zero_len_buf_reg  <= 1'b0;
        end

        DMA_MANWR:
        begin
          if (pkt_flush)
          begin
            for (int_q0 = 0;int_q0<p_edma_queues[31:0];int_q0=int_q0+1)
              if (queue_ptr_dph == int_q0[3:0])
                nxt_descr_ptr[int_q0]  <= str_descr_ptr_wr;
          end
          if (dma_next_man_rd)
            zero_len_buf_reg  <= 1'b0;
        end

        default : // DMA_IDLE
        begin
          if (new_tx_q_ptr_pulse)
            for (i=0; i<p_edma_queues; i=i+1)
              nxt_descr_ptr[i] <= tx_dma_descr_base_addr_array[i][31:2];
          manrd_done         <= 1'b0;
          ahb_data_addr       <= 30'h00000000;
          num_requests        <= 12'h000;
          buf_length          <= 12'h000;
          buf_has_eop         <= buf_has_eop;
          if (dma_next_man_rd)
            zero_len_buf_reg  <= 1'b0;
        end

        endcase
      end
    end
  end

  genvar k;
  generate for (k=0; k<16; k=k+1) begin: gen_padded_signals
    if(k<p_edma_queues) begin: gen_queues
      assign nxt_descr_ptr_pad[k] = nxt_descr_ptr[k];
    end
    else begin: gen_remaining
      assign nxt_descr_ptr_pad[k] = 30'h00000000;
    end
  end
  endgenerate

  assign generate_ip_csum     = 1'b1;
  assign generate_tcp_csum    = 1'b1;

  assign buffer_written = (buf_length[11:1] == 11'h000 & ahbdataph_strobe_data)
                          | hresp_notok_eob;

  assign buffer_written_pluspad = (force_max_ahb_burst_tx &
                                    |ahb_burst_length[4:2] &
                                    reading_pad_aph)
                                      ?  (buf_length[11:1] == 11'h000 &
                                          ahbdataph_strobe_data &
                                          last_access_burst_dph)

                                      : buffer_written;

  // Differentiate the real data from the pad
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      reading_pad_aph <= 1'b0;
      reading_pad_dph <= 1'b0;
    end
    else
    begin
      if (hready)
        reading_pad_dph <= reading_pad_aph;

      if (hready)
        reading_pad_aph <= reading_pad_rph;
    end
  end

  assign pad_remaining_burst =
          // The burst padding feature is enabled and the AHB burst length
          // programmed in the registers is set to BURST of 4,8,16 - ignore
          // all others
                (force_max_ahb_burst_tx & |ahb_burst_length[4:2] &

                num_requests == 12'h001 &// last request of the buffer
                ahbreqph_strobe_data &   // essentially hready
                ~last_access_burst_req & // not the last access of the burst

          // if at the end of the packet we are close to a 1k boundary
          // (< 4 words), then we might have to block the padding.  In
          // order to pad, one of the following 3 things must be true
          //   1. we are not close to a 1k boundary
          //   2. We are already in the middle of a burst, which means
          //      there must be enough room to complete that burst - hburst != 1
          //   3. If we are about to start a new burst (ahb_access_cnt == 0)
          //      and there is at least enough room for a burst of 4
          // Else do NOT pad
               (~brk1kbndry_burst |
               (|hburst[2:1] & |ahb_access_cnt) |
               (ahb_access_cnt == 4'h0 & |bndry1k_acc_size[3:2])));


  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      reading_pad_rph <= 1'b0;
    end
    else if (reading_pad_rph & ahbreqph_strobe_data & last_access_burst_req)
      reading_pad_rph <= 1'b0;
    else if (pad_remaining_burst)
      reading_pad_rph <= 1'b1;
  end

  assign used_bit_read_regc = (dma_state_man_rd & ahbdataph_strobe_descr & (descr_rd_done_dph_cnt == 4'h0)) &
                              ((tx_dma_data_in[31] & dma_bus_width == 2'b00) |
                               (tx_dma_data_in[63] &(|dma_bus_width)));

  assign wrap_bit_read_regc = (dma_state_man_rd & ahbdataph_strobe_descr & (descr_rd_done_dph_cnt == 4'h0)) &
                              ((tx_dma_data_in[30] & dma_bus_width == 2'b00) |
                               (tx_dma_data_in[62] &(|dma_bus_width)));

  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      used_bit_read_reg   <= 1'b0;
      wrap_bit_read_reg   <= 1'b0;
    end
    else
    begin
      if ((descr_rd_done_dph & ahbdataph_strobe_descr) | manrd_done | dma_state != DMA_MANRD)
      begin
        used_bit_read_reg   <= 1'b0;
        wrap_bit_read_reg   <= 1'b0;
      end
      else
      begin
        if (used_bit_read_regc)
          used_bit_read_reg <= 1'b1;
        if (wrap_bit_read_regc)
          wrap_bit_read_reg <= 1'b1;
      end
    end
  end

generate if (p_edma_queues > 32'd1) begin : gen_priq_specific_code
  reg [p_edma_queues-1:0] buf_full_stored;
  wire             [16:0] buf_full_stored_pad;
  reg [p_edma_queues-1:0] used_bit_stored;
  reg                     clear_buffull_en;
  reg                     q0_no_space_for_status;
  reg                     used_bit_read_all_r;

  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      used_bit_read_all_r   <= 1'b1;
    else
    begin
      if (~dma_state_man_rd)
        used_bit_read_all_r <= 1'b1;
      else if (ahbdataph_strobe_descr & (descr_rd_done_dph_cnt == 4'h0) &
              ((dma_bus_width==2'b00 & ~tx_dma_data_in[31]) | ((|dma_bus_width)  & ~tx_dma_data_in[63])))
        used_bit_read_all_r <= 1'b0;
    end
  end
  assign used_bit_read_all = used_bit_read_all_r;

  always @(posedge hclk or negedge n_hreset)
    if (~n_hreset)
      clear_buffull_en <= 1'b0;
    else if (~enable_tx_hclk | complete_flush_hclk)
      clear_buffull_en  <= 1'b0;
    else
      // Cleared when packet has been transmitted,
      // or when there is a flush event
      // This will enable the next descriptor read
      // Note that in 32 bit mode, we want to ensure buf_full_stored
      // does not get updated during the first of the 2 descriptor read
      // accesses.
      if (descr_rd_done_dph & ahbdataph_strobe_descr)
       clear_buffull_en <= 1'b0;
      else if ((full_pkt_read_edge | pkt_flush_report) & dma_state_man_rd)
       clear_buffull_en <= 1'b1;

  // The following is done to avoid some LINT warnings when dpram_fill_lvl_array has to be
  // compared with 3 or 6 to produce q0_no_space_for_status
  wire [16:0] dpram_fill_lvl_array_pad [p_edma_queues-1:0];
  genvar gen_k;
  for (gen_k=0; gen_k<p_edma_queues[31:0]; gen_k=gen_k+1) 
  begin: gen_dpram_fill_lvl_array_padding
    assign dpram_fill_lvl_array_pad[gen_k] = {{(17-p_edma_tx_pbuf_addr){1'b0}},dpram_fill_lvl_array[gen_k]};
  end
  
  always @(*)
  begin
    if (p_edma_tx_pbuf_data == 32'd128)
      q0_no_space_for_status  = (dpram_fill_lvl_array_pad[0] <= 17'd3); // is full if there is space for 2 status - keeping it safe here
    else
      q0_no_space_for_status  = (dpram_fill_lvl_array_pad[0] <= 17'd6); // is full if there is space for 2 status - keeping it safe here
  end
  
  for (g=0; g<p_edma_queues; g=g+1) begin : gen_priq_specific_code_for
    always @(posedge hclk or negedge n_hreset)
      if (~n_hreset)
      begin
        buf_full_stored[g] <= 1'b0;
        used_bit_stored[g] <= 1'b0;
      end
      else if (~enable_tx_hclk | complete_flush_hclk)
      begin
        buf_full_stored[g] <= 1'b0;
        used_bit_stored[g] <= 1'b0;
      end
      else
      begin

        if (((descr_rd_done_dph & ahbdataph_strobe_descr) | ~dma_state_man_rd) &
            (clear_buffull_en | manwr_complete | pkt_flush_report | (&dpram_fill_lvl_array[g])))
          buf_full_stored[g] <= 1'b0;
        else if (pkt_flush_norep & queue_ptr_dph == g[3:0])
          buf_full_stored[g] <= 1'b1;

        if (dma_state == DMA_PKTINFO)
          used_bit_stored[g] <= 1'b0;
        else if (dma_state_man_rd & descr_rd_done_dph & ahbdataph_strobe_descr)
        begin
          if (queue_ptr_dph == g[3:0])
            used_bit_stored[g] <= used_bit_read;
          else if (queue_ptr_dph > g[3:0])
            used_bit_stored[g] <= 1'b0;
        end
      end
  end

  assign buf_full_stored_pad    = {{(17-p_edma_queues){1'b0}},buf_full_stored[p_edma_queues-1:0]};
  assign set_dpram_region_full  = (&(buf_full_stored | used_bit_stored) | q0_no_space_for_status);
  assign buffullstr_sel         = buf_full_stored_pad[queue_ptr_dph];
  assign all_queues_checked     = (queue_ptr_dph == 4'h0) | ~first_buffer_of_pkt;
 end else begin : gen_npriq_specific_code_for
  assign used_bit_read_all      = 1'b1;
  assign buffullstr_sel         = 1'b0;
  assign all_queues_checked     = 1'b1;
  assign set_dpram_region_full  = buffer_full;
 end
 endgenerate

  assign used_bit_read        = descriptor_rd_1_access
                                  ? used_bit_read_regc & dma_state_man_rd :
                                descriptor_rd_2_access
                                  ? used_bit_read_reg & descr_rd_done_dph_cnt[3:0] == 4'h1 & ahbdataph_strobe_descr
                                  : used_bit_read_reg & descr_rd_done_dph_cnt[3:0] == 4'h2 & ahbdataph_strobe_descr; // 3 access

  assign wrap_bit_read        = descriptor_rd_1_access
                                  ? wrap_bit_read_regc & dma_state_man_rd :
                                descriptor_rd_2_access
                                  ? wrap_bit_read_reg & descr_rd_done_dph_cnt[3:0] == 4'h1 & ahbdataph_strobe_descr
                                  : wrap_bit_read_reg & descr_rd_done_dph_cnt[3:0] == 4'h2 & ahbdataph_strobe_descr; // 3 access

  assign eop_burst            = ~(force_max_ahb_burst_tx & |ahb_burst_length[4:2]) &
                                (num_requests < {7'h00, ahb_burst_length[4:0]});
  assign eop_burst_size       = (num_requests[4:0]);


  // Calculate if the current buffer is the first buffer of the current frame
  // To simplfy things, this signal will be set if the last buffer read
  // was the last of the previous frame
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      first_buffer_of_pkt   <= 1'b0;
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
        first_buffer_of_pkt <= 1'b0;

      // First_buffer_of_pkt will be read next time the state is
      // in DMA_MANRD
      else if (dma_next_man_rd & ~dma_state_man_rd)
        first_buffer_of_pkt <= buf_has_eop;
    end
  end

  edma_sync_toggle_detect i_edma_sync_toggle_detect_underflow_tog (
    .clk(hclk),
    .reset_n(n_hreset),
    .din(underflow_tog),
    .rise_edge(),
    .fall_edge(),
    .any_edge(underflow_tog_edge));

  always@(posedge hclk or negedge n_hreset)
    if (~n_hreset)
      underflow_frame_hclk  <= 1'b0;
    else
      if (underflow_tog_edge)
        underflow_frame_hclk  <= 1'b1;
      else if (status_captured)
        underflow_frame_hclk  <= 1'b0;


  // Validate underflow events - need to create versions for
  // AHB request phase & address phase.  Need to do this so
  // that any burst is completed before we perform the complete_flush
  assign underflow_reqph =  ((~int_issued_wait_for_capt & ahbreqph_strobe_data
                             & last_access_burst_req) |
                             ~hbusreq)
                             & underflow_frame_hclk ;

  // Interrupt generation
  // Write the status updates to the upper layer, which will in turn
  // create the interrupt based on the information we send ...
  //
  // Typically, we will generate an interrupt when the DMA writeback is
  // complete.  The DMA signals that are used to generate specific
  // interrupts are sampled by the APB space using a handshake protocol
  // To ensure this handshake is clean, tx_dma_stable_tog can only toggle
  // when the tx_dma_* signals are stable.  tx_stat_capt_pulse will be
  // driven to indicate when the register space has sampled the signals
  // safely. int_issued_wait_for_capt is high while we are waiting for tx_stat_capt_pulse
  //
  // Note that if we are waiting for tx_stat_capt_pulse, the writeback state
  // is not even entered ...
  assign dma_late_col_int     = (status_word_rd_0[1] & ~(|status_word_rd_0[16:14]));
  assign dma_toomanyretry_int = (status_word_rd_0[0] & ~(|status_word_rd_0[16:14]));
  assign dma_hresp_notok_int  = (status_word_rd_0[15] | hresp_notok_eob);
  assign dma_buff_ex_mid_int  = (|status_word_rd_0[16:15] | hresp_notok_eob);
  assign dma_buff_ex_int      = (status_word_rd_0[16] | status_word_rd_0[14]);
  assign dma_tx_ok_int        = (~(|status_word_rd_0[16:14]) & ~(|status_word_rd_0[1:0]));

generate if (p_edma_queues > 32'd1) begin : gen_priq_int_gen_logic
  assign set_queue_int        = queue_being_read_manwr;
end else begin : gen_npriq_int_gen_logic
  assign set_queue_int        = 4'h0;
end
endgenerate

  assign int_already_requested= (tx_dma_complete_ok | tx_dma_buff_ex_mid | tx_dma_buffers_ex | tx_dma_hresp_notok | tx_dma_toomanyretry | tx_dma_late_col | tx_dma_underflow);

  assign set_late_col_int     = dma_late_col_int;
  assign set_toomanyretry_int = dma_toomanyretry_int;
  assign set_hresp_notok_int  = dma_hresp_notok_int;
  assign set_buff_ex_mid_int  = dma_buff_ex_mid_int;
  assign set_buff_ex_int      = dma_buff_ex_int;
  assign set_tx_ok_int        = dma_tx_ok_int;
  assign gen_int              = manwr_complete;
  assign gen_int_last         = gen_int & all_manwr_done;

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      str_int_vector           <= 8'h00;
      int_issued_wait_for_capt <= 1'b0;
      tx_dma_stable_tog        <= 1'b0;
      tx_dma_complete_ok       <= 1'b0;
      tx_dma_buff_ex_mid       <= 1'b0;
      tx_dma_buffers_ex        <= 1'b0;
      tx_dma_hresp_notok       <= 1'b0;
      tx_dma_late_col          <= 1'b0;
      tx_dma_toomanyretry      <= 1'b0;
      tx_dma_underflow         <= 1'b0;
      hresp_notok_hold         <= 1'b0;
      revert_to_data           <= 1'b0;
      underflow_addph          <= 1'b0;
      tx_dma_int_queue         <= 4'd0;
      str_int_queue            <= 4'h0;
    end
    else
    begin

      if (~enable_tx_hclk | complete_flush_hclk)
      begin
        str_int_vector           <= 8'h00;
        tx_dma_complete_ok       <= 1'b0;
        tx_dma_buff_ex_mid       <= 1'b0;
        tx_dma_stable_tog        <= 1'b0;
        tx_dma_buffers_ex        <= 1'b0;
        tx_dma_hresp_notok       <= 1'b0;
        tx_dma_late_col          <= 1'b0;
        tx_dma_toomanyretry      <= 1'b0;
        tx_dma_underflow         <= 1'b0;
        hresp_notok_hold         <= 1'b0;
        int_issued_wait_for_capt <= 1'b0;
        revert_to_data           <= 1'b0;
        underflow_addph          <= 1'b0;
        tx_dma_int_queue         <= 4'd0;
        str_int_queue            <= 4'h0;
      end
      else
      begin

        if (underflow_reqph & hready)
          underflow_addph <= 1'b1; // Hold this until complete_flush_hclk occurs

        // hresp_not_ok is a data phase timed signal
        // We use this to halt hbusreq, which is a request phase timed signal
        // This means there will probably be a couple of data phases before
        // the AHB requests stop.  We dont need to write any of these dataphases
        // into memory
        // hresp_notok_hold gets set on hresp_not_ok and remains set until
        // the end of the AHB accesses
        if (hresp_notok_eob)
          hresp_notok_hold  <= 1'b0;
        else if (hresp_not_ok)
          hresp_notok_hold  <= 1'b1;

        // revert_to_data identifies when we must return to completing
        // the fetch of the current packet - from the writeback state
        if ((dma_state_data | dma_state_man_rd) & (dma_state_nxt  == DMA_MANWR))
          revert_to_data  <= 1'b1;
        else if (dma_state_data)
          revert_to_data  <= 1'b0;

        if (int_issued_wait_for_capt & (gen_int | (underflow_addph & hready)))
        begin
          int_issued_wait_for_capt       <= ~status_captured;
          if (status_captured)
          begin
            tx_dma_int_queue    <= 4'd0;
            tx_dma_complete_ok  <= 1'b0;
            tx_dma_buff_ex_mid  <= 1'b0;
            tx_dma_buffers_ex   <= 1'b0;
            tx_dma_hresp_notok  <= 1'b0;
            tx_dma_toomanyretry <= 1'b0;
            tx_dma_late_col     <= 1'b0;
            tx_dma_underflow    <= 1'b0;
          end
          str_int_queue <= set_queue_int;
          str_int_vector <= {set_tx_ok_int,
                             set_buff_ex_int,
                             set_buff_ex_mid_int,
                             set_hresp_notok_int,
                             set_toomanyretry_int,
                             set_late_col_int,
                             (underflow_addph & hready),
                             gen_int_last
                            } | str_int_vector;
        end

        // Special case to trigger an interrupt because we have seen a interrupt gen request to a different queue
        else if (~int_issued_wait_for_capt &
                 (set_queue_int != tx_dma_int_queue & int_already_requested) &
                 (gen_int | (underflow_addph & hready)))
        begin
          int_issued_wait_for_capt       <= 1'b1;
          // Toggle hanshake to register block to perform status update
          tx_dma_stable_tog <= ~tx_dma_stable_tog;

          str_int_queue <= set_queue_int;
          str_int_vector <= {set_tx_ok_int,
                             set_buff_ex_int,
                             set_buff_ex_mid_int,
                             set_hresp_notok_int,
                             set_toomanyretry_int,
                             set_late_col_int,
                             (underflow_addph & hready),
                             gen_int_last
                            } | str_int_vector;
        end

        // Special mechanism for generating an interrupt due to underflow
        else if (~int_issued_wait_for_capt & ((underflow_addph & hready) | str_int_vector[1]))
        begin
          str_int_vector           <= 8'h00;
          int_issued_wait_for_capt <= 1'b1;
          tx_dma_complete_ok       <= 1'b0;
          tx_dma_buff_ex_mid       <= 1'b0;
          tx_dma_buffers_ex        <= 1'b0;
          tx_dma_hresp_notok       <= 1'b0;
          tx_dma_int_queue         <= 4'd0;
          tx_dma_stable_tog        <= ~tx_dma_stable_tog;
          tx_dma_toomanyretry      <= 1'b0;
          tx_dma_late_col          <= 1'b0;
          tx_dma_underflow         <= 1'b1;
        end

        // Determine if the descriptor writeback is due to a packet
        // getting transmitted or if it due to an error
        // Note that if int_issued_wait_for_capt is set, we can pretty much guarantee
        // that the cause is the above underflow event.  If the underflow
        // occured, then entering DMA_MANWR state is very unlikely indeed
        // and is really dont care.
        else if (~int_issued_wait_for_capt & (gen_int | (|str_int_vector)))
        begin
          str_int_vector <= 8'h00;
          if (gen_int_last | str_int_vector[0])
          begin
            int_issued_wait_for_capt <= 1'b1;

            // Toggle hanshake to register block to perform status update
            tx_dma_stable_tog <= ~tx_dma_stable_tog;
          end

          if (gen_int)
            tx_dma_int_queue    <= set_queue_int;
          else
            tx_dma_int_queue    <= str_int_queue;

          // If there was any error reported through error_status &
          // !too_many_retries and !late_coll_occured
          if (set_tx_ok_int | str_int_vector[7])
            tx_dma_complete_ok  <= 1'b1;

          // If there was any error seen (used bit, hresp)
          if (set_buff_ex_int | str_int_vector[6])
            tx_dma_buffers_ex <= 1'b1;

          // If there an exhausted buffer mid-frame condition detected,
          // or an AHB error occurred, a separate writeback will be
          // required. However, to simplify the clock domain issues,
          // it is better to send just one interrupt,
          if (set_buff_ex_mid_int | str_int_vector[5])
            tx_dma_buff_ex_mid <= 1'b1;

          // AHB error, look at tx_burst-error to catch HRESP errors
          // during writeback
          if (set_hresp_notok_int | str_int_vector[4])
            tx_dma_hresp_notok <= 1'b1;

          if (set_toomanyretry_int | str_int_vector[3])
            tx_dma_toomanyretry <= 1'b1;

          if (set_late_col_int | str_int_vector[2])
            tx_dma_late_col     <= 1'b1;

          tx_dma_underflow <= str_int_vector[1];
        end

        // Reset all flags when acknowledge seen from registers block
        else if (status_captured)
        begin
          begin
            tx_dma_int_queue         <= 4'd0;
            int_issued_wait_for_capt <= 1'b0;
            tx_dma_complete_ok       <= 1'b0;
            tx_dma_buff_ex_mid       <= 1'b0;
            tx_dma_buffers_ex        <= 1'b0;
            tx_dma_hresp_notok       <= 1'b0;
            tx_dma_stable_tog        <= tx_dma_stable_tog;
            tx_dma_toomanyretry      <= 1'b0;
            tx_dma_late_col          <= 1'b0;
            tx_dma_underflow         <= 1'b0;
          end
        end
      end
    end
  end



  // Only look at handshake from registers block when an update is pending.
  assign status_captured = (tx_stat_capt_pulse & int_issued_wait_for_capt);

  // Pass the do_writeback_tog signal into AHB clock domain
  edma_sync_toggle_detect # (
     .DIN_W(2)
  ) i_edma_sync_toggle_detect_pkt_read (
    .clk(hclk),
    .reset_n(n_hreset),
    .din({full_pkt_read,part_pkt_read}),
    .rise_edge(),
    .fall_edge(),
    .any_edge({full_pkt_read_edge,part_pkt_read_edge}));

  // DMA writebacks are triggered when the MAC side of the packet buffer
  // is done with a packet.  it will toggle 'full_pkt_read' to indicate this
  // It will also send the status information associated with the writeback
  // directly via 'xfer_status_bus'
  // We need to capture this information as quickly as possible to allow the
  // MAC side to 'move on' and avoid being locked up.  However, we need to
  // latch this information until we ourselves have completed the writeback.
  // The time for this to happen is governed by the time it takes to move
  // into the DMA writeback state and the time taken to perform the AHB write
  // (which in itself is governed by the number of wait states foir the descriptor
  // write access). I have decided that locally storing 2 banks of status info
  // in flops should be sufficient for the vast majority of cases, given that
  // the DMA writeback state will be entered quickly, and that successive writeback
  // requests should be received at worst every 70 odd tx_mac_clk cycles.
    assign manwr_complete = (dma_state == DMA_MANWR & manwr_done);
   wire [77:0]  xfer_status_bus_gated;
   assign xfer_status_bus_gated = xfer_status_bus & {78{full_pkt_read_edge}};

   wire [48:0]  xfer_status_bus_ts_gated;
   assign xfer_status_bus_ts_gated[42:0]  = xfer_status_bus_ts[42:0] & {43{full_pkt_read_edge}};
   assign xfer_status_bus_ts_gated[48:43] = xfer_status_bus_ts[48:43] & {6{full_pkt_read_edge}};  // passing parity

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      man_wr_cnt              <= 2'h0;
      xfer_status_captured    <= 1'b0;
      nxt_xfer_status_bus     <= 78'd0;
      nxt_xfer_status_bus2    <= 78'd0;
      nxt_xfer_status_bus_ts  <= {6'd0,43'd0};
      nxt_xfer_status_bus_ts2 <= {6'd0,43'd0};
    end
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
      begin
        man_wr_cnt              <= 2'h0;
        nxt_xfer_status_bus     <= 78'd0;
        nxt_xfer_status_bus2    <= 78'd0;
        nxt_xfer_status_bus_ts  <= {6'd0,43'd0};
        nxt_xfer_status_bus_ts2 <= {6'd0,43'd0};
      end
      else
      begin
        if (full_pkt_read_edge)
        begin
          if (manwr_complete)
            man_wr_cnt <= man_wr_cnt;
          else
            man_wr_cnt <= man_wr_cnt + 2'h1;
        end
        else if (manwr_complete)
          man_wr_cnt <= man_wr_cnt - 2'h1;

        if (full_pkt_read_edge)
        begin
          case (man_wr_cnt)
            2'b00 :
            begin
              xfer_status_captured   <= ~xfer_status_captured;
              nxt_xfer_status_bus    <= xfer_status_bus_gated;
              nxt_xfer_status_bus_ts <= xfer_status_bus_ts_gated;
            end
            2'b01 :
            begin
              xfer_status_captured  <= ~xfer_status_captured;
              if (manwr_complete)
                begin
                  nxt_xfer_status_bus    <= xfer_status_bus_gated;
                  nxt_xfer_status_bus_ts <= xfer_status_bus_ts_gated;
                end
              else
              begin
                nxt_xfer_status_bus2    <= xfer_status_bus_gated;
                nxt_xfer_status_bus_ts2 <= xfer_status_bus_ts_gated;
              end
            end
            default :
            begin
              // Already storing 2 status's, so cant store any more,
              // unless we are finished with one.  Instead, we can
              // hold the value in xfer_status_bus by not toggling
              // xfer_status_captured
              if (manwr_complete)
              begin
                xfer_status_captured    <= ~xfer_status_captured;
                nxt_xfer_status_bus2    <= xfer_status_bus_gated;
                nxt_xfer_status_bus     <= nxt_xfer_status_bus2;
                nxt_xfer_status_bus_ts2 <= xfer_status_bus_ts_gated;
                nxt_xfer_status_bus_ts  <= nxt_xfer_status_bus_ts2;
              end
            end
          endcase
        end
        else if (man_wr_cnt[1] & manwr_complete)
        begin
          xfer_status_captured    <= &man_wr_cnt[1:0] ? ~xfer_status_captured : xfer_status_captured;
          nxt_xfer_status_bus2    <= xfer_status_bus;
          nxt_xfer_status_bus     <= nxt_xfer_status_bus2;
          nxt_xfer_status_bus_ts2 <= xfer_status_bus_ts;
          nxt_xfer_status_bus_ts  <= nxt_xfer_status_bus_ts2;
        end
      end
    end
  end
  assign all_manwr_done = manwr_done & man_wr_cnt == 2'b01 & ~full_pkt_read_edge;


  assign muxed_descr_ptr = nxt_descr_ptr_pad[queue_ptr_rph];


     reg [29:0] tx_dma_burst_addr_local;
     // Calculate the address used on the AHB.  This is made combinatorial
     // This increments the ahb address during a BD to read additional words
     
     wire [30:0] tx_dma_burst_addr_local_1;
     wire [30:0] tx_dma_burst_addr_local_2;
     wire [30:0] status_word_rd_1_p1;
     wire [30:0] status_word_rd_1_p2;
     wire [30:0] status_word_rd_1_p3;
     wire [30:0] status_word_rd_1_p4;
     
     assign      tx_dma_burst_addr_local_1 = muxed_descr_ptr + {26'h0000000,descr_rd_done_rph_cnt};
     assign      tx_dma_burst_addr_local_2 = muxed_descr_ptr + {25'h0000000,descr_rd_done_rph_cnt,1'b0};
     assign      status_word_rd_1_p1       = status_word_rd_1[29:0] + 30'd1;
     assign      status_word_rd_1_p2       = status_word_rd_1[29:0] + 30'd2;
     assign      status_word_rd_1_p3       = status_word_rd_1[29:0] + 30'd3;
     assign      status_word_rd_1_p4       = status_word_rd_1[29:0] + 30'd4;
     
     always @( * )
     begin
       if (dma_state == DMA_MANRD)
       begin
         if (dma_bus_width == 2'b00) // 32 bit
         begin
             case (descr_rd_done_rph_cnt)
               4'h0:    tx_dma_burst_addr_local = muxed_descr_ptr + 30'h00000001;
               4'h1:    tx_dma_burst_addr_local = muxed_descr_ptr;
               default: tx_dma_burst_addr_local = tx_dma_burst_addr_local_1[29:0];
             endcase
         end

         else
           tx_dma_burst_addr_local = tx_dma_burst_addr_local_2[29:0];
       end

       else if (dma_state == DMA_PKTDATA)
         tx_dma_burst_addr_local  = ahb_data_addr;

       else  // DMA_MANWR
         // single manwr access (to BD word 1) when not using extended BD's
         // additional write to BD words 2 and 3 for non 64b addressing
         // additional write to BD words 4 and 5 for 64b addressing
         // initially perform 32b accesses for each write although a
         // 64b access can be performed for 64 and 128b data bus widths
         if (~tx_bd_extended_mode_en) // 1 BD WORD to be written (no write to WORD 0)
           tx_dma_burst_addr_local  = status_word_rd_1[29:0]; // lower address bits of BD
         else
           // Code for multiple writes to BD location
           // we need to do several writes to the TX BD if extended BD mode
           // the last write must be to address containing WORD1 as it has 'Used Bit'
           begin
             if (~gem_dma_addr_w_is_64) // write to words 2 and 3
               begin
                 if (descr_wr_reqph_cnt == 4'h2) // 3 BD WORDS to be written (no write to WORD 0)
                   begin
                     tx_dma_burst_addr_local = status_word_rd_1[29:0];
                   end
                 else if (descr_wr_reqph_cnt == 4'h1)
                   begin
                     tx_dma_burst_addr_local = status_word_rd_1_p1[29:0];
                   end
                 else //if (descr_wr_reqph_cnt == 4'h0)
                   begin
                     tx_dma_burst_addr_local = status_word_rd_1_p2[29:0];
                   end
               end
             else
               begin
                 if (descr_wr_reqph_cnt == 4'h2) // 3 BD WORDS to be written (no write to WORD 0)
                   begin
                     tx_dma_burst_addr_local = status_word_rd_1[29:0];
                   end
                 else if (descr_wr_reqph_cnt == 4'h1)
                   begin
                     tx_dma_burst_addr_local = status_word_rd_1_p3[29:0];
                   end
                 else //if (descr_wr_reqph_cnt == 4'h0)
                   begin
                     tx_dma_burst_addr_local = status_word_rd_1_p4[29:0];
                   end
               end
           end
     end
     assign tx_dma_burst_addr = tx_dma_burst_addr_local;



  // if a packet has been transmitted, a writeback will be required
  // Hold off the writeback request until previous intterupt info has been
  // captured. No writebacks needed for AXI ! Uses a separate interface
  assign pkt_needs_writeback  = (|man_wr_cnt & ~int_issued_wait_for_capt);

  // The DMA is active as long as the state is not in IDLE and the dma has not
  // been halted
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      tx_dma_go <= 1'b0;
    end
    else
    begin
      tx_dma_go <= (num_pkts_in_buf[7:0] != 8'h00) | dma_state_man_wr;
    end
  end

  // Process the status to write back
  // this will depend on tx_bd_extended_mode_en which requires additional status writes
  assign descriptor_wb_word1  =
                  {1'b1,                       // Used bit
                   status_word_rd_2[19],       // Wrap bit
                   (status_word_rd_0[0]&~(|status_word_rd_0[16:14])), // Too many retries
                   status_word_rd_0[15],       // Frame Corruption
                   status_word_rd_0[16],       // Exhausted buffers mid frame
                   (status_word_rd_0[1]&~(|status_word_rd_0[16:14])), // Late Collision
                   status_word_rd_2[25:24],   // TCP stream ID
                   ts_to_be_written,
                   status_word_rd_2[18:16],    // TCP status
                   status_word_rd_2[23],   // sequence number sel
                   status_word_rd_2[22],   // TSO enable
                   status_word_rd_2[21],   // UFO enable
                   status_word_rd_2[15],   // no CRC
                   status_word_rd_2[14],   // EOF
                   status_word_rd_2[20],   // Last header flag
                   status_word_rd_2[13:0]} ;
 always @ ( * )
 begin
   if (~tx_bd_extended_mode_en) // single word written for manwr
   begin
     dma_data_out  = {96'd0,descriptor_wb_word1};      // Length
     dma_prty_out  = {12'd0,descriptor_wb_word1_prty[3:0]}; // parity for Length
   end else  // 3 words written for enhance TS
   begin
     case (descr_wr_addph_cnt)
     4'h0 : begin
       // second TS word
       dma_data_out  = {118'd0, tx_timestamp[41:32]};    // TX TS
       dma_prty_out  = {14'd0, tx_timestamp_prty[5:4]};  // TX TS parity
     end
     4'h1 : begin
       // first TS word
       dma_data_out  = {96'd0, tx_timestamp[31:0]};     // TX TS
       dma_prty_out  = {12'd0, tx_timestamp_prty[3:0]}; // TX TS parity
     end

      default : begin

      // used bit and status
      dma_data_out = {96'd0,descriptor_wb_word1};    // Length
      dma_prty_out  = {12'd0,descriptor_wb_word1_prty[3:0]}; // parity for Length
      end
      endcase

   end

 end

  // Detect when a first valid buffer descriptor has been read, so that we can
  // increment the number of packets in the TX pipeline.
  // Only valid if not a zero length buffer with end.
  always @(*)
  begin
    stored_buf_inc =  ((dma_state_man_rd & first_buffer_of_pkt & ~manrd_done &
                        ahbdataph_strobe_descr) &
                        ((all_queues_checked & used_bit_read & used_bit_read_all)
                        |(~zero_len_buf_eop & ~used_bit_read & priq_descr_rd_notusedfull & descr_rd_done_dph)));

  end

  // Calculate the number of pkts currently getting processed in the
  // DPRAM.  This number represents the number of packets in the DPRAM
  // including non-complete packets.  I.e. Once a new packet starts getting
  // written to DPRAM, this signal is incrementd.  Once a packet has been
  // successfully transmitted or flushed, this signal is decremented
  reg pkt_flush_norep_d1;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      num_pkts_in_buf   <= 8'h00;
    end
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
        num_pkts_in_buf <= 8'h00;
      else
      begin
        // Decremented for a good packet when it has completed its writeback,
        // or we are replaying the packet
        if ((manwr_complete) |
            (pkt_flush_norep & ~first_buffer_of_pkt) |
            (pkt_flush_norep_d1 & last_dma_state != DMA_MANRD & first_buffer_of_pkt))
        begin
          if (~stored_buf_inc)
            num_pkts_in_buf <= num_pkts_in_buf - 8'h01;
        end
        else if (stored_buf_inc)
          num_pkts_in_buf <= num_pkts_in_buf + 8'h01;
      end
    end
  end
  
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      pkt_flush_norep_d1 <= 1'b0;
    end
    else
      pkt_flush_norep_d1 <= pkt_flush_norep;
  end


  // Work out when only one packet in buffer. This is when either:-
  // 1. num_pkts_in_buf == 1 OR
  // 2. num_pkts_in_buf == 2 and a writeback is pending (means buffer
  //    resources for first packet have been freed-up
  assign one_packet_in_buf = num_pkts_in_buf == 8'h01 & ~tx_cutthru;


  // Conditions to flush a packet from the DPRAM ...
  //   1) Used bit read
  //   2) AHB transaction error (HRESP error)
  //   3) Zero length buffer read during last buffer of a multi-buffer pkt
  //   4) Buffer is full and the number of packets in the pipeline = 1
  //   5) Aborting a frame if buffer_full gets set and priority queueing is enabled
  //      (all frames except highest priority)
  // Two signals are generated.  the first is when a pkt flush from the DPRAM is required
  // AND a writeback will be performed. The second is just when a packet is flushed (when
  // the packet will be replayed)
  wire   pkt_flush_used;
  wire   pkt_flush_ahb;
  wire   pkt_flush_zero;
  wire   pkt_flush_oflow_dat;
  wire   pkt_flush_oflow_ndat;
  assign pkt_flush_used       = used_bit_read_all & all_queues_checked & used_bit_read;
  assign pkt_flush_ahb        = (hresp_notok_eob & ~err_status[3]);
  assign pkt_flush_zero       = (~first_buffer_of_pkt & zero_len_buf_eop & dma_state == DMA_MANRD & ahbdataph_strobe_descr);
  assign pkt_flush_oflow_dat  = (buffer_full_err & ahbdataph_strobe_data & ~ahbaddph_strobe_data);
  assign pkt_flush_oflow_ndat = (buffer_full_err & (last_dma_state != DMA_PKTDATA));
  assign pkt_flush_report =
                        // Used bit read
                        pkt_flush_used |

                        // AHB error
                        pkt_flush_ahb |

                        // Zero length buffer during multi-buffer pkt
                        pkt_flush_zero |

                        // Data buffer overflow during data state, detected
                        // as burst is finishing.
                        pkt_flush_oflow_dat |

                        // Data buffer overflow due to entering data state
                        // and already full (no request generated so force).
                        pkt_flush_oflow_ndat;

  // pkt_flush_norep is mainly used as a means of aborting the current packet fetch. It doesnt drop the
  // frame or report it as a real error (with a status writeback. It just means the TX got full and we should
  // retry it later. we could have just stayed in the data state waiting for the dpram region to become non-full
  // (i.e. wait for tx_rd to read some data out of the SRAM), but in priority queue mode, this could be ages if
  // the MAC is currently transmitting to a different queue than the TX_WR is working on.
  // What we do therefore is abort unless TX_RD is working on the same queue TX_WR is working on.
  // Note this is only used in AHB, priority queue and non cut-thru modes. AXI handles this completely
  // differently inside the AXI block itself. In cut-thru, we cant abort if we have already started processing
  // the frame (we are in the DMA_PKTDATA state) as we dont know if the TX-RD might have started reading from
  // the queue at risk.
generate if (p_edma_queues > 32'd1) begin : gen_priq_set_pkt_flush_norep
  assign pkt_flush_norep = (

                      // In Data state, we will completely break out if the DPRAM
                      // region becomes full and the MAC side of the packet buffer
                      // isnt currently reading from the same DPRAM region
                        ((dma_state_data & ~one_packet_in_buf & ~tx_cutthru &
                         (brkdatabuf_full_data | (buffer_full & ~hbusreq & ahbdataph_strobe_data))) &
                         (~queue_being_read_vld | (queue_ptr_dph != queue_being_read)))

                      | (dma_state == DMA_MANRD & buffer_full & ahbdataph_strobe_descr & first_buffer_of_pkt &
                         (~queue_being_read_vld | (queue_ptr_dph != queue_being_read)) &
                         descr_rd_done_dph & ~used_bit_read)

                      | (last_dma_state == DMA_MANWR & dma_state_data & buffer_full & ~tx_cutthru &
                         (~queue_being_read_vld | (queue_ptr_dph != queue_being_read)))

                            );
end else begin : gen_npriq_set_pkt_flush_norep
  assign pkt_flush_norep = 1'b0;
end
endgenerate


  assign pkt_flush = (pkt_flush_report | pkt_flush_norep);


  // On the last AHB access of a buffer read, calculate the number of valid
  // bytes.
  assign mod_plus_ali = first_word_of_buffer ? {1'b0,buf_has_mod}
                                             : buf_has_mod +
                                               alignment_addr;

  // calculate number of valid bytes
  always @(*)
  begin
    if (dma_bus_width[1])
    begin
      if (mod_plus_ali[3:0] == 4'h0)
        num_bytes_ahb_end = 5'b10000;
      else
        num_bytes_ahb_end = {1'h0,mod_plus_ali[3:0]};
    end
    else if (dma_bus_width[0])
    begin
      if (mod_plus_ali[2:0] == 3'h0)
        num_bytes_ahb_end = 5'b01000;
      else
        num_bytes_ahb_end = {2'h0,mod_plus_ali[2:0]};
    end
    else
    begin
      if (mod_plus_ali[1:0] == 2'h0)
        num_bytes_ahb_end = 5'b00100;
      else
        num_bytes_ahb_end = {3'h0,mod_plus_ali[1:0]};
    end
  end

  // assign tx length decrement
  always @(dma_bus_width)
  begin
    if (dma_bus_width[1])
      tx_length_decrement =  5'b10000;  // 128 bit
    else if (dma_bus_width[0])
      tx_length_decrement =  5'b01000;  // 64 bit
    else
      tx_length_decrement =  5'b00100;  // 32 bit
  end

  // Inst of Alignment buffer
  //
  // This module realigns incoming data to start at byte 0 of the word
  // This is the same alignment module as used in the non packet buffer
  // DMA implementation.
edma_pbuf_tx_align #(.p_edma_asf_dap_prot(p_edma_asf_dap_prot)) i_edma_pbuf_tx_align (

   // system signals
   .hclk                 (hclk),
   .n_hreset             (n_hreset),

   // signals coming from gem_registers
   .dma_bus_width        (dma_bus_width),

   // inputs from edma_tx
   .tx_dma_state_data    (dma_state_data),
   .tx_data_strobe       (ahbdataph_strobe_data & ~reading_pad_dph),
   .frm_val_data_phase   (1'b0),
   .hrdata               (tx_dma_data_in),
   .hrdata_par           (tx_dma_prty_in),
   .buffer_done_decode   (buffer_written),
   .last_buf_done_decode (buffer_written & buf_has_eop),
   .last_access_bytes    (num_bytes_ahb_end),
   .tx_length_decrement  (tx_length_decrement),
   .tx_buffer_offset     (alignment_addr),
   .dma_w_fifo_count     (4'd0),
   .dma_w_flush          (pkt_flush | ~enable_tx_hclk | complete_flush_hclk),
   .force_fifo_eop_err   (1'b0),

   // outputs to edma_tx
   .dma_w_data           (al_w_data[127:0]),
   .dma_w_data_par       (al_w_data[143:128]),
   .dma_w_wr             (al_w_wr),
   .dma_w_eop            (align_buf_end),
   .dma_w_mod            (al_w_mod)
   );

  // Upsize the AMBA data to the DPRAM width if the DPRAM size is 128 bits

   edma_pbuf_dpram_width_upsize #(

      .ODATA_W(p_edma_tx_pbuf_data),
      .ODATA_W_PAR(p_edma_tx_pbuf_prty)
   ) i_edma_pbuf_dpram_width_upsize (

      .clk(hclk),
      .reset_n(n_hreset),

      .iwr(al_w_wr),
      .idata(al_w_data),
      .iwidth(dma_bus_width),
      .imod(al_w_mod),
      .ieop(align_buf_end),
      .isop(1'b0),
      .iflush(pkt_flush | ~enable_tx_hclk | complete_flush_hclk),

      .owr(dpram_wr_data_en),
      .osop(),
      .odata(wdata_upsized),
      .omod(wmod_upsized));

  generate if(p_edma_tx_pbuf_prty == 8'd0) begin : gen_dp_parity_1
    assign wdata_upsized_pad =
               { 17'd0,                                                                       // no parity protection: the parity pad is zero
                 {(129-p_edma_tx_pbuf_data){1'b0}},wdata_upsized[p_edma_tx_pbuf_data-1:0]     // the data bits padded to 128 bits (bit 128 unused).
                };
  end else begin : gen_no_dp_parity_1
    assign wdata_upsized_pad =
                { {(17-p_edma_tx_pbuf_prty){1'b0}},       // the parity bits padded to 17 bits (bit 145 unused)
                  wdata_upsized[p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:p_edma_tx_pbuf_data],
                  {(129-p_edma_tx_pbuf_data){1'b0}},             // the data bits padded to 128 bits (bit 128 unused).
                  wdata_upsized[p_edma_tx_pbuf_data-1:0]
                };
  end
  endgenerate


  // Assign when there are only a few free slots left
  // The number of slots used depends on the size of the programmed burst
  // as we always allow a burst-sized gap at the top of memory to take account
  // of the inertia in fetching data from the AHB (we may have just started a
  // burst so have to allow enough space for this to complete before requesting
  // next burst).
  // buffer_full is used with 'last_access_burst_req' to stop AHB activity
  // Worst case situation is when last_access_burst_req gets set the cycle
  // before buffer_full gets set. In this case, a new AHB data burst may be
  // initiated - the last_access_burst_req of this next burst will be the one
  // that is used to drop hbusreq and stop writing into the DPRAM.
  // I.e. when buffer_full = 1 and hburst == 16-beat, there can be 16 further
  // AHB requests before hbusreq will be dropped. If there are 0 wait states,
  // 16 further requests actually means there could be 18 words of data to
  // take from the AHB memory.  If we are offsetting, then an extra word may be
  // requried to write into DPRAM - i.e. 19.
  // since 3 locations are always needed for status, ensure buffer_full always
  // gets set when there is still +3 free locations remaining - this makes 22
  // Finally, there are 3 cycles of latency in this block on the datapath, so,
  // we need to add a further 3 to take that into account.
  // Final number for 16-beat bursts = 16 + 2 + 1 + 3 + 3 = 25
  // Final number for 8-beat bursts  = 8 + 2 + 1 + 3 + 3 = 17
  // Final number for 4-beat bursts  = 4 + 2 + 1 + 3 + 3 = 13
  // For 128b sram data widths a single location in memory can contain more than
  // one AMBA word - i.e. if the dma bus width is 32 then 4 words will be stored
  // in 1, 128b word. We therefore need to adjust the calculations accordingly. A
  // caluclation for a dma_bus_width of 32bits is as follows:
  // Final number for 16-beat bursts = (16 + 2 + 1)/4 + 2 + 2 = 9
  // Final number for 8-beat bursts  = ( 8 + 2 + 1)/4 + 2 + 2 = 7
  // Final number for 4-beat bursts  = ( 4 + 2 + 1)/4 + 2 + 2 = 6

  // this function is used to stop a lot of code bloat.
  function calculate_full(

    input [4:0] ahb_burst_length,
    input [p_edma_tx_pbuf_addr-1:0] fill_lvl,
    input [1:0] dma_bus_width,
    input       edma_tx_pbuf_data_w_is_128
    );
    
    reg [16:0] fill_lvl_pad;
    
    begin
      // Adjust the fill level settings for 32b and 64b data widths when we are have
      // a 128b ram width as we can fit more than one word into each ram location
      
      fill_lvl_pad = {{(17-p_edma_tx_pbuf_addr){1'b0}},fill_lvl};
      
      if (edma_tx_pbuf_data_w_is_128 && dma_bus_width <= 2'b01)
        case (dma_bus_width[0])
          1'b0:
            calculate_full = ahb_burst_length[4] ? fill_lvl_pad <= 17'd9 : // 16-beat
                             ahb_burst_length[3] ? fill_lvl_pad <= 17'd7 : // 8-beat
                                                   fill_lvl_pad <= 17'd6;  // 4-beat
          default:
            calculate_full = ahb_burst_length[4] ? fill_lvl_pad <= 17'd14 : // 16-beat
                             ahb_burst_length[3] ? fill_lvl_pad <= 17'd10 : // 8-beat
                                                   fill_lvl_pad <= 17'd8;   // 4-beat
         endcase
      else
        calculate_full = ahb_burst_length[4] ? fill_lvl_pad <= 17'd25 : // 16-beat
                         ahb_burst_length[3] ? fill_lvl_pad <= 17'd17 : // 8-beat
                                               fill_lvl_pad <= 17'd13;  // 4-beat
 
    end
    
  endfunction

  generate for (g=0; g<p_edma_queues[31:0]; g=g+1) begin : gen_buffer_full_q
      assign buffer_full_q[g] = calculate_full(ahb_burst_length, dpram_fill_lvl_array[g],dma_bus_width,edma_tx_pbuf_data_w_is_128);
  end

  if(p_edma_queues<32'd16) begin: gen_remain
    for(g2=p_edma_queues; g2<16; g2=g2+1) begin: gen_loop
      assign buffer_full_q[g2] = 1'b0;
    end
  end
  endgenerate

  // Error condition if the buffer gets full and there is only 1 frame !
  assign buffer_full_err = one_packet_in_buf & dma_state_data & buffer_full_q[queue_ptr_dph] ;

  assign buffer_full = buffer_full_q[queue_ptr_dph]; // in AXI mode, let the AXI wrapper decide


  // Writing to DPRAM when in datastate or we are writing the pkt status
  assign dpram_wr_en   = dpram_wr_data_en | dpram_wr_stat_en;


  // Determine length of packet being written to the DPRAM
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      pkt_length_wr   <= 12'h000;
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
        pkt_length_wr     <= 12'h000;
      else if (pkt_flush_norep | (dma_state == DMA_PKTINFO & dma_pktstatus_done))
        pkt_length_wr     <= 12'h000;
      else if (dpram_wr_data_en)
        pkt_length_wr     <= pkt_length_wr + 12'h001;
    end
  end

  // Obtain the number of bytes that can be freed up
  // The DPRAM fill level can be reduced by the word length of the packet
  // once we are happy the packet has been transmitted to the line and
  // we no longer need to store this data
  always @(*)
  begin
    if (status_word_rd_0[17])
    begin
      if (edma_tx_pbuf_data_w_is_128)
        // Only 1 status words to clear
        pkt_length_rd = 12'd1;
      else if (dma_bus_width[0])
        // Only 2 status words to clear
        pkt_length_rd = 12'd2;
      else
        // Only 3 status words to clear + extra_words depending on address mode
        pkt_length_rd = 12'd3;

    end
    else
      // Pull the length from the status word, which
      // will have been written from the MAC side of the packet buffer DMA
      pkt_length_rd = status_word_rd_0[13:2];
  end



  // Free up resources due to packet completion
  wire [15:0] pkt_length_rd_pad;
  assign pkt_length_rd_pad = {4'd0, pkt_length_rd};
  assign fill_lvl_up_1 = manwr_complete
                              ? pkt_length_rd_pad[p_edma_tx_pbuf_addr-1:0]
                              : {p_edma_tx_pbuf_addr{1'b0}};

  // Free up resources due to flush condition
  wire [15:0] pkt_length_wr_pad;
  assign pkt_length_wr_pad = {4'd0, pkt_length_wr};
  assign fill_lvl_up_2 = (pkt_flush & ~(tx_cutthru & full_duplex) & dma_state != DMA_PKTINFO)
                              ? (pkt_length_wr_pad[p_edma_tx_pbuf_addr-1:0])
                              : {p_edma_tx_pbuf_addr{1'b0}};

  // Free up resources due to part of packet completion
  assign fill_lvl_up_3 = (part_pkt_read_edge)
                              ? partpkt_threshold
                              : {p_edma_tx_pbuf_addr{1'b0}};

  // For normal good packets, there are 4 status words for 32 bit datapaths and 3
  // for 64 bit - The first status word exists at address 0 of the packet.  This word
  // is repeated in the first status word at the end of the packet - this repeated
  // word is not actually written by the AHB side - it is written by the MAC side
  // instead. dpram_wr_en can be used to identify all writes to the DPRAM EXCEPT
  // for this status word - lets take this into account on the final cycle of
  // DMA_PKTINFO state
  always @(*)
  begin
    if (dma_state == DMA_PKTINFO)
    begin
      if  ( dpram_wr_stat_en |
          ((dpram_wr_data_en | (state_cnt == 3'b011)) & ~err_status[3]))
        fill_lvl_down_1 = {{p_edma_tx_pbuf_addr-1{1'b0}},1'b1};
      else
        fill_lvl_down_1 = {p_edma_tx_pbuf_addr{1'b0}};
    end
    else if (dpram_wr_en & ~err_status[3] & ~(pkt_flush & ~(tx_cutthru & full_duplex)))
      fill_lvl_down_1 = {{p_edma_tx_pbuf_addr-1{1'b0}},1'b1};
    else
      fill_lvl_down_1 = {p_edma_tx_pbuf_addr{1'b0}};
  end




  // Determine current fill level
  // A value of zero means it is FULL
  // Note that for every packet, 3 DPRAM locations (or 2 in 64 bit) are
  // required to store status information associated with that packet.
  // In some cases, there is no data associated with a packet (for errored
  // packets).  however in these cases, it is quite possible that the error
  // will only have been detected part way through fetching the packet from
  // AHB - in these cases, the pbuf resources used to store the packet data
  // are freed immediately here

  genvar g3;
  generate for (g=0; g<p_edma_queues; g=g+1) begin : gen_fill_lvl

    assign q_empty_lvl[g] = TX_PBUF_MAX_FILL_LVL_ARRAY[g];

    always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
        dpram_almost_empty[g] <= 1'b1;
      else
        // dpram_almost_empty is used by the MAC side to understand when an
        // underflow is near - it is only relevant for cut-thru modes.
        // This happens when we are reading faster than we are writing in, and
        // we can identify this condition by checking the dpram_fill_lvl against
        // the partpkt_threshold value
        // Assumes threshold is 16, or 2**4
        // If we have a 128b wide FIFO then reduce the comparison to 8 as each
        // location contains tat least 2 MAC words.
        if (edma_tx_pbuf_data_w_is_128)
          dpram_almost_empty[g] <= dpram_fill_lvl_array[g][p_edma_tx_pbuf_addr-1:3] == q_empty_lvl[g][p_edma_tx_pbuf_addr-1:3];
        else
          dpram_almost_empty[g] <= dpram_fill_lvl_array[g][p_edma_tx_pbuf_addr-1:4] == q_empty_lvl[g][p_edma_tx_pbuf_addr-1:4];

    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        dpram_fill_lvl_array[g]  <= {(p_edma_tx_pbuf_addr){1'b1}};
      else

        if (~enable_tx_hclk | complete_flush_hclk)
          // Should only change fill level when TX is disabled
          dpram_fill_lvl_array[g] <= TX_PBUF_MAX_FILL_LVL_ARRAY[g];
        else
          // On the AHB side of the PBUF, the DPRAM fill level will
          // decrease when valid data is written from AHB.  If there
          // is a packet flush event, such as an AHB error, then
          // the fill level will increase by the number of words
          // read from AHB
          //
          // On the MAC side of the PBUF, the DPRAM fill level will
          // decrease when it has indicated that it no longer requires
          // the data(packet is transmitted to the MAC).

          // Descriptor Writeback - indicates we are done with the packet data
          // and the packet status - clear the lot
          dpram_fill_lvl_array[g] <= dpram_fill_lvl_array[g] + fill_lvl_inc[g] - fill_lvl_dec[g];
    end
    wire  [p_edma_tx_pbuf_addr+1:0] fill_lvl_inc_c; // Amount to increment
    assign fill_lvl_inc_c     = (fill_lvl_up_1   & ({(p_edma_tx_pbuf_addr){(queue_being_read_manwr == g[3:0])}}))
                              + (fill_lvl_up_2   & ({(p_edma_tx_pbuf_addr){(queue_being_written == g[3:0])}}))
                              + (fill_lvl_up_3   & ({(p_edma_tx_pbuf_addr){(part_pkt_queue  == g[3:0])}}));
    assign fill_lvl_inc[g]  = fill_lvl_inc_c[p_edma_tx_pbuf_addr-1:0];
    assign fill_lvl_dec[g]  = (fill_lvl_down_1 & ({(p_edma_tx_pbuf_addr){(queue_being_written == g[3:0])}}));
  end

  if(p_edma_queues<32'd16) begin: gen_fill_lvl_others
    for(g3=p_edma_queues; g3<16; g3=g3+1) begin: gen_loop
      assign q_empty_lvl[g3] = {p_edma_tx_pbuf_addr{1'b0}};
    end
  end
  endgenerate





  // implement a state counter for the TCP and WRITEBACK states
  assign state_cnt_nxt  = (state_cnt + 3'b001);

  // writing packet status occurs in DMA_PKTINFO state
  // but since the first few cycles of this state might include actual packet writes,
  // we need to gate these out
  // Also hold at 0 when we are waiting for descriptor read state to
  // finish (this is only needed when a pkt_flush event occured)
  assign dpram_pktinfo_wr = (dma_state == DMA_PKTINFO &
                            (err_d1 |
                            (~dpram_wr_data_en & ~ahbdataph_strobe_en_data & ~ahbdataph_strobe_d1 & ~ahbdataph_strobe_en_descr & ~al_w_wr))
                             & state_cnt < 3'b110 );



  // Dont include the cycles where TCP and IP checksums are written
  // At the first state we don't write any data to the ram in 128 bit DPRAM mode
  // In 32b data bus and we will just 3rd status word write
  // when not in 64b addr mode.
  // Calculate next state_cnt depending on data to write to dpram.
  // This essentially jumps over unused states
  // Note: word3 is extra status word for upper 32b of ahb address if required
  // so is jumped if not used
  // state_cnt value  descr

  // 000  write status word0 32b, word0/1 for 64b
  // 001  write status word1 for 32b, word2/3 for 64b, word0/1/2/3 for 128b
  // 010  write status word2 for 32b
  // 011  write TCP / IP if required
  // 100  write TCP / IP if required
  //

  assign dpram_wr_stat_en =  (dpram_pktinfo_wr & state_cnt == 3'b000 & edma_tx_pbuf_data_w_is_128)
                             ? 1'b0 : (dpram_pktinfo_wr & state_cnt < 3'b011);

  always @ (posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      state_cnt <= 3'b000;

    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
        state_cnt <= 3'b000;

      // Hold at 0 when we are actually writing PKT data or waiting for
      // descriptor read state to finish (this is only needed when
      // a pkt_flush event occured)
      else if (dma_state == DMA_PKTINFO & ~dpram_pktinfo_wr)
        state_cnt <= 3'b000;

      else
      begin
        // For DMA_PKTINFO state, we need to write the pkt status to the DPRAM
        // and write the TCP and IP checksum values to the DPRAM
        // In 32 bit mode, there are 3 status writes (using states 0 to 2)
        // In 64 bit mode, there are 2 status writes (using states 0 to 1)
        // I.e. state cnts = 2 is not used in 64 bit mode (simply jump over)
        // The IP and TCP checksum values are always written when state_cnt = 3 or 4
        // state_cnt is reset once the status writes and the TCP/IP checksum updates
        // are complete
        // There is a further state required to reset the address to the end of the
        // current packet
        if (dma_state == DMA_PKTINFO)
        begin

          if (dma_bus_width[0]|edma_tx_pbuf_data_w_is_128) // 128 or 64 bit
          begin
            // Check if we need to insert IP or TCP checksums ..
            if (~((tcp_hdr_cs_we & generate_tcp_csum) |
                  (ip_hdr_cs_we  & generate_ip_csum)))
            begin
              if (state_cnt == 3'b011)
                state_cnt <= 3'b000;
              else if (state_cnt == 3'b001)
                state_cnt <= 3'b011;  // Jump over 2
              else
                state_cnt <= state_cnt_nxt;
            end
            else if (state_cnt == 3'b001)
              state_cnt <= 3'b011;  // Jump over 2
            else
              state_cnt <= state_cnt_nxt;
          end

          else // 32 bit
          begin
            // Check if we need to insert IP or TCP checksums ..
            if (~((tcp_hdr_cs_we & generate_tcp_csum) |
                  (ip_hdr_cs_we  & generate_ip_csum)))
            begin
              if (state_cnt == 3'b011)
                state_cnt <= 3'b000;
              else
                state_cnt <= state_cnt_nxt;
            end
            else
              state_cnt <= state_cnt_nxt;
          end
        end

        else
          state_cnt <= 3'b000;
      end
    end
  end

  // -----------------------------------------------------
  // Write to DPRAM
  //
  // Reverse bytes of IP and TCP/UDP checksums bus to make the
  // calculation logic easier
  wire  [143:0] ip_hdr_cs_end;          // Padded ip_hdr_cs to 64-bits
  wire  [143:0] tcp_hdr_cs_pad;         // Padded tcp_hdr_cs to 64-bits
  assign ip_hdr_cs_end[127:0] = {ip_hdr_cs[119:112],ip_hdr_cs[127:120],
                          ip_hdr_cs[103:96],ip_hdr_cs[111:104],
                          ip_hdr_cs[87:80],ip_hdr_cs[95:88],
                          ip_hdr_cs[71:64],ip_hdr_cs[79:72],
                          ip_hdr_cs[55:48],ip_hdr_cs[63:56],
                          ip_hdr_cs[39:32],ip_hdr_cs[47:40],
                          ip_hdr_cs[23:16],ip_hdr_cs[31:24],
                          ip_hdr_cs[7:0],ip_hdr_cs[15:8]};
  // This is simple databyte reordering and the parity
  // bits should therefore be reordered consistently
  assign ip_hdr_cs_end[128+15:128+0] = {ip_hdr_cs[128+14],ip_hdr_cs[128+15],
                          ip_hdr_cs[128+12],ip_hdr_cs[128+13],
                          ip_hdr_cs[128+10],ip_hdr_cs[128+11],
                          ip_hdr_cs[128+8],ip_hdr_cs[128+9],
                          ip_hdr_cs[128+6],ip_hdr_cs[128+7],
                          ip_hdr_cs[128+4],ip_hdr_cs[128+5],
                          ip_hdr_cs[128+2],ip_hdr_cs[128+3],
                          ip_hdr_cs[128+0],ip_hdr_cs[128+1]};
  assign tcp_hdr_cs_pad[127:0] = {tcp_hdr_cs[119:112],tcp_hdr_cs[127:120],
                           tcp_hdr_cs[103:96],tcp_hdr_cs[111:104],
                           tcp_hdr_cs[87:80],tcp_hdr_cs[95:88],
                           tcp_hdr_cs[71:64],tcp_hdr_cs[79:72],
                           tcp_hdr_cs[55:48],tcp_hdr_cs[63:56],
                           tcp_hdr_cs[39:32],tcp_hdr_cs[47:40],
                           tcp_hdr_cs[23:16],tcp_hdr_cs[31:24],
                           tcp_hdr_cs[7:0],tcp_hdr_cs[15:8]};
  // This is simple databyte reordering and the parity
  // bits should therefore be reordered consistently
  assign tcp_hdr_cs_pad[128+15:128+0] = {tcp_hdr_cs[128+14],tcp_hdr_cs[128+15],
                           tcp_hdr_cs[128+12],tcp_hdr_cs[128+13],
                           tcp_hdr_cs[128+10],tcp_hdr_cs[128+11],
                           tcp_hdr_cs[128+8],tcp_hdr_cs[128+9],
                           tcp_hdr_cs[128+6],tcp_hdr_cs[128+7],
                           tcp_hdr_cs[128+4],tcp_hdr_cs[128+5],
                           tcp_hdr_cs[128+2],tcp_hdr_cs[128+3],
                           tcp_hdr_cs[128+0],tcp_hdr_cs[128+1]};

  // In cut-thru mode it's possible for the first status word (at the start of frame)
  // and the last status words (at the end of frame) to have the same same address.
  // In this case we will increment the pkt_end_addr by an extra 1 or 2 to avoid writing
  // to the same location. We also need to take into account the various dma bus widths
  // as 32 bit modes uses 3 locations for status, 64 bit mode uses 2 and 128 bit mode uses
  // 1.

  assign pkt_end_addr_p2_eq_status_add_0 = edma_tx_pbuf_data_w_is_128 || dma_bus_width == 2'b10
                                           ? 1'b0 // doesn't Apply for 128 bit mode
                                           : tx_cutthru
                                             ? dpram_addr_p2[p_edma_tx_pbuf_addr-1:0] == status_add_0
                                             : 1'b0;
  assign pkt_end_addr_p3_eq_status_add_0 = edma_tx_pbuf_data_w_is_128 || dma_bus_width != 2'b00
                                           ? 1'b0 // Plus 3 for the status words only applies in 32 bit mode
                                           : tx_cutthru
                                             ? dpram_addr_p3[p_edma_tx_pbuf_addr-1:0] == status_add_0
                                             : 1'b0;
  wire [16:0] pkt_end_addr_p2;
  wire [16:0] pkt_end_addr_p3;
  wire [16:0] pkt_end_addr_p4;

  assign      pkt_end_addr_p2 = {{(17-p_edma_tx_pbuf_addr){1'b0}},pkt_end_addr} + 17'd2;
  assign      pkt_end_addr_p3 = {{(17-p_edma_tx_pbuf_addr){1'b0}},pkt_end_addr} + 17'd3;
  assign      pkt_end_addr_p4 = {{(17-p_edma_tx_pbuf_addr){1'b0}},pkt_end_addr} + 17'd4;
  
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      writing_status_dpram  <= 1'b0;
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
        writing_status_dpram  <= 1'b0;
      else if (dma_state == DMA_PKTINFO & dpram_pktinfo_wr)
        writing_status_dpram <= |dma_bus_width    ? state_cnt == 3'b001
                                                  : state_cnt == 3'b010;
    end
  end


  always @(*)
  begin
    status_add_0_c  = status_add_0;
    dpram_addr_c    = dpram_addr;
    pkt_end_addr_c  = pkt_end_addr;
    pkt_end_mod_c   = pkt_end_mod;

    // The first word written to DPRAM will be some status that will be required
    // by the MAC side of the packet buffer - Note that this status is
    // actually repeated with more status information at the end of the packet.
    // the reason it is repeated ike this is because we want to be able to
    // overwrite the beginning of the packet once it has been read to make
    // best use of the dual port RAM
    // Descriptor Read for the first buffer of a multibuffer frame
    // or the only buffer of a non-multibuffer frame
    // The only time we dont want to write the status in is when
    // we are ditching the information from AHB altogether.
    // This happens ONLY when we are reading a zero length frame
    // (on the 1st buffer and with the EOP bit set)
    // we initiate this write on the first AHB descriptor read ...
    if (dma_state == DMA_MANRD & ahbdataph_strobe_descr & ~manrd_done &
        first_buffer_of_pkt &

        // Zero length error
        // even if it is a zero length frame, we want to write status if
        // the used bit is set, so ...
        ((descr_rd_done_dph & ~zero_len_buf_eop & ~used_bit_read & priq_descr_rd_notusedfull) |
        (used_bit_read & all_queues_checked & used_bit_read_all)))

    begin
      // Need to update the status at some point in the future - keep track of the
      // status address
      status_add_0_c = dpram_addr;

      // Set the address to the start of the actual packet data
      // The PACKET data will reside in the next location.
      // We need to reserve 1 location for PACKET STATUS which will
      // be used by the MAC side of the packet buffer.
      if (~pkt_flush)
        dpram_addr_c = dpram_addr_p1[p_edma_tx_pbuf_addr-1:0];

    end


    // Usually the address to the DPRAM write Interface will simply
    // post increment after a valid access.  However, when there has
    // been a serious error condition in the hclk domain, the address
    // needs to be pulled back to the start of the packet
    // For MANRD's, we only want to do this if it is not the first buffer of the
    // packet - we dont need to because the address is already at the
    // start of the packet, but also because status_add_0 is not setup properly
    // for errors on the first buffers manrd
    else if (pkt_flush & ~(tx_cutthru & full_duplex))
    begin
      if ((dma_state_man_rd & ~first_buffer_of_pkt) | dma_state_data)
        dpram_addr_c = status_add_0;
    end

    // The end of packet actually occurs in DMA_PKTINFO state(as the states
    // change based on an earlier pipeline than the returned read data)
    // , rather than DMA_PKTDATA state, so just gate the end of
    // packet in here
    else if (dma_state == DMA_PKTINFO & dpram_pktinfo_wr)
    begin
      case (state_cnt)
      3'b000   :
      begin
        if (err_status[3])
          // When there is status only, we need to point the end
          // address to 1 below the current status_add_0
          // This is because there is no replication of status for status
          // only frames, and for the writeback the status that is read is
          // always 1 + pkt_end_addr
          pkt_end_addr_c = status_add_0 - 10'd1;
        else if (dpram_wr_data_en_d1)   // End of Packet Address
        begin
          if (pkt_end_addr_p3_eq_status_add_0)
            pkt_end_addr_c = dpram_addr_p2[p_edma_tx_pbuf_addr-1:0];
          else if (pkt_end_addr_p2_eq_status_add_0)
            pkt_end_addr_c = dpram_addr_p1[p_edma_tx_pbuf_addr-1:0];
          else
            pkt_end_addr_c = dpram_addr;
        end
        else
        begin
          if (pkt_end_addr_p3_eq_status_add_0)
            pkt_end_addr_c = dpram_addr_p1[p_edma_tx_pbuf_addr-1:0];
          else if (pkt_end_addr_p2_eq_status_add_0)
            pkt_end_addr_c = dpram_addr;
          else
            pkt_end_addr_c = dpram_addr - {{p_edma_tx_pbuf_addr-1{1'b0}},1'b1};
        end
        pkt_end_mod_c  = final_mod[3:0];

        // Place the address for the 2nd status write into dpram_addr
        // Status Word 0 is not actually ready for writing until the
        // next cycle. But we can write the 2nd status word NOW -
        // Remember statusword 0 resides in the very first location
        // and is repeated in the first location following EOP(unless
        // there was an error - in these cases, the data is NOT repeated
        // to simplify the MAC side of the buffer).
        // Therefore the 2nd status word resides in dpram_addr + 2
        // or dpram_addr + 1 for frames with only status
        if (edma_tx_pbuf_data_w_is_128)
          dpram_addr_c     = status_add_0;
        else if (err_status[3])
          dpram_addr_c     = status_add_0 + 10'd1;
        else if (dpram_wr_data_en_d1)   // End of Packet Address
        begin
          if (pkt_end_addr_p3_eq_status_add_0)
            dpram_addr_c = dpram_addr_p4[p_edma_tx_pbuf_addr-1:0];
          else if (pkt_end_addr_p2_eq_status_add_0)
            dpram_addr_c = dpram_addr_p3[p_edma_tx_pbuf_addr-1:0];
          else
            dpram_addr_c = dpram_addr_p2[p_edma_tx_pbuf_addr-1:0];
        end
        else
        begin
          if (pkt_end_addr_p3_eq_status_add_0)
            dpram_addr_c = dpram_addr_p3[p_edma_tx_pbuf_addr-1:0];
          else if (pkt_end_addr_p2_eq_status_add_0)
            dpram_addr_c = dpram_addr_p2[p_edma_tx_pbuf_addr-1:0];
          else
            dpram_addr_c = dpram_addr_p1[p_edma_tx_pbuf_addr-1:0];
        end
      end

      3'b001   :
      // The first status word can be written here - this is written to the
      // location immediately preceding the start of the packet data...
        dpram_addr_c = status_add_0;

      3'b010   :
      // This state only entered in 32bit
      // The third status word is written to the pkt_end_addr + 3 location
        dpram_addr_c =  pkt_end_addr_p3[p_edma_tx_pbuf_addr-1:0];

      3'b011   : 
      begin
        if (dma_pktstatus_done)
        begin
          // reset to the start of the next packet
          if (edma_tx_pbuf_data_w_is_128)
            dpram_addr_c = pkt_end_addr_p2[p_edma_tx_pbuf_addr-1:0];
          else if (dma_bus_width[0])
            dpram_addr_c = pkt_end_addr_p3[p_edma_tx_pbuf_addr-1:0];
          else
            dpram_addr_c = pkt_end_addr_p4[p_edma_tx_pbuf_addr-1:0];
        end
        else
          dpram_addr_c  = ip_hdr_cs_addr;
      end

      3'b100  : dpram_addr_c = tcp_hdr_cs_addr;

      default :
      begin
        // reset to the start of the next packet
        if (edma_tx_pbuf_data_w_is_128)
          dpram_addr_c = pkt_end_addr_p2[p_edma_tx_pbuf_addr-1:0];
        else if (dma_bus_width[0])
          dpram_addr_c = pkt_end_addr_p3[p_edma_tx_pbuf_addr-1:0];
        else
          dpram_addr_c = pkt_end_addr_p4[p_edma_tx_pbuf_addr-1:0];
      end
      endcase
    end


    // Post increment on the last cycle of the data state
    // And jump over the reserved status word if cutthru is enabled
    else if (dpram_wr_data_en_d1)
    begin
      if (dpram_addr_p1[p_edma_tx_pbuf_addr-1:0] == status_add_0)
        dpram_addr_c    = dpram_addr_p2[p_edma_tx_pbuf_addr-1:0];
      else
        dpram_addr_c    = dpram_addr_p1[p_edma_tx_pbuf_addr-1:0];
    end

    // The address to the DPRAM should not change for the first access
    // of the data
    else
      dpram_addr_c    = dpram_addr;

  end


  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      pkt_end_addr          <= {p_edma_tx_pbuf_addr{1'b0}};
      pkt_end_mod           <= 4'h0;
      status_add_0          <= {p_edma_tx_pbuf_addr{1'b0}};
    end
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
      begin
        pkt_end_addr         <= {p_edma_tx_pbuf_addr{1'b0}};
        pkt_end_mod          <= 4'h0;
        status_add_0         <= {p_edma_tx_pbuf_addr{1'b0}};
      end
      else
      begin
        pkt_end_addr          <= pkt_end_addr_c;
        pkt_end_mod           <= pkt_end_mod_c;
        status_add_0          <= status_add_0_c;
      end
    end
  end


  // This function ensures a queue's upper address bits stay within its
  // upper and lower address limits. dpram_addr_c will automatically increment
  // on to the next address, which could be into the next queue's segment
  // space. We therefore stop this happening by checking the segment bounds.

  function              [p_edma_tx_pbuf_addr-1:0] bind2queueRange (
    input               [p_edma_tx_pbuf_addr-1:0] addr,
    input [p_edma_tx_pbuf_queue_segment_size-1:0] q_upper_bound, // Upper bound for segment
    input [p_edma_tx_pbuf_queue_segment_size-1:0] q_lower_bound, // Lower bound for segment
    input                                   [4:0] q_num_segments // Number of segments for the queue
    ); 
    
    reg [p_edma_tx_pbuf_queue_segment_size+p_edma_tx_pbuf_addr-1:0] segment_addr_bits_pad;
    reg                     [p_edma_tx_pbuf_queue_segment_size-1:0] q_segment_mask;
    reg                     [p_edma_tx_pbuf_queue_segment_size-1:0] segment_addr_bits;
    reg                     [p_edma_tx_pbuf_queue_segment_size-1:0] segment_addr_bits_m_q_lower_bound;
    reg                       [p_edma_tx_pbuf_queue_segment_size:0] bind2queueRange_int2;
    reg                                   [p_edma_tx_pbuf_addr-1:0] bind2queueRange_int;

  begin
    // A queue's segment range is always a power of 2 number so calculate the mask to keep
    // within the power of 2 range.
    q_segment_mask = q_num_segments-5'd1;
    // Get the segment address bits for the address coming in.
    segment_addr_bits_pad = addr >> (p_edma_tx_pbuf_addr - p_edma_tx_pbuf_queue_segment_size);
    segment_addr_bits = segment_addr_bits_pad[p_edma_tx_pbuf_queue_segment_size-1:0];

    // We don't touch the lower address bits so default the output and then later on
    // we will change the upper address bits.
    bind2queueRange_int = addr;

    segment_addr_bits_m_q_lower_bound = (segment_addr_bits - q_lower_bound);
    bind2queueRange_int2 = (segment_addr_bits_m_q_lower_bound & q_segment_mask) + q_lower_bound;

    // If the queue is not within its bounds then bind the queue back to its bounds.
    if (addr[p_edma_tx_pbuf_addr-1:p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size] > q_upper_bound ||
        addr[p_edma_tx_pbuf_addr-1:p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size] < q_lower_bound)
      // If the queue only has one segment then default to the lower address
    begin
      if (q_num_segments == 5'd1)
        bind2queueRange_int[p_edma_tx_pbuf_addr-1:p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size] = q_lower_bound;
      // Bind the queue to the correct position within its address bounds
      else
        bind2queueRange_int[p_edma_tx_pbuf_addr-1:p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size] =
        bind2queueRange_int2[p_edma_tx_pbuf_queue_segment_size-1:0];
    end

    bind2queueRange = bind2queueRange_int;

  end
  endfunction

generate if (p_edma_queues > 32'd1) begin : gen_priq_set_dpram_addr
  integer       j;

  // The function bind2queueRange wants a p_edma_tx_pbuf_addr length vector.
  // dpram_addr + 1 is a p_edma_tx_pbuf_addr + 1 length vector
  // Therefore before passing it to the function we have to truncate the MSB.

  wire    [p_edma_tx_pbuf_addr:0] f_dpram_addr_p1;
  wire    [p_edma_tx_pbuf_addr:0] f_dpram_addr_p2;
  wire    [p_edma_tx_pbuf_addr:0] f_dpram_addr_p3;
  wire    [p_edma_tx_pbuf_addr:0] f_dpram_addr_p4;
  wire  [p_edma_tx_pbuf_addr-1:0] f1_dpram_addr_p1;
  wire  [p_edma_tx_pbuf_addr-1:0] f1_dpram_addr_p2;
  wire  [p_edma_tx_pbuf_addr-1:0] f1_dpram_addr_p3;
  wire  [p_edma_tx_pbuf_addr-1:0] f1_dpram_addr_p4;

  assign f_dpram_addr_p1  = dpram_addr + {{(p_edma_tx_pbuf_addr-1){1'b0}},1'd1};
  assign f_dpram_addr_p2  = dpram_addr + {{(p_edma_tx_pbuf_addr-2){1'b0}},2'd2};
  assign f_dpram_addr_p3  = dpram_addr + {{(p_edma_tx_pbuf_addr-2){1'b0}},2'd3};
  assign f_dpram_addr_p4  = dpram_addr + {{(p_edma_tx_pbuf_addr-3){1'b0}},3'd4};
  assign f1_dpram_addr_p1 = f_dpram_addr_p1 [p_edma_tx_pbuf_addr-1:0];
  assign f1_dpram_addr_p2 = f_dpram_addr_p2 [p_edma_tx_pbuf_addr-1:0];
  assign f1_dpram_addr_p3 = f_dpram_addr_p3 [p_edma_tx_pbuf_addr-1:0];
  assign f1_dpram_addr_p4 = f_dpram_addr_p4 [p_edma_tx_pbuf_addr-1:0];

  reg  [p_edma_tx_pbuf_addr-1:0] tx_addr_q     [p_edma_queues-1:0]; // Stored address of all queues
  wire [p_edma_tx_pbuf_addr-1:0] tx_addr_q_pad [15:0];              // Padded version for the reg above
  assign dpram_addr_p1[p_edma_tx_pbuf_addr-1:0]    = bind2queueRange(f1_dpram_addr_p1,
                                            TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[queue_ptr_dph],
                                            TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[queue_ptr_dph],
                                            TX_PBUF_NUM_SEGMENTS_ARRAY[queue_ptr_dph]);
  assign dpram_addr_p2[p_edma_tx_pbuf_addr-1:0]    = bind2queueRange(f1_dpram_addr_p2,
                                            TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[queue_ptr_dph],
                                            TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[queue_ptr_dph],
                                            TX_PBUF_NUM_SEGMENTS_ARRAY[queue_ptr_dph]);
  assign dpram_addr_p3[p_edma_tx_pbuf_addr-1:0]    = bind2queueRange(f1_dpram_addr_p3,
                                            TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[queue_ptr_dph],
                                            TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[queue_ptr_dph],
                                            TX_PBUF_NUM_SEGMENTS_ARRAY[queue_ptr_dph]);
  assign dpram_addr_p4[p_edma_tx_pbuf_addr-1:0]    = bind2queueRange(f1_dpram_addr_p4,
                                            TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[queue_ptr_dph],
                                            TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[queue_ptr_dph],
                                            TX_PBUF_NUM_SEGMENTS_ARRAY[queue_ptr_dph]);

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      begin
        for (j=0; j<p_edma_queues; j=j+1)
          tx_addr_q[j] <= 0;
      end
    else
      begin
        if (~enable_tx_hclk | complete_flush_hclk)
          for (j=0; j<p_edma_queues[31:0]; j=j+1)
          begin
            tx_addr_q[j][p_edma_tx_pbuf_addr-1:p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size] <= TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[j];
            tx_addr_q[j][p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size-1:0] <= {p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size{1'b0}};
          end
        else
        begin
          for (j=0; j<p_edma_queues[31:0]; j=j+1)
            if (queue_ptr_dph == j[3:0])
              tx_addr_q[j] <= bind2queueRange(dpram_addr_c,
                                                      TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[queue_ptr_dph],
                                                      TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[queue_ptr_dph],
                                                      TX_PBUF_NUM_SEGMENTS_ARRAY[queue_ptr_dph]);
        end
      end
  end

  always @(*) dpram_addr = tx_addr_q_pad[queue_ptr_dph];

  genvar m;
  for(m=0; m<p_edma_queues; m=m+1) begin: gen_tx_addr_q_pad
    assign tx_addr_q_pad[m] = tx_addr_q[m];
  end

  if(p_edma_queues<32'd16) begin: gen_remainings
    genvar m1;
    for(m1=p_edma_queues; m1<16; m1=m1+1) begin: gen_loop
      assign tx_addr_q_pad[m1] = {p_edma_tx_pbuf_addr{1'b0}};
    end
  end

end else begin : gen_npriq_set_dpram_addr
  assign dpram_addr_p1 = dpram_addr + 1;
  assign dpram_addr_p2 = dpram_addr + 2;
  assign dpram_addr_p3 = dpram_addr + 3;
  assign dpram_addr_p4 = dpram_addr + 4;
  always@(posedge hclk or negedge n_hreset)
    if (~n_hreset)
      dpram_addr <= {p_edma_tx_pbuf_addr{1'b0}};
    else if (~enable_tx_hclk | complete_flush_hclk)
      dpram_addr <= {p_edma_tx_pbuf_addr{1'b0}};
    else
      dpram_addr <= dpram_addr_c;

end
endgenerate

  assign tx_addra = dpram_addr;

  // the following few lines are to remove some lint warnings ...
  wire [127:0] status_word_wr_3_2_1_0;
  wire [127:0] status_word_wr_3_2;
  wire [127:0] status_word_wr_1_0;
  wire [127:0] status_word_wr_2_pad;
  wire [127:0] status_word_wr_1_pad;
  wire [127:0] status_word_wr_0_pad;
  assign status_word_wr_3_2_1_0 = {status_word_wr_3,status_word_wr_2,status_word_wr_1,status_word_wr_0};
  assign status_word_wr_3_2   = {{64{1'b0}},status_word_wr_3,status_word_wr_2};
  assign status_word_wr_1_0   = {{64{1'b0}},status_word_wr_1,status_word_wr_0};
  assign status_word_wr_2_pad = {{96{1'b0}},status_word_wr_2};
  assign status_word_wr_1_pad = {{96{1'b0}},status_word_wr_1};
  assign status_word_wr_0_pad = {{96{1'b0}},status_word_wr_0};
  // parity generator
  wire [3:0] status_word_wr_0_par;
  wire [3:0] status_word_wr_1_par;
  wire [3:0] status_word_wr_2_par;
  wire [3:0] status_word_wr_3_par;
  wire [15:0] status_word_wr_3_2_1_0_par;
  wire [15:0] status_word_wr_3_2_par;
  wire [15:0] status_word_wr_1_0_par;
  wire [15:0] status_word_wr_2_pad_par;
  wire [15:0] status_word_wr_1_pad_par;
  wire [15:0] status_word_wr_0_pad_par;
  assign status_word_wr_3_2_1_0_par = {status_word_wr_3_par,status_word_wr_2_par,status_word_wr_1_par,status_word_wr_0_par};
  assign status_word_wr_3_2_par     = {{8{1'b0}},status_word_wr_3_par,status_word_wr_2_par};
  assign status_word_wr_1_0_par     = {{8{1'b0}},status_word_wr_1_par,status_word_wr_0_par};
  assign status_word_wr_2_pad_par   = {{12{1'b0}},status_word_wr_2_par};
  assign status_word_wr_1_pad_par   = {{12{1'b0}},status_word_wr_1_par};
  assign status_word_wr_0_pad_par   = {{12{1'b0}},status_word_wr_0_par};

generate if (p_edma_pbuf_cutthru == 1) begin : gen_priq_set_cuthru_status
  assign cutthru_status_word = {status_add_0,status_word_wr_2,status_word_wr_1,status_word_wr_0};
end else begin : gen_npriq_set_cuthru_status
  assign cutthru_status_word = {p_edma_tx_pbuf_addr+96{1'b0}};
end
endgenerate

  wire [p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:0] tx_dia_wdata_upsized_pad;
  wire [p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:0] tx_dia_ip_hdr_cs_end;
  wire [p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:0] tx_dia_tcp_hdr_cs_pad;
  wire [p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:0] tx_dia_state_cnt_zero;
  wire [p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:0] tx_dia_state_cnt_1st;
  wire [p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:0] tx_dia_state_cnt_2nd;
  generate if (p_edma_tx_pbuf_prty == 8'd0) begin : gen_dp_parity_2
    assign tx_dia_wdata_upsized_pad = wdata_upsized_pad[p_edma_tx_pbuf_data-1:0];
    assign tx_dia_ip_hdr_cs_end     = ip_hdr_cs_end[p_edma_tx_pbuf_data-1:0];
    assign tx_dia_tcp_hdr_cs_pad    = tcp_hdr_cs_pad[p_edma_tx_pbuf_data-1:0];
    assign tx_dia_state_cnt_zero    =
               |dma_bus_width            ? status_word_wr_3_2[p_edma_tx_pbuf_data-1:0]
                                         : status_word_wr_1_pad[p_edma_tx_pbuf_data-1:0];
    assign tx_dia_state_cnt_1st     =
               edma_tx_pbuf_data_w_is_128 ? status_word_wr_3_2_1_0[p_edma_tx_pbuf_data-1:0]
                                          : |dma_bus_width   ? status_word_wr_1_0[p_edma_tx_pbuf_data-1:0]
                                                             : status_word_wr_0_pad[p_edma_tx_pbuf_data-1:0];
    assign tx_dia_state_cnt_2nd     = status_word_wr_2_pad[p_edma_tx_pbuf_data-1:0];
  end else begin  : gen_no_dp_parity_2
    assign tx_dia_wdata_upsized_pad =
                  { wdata_upsized_pad[p_edma_tx_pbuf_prty+129-1:129],   // passing parity from bit 128 to last bits
                    wdata_upsized_pad[p_edma_tx_pbuf_data-1:0]};               // passing the data to lower bits
    assign tx_dia_ip_hdr_cs_end =
                  { ip_hdr_cs_end[p_edma_tx_pbuf_prty+128-1:128],   // passing parity from bit 128 to last bits
                    ip_hdr_cs_end[p_edma_tx_pbuf_data-1:0]};               // passing the data to lower bits
    assign tx_dia_tcp_hdr_cs_pad =
                  { tcp_hdr_cs_pad[p_edma_tx_pbuf_prty+128-1:128],   // passing parity from bit 128 to last bits
                    tcp_hdr_cs_pad[p_edma_tx_pbuf_data-1:0]};               // passing the data to lower bits
    assign tx_dia_state_cnt_zero    =
               |dma_bus_width ?  { status_word_wr_3_2_par[p_edma_tx_pbuf_prty-1:0],  // generated parity
                                   status_word_wr_3_2[p_edma_tx_pbuf_data-1:0]}
                              :  { status_word_wr_1_pad_par[p_edma_tx_pbuf_prty-1:0],  // generated parity
                                   status_word_wr_1_pad[p_edma_tx_pbuf_data-1:0]};
    assign tx_dia_state_cnt_1st     =
               edma_tx_pbuf_data_w_is_128 ? { status_word_wr_3_2_1_0_par[p_edma_tx_pbuf_prty-1:0],
                                              status_word_wr_3_2_1_0[p_edma_tx_pbuf_data-1:0] }
                                          : |dma_bus_width   ? { status_word_wr_1_0_par[p_edma_tx_pbuf_prty-1:0],
                                                                 status_word_wr_1_0[p_edma_tx_pbuf_data-1:0] }
                                                             : { status_word_wr_0_pad_par[p_edma_tx_pbuf_prty-1:0],
                                                                 status_word_wr_0_pad[p_edma_tx_pbuf_data-1:0] };
    assign tx_dia_state_cnt_2nd     = { status_word_wr_2_pad_par[p_edma_tx_pbuf_prty-1:0],
                                         status_word_wr_2_pad[p_edma_tx_pbuf_data-1:0]};
  end
  endgenerate

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      tx_ena_int            <= 1'b0;
      tx_wea_int            <= 1'b0;
      tx_dia                <= {p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data{1'b0}};
      dpram_wr_data_en_d1   <= 1'b0;
      ahbdataph_strobe_d1   <= 1'b0;
    end
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
      begin
        tx_ena_int            <= 1'b0;
        tx_wea_int            <= 1'b0;
        tx_dia                <= {p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data{1'b0}};
        dpram_wr_data_en_d1   <= 1'b0;
        ahbdataph_strobe_d1   <= 1'b0;
      end
      else
      begin
        dpram_wr_data_en_d1   <= dpram_wr_data_en & ~pkt_flush;
        ahbdataph_strobe_d1   <= (ahbdataph_strobe_data);

        // At reset, first packet will start filling up from address 0.  The
        // second packet should start staight after this.  If the packets are
        // max size, then the dpram may fill up before the second packet has
        // been completely read.  Once the first packet has been fully
        // transmitted, the DPRAM may wrap to complete the second packet.  Once
        // this packet has been completely read, the third packet may start
        // (DP start address will be the end address of pkt_2 + 1)
        if (pkt_flush & ~(tx_cutthru & full_duplex))
        begin
          tx_ena_int        <= 1'b0;
          tx_wea_int        <= 1'b0;
          tx_dia            <= tx_dia;
        end

        else if (dpram_wr_data_en)
        begin
          tx_ena_int    <= 1'b1;
          tx_wea_int    <= 1'b1;
          tx_dia        <= tx_dia_wdata_upsized_pad;
        end

        else if (dma_state == DMA_PKTINFO & dpram_pktinfo_wr)
        begin
          case (state_cnt)
          3'b000   :
          begin
                           // Write the 2nd status word first, as this info is ready
            tx_dia    <= tx_dia_state_cnt_zero;
            // If we are in 128 bit DPRAM mode then we don't need to do the status write
            // here.
            tx_ena_int <= ~edma_tx_pbuf_data_w_is_128;
            tx_wea_int <=1'b1;
          end
          3'b001   :
          begin
                           // for 128 bit mode we can write the entire status word in one go.
            tx_dia    <= tx_dia_state_cnt_1st;
            tx_ena_int <= 1'b1;
            tx_wea_int <=1'b1;
          end
          3'b010   : //Only required for 32 bit mode
          begin
            tx_dia     <= tx_dia_state_cnt_2nd;
            tx_ena_int <= 1'b1;
            tx_wea_int <= 1'b1;
          end
          3'b011   :
          begin
            tx_dia      <= tx_dia_ip_hdr_cs_end;
            tx_ena_int  <= (ip_hdr_cs_we & generate_ip_csum);
            tx_wea_int  <= 1'b1;
          end
          3'b100   :
          begin
            tx_ena_int  <= (tcp_hdr_cs_we & generate_tcp_csum);
            tx_dia      <= tx_dia_tcp_hdr_cs_pad;
            tx_wea_int  <= 1'b1;
           end

          default  :
          begin
            tx_ena_int  <= 1'b0;
            tx_wea_int  <= 1'b0;
            tx_dia      <= tx_dia;
          end

          endcase
        end

        else
        begin
          tx_ena_int  <= 1'b0;
          tx_dia      <= tx_dia;
        end
      end
    end
  end

  assign status_word_rd_0  = nxt_xfer_status_bus[17:0];
  assign status_word_rd_1  = nxt_xfer_status_bus[47:18];
  assign status_word_rd_2  = nxt_xfer_status_bus[73:48];
  assign status_word_rd_3  = nxt_xfer_status_bus_ts[42:0];


  // These gates should optimize out
  wire [31:0] edma_tx_pbuf_data_width = p_edma_tx_pbuf_data;
  wire [1:0]  tcp_data_width;
  assign tcp_data_width = edma_tx_pbuf_data_width[7] ? 2'b10 : dma_bus_width;

  // Zero out any data that is not valid. With a 32-bit datapath, zero out bits 127:32 etc
  wire [128:0] delayed_data_for_csum_oe;
  wire [128:0] delayed_data_gate;
  assign delayed_data_gate = tcp_data_width[1] ? {129{1'b1}} :
                             tcp_data_width[0] ? {{65{1'b0}},{64{1'b1}}} :
                                                 {{97{1'b0}},{32{1'b1}}};
  wire [16:0] delayed_data_gate_par;
  assign delayed_data_gate_par = tcp_data_width[1] ? {17{1'b1}} :
                             tcp_data_width[0] ? {{9{1'b0}},{8{1'b1}}} :
                                                 {{13{1'b0}},{4{1'b1}}};
  assign delayed_data_for_csum_oe = {{(129-p_edma_tx_pbuf_data){1'b0}},tx_dia[p_edma_tx_pbuf_data-1:0]} & delayed_data_gate;

  edma_pbuf_tx_tcp #(
                      .p_edma_tx_pbuf_addr(p_edma_tx_pbuf_addr),
                      .p_edma_spram(p_edma_spram),
                      .p_edma_asf_dap_prot(p_edma_asf_dap_prot),
                      .p_edma_axi(p_edma_axi)
                    ) i_edma_pbuf_tx_tcp (
    .hclk              (hclk),
    .n_hreset          (n_hreset),
    .soft_reset        (xfer_flush_event),

    .dpram_we          (dpram_wr_data_en),
    .dpram_din         (wdata_upsized_pad[127:0] & delayed_data_gate[127:0]),
    .dpram_din_par     (wdata_upsized_pad[144:129] & delayed_data_gate_par[15:0]),
    .dpram_addr        (dpram_addr),
    .dpram_eop         (align_buf_end),
    .dpram_din_d1      (delayed_data_for_csum_oe[127:0]),
    .man_rd_new_pkt    (dma_state_man_rd & first_buffer_of_pkt),
    .tx_pbuf_tcp_en    (tx_pbuf_tcp_en & ~str_descriptor_wr_1[16]), // TCP enabled and adding CRC to pkt
    .dma_bus_width     (tcp_data_width),

    .ip_hdr_cs_we      (ip_hdr_cs_we),
    .ip_hdr_cs         (ip_hdr_cs[127:0]),
    .ip_hdr_cs_par     (ip_hdr_cs[143:128]),
    .ip_hdr_cs_addr    (ip_hdr_cs_addr),
    .tcp_hdr_cs_we     (tcp_hdr_cs_we),
    .tcp_hdr_cs        (tcp_hdr_cs[127:0]),
    .tcp_hdr_cs_par    (tcp_hdr_cs[143:128]),
    .tcp_hdr_cs_addr   (tcp_hdr_cs_addr),
    .tcp_status        (tcp_status),

    .tx_ena_abort  (tx_ena_abort)
  );

assign tx_wea    = tx_wea_int;

// Block writes to the SPRAM when in SPRAM mode for tcp/udp accesses as the
// ram locations will be re-written later and the early writes are therefore
// unnecessary. For SPRAM mode the aim is to minimise the writes to the RAM to
// facilitate a lower ahb/axi frequency - the less writes the lower the frequency
// can go.
  assign tx_ena    = tx_ena_int & (~tx_ena_abort | p_edma_spram == 0);

// ---------------------------------------------------------------------
// STATUS writes to DPRAM - 1 per packet
//
// WORD 0
//  [31:28] = error status
//            [31] = only status with this frame
//            [30] = error was exhausted mid frame
//            [29] = tx burst error (ahb)
//            [28] = used bit was read
//  [27]    = Add CRC to packet -- needed by MAC side only -
//  [26:15] = DPRAM address of EOP -- needed by MAC side only -
//                                    can be overwritten by MAC side once it
//                                    is done with data
//  [14:12] = mod of EOP write     -- needed by MAC side only -
//                                    can be overwritten
//                                    by MAC side once it is done with data
//  [11:0]  = Number of words in pkt -- needed by MAC side only -
//                                    can be overwritten by MAC side once it
//                                    is done with data
//
// Note that BITS 26:15 are set by the MAC side to indicate the
// number of dpram locations that can be recovered after the
// packet writeback is completed
// in a similar way,
//  BIT  14 is set to 'mac_underflow' MAC error
//  BIT  13 is set to 'late_coll_occured' MAC error
//  BIT  12 is set to 'too_many_retries' MAC error
//
//
// WORD 1
//  [31]    = Reserved
//  [30]    = Add CRC to packet
//  [29:0]  = AHB Address of the first descriptor of this packet
//
//
// WORD 2   = Data stored in the first descriptor of this packet[63:32]


// The following calculation denotes the the position of the end of
// frame address. There are not enough bits in the status words to
// pass the end of frame address, so we instead calculate the end of
// frame address based on the current address. Note. The offset can
// be negative to account for frames without frame data (i.e. used
// bit read or errored status frames). When negative the end
// of frame address is one less than the status word 0 address.
// The pkt_end_addr_offset is only 3 bits as we uses the values -1, 0, 1, 2
// Note. We extend the calculation to 16 bits to account for the scenario
// where the edma_tx_pbuf_addr paramater is larger or smaller than the 12
// bits allocated for the size of frame.
wire  [16:0] pkt_end_addr_mod;
assign pkt_end_addr_mod = ({{17-p_edma_tx_pbuf_addr{1'b0}}, pkt_end_addr} -
                          {{17-p_edma_tx_pbuf_addr{1'b0}}, status_add_0} -
                           {5'd0, status_word_wr_0[11:0]}) & {{17-p_edma_tx_pbuf_addr{1'b0}}, q_empty_lvl[queue_ptr_dph]};

assign pkt_end_addr_offset = err_status[3]
                             ? 8'hff   // minus 1
                             : pkt_end_addr_mod[7:0];

assign status_word_wr_0   = {
                              err_status[3:0],                                    // 31:28
                              str_descriptor_wr_1[16],                            // 27
                              3'd0,                                               // 26:24
                              pkt_end_addr_offset,                                // 23:16
                              pkt_end_mod,                                        // 15:12
                              (err_status[3] ? 12'h000 : pkt_length_wr)           // 11:0. If we have an error set to -1
                            };

assign str_descr_ptr_wr_p1  = {upper_tx_q_base_addr, (str_descr_ptr_wr[29:0] + 30'd1)};

assign status_word_wr_1   = {
                              1'b0,
                              str_descriptor_wr_1[16],              // 30
                        //      str_descr_ptr_wr[29:0] + 30'd1        // 29:0
                              str_descr_ptr_wr_p1[29:0]            // 29:0
                            };

// Write the 64-bit descriptor so that it can be reused when we
// need it for writeback later on - Only bit 30, and [16],[15] and [13:0]
// are required
// Use [18:16] to store the tcp status of the packet in dpram locns
// Use [29:24] to store TX offload control information for TSO/UFO
assign status_word_wr_2   = { 2'b00,
                              queue_ptr_dph[3:0],
                              str_descriptor_wr_1[25:24],
                              str_descriptor_wr_1[19:17],
                              str_descriptor_wr_1[14],
                              str_descriptor_wr_1[30],
                              tcp_status[2:0],
                              str_descriptor_wr_1[16:15],
                              str_descriptor_wr_1[13:0]
                            };

assign status_word_wr_3   = {
                              str_descr_ptr_wr_p1[61:30]
                            };



assign pkt_tx_xfer_req = (last_dma_state == DMA_PKTINFO &
                          dma_state != DMA_PKTINFO) |
                         (pkt_end_flush_capt & ~pkt_end_flush);

assign part_pkt_xfer_req = ({5'd0,pkt_length_wr} ==
                            {{(17-p_edma_tx_pbuf_addr){1'b0}},tx_cutthru_threshold} &
                            tx_cutthru & full_duplex & dpram_wr_data_en);



  // ----------------------------------------------------
  // Synchronise the incoming signals from the tx_rd side
  // and generate a toggle when they change

  // Synchronize the part of frame and end of frame toggles
  cdnsdru_datasync_v1 #(
   .CDNSDRU_DATASYNC_DIN_W(p_edma_queues)
  ) i_cdnsdru_datasync_v1 (
   .clk(hclk),
   .reset_n(n_hreset),
   .din(pkt_captured),
   .dout(pkt_captured_sync));

  // Detect an edge on the incoming frame and end of frame toggles
  edma_toggle_detect #(
   .DIN_W(p_edma_queues)
  ) i_edma_toggle_detect (
   .clk(hclk),
   .reset_n(n_hreset),
   .din(pkt_captured_sync),
   .rise_edge(),
   .fall_edge(),
   .any_edge(pkt_captured_edge));

  assign xfer_flush_event = (~enable_tx_hclk | complete_flush_hclk);
  always@(posedge hclk or negedge n_hreset)
    if (~n_hreset)
    begin
      final_mod <= 4'b0000;
      pkt_end_flush_capt <= 1'b1;
    end
    else
      if (xfer_flush_event)
      begin
        final_mod <= 4'b0000;
        pkt_end_flush_capt <= 1'b1;
      end
      else
      begin
        final_mod  <= align_buf_end ? wmod_upsized[3:0] : final_mod;
        if (pkt_captured_edge[0] & pkt_end_flush)
          pkt_end_flush_capt <= 1'b0;
      end


  generate for (g=0; g<p_edma_queues; g=g+1) begin : gen_cutthru_buffer_pending

    always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
        cutthru_buffer_pending[g] <= 1'b0;
      else
        // Depending on the timing in the tx_rd block, the tx_rd block
        // may or may not see the part_pkt_trigger signal, as the
        // start_reading_at_risk signal is cleared when the tx_rd side
        // reads the status. If the tx_rd side happens to transmit a large
        // frame after a small frame then there may not be another
        // part_pkt_trigger after the status has been read for the small frame
        // has been read. This can happen if the amba side is running much
        // faster than the mac side - i.e. a small frame, followed by a
        // large frame are burst into the FIFO. There will be a number of
        // part_pkt_triggers when the large frame is being written, but in
        // this time the small frame is being transmitted on the line. Once
        // the small frame is transmitted most of the large frame is in the
        // FIFO and the FIFO is full, but an eop has not been written and the
        // part_pkt_trigger signals have therefore stopped (the part_pkt
        // signals will have been ignored during the transmission of the small
        // frame).
        // The cutthru_buffer_pending signal is therefore a very crude detect, where
        // if there is more than 50% of the buffer utilized then we flag to
        // the tx_rd side that the part buffer is full.
        //
        if (!enable_tx_hclk || complete_flush_hclk || !tx_cutthru)
          cutthru_buffer_pending[g] <= 1'b0;
        else if (dpram_fill_lvl_array[g] <= (q_empty_lvl[g]>>1) && dpram_fill_lvl_array[g] < (q_empty_lvl[g] - tx_cutthru_threshold))
          cutthru_buffer_pending[g] <= 1'b1;
        else
          cutthru_buffer_pending[g] <= 1'b0;

  end
  endgenerate


  // ----------------------------------------------------
  // Create a toggle on end_of_packet so that it can be
  // passed across clock domains to indicate a full packet is
  // ready to be read from DPRAM
  //
  generate for (g=0; g<p_edma_queues; g=g+1) begin : gen_pkt_xfers
    reg [3:0] num_pkts_xfer_local;      // Count num of packets that are ready
                                        // to be read by the RD side of PBUF
                                        // but which cannot be taken right now
    wire [4:0]  num_pkts_xfer_local_pnewreq;
    assign num_pkts_xfer_local_pnewreq =  num_pkts_xfer_local + (pkt_tx_xfer_req & queue_ptr_dph == g[3:0]);
    wire [4:0]  num_pkts_xfer_local_p1;
    assign num_pkts_xfer_local_p1 =  num_pkts_xfer_local + 4'h1;

    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
      begin
        end_of_packet_tog[g] <= 1'b0;
        part_of_packet_tog[g] <= 1'b0;
        new_pkt_capt_req[g]   <= 1'b0;
        new_part_pkt_capt_req[g] <= 1'b0;
        num_pkts_xfer[((g+1)*4)-1:g*4] <= 4'h0;
        num_pkts_xfer_local <= 4'h0;
        waiting_for_pkt_capt[g]  <= 1'b0;
        pkt_end_new[g] <= 1'b0;
      end
      else
      begin

        if (xfer_flush_event & (~waiting_for_pkt_capt[g] | pkt_captured_edge[g]))
        begin
          num_pkts_xfer_local <= 4'h0;
          num_pkts_xfer[((g+1)*4)-1:g*4] <= 4'h1;
          end_of_packet_tog[g] <= ~end_of_packet_tog[g];
          waiting_for_pkt_capt[g] <= 1'b1;
          pkt_end_new[g] <= 1'b0;
        end

        // Enough of a packet has been received by AHB and written into DPRAM
        // Inform read side of PBUF that it can now start reading the packet ...
        else if (((pkt_tx_xfer_req | part_pkt_xfer_req) & queue_ptr_dph == g[3:0]) & ~waiting_for_pkt_capt[g])
        begin
          num_pkts_xfer_local <= 4'h0;
          num_pkts_xfer[((g+1)*4)-1:g*4] <= 4'h1;
          if (pkt_tx_xfer_req)
            end_of_packet_tog[g] <= ~end_of_packet_tog[g];
          else
            part_of_packet_tog[g] <= ~part_of_packet_tog[g];
          waiting_for_pkt_capt[g]  <= 1'b1;
          pkt_end_new[g] <= ~(pkt_end_flush_capt & ~pkt_end_flush);
        end

        // MAC side has captured the information we passed over ..
        // If there have been more pkts written into DPRAM since we first
        // indicated available data, then send a new handshake
        else if (pkt_captured_edge[g])
        begin
          num_pkts_xfer_local   <= 4'h0;
          if (((pkt_tx_xfer_req | part_pkt_xfer_req) & queue_ptr_dph == g[3:0]) | new_pkt_capt_req[g] | new_part_pkt_capt_req[g])
          begin
            new_pkt_capt_req[g] <= 1'b0;
            new_part_pkt_capt_req[g] <= 1'b0;
            num_pkts_xfer[((g+1)*4)-1:g*4] <= num_pkts_xfer_local_pnewreq[3:0];
            if (new_pkt_capt_req[g] | (pkt_tx_xfer_req & queue_ptr_dph == g[3:0]))
              end_of_packet_tog[g] <= ~end_of_packet_tog[g];
            else
              part_of_packet_tog[g] <= ~part_of_packet_tog[g];
            waiting_for_pkt_capt[g] <= 1'b1;
            pkt_end_new[g] <= ~(pkt_end_flush_capt & ~pkt_end_flush);
          end
          // Not any new pkt information received, so just go quiet
          else
          begin
            num_pkts_xfer[((g+1)*4)-1:g*4] <= 4'h0;
            waiting_for_pkt_capt[g]  <= 1'b0;
            new_pkt_capt_req[g]      <= 1'b0;
            new_part_pkt_capt_req[g] <= 1'b0;
          end
        end

        // MAC side has not captured anything yet, and there has been another pkt received
        // from AHB since
        else if (pkt_tx_xfer_req & queue_ptr_dph == g[3:0])
        begin
          new_pkt_capt_req[g] <= 1'b1;
          new_part_pkt_capt_req[g] <= 1'b0;
          num_pkts_xfer_local <= num_pkts_xfer_local_p1[3:0];
        end

        // MAC side has not captured anything yet, and there has been another part received
        // from AHB since
        else if (part_pkt_xfer_req & queue_ptr_dph == g[3:0])
          new_part_pkt_capt_req[g] <= 1'b1;
      end
    end

    // end flush can only occur on Q0 -- the following code is repeated from above but is specific to Q0
    if (g == 0) begin : gen_pkt_end_flush
      always@(posedge hclk or negedge n_hreset)
      begin
        if (~n_hreset)
          pkt_end_flush <= 1'b0;
        else
        begin
          if (xfer_flush_event & (~waiting_for_pkt_capt[0] | pkt_captured_edge[0]))
            pkt_end_flush <= 1'b1;
          else if (((pkt_tx_xfer_req | part_pkt_xfer_req) & queue_ptr_dph == 4'd0) & ~waiting_for_pkt_capt[0])
            pkt_end_flush <= (pkt_end_flush_capt & ~pkt_end_flush);
          else if (pkt_captured_edge[0])
          begin
            if (((pkt_tx_xfer_req | part_pkt_xfer_req) & queue_ptr_dph == 4'd0) | new_pkt_capt_req[0] | new_part_pkt_capt_req[0])
              pkt_end_flush <= (pkt_end_flush_capt & ~pkt_end_flush);
            else
              pkt_end_flush <= 1'b0;
          end
        end
      end
    end
  end
  endgenerate

  // Signals for lockup detection
  // Generate 1-bit per queue signal to indicate used bit read and full packet written
  genvar g_loop_q;
  generate for (g_loop_q = 0; g_loop_q<p_edma_queues;g_loop_q=g_loop_q+1) begin : gen_lockup_sigs
    assign used_bit_vec[g_loop_q] = used_bit_read && (queue_ptr_dph == g_loop_q[3:0]);
    assign full_pkt_inc[g_loop_q] = (last_dma_state == DMA_PKTDATA) && (dma_state == DMA_PKTINFO) && (queue_ptr_dph == g_loop_q[3:0]);
  end
  endgenerate
  assign lockup_flush = xfer_flush_event;

// -----------------------------------------------------------------------------
// ASF - End to end data path parity protection
// -----------------------------------------------------------------------------


  /////////////////////////////////////////////////
  // ASF - end to end parity check
  generate if (p_edma_asf_dap_prot == 1) begin : gen_dp_parity
    // parity generation for rdata_pad
    wire [31:0] status_word_hrdata_parity_32b;
    cdnsdru_asf_parity_gen_v1 #(.p_data_width(256)) i_gem_par_gen_dp_status_word_hrdata(
      .odd_par(1'b0),
      .data_in( {status_word_wr_3,status_word_wr_2,status_word_wr_1,status_word_wr_0,hrdata[127:0]} ),
      .data_out(),
      .parity_out(status_word_hrdata_parity_32b)
    );
    assign  hrdata_prty            =  status_word_hrdata_parity_32b[15:0];
    assign  status_word_wr_0_par  =  status_word_hrdata_parity_32b[19:16];
    assign  status_word_wr_1_par  =  status_word_hrdata_parity_32b[23:20];
    assign  status_word_wr_2_par  =  status_word_hrdata_parity_32b[27:24];
    assign  status_word_wr_3_par  =  status_word_hrdata_parity_32b[31:28];
  end else begin : gen_no_dp_parity
    assign hrdata_prty             = 16'd0;
    assign status_word_wr_0_par   = 4'd0;
    assign status_word_wr_1_par   = 4'd0;
    assign status_word_wr_2_par   = 4'd0;
    assign status_word_wr_3_par   = 4'd0;
  end
  endgenerate

  /////////////////////////////////////////////////
  // ASF - timestamp value parity protection
  generate if (p_edma_asf_dap_prot == 1) begin : gen_ts_parity
   // Parity generation for the RX Timestamp value when taken
   cdnsdru_asf_parity_gen_v1 #(.p_data_width(256)) i_gem_par_gen_ts_descriptor_wb_word1 (
     .odd_par(1'b0),
     .data_in({224'd0,descriptor_wb_word1}),
     .data_out(),
     .parity_out(descriptor_wb_word1_prty)
   );

    // Parity check for TX Timestamp passed hwdata (outside the design)
    cdnsdru_asf_parity_check_v1 #(.p_data_width(256)) i_gem_par_chk_ts_pbuf_tx_w (
      .odd_par(1'b0),
      .data_in({128'd0,hwdata}),
      .parity_in({16'd0,hwprty}),
      .parity_err(asf_dap_tx_wr_err)
    );

  end else begin : gen_no_ts_parity
    assign descriptor_wb_word1_prty = 32'd0;
    assign asf_dap_tx_wr_err  = 1'b0;
  end
  endgenerate
  ////////////////////////////////////////////////

`ifdef ABV_ON
  // Assertion to ensure fill level never indicates overflow on TX.
  genvar  queue_loop;
  generate

    for (queue_loop = 0; queue_loop < p_edma_queues; queue_loop=queue_loop+1)
    begin : gen_assert_loop
      wire  [p_edma_tx_pbuf_addr:0] calc_result;
      assign calc_result  = dpram_fill_lvl_array[queue_loop] + fill_lvl_inc[queue_loop] - fill_lvl_dec[queue_loop];
      property fill_lvl_no_wrap;
        @(posedge hclk) disable iff ( (n_hreset != 1'b1)  ||
                                      (~enable_tx_hclk)   ||
                                      complete_flush_hclk )
        ~calc_result[p_edma_tx_pbuf_addr];
      endproperty
      AP_fill_lvl_no_wrap  : assert property (fill_lvl_no_wrap);
    end
  endgenerate

`endif
endmodule

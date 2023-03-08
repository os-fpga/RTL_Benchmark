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
//   Filename:           edma_pbuf_axi_tx_rd.v
//   Module Name:        edma_pbuf_axi_tx_rd
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
//   Description    : tx_clk domain portion of the tx packet buffer
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_pbuf_axi_tx_rd #(
   parameter p_edma_tsu                         = 1'b0,
   parameter p_edma_spram                       = 1'b0,
   parameter p_edma_pbuf_cutthru                = 1'b0,
   parameter p_edma_queues                      = 32'd1,
   parameter p_edma_tx_pbuf_data                = 32'd64,
   parameter p_edma_tx_pbuf_prty                = 8'd8,
   parameter p_edma_tx_pbuf_addr                = 32'd10,
   parameter p_emac_bus_width                   = 32'd64,
   parameter p_emac_bus_pwid                    = p_emac_bus_width/8,
   parameter p_emac_parity_width                = 8'd8,
   parameter p_edma_tx_pbuf_queue_segment_size  = 32'd2,
   parameter top_queue_id                       = p_edma_queues-1,
   parameter top_queue_id_m1                    = p_edma_queues == 32'd1 ? 32'd0
                                                                         : p_edma_queues-32'd2,
   parameter p_edma_asf_dap_prot                = 1'b0,
   parameter p_ct_width                         = p_edma_tx_pbuf_addr+32'd128,
   parameter p_ct_par_w                         = (p_ct_width+7)/8

  ) (

   input [(p_edma_tx_pbuf_queue_segment_size*p_edma_queues)-1:0] TX_PBUF_SEGMENTS_LOWER_ADDR,
   input [(p_edma_tx_pbuf_queue_segment_size*p_edma_queues)-1:0] TX_PBUF_SEGMENTS_UPPER_ADDR,
   input [(16*5)-1:0] TX_PBUF_NUM_SEGMENTS,

   // System signals
   input                              tx_r_clk,            // tx_clk for fifo read clock.
   input                              tx_r_rst_n,          // n_txreset for fifo read reset.

   input                              enable_transmit,     // soft reset

   // Fifo input signals from gem_tx
   input   [p_edma_queues-1:0]        tx_r_rd,             // gem tx requires a pop from the fifo.
   input   [p_edma_queues-1:0]        tx_r_rd_int,         // Early version
   input   [3:0]                      tx_r_queue_int,      // Queue ID, sync with tx_r_rd_int


   // Signals from MAC
   input                              dma_tx_end_tog,      // Toggle signal indicating the end of
                                                           // transmission of the oldest frame
   input                              dma_tx_small_end_tog,// Toggle signal indicating the end of
                                                           // transmission of a smal frame. Used
                                                           // for xgm only, where the xgm mac will
                                                           // automatically ignore packets <9
                                                           // bytes.
   input                              collision_occured,   // collision occurred on current frame,
                                                           // cause a restart sequence.
   input                              late_coll_occured,   // collision occurred on current frame,
                                                           // cause a restart sequence.
   input                              too_many_retries,    // signals too many retries error
                                                           // condition (flushes tx fifo),
                                                           // cleared when dma_tx_status_tog
                                                           // is returned.
   input                              underflow_frame,     // signals underflow event
                                                           // condition  (flushes tx fifo),
                                                           // cleared when dma_tx_status_tog
                                                           // is returned.
   // Outputs signals to gem_tx
   output reg                         dma_tx_status_tog,   // Signal to gem_tx that both writeback
                                                           // and pclk status update have completed.


   // Fifo output signals to gem_tx
   output reg                         tx_r_valid,          // Validates data, eop, sop after a r_rd.
   output     [p_emac_bus_width-1:0]  tx_r_data,           // Read data from FIFO (128/64/32 bits)
   output     [p_emac_bus_pwid-1:0]   tx_r_data_par,       // Parity
   output reg                         tx_r_eop,            // End of packet present on r_rd.
   output reg                         tx_r_sop,            // Start of packet present on r_rd.
   output reg  [3:0]                  tx_r_mod,            // Number of valid bytes in final access.
   output reg                         tx_r_err,            // There is a error with the current
                                                           // frame being read from the FIFO. TX
                                                           // MAC should terminate transmission.
   output reg                         tx_r_flushed,        // Flush has been asserted.
   output reg                         tx_r_underflow,      // r_rd asserted and fifo empty.
   output     [p_edma_queues-1:0]     tx_r_data_rdy,       // Enough data in FIFO to begin TX.
   output                             dma_is_busy,         // Stop Scheduler from requesting
   output reg                         tx_r_control,        // Packet control information.
   output   [p_edma_queues-1:0]       tx_r_frame_size_vld, // We have the frame size.
   output   [(p_edma_queues*14)-1:0]  tx_r_frame_size,     // Frame Length, 1 per queue
   output   [p_edma_queues-1:0]       tx_r_launch_time_vld,// We have a launch time to adhere to ..
   output   [(p_edma_queues*32)-1:0]  tx_r_launch_time,    // launch time

   // DPRAM interface
   output reg                            tx_enb,
   output reg                            tx_web,
   output reg [p_edma_tx_pbuf_addr-1:0]  tx_addrb,
   input      [127:0]                   tx_dob_pad,        // the top p_edma_tx_pbuf_prty bits are parity
   input      [15:0]                    tx_dob_par_pad,


   // AHB side of PKT BUFFER identifies that one or more
   // full (or partial if cutthru is enabled)packets are available
   // to be read
   input [p_edma_queues-1:0]          end_of_packet_tog,    // Full packet is ready to be read
   input [p_edma_queues-1:0]          part_of_packet_tog,   // Part packet is ready to be read
   input [p_edma_queues-1:0]          pkt_end_new,          // Good packet written
   input                              pkt_end_flush,        // Packet was flushed
   input [(p_edma_queues*4)-1:0]      num_pkts_xfer,
   output [p_edma_queues-1:0]         pkt_captured,
   input [p_edma_queues-1:0]          dpram_almost_empty,   // Flag identifies dpram is almost empty
   output reg                         underflow_tog,
   input                              tx_wr_seen_uflow,    // soft reset

   // MAC side of PKT BUFFER identifies how many dpram locations have been
   // completely used
   input                              xfer_status_captured, // Status was captured - signaled by
   output reg                         full_pkt_read,        // Full packet has been read from pbuff
   output reg                         part_pkt_read,        // Part packet has been read from pbuff
   output [81:0]                      xfer_status_bus,      // Status to use for writeback
   output [10:0]                      xfer_status_bus_par,
   output reg [3:0]                   part_pkt_queue,       // Full packet has been read from pbuff
   output [42:0]                      xfer_status_bus_ts,   // Status to use for writeback of timestamp
   output [5:0]                       xfer_status_bus_ts_par,// msb indicates ts_to_be_written to BD
                                                            // last 6 bits are parity bits of timestamp[41:0]
    // Static Signalling from register block
   input  [1:0]                       dma_bus_width,
   input                              full_duplex,          // full duplex signal from the NCR.
   input  [1:0]                       tx_bd_ts_mode,
   input                              bd_extended_mode_en,  // enable extended BD mode, which is used to Descriptor TS insertion

   // Timestamp for current tx packet
   input  [41:0]                      tx_timestamp,
   input   [5:0]                      tx_timestamp_prty,    // ASF - parity protection for the TX Timestamp[41:0] to DMA Descriptor

   // PTP frame decoded signals
   input                              event_frame_tx,        // sync/delay_req/pdelay_req/pdelay_resp frames
   input                              general_frame_tx,      // PTP frame which is not an event frame

   input [p_ct_width-1:0]             cutthru_status_word,
   input [p_ct_par_w-1:0]             cutthru_status_word_par,
   input                              cutthru_status_word_empty,
   output                             cutthru_status_word_pop,

   // ASF - signals going to gem_reg_top
   output   asf_dap_tx_rd_err         // data path parity error indication in tclk domain

   );

  localparam IDLE                = 3'b000;
  localparam READ_ESTATUS_WORD   = 3'b001;
  localparam PKT_DATA            = 3'b010;
  localparam READ_LSTATUS_WORD0  = 3'b011;
  localparam READ_LSTATUS_WORD2  = 3'b100;
  localparam READ_LSTATUS_WORD3  = 3'b101;
  localparam STATUS_ONLY         = 3'b110;
  localparam WAIT_FOR_STATUS     = 3'b111;

  // Determine if a word unit is increased to accomodate parity
  localparam p_dword_w           = (p_edma_asf_dap_prot  == 1) ? 36  : 32;

  // Status word0 is compressed to save space
  localparam p_sw0_cmpr_w  = (p_edma_asf_dap_prot  == 1) ? 21  : 18;

  // Bits required for timestamp store for writeback
  localparam p_wb_ts_bits  = (p_edma_tsu == 0) ? 0 : (p_edma_asf_dap_prot == 1)  ? 49  : 43;

  // Write back FIFO width depends if we are storing parity
  localparam p_wb_fifo_w = (p_edma_asf_dap_prot  == 1) ? p_wb_ts_bits + p_dword_w + p_dword_w + p_sw0_cmpr_w
                                                       : p_wb_ts_bits + p_dword_w + p_dword_w + p_sw0_cmpr_w;
  // Register and Wire Declarations
  wire [p_dword_w-1:0]            tx_dob_w0;
  wire [p_dword_w-1:0]            tx_dob_w1;
  wire [p_dword_w-1:0]            tx_dob_w2;
  wire [p_dword_w-1:0]            tx_dob_w3;
  wire [p_dword_w-1:0]            ct_fifo_w0;
  wire [p_dword_w-1:0]            ct_fifo_w1;
  wire [p_dword_w-1:0]            ct_fifo_w2;
  wire [p_dword_w-1:0]            ct_fifo_w3;
  reg                             ts_to_be_written;
  wire                            xfer_status_captured_sync;
  wire                            xfer_status_captured_edge;
  wire [p_edma_queues-1:0]        part_of_packet_tog_sync;
  wire [p_edma_queues-1:0]        end_of_packet_tog_sync;
  wire [p_edma_queues-1:0]        end_of_packet_edge;
  wire [15:0]                     dpram_almost_empty_sync;
  wire [p_edma_queues-1:0]        part_of_packet_edge;
  wire [p_edma_queues-1:0]        pkt_written;
  wire                            complete_flush;
  wire [p_edma_tx_pbuf_addr+3:0]  partpkt_threshold;
  reg  [7:0]                      num_pkts_needing_read[15:0]; // Number of pkts in buffer still needing read
  wire [7:0]                      num_pkts_needing_read_nxt[15:0]; // Number of pkts in buffer still needing read

  wire                            coll_occurred_le;
  reg  [3:0]                      queue_dma_c;
  reg  [3:0]                      queue_dma;
  reg  [3:0]                      queue_mac;
  reg  [1:0]                      num_pkts_in_mac_nxt;
  reg  [1:0]                      num_pkts_in_mac;
  reg  [1:0]                      store_mac_sw0_en;
  reg  [p_dword_w+p_edma_tx_pbuf_addr+3:0]
                                  store_1st_sw0;
  reg  [p_dword_w+p_edma_tx_pbuf_addr+3:0]
                                  store_2nd_sw0;
  wire                            pkt_mac_sent;

  reg  [15:0]                     start_reading_at_risk_q;
  reg  [15:0]                     start_reading_at_risk_q_nxt;
  reg  [2:0]                      read_state;
  reg  [2:0]                      read_state_nxt;
  reg                             read_state_tr_idle2data;
  reg                             sample_sw0;
  reg                             sample_cut_thru_sw;
  reg  [p_dword_w-1:0]            status_word_0;
  reg  [p_dword_w-1:0]            status_word_2;
  reg  [p_dword_w-1:0]            status_word_3;
  wire [p_dword_w-1:0]            status_word_mac_0;
  wire [p_dword_w-1:0]            status_word_mac_2;
  wire [p_dword_w-1:0]            status_word_mac_3;
  reg  [p_edma_tx_pbuf_addr-1:0]  status_word0_add_int;
  wire [p_edma_tx_pbuf_addr-1:0]  status_word0_add;
  wire [p_edma_tx_pbuf_addr-1:0]  status_word0_add_mac;
  wire [31:0]                     nxt_sw0_nxt;
  reg                             status_word0_obtained;
  reg                             status_word2_obtained;
  reg                             status_word3_obtained;

  reg  [p_edma_queues-1:0]        need_sw0_nxt_req;
  reg  [p_edma_queues-1:0]        need_sw1_nxt_req;
  reg  [15:0]                     got_sw0_nxt;
  reg  [p_edma_queues-1:0]        got_sw1_nxt;
  wire [p_edma_queues-1:0]        sw0_nxt_req;
  reg  [p_dword_w-1:0]            status_word0_nxt [15:0];
  reg  [p_dword_w-1:0]            status_word1_nxt [p_edma_queues-1:0]; // Only used for launch time
  wire [p_edma_queues-1:0]        sw01_par_err; // Parity error

  reg                             sw2_req;
  reg                             sw3_req;
  integer                         sram_arb_cnt;
  integer                         sram_arb_cnt2;
  wire [p_edma_queues+2:0]        sram_req;
  reg  [p_edma_queues+2:0]        sram_req_gnt;
  reg  [p_edma_queues+2:0]        sram_add_gnt;
  reg  [p_edma_queues+2:1]        sram_dat_gnt; // bit zero not used
  reg  [p_edma_tx_pbuf_addr-1:0]  status_word0_nxt_add [15:0];
  reg                             reading_pkt_last_word_req_c;
  reg                             reading_pkt_last_word_req;
  wire                            reading_pkt_last_word_req_vld;
  reg                             reading_pkt_last_word_add;
  reg                             tx_r_sop_aph;
  reg                             tx_r_sop_dph;
  reg                             tx_r_pip;
  reg                             tx_r_underflow_dph;
  reg                             tx_r_eop_dph;
  reg                             tx_r_flushed_uflow;
  reg  [3:0]                      tx_r_mod_dph;
  reg                             tx_r_err_dph;
  reg                             tx_r_valid_dph;

  reg  [11:0]                     clr_dplocns_val;
  wire [11:0]                     clr_dplocns_val_mac;
  reg  [4:0]                      pkt_dplocns_cnt_part;
  reg  [11:0]                     pkt_dplocns_cnt;
  wire [p_edma_tx_pbuf_addr-1:0]  pkt_data_nxt_add2;
  wire [p_edma_tx_pbuf_addr-1:0]  pkt_data_nxt_add;
  wire                            replay_residual_frame;
  wire                            need_to_replay;
  reg                             need_to_replay_r;
  wire                            cutthru_status_word_valid;
//  reg  [15:0]                     cutthru_status_word_valid_bus;
  reg  [p_edma_tx_pbuf_addr-1:0]  sw0_sweep_sram_addr;
  reg  [p_edma_tx_pbuf_addr-1:0]  sw0_sweep_sram_addr_p1;
  reg                             sram_add_sw1_q;
  reg  [p_edma_tx_pbuf_addr-1:0]  pkt_data_sram_addr;
  wire [p_edma_tx_pbuf_addr-1:0]  lstatus_word2_add;
  wire [p_edma_tx_pbuf_addr-1:0]  lstatus_word3_add;
  reg   [16:0]                    pkt_end_addr_int; // Packet end address
  wire  [3:0]                     pkt_end_mod_aph;  // Packet end mod, aph timed
  integer                         sram_add_cnt;
  integer                         sram_add_cnt_index;
  wire  [p_emac_bus_width-1:0]    tx_dob_downsize;
  wire  [p_emac_bus_pwid-1:0]     tx_dob_downsize_par;
  wire                            empty_next_downsize;
  wire                            sw_mac_fifo_pop_raw;
  wire                            sw_mac_fifo_pop;
  reg                             sw_mac_fifo_pop_hold;
  reg                             too_many_retries_hold;
  reg                             late_coll_occured_hold;
  wire                            too_many_retries_mac;
  wire                            late_coll_occured_mac;
  wire                            sw_mac_fifo_empty;
  wire                            sw_mac_fifo_2_empty;
  wire                            sw_mac_fifo_full;
  wire                            sw_mac_fifo_push;
  wire [p_dword_w+p_edma_tx_pbuf_addr-1:0]
                                  sw_mac_fifo_din;
  wire [p_wb_fifo_w-1:0]          wb_status_to_tx_wr_fifo_din;
  wire [p_wb_fifo_w-1:0]          wb_status_to_tx_wr_fifo_dout;
  wire                            wb_status_to_tx_wr_fifo_empty;
  wire                            wb_status_to_tx_wr_fifo_full;
  wire                            wb_status_to_tx_wr_fifo_afull;
  reg                             xfer_status_captured_edge_d1;
  integer                         b1;
  wire                            mac_bp;
  wire                            gem_tx_pbuf_data_w_is_128;
  wire                            reading_pkt_last_word_sram_req_c;
  wire                            data_to_mac_xfer_mode;
  wire                            part_pkt_trigger;
  reg                             uflow_wait_for_mac;
  reg                             uflow_wait_for_dma;

  wire  [18:0]                    sword0_cmprsd_mac_pad;  // Compressed Status word 0
  wire  [17:0]                    sword0_cmprsd_mac;      // Compressed Status word 0
  wire  [p_sw0_cmpr_w-1:0]        sword0_cmprsd_mac_p;    // With optional parity
  wire  [15:0]                    tx_r_rd_int_pad;

  // Just for LINT
  assign tx_r_rd_int_pad[p_edma_queues-1:0]  = tx_r_rd_int;

  // Assign some wires based on parameters. This is not functional ....
  assign gem_tx_pbuf_data_w_is_128 = p_edma_tx_pbuf_data == 32'd128;

  // If the dma bus width is configured to be larger than the theoretical maximum
  // mac bus width then we need to limit the mac bus width to be the correct
  // size
  wire [1:0] emac_bus_width_max = p_emac_bus_width == 32'd32 ? 2'b00 :
                                  p_emac_bus_width == 32'd64 ? 2'b01 :
                                                               2'b10 ;
  wire [1:0] emac_bus_width = (dma_bus_width > emac_bus_width_max) ? emac_bus_width_max : dma_bus_width;

  wire enable_tx_sync;
  wire tx_wr_seen_uflow_sync;

  cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_enable_transmit (.clk(tx_r_clk),.reset_n(tx_r_rst_n),.din(enable_transmit),.dout(enable_tx_sync));
  edma_sync_toggle_detect i_edma_sync_toggle_detect_underflow_tog (.clk(tx_r_clk),.reset_n(tx_r_rst_n),.din(tx_wr_seen_uflow),.rise_edge(),.fall_edge(),.any_edge(tx_wr_seen_uflow_sync));
  assign complete_flush = !enable_tx_sync || tx_wr_seen_uflow_sync;

  // The downsize block is used when the attached SRAM width is greater than the MAC datawidth. It is only needed if ...
  //  1. The output(to the MAC) is not 128bits (max)
  //  2. The input (the SRAM width) is 128bits.
  // If the input is not 128 bits, then we state in the defs file that output must be the same as input
  generate if ((p_emac_bus_width != 32'd128) && (p_edma_tx_pbuf_data == 32'd128)) begin : gen_edma_pbuf_downsize
    wire  [p_edma_tx_pbuf_prty+p_edma_tx_pbuf_data-1:0] idata;
    wire  [p_emac_parity_width+p_emac_bus_width-1:0]    odata;

    if (p_edma_tx_pbuf_prty > 8'd0) begin : gen_with_par
      assign idata                = {tx_dob_par_pad[p_edma_tx_pbuf_prty-1:0],tx_dob_pad[p_edma_tx_pbuf_data-1:0]};
      assign {tx_dob_downsize_par,
              tx_dob_downsize}    = odata;
    end else begin : gen_without_par
      assign idata  = tx_dob_pad[p_edma_tx_pbuf_data-1:0];
      assign tx_dob_downsize_par  = {p_emac_bus_pwid{1'b0}};
      assign tx_dob_downsize      = odata[p_emac_bus_width-1:0];
    end
    
    wire   ird_in;
    wire   iflush_nxt_in;
    
    assign ird_in        = |tx_r_rd & !need_to_replay & ((read_state != IDLE & read_state != WAIT_FOR_STATUS) | reading_pkt_last_word_add);
    assign iflush_nxt_in = (read_state == IDLE) || (coll_occurred_le | (pkt_mac_sent & (late_coll_occured|too_many_retries))) || tx_r_flushed;
    
    edma_pbuf_dpram_width_downsize # (
     .IDATA_W(p_edma_tx_pbuf_data),
     .IDATA_W_PAR(p_edma_tx_pbuf_prty),
     .ODATA_W(p_emac_bus_width),
     .ODATA_W_PAR(p_emac_parity_width),
     .IDATA_PIPELINE_DEPTH(1)
    ) i_edma_pbuf_dpram_width_downsize (

     .clk                   (tx_r_clk),
     .reset_n               (tx_r_rst_n),

     .dma_bus_width         (emac_bus_width),

     .ird                   (ird_in),
     .idata                 (idata),
     .imod                  (pkt_end_mod_aph),
     .iflush                ((tx_r_eop_dph & tx_r_valid_dph) ||
                              complete_flush ||
                              tx_r_flushed
                             ),
     .iflush_nxt            (iflush_nxt_in),
     .size                  (),
     .ord                   (),
     .odata                 (odata),
     .oempty                (),
     .oempty_next           (empty_next_downsize),
     .oeop_next             (),
     .oeop                  ()
    );

   end else begin : gen_no_edma_pbuf_downsize
    assign empty_next_downsize  = 1'b1;
    assign tx_dob_downsize      = tx_dob_pad[p_emac_bus_width-1:0];
    assign tx_dob_downsize_par  = tx_dob_par_pad[p_emac_bus_pwid-1:0];
   end
   endgenerate


   // Depending on the size of the RAM, adjust the partpkt_threshold
   // accordingly.
   generate if (p_edma_tx_pbuf_data == 32'd128) begin : gen_partpkt_threhold
      assign partpkt_threshold = {{p_edma_tx_pbuf_addr{1'b0}},4'd8};
   end
   else begin : gen_no_partpkt_threshold
      assign partpkt_threshold = {{p_edma_tx_pbuf_addr-1{1'b0}},5'd16};
   end
   endgenerate

  wire  [4:0] TX_PBUF_NUM_SEGMENTS_ARRAY [15:0]; // Handy array to de-serialise the incoming signal
  wire [(p_edma_tx_pbuf_queue_segment_size)-1:0] TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY [15:0]; // Handy array to de-serialise the incoming signal
  wire [(p_edma_tx_pbuf_queue_segment_size)-1:0] TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY [15:0]; // Handy array to de-serialise the incoming signal
  genvar g1;
  generate for (g1=0; g1<p_edma_queues[31:0]; g1=g1+1) begin : gen_tx_dma_descr_base_addr
    assign TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[g1] = TX_PBUF_SEGMENTS_LOWER_ADDR[((g1+1)*p_edma_tx_pbuf_queue_segment_size)-1:g1*p_edma_tx_pbuf_queue_segment_size];
    assign TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[g1] = TX_PBUF_SEGMENTS_UPPER_ADDR[((g1+1)*p_edma_tx_pbuf_queue_segment_size)-1:g1*p_edma_tx_pbuf_queue_segment_size];
    assign TX_PBUF_NUM_SEGMENTS_ARRAY[g1] = TX_PBUF_NUM_SEGMENTS[((g1+1)*5)-1:g1*5];
  end
  endgenerate

  // start_reading_at_risk is a signal used to trigger frame transmissions for cut-thru operation
  // It gets triggered when part_of_packet trigger is detected (which itself is the result of a clock boundary
  // from the WRITE side of the DMA).  We also trigger it if the SRAM itself is > half full and we missed
  // a part of packet trigger previously (perhaps because we were transmitting a previous frame).
  // It is cleared when we have obtained the status words from the SRAM (which means we are no longer reding
  // at risk because we have all the packet information via the status words.  It is also cleared if
  // we have a flush event.
  genvar g;
  generate for (g=0; g<p_edma_queues[31:0]; g=g+1) begin : gen_start_reading_at_risk
    reg cutthru_pending_q;
    always@(posedge tx_r_clk or negedge tx_r_rst_n)
      if (~tx_r_rst_n)
        start_reading_at_risk_q[g] <= 1'b0;
      else
        start_reading_at_risk_q[g] <= start_reading_at_risk_q_nxt[g];

    always@(posedge tx_r_clk or negedge tx_r_rst_n)
      if (~tx_r_rst_n)
        cutthru_pending_q <= 1'b0;
      else if (end_of_packet_edge[g])
        cutthru_pending_q <= 1'b0;
      else if (part_of_packet_edge[g] && (read_state != IDLE || num_pkts_needing_read[g] != 8'd0))
        cutthru_pending_q <= 1'b1;

    always@(*) begin

      start_reading_at_risk_q_nxt[g] = start_reading_at_risk_q[g];

      if (complete_flush)
        start_reading_at_risk_q_nxt[g] = 1'b0;
      else
        // Parts of pkts are more straight forward
        // We only care about full duplex, so restarts are irrelevant here
        // Also transfers from the AHB side that contain no data (errored transfers)
        // also are irrelevant as they are only indicated through pkt_written
        // start_reading_at_risk_q_nxt gets set if part_of_packet_edge goes high
        if (start_reading_at_risk_q[g] &
              ((queue_dma == g[3:0] & status_word3_obtained) | tx_r_underflow ))
          start_reading_at_risk_q_nxt[g] = 1'b0;

        else if ((part_of_packet_edge[g]||cutthru_pending_q) && read_state == IDLE && !(|num_pkts_needing_read[g]))
          start_reading_at_risk_q_nxt[g] = 1'b1;
    end
  end
  endgenerate

  // If we have cut-thru operation then monitor for the write side pushing data
  // to the status word FIFO. For cut-thru operation, we dont rely on obtaining
  // the status words from the SRAM as they could easily be overwritten by newer
  // frames.  Instead, we have a dedicated status xfer bus implemented in flops.
  // If data is there then compare the status word
  // with the current frame start address. If there is a match then flag a
  // match and pop the FIFO once the status words have been read.
generate if (p_edma_pbuf_cutthru == 1) begin : gen_cutthru_logic
  reg cutthru_status_word_pop_r;
  reg cutthru_status_word_valid_r;
  //reg cutthru_status_word_err_r;

  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      cutthru_status_word_pop_r     <= 1'b0;
      cutthru_status_word_valid_r   <= 1'b0;
    end
    else
    begin
      if (complete_flush)
      begin
        cutthru_status_word_pop_r     <= 1'b0;
        cutthru_status_word_valid_r   <= 1'b0;
      end
      // When the SW0 has been sampled, we can always pop this FIFO as it means the this block has already captured the SW from
      // the cutthru buffer, or it wasnt needed at all. Also dont need it in IDLE state, as that would mean we can just get the
      // SW from SRAM
      else if (!cutthru_status_word_empty && (sample_sw0 || read_state == IDLE))
      begin
        cutthru_status_word_pop_r   <= 1'b1;
        cutthru_status_word_valid_r <= 1'b0;
      end
      else
      begin
        cutthru_status_word_pop_r   <= 1'b0;
        // Only need to use the cutthru buffer if we have already said we would via start_reading_at risk
        // there cant be any full frames buffered for this to work ..
        if (start_reading_at_risk_q_nxt[queue_dma])
        begin
          // Determine if the status words in the cutthru status word FIFO match the current frame.
          cutthru_status_word_valid_r <= !cutthru_status_word_empty && !cutthru_status_word_pop_r &&
                                          cutthru_status_word[p_edma_tx_pbuf_addr-1+128:128] == status_word0_nxt_add[queue_dma];
        end
      end
    end
  end

  assign cutthru_status_word_pop   = cutthru_status_word_pop_r;
  assign cutthru_status_word_valid = cutthru_status_word_valid_r;

end else begin : gen_no_cutthru_logic
  assign cutthru_status_word_pop   = 1'b0;
  assign cutthru_status_word_valid = 1'b0;
end
endgenerate



  generate if (p_edma_tsu == 1) begin : gen_ts_to_be_written

    // Register tx timestamp
    // indicate ts is to be written to BD based on decoded frame type
    // and tx_bd_ts_mode
    // This isnt really used in this module, but the timestamp needs to be passed back to the
    // AXI/AHB side of the DMA for inclusion in the descriptor writeback.
    reg                             event_frame_tx_d1;
    reg                             general_frame_tx_d1;
    always@(posedge tx_r_clk or negedge tx_r_rst_n)
    begin
      if (~tx_r_rst_n)
        begin
        event_frame_tx_d1   <= 1'b0;
        general_frame_tx_d1 <= 1'b0;
        end
      else
      begin
        if (complete_flush)
        begin
          event_frame_tx_d1   <= 1'b0;
          general_frame_tx_d1 <= 1'b0;
        end
        else
        begin
          event_frame_tx_d1   <=  event_frame_tx;
          general_frame_tx_d1 <=  general_frame_tx;
        end
      end
    end

    always@(*)
    begin
      casex ({tx_bd_ts_mode, general_frame_tx_d1, event_frame_tx_d1})
        4'b00xx:  // no frames
                 ts_to_be_written = 1'b0;
        4'b0101:  // event frames only
                 ts_to_be_written = 1'b1;
        4'b1010:  // general frames (ie all ptp frames)
                 ts_to_be_written = 1'b1;
        4'b1001:  // event frames (ie all ptp frames)
                 ts_to_be_written = 1'b1;
        4'b11xx:  // all frames
                 ts_to_be_written = 1'b1;
        default: ts_to_be_written = 1'b0;
      endcase
    end
  end else begin : gen_no_ts_to_be_written
    wire zero;
    assign zero = 1'b0;
    always @(*)
      ts_to_be_written = zero;
  end
  endgenerate



  // ---------------------------------------------------------------------------
  // Sample various signals from the tx_wr domain (new frame, part of frame
  // toggle, xfer status captured, etc) from the tx_wr side and
  // also signal back to the tx_wr side that the frame has been captured.
  // Signal internally if a new frame has been written
  //
  // Synchronize the part of frame and end of frame toggles
  cdnsdru_datasync_v1 i_cdnsdru_datasync_v11 (.clk(tx_r_clk), .reset_n(tx_r_rst_n), .din(xfer_status_captured), .dout(xfer_status_captured_sync));
  cdnsdru_datasync_v1 #(.CDNSDRU_DATASYNC_DIN_W(p_edma_queues)) i_cdnsdru_datasync_v13 (.clk(tx_r_clk), .reset_n(tx_r_rst_n), .din(part_of_packet_tog), .dout(part_of_packet_tog_sync));
  cdnsdru_datasync_v1 #(.CDNSDRU_DATASYNC_DIN_W(p_edma_queues)) i_cdnsdru_datasync_v14 (.clk(tx_r_clk), .reset_n(tx_r_rst_n), .din(dpram_almost_empty[p_edma_queues-1:0]), .dout(dpram_almost_empty_sync[p_edma_queues-1:0]));
  cdnsdru_datasync_v1 #(.CDNSDRU_DATASYNC_DIN_W(p_edma_queues)) i_cdnsdru_datasync_v15 (.clk(tx_r_clk), .reset_n(tx_r_rst_n), .din(end_of_packet_tog), .dout(end_of_packet_tog_sync));

  // Detect an edge on the incoming frame and end of frame toggles
  edma_toggle_detect i_edma_toggle_detect1 (.clk(tx_r_clk),  .reset_n(tx_r_rst_n), .din(xfer_status_captured_sync),.rise_edge(),.fall_edge(),.any_edge(xfer_status_captured_edge));
  edma_toggle_detect #(.DIN_W(p_edma_queues)) i_edma_toggle_detect2 (.clk(tx_r_clk),  .reset_n(tx_r_rst_n), .din(part_of_packet_tog_sync),.rise_edge(),.fall_edge(),.any_edge(part_of_packet_edge));
  edma_toggle_detect #(.DIN_W(p_edma_queues)) i_edma_toggle_detect3 (.clk(tx_r_clk),  .reset_n(tx_r_rst_n), .din(end_of_packet_tog_sync),.rise_edge(),.fall_edge(),.any_edge(end_of_packet_edge));

  // Signal back to the tx_wr side that the incoming toggles have
  // been recognised
  edma_toggle_generate #(
    .DIN_W(p_edma_queues)
  ) i_edma_toggle_generate_pkt_captured (
    .clk(tx_r_clk),
    .reset_n(tx_r_rst_n),
    .din(part_of_packet_edge | end_of_packet_edge),
    .dout(pkt_captured));


  // pkt_written is the signal we use to know a packet has been written to the DPRAM and is fully synchronous
  // to tx_r_clk
  assign pkt_written  = end_of_packet_edge &
                        pkt_end_new &
                        {p_edma_queues{~(end_of_packet_edge[0] & pkt_end_flush)}};


  // ---------------------------------------------------------------------------
  // Monitor the number of packets needing read. num_pkts_needing_read
  // counter is incremented when we identify a full new frame is available in the SRAM
  // for fetching.  decremented when a frame is sent to the MAC
  //
  genvar i;
  generate for (i=0; i<p_edma_queues[31:0]; i=i+1) begin : gen_num_pkt_counters
    wire [3:0] num_pkts_xfer_safe;
    assign num_pkts_xfer_safe = (num_pkts_xfer[((i+1)*4)-1:i*4] & {4{end_of_packet_edge[i]}}) & {4{pkt_written[i]}} ;
    reg  [8:0] num_pkts_needing_read_loc; // Number of pkts in buffer still needing read
    always@(*)
    begin
      begin
        //  num_pkts_needing_read counts the number of packets in the pkbuffer
        // It is decremented as soon as we commit to a frame ...
        num_pkts_needing_read_loc =  num_pkts_needing_read[i] + num_pkts_xfer_safe[3:0];

      end
    end
    assign num_pkts_needing_read_nxt[i] =  num_pkts_needing_read_loc[7:0];

    always@(posedge tx_r_clk or negedge tx_r_rst_n)
    begin
      if (~tx_r_rst_n)
      begin
        num_pkts_needing_read[i] <= 8'h00;
      end
      else if (complete_flush)
      begin
        num_pkts_needing_read[i] <= 8'h00;
      end
      else
      begin
        num_pkts_needing_read[i] <= num_pkts_needing_read_nxt[i] -
                                        (sample_sw0 & (i == {{28{1'b0}},queue_dma_c}) & !(|store_mac_sw0_en));
      end
    end
  end
  for (i=p_edma_queues; i<16; i=i+1) begin : gen_num_pkt_counters_pad
    assign num_pkts_needing_read_nxt[i] =  8'h00;
  end
  endgenerate


// Now for the main state machines that reads from the SRAM.
// Packets are stored in the SRAM in regions, one region per queue.
// The packets themselves are sandwiched between status words holding
// key information.  There are 4 32-bit status words required, named
// status_word0, status_word1, status_word2 and status_word3.  Of these, status_word0
// is critical and contains all the really important information needed to
// understand pkt length etc.  status_word1 is only relevant if we have extended bd enabled and
// have enabled launch times.
// We will therefore do a pre-fetch of status_word0
// before we do any transmissions and try to maintain an early understanding of
// what is at the head of each queue.
// The information in status_word0 is actually ...
// Bits 11:0        = pkt length in SRAM words ...
// Bits 15:12       = number of bytes valid in the last word ...
// Bits 23:16       = Add this to status_word_wr_0[11:0] to get the end address
// Bits 26:24       = reserved
// Bits 27          = pass through of bit 16 of the descriptor for this frame
// Bits 31:28       = The error status bits - if bit 31 is set, this frame contains no data

// In 32bit mode, the structure of the full frame is
// status_word0 -> status_word1 (extended bd mode only) -> packet data -> status_word2 -> status_word3

// In 64bit mode, the structure of the full frame is
// status_word01 -> packet data -> status_word23

// In 128bit mode, the structure of the full frame is
// status_word0123 -> packet data -> status_word0123 (repeated)

// perform a sweep of the status word0 and 1 and store in an bank of 32bit flops.
// This sweep is done to obtain an early understanding of whats in each queue.
// One bank per queue
// need_sw0_nxt_req is set when we dont have the status_word0 information
// when this is set, the SRAM arbiter will attempt to fetch the information
// from SRAM as soon as there are packets available. One bit for each queue
// got_sw0_nxt is set when we have the status_word0 info stored. this is an
// indiation that we can pass this queue as a valid candidate for scheduling.
// status_word0_nxt_add holds the address of the next status_work0 for each queue.
// status_word0_nxt is the actual status word.
  genvar i1;
  generate for (i1=0; i1<p_edma_queues[31:0]; i1=i1+1) begin : gen_req_sw0_nxt_access
    
    wire [17:0] tmp_end_addr;
    wire [16:0] tmp_end_addr2;
    reg  [17:0] tmp_nxt_start_addr;
    wire [31:0] local_sw0;

    always@(posedge tx_r_clk or negedge tx_r_rst_n)
    begin
      if (~tx_r_rst_n)
      begin
        need_sw0_nxt_req[i1]        <= 1'b1;
        need_sw1_nxt_req[i1]        <= 1'b1;
        got_sw0_nxt[i1]             <= 1'b0;
        got_sw1_nxt[i1]             <= 1'b0;
        status_word0_nxt_add[i1]    <= {p_edma_tx_pbuf_addr{1'b0}};
        status_word0_nxt[i1]        <= {p_dword_w{1'b0}};
        status_word1_nxt[i1]        <= {p_dword_w{1'b0}};
      end
      else
      begin
        if (complete_flush)
        begin
          need_sw0_nxt_req[i1]           <= 1'b1;
          need_sw1_nxt_req[i1]           <= bd_extended_mode_en && !gem_tx_pbuf_data_w_is_128;
          got_sw0_nxt[i1]                <= 1'b0;
          got_sw1_nxt[i1]                <= 1'b0;
          status_word0_nxt_add[i1][p_edma_tx_pbuf_addr-1:p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size] <=
                                                      TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[i1];
          status_word0_nxt_add[i1][p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size-1:0] <=
                                                      {p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size{1'b0}};
          status_word0_nxt[i1]           <= {p_dword_w{1'b0}};
        end

        else
        begin
          if (sample_cut_thru_sw & {{28{1'b0}},queue_dma} == i1)
          begin
            need_sw0_nxt_req[i1]           <= 1'b0;
            need_sw1_nxt_req[i1]           <= 1'b0;
          end
          else if (sram_req_gnt[i1+3])
          begin
            if (!need_sw1_nxt_req[i1] || gem_tx_pbuf_data_w_is_128 || dma_bus_width == 2'b01) // If already requested the launch time in SW1, or can get both SW0 and SW1 in 1 access
            begin
              need_sw1_nxt_req[i1]         <= 1'b0;
              need_sw0_nxt_req[i1]         <= 1'b0;
            end
            else
              need_sw1_nxt_req[i1]         <= 1'b0; // 32 bit only - still need SW0
          end
          else if (sample_sw0 && (i1 == {{28{1'b0}},queue_dma_c}) & ~(|store_mac_sw0_en))
          begin
            need_sw1_nxt_req[i1]      <= bd_extended_mode_en && !gem_tx_pbuf_data_w_is_128;
            need_sw0_nxt_req[i1]      <= 1'b1;
            status_word0_nxt_add[i1]  <= bind2queueRange(tmp_nxt_start_addr[p_edma_tx_pbuf_addr-1:0],
                                         TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[i1],
                                         TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[i1],
                                         TX_PBUF_NUM_SEGMENTS_ARRAY[i1]);
          end
          else if (!bd_extended_mode_en)
            need_sw1_nxt_req[i1]      <= 1'b0;

          // If the cutthru bus comes in first with the SW0, then need_sw0_nxt_req will go low on nxt cycle
          // thus blocking any chance for the normal SRAM request to fetch SW0
          // If the num_pkts_needing_read bus increments first, or at the same time, then we need to block
          // the result from this from loading got_sw0_nxt and the status word. This is because the sw0
          // and the got_sw0_nxt bus will be loaded from the cutthru bus instead.
          if (sample_cut_thru_sw & {{28{1'b0}},queue_dma} == i1)
          begin
            got_sw0_nxt[i1]             <= 1'b1;
            got_sw1_nxt[i1]             <= 1'b1;
            status_word0_nxt[i1]        <= ct_fifo_w0;
            status_word1_nxt[i1]        <= ct_fifo_w1;
          end
          else if (sram_dat_gnt[i1+3])
          begin
            if (got_sw1_nxt[i1] || gem_tx_pbuf_data_w_is_128 || dma_bus_width == 2'b01 || !bd_extended_mode_en) // If we already have SW1, or can get both SW0 and SW1 in 1 access
            begin
              got_sw0_nxt[i1]           <= 1'b1;
              status_word0_nxt[i1]      <= tx_dob_w0;
              if (!got_sw1_nxt[i1])
              begin
                status_word1_nxt[i1]    <= tx_dob_w1;
                got_sw1_nxt[i1]         <= 1'b1;
              end
            end
            else  // 32 bit, got SW1 now, but still need SW0
            begin
              got_sw1_nxt[i1]           <= 1'b1;
              status_word1_nxt[i1]      <= tx_dob_w0;
            end
          end
          else if (sample_sw0 && (i1 == {{28{1'b0}},queue_dma_c}) & ~(|store_mac_sw0_en))
          begin
            got_sw0_nxt[i1]          <= 1'b0;
            got_sw1_nxt[i1]          <= 1'b0;
          end
        end
      end
    end


    // This is the SRAM request for fetching status word 0.  This will be passed to the SRAM arbiter
    assign sw0_nxt_req[i1] = need_sw0_nxt_req[i1] & (|num_pkts_needing_read[i1]) & !sample_cut_thru_sw;

    // Calculate the packet end addresses, using the start address, number of locations in a frame
    // and the offset to the frame end address. This is needed to identify the next status word 0 address.
    // We also sign extened the offset to the frame address as
    // at times we need to subtract 1.
    // Note. We extend the calculation to 16 bits to account for the scenario
    // where the edma_tx_pbuf_addr paramater is larger or smaller than the 12
    // bits allocated for the size of frame. We also sign extend the offset
    assign local_sw0          = status_word0_nxt[i1][31:0];
    assign tmp_end_addr2      = {{(17-p_edma_tx_pbuf_addr){1'b0}},status_word0_nxt_add[i1]} + {5'd0,local_sw0[11:0]};
    assign tmp_end_addr       = tmp_end_addr2 + {1'd0,{8{local_sw0[23]}},local_sw0[23:16]};

    always @(*)
    begin
      if (gem_tx_pbuf_data_w_is_128)
        tmp_nxt_start_addr = tmp_end_addr[16:0] + 17'd1 ; // 4 status words fit into 1 SRAM locn
      else if (dma_bus_width[0])
        tmp_nxt_start_addr = tmp_end_addr[16:0] + 17'd2 ; // 4 status words fit into 2 SRAM locns
      else
        tmp_nxt_start_addr = tmp_end_addr[16:0] + 17'd4;  // 4 status words fit into 4 SRAM locns
    end

  end
  endgenerate



// Implement the SRAM arbiter
// Top priority is the MAC request as failure to respond here will incur an underflow.
// Once the MAC requests data, we must return data in 2 clock cycles.
// We can use tx_r_rd_int as an early indicator that the MAC will set tx_r_rd on the next clock
// That gives us 3 clocks total to read the SRAM and register the data back to ease timing on SRAM IO.
// There is one request for the MAC, one request for each status word (excl sw0)
// and up to 16 requests for the sw0_sweep.
  assign sram_req[0] = |tx_r_rd_int &
                        ((read_state != IDLE & empty_next_downsize) | read_state_tr_idle2data);
  assign sram_req[1] = sw2_req;
  assign sram_req[2] = sw3_req;
  assign sram_req[p_edma_queues+2:3] = sw0_nxt_req;
  always@(*)
  begin
    sram_req_gnt = {p_edma_queues+3{1'b0}};
    for (sram_arb_cnt=(p_edma_queues+2); sram_arb_cnt>=0; sram_arb_cnt=sram_arb_cnt-1) begin
      if (sram_req[sram_arb_cnt])
        sram_req_gnt = {{p_edma_queues+2{1'b0}},1'b1} << sram_arb_cnt;
    end
  end

  // sram_add_gnt identifies which source is currently accessing the SRAM (address phase)
  // sram_dat_gnt identifies which source is currently accessing the SRAM (data phase)
  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      for (sram_arb_cnt2=(p_edma_queues+2); sram_arb_cnt2>=0; sram_arb_cnt2=sram_arb_cnt2-1) begin
        sram_add_gnt[sram_arb_cnt2]  <=  1'b0;
        if (sram_arb_cnt2 > 0) sram_dat_gnt[sram_arb_cnt2]  <=  1'b0;
      end
    end
    else
    begin
      if (complete_flush)
      begin
        for (sram_arb_cnt2=(p_edma_queues+2); sram_arb_cnt2>=0; sram_arb_cnt2=sram_arb_cnt2-1) begin
          sram_add_gnt[sram_arb_cnt2]  <=  1'b0;
          if (sram_arb_cnt2 > 0) sram_dat_gnt[sram_arb_cnt2]  <=  1'b0;
        end
      end
      else
      begin
        for (sram_arb_cnt2=(p_edma_queues+2); sram_arb_cnt2>=0; sram_arb_cnt2=sram_arb_cnt2-1) begin
          sram_add_gnt[sram_arb_cnt2]  <=  sram_req_gnt[sram_arb_cnt2];
          if (sram_arb_cnt2 > 0) sram_dat_gnt[sram_arb_cnt2]  <=  sram_add_gnt[sram_arb_cnt2];
        end
      end
    end
  end

  // Create a signal that identifies whether the current address issued to the SRAM
  // is for obtaining the early SW0 or SW1 (launch time)
  reg [p_edma_queues-1:0] sram_add_sw1;
  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
      sram_add_sw1  <= {p_edma_queues{1'b0}};
    else
      for (sram_add_cnt=p_edma_queues-1; sram_add_cnt>=0; sram_add_cnt=sram_add_cnt-1) begin
        if (complete_flush || need_sw1_nxt_req[sram_add_cnt])
          sram_add_sw1[sram_add_cnt]  <=  dma_bus_width == 2'b00;
        else
          sram_add_sw1[sram_add_cnt]  <=  1'b0;
      end
  end

  // Based on the granted master, set the SRAM address. First identify the status_word0 sweep address
  // There is one of these per queue.
  always@(*)
  begin
    sw0_sweep_sram_addr = {p_edma_tx_pbuf_addr{1'b0}};
    sw0_sweep_sram_addr_p1 = {p_edma_tx_pbuf_addr{1'b0}};
    sram_add_sw1_q         = 1'b1;
    for (sram_add_cnt_index=p_edma_queues-1; sram_add_cnt_index>=0; sram_add_cnt_index=sram_add_cnt_index-1) begin
      if (sram_add_gnt[sram_add_cnt_index+3])
      begin
        sw0_sweep_sram_addr    = status_word0_nxt_add[sram_add_cnt_index];
        sw0_sweep_sram_addr_p1 = bind2queueRange((status_word0_nxt_add[sram_add_cnt_index] + {{p_edma_tx_pbuf_addr-2{1'b0}},2'b01}),
                                               TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[sram_add_cnt_index],
                                               TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[sram_add_cnt_index],
                                               TX_PBUF_NUM_SEGMENTS_ARRAY[sram_add_cnt_index]);
        sram_add_sw1_q         = sram_add_sw1[sram_add_cnt_index];
      end
    end
  end


  always @(*)
  begin
    tx_enb = |sram_add_gnt[2:0] | (|(sram_add_gnt[(p_edma_queues+2):3]));
    tx_web = 1'b0;
    if      (sram_add_gnt[0]) tx_addrb = pkt_data_sram_addr;                                                                           // Status Word 0
    else if (sram_add_gnt[1]) tx_addrb = gem_tx_pbuf_data_w_is_128 ? status_word0_add : lstatus_word2_add;                             // Status Word 2
    else if (sram_add_gnt[2]) tx_addrb = lstatus_word3_add;                                                                            // Status Word 3
    else if (sram_add_sw1_q)  tx_addrb = sw0_sweep_sram_addr_p1;
    else                      tx_addrb = sw0_sweep_sram_addr;
  end


// Instantiate the transmit scheduler ...
// First Identify whether there are packets in each queue
// and identify what the length of the frame at the head of every non-empty queue
  wire  [(p_edma_queues*14)-1:0]    nxt_frame_size;
  wire  [15:0]                      status_frame_in_q;
  wire  [p_edma_queues-1:0]         tx_r_data_rdy_rph;
  reg   [p_edma_queues-1:0]         tx_r_data_rdy_aph;
  wire  [p_edma_queues-1:0]         tx_r_frame_size_vld_rph;
  wire  [3:0]                       status_index [p_edma_queues-1:0];
  wire  [1:0]                       dma_bus_width_override;

  // Override dma_bus_width if 128-bit SRAM for frame size calculation
  assign dma_bus_width_override = gem_tx_pbuf_data_w_is_128 ? 2'b10 : dma_bus_width;

  genvar i2;
  generate for (i2=0; i2<p_edma_queues[31:0]; i2=i2+1) begin : gen_packets_in_q
    wire [31:0] local_sw0;
    wire [13:0] nxt_frame_size_word;
    reg  [14:0] nxt_frame_size_local;
    assign local_sw0          = status_word0_nxt[i2][31:0];

    // The frame size must be in bytes ...
    // Unfortunately, the local_sw0 is in SRAM words, and doesnt take into account any of the
    // bytes added by the MAC, such as the preamble CRC and IPG. So add 24 bytes.
    assign nxt_frame_size_word =  dma_bus_width_override == 2'b00 ? {local_sw0[11:0],2'b00} :
                                  dma_bus_width_override == 2'b01 ? {local_sw0[10:0],3'b000} :
                                                                    {local_sw0[9:0],4'b0000};
    always @(*)
    begin
      case ({ (local_sw0[15] | !dma_bus_width_override[1]),
              (local_sw0[14] | !(|dma_bus_width_override)),
              (local_sw0[13:12])})
        4'b1111   : nxt_frame_size_local = nxt_frame_size_word + 14'd23; // +24-1
        4'b1110   : nxt_frame_size_local = nxt_frame_size_word + 14'd22; // +24-2
        4'b1101   : nxt_frame_size_local = nxt_frame_size_word + 14'd21;
        4'b1100   : nxt_frame_size_local = nxt_frame_size_word + 14'd20;
        4'b1011   : nxt_frame_size_local = nxt_frame_size_word + 14'd19;
        4'b1010   : nxt_frame_size_local = nxt_frame_size_word + 14'd18;
        4'b1001   : nxt_frame_size_local = nxt_frame_size_word + 14'd17;
        4'b1000   : nxt_frame_size_local = nxt_frame_size_word + 14'd16;
        4'b0111   : nxt_frame_size_local = nxt_frame_size_word + 14'd15;
        4'b0110   : nxt_frame_size_local = nxt_frame_size_word + 14'd14;
        4'b0101   : nxt_frame_size_local = nxt_frame_size_word + 14'd13;
        4'b0100   : nxt_frame_size_local = nxt_frame_size_word + 14'd12;
        4'b0011   : nxt_frame_size_local = nxt_frame_size_word + 14'd11;
        4'b0010   : nxt_frame_size_local = nxt_frame_size_word + 14'd10;
        4'b0001   : nxt_frame_size_local = nxt_frame_size_word + 14'd9;
        default   : nxt_frame_size_local = nxt_frame_size_word + 14'd24;
      endcase
    end

    assign nxt_frame_size[(14*i2+13):(14*i2)] = nxt_frame_size_local[13:0];

    // tx_r_frame_size_vld is a FIFO interface signal that is visible only when the DMA is included
    // It is similarly timed to the now that should be valid for the duration of the frame from the first tx_r_rd
    assign tx_r_frame_size_vld_rph[i2]  = (|store_mac_sw0_en & i2[3:0] == store_1st_sw0[p_dword_w+3:p_dword_w]) | (got_sw0_nxt[i2] & !local_sw0[31]);
    // Hold it for the duration of the frame ..
    assign tx_r_frame_size_vld[i2]      =  tx_r_frame_size_vld_rph[i2] | (status_word0_obtained & !status_word_0[31] & queue_dma == i2[3:0]);

    assign tx_r_data_rdy_rph[i2]        =  ((|store_mac_sw0_en & i2[3:0] == store_1st_sw0[p_dword_w+3:p_dword_w] & !store_1st_sw0[31]) |
                                           (!(|store_mac_sw0_en) & ((|num_pkts_needing_read_nxt[i2] & tx_r_frame_size_vld_rph[i2] & !local_sw0[31]) | start_reading_at_risk_q_nxt[i2])));
    assign tx_r_launch_time_vld[i2]     =  (store_mac_sw0_en == 2'b00 && bd_extended_mode_en && got_sw0_nxt[i2] && local_sw0[24] &&  !local_sw0[31]);
    assign tx_r_launch_time[(32*i2+31):(32*i2)] =  status_word1_nxt[i2][31:0];
    assign status_frame_in_q[i2]        = (|store_mac_sw0_en & i2[3:0] == store_1st_sw0[p_dword_w+3:p_dword_w] & store_1st_sw0[31]) |
                                          ((|num_pkts_needing_read_nxt[i2]) & local_sw0[31] & got_sw0_nxt[i2]);
    assign status_index[i2] = i2[3:0];

    // Parity check for status word 0 and 1, used for frame size and launch time.
    if (p_edma_asf_dap_prot == 1) begin : gen_par_chk
      cdnsdru_asf_parity_check_v1 #(.p_data_width(64)) i_gem_par_chk_sw1 (
        .odd_par(1'b0),
        .data_in({status_word1_nxt[i2][31:0],
                  status_word0_nxt[i2][31:0]}),
        .parity_in({status_word1_nxt[i2][35:32],
                    status_word0_nxt[i2][35:32]}),
        .parity_err(sw01_par_err[i2])
      );
    end else begin : gen_no_par_chk
      assign sw01_par_err[i2]  = 1'b0;
    end
  end
  endgenerate
  assign dma_is_busy         = (((|status_frame_in_q && !(|store_mac_sw0_en)) || mac_bp) && read_state == IDLE) || read_state == WAIT_FOR_STATUS;
  assign tx_r_frame_size     = nxt_frame_size;

  // The selected queue is not something this module controls. It comes from the
  // scheduler inside the MAC.  so we need to wait for tx_r_rd_int and then use tx_r_queue_int


  // Set the queue ID based on the above scheduled_queue bus ...
  integer q_cnt;
  always@(*)
  begin
    queue_dma_c = queue_dma;
    if (|store_mac_sw0_en)  // restart due to collision ...
      queue_dma_c = store_1st_sw0[p_dword_w+3:p_dword_w];
    else if (|status_frame_in_q && read_state == IDLE)
      for (q_cnt= 0; q_cnt<p_edma_queues[31:0]; q_cnt=q_cnt+ 1)
      begin
        if (status_frame_in_q[q_cnt])  // Fixed priority - highest queue num wins ...
          queue_dma_c = status_index[q_cnt];
      end
    else
      queue_dma_c = tx_r_queue_int;
  end

  // transfers to the MAC must be back pressured if any of the following is true.
  //  1. There are already 2 packets in the MAC pipeline ...
  //  2. Any of the FIFO's in this module that communicate with other parts of the design are full
  assign mac_bp = (num_pkts_in_mac == 2'b10 |
                   sw_mac_fifo_full |
                   wb_status_to_tx_wr_fifo_afull);

  // Store the queue information. Useful to know what the queue is as we fetch the frame from the SRAM and feed the MAC.
  // Also udeful to know what the queue is as it passes through the MAC pipeline.
  always@(posedge tx_r_clk or negedge tx_r_rst_n)
    if (~tx_r_rst_n)
    begin
      queue_dma <= 4'h0;
      queue_mac <= 4'h0;
    end
    else
    begin
      if (complete_flush)
      begin
        queue_dma <= 4'h0;
        queue_mac <= 4'h0;
      end
      else
      begin
        if (read_state == IDLE)
          queue_dma <= queue_dma_c;
        if (num_pkts_in_mac == 2'b00 & read_state_tr_idle2data)
          queue_mac <= queue_dma_c;
        else if (|num_pkts_in_mac & pkt_mac_sent)
          queue_mac <= queue_dma;
      end
    end

  // Obtain the status word 0 for the next frame we want to transmit from ...
  assign nxt_sw0_nxt  = |store_mac_sw0_en ? store_1st_sw0[31:0] : status_word0_nxt[queue_dma_c][31:0];

  // Implement the main state machine, which acts upon the queue decision
  // and fetches the frame data for that queue. It also controls the main data_rdy
  // signal to the MAC, which informs the MAC when data is available to fetch. The state
  // machine will stay in the PKT_DATA state until all the frame data has been pushed to the MAC
  // and all 3 status words have been successfully obtained.
  // It will also handle the status-only frames, which are really just error status from
  // the AHB/AXI side of the DMA passed through the SRAM to be in the correct packet order.
  // Status-only frames dont have any packet data, so are handled a little differently.
  // Note this state machine operates in the SRAM request phase
  always @(*)
  begin
      read_state_nxt          = read_state;
      read_state_tr_idle2data = 1'b0;
      sw2_req                 = 1'b0;
      sw3_req                 = 1'b0;
      sample_sw0              = 1'b0;
      sample_cut_thru_sw      = 1'b0;
      case (read_state)
        IDLE  :
        begin
          if (mac_bp)
            read_state_nxt          = IDLE;
          else if ((got_sw0_nxt[queue_dma_c] && !(|store_mac_sw0_en | need_to_replay) &&
                    (tx_r_rd_int_pad[queue_dma_c] || status_frame_in_q[queue_dma_c])) ||

                  ((|store_mac_sw0_en) && (tx_r_rd_int_pad[queue_dma_c] || store_1st_sw0[31])))
          begin
            sw2_req                 = ~status_word2_obtained & ~sram_add_gnt[1] & ~sram_dat_gnt[1];
            sw3_req                 = dma_bus_width_override == 2'b00 & ~status_word3_obtained & ~sram_add_gnt[2] & ~sram_dat_gnt[2];
            sample_sw0              = 1'b1;
            // If the frame is a status only frame, then only go get status - i.e. no data to send MAC
            if (nxt_sw0_nxt[31])
              read_state_nxt        = WAIT_FOR_STATUS;
            else
            begin
              read_state_tr_idle2data = 1'b1;
              if (reading_pkt_last_word_req_c)
                read_state_nxt        = WAIT_FOR_STATUS;
              else
                read_state_nxt        = PKT_DATA;
            end
          end
          else if (start_reading_at_risk_q_nxt[queue_dma_c] & tx_r_rd_int_pad[queue_dma_c])
          begin
            read_state_tr_idle2data = 1'b1;
            read_state_nxt          = PKT_DATA;
          end
        end

        PKT_DATA :
        begin
          if  (need_to_replay | reading_pkt_last_word_req)
          begin
            if (status_word2_obtained & status_word3_obtained)
              read_state_nxt  = IDLE;
            else
              read_state_nxt  = WAIT_FOR_STATUS;
          end
          else if (start_reading_at_risk_q_nxt[queue_dma] & cutthru_status_word_valid & !status_word0_obtained & !got_sw0_nxt[queue_dma])
            sample_cut_thru_sw = 1'b1; // This happens as soon as the cutthru_status_word becomes available to preload status_word_0_nxt
          else if (start_reading_at_risk_q_nxt[queue_dma] & got_sw0_nxt[queue_dma] & (|num_pkts_needing_read[queue_dma]) & !status_word0_obtained)
            sample_sw0      = 1'b1;// This happens a bit later than above when num_pkts_needing_read has been updated
          else if (sram_req_gnt[1])
            read_state_nxt  = READ_LSTATUS_WORD2;
          else if (sram_req_gnt[2])
            read_state_nxt  = READ_LSTATUS_WORD3;

          sw2_req           = ~status_word2_obtained & status_word0_obtained & ~sram_add_gnt[1] & ~sram_dat_gnt[1];
          sw3_req           = dma_bus_width_override == 2'b00 && ~status_word3_obtained && status_word0_obtained && ~sram_add_gnt[2] && ~sram_dat_gnt[2];
        end

        READ_LSTATUS_WORD2 :
        begin
          sw3_req           = dma_bus_width_override == 2'b00 && status_word0_obtained;  // Only in 32b/64b mode do we need to fetch status_word2 separately
          if (need_to_replay | reading_pkt_last_word_req)
            read_state_nxt  = WAIT_FOR_STATUS;
          else if (sram_req_gnt[2])
            read_state_nxt  = READ_LSTATUS_WORD3;
          else
            read_state_nxt  = PKT_DATA;
        end

        READ_LSTATUS_WORD3 :
        begin
          if (need_to_replay | reading_pkt_last_word_req)
            read_state_nxt  = WAIT_FOR_STATUS;
          else
            read_state_nxt  = PKT_DATA;
        end

        default : // WAIT_FOR_STATUS only entered if we have finished reading the frame from SRAM, but havent yet got all the status words
        begin
          sw2_req               = ~status_word2_obtained & status_word0_obtained & ~sram_add_gnt[1] & ~sram_dat_gnt[1];
          sw3_req               = dma_bus_width_override == 2'b00 & ~status_word3_obtained & status_word0_obtained & ~sram_add_gnt[2] & ~sram_dat_gnt[2];
          if (status_word3_obtained)
          begin
            read_state_nxt      = IDLE;
          end
        end


      endcase
  end

  always @(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      read_state            <= IDLE;
      status_word_0         <= {p_dword_w{1'b0}};
      status_word_2         <= {p_dword_w{1'b0}};
      status_word_3         <= {p_dword_w{1'b0}};
      status_word0_add_int  <= {p_edma_tx_pbuf_addr{1'b0}};
      status_word0_obtained <= 1'b0;
      status_word2_obtained <= 1'b0;
      status_word3_obtained <= 1'b0;
    end
    else
    begin
      if (complete_flush | uflow_wait_for_dma)
      begin
        read_state            <= IDLE;
        status_word_0         <= {p_dword_w{1'b0}};
        status_word_2         <= {p_dword_w{1'b0}};
        status_word_3         <= {p_dword_w{1'b0}};
        status_word0_add_int  <= {p_edma_tx_pbuf_addr{1'b0}};
        status_word0_obtained <= 1'b0;
        status_word2_obtained <= 1'b0;
        status_word3_obtained <= 1'b0;
      end
      else
      begin
        read_state              <= read_state_nxt;
        if (sample_sw0)
        begin
          if (|store_mac_sw0_en)
          begin
            status_word_0         <= store_1st_sw0[p_dword_w-1:0];
            status_word0_add_int  <= store_1st_sw0[p_dword_w+p_edma_tx_pbuf_addr+3:p_dword_w+4];
          end
          else
          begin
            status_word_0         <= status_word0_nxt[queue_dma_c];
            status_word0_add_int  <= status_word0_nxt_add[queue_dma_c];
          end
        end

        // For cut-thru operation, we can get the data straight from the cut-thru buffer
        if (sample_sw0 & cutthru_status_word_valid)
        begin
          status_word_2     <= ct_fifo_w2;
          status_word_3     <= ct_fifo_w3;
        end
        else if (sram_dat_gnt[1])
        begin
          if (gem_tx_pbuf_data_w_is_128)
          begin
            status_word_2     <= tx_dob_w2;
            status_word_3     <= tx_dob_w3;
          end
          else if (dma_bus_width[0])
          begin
            status_word_2     <= tx_dob_w0;
            status_word_3     <= tx_dob_w1;
          end
          else
            status_word_2     <= tx_dob_w0;
        end
        else if (sram_dat_gnt[2])
          status_word_3       <= tx_dob_w0;


        if (read_state_nxt == IDLE)
        begin
          status_word0_obtained   <= 1'b0;
          status_word2_obtained   <= 1'b0;
          status_word3_obtained   <= 1'b0;
        end
        else if (sample_sw0)
        begin
          status_word0_obtained   <= 1'b1;
          if (cutthru_status_word_valid)
          begin
            status_word2_obtained   <= 1'b1;
            status_word3_obtained   <= 1'b1;
          end
        end
        else if (sram_dat_gnt[1] & read_state != IDLE) // impossible to get status word 1 in IDLE state - if it is set, then it is residual from previous frame and should be ignored.
        begin
          status_word2_obtained   <= 1'b1;
          if (gem_tx_pbuf_data_w_is_128 || dma_bus_width != 2'b00)
            status_word3_obtained <= 1'b1;
        end
        else if (sram_dat_gnt[2] & read_state != IDLE) // impossible to get status word 2 in IDLE state - if it is set, then it is residual from previous frame and should be ignored.
          status_word3_obtained <= 1'b1;
      end
    end
  end

  assign pkt_data_nxt_add  = bind2queueRange((pkt_data_sram_addr[p_edma_tx_pbuf_addr-1:0] + {{p_edma_tx_pbuf_addr-1{1'b0}},1'b1}),
                                               TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[queue_dma],
                                               TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[queue_dma],
                                               TX_PBUF_NUM_SEGMENTS_ARRAY[queue_dma]);

  wire [p_edma_tx_pbuf_addr-1:0] pkt_data_addr_inc1;
  assign pkt_data_addr_inc1 = (gem_tx_pbuf_data_w_is_128 || dma_bus_width != 2'b00)  ? ({{p_edma_tx_pbuf_addr-2{1'b0}},2'b10})
                                                                                     : ({{p_edma_tx_pbuf_addr-2{1'b0}},2'b11});
  assign pkt_data_nxt_add2 = bind2queueRange((pkt_data_sram_addr[p_edma_tx_pbuf_addr-1:0] + pkt_data_addr_inc1),
                                               TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[queue_dma],
                                               TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[queue_dma],
                                               TX_PBUF_NUM_SEGMENTS_ARRAY[queue_dma]);

  assign lstatus_word2_add = bind2queueRange((pkt_end_addr_int[p_edma_tx_pbuf_addr-1:0] + {{p_edma_tx_pbuf_addr-2{1'b0}},2'b01}),
                                               TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[queue_dma],
                                               TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[queue_dma],
                                               TX_PBUF_NUM_SEGMENTS_ARRAY[queue_dma]);

  assign lstatus_word3_add = bind2queueRange((pkt_end_addr_int[p_edma_tx_pbuf_addr-1:0] + {{p_edma_tx_pbuf_addr-2{1'b0}},2'b10}),
                                               TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[queue_dma],
                                               TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[queue_dma],
                                               TX_PBUF_NUM_SEGMENTS_ARRAY[queue_dma]);

  // The following signal holds the SRAM address of the packet data.
  // This is used by the main SRAM arbiter to load the SRAM address when the MAC is requesting data.
  // It is a counter implemented in flops, the source of which needs to be request phase timed from
  // the arbiters perspective.
  // When the main statemachine (which is request phase timed) moves from IDLE to PKT_DATA, we load
  // the initial frame address. This is identified by the signal "read_state_tr_idle2data".
  // When the MAC then issues read requests (granted via the SRAM arbiter by sram_req_gnt), we increment
  // the address.
  // If it is possible read_state_tr_idle2data will be set before the first tx_r_rd_int is issued by the MAC (when
  // we are finishing off a previous frame, the MAC may delay). In this case we want to gate
  // out the first address increment.
  // Note with the move of the scheduler to the MAC, this cant actually happen anymore, so we can
  // remove that code (9commented for furture reference -- see first_word_read)
  //reg                   first_word_read;

  // The data starts 1 location after status word 0 for 64 and 128 bit modes and 2 locations after for 32 bit modes
  wire [p_edma_tx_pbuf_addr-1:0] pkt_data_addr_inc;
  assign pkt_data_addr_inc = (gem_tx_pbuf_data_w_is_128 || dma_bus_width != 2'b00)  ? ({{p_edma_tx_pbuf_addr-1{1'b0}},1'b1})
                                                                                    : ({{p_edma_tx_pbuf_addr-2{1'b0}},2'b10});
  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      pkt_data_sram_addr  <= {p_edma_tx_pbuf_addr{1'b0}};
      //first_word_read     <= 1'b0;
    end
    else
    begin
      if (complete_flush)
      begin
        pkt_data_sram_addr  <= {p_edma_tx_pbuf_addr{1'b0}};
        //first_word_read     <= 1'b0;
      end
      else
      begin
        if (|store_mac_sw0_en & read_state_tr_idle2data)
        begin
          pkt_data_sram_addr  <= bind2queueRange((store_1st_sw0[p_dword_w+p_edma_tx_pbuf_addr+3:p_dword_w+4] + pkt_data_addr_inc),
                                                 TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[queue_dma_c],
                                                 TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[queue_dma_c],
                                                 TX_PBUF_NUM_SEGMENTS_ARRAY[queue_dma_c]);
          //first_word_read   <= sram_req_gnt[0];
        end
        else if (read_state_tr_idle2data)
        begin
          pkt_data_sram_addr  <= bind2queueRange((status_word0_nxt_add[queue_dma_c] + pkt_data_addr_inc),
                                                 TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[queue_dma_c],
                                                 TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[queue_dma_c],
                                                 TX_PBUF_NUM_SEGMENTS_ARRAY[queue_dma_c]);
          //first_word_read   <= sram_req_gnt[0];
        end
        else if (sram_req_gnt[0])
        begin
          //first_word_read   <= 1'b1;
          //if (first_word_read)
          //begin
            // Jump over status word
            if ((!status_word0_obtained & pkt_data_nxt_add == status_word0_nxt_add[queue_dma]) |
                (status_word0_obtained  & pkt_data_nxt_add == status_word0_add_int))
              pkt_data_sram_addr  <= pkt_data_nxt_add2;
            else
              pkt_data_sram_addr  <= pkt_data_nxt_add;
          //end
        end
      end
    end
  end
  assign pkt_end_mod_aph  = |dma_bus_width | gem_tx_pbuf_data_w_is_128 ? status_word_0[15:12]
                                                                       : {1'b0,status_word_0[14:12]};

  // in 32 bit modes, there are 2 locations used at the start of the frame for status, and 2 more at the end
  // for 64/128 there is only 1 locn reserved at the start. This makes the end locn a bit more complex ..
  wire [16:0] pkt_end_addr_intermediate;
  wire [17:0] pkt_end_addr_sum1;
  wire [16:0] pkt_end_addr_sum2;
  
  // pkt_end_addr_intermediate cannot overflow by construction so it will remain 17 bits. The same applies for pkt_end_addr_sum1 
  // and pkt_end_addr_sum2 too.
  // AFL is complaining about plt_end_addr_sum1 to have a bit more, so we will increase its size
  // and do a part select for the calculation of pkt_end_addr_sum2
  assign pkt_end_addr_intermediate = {{(17-p_edma_tx_pbuf_addr){1'b0}},status_word0_add_int} + {5'd0,status_word_0[11:0]};  
  assign pkt_end_addr_sum1         = pkt_end_addr_intermediate                               + {9'd0,status_word_0[23:16]};  
  assign pkt_end_addr_sum2         = pkt_end_addr_sum1[16:0]                                 + {18'd0,1'b1};
    
  always @(*)
  begin
    if (|dma_bus_width || gem_tx_pbuf_data_w_is_128)
      pkt_end_addr_int = pkt_end_addr_sum1[16:0];
    else
      pkt_end_addr_int = pkt_end_addr_sum2;
  end

  wire [11:0] num_sram_rds_c;
  wire [11:0] num_sram_rds;
  assign num_sram_rds_c = nxt_sw0_nxt[11:0];

  assign num_sram_rds = status_word_0[11:0] ;

  // The last read to the SRAM (req ph) occurs when pkt_dplocns_cnt == num_sram_rds
  wire                      reading_pkt_last_word_sram_req;
  assign reading_pkt_last_word_sram_req_c = pkt_dplocns_cnt == num_sram_rds_c;
  assign reading_pkt_last_word_sram_req   = pkt_dplocns_cnt == num_sram_rds & status_word0_obtained;

  // When the width of the SRAM = the datawidth feeding the MAC, then reading_pkt_last_word_req
  // is the same as reading_pkt_last_word_sram_req.
  // Otherwise when we are downsizing, it depends on the MOD (number of bytes to feed into the MAC).
  // these flops are only required in 128bit DP's, since downsizing only happens then
  generate if (p_edma_tx_pbuf_data == 32'd128) begin : gen_flops_for_128bitDP
    wire [3:0] pkt_end_mod_rph;  // Packet end mod, rph timed
    wire [3:0] pkt_end_mod_nxt;  // Packet end mod rph timed, just valid while in the IDLE state
    reg        reading_pkt_last_word_sram_d1;
    reg        reading_pkt_last_word_sram_d2;
    reg        reading_pkt_last_word_sram_d3;
    assign     pkt_end_mod_rph  = read_state_tr_idle2data ? pkt_end_mod_nxt  : pkt_end_mod_aph;
    assign     pkt_end_mod_nxt  = |dma_bus_width | gem_tx_pbuf_data_w_is_128 ? nxt_sw0_nxt[15:12]
                                                                             : {1'b0,nxt_sw0_nxt[14:12]};

    always@(posedge tx_r_clk or negedge tx_r_rst_n)
    begin
      if (~tx_r_rst_n)
      begin
        reading_pkt_last_word_sram_d1 <= 1'b0;
        reading_pkt_last_word_sram_d2 <= 1'b0;
        reading_pkt_last_word_sram_d3 <= 1'b0;
      end
      else
      begin
        if (complete_flush | read_state_nxt == IDLE )
        begin
          reading_pkt_last_word_sram_d1 <= 1'b0;
          reading_pkt_last_word_sram_d2 <= 1'b0;
          reading_pkt_last_word_sram_d3 <= 1'b0;
        end
        else if (|tx_r_rd_int)
        begin
          if (empty_next_downsize)
            reading_pkt_last_word_sram_d1 <= sample_sw0 ? reading_pkt_last_word_sram_req_c : reading_pkt_last_word_sram_req;
          reading_pkt_last_word_sram_d2   <= reading_pkt_last_word_sram_d1;
          reading_pkt_last_word_sram_d3   <= reading_pkt_last_word_sram_d2;
        end
      end
    end

    always @(*)
    begin
      if (emac_bus_width == 2'b00)
      begin
        if (pkt_end_mod_rph <= 4'h4 & pkt_end_mod_rph > 4'h0 & empty_next_downsize)
          reading_pkt_last_word_req_c = |tx_r_rd_int & reading_pkt_last_word_sram_req_c;
        else if (pkt_end_mod_rph <= 4'h8 & pkt_end_mod_rph != 4'h0)
          reading_pkt_last_word_req_c = |tx_r_rd_int & reading_pkt_last_word_sram_d1;
        else if (pkt_end_mod_rph <= 4'hc & pkt_end_mod_rph != 4'h0)
          reading_pkt_last_word_req_c = |tx_r_rd_int & reading_pkt_last_word_sram_d2;
        else
          reading_pkt_last_word_req_c = |tx_r_rd_int & reading_pkt_last_word_sram_d3;
      end
      else if (emac_bus_width == 2'b01)
      begin
        if (pkt_end_mod_rph <= 4'h8 & pkt_end_mod_rph > 4'h0 & empty_next_downsize)
          reading_pkt_last_word_req_c = |tx_r_rd_int & reading_pkt_last_word_sram_req_c;
        else
          reading_pkt_last_word_req_c = |tx_r_rd_int & reading_pkt_last_word_sram_d1;
      end
      else
        reading_pkt_last_word_req_c = |tx_r_rd_int & reading_pkt_last_word_sram_req_c;
    end

    always @(*)
    begin
      if (emac_bus_width == 2'b00)
      begin
        if (pkt_end_mod_rph <= 4'h4 & pkt_end_mod_rph > 4'h0 & empty_next_downsize)
          reading_pkt_last_word_req = |tx_r_rd_int & reading_pkt_last_word_sram_req;
        else if (pkt_end_mod_rph <= 4'h8 & pkt_end_mod_rph != 4'h0)
          reading_pkt_last_word_req = |tx_r_rd_int & reading_pkt_last_word_sram_d1;
        else if (pkt_end_mod_rph <= 4'hc & pkt_end_mod_rph != 4'h0)
          reading_pkt_last_word_req = |tx_r_rd_int & reading_pkt_last_word_sram_d2;
        else
          reading_pkt_last_word_req = |tx_r_rd_int & reading_pkt_last_word_sram_d3;
      end
      else if (emac_bus_width == 2'b01)
      begin
        if (pkt_end_mod_rph <= 4'h8 & pkt_end_mod_rph > 4'h0 & empty_next_downsize)
          reading_pkt_last_word_req = |tx_r_rd_int & reading_pkt_last_word_sram_req;
        else
          reading_pkt_last_word_req = |tx_r_rd_int & reading_pkt_last_word_sram_d1;
      end

      else
        reading_pkt_last_word_req = |tx_r_rd_int & reading_pkt_last_word_sram_req;
    end

  end else begin : gen_no_flops_for_128bitDP
    always @(*)
    begin
      reading_pkt_last_word_req_c = |tx_r_rd_int & reading_pkt_last_word_sram_req_c;
      reading_pkt_last_word_req = |tx_r_rd_int & reading_pkt_last_word_sram_req;
    end
  end
  endgenerate


  assign reading_pkt_last_word_req_vld = sample_sw0 ? reading_pkt_last_word_req_c : reading_pkt_last_word_req;

  assign status_word0_add = bind2queueRange((status_word0_add_int),
                                               TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[queue_dma],
                                               TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[queue_dma],
                                               TX_PBUF_NUM_SEGMENTS_ARRAY[queue_dma]);

  // error, but need to replay the pkt that has just been sent to MAC
  assign replay_residual_frame = (pkt_mac_sent & (late_coll_occured|too_many_retries) & num_pkts_in_mac[1]);

  assign need_to_replay = replay_residual_frame | coll_occurred_le | need_to_replay_r;


  // If we are in half duplex mode, it is possible the transmission will suffer collisions.
  // For normal collisions, we will restart the transmission.
  // this is complicated by the fact we might get collisions after the frame has left the DMA
  // I.e. a collision during the last few bytes of the frame. To do this, we need to
  // remember up to two status word_1's. The first is the one associated with the frame that caused
  // the collision (status_word_mac_0). We already have this stored. The second is the one that
  // is associated with the frame we are currently sending to the MAC. This may be different to the
  // first one if the collision happened on a frame that has completely been sent in the past to the MAC
  always@(*)
  begin
    if (need_to_replay)
      num_pkts_in_mac_nxt = 2'b00;
    else if (read_state == IDLE && read_state_nxt != IDLE)
    begin
      if (~sw_mac_fifo_pop)
        num_pkts_in_mac_nxt = num_pkts_in_mac + 2'b01;
      else
        num_pkts_in_mac_nxt = num_pkts_in_mac;
    end
    else if (sw_mac_fifo_pop)
      num_pkts_in_mac_nxt = num_pkts_in_mac - 2'b01;
    else
      num_pkts_in_mac_nxt = num_pkts_in_mac;
  end


  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      num_pkts_in_mac             <= 2'b00;
      store_mac_sw0_en            <= 2'b00;
      store_1st_sw0               <= {p_dword_w+p_edma_tx_pbuf_addr+4{1'b0}};
      store_2nd_sw0               <= {p_dword_w+p_edma_tx_pbuf_addr+4{1'b0}};
      need_to_replay_r            <= 1'b0;
    end
    else
    begin
      if (complete_flush)
      begin
        num_pkts_in_mac             <= 2'b00;
        store_mac_sw0_en            <= 2'b00;
        store_1st_sw0               <= {p_dword_w+p_edma_tx_pbuf_addr+4{1'b0}};
        store_2nd_sw0               <= {p_dword_w+p_edma_tx_pbuf_addr+4{1'b0}};
        need_to_replay_r            <= 1'b0;
      end
      else
      begin
        num_pkts_in_mac             <= num_pkts_in_mac_nxt;
        if (status_word2_obtained & status_word3_obtained)
          need_to_replay_r          <= 1'b0;
        else if (need_to_replay & read_state != IDLE)
          need_to_replay_r          <= 1'b1;

        if (need_to_replay & ~store_mac_sw0_en[1])
        begin
          // Case 1 :  collision occuring while frame is being transferred, 1 pkt_in_mac - need to replay
          if (num_pkts_in_mac == 2'b01 & read_state != IDLE)
          begin
            store_mac_sw0_en      <= 2'b01;
            store_1st_sw0         <= {status_word0_add_mac,queue_mac,status_word_mac_0};
            store_2nd_sw0         <= {p_dword_w+p_edma_tx_pbuf_addr+4{1'b0}};
          end
          // Case 2 : collision occuring after frame has being transferred, 1 pkt_in_mac - need to replay and shift
          else if (num_pkts_in_mac == 2'b01)
          begin
            store_mac_sw0_en      <= store_mac_sw0_en + 2'b01;
            store_1st_sw0         <= {status_word0_add_mac,queue_mac,status_word_mac_0};
            store_2nd_sw0         <= store_1st_sw0;
          end
          // Case 3 : normal collision, 2 pkt_in_mac, replay oldest
          else if (num_pkts_in_mac == 2'b10 & !replay_residual_frame)
          begin
            store_mac_sw0_en      <= 2'b10;
            store_1st_sw0         <= {status_word0_add_mac,queue_mac,status_word_mac_0};
            store_2nd_sw0         <= {status_word0_add,    queue_dma,status_word_0};
          end
          // Case 4 : late collision/tmr, 2 pkt_in_mac, replay newest
          else //if (num_pkts_in_mac == 2'b10)
          begin
            store_mac_sw0_en      <= 2'b01;
            store_1st_sw0         <= {status_word0_add,    queue_dma,status_word_0};
            store_2nd_sw0         <= {p_dword_w+p_edma_tx_pbuf_addr+4{1'b0}};
          end
        end
        else if (read_state != IDLE & read_state_nxt == IDLE & (|store_mac_sw0_en) & ~need_to_replay)
        begin
          store_mac_sw0_en      <= store_mac_sw0_en - 2'b01;
          store_1st_sw0         <= store_2nd_sw0;
          store_2nd_sw0         <= {p_dword_w+p_edma_tx_pbuf_addr+4{1'b0}};
        end
      end
    end
  end

  reg tx_r_control_r;

  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      reading_pkt_last_word_add   <= 1'b0;
      tx_r_mod_dph                <= 4'h0;
      tx_r_flushed_uflow          <= 1'b0;
      tx_r_underflow_dph          <= 1'b0;
      tx_r_sop_aph                <= 1'b0;
      tx_r_sop_dph                <= 1'b1;
      tx_r_eop_dph                <= 1'b0;
      tx_r_err_dph                <= 1'b0;
      tx_r_valid_dph              <= 1'b0;
      tx_r_data_rdy_aph           <= {p_edma_queues{1'b0}};
      tx_r_control_r              <= 1'b0;
      tx_r_pip                    <= 1'b0;
    end
    else
    begin
      if (complete_flush)
      begin
        reading_pkt_last_word_add   <= 1'b0;
        tx_r_mod_dph                <= 4'h0;
        tx_r_flushed_uflow          <= 1'b0;
        tx_r_underflow_dph          <= 1'b0;
        tx_r_sop_dph                <= 1'b1;
        tx_r_eop_dph                <= 1'b0;
        tx_r_err_dph                <= 1'b0;
        tx_r_sop_aph                <= 1'b0;
        tx_r_valid_dph              <= 1'b0;
        tx_r_data_rdy_aph           <= {p_edma_queues{1'b0}};
        tx_r_control_r              <= 1'b0;
        tx_r_pip                    <= 1'b0;
      end
      else
      begin
        tx_r_control_r  <= tx_r_control;

        if (|tx_r_rd_int)
          reading_pkt_last_word_add <= reading_pkt_last_word_req_vld;

        for (b1=0;b1<p_edma_queues[31:0];b1=b1+1)
        begin
          // Clear the stored tx_r_data_rdy on the last request
          // Also need to clear everything down if we are about to replay due to a collision or if there was an udnerflow
          if (need_to_replay | uflow_wait_for_dma)
            tx_r_data_rdy_aph[b1]   <= 1'b0;
          else if (tx_r_rd[b1] & reading_pkt_last_word_add)
            tx_r_data_rdy_aph[b1]   <= tx_r_data_rdy_rph[b1];
          else if (tx_r_data_rdy_rph[b1])
            tx_r_data_rdy_aph[b1]   <= 1'b1;
        end

        tx_r_valid_dph              <= |tx_r_rd;

        tx_r_mod_dph                <= pkt_end_mod_aph[3:0];
        tx_r_underflow_dph          <= |tx_r_rd & dpram_almost_empty_sync[queue_dma] & start_reading_at_risk_q[queue_dma];
        tx_r_sop_aph                <= read_state_tr_idle2data;
        tx_r_sop_dph                <= tx_r_sop_aph;
        tx_r_eop_dph                <= (|tx_r_rd & reading_pkt_last_word_add);
        tx_r_err_dph                <= (|tx_r_rd & reading_pkt_last_word_add & (|status_word_0[30:28]));
        tx_r_flushed_uflow          <= underflow_frame;

        if (tx_r_sop_aph)
          tx_r_pip  <= 1'b1;
        else if (tx_r_eop_dph)
          tx_r_pip  <= 1'b0;

      end
    end
  end

  // Make combinatorial. This has allowed us to register the tx_r_rd_int signal from MAC to DMA
  // thus breaking a long timing path (hurting slow FPGA builds).  It also saves a lot of gates -
  // disadvantage is that the SRAM databus goes straight to the MAC block now ...
  always@(*)
  begin
    tx_r_valid                  = tx_r_valid_dph;
    tx_r_eop                    = tx_r_eop_dph;

    if (status_word0_obtained)
      tx_r_control   = status_word_0[27] & ~status_word_0[31];
    else if (tx_r_eop & tx_r_valid)
      tx_r_control   = 1'b0;
    else
      tx_r_control   = tx_r_control_r;

    tx_r_mod                    = tx_r_mod_dph;
    tx_r_flushed                = coll_occurred_le | (pkt_mac_sent & (late_coll_occured|too_many_retries)) | tx_r_flushed_uflow;
    tx_r_underflow              = tx_r_underflow_dph;
    tx_r_sop                    = tx_r_sop_dph;
    tx_r_err                    = tx_r_err_dph;
  end

  assign tx_r_data_rdy  = tx_r_data_rdy_aph;
//  assign tx_r_data_rdy  = (tx_r_data_rdy_rph & ~{p_edma_queues{uflow_wait_for_dma}}) | tx_r_data_rdy_aph;

  // This bus  is passed through directly out of
  // this module and out of the DMA as tx_r_data.
  assign tx_r_data      = (tx_r_pip & tx_r_valid_dph) ? tx_dob_downsize[p_emac_bus_width-1:0]
                                                      : {p_emac_bus_width{1'b0}};
  assign tx_r_data_par  = (tx_r_pip & tx_r_valid_dph) ? tx_dob_downsize_par[p_emac_bus_pwid-1:0]
                                                      : {p_emac_bus_pwid{1'b0}};

// -----------------------------------------------------------------------------------------------
// Now decide how to free up SRAM resources ...
// This is dependent on the mode of operation  ...
//  1) Only free up SRAM resources once the frame has been known to have transmitted to the wire.
//     This is after the last byte has been forwarded to the MAC, and which has also completely
//     passed through the MAC TX pipeline.  For this, we need to keep track of the number
//     of SRAM locations used by the frame until the frame has passed out of the MAC. This info
//     is held in the status words of a frame.
//     This mode of operation is needed when we need to replay the current frame from the start,
//     because of half duplex collisions, or because we want to repeat transmission of a frame
//     for whatever reason.
//
//  2) Free up SRAM locations as they are read and forwarded to the MAC.  We can do this in most
//     full duplex configurations, assuming we definately do not want to repeat the frame.  We must
//     do this in cut-through configs. Freeing up locations dynamically helps performance as well as
//     SRAM utilization. Performace is improved as the AXI/AHB side of the DMA can fill up space earlier
//     than it would otherwise do.  SRAM utilization is improved - we can support equal performance with
//     smaller SRAM's.

  // First select the mode ...
  assign data_to_mac_xfer_mode = full_duplex;

  // The total number of locations to free up is stored in a bank of flops called
  // clr_dplocns_val.
  // When we first sample the status words, we can also capture the total number of SRAM locations used
  // by this frame, which is stored in SW0.  This will depend on the size of the frame, and also the
  // number of locations used to store the status words (which itself depends on the width of the SRAM).
  // For mode 1 above, this signal will not change while the frame is being sent to the MAC.
  // For mode 2 above however, we will reduce this periodically after a fixed amount of packet data
  // has been forwarded. This fixed amount is set in parameter "partpkt_threshold"
  assign part_pkt_trigger = (sram_req_gnt[0] & ~reading_pkt_last_word_req_vld & data_to_mac_xfer_mode & !sample_sw0 &
                             {12'd0,pkt_dplocns_cnt_part} == {{(17-p_edma_tx_pbuf_addr){1'b0}},partpkt_threshold[p_edma_tx_pbuf_addr-1:0]});

  reg [12:0] clr_dplocns_val_nxt;
  reg [5:0]  pkt_dplocns_cnt_part_nxt;
  reg [12:0] pkt_dplocns_cnt_nxt;
  wire [16:0] tmp_clr_dplocns_nxt;
  assign tmp_clr_dplocns_nxt = {5'd0,clr_dplocns_val} - {{(17-p_edma_tx_pbuf_addr){1'b0}},partpkt_threshold[p_edma_tx_pbuf_addr-1:0]};
  always @(*)
  begin
      if (read_state_nxt == IDLE | part_pkt_trigger)
        pkt_dplocns_cnt_part_nxt = 5'h01;
      else if (sram_req_gnt[0] & data_to_mac_xfer_mode)
        pkt_dplocns_cnt_part_nxt = pkt_dplocns_cnt_part + 5'h01;
      else
        pkt_dplocns_cnt_part_nxt = {1'b0,pkt_dplocns_cnt_part};

      if (read_state_nxt == IDLE)
        pkt_dplocns_cnt_nxt    = 12'h001;
      else if (sram_req_gnt[0])
        pkt_dplocns_cnt_nxt    = pkt_dplocns_cnt + 12'h001;
      else
        pkt_dplocns_cnt_nxt    = {1'b0,pkt_dplocns_cnt};

      if (read_state_nxt == IDLE && read_state != IDLE)
        clr_dplocns_val_nxt    = 13'd0;
      else if (|store_mac_sw0_en & read_state_tr_idle2data) // replaying a frame from storage buffer
        clr_dplocns_val_nxt  = {1'b0,nxt_sw0_nxt[11:0]};
      else if (sample_sw0)
        clr_dplocns_val_nxt  = clr_dplocns_val + nxt_sw0_nxt[11:0];
      else
      begin
        // Now reduce clr_dplocns_val as we progress through the frame ...
        if (part_pkt_trigger)
          clr_dplocns_val_nxt  = tmp_clr_dplocns_nxt[12:0];
        else
          clr_dplocns_val_nxt  = {1'b0,clr_dplocns_val};
      end
  end

  always @(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      clr_dplocns_val       <= 12'd0;
      pkt_dplocns_cnt_part  <= 5'h00;
      pkt_dplocns_cnt       <= 12'd0;
    end
    else
    begin
      if (complete_flush)
      begin
        clr_dplocns_val       <= 12'd0;
        pkt_dplocns_cnt_part  <= 5'h00;
        pkt_dplocns_cnt       <= 12'd0;
      end
      else
      begin
        clr_dplocns_val       <= clr_dplocns_val_nxt[11:0];
        pkt_dplocns_cnt_part  <= pkt_dplocns_cnt_part_nxt[4:0];
        pkt_dplocns_cnt       <= pkt_dplocns_cnt_nxt[11:0];
      end
    end
  end

// The actual mechanism to free up SRAM locations is a handshake between this module and the AXI/AHB
// side of the DMA.  This is across a clock boundary and is handled using toggles.
// To free up part of the packet (Fixed at partpkt_threshold), we can just send the toggle directly
// without any accompanying information (other than the queue), since the AHB/AXI side can assume
// the number of locations is partpkt_threshold.
// Note that we assume the AXI/AHB clock frequency is at least 1/4 of the tx_clk frequency for this
// to sample correctly.
  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      part_pkt_queue  <= 4'h0;
      part_pkt_read   <= 1'b0;
    end
    else if (complete_flush)
    begin
      part_pkt_queue  <= 4'h0;
      part_pkt_read   <= part_pkt_read;
    end
    else if (part_pkt_trigger)
    begin
      part_pkt_queue  <= queue_dma;
      part_pkt_read   <= ~part_pkt_read;
    end
  end

// For the update at the end of the frame, we will send the clr_dplocns_val information
// along with other bits of the status information so the AHB/AXI can initiate a descriptor
// writeback, as well as free up the last remaining DPRAM locations.
// One complication to this is that we need to wait until the frame has successfully been
// sent to the wire before issuing the command.  Unfortunately this means we have to buffer
// all this information since the status words are lost once the final byte has been pushed
// to the MAC. We need to buffer the status information locally.
// We dont allow more than two EOP's in the MAC pipeline at any one time, so we should only have to
// buffer the status words twice ...

  // First Identify when the MAC actually transmits a frame to the wire ...
  reg           dma_tx_end_tog_prev;        // MAC has transmitted the pkt
  reg           dma_tx_small_end_tog_prev;  // XGM MAC has transmitted the small pkt
  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      dma_tx_end_tog_prev       <= 1'b0;
      dma_tx_small_end_tog_prev <= 1'b0;
    end
    else if (complete_flush)
    begin
      dma_tx_end_tog_prev       <= dma_tx_end_tog_prev;
      dma_tx_small_end_tog_prev <= dma_tx_small_end_tog_prev;
    end
    else
    begin
      dma_tx_end_tog_prev       <= dma_tx_end_tog;
      dma_tx_small_end_tog_prev <= dma_tx_small_end_tog;
    end
  end

  // dma_tx_status_tog
  // Signal completion back to the gem_tx module. This toggle
  // handshaking signal is set once both management writeback has
  // completed and the pclk update has completed.
  // Additionally if a collision has occured, this same handshaking
  // mechanism is used by gem_tx to indicate that the collision has
  // been seen and serviced by the DMA.
  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
  if (~tx_r_rst_n)
    dma_tx_status_tog <= 1'b0;
  else
    begin
      if (pkt_mac_sent | coll_occurred_le)
        dma_tx_status_tog <= ~dma_tx_status_tog;
    end
  end

  // Detect edge on collision for acknowledge toggle
  reg                 coll_occurred_d1;
  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
      coll_occurred_d1 <= 1'b0;
    else
      coll_occurred_d1 <= collision_occured;
  end

  // Detect leading edge
  assign coll_occurred_le =  collision_occured & ~coll_occurred_d1;


  assign pkt_mac_sent = (dma_tx_end_tog_prev        ^ dma_tx_end_tog) |
                        (dma_tx_small_end_tog_prev  ^ dma_tx_small_end_tog);

  // now buffer the status words and the number of words to free up ...
  assign sw_mac_fifo_push = sample_sw0;
  assign sw_mac_fifo_din =  |store_mac_sw0_en ? {store_1st_sw0[p_dword_w+p_edma_tx_pbuf_addr+3:p_dword_w+4],store_1st_sw0[p_dword_w-1:0]}
                                              : {status_word0_nxt_add[queue_dma_c],status_word0_nxt[queue_dma_c]};

// status word 0 (mac version) info might be needed if we need to replay the frame, which might happen as we
// xfer the frame through to the MAC from the DMA. We therefore need to load it as soon as we have it.
// For this info, we actually have it right from the start for full store and forward mode. It is later in
// partial store and forward mode, but we dont support replays in PSF.
  edma_gen_fifo #( .FIFO_WIDTH(p_dword_w+p_edma_tx_pbuf_addr),
                   .FIFO_DEPTH(2),
                   .FIFO_ADDR_WIDTH(4'd1)
                 ) i_status_word0_mac (

    .qout       ({status_word0_add_mac,status_word_mac_0}),
    .qempty     (sw_mac_fifo_empty),
    .qfull      (sw_mac_fifo_full),
    .qlevel     (),
    .clk_pcie   (tx_r_clk),
    .rst_n      (tx_r_rst_n),

    .din        (sw_mac_fifo_din),
    .push       (sw_mac_fifo_push),
    .flush      (complete_flush | need_to_replay),
    .pop        (sw_mac_fifo_pop)
  );

   // add in the status words used for each frame...
   reg  [12:0] clr_dplocns_val_pstatus;
   always @(*)
   begin
     if (gem_tx_pbuf_data_w_is_128)
       clr_dplocns_val_pstatus  = clr_dplocns_val + 12'd1;
     else if (dma_bus_width[0])
       clr_dplocns_val_pstatus  = clr_dplocns_val + 12'd2;
     else
       clr_dplocns_val_pstatus  = clr_dplocns_val + 12'd4;
   end

// the other status words, and the number of locations to clear for this frame dont need to be loaded until we
// finish processing the frame. This is beasically when we transition to IDLE.
// Also has parity if necessary
  wire   read_state_nxt_is_idle;
  assign read_state_nxt_is_idle = (read_state_nxt == IDLE);
   
  edma_gen_fifo #( .FIFO_WIDTH((p_dword_w*2)+12),
                   .FIFO_DEPTH(2),
                   .FIFO_ADDR_WIDTH(4'd1)
                 ) i_status_word23_mac (

    .qout       ({clr_dplocns_val_mac,status_word_mac_3,status_word_mac_2}),
    .qempty     (sw_mac_fifo_2_empty),
    .qfull      (),
    .qlevel     (),
    .clk_pcie   (tx_r_clk),
    .rst_n      (tx_r_rst_n),

    .din        ({clr_dplocns_val_pstatus[11:0],status_word_3,status_word_2}),
    .push       (read_state_nxt_is_idle && status_word3_obtained & (|num_pkts_in_mac)),
    .flush      (complete_flush | need_to_replay),
    .pop        (sw_mac_fifo_pop)
  );

// The pop for both the FIFO's above should be when the MAC layer is completely done with the info.
// This is basically when the MAC has finished transmitting the frame to the wire, or when the status info at the
// head of the queue identifies a status only frame (in which case nothing is to be sent to the MAC).  There is
// one complication to this. for too many retries and late collisions, the MAC can signal pkt transmitted (via
// pkt_mac_sent) before the DMA has finished issuing the frame itself to the MAC. This means the FIFO's may not actually
// contain the data needed to pop.  To get around this, we first create a 'pop' signal, then we check if the fill
// levels of both FIFO's are the same. If they are, then we allow a pop.  If not, then we hold the pop signal until
// we do have the data.
// We also block this from popping if the downstream FIFO is full and cant take the contents.
  assign sw_mac_fifo_pop_raw = ((pkt_mac_sent & ~coll_occurred_le) |
                                status_word_mac_0[31]) & !sw_mac_fifo_empty;

  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      sw_mac_fifo_pop_hold          <= 1'b0;
      late_coll_occured_hold        <= 1'b0;
      too_many_retries_hold         <= 1'b0;
    end
    else if (complete_flush)
    begin
      sw_mac_fifo_pop_hold          <= 1'b0;
      late_coll_occured_hold        <= 1'b0;
      too_many_retries_hold         <= 1'b0;
    end
    else
    begin
      if      (sw_mac_fifo_pop_raw & wb_status_to_tx_wr_fifo_full)
      begin
        sw_mac_fifo_pop_hold        <= 1'b1;
        late_coll_occured_hold      <= late_coll_occured;
        too_many_retries_hold       <= too_many_retries;
      end
      else if (sw_mac_fifo_pop_raw & sw_mac_fifo_2_empty)
      begin
        sw_mac_fifo_pop_hold        <= 1'b1;
        late_coll_occured_hold      <= late_coll_occured;
        too_many_retries_hold       <= too_many_retries;
      end
      else if (!wb_status_to_tx_wr_fifo_full & !sw_mac_fifo_2_empty)
      begin
        sw_mac_fifo_pop_hold        <= 1'b0;
        late_coll_occured_hold      <= late_coll_occured_hold;
        too_many_retries_hold       <= too_many_retries_hold;
      end
    end
  end
  assign sw_mac_fifo_pop = ((sw_mac_fifo_pop_raw | sw_mac_fifo_pop_hold) &
                           (!wb_status_to_tx_wr_fifo_full & !(sw_mac_fifo_empty | sw_mac_fifo_2_empty)));

  assign late_coll_occured_mac = sw_mac_fifo_pop_hold ? late_coll_occured_hold & sw_mac_fifo_pop : late_coll_occured & sw_mac_fifo_pop;
  assign too_many_retries_mac  = sw_mac_fifo_pop_hold ? too_many_retries_hold & sw_mac_fifo_pop : too_many_retries & sw_mac_fifo_pop;

// Now we have the information to send to the AHB/AXI side of the DMA.
  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
    if (~tx_r_rst_n)
    begin
      full_pkt_read                 <= 1'b0;
      xfer_status_captured_edge_d1  <= 1'b0;
    end
    else if (complete_flush)
    begin
      full_pkt_read                 <= full_pkt_read;
      xfer_status_captured_edge_d1  <= 1'b0;
    end
    else
    begin
      xfer_status_captured_edge_d1  <= xfer_status_captured_edge & !wb_status_to_tx_wr_fifo_empty;
      if ((xfer_status_captured_edge_d1 & !wb_status_to_tx_wr_fifo_empty) |
          (sw_mac_fifo_pop              & wb_status_to_tx_wr_fifo_empty))
        full_pkt_read               <= ~full_pkt_read;

    end
  end

  // The following is a 2 deep plumbing FIFO that stores the status information that is passed to
  // the TX WR block.  It is loaded when a packet has been fully transmitted to the wire, or
  // when a status only packet (errored, not passed to MAC) is detected - these status only
  // frames are simply routed back to the TX WR
  assign sword0_cmprsd_mac            = {sword0_cmprsd_mac_pad[18:15],sword0_cmprsd_mac_pad[13:0]};
  edma_gen_fifo #( .FIFO_WIDTH(p_wb_fifo_w),
                   .FIFO_DEPTH(2),
                   .FIFO_ADDR_WIDTH(4'd1)
                 ) i_wb_status_to_tx_wr_fifo (

    .qout       (wb_status_to_tx_wr_fifo_dout),
    .qempty     (wb_status_to_tx_wr_fifo_empty),
    .qfull      (wb_status_to_tx_wr_fifo_full),
    .qlevel     (),
    .clk_pcie   (tx_r_clk),
    .rst_n      (tx_r_rst_n),

    .din        (wb_status_to_tx_wr_fifo_din),
    .push       (sw_mac_fifo_pop),
    .flush      (complete_flush),
    .pop        (xfer_status_captured_edge)
  );

  assign wb_status_to_tx_wr_fifo_afull = (!wb_status_to_tx_wr_fifo_empty & sw_mac_fifo_pop) || wb_status_to_tx_wr_fifo_full;
  assign sword0_cmprsd_mac_pad  = {status_word_mac_0[31:28],          // 18:15
                                  1'd0,                               // 14
                                  clr_dplocns_val_mac,                // 13:2
                                  late_coll_occured_mac,              // 1
                                  too_many_retries_mac} ;             // 0




  // ---------------------------------------------------------------
  // Underflow logic
  // The initial underflow detection is made by tx_r_underflow_dph
  // which looks at the current fill level of the DPRAM.
  // if it is decided we are to underflow, then  tx_r_underflow is
  // driven to the MAC.  The MAC will initiate it's own underflow
  // logic and sometime in the future will drive underflow_frame
  // On this, we need to perform a flush via tx_r_flushed and
  // toggle the status back to the MAC via dma_tx_status_tog
  // we will also drive an underflow_tog signal which will be
  // passed back to the AHB side of the PBUF.  There, a full
  // soft reset will be initiated, which in turn will be passed
  // to this module via complete_flush.  Until this happens, we
  // want to silence the MAC FIFO signals
  always@(posedge tx_r_clk or negedge tx_r_rst_n)
  begin
  if (~tx_r_rst_n)
  begin
    uflow_wait_for_mac <= 1'b0;
    uflow_wait_for_dma <= 1'b0;
    underflow_tog  <= 1'b0;
  end
  else
  begin
    if (complete_flush)
    begin
      uflow_wait_for_mac <= 1'b0;
      uflow_wait_for_dma <= 1'b0;
    end
    else if (tx_r_underflow_dph)
    begin
      uflow_wait_for_mac <= 1'b1;
      uflow_wait_for_dma <= 1'b1;
    end
    else if (underflow_frame)
    begin
      uflow_wait_for_mac <= 1'b0;
      if (uflow_wait_for_mac)
        underflow_tog <= ~underflow_tog;
    end
  end
  end


  // This function ensures a queue's upper address bits stay within its
  // upper and lower address limits. dpram_addr_c will automatically increment
  // on to the next address, which could be into the next queue's segment
  // space. We therefore stop this happening by checking the segment bounds.

  function [p_edma_tx_pbuf_addr-1:0] bind2queueRange (
    input [p_edma_tx_pbuf_addr-1:0] addr,
    input [p_edma_tx_pbuf_queue_segment_size-1:0] q_upper_bound, // Upper bound for segment
    input [p_edma_tx_pbuf_queue_segment_size-1:0] q_lower_bound, // Lower bound for segment
    input [4:0] q_num_segments); // Number of segments for the queue

    reg [p_edma_tx_pbuf_queue_segment_size-1:0] q_segment_mask;
    reg [p_edma_tx_pbuf_queue_segment_size+p_edma_tx_pbuf_addr-1:0] segment_addr_bits_pad;
    reg [p_edma_tx_pbuf_queue_segment_size-1:0] segment_addr_bits;
    reg [p_edma_tx_pbuf_addr-1:0] bind2queueRange_int;
    reg [p_edma_tx_pbuf_queue_segment_size-1:0] local_add_var1;
    reg [p_edma_tx_pbuf_queue_segment_size-1:0] local_add_var2;
    reg [p_edma_tx_pbuf_queue_segment_size:0] local_add_var;

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

      local_add_var1 = (segment_addr_bits - q_lower_bound);
      local_add_var2 = (local_add_var1 & q_segment_mask);
      local_add_var  = local_add_var2 + q_lower_bound;

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
                local_add_var[p_edma_tx_pbuf_queue_segment_size-1:0];
      end

      bind2queueRange = bind2queueRange_int;

  end
  endfunction

// -----------------------------------------------------------------------------
// ASF - End to end data path parity protection
// -----------------------------------------------------------------------------


  /////////////////////////////////////////////////
  // RAS - end to end parity check
  generate if (p_edma_asf_dap_prot == 1) begin : gen_dp_parity
    wire  dap_err_tx_r_data_c;
    wire  dap_err_status_words;
    wire  dap_err_xfer_sts_bus;
    wire  dap_err_xfer_sts_bus_ts;
    reg   asf_dap_tx_rd_err_r;

    // Parity check at the tx_r_data
    // This bus  is passed through directly out of
    // this module and out of the DMA as tx_r_data.
    // A parity check should be performed on this bus
    // at this stage and the parity bits then dropped.
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_emac_bus_width)) i_par_chk_dp_tx_r_data (
      .odd_par(1'b0),
      .data_in(tx_r_data),
      .parity_in(tx_r_data_par),
      .parity_err(dap_err_tx_r_data_c)
    );

    // Parity check the status words
    cdnsdru_asf_parity_check_v1 #(.p_data_width(192)) i_par_chk_sts_words (
      .odd_par(1'b0),
      .data_in({status_word_3[31:0],
                status_word_2[31:0],
                status_word_0[31:0],
                status_word_mac_3[31:0],
                status_word_mac_2[31:0],
                status_word_mac_0[31:0]}),
      .parity_in({status_word_3[35:32],
                  status_word_2[35:32],
                  status_word_0[35:32],
                  status_word_mac_3[35:32],
                  status_word_mac_2[35:32],
                  status_word_mac_0[35:32]}),
      .parity_err(dap_err_status_words)
    );

    // Parity check xfer_status_bus
    // Note that this has padding since the data is compressed and decompressed
    // later in tx_wr so the parity check is not done directly here.
    cdnsdru_asf_parity_check_v1 #(.p_data_width(88)) i_par_chk_xfer_sts_bus (
      .odd_par(1'b0),
      .data_in({xfer_status_bus[81:50], // Status word 3
                xfer_status_bus[49:18], // Status word 2
                6'h00,                  // Pad
                xfer_status_bus[17:0]   // Status word 0
                }),
      .parity_in(xfer_status_bus_par),
      .parity_err(dap_err_xfer_sts_bus)
    );

    // Parity check xfer_status_bus_ts
    cdnsdru_asf_parity_check_v1 #(.p_data_width(42)) i_par_chk_xfer_sts_bus_ts (
      .odd_par(1'b0),
      .data_in(xfer_status_bus_ts[41:0]), // Top bit is status and not protected
      .parity_in(xfer_status_bus_ts_par),
      .parity_err(dap_err_xfer_sts_bus_ts)
    );

    // Register parity error
    always@(posedge tx_r_clk or negedge tx_r_rst_n)
    begin
      if (~tx_r_rst_n)
        asf_dap_tx_rd_err_r <= 1'b0;
      else
        asf_dap_tx_rd_err_r <= dap_err_tx_r_data_c  | (|sw01_par_err) | dap_err_status_words |
                                dap_err_xfer_sts_bus | dap_err_xfer_sts_bus_ts;
    end
    assign asf_dap_tx_rd_err  = asf_dap_tx_rd_err_r;

    // Pad words with parity
    assign tx_dob_w0  = {tx_dob_par_pad[3:0],tx_dob_pad[31:0]};
    assign tx_dob_w1  = {tx_dob_par_pad[7:4],tx_dob_pad[63:32]};
    assign tx_dob_w2  = {tx_dob_par_pad[11:8],tx_dob_pad[95:64]};
    assign tx_dob_w3  = {tx_dob_par_pad[15:12],tx_dob_pad[127:96]};
    assign ct_fifo_w0 = {cutthru_status_word_par[3:0],cutthru_status_word[31:0]};
    assign ct_fifo_w1 = {cutthru_status_word_par[7:4],cutthru_status_word[63:32]};
    assign ct_fifo_w2 = {cutthru_status_word_par[11:8],cutthru_status_word[95:64]};
    assign ct_fifo_w3 = {cutthru_status_word_par[15:12],cutthru_status_word[127:96]};

    // Add parity to the sword0_cmprsd_mac to create sword0_cmprsd_mac_p
    cdnsdru_asf_parity_gen_v1 #(
      .p_data_width (18)
    ) i_par_gen_sword0_cmprsd_mac_p (
      .odd_par    (1'b0),
      .data_in    (sword0_cmprsd_mac),
      .data_out   (sword0_cmprsd_mac_p[17:0]),
      .parity_out (sword0_cmprsd_mac_p[20:18])
    );

    // If no p_edma_tsu is not defined, then no need to store the timestamp bits
    if (p_edma_tsu == 0) begin : gen_no_ts
      assign wb_status_to_tx_wr_fifo_din  = {status_word_mac_3,status_word_mac_2,sword0_cmprsd_mac_p};
      assign xfer_status_bus_ts_par       = 6'h00;
      assign xfer_status_bus_ts           = {43{1'b0}};
    end else begin : gen_ts
      assign wb_status_to_tx_wr_fifo_din  = {tx_timestamp_prty,ts_to_be_written,tx_timestamp,
                                            status_word_mac_3,status_word_mac_2,sword0_cmprsd_mac_p};
      assign xfer_status_bus_ts_par       = wb_status_to_tx_wr_fifo_dout[141:136];
      assign xfer_status_bus_ts           = wb_status_to_tx_wr_fifo_dout[135:93];
    end

    // Re-order output to separate parity bus from data
    assign xfer_status_bus_par[10:7]    = wb_status_to_tx_wr_fifo_dout[92:89];
    assign xfer_status_bus[81:50]       = wb_status_to_tx_wr_fifo_dout[88:57];
    assign xfer_status_bus_par[6:3]     = wb_status_to_tx_wr_fifo_dout[56:53];
    assign xfer_status_bus[49:18]       = wb_status_to_tx_wr_fifo_dout[52:21];
    assign xfer_status_bus_par[2:0]     = wb_status_to_tx_wr_fifo_dout[20:18];
    assign xfer_status_bus[17:0]        = wb_status_to_tx_wr_fifo_dout[17:0];
  end else begin : gen_no_dp_parity
    assign asf_dap_tx_rd_err = 1'b0;
    assign tx_dob_w0  = tx_dob_pad[31:0];
    assign tx_dob_w1  = tx_dob_pad[63:32];
    assign tx_dob_w2  = tx_dob_pad[95:64];
    assign tx_dob_w3  = tx_dob_pad[127:96];
    assign ct_fifo_w0 = cutthru_status_word[31:0];
    assign ct_fifo_w1 = cutthru_status_word[63:32];
    assign ct_fifo_w2 = cutthru_status_word[95:64];
    assign ct_fifo_w3 = cutthru_status_word[127:96];

    assign sword0_cmprsd_mac_p          = sword0_cmprsd_mac;

    // If no p_edma_tsu is not defined, then no need to store the timestamp bits
    if (p_edma_tsu == 0) begin : gen_no_ts
      assign wb_status_to_tx_wr_fifo_din  = {status_word_mac_3,status_word_mac_2,sword0_cmprsd_mac_p};
      assign xfer_status_bus_ts           = {43{1'b0}};
    end else begin : gen_ts
      assign wb_status_to_tx_wr_fifo_din  = {ts_to_be_written,tx_timestamp,
                                            status_word_mac_3,status_word_mac_2,sword0_cmprsd_mac_p};
      assign xfer_status_bus_ts           = wb_status_to_tx_wr_fifo_dout[124:82];
    end

    assign xfer_status_bus              = wb_status_to_tx_wr_fifo_dout[81:0];
    assign xfer_status_bus_ts_par       = 6'h00;
    assign xfer_status_bus_par          = 11'h000;
  end
  endgenerate

  // The following is just for lint
  genvar unused_q_cnt;
  generate for (unused_q_cnt=p_edma_queues[31:0]; unused_q_cnt<16; unused_q_cnt = unused_q_cnt+1)
  begin : set_unused_sigs
    wire zero = 1'b0;
    always@(*)
    begin
      status_word0_nxt[unused_q_cnt] = {p_dword_w{zero}};
      got_sw0_nxt[unused_q_cnt] = zero;
      start_reading_at_risk_q_nxt[unused_q_cnt] = zero;
      start_reading_at_risk_q[unused_q_cnt] = zero;
      num_pkts_needing_read[unused_q_cnt] = {8{zero}};
      status_word0_nxt_add[unused_q_cnt] = {p_edma_tx_pbuf_addr{zero}};
    end
    assign tx_r_rd_int_pad[unused_q_cnt] = 1'b0;
    assign status_frame_in_q[unused_q_cnt] = 1'b0;
    assign TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[unused_q_cnt] = {p_edma_tx_pbuf_queue_segment_size{1'b0}};
    assign TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[unused_q_cnt] = {p_edma_tx_pbuf_queue_segment_size{1'b0}};
    assign TX_PBUF_NUM_SEGMENTS_ARRAY[unused_q_cnt] = 5'd0;
    assign dpram_almost_empty_sync[unused_q_cnt] = 1'b0;
  end
  endgenerate


endmodule

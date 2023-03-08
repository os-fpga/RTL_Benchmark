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
//   Filename:           edma_pbuf_axi_tx_wr.v
//   Module Name:        edma_pbuf_axi_tx_wr
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

module edma_pbuf_axi_tx_wr # (
   parameter p_edma_tsu                         = 1'b1,
   parameter p_edma_axi                         = 1'b1,
   parameter p_edma_spram                       = 1'b0,
   parameter p_edma_pbuf_cutthru                = 1'b0,
   parameter p_edma_hprot_value                 = 4'd0,
   parameter p_edma_queues                      = 32'd1,
   parameter p_edma_addr_width                  = 32'd32,
   parameter p_edma_tx_pbuf_data                = 32'd64,
   parameter p_edma_tx_pbuf_addr                = 32'd10,
   parameter p_edma_tx_pbuf_queue_segment_size  = 32'd2,
   parameter p_edma_asf_dap_prot                = 1'b0,
   parameter p_ct_width                         = p_edma_tx_pbuf_addr+128,
   parameter p_ct_par_w                         = (p_ct_width+7)/8

   ) (

   // Constants to define the upper and lower bounds of the queue addresses. These would
   // normally be passsed in as parameters, but owing to how these bounds are calculated
   // (in a for loop) it's not possible to use a paramater and a wire is instead used.
   input [(p_edma_tx_pbuf_queue_segment_size*p_edma_queues)-1:0] TX_PBUF_SEGMENTS_LOWER_ADDR,
   input [(p_edma_tx_pbuf_queue_segment_size*p_edma_queues)-1:0] TX_PBUF_SEGMENTS_UPPER_ADDR,
   input [(16*5)-1:0]                                            TX_PBUF_NUM_SEGMENTS,

   // Set the max fill level for the queue
   input [(p_edma_tx_pbuf_addr*p_edma_queues)-1:0]  TX_PBUF_MAX_FILL_LVL,

   // System signals
   input                                            hclk,                // clock.
   input                                            n_hreset,            // reset.

   // Signals coming from gem_registers
   input                                            enable_tx_hclk,      // Enable transmission path (soft reset)
   input    [1:0]                                   dma_bus_width,       // Current programmed width of data bus:
   input                                            tx_pbuf_tcp_en,      // TCP offload enable
   input                                            bd_extended_mode_en, // enable extended BD mode, which is used to Descriptor TS insertion
   input                                            full_duplex,         // full duplex signal from the network.
                                                                         // configuration register.
   input [p_edma_tx_pbuf_addr-1:0]                  tx_cutthru_threshold,// Threshold value for cut-thru
   input                                            tx_cutthru,          // Enable for cut-thru operation

   // Main Interface with AXI TX
   input                                            cur_descr_rd_valid,  // Next descriptor is available
   output reg                                       cur_descr_rd_rdy,    // This module can consume the descriptor
   input  [96:0]                                    cur_descr_rd,        // The actual descriptor
   input  [12:0]                                    cur_descr_rd_par,    // Parity
   input  [31:0]                                    cur_descr_rd_add,    // The memory address where the descriptor is located
   input   [3:0]                                    cur_descr_rd_add_par,// Parity
   input   [3:0]                                    cur_descr_rd_queue,  // The queue the traffic belongs to
   input                                            buff_stripe_vld,     // Packet data is available
   output reg                                       buff_stripe_rdy,     // This module can consume the data
   input                                            buff_stripe_last,    // This is the last stripe of the buffer, not pkt
   input [127:0]                                    buff_stripe,         // the actual data
   input [15:0]                                     buff_stripe_par,     // the actual data

   // SRAM Interface
   output  reg                                      tx_ena,              // DPRAM Interface
   output                                           tx_wea,              // DPRAM Interface
   output  reg [p_edma_tx_pbuf_addr-1:0]            tx_addra,            // DPRAM Interface
   output  reg [127:0]                              tx_dia,              // DPRAM Interface
   output  reg [15:0]                               tx_dia_par,

  // Interface with read side of SRAM
   output  reg [p_edma_queues-1:0]                  end_of_packet_tog,   // Packet completely written into DPRAM
   output  reg [p_edma_queues-1:0]                  part_of_packet_tog,  // Part of Packet  written into DPRAM
   output  reg [(p_edma_queues*4)-1:0]              num_pkts_xfer,       // the number of pkts that have been written since last acceptance
   input       [p_edma_queues-1:0]                  pkt_captured,
   output      [p_edma_queues-1:0]                  pkt_end_new,         // Good Packet written into DPRAM
   output                                           pkt_end_flush,       // Packet flushed in DPRAM
   output  reg [p_edma_queues-1:0]                  dpram_almost_empty,
   output  reg                                      tx_wr_seen_uflow,

   // Descriptor Write Interface (from RD to WR side of SRAM)
   input                                            full_pkt_read,       // Status available from RD side of DPRAM
   input                                            part_pkt_read,       // Status available from RD side of DPRAM
   input   [3:0]                                    part_pkt_queue,      // Queue to which part_pkt_read refers to
   input  [81:0]                                    xfer_status_bus,     // Status to use for writeback
   input  [10:0]                                    xfer_status_bus_par, // Parity
   input  [42:0]                                    xfer_status_bus_ts,  // Status to use for writeback of timestamp
   input  [5:0]                                     xfer_status_bus_ts_par,// msb indicates ts_to_be_written to BD
                                                                         // last 6 bits are parity bits of timestamp[41:0]
   output  reg                                      xfer_status_captured,// Status from RD side has been captured
   input                                            underflow_tog,       // MAC indicates an underflow event

   // Descriptor Write Interface (from this block to AXI TX)
   output  reg                                      tx_descr_wr_vld,      // Direct interface to handle TX descriptor writes
   input                                            tx_descr_wr_rdy,
   output  reg [63:0]                               tx_descr_wr_data,
   output      [7:0]                                tx_descr_wr_data_par,
   output      [41:0]                               tx_descr_wr_ts,       // TX timestamp
   output      [5:0]                                tx_descr_wr_ts_par,   // RAS -TS - parity protection for tx_descr_wr_data
   output  reg [9:0]                                tx_descr_wr_sts,      // Status bits, these will be reflected back to this
                                                                          // module for interrupt gen

   // Status inputs that are the same as tx_descr_wr_sts but reflected back by AXI
   input       [9:0]                                reflected_tx_sts,    // Reflected Status bits
   input                                            reflected_tx_sts_vld,

   // Interrupt Generation ..
   output reg  [10:0]                               tx_status2apb,       // TX Status Sent to registers for interrupt ..
   output reg                                       tx_dma_stable_tog,   // Toggles when tx_status2apb is stable
   input                                            tx_stat_capt_pulse,  // Pulses when the the reg block has safely captured the status

   // Signals to gem_registers - REVIEW - SOME COULD MOVE TO AXI ?
   output reg                                       tx_dma_go,            // DMA indicates on-going activity.

    // Write to the cutthru FIFO
    output [p_ct_width-1:0]                         cutthru_status_word,
    output [p_ct_par_w-1:0]                         cutthru_status_word_par,
    output                                          cutthru_status_word_push,

   // Loose signals that pass between DMA WR and AXI TX
   output                                           dma_has_seen_err,
   output                                           complete_flush_hclk,  // Underflow event causes the whole transmitter to reset
   output [(p_edma_queues-1)*8+7:0]                 num_pkts_in_buf,
   output [p_edma_queues-1:0]                       buffer_full_q,
   output [(p_edma_queues*p_edma_tx_pbuf_addr)-1:0] dpram_fill_lvl,       // Fill level for all queues

   output                                           asf_dap_tx_wr_err

  );

  localparam p_wr_state_idle                    = 3'd0;
  localparam p_wr_state_frm_data                = 3'd1;
  localparam p_wr_state_wait_descr              = 3'd2;
  localparam p_wr_state_resid_data              = 3'd3;
  localparam p_wr_state_frm_ctrl_upd            = 3'd4;
  localparam p_wr_state_wait_csum               = 3'd5;
  localparam p_wr_state_ip_csum                 = 3'd6;
  localparam p_wr_state_tcp_csum                = 3'd7;


  // If parity protecting address, then tag parity to address width
  localparam p_awid_par  = (p_edma_asf_dap_prot == 1)  ? 36  : 32;

  reg                                      [2:0] sram_wr_state_nxt;
  reg                                      [2:0] sram_wr_state;
  reg                  [p_edma_tx_pbuf_addr-1:0] frm_data_add  [0 : p_edma_queues-1];
  wire                 [p_edma_tx_pbuf_addr-1:0] frm_data_add_pad  [0 : 15];
  wire                 [p_edma_tx_pbuf_addr-1:0] frm_data_add_c;
  wire                   [p_edma_tx_pbuf_addr:0] tx_addra_p1;
  wire                   [p_edma_tx_pbuf_addr:0] tx_addra_p2_or_p1;
  wire                   [p_edma_tx_pbuf_addr:0] tx_addra_p3_or_p2;
  wire                 [p_edma_tx_pbuf_addr-1:0] tx_addra_p1_c;
  wire                 [p_edma_tx_pbuf_addr-1:0] tx_addra_p2_or_p1_c;
  wire                 [p_edma_tx_pbuf_addr-1:0] tx_addra_p3_or_p2_c;
  reg                  [p_edma_tx_pbuf_addr-1:0] frm_ctrl_add;
  wire         [((p_edma_tx_pbuf_addr+7)/8)-1:0] frm_ctrl_add_par;
  reg                                            load_frm_ctrl_add;
  wire                                           stripe_is_last_of_pkt;
  reg                                     [96:0] first_descr;
  wire                                    [35:0] cur_descr_rd_add_p4;
  reg                           [p_awid_par-1:0] first_descr_wb_add;
  reg                                            this_is_1st_descr_nxt;
  reg                                            this_is_1st_descr;
  wire                                    [31:0] status_word_wr_0;
  wire                                     [3:0] status_word_wr_0_par;
  wire                                    [31:0] status_word_wr_1;
  wire                                     [3:0] status_word_wr_1_par;
  wire                                    [31:0] status_word_wr_2;
  wire                                     [3:0] status_word_wr_2_par;
  wire                                    [31:0] status_word_wr_3;
  wire                                     [3:0] status_word_wr_3_par;
  wire                                     [2:0] tcp_status;
  reg                                      [1:0] sts_upd_cnt_nxt;
  reg                                      [1:0] sts_upd_cnt;
  wire                                           frame_written_to_sram;
  wire                                    [11:0] frame_len_cnt_nxt;
  reg                                     [11:0] frame_len_cnt;
  reg                                      [4:0] buf_stripe_mod;
  wire                                     [3:0] err_status;
  wire                                    [13:0] cur_descr_len_field;
  wire                                           cur_descr_zero_len;
  wire                                           cur_descr_used_field;
  wire                                           cur_descr_last_field;
  wire                                    [17:0] status_word_rd_0;
  wire                                    [31:0] status_word_rd_2;
  wire                                    [31:0] status_word_rd_3;
  wire                                           ts_to_be_written;
  wire                                    [31:0] descriptor_wb_word1;
  wire                                           gen_int;
  reg                                      [6:0] str_int_vector;
  reg                                      [3:0] str_int_queue;
  reg                                            str_int_queue_done;
  reg                                            int_issued_wait_for_capt;
  wire                                           dma_late_col_int;
  wire                                           dma_toomanyretry_int;
  wire                                           dma_hresp_notok_int;
  wire                                           dma_buff_ex_mid_int;
  wire                                           dma_buff_ex_int;
  wire                                           dma_tx_ok_int;
  wire                                     [3:0] dma_queue_int;
  reg                  [p_edma_tx_pbuf_addr-1:0] dpram_fill_lvl_array  [p_edma_queues-1:0];
  wire                 [p_edma_tx_pbuf_addr-1:0] fill_lvl_inc[p_edma_queues-1:0];
  wire                 [p_edma_tx_pbuf_addr-1:0] fill_lvl_dec[p_edma_queues-1:0];
  wire                 [p_edma_tx_pbuf_addr-1:0] q_empty_lvl[p_edma_queues-1:0]; // When does the q hit empty
  wire                                   [127:0] ip_hdr_cs_reord;
  wire                                    [15:0] ip_hdr_cs_par_reord;
  wire                                   [127:0] ip_hdr_cs;
  wire                                    [15:0] ip_hdr_cs_par;
  wire                                           ip_hdr_cs_we;
  wire                 [p_edma_tx_pbuf_addr-1:0] ip_hdr_cs_addr;
  wire                                   [127:0] tcp_hdr_cs_reord;
  wire                                    [15:0] tcp_hdr_cs_par_reord;
  wire                                   [127:0] tcp_hdr_cs;
  wire                                    [15:0] tcp_hdr_cs_par;
  wire                                           tcp_hdr_cs_we;
  wire                 [p_edma_tx_pbuf_addr-1:0] tcp_hdr_cs_addr;
  wire                                   [127:0] al_w_data;
  wire                                    [15:0] al_w_data_par;
  wire                                     [3:0] al_w_mod;
  wire                                           al_w_wr;
  wire                                           al_w_eop;
  reg                                    [127:0] up_w_data;
  reg                                     [15:0] up_w_data_par;
  reg                                      [4:0] up_w_mod;
  reg                                            up_w_wr;
  reg                                            up_w_eop;
  reg                                      [1:0] upsize_str_cnt;
  reg                                      [1:0] upsize_str_cnt_nxt;
  reg                                     [95:0] upsize_data_str;
  wire                                    [11:0] upsize_data_str_par;
  wire                                           upsize_x2;
  wire                                           upsize_x4;
  wire                                     [4:0] TX_PBUF_NUM_SEGMENTS_ARRAY [15:0];        // Handy array to de-serialise the incoming signal
  wire [(p_edma_tx_pbuf_queue_segment_size)-1:0] TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY [15:0]; // Handy array to de-serialise the incoming signal
  wire [(p_edma_tx_pbuf_queue_segment_size)-1:0] TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY [15:0]; // Handy array to de-serialise the incoming signal
  reg                                      [7:0] num_pkts_in_buf_q [15:0];
  integer                                        i0;
  integer                                        i1;
  wire                                           part_pkt_xfer_req;
  wire                                           full_pkt_read_edge;
  wire                                           part_pkt_read_edge;

  assign tx_wea = 1'b1;

  // Signal used to denote when the SRAM i/f is 128bits
  wire   edma_tx_pbuf_data_w_is_128;
  assign edma_tx_pbuf_data_w_is_128 = p_edma_tx_pbuf_data == 32'd128;

  // The following adders are permitted to rollover
  assign tx_addra_p1        = tx_addra + {{p_edma_tx_pbuf_addr-1{1'b0}},1'b1};
  assign tx_addra_p2_or_p1  = edma_tx_pbuf_data_w_is_128 | dma_bus_width[0] ? tx_addra + {{p_edma_tx_pbuf_addr-2{1'b0}},2'b01}
                                                                            : tx_addra + {{p_edma_tx_pbuf_addr-2{1'b0}},2'b10};
  assign tx_addra_p3_or_p2  = edma_tx_pbuf_data_w_is_128 | dma_bus_width[0] ? tx_addra + {{p_edma_tx_pbuf_addr-2{1'b0}},2'b10}
                                                                            : tx_addra + {{p_edma_tx_pbuf_addr-2{1'b0}},2'b11};

  assign tx_addra_p1_c        = bind2queueRange(tx_addra_p1[p_edma_tx_pbuf_addr-1:0],      TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[cur_descr_rd_queue],TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[cur_descr_rd_queue],TX_PBUF_NUM_SEGMENTS_ARRAY[cur_descr_rd_queue]);
  assign tx_addra_p2_or_p1_c  = bind2queueRange(tx_addra_p2_or_p1[p_edma_tx_pbuf_addr-1:0],TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[cur_descr_rd_queue],TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[cur_descr_rd_queue],TX_PBUF_NUM_SEGMENTS_ARRAY[cur_descr_rd_queue]);
  assign tx_addra_p3_or_p2_c  = bind2queueRange(tx_addra_p3_or_p2[p_edma_tx_pbuf_addr-1:0],TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[cur_descr_rd_queue],TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[cur_descr_rd_queue],TX_PBUF_NUM_SEGMENTS_ARRAY[cur_descr_rd_queue]);

  // Decode some useful signals off the cur_descr ..
  assign cur_descr_used_field = cur_descr_rd[63];
  assign cur_descr_last_field = cur_descr_rd[47];
  assign cur_descr_len_field  = cur_descr_rd[45:32];  // This is only used for the zero length check below.
  assign cur_descr_zero_len   = (cur_descr_len_field == 14'd0) && !cur_descr_used_field;

  // Assign the possible error bits that will be routed through to RD side of SRAM, and then back over here for eventual interrupts
  assign err_status[2] = (cur_descr_zero_len && !this_is_1st_descr) || // zero_len error (current descriptor)
                         (cur_descr_used_field && !this_is_1st_descr); // used bit read mid frame
  assign err_status[1] = 1'b0;                                         // not used in AXI
  assign err_status[0] = (cur_descr_used_field && this_is_1st_descr);  // used bit read on 1st buffer
  assign err_status[3] = |err_status[2:0];                             // zero_len error or used bit read

  // Alignment Buffer
  // The data entering this block is buffer based, not pkt based
  // a packet could be made up of multiple buffers. The AXI
  // module ensures that all buffers start at byte 0, but they could
  // end anywhere. we need to pack all the buffers together ..
  reg [4:0] tx_length_decrement;
  always @(dma_bus_width)
    if (dma_bus_width[1])
      tx_length_decrement =  5'b10000;  // 128 bit
    else if (dma_bus_width[0])
      tx_length_decrement =  5'b01000;  // 64 bit
    else
      tx_length_decrement =  5'b00100;  // 32 bit

  // Identify how many bytes are valid on the last stripe of the packet ..
  always @(*)
  begin
    if (dma_bus_width[1])
      buf_stripe_mod = {cur_descr_rd[35:32] == 4'h0, cur_descr_rd[35:32]};
    else if (dma_bus_width[0])
      buf_stripe_mod = {1'b0,cur_descr_rd[34:32] == 3'h0,cur_descr_rd[34:32]};
    else
      buf_stripe_mod = {2'b00,cur_descr_rd[33:32] == 2'h0,cur_descr_rd[33:32]};
  end
  
  wire sram_wr_state_is_frm_data;
  wire sram_wr_state_is_idle;
  
  assign sram_wr_state_is_frm_data = (sram_wr_state == p_wr_state_frm_data);
  assign sram_wr_state_is_idle     = (sram_wr_state == p_wr_state_idle);
  
  edma_pbuf_tx_align #(.p_edma_asf_dap_prot(p_edma_asf_dap_prot)) i_edma_pbuf_tx_align (
   // system signals
   .hclk                 (hclk),
   .n_hreset             (n_hreset),
   .dma_bus_width        (dma_bus_width),
   .tx_dma_state_data    (sram_wr_state_is_frm_data),
   .tx_data_strobe       (buff_stripe_vld && buff_stripe_rdy),
   .frm_val_data_phase   (1'b0),
   .hrdata               (buff_stripe),
   .hrdata_par           (buff_stripe_par),
   .buffer_done_decode   (buff_stripe_last),
   .last_buf_done_decode (stripe_is_last_of_pkt),
   .last_access_bytes    (buf_stripe_mod),
   .tx_length_decrement  (tx_length_decrement),
   .tx_buffer_offset     (4'h0),
   .dma_w_fifo_count     (4'd0),
   .dma_w_flush          (sram_wr_state_is_idle || ~enable_tx_hclk || complete_flush_hclk),
   .force_fifo_eop_err   (1'b0),

   .dma_w_data           (al_w_data),
   .dma_w_data_par       (al_w_data_par),
   .dma_w_wr             (al_w_wr),
   .dma_w_eop            (al_w_eop),
   .dma_w_mod            (al_w_mod)
   );

  // Upsizing ..
  // Determine if we need to upsize the data when writing to the SRAM
  // basically this only happens when the SRAM datawidth > dma_bus_width
  wire [4:0] up_w_mod_upsize_x2;
  wire [4:0] up_w_mod_upsize_x4;
  wire [3:0] up_w_mod_upsize_x2_op1;
  wire [3:0] up_w_mod_upsize_x2_op2;
  wire [3:0] up_w_mod_upsize_x4_op1;
  wire [3:0] up_w_mod_upsize_x4_op2;

  assign upsize_x2              = dma_bus_width == 2'b01 && edma_tx_pbuf_data_w_is_128;
  assign upsize_x4              = dma_bus_width == 2'b00 && edma_tx_pbuf_data_w_is_128;
  
  assign up_w_mod_upsize_x2_op1 = {(~(|al_w_mod[2:0])),al_w_mod[2:0]};
  assign up_w_mod_upsize_x2_op2 = {upsize_str_cnt[0],3'b000};
  assign up_w_mod_upsize_x4_op1 = {1'b0,(~(|al_w_mod[1:0])),al_w_mod[1:0]};
  assign up_w_mod_upsize_x4_op2 = {upsize_str_cnt,2'b00};
  
  assign up_w_mod_upsize_x2     = up_w_mod_upsize_x2_op1 + up_w_mod_upsize_x2_op2;
  assign up_w_mod_upsize_x4     = up_w_mod_upsize_x4_op1 + up_w_mod_upsize_x4_op2;
  
  always @(*)
  begin
    up_w_eop = al_w_eop;
    // upsize_str_cnt is a counter that will rollover. The rollover points are 2'b11 for 32bit-128bit upsizing
    // and 2'b01 for 64bit to 128bit upsizing.  These conditions are explicitly called out.
    // up_w_mod is a 5 bit adder, with two 4 bit operands. This means it can never rollover ..
    if (upsize_x2)
      up_w_mod            = up_w_mod_upsize_x2;
    else if (upsize_x4)
      up_w_mod            = up_w_mod_upsize_x4; // 64bit in, 128bit out
    else
      up_w_mod            = {1'b0,al_w_mod};

    if (upsize_x2 && upsize_str_cnt[0] && al_w_wr)            // 64bit in, 128bit out
    begin
      upsize_str_cnt_nxt  = 2'b00;
      up_w_data           = {al_w_data[63:0],upsize_data_str[63:0]};
      up_w_data_par       = {al_w_data_par[7:0],upsize_data_str_par[7:0]};
      up_w_wr             = 1'b1;
    end
    else if (upsize_x4 && upsize_str_cnt == 2'b11 && al_w_wr) // 32bit in, 128bit out
    begin
      upsize_str_cnt_nxt  = 2'b00;
      up_w_data           = {al_w_data[31:0],upsize_data_str[95:0]};
      up_w_data_par       = {al_w_data_par[3:0],upsize_data_str_par[11:0]};
      up_w_wr             = 1'b1;
    end
    else // for other cases, just pass through
    begin
      up_w_wr               = (!(upsize_x2 || upsize_x4) && al_w_wr) || al_w_eop;
      if (upsize_str_cnt == 2'b10)
      begin
        up_w_data           = {32'd0,al_w_data[31:0],upsize_data_str[63:0]};
        up_w_data_par       = {4'h0,al_w_data_par[3:0],upsize_data_str_par[7:0]};
      end
      else if (upsize_str_cnt == 2'b01)
      begin
        up_w_data           = {64'd0,al_w_data[31:0],upsize_data_str[31:0]};
        up_w_data_par       = {8'h00,al_w_data_par[3:0],upsize_data_str_par[3:0]};
      end
      else
      begin
        up_w_data           = al_w_data[127:0];
        up_w_data_par       = al_w_data_par;
      end

      if (al_w_eop)
        upsize_str_cnt_nxt  = 2'b00;
      else
        upsize_str_cnt_nxt  = (upsize_x2 || upsize_x4) && al_w_wr ? upsize_str_cnt + 2'b01 : upsize_str_cnt;
    end
  end

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      upsize_str_cnt    <= 2'd0;
      upsize_data_str   <= 96'd0;
    end
    else if (~enable_tx_hclk | complete_flush_hclk)
    begin
      upsize_str_cnt    <= 2'd0;
      upsize_data_str   <= 96'd0;
    end
    else
    begin
      upsize_str_cnt    <= upsize_str_cnt_nxt;
      if (al_w_wr)
        case (upsize_str_cnt_nxt)
          2'b01   : upsize_data_str   <= al_w_data[95:0];
          2'b10   : upsize_data_str   <= {al_w_data[63:0],upsize_data_str[31:0]};
          default : upsize_data_str   <= {al_w_data[31:0],upsize_data_str[63:0]};
        endcase
    end
  end

  // sts_upd_cnt_p1 is a 3 bit adder with two 2bit operands. It can never overflow.
  wire [2:0] sts_upd_cnt_p1;
  assign     sts_upd_cnt_p1 = sts_upd_cnt + 2'b01;
  always @(*)
  begin
    sram_wr_state_nxt         = sram_wr_state;

    // defaults
    tx_dia                    = up_w_data[127:0];
    tx_dia_par                = up_w_data_par;
    tx_addra                  = frm_data_add_c;
    tx_ena                    = 1'b0;
    load_frm_ctrl_add         = 1'b0;
    buff_stripe_rdy           = 1'b0;
    cur_descr_rd_rdy          = 1'b0;
    this_is_1st_descr_nxt     = this_is_1st_descr;

    case (sram_wr_state)
      p_wr_state_idle :
      begin
        sts_upd_cnt_nxt       = 2'b00;
        tx_addra              = frm_data_add_c;
        tx_dia                = {status_word_wr_3,status_word_wr_2,status_word_wr_1,err_status,28'd0};
        tx_dia_par            = {status_word_wr_3_par,status_word_wr_2_par,status_word_wr_1_par,^err_status,3'h0};
        // Ignore valid zero length (ones with last bit set) and for a detected zero length error,
        // wait until we see a descriptor with last bit before reporting error ..
        if (cur_descr_rd_valid && cur_descr_zero_len && (!cur_descr_last_field || this_is_1st_descr))
        begin
          cur_descr_rd_rdy        = 1'b1;
          this_is_1st_descr_nxt   = cur_descr_last_field;
        end
        // We cant have more than 256 packets in the buffer at any one time due to restrictions on the read side ...
        // so back pressure when that event occurs
        else if (cur_descr_rd_valid && (num_pkts_in_buf_q[cur_descr_rd_queue] != 8'hff))
        begin
          load_frm_ctrl_add   = 1'b1;
          if (err_status[3])  // Error, no data associated with this frame, so just need to update the rest of the status words ...
          begin
            tx_ena                = 1'b1;                     // update the key control word as long as its not a valid zero length
            sts_upd_cnt_nxt       = (dma_bus_width == 2'b00 && bd_extended_mode_en) ? sts_upd_cnt_p1[1:0] : 2'b10;
            if (edma_tx_pbuf_data_w_is_128)
              sram_wr_state_nxt   = p_wr_state_tcp_csum;      // Just finish up
            else
              sram_wr_state_nxt   = p_wr_state_frm_ctrl_upd;  // Update the ctrl words
          end
          else
          begin
            tx_ena                = 1'b1;                     // update the key control word as long as its not a valid zero length
            sram_wr_state_nxt     = p_wr_state_frm_data;
          end
        end
      end

      // Now go write the packet data
      // Note there is a minimum of 2 cycle delay on the data due to the alignment module (2/3 cycles on last data)
      p_wr_state_frm_data :
      begin
        sts_upd_cnt_nxt       = 2'b00;
        buff_stripe_rdy       = 1'b1;
        tx_addra              = frm_data_add_c;
        tx_ena                = up_w_wr;
        tx_dia                = up_w_data[127:0];
        tx_dia_par            = up_w_data_par;

        if (buff_stripe_vld && (stripe_is_last_of_pkt || buff_stripe_last))
          sram_wr_state_nxt   = p_wr_state_resid_data; // write the last word of data from the alignment buffer
      end

      // Wait for the next descriptor in the frame. Note due to the delay in the alignment block above (2 cycles)
      // there will be residual data coming through from the last buffer
      p_wr_state_wait_descr :
      begin
        sts_upd_cnt_nxt       = 2'b00;
        tx_addra              = frm_data_add_c;
        tx_ena                = up_w_wr;
        tx_dia                = up_w_data[127:0];
        tx_dia_par            = up_w_data_par;
        if (cur_descr_rd_valid && cur_descr_zero_len && !cur_descr_last_field && !cur_descr_used_field)
          cur_descr_rd_rdy    = 1'b1;
        else if (cur_descr_rd_valid)
        begin
          if (err_status[3]) // Error, no data associated with this frame, so just need to update the rest of the status words ...
            sram_wr_state_nxt = p_wr_state_resid_data;  // Wait for final data from alignment buffer (3 cycles max)
          else
            sram_wr_state_nxt = p_wr_state_frm_data;
        end
      end

     // Wait for the remaining data from the alignment buffer. This can be at max 3 cycles (for EOP)
     // Use sts_upd_cnt to count the 3 cycles
      p_wr_state_resid_data :
      begin
        tx_addra              = frm_data_add_c;
        tx_dia                = up_w_data[127:0];
        tx_dia_par            = up_w_data_par;
        tx_ena                = up_w_wr;
        if (sts_upd_cnt[1] || al_w_eop)
        begin
          sts_upd_cnt_nxt       = 2'b00;
          if (al_w_eop || err_status[3])
            sram_wr_state_nxt   =  p_wr_state_frm_ctrl_upd;
          else
          begin
            sram_wr_state_nxt     =  p_wr_state_wait_descr;
            this_is_1st_descr_nxt = 1'b0;
            cur_descr_rd_rdy      = 1'b1;
          end
        end
        else
          sts_upd_cnt_nxt     = sts_upd_cnt_p1[1:0];
      end

      // Now go update the control word, or the cutthru word if rd side is empty ..
      // This writes the all 4 status words as described below ..
      p_wr_state_frm_ctrl_upd :
      begin
        // If the read side of the SRAM has started reading the frame already
        // i.e. in cut-thru mode, then the status should be stored in the cut-thru
        // status. otherwise update the ctrl word
        case (sts_upd_cnt)
          2'b00 :
          begin
            tx_ena              = 1'b1;
            tx_addra            = frm_ctrl_add;
            tx_dia              = {status_word_wr_3,status_word_wr_2,status_word_wr_1,status_word_wr_0};
            tx_dia_par          = {status_word_wr_3_par,status_word_wr_2_par,status_word_wr_1_par,status_word_wr_0_par};
            sts_upd_cnt_nxt     = (dma_bus_width == 2'b00 && bd_extended_mode_en) ? sts_upd_cnt_p1[1:0] : 2'b10;
            if (edma_tx_pbuf_data_w_is_128)
              sram_wr_state_nxt = tx_pbuf_tcp_en ? p_wr_state_wait_csum : p_wr_state_tcp_csum;
          end
          2'b01 : // Store Launch time - only valid in 32bit modes ..
          begin
            tx_ena              = 1'b1;
            tx_addra            = frm_ctrl_add;
            tx_dia              = {96'd0,status_word_wr_1};
            tx_dia_par          = {12'h000,status_word_wr_1_par};
            sts_upd_cnt_nxt     = sts_upd_cnt_p1[1:0];
          end
          2'b10 : // Store status word 2 (&3 in 64bit datapaths)
          begin
            tx_ena              = 1'b1;
            tx_addra            = frm_data_add_c;
            tx_dia              = {64'd0,status_word_wr_3,status_word_wr_2};
            tx_dia_par          = {8'h00,status_word_wr_3_par,status_word_wr_2_par};
            sts_upd_cnt_nxt     = sts_upd_cnt_p1[1:0];
            if (dma_bus_width == 2'b01)
              sram_wr_state_nxt = tx_pbuf_tcp_en ? p_wr_state_ip_csum : p_wr_state_tcp_csum;
          end
          default : // Store status word 3 - only valid in 32bit modes ..
          begin
            tx_ena              = 1'b1;
            tx_addra            = frm_data_add_c;
            tx_dia              = {96'd0,status_word_wr_3};
            tx_dia_par          = {12'h000,status_word_wr_3_par};
            sts_upd_cnt_nxt     = 2'b00;
            sram_wr_state_nxt   = tx_pbuf_tcp_en ? p_wr_state_ip_csum : p_wr_state_tcp_csum;
          end
        endcase
      end

      // Wait for the TCP checksum engine to catch up. It might still be processing the checksums for 1 cycle..
      // this is only an issue in 128bit datapath modes since we were only in the p_wr_state_frm_ctrl_upd for 1 cycle
      p_wr_state_wait_csum :
      begin
        sts_upd_cnt_nxt       = 2'b00;
        sram_wr_state_nxt     = p_wr_state_ip_csum;
      end

      // Update the IP checksum
      p_wr_state_ip_csum :
      begin
        sts_upd_cnt_nxt       = 2'b00;
        tx_ena                = ip_hdr_cs_we;
        tx_addra              = ip_hdr_cs_addr;
        tx_dia                = ip_hdr_cs_reord;
        tx_dia_par            = ip_hdr_cs_par_reord;
        sram_wr_state_nxt     = p_wr_state_tcp_csum;
      end

      // Update the TCP checksum and/or finish up:
      default : // p_wr_state_tcp_csum :
      begin
        sts_upd_cnt_nxt       = 2'b00;
        tx_ena                = tcp_hdr_cs_we;
        tx_addra              = tcp_hdr_cs_addr;
        tx_dia                = tcp_hdr_cs_reord;
        tx_dia_par            = tcp_hdr_cs_par_reord;
        sram_wr_state_nxt     = p_wr_state_idle;
        cur_descr_rd_rdy      = 1'b1;
        this_is_1st_descr_nxt = 1'b1;
      end

    endcase
  end

  // State Variables
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      sram_wr_state     <= p_wr_state_idle;
      first_descr       <= 97'd0;
      first_descr_wb_add<= {p_awid_par{1'b0}};
      this_is_1st_descr <= 1'b1;
      sts_upd_cnt       <= 2'b00;
    end
    else if (~enable_tx_hclk | complete_flush_hclk)
    begin
      sram_wr_state     <= p_wr_state_idle;
      first_descr       <= 97'd0;
      first_descr_wb_add<= {p_awid_par{1'b0}};
      this_is_1st_descr <= 1'b1;
      sts_upd_cnt       <= 2'b00;
    end
    else
    begin
      sram_wr_state     <= sram_wr_state_nxt;
      sts_upd_cnt       <= sts_upd_cnt_nxt;
      this_is_1st_descr <= this_is_1st_descr_nxt;
      if (cur_descr_rd_valid && this_is_1st_descr)
      begin
        first_descr         <= cur_descr_rd[96:0];
        first_descr_wb_add  <= cur_descr_rd_add_p4[p_awid_par-1:0];
      end
    end
  end

  // The writeback address is the next location after the cur_descr_rd_add, i.e.
  // add 4 to the address.
  // Instantiate following module to deal with potential parity as well.
  edma_arith_par #(
    .p_dwidth (32),
    .p_pwidth (4),
    .p_has_par(p_edma_asf_dap_prot)
  ) i_arith_cur_descr_rd_add_p4 (
    .in_val (cur_descr_rd_add),
    .in_par (cur_descr_rd_add_par),
    .op_val (32'd4),
    .op_add (1'b1),
    .out_val(cur_descr_rd_add_p4[31:0]),
    .out_par(cur_descr_rd_add_p4[35:32])
  );

  // Address Variables for the SRAM
  // The address jumps around a bit ..
  //   1. The addr of the status words at the start of the frame are loaded is frm_ctrl_add.
  //   2. Normal address used by data is in tx_addra_p1 - post increments
  //   3. TCP/IP checksum locations
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      for (i0=0; i0<p_edma_queues[31:0]; i0=i0+1)
        frm_data_add[i0]  <= {p_edma_tx_pbuf_addr{1'b0}};
      frm_ctrl_add        <= {p_edma_tx_pbuf_addr{1'b0}};
    end
    else if (~enable_tx_hclk | complete_flush_hclk)
    begin
      for (i0=0; i0<p_edma_queues[31:0]; i0=i0+1) begin
        frm_data_add[i0][p_edma_tx_pbuf_addr-1:p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size] <= TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[i0];
        frm_data_add[i0][p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size-1:0] <= {p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size{1'b0}};
      end
      frm_ctrl_add        <= {p_edma_tx_pbuf_addr{1'b0}};
    end
    else
    begin
      // Altrhough its called frm_data_add, we also use this for the status words at the end of the frame ..
      for (i0=0; i0<p_edma_queues; i0=i0+1)
        if (i0[3:0] == cur_descr_rd_queue)
        begin
          if (load_frm_ctrl_add)                                                               // jump over 2 status words(32bit) or 1 at start of frame
            frm_data_add[i0]  <= tx_addra_p2_or_p1_c[p_edma_tx_pbuf_addr-1:0];
          else if (tx_ena && sram_wr_state == p_wr_state_frm_ctrl_upd && sts_upd_cnt[1])       // use to increment through last 2 status word writes ..
            frm_data_add[i0]  <= tx_addra_p1_c[p_edma_tx_pbuf_addr-1:0];
          else if (up_w_wr)
          begin
            if (tx_addra_p1_c[p_edma_tx_pbuf_addr-1:0] == frm_ctrl_add)
              frm_data_add[i0]  <= tx_addra_p3_or_p2_c[p_edma_tx_pbuf_addr-1:0];               // post increment, but jump over status words at start ..
            else
              frm_data_add[i0]  <= tx_addra_p1_c[p_edma_tx_pbuf_addr-1:0];                     // post increment ..
          end
        end

      if ((load_frm_ctrl_add && err_status[3]) | (sram_wr_state == p_wr_state_frm_ctrl_upd)) // preparing to write the launch time
        frm_ctrl_add  <= tx_addra_p1_c[p_edma_tx_pbuf_addr-1:0];
      else if (load_frm_ctrl_add)             // start of frame
        frm_ctrl_add  <= tx_addra;
    end
  end
  assign frm_data_add_c = bind2queueRange(frm_data_add_pad[cur_descr_rd_queue],TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[cur_descr_rd_queue],TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[cur_descr_rd_queue],TX_PBUF_NUM_SEGMENTS_ARRAY[cur_descr_rd_queue]);


  // Packet Length Counters
  // This counter has 12 valid bits. It should never wrap around. If it does, then the incoming packet length is too high ..
  assign frame_len_cnt_nxt = frame_len_cnt + 12'h001;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      frame_len_cnt     <= 12'h000;
    else if (~enable_tx_hclk | complete_flush_hclk)
      frame_len_cnt     <= 12'h000;
    else if (up_w_wr)
      frame_len_cnt     <= frame_len_cnt_nxt[11:0];
    else if (sram_wr_state == p_wr_state_idle)
      frame_len_cnt     <= 12'h000;
  end

  assign frame_written_to_sram = (sram_wr_state == p_wr_state_tcp_csum) ;
  assign part_pkt_xfer_req = ({5'd0,frame_len_cnt} ==
                              {{(17-p_edma_tx_pbuf_addr){1'b0}},tx_cutthru_threshold} &&
                              tx_cutthru && full_duplex && up_w_wr);

  assign cutthru_status_word_push = sram_wr_state == p_wr_state_frm_ctrl_upd && sts_upd_cnt == 2'b00 && tx_cutthru;
  generate if (p_edma_pbuf_cutthru == 1) begin : gen_priq_set_cuthru_status
    assign cutthru_status_word = {frm_ctrl_add,status_word_wr_3,status_word_wr_2,status_word_wr_1,status_word_wr_0};
    assign cutthru_status_word_par  = {frm_ctrl_add_par,status_word_wr_3_par,status_word_wr_2_par,status_word_wr_1_par,status_word_wr_0_par};
  end else begin : gen_npriq_set_cuthru_status
    assign cutthru_status_word = {p_edma_tx_pbuf_addr+128{1'b0}};
    assign cutthru_status_word_par  = {p_ct_par_w{1'b0}};
  end
  endgenerate

  // Packet Mod
  reg [3:0] pkt_mod;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      pkt_mod     <= 4'h0;
    else if (~enable_tx_hclk | complete_flush_hclk)
      pkt_mod     <= 4'h0;
    else if (up_w_wr && up_w_eop)
      pkt_mod     <= up_w_mod[3:0];
  end


// Status Words ...
// status_word0 (and 1 in extended buffer descriptors) always precedes the packet data.

// In 32bit mode, the structure of the full frame is
// status_word0 -> status_word1 (extended bd mode only) -> packet data -> status_word2 -> status_word3

// In 64bit mode, the structure of the full frame is
// status_word01 -> packet data -> status_word23

// In 128bit mode, the structure of the full frame is
// status_word0123 -> packet data -> status_word0123 (repeated)

  reg  [2:0] num_sram_ctrl_wr;
  always @(*)
    if (edma_tx_pbuf_data_w_is_128)
      num_sram_ctrl_wr  = 3'd1;
    else if (dma_bus_width[0])
      num_sram_ctrl_wr  = 3'd2;
    else
      num_sram_ctrl_wr  = 3'd4;

// The read side of the SRAM needs a way to recover the end address asap
// It cant wait until it has read the frame. In order to calculate the end address
// usually you would simply add the frame length (bits 11:0 of statusword0) to the start address
// However in cut-thru modes, that wont work because it is quite possible the write side of the SRAM
// had to skip over the status words as it wrote the frame and wrapped at the top of the SRAM multiple times
// in single frame.  Whenever we skip, keep track of the num sram locations we have skipped.
// we will allow a max of 256 skips,  brought down to an effective 128 in 32 bit modes due to the need to skip over 2 status words
// for a 7bit SRAM ( 512bytes in a 32bit SRAM), 128 skips would cater for a 64KB frame to be stored
// This counter must never overrun.
  wire [8:0] pkt_end_addr_mod_p1;
  reg  [7:0] pkt_end_addr_mod;
  assign pkt_end_addr_mod_p1 = edma_tx_pbuf_data_w_is_128 | dma_bus_width[0] ? pkt_end_addr_mod + 8'd1
                                                                             : pkt_end_addr_mod + 8'd2;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      pkt_end_addr_mod     <= 8'h00;
    else if (~enable_tx_hclk | complete_flush_hclk)
      pkt_end_addr_mod     <= 8'h00;
    else if (sram_wr_state == p_wr_state_idle)
      pkt_end_addr_mod <= 8'h00;
    else if (up_w_wr && tx_addra_p1_c[p_edma_tx_pbuf_addr-1:0] == frm_ctrl_add)
      pkt_end_addr_mod <= pkt_end_addr_mod_p1[7:0];
  end

// Status word 0. key critical information the RD side of the SRAM needs before it
// starts fetching anything else
// Bits 11:0        = pkt length in SRAM words ...
// Bits 15:12       = number of bytes valid in the last word ...
// Bits 23:16       = Add this to status_word_wr_0[11:0]+start_add to get the end address
// Bits 26:25       = reserved
// Bits 24          = launch time enable
// Bits 27          = pass through of bit 16 of the descriptor for this frame
// Bits 31:28       = The error status bits - if bit 31 is set, this frame contains no data
assign status_word_wr_0   = {
                              err_status,           // 31:28  (Error Status Bits)
                              first_descr[48],      // 27     (pass through of bit 16 of the descriptor for this frame - this is the CRC gen bit)
                              2'd0,                 // 26:25  (reserved)
                              first_descr[96],      // 24     (launch_time enable)
                              pkt_end_addr_mod,     // 23:16  (reserved)
                              pkt_mod,              // 15:12  (number of bytes valid in the last word)
                              frame_len_cnt         // 11:0   (number of words in the packet)
                            };

// Status word 1. Launch Time. Only required when extended buffer descriptors are enabled
assign status_word_wr_1   = bd_extended_mode_en ? first_descr[95:64] : 32'd0;
// Status word 2. Contains the BD memory address, needed when we do a BD write later, writeback is always to word 1 only ..
assign status_word_wr_2   = first_descr_wb_add[31:0];
// Status word 3. Mainly contains parts of the first BD that was read in the packet. This is so the BD can be written back as RMW later ..
assign status_word_wr_3   = { 2'b00,
                              cur_descr_rd_queue[3:0],
                              first_descr[57:56],
                              first_descr[51:49],
                              first_descr[46],
                              first_descr[62],
                              tcp_status[2:0],
                              first_descr[48:47],
                              first_descr[45:32]
                            };

  assign stripe_is_last_of_pkt  = buff_stripe_vld && buff_stripe_last && cur_descr_last_field;


  // Interface with read side of SRAM
  // Whenever a frame is written to the SRAM, pass this indication over
  // since tx_clk might be running much slower than the AXI clock, we must
  // have a local count while we wait for the slow side to finish
  // If the local count gets to maximum (8 frames), we back pressure ...
  genvar g0;
  generate for (g0=0; g0<p_edma_queues[31:0]; g0=g0+1) begin : gen_pkt_xfers
    reg [3:0] num_pkts_xfer_local;      // Count num of packets that are ready
                                        // to be read by the RD side of PBUF
                                        // but which cannot be taken right now
    reg        num_parts_xfer_local;
    wire [4:0] num_pkts_xfer_local_p1;
    reg        waiting_for_pkt_capt;
    wire       pkt_captured_sync;
    wire       pkt_captured_edge;
    assign     num_pkts_xfer_local_p1 = num_pkts_xfer_local + 4'h1;

    cdnsdru_datasync_v1 i_cdnsdru_datasync_v1 (.clk(hclk),.reset_n(n_hreset),.din(pkt_captured[g0]),.dout(pkt_captured_sync));
    edma_toggle_detect  i_edma_toggle_detect  (.clk(hclk),.reset_n(n_hreset),.din(pkt_captured_sync),.rise_edge(),.fall_edge(),.any_edge(pkt_captured_edge));

    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
      begin
        end_of_packet_tog[g0]             <= 1'b0;
        part_of_packet_tog[g0]            <= 1'b0;
        num_pkts_xfer[((g0+1)*4)-1:g0*4]  <= 4'h0;
        num_pkts_xfer_local               <= 4'h0;
        num_parts_xfer_local              <= 1'h0;
        waiting_for_pkt_capt              <= 1'b0;
      end
      else if (~enable_tx_hclk | complete_flush_hclk)
      begin
        num_pkts_xfer_local               <= 4'h0;
        num_parts_xfer_local              <= 1'h0;
        waiting_for_pkt_capt              <= 1'b0;
      end
      else
      begin
        // Enough of a packet has been received by AHB and written into DPRAM
        // Inform read side of PBUF that it can now start reading the packet ...
        if (g0 == {{28{1'b0}},cur_descr_rd_queue} && frame_written_to_sram)
        begin
          waiting_for_pkt_capt              <= 1'b1;
          if (pkt_captured_edge || !waiting_for_pkt_capt)
          begin
            num_pkts_xfer[((g0+1)*4)-1:g0*4]<= num_pkts_xfer_local_p1[3:0];
            num_pkts_xfer_local             <= 4'h0;
            num_parts_xfer_local            <= 1'h0;
            end_of_packet_tog[g0]           <= !end_of_packet_tog[g0];
          end
          else //if (waiting_for_pkt_capt)
            num_pkts_xfer_local             <= num_pkts_xfer_local_p1[3:0];
        end
        else if (g0 == {{28{1'b0}},cur_descr_rd_queue} && part_pkt_xfer_req)
        begin
          waiting_for_pkt_capt              <= 1'b1;
          if (pkt_captured_edge || !waiting_for_pkt_capt)
          begin
            num_pkts_xfer_local             <= 4'h0;
            num_parts_xfer_local            <= 1'h0;
            part_of_packet_tog[g0]          <= !part_of_packet_tog[g0];
          end
          else //if (waiting_for_pkt_capt)
            num_parts_xfer_local            <= 1'h1;
        end
        else if (pkt_captured_edge)
        begin
          num_pkts_xfer_local               <= 4'h0;
          num_parts_xfer_local              <= 1'h0;
          num_pkts_xfer[((g0+1)*4)-1:g0*4]  <= num_pkts_xfer_local;
          if (|num_pkts_xfer_local)
            end_of_packet_tog[g0]           <= !end_of_packet_tog[g0];
          else if (num_parts_xfer_local)
            part_of_packet_tog[g0]          <= !part_of_packet_tog[g0];
          else
            waiting_for_pkt_capt            <= 1'b0;
        end
      end
    end
  end
  endgenerate


  // Descriptor Writebacks ..
  // The Read side of the SRAM will identify when a descriptor writeback can occur ..
  // DMA writebacks are triggered when the MAC side of the packet buffer
  // is done with a packet.  it will toggle 'full_pkt_read' to indicate this
  // It will also send the status information associated with the writeback
  // directly via 'xfer_status_bus'
  // We need to capture this information as quickly as possible to allow the
  // MAC side to 'move on' and avoid being locked up.  However, we need to
  // latch this information until we ourselves have completed the writeback.
  // The time for this to happen is governed by the time it takes to move
  // into the DMA writeback state and the time taken to perform the AXI write
  // (which in itself is governed by the number of wait states foir the descriptor
  // write access).
  // there is a descriptor write buffer which will locally buffer the writes
  // The user can choose the depth of these buffers. If they keep it at minimum
  // there will be just 1 buffer. We will keep another buffer locally here
  // so that at minimum 2 banks of status info will be allowed before the MAC side
  // is completely back pressured. Note that at worst descritpor writeback requests
  // should occur every 70 odd tx_mac_clk cycles.
  edma_sync_toggle_detect i_edma_sync_full_pkt_read (.clk(hclk),.reset_n(n_hreset),.din(full_pkt_read),.rise_edge(),.fall_edge(),.any_edge(full_pkt_read_edge));
  edma_sync_toggle_detect i_edma_sync_part_pkt_read (.clk(hclk),.reset_n(n_hreset),.din(part_pkt_read),.rise_edge(),.fall_edge(),.any_edge(part_pkt_read_edge));

  wire [81:0]  xfer_status_bus_gated;
  wire [42:0]  xfer_status_bus_ts_gated;
  assign xfer_status_bus_gated      = xfer_status_bus    & {82{full_pkt_read_edge}};
  assign xfer_status_bus_ts_gated   = xfer_status_bus_ts & {43{full_pkt_read_edge}}; // Top 6 bits are parity here ..

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      xfer_status_captured    <= 1'b0;
      tx_descr_wr_vld         <= 1'b0;
      tx_descr_wr_data        <= 64'd0;
      tx_descr_wr_sts         <= 10'd0;
    end
    else
    begin
      if (~enable_tx_hclk | complete_flush_hclk)
      begin
        tx_descr_wr_vld         <= 1'b0;
        tx_descr_wr_data        <= 64'd0;
        tx_descr_wr_sts         <= 10'd0;
      end
      else
      begin
        tx_descr_wr_vld          <= full_pkt_read_edge || (tx_descr_wr_vld && !tx_descr_wr_rdy);
        if (full_pkt_read_edge)
        begin
          tx_descr_wr_data       <= {descriptor_wb_word1,status_word_rd_2}; // ie bd word1, bd word0[31:0]
          tx_descr_wr_sts        <= {dma_late_col_int, dma_toomanyretry_int,dma_hresp_notok_int,dma_buff_ex_mid_int,dma_buff_ex_int,dma_queue_int,dma_tx_ok_int};
        end

        if (tx_descr_wr_vld && tx_descr_wr_rdy)
          xfer_status_captured   <= ~xfer_status_captured;
      end
    end
  end

  // Only store the timestamp if supported
  generate if (p_edma_tsu == 1) begin : gen_ts_store
    reg [41:0]  tx_descr_wr_ts_r;
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        tx_descr_wr_ts_r  <= 42'd0;
      else if (~enable_tx_hclk | complete_flush_hclk)
        tx_descr_wr_ts_r  <= 42'd0;
      else if (full_pkt_read_edge)
        tx_descr_wr_ts_r  <= xfer_status_bus_ts_gated[41:0];
    end
    assign tx_descr_wr_ts = tx_descr_wr_ts_r;
  end else begin : gen_no_ts_store
    assign tx_descr_wr_ts = {42{1'b0}};
  end
  endgenerate

  assign status_word_rd_0  = xfer_status_bus_gated[17:0];
  assign status_word_rd_2  = xfer_status_bus_gated[49:18];
  assign status_word_rd_3  = xfer_status_bus_gated[81:50];
  assign ts_to_be_written  = xfer_status_bus_ts_gated[42] & bd_extended_mode_en;
  assign descriptor_wb_word1  =
                  {1'b1,                          // Used bit
                   status_word_rd_3[19],          // Wrap bit
                   (status_word_rd_0[0] &
                    ~(|status_word_rd_0[16:14])), // Too many retries
                   status_word_rd_0[15],          // Frame Corruption
                   status_word_rd_0[16],          // Exhausted buffers mid frame
                   (status_word_rd_0[1] &
                    ~(|status_word_rd_0[16:14])), // Late Collision
                   status_word_rd_3[25:24],       // TCP stream ID
                   ts_to_be_written,
                   status_word_rd_3[18:16],       // TCP status
                   status_word_rd_3[23],          // sequence number sel
                   status_word_rd_3[22],          // TSO enable
                   status_word_rd_3[21],          // UFO enable
                   status_word_rd_3[15],          // no CRC
                   status_word_rd_3[14],          // EOF
                   status_word_rd_3[20],          // Last header flag
                   status_word_rd_3[13:0]};

  // Some status that will be sent with descriptor writes ..
  assign dma_late_col_int     = (status_word_rd_0[1] & ~(|status_word_rd_0[16:14]));
  assign dma_toomanyretry_int = (status_word_rd_0[0] & ~(|status_word_rd_0[16:14]));
  assign dma_hresp_notok_int  = (status_word_rd_0[15]);
  assign dma_buff_ex_mid_int  = (|status_word_rd_0[16:15]);
  assign dma_buff_ex_int      = (status_word_rd_0[16] | status_word_rd_0[14]);
  assign dma_tx_ok_int        = (~(|status_word_rd_0[16:14]) & ~(|status_word_rd_0[1:0]));
  generate if (p_edma_queues > 32'd1) begin : gen_priq_int_gen_logic
    assign dma_queue_int      = status_word_rd_3[29:26];
  end else begin : gen_npriq_int_gen_logic
    assign dma_queue_int      = 4'h0;
  end
  endgenerate


  // Interrupt Generation
  // Status should be reflected back to this module from the AXI TX block
  // and is in reflected_tx_sts
  //
  // Typically, we will generate an interrupt when the DMA writeback is
  // complete.  The DMA signals that are used to generate specific
  // interrupts are sampled by the APB space using a handshake protocol
  // To ensure this handshake is clean, tx_dma_stable_tog can only toggle
  // when the tx_status2apb signals are stable.  tx_stat_capt_pulse will be
  // driven to indicate when the register space has sampled the signals
  // safely. int_issued_wait_for_capt is high while we are waiting for tx_stat_capt_pulse
  //
  // Status transfers can be initiated based on the reflected status or due to underflows/hresp errors

  // Underflow Monitoring - This will be used to trigger an underflow event ...
  wire  underflow_tog_edge;
  edma_sync_toggle_detect i_edma_sync_toggle_detect_underflow_tog (.clk(hclk),.reset_n(n_hreset),.din(underflow_tog),.rise_edge(),.fall_edge(),.any_edge(underflow_tog_edge));

  assign gen_int        = reflected_tx_sts_vld || underflow_tog_edge;

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      str_int_vector            <= 7'h00;
      str_int_queue             <= 4'h0;
      str_int_queue_done        <= 1'b0;
      int_issued_wait_for_capt  <= 1'b0;
      tx_status2apb             <= 11'd0;
      tx_dma_stable_tog         <= 1'b0;
      tx_wr_seen_uflow          <= 1'b0;
    end
    // we dont soft reset this code as it is a key clock boundary so resetting tx_dma_stable_tog and/or tx_status2apb must absolutely not happen.
    // Also we want to report all existing events that are being locally stored when the reset occurs to APB, so resetting str_int* is also not done.
    else
    begin
      // If we are not waiting for the capture of a previous status xfer, then proceed with first request ..
      if (!int_issued_wait_for_capt && gen_int)
      begin
        int_issued_wait_for_capt  <= 1'b1;
        tx_status2apb[9:0]        <= reflected_tx_sts;
        tx_status2apb[10]         <= underflow_tog_edge;
        tx_dma_stable_tog         <= ~tx_dma_stable_tog;
      end
      else if (int_issued_wait_for_capt)  // If already waiting for previous request to be accepted
      begin
        // If the register block has captured the status, we can pass on what is locally buffered
        // or just go idle ..
        if (tx_stat_capt_pulse)
        begin
          str_int_vector            <= 7'h00;
          str_int_queue_done        <= 1'h0;
          str_int_queue             <= 4'h0;
          if (|str_int_vector || reflected_tx_sts_vld)
          begin
            int_issued_wait_for_capt  <= 1'b1;
            tx_status2apb[10:5]       <= str_int_vector[6:1] | {1'b0,reflected_tx_sts[9:5]};
            tx_status2apb[4:1]        <= |str_int_vector ? str_int_queue : reflected_tx_sts[4:1];
            tx_status2apb[0]          <= |str_int_vector ? str_int_vector[0] : reflected_tx_sts[0];
            tx_dma_stable_tog         <= ~tx_dma_stable_tog;
          end
          else
            int_issued_wait_for_capt  <= 1'b0;
        end
        else
        begin
          // Locally buffer status if we get a new int while we are waiting, and keep adding to it until we get 'tx_stat_capt_pulse'
          str_int_vector          <= ({underflow_tog_edge,reflected_tx_sts[9:5], reflected_tx_sts[0]} & {7{gen_int}}) | (str_int_vector & ~{7{tx_stat_capt_pulse}});
          // Assume all interrupts that occur while we are waiting are to the same queue ..
          str_int_queue_done      <= gen_int || str_int_queue_done;
          str_int_queue           <= str_int_queue_done ? str_int_queue : reflected_tx_sts[4:1];
        end
      end

      if (tx_status2apb[10] && tx_stat_capt_pulse)
        tx_wr_seen_uflow          <= ~tx_wr_seen_uflow;

    end
  end

  // SRAM Fill Level Management
  // Starts from all ones {(p_edma_queues*p_edma_tx_pbuf_addr){1'b1}}
  // decrements whenever there is a write to the SRAM
  // Space is recovered using the information passed back from the RD side of the SRAM
  // there are 3 possible ways to recover space
  //  1. Free up resources due to packet completion on RD side - i.e. the full packet has been pushed to the MAC
  wire  [15:0] fill_lvl_up_1_16;
  wire  [p_edma_tx_pbuf_addr-1:0] fill_lvl_up_1;
  assign fill_lvl_up_1_16 = {16{full_pkt_read_edge}} & {4'h0,status_word_rd_0[13:2]};
  assign fill_lvl_up_1    = fill_lvl_up_1_16[p_edma_tx_pbuf_addr-1:0];
  //  2. Free up resources due to local flush condition
  wire  [p_edma_tx_pbuf_addr-1:0] fill_lvl_up_2;
  assign fill_lvl_up_2 = {p_edma_tx_pbuf_addr{1'b0}};
  //  3. Free up resources due to part of packet completion - some of the data has been pushed to the MAC
  wire [15:0] partpkt_threshold;
  generate if (p_edma_tx_pbuf_data == 32'd128) begin : gen_partpkt_threhold_8
     assign partpkt_threshold = 16'd8;
  end
  else begin : gen_partpkt_threhold_16
     assign partpkt_threshold = 16'd16;
  end
  endgenerate
  wire  [p_edma_tx_pbuf_addr-1:0] fill_lvl_up_3_16;
  wire  [p_edma_tx_pbuf_addr-1:0] fill_lvl_up_3;
  assign fill_lvl_up_3_16 = {p_edma_tx_pbuf_addr{part_pkt_read_edge}} & partpkt_threshold[p_edma_tx_pbuf_addr-1:0];
  assign fill_lvl_up_3    = fill_lvl_up_3_16[p_edma_tx_pbuf_addr-1:0];

  // For normal good packets, there are 4 status words for 32 bit datapaths, 3 for 64bit/128
  // for 64 bit. This is documented in a comment further above ...
  reg   [p_edma_tx_pbuf_addr-1:0] fill_lvl_down_1;
  always @(*)
  begin
    if (up_w_wr)
      fill_lvl_down_1 = {{(p_edma_tx_pbuf_addr-1){1'b0}},1'b1};
    else if (sram_wr_state == p_wr_state_idle && tx_ena)
      fill_lvl_down_1 = {{(p_edma_tx_pbuf_addr-3){1'b0}},num_sram_ctrl_wr};
    else
      fill_lvl_down_1 = {p_edma_tx_pbuf_addr{1'b0}};
  end

  wire [(p_edma_tx_pbuf_addr)-1:0] TX_PBUF_MAX_FILL_LVL_ARRAY [p_edma_queues-1:0]; // Handy array to de-serialise the incoming signal
  genvar g1;
  generate for (g1=0; g1<p_edma_queues[31:0]; g1=g1+1) begin : gen_fill_lvl
    assign TX_PBUF_MAX_FILL_LVL_ARRAY[g1] = TX_PBUF_MAX_FILL_LVL[((g1+1)*p_edma_tx_pbuf_addr)-1:g1*p_edma_tx_pbuf_addr];
    assign q_empty_lvl[g1]                = TX_PBUF_MAX_FILL_LVL_ARRAY[g1];

    always@(posedge hclk or negedge n_hreset)
      if (~n_hreset)
        dpram_almost_empty[g1] <= 1'b1;
      else if (~enable_tx_hclk | complete_flush_hclk)
        dpram_almost_empty[g1] <= 1'b1;
      else
        // dpram_almost_empty is used by the MAC side to understand when an
        // underflow is near - it is only relevant for cut-thru modes.
        // If we have a 128b wide FIFO then reduce the comparison to 8 as each
        // location contains at least 2 MAC words.
        if (edma_tx_pbuf_data_w_is_128)
          dpram_almost_empty[g1] <= dpram_fill_lvl_array[g1][p_edma_tx_pbuf_addr-1:3] == q_empty_lvl[g1][p_edma_tx_pbuf_addr-1:3];
        else
          dpram_almost_empty[g1] <= dpram_fill_lvl_array[g1][p_edma_tx_pbuf_addr-1:4] == q_empty_lvl[g1][p_edma_tx_pbuf_addr-1:4];


    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        dpram_fill_lvl_array[g1]  <= {(p_edma_tx_pbuf_addr){1'b1}};
      else if (~enable_tx_hclk | complete_flush_hclk)
        dpram_fill_lvl_array[g1] <= TX_PBUF_MAX_FILL_LVL_ARRAY[g1];
      else
        dpram_fill_lvl_array[g1] <= dpram_fill_lvl_array[g1] + fill_lvl_inc[g1] - fill_lvl_dec[g1];
    end
    wire  [p_edma_tx_pbuf_addr+1:0] fill_lvl_inc_c; // Amount to increment
    assign fill_lvl_inc_c     = (fill_lvl_up_1   & ({(p_edma_tx_pbuf_addr){(status_word_rd_3[29:26] == g1[3:0])}}))
                              + (fill_lvl_up_2   & ({(p_edma_tx_pbuf_addr){(cur_descr_rd_queue == g1[3:0])}}))
                              + (fill_lvl_up_3   & ({(p_edma_tx_pbuf_addr){(part_pkt_queue  == g1[3:0])}}));
    assign fill_lvl_inc[g1]   = fill_lvl_inc_c[p_edma_tx_pbuf_addr-1:0];
    assign fill_lvl_dec[g1]   = (fill_lvl_down_1 & {(p_edma_tx_pbuf_addr){(cur_descr_rd_queue == g1[3:0])}});
    assign dpram_fill_lvl[((g1+1)*p_edma_tx_pbuf_addr[31:0])-1:g1*p_edma_tx_pbuf_addr[31:0]] = dpram_fill_lvl_array[g1] | ~TX_PBUF_MAX_FILL_LVL_ARRAY[g1];
    assign TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[g1] = TX_PBUF_SEGMENTS_LOWER_ADDR[((g1+1)*p_edma_tx_pbuf_queue_segment_size[31:0])-1:g1*p_edma_tx_pbuf_queue_segment_size[31:0]];
    assign TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[g1] = TX_PBUF_SEGMENTS_UPPER_ADDR[((g1+1)*p_edma_tx_pbuf_queue_segment_size[31:0])-1:g1*p_edma_tx_pbuf_queue_segment_size[31:0]];
    assign TX_PBUF_NUM_SEGMENTS_ARRAY[g1]        = TX_PBUF_NUM_SEGMENTS[((g1+1)*5)-1:g1*5];
    assign num_pkts_in_buf[g1*8+7:g1*8]          = num_pkts_in_buf_q[g1];
  end
  endgenerate

  // TCP / IP Checksum Offloading
  // This module will automatically calculate IP/TCP/UDP checksums and insert them into the frame
  wire  [127:0] tcp_din_mask;
  wire  [15:0]  tcp_din_par_mask;

  assign tcp_din_mask[127:64] = edma_tx_pbuf_data_w_is_128  ? {64{1'b1}}  : {64{1'b0}};
  assign tcp_din_mask[63:32]  = edma_tx_pbuf_data_w_is_128  ? {32{1'b1}}  : dma_bus_width[0]  ? {32{1'b1}}  : {32{1'b0}};
  assign tcp_din_mask[31:0]   = {32{1'b1}};

  assign tcp_din_par_mask[15:8] = edma_tx_pbuf_data_w_is_128  ? {8{1'b1}} : {8{1'b0}};
  assign tcp_din_par_mask[7:4]  = edma_tx_pbuf_data_w_is_128  ? {4{1'b1}} : dma_bus_width[0]  ? {4{1'b1}} : {4{1'b0}};
  assign tcp_din_par_mask[3:0]  = {4{1'b1}};

  reg [127:0] tx_dia_d1;
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      tx_dia_d1 <= 128'd0;
    else
      tx_dia_d1 <= tx_dia & tcp_din_mask;
  end

  edma_pbuf_tx_tcp #(
                    .p_edma_tx_pbuf_addr(p_edma_tx_pbuf_addr),
                    .p_edma_spram       (p_edma_spram),
                    .p_edma_asf_dap_prot(p_edma_asf_dap_prot),
                    .p_edma_axi         (p_edma_axi)
                  ) i_edma_pbuf_tx_tcp (
    .hclk            (hclk),
    .n_hreset        (n_hreset),
    .soft_reset      (~enable_tx_hclk),

    .dpram_we        (up_w_wr),
    .dpram_din       (up_w_data & tcp_din_mask),
    .dpram_din_par   (up_w_data_par & tcp_din_par_mask),
    .dpram_addr      (tx_addra),
    .dpram_eop       (al_w_eop),
    .dpram_din_d1    (tx_dia_d1 & tcp_din_mask),
    .man_rd_new_pkt  (sram_wr_state_is_idle),
    .tx_pbuf_tcp_en  (tx_pbuf_tcp_en & ~first_descr[48]), // TCP enabled and adding CRC to pkt
    .dma_bus_width   ({edma_tx_pbuf_data_w_is_128,dma_bus_width[0]}),

    .ip_hdr_cs_we    (ip_hdr_cs_we),
    .ip_hdr_cs       (ip_hdr_cs),
    .ip_hdr_cs_par   (ip_hdr_cs_par),
    .ip_hdr_cs_addr  (ip_hdr_cs_addr),
    .tcp_hdr_cs_we   (tcp_hdr_cs_we),
    .tcp_hdr_cs      (tcp_hdr_cs),
    .tcp_hdr_cs_par  (tcp_hdr_cs_par),
    .tcp_hdr_cs_addr (tcp_hdr_cs_addr),
    .tcp_status      (tcp_status),
    .tx_ena_abort    ()
  );
  
  assign ip_hdr_cs_reord      = { ip_hdr_cs[119:112],  ip_hdr_cs[127:120],
                                  ip_hdr_cs[103:96],   ip_hdr_cs[111:104],
                                  ip_hdr_cs[87:80],    ip_hdr_cs[95:88],
                                  ip_hdr_cs[71:64],    ip_hdr_cs[79:72],
                                  ip_hdr_cs[55:48],    ip_hdr_cs[63:56],
                                  ip_hdr_cs[39:32],    ip_hdr_cs[47:40],
                                  ip_hdr_cs[23:16],    ip_hdr_cs[31:24],
                                  ip_hdr_cs[7:0],      ip_hdr_cs[15:8]};

  assign ip_hdr_cs_par_reord  = { ip_hdr_cs_par[14],  ip_hdr_cs_par[15],
                                  ip_hdr_cs_par[12],  ip_hdr_cs_par[13],
                                  ip_hdr_cs_par[10],  ip_hdr_cs_par[11],
                                  ip_hdr_cs_par[8],   ip_hdr_cs_par[9],
                                  ip_hdr_cs_par[6],   ip_hdr_cs_par[7],
                                  ip_hdr_cs_par[4],   ip_hdr_cs_par[5],
                                  ip_hdr_cs_par[2],   ip_hdr_cs_par[3],
                                  ip_hdr_cs_par[0],   ip_hdr_cs_par[1]};

  assign tcp_hdr_cs_reord     = { tcp_hdr_cs[119:112],tcp_hdr_cs[127:120],
                                  tcp_hdr_cs[103:96], tcp_hdr_cs[111:104],
                                  tcp_hdr_cs[87:80],  tcp_hdr_cs[95:88],
                                  tcp_hdr_cs[71:64],  tcp_hdr_cs[79:72],
                                  tcp_hdr_cs[55:48],  tcp_hdr_cs[63:56],
                                  tcp_hdr_cs[39:32],  tcp_hdr_cs[47:40],
                                  tcp_hdr_cs[23:16],  tcp_hdr_cs[31:24],
                                  tcp_hdr_cs[7:0],    tcp_hdr_cs[15:8]};

  assign tcp_hdr_cs_par_reord = { tcp_hdr_cs_par[14], tcp_hdr_cs_par[15],
                                  tcp_hdr_cs_par[12], tcp_hdr_cs_par[13],
                                  tcp_hdr_cs_par[10], tcp_hdr_cs_par[11],
                                  tcp_hdr_cs_par[8],  tcp_hdr_cs_par[9],
                                  tcp_hdr_cs_par[6],  tcp_hdr_cs_par[7],
                                  tcp_hdr_cs_par[4],  tcp_hdr_cs_par[5],
                                  tcp_hdr_cs_par[2],  tcp_hdr_cs_par[3],
                                  tcp_hdr_cs_par[0],  tcp_hdr_cs_par[1]};


  // Indicate to the AXI TX block that we have seen an error and have acted upon it.
  // The AXI TX sometimes waits for this signal following errors like this
  assign dma_has_seen_err     = sram_wr_state == p_wr_state_tcp_csum && err_status[3];

  // identify when this module is busy ..
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      tx_dma_go <= 1'b0;
    else if (~enable_tx_hclk | complete_flush_hclk)
      tx_dma_go <= 1'b0;
    else
      tx_dma_go <= dpram_fill_lvl != {(p_edma_queues*p_edma_tx_pbuf_addr){1'b1}} || tx_descr_wr_vld;
  end

  // this needs to be implemented better. The Read side of the SRAM has limits of 256 frames per queue.  At the moment,
  // we have a single counter in the TX side to limit the AXI from sending more than 256 frames at a time. This
  // causes scheduler problems when there are 16 queues, as the 256 frames are distributed between them ..
  generate for (g0=0; g0<p_edma_queues[31:0]; g0=g0+1) begin : gen_num_pkts_in_buf_q
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      num_pkts_in_buf_q[g0]   <= 8'h00;
    else if (~enable_tx_hclk | complete_flush_hclk)
      num_pkts_in_buf_q[g0]   <= 8'h00;
    else if (full_pkt_read_edge && g0 == {{28{1'b0}},dma_queue_int})
    begin
      if (!(frame_written_to_sram && g0 == {{28{1'b0}},cur_descr_rd_queue}))
        num_pkts_in_buf_q[g0] <= num_pkts_in_buf_q[g0] - 8'h01;
    end
    else if (frame_written_to_sram && g0 == {{28{1'b0}},cur_descr_rd_queue})
      num_pkts_in_buf_q[g0] <= num_pkts_in_buf_q[g0] + 8'h01;
  end
  end
  endgenerate

  assign buffer_full_q        = {p_edma_queues{1'b0}};

  assign complete_flush_hclk  =  tx_status2apb[10] && tx_stat_capt_pulse;

  assign pkt_end_flush        = 1'b0;
  assign pkt_end_new          = {p_edma_queues{1'b1}};

  function              [p_edma_tx_pbuf_addr-1:0] bind2queueRange (
    input               [p_edma_tx_pbuf_addr-1:0] addr,
    input [p_edma_tx_pbuf_queue_segment_size-1:0] q_upper_bound, // Upper bound for segment
    input [p_edma_tx_pbuf_queue_segment_size-1:0] q_lower_bound, // Lower bound for segment
    input                                   [4:0] q_num_segments // Number of segments for the queue
    );                            
         
    reg [p_edma_tx_pbuf_queue_segment_size+p_edma_tx_pbuf_addr-1:0] segment_addr_bits_pad;
    reg                     [p_edma_tx_pbuf_queue_segment_size-1:0] segment_addr_bits;
    reg                     [p_edma_tx_pbuf_queue_segment_size-1:0] q_segment_mask;
    reg                     [p_edma_tx_pbuf_queue_segment_size-1:0] segment_addr_bits_m_q_lower_bound;
    reg                       [p_edma_tx_pbuf_queue_segment_size:0] bind2queueRange_int2;
    reg                                   [p_edma_tx_pbuf_addr-1:0] bind2queueRange_int;
                                    
    begin
      // A queue's segment range is always a power of 2 number so calculate the mask to keep
      // within the power of 2 range.
      q_segment_mask = q_num_segments-5'd1;
      
      // Get the segment address bits for the address coming in.
      segment_addr_bits_pad = addr >> (p_edma_tx_pbuf_addr - p_edma_tx_pbuf_queue_segment_size);
      segment_addr_bits     = segment_addr_bits_pad[p_edma_tx_pbuf_queue_segment_size-1:0];

      // We don't touch the lower address bits so default the output and then later on
      // we will change the upper address bits.
      bind2queueRange_int = addr;
      
      segment_addr_bits_m_q_lower_bound = (segment_addr_bits - q_lower_bound);
      bind2queueRange_int2 = (segment_addr_bits_m_q_lower_bound & q_segment_mask) + q_lower_bound;
      
      //$display ("addr = %0x, q_upper_bound = %0x, q_lower_bound = %0x, q_num_segments = %0x, total_segments = %0x",addr,q_upper_bound,q_lower_bound,q_num_segments,p_edma_tx_pbuf_queue_segment_size);
      // If the queue is not within its bounds then bind the queue back to its bounds.
      if (addr[p_edma_tx_pbuf_addr-1:p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size] > q_upper_bound ||
          addr[p_edma_tx_pbuf_addr-1:p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size] < q_lower_bound)
        // If the queue only has one segment then default to the lower address
      begin
        //$display ("p_edma_tx_pbuf_addr = %0d, segment address bits = %0x, mask = %0x",p_edma_tx_pbuf_addr,segment_addr_bits,q_segment_mask);
        //$display ("segment_addr_bits - q_lower_bound = %0x",(segment_addr_bits - q_lower_bound));
        if (q_num_segments == 5'd1)
          bind2queueRange_int[p_edma_tx_pbuf_addr-1:p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size] = q_lower_bound;
        // Bind the queue to the correct position within its address bounds
        else
          bind2queueRange_int [p_edma_tx_pbuf_addr-1:p_edma_tx_pbuf_addr-p_edma_tx_pbuf_queue_segment_size] = 
          bind2queueRange_int2[p_edma_tx_pbuf_queue_segment_size-1:0];
      end

      bind2queueRange = bind2queueRange_int;

    end
  endfunction

  // Handle parity related assignments and storage
  generate if (p_edma_asf_dap_prot == 1) begin : gen_dap
    wire        status_word_rd_0_3_par_err;
    wire        first_descr_par_err;
    wire        ct_sw_par_err_c;
    reg         ct_sw_par_err_r;
    wire [10:0] xfer_status_bus_par_gated;
    wire [5:0]  xfer_status_bus_ts_par_gated;
    reg  [7:0]  tx_descr_wr_data_par_r;
    reg  [11:0] upsize_data_str_par_r;
    reg  [12:0] first_descr_par;
    wire [2:0]  status_word_rd_0_par;
    wire [3:0]  status_word_rd_2_par;
    wire [3:0]  status_word_rd_3_par;
    wire [3:0]  descriptor_wb_word1_par;

    assign xfer_status_bus_par_gated    = xfer_status_bus_par & {11{full_pkt_read_edge}};
    assign xfer_status_bus_ts_par_gated = xfer_status_bus_ts_par & {6{full_pkt_read_edge}};

    assign status_word_rd_0_par = xfer_status_bus_par_gated[2:0];
    assign status_word_rd_2_par = xfer_status_bus_par_gated[6:3];
    assign status_word_rd_3_par = xfer_status_bus_par_gated[10:7];

    // Check and regenerate parity for descriptor_wb_word1
    // This uses status_word_rd_0 and status_word_rd_3.
    gem_par_chk_regen #(.p_chk_dwid (50),.p_new_dwid(32)) i_regen_par_wb_word1 (
      .odd_par  (1'b0),
      .chk_dat  ({status_word_rd_0,status_word_rd_3}),
      .chk_par  ({status_word_rd_0_par,status_word_rd_3_par}),
      .new_dat  (descriptor_wb_word1),
      .dat_out  (),
      .par_out  (descriptor_wb_word1_par),
      .chk_err  (status_word_rd_0_3_par_err)
    );

    // The timestamp is optional
    if (p_edma_tsu == 1) begin : gen_ts_par_store
      reg  [5:0]  tx_descr_wr_ts_par_r;
      always@(posedge hclk or negedge n_hreset)
      begin
        if (~n_hreset)
          tx_descr_wr_ts_par_r  <= 6'h00;
        else if (~enable_tx_hclk | complete_flush_hclk)
          tx_descr_wr_ts_par_r    <= 6'h00;
        else if (full_pkt_read_edge)
          tx_descr_wr_ts_par_r  <= xfer_status_bus_ts_par_gated;
      end
      assign tx_descr_wr_ts_par = tx_descr_wr_ts_par_r;
    end else begin : gen_no_ts_par_store
      assign tx_descr_wr_ts_par = 6'h00;
    end

    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        tx_descr_wr_data_par_r  <= 8'h00;
      else if (~enable_tx_hclk | complete_flush_hclk)
        tx_descr_wr_data_par_r  <= 8'h00;
      else if (full_pkt_read_edge)
        tx_descr_wr_data_par_r  <= {descriptor_wb_word1_par,
                                    status_word_rd_2_par};
    end

    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        first_descr_par <= 13'd0;
      else if (~enable_tx_hclk | complete_flush_hclk)
        first_descr_par <= 13'd0;
      else if (cur_descr_rd_valid && this_is_1st_descr)
        first_descr_par <= cur_descr_rd_par;
    end

    // Check and regenerate parity for status_word_wr_0/3 as this is based on various parts of first_descr.
    gem_par_chk_regen #(.p_chk_dwid (97),.p_new_dwid(64)) i_regen_tx_descr_wr_data_par (
      .odd_par  (1'b0),
      .chk_dat  (first_descr),
      .chk_par  (first_descr_par),
      .new_dat  ({status_word_wr_3,status_word_wr_0}),
      .dat_out  (),
      .par_out  ({status_word_wr_3_par,status_word_wr_0_par}),
      .chk_err  (first_descr_par_err)
    );

    // Parity generator for frm_ctrl_add
    cdnsdru_asf_parity_gen_v1 #(
      .p_data_width (p_edma_tx_pbuf_addr)
    ) i_par_frm_ctrl_add (
      .odd_par    (1'b0),
      .data_in    (frm_ctrl_add),
      .data_out   (),
      .parity_out (frm_ctrl_add_par)
    );

    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        upsize_data_str_par_r <= 12'h000;
      else if (~enable_tx_hclk | complete_flush_hclk)
        upsize_data_str_par_r <= 12'h000;
      else if (al_w_wr)
        case (upsize_str_cnt_nxt)
          2'b01   : upsize_data_str_par_r <= al_w_data_par[11:0];
          2'b10   : upsize_data_str_par_r <= {al_w_data_par[7:0],upsize_data_str_par_r[3:0]};
          default : upsize_data_str_par_r <= {al_w_data_par[3:0],upsize_data_str_par_r[7:0]};
        endcase
    end

    // Parity checker for cutthru_status_word
    cdnsdru_asf_parity_check_v1 #(.p_data_width(p_ct_width)) i_par_chk_ct_sw (
      .odd_par(1'b0),
      .data_in(cutthru_status_word),
      .parity_in(cutthru_status_word_par),
      .parity_err(ct_sw_par_err_c)
    );

    // Register the parity error when actually pushing to the FIFO.
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        ct_sw_par_err_r <= 1'b0;
      else if (~enable_tx_hclk | complete_flush_hclk)
        ct_sw_par_err_r <= 1'b0;
      else if (cutthru_status_word_push)
        ct_sw_par_err_r <= ct_sw_par_err_c;
    end

    // Combine ASF error signals
    assign asf_dap_tx_wr_err    = first_descr_par_err | status_word_rd_0_3_par_err | ct_sw_par_err_r;

    assign tx_descr_wr_data_par = tx_descr_wr_data_par_r;
    assign status_word_wr_1_par = bd_extended_mode_en ? first_descr_par[11:8] : 4'h0;
    assign status_word_wr_2_par = first_descr_wb_add[35:32];
    assign upsize_data_str_par  = upsize_data_str_par_r;
  end else begin : gen_no_dap
    assign tx_descr_wr_ts_par   = 6'h00;
    assign tx_descr_wr_data_par = 8'h00;
    assign status_word_wr_0_par = 4'h0;
    assign status_word_wr_1_par = 4'h0;
    assign status_word_wr_2_par = 4'h0;
    assign status_word_wr_3_par = 4'h0;
    assign frm_ctrl_add_par     = {((p_edma_tx_pbuf_addr+7)/8){1'b0}};
    assign upsize_data_str_par  = 12'd0;
    assign asf_dap_tx_wr_err    = 1'b0;
  end
  endgenerate

  // The following is just for lint
  genvar q_cnt_1;
  generate for (q_cnt_1=0; q_cnt_1<p_edma_queues[31:0]; q_cnt_1 = q_cnt_1+1) begin : gen_pad_sigs
    assign frm_data_add_pad[q_cnt_1] = frm_data_add[q_cnt_1];
  end
  endgenerate
  genvar unused_q_cnt;
  generate for (unused_q_cnt=p_edma_queues; unused_q_cnt<16; unused_q_cnt = unused_q_cnt+1)
  begin : set_unused_sigs
    wire zero = 1'b0;
    always@(*)
    begin
      num_pkts_in_buf_q[unused_q_cnt] = {8{zero}};
    end
    assign TX_PBUF_SEGMENTS_UPPER_ADDR_ARRAY[unused_q_cnt] = {p_edma_tx_pbuf_queue_segment_size{1'b0}};
    assign TX_PBUF_SEGMENTS_LOWER_ADDR_ARRAY[unused_q_cnt] = {p_edma_tx_pbuf_queue_segment_size{1'b0}};
    assign TX_PBUF_NUM_SEGMENTS_ARRAY[unused_q_cnt] = 5'd0;
    assign frm_data_add_pad[unused_q_cnt] = {p_edma_tx_pbuf_addr{1'b0}};
  end
  endgenerate

endmodule


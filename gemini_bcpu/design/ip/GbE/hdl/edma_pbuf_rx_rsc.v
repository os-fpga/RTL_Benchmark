//------------------------------------------------------------------------------
// Copyright (c) 2012-2017 Cadence Design Systems, Inc.
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
//   Filename:           edma_pbuf_rx_rsc.v
//   Module Name:        edma_pbuf_rx_rsc
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
//   Description :      Receive Side Coelescing Module
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_pbuf_rx_rsc
  #(parameter p_edma_queues       = 0,
    parameter p_edma_addr_width   = 0,
    parameter p_edma_bus_width    = 0)
  (

  // Clocks and Reset
  input                               hclk,
  input                               n_hreset,

  // AHB Interface (MAC side)
  input                               mac_hbusreq_descr_rd,
  input                               mac_hbusreq_descr_wr,
  input                               mac_in_header,
  input                               mac_hlock_descr,
  input  [p_edma_addr_width-1:0]       mac_haddr_descr,
  input  [1:0]                        mac_htrans_descr,
  input                               mac_hwrite_descr,
  input  [2:0]                        mac_hsize_descr,
  input  [2:0]                        mac_hburst_descr,
  input  [3:0]                        mac_hprot_descr,
  input  [127:0]                      mac_hwdata_descr,
  input                               mac_hbusreq_data,
  input                               mac_hlock_data,
  input  [p_edma_addr_width-1:0]       mac_haddr_data,
  input  [1:0]                        mac_htrans_data,
  input                               mac_hwrite_data,
  input  [2:0]                        mac_hsize_data,
  input  [2:0]                        mac_hburst_data,
  input  [3:0]                        mac_hprot_data,
  input  [127:0]                      mac_hwdata_data,
  output reg                          mac_hgrant_descr,
  output reg                          mac_hgrant_data,
  output reg                          mac_hready,
  output reg [1:0]                    mac_hresp,
  output     [p_edma_bus_width-1:0]    mac_hrdata,

  // AHB Interface (Host side)
  output reg                          host_hbusreq_descr,
  output reg                          host_hlock_descr,
  output reg [p_edma_addr_width-1:0]   host_haddr_descr,
  output reg [1:0]                    host_htrans_descr,
  output reg                          host_hwrite_descr,
  output reg [2:0]                    host_hsize_descr,
  output reg [2:0]                    host_hburst_descr,
  output reg [3:0]                    host_hprot_descr,
  output reg [127:0]                  host_hwdata_descr,
  input                               write_to_base_descr,
  output reg                          host_hbusreq_data,
  output reg                          host_hlock_data,
  output reg [p_edma_addr_width-1:0]   host_haddr_data,
  output reg [1:0]                    host_htrans_data,
  output reg                          host_hwrite_data,
  output reg [2:0]                    host_hsize_data,
  output reg [2:0]                    host_hburst_data,
  output reg [3:0]                    host_hprot_data,
  output reg [127:0]                  host_hwdata_data,
  input                               host_hgrant_descr,
  input                               host_hgrant_data,
  input                               host_hready,
  input  [1:0]                        host_hresp,
  input  [p_edma_bus_width-1:0]       host_hrdata,
  output [p_edma_addr_width-1:0]      next_buffer_start_add,
  output                              host_update_buf_add,
  output reg                          rsc_coalescing_ended,
  input                               jumbo_enable,                   // Enable jumbo frames
  input       [13:0]                  jumbo_max_length,

  output                              update_databuf_add, //Instruct AHB DMA to update databuffer address
  input       [13:0]                  full_pkt_size_in,
  output      [3:0]                   mac_buffer_offset,
  output reg  [13:0]                  full_pkt_size_out,
  output      [15:0]                  rsc_write_strobe,
  output reg  [3:0]                   queue_ptr_rx_mod,

  // Memory Update interface
  output                              rsc_update_valid,
  input                               rsc_update_ready,
  output                              rsc_update_descr,
  output                              rsc_update_last,
  output      [p_edma_addr_width-1:0] rsc_update_addr,
  output      [31:0]                  rsc_update_data,
  output      [15:0]                  rsc_update_ben,

  // Control
  input                               last_data_to_buff_mac,
  output                              last_data_to_buff_rsc,
  input                               enable_rx_hclk, // soft reset
  input  [1:0]                        dma_bus_width,
  input  [p_edma_queues-1:0]          rsc_en, // Receive Side Coalescing enable
  input  [3:0]                        ahb_queue_ptr_rx, // Queue
  input                               rsc_stop,   // Stop coalescing immediately
  input                               rsc_push,   // Stop coalescing after this upcoming frame
  input  [4:0]                        l3_offset,  // IP offset in bytes
  input  [11:0]                       l4_offset,  // UDP/TCP offset in bytes
  input  [11:0]                       pld_offset, // Payload offset
  input                               rx_dma_err, // DMA state machine error
  output wire                         first_frame, // Indicates 1st Frame
  output reg [p_edma_queues-1:0]      rsc_clr_tog  // Receive Side Coalescing clear
);

localparam S1_IDLE         = 4'h0;
localparam S1_HDR_DESCR_RD = 4'h1;
localparam S1_HDR_DATA_WR  = 4'h2;
localparam S1_HDR_DESCR_WR = 4'h3;
localparam S1_PLD_DESCR_RD = 4'h4;
localparam S1_PLD_DATA_WR  = 4'h5;
localparam S1_PLD_DESCR_WR = 4'h6;
localparam S1_HDR_UPDATE   = 4'h7;
localparam S1_DESCR_UPDATE = 4'h8;
localparam WAIT_FOR_NXT_FRAME = 4'h9;

// This parameter defines when coalescing should stop
// 1522 is the max length, including 1 VLAN, to be safe
localparam MAX_COALESCING_LEN = 16'd16383;

reg                          mac_push_hready;
reg                          mac_haddr_bit3_dph;
wire [127:0]                 mac_hwdata_data_end;
wire                         allowed_to_coalesce;
reg                          need_update_cycle;
wire                         hdr_update_cmp;
wire                         descr_update_cmp;
reg  [128:0]                 mac_hrdata_pad;
wire                         block_writes_aph;
wire [13:0]                  full_pkt_size;
reg                          write_to_base_descr_dph;
reg                          rsc_stopping;
reg                          rsc_stopping_only;
wire [15:0]                  num_bytes_coalesced;
wire                         mac_htrans_data_dph_pulse;
reg                          mac_htrans_data_dph;
reg                          start_of_new_mac_frame;
wire                         ptr_update;
reg                          seen_nxt_descr_rd;

//------------------------------------------------------------------------------
// This module will be split into two sections; the first being that for multi
// queues where the logic requires to be replicated on a per queue and the second
// section where we don't need the logic to be replicated.
//------------------------------------------------------------------------------
reg [3:0]                    fsm_descr_rd_nxt_state [p_edma_queues-1:0];
wire[3:0]                    fsm_descr_rd_nxt_state_pad [15:0];
reg [3:0]                    fsm_descr_rd_cur_state [p_edma_queues-1:0];
wire[3:0]                    fsm_descr_rd_cur_state_pad [15:0];
reg [3:0]                    fsm_descr_rd_lst_state [p_edma_queues-1:0];
reg                          first_frame_int        [p_edma_queues-1:0];
wire                         first_frame_int_pad    [15:0];
reg [6:0]                    saved_descr_hdr_wr     [p_edma_queues-1:0];
wire[6:0]                    saved_descr_hdr_wr_pad [15:0];
reg [6:0]                    saved_descr_pld_wr     [p_edma_queues-1:0];
wire[6:0]                    saved_descr_pld_wr_pad [15:0];
wire [15:0]                  block_descr_rd;
wire [15:0]                  block_descr_wr;
wire [15:0]                  block_hdr_wr;
wire [p_edma_queues-1:0]     rsc_coalescing_ended_int;
wire                         rsc_coalescing_ended_c;
reg  [p_edma_queues-1:0]     nxt_is_update;
reg  [p_edma_queues-1:0]     block_descr_rd_1;
wire                         curr_rsc_en;
wire                         valid_descr_rd_rsc;

wire [16:0] rsc_en_pad;
assign rsc_en_pad = {{17-p_edma_queues{1'b0}},rsc_en};
assign curr_rsc_en        = rsc_en_pad[ahb_queue_ptr_rx];
assign valid_descr_rd_rsc = |mac_htrans_descr[1] & ~mac_hwrite_descr & ~(rsc_stopping) & rsc_en_pad[ahb_queue_ptr_rx];

wire [15:0] _16k_minus_maxlen;
assign _16k_minus_maxlen = jumbo_enable ? MAX_COALESCING_LEN - {2'b00,jumbo_max_length}
                                        : MAX_COALESCING_LEN - 16'd1522;
genvar gv_i;
generate for (gv_i=0; gv_i<p_edma_queues; gv_i=gv_i+1) begin : gen_rsc_queues
  reg                          first_frame_c;
  reg                          read_base_descr;
  //------------------------------------------------------------------------------
  // Main state machine.
  //------------------------------------------------------------------------------
  // This state machine controls monitors the MAC accesses, and identifies when descritor fetches,
  // descriptor writes and data buffer writes occur. It uses this to identify which of the accesses
  // can be dropped before forwarding to the host, and also controls the back pressure (hready)
  // back to the MAC so that extra host accesses can be added (like header updates, or descr wr updates)
  // Note when RSC is on, there will always be 2 descriptor fetches per frame coming
  // from the AHB DMA. the first will be for the TCP/IP  header, the 2nd will be payload.
  // There will be no further splits because the user must set the buffer size going into
  // the AHB DMA for the queues associated with RSC to be maximum
  // So effective 6 transactions from the AHB DMA for each packet
  //  1. Descriptor read for header
  //  2. Data write for header
  //  3. Descriptor write for header
  //  4. Descriptor read for payload
  //  5. Data write for payload
  //  6. Descriptor write for payload
  //
  // And that is repeated for each packet
  // When RSC is on, for the first inbound segment ...
  //    1. Step 5 should be truncated to ensure pad/crc is dropped
  //    2. Step 6 should be modified such that the used bit is cleared. however, the actual write is passed to host.
  //       This is so that when it comes to setting the used bit at the end of coalescing, it can be done
  //       without having to rewrite all the rest of the descriptor contents.  Only the buffer length
  //       and used bit will need to be updated.
  //
  // When RSC is on, for the remaining inbound segments ...
  //   1. we will drop step 1,2,3,4 and 6 for the second to last frame segment of a coalesced frame
  //
  // For every incoming segment being coalesced apart from the first, after step 6, this block should
  // issue a header update. During this time, the hready to the MAC should be held low and the
  // transactions issued to the host will be made via the update interface
  //
  // When coalescing has to finish, this block must issue a descriptor update following the last header update.
  // During this time, the hready to the MAC should be held low and the
  // transactions issued to the host will be made via the update interface

  // Helper signals ...
  wire   looking_at_correct_queue;
  assign looking_at_correct_queue = gv_i[3:0] == ahb_queue_ptr_rx;

  // We will stop if this frame will make us go past the 16K-max length
  // pkt threshold. Note hat num_bytes_coalesced is updated during frame transfer, so we can only act
  // upon it at the end of current small frame
  wire perform_rsc_stop;
  assign perform_rsc_stop = (num_bytes_coalesced >= _16k_minus_maxlen | (rsc_stopping & looking_at_correct_queue) | ~rsc_en[gv_i]);
  // Determines next state
  always @(*)
  begin
   nxt_is_update[gv_i] = 1'b0;
   block_descr_rd_1[gv_i] = 1'b0;
   case (fsm_descr_rd_cur_state[gv_i])
     S1_IDLE    :
     begin
       if (curr_rsc_en & valid_descr_rd_rsc & looking_at_correct_queue) // Shouldn't need rsc_stop here if rsc_en drops
         fsm_descr_rd_nxt_state[gv_i]  = S1_HDR_DESCR_RD;
       else
         fsm_descr_rd_nxt_state[gv_i]  = S1_IDLE;
     end

     S1_HDR_DESCR_RD    :
     // The underlying MAC is performing the descriptor read for the payload of the 1st segment
     // descriptor read. Wait until the descriptor read is complete -
     // using the first data write for this
     begin
       if (|mac_htrans_data[1] & looking_at_correct_queue)
         fsm_descr_rd_nxt_state[gv_i]  = S1_HDR_DATA_WR;
       else
         fsm_descr_rd_nxt_state[gv_i]  = S1_HDR_DESCR_RD;
     end

     S1_HDR_DATA_WR    :
     begin
       if (|mac_htrans_descr[1] & mac_hwrite_descr & looking_at_correct_queue)
         fsm_descr_rd_nxt_state[gv_i]  = S1_HDR_DESCR_WR;
       else
         fsm_descr_rd_nxt_state[gv_i]  = S1_HDR_DATA_WR;
     end

     S1_HDR_DESCR_WR    :
     begin
       if (|mac_htrans_descr[1] & ~mac_hwrite_descr & looking_at_correct_queue)
         fsm_descr_rd_nxt_state[gv_i]  = S1_PLD_DESCR_RD;
       else
         fsm_descr_rd_nxt_state[gv_i]  = S1_HDR_DESCR_WR;
     end

     S1_PLD_DESCR_RD    :
     begin
       if (|mac_htrans_data[1] & looking_at_correct_queue)
         fsm_descr_rd_nxt_state[gv_i]  = S1_PLD_DATA_WR;
       else
         fsm_descr_rd_nxt_state[gv_i]  = S1_PLD_DESCR_RD;
     end

     S1_PLD_DATA_WR    :
     begin
       if (mac_hbusreq_descr_wr & looking_at_correct_queue)
         fsm_descr_rd_nxt_state[gv_i]  = S1_PLD_DESCR_WR;
       else
         fsm_descr_rd_nxt_state[gv_i]  = S1_PLD_DATA_WR;
     end

     S1_PLD_DESCR_WR    :
     begin
       if (write_to_base_descr_dph & gv_i[3:0] == queue_ptr_rx_mod)  // writing to last descriptor word ...
       begin
         if (~first_frame_int_pad[queue_ptr_rx_mod])
         begin
           nxt_is_update[gv_i]  = 1'b1;
           fsm_descr_rd_nxt_state[gv_i]  = S1_HDR_UPDATE;
         end
         else if (perform_rsc_stop) // With first_frame, we dont need to do a header update, just the descriptor
         begin
           nxt_is_update[gv_i]  = 1'b1;
           fsm_descr_rd_nxt_state[gv_i]  = S1_DESCR_UPDATE;
         end
         else if (valid_descr_rd_rsc & looking_at_correct_queue)
         begin
           fsm_descr_rd_nxt_state[gv_i]  = S1_HDR_DATA_WR;  // have we had the next descriptor read ?
           block_descr_rd_1[gv_i] = 1'b1;
         end
         else
           fsm_descr_rd_nxt_state[gv_i]  = WAIT_FOR_NXT_FRAME;
       end
       else
         fsm_descr_rd_nxt_state[gv_i]  = S1_PLD_DESCR_WR;
     end

     S1_HDR_UPDATE :
     begin
       if (hdr_update_cmp)
       begin
         // We will stop if this frame will make us go past the 16K-max length
         // pkt threshold
         if (perform_rsc_stop)
         begin
           nxt_is_update[gv_i]  = 1'b1;
           fsm_descr_rd_nxt_state[gv_i]  = S1_DESCR_UPDATE;
         end
         else
           fsm_descr_rd_nxt_state[gv_i]  = WAIT_FOR_NXT_FRAME;
       end
       else
       begin
         nxt_is_update[gv_i]  = 1'b1;
         fsm_descr_rd_nxt_state[gv_i]  = S1_HDR_UPDATE;
       end
     end

     S1_DESCR_UPDATE :
     begin
       if (descr_update_cmp)
       begin
         if (~rsc_stopping & valid_descr_rd_rsc & looking_at_correct_queue & rsc_en[gv_i])
           fsm_descr_rd_nxt_state[gv_i]  = S1_HDR_DATA_WR;  // have we had the next descriptor read ?
         else
           fsm_descr_rd_nxt_state[gv_i]  = S1_IDLE;         // else wait for it
       end
       else
       begin
         nxt_is_update[gv_i]  = 1'b1;
         fsm_descr_rd_nxt_state [gv_i] = S1_DESCR_UPDATE;
       end
     end

     default :    // WAIT_FOR_NXT_FRAME
     begin
       // Jump to the descriptor update state if a new frame comes in and it has the rsc_stop flags set
       if  ((rsc_stopping & looking_at_correct_queue) | (~rsc_en[gv_i]))
       begin
         nxt_is_update[gv_i]  = 1'b1;
         // Wait until the state machine processing the previous queue has finished its update cycles
         if (~(write_to_base_descr_dph | fsm_descr_rd_cur_state_pad[queue_ptr_rx_mod] == S1_HDR_UPDATE | fsm_descr_rd_cur_state_pad[queue_ptr_rx_mod] == S1_DESCR_UPDATE))
           fsm_descr_rd_nxt_state[gv_i]  = S1_DESCR_UPDATE;
         else
           fsm_descr_rd_nxt_state[gv_i]  = WAIT_FOR_NXT_FRAME;
       end
       else if ((seen_nxt_descr_rd | valid_descr_rd_rsc) & looking_at_correct_queue)
         fsm_descr_rd_nxt_state[gv_i]  = S1_HDR_DATA_WR;
       else
         fsm_descr_rd_nxt_state[gv_i]  = WAIT_FOR_NXT_FRAME;
     end

   endcase
  end

  // Current state
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      fsm_descr_rd_cur_state [gv_i] <= S1_IDLE;
    else
    begin
      if (~enable_rx_hclk)
        fsm_descr_rd_cur_state[gv_i]  <= S1_IDLE;
      else if  (rx_dma_err & fsm_descr_rd_cur_state[gv_i] != S1_IDLE)
        fsm_descr_rd_cur_state[gv_i]  <= fsm_descr_rd_lst_state[gv_i];
      else
        fsm_descr_rd_cur_state[gv_i]  <= fsm_descr_rd_nxt_state[gv_i];
    end
  end

  // lstrent state
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      fsm_descr_rd_lst_state [gv_i] <= S1_IDLE;
    else
    begin
      if (~enable_rx_hclk)
        fsm_descr_rd_lst_state[gv_i]  <= S1_IDLE;
      else if (mac_hready)
        fsm_descr_rd_lst_state[gv_i]  <= fsm_descr_rd_cur_state[gv_i];
    end
  end

  always @(*)
  begin
    if (rsc_coalescing_ended & gv_i[3:0] == queue_ptr_rx_mod)
      first_frame_c = 1'b1;
    else if (fsm_descr_rd_nxt_state[gv_i] != S1_PLD_DESCR_WR & fsm_descr_rd_cur_state[gv_i] == S1_PLD_DESCR_WR)
      first_frame_c = 1'b0;
    else
      first_frame_c = first_frame_int[gv_i];
  end

  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      first_frame_int[gv_i] <= 1'b1;
    else if (~enable_rx_hclk)
      first_frame_int[gv_i] <= 1'b1;
    else
      first_frame_int[gv_i] <= first_frame_c;
  end

//------------------------------------------------------------------------------
// Set the clear if you are doing an descriptor update which means a flag has
// been set (SYN/FIN/RST/URG/PSH or sequence number shows a packet has been
// dropped.
// The clear signal needs to be detected in the pclk domain therefore for the
// signal to be captured we use this signal as a toggle.
//------------------------------------------------------------------------------
//
  always@(posedge hclk or negedge n_hreset)
  begin : p_rsc_clr_tog
    if (~n_hreset)
      rsc_clr_tog[gv_i] <= 1'b0;
    else if (~enable_rx_hclk)
      rsc_clr_tog[gv_i] <= 1'b0;
    else
    begin
      // The descriptor update happens over multiple cycles to also
      // ensure the update is done on the last phase of the access.
      if (rsc_en[gv_i] & (fsm_descr_rd_cur_state[gv_i] == S1_DESCR_UPDATE) &
         (rsc_stopping_only) & (fsm_descr_rd_nxt_state[gv_i] != S1_DESCR_UPDATE))
        rsc_clr_tog[gv_i] <= ~rsc_clr_tog[gv_i];
      else
        rsc_clr_tog[gv_i] <= rsc_clr_tog[gv_i];
    end
  end // p_rsc_clr_tog

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      read_base_descr <= 1'b0;
    else if (~enable_rx_hclk)
      read_base_descr <= 1'b0;
    else if (mac_hready & looking_at_correct_queue)
    begin
      read_base_descr <= (mac_htrans_descr[1] & ~mac_hwrite_descr & (first_frame_int[gv_i] | rsc_stopping | ~rsc_en[gv_i] |
                         (num_bytes_coalesced >= _16k_minus_maxlen &
                          fsm_descr_rd_cur_state[gv_i] == S1_PLD_DESCR_WR)));
    end
  end

//------------------------------------------------------------------------------
// When coalescing finishes, we need to issue a new descriptor write update to the AXI block.
// This will be to update the total length bytes in the coalesced frame (including header) in word 1 of the databuffer.
// Also need a seperate update for the used bit to set it high.
// We use the update interface rather than the descriptor write port, as we dont have all the information
// to perform a full descriptor write, just the updated bytes.
// To achieve this, we need to understand the bytes invloved and store any other bits of a specific byte we update.
// For example, the length field of the descriptor is in bits 13:0 of word 1. Bits 15 and 14 are the EOP and SOP bits
// respectively and can be calculated without storage.  The used bit on the other hand resides in bit 0 of word 0.
// Bits [7:1] hold the data buffer address bits and the wrap bit. In order to update this byte, we will need to buffer
// these 7 bits.
//------------------------------------------------------------------------------
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      saved_descr_hdr_wr[gv_i] <= 7'h00;
      saved_descr_pld_wr[gv_i] <= 7'h00;
    end
    else if (~enable_rx_hclk)
    begin
      saved_descr_hdr_wr[gv_i] <= 7'h00;
      saved_descr_pld_wr[gv_i] <= 7'h00;
    end
    else
    begin
      if (mac_hready & (looking_at_correct_queue))
      begin
        if (read_base_descr)
        begin
          if (~mac_in_header)
            saved_descr_pld_wr[gv_i] <= mac_hrdata[7:1];
          else if (first_frame_int[gv_i])      // Only update on first Header of a Coalesced frame
            saved_descr_hdr_wr[gv_i] <= mac_hrdata[7:1];
          else
            saved_descr_hdr_wr[gv_i] <= saved_descr_hdr_wr[gv_i];
        end
      end
    end
  end

  assign rsc_coalescing_ended_int[gv_i] = fsm_descr_rd_nxt_state[gv_i] == S1_DESCR_UPDATE &
                                          fsm_descr_rd_cur_state[gv_i] != S1_DESCR_UPDATE;


  //------------------------------------------------------------------------------
  // We need to block descriptor reads if they are part of a coalesced frame.
  // Sometimes a descriptor read can occur immediately following a descriptor write.
  // in this case, first_frame will stay high for the cycle that the descriptor read
  // is active.
  //------------------------------------------------------------------------------

  // block all descriptor reads if first_frame is low
  assign block_descr_rd[gv_i] =   block_descr_rd_1[gv_i] |
                                  (looking_at_correct_queue & ~(first_frame_int[gv_i] |
                                   rsc_stopping | ~rsc_en[gv_i]) & ~mac_hwrite_descr) |
                                  (looking_at_correct_queue & (|nxt_is_update));

  assign block_descr_wr[gv_i] = looking_at_correct_queue & ~first_frame_int[gv_i] & mac_hwrite_descr;


  assign block_hdr_wr[gv_i]   = (fsm_descr_rd_cur_state[gv_i]  == S1_HDR_DATA_WR & ~first_frame_int[gv_i]);


  assign saved_descr_hdr_wr_pad[gv_i]   = saved_descr_hdr_wr[gv_i];
  assign saved_descr_pld_wr_pad[gv_i]   = saved_descr_pld_wr[gv_i];
  assign first_frame_int_pad[gv_i]      = first_frame_int[gv_i];
  assign fsm_descr_rd_nxt_state_pad[gv_i]      = fsm_descr_rd_nxt_state[gv_i];
  assign fsm_descr_rd_cur_state_pad[gv_i]      = fsm_descr_rd_cur_state[gv_i];
end // gen_rsc_queues
for (gv_i=p_edma_queues; gv_i<16; gv_i=gv_i+1) begin : gen_rsc_queues_pad
  assign saved_descr_hdr_wr_pad[gv_i]   = 7'd0;
  assign saved_descr_pld_wr_pad[gv_i]   = 7'd0;
  assign first_frame_int_pad[gv_i]      = 1'b0;
  assign fsm_descr_rd_nxt_state_pad[gv_i] = 4'd0;
  assign fsm_descr_rd_cur_state_pad[gv_i] = 4'd0;
  assign block_descr_rd[gv_i] =   1'b0;
  assign block_descr_wr[gv_i] =   1'b0;
  assign block_hdr_wr[gv_i] =   1'b0;
end // gen_rsc_queues_pad
endgenerate


//------------------------------------------------------------------------------
// Non Replicated logic
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Capture the dph of the descriptor read. This is so we can always view the descriptor read
// on the exit from S1_DESCR_UPDATE/S1_HDR_UPDATE state
//------------------------------------------------------------------------------
//
always@(posedge hclk or negedge n_hreset)
begin
  if (~n_hreset)
    seen_nxt_descr_rd  <= 1'b0;
  else
  begin
    if (~enable_rx_hclk)
      seen_nxt_descr_rd  <= 1'b0;
    else if (mac_hready)
      seen_nxt_descr_rd  <= (|mac_htrans_descr[1] & ~mac_hwrite_descr);
  end
end

always@(posedge hclk or negedge n_hreset)
begin
  if (~n_hreset)
    write_to_base_descr_dph <= 1'b0;
  else if (~enable_rx_hclk)
    write_to_base_descr_dph <= 1'b0;
  else if (host_hready)
    write_to_base_descr_dph <= write_to_base_descr;
end

//------------------------------------------------------------------------------
// Virtually the same as rsc_stop, however we don't want this
// active to early in the cycle therefore it needed qualified
// with mac_hready
//------------------------------------------------------------------------------
//
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      begin
      rsc_stopping      <= 1'b0;
      rsc_stopping_only <= 1'b0;
      end
    else if (~enable_rx_hclk)
      begin
      rsc_stopping      <= 1'b0;
      rsc_stopping_only <= 1'b0;
      end
    else if (mac_hready)
      begin
      rsc_stopping      <= (rsc_stop | rsc_push);
      rsc_stopping_only <= (rsc_stop);
      end
  end

//------------------------------------------------------------------------------
// Don't update the queue pointer if its just about to change but not completed
// the current sequence. Hold the pointer until its complete otherwise the
// statemachines get cross contaminated.
//------------------------------------------------------------------------------
//
  assign ptr_update =   (fsm_descr_rd_nxt_state_pad[queue_ptr_rx_mod] != S1_DESCR_UPDATE &&
                         fsm_descr_rd_nxt_state_pad[queue_ptr_rx_mod] != S1_HDR_UPDATE);

  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      queue_ptr_rx_mod  <= 4'h0;
    else
    begin
      if (~enable_rx_hclk)
        queue_ptr_rx_mod  <= 4'h0;
      else if (ptr_update)
        queue_ptr_rx_mod  <= ahb_queue_ptr_rx;
    end
  end

always @(*)
begin
  // Block descriptor reads from getting to host side and all descriptor writes
  // apart from the first in payload
  if (block_descr_rd[ahb_queue_ptr_rx] | block_descr_wr[ahb_queue_ptr_rx])
  begin
    host_hbusreq_descr  =  1'b0;
    host_htrans_descr   =  2'b00;
  end

  // Intercept the descriptor write for the first payload and clear the used bit
  // This is vital since we are not done with the descriptor yet.
  else if (first_frame_int_pad[ahb_queue_ptr_rx] & (fsm_descr_rd_cur_state_pad[ahb_queue_ptr_rx]  != S1_IDLE))
  begin
    // We want block ALL descriptor reads and all descriptor writes apart from the first payload
    host_hbusreq_descr  =  mac_hbusreq_descr_wr ;
    host_htrans_descr   =  mac_htrans_descr;
  end

  else
  begin
    host_hbusreq_descr  =  mac_hbusreq_descr_rd | mac_hbusreq_descr_wr;
    host_htrans_descr   =  mac_htrans_descr;
  end

  // Intercept the descriptor write for the first payload and clear the used bit
  // This is vital since we are not done with the descriptor yet.
  if (block_descr_wr[queue_ptr_rx_mod] == 1'b0 & first_frame_int_pad[queue_ptr_rx_mod] & (fsm_descr_rd_cur_state_pad[queue_ptr_rx_mod]  != S1_IDLE))
  begin
    if (dma_bus_width[1] & mac_haddr_bit3_dph) // 128bit (descriptor will be on upper half)
      host_hwdata_descr =  write_to_base_descr_dph ? mac_hwdata_descr & {{63{1'b1}},1'b0,{64{1'b0}}} : mac_hwdata_descr;  // clear used
    else
      host_hwdata_descr =  write_to_base_descr_dph ? mac_hwdata_descr & {{127{1'b1}},1'b0} : mac_hwdata_descr;  // clear used
  end

  else
    host_hwdata_descr   =  mac_hwdata_descr;

  mac_hgrant_descr    =  host_hgrant_descr;
  host_hlock_descr    =  mac_hlock_descr;
  host_haddr_descr    =  mac_haddr_descr;
  host_hwrite_descr   =  mac_hwrite_descr;
  host_hsize_descr    =  mac_hsize_descr;
  host_hburst_descr   =  mac_hburst_descr;
  host_hprot_descr    =  mac_hprot_descr;

  // Block data writes from getting to host side if in state S1_3 and it's not payload
  // Basically this means we drop all the headers of each incoming coalesced frames apart
  // from the first
  if (block_hdr_wr[ahb_queue_ptr_rx])
  begin
    host_hbusreq_data   =  1'b0;
    mac_hgrant_data     =  1'b1;
    host_htrans_data    =  2'b00;
  end
  else
  begin
    host_hbusreq_data  =  mac_hbusreq_data;
    mac_hgrant_data    =  host_hgrant_data;
    host_htrans_data   =  mac_htrans_data & {2{~block_writes_aph}};
  end

  host_hlock_data     =  mac_hlock_data;
  host_haddr_data     =  mac_haddr_data;
  host_hwrite_data    =  mac_hwrite_data;
  host_hsize_data     =  mac_hsize_data;
  host_hburst_data    =  mac_hburst_data;
  host_hprot_data     =  mac_hprot_data;
  host_hwdata_data    =  mac_hwdata_data;

  mac_hready          =  (host_hready & ~(|nxt_is_update));

  if (mac_push_hready)
  begin
    mac_hresp         =  2'b00;
    if (mac_in_header)
      mac_hrdata_pad    = {129{1'b0}};  // Just set the descriptor read response to 0 if we are dropping it.
    else if (dma_bus_width[1] & mac_haddr_bit3_dph)
      mac_hrdata_pad    =  {33'd0,next_buffer_start_add[31:2],2'b00,64'd0};
    else
      mac_hrdata_pad    =  {{97{1'b0}},
                            next_buffer_start_add[31:2],2'b00};
  end
  else
  begin
    mac_hresp         =  host_hresp;
    mac_hrdata_pad    =  {{129-p_edma_bus_width{1'b0}},host_hrdata};
  end
end

assign mac_hrdata = mac_hrdata_pad[p_edma_bus_width-1:0];

assign update_databuf_add = first_frame_int_pad[ahb_queue_ptr_rx];

always@(posedge hclk or negedge n_hreset)
begin
  if (~n_hreset)
  begin
    mac_push_hready <= 1'b0;
    mac_haddr_bit3_dph <= 1'b0;
  end
  else
  begin
    if (~enable_rx_hclk)
    begin
      mac_push_hready  <= 1'b0;
      mac_haddr_bit3_dph <= 1'b0;
    end
    else
    begin
      mac_haddr_bit3_dph <= mac_haddr_descr[3];
      if (host_hready)
        mac_push_hready  <= ((mac_htrans_descr[1] & (block_descr_rd[ahb_queue_ptr_rx] | block_descr_wr[ahb_queue_ptr_rx])) |           // Descriptor accesses are blocked
                             (mac_htrans_data[1] & block_hdr_wr[ahb_queue_ptr_rx]) |                                 // Headers are blocked
                             (mac_htrans_data[1] & block_writes_aph));                              // Pad and CRC are blocked
    end
  end
end

always@(posedge hclk or negedge n_hreset)
begin
  if (~n_hreset)
    mac_htrans_data_dph <= 1'b0;
  else
  begin
    if (~enable_rx_hclk)
      mac_htrans_data_dph  <= 1'b0;
    else if (mac_hready & mac_htrans_data[1])
      mac_htrans_data_dph  <= 1'b1;
    else if (mac_hready)
      mac_htrans_data_dph  <= 1'b0;
  end
end

  assign mac_htrans_data_dph_pulse = mac_htrans_data_dph & host_hready;

  // endian_swap not supported
  assign mac_hwdata_data_end = mac_hwdata_data;


// based on mac descriptor read, and in header
always @(posedge hclk or negedge n_hreset)
begin
  if (~n_hreset)
    start_of_new_mac_frame <= 1'b0;
  else if (~enable_rx_hclk)
    start_of_new_mac_frame <= 1'b0;
  else
    start_of_new_mac_frame <= (mac_htrans_descr[1] & ~mac_hwrite_descr & mac_in_header & mac_hready);
end

assign first_frame = first_frame_int_pad[ahb_queue_ptr_rx];


//------------------------------------------------------------------------------
// Instance the RSC Updater module
//------------------------------------------------------------------------------
//
edma_pbuf_rx_rsc_updater  #(
                            .p_edma_addr_width(p_edma_addr_width),
                            .p_edma_bus_width(p_edma_bus_width),
                            .p_edma_queues(p_edma_queues)
                            ) i_edma_pbuf_rx_rsc_updater (

    .hclk                      (hclk),
    .n_hreset                  (n_hreset),

    .enable_rx                 (enable_rx_hclk),
    .start_of_new_mac_frame    (start_of_new_mac_frame),   // MAC descriptor read on 1st buffer of frame
    .end_of_payload            (mac_hbusreq_descr_wr),   // MAC descriptor read on 1st buffer of frame
    .dma_bus_width             (dma_bus_width),

    .add_in_vld                (mac_htrans_data[1] & mac_hready),
    .data_in_vld               (mac_htrans_data_dph_pulse),
    .data_in                   (mac_hwdata_data_end),
    .host_add_in               (mac_htrans_data[1] ? mac_haddr_data : mac_haddr_descr),
    .in_header                 (mac_in_header),
    .first_frame               (first_frame),
    .l3_offset                 (l3_offset),
    .l4_offset                 (l4_offset),
    .pld_offset                (pld_offset),
    .queue_ptr_rx              (ahb_queue_ptr_rx),
    .queue_ptr_rx_upd          (queue_ptr_rx_mod),

    .write_to_base_descr       (write_to_base_descr),
    .saved_descr_hdr_wr        (saved_descr_hdr_wr_pad[queue_ptr_rx_mod]),
    .saved_descr_pld_wr        (saved_descr_pld_wr_pad[queue_ptr_rx_mod]),
    .rsc_coalescing_ended_c    (rsc_coalescing_ended_c),
    .rsc_coalescing_ended      (rsc_coalescing_ended),
    .allowed_to_coalesce       (allowed_to_coalesce),
    .need_update_cycle         (need_update_cycle),

    .rsc_update_valid          (rsc_update_valid),
    .rsc_update_ready          (rsc_update_ready),
    .rsc_update_descr          (rsc_update_descr),
    .rsc_update_last           (rsc_update_last),
    .rsc_update_addr           (rsc_update_addr),
    .rsc_update_data           (rsc_update_data),
    .rsc_update_ben            (rsc_update_ben),
    .hdr_update_cmp            (hdr_update_cmp),
    .descr_update_cmp          (descr_update_cmp),

    .block_writes_aph          (block_writes_aph),
    .next_buffer_start_add     (next_buffer_start_add),
    .mac_buffer_offset         (mac_buffer_offset),
    .num_bytes_coalesced       (num_bytes_coalesced),
    .full_pkt_size             (full_pkt_size),
    .rsc_write_strobe          (rsc_write_strobe)
  );

//------------------------------------------------------------------------------
// Descriptor reads coming from the MAC indicate a quiet time on both the AHB data channel, and the toplevel AXI data writes.
// the AXI cannot be doing any data writes at this time because it doesnt know the packet length and cannot issue AW requests
// until it knows that.
// When we are coalescing, it is possible the same AXI location will be written to twice - once for the bytes at the end of the
// first inbound frame, and 2nd to ensure the start of the next frame can be packed directly into the remaining space.
// To do that, we need to sync the address generated by the AXI block with the address issued by the AHB DMA - the best way to
// to do this is during the guaranteed quiet time identified by the MAC descriptor read.
//------------------------------------------------------------------------------

assign host_update_buf_add =  mac_htrans_descr[1] & ~mac_hwrite_descr &
                              ~(first_frame | rsc_stopping | ~rsc_en_pad[ahb_queue_ptr_rx]);

//------------------------------------------------------------------------------
// last_data_to_buff_mac is a pass through signal from the underlying AHB DMA(dph timed) that is used by the AXI DMA to identify
// the last data write to a buffer.  This is used as a precurser to initating a descriptor write in the AXI block.
// Essentially it is passed into the w2b FIFO so that the descriptor write itself is not issued until the B resp has
// returned representing the last data write for the packet data is completed. This is crucial in order to avoid system
// race conditions - we dont want software thinking a descriptor write has completed before the actual packet data has
// been officially written.
// The RSC can drop some data from the AHB DMA, eg strip CRC and padding from payload, so we need to update this signal
// with the correct indication of last data to the buffer.
// Also, when RSC is active this signal is used in the AXI block to delay the issuance of descriptor writes AND RSC updates.
// Therefore, we need to ensure it is set on the last data whenever we want to issue an update or a normal descriptor write
//  - descriptor writes - end of first header, and end of first payload
//  - updates - end of all coalesced payloads, apart from first
//------------------------------------------------------------------------------
assign last_data_to_buff_rsc = (last_data_to_buff_mac | block_writes_aph);


// Need a signal to indicate when we expect the update cycle to begin.
always@(posedge hclk or negedge n_hreset)
begin
  if (~n_hreset)
    need_update_cycle <= 1'b0;
  else if (~enable_rx_hclk)
    need_update_cycle <= 1'b0;
  else
    need_update_cycle <= fsm_descr_rd_nxt_state_pad[queue_ptr_rx_mod] == S1_HDR_UPDATE &
                         fsm_descr_rd_cur_state_pad[queue_ptr_rx_mod] != S1_HDR_UPDATE;
end

//------------------------------------------------------------------------------
// Need a signal to pass to the AXI block to indicate that coalescing has completed and it should clear some flops.  This is
// usually acheived by sending a descriptor write request, but since these have been dropped due to RSC, we need to send
// a new signal
//------------------------------------------------------------------------------
assign rsc_coalescing_ended_c = |rsc_coalescing_ended_int;
always@(posedge hclk or negedge n_hreset)
begin
  if (~n_hreset)
    rsc_coalescing_ended <= 1'b0;
  else if (~enable_rx_hclk)
    rsc_coalescing_ended <= 1'b0;
  else
    rsc_coalescing_ended <= rsc_coalescing_ended_c;
end


assign allowed_to_coalesce = (fsm_descr_rd_cur_state_pad[ahb_queue_ptr_rx]  != S1_IDLE);

// See inside updater module for comment
always @(*)
begin
  if  (allowed_to_coalesce)
    full_pkt_size_out  = full_pkt_size;

  else
    // initialize with the value sent in from the existing DMA. This will be updated when the total_length becomes available
    full_pkt_size_out  = full_pkt_size_in;
end

endmodule

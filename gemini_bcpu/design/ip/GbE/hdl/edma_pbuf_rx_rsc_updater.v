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
//   Filename:           edma_pbuf_rx_rsc_updater.v
//   Module Name:        edma_pbuf_rx_rsc_updater
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

module edma_pbuf_rx_rsc_updater
  #(parameter p_edma_queues       = 0,
    parameter p_edma_addr_width   = 0,
    parameter p_edma_bus_width    = 0)
  (

  // Clocks and Reset
  input                               hclk,
  input                               n_hreset,

  // Control
  input                               enable_rx,               // soft reset
  input                               start_of_new_mac_frame,  // clears all flops associated with decoding so it can restart decoding incoming frame
  input                               end_of_payload,
  input  [1:0]                        dma_bus_width,
  input  [4:0]                        l3_offset,              // IP offset in bytes
  input  [11:0]                       l4_offset,              // UDP/TCP offset in bytes
  input  [11:0]                       pld_offset,             // payload offset
  input  [3:0]                        queue_ptr_rx,           // Queue
  input  [3:0]                        queue_ptr_rx_upd,       // Queue for update

  // Packet data in
  input                               add_in_vld,
  input                               data_in_vld,
  input   [127:0]                     data_in,
  input                               in_header,
  input   [p_edma_addr_width-1:0]      host_add_in,
  input                               first_frame,
  input                               write_to_base_descr,
  input   [6:0]                       saved_descr_pld_wr,
  input   [6:0]                       saved_descr_hdr_wr,
  input                               rsc_coalescing_ended_c,
  input                               rsc_coalescing_ended,
  input                               allowed_to_coalesce,
  input                               need_update_cycle,

  output  reg                         rsc_update_valid,
  input                               rsc_update_ready,
  output  reg                         rsc_update_descr,
  output  reg                         rsc_update_last,
  output wire [p_edma_addr_width-1:0] rsc_update_addr,
  output  reg [31:0]                  rsc_update_data,
  output  reg [15:0]                  rsc_update_ben,
  output  reg                         hdr_update_cmp,
  output                              descr_update_cmp,

  output                              block_writes_aph,
  output wire [p_edma_addr_width-1:0]  next_buffer_start_add,
  output      [3:0]                   mac_buffer_offset,
  output      [15:0]                  num_bytes_coalesced,
  output wire [13:0]                  full_pkt_size,
  output  reg [15:0]                  rsc_write_strobe

);

  localparam include_checksum_update = 1;

  // Descriptor update statemachine
  localparam P_DSR_LEN         = 3'b000;
  localparam P_IPCSUM          = 3'b001;
  localparam P_TCPCSUM         = 3'b010;
  localparam P_ACK1            = 3'b011;
  localparam P_ACK2            = 3'b100;
  localparam P_ACK3            = 3'b111;
  localparam P_DSR_HDR_UPDATE  = 3'b101;
  localparam P_DSR_PLD_UPDATE  = 3'b110;


  reg   [13:0]                      running_byte_count_aph;
  reg   [15:0]                      running_byte_count_dph;
  reg   [15:0]                      running_byte_count_pld;
  wire  [15:0]                      num_bytes_in_stripe;
  wire  [5:0]                       ipv4_tot_len_offset;
  wire  [5:0]                       l3_offset_poff;
  wire  [5:0]                       ipv4_csum_offset;
  wire  [12:0]                      tcp_acknum_offset_lo;
  wire  [12:0]                      tcp_acknum_offset_hi;
  wire  [12:0]                      tcp_ackbit_offset;
  wire  [12:0]                      tcp_csum_offset;
  reg   [p_edma_addr_width-1:0]     host_add_in_dph;
  reg                               block_writes_aph_d1;
  wire                              block_writes_aph_pulse;
  wire   [15:0]                     payload_length_poff;
  wire   [15:0]                     payload_length;
  reg                               first_dph_of_frame;
  wire   [10:0]                     ini_hdr_size;
  wire   [13:0]                     pld_size;
  wire   [14:0]                     total_frame_words;
  wire   [p_edma_addr_width-1:0]    last_host_add_in;
  wire   [2:0]                      omit_checksum_state;
  wire   [15:0]                     extr_ipv4_total_length;
  wire                              extr_ipv4_total_length_v;
  wire   [15:0]                     running_ipv4_tot_len_rev;
  wire   [16:0]                     running_coalesced_len;
  wire   [15:0]                     extr_ipv4_csum;
  wire                              extr_ipv4_csum_v;
  wire   [15:0]                     extr_tcp_csum;
  wire                              extr_tcp_csum_v;
  wire   [31:0]                     extr_tcp_acknum;
  wire   [7:0]                      extr_tcp_ackbit_b;
  wire                              extr_tcp_acknum_lo_v;
  wire                              extr_tcp_ackbit_v;
  wire   [15:0]                     init_tcp_csum_sub;
  wire   [16:0]                     updated_tcp_csum_sub;
  wire   [16:0]                     updated_ipv4_csum_sub;
  wire   [p_edma_addr_width:0]      update_descr_buflen_add;
  reg                               need_descr_wr_update;
  reg                               update_wait_ready;
  reg    [2:0]                      update_fsm_nxt;
  reg    [2:0]                      update_fsm;
  wire                              extr_ipv4_total_length_vc;

  // Multi Queue Signals
  reg   [p_edma_addr_width-1:0]      base_descr_hdr_host_add   [p_edma_queues-1:0];
  wire  [p_edma_addr_width-1:0]      base_descr_hdr_host_add_pad   [15:0];
  reg   [p_edma_addr_width-1:0]      base_descr_pld_host_add   [p_edma_queues-1:0];
  wire  [p_edma_addr_width-1:0]      base_descr_pld_host_add_pad   [15:0];
  reg   [p_edma_addr_width-1:0]      ipv4_totlen_hostadd       [p_edma_queues-1:0];
  wire  [p_edma_addr_width-1:0]      ipv4_totlen_hostadd_pad   [15:0];
  reg   [p_edma_addr_width-1:0]      ipv4_csum_hostadd         [p_edma_queues-1:0];
  wire  [p_edma_addr_width-1:0]      ipv4_csum_hostadd_pad     [15:0];
  reg   [p_edma_addr_width-1:0]      tcp_csum_hostadd          [p_edma_queues-1:0];
  wire  [p_edma_addr_width-1:0]      tcp_csum_hostadd_pad      [15:0];
  reg   [p_edma_addr_width-1:0]      tcp_acknum_hostadd        [p_edma_queues-1:0];
  wire  [p_edma_addr_width-1:0]      tcp_acknum_hostadd_pad    [15:0];
  reg   [p_edma_addr_width-1:0]      next_buffer_start_add_int [p_edma_queues-1:0];
  wire  [p_edma_addr_width-1:0]      next_buffer_start_add_int_pad [15:0];
  reg   [4:0]                       orig_l3_offset            [p_edma_queues-1:0];
  wire  [4:0]                       orig_l3_offset_pad        [15:0];
  reg   [5:0]                       orig_ipv4_tot_len_offset  [p_edma_queues-1:0];
  wire  [5:0]                       orig_ipv4_tot_len_offset_pad   [15:0];
  reg   [5:0]                       orig_ipv4_csum_offset     [p_edma_queues-1:0];
  wire  [5:0]                       orig_ipv4_csum_offset_pad [15:0];
  reg   [12:0]                      orig_tcp_csum_offset      [p_edma_queues-1:0];
  wire  [12:0]                      orig_tcp_csum_offset_pad  [15:0];
  reg   [12:0]                      orig_tcp_acknum_offset    [p_edma_queues-1:0];
  wire  [12:0]                      orig_tcp_acknum_offset_pad    [15:0];
  reg   [15:0]                      running_ipv4_tot_len      [p_edma_queues-1:0];
  wire  [15:0]                      running_ipv4_tot_len_pad  [15:0];
  reg   [15:0]                      running_pld_tot           [p_edma_queues-1:0];
  wire  [15:0]                      running_pld_tot_pad       [15:0];
  reg   [15:0]                      updated_ipv4_csum         [p_edma_queues-1:0];
  wire  [15:0]                      updated_ipv4_csum_pad     [15:0];
  reg   [15:0]                      updated_tcp_csum          [p_edma_queues-1:0];
  wire  [15:0]                      updated_tcp_csum_pad      [15:0];
  reg   [13:0]                      full_pkt_size_int         [p_edma_queues-1:0];
  wire  [13:0]                      full_pkt_size_int_pad     [15:0];
  reg   [3:0]                       mac_buff_offset_pldonly   [p_edma_queues-1:0];
  wire  [3:0]                       mac_buff_offset_pldonly_pad [15:0];
  reg                               tcp_ackbit                [p_edma_queues-1:0];
  wire                              tcp_ackbit_pad            [15:0];
  reg   [31:0]                      tcp_acknum                [p_edma_queues-1:0];
  wire  [31:0]                      tcp_acknum_pad            [15:0];
  reg   [p_edma_addr_width:0]       rsc_update_addr_c;

//------------------------------------------------------------------------------
// This module will be split into two sections; the first being that for multi
// queues where the logic requires to be replicated on a per queue and the second
// section where we don't need the logic to be replicated.
//------------------------------------------------------------------------------
//
generate
  genvar gv_i;
  for (gv_i=0; gv_i<p_edma_queues; gv_i=gv_i+1) begin : gen_rsc_queues_update

    //------------------------------------------------------------------------------
    // When coalescing is finished, we need to do a descriptor write update.
    // When the first frame's payload was written out to AXI, we did an initial
    // descriptor write, and intercepted the data to ensure the used bit was NOT
    // set. This was done because most of the data in that descriptor write was correct
    // and we didnt want to buffer it through the RSC module.
    // The data that was not correct however was
    //    1. The buffer length (it needs to reflect the coalesced amount in bytes)
    //    2. The used bit (was written with a '0', needs to be '1'.
    // 1) is always in word 1 of the descriptor.
    // 2) is always in word 0 of the descriptor.
    // In order to do the update, we need to know the host address that the original
    // descriptor write to the first frame's payload was issued to
    // Currently we do this by buffering the address when it was first sent through from
    // the MAC.
    // It is possible that we could derive this from the state of mac_haddr_descr, but
    // further analysis of how that bus changes is needed.  This would save flops however.
    //
    //------------------------------------------------------------------------------
    //
    always @(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        base_descr_pld_host_add[gv_i] <= {p_edma_addr_width{1'b0}};
      else if (~enable_rx)
        base_descr_pld_host_add[gv_i] <= {p_edma_addr_width{1'b0}};
      else
      begin
        if (write_to_base_descr & ~in_header & first_frame & (gv_i[3:0] == queue_ptr_rx)) // in_header goes low before descr wr
          base_descr_pld_host_add[gv_i] <= host_add_in;
      end
    end

    always @(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        base_descr_hdr_host_add[gv_i] <= {p_edma_addr_width{1'b0}};
      else if (~enable_rx)
        base_descr_hdr_host_add[gv_i] <= {p_edma_addr_width{1'b0}};
      else
      begin
        if (write_to_base_descr & in_header & first_frame & (gv_i[3:0] == queue_ptr_rx)) // in_header goes low before descr wr
          base_descr_hdr_host_add[gv_i] <= host_add_in;
      end
    end


    wire [16:0] running_ipv4_tot_len_nxt;
    assign running_ipv4_tot_len_nxt = running_ipv4_tot_len[gv_i] + payload_length;
    wire [16:0] running_pld_tot_nxt;
    assign running_pld_tot_nxt = running_pld_tot[gv_i] + payload_length;
    //------------------------------------------------------------------------------
    // Sample the host addresses that each of the extracted fields are being written to.
    // these will be needed so we know where to update the 4 fields.
    //------------------------------------------------------------------------------
    //
    always @(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
      begin
        ipv4_totlen_hostadd[gv_i]      <= {p_edma_addr_width-1{1'b0}};
        ipv4_csum_hostadd[gv_i]        <= {p_edma_addr_width-1{1'b0}};
        tcp_csum_hostadd[gv_i]         <= {p_edma_addr_width-1{1'b0}};
        tcp_acknum_hostadd[gv_i]       <= {p_edma_addr_width-1{1'b0}};
        orig_l3_offset[gv_i]           <= 5'h00;
        orig_ipv4_tot_len_offset[gv_i] <= 6'h00;
        orig_ipv4_csum_offset[gv_i]    <= 6'h00;
        orig_tcp_csum_offset[gv_i]     <= 13'h0000;
        orig_tcp_acknum_offset[gv_i]   <= 13'h0000;
        running_ipv4_tot_len[gv_i]     <= 16'h0000;
        running_pld_tot[gv_i]          <= 16'h0000;
        updated_ipv4_csum[gv_i]        <= 16'h0000;
        updated_tcp_csum[gv_i]         <= 16'h0000;
        tcp_acknum[gv_i]               <= 32'h00000000;
      end
      else if (~enable_rx)
      begin
        ipv4_totlen_hostadd[gv_i]      <= {p_edma_addr_width-1{1'b0}};
        ipv4_csum_hostadd[gv_i]        <= {p_edma_addr_width-1{1'b0}};
        tcp_csum_hostadd[gv_i]         <= {p_edma_addr_width-1{1'b0}};
        tcp_acknum_hostadd[gv_i]       <= {p_edma_addr_width-1{1'b0}};
        orig_l3_offset[gv_i]           <= 5'h00;
        orig_ipv4_tot_len_offset[gv_i] <= 6'h00;
        orig_ipv4_csum_offset[gv_i]    <= 6'h00;
        orig_tcp_csum_offset[gv_i]     <= 13'h0000;
        orig_tcp_acknum_offset[gv_i]   <= 13'h0000;
        running_ipv4_tot_len[gv_i]     <= 16'h0000;
        running_pld_tot[gv_i]          <= 16'h0000;
        updated_ipv4_csum[gv_i]        <= 16'h0000;
        updated_tcp_csum [gv_i]        <= 16'h0000;
        tcp_acknum[gv_i]               <= 32'h00000000;
      end
      else
      begin
        if (gv_i[3:0] == queue_ptr_rx)
        begin
          if (extr_ipv4_total_length_vc & first_frame)
          begin
            orig_ipv4_tot_len_offset[gv_i]  <= ipv4_tot_len_offset;
            orig_l3_offset[gv_i]            <= l3_offset;
            ipv4_totlen_hostadd[gv_i]       <= host_add_in_dph;
            running_ipv4_tot_len[gv_i]      <= {extr_ipv4_total_length[7:0],extr_ipv4_total_length[15:8]};
            running_pld_tot[gv_i]           <= payload_length;
          end
          else if (extr_ipv4_total_length_vc)
          begin
            running_ipv4_tot_len[gv_i]      <= running_ipv4_tot_len_nxt[15:0];
            running_pld_tot[gv_i]           <= running_pld_tot_nxt[15:0];
          end

          if (extr_ipv4_csum_v & first_frame)
          begin
            ipv4_csum_hostadd[gv_i]         <= host_add_in_dph;
            orig_ipv4_csum_offset[gv_i]     <= ipv4_csum_offset;
            updated_ipv4_csum[gv_i]         <= extr_ipv4_csum;
          end
          else if (extr_ipv4_total_length_vc & ~first_frame)
            updated_ipv4_csum[gv_i]         <= ~{updated_ipv4_csum_sub[7:0],updated_ipv4_csum_sub[15:8]};

          // The 32-bit TCP ACK number and the total coalesced payload length changes from 1 frame to the next
          // so we need to record the changes. Best thing to do is to record the original extracted checksum
          // value, minus the ACK field
          if (extr_tcp_csum_v & first_frame)
          begin
            tcp_csum_hostadd [gv_i]         <= host_add_in_dph;
            orig_tcp_csum_offset[gv_i]      <= tcp_csum_offset;
            updated_tcp_csum[gv_i]          <= {init_tcp_csum_sub[7:0],init_tcp_csum_sub[15:8]};
          end
          else if (extr_tcp_csum_v & ~first_frame)
            updated_tcp_csum[gv_i]          <= {updated_tcp_csum_sub[7:0],updated_tcp_csum_sub[15:8]};

          if (extr_tcp_acknum_lo_v & first_frame)
          begin
            tcp_acknum_hostadd[gv_i]        <= host_add_in_dph;
            orig_tcp_acknum_offset[gv_i]    <= tcp_acknum_offset_lo;
          end

          if (extr_tcp_ackbit_b[4])
            tcp_acknum[gv_i] <= extr_tcp_acknum;
        end
      end
    end
    assign running_ipv4_tot_len_pad[gv_i] = running_ipv4_tot_len[gv_i];
    assign orig_l3_offset_pad[gv_i] = orig_l3_offset[gv_i];
    assign running_pld_tot_pad[gv_i] = running_pld_tot[gv_i];
    assign updated_ipv4_csum_pad[gv_i] = updated_ipv4_csum[gv_i];
    assign updated_tcp_csum_pad[gv_i] = updated_tcp_csum[gv_i];
    assign tcp_acknum_pad[gv_i] = tcp_acknum[gv_i];
    assign base_descr_pld_host_add_pad[gv_i] = base_descr_pld_host_add[gv_i];
    assign base_descr_hdr_host_add_pad[gv_i] = base_descr_hdr_host_add[gv_i];
    assign ipv4_totlen_hostadd_pad[gv_i] = ipv4_totlen_hostadd[gv_i];
    assign ipv4_csum_hostadd_pad[gv_i] = ipv4_csum_hostadd[gv_i];
    assign tcp_csum_hostadd_pad[gv_i] = tcp_csum_hostadd[gv_i];
    assign tcp_acknum_hostadd_pad[gv_i] = tcp_acknum_hostadd[gv_i];
    assign orig_tcp_csum_offset_pad[gv_i] = orig_tcp_csum_offset[gv_i];
    assign orig_tcp_acknum_offset_pad[gv_i] = orig_tcp_acknum_offset[gv_i];
    assign orig_ipv4_csum_offset_pad[gv_i] = orig_ipv4_csum_offset[gv_i];
    assign orig_ipv4_tot_len_offset_pad[gv_i] = orig_ipv4_tot_len_offset[gv_i];
  end // gen_rsc_queues

  for (gv_i=p_edma_queues; gv_i<16; gv_i=gv_i+1) begin : gen_rsc_queues_update_pad
    assign running_ipv4_tot_len_pad[gv_i] = 16'h0000;
    assign orig_l3_offset_pad[gv_i] = 5'h00;
    assign running_pld_tot_pad[gv_i] = 16'h0000;
    assign updated_ipv4_csum_pad[gv_i] = 16'h0000;
    assign updated_tcp_csum_pad[gv_i] = 16'h0000;
    assign tcp_acknum_pad[gv_i] = 32'h00000000;
    assign base_descr_pld_host_add_pad[gv_i] = {p_edma_addr_width{1'b0}};
    assign base_descr_hdr_host_add_pad[gv_i] = {p_edma_addr_width{1'b0}};
    assign ipv4_totlen_hostadd_pad[gv_i] = {p_edma_addr_width{1'b0}};
    assign ipv4_csum_hostadd_pad[gv_i] = {p_edma_addr_width{1'b0}};
    assign tcp_csum_hostadd_pad[gv_i] = {p_edma_addr_width{1'b0}};
    assign tcp_acknum_hostadd_pad[gv_i] = {p_edma_addr_width{1'b0}};
    assign orig_tcp_csum_offset_pad[gv_i] = 13'd0;
    assign orig_tcp_acknum_offset_pad[gv_i] = 13'd0;
    assign orig_ipv4_csum_offset_pad[gv_i] = 6'd0;
    assign orig_ipv4_tot_len_offset_pad[gv_i] = 6'd0;
  end
endgenerate

generate
  genvar gv1_i;
  for (gv1_i=0; gv1_i<p_edma_queues; gv1_i=gv1_i+1) begin : gen_full_pkt_size_int

  //------------------------------------------------------------------------------
  // The DMA generates a signal called "full pkt size" which is used by the AXI block
  // to understand how to efficiently create aw requests in advance of the underlying
  // DMA issuing the AHB requests.
  // It is possible that this RSC block will drop some data (padding/crc) based on the
  // extraction of the IP total length field. Since we are dropping some data from all
  // or some frames from AHB, we must regenerate "full_pkt_size" to the AXI
  // with the reduced amount. It needs to reflect the size of the cutdown packet, in words.
  // This RSC block coalesces frames, so the upstream AXI block will just see the big
  // coalesced frame. To handle this, we will set full_pkt_size to the cut-down first
  // frame size, and then slowly increase as we coalese frames. This will have the effect
  // of limiting the AXI from generating new requests until we actually know what the
  // increased value should be. For the initial frame coming in, we will write out the
  // header and the payload separate;y, so the size of the frame is the number of words
  // both of these components will consume. For subsequent coalesced frames, the increase
  // in size will be just the the payload size.
  //------------------------------------------------------------------------------
  //
    wire [14:0] full_pkt_size_init_nxt;
    assign full_pkt_size_init_nxt = ini_hdr_size + pld_size; // initial frame size
    wire [14:0] full_pkt_size_add_nxt;
    assign full_pkt_size_add_nxt = full_pkt_size_int[gv1_i] + pld_size;// additional frame size
    always @(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        full_pkt_size_int[gv1_i] <= 14'h3fff;
      else if (~enable_rx)
        full_pkt_size_int[gv1_i] <= 14'h3fff;
      else if (extr_ipv4_total_length_vc & first_frame & (gv1_i[3:0] == queue_ptr_rx))
        full_pkt_size_int[gv1_i] <= full_pkt_size_init_nxt[13:0];
      else if (extr_ipv4_total_length_vc & (gv1_i[3:0] == queue_ptr_rx))
        full_pkt_size_int[gv1_i] <= full_pkt_size_add_nxt[13:0];
      else if (rsc_coalescing_ended & (gv1_i[3:0] == queue_ptr_rx_upd))
        full_pkt_size_int[gv1_i] <= 14'h3fff;
    end

  //------------------------------------------------------------------------------
  // If the ACK bit is set on any of the received frames during coalescing, we need to
  // track those here and then update the final coalesced header with the ACK bit set
    always @(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        tcp_ackbit[gv1_i] <= 1'b0;
      else if (~enable_rx)
        tcp_ackbit[gv1_i] <= 1'b0;
      else if (extr_tcp_ackbit_v & first_frame & (gv1_i[3:0] == queue_ptr_rx))
        tcp_ackbit[gv1_i] <= extr_tcp_ackbit_b[4];
      else if (extr_tcp_ackbit_v & (gv1_i[3:0] == queue_ptr_rx))
        tcp_ackbit[gv1_i] <= tcp_ackbit[gv1_i] | extr_tcp_ackbit_b[4];
//      else if (rsc_coalescing_ended & (gv1_i[3:0] == queue_ptr_rx_upd))
//        tcp_ackbit[gv1_i] <= 1'b0;
    end


    assign full_pkt_size_int_pad[gv1_i] = full_pkt_size_int[gv1_i];
    assign tcp_ackbit_pad[gv1_i] = tcp_ackbit[gv1_i];
  end // gen_full_pkt_size_int

  for (gv1_i=p_edma_queues; gv1_i<16; gv1_i=gv1_i+1) begin : gen_full_pkt_size_int_pad
    assign full_pkt_size_int_pad[gv1_i] = 14'd0;
    assign tcp_ackbit_pad[gv1_i] = 1'b0;
  end

endgenerate


generate
  genvar gv2_i;
  for (gv2_i=0; gv2_i<p_edma_queues; gv2_i=gv2_i+1) begin : gen_buffer_start_add
  //------------------------------------------------------------------------------
  // When this block identifies the end of the valid TCP payload, we block further
  // writes (including pad and crc).
  // To do this, we need to sample the address that is currently being written, in
  // order to restart writes on the same AXI address on the next coalesced TCP payload,
  // we need to use this address to make sure the writes are completey packed.
  // To do this, we can feed this address both upstream and downstream to keep both
  // the AHB and AXI blocks aligned
  // As a complication, if an entire stripe was not filled up when we decided to stop
  // writing we will need to overwrite the loaction in memory and ensure the next frame
  // has an appropriate offset to ensure it starts from the correct byte address.
  // This is to pack the stripe properly.
  // We can reuse the buffer_offset functionality in the underlying AHB to do this
  //
  //------------------------------------------------------------------------------
  //
    always @(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
      begin
        mac_buff_offset_pldonly[gv2_i] <= 4'h0;
        next_buffer_start_add_int[gv2_i] <= {p_edma_addr_width-1{1'b0}};
      end
      else if (~enable_rx)
      begin
        mac_buff_offset_pldonly[gv2_i] <= 4'h0;
        next_buffer_start_add_int[gv2_i] <= {p_edma_addr_width-1{1'b0}};
      end
      else
      begin
        if (rsc_coalescing_ended & gv2_i[3:0] == queue_ptr_rx_upd)
          mac_buff_offset_pldonly[gv2_i] <= 4'h0;
        else if (block_writes_aph_pulse & gv2_i[3:0] == queue_ptr_rx & data_in_vld)
          // setup before the next coalesced frame starts
          mac_buff_offset_pldonly[gv2_i] <= payload_length_poff[3:0] & {dma_bus_width[1],|dma_bus_width[1:0],2'b11};

        if (block_writes_aph_pulse & gv2_i[3:0] == queue_ptr_rx & data_in_vld)
        begin
          if (dma_bus_width[1] & (|payload_length_poff[3:0]))
            next_buffer_start_add_int[gv2_i] <= {last_host_add_in[p_edma_addr_width-1:4],payload_length_poff[3:2],2'b00};
          else if (dma_bus_width[0] & (|payload_length_poff[2:0]))
            next_buffer_start_add_int[gv2_i] <= {last_host_add_in[p_edma_addr_width-1:3],payload_length_poff[2],2'b00};
          else if (|payload_length_poff[1:0])
            next_buffer_start_add_int[gv2_i] <= {last_host_add_in[p_edma_addr_width-1:2],2'b00};
          else
            next_buffer_start_add_int[gv2_i] <= {host_add_in[p_edma_addr_width-1:2],2'b00};
        end
      end
    end

    assign next_buffer_start_add_int_pad[gv2_i] = next_buffer_start_add_int[gv2_i];
    assign mac_buff_offset_pldonly_pad[gv2_i] = mac_buff_offset_pldonly[gv2_i];
  end // gen_buffer_start_add

  for (gv2_i=p_edma_queues; gv2_i<16; gv2_i=gv2_i+1) begin : gen_buffer_start_add_pad
    assign next_buffer_start_add_int_pad[gv2_i] = {p_edma_addr_width-1{1'b0}};
    assign mac_buff_offset_pldonly_pad[gv2_i] = {p_edma_addr_width-1{1'b0}};
  end
endgenerate




//------------------------------------------------------------------------------
// Non Replicated logic
//------------------------------------------------------------------------------
//
  assign num_bytes_in_stripe = dma_bus_width == 2'b00 ? 16'd4 :
                               dma_bus_width == 2'b01 ? 16'd8 :
                                                        16'd16;

  assign full_pkt_size       = full_pkt_size_int_pad[queue_ptr_rx];

  assign next_buffer_start_add = next_buffer_start_add_int_pad[queue_ptr_rx];

  assign ini_hdr_size  =  dma_bus_width[1] ? ({3'h0,pld_offset[11:4]} + |pld_offset[3:0]) :
                          dma_bus_width[0] ? ({2'h0,pld_offset[11:3]} + |pld_offset[2:0]) :
                                             ({1'h0,pld_offset[11:2]} + |pld_offset[1:0]);

  assign pld_size      =  dma_bus_width[1] ? ({4'h0,payload_length_poff[13:4]} + |payload_length_poff[3:0]) :
                          dma_bus_width[0] ? ({3'h0,payload_length_poff[13:3]} + |payload_length_poff[2:0]) :
                                             ({2'h0,payload_length_poff[13:2]} + |payload_length_poff[1:0]);

  assign total_frame_words = ini_hdr_size + pld_size ;

//------------------------------------------------------------------------------
// Running byte counts are basically counters that increment by the
// number of bytes in a stripe (either 4,8 or 16 based on dma bus width).
// We need an AHB address phase timed version and an AHB data phased
// timed, both running_byte_count_aph and running_byte_count_dph will
// count from start of frame.
// running_byte_count_pld only counts payload and is reqd for calc TCP
// checksum over coalesced payload.
// Note could probably be more clever here wrt area and use
// one counter for all 3 uses
//------------------------------------------------------------------------------
//
  wire [14:0] running_byte_count_aph_p1;
  assign      running_byte_count_aph_p1 = running_byte_count_aph + 14'h0001;
  wire [16:0] running_byte_count_dph_nxt;
  assign      running_byte_count_dph_nxt = running_byte_count_dph + num_bytes_in_stripe;
  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      running_byte_count_aph  <= 14'h0000;
    else if (~enable_rx | start_of_new_mac_frame)
      running_byte_count_aph  <= 14'h0000;
    else if (add_in_vld)
      running_byte_count_aph  <= running_byte_count_aph_p1[13:0];
  end

  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      running_byte_count_dph  <= 16'h0000;
    else if (~enable_rx | start_of_new_mac_frame)
      running_byte_count_dph  <= 16'h0000;
    else if (data_in_vld)
      running_byte_count_dph  <= running_byte_count_dph_nxt[15:0];
  end

  generate if (include_checksum_update == 1) begin : gen_checksum1
  wire [16:0] running_byte_count_pld_nxt;
  assign running_byte_count_pld_nxt = running_byte_count_pld + num_bytes_in_stripe;
  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      running_byte_count_pld  <= 16'h0000;
    else if (~enable_rx | start_of_new_mac_frame | in_header)
      running_byte_count_pld  <= 16'h0000;
    else if (add_in_vld)
      running_byte_count_pld  <= running_byte_count_pld_nxt[15:0];
  end

  end
  endgenerate

//------------------------------------------------------------------------------
// Extract all the relevant fields from the header
// We want to extract
// - IPv4 Total Length
// - Header Checksum
// - TCP Checksum
// - Segment Number
//------------------------------------------------------------------------------
//
  assign  l3_offset_poff              = l3_offset + mac_buff_offset_pldonly_pad[queue_ptr_rx][3:0];
  assign  ipv4_tot_len_offset         = l3_offset + 5'd2;
  assign  ipv4_csum_offset            = l3_offset + 5'd10;
  assign  tcp_acknum_offset_lo        = l4_offset + 12'd8;
  assign  tcp_acknum_offset_hi        = l4_offset + 12'd10;
  assign  tcp_ackbit_offset           = l4_offset + 12'd13;
  assign  tcp_csum_offset             = l4_offset + 12'd16;

/* Unused extra module.
//  edma_field_decode #( .field_size(16'd1),.p_always_on_one_stripe(1'b1)) i_ipv4_hdrlen_extr  (
//    .host_clk               (hclk),
//    .host_rst_n             (n_hreset),
//
//    .soft_enable            (enable_rx | ~start_of_new_mac_frame),
//    .data                   (data_in),
//    .valid                  (data_in_vld),
//    .eop                    (1'b0),
//    .field_offset           ({11'h000,l3_offset}),
//    .running_byte_count     (running_byte_count_dph),
//    .dma_bus_width          (dma_bus_width),
//
//    .field                  (),
//    .field_valid            (),
//    .field_c                (extr_ipv4_hdr_length_pad),
//    .field_valid_c          (extr_ipv4_hdr_length_v)
//  );
*/

  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1)) i_ipv4_totlen_extr  (
    .host_clk               (hclk),
    .host_rst_n             (n_hreset),

    .soft_enable            (enable_rx | ~start_of_new_mac_frame),
    .data                   (data_in),
    .valid                  (data_in_vld),
    .eop                    (1'b0),
    .field_offset           ({10'h000,ipv4_tot_len_offset}),
    .running_byte_count     (running_byte_count_dph),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (extr_ipv4_total_length_v),
    .field_c                (extr_ipv4_total_length),
    .field_valid_c          (extr_ipv4_total_length_vc)
  );

  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1)) i_ipv4_csum_extr  (
    .host_clk               (hclk),
    .host_rst_n             (n_hreset),

    .soft_enable            (enable_rx | ~start_of_new_mac_frame),
    .data                   (data_in),
    .valid                  (data_in_vld),
    .eop                    (1'b0),
    .field_offset           ({10'h000,ipv4_csum_offset}),
    .running_byte_count     (running_byte_count_dph),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (),
    .field_c                (extr_ipv4_csum),
    .field_valid_c          (extr_ipv4_csum_v)
  );

  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1)) i_tcp_csum_extr  (
    .host_clk               (hclk),
    .host_rst_n             (n_hreset),

    .soft_enable            (enable_rx | ~start_of_new_mac_frame),
    .data                   (data_in),
    .valid                  (data_in_vld),
    .eop                    (1'b0),
    .field_offset           ({3'd0,tcp_csum_offset}),
    .running_byte_count     (running_byte_count_dph),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (),
    .field_c                (extr_tcp_csum),
    .field_valid_c          (extr_tcp_csum_v)
  );

  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1)) i_tcp_acknum_lo_extr  (
    .host_clk               (hclk),
    .host_rst_n             (n_hreset),

    .soft_enable            (enable_rx | ~start_of_new_mac_frame),
    .data                   (data_in),
    .valid                  (data_in_vld),
    .eop                    (1'b0),
    .field_offset           ({3'd0,tcp_acknum_offset_lo}),
    .running_byte_count     (running_byte_count_dph),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (),
    .field_c                (extr_tcp_acknum[15:0]),
    .field_valid_c          (extr_tcp_acknum_lo_v)
  );

  edma_field_decode #( .field_size(16'd2),.p_always_on_one_stripe(1'b1)) i_tcp_acknum_hi_extr  (
    .host_clk               (hclk),
    .host_rst_n             (n_hreset),

    .soft_enable            (enable_rx | ~start_of_new_mac_frame),
    .data                   (data_in),
    .valid                  (data_in_vld),
    .eop                    (1'b0),
    .field_offset           ({3'd0,tcp_acknum_offset_hi}),
    .running_byte_count     (running_byte_count_dph),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (),
    .field_c                (extr_tcp_acknum[31:16]),
    .field_valid_c          ()
  );

  edma_field_decode #( .field_size(16'd1),.p_always_on_one_stripe(1'b1)) i_tcp_ackbit_extr  (
    .host_clk               (hclk),
    .host_rst_n             (n_hreset),

    .soft_enable            (enable_rx | ~start_of_new_mac_frame),
    .data                   (data_in),
    .valid                  (data_in_vld),
    .eop                    (1'b0),
    .field_offset           ({3'd0,tcp_ackbit_offset}),
    .running_byte_count     (running_byte_count_dph),
    .dma_bus_width          (dma_bus_width),

    .field                  (),
    .field_valid            (),
    .field_c                (extr_tcp_ackbit_b),
    .field_valid_c          (extr_tcp_ackbit_v)
  );

  assign payload_length_poff      = l3_offset_poff + {extr_ipv4_total_length[7:0],extr_ipv4_total_length[15:8]} - pld_offset;
  assign payload_length           = l3_offset + {extr_ipv4_total_length[7:0],extr_ipv4_total_length[15:8]} - pld_offset;

//------------------------------------------------------------------------------
// Get the host memory and push to AHB dataphase
//------------------------------------------------------------------------------
//
  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      host_add_in_dph  <= {p_edma_addr_width-1{1'b0}};
    else if (~enable_rx)
      host_add_in_dph  <= {p_edma_addr_width-1{1'b0}};
    else if (data_in_vld)
      host_add_in_dph  <= host_add_in;
  end

//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
//
  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      block_writes_aph_d1     <= 1'b0;
      first_dph_of_frame      <= 1'b0;
    end
    else if (~enable_rx)
    begin
      block_writes_aph_d1     <= 1'b0;
      first_dph_of_frame      <= 1'b0;
    end
    else
    begin
      if (end_of_payload)
        block_writes_aph_d1  <= 1'b0;
      else if (block_writes_aph_pulse & data_in_vld)
        block_writes_aph_d1  <= 1'b1;

      if (start_of_new_mac_frame)
        first_dph_of_frame  <= 1'b1;
      else if (data_in_vld & ~in_header)
        first_dph_of_frame  <= 1'b0;
    end
  end

  assign mac_buffer_offset        = in_header ? 4'h0 : mac_buff_offset_pldonly_pad[queue_ptr_rx];
  assign running_ipv4_tot_len_rev = {running_ipv4_tot_len_pad[queue_ptr_rx_upd][7:0],running_ipv4_tot_len_pad[queue_ptr_rx_upd][15:8]};
  assign running_coalesced_len    = running_ipv4_tot_len_pad[queue_ptr_rx_upd] + orig_l3_offset_pad[queue_ptr_rx_upd];
  assign num_bytes_coalesced      = running_pld_tot_pad[queue_ptr_rx_upd];
  assign last_host_add_in         = host_add_in - {{p_edma_addr_width-16{1'b0}},num_bytes_in_stripe};
  assign block_writes_aph_pulse   = allowed_to_coalesce & extr_ipv4_total_length_v & ~block_writes_aph_d1 &
                                    (running_byte_count_aph[13:0] == total_frame_words[13:0]);
  assign block_writes_aph         = block_writes_aph_pulse | block_writes_aph_d1;



//------------------------------------------------------------------------------
// Drive the write strobes to the AXI block.
//
// The AHB DMA never drove any write strobes for data on the receive path at all since it never had too.
// If the last stipe of a frame write to AXI had only 1 byte valid, then it would still
// write the entire stripe.  This simplifed the code and didnt cause any issues as the buffer memory regions
// allocated by software were completely reserved by the system and stripes can not be reused from one frame
// to the next.
//
// For RSC however, we are coalescing frames and packing one frame's payload with the next.
// This means we may need to overwrite the same location (with the last few bytes of one frame
// with the first few bytes of the next), using write strobes to ensure we dont overwrite
// existing good bytes block_writes_aph_pulse identifies the last data phase allowed to progress.
//------------------------------------------------------------------------------
//
  always @(*)
  begin
    if (first_dph_of_frame & ~first_frame)
      case (mac_buff_offset_pldonly_pad[queue_ptr_rx][3:0])
        4'h0  : rsc_write_strobe = 16'hffff & {{8{dma_bus_width[1]}},{4{|dma_bus_width[1:0]}},4'hf};
        4'h1  : rsc_write_strobe = 16'hfffe & {{8{dma_bus_width[1]}},{4{|dma_bus_width[1:0]}},4'hf};
        4'h2  : rsc_write_strobe = 16'hfffc & {{8{dma_bus_width[1]}},{4{|dma_bus_width[1:0]}},4'hf};
        4'h3  : rsc_write_strobe = 16'hfff8 & {{8{dma_bus_width[1]}},{4{|dma_bus_width[1:0]}},4'hf};
        4'h4  : rsc_write_strobe = 16'hfff0 & {{8{dma_bus_width[1]}},{4{|dma_bus_width[1:0]}},4'hf};
        4'h5  : rsc_write_strobe = 16'hffe0 & {{8{dma_bus_width[1]}},{4{|dma_bus_width[1:0]}},4'hf};
        4'h6  : rsc_write_strobe = 16'hffc0 & {{8{dma_bus_width[1]}},{4{|dma_bus_width[1:0]}},4'hf};
        4'h7  : rsc_write_strobe = 16'hff80 & {{8{dma_bus_width[1]}},{4{|dma_bus_width[1:0]}},4'hf};
        4'h8  : rsc_write_strobe = 16'hff00;
        4'h9  : rsc_write_strobe = 16'hfe00;
        4'ha  : rsc_write_strobe = 16'hfc00;
        4'hb  : rsc_write_strobe = 16'hf800;
        4'hc  : rsc_write_strobe = 16'hf000;
        4'hd  : rsc_write_strobe = 16'he000;
        4'he  : rsc_write_strobe = 16'hc000;
        default  : rsc_write_strobe = 16'h8000;
      endcase

    else if (block_writes_aph_pulse)
      case (payload_length_poff[3:0] & {dma_bus_width[1],|dma_bus_width[1:0],2'b11})
        4'h0  : rsc_write_strobe = 16'hffff & {{8{dma_bus_width[1]}},{4{|dma_bus_width[1:0]}},4'hf};
        4'h1  : rsc_write_strobe = 16'h0001;
        4'h2  : rsc_write_strobe = 16'h0003;
        4'h3  : rsc_write_strobe = 16'h0007;
        4'h4  : rsc_write_strobe = 16'h000f;
        4'h5  : rsc_write_strobe = 16'h001f;
        4'h6  : rsc_write_strobe = 16'h003f;
        4'h7  : rsc_write_strobe = 16'h007f;
        4'h8  : rsc_write_strobe = 16'h00ff;
        4'h9  : rsc_write_strobe = 16'h01ff;
        4'ha  : rsc_write_strobe = 16'h03ff;
        4'hb  : rsc_write_strobe = 16'h07ff;
        4'hc  : rsc_write_strobe = 16'h0fff;
        4'hd  : rsc_write_strobe = 16'h1fff;
        4'he  : rsc_write_strobe = 16'h3fff;
        default  : rsc_write_strobe = 16'h7fff;
      endcase
    else
      rsc_write_strobe = 16'hffff & {{8{dma_bus_width[1]}},{4{|dma_bus_width[1:0]}},4'hf};
  end

//------------------------------------------------------------------------------
// Extract and calculate the TCP checksum, its only used if the parameter
// include_checksum_update is set; otherwise its set to 0
//------------------------------------------------------------------------------
//
  wire [15:0] final_tcp_res;

  generate if (include_checksum_update == 1) begin: gen_checksum2
    wire [16:0]  updated_ipv4_csum_sub1;
    wire [16:0]  init_tcp_csum_sub1;
    wire [15:0]  init_tcp_csum_sub2;
    wire [16:0]  init_tcp_csum_sub3;
    wire [16:0]  updated_tcp_csum_sub1;
    wire [16:0]  updated_tcp_csum_sub2;
    wire [16:0]  updated_tcp_csum_sub3;
    wire [16:0]  updated_tcp_csum_sub4;
    wire [16:0]  updated_tcp_csum_sub5;
    wire [16:0]  updated_tcp_csum_sub6;
    wire [16:0]  updated_tcp_csum_sub7;
    wire [15:0]  tcp_hdr_payload_result;
    wire [127:0] data_in_masked;
    wire [16:0]  tcp_csum_result_pad;
    wire [16:0]  tcp_csum_result;

    // Add in the difference to the payload length to get the correct IP checksum
    assign updated_ipv4_csum_sub1 = {~updated_ipv4_csum_pad[queue_ptr_rx][7:0],~updated_ipv4_csum_pad[queue_ptr_rx][15:8]} + payload_length;
    assign updated_ipv4_csum_sub = (updated_ipv4_csum_sub1[16] + updated_ipv4_csum_sub1[15:0]);

    // For first frame, Subtract the 32bit ack number from the checksum
    assign init_tcp_csum_sub1    = {1'b0,~extr_tcp_csum[7:0],~extr_tcp_csum[15:8]} - {1'b0,extr_tcp_acknum[23:16],extr_tcp_acknum[31:24]};
    assign init_tcp_csum_sub2    = (init_tcp_csum_sub1[16] | init_tcp_csum_sub1[15:0] == 16'h0000) ? init_tcp_csum_sub1[15:0] - 16'd1 : init_tcp_csum_sub1[15:0];
    assign init_tcp_csum_sub3    = {1'b0,init_tcp_csum_sub2} - {1'b0,extr_tcp_acknum[7:0],extr_tcp_acknum[15:8]} - {12'h000,tcp_ackbit_pad[queue_ptr_rx],4'h0};
    assign init_tcp_csum_sub     = (init_tcp_csum_sub3[16] | init_tcp_csum_sub3[15:0] == 16'h0000) ? init_tcp_csum_sub3[15:0] - 16'd1 : init_tcp_csum_sub3[15:0];

    // For all other segments, add the difference to the payload length
    // and the acknum for this segment.
    assign updated_tcp_csum_sub1 = {1'b0,updated_tcp_csum_pad[queue_ptr_rx][7:0],updated_tcp_csum_pad[queue_ptr_rx][15:8]} + {1'b0,payload_length};
    assign updated_tcp_csum_sub2 = (updated_tcp_csum_sub1[16] + updated_tcp_csum_sub1[15:0]);
    assign updated_tcp_csum_sub3 = {1'b0,updated_tcp_csum_sub2[15:0]} + ({1'b0,tcp_acknum_pad[queue_ptr_rx][23:16],tcp_acknum_pad[queue_ptr_rx][31:24]} & {17{extr_tcp_ackbit_b[4]}});
    assign updated_tcp_csum_sub4 = (updated_tcp_csum_sub3[16] + updated_tcp_csum_sub3[15:0]);
    assign updated_tcp_csum_sub5 = {1'b0,updated_tcp_csum_sub4[15:0]} + ({1'b0,tcp_acknum_pad[queue_ptr_rx][7:0],tcp_acknum_pad[queue_ptr_rx][15:8]} & {17{extr_tcp_ackbit_b[4]}});
    assign updated_tcp_csum_sub6 = (updated_tcp_csum_sub5[16] + updated_tcp_csum_sub5[15:0]);
    assign updated_tcp_csum_sub7 = {1'b0,updated_tcp_csum_sub6[15:0]}  + {12'h000,tcp_ackbit_pad[queue_ptr_rx],4'h0};
    assign updated_tcp_csum_sub  = (updated_tcp_csum_sub7[16] + updated_tcp_csum_sub7[15:0]) ;
    assign omit_checksum_state = P_IPCSUM;

    assign data_in_masked = {data_in[127:64] & {64{dma_bus_width[1]}},
                             data_in[63:32]  & {32{|dma_bus_width[1:0]}},
                             data_in[31:0]};

    edma_csum #( .SKIP_OVER_CSUM(1'b0)) i_edma_tcp_csum (

      .host_clk                (hclk),
      .host_rst_n              (n_hreset),

      .tx_r_data               (data_in_masked),
      .tx_r_eop                (1'b0),
      .tx_r_err                (1'b0),
      .tx_r_valid              (data_in_vld),

      .csum_start_offset       ({12'h000,mac_buff_offset_pldonly_pad[queue_ptr_rx]}),
      .running_byte_count      (running_byte_count_pld),
      .tx_e_valid              (data_in_vld),
      .csum_offset             (16'h0000),
      .csum_end_offset         (payload_length_poff-16'd1),
      .dma_bus_width           (dma_bus_width),

      .csum                    (tcp_hdr_payload_result),
      .csum_vld                ()
    );

    // Add it in here
    assign tcp_csum_result_pad  ={updated_tcp_csum_pad[queue_ptr_rx][7:0], updated_tcp_csum_pad[queue_ptr_rx][15:8]}+
                                 {tcp_hdr_payload_result[7:0],tcp_hdr_payload_result[15:8]};

    assign tcp_csum_result = tcp_csum_result_pad[15:0] + tcp_csum_result_pad[16];

    assign final_tcp_res   = ~{tcp_csum_result[7:0],tcp_csum_result[15:8]};

  end
  else begin: no_gen_checksum2
    assign omit_checksum_state   = P_ACK1;
    assign final_tcp_res         = 16'h0000;
    assign updated_ipv4_csum_sub = 17'h00000;
    assign init_tcp_csum_sub     = 16'h0000;
    assign updated_tcp_csum_sub  = 17'h00000;
  end
  endgenerate

//------------------------------------------------------------------------------
// The buffer_length is always in bits 13:0 of the word 1 of the descriptor
// the used bit is always in bit 0 of word 0
//------------------------------------------------------------------------------
//
  assign update_descr_buflen_add = base_descr_pld_host_add_pad[queue_ptr_rx_upd] + {{p_edma_addr_width-3{1'b0}},3'b100} ;

//------------------------------------------------------------------------------
// Identify if a decsriptor update is required which is determined by the signal
// rsc_coalescing_ended being set
//------------------------------------------------------------------------------
//
  always @(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
      need_descr_wr_update <= 1'b0;
    else if (~enable_rx)
      need_descr_wr_update <= 1'b0;
    else if (rsc_coalescing_ended_c)
      need_descr_wr_update <= 1'b1;
    else if (descr_update_cmp)
      need_descr_wr_update <= 1'b0;
  end

//------------------------------------------------------------------------------
// On descriptor writes from the MAC, we need to initiate an update cycles. This
// will take the form of a statemachine with the following sequences:
//  - Buffer Length field
//  - IPv4 Total Length
//  - IPv4 Checksum
//  - TCP Checksum
//  - TCP ACK Number
//  - Descriptor writeback update - used
//
//------------------------------------------------------------------------------
//
// Some helper signals ..
// identify if the TCP acknum is split over 2 stripes ... This depends on buswidth ...
wire  orig_tcp_acknum_off_split_32;
wire  orig_tcp_acknum_off_split_64;
wire  orig_tcp_acknum_off_split_128;
wire  orig_tcp_acknum_off_split;

// When datawidth is 32 bits, the acknum is ALWAYS going to be split over 2 stripes - this is because it will always start halfway through the
// stripe
assign orig_tcp_acknum_off_split_32  = dma_bus_width == 2'b00; // && orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][1]);
assign orig_tcp_acknum_off_split_64  = (dma_bus_width == 2'b01 && (&orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][2:1]));
assign orig_tcp_acknum_off_split_128 = (dma_bus_width == 2'b10 && (&orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][3:1]));
assign orig_tcp_acknum_off_split     = orig_tcp_acknum_off_split_32 || orig_tcp_acknum_off_split_64 || orig_tcp_acknum_off_split_128;



  // State decode and outputs
  always@(*)
  begin : p_update_fsm_nxt

    case (update_fsm)
      P_DSR_LEN :
      begin
        if (need_update_cycle | update_wait_ready)
        begin // Update IPv4 Total Length
          rsc_update_addr_c = {1'b0,ipv4_totlen_hostadd_pad[queue_ptr_rx_upd]};
          rsc_update_data = {{16{1'b0}},running_ipv4_tot_len_rev};

          if (dma_bus_width[1])
            rsc_update_ben  = 16'h0003 << orig_ipv4_tot_len_offset_pad[queue_ptr_rx_upd][3:0];
          else if (dma_bus_width[0])
            rsc_update_ben  = 16'h0003 << orig_ipv4_tot_len_offset_pad[queue_ptr_rx_upd][2:0];
          else
            rsc_update_ben  = 16'h0003 << orig_ipv4_tot_len_offset_pad[queue_ptr_rx_upd][1:0];

          rsc_update_last  = 1'b0;
          rsc_update_valid = 1'b1;
          rsc_update_descr = 1'b0;
          hdr_update_cmp   = 1'b0;
          if (rsc_update_ready)
            update_fsm_nxt = omit_checksum_state;
          else
            update_fsm_nxt = P_DSR_LEN;
        end
        else
        begin // Update Buffer Length field
          rsc_update_addr_c = {1'b0,update_descr_buflen_add[p_edma_addr_width-1:0]};
          rsc_update_data = {{16{1'b0}},1'b1,1'b0,running_coalesced_len[13:0]};  // update length field
          case (dma_bus_width)
            2'b00 : rsc_update_ben  = 16'h0003;
            2'b01 : rsc_update_ben  = 16'h0030;
            default : rsc_update_ben  = update_descr_buflen_add[3] ? 16'h3000 : 16'h0030;
          endcase
          rsc_update_valid = need_descr_wr_update;
          rsc_update_descr = 1'b1;
          rsc_update_last  = 1'b0;
          hdr_update_cmp   = 1'b0;
          if (need_descr_wr_update & rsc_update_ready)
            update_fsm_nxt = P_DSR_HDR_UPDATE;
          else
            update_fsm_nxt = P_DSR_LEN;
        end

      end

      P_IPCSUM : // Update IPv4 Checksum
      begin
        rsc_update_addr_c = {1'b0,ipv4_csum_hostadd_pad[queue_ptr_rx_upd]};
        rsc_update_data = {{16{1'b0}},updated_ipv4_csum_pad[queue_ptr_rx_upd]} ;

        if (dma_bus_width[1])
          rsc_update_ben  = 16'h0003 << orig_ipv4_csum_offset_pad[queue_ptr_rx_upd][3:0];
        else if (dma_bus_width[0])
          rsc_update_ben  = 16'h0003 << orig_ipv4_csum_offset_pad[queue_ptr_rx_upd][2:0];
        else
          rsc_update_ben  = 16'h0003 << orig_ipv4_csum_offset_pad[queue_ptr_rx_upd][1:0];

        rsc_update_last  = 1'b0;
        rsc_update_valid = 1'b1;
        rsc_update_descr = 1'b0;
        hdr_update_cmp   = 1'b0;
        if (rsc_update_ready)
          update_fsm_nxt = P_TCPCSUM;
        else
          update_fsm_nxt = P_IPCSUM;
      end

      P_TCPCSUM : // Update TCP Checksum
      begin
        rsc_update_addr_c = {1'b0,tcp_csum_hostadd_pad[queue_ptr_rx_upd]};
        rsc_update_data = {{16{1'b0}},final_tcp_res};

        if (dma_bus_width[1])
          rsc_update_ben  = 16'h0003 << orig_tcp_csum_offset_pad[queue_ptr_rx_upd][3:0];
        else if (dma_bus_width[0])
          rsc_update_ben  = 16'h0003 << orig_tcp_csum_offset_pad[queue_ptr_rx_upd][2:0];
        else
          rsc_update_ben  = 16'h0003 << orig_tcp_csum_offset_pad[queue_ptr_rx_upd][1:0];

        rsc_update_last  = 1'b0;
        rsc_update_valid = 1'b1;
        rsc_update_descr = 1'b0;
        hdr_update_cmp   = 1'b0;
        if (rsc_update_ready)
        begin
          if (extr_tcp_ackbit_b[4])
            update_fsm_nxt = P_ACK1;
          else
            update_fsm_nxt = P_ACK3;
        end
        else
          update_fsm_nxt = P_TCPCSUM;
      end

      P_ACK1 : // Update TCP ACK Number - this could be spread over 2 cycles, depending on orig_tcp_acknum_offset and dma_bus_width
      begin
        rsc_update_descr = 1'b0;
        rsc_update_addr_c = {1'b0,tcp_acknum_hostadd_pad[queue_ptr_rx_upd]};
        rsc_update_data = tcp_acknum_pad[queue_ptr_rx_upd];

        if (dma_bus_width[1])
          rsc_update_ben  = 16'h000f << orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][3:0];
        else if (dma_bus_width[0])
          rsc_update_ben  = 16'h000f << orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][2:0];
        else
          rsc_update_ben  = 16'h000f << orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][1:0];

        rsc_update_valid = 1'b1;
        if (orig_tcp_acknum_off_split)  // TCP ACKNUm is split over 2 cycles
        begin
          rsc_update_last  = 1'b0;
          hdr_update_cmp   = 1'b0;
          if (rsc_update_ready)
            update_fsm_nxt = P_ACK2;
          else
            update_fsm_nxt = P_ACK1;
        end
        else
        begin
          rsc_update_last  = 1'b0;
          if (rsc_update_ready)
          begin
            hdr_update_cmp = 1'b0;
            update_fsm_nxt = P_ACK3;
          end
          else
          begin
            hdr_update_cmp = 1'b0;
            update_fsm_nxt = P_ACK1;
          end
        end
      end

      P_ACK2 : // Update TCP ACK Number (only valid when the acknum spans over 2 cycles)
      begin
        if (dma_bus_width == 2'b00)
          rsc_update_addr_c = tcp_acknum_hostadd_pad[queue_ptr_rx_upd] + {{p_edma_addr_width-3{1'b0}},3'd4};
        // 64bit data with with overlap on boundary
        else if (dma_bus_width == 2'b01)
          rsc_update_addr_c = tcp_acknum_hostadd_pad[queue_ptr_rx_upd] + {{p_edma_addr_width-4{1'b0}},4'd8};
        else
          rsc_update_addr_c = tcp_acknum_hostadd_pad[queue_ptr_rx_upd] + {{p_edma_addr_width-5{1'b0}},5'd16};

        rsc_update_data = {16'h0000,extr_tcp_acknum[31:16]};
        rsc_update_ben  = dma_bus_width[1] ? 16'h0003  :
                          dma_bus_width[0] ? 16'h0003  :
                                             16'h0003 ;
        rsc_update_last  = 1'b0;
        rsc_update_valid = 1'b1;
        rsc_update_descr = 1'b0;
        if (rsc_update_ready)
        begin
          hdr_update_cmp = 1'b0;
          update_fsm_nxt = P_ACK3;
        end
        else
        begin
          hdr_update_cmp = 1'b0;
          update_fsm_nxt = P_ACK2;
        end
      end

      P_ACK3 : // Update TCP ACK Bit
      begin
        if (dma_bus_width == 2'b00)
        begin
          rsc_update_addr_c = tcp_acknum_hostadd_pad[queue_ptr_rx_upd] + {{p_edma_addr_width-3{1'b0}},3'd4};
          rsc_update_ben  = orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][1] ? 16'h0008 : 16'h0002;
        end
        else if (dma_bus_width == 2'b01 & orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][2])
        begin
          rsc_update_addr_c = tcp_acknum_hostadd_pad[queue_ptr_rx_upd] + {{p_edma_addr_width-4{1'b0}},4'd8};
          rsc_update_ben  = orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][1] ? 16'h0008 : 16'h0002;
        end
        else if (dma_bus_width == 2'b10 & (&orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][3:2]))
        begin
          rsc_update_addr_c = tcp_acknum_hostadd_pad[queue_ptr_rx_upd] + {{p_edma_addr_width-5{1'b0}},5'd16};
          rsc_update_ben  = orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][1] ? 16'h0008 : 16'h0002;
        end
        else
        begin
          rsc_update_addr_c = {1'b0,tcp_acknum_hostadd_pad[queue_ptr_rx_upd]};
          if (dma_bus_width[1])
            rsc_update_ben  = 16'h0020 << orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][3:0];
          else // if (dma_bus_width[0]) // always 64 bit
            rsc_update_ben  = 16'h0020 << orig_tcp_acknum_offset_pad[queue_ptr_rx_upd][2:0];
        end

        rsc_update_data = {27'd0,tcp_ackbit_pad[queue_ptr_rx_upd],4'd0};
        rsc_update_last  = 1'b1;
        rsc_update_valid = 1'b1;
        rsc_update_descr = 1'b0;
        if (rsc_update_ready)
        begin
          hdr_update_cmp = 1'b1;
          update_fsm_nxt = P_DSR_LEN;
        end
        else
        begin
          hdr_update_cmp = 1'b0;
          update_fsm_nxt = P_ACK3;
        end
      end

      P_DSR_HDR_UPDATE :
      begin
        rsc_update_addr_c = {1'b0,base_descr_hdr_host_add_pad[queue_ptr_rx_upd]};
        rsc_update_data = {24'h000000,saved_descr_hdr_wr,1'b1};
        if (dma_bus_width[1] & base_descr_hdr_host_add_pad[queue_ptr_rx_upd][3])
          rsc_update_ben  = 16'h0100;
        else
          rsc_update_ben  = 16'h0001;
        rsc_update_valid = 1'b1;
        rsc_update_last  = 1'b0;
        rsc_update_descr = 1'b1;  // Set on last descriptor update
        hdr_update_cmp   = 1'b0;
        if (rsc_update_ready)
          update_fsm_nxt = P_DSR_PLD_UPDATE;
        else
          update_fsm_nxt = P_DSR_HDR_UPDATE;
      end

      default : // P_DSR_PLD_UPDATE - Descriptor writeback update - used
      begin
        rsc_update_addr_c = {1'b0,base_descr_pld_host_add_pad[queue_ptr_rx_upd]};
        rsc_update_data = {24'h000000,saved_descr_pld_wr,1'b1};
        if (dma_bus_width[1] & base_descr_pld_host_add_pad[queue_ptr_rx_upd][3])
          rsc_update_ben  = 16'h0100;
        else
        rsc_update_ben   = 16'h0001;
        rsc_update_valid = 1'b1;
        rsc_update_last  = 1'b1;
        rsc_update_descr = 1'b1;  // Set on last descriptor update
        hdr_update_cmp   = 1'b0;
        if (rsc_update_ready)
          update_fsm_nxt = P_DSR_LEN;
        else
          update_fsm_nxt = P_DSR_PLD_UPDATE;
      end
    endcase
  end  // p_update_fsm_nxt

  assign rsc_update_addr = rsc_update_addr_c[p_edma_addr_width-1:0];

  assign descr_update_cmp =  rsc_update_ready & update_fsm == P_DSR_PLD_UPDATE;

  // State
  always@(posedge hclk or negedge n_hreset)
  begin : P_DSR_PLD_UPDATE_fsm
    if (~n_hreset)
    begin
      update_wait_ready   <= 1'b0;
      update_fsm          <= P_DSR_LEN;
    end
    else if (~enable_rx)
    begin
      update_wait_ready   <= 1'b0;
      update_fsm          <= P_DSR_LEN;
    end
    else
    begin
      update_fsm          <= update_fsm_nxt;
      if (rsc_update_ready)
        update_wait_ready <= 1'b0;
      else if (rsc_update_valid & need_update_cycle)
        update_wait_ready <= 1'b1;
    end
  end // P_DSR_PLD_UPDATE_fsm

endmodule

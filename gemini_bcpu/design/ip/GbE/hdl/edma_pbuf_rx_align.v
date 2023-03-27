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
//   Filename:           edma_pbuf_rx_align.v
//   Module Name:        edma_pbuf_rx_align
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
//   Description : This module perfoms alignment of RX data as it is read
//                from the SRAM. It is combinatorial if no realigning is to take place
//
//------------------------------------------------------------------------------


module edma_pbuf_rx_align (

   // system signals
   input          hclk,
   input          n_hreset,

   input [1:0]    dma_bus_width,
   input          soft_reset,

   input [127:0]  data_in,              // data
   input  [15:0]  par_in,               // parity
   input          data_in_vld,
   input          eob_in,               // Current stripe is the last of data buffer. Validated by data_in_vld
   input  [3:0]   eob_mod_in,
   input          eop_in,               // Current stripe is the last of packet. Validated by data_in_vld
   input  [3:0]   mod_in,               // Indicates how many bytes are valid on input (only valid on eob or eop)
   input  [3:0]   start_byte_in,        // Indicates where the 1st byte is located
   input          early_eop_in,         // Should be set on the data_in_vld preceding eop_in
   input          all_outputs_sampled,  // An input signal used to indicate the outputs are completely done with
   input          hdr_data_splitting_en,// Static configuration

   input          push_residue,         // Control signal to push data out after EOP (note data is output on every data_in_vld as well)

   output [127:0] data_out,             // data
   output [15:0]  par_out,              // parity
   output         eop_out,              // realigned eop
   output         early_eop_out,        // realigned early eop
   output reg [2:0] words_in_residue    // how many stripes are in the residue

   );

  parameter p_edma_asf_dap_prot = 1'b0;  // Define whether parity protection is used, if not then do not store

  reg  [5:0]   bytes_in_residue_c;
  reg  [4:0]   bytes_in_residue;
  reg  [239:0] offset_residue;

  reg          sob_in;
  reg          first_buffer_of_frame;
  reg          eop_pending;
  reg          early_eop_pending;
  wire         data_out_vld;

  // Calculate number of bytes in the residue
  wire [4:0]   num_bytes_in_stripe;
  assign num_bytes_in_stripe = dma_bus_width == 2'b00 ? 5'd4 :
                               dma_bus_width == 2'b01 ? 5'd8 :
                                                        5'd16;

  wire [3:0] start_byte_in_sob;
  assign start_byte_in_sob = (sob_in & (first_buffer_of_frame | hdr_data_splitting_en)) ? start_byte_in : 4'h0;

  reg  [4:0]   num_bytes_on_ip;
  reg  [4:0]   e_num_bytes_on_ip;
  always @(*)
  begin
    if (eop_pending)
      num_bytes_on_ip = 5'h00;
    else if (eop_in)
      num_bytes_on_ip = mod_in == 4'h0 ? num_bytes_in_stripe : {1'b0,mod_in};
    else
      num_bytes_on_ip = num_bytes_in_stripe;

    if (early_eop_pending)
      e_num_bytes_on_ip = 5'h00;
    else if (early_eop_in)
      e_num_bytes_on_ip = mod_in == 4'h0 ? num_bytes_in_stripe : {1'b0,mod_in};
    else
      e_num_bytes_on_ip = num_bytes_on_ip;
  end

  wire [4:0] max_bytes_on_op_start_eob;
  assign  max_bytes_on_op_start_eob = start_byte_in + eob_mod_in;

  reg  [4:0] max_bytes_on_op;
  always @(*)
  begin
    max_bytes_on_op = num_bytes_in_stripe - {1'b0,start_byte_in_sob};
    if (eob_in & sob_in)
    begin
      if ((max_bytes_on_op_start_eob > num_bytes_in_stripe) | (max_bytes_on_op_start_eob == 5'h00))
        max_bytes_on_op = num_bytes_in_stripe;
      else
        max_bytes_on_op = {1'b0,eob_mod_in} - {1'b0,start_byte_in_sob};
    end
    else if (eob_in & eob_mod_in != 4'h0)
      max_bytes_on_op = {1'b0,eob_mod_in};
    else
      max_bytes_on_op = num_bytes_in_stripe - {1'b0,start_byte_in_sob};
  end

  wire [5:0] tot_num_bytes_ip;
  wire [5:0] e_tot_num_bytes_ip;
  assign tot_num_bytes_ip   = bytes_in_residue + num_bytes_on_ip;
  assign e_tot_num_bytes_ip = bytes_in_residue + e_num_bytes_on_ip;

  reg [4:0] num_bytes_on_op;
  always @(*)
  begin
    if (tot_num_bytes_ip > {1'b0,max_bytes_on_op})
      num_bytes_on_op = max_bytes_on_op;
    else
      num_bytes_on_op = tot_num_bytes_ip[4:0];
  end

  // useful signal to identify how many free bytes there are on EOP
  wire [4:0]   free_bytes_eop;
  assign free_bytes_eop = (5'b10000 - {1'b0,mod_in}) & {1'b0,dma_bus_width[1],|dma_bus_width[1:0],2'b11};

  wire [240+128-1:0] offset_residue_with_data;
  assign offset_residue_with_data = {({{240{1'b0}},(data_in[127:0] & {128{~eop_pending}})} << {bytes_in_residue[4:0],3'b000}) |
                                      {{128{1'b0}},offset_residue}};

  always @(*)
  begin
    if (data_in_vld & (tot_num_bytes_ip > {1'b0,max_bytes_on_op}))
      bytes_in_residue_c   = tot_num_bytes_ip - max_bytes_on_op;
    else if (data_in_vld)
      bytes_in_residue_c   = 6'h00;
    else
      bytes_in_residue_c   = {1'b0,bytes_in_residue};
  end

  wire [240+128-1:0] offset_residue_pad;
  assign             offset_residue_pad = (offset_residue_with_data >> {num_bytes_on_op,3'b000});
  always@(posedge hclk or negedge n_hreset)
  begin
    if (~n_hreset)
    begin
      first_buffer_of_frame <= 1'b1;
      sob_in                <= 1'b1;
      offset_residue        <= 240'd0;
      bytes_in_residue      <= 5'h00;
      eop_pending           <= 1'b0;
      early_eop_pending     <= 1'b0;
      words_in_residue      <= 3'b000;
    end
    else if (soft_reset)
    begin
      first_buffer_of_frame <= 1'b1;
      sob_in                <= 1'b1;
      offset_residue        <= 240'd0;
      bytes_in_residue      <= 5'h00;
      eop_pending           <= 1'b0;
      early_eop_pending     <= 1'b0;
      words_in_residue      <= 3'b000;
    end
    else
    begin
      if (all_outputs_sampled)
        words_in_residue <= 3'b000;
      else if (bytes_in_residue > free_bytes_eop)
      begin
        if (dma_bus_width[1])
          words_in_residue <= {1'b0,({1'b0,bytes_in_residue[4]} + {1'b0,|bytes_in_residue[3:0]})};
        else if (dma_bus_width[0])
          words_in_residue <= (bytes_in_residue[4:3] + |bytes_in_residue[2:0]);
        else
          words_in_residue <= (bytes_in_residue[3:2] + |bytes_in_residue[1:0]);
      end

      if (eop_out & data_out_vld)
      begin
        first_buffer_of_frame <= 1'b1;
        sob_in                <= 1'b1;
        offset_residue        <= 240'd0;
        bytes_in_residue      <= 5'h00;
        eop_pending           <= 1'b0;
        early_eop_pending     <= 1'b0;
      end
      else
      begin
        if (eob_in & data_in_vld)
        begin
          sob_in  <= 1'b1;
          first_buffer_of_frame <= 1'b0;
        end
        else if (sob_in & data_in_vld)
          sob_in  <= 1'b0;

        bytes_in_residue   <= bytes_in_residue_c[4:0];

        if (data_in_vld)
          offset_residue     <= offset_residue_pad[239:0];
        if (data_in_vld & eop_in & (tot_num_bytes_ip > {1'b0,max_bytes_on_op}))
          eop_pending  <= 1'b1;

        if (early_eop_in & (e_tot_num_bytes_ip > {1'b0,max_bytes_on_op}))
          early_eop_pending  <= 1'b1;
        else if (early_eop_out)
          early_eop_pending  <= 1'b0;

      end
    end
  end

  assign data_out_vld   = (push_residue & eop_pending) | data_in_vld;
  assign data_out       = offset_residue_with_data[127:0] << {start_byte_in_sob,3'b000};
  assign eop_out        = (((eop_pending&push_residue)| (eop_in & data_in_vld)) &
                             (tot_num_bytes_ip <= {1'b0,max_bytes_on_op}));

  assign early_eop_out = ((early_eop_in & (bytes_in_residue <= free_bytes_eop)) |
                          (|bytes_in_residue & early_eop_pending & ({1'b0,bytes_in_residue} < {num_bytes_in_stripe,1'b0})));

  // Generate aligned parity.
  generate if (p_edma_asf_dap_prot == 0) begin : gen_no_par
    assign par_out  = 16'h0000;
  end else begin : gen_par
    reg  [29:0]  offset_residue_par;
    wire [30+16-1:0] offset_residue_with_prty;
    wire [30+16-1:0] offset_residue_pad_par;
    assign offset_residue_with_prty = {({{30{1'b0}},(par_in[15:0] & {16{~eop_pending}})} << {bytes_in_residue[4:0]}) |
                                        {{16{1'b0}},offset_residue_par}};
    assign offset_residue_pad_par = (offset_residue_with_prty >> {num_bytes_on_op});
    always@(posedge hclk or negedge n_hreset)
    begin
      if (~n_hreset)
        offset_residue_par  <= 30'd0;
      else if (soft_reset)
        offset_residue_par  <= 30'd0;
      else if (eop_out & data_out_vld)
        offset_residue_par  <= 30'd0;
      else if (data_in_vld)
        offset_residue_par  <= offset_residue_pad_par[29:0];
    end
    assign par_out  = offset_residue_with_prty[15:0]  << {start_byte_in_sob};
  end
  endgenerate

endmodule

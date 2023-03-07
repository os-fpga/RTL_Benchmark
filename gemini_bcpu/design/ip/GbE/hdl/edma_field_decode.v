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
//   Filename:           edma_field_decode.v
//   Module Name:        edma_field_decode
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
//   Description :      Block to extract a particular field
//
//------------------------------------------------------------------------------


module edma_field_decode (

     host_clk,
     host_rst_n,

     soft_enable,

     data,
     valid,
     eop,
     field_offset,
     running_byte_count,
     dma_bus_width,

     field,
     field_valid,
     field_c,
     field_valid_c

  );

  parameter field_size              = 16'd1;    // Number of bytes to extract
  parameter field_size_words        = 13'd1;    // Number of words those bytes would span if byte started on 64-byte boundary
  parameter p_always_on_one_stripe  = 1'b0;     // Number of words those bytes would span if byte started on 64-byte boundary
  parameter p_register_output       = 1'b1;     // This only applies to the *_c outputs. When low, these outputs are only valid combinatorially set
  parameter FIELD_NOT_EXTRACT       = 1'b0;
  parameter FIELD_EXTRACT           = 1'b1;

  input               host_clk;
  input               host_rst_n;

  input               soft_enable;
  input  [127:0]      data;
  input               valid;
  input               eop;
  input  [15:0]       field_offset;
  input  [15:0]       running_byte_count;
  input  [1:0]        dma_bus_width;      // programmed data width
                                          // 00 = 32  bit bus
                                          // 01 = 64  bit bus
                                          // 1x = 128 bit bus
  output [8*field_size-1:0] field;
  output                    field_valid;
  output [8*field_size-1:0] field_c;
  output                    field_valid_c;

  wire               [13:0] stripe_num;
  wire               [13:0] field_offset_stripe;
  wire                [3:0] field_offset_bytes;

  reg                       field_valid;
  reg                       field_valid_c;
  reg    [8*field_size-1:0] field_c;
  reg    [8*field_size-1:0] field;
  integer                   inta;


  // How many stripes will the extraction go over
  assign stripe_num           = dma_bus_width == 2'b00 ? running_byte_count[15:2] :
                                dma_bus_width == 2'b01 ? {1'b0, running_byte_count[15:3]} :
                                                         {2'b00,running_byte_count[15:4]};

  assign field_offset_stripe  = dma_bus_width == 2'b00 ? field_offset[15:2] :
                                dma_bus_width == 2'b01 ? {1'b0, field_offset[15:3]} :
                                                         {2'b00,field_offset[15:4]};
  assign field_offset_bytes   = dma_bus_width == 2'b00 ? {2'b00,field_offset[1:0]} :
                                dma_bus_width == 2'b01 ? {1'b0, field_offset[2:0]} :
                                                          field_offset[3:0];

  generate
    // design when it is not possible the decode will stretch over more than 1 stripe
    if (p_always_on_one_stripe)
    begin : two_byte_field_extract
      // The following is just for LINT
      wire [255:0] data_pad;

      assign data_pad[127:0]   = data;
      assign data_pad[255:128] = 128'd0;
      always @(*)
      begin
        if (stripe_num == field_offset_stripe)
        begin
          field_valid_c   = 1'b1;
          for (inta=0;inta<(field_size[4:0]*4'd8);inta=inta+1)
            field_c[inta] = data_pad[((field_offset_bytes*8)+inta[4:0])];
        end
        else
        begin
          field_valid_c  = 1'b0;
          if (p_register_output)
            field_c      = field;
          else
            field_c      = {(8*field_size){1'b0}};
        end
      end

      always @(posedge host_clk or negedge host_rst_n)
      begin
        if (~host_rst_n)
        begin
          field       <= {8*field_size{1'b0}};
          field_valid <= 1'b0;
        end
        else
        begin
          if (~soft_enable | (eop & valid))
          begin
            field_valid <= 1'b0;
            field       <= {8*field_size{1'b0}};
          end
          else if (field_valid_c & valid)
          begin
            field_valid <= field_valid_c;
            field       <= field_c;
          end
        end
      end
    end

    else begin : else_two_byte_field_extract
      // design when it is possible the decode will stretch over more than 1 stripe

      reg    [128*field_size_words-1:0] field_pad_c;
      reg    [128*field_size_words-1:0] field_pad;
      reg    [15:0]       field_index;
      reg    [16:0]       field_index_c;
      reg    [127:0]      extr_stripe;
      reg                 field_extracted;
      reg                 field_extracting;
      reg                 field_extract_state;
      reg                 field_extract_state_nxt;
      wire   [16:0]       field_end_offset;
      wire   [13:0]       field_end_offset_stripe;
      wire   [4:0]        num_bytes_in_stripe_b;
      wire   [128*field_size_words:0]   extr_stripe_pad;
      wire   [128*field_size_words-1:0] extr_stripe_pad_shifted;
      
      assign extr_stripe_pad         = {{(128*field_size_words - 127){1'b0}},extr_stripe};
      assign extr_stripe_pad_shifted = extr_stripe_pad[128*field_size_words-1:0] << {field_index,3'b000};
      
      assign field_end_offset         =  field_offset + (field_size - 16'd1);
      assign field_end_offset_stripe  = dma_bus_width == 2'b00 ?        field_end_offset[15:2] :
                                        dma_bus_width == 2'b01 ? {1'b0, field_end_offset[15:3]} :
                                                                 {2'b00,field_end_offset[15:4]};

      assign num_bytes_in_stripe_b    = dma_bus_width == 2'b00 ? 5'd4 :
                                        dma_bus_width == 2'b01 ? 5'd8 :
                                                                 5'd16;

      always @(*)
      begin
        if (field_extract_state == FIELD_NOT_EXTRACT)
        begin
          if (stripe_num == field_offset_stripe)
          begin
            field_extracting  = 1'b1;
            if (stripe_num == field_end_offset_stripe)
            begin
              field_extracted  = 1'b1;
              field_extract_state_nxt = FIELD_NOT_EXTRACT;
            end
            else
            begin
              field_extracted  = 1'b0;
              field_extract_state_nxt = FIELD_EXTRACT;
            end
          end
          else
          begin
            field_extracted   = 1'b0;
            field_extracting  = 1'b0;
            field_extract_state_nxt = FIELD_NOT_EXTRACT;
          end
        end
        else
        begin
          field_extracting  = 1'b1;
          if (stripe_num == field_end_offset_stripe)
          begin
            field_extracted  = 1'b1;
            field_extract_state_nxt = FIELD_NOT_EXTRACT;
          end
          else
          begin
            field_extracted  = 1'b0;
            field_extract_state_nxt = FIELD_EXTRACT;
          end
        end
      end

      // Put the valid bytes starting from byte 0. keep track of number of bytes;
      always @(*)
      begin
        if ( field_extract_state == 1'b0)
        begin
          case (field_offset_bytes[3:0])
            4'b0000  : extr_stripe = data;
            4'b0001  : extr_stripe = {8'd0 ,data[127:8]};
            4'b0010  : extr_stripe = {16'd0,data[127:16]};
            4'b0011  : extr_stripe = {24'd0,data[127:24]};
            4'b0100  : extr_stripe = {32'd0,data[127:32]};
            4'b0101  : extr_stripe = {40'd0,data[127:40]};
            4'b0110  : extr_stripe = {48'd0,data[127:48]};
            4'b0111  : extr_stripe = {56'd0,data[127:56]};
            4'b1000  : extr_stripe = {64'd0,data[127:64]};
            4'b1001  : extr_stripe = {72'd0,data[127:72]};
            4'b1010  : extr_stripe = {80'd0,data[127:80]};
            4'b1011  : extr_stripe = {88'd0,data[127:88]};
            4'b1100  : extr_stripe = {96'd0,data[127:96]};
            4'b1101  : extr_stripe = {104'd0,data[127:104]};
            4'b1110  : extr_stripe = {112'd0,data[127:112]};
            default  : extr_stripe = {120'd0,data[127:120]};
          endcase
        end
        else
          extr_stripe = data;
      end

      always @(*)
      begin
        if (field_extracted)
          field_valid_c = 1'b1;
        else
          field_valid_c = 1'b0;

        if (field_extract_state == 1'b0 & field_extracting)
        begin
          field_pad_c   = extr_stripe_pad[128*field_size_words-1:0];
          field_index_c = {12'd0,num_bytes_in_stripe_b} - {13'd0,field_offset_bytes};
        end
        else if (field_extract_state == 1'b1)
        begin
          field_pad_c   = field_pad | extr_stripe_pad_shifted;
          field_index_c = field_index + {11'd0,num_bytes_in_stripe_b};
        end
        else
        begin
          field_pad_c   = field_pad;
          field_index_c = {1'b0,field_index};
        end
      end

      always @(posedge host_clk or negedge host_rst_n)
      begin
        if (~host_rst_n)
        begin
          field_extract_state <= FIELD_NOT_EXTRACT;
          field_index <= 16'h0000;
          field_pad   <= {128*field_size_words{1'b0}};
          field_valid <= 1'b0;
        end
        else
        begin
          if (~soft_enable | (eop & valid))
          begin
            field_extract_state <= FIELD_NOT_EXTRACT;
            field_valid <= 1'b0;
            field_pad   <= {128*field_size_words{1'b0}};
            field_index <= 16'h0000;
          end
          else if (valid)
          begin
            field_extract_state <= field_extract_state_nxt;
            field_valid <= field_valid_c | field_valid;
            field_pad   <= field_pad_c;
            field_index <= field_index_c[15:0];
          end
        end
      end
      always @(*)
        field    = field_pad[8*field_size-1:0];
      always @(*)
        field_c  = field_pad_c[8*field_size-1:0];
    end
  endgenerate

endmodule

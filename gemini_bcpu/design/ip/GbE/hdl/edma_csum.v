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
//   Filename:           edma_csum.v
//   Module Name:        edma_csum
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
//   Description :      Block to offload checksum calculation
//
//------------------------------------------------------------------------------


module edma_csum
#(parameter   SKIP_OVER_CSUM = 1'b1)
  (
     host_clk,
     host_rst_n,

     tx_r_data,
     tx_r_eop,
     tx_r_err,
     tx_r_valid,

     csum_start_offset,
     running_byte_count,
     tx_e_valid,
     csum_offset,
     csum_end_offset,
     dma_bus_width,

     csum,
     csum_vld
  );

  input               host_clk;
  input               host_rst_n;

  input  [127:0]      tx_r_data;
  input               tx_r_eop;
  input               tx_r_err;
  input               tx_r_valid;

  input  [15:0]       csum_start_offset; // Byte offset
  input  [15:0]       running_byte_count;
  input               tx_e_valid; // early version of valid that is valid on running_byte_count
  input  [15:0]       csum_offset;
  input  [15:0]       csum_end_offset;
  input  [1:0]        dma_bus_width;      // programmed data width
                                          // 00 = 32  bit bus
                                          // 01 = 64  bit bus
                                          // 1x = 128 bit bus

  output [15:0]       csum;
  output              csum_vld;

  reg                 chksm_calc_en_end;
  reg                 chksm_calc_en_start;
  reg                 chksm_calc_en_r;
  wire                chksm_calc_en;
  reg    [15:0]       chksm_calc_field_en;
  reg    [15:0]       csum_result0;
  reg    [15:0]       csum_result1;
  wire   [16:0]       csum_resulta;
  wire   [16:0]       csum_result;
  wire   [15:0]       count1b [3:0];
  wire   [15:0]       count1d [1:0];
  reg    [16:0]       count2a0;
  reg    [16:0]       count2b0;
  reg    [16:0]       count2a1;
  reg    [16:0]       count2b1;
  reg                 csum_vld_r;
  wire                csum_vld;
  reg                 calc_started_on_odd;
  wire   [13:0]       stripe_num;
  wire   [13:0]       csum_start_stripe;
  wire   [3:0]        csum_start_bytes;
  wire   [13:0]       end_offset_stripe;
  wire   [3:0]        end_offset_bytes;
  wire   [13:0]       csum_stripe;
  wire   [3:0]        csum_bytes;
  integer             inta;

  assign stripe_num           = dma_bus_width == 2'b00 ? running_byte_count[15:2] :
                                dma_bus_width == 2'b01 ? {1'b0, running_byte_count[15:3]} :
                                                         {2'b00,running_byte_count[15:4]};

  assign csum_start_stripe    = dma_bus_width == 2'b00 ? csum_start_offset[15:2] :
                                dma_bus_width == 2'b01 ? {1'b0, csum_start_offset[15:3]} :
                                                         {2'b00,csum_start_offset[15:4]};
  assign csum_start_bytes     = dma_bus_width == 2'b00 ? {2'b00, csum_start_offset[1:0]} :
                                dma_bus_width == 2'b01 ? {1'b0, csum_start_offset[2:0]} :
                                                                csum_start_offset[3:0];

  assign end_offset_stripe    = dma_bus_width == 2'b00 ?  csum_end_offset[15:2] :
                                dma_bus_width == 2'b01 ?  {1'b0, csum_end_offset[15:3]} :
                                                          {2'b00,csum_end_offset[15:4]};
  assign end_offset_bytes     = dma_bus_width == 2'b00 ? {2'b00, csum_end_offset[1:0]} :
                                dma_bus_width == 2'b01 ? {1'b0, csum_end_offset[2:0]} :
                                                                csum_end_offset[3:0];

  assign csum_stripe          = dma_bus_width == 2'b00 ? csum_offset[15:2] :
                                dma_bus_width == 2'b01 ? {1'b0, csum_offset[15:3]} :
                                                         {2'b00,csum_offset[15:4]};
  assign csum_bytes           = dma_bus_width == 2'b00 ? {2'h0, csum_offset[1:0]} :
                                dma_bus_width == 2'b01 ? {1'b0, csum_offset[2:0]} :
                                                                csum_offset[3:0];

wire skip_carry_nxt;
reg  skip_carry;
generate
  if (SKIP_OVER_CSUM == 1'b1)
  begin : gen_skip_over_csum
    assign skip_carry_nxt = ( csum_bytes == 4'h3 & dma_bus_width  == 2'b00 |
                              csum_bytes == 4'h7 & dma_bus_width  == 2'b01 |
                              csum_bytes == 4'hf);
    always @(posedge host_clk or negedge host_rst_n)
    begin
      if (~host_rst_n)
        skip_carry          <= 1'b0;
      else
      begin
        if (tx_r_valid & (tx_r_eop | tx_r_err))
          skip_carry          <= 1'b0;
        else
        begin
          // if the index is at the top of the stripe, then we
          // need to skip over the first byte in the next
          // stripe also.
          if (stripe_num == csum_stripe)
            skip_carry  <= skip_carry_nxt;
          else
            skip_carry  <= 1'b0;
        end
      end
    end
  end
  else
  begin :gen_no_skip_over_csum
    assign skip_carry_nxt = 1'b0;
    always @(*) skip_carry = skip_carry_nxt;
  end
endgenerate

  // Can register csum_start_offset as it is valid from SOP and we can guarantee we wont look
  // at it until at
  // least byte 14 (stripe 2)
  // Can register csum_end_offset as it is also valid early enough
  always @(posedge host_clk or negedge host_rst_n)
  begin
    if (~host_rst_n)
    begin
      chksm_calc_en_start <= 1'b1;
      chksm_calc_en_end   <= 1'b0;
      chksm_calc_field_en <= {16{1'b0}};
    end
    else
    begin
      if (tx_r_valid & (tx_r_eop | tx_r_err))
      begin
        chksm_calc_en_start <= 1'b0;
        chksm_calc_en_end   <= 1'b0;
        chksm_calc_field_en <= {16{1'b0}};
      end

      else
      begin
        if (stripe_num == csum_start_stripe & tx_e_valid)
        begin
          chksm_calc_en_start <= 1'b1;
          chksm_calc_en_end <= stripe_num == end_offset_stripe;
          for (inta = 0;inta<=32'd15;inta=inta+32'd1)
          begin
            if (inta[3:0] >= csum_start_bytes)
            begin
              if (SKIP_OVER_CSUM & stripe_num == csum_stripe & inta[3:0] == csum_bytes)
                chksm_calc_field_en[inta] <= 1'b0;
              else if (SKIP_OVER_CSUM & stripe_num == csum_stripe & inta[3:0] == (csum_bytes + 3'd1) & ~skip_carry_nxt)
                chksm_calc_field_en[inta] <= 1'b0;
              else if (stripe_num == end_offset_stripe & inta[3:0] > end_offset_bytes)
                chksm_calc_field_en[inta] <= 1'b0;
              else
                chksm_calc_field_en[inta] <= 1'b1;
            end
            else
              chksm_calc_field_en[inta] <= 1'b0;
          end
        end

        else if (tx_e_valid & stripe_num == end_offset_stripe & (|chksm_calc_field_en))
        begin
          chksm_calc_en_start <= 1'b0;
          chksm_calc_en_end <= 1'b1;
          for (inta = 0;inta<=32'd15;inta=inta+32'd1)
          begin
            if (inta[4:0] == 5'd00 & skip_carry)
              chksm_calc_field_en[inta] <= 1'b0;
            else if (stripe_num == csum_stripe & inta[3:0] == csum_bytes & SKIP_OVER_CSUM)
              chksm_calc_field_en[inta] <= 1'b0;
            else if (stripe_num == csum_stripe & inta[3:0] == (csum_bytes + 4'd1) & SKIP_OVER_CSUM)
              chksm_calc_field_en[inta] <= 1'b0;
            else if (inta[3:0] <= end_offset_bytes)
              chksm_calc_field_en[inta] <= 1'b1;
            else
              chksm_calc_field_en[inta] <= 1'b0;
          end
        end

        // The following implements the logic to skip over the incoming bytes in order to calculate the
        // correct CSUM based.
        else if (tx_e_valid & (|chksm_calc_field_en) & ~chksm_calc_en_end)
        begin
          chksm_calc_en_start <= 1'b0;
          chksm_calc_en_end   <= 1'b0;

          for (inta = 0;inta<=32'd15;inta=inta+32'd1)
          begin
            if (inta[4:0] == 5'd00 & skip_carry)
              chksm_calc_field_en[inta] <= 1'b0;
            else if (stripe_num == csum_stripe & inta[3:0] == csum_bytes & SKIP_OVER_CSUM)
              chksm_calc_field_en[inta] <= 1'b0;
            else if (stripe_num == csum_stripe & inta[3:0] == (csum_bytes + 4'd1) & SKIP_OVER_CSUM)
              chksm_calc_field_en[inta] <= 1'b0;
            else
              chksm_calc_field_en[inta] <= 1'b1;
          end
        end

        else if (tx_e_valid)
        begin
          chksm_calc_en_start <= 1'b0;
          chksm_calc_en_end   <= 1'b0;
          chksm_calc_field_en  <= 16'h0000;
        end
      end
    end
  end


  always @(posedge host_clk or negedge host_rst_n)
  begin
    if (~host_rst_n)
      chksm_calc_en_r  <= 1'b0;
    else if ((chksm_calc_en_end | (tx_r_eop | tx_r_err)) & tx_r_valid)
      chksm_calc_en_r  <= 1'b0;
    else if (chksm_calc_en_start & tx_r_valid)
      chksm_calc_en_r  <= 1'b1;
  end
  assign chksm_calc_en = (chksm_calc_en_start | chksm_calc_en_r) & tx_r_valid;

  // Checksum Calculation
  // The checksum field is the 16 bit one's complement of the one's
  // complement sum of all 16 bit words in the header and text.
  // 16 byte datapath means there are 8 16-bit fields that need
  // to be added per clock cycle, plus the 16 bit carry from previous cycle
  // Each 16 bit field is added in pairs, and the carry bit of this addition
  // must also be added in.
  //
  // First add every 16 bit pair (4 counts)
  genvar gena;
  generate
  for (gena = 0;gena <4;gena=gena+1)
  begin : gen_cs_1
    wire [7:0] operand1;
    wire [7:0] operand2;
    wire [7:0] operand3;
    wire [7:0] operand4;
    assign operand1 = ({8{chksm_calc_field_en[gena*4+0]}} & tx_r_data[gena*32+7:gena*32+0]);
    assign operand2 = ({8{chksm_calc_field_en[gena*4+1]}} & tx_r_data[gena*32+15:gena*32+8]);
    assign operand3 = ({8{chksm_calc_field_en[gena*4+2]}} & tx_r_data[gena*32+23:gena*32+16]);
    assign operand4 = ({8{chksm_calc_field_en[gena*4+3]}} & tx_r_data[gena*32+31:gena*32+24]);
    reg    [16:0]       count1a_local;
    reg    [16:0]       count1b_local;
    always@(*)
    begin
      count1a_local = {operand1,operand2} + {operand3,operand4};
      count1b_local = count1a_local[16] + count1a_local[15:0];
    end
    assign  count1b[gena] = count1b_local[15:0];
  end
  endgenerate

  genvar genb;
  generate
  for (genb = 0;genb <2;genb=genb+1)
  begin: gen_cs_2
    reg    [16:0]       count1c_local;
    reg    [16:0]       count1d_local;
    always@(*)
    begin
      count1c_local = count1b[2*genb] + count1b[2*genb+1];
      count1d_local = count1c_local[16] + count1c_local[15:0];
    end
    assign  count1d[genb] = count1d_local[15:0];
  end
  endgenerate


  // leaves 2 results
  // Add the previous result to this, then register
  always@(*)
  begin
    count2a0 = count1d[0] + ({16{~chksm_calc_en_start}} & csum_result0);
    count2b0 = count2a0[16] + count2a0[15:0];
  end
  always@(*)
  begin
    count2a1 = count1d[1] + ({16{~chksm_calc_en_start}} & csum_result1);
    count2b1 = count2a1[16] + count2a1[15:0];
  end

  always @(posedge host_clk or negedge host_rst_n)
  begin
    if (~host_rst_n)
    begin
      csum_result0    <= 16'h0000;
      csum_result1    <= 16'h0000;
      calc_started_on_odd <= 1'b0;
      csum_vld_r <= 1'b0;
    end
    else
    begin
      if (tx_r_valid)
      begin
        csum_result0    <= count2b0[15:0];
        csum_result1    <= count2b1[15:0];
        if (~tx_r_eop)
          calc_started_on_odd <= csum_start_offset[0];
      end
      csum_vld_r   <= (chksm_calc_en & chksm_calc_en_end & tx_r_valid);
    end
  end
  assign csum_resulta = csum_result0 + csum_result1;
  assign csum_result = csum_resulta[16] + csum_resulta[15:0];

  // If the checksum started on an odd boundary, then we dont need to flip the bytes.
  // This is because we artifically do it in the calculation itself
  assign csum_vld   = csum_vld_r;
  assign csum       = calc_started_on_odd ? csum_result[15:0]
                                         : ({csum_result[7:0],csum_result[15:8]});


endmodule


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
//   Filename:           edma_pbuf_axi_fe_hdr_parse.v
//   Module Name:        edma_pbuf_axi_fe_hdr_parse
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
//   Description       :      AXI front end driver for TX
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module edma_pbuf_axi_fe_hdr_parse # (

  parameter p_axi_tx_descr_rd_buff_bits   = `edma_axi_tx_descr_rd_buff_bits,
  parameter p_axi_tx_descr_rd_buff_depth  = 2**p_axi_tx_descr_rd_buff_bits,
  parameter p_descr_width                 = 32+`edma_addr_width

  ) (

  input                 enable,
  input       [127:0]   rdata,
  input       [1:0]     dma_bus_width,

  input       [11:0]    ls_word_id,
  input       [11:0]    ms_word_id,
  input       [11:0]    word_pstn,

  output reg  [3:0]     trig,
  output reg  [31:0]    data_word

  );

  reg         [2:0]     trig_bit;

  // Check if required word is in current stripe and if so determine the word lane
  always @ *
  begin
    trig_bit = 3'd0;
    trig     = 4'd0;

    if ((word_pstn >= ls_word_id) && (word_pstn <= ms_word_id))
      case (dma_bus_width)

        2'b00 :
        begin
          trig_bit            = 3'h0;
          trig[trig_bit[1:0]] = enable;
        end

        2'b01 :
        begin
          trig_bit            = 3'h1 - (ms_word_id[0] - word_pstn[0]);
          trig[trig_bit[1:0]] = enable;
        end

        default :
        begin
          trig_bit            = 3'h3 - (ms_word_id[1:0] - word_pstn[1:0]);
          trig[trig_bit[1:0]] = enable;
        end
      endcase

  end

  always @ *
  begin
    case (trig_bit[1:0])
      2'b00   : data_word = rdata[31:0];
      2'b01   : data_word = rdata[63:32];
      2'b10   : data_word = rdata[95:64];
      default : data_word = rdata[127:96];
    endcase
  end


endmodule //edma_pbuf_axi_fe_hdr_parse

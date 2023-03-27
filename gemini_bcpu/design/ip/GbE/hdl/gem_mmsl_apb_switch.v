//------------------------------------------------------------------------------
// Copyright (c) 2016-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_mmsl_apb_switch.v
//   Module Name:        gem_mmsl_apb_switch
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
//   Description :      APB switch for 802.3br
//
//------------------------------------------------------------------------------

module gem_mmsl_apb_switch (

  // APB interface signals
  input                 psel,
  input                 penable,
  input          [12:2] paddr,
  input                 pwrite,
  input          [31:0] pwdata,
  input          [3:0]  pwdata_par,
  output                pslverr,
  output         [31:0] prdata,
  output         [3:0]  prdata_par,

  // MMSL register interface signals
  output reg            mmsl_psel,
  output reg            mmsl_penable,
  output reg      [7:2] mmsl_paddr,
  output reg            mmsl_pwrite,
  output reg     [31:0] mmsl_pwdata,
  output reg      [3:0] mmsl_pwdata_par,
  input                 mmsl_pslverr,
  input          [31:0] mmsl_prdata,
  input           [3:0] mmsl_prdata_par,

  // pMAC registers interface signals
  output reg            pmac_psel,
  output reg            pmac_penable,
  output reg     [11:2] pmac_paddr,
  output reg            pmac_pwrite,
  output reg     [31:0] pmac_pwdata,
  output reg      [3:0] pmac_pwdata_par,
  input                 pmac_pslverr,
  input          [31:0] pmac_prdata,
  input           [3:0] pmac_prdata_par,

  // eMAC registers interface signals
  output reg            emac_psel,
  output reg            emac_penable,
  output reg     [11:2] emac_paddr,
  output reg            emac_pwrite,
  output reg     [31:0] emac_pwdata,
  output reg      [3:0] emac_pwdata_par,
  input                 emac_pslverr,
  input          [31:0] emac_prdata,
  input           [3:0] emac_prdata_par

);

// -----------------------------------------------------------------------------
// Declaration of the signals and parameters
// -----------------------------------------------------------------------------

wire [4:0] decode_paddr;

// -----------------------------------------------------------------------------
// Beginning of the code
// -----------------------------------------------------------------------------

// This module will only decode paddr[12:8] because the register map is:
// 0x0000 - 0x0EFC -- pMAC
// 0x0F00 - 0x0FFF -- MMSL
// 0x1000 - 0x1FFF -- eMAC
// So the first 5 bits are enough to know if the paddr is an
// mmsl register address, a pMAC or a eMAC register address.

assign decode_paddr = paddr[12:8];

always @ *
begin
  if(decode_paddr < 5'b01111) // pMAC address (less than 0x0f00)
    begin
      pmac_psel       = psel;
      pmac_penable    = penable;
      pmac_paddr      = paddr[11:2];
      pmac_pwrite     = pwrite;
      pmac_pwdata     = pwdata;
      pmac_pwdata_par = pwdata_par;

      emac_psel       = 1'b0;
      emac_penable    = 1'b0;
      emac_paddr      = 10'd0;
      emac_pwrite     = 1'b0;
      emac_pwdata     = 32'd0;
      emac_pwdata_par = 4'h0;

      mmsl_psel       = 1'b0;
      mmsl_penable    = 1'b0;
      mmsl_paddr      = 6'd0;
      mmsl_pwrite     = 1'b0;
      mmsl_pwdata     = 32'd0;
      mmsl_pwdata_par = 4'h0;
    end
  else
    begin
      if(decode_paddr >= 5'b10000) // eMAC address (greater than equal to 0x1000)
        begin
          emac_psel       = psel;
          emac_penable    = penable;
          emac_paddr      = paddr[11:2];
          emac_pwrite     = pwrite;
          emac_pwdata     = pwdata;
          emac_pwdata_par = pwdata_par;

          pmac_psel       = 1'b0;
          pmac_penable    = 1'b0;
          pmac_paddr      = 10'd0;
          pmac_pwrite     = 1'b0;
          pmac_pwdata     = 32'd0;
          pmac_pwdata_par = 4'h0;

          mmsl_psel       = 1'b0;
          mmsl_penable    = 1'b0;
          mmsl_paddr      = 6'd0;
          mmsl_pwrite     = 1'b0;
          mmsl_pwdata     = 32'd0;
          mmsl_pwdata_par = 4'h0;
        end
      else  // MMSL address (between 0x0f00 and 0x0ffc)
        begin
          mmsl_psel       = psel;
          mmsl_penable    = penable;
          mmsl_paddr      = paddr[7:2];
          mmsl_pwrite     = pwrite;
          mmsl_pwdata     = pwdata;
          mmsl_pwdata_par = pwdata_par;

          emac_psel       = 1'b0;
          emac_penable    = 1'b0;
          emac_paddr      = 10'd0;
          emac_pwrite     = 1'b0;
          emac_pwdata     = 32'd0;
          emac_pwdata_par = 4'h0;

          pmac_psel       = 1'b0;
          pmac_penable    = 1'b0;
          pmac_paddr      = 4'd0;
          pmac_pwrite     = 1'b0;
          pmac_pwdata     = 32'd0;
          pmac_pwdata_par = 4'h0;
        end
    end
end
assign prdata  = mmsl_prdata | emac_prdata | pmac_prdata;
assign prdata_par = mmsl_prdata_par | emac_prdata_par | pmac_prdata_par;
assign pslverr = mmsl_pslverr | emac_pslverr | pmac_pslverr;

endmodule

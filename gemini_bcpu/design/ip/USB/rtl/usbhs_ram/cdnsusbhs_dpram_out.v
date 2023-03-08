//------------------------------------------------------------------------------
// Copyright (c) 2019 Cadence Design Systems, Inc.
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
//   Filename:           cdnsusbhs_dpram_out.v
//   Module Name:        cdnsusbhs_dpram_out
//
//   Release Revision:   R128_F015
//   Release SVN Tag:    USBHS_DUS1301_R128_F015_H03X32T08A32
//
//   IP Name:            USBHS-OTG
//   IP Part Number:     IP4010E
//
//   Product Type:       Configurable
//   IP Type:            Soft IP
//   IP Family:          USB
//   Technology:         N/A
//   Protocol:           USB2
//   Architecture:       OTGCTL
//   Licensable IP:      N/A
//
//------------------------------------------------------------------------------
//   Description:
//   On-Chip RAM - USBHS endpoint buffer
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_dpram_out
  (
  clka,
  addra,
  dina,
  wea,
  clkb,
  addrb,
  enb,
  dob
  );

  parameter ADDR_WIDTH   = 32'd`CDNSUSBHS_OUTADD;
  parameter DATA_WIDTH   = 32'd32;
  parameter MEMORY_DEPTH = (32'd`CDNSUSBHS_EPOUT_ENDADDR + 32'd1) / 32'd4;

  input                            clka;
  input  [ADDR_WIDTH-1:0]          addra;
  input  [DATA_WIDTH-1:0]          dina;
  input  [DATA_WIDTH/8-1:0]        wea;
  input                            clkb;
  input  [ADDR_WIDTH-1:0]          addrb;
  input                            enb;
  output [DATA_WIDTH-1:0]          dob;
  `ifdef CDNSUSBHS_DATA_DPRAM
  reg    [DATA_WIDTH-1:0]          dob;
  `else
  wire   [DATA_WIDTH-1:0]          dob;
  `endif

  `ifdef CDNSUSBHS_DATA_DPRAM
  `else
  reg    [ADDR_WIDTH-1:0]          addrb_r;
  `ifdef CDNSUSBHS_SIMULATE
  reg                              enb_r;
  `endif
  `endif

  reg    [7:0]                     mem_3 [MEMORY_DEPTH-1:0];
  reg    [7:0]                     mem_2 [MEMORY_DEPTH-1:0];
  reg    [7:0]                     mem_1 [MEMORY_DEPTH-1:0];
  reg    [7:0]                     mem_0 [MEMORY_DEPTH-1:0];



  `ifdef CDNSUSBHS_MEMORY_INIT
  initial
    begin : MEMORY_INIT
      integer i;
    for(i = MEMORY_DEPTH-1; i >= 0; i = i - 1)
      begin
      mem_3[i] = {8{1'b0}};
      mem_2[i] = {8{1'b0}};
      mem_1[i] = {8{1'b0}};
      mem_0[i] = {8{1'b0}};
      end
    end
  `endif



  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  always @(posedge clka)
  `else
  always @(negedge clka)
  `endif
    begin : MEMORY_LAB

    if (wea[3] == 1'b1)      mem_3[addra] <= dina[31:24] ;
    if (wea[2] == 1'b1)      mem_2[addra] <= dina[23:16] ;
    if (wea[1] == 1'b1)      mem_1[addra] <= dina[15:8] ;
    if (wea[0] == 1'b1)      mem_0[addra] <= dina[7:0] ;
    end

  `ifdef CDNSUSBHS_DATA_DPRAM



  `ifdef CDNSUSBHS_SIMULATE
  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  always @(posedge clkb)
  `else
  always @(negedge clkb)
  `endif
  `ifdef CDNSUSBHS_NO_Z_ON_DATA
    begin : READER_PROC
    if (enb == 1'b1)         dob <= {mem_3[addrb], mem_2[addrb],
                                     mem_1[addrb], mem_0[addrb]} ;
    else                     dob <= {DATA_WIDTH{1'b0}} ;
    end
  `else
    begin : READER_PROC
    if (enb == 1'b1)         dob <= {mem_3[addrb], mem_2[addrb],
                                     mem_1[addrb], mem_0[addrb]} ;
    else                     dob <= {DATA_WIDTH{1'bz}} ;
    end
  `endif
  `else
  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  always @(posedge clkb)
  `else
  always @(negedge clkb)
  `endif
    begin : READER_PROC
    if (enb == 1'b1)         dob <= {mem_3[addrb], mem_2[addrb],
                                     mem_1[addrb], mem_0[addrb]} ;
    end
  `endif

  `else



  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  always @(posedge clkb)
  `else
  always @(negedge clkb)
  `endif
    begin : READER_PROC
    if (enb == 1'b1)         addrb_r <= addrb ;
    end

  `ifdef CDNSUSBHS_SIMULATE



  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  always @(posedge clkb)
  `else
  always @(negedge clkb)
  `endif
    begin : ENB_PROC
    enb_r <= enb ;
    end
  `endif




  `ifdef CDNSUSBHS_SIMULATE
  `ifdef CDNSUSBHS_NO_Z_ON_DATA
  assign dob = (enb_r == 1'b1) ? {mem_3[addrb_r], mem_2[addrb_r],
                                  mem_1[addrb_r], mem_0[addrb_r]} :
                                 {DATA_WIDTH{1'b0}} ;
  `else
  assign dob = (enb_r == 1'b1) ? {mem_3[addrb_r], mem_2[addrb_r],
                                  mem_1[addrb_r], mem_0[addrb_r]} :
                                 {DATA_WIDTH{1'bz}} ;
  `endif
  `else
  assign dob = {mem_3[addrb_r], mem_2[addrb_r],
                mem_1[addrb_r], mem_0[addrb_r]} ;
  `endif
  `endif

  `ifdef CDNSUSBHS_SIMULATE


  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  always @(posedge clka)
  `else
  always @(negedge clka)
  `endif
    begin : A_B_ACCESS_PROC
    if (|wea == 1'b1 && enb == 1'b1)
      begin
      if (addra == addrb)
        begin
        $display("*E %m %t : Write Read conflict at %h address", $time, addra);
        end
      end
    end



  `ifdef CDNSUSBHS_POSEDGE_CLOCK
  always @(posedge clkb)
  `else
  always @(negedge clkb)
  `endif
    begin : B_A_ACCESS_PROC
    if (|wea == 1'b1 && enb == 1'b1)
      begin
      if (addra == addrb)
        begin
        $display("*E %m %t : Read Write conflict at %h address", $time, addrb);
        end
      end
    end
  `endif

endmodule

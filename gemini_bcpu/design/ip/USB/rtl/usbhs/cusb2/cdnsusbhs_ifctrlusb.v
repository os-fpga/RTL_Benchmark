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
//   Filename:           cdnsusbhs_ifctrlusb.v
//   Module Name:        cdnsusbhs_ifctrlusb
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
//   Interfaces controller
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_ifctrlusb
  (
  usbclk,
  usbrst,

  tendp,

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  usbfifoptrrd15,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  usbfifoptrrd14,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  usbfifoptrrd13,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  usbfifoptrrd12,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  usbfifoptrrd11,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  usbfifoptrrd10,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  usbfifoptrrd9,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  usbfifoptrrd8,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  usbfifoptrrd7,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  usbfifoptrrd6,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  usbfifoptrrd5,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  usbfifoptrrd4,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  usbfifoptrrd3,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  usbfifoptrrd2,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  usbfifoptrrd1,
  `endif
  usbfifoptrrd0,

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  usbfifoptrwr15,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  usbfifoptrwr14,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  usbfifoptrwr13,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  usbfifoptrwr12,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  usbfifoptrwr11,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  usbfifoptrwr10,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  usbfifoptrwr9,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  usbfifoptrwr8,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  usbfifoptrwr7,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  usbfifoptrwr6,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  usbfifoptrwr5,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  usbfifoptrwr4,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  usbfifoptrwr3,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  usbfifoptrwr2,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  usbfifoptrwr1,
  `endif
  usbfifoptrwr0,

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  out15startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  out14startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  out13startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  out12startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  out11startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  out10startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  out9startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  out8startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  out7startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  out6startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  out5startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  out4startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  out3startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  out2startaddr,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  out1startaddr,
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  in15startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  in14startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  in13startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  in12startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  in11startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  in10startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  in9startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  in8startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  in7startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  in6startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  in5startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  in4startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  in3startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  in2startaddr,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  in1startaddr,
  `endif

  outwr,
  outdatawr,

  inrd,
  indatard,

  out_rama_addr,
  out_rama_wr,
  out_rama_data,

  in_ramb_addr,
  in_ramb_rd,
  in_ramb_data
  );

  parameter OUTADDRWIDTH = 32'd`CDNSUSBHS_OUTADDRWIDTH;
  parameter INADDRWIDTH  = 32'd`CDNSUSBHS_INADDRWIDTH;



  input                            usbclk;
  input                            usbrst;

  input  [3:0]                     tendp;

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  input  [11:0]                    usbfifoptrrd15;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  input  [11:0]                    usbfifoptrrd14;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  input  [11:0]                    usbfifoptrrd13;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  input  [11:0]                    usbfifoptrrd12;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  input  [11:0]                    usbfifoptrrd11;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  input  [11:0]                    usbfifoptrrd10;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  input  [11:0]                    usbfifoptrrd9;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  input  [11:0]                    usbfifoptrrd8;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  input  [11:0]                    usbfifoptrrd7;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  input  [11:0]                    usbfifoptrrd6;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  input  [11:0]                    usbfifoptrrd5;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  input  [11:0]                    usbfifoptrrd4;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  input  [11:0]                    usbfifoptrrd3;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  input  [11:0]                    usbfifoptrrd2;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  input  [11:0]                    usbfifoptrrd1;
  `endif
  input  [11:0]                    usbfifoptrrd0;

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  input  [11:0]                    usbfifoptrwr15;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  input  [11:0]                    usbfifoptrwr14;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  input  [11:0]                    usbfifoptrwr13;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  input  [11:0]                    usbfifoptrwr12;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  input  [11:0]                    usbfifoptrwr11;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  input  [11:0]                    usbfifoptrwr10;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  input  [11:0]                    usbfifoptrwr9;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  input  [11:0]                    usbfifoptrwr8;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  input  [11:0]                    usbfifoptrwr7;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  input  [11:0]                    usbfifoptrwr6;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  input  [11:0]                    usbfifoptrwr5;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  input  [11:0]                    usbfifoptrwr4;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  input  [11:0]                    usbfifoptrwr3;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  input  [11:0]                    usbfifoptrwr2;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  input  [11:0]                    usbfifoptrwr1;
  `endif
  input  [11:0]                    usbfifoptrwr0;

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  input  [OUTADDRWIDTH-1:2]        out15startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  input  [OUTADDRWIDTH-1:2]        out14startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  input  [OUTADDRWIDTH-1:2]        out13startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  input  [OUTADDRWIDTH-1:2]        out12startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  input  [OUTADDRWIDTH-1:2]        out11startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  input  [OUTADDRWIDTH-1:2]        out10startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  input  [OUTADDRWIDTH-1:2]        out9startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  input  [OUTADDRWIDTH-1:2]        out8startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  input  [OUTADDRWIDTH-1:2]        out7startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  input  [OUTADDRWIDTH-1:2]        out6startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  input  [OUTADDRWIDTH-1:2]        out5startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  input  [OUTADDRWIDTH-1:2]        out4startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  input  [OUTADDRWIDTH-1:2]        out3startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  input  [OUTADDRWIDTH-1:2]        out2startaddr;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  input  [OUTADDRWIDTH-1:2]        out1startaddr;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  input  [INADDRWIDTH-1:2]         in15startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  input  [INADDRWIDTH-1:2]         in14startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  input  [INADDRWIDTH-1:2]         in13startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  input  [INADDRWIDTH-1:2]         in12startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  input  [INADDRWIDTH-1:2]         in11startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  input  [INADDRWIDTH-1:2]         in10startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  input  [INADDRWIDTH-1:2]         in9startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  input  [INADDRWIDTH-1:2]         in8startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  input  [INADDRWIDTH-1:2]         in7startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  input  [INADDRWIDTH-1:2]         in6startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  input  [INADDRWIDTH-1:2]         in5startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  input  [INADDRWIDTH-1:2]         in4startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  input  [INADDRWIDTH-1:2]         in3startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  input  [INADDRWIDTH-1:2]         in2startaddr;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  input  [INADDRWIDTH-1:2]         in1startaddr;
  `endif

  input                            outwr;
  input  [7:0]                     outdatawr;

  input                            inrd;
  output [7:0]                     indatard;
  wire   [7:0]                     indatard;

  output [`CDNSUSBHS_OUTADD-1:0]   out_rama_addr;
  wire   [`CDNSUSBHS_OUTADD-1:0]   out_rama_addr;
  output [3:0]                     out_rama_wr;
  wire   [3:0]                     out_rama_wr;
  output [31:0]                    out_rama_data;
  wire   [31:0]                    out_rama_data;

  output [`CDNSUSBHS_INADD-1:0]    in_ramb_addr;
  wire   [`CDNSUSBHS_INADD-1:0]    in_ramb_addr;
  output                           in_ramb_rd;
  wire                             in_ramb_rd;
  input  [31:0]                    in_ramb_data;

  reg    [`CDNSUSBHS_OUTADDWR-1:0] outaddrwr;

  reg    [`CDNSUSBHS_INADDRD-1:0]  inaddrrd;

  reg    [1:0]                     inaddrrd_r;
  reg                              inrd_r;
  wire   [7:0]                     in_rddata;
  reg    [7:0]                     in_rddata_r;

  wire   [11:0]                    inaddrrd_arg1;
  `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
  `else
  wire   [INADDRWIDTH-3:0]         inaddrrd_arg2;
  `endif

  wire   [11:0]                    outaddrwr_arg1;
  `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
  `else
  wire   [OUTADDRWIDTH-3:0]        outaddrwr_arg2;
  `endif



  assign inaddrrd_arg1 =
      `ifdef CDNSUSBHS_EPIN_EXIST_15
                         (tendp == 4'hF) ? usbfifoptrrd15 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_14
                         (tendp == 4'hE) ? usbfifoptrrd14 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_13
                         (tendp == 4'hD) ? usbfifoptrrd13 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_12
                         (tendp == 4'hC) ? usbfifoptrrd12 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_11
                         (tendp == 4'hB) ? usbfifoptrrd11 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_10
                         (tendp == 4'hA) ? usbfifoptrrd10 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_9
                         (tendp == 4'h9) ? usbfifoptrrd9 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_8
                         (tendp == 4'h8) ? usbfifoptrrd8 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_7
                         (tendp == 4'h7) ? usbfifoptrrd7 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_6
                         (tendp == 4'h6) ? usbfifoptrrd6 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_5
                         (tendp == 4'h5) ? usbfifoptrrd5 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_4
                         (tendp == 4'h4) ? usbfifoptrrd4 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_3
                         (tendp == 4'h3) ? usbfifoptrrd3 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_2
                         (tendp == 4'h2) ? usbfifoptrrd2 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_1
                         (tendp == 4'h1) ? usbfifoptrrd1 :
      `endif
                                           usbfifoptrrd0 ;

    `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
    `else


  assign inaddrrd_arg2 =
      `ifdef CDNSUSBHS_EPIN_EXIST_15
                         (tendp == 4'hF) ? in15startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_14
                         (tendp == 4'hE) ? in14startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_13
                         (tendp == 4'hD) ? in13startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_12
                         (tendp == 4'hC) ? in12startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_11
                         (tendp == 4'hB) ? in11startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_10
                         (tendp == 4'hA) ? in10startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_9
                         (tendp == 4'h9) ? in9startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_8
                         (tendp == 4'h8) ? in8startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_7
                         (tendp == 4'h7) ? in7startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_6
                         (tendp == 4'h6) ? in6startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_5
                         (tendp == 4'h5) ? in5startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_4
                         (tendp == 4'h4) ? in4startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_3
                         (tendp == 4'h3) ? in3startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_2
                         (tendp == 4'h2) ? in2startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_1
                         (tendp == 4'h1) ? in1startaddr :
      `endif
                                           {INADDRWIDTH-2{1'b0}};
    `endif




  `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
  always @(inaddrrd_arg1)
    begin : INADDRRD_COMB_PROC
      reg [15:0] inaddrrd_v;
      integer    i;


    inaddrrd   = {`CDNSUSBHS_INADDRD{1'b0}};
    inaddrrd_v = {16{1'b0}};

    inaddrrd_v = {4'b0000, inaddrrd_arg1};



    for(i = `CDNSUSBHS_INADDRD; i >= 1; i = i - 1)
      begin

      inaddrrd[`CDNSUSBHS_INADDRD-i] = inaddrrd_v[INADDRWIDTH-i];
      end

    end
  `else
  always @(inaddrrd_arg1 or inaddrrd_arg2)
    begin : INADDRRD_COMB_PROC
      reg [15:0] inaddrrd_v;
      reg [15:0] inaddrrd_arg2_v;
      integer    i;


    inaddrrd   = {`CDNSUSBHS_INADDRD{1'b0}};
    inaddrrd_v = {16{1'b0}};

    inaddrrd_arg2_v                  = {16{1'b0}};
    inaddrrd_arg2_v[INADDRWIDTH-1:2] = inaddrrd_arg2;

    inaddrrd_v = {4'b0000, inaddrrd_arg1} + inaddrrd_arg2_v;



    for(i = `CDNSUSBHS_INADDRD; i >= 1; i = i - 1)
      begin

      inaddrrd[`CDNSUSBHS_INADDRD-i] = inaddrrd_v[INADDRWIDTH-i];
      end

    end
  `endif



  assign outaddrwr_arg1 =
      `ifdef CDNSUSBHS_EPOUT_EXIST_15
                          (tendp == 4'hF) ? usbfifoptrwr15 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_14
                          (tendp == 4'hE) ? usbfifoptrwr14 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_13
                          (tendp == 4'hD) ? usbfifoptrwr13 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_12
                          (tendp == 4'hC) ? usbfifoptrwr12 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_11
                          (tendp == 4'hB) ? usbfifoptrwr11 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_10
                          (tendp == 4'hA) ? usbfifoptrwr10 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_9
                          (tendp == 4'h9) ? usbfifoptrwr9 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_8
                          (tendp == 4'h8) ? usbfifoptrwr8 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_7
                          (tendp == 4'h7) ? usbfifoptrwr7 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_6
                          (tendp == 4'h6) ? usbfifoptrwr6 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_5
                          (tendp == 4'h5) ? usbfifoptrwr5 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_4
                          (tendp == 4'h4) ? usbfifoptrwr4 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_3
                          (tendp == 4'h3) ? usbfifoptrwr3 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_2
                          (tendp == 4'h2) ? usbfifoptrwr2 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_1
                          (tendp == 4'h1) ? usbfifoptrwr1 :
      `endif
                                            usbfifoptrwr0 ;

    `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
    `else


  assign outaddrwr_arg2 =
      `ifdef CDNSUSBHS_EPOUT_EXIST_15
                          (tendp == 4'hF) ? out15startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_14
                          (tendp == 4'hE) ? out14startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_13
                          (tendp == 4'hD) ? out13startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_12
                          (tendp == 4'hC) ? out12startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_11
                          (tendp == 4'hB) ? out11startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_10
                          (tendp == 4'hA) ? out10startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_9
                          (tendp == 4'h9) ? out9startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_8
                          (tendp == 4'h8) ? out8startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_7
                          (tendp == 4'h7) ? out7startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_6
                          (tendp == 4'h6) ? out6startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_5
                          (tendp == 4'h5) ? out5startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_4
                          (tendp == 4'h4) ? out4startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_3
                          (tendp == 4'h3) ? out3startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_2
                          (tendp == 4'h2) ? out2startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_1
                          (tendp == 4'h1) ? out1startaddr :
      `endif
                                            {OUTADDRWIDTH-2{1'b0}};
    `endif




  `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
  always @(outaddrwr_arg1)
    begin : OUTADDRWR_COMB_PROC
      reg [15:0] outaddrwr_v;
      integer    i;


    outaddrwr   = {`CDNSUSBHS_OUTADDWR{1'b0}};
    outaddrwr_v = {16{1'b0}};

    outaddrwr_v = {4'b0000, outaddrwr_arg1};



    for(i = `CDNSUSBHS_OUTADDWR; i >= 1; i = i - 1)
      begin

      outaddrwr[`CDNSUSBHS_OUTADDWR-i] = outaddrwr_v[OUTADDRWIDTH-i];
      end

    end
  `else
  always @(outaddrwr_arg1 or outaddrwr_arg2)
    begin : OUTADDRWR_COMB_PROC
      reg [15:0] outaddrwr_v;
      reg [15:0] outaddrwr_arg2_v;
      integer    i;


    outaddrwr   = {`CDNSUSBHS_OUTADDWR{1'b0}};
    outaddrwr_v = {16{1'b0}};

    outaddrwr_arg2_v                   = {16{1'b0}};
    outaddrwr_arg2_v[OUTADDRWIDTH-1:2] = outaddrwr_arg2;

    outaddrwr_v = {4'b0000, outaddrwr_arg1} + outaddrwr_arg2_v;



    for(i = `CDNSUSBHS_OUTADDWR; i >= 1; i = i - 1)
      begin

      outaddrwr[`CDNSUSBHS_OUTADDWR-i] = outaddrwr_v[OUTADDRWIDTH-i];
      end

    end
  `endif








  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : INADDRRD_R_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      inaddrrd_r <= 2'b00;
      end
    else
      begin
      if (inrd == 1'b1)
        begin
        inaddrrd_r <= inaddrrd[1:0] ;
        end
      end
    end




  `CDNSUSBHS_ALWAYS(usbclk,usbrst)
    begin : IN_RDDATA_R_PROC
    if `CDNSUSBHS_RESET(usbrst)
      begin
      in_rddata_r <= {8{1'b0}};
      inrd_r      <= 1'b0 ;
      end
    else
      begin
      inrd_r <= inrd ;
      if (inrd_r == 1'b1)
        begin
        in_rddata_r <= in_rddata ;
        end
      end
    end



  assign indatard = (inrd_r == 1'b1) ? in_rddata :
                                       in_rddata_r ;




  assign in_ramb_addr = inaddrrd[`CDNSUSBHS_INADDRD-1:2] ;
  assign in_ramb_rd   = inrd;
  assign in_rddata    = (inaddrrd_r[1:0] == 2'b11) ? in_ramb_data[31:24] :
                        (inaddrrd_r[1:0] == 2'b10) ? in_ramb_data[23:16] :
                        (inaddrrd_r[1:0] == 2'b01) ? in_ramb_data[15:8]  :
                                                     in_ramb_data[7:0] ;








  assign out_rama_addr = outaddrwr[`CDNSUSBHS_OUTADDWR-1:2] ;
  assign out_rama_data = {4{outdatawr}} ;
  assign out_rama_wr   = (outwr == 1'b0)           ? 4'h0 :
                         (outaddrwr[1:0] == 2'b11) ? 4'h8 :
                         (outaddrwr[1:0] == 2'b10) ? 4'h4 :
                         (outaddrwr[1:0] == 2'b01) ? 4'h2 :
                                                     4'h1 ;

endmodule

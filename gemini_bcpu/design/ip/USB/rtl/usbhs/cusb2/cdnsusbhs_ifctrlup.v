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
//   Filename:           cdnsusbhs_ifctrlup.v
//   Module Name:        cdnsusbhs_ifctrlup
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



module cdnsusbhs_ifctrlup
  (
  upclk,
  uprst,

  fifoaccrd,
  fifoaccwr,

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  upfifoptrrd15,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  upfifoptrrd14,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  upfifoptrrd13,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  upfifoptrrd12,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  upfifoptrrd11,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  upfifoptrrd10,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  upfifoptrrd9,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  upfifoptrrd8,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  upfifoptrrd7,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  upfifoptrrd6,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  upfifoptrrd5,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  upfifoptrrd4,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  upfifoptrrd3,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  upfifoptrrd2,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  upfifoptrrd1,
  `endif
  upfifoptrrd0,

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  upfifoptrwr15,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  upfifoptrwr14,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  upfifoptrwr13,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  upfifoptrwr12,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  upfifoptrwr11,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  upfifoptrwr10,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  upfifoptrwr9,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  upfifoptrwr8,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  upfifoptrwr7,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  upfifoptrwr6,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  upfifoptrwr5,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  upfifoptrwr4,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  upfifoptrwr3,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  upfifoptrwr2,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  upfifoptrwr1,
  `endif
  upfifoptrwr0,

  fifoinfull,
  fifoinafull,
  fifooutempty,

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  fifooutbc15,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  fifooutbc14,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  fifooutbc13,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  fifooutbc12,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  fifooutbc11,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  fifooutbc10,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  fifooutbc9,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  fifooutbc8,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  fifooutbc7,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  fifooutbc6,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  fifooutbc5,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  fifooutbc4,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  fifooutbc3,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  fifooutbc2,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  fifooutbc1,
  `endif
  fifooutbc0,

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

  fifoinaddr,
  fifooutaddr,
  fifodatai,
  fiford,
  fifowr,
  upaddr,
  updatai,
  upwr,
  uprd,
  upbe_rd,
  upbe_wr,
  sfrdata,
  ep0data,

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  epoutdata15,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  epoutdata14,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  epoutdata13,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  epoutdata12,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  epoutdata11,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  epoutdata10,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  epoutdata9,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  epoutdata8,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  epoutdata7,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  epoutdata6,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  epoutdata5,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  epoutdata4,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  epoutdata3,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  epoutdata2,
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  epoutdata1,
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  epindata15,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  epindata14,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  epindata13,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  epindata12,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  epindata11,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  epindata10,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  epindata9,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  epindata8,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  epindata7,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  epindata6,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  epindata5,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  epindata4,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  epindata3,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  epindata2,
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  epindata1,
  `endif

  outptrinc,
  fifodatao,
  fifofull,
  fifoafull,
  fifoempty,
  fifobc,
  fifooutrdff,
  fifoctrl_7,
  updatao,

  out_ramb_addr,
  out_ramb_rd,
  out_ramb_data,

  in_rama_addr,
  in_rama_wr,
  in_rama_data
  );

  parameter OUTADDRWIDTH = 32'd`CDNSUSBHS_OUTADDRWIDTH;
  parameter INADDRWIDTH  = 32'd`CDNSUSBHS_INADDRWIDTH;

  parameter EPINEXIST    = `CDNSUSBHS_EPINEXIST;
  parameter EPOUTEXIST   = `CDNSUSBHS_EPOUTEXIST;



  input                            upclk;
  input                            uprst;

  output                           fifoaccrd;
  wire                             fifoaccrd;
  output                           fifoaccwr;
  wire                             fifoaccwr;

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  input  [11:0]                    upfifoptrrd15;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  input  [11:0]                    upfifoptrrd14;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  input  [11:0]                    upfifoptrrd13;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  input  [11:0]                    upfifoptrrd12;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  input  [11:0]                    upfifoptrrd11;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  input  [11:0]                    upfifoptrrd10;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  input  [11:0]                    upfifoptrrd9;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  input  [11:0]                    upfifoptrrd8;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  input  [11:0]                    upfifoptrrd7;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  input  [11:0]                    upfifoptrrd6;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  input  [11:0]                    upfifoptrrd5;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  input  [11:0]                    upfifoptrrd4;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  input  [11:0]                    upfifoptrrd3;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  input  [11:0]                    upfifoptrrd2;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  input  [11:0]                    upfifoptrrd1;
  `endif
  input  [11:0]                    upfifoptrrd0;

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  input  [11:0]                    upfifoptrwr15;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  input  [11:0]                    upfifoptrwr14;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  input  [11:0]                    upfifoptrwr13;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  input  [11:0]                    upfifoptrwr12;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  input  [11:0]                    upfifoptrwr11;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  input  [11:0]                    upfifoptrwr10;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  input  [11:0]                    upfifoptrwr9;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  input  [11:0]                    upfifoptrwr8;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  input  [11:0]                    upfifoptrwr7;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  input  [11:0]                    upfifoptrwr6;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  input  [11:0]                    upfifoptrwr5;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  input  [11:0]                    upfifoptrwr4;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  input  [11:0]                    upfifoptrwr3;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  input  [11:0]                    upfifoptrwr2;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  input  [11:0]                    upfifoptrwr1;
  `endif
  input  [11:0]                    upfifoptrwr0;

  input  [15:0]                    fifoinfull;
  input  [15:1]                    fifoinafull;
  input  [15:0]                    fifooutempty;

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  input  [10:0]                    fifooutbc15;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  input  [10:0]                    fifooutbc14;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  input  [10:0]                    fifooutbc13;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  input  [10:0]                    fifooutbc12;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  input  [10:0]                    fifooutbc11;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  input  [10:0]                    fifooutbc10;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  input  [10:0]                    fifooutbc9;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  input  [10:0]                    fifooutbc8;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  input  [10:0]                    fifooutbc7;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  input  [10:0]                    fifooutbc6;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  input  [10:0]                    fifooutbc5;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  input  [10:0]                    fifooutbc4;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  input  [10:0]                    fifooutbc3;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  input  [10:0]                    fifooutbc2;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  input  [10:0]                    fifooutbc1;
  `endif
  input  [10:0]                    fifooutbc0;

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

  input  [3:0]                     fifoinaddr;
  input  [3:0]                     fifooutaddr;
  input  [31:0]                    fifodatai;
  input                            fiford;
  input                            fifowr;
  input  [7:0]                     upaddr;
  input  [31:0]                    updatai;
  input                            upwr;
  input                            uprd;
  input  [3:0]                     upbe_rd;
  input  [3:0]                     upbe_wr;
  input  [31:0]                    sfrdata;
  input  [31:0]                    ep0data;

  `ifdef CDNSUSBHS_EPOUT_EXIST_15
  input  [31:0]                    epoutdata15;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_14
  input  [31:0]                    epoutdata14;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_13
  input  [31:0]                    epoutdata13;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_12
  input  [31:0]                    epoutdata12;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_11
  input  [31:0]                    epoutdata11;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_10
  input  [31:0]                    epoutdata10;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_9
  input  [31:0]                    epoutdata9;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_8
  input  [31:0]                    epoutdata8;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_7
  input  [31:0]                    epoutdata7;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_6
  input  [31:0]                    epoutdata6;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_5
  input  [31:0]                    epoutdata5;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_4
  input  [31:0]                    epoutdata4;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_3
  input  [31:0]                    epoutdata3;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_2
  input  [31:0]                    epoutdata2;
  `endif
  `ifdef CDNSUSBHS_EPOUT_EXIST_1
  input  [31:0]                    epoutdata1;
  `endif

  `ifdef CDNSUSBHS_EPIN_EXIST_15
  input  [31:0]                    epindata15;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_14
  input  [31:0]                    epindata14;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_13
  input  [31:0]                    epindata13;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_12
  input  [31:0]                    epindata12;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_11
  input  [31:0]                    epindata11;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_10
  input  [31:0]                    epindata10;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_9
  input  [31:0]                    epindata9;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_8
  input  [31:0]                    epindata8;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_7
  input  [31:0]                    epindata7;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_6
  input  [31:0]                    epindata6;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_5
  input  [31:0]                    epindata5;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_4
  input  [31:0]                    epindata4;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_3
  input  [31:0]                    epindata3;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_2
  input  [31:0]                    epindata2;
  `endif
  `ifdef CDNSUSBHS_EPIN_EXIST_1
  input  [31:0]                    epindata1;
  `endif

  output [15:1]                    outptrinc;
  wire   [15:1]                    outptrinc;
  output [31:0]                    fifodatao;
  wire   [31:0]                    fifodatao;
  output [15:0]                    fifofull;
  wire   [15:0]                    fifofull;
  output [15:0]                    fifoafull;
  wire   [15:0]                    fifoafull;
  output [15:0]                    fifoempty;
  wire   [15:0]                    fifoempty;
  output [10:0]                    fifobc;
  wire   [10:0]                    fifobc;
  output                           fifooutrdff;
  reg                              fifooutrdff;
  input                            fifoctrl_7;
  output [31:0]                    updatao;
  reg    [31:0]                    updatao;

  output [`CDNSUSBHS_OUTADD-1:0]   out_ramb_addr;
  wire   [`CDNSUSBHS_OUTADD-1:0]   out_ramb_addr;
  output                           out_ramb_rd;
  wire                             out_ramb_rd;
  input  [31:0]                    out_ramb_data;

  output [`CDNSUSBHS_INADD-1:0]    in_rama_addr;
  wire   [`CDNSUSBHS_INADD-1:0]    in_rama_addr;
  output [3:0]                     in_rama_wr;
  wire   [3:0]                     in_rama_wr;
  output [31:0]                    in_rama_data;
  wire   [31:0]                    in_rama_data;

  reg    [`CDNSUSBHS_OUTADDRD-1:0] outaddrrd;
  wire                             outrd;
  wire   [31:0]                    outdatard;

  reg    [`CDNSUSBHS_INADDWR-1:0]  inaddrwr;
  wire                             inwr;
  reg    [31:0]                    indatawr;
  reg    [3:0]                     indataval;

  reg                              outrd_r;

  wire   [31:0]                    out_rddata;
  reg    [31:0]                    out_rddata_r;

  wire   [31:0]                    sfrdata_mux;
  reg    [31:0]                    sfrdata_mux_ff;
  reg    [1:0]                     out_addr_rd_nxt;
  reg    [1:0]                     out_addr_rd;
  reg    [1:0]                     in_addr_wr;
  wire   [15:0]                    fifooutempty_tmp;
  wire   [15:0]                    fifoinfull_tmp;
  wire   [15:0]                    fifoinafull_tmp;

  wire                             fifoaccrd_epx;
  reg                              fifoaccrd_epx_r;
  wire                             fifoaccwr_epx;
  wire   [31:0]                    outdatard_epx;
  wire   [31:0]                    outdatard_epx_16;
  wire   [31:0]                    outdatard_epx_8;

  wire                             fifoaccrd_ep0;
  reg                              fifoaccrd_ep0_r;
  wire                             fifoaccwr_ep0;
  wire   [31:0]                    outdatard_ep0;

  wire   [31:0]                    indatawr_epx;
  wire   [31:0]                    indatawr_ep0;
  wire   [31:0]                    indatawr_fifo;

  wire   [3:0]                     endpnr_in_s;
  wire   [3:0]                     endpnr_out_s;

  wire   [3:0]                     indataval_epx;
  wire   [3:0]                     indataval_ep0;
  wire   [3:0]                     indataval_fifo;
  reg    [3:0]                     fifooutaddr_ff;

  wire   [1:0]                     upaddr_offset;
  reg    [15:1]                    outptrinc_r;

  wire   [11:0]                    inaddrwr_arg1;
  `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
  `else
  wire   [INADDRWIDTH-3:0]         inaddrwr_arg2;
  `endif

  wire   [11:0]                    outaddrrd_arg1;
  `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
  `else
  wire   [OUTADDRWIDTH-3:0]        outaddrrd_arg2;
  `endif




  assign upaddr_offset = (upbe_wr == 4'hF) ? 2'b00 :
                         (upbe_wr == 4'hC) ? 2'b10 :
                         (upbe_wr == 4'h3) ? 2'b00 :
                         (upbe_wr == 4'h8) ? 2'b11 :
                         (upbe_wr == 4'h4) ? 2'b10 :
                         (upbe_wr == 4'h2) ? 2'b01 :
                                             2'b00 ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUTPTRINC_FF_SYNC_PROC
      integer i;
    if `CDNSUSBHS_RESET(uprst)
      begin
      outptrinc_r <= {15{1'b0}};
      end
    else
      begin
      for(i = 15; i >= 1; i = i - 1)
        begin
        if (upaddr[7:4] == 4'h2 &&
            upaddr[3:0] == i &&
            uprd == 1'b1)
          begin
          outptrinc_r[i] <= 1'b1;
          end
        else
          begin
          outptrinc_r[i] <= 1'b0;
          end
        end
      end
    end



  assign outptrinc = outptrinc_r & EPOUTEXIST[15:1];





  assign fifoaccrd_epx = (upaddr[7:4] == 4'h2 &&
                          upaddr[3:0] != 4'h0 &&
                                                 uprd == 1'b1) ? 1'b1 :
                                                                 1'b0 ;



  assign fifoaccwr_epx = (upaddr[7:4] == 4'h2 &&
                          upaddr[3:0] != 4'h0 &&
                                                 upwr == 1'b1) ? 1'b1 :
                                                                 1'b0 ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOACCRD_EPX_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoaccrd_epx_r <= 1'b0 ;
      end
    else
      begin

      fifoaccrd_epx_r <= fifoaccrd_epx ;
      end
    end




  assign fifoaccrd_ep0 = (upaddr[7:4] == 4'h5 &&
                                                    uprd == 1'b1) ? 1'b1 :
                                                                    1'b0 ;



  assign fifoaccwr_ep0 = (upaddr[7:4] == 4'h4 &&
                                                    upwr == 1'b1) ? 1'b1 :
                                                                    1'b0 ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOACCRD_EP0_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifoaccrd_ep0_r <= 1'b0 ;
      end
    else
      begin

      fifoaccrd_ep0_r <= fifoaccrd_ep0 ;
      end
    end



  assign fifoaccrd = (fifoaccrd_epx | fifoaccrd_ep0 | fifoctrl_7) ;



  assign fifoaccwr = (fifoaccwr_epx | fifoaccwr_ep0 | fifoctrl_7) ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT_ADDR_RD_SYNC_PROC



    if `CDNSUSBHS_RESET(uprst)
      begin
      out_addr_rd <= 2'b00;
      end
    else
      begin
      out_addr_rd <= out_addr_rd_nxt;
      end
    end




  assign fifooutempty_tmp = fifooutempty;


  assign fifoinfull_tmp   = fifoinfull;


  assign fifoinafull_tmp  = {fifoinafull, 1'b1};


  assign fifofull         = (fifoctrl_7 == 1'b1) ? {16{1'b1}} :
                                                   fifoinfull_tmp;


  assign fifoafull        = (fifoctrl_7 == 1'b1) ? {16{1'b1}} :
                                                   fifoinafull_tmp;


  assign fifoempty        = (fifoctrl_7 == 1'b1) ? {16{1'b1}} :
                                                   fifooutempty_tmp;




  assign fifobc =
                  `ifdef CDNSUSBHS_EPOUT_EXIST_15
                  (fifooutaddr_ff == 4'hF) ? fifooutbc15 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_14
                  (fifooutaddr_ff == 4'hE) ? fifooutbc14 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_13
                  (fifooutaddr_ff == 4'hD) ? fifooutbc13 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_12
                  (fifooutaddr_ff == 4'hC) ? fifooutbc12 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_11
                  (fifooutaddr_ff == 4'hB) ? fifooutbc11 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_10
                  (fifooutaddr_ff == 4'hA) ? fifooutbc10 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_9
                  (fifooutaddr_ff == 4'h9) ? fifooutbc9 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_8
                  (fifooutaddr_ff == 4'h8) ? fifooutbc8 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_7
                  (fifooutaddr_ff == 4'h7) ? fifooutbc7 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_6
                  (fifooutaddr_ff == 4'h6) ? fifooutbc6 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_5
                  (fifooutaddr_ff == 4'h5) ? fifooutbc5 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_4
                  (fifooutaddr_ff == 4'h4) ? fifooutbc4 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_3
                  (fifooutaddr_ff == 4'h3) ? fifooutbc3 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_2
                  (fifooutaddr_ff == 4'h2) ? fifooutbc2 :
                  `endif
                  `ifdef CDNSUSBHS_EPOUT_EXIST_1
                  (fifooutaddr_ff == 4'h1) ? fifooutbc1 :
                  `endif
                                             fifooutbc0 ;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOOUTADDR_SYNC_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifooutaddr_ff <= {4{1'b0}};
      end
    else
      begin
      fifooutaddr_ff <= fifooutaddr;
      end
    end



  assign fifodatao = outdatard;



  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : FIFOOUTRDFF_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      fifooutrdff <= 1'b0 ;
      end
    else
      begin
      fifooutrdff <= fiford ;
      end
    end




  assign outrd = (fifoaccrd_epx == 1'b1 ||
                  fifoaccrd_ep0 == 1'b1) ? uprd :
                                           fiford ;






  assign inwr = (fifoaccwr_epx == 1'b1 ||
                 fifoaccwr_ep0 == 1'b1) ? upwr :
                                          fifowr ;



  assign indatawr_fifo = fifodatai;



  assign indatawr_epx = (upbe_wr == 4'h1) ? {4{updatai[7:0]}} :
                        (upbe_wr == 4'h2) ? {4{updatai[15:8]}} :
                        (upbe_wr == 4'h4) ? {4{updatai[23:16]}} :
                        (upbe_wr == 4'h8) ? {4{updatai[31:24]}} :
                        (upbe_wr == 4'h3) ? {2{updatai[15:0]}} :
                        (upbe_wr == 4'hC) ? {2{updatai[31:16]}} :
                                               updatai;



  assign indatawr_ep0 = updatai;




  assign indataval_epx = (upbe_wr == 4'hF) ?
                            (
                             4'hF
                            ) :
                         (upbe_wr == 4'h3 || upbe_wr == 4'hC) ?
                            (
                             (in_addr_wr[1]   == 1'b1)  ? 4'hC :
                                                          4'h3
                            ) : (
                             (in_addr_wr[1:0] == 2'b00) ? 4'h1 :
                             (in_addr_wr[1:0] == 2'b01) ? 4'h2 :
                             (in_addr_wr[1:0] == 2'b10) ? 4'h4 :
                                                          4'h8
                            ) ;




  assign indataval_ep0 = upbe_wr;




  assign indataval_fifo = 4'hF;




  always @(fifoaccwr_epx or indataval_epx or
                            indataval_fifo or
           fifoaccwr_ep0 or indataval_ep0)
    begin : INDATAVAL_COMB_PROC



    if (fifoaccwr_epx == 1'b1)
      begin
      indataval = indataval_epx;
      end
    else if (fifoaccwr_ep0 == 1'b1)
      begin
      indataval = indataval_ep0;
      end
    else
      begin
      indataval = indataval_fifo;
      end
    end




  always @(fifoaccwr_epx or indatawr_epx or
                            indatawr_fifo or
           fifoaccwr_ep0 or indatawr_ep0)
    begin : INDATAWR_COMB_PROC



    if (fifoaccwr_epx == 1'b1)
      begin
      indatawr = indatawr_epx;
      end
    else if (fifoaccwr_ep0 == 1'b1)
      begin
      indatawr = indatawr_ep0;
      end
    else
      begin
      indatawr = indatawr_fifo;
      end
    end




  assign sfrdata_mux =
                      `ifdef CDNSUSBHS_EPIN_EXIST_15
                       epindata15  |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_14
                       epindata14  |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_13
                       epindata13  |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_12
                       epindata12  |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_11
                       epindata11  |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_10
                       epindata10  |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_9
                       epindata9   |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_8
                       epindata8   |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_7
                       epindata7   |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_6
                       epindata6   |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_5
                       epindata5   |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_4
                       epindata4   |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_3
                       epindata3   |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_2
                       epindata2   |
                      `endif
                      `ifdef CDNSUSBHS_EPIN_EXIST_1
                       epindata1   |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_15
                       epoutdata15 |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_14
                       epoutdata14 |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_13
                       epoutdata13 |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_12
                       epoutdata12 |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_11
                       epoutdata11 |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_10
                       epoutdata10 |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_9
                       epoutdata9  |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_8
                       epoutdata8  |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_7
                       epoutdata7  |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_6
                       epoutdata6  |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_5
                       epoutdata5  |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_4
                       epoutdata4  |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_3
                       epoutdata3  |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_2
                       epoutdata2  |
                      `endif
                      `ifdef CDNSUSBHS_EPOUT_EXIST_1
                       epoutdata1  |
                      `endif
                       ep0data     |
                       sfrdata;




  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : SFRDATA_MUX_FF_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      sfrdata_mux_ff <= {32{1'b0}};
      end
    else
      begin
      sfrdata_mux_ff <= sfrdata_mux;
      end
    end




  assign outdatard_epx_16 = (out_addr_rd[1] == 1'b0) ? {2{outdatard[15:0]}} :
                                                       {2{outdatard[31:16]}} ;
  assign outdatard_epx_8  = (out_addr_rd[1:0] == 2'b00) ? {4{outdatard[7:0]}} :
                            (out_addr_rd[1:0] == 2'b01) ? {4{outdatard[15:8]}} :
                            (out_addr_rd[1:0] == 2'b10) ? {4{outdatard[23:16]}} :
                                                          {4{outdatard[31:24]}} ;

  assign outdatard_epx = (upbe_rd == 4'hF) ? outdatard :
                         (upbe_rd == 4'h3 ||
                          upbe_rd == 4'hC) ? outdatard_epx_16 :
                                             outdatard_epx_8 ;




  assign outdatard_ep0 = outdatard ;




  always @(fifoaccrd_epx_r or outdatard_epx or
           fifoaccrd_ep0_r or outdatard_ep0 or
           sfrdata_mux_ff)
    begin : UPDATAO_COMB_PROC




    if (fifoaccrd_epx_r == 1'b1)
      begin

      updatao = outdatard_epx;
      end
    else if (fifoaccrd_ep0_r == 1'b1)
      begin

      updatao = outdatard_ep0;
      end
    else
      begin
      updatao = sfrdata_mux_ff ;
      end
    end




  assign endpnr_in_s = (fifoaccwr_epx == 1'b1) ? upaddr[3:0] :
                       (fifoaccwr_ep0 == 1'b1) ? 4'h0 :
                                                 fifoinaddr;




  assign endpnr_out_s = (fifoaccrd_epx == 1'b1) ? upaddr[3:0] :
                        (fifoaccrd_ep0 == 1'b1) ? 4'h0 :
                                                  fifooutaddr;



  assign inaddrwr_arg1 =
      `ifdef CDNSUSBHS_EPIN_EXIST_15
                         (endpnr_in_s == 4'hF) ? upfifoptrwr15 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_14
                         (endpnr_in_s == 4'hE) ? upfifoptrwr14 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_13
                         (endpnr_in_s == 4'hD) ? upfifoptrwr13 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_12
                         (endpnr_in_s == 4'hC) ? upfifoptrwr12 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_11
                         (endpnr_in_s == 4'hB) ? upfifoptrwr11 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_10
                         (endpnr_in_s == 4'hA) ? upfifoptrwr10 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_9
                         (endpnr_in_s == 4'h9) ? upfifoptrwr9 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_8
                         (endpnr_in_s == 4'h8) ? upfifoptrwr8 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_7
                         (endpnr_in_s == 4'h7) ? upfifoptrwr7 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_6
                         (endpnr_in_s == 4'h6) ? upfifoptrwr6 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_5
                         (endpnr_in_s == 4'h5) ? upfifoptrwr5 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_4
                         (endpnr_in_s == 4'h4) ? upfifoptrwr4 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_3
                         (endpnr_in_s == 4'h3) ? upfifoptrwr3 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_2
                         (endpnr_in_s == 4'h2) ? upfifoptrwr2 :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_1
                         (endpnr_in_s == 4'h1) ? upfifoptrwr1 :
      `endif
                       (fifoaccwr_ep0 == 1'b1) ? {6'b000000, upaddr[3:0], upaddr_offset} :
                                                 upfifoptrwr0 ;

    `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
    `else


  assign inaddrwr_arg2 =
      `ifdef CDNSUSBHS_EPIN_EXIST_15
                         (endpnr_in_s == 4'hF) ? in15startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_14
                         (endpnr_in_s == 4'hE) ? in14startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_13
                         (endpnr_in_s == 4'hD) ? in13startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_12
                         (endpnr_in_s == 4'hC) ? in12startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_11
                         (endpnr_in_s == 4'hB) ? in11startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_10
                         (endpnr_in_s == 4'hA) ? in10startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_9
                         (endpnr_in_s == 4'h9) ? in9startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_8
                         (endpnr_in_s == 4'h8) ? in8startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_7
                         (endpnr_in_s == 4'h7) ? in7startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_6
                         (endpnr_in_s == 4'h6) ? in6startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_5
                         (endpnr_in_s == 4'h5) ? in5startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_4
                         (endpnr_in_s == 4'h4) ? in4startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_3
                         (endpnr_in_s == 4'h3) ? in3startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_2
                         (endpnr_in_s == 4'h2) ? in2startaddr :
      `endif
      `ifdef CDNSUSBHS_EPIN_EXIST_1
                         (endpnr_in_s == 4'h1) ? in1startaddr :
      `endif
                                                 {INADDRWIDTH-2{1'b0}};
    `endif




  `ifdef CDNSUSBHS_OTHERS_EPIN_DO_NOT_EXIST
  always @(inaddrwr_arg1)
    begin : INADDRWR_COMB_PROC
      reg [15:0] inaddrwr_v;
      integer    i;


    inaddrwr   = {`CDNSUSBHS_INADDWR{1'b0}};
    inaddrwr_v = {16{1'b0}};

    inaddrwr_v = {4'b0000, inaddrwr_arg1};

    in_addr_wr = inaddrwr_v[1:0];



    for(i = `CDNSUSBHS_INADDWR; i >= 1; i = i - 1)
      begin

      inaddrwr[`CDNSUSBHS_INADDWR-i] = inaddrwr_v[INADDRWIDTH-i];
      end

    end
  `else
  always @(inaddrwr_arg1 or inaddrwr_arg2)
    begin : INADDRWR_COMB_PROC
      reg [15:0] inaddrwr_v;
      reg [15:0] inaddrwr_arg2_v;
      integer    i;


    inaddrwr   = {`CDNSUSBHS_INADDWR{1'b0}};
    inaddrwr_v = {16{1'b0}};

    inaddrwr_arg2_v                  = {16{1'b0}};
    inaddrwr_arg2_v[INADDRWIDTH-1:2] = inaddrwr_arg2;

    inaddrwr_v = {4'b0000, inaddrwr_arg1} + inaddrwr_arg2_v;

    in_addr_wr = inaddrwr_v[1:0];



    for(i = `CDNSUSBHS_INADDWR; i >= 1; i = i - 1)
      begin

      inaddrwr[`CDNSUSBHS_INADDWR-i] = inaddrwr_v[INADDRWIDTH-i];
      end

    end
  `endif



  assign outaddrrd_arg1 =
      `ifdef CDNSUSBHS_EPOUT_EXIST_15
                         (endpnr_out_s == 4'hF) ? upfifoptrrd15 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_14
                         (endpnr_out_s == 4'hE) ? upfifoptrrd14 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_13
                         (endpnr_out_s == 4'hD) ? upfifoptrrd13 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_12
                         (endpnr_out_s == 4'hC) ? upfifoptrrd12 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_11
                         (endpnr_out_s == 4'hB) ? upfifoptrrd11 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_10
                         (endpnr_out_s == 4'hA) ? upfifoptrrd10 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_9
                         (endpnr_out_s == 4'h9) ? upfifoptrrd9 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_8
                         (endpnr_out_s == 4'h8) ? upfifoptrrd8 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_7
                         (endpnr_out_s == 4'h7) ? upfifoptrrd7 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_6
                         (endpnr_out_s == 4'h6) ? upfifoptrrd6 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_5
                         (endpnr_out_s == 4'h5) ? upfifoptrrd5 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_4
                         (endpnr_out_s == 4'h4) ? upfifoptrrd4 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_3
                         (endpnr_out_s == 4'h3) ? upfifoptrrd3 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_2
                         (endpnr_out_s == 4'h2) ? upfifoptrrd2 :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_1
                         (endpnr_out_s == 4'h1) ? upfifoptrrd1 :
      `endif
                        (fifoaccrd_ep0 == 1'b1) ? {6'b000000, upaddr[3:0], upaddr_offset} :
                                                  upfifoptrrd0 ;

    `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
    `else


  assign outaddrrd_arg2 =
      `ifdef CDNSUSBHS_EPOUT_EXIST_15
                         (endpnr_out_s == 4'hF) ? out15startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_14
                         (endpnr_out_s == 4'hE) ? out14startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_13
                         (endpnr_out_s == 4'hD) ? out13startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_12
                         (endpnr_out_s == 4'hC) ? out12startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_11
                         (endpnr_out_s == 4'hB) ? out11startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_10
                         (endpnr_out_s == 4'hA) ? out10startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_9
                         (endpnr_out_s == 4'h9) ? out9startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_8
                         (endpnr_out_s == 4'h8) ? out8startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_7
                         (endpnr_out_s == 4'h7) ? out7startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_6
                         (endpnr_out_s == 4'h6) ? out6startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_5
                         (endpnr_out_s == 4'h5) ? out5startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_4
                         (endpnr_out_s == 4'h4) ? out4startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_3
                         (endpnr_out_s == 4'h3) ? out3startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_2
                         (endpnr_out_s == 4'h2) ? out2startaddr :
      `endif
      `ifdef CDNSUSBHS_EPOUT_EXIST_1
                         (endpnr_out_s == 4'h1) ? out1startaddr :
      `endif
                                                  {OUTADDRWIDTH-2{1'b0}};
    `endif




  `ifdef CDNSUSBHS_OTHERS_EPOUT_DO_NOT_EXIST
  always @(outaddrrd_arg1)
    begin : OUTADDRRD_COMB_PROC
      reg [15:0] outaddrrd_v;
      integer    i;


    outaddrrd   = {`CDNSUSBHS_OUTADDRD{1'b0}};
    outaddrrd_v = {16{1'b0}};

    outaddrrd_v = {4'b0000, outaddrrd_arg1};

    out_addr_rd_nxt = outaddrrd_v[1:0];



    for(i = `CDNSUSBHS_OUTADDRD; i >= 1; i = i - 1)
      begin

      outaddrrd[`CDNSUSBHS_OUTADDRD-i] = outaddrrd_v[OUTADDRWIDTH-i];
      end

    end
  `else
  always @(outaddrrd_arg1 or outaddrrd_arg2)
    begin : OUTADDRRD_COMB_PROC
      reg [15:0] outaddrrd_v;
      reg [15:0] outaddrrd_arg2_v;
      integer    i;


    outaddrrd   = {`CDNSUSBHS_OUTADDRD{1'b0}};
    outaddrrd_v = {16{1'b0}};

    outaddrrd_arg2_v                   = {16{1'b0}};
    outaddrrd_arg2_v[OUTADDRWIDTH-1:2] = outaddrrd_arg2;

    outaddrrd_v = {4'b0000, outaddrrd_arg1} + outaddrrd_arg2_v;

    out_addr_rd_nxt = outaddrrd_v[1:0];



    for(i = `CDNSUSBHS_OUTADDRD; i >= 1; i = i - 1)
      begin

      outaddrrd[`CDNSUSBHS_OUTADDRD-i] = outaddrrd_v[OUTADDRWIDTH-i];
      end

    end
  `endif








  assign in_rama_addr = inaddrwr ;
  assign in_rama_data = indatawr ;
  assign in_rama_wr   = (inwr == 1'b0) ? 4'h0 :
                                         indataval ;








  `CDNSUSBHS_ALWAYS(upclk,uprst)
    begin : OUT_RDDATA_R_PROC
    if `CDNSUSBHS_RESET(uprst)
      begin
      out_rddata_r <= {32{1'b0}};
      outrd_r      <= 1'b0 ;
      end
    else
      begin
      outrd_r <= outrd ;
      if (outrd_r == 1'b1)
        begin
        out_rddata_r <= out_rddata ;
        end
      end
    end



  assign outdatard = (outrd_r == 1'b1) ? out_rddata :
                                         out_rddata_r ;




  assign out_ramb_addr = outaddrrd ;
  assign out_ramb_rd   = outrd;
  assign out_rddata    = out_ramb_data ;

endmodule

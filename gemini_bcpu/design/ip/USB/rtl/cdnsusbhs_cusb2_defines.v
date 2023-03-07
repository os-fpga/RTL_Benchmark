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
//   Filename:           cdnsusbhs_cusb2_defines.v
//   Module Name:        N/A
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
//   CUSB2 defines package
//   K.W.
//------------------------------------------------------------------------------

  `define CDNSUSBHS_CROMADDR             11

  `define CDNSUSBHS_EPIN_EXIST_0
  `define CDNSUSBHS_EPIN_EXIST_1
  `define CDNSUSBHS_EPIN_EXIST_2
  `define CDNSUSBHS_EPIN_EXIST_3
  `define CDNSUSBHS_EPIN_EXIST_4
  `define CDNSUSBHS_EPIN_EXIST_5
  `define CDNSUSBHS_EPIN_EXIST_6
  `define CDNSUSBHS_EPIN_EXIST_7
  `define CDNSUSBHS_EPIN_EXIST_8

  `define CDNSUSBHS_EPOUT_EXIST_0
  `define CDNSUSBHS_EPOUT_EXIST_1
  `define CDNSUSBHS_EPOUT_EXIST_2
  `define CDNSUSBHS_EPOUT_EXIST_3
  `define CDNSUSBHS_EPOUT_EXIST_4
  `define CDNSUSBHS_EPOUT_EXIST_5
  `define CDNSUSBHS_EPOUT_EXIST_6
  `define CDNSUSBHS_EPOUT_EXIST_7
  `define CDNSUSBHS_EPOUT_EXIST_8

  `define CDNSUSBHS_EPIN_SIZE_0         64
  `define CDNSUSBHS_EPIN_SIZE_1       1024
  `define CDNSUSBHS_EPIN_SIZE_2       1024
  `define CDNSUSBHS_EPIN_SIZE_3       1024
  `define CDNSUSBHS_EPIN_SIZE_4       1024
  `define CDNSUSBHS_EPIN_SIZE_5       1024
  `define CDNSUSBHS_EPIN_SIZE_6       1024
  `define CDNSUSBHS_EPIN_SIZE_7       1024
  `define CDNSUSBHS_EPIN_SIZE_8       1024

  `define CDNSUSBHS_EPOUT_SIZE_0        64
  `define CDNSUSBHS_EPOUT_SIZE_1      1024
  `define CDNSUSBHS_EPOUT_SIZE_2      1024
  `define CDNSUSBHS_EPOUT_SIZE_3      1024
  `define CDNSUSBHS_EPOUT_SIZE_4      1024
  `define CDNSUSBHS_EPOUT_SIZE_5      1024
  `define CDNSUSBHS_EPOUT_SIZE_6      1024
  `define CDNSUSBHS_EPOUT_SIZE_7      1024
  `define CDNSUSBHS_EPOUT_SIZE_8      1024

  `define CDNSUSBHS_EPIN_BUFFER_0        1
  `define CDNSUSBHS_EPIN_BUFFER_1        2
  `define CDNSUSBHS_EPIN_BUFFER_2        2
  `define CDNSUSBHS_EPIN_BUFFER_3        2
  `define CDNSUSBHS_EPIN_BUFFER_4        2
  `define CDNSUSBHS_EPIN_BUFFER_5        2
  `define CDNSUSBHS_EPIN_BUFFER_6        2
  `define CDNSUSBHS_EPIN_BUFFER_7        2
  `define CDNSUSBHS_EPIN_BUFFER_8        2

  `define CDNSUSBHS_EPIN_BUFFER_CC_2

  `define CDNSUSBHS_EPOUT_BUFFER_0       1
  `define CDNSUSBHS_EPOUT_BUFFER_1       2
  `define CDNSUSBHS_EPOUT_BUFFER_2       2
  `define CDNSUSBHS_EPOUT_BUFFER_3       2
  `define CDNSUSBHS_EPOUT_BUFFER_4       2
  `define CDNSUSBHS_EPOUT_BUFFER_5       2
  `define CDNSUSBHS_EPOUT_BUFFER_6       2
  `define CDNSUSBHS_EPOUT_BUFFER_7       2
  `define CDNSUSBHS_EPOUT_BUFFER_8       2

  `define CDNSUSBHS_EPOUT_BUFFER_CC_2

  `define CDNSUSBHS_EPIN_BC_1           11
  `define CDNSUSBHS_EPIN_BC_2           11
  `define CDNSUSBHS_EPIN_BC_3           11
  `define CDNSUSBHS_EPIN_BC_4           11
  `define CDNSUSBHS_EPIN_BC_5           11
  `define CDNSUSBHS_EPIN_BC_6           11
  `define CDNSUSBHS_EPIN_BC_7           11
  `define CDNSUSBHS_EPIN_BC_8           11

  `define CDNSUSBHS_EPOUT_BC_1          11
  `define CDNSUSBHS_EPOUT_BC_2          11
  `define CDNSUSBHS_EPOUT_BC_3          11
  `define CDNSUSBHS_EPOUT_BC_4          11
  `define CDNSUSBHS_EPOUT_BC_5          11
  `define CDNSUSBHS_EPOUT_BC_6          11
  `define CDNSUSBHS_EPOUT_BC_7          11
  `define CDNSUSBHS_EPOUT_BC_8          11

  `define CDNSUSBHS_EPIN_NUMBER_1        1
  `define CDNSUSBHS_EPIN_NUMBER_2        2
  `define CDNSUSBHS_EPIN_NUMBER_3        3
  `define CDNSUSBHS_EPIN_NUMBER_4        4
  `define CDNSUSBHS_EPIN_NUMBER_5        5
  `define CDNSUSBHS_EPIN_NUMBER_6        6
  `define CDNSUSBHS_EPIN_NUMBER_7        7
  `define CDNSUSBHS_EPIN_NUMBER_8        8

  `define CDNSUSBHS_EPOUT_NUMBER_1       1
  `define CDNSUSBHS_EPOUT_NUMBER_2       2
  `define CDNSUSBHS_EPOUT_NUMBER_3       3
  `define CDNSUSBHS_EPOUT_NUMBER_4       4
  `define CDNSUSBHS_EPOUT_NUMBER_5       5
  `define CDNSUSBHS_EPOUT_NUMBER_6       6
  `define CDNSUSBHS_EPOUT_NUMBER_7       7
  `define CDNSUSBHS_EPOUT_NUMBER_8       8

  `define CDNSUSBHS_EPINEXIST           16'b0000_0001_1111_1111
  `define CDNSUSBHS_EPOUTEXIST          16'b0000_0001_1111_1111

  `define CDNSUSBHS_EPOUT_STARTADDR_0    0
  `define CDNSUSBHS_EPOUT_STARTADDR_1    64
  `define CDNSUSBHS_EPOUT_STARTADDR_2    2112
  `define CDNSUSBHS_EPOUT_STARTADDR_3    4160
  `define CDNSUSBHS_EPOUT_STARTADDR_4    6208
  `define CDNSUSBHS_EPOUT_STARTADDR_5    8256
  `define CDNSUSBHS_EPOUT_STARTADDR_6    10304
  `define CDNSUSBHS_EPOUT_STARTADDR_7    12352
  `define CDNSUSBHS_EPOUT_STARTADDR_8    14400
  `define CDNSUSBHS_EPOUT_STARTADDR_9    16448
  `define CDNSUSBHS_EPOUT_STARTADDR_10   16448
  `define CDNSUSBHS_EPOUT_STARTADDR_11   16448
  `define CDNSUSBHS_EPOUT_STARTADDR_12   16448
  `define CDNSUSBHS_EPOUT_STARTADDR_13   16448
  `define CDNSUSBHS_EPOUT_STARTADDR_14   16448
  `define CDNSUSBHS_EPOUT_STARTADDR_15   16448

  `define CDNSUSBHS_EPOUT_ENDADDR        16447

  `define CDNSUSBHS_EPIN_STARTADDR_0     0
  `define CDNSUSBHS_EPIN_STARTADDR_1     64
  `define CDNSUSBHS_EPIN_STARTADDR_2     2112
  `define CDNSUSBHS_EPIN_STARTADDR_3     4160
  `define CDNSUSBHS_EPIN_STARTADDR_4     6208
  `define CDNSUSBHS_EPIN_STARTADDR_5     8256
  `define CDNSUSBHS_EPIN_STARTADDR_6     10304
  `define CDNSUSBHS_EPIN_STARTADDR_7     12352
  `define CDNSUSBHS_EPIN_STARTADDR_8     14400
  `define CDNSUSBHS_EPIN_STARTADDR_9     16448
  `define CDNSUSBHS_EPIN_STARTADDR_10    16448
  `define CDNSUSBHS_EPIN_STARTADDR_11    16448
  `define CDNSUSBHS_EPIN_STARTADDR_12    16448
  `define CDNSUSBHS_EPIN_STARTADDR_13    16448
  `define CDNSUSBHS_EPIN_STARTADDR_14    16448
  `define CDNSUSBHS_EPIN_STARTADDR_15    16448

  `define CDNSUSBHS_EPIN_ENDADDR         16447

  `define CDNSUSBHS_UPADDRWIDTH          32

  `define CDNSUSBHS_UPDATAWIDTH          32
  `define CDNSUSBHS_USBDATAWIDTH         8
  `define CDNSUSBHS_FIFODATAWIDTH        32

  `define CDNSUSBHS_OUTADDRD             13
  `define CDNSUSBHS_OUTADDWR             15
  `define CDNSUSBHS_OUTADDRWIDTH         15
  `define CDNSUSBHS_OUTADD               13

  `define CDNSUSBHS_INADDWR              13
  `define CDNSUSBHS_INADDRD              15
  `define CDNSUSBHS_INADDRWIDTH          15
  `define CDNSUSBHS_INADD                13

  `define CDNSUSBHS_BUFFDATAWIDTH        32
  `define CDNSUSBHS_RAMDATAWIDTH         32

  `define CDNSUSBHS_ISP1501



  `define CDNSUSBHS_VERILOG_2001





  `define CDNSUSBHS_DATA_DPRAM





  `define CDNSUSBHS_POSEDGE_CLOCK


  `define CDNSUSBHS_ASYNCHRONOUS_RST

  `define CDNSUSBHS_LOW_RST





`ifdef CDNSUSBHS_POSEDGE_CLOCK
  `ifdef CDNSUSBHS_ASYNCHRONOUS_RST
  `ifdef CDNSUSBHS_HIGH_RST
    `define CDNSUSBHS_ALWAYS(clk, rst) always @(posedge clk or posedge rst)
  `else
    `define CDNSUSBHS_ALWAYS(clk, rst) always @(posedge clk or negedge rst)
  `endif
  `else
    `define CDNSUSBHS_ALWAYS(clk, rst) always @(posedge clk)
  `endif
`else
  `ifdef CDNSUSBHS_ASYNCHRONOUS_RST
  `ifdef CDNSUSBHS_HIGH_RST
    `define CDNSUSBHS_ALWAYS(clk, rst) always @(negedge clk or posedge rst)
  `else
    `define CDNSUSBHS_ALWAYS(clk, rst) always @(negedge clk or negedge rst)
  `endif
  `else
    `define CDNSUSBHS_ALWAYS(clk, rst) always @(negedge clk)
  `endif
`endif

  `ifdef CDNSUSBHS_HIGH_RST
    `define CDNSUSBHS_RESET(rst) (rst == 1'b1)
  `else
    `define CDNSUSBHS_RESET(rst) (rst == 1'b0)
  `endif

  `ifdef CDNSUSBHS_HIGH_RST
    `define CDNSUSBHS_LEVEL 1'b1
  `else
    `define CDNSUSBHS_LEVEL 1'b0
  `endif

  `define CDNSUSBHS_PHY_UTMI

  `define FL_GENERIC_TECH


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
//   Filename:           cdnsusbhs_upwrap.v
//   Module Name:        cdnsusbhs_upwrap
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
//   The microprocessor interface wrapper
//   D.K.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_upwrap
  (
  ocp_clk,
  ocp_rst,

  ocps_maddr,
  ocps_mdata,
  ocps_mcmd,
  ocps_mbyteen,
  ocps_scmdaccept,
  ocps_sresp,
  ocps_sdata,

  int_upaddr,
  int_uprd,
  int_upwr,
  int_upbe_rd,
  int_upbe_wr,
  int_upwdata,
  int_uprdata
  );



  parameter UPDATAWIDTH      = 32'd`CDNSUSBHS_UPDATAWIDTH;
  parameter UPADDRWIDTH      = 32'd`CDNSUSBHS_UPADDRWIDTH;

  input                            ocp_clk;
  input                            ocp_rst;
  input  [UPADDRWIDTH-1:0]         ocps_maddr;
  input  [UPDATAWIDTH-1:0]         ocps_mdata;
  input  [2:0]                     ocps_mcmd;
  input  [3:0]                     ocps_mbyteen;

  output                           ocps_scmdaccept;
  wire                             ocps_scmdaccept;
  output [1:0]                     ocps_sresp;
  reg    [1:0]                     ocps_sresp;
  output [UPDATAWIDTH-1:0]         ocps_sdata;
  wire   [UPDATAWIDTH-1:0]         ocps_sdata;


  output [8:0]                     int_upaddr;
  wire   [8:0]                     int_upaddr;
  output                           int_uprd;
  wire                             int_uprd;
  output                           int_upwr;
  wire                             int_upwr;
  output [3:0]                     int_upbe_rd;
  wire   [3:0]                     int_upbe_rd;
  output [3:0]                     int_upbe_wr;
  wire   [3:0]                     int_upbe_wr;
  output [31:0]                    int_upwdata;
  wire   [31:0]                    int_upwdata;
  input  [31:0]                    int_uprdata;

  wire   [UPDATAWIDTH-1:0]         updatao;


  wire                             upwr;
  wire                             uprd;




  assign upwr = (ocps_mcmd == 3'b001 ) ? 1'b1 :
                                         1'b0 ;



  assign uprd = (ocps_mcmd == 3'b010) ? 1'b1 :
                                        1'b0 ;



  assign ocps_scmdaccept = uprd | upwr;




  `CDNSUSBHS_ALWAYS(ocp_clk,ocp_rst)
    begin : OCPS_RESP_PROC
    if `CDNSUSBHS_RESET(ocp_rst)
      begin
      ocps_sresp <= 2'b00;
      end
    else
      begin

      if (uprd == 1'b1)
        begin
        ocps_sresp <= 2'b01;
        end
      else
        begin
        ocps_sresp <= 2'b00;
        end
      end
    end



  assign ocps_sdata = updatao;








  assign int_upaddr = ocps_maddr[10:2];




  assign int_upbe_wr = ocps_mbyteen;




  assign int_upbe_rd = ocps_mbyteen;




  assign int_uprd    = uprd;




  assign int_upwr    = upwr;




  assign int_upwdata = ocps_mdata;




  assign updatao     = int_uprdata;

endmodule

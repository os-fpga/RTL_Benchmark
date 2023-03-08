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
//   Filename:           cdnsusbhs_dpram_out.stub.v
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

module cdnsusbhs_dpram_out (
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

  //
  localparam BUF_512_NUM    = (MEMORY_DEPTH - 16)/512;

  wire [BUF_512_NUM-1:0] wea_n;
  wire [BUF_512_NUM-1:0] cea_n;
  wire [BUF_512_NUM-1:0] ceb_n;

  wire  [DATA_WIDTH-1:0] dob_ram [BUF_512_NUM-1:0];
  logic [DATA_WIDTH-1:0] dob_mux;
  // Endpoints 0-8 buffers 
  genvar mem_inst_num;
  generate
    for (mem_inst_num = 0; mem_inst_num < BUF_512_NUM; mem_inst_num = mem_inst_num + 1) begin : _dp_512x32_
  
      assign wea_n[mem_inst_num] = !(wea & (addra[ADDR_WIDTH-1:9] == mem_inst_num));
  
      assign cea_n[mem_inst_num] = !((|wea) & (addra[ADDR_WIDTH-1:9] == mem_inst_num));
      assign ceb_n[mem_inst_num] = !(enb    & (addrb[ADDR_WIDTH-1:9] == mem_inst_num));
  
      // dual-port Endpoint RAM: port A - write op, port B - read op
      dti_dp_tm16fcll_512x32_4ww2xoe_m_hc ep_buf_u (
        .VDD     ( 1'b1                 ), 
        .VSS     ( 1'b0                 ), 
        .DO_A    (                      ), 
        .DO_B    ( dob_ram[mem_inst_num]), 
        .A_A     ( addra[8:0]           ), 
        .A_B     ( addrb[8:0]           ), 
        .DI_A    ( dina                 ), 
        .DI_B    ( 32'h0                ), 
        .CE_N_A  ( cea_n[mem_inst_num]  ), 
        .CE_N_B  ( ceb_n[mem_inst_num]  ), 
        .GWE_N_A ( wea_n[mem_inst_num]  ), 
        .GWE_N_B ( 1'b1                 ), 
        .OE_N_A  ( 1'b0                 ), 
        .OE_N_B  ( ceb_n[mem_inst_num]  ), 
        .T_RWM_A ( 3'b011               ), 
        .T_RWM_B ( 3'b011               ), 
        .CLK_A   ( clka                 ), 
        .CLK_B   ( clkb                 )
      );
  
    end // _dp_512x32_
  
  endgenerate


always_comb begin
  dob_mux = {DATA_WIDTH{1'b0}};
  for (int i = 0; i < BUF_512_NUM; i++) if (!ceb_n[i]) dob_mux = dob_ram[i];
end
assign dob = dob_mux;

endmodule

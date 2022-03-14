//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2008-2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//   Checked In : $Date: 2011-12-30 10:51:05 +0000 (Fri, 30 Dec 2011) $
//   Revision   : $Revision: 196368 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

module cm0p_dap_ap
  #(parameter CBAW    = 0,
    parameter USER    = 0,       //0 -> SLVPROT user/priv bit is RO
    parameter MPU     = 0,       //0 -> SLVPROT cacheable/bufferable bits RO
    parameter RAR     = 0
    )
   (input  wire        dclk,
    input  wire        apreset_n,
    input  wire        deviceen_i,
    input  wire [31:0] slvrdata_i,
    input  wire        slvready_i,
    input  wire        slvresp_i,
    output wire [31:0] slvwdata_o,
    output wire [31:0] slvaddr_o,
    output wire [1:0]  slvtrans_o,
    output wire [3:0]  slvprot_o,
    output wire        slvwrite_o,
    output wire [1:0]  slvsize_o,
    input  wire [31:0] ap_base_reg_i,

    //Internal DAP IO
    input  wire [37:0] dap_dp_to_ap_i,
    output wire [33:0] dap_ap_to_dp_o,

    //Configurability IO
    input  wire [3:0]  ecorevnum_i,

    // Scan Enable for DFT
    input  wire        DFTSE
     );

// ----------------------------------------------------------------------------
// Signal Declarations
// ----------------------------------------------------------------------------
  //Outputs To Top Level
  wire   [31:0] ap_data;
  wire          ap_err;
  wire          ap_ack_ap;

  //Connections Between Internal Blocks
  wire   [31:0] dp_data_ap;
  wire    [3:0] dp_regaddr_ap;
  wire          dp_rnw_ap;
  wire   [31:0] ap_data_ap;
  wire          ap_err_ap;
  wire          ap_wr_en;
  wire          ap_out_en;
  wire          dp_req_ap;
  wire          ap_ack_load;

  // Bus Unpacking
  wire   [31:0] dp_data;
  wire   [3:0]  dp_regaddr;
  wire          dp_rnw;
  wire          dp_req_dp;

  // Avoid combinational paths through cm0p_dap_ap_mast
  assign        slvwrite_o = ~dp_rnw_ap;
  assign        slvwdata_o = dp_data_ap;

// -----------------------------------------------------------------------------
// Domain Crossing Buses
// -----------------------------------------------------------------------------

  // To facilitate tool workflow, signals crossing the power domain boundary
  // from the AP (Debug Power Domain) to the DP (DP Power Domain) are bundled
  // into a bus to be passed across the boundary as a single signal.
  assign dap_ap_to_dp_o = {
                            ap_data,    // [33:2]
                            ap_err,     // [1]
                            ap_ack_ap   // [0]
                          };

  // Unpack signals from incoming bus
  assign
  {
    dp_rnw,
    dp_regaddr,
    dp_data,
    dp_req_dp
  }
  = dap_dp_to_ap_i;

//------------------------------------------------------------------------------
// Instantiate AP Modules
//------------------------------------------------------------------------------
  //Instantiate AP Bus Master
  cm0p_dap_ap_mast
    #(.CBAW     (CBAW),
      .USER     (USER),
      .MPU      (MPU),
      .RAR      (RAR))
    u_cm0p_dap_ap_mast
    (
      .dclk             (dclk),
      .apreset_n        (apreset_n),
      .deviceen_i       (deviceen_i),
      .dp_data_ap_i     (dp_data_ap),
      .dp_regaddr_ap_i  (dp_regaddr_ap),
      .dp_rnw_ap_i      (dp_rnw_ap),
      .dp_req_ap_i      (dp_req_ap),
      .slvrdata_i       (slvrdata_i),
      .slvready_i       (slvready_i),
      .slvresp_i        (slvresp_i),
      .ap_data_ap_o     (ap_data_ap),
      .ap_out_en_o      (ap_out_en),
      .ap_wr_en_o       (ap_wr_en),
      .ap_err_ap_o      (ap_err_ap),
      .ap_ack_ap_i      (ap_ack_ap),
      .ap_ack_load_o    (ap_ack_load),
      .slvaddr_o        (slvaddr_o),
      .slvtrans_o       (slvtrans_o),
      .slvprot_o        (slvprot_o),
      .slvsize_o        (slvsize_o),
      .ap_base_reg_i    (ap_base_reg_i),
      .ecorevnum_i      (ecorevnum_i)
    );

  //Instantiate Transfer block to pass data between AP and DP across clock
  //boundary
  cm0p_dap_ap_cdc
    #(.CBAW     (CBAW),
      .RAR      (RAR))
    u_cm0p_dap_ap_cdc
    (
      .dclk             (dclk),
      .apreset_n        (apreset_n),
      .dp_data_i        (dp_data),
      .dp_regaddr_i     (dp_regaddr),
      .dp_rnw_i         (dp_rnw),
      .ap_data_ap_i     (ap_data_ap),
      .ap_err_ap_i      (ap_err_ap),
      .ap_wr_en_i       (ap_wr_en),
      .ap_out_en_i      (ap_out_en),
      .dp_req_dp_i      (dp_req_dp),
      .ap_data_o        (ap_data),
      .ap_err_o         (ap_err),
      .dp_data_ap_o     (dp_data_ap),
      .dp_regaddr_ap_o  (dp_regaddr_ap),
      .dp_rnw_ap_o      (dp_rnw_ap),
      .dp_req_ap_o      (dp_req_ap),
      .ap_ack_ap_o      (ap_ack_ap),
      .ap_ack_load_i    (ap_ack_load),
      .DFTSE            (DFTSE)
    );

endmodule

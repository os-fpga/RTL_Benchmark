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

module CM0PDAP
  #(// ------------------------------------------------------------------------
    // CORTEX-M0+ DAP PER-INSTANCE PARAMETERIZATION:
    // ------------------------------------------------------------------------
    parameter JTAGnSW = 0,       //1 -> JTAG, 0 -> SW
    parameter SWMD    = 0,       //1 -> For Serial Wire multi-drop support
    parameter USER    = 0,       //0 -> SLVPROT user/priv bit is RO
    parameter MPU     = 0,       //0 -> SLVPROT cacheable/bufferable bits RO
    parameter HALTEV  = 0,       //1 -> Debug halt event is supported
    parameter RAR     = 0        //1 -> Resets on all Registers, 0 -> Non-RAR
    )
   (// ------------------------------------------------------------------------
    // CORTEX-M0+ DAP PRIMARY INPUTS AND OUTPUTS
    // ------------------------------------------------------------------------

    // CLOCK AND RESETS -------------------------------------------------------
    input  wire        SWCLKTCK,     // SW/JTAG DP clock
    input  wire        DPRESETn,     // Negative sense power-on reset for DP
    input  wire        DCLK,         // AP clock
    input  wire        APRESETn,     // Negative sense power-on reset for AP

    // JTAG-DP ----------------------------------------------------------------
    input  wire        nTRST,        // JTAG test logic reset signal
    input  wire        TDI,          // JTAG data in
    output wire        TDO,          // JTAG data out
    output wire        nTDOEN,       // JTAG TDO Output Enable

    // SERIAL WIRE-DP ---------------------------------------------------------
    input  wire        SWDITMS,      // SW data in/JTAG TMS
    output wire        SWDO,         // SW data out
    output wire        SWDOEN,       // SW data out enable
    output wire        SWDETECT,     // SW line reset Detect

    // HALTED -----------------------------------------------------------------
    input  wire        HALTED,       // Processor halted

    // POWER MANAGEMENT -------------------------------------------------------
    output wire        CDBGPWRUPREQ, // Debug Power Up Request
    input  wire        CDBGPWRUPACK, // Debug Power Up Acknowledge

    // AP ENABLE --------------------------------------------------------------
    input  wire        DEVICEEN,     // Debug enabled by system

    // DEBUG SLAVE PORT -------------------------------------------------------
    output wire [31:0] SLVADDR,      // Bus address
    output wire [31:0] SLVWDATA,     // Bus write data
    output wire [1:0]  SLVTRANS,     // Bus transfer valid
    output wire [3:0]  SLVPROT,      // Bus transaction protection
    output wire        SLVWRITE,     // Bus write/not read
    output wire [1:0]  SLVSIZE,      // Bus Access Size
    input  wire [31:0] SLVRDATA,     // Bus read data
    input  wire        SLVREADY,     // Bus Ready from bus
    input  wire        SLVRESP,      // Bus Response from bus

    // CONFIGURATION ----------------------------------------------------------
    input  wire [31:0] BASEADDR,     // AP ROM Table Base
    input  wire [31:0] TARGETID,     // 31:28=TREVISION 27:12=TPARTNO 11:1=TDESIGNER 0=1
    input  wire [3:0]  INSTANCEID,   // DLPIDR[31:28] for Serial Wire protocol 2
    input  wire [7:0]  ECOREVNUM,    // Top 4 bits = DP Revision, Bottom 4 = AP Revision

    // SCAN/TEST IO -----------------------------------------------------------
    input  wire        DFTSE         // Scan enable for DFT
    );

  // ----------------------------------------------------------------------------
  // Disable wire-based configuration (used for DSM generation only)
  // ----------------------------------------------------------------------------

  localparam CBAW = 0;

  // -------------------------------------------------------------------------
  // If we have an MPU, then we must have user/privilege support
  // -------------------------------------------------------------------------

  localparam USERORMPU = (USER != 0) || (MPU != 0);

  // -------------------------------------------------------------------------
  // Instantiate Cortex-M0+ DAP structural level
  // -------------------------------------------------------------------------

  cm0p_dap_top
    #(.CBAW    (CBAW),
      .JTAGnSW (JTAGnSW),
      .SWMD    (SWMD),
      .USER    (USERORMPU),
      .MPU     (MPU),
      .HALTEV  (HALTEV),
      .RAR     (RAR))
  u_dap_top
    (.swclktck       (SWCLKTCK),
     .dpreset_n      (DPRESETn),
     .dclk           (DCLK),
     .apreset_n      (APRESETn),

     .n_trst         (nTRST),
     .tdi_i          (TDI),
     .tdo_o          (TDO),
     .ntdoen_o       (nTDOEN),

     .swditms_i      (SWDITMS),
     .swdo_o         (SWDO),
     .swdoen_o       (SWDOEN),
     .swdetect_o     (SWDETECT),

     .halted_i       (HALTED),

     .cdbgpwrupreq_o (CDBGPWRUPREQ),
     .cdbgpwrupack_i (CDBGPWRUPACK),

     .deviceen_i     (DEVICEEN),

     .slvaddr_o      (SLVADDR[31:0]),
     .slvwdata_o     (SLVWDATA[31:0]),
     .slvtrans_o     (SLVTRANS[1:0]),
     .slvprot_o      (SLVPROT[3:0]),
     .slvwrite_o     (SLVWRITE),
     .slvsize_o      (SLVSIZE[1:0]),
     .slvrdata_i     (SLVRDATA[31:0]),
     .slvready_i     (SLVREADY),
     .slvresp_i      (SLVRESP),

     .baseaddr_i     (BASEADDR[31:0]),
     .targetid_i     (TARGETID[31:0]),
     .instanceid_i   (INSTANCEID[3:0]),
     .ecorevnum_i    (ECOREVNUM[7:0]),

     .DFTSE          (DFTSE)
     );

endmodule

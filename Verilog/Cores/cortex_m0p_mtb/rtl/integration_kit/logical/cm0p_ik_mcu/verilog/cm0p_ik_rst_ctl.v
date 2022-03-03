//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2009-2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//   Checked In : $Date: 2012-12-10 17:36:51 +0000 (Mon, 10 Dec 2012) $
//   Revision   : $Revision: 231134 $
//   Release    : Cortex-M0+ AT590-r0p1-00rel0
//
//-----------------------------------------------------------------------------
// Verilog-2001 (IEEE Std 1364-2001)
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// CORTEX-M0+ EXAMPLE RESET CONTROLLER
// This module is designed as an example reset controller for the CORTEX-M0+
// processor It takes a global reset that can be asynchronously asserted
// and generates from it synchronously asserted and deasserted resets based
// on synchronous reset requests
// This module is intended to interface to the example PMU provided
// (cm0p_ik_pmu.v). You can modify this module to suit your requirements
//-----------------------------------------------------------------------------

module cm0p_ik_rst_ctl
  (
  input  wire GLOBALRESETn,   // Global asynchronous reset
  input  wire FCLK,           // Free running clock (connect to FCLK of CORTEX-M0+INTEGRATION)
  input  wire HCLK,           // AHB clock (connect to HCLK of CORTEX-M0+INTEGRATION)
  input  wire DCLK,           // Debug clock (connect to DCLK of CORTEX-M0+INTEGRATION)
  input  wire SYSRESETREQ,    // Synchronous (to HCLK) request for HRESETn from system
  input  wire PMUHRESETREQ,   // Synchronous (to HCLK) request for HRESETn from PMU
  input  wire PMUDBGRESETREQ, // Synchronous (to DCLK) request for DBGRESETn from PMU
  input  wire DFTRSTDISABLE,  // Reset synchroniser bypass (for DFT)
  input  wire DFTSE,          // Scan Enable (for DFT)
  input  wire HREADY,         // AHB HREADY from CORTEX-M0+INTEGRATION

  output wire PORESETn,       // Connect to PORESETn of CORTEX-M0+INTEGRATION
  output wire HRESETn,        // Connect to HRESETn of CORTEX-M0+INTEGRATION
  output wire DBGRESETn,      // Connect to DBGRESETn of CORTEX-M0+INTEGRATION
  output wire HRESETREQ);     // Synchronous (to FCLK) indication of HRESET request

  // Sample synchronous requests to assert HRESETn.
  // To ensure AHB-Lite compliance of the AHB-Lite master interface,
  // unless asserted as part of a power-on reset (in which case DBGRESETn is
  // also asserted), HRESETn must be asserted synchronously and only if HREADY
  // was HIGH on the previous cycle.
  // Sources:
  // 1 - System (SYSRESETREQ)
  // 2 - PMU    (PMUHRESETREQ)

  wire   h_reset_req_in = SYSRESETREQ | PMUHRESETREQ;

  cm0p_rst_send_set u_hreset_req
    (.RSTn      (PORESETn),
     .CLK       (FCLK),
     .CLKEN     (HREADY),
     .RSTREQIN  (h_reset_req_in),
     .RSTREQOUT (HRESETREQ)
     );

  // Sample synchronous requests to assert DBGRESETn.
  // To ensure AHB-Lite compliance of the AHB-Lite master interface,
  // unless asserted as part of a power-on reset (in which case HRESETn is also
  // asserted), DBGRESETn must not be asserted when a debugger transfer is in
  // progress. This can be achieved by ignoring debug reset requests when a
  // debugger is connected.
  // The example PMU only requests a debug reset when the debug domain is
  // powered down or powering up.
  // Sources:
  // 1 - PMU (PMUDBGRESETREQ)

  wire   dbg_reset_req_sync;

  cm0p_rst_send_set u_dbgreset_req
    (.RSTn      (PORESETn),
     .CLK       (FCLK),
     .CLKEN     (1'b1),
     .RSTREQIN  (PMUDBGRESETREQ),
     .RSTREQOUT (dbg_reset_req_sync)
     );

  // --------------------
  // Reset synchronisers
  // --------------------

  cm0p_rst_sync u_poresetn_sync
    (.RSTINn        (GLOBALRESETn),
     .RSTREQ        (1'b0),
     .CLK           (FCLK),
     .DFTSE         (DFTSE),
     .DFTRSTDISABLE (DFTRSTDISABLE),
     .RSTOUTn       (PORESETn)
     );

  cm0p_rst_sync u_hresetn_sync
    (.RSTINn        (GLOBALRESETn),
     .RSTREQ        (HRESETREQ),
     .CLK           (HCLK),
     .DFTSE         (DFTSE),
     .DFTRSTDISABLE (DFTRSTDISABLE),
     .RSTOUTn       (HRESETn)
     );

  cm0p_rst_sync u_dbgresetn_sync
    (.RSTINn        (GLOBALRESETn),
     .RSTREQ        (dbg_reset_req_sync),
     .CLK           (DCLK),
     .DFTSE         (DFTSE),
     .DFTRSTDISABLE (DFTRSTDISABLE),
     .RSTOUTn       (DBGRESETn)
     );

endmodule // cm0p_ik_rst_ctl




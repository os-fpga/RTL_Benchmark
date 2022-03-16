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

module cm0p_dap_dp_pwr
   (// Clock and Reset
    input  wire    swclktck,
    input  wire    dpreset_n,

    // Inputs from other Modules
    input  wire    dp_cs_cdbgpwrupreq_i,    // CDBGPWRUPREQ from DP CTRL/STAT
    input  wire    cdbgpwrupack_i,          // CDBGPWRUPACK from DAP pin
    input  wire    dp_req_dp_i,             // DP Request to AP
    input  wire    ap_ack_dp_i,             // AP Acknowledge from AP to DP

    // Output Wires to other Modules
    output wire    dp_cs_cdbgpwrupack_o,    // CDBGPWRUPACK for DP CTRL/STAT
    output wire    cdbgpwrupreq_o,          // CDBGPWRUPREQ to DAP pin
    output wire    reset_dp_ap_handshake_o, // DP/AP handshake reset required

    // Scan Enable for DFT
    input  wire    DFTSE
    );

// ----------------------------------------------------------------------------
// Wire Declarations
// ----------------------------------------------------------------------------

  wire      dp_cs_cdbgpwrupack;
  wire      reset_dp_ap_handshake;

  wire      cdbgpwrupack_sync;      // S/synchronized CDBGPWRUPACK from pin

  reg       cdbgpwrupreq_0;         // Power Up Request PEND
  wire      cdbgpwrupreq_1;         // Power Up Request COMMIT
                                    // (declared as wire as using instantiated
                                    // register)

  wire      cdbgpwrupreq_0_load;
  wire      cdbgpwrupreq_0_next;
  wire      cdbgpwrupreq_1_load;
  wire      cdbgpwrupreq_1_next;

  assign  dp_cs_cdbgpwrupack_o    = dp_cs_cdbgpwrupack;
  assign  cdbgpwrupreq_o          = cdbgpwrupreq_1;
  assign  reset_dp_ap_handshake_o = reset_dp_ap_handshake;

// ----------------------------------------------------------------------------
// CDBGPWRUPACK Synchronization
// ----------------------------------------------------------------------------
// CDBGPWRUPACK is a DAP pin and is assumed to be coming from a different
// clock domain to the DP, therefore synchronization is required.
// ----------------------------------------------------------------------------
  cm0p_dap_cdc_capt_sync
    u_cdbgpwrupack_sync
    (
      .SYNCRSTn     (dpreset_n),
      .SYNCCLK      (swclktck),
      .SYNCDI       (cdbgpwrupack_i),
      .DFTSE        (DFTSE),
      .SYNCDO       (cdbgpwrupack_sync)
    );

// ----------------------------------------------------------------------------
// Power Up/Power Down Handshaking
// ----------------------------------------------------------------------------
// The power up/power down signals in software (as seen by the debugger) are
// decoupled from the signals sent to the pin to control power to the AP. This
// ensures that the 4-phase power handshaking on the interface is always
// correctly performed.
//
// The software power down request is only committed (forwarded to the pin)
// when the DP/AP interface is idle with both handshake signals low. If the AP
// is busy the transaction is allowed to complete. If the AP is idle with the
// handshake signals high, then a transaction accessing reserved AP registers
// (which are RAZ/WI) is started, which when complete will result in both
// dp_req and ap_ack low, at which point the AP may safely be powered down.
//
// If an AP transaction is attempted after a power down request is made, the
// sticky error bit is forced high as such a transaction is illegal.
// ---------------------------------------------------------------------------

  // Logic to generate CDBGPWRUPACK in the CTRL/STAT Register
  assign dp_cs_cdbgpwrupack =  cdbgpwrupack_sync &
                             ((~dp_cs_cdbgpwrupreq_i) |
                             (cdbgpwrupreq_0 &
                             cdbgpwrupreq_1));

  // Next values for power request pend (0) and commit (1) signals
  assign cdbgpwrupreq_0_next = dp_cs_cdbgpwrupreq_i;
  assign cdbgpwrupreq_1_next = cdbgpwrupreq_0;

  // Load Enable terms
  assign cdbgpwrupreq_0_load = (~(cdbgpwrupreq_0 ^ cdbgpwrupack_sync));
  assign cdbgpwrupreq_1_load = (~(dp_req_dp_i | ap_ack_dp_i));

  //If the handshake is idle with both dp_req and ap_ack high it needs to be
  //reset to both 0. This is done by triggering a transaction to a reserved AP
  //register which is RAZ/WI.
  assign reset_dp_ap_handshake = dp_req_dp_i & ap_ack_dp_i & (~cdbgpwrupreq_0);

  // Registers
  always @(posedge swclktck or negedge dpreset_n)
    if (!dpreset_n)
    begin
      cdbgpwrupreq_0 <= 1'b0;
    end
    else if (cdbgpwrupreq_0_load)
    begin
      cdbgpwrupreq_0 <= cdbgpwrupreq_0_next;
    end

  // CDBGPWRUPREQ is normally output from the DAP into a different clock
  // domain, therefore a CDC-safe launch flop is required.
  cm0p_dap_cdc_send_reset
    u_cdbgpwrupreq_commit
    (
      .REGCLK     (swclktck),
      .REGRESETn  (dpreset_n),
      .REGEN      (cdbgpwrupreq_1_load),
      .REGDI      (cdbgpwrupreq_1_next),
      .DFTSE      (DFTSE),
      .REGDO      (cdbgpwrupreq_1)
    );

// ----------------------------------------------------------------------------
// Assertions
// ----------------------------------------------------------------------------
`ifdef ARM_ASSERT_ON
  `include "std_ovl_defines.h"

  // - cdbgpwrupreq_1_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
       .width               (1),
       .property_type       (`OVL_ASSERT),
       .msg                 ("cdbgpwrupreq_1_load can never be x"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
    u_asrt_cdbgpwrupreq_1_load_x
      ( .clock      (swclktck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (cdbgpwrupreq_1_load),
        .fire       ()
        );

  // - cdbgpwrupreq_0_load
  ovl_never_unknown
    #(.severity_level      (`OVL_FATAL),
       .width               (1),
       .property_type       (`OVL_ASSERT),
       .msg                 ("cdbgpwrupreq_0_load can never be x"),
       .coverage_level      (`OVL_COVER_DEFAULT),
       .clock_edge          (`OVL_POSEDGE),
       .reset_polarity      (`OVL_ACTIVE_LOW),
       .gating_type         (`OVL_GATE_NONE))
    u_asrt_cdbgpwrupreq_0_load_x
      ( .clock      (swclktck),
        .reset      (dpreset_n),
        .enable     (1'b1),
        .qualifier  (1'b1),
        .test_expr  (cdbgpwrupreq_0_load),
        .fire       ());
`endif

endmodule
